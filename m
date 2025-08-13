Return-Path: <linux-fsdevel+bounces-57705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F69B24B06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA10E167860
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 13:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E478E2EB5D3;
	Wed, 13 Aug 2025 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="iVDqdWfO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD7B72612;
	Wed, 13 Aug 2025 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092759; cv=none; b=a4AZIe3YPBX+e3pgBB0cc5zD6cY961wgQy9tMaEWwr+XbDuvfOI6Pn2Szf+uhorxapjy5O3hETDRC8oPCrcFkGuLkdYLqhFarT5p1folhgj/9mgDgSLvaR1k8RV2qG5zSadwd55cU+9l9EHaPgr1nRyxjtTzGLb6wMKEH4xDZYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092759; c=relaxed/simple;
	bh=/moHEU+jrzpSY24+lzEDBteKQ7bkZsCMo6ltlWZ5QxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUrvx1POMdhJiouMMZhNpukEZBgSkhUdgPBUshfCxFTk/YzCGVbrzfx+KutCWViCwVZg7DAEaKm7ZYCOmQQuprB3ZDjojuUM2US8ZcuTZtLTmTixIW6+c26ryZ/A8K5poMG7mOF001pcgObPvZuZEKf5C9gb3YEuL2fd7O86JW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=iVDqdWfO; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 67C9814C2D3;
	Wed, 13 Aug 2025 15:45:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1755092755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O7DIiSFTU0d+SOR8smmh+GVaLhshEu060AgzuYvrVMU=;
	b=iVDqdWfOqfC7zGw5pMTbF0uOkQf840TCcqccC6MfX+jhl/kiESHTstDOEoMxRS/nUQ9Ds6
	MEBHYWhy9RuQ9+cBA7nglc0sbtNAHjYVZFMvMLj68pFX5tUfEPka2mGiIJnWGOiM4o41Ev
	RXYM4F8f9Vf8HclTLyjFnK9m7Xpd5+U3HFc6PF7bxgoB9V92C8LJVZzsDiEyLF6qf91di+
	jAMaVx8cMTp864nf7WcPFtLDEap6afRs5PkVVA+IFVsk+0LOIdoAJW+vqTSf9bez9wh6Sq
	RbmWS4DMcXMNdHulvj+iLRTjLlw3/C0a/tirBD8qwJsBJfG6dkgbK2ZK54YhbA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 8a7ce430;
	Wed, 13 Aug 2025 13:45:48 +0000 (UTC)
Date: Wed, 13 Aug 2025 22:45:33 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
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
Message-ID: <aJyW_QNI8vIdr03O@codewreck.org>
References: <20250811-iot_iter_folio-v1-1-d9c223adf93c@codewreck.org>
 <202508120250.Eooq2ydr-lkp@intel.com>
 <20250813051633.GA3895812@ax162>
 <aJwj4dQ3b599qKHn@codewreck.org>
 <aJyVfWKX2eSMsfrb@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJyVfWKX2eSMsfrb@black.igk.intel.com>

Andy Shevchenko wrote on Wed, Aug 13, 2025 at 03:39:09PM +0200:
> > I assume Andrew will pick it up eventually?
> 
> I hope this to happen sooner as it broke my builds too (I always do now `make W=1`
> and suggest all developers should follow).

I actually test with W=1 too, but somehow this warning doesn't show up
in my build, I'm not quite sure why :/
(even if I try clang like the test robot... But there's plenty of
other warnings all around everywhere else, so I agree this is all way
too manual)

Anyway, sorry about it...
-- 
Dominique

