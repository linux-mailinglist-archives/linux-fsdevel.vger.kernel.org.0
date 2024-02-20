Return-Path: <linux-fsdevel+bounces-12083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3802985B1D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 05:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED5A282F19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 04:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A768554F94;
	Tue, 20 Feb 2024 04:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S//xKMks"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E87535B4;
	Tue, 20 Feb 2024 04:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708402042; cv=none; b=r5fn1X7VnXtgT98Vq0luuboy0XccaDbrimFVl1hQaCjpEvJnLifU1FQ92JticXjoKyNygcIsRRU5+hhHvSYbJRLPnNn+so6vAnyizv9A7mhLzDkk1E+5/30Yk7H98dQO/z3ZAJG5eQVVY8R3VAWMpO+aTnfudb7cLX/YdFB9Cp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708402042; c=relaxed/simple;
	bh=WzcJaUbAd9e6n4Q8B/516dQe7OIlDOfUYRQ8n1ZqKVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIfO+TCkJI9ZDuDQAHkWswHNxwG4HPEzlr3QVXo1nS7U+NwFf8LL6FbfEMqBaHB50tEMRTWUID6NGCtyYA98DidfJII20YOv15kV9acNMo5MR3oC5CZA5elGsIuc4XuH7SEuUS06jSiX1R3oHh71BPTAlCdvYqs3rbCX5OES85k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S//xKMks; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NV09tUAzZc9dnnCtco4N+xbImTBJKqV3EQlqPqU5324=; b=S//xKMks2ig+UZ7aW6tJN8A8Oa
	7/13hOBwKMRxyhtgHiAYyph09RhQnc/uq1h+5Yrtus0OvkBRbLC18p0MR7C/d9aVFr5t1R/TwAXZN
	x0K4cxR4q3cPRF6+BAFbh8lU0mzRACVntAsnkLZmAStbIncRRoxR5CjJMKsMf9nRLQkgZhUX5v4lP
	PpwDcVBLo9bGGnZz9XG8/fHmX8scVoSRX4Jnzx/cEtgPDrlPs/b5ReLvVutH1kj95Ho0XtFZUDg1v
	ZUuswLW+qV3B7tBZobwekgFvd1LHdhbfDKGS/NVkoIvzVtZOd+538o0ui/Qfr4FMD2sg8YZSfSdbl
	hF8mK5Dw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcHPR-0000000Eat0-0mh3;
	Tue, 20 Feb 2024 04:07:09 +0000
Date: Tue, 20 Feb 2024 04:07:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+c244f4a09ca85dd2ebc1@syzkaller.appspotmail.com,
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] jfs: fix uaf in jfs_syncpt
Message-ID: <ZdQlbc0Hb0UZy6od@casper.infradead.org>
References: <0000000000003d021006119cbf46@google.com>
 <tencent_E860EA86EF0ECC0079FA6D3C2D496D30940A@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_E860EA86EF0ECC0079FA6D3C2D496D30940A@qq.com>

On Tue, Feb 20, 2024 at 11:55:18AM +0800, Edward Adam Davis wrote:
> During the execution of the jfs lazy commit, the jfs file system was unmounted,
> causing the sbi and jfs log objects to be released, triggering this issue.
> The solution is to add mutex to synchronize jfs lazy commit and jfs unmount 
> operations.

Why is that the solution?  LAZY_LOCK with IN_LAZYCOMMIT is supposed to
cover this.  Please be more verbose in your commit messages.  Describe
what is going wrong and why; that will allow people to understand why
this is the correct solution to the problem.

