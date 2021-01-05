Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A372EB094
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 17:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbhAEQu7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 11:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729518AbhAEQu6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 11:50:58 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5E6C061793;
        Tue,  5 Jan 2021 08:50:17 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwpX3-0076tQ-14; Tue, 05 Jan 2021 16:50:05 +0000
Date:   Tue, 5 Jan 2021 16:50:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4] proc: Allow pid_revalidate() during LOOKUP_RCU
Message-ID: <20210105165005.GV3579531@ZenIV.linux.org.uk>
References: <20210104232123.31378-1-stephen.s.brennan@oracle.com>
 <20210105055935.GT3579531@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105055935.GT3579531@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 05, 2021 at 05:59:35AM +0000, Al Viro wrote:

> Umm...  I'm rather worried about the side effect you are removing here -
> you are suddenly exposing a bunch of methods in there to RCU mode.
> E.g. is proc_pid_permission() safe with MAY_NOT_BLOCK in the mask?
> generic_permission() call in there is fine, but has_pid_permission()
> doesn't even see the mask.  Is that thing safe in RCU mode?  AFAICS,
> this
> static int selinux_ptrace_access_check(struct task_struct *child,
>                                      unsigned int mode)
> {
>         u32 sid = current_sid();
>         u32 csid = task_sid(child);
> 
>         if (mode & PTRACE_MODE_READ)
>                 return avc_has_perm(&selinux_state,
>                                     sid, csid, SECCLASS_FILE, FILE__READ, NULL);
> 
>         return avc_has_perm(&selinux_state,
>                             sid, csid, SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
> }
> is reachable and IIRC avc_has_perm() should *NOT* be called in RCU mode.
> If nothing else, audit handling needs care...
> 
> And LSM-related stuff is only a part of possible issues here.  It does need
> a careful code audit - you are taking a bunch of methods into the conditions
> they'd never been tested in.  ->permission(), ->get_link(), ->d_revalidate(),
> ->d_hash() and ->d_compare() instances for objects that subtree.  The last
> two are not there in case of anything in /proc/<pid>, but the first 3 very
> much are.

FWIW, after looking through the selinux and smack I started to wonder whether
we really need that "return -ECHILD rather than audit and fail" in case of
->inode_permission().

AFAICS, the reason we need it is that dump_common_audit_data() is not safe
in RCU mode with LSM_AUDIT_DATA_DENTRY and even more so - with
LSM_AUDIT_DATA_INODE (d_find_alias() + dput() there, and dput() can bloody well
block).

LSM_AUDIT_DATA_DENTRY is easy to handle - wrap
                audit_log_untrustedstring(ab, a->u.dentry->d_name.name);
into grabbing/dropping a->u.dentry->d_lock and we are done.  And as for
the LSM_AUDIT_DATA_INODE...  How about this:

/*
 * Caller *MUST* hold rcu_read_lock() and be guaranteed that inode itself
 * will be around until that gets dropped.
 */
struct dentry *d_find_alias_rcu(struct inode *inode)
{
	struct hlist_head *l = &inode->i_dentry;
        struct dentry *de = NULL;

	spin_lock(&inode->i_lock);
	// ->i_dentry and ->i_rcu are colocated, but the latter won't be
	// used without having I_FREEING set, which means no aliases left
	if (inode->i_state & I_FREEING) {
		spin_unlock(&inode->i_lock);
		return NULL;
	}
	// we can safely access inode->i_dentry
        if (hlist_empty(p)) {
		spin_unlock(&inode->i_lock);
		return NULL;
	}
	if (S_ISDIR(inode->i_mode)) {
		de = hlist_entry(l->first, struct dentry, d_u.d_alias);
	} else hlist_for_each_entry(de, l, d_u.d_alias) {
		if (d_unhashed(de))
			continue;
		// hashed + nonrcu really shouldn't be possible
		if (WARN_ON(READ_ONCE(de->d_flags) & DCACE_NONRCU))
			continue;
		break;
	}
	spin_unlock(&inode->i_lock);
        return de;
}

and have
        case LSM_AUDIT_DATA_INODE: {
                struct dentry *dentry;
                struct inode *inode;

		rcu_read_lock();
                inode = a->u.inode;
                dentry = d_find_alias_rcu(inode);
                if (dentry) {
                        audit_log_format(ab, " name=");
			spin_lock(&dentry->d_lock);
                        audit_log_untrustedstring(ab,
                                         dentry->d_name.name);
			spin_unlock(&dentry->d_lock);
                }
                audit_log_format(ab, " dev=");
                audit_log_untrustedstring(ab, inode->i_sb->s_id);
                audit_log_format(ab, " ino=%lu", inode->i_ino);
		rcu_read_unlock();
                break;
        }
in dump_common_audit_data().  Would that be enough to stop bothering
with the entire AVC_NONBLOCKING thing or is there anything else
involved?
