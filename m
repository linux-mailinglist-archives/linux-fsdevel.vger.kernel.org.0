Return-Path: <linux-fsdevel+bounces-34960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576CA9CF251
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 18:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01002816E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 17:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C551D5170;
	Fri, 15 Nov 2024 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TvAiwS/E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15854163;
	Fri, 15 Nov 2024 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731690207; cv=none; b=KcHBP45kc24xQ9Gba7iP8PxrmEwOA3ElSvcPtWNSk0bFKwbxk1afbatZ5b0WILE197O5Uz8RBbqJy7O6KZMVkG3f7dSlbHAYQmhx8kHRjaAt1nlf8wXxhJLgtyuDWekc6hYjIWI/01Qv5I95ciqm5jfIzGjD+Ie2USSfkQC3HP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731690207; c=relaxed/simple;
	bh=ugQtQNrTRgu0hoK5Nnku/3CrqPXtkQCqjUnpyQHX4oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvII6w457uPWgLMzZ2rRKsLa+x6Xcy4hLOUwsN8y1qSE09/cKoyof9hRnFXFqlz+7hwoEzJmuPquoeSMtO7vVblmmwK3NWc2HnTou9VC03LOVKJ5c+g156HrXvQ6jt3Ci+7cc4r/gvy/mAM/rTt1UHbri+5gcUXj/7Nx6PGvsP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TvAiwS/E; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K7zEdA/GzcTPZjE4/1GuhRRBG5KqT+kHRTv9twkHvWc=; b=TvAiwS/EV/jX3qrud/O99k1nKI
	NjJxvKfabJMbBitmzQWIM68kxPvWp1akGfKbmPixhigy3efSIoTgI125qI5SfYQ1emjVlJOkb3KqH
	HPlATuVJplJkaEWAg7RDshEYgRR9PlB7Cfi0lXjZdNanPUOc0Kcks39YaxJ8c98WWikvgxIi0RIVf
	pMOQ9jkcKE7AU4XNukakqSomhGJaTNxRkq3cT4EBwS7fqoWN6+lQoZouEHCN5v7fBGWtBVQtJe/YX
	Q53GgGRU3SeZRcpdkoWMjmN2cVkzQhnGNRS17545qXK+hWNvQDE8oj0eGNj3XElyeXUZdLcV0b0k7
	8OjrMIsw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBzj8-000000007JN-2Jo1;
	Fri, 15 Nov 2024 17:03:22 +0000
Date: Fri, 15 Nov 2024 17:03:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+18dd03a3fcf0ffe27da0@syzkaller.appspotmail.com
Subject: Re: [PATCH] hfs: Fix uninitialized value issue in hfs_iget
Message-ID: <Zzd-2iVB2AtJaxR8@casper.infradead.org>
References: <20240923180050.11158-1-surajsonawane0215@gmail.com>
 <e43ec7eb-6acf-41e3-b7f9-f0391bf4cb65@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e43ec7eb-6acf-41e3-b7f9-f0391bf4cb65@gmail.com>

On Fri, Nov 15, 2024 at 09:22:31PM +0530, Suraj Sonawane wrote:
> On 23/09/24 23:30, SurajSonawane2415 wrote:
> > Fix uninitialized value issue in hfs_iget by initializing the hfs_cat_rec
> > structure in hfs_lookup.

This doesn't make sense to me.  I don't see how we get to hfs_iget()
with an uninit "rec".

        hfs_cat_rec rec;
...
        res = hfs_brec_read(&fd, &rec, sizeof(rec));
        if (res) {
...
        } else {
                inode = hfs_iget(dir->i_sb, &fd.search_key->cat, &rec);

Unless there's a path in hfs_brec_read() which returns 'success' while
not actually filling in all of 'rec', in which case that's the bug which
needs to be fixed.


