Return-Path: <linux-fsdevel+bounces-55143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC58B0745F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 13:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186123B4A11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 11:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB672F3622;
	Wed, 16 Jul 2025 11:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WpUi2ixj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955A02F2C56;
	Wed, 16 Jul 2025 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664269; cv=none; b=ZyQg9wNAMZn1ZFKRfyyegZq5lwaVyTKD4ahHVPJGyc9gcj/cZYG6p0Gpzu2ovZ6if68h1jAmbL8+xk5a2kQtOILQ4wYS7rHm2kBy89XeCqsfRyBJUKA64n5R+7t3/NC8RT0qRUOaeCdf2oNPOQE/mVx8HwloSeZLrZv/fLP2iPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664269; c=relaxed/simple;
	bh=qCvWScO7YT9tPuS9HlSbk2B84ChQADd2yavwcy3BNDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xen8u/PRPaNI9whNbhNdi4TxU1b17MpxPkdKp5mBq3Mxz5WA3koFUq98c6CLwXDAyoR9NhwU/rjaHGA6nxDL85IS/3mn50CW+I9bSPhd8RYoH/JBOVNwyqE68NSiLa6KCNKUUv48Gu5GPGCbshH/6lp+l9HmkAbXFi95H7AuYAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WpUi2ixj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=YNM4YXiRTugYP4St2XF/wvdNCP1F0YhY9Wc6I1yX/lQ=; b=WpUi2ixjQpHpCwpmWHNzQ3ZPH4
	TAIyUU3rZLF9AvlXQDLcnV0SDyrNC2F+DSLxKxKjiB/Wj6rSrPey8QjQjKU4s9dHi4X/2kQWF2dle
	1yjmJAa04ES4ukuR0WJ/SQH/SihjW6nW1i4EIlOex3G6REXNZlWSh9uMgt2/jUwIb/iJVnVRBEWOO
	oUCn4VY5w3hXMZ1Fx9QXOcvyg8runbraUzuG0/AB+RW+qhBbmj84GwExKiaonqxdvi4lSindp7K+/
	C4q6ZoOEfe4YnE8W4uMrsjcz5ck3CNyqcAsjV6kdIqRNMCOiuP2Qc3bbnh8jngcdblZvgbMgG4M8p
	3Zn9UFRQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc02S-00000007WPi-3mfS;
	Wed, 16 Jul 2025 11:11:04 +0000
Date: Wed, 16 Jul 2025 04:11:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/15] fs,fork,exit: export symbols necessary for
 KUnit UAPI support
Message-ID: <aHeIyNmIYsKkBktV@infradead.org>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
 <20250626-kunit-kselftests-v4-6-48760534fef5@linutronix.de>
 <20250711123215-12326d5f-928c-40cd-8553-478859d9ed18@linutronix.de>
 <20250711154423.GW1880847@ZenIV>
 <20250714073704-ad146959-da12-4451-be01-819aba61c917@linutronix.de>
 <20250716072228-2dc39361-80b4-4603-8c20-4670a41e06ec@linutronix.de>
 <aHdE9zgr_vjQlpwH@infradead.org>
 <20250716101207-c4201cef-abbe-481d-bca5-c2b27f324506@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250716101207-c4201cef-abbe-481d-bca5-c2b27f324506@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 16, 2025 at 10:39:57AM +0200, Thomas Weißschuh wrote:
> Let's take kernel_execve() as example, there is no way around using this
> function in one way or another. It only has two existing callers.
> init/main.c: It is completely unsuitable for this usecase.
> kernel/umh.c: It is also what Al suggested and I am all for it.
> Unfortunately it is missing features. Citation from my response to Al:

But why does the code that calls it need to be modular?  I get why
the actual test cases should be modular, but the core test runner is
small and needs a lot of kernel internals.  Just require it to be
built-in and all this mess goes away.

That being said some of this stuff, like get_fs_type / put_filesystem
or replace_fd seem like the wrong level of abstractions for something
running tests anyway.


