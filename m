Return-Path: <linux-fsdevel+bounces-57817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78145B258DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 03:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C601C21B5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 01:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E3C19CCEC;
	Thu, 14 Aug 2025 01:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="tPycMhMr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1AF188000;
	Thu, 14 Aug 2025 01:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755134107; cv=none; b=t7Rhzg9ZA1cDuGZ0mfJhW27FM4BmLRGjinQ0trunmAPOrWd51Csz9tWf1NMnfoH1muvqgCZRELCJB9DjuSRlP27TOtnlDx7gmvfDtuxuaJMzS50QoCUPTKt2248qD89srGL9IIPe2RU68SQ8QFQbfSI7WebxPJggjNf8FxnCVoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755134107; c=relaxed/simple;
	bh=y9PO2PO6nPeVBRQUafPLj9FIxNajLXqS18P2UUJjTFc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=T7F1Nc4HqLhv0lVl1eNXtwRVAWgXZuZ0w2rrtzmIXm87pJlyrjPor31HKVWbU/1aONuMgS5dOz3pbEs54YRtLu/GHE6DdU6XpJUybC/QEDw8oOA+npS6Rz6L84xmZQkcQLb5E65gacCWEbBJahRsgAijavvbqV43GrFWChOQa4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=tPycMhMr; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 468D714C2D3;
	Thu, 14 Aug 2025 03:14:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1755134096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=VSS/GzTf7mRkzo4sO438c/imKZ2sgMqL0KjQB+0sB9s=;
	b=tPycMhMr7X0wubaDHNZnMqB/VEiz0UUE8omXCbl8cVPraMQEqlPqNl3No+vWVKYafyfuSA
	xhjW37XOoQV3q0j5uHaXh7YYbCRG3IZ+tEUlLhY8SaSBmV/WqNdlGIekaFWtvKennOmXOg
	0jP8VHStgbUj1JeXRD4kB6OG5m1l26zOxuPZDjMXERijZSNrQI3moAFxCHhbi/gpYqBfCC
	2bzC09Ecy/3pG2mjK78rVDFpscJKNFoOvRfr4bJcTgSUHhKrooXlVZISs1Qm35JZT+XjI1
	2qZyXvNOntTkDnzLDvryfNjAjjTCBnXfmst23VvZ/ZElMoQUN43e9Adp+48JMQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 5e52dd40;
	Thu, 14 Aug 2025 01:14:49 +0000 (UTC)
Date: Thu, 14 Aug 2025 10:14:34 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Maximilian Bosch <maximilian@mbosch.me>,
	Ryan Lahfa <ryan@lahfa.xyz>, Christian Theune <ct@flyingcircus.io>,
	Arnout Engelen <arnout@bzzt.net>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iov_iter: iterate_folioq: fix handling of offset >=
 folio size
Message-ID: <aJ04ej2P3ZXiBjOG@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f389ac0d-de77-4443-9302-3d8895e39daf@paulmck-laptop>
 <aJyYp-3VA9kJ5YMd@smile.fi.intel.com>

Andy Shevchenko wrote on Wed, Aug 13, 2025 at 04:52:39PM +0300:
> > I actually test with W=1 too, but somehow this warning doesn't show up
> > in my build, I'm not quite sure why :/
> > (even if I try clang like the test robot... But there's plenty of
> > other warnings all around everywhere else, so I agree this is all way
> > too manual)
> 
> Depends on your config, last few releases I was specifically targetting x86
> defconfigs (32- and 64-bit) to be build with `make W=1`. There are a couple of
> changes that are still pending, but otherwise it builds with GCC and clang.

I meant it the other way around: the warning isn't showing up on master
+ these patches for my config.

But now I double-checked, 'CC=clang make W=1' doesn't actually use
clang, I should have tried 'make CC=clang W=1'...
And, yeah, it just doesn't show up with gcc so I'll know it's better to
check both compilers...

Paul E. McKenney wrote on Wed, Aug 13, 2025 at 04:04:19PM -0700:
> > I hope this to happen sooner as it broke my builds too (I always do now `make W=1`
> > and suggest all developers should follow).
> 
> This build failure is showing up in my testing as well.
> 
> In the service of preventing bisection issues, would it be possible to
> fold the fix into the original patch?

Andrew just picked v3 up, so there won't be any such problem, and -next
will stop failing after today's update

-- 
Dominique Martinet | Asmadeus

