Return-Path: <linux-fsdevel+bounces-63723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AE2BCBB81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 07:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7CF3BB040
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 05:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA012264A90;
	Fri, 10 Oct 2025 05:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OpiCnd/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7F61494CC;
	Fri, 10 Oct 2025 05:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760074081; cv=none; b=nUq47Nth6bYpGOIXO5ddPz5p5Ergj0k1YSybo9jbbXKudOyxN4oNWDq++e0taGrCJ5jF8eRpnFmhNO8H4APbZVuFGPCncameTgcgfKNj6G+v1p3MdFw9WOKEDMP6fCq3anV9BIY7/xOIUlXJSa9Y7+GTjQz0JZDa596g937T/GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760074081; c=relaxed/simple;
	bh=mDGmi3+Wa36bqb6hX02bN3onFxey1pLGTUWruEAOyX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQgFS2Y8BLj7tI6j95IIWXkLYEMH5CEcNgQFZT8TPajokH1P+pKJ5h1IVu5ZGAI72HlKJSrEHN3xx5ugurQuPGm2hbdFFK6FtGvvu+u7pM/tV4Bv+F3d5L+ThWrluWKQK/a0M0XOh3JrQOvM4UGZ7rkjKyHOv+n/CKJav+A+btU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OpiCnd/J; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=yWCrP/oYlMAZ7QVzoZ7F/7mx1aOjPJpsMFlqIpG86h8=; b=OpiCnd/Jqy1af1tAwRQ4Qpyh+8
	F++KMdLENM6ks6AvSoUSYtgsC8KojVVV49pzb4vkeqlPa6b149RQHZic1gRVMj9hCeo6lb60MxN3T
	hFl14gI6LGbmagzn1SYlBgZJe+vpAS8C7G+HMNnRLYgIHGkRcX+wlLrQW5nGIh7MieTX2Jh9nRvaZ
	Nvhu7UAck0WWV8nSBM/8Ku2ZZ/DreBNJVp65+Vx4d9+Bk1DacjZBahGuiEGr/KikKG2IgzCRczl0c
	rLOIxSHyAvePYkgeC6XFzYT2fHGivhAsAlQTxSsA3LseEpOZH3cNM8KgfDxtGVjXHhEnxbtbl+MJx
	vLBpOmKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v75fb-00000007iAF-17zR;
	Fri, 10 Oct 2025 05:27:59 +0000
Date: Thu, 9 Oct 2025 22:27:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Christoph Hellwig <hch@infradead.org>,
	Pavel Emelyanov <xemul@scylladb.com>, linux-fsdevel@vger.kernel.org,
	"Raphael S . Carvalho" <raphaelsc@scylladb.com>,
	linux-api@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] fs: Propagate FMODE_NOCMTIME flag to user-facing
 O_NOCMTIME
Message-ID: <aOiZX9iqZnf9jUdQ@infradead.org>
References: <20251003093213.52624-1-xemul@scylladb.com>
 <aOCiCkFUOBWV_1yY@infradead.org>
 <CALCETrVsD6Z42gO7S-oAbweN5OwV1OLqxztBkB58goSzccSZKw@mail.gmail.com>
 <aOSgXXzvuq5YDj7q@infradead.org>
 <CALCETrW3iQWQTdMbB52R4=GztfuFYvN_8p52H1fopdS8uExQWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrW3iQWQTdMbB52R4=GztfuFYvN_8p52H1fopdS8uExQWg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 08, 2025 at 08:22:35AM -0700, Andy Lutomirski wrote:
> On Mon, Oct 6, 2025 at 10:08 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Sat, Oct 04, 2025 at 09:08:05AM -0700, Andy Lutomirski wrote:
> > > > Well, we'll need to look into that, including maybe non-blockin
> > > > timestamp updates.
> > > >
> > >
> > > It's been 12 years (!), but maybe it's time to reconsider this:
> > >
> > > https://lore.kernel.org/all/cover.1377193658.git.luto@amacapital.net/
> >
> > I don't see how that is relevant here.  Also writes through shared
> > mmaps are problematic for so many reasons that I'm not sure we want
> > to encourage people to use that more.
> >
> 
> Because the same exact issue exists in the normal non-mmap write path,
> and I can even quote you upthread :)

The thread that started this is about io_uring nonblock writes, aka
O_DIRECT.  So there isn't any writeback to defer to. 

