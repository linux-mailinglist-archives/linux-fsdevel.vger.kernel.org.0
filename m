Return-Path: <linux-fsdevel+bounces-12090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 273DB85B2ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 07:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599581C22A5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 06:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29931EB4A;
	Tue, 20 Feb 2024 06:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rjeFNzN9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841821EA71;
	Tue, 20 Feb 2024 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708410635; cv=none; b=eLN6ndakkfgaMV0fm2YIKsxIon4jQWt1aJB5Zb+nVVrQF52LaBJhbtfkQLsdFpphk/6ghowN9uGHbR/jeYu8+cYh9O8V65+o7iWOFK8rfqr5cdbIGFMxJIWuFLkT4lYXsKgZPRmTiqzUJiIPP/tjIyozQxpaNd5VAFv81rtjAzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708410635; c=relaxed/simple;
	bh=D+PIznuYJ18hgVggm/ptv6qhp+HP6M15UycoBPzfxQg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=CPjawKlNVw1G+9/ibE7VASV8SyWtUCVF7PIBUIYHEiQ2D5lF3sZUPSFho0goxGTghjdBGtl24IsxzytNaAb0bRwNSOpuoyIUcjnx14wHlMLTE8zx86Sp8GPt7Q4rYFb1BttRBqIZpK8+Y/HMvjpVcGD6qe9eBhKDrS0Co0v3NHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rjeFNzN9; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708410630; bh=KvQgfrpHTfaIAHlMoCXgNUZv8A1FgCwmH70Zc3FIOTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rjeFNzN9KVqIH5J9to9pG9UM5m79HSR0mUKtf3Kpt4X2aK4VdIkdeVZkO5J9uYYn2
	 eU/22MSE507uf+A+fe9wUXpbYsno2bQHBy5nX9HHx02KUwZYLMCnbPTnqo3VoBOjri
	 +5vCQzLi8OzZ9s48M5nA953rP3+S/23lz7raq+aY=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 440BBCB0; Tue, 20 Feb 2024 14:17:00 +0800
X-QQ-mid: xmsmtpt1708409820to57u16s9
Message-ID: <tencent_7D2D4F8D8DCEA5FA8D85922ADDDB5DEE9907@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujWSJcmP7VMyfwxH2aK9p36RL/XmE6WluWJMRtIQi/FA52eJXEuv
	 yhjC7qKLQoKbKVbR5aHGCZFd0fL2MwqSWcuST4Yz12K7/9XzeKWRQlzvmJB8HRuingxk6bKKfTDm
	 h5+DMyMlw6WeQDg+D929aEPKUr/eAOSnCTA5xUnKkQyZsjpmtrLEBTk0LuTbmRv7A54wFvqPoOfL
	 /3eCcCEbe70oXL8Ax/3tuOjdP/jhU+Sj6AwUSwDjUMg1+gN2vyxsmlr5ZSL6assPezreGIyYuwbB
	 xzPVN9NhYjY2lFNmrOhEk/W8PnfvcenRZe3cX0FawEyGipIZHfSX7/Evb75jye0JLuwgcxtk7oe7
	 DsifPRUEDFgQURIYwOR0wX3cV8QUzHQWErBrp3iTA7/nRZjNvfr5N5yOskz9CC/+Svcl7mOGNmIW
	 k4q3WFvjdF/hcql3XBAgFl7IxqNF7ugm08JMCbs2izrJ6QV84zN5DAr1BjT3IYWni2XDNTvNCfIr
	 9Y+ZkeJt9hRBhCjPctOOae4bi+Ss/b90Li4F7Rr/kZvClc/v1GBAU6DR+niuhFeZJI5DP1vpdzSY
	 7SMqUbJRNS+D+WNz98ZAihIYpfyrkeq7biDjd+wjeZLKJrRjqUFd0xzD8MAQzNVIeD+MLkCQRSY7
	 ojb79YiXSkFpgDSxPkHQ0low6t/WH609Xn3afoCwi4fGlDi7rqbYW/f5xxHSpt6xecaWTy9QjFRu
	 TO+JlgyUyPErqO8auUOI3Dl53t0IWQv7h+rqTXeYY2H0BfHtuyuDnO+OPHBw4wh89JMaCI5v/Hrp
	 0fi3nZ1w7iEA0YWrEHhg6lPsnIujDpweuXGNC13xGq1zsbnb3CZ6zPpPihWj+QDJib3XKkLr8D2V
	 9Xu3PFt6Wp9F3V8VET9apVZW1iNzAMf2XMPxJSUfG3jZNQcXKqGndrLjMHQ1MJERQjVAQjOB5y
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: willy@infradead.org
Cc: eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzbot+c244f4a09ca85dd2ebc1@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] jfs: fix uaf in jfs_syncpt
Date: Tue, 20 Feb 2024 14:17:01 +0800
X-OQ-MSGID: <20240220061700.2256404-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZdQlbc0Hb0UZy6od@casper.infradead.org>
References: <ZdQlbc0Hb0UZy6od@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 20 Feb 2024 04:07:09 +0000, Matthew Wilcox wrote:
> > During the execution of the jfs lazy commit, the jfs file system was unmounted,
> > causing the sbi and jfs log objects to be released, triggering this issue.
> > The solution is to add mutex to synchronize jfs lazy commit and jfs unmount
> > operations.
> 
> Why is that the solution?  LAZY_LOCK with IN_LAZYCOMMIT is supposed to
LAZY_LOCK not cover jfs umount.
> cover this.  Please be more verbose in your commit messages.  Describe
> what is going wrong and why; that will allow people to understand why
> this is the correct solution to the problem.
[Syz reported]
BUG: KASAN: slab-use-after-free in __mutex_waiter_is_first kernel/locking/mutex.c:197 [inline]
BUG: KASAN: slab-use-after-free in __mutex_lock_common kernel/locking/mutex.c:686 [inline]
BUG: KASAN: slab-use-after-free in __mutex_lock+0x8f4/0x9d0 kernel/locking/mutex.c:752
Read of size 8 at addr ffff8880272d2908 by task jfsCommit/131

CPU: 3 PID: 131 Comm: jfsCommit Not tainted 6.8.0-rc4-syzkaller-00388-gced590523156 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:488
 kasan_report+0xda/0x110 mm/kasan/report.c:601
 __mutex_waiter_is_first kernel/locking/mutex.c:197 [inline]
 __mutex_lock_common kernel/locking/mutex.c:686 [inline]
 __mutex_lock+0x8f4/0x9d0 kernel/locking/mutex.c:752
 jfs_syncpt+0x2a/0xa0 fs/jfs/jfs_logmgr.c:1039
 txEnd+0x30d/0x5a0 fs/jfs/jfs_txnmgr.c:549
 txLazyCommit fs/jfs/jfs_txnmgr.c:2684 [inline]
 jfs_lazycommit+0x77d/0xb20 fs/jfs/jfs_txnmgr.c:2733
 kthread+0x2c6/0x3b0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242


Freed by task 5177:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3f/0x60 mm/kasan/generic.c:640
 poison_slab_object mm/kasan/common.c:241 [inline]
 __kasan_slab_free+0x121/0x1c0 mm/kasan/common.c:257
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x124/0x370 mm/slub.c:4409
 lmLogClose+0x585/0x710 fs/jfs/jfs_logmgr.c:1461
 jfs_umount+0x2f0/0x440 fs/jfs/jfs_umount.c:114
 jfs_put_super+0x88/0x1d0 fs/jfs/super.c:194

[Analyze]
This issue occurs due to task 131 executing jfs lazy commit and task 5177 executing
jfs put super (which will release objects such as sbi and jfs log).

The solution is to use mutex to sort the two tasks and determine whether the log
and sbi objects are valid before using them. 
This way, regardless of who executes the two tasks first, the latter can determine
whether the log and sbi objects are valid or invalid, thus avoiding the current problem.


