Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2132E0693
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 16:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfJVOhj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 10:37:39 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38780 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfJVOhj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 10:37:39 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMvI0-0008W2-Pe; Tue, 22 Oct 2019 14:37:36 +0000
Date:   Tue, 22 Oct 2019 15:37:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        wugyuan@cn.ibm.com, jlayton@kernel.org, hsiangkao@aol.com,
        Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RESEND 1/1] vfs: Really check for inode ptr in lookup_fast
Message-ID: <20191022143736.GX26530@ZenIV.linux.org.uk>
References: <20190927044243.18856-1-riteshh@linux.ibm.com>
 <20191015040730.6A84742047@d06av24.portsmouth.uk.ibm.com>
 <20191022133855.B1B4752050@d06av21.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022133855.B1B4752050@d06av21.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 22, 2019 at 07:08:54PM +0530, Ritesh Harjani wrote:
> I think we have still not taken this patch. Al?

I'm still not sure it's a good way to deal with the whole
mess, TBH ;-/  Consider e.g. walk_component(), with its

                if (unlikely(d_is_negative(path.dentry))) {
                        path_to_nameidata(&path, nd);
                        return -ENOENT;
                }

                seq = 0;        /* we are already out of RCU mode */
                inode = d_backing_inode(path.dentry);

or mountpoint_last()
        if (d_is_negative(path.dentry)) {
                dput(path.dentry);
                return -ENOENT;
        }
        path.mnt = nd->path.mnt;
        return step_into(nd, &path, 0, d_backing_inode(path.dentry), 0);
or last_open()
        if (unlikely(d_is_negative(path.dentry))) {
                path_to_nameidata(&path, nd);
                return -ENOENT; 
        }

        /*
         * create/update audit record if it already exists.
         */
        audit_inode(nd->name, path.dentry, 0);

        if (unlikely((open_flag & (O_EXCL | O_CREAT)) == (O_EXCL | O_CREAT))) {
                path_to_nameidata(&path, nd);
                return -EEXIST;
        }

        seq = 0;        /* out of RCU mode, so the value doesn't matter */
        inode = d_backing_inode(path.dentry);
or, for that matter, any callers of filename_lookup() assuming that the
lack of ENOENT means that the last call of walk_component() (from lookup_last())
has not failed with the same ENOENT and thus the result has been observed
positive.

You've picked the easiest one to hit, but on e.g. KVM setups you can have the
host thread representing the CPU where __d_set_inode_and_type() runs get
preempted (by the host kernel), leaving others with much wider window.

Sure, we can do that to all callers of d_is_negative/d_is_positive, but...
the same goes for any places that assumes that d_is_dir() implies that
the sucker is positive, etc.

What we have guaranteed is
	* ->d_lock serializes ->d_flags/->d_inode changes
	* ->d_seq is bumped before/after such changes
	* positive dentry never changes ->d_inode as long as you hold
a reference (negative dentry *can* become positive right under you)

So there are 3 classes of valid users: those holding ->d_lock, those
sampling and rechecking ->d_seq and those relying upon having observed
the sucker they've pinned to be positive.

What you've been hitting is "we have it pinned, ->d_flags says it's
positive but we still observe the value of ->d_inode from before the
store to ->d_flags that has made it look positive".

I'm somewhat tempted to make __d_set_inode_and_type() do smp_store_release()
for setting ->d_flags and __d_entry_type() - smp_load_acquire(); that would
be pretty much free for x86 (as well as sparc, s390 and itanic) and reasonably
cheap on ppc and arm64.  How badly would e.g. SMP arm suffer from the below
(completely untested)?

diff --git a/fs/dcache.c b/fs/dcache.c
index e88cf0554e65..35368316c582 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -319,7 +319,7 @@ static inline void __d_set_inode_and_type(struct dentry *dentry,
 	flags = READ_ONCE(dentry->d_flags);
 	flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
 	flags |= type_flags;
-	WRITE_ONCE(dentry->d_flags, flags);
+	smp_store_release(&dentry->d_flags, flags);
 }
 
 static inline void __d_clear_type_and_inode(struct dentry *dentry)
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 10090f11ab95..bee28076a3fd 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -386,7 +386,7 @@ static inline bool d_mountpoint(const struct dentry *dentry)
  */
 static inline unsigned __d_entry_type(const struct dentry *dentry)
 {
-	return dentry->d_flags & DCACHE_ENTRY_TYPE;
+	return smp_load_acquire(&dentry->d_flags) & DCACHE_ENTRY_TYPE;
 }
 
 static inline bool d_is_miss(const struct dentry *dentry)
