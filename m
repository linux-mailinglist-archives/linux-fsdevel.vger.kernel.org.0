Return-Path: <linux-fsdevel+bounces-7676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E96C582930E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 05:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D48B2891E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 04:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6596D8BF7;
	Wed, 10 Jan 2024 04:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Xz/QTWGU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B053A6FAF;
	Wed, 10 Jan 2024 04:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFFCC433F1;
	Wed, 10 Jan 2024 04:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1704861837;
	bh=RKClabnfbCkpoH3vhzF2N9v90yEPu3odm1xJiTbC6Qk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xz/QTWGUo/6dZ6/hjpWWoB0F1FjKRq+euouAygBcGRWgToVFGW3nslnADnZ/9K87p
	 7fu3CoEto8PtfPTdNEMs5pUtTcZ6fMFi4NqNiJn6qtFCwjZWrY1FbOOx1J8sUIuzsH
	 Ngz4WszWViXwj6voGoRqpPneYmWIfr6RJ3V2k7Fc=
Date: Tue, 9 Jan 2024 20:43:56 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, David Hildenbrand
 <david@redhat.com>, Andrei Vagin <avagin@google.com>, Peter Xu
 <peterx@redhat.com>, Hugh Dickins <hughd@google.com>, Suren Baghdasaryan
 <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>, Kefeng Wang
 <wangkefeng.wang@huawei.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 =?UTF-8?Q?"Micha=C5=82_Miros=C5=82aw"?= <mirq-linux@rere.qmqm.pl>, Stephen
 Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
 kernel@collabora.com,
 syzbot+81227d2bd69e9dedb802@syzkaller.appspotmail.com,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: move mmu notification mechanism
 inside mm lock
Message-Id: <20240109204356.6c088124a9ba0ce0b5a4bb00@linux-foundation.org>
In-Reply-To: <ZZ10FqvnVWIbyo-9@google.com>
References: <20240109112445.590736-1-usama.anjum@collabora.com>
	<ZZ10FqvnVWIbyo-9@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jan 2024 08:28:06 -0800 Sean Christopherson <seanjc@google.com> wrote:

> > -	/* Protection change for the range is going to happen. */
> > -	if (p.arg.flags & PM_SCAN_WP_MATCHING) {
> > -		mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA, 0,
> > -					mm, p.arg.start, p.arg.end);
> > -		mmu_notifier_invalidate_range_start(&range);
> > -	}
> > -
> >  	for (walk_start = p.arg.start; walk_start < p.arg.end;
> >  			walk_start = p.arg.walk_end) {
> >  		long n_out;
> 
> Nit, might be worth moving
> 
> 		struct mmu_notifier_range range;
> 
> inside the loop to guard against stale usage, but that's definitely optional.

Yes, I think that's nicer.

--- a/fs/proc/task_mmu.c~fs-proc-task_mmu-move-mmu-notification-mechanism-inside-mm-lock-fix
+++ a/fs/proc/task_mmu.c
@@ -2432,7 +2432,6 @@ static long pagemap_scan_flush_buffer(st
 
 static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
 {
-	struct mmu_notifier_range range;
 	struct pagemap_scan_private p = {0};
 	unsigned long walk_start;
 	size_t n_ranges_out = 0;
@@ -2450,6 +2449,7 @@ static long do_pagemap_scan(struct mm_st
 
 	for (walk_start = p.arg.start; walk_start < p.arg.end;
 			walk_start = p.arg.walk_end) {
+		struct mmu_notifier_range range;
 		long n_out;
 
 		if (fatal_signal_pending(current)) {
_


I'm surprised this code doesn't generate a might-be-used-uninitialized
warning.  I guess gcc got smarter.


