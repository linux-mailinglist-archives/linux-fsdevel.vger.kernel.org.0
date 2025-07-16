Return-Path: <linux-fsdevel+bounces-55091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8113FB06DCD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 08:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB11B7ADCFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 06:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449452857CD;
	Wed, 16 Jul 2025 06:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mofl2wKn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C878198E8C;
	Wed, 16 Jul 2025 06:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752646907; cv=none; b=fRHJYxAQ5wf+sTcH2pltJPVUn4iTvrUjaJX/leb0fCYfYgXmpL4qUvMBF2JVCJrROaaFoCbn1qPhfzJwLhZLyjxFWXTPo4HnDBQTzhcw2mc6npBHbR1WQdDl/DAHLBCrlZyAQCh9HONEwkEix3MLtRNuv2GAUTvoAj+yod5KYsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752646907; c=relaxed/simple;
	bh=9PZIFgfH82r21F06l+nCFRIcTPUzxHwFnEZukofFnz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UR80CLIRS3loGG47wOp3iv5teslQyIG1g1f/INGab1JyAplRQXAmaBKWkN0Hh+W1jWV9PXlRzooHcyUwiHtDA3JkyrSpG46Tf2WmUY7jAiAYw3SfXZl/MyTG3Sdscue7qFt7WMF3suwdegrKKjBFkYfGf3nqiTY4LcgVyFNV6rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Mofl2wKn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=YKkz8lS5G74bKddbsW4P64woHWlQNnkiSMyItwjDQj8=; b=Mofl2wKno1Md6XD6b+fYMr4jXm
	7SPSnCY3GTxiKu5cqwg/aT6B8jX4hK5FSYgXzUgPEeSbH8vsn7k5+RdI6SjHvqJZNiUmLuwRSiz+C
	wwUg2d1683/pnc39qjye0llTFXv04LmqzMPNpl9SSWg4xCnvRiFNIaUPR4gU+x7JjC1T+yqHSfZ4u
	dSUSRl9+/UF9lUsqkTBlYotLhOsx4hrv+nzwfIAr4nmXVM4xeo33TGKD4eNH4/T9fT/dXryvLz0Rc
	Mgo863jaxZZSnHCGdU8NGcr/iHEWxBzmp6UIs+hoTFQRESKy8pQSGoeM0hQO+DdseOnpSXCJKfh+o
	Jbqj6E6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubvWR-00000006sCF-1M3N;
	Wed, 16 Jul 2025 06:21:43 +0000
Date: Tue, 15 Jul 2025 23:21:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/15] fs,fork,exit: export symbols necessary for
 KUnit UAPI support
Message-ID: <aHdE9zgr_vjQlpwH@infradead.org>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
 <20250626-kunit-kselftests-v4-6-48760534fef5@linutronix.de>
 <20250711123215-12326d5f-928c-40cd-8553-478859d9ed18@linutronix.de>
 <20250711154423.GW1880847@ZenIV>
 <20250714073704-ad146959-da12-4451-be01-819aba61c917@linutronix.de>
 <20250716072228-2dc39361-80b4-4603-8c20-4670a41e06ec@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250716072228-2dc39361-80b4-4603-8c20-4670a41e06ec@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 16, 2025 at 07:30:46AM +0200, Thomas Weißschuh wrote:
> On Mon, Jul 14, 2025 at 07:52:28AM +0200, Thomas Weißschuh wrote:
> > On Fri, Jul 11, 2025 at 04:44:23PM +0100, Al Viro wrote:
> 
> (...)
> 
> > > On Fri, Jul 11, 2025 at 12:35:59PM +0200, Thomas Weißschuh wrote:
> > > > could you take a look at these new symbol exports?
> > > 
> > > > > +EXPORT_SYMBOL_GPL_FOR_MODULES(put_filesystem, "kunit-uapi");
> > > 
> > > What's that one for???
> > 
> > What are you referring to?
> 
> Reading this again you probably asked why put_filesystem() is exported.
> 
> As I see it, that should be called after being done with the return value of
> get_fs_type(). Not that it does anything for the always built-in ramfs.
> The alternatives I see are a commented-out variant with an explanation or
> making put_filesystem() into an inline function.

The right answer is to rework your code to not need all those exports.
Nothing modular, and especially not something testing only should need
all these low-level bits.


