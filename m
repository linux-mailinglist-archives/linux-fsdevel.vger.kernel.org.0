Return-Path: <linux-fsdevel+bounces-58216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA649B2B3C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 23:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0C6620BAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 21:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E776276038;
	Mon, 18 Aug 2025 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="moSNTz60"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA40275869;
	Mon, 18 Aug 2025 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755554140; cv=none; b=ffFX0zTauiJ18iGG6rWpqQF16PXfA3nwyDOcm+2jX1MY2a3DZ2piuYTMz+HU+OQUiUfTWhqqpHAnhyN3n66xvi663mzikydzLBx+BgoKBF5nnW8LP1R7yNDMr6DTVHebhzqe80rrPK/AkOZ7YxpLGxeVhOpMX8yi/AWBppacTmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755554140; c=relaxed/simple;
	bh=AvPnhp8uiVkXXK54PS71qwBLejCBhN5BMJOLT95GAbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWmq7cmqPP1x+0LVdRLJg64nDF3Pk9sbd2/HUiw68zSOSxGK4RripO09RaPDHDqrBaW09yh/ife9su8Rwly/Wb2BOeJ5Gw4PvwCEV1WgwvAEMmU+uDL5ud9lBmdJviBB85+b8bqV958evRz3XSIEzB//SQVrjXlkiey5iFhdlpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=moSNTz60; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id C157514C2D3;
	Mon, 18 Aug 2025 23:55:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1755554135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=auLOhWoJLzMo5J4E2hQaw+rrZVFMM1bMgBRMGY/PL2o=;
	b=moSNTz60+w3p/T7Zd9IShd1kdgP0RV90fFSfnL1+vsHRSeh7tj/xyJii/z3OkUe+FH5nC6
	nDIO9qHEMECFFjhGZMOLkqH8yUAM0Ai8uTeYNHFA90EYfsqxqbzBhPJ+TK7a9bv0eiGMuP
	81V/4OSzpxsKhGaX+yZzdQ9VeD8rJB4c17ywfQUb2sLa7sGbm6H1iJ4i7zTPzIdcG0EAD6
	q6aVhSJDZeodIqNpr0c6vxMg/IC8+57UCNk1ybDfE1powYj1yG2Q1Dxrf1CCkgRkQCX7YC
	emBsonRLxlE+KQdqi/00x1h+EfKsFJb+q1hvEaIK9T0W8yoWtDdh2iA66ixJYw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 05349875;
	Mon, 18 Aug 2025 21:55:29 +0000 (UTC)
Date: Tue, 19 Aug 2025 06:55:13 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: syzbot <syzbot+d1b5dace43896bc386c3@syzkaller.appspotmail.com>,
	David Howells <dhowells@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>, akpm@linux-foundation.org,
	brauner@kernel.org, dvyukov@google.com, elver@google.com,
	glider@google.com, jack@suse.cz, kasan-dev@googlegroups.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [syzbot] [fs?] [mm?] INFO: task hung in v9fs_file_fsync
Message-ID: <aKOhQcVwLd1Kvt6N@codewreck.org>
References: <20250818114404.GA18626@redhat.com>
 <68a31e33.050a0220.e29e5.00a6.GAE@google.com>
 <20250818125625.GC18626@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250818125625.GC18626@redhat.com>

Hi Oleg,

Oleg Nesterov wrote on Mon, Aug 18, 2025 at 02:56:26PM +0200:
> On 08/18, syzbot wrote:
> > syzbot has tested the proposed patch and the reproducer did not trigger any issue:

(I hate that syzbot identified "hung in v9fs_file_fsync" but doesn't
bother to Cc 9p folks... all the time..)

> Dominique, David,
> 
> Perhaps you can reconsider the fix that Prateek and I tried to propose
> in this thread
> 
> 	[syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
> 	https://lore.kernel.org/all/67dedd2f.050a0220.31a16b.003f.GAE@google.com/

I've re-read that thread, and I still think this must be a problem
specific to syzbot doing obviously bogus things (e.g. replying before
request, or whatever it is this particular repro is doing), but I guess
your patch is also sane enough and the 9p optimization is probably not
really needed here

Please resend as a proper patch, and I'll just run some quick check (and
a trivial benchmark) and pick it up

Thanks,
-- 
Dominique Martinet | Asmadeus

