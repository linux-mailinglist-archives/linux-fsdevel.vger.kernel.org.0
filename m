Return-Path: <linux-fsdevel+bounces-47413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 215DBA9D298
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 22:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF4F1BC4127
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 20:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C40B221D86;
	Fri, 25 Apr 2025 20:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r1rMBRHl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6358F21ADC6;
	Fri, 25 Apr 2025 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745611273; cv=none; b=LJRYpaA7CykTRIUB+Kkk2LrGbbXCpoJJnns2WnvhK++4//eIlnQBnUiZLzlj2wvo36HljDdQA+gkDlLiVdH/+h9MwdVdYKZx40UR7bF8z6uZ9lWGgKrOXWWLlKkYnHZchUqRebjXEBB/epu3uQKlC+IeMG7bzL0jSZs6dvwNplE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745611273; c=relaxed/simple;
	bh=n/1fR8HSszgJneX29axl6+BbOER/pnjQNSYcb0wrvXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtIXuQkIv0pRaqlSCFj3V8Nu0n40WpsDLX44QI80LdM15GOqNYMEANRatZnxliPdx302mzLlZwjueoQ48xj/UOu7wIX5HPFMt78MTxbBON8RmmVGkch3b3UNthi1fw0SRPWfBCR66jzZPuVJwXrpSEhnK1GUQnE7UX/QidLroCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r1rMBRHl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PCZojZ/zHTrseUyjrDFiaUsL6Zd8Ugb18vD3fXoqbck=; b=r1rMBRHl3w6e4SEbKmMjDlPgiP
	VuXgnMLo4Br5pl1kRwRoU5Uo10fpPpbtb4x8LDL/tTQtiLAzTfUi74AD1rL91Nn/AnHvQkAB0ENE7
	Mf2n7TNe5CsRkUiOkTLbsUbiFVE2nvTxTjsJ2+J1SqF1AtLGMm9lQtRSJF2hXs0XGdkzN6huHZ6ef
	FgnqyCMw56YMQrkJKRmHJmyyTh2IHyCKeUXSEv1VzF3vwEUGqeIcSf4UaMOYEkUXL3Hzhby+dsxnI
	//kPM0KoX4hmj3YYlSdpWrXzQpbI6IR9ORQrDzbA30pKODNdHxixF8Ig0nktOGktFWtlprkJX4jfF
	nRIL5D+g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8PEO-0000000FPAl-2mRE;
	Fri, 25 Apr 2025 20:01:04 +0000
Date: Fri, 25 Apr 2025 21:01:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: Jan Kara <jack@suse.cz>,
	syzbot+de1498ff3a934ac5e8b4@syzkaller.appspotmail.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net, shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [RFC PATCH] fs/buffer: Handle non folio buffer case for
 drop_buffer()
Message-ID: <aAvqAMBW7fzYkz_o@casper.infradead.org>
References: <66fcb7f9.050a0220.f28ec.04e8.GAE@google.com>
 <20250423023703.632613-1-richard120310@gmail.com>
 <nfnwvcefhvm5sfrvlqqf4zcdq2iyzk4f2n366ux3bjatj7o4vl@5hq5evovwsxp>
 <aAu92k-iPbnWBKGz@vaxr-BM6660-BM6360>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAu92k-iPbnWBKGz@vaxr-BM6660-BM6360>

On Sat, Apr 26, 2025 at 12:52:42AM +0800, I Hsin Cheng wrote:
> > Can you print more about the folio where this happened? In particular it
> > would be interesting what's in folio->flags, folio->mapping->flags and
> > folio->mapping->aops (resolved to a symbol). Because either the mapping has
> > AS_RELEASE_ALWAYS set but then we should have ->releasepage handler, or
> > have PG_Private bit set without buffers attached to a page but then again
> > either ->releasepage should be set or there's some bug in fs/buffer.c which
> > can set PG_Private without attaching buffers (I don't see where that could
> > be).
> > 
> 
> Hmm so I suppose when there're buffers attached, the PG_Private bit
> should always be set in folio->flags or folio->mapping->flags or
> folio->mapping->aops ?

See folio_attach_private().  I am trying to get rid of PG_private, but
we're not quite there yet.  The other information may help track down
what is going on.

