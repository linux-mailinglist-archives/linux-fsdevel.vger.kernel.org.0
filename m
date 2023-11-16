Return-Path: <linux-fsdevel+bounces-2970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FB57EE581
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 17:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3021C209CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 16:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29703BB24;
	Thu, 16 Nov 2023 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAtS8Ds3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F8FB7
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 08:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700153358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1s0WJ01gB5zhcFsx6lBCHGMIG0MB40ACPZy6Q7ECjY=;
	b=IAtS8Ds3aNt6bhkZ9YXfsMHQRk4rmXnwyUMAjZMqI+pM2M83hzDbZUdMF8BI6xWZqvSECA
	Laz9+XO6s6V18M+O5CwZFVsEDo0zGjCziIt5HQ2eSgnzZvEEDIrBziHa0UnRtKArLMUmhg
	P2SfswS5GcuUSaxxtcT8MlQRwKIuBLk=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-DbX197phNLKawALYhtlJ2w-1; Thu, 16 Nov 2023 11:49:17 -0500
X-MC-Unique: DbX197phNLKawALYhtlJ2w-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6ce2908d14dso187834a34.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 08:49:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700153356; x=1700758156;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1s0WJ01gB5zhcFsx6lBCHGMIG0MB40ACPZy6Q7ECjY=;
        b=WYNkBi4fOtkX7eCJrbRk3cycNdoMCo7wshd9EmK0FbaRGQ9vgjixpGIGXJNdbCgYTp
         cgnC8u0fkOzGapHFIdArLMNUWUIKs/3FcAAbCppAWiU2Bxr+ZSBaBL3RYJ8WixuKPvvC
         fSmpI9JKHKkwOsjayKHb93kYUGrAqZ+U58ZRHId9r88EJUDTX4NsVzT3I8M2v+JLdCUC
         4XvE++RoKewTf9LNXl3QaFgM68D7Y9BUV3dZhRKhZRp0ecjKbc8Df2aB3dWNPXAk8ikn
         ctXOVMqm3bE8CeVWrCZOwBF1Era9RkDT4HJgemGAUgYR5iaW8CpHAVih6jGLi37hnmm2
         NemA==
X-Gm-Message-State: AOJu0Yx466TyNumMxeHR+Zl3t1OG5hnQEdgg/VUD/nYC+FdV6+ReWB7F
	+ZBxfpNtRvMptpktXUejs2EyuEgdohXb6AFlcOpBn8lIjiKpCL15tkYyeLJFARqfS0hVxsksVKN
	+LRf09er9CpXebjGjRiTO2IbvAKkskc859Q==
X-Received: by 2002:a05:6870:2301:b0:1ea:7463:1b8f with SMTP id w1-20020a056870230100b001ea74631b8fmr9795877oao.0.1700153356463;
        Thu, 16 Nov 2023 08:49:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLYjE0JU3/o+D+SOTaQIUYfk67pHPZl5NWX/n+45FCCvkq5nj1uuM7IZ+IB1wOmRN836CKJQ==
X-Received: by 2002:a05:6870:2301:b0:1ea:7463:1b8f with SMTP id w1-20020a056870230100b001ea74631b8fmr9795855oao.0.1700153356030;
        Thu, 16 Nov 2023 08:49:16 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id ke21-20020a05622a289500b00417fa0cd77esm4449897qtb.80.2023.11.16.08.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 08:49:15 -0800 (PST)
Date: Thu, 16 Nov 2023 11:49:12 -0500
From: Peter Xu <peterx@redhat.com>
To: Andrei Vagin <avagin@gmail.com>
Cc: syzbot <syzbot+e94c5aaf7890901ebf9b@syzkaller.appspotmail.com>,
	Muhammad Usama Anjum <musamaanjum@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] WARNING in pagemap_scan_pmd_entry
Message-ID: <ZVZICOmNRHWOV6g-@x1n>
References: <000000000000773fa7060a31e2cc@google.com>
 <CANaxB-yrvmv134dwTcMD9q5chXvm3YU1pDFhqvaRA8M1Gn7Guw@mail.gmail.com>
 <ZVVoCT_gNvbZg93f@x1n>
 <CANaxB-zLxs2=gNgWTqstLvyPK8mSwpEu2ob35TtaKWheMejZOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANaxB-zLxs2=gNgWTqstLvyPK8mSwpEu2ob35TtaKWheMejZOQ@mail.gmail.com>

On Thu, Nov 16, 2023 at 07:38:00AM -0800, Andrei Vagin wrote:
> On Wed, Nov 15, 2023 at 4:53 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > Hi, Andrei, Muhammad,
> >
> > I had a look (as it triggered the guard I added before..), and I think I
> > know what happened.  So far I think it's a question to the new ioctl()
> > interface, which I'd like to double check with you all.  See below.
> >
> > On Wed, Nov 15, 2023 at 01:07:18PM -0800, Andrei Vagin wrote:
> > > Cc: Peter and Muhammad
> > >
> > > On Wed, Nov 15, 2023 at 6:41 AM syzbot
> > > <syzbot+e94c5aaf7890901ebf9b@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    c42d9eeef8e5 Merge tag 'hardening-v6.7-rc2' of git://git.k..
> > > > git tree:       upstream
> > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=13626650e80000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=84217b7fc4acdc59
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=e94c5aaf7890901ebf9b
> > > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d73be0e80000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13670da8e80000
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/a595d90eb9af/disk-c42d9eee.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/c1e726fedb94/vmlinux-c42d9eee.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/cb43ae262d09/bzImage-c42d9eee.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+e94c5aaf7890901ebf9b@syzkaller.appspotmail.com
> > > >
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 1 PID: 5071 at arch/x86/include/asm/pgtable.h:403 pte_uffd_wp arch/x86/include/asm/pgtable.h:403 [inline]
> >
> > This is the guard I added to detect writable bit set even if uffd-wp bit is
> > not yet cleared.  It means something obviously wrong happened.
> >
> > Here afaict the wrong thing is ioctl(PAGEMAP_SCAN) allows applying uffd-wp
> > bit to VMA that is not even registered with userfault.  Then what happened
> > is when the page is written, do_wp_page() will try to reuse the anonymous
> > page with the uffd-wp bit set, set W bit on top of it.
> 
> Thank you for looking at this.
> 
> >
> > Below change works for me:
> >
> > ===8<===
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index ef2eb12906da..8a2500fa4580 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -1987,6 +1987,12 @@ static int pagemap_scan_test_walk(unsigned long start, unsigned long end,
> >                 vma_category |= PAGE_IS_WPALLOWED;
> >         else if (p->arg.flags & PM_SCAN_CHECK_WPASYNC)
> >                 return -EPERM;
> > +       else
> > +               /*
> > +                * Neither has the VMA enabled WP tracking, nor does the
> > +                * user want to explicit fail the walk.  Skip the vma.
> > +                */
> > +               return 1;
> 
> In this case, I think we need to check the PM_SCAN_WP_MATCHING flag
> and skip these vma-s only if it is set.
> 
> If PM_SCAN_WP_MATCHING isn't set, this ioctl returns page flags and
> can be used without the intention of tracking memory changes.
> 
> >
> >         if (vma->vm_flags & VM_PFNMAP)
> >                 return 1;
> > ===8<===
> >
> > This is based on my reading of the pagemap scan flags:
> >
> > - Write-protect the pages. The ``PM_SCAN_WP_MATCHING`` is used to write-protect
> >   the pages of interest. The ``PM_SCAN_CHECK_WPASYNC`` aborts the operation if
> >   non-Async Write Protected pages are found. The ``PM_SCAN_WP_MATCHING`` can be
> >   used with or without ``PM_SCAN_CHECK_WPASYNC``.
> >
> > If PM_SCAN_CHECK_WPASYNC is used to enforce the check, we need to skip the
> > vma that is not registered properly.  Does it look reasonable to you?
> 
> I think the idea here could be to report page flags but doesn't
> write-protect such pages.

Ah, I think I understand slightly better now.  Below is my 2nd try..

Meanwhile, I think this won't work:

	/* 9. Memory mapped file */
	fd = open(__FILE__, O_RDONLY);
	if (fd < 0)
		ksft_exit_fail_msg("%s Memory mapped file\n", __func__);

We can't assume __FILE__ is there..  Attached one more patch for that.
I'll repost formally if that looks good to you.

===8<===

From 47d54f3bbb709c54d6bed95fbf2045ea3a541a4b Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 16 Nov 2023 11:05:12 -0500
Subject: [PATCH] mm/pagemap: Fix ioctl(PAGEMAP_SCAN) on vma check

The new ioctl(PAGEMAP_SCAN) relies on vma wr-protect capability provided by
userfault, however in the vma test it didn't explicitly require the vma to
have wr-protect function enabled, even if PM_SCAN_WP_MATCHING flag is set.

It means the pagemap code can now apply uffd-wp bit to a page in the vma
even if not registered to userfaultfd at all.

Then in whatever way as long as the pte got written and page fault
resolved, we'll apply the write bit even if uffd-wp bit is set.  We'll see
a pte that has both UFFD_WP and WRITE bit set.  Anything later that looks
up the pte for uffd-wp bit will trigger the warning:

WARNING: CPU: 1 PID: 5071 at arch/x86/include/asm/pgtable.h:403 pte_uffd_wp arch/x86/include/asm/pgtable.h:403 [inline]

Fix it by doing proper check over the vma attributes when
PM_SCAN_WP_MATCHING is specified.

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Reported-by: syzbot+e94c5aaf7890901ebf9b@syzkaller.appspotmail.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/proc/task_mmu.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 51e0ec658457..e91085d79926 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1994,15 +1994,31 @@ static int pagemap_scan_test_walk(unsigned long start, unsigned long end,
 	struct pagemap_scan_private *p = walk->private;
 	struct vm_area_struct *vma = walk->vma;
 	unsigned long vma_category = 0;
+	bool wp_allowed = userfaultfd_wp_async(vma) &&
+	    userfaultfd_wp_use_markers(vma);
 
-	if (userfaultfd_wp_async(vma) && userfaultfd_wp_use_markers(vma))
-		vma_category |= PAGE_IS_WPALLOWED;
-	else if (p->arg.flags & PM_SCAN_CHECK_WPASYNC)
-		return -EPERM;
+	if (!wp_allowed) {
+		/* User requested explicit failure over wp-async capability */
+		if (p->arg.flags & PM_SCAN_CHECK_WPASYNC)
+			return -EPERM;
+		/*
+		 * User requires wr-protect, and allows silently skipping
+		 * unsupported vmas.
+		 */
+		if (p->arg.flags & PM_SCAN_WP_MATCHING)
+			return 1;
+		/*
+		 * Then the request doesn't involve wr-protects at all,
+		 * fall through to the rest checks, and allow vma walk.
+		 */
+	}
 
 	if (vma->vm_flags & VM_PFNMAP)
 		return 1;
 
+	if (wp_allowed)
+		vma_category |= PAGE_IS_WPALLOWED;
+
 	if (vma->vm_flags & VM_SOFTDIRTY)
 		vma_category |= PAGE_IS_SOFT_DIRTY;
 
-- 
2.41.0

===8<===

From f2be2816c30fd1016d597a219e5b42c4ae847796 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 16 Nov 2023 11:45:47 -0500
Subject: [PATCH 2/2] mm/selftests: Fix pagemap_ioctl memory map test

__FILE__ is not guaranteed to exist in current dir.  Replace that with
argv[0] for memory map test.

Fixes: 46fd75d4a3c9 ("selftests: mm: add pagemap ioctl tests")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/pagemap_ioctl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index befab43719ba..d59517ed3d48 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -36,6 +36,7 @@ int pagemap_fd;
 int uffd;
 int page_size;
 int hpage_size;
+const char *progname;
 
 #define LEN(region)	((region.end - region.start)/page_size)
 
@@ -1149,11 +1150,11 @@ int sanity_tests(void)
 	munmap(mem, mem_size);
 
 	/* 9. Memory mapped file */
-	fd = open(__FILE__, O_RDONLY);
+	fd = open(progname, O_RDONLY);
 	if (fd < 0)
 		ksft_exit_fail_msg("%s Memory mapped file\n", __func__);
 
-	ret = stat(__FILE__, &sbuf);
+	ret = stat(progname, &sbuf);
 	if (ret < 0)
 		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
 
@@ -1472,12 +1473,14 @@ static void transact_test(int page_size)
 			      extra_thread_faults);
 }
 
-int main(void)
+int main(int argc, char *argv[])
 {
 	int mem_size, shmid, buf_size, fd, i, ret;
 	char *mem, *map, *fmem;
 	struct stat sbuf;
 
+	progname = argv[0];
+
 	ksft_print_header();
 
 	if (init_uffd())
-- 
2.41.0


-- 
Peter Xu


