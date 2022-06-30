Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B64A561567
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 10:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiF3Ir6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 04:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiF3Ir6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:47:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD70E3982F;
        Thu, 30 Jun 2022 01:47:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FBCFB82922;
        Thu, 30 Jun 2022 08:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE39C34115;
        Thu, 30 Jun 2022 08:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656578874;
        bh=QXlp7dJ2o7CJ43JsIC1G+oA+EOkK0MDpCbSQKIZZpwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cY+EB/1vpe2qlFbRMTG6TaCURLED8htdKd8AgmiYtNhrdTBrPLd60Baw5pWJSmSYT
         7F0hP1vRiZO45zwM4j88vygPle+lVdv6DeIuob9mV4cMS2GXfmGo/Ai4TUHbEjUkzQ
         LkLISH/corylj3xyx+DUC0I2CFY7mBjkCpA9N5g+iN05CDxSI9T+Di4a2+B5S3++kr
         JOew9IvAIFP/MNbkpjjFfLKHKveulBobrvxRf9K4ui9ALJDhJ687r757NEK0bJbxpP
         IRvb2l389ynVgBXMrH1/0asDuX/5h1N9rtd2jvKzCrkmbZRPQYEBhLd2vye/ftf9ey
         goGND/nniJxAQ==
Date:   Thu, 30 Jun 2022 11:47:39 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+9bd2b7adbd34b30b87e4@syzkaller.appspotmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 truncate_inode_partial_folio
Message-ID: <Yr1jKwz2+SGxjcuW@kernel.org>
References: <000000000000f94c4805e289fc47@google.com>
 <YrvYEdTNWcvhIE7U@sol.localdomain>
 <CAJHvVcgoeKhqFTN5aGfQ53GbRDYJsfkRjeUM-yO5AROC0A8ekQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJHvVcgoeKhqFTN5aGfQ53GbRDYJsfkRjeUM-yO5AROC0A8ekQ@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 29, 2022 at 09:30:12AM -0700, Axel Rasmussen wrote:
> On Tue, Jun 28, 2022 at 9:41 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Tue, Jun 28, 2022 at 03:59:26PM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    941e3e791269 Merge tag 'for_linus' of git://git.kernel.org..
> > > git tree:       upstream
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=1670ded4080000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=833001d0819ddbc9
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=9bd2b7adbd34b30b87e4
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140f9ba8080000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15495188080000
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+9bd2b7adbd34b30b87e4@syzkaller.appspotmail.com
> > >
> > > BUG: unable to handle page fault for address: ffff888021f7e005
> > > #PF: supervisor write access in kernel mode
> > > #PF: error_code(0x0002) - not-present page
> > > PGD 11401067 P4D 11401067 PUD 11402067 PMD 21f7d063 PTE 800fffffde081060
> > > Oops: 0002 [#1] PREEMPT SMP KASAN
> > > CPU: 0 PID: 3761 Comm: syz-executor281 Not tainted 5.19.0-rc4-syzkaller-00014-g941e3e791269 #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > RIP: 0010:memset_erms+0x9/0x10 arch/x86/lib/memset_64.S:64
> > > Code: c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 f3 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 <f3> aa 4c 89 c8 c3 90 49 89 fa 40 0f b6 ce 48 b8 01 01 01 01 01 01
> > > RSP: 0018:ffffc9000329fa90 EFLAGS: 00010202
> > > RAX: 0000000000000000 RBX: 0000000000001000 RCX: 0000000000000ffb
> > > RDX: 0000000000000ffb RSI: 0000000000000000 RDI: ffff888021f7e005
> > > RBP: ffffea000087df80 R08: 0000000000000001 R09: ffff888021f7e005
> > > R10: ffffed10043efdff R11: 0000000000000000 R12: 0000000000000005
> > > R13: 0000000000000000 R14: 0000000000001000 R15: 0000000000000ffb
> > > FS:  00007fb29d8b2700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: ffff888021f7e005 CR3: 0000000026e7b000 CR4: 00000000003506f0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  zero_user_segments include/linux/highmem.h:272 [inline]
> > >  folio_zero_range include/linux/highmem.h:428 [inline]
> > >  truncate_inode_partial_folio+0x76a/0xdf0 mm/truncate.c:237
> > >  truncate_inode_pages_range+0x83b/0x1530 mm/truncate.c:381
> > >  truncate_inode_pages mm/truncate.c:452 [inline]
> > >  truncate_pagecache+0x63/0x90 mm/truncate.c:753
> > >  simple_setattr+0xed/0x110 fs/libfs.c:535
> > >  secretmem_setattr+0xae/0xf0 mm/secretmem.c:170
> > >  notify_change+0xb8c/0x12b0 fs/attr.c:424
> > >  do_truncate+0x13c/0x200 fs/open.c:65
> > >  do_sys_ftruncate+0x536/0x730 fs/open.c:193
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > > RIP: 0033:0x7fb29d900899
> > > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007fb29d8b2318 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
> > > RAX: ffffffffffffffda RBX: 00007fb29d988408 RCX: 00007fb29d900899
> > > RDX: 00007fb29d900899 RSI: 0000000000000005 RDI: 0000000000000003
> > > RBP: 00007fb29d988400 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb29d98840c
> > > R13: 00007ffca01a23bf R14: 00007fb29d8b2400 R15: 0000000000022000
> > >  </TASK>
> > > Modules linked in:
> > > CR2: ffff888021f7e005
> > > ---[ end trace 0000000000000000 ]---
> >
> > I think this is a bug in memfd_secret.  secretmem_setattr() can race with a page
> > being faulted in by secretmem_fault().  Specifically, a page can be faulted in
> > after secretmem_setattr() has set i_size but before it zeroes out the partial
> > page past i_size.  memfd_secret pages aren't mapped in the kernel direct map, so
> > the crash occurs when the kernel tries to zero out the partial page.
> >
> > I don't know what the best solution is -- maybe a rw_semaphore protecting
> > secretmem_fault() and secretmem_setattr()?  Or perhaps secretmem_setattr()
> > should avoid the call to truncate_setsize() by not using simple_setattr(), given
> > that secretmem_setattr() only supports the size going from zero to nonzero.
> 
> From my perspective the rw_semaphore approach sounds reasonable.
> 
> simple_setattr() and the functions it calls to do the actual work
> isn't a tiny amount of code, it would be a shame to reimplement it in
> secretmem.c.
> 
> For the rwsem, I guess the idea is setattr will take it for write, and
> fault will take it for read? Since setattr is a very infrequent
> operation - a typical use case is you'd do it exactly once right after
> opening the memfd_secret - this seems like it wouldn't make fault
> significantly less performant. It's also a pretty small change I
> think, just a few lines.
 
Below is my take on adding a semaphore and making ->setattr() and ->fault()
mutually exclusive. It's only lightly tested so I'd appreciate if Eric
could give it a whirl.

With addition of semaphore to secretmem_setattr() it seems we don't need
special care for size changes, just calling simple_setattr() after taking
the semaphore should be fine. Thoughts?

From edfcb2f0d31c2132bda483635dd2a8dd295efb04 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Thu, 30 Jun 2022 11:26:37 +0300
Subject: [PATCH] secretmem: fix unhandled fault in truncate

syzkaller reports the following issue:

BUG: unable to handle page fault for address: ffff888021f7e005
PGD 11401067 P4D 11401067 PUD 11402067 PMD 21f7d063 PTE 800fffffde081060
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 3761 Comm: syz-executor281 Not tainted 5.19.0-rc4-syzkaller-00014-g941e3e791269 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:memset_erms+0x9/0x10 arch/x86/lib/memset_64.S:64
Code: c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 f3 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 <f3> aa 4c 89 c8 c3 90 49 89 fa 40 0f b6 ce 48 b8 01 01 01 01 01 01
RSP: 0018:ffffc9000329fa90 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000001000 RCX: 0000000000000ffb
RDX: 0000000000000ffb RSI: 0000000000000000 RDI: ffff888021f7e005
RBP: ffffea000087df80 R08: 0000000000000001 R09: ffff888021f7e005
R10: ffffed10043efdff R11: 0000000000000000 R12: 0000000000000005
R13: 0000000000000000 R14: 0000000000001000 R15: 0000000000000ffb
FS:  00007fb29d8b2700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888021f7e005 CR3: 0000000026e7b000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 zero_user_segments include/linux/highmem.h:272 [inline]
 folio_zero_range include/linux/highmem.h:428 [inline]
 truncate_inode_partial_folio+0x76a/0xdf0 mm/truncate.c:237
 truncate_inode_pages_range+0x83b/0x1530 mm/truncate.c:381
 truncate_inode_pages mm/truncate.c:452 [inline]
 truncate_pagecache+0x63/0x90 mm/truncate.c:753
 simple_setattr+0xed/0x110 fs/libfs.c:535
 secretmem_setattr+0xae/0xf0 mm/secretmem.c:170
 notify_change+0xb8c/0x12b0 fs/attr.c:424
 do_truncate+0x13c/0x200 fs/open.c:65
 do_sys_ftruncate+0x536/0x730 fs/open.c:193
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fb29d900899
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb29d8b2318 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007fb29d988408 RCX: 00007fb29d900899
RDX: 00007fb29d900899 RSI: 0000000000000005 RDI: 0000000000000003
RBP: 00007fb29d988400 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb29d98840c
R13: 00007ffca01a23bf R14: 00007fb29d8b2400 R15: 0000000000022000
 </TASK>
Modules linked in:
CR2: ffff888021f7e005
---[ end trace 0000000000000000 ]---

Eric Biggers suggested that this happens when
secretmem_setattr()->simple_setattr() races with secretmem_fault() so
that a page that is faulted in by secretmem_fault() (and thus removed
from the direct map) is zeroed by inode truncation right afterwards.

Use an rw_semaphore to make secretmem_fault() and secretmem_setattr()
mutually exclusive.

Reported-by: syzbot+9bd2b7adbd34b30b87e4@syzkaller.appspotmail.com
Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/secretmem.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 206ed6b40c1d..40573b045c96 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -47,30 +47,41 @@ bool secretmem_active(void)
 	return !!atomic_read(&secretmem_users);
 }
 
+struct secretmem_state {
+	struct rw_semaphore rw_sem;
+};
+
 static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct secretmem_state *state = inode->i_private;
 	pgoff_t offset = vmf->pgoff;
 	gfp_t gfp = vmf->gfp_mask;
 	unsigned long addr;
 	struct page *page;
+	vm_fault_t ret;
 	int err;
 
 	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
 		return vmf_error(-EINVAL);
 
+	down_read(&state->rw_sem);
+
 retry:
 	page = find_lock_page(mapping, offset);
 	if (!page) {
 		page = alloc_page(gfp | __GFP_ZERO);
-		if (!page)
-			return VM_FAULT_OOM;
+		if (!page) {
+			ret = VM_FAULT_OOM;
+			goto out;
+		}
 
 		err = set_direct_map_invalid_noflush(page);
 		if (err) {
 			put_page(page);
-			return vmf_error(err);
+			ret = vmf_error(err);
+			goto out;
 		}
 
 		__SetPageUptodate(page);
@@ -86,7 +97,8 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 			if (err == -EEXIST)
 				goto retry;
 
-			return vmf_error(err);
+			ret = vmf_error(err);
+			goto out;
 		}
 
 		addr = (unsigned long)page_address(page);
@@ -94,7 +106,11 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 	}
 
 	vmf->page = page;
-	return VM_FAULT_LOCKED;
+	ret = VM_FAULT_LOCKED;
+
+out:
+	up_read(&state->rw_sem);
+	return ret;
 }
 
 static const struct vm_operations_struct secretmem_vm_ops = {
@@ -163,11 +179,17 @@ static int secretmem_setattr(struct user_namespace *mnt_userns,
 {
 	struct inode *inode = d_inode(dentry);
 	unsigned int ia_valid = iattr->ia_valid;
+	struct secretmem_state *state = inode->i_private;
+	int ret;
 
+	down_write(&state->rw_sem);
 	if ((ia_valid & ATTR_SIZE) && inode->i_size)
-		return -EINVAL;
+		ret = -EINVAL;
+	else
+		ret = simple_setattr(mnt_userns, dentry, iattr);
+	up_write(&state->rw_sem);
 
-	return simple_setattr(mnt_userns, dentry, iattr);
+	return ret;
 }
 
 static const struct inode_operations secretmem_iops = {
@@ -179,22 +201,30 @@ static struct vfsmount *secretmem_mnt;
 static struct file *secretmem_file_create(unsigned long flags)
 {
 	struct file *file = ERR_PTR(-ENOMEM);
+	struct secretmem_state *state;
 	struct inode *inode;
 
 	inode = alloc_anon_inode(secretmem_mnt->mnt_sb);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		goto err_free_inode;
+
 	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
 				 O_RDWR, &secretmem_fops);
 	if (IS_ERR(file))
-		goto err_free_inode;
+		goto err_free_state;
 
 	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
 	mapping_set_unevictable(inode->i_mapping);
 
+	init_rwsem(&state->rw_sem);
+
 	inode->i_op = &secretmem_iops;
 	inode->i_mapping->a_ops = &secretmem_aops;
+	inode->i_private = state;
 
 	/* pretend we are a normal file with zero size */
 	inode->i_mode |= S_IFREG;
@@ -202,6 +232,8 @@ static struct file *secretmem_file_create(unsigned long flags)
 
 	return file;
 
+err_free_state:
+	kfree(state);
 err_free_inode:
 	iput(inode);
 	return file;

base-commit: 03c765b0e3b4cb5063276b086c76f7a612856a9a
-- 
2.34.1


> > The following commit tried to fix a similar bug, but it wasn't enough:
> >
> >         commit f9b141f93659e09a52e28791ccbaf69c273b8e92
> >         Author: Axel Rasmussen <axelrasmussen@google.com>
> >         Date:   Thu Apr 14 19:13:31 2022 -0700
> >
> >             mm/secretmem: fix panic when growing a memfd_secret
> >
> >
> > Here's a simplified reproducer.  Note, for memfd_secret to be supported, the
> > kernel config must contain CONFIG_SECRETMEM=y and the kernel command line must
> > contain secretmem.enable=1.
> >
> > #include <pthread.h>
> > #include <setjmp.h>
> > #include <signal.h>
> > #include <sys/mman.h>
> > #include <sys/syscall.h>
> > #include <unistd.h>
> >
> > static volatile int fd;
> > static jmp_buf jump_buf;
> >
> > static void *truncate_thread(void *arg)
> > {
> >         for (;;)
> >                 ftruncate(fd, 1000);
> > }
> >
> > static void handle_sigbus(int sig)
> > {
> >         longjmp(jump_buf, 1);
> > }
> >
> > int main(void)
> > {
> >         struct sigaction act = {
> >                 .sa_handler = handle_sigbus,
> >                 .sa_flags = SA_NODEFER,
> >         };
> >         pthread_t t;
> >         void *addr;
> >
> >         sigaction(SIGBUS, &act, NULL);
> >
> >         pthread_create(&t, NULL, truncate_thread, NULL);
> >         for (;;) {
> >                 fd = syscall(__NR_memfd_secret, 0);
> >                 addr = mmap(NULL, 8192, PROT_WRITE, MAP_SHARED, fd, 0);
> >                 if (setjmp(jump_buf) == 0)
> >                         *(unsigned int *)addr = 0;
> >                 munmap(addr, 8192);
> >                 close(fd);
> >         }
> > }

-- 
Sincerely yours,
Mike.
