Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD794A3C7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 02:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357331AbiAaB5l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jan 2022 20:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiAaB5k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jan 2022 20:57:40 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071ABC061714;
        Sun, 30 Jan 2022 17:57:40 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nELwo-005ycg-Rm; Mon, 31 Jan 2022 01:57:38 +0000
Date:   Mon, 31 Jan 2022 01:57:38 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-cifs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [ksmbd] racy uses of ->d_parent and ->d_name
Message-ID: <YfdCElWBOdOnsH5b@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Folks, ->d_name and ->d_parent are *NOT* stable unless the
appropriate locks are held.  In particular, locking a directory that
might not be our parent is obviously not going to prevent anything.
Even if it had been our parent at some earlier point.

	->d_lock would suffice, but it can't be held over blocking
operation and it can't be held over dcache lookups anyway (instant
deadlocks).  IOW, the following is racy:

int ksmbd_vfs_lock_parent(struct user_namespace *user_ns, struct dentry *parent,
                          struct dentry *child)
{
        struct dentry *dentry;
        int ret = 0;

        inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
        dentry = lookup_one(user_ns, child->d_name.name, parent,
                            child->d_name.len);
        if (IS_ERR(dentry)) {
                ret = PTR_ERR(dentry);
                goto out_err;
        }

        if (dentry != child) {
                ret = -ESTALE;
                dput(dentry);
                goto out_err;
        }

        dput(dentry);
        return 0;
out_err:
        inode_unlock(d_inode(parent));
        return ret;
}


	Some of that might be fixable - verifying that ->d_parent points
to parent immediately after inode_lock would stabilize ->d_name in case
of match.  However, a quick look through the callers shows e.g. this:
                write_lock(&ci->m_lock);
                if (ci->m_flags & (S_DEL_ON_CLS | S_DEL_PENDING)) {
                        dentry = filp->f_path.dentry;
                        dir = dentry->d_parent;
                        ci->m_flags &= ~(S_DEL_ON_CLS | S_DEL_PENDING);
                        write_unlock(&ci->m_lock);
                        ksmbd_vfs_unlink(file_mnt_user_ns(filp), dir, dentry);
                        write_lock(&ci->m_lock);
                }
                write_unlock(&ci->m_lock);

	What's to keep dir from getting freed right under us, just as
ksmbd_vfs_lock_parent() (from ksmbd_vfs_unlink()) tries to grab ->i_rwsem
on its inode?

	Have the file moved to other directory and apply memory pressure.
What's to prevent dir from being evicted, its memory recycled, etc.?

	For another fun example, consider e.g. smb2_rename():
                if (file_present &&
                    strncmp(old_name, path.dentry->d_name.name, strlen(old_name))) {
                        rc = -EEXIST;
                        ksmbd_debug(SMB,
                                    "cannot rename already existing file\n");
                        goto out;
                }

Suppose path.dentry has a name longer than 32 bytes (i.e. too large to
fit into ->d_iname and thus allocated separately).  At this point you
are not holding any locks (otherwise ksmbd_vfs_fp_rename() immediately
downstream would deadlock).  So what's to prevent rename(2) on host
ending up with path.dentry getting renamed and old name getting freed?

	More of the same: ksmbd_vfs_fp_rename().  In this one
dget_parent() will at least avoid parent getting freed.  It won't do
a damn thing to stabilize src_dent->d_name after lock_rename(),
though, since we are not guaranteed that the thing we locked is
still the parent...

	Why is so much tied to "open, then figure out where it is" model?
Is it a legacy of userland implementation, or a network fs protocol that
manages to outsuck NFS, or...?
