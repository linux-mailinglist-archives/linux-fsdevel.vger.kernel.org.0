Return-Path: <linux-fsdevel+bounces-18536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44CD8BA36A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 00:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8981C21F60
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 22:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141051BC44;
	Thu,  2 May 2024 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NNuR3eFN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0C957C92;
	Thu,  2 May 2024 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714689781; cv=none; b=DS01QHiTnVln56ezEIyXmVCupSLEzEh5vdEJuDpCTj6ca/0shJM4o/9n8M5Odv/n7+UELyWcS/xso1HJDCKEKeGSLytnP/Wdr35mQbzAhlqzbccvaUoO+4zQX9zY77SwrJ7rMM1wP2MqdI+3cczrLz6vCzSF1YsCmOjpERLiJMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714689781; c=relaxed/simple;
	bh=xYzraABcVwLhbPKPIv+CnLrEEfApFOCv62m318pkhXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDSaSq19nT9fKU8I6zSk29iO8sPDilV4yPXppCyTAiry5hejl8AgYk8z9MonvMM2aU/SzfFmEtJn5u1u0dsu8DsBgI6/W7QkpJnCVFcH6fL/9749PnMn640a6BWXEp59YTmx4rCLUwEGiiFi/n7XsgR0OaJNmM2NtWozU0gDBw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NNuR3eFN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ULmPR6hNHGKvfw+x5JwcQb4TEP/e6WVplfSdLUYOMgQ=; b=NNuR3eFNcyOS5w/isy/zTLRRaO
	onkClByWbmCmRL22TUag18at6tRT063x5web+FO3DofpsddeR40Fxrmy28bSrpWv7i4p+1yLeikpn
	EYbpPlGUaFPmC3sMIoJpMg8TQeMrNL45IYY9piBB9jmaMTUtNM1s//whrWuNmUGA+zygfNQJ37d/i
	Vkf//jPzrLoKGrzTQ0duPSTjOCODLfcBJjIBJqJqXbjsFGJq2qCgCqfUWSbAYzrvnLWUFE6cKzOyz
	1PUzkElvAPYcXaYecp7LqBbN9Dzk1D0oicseeFPfjzh2181gcIvkDpOuetjBnt4NaFS63aMLfea70
	xEGx9oWA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2f8c-009pC0-1L;
	Thu, 02 May 2024 22:42:50 +0000
Date: Thu, 2 May 2024 23:42:50 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Kees Cook <keescook@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Zack Rusin <zack.rusin@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Matt Atwood <matthew.s.atwood@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, linux-kbuild@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 5/5] fs: Convert struct file::f_count to refcount_long_t
Message-ID: <20240502224250.GM2118490@ZenIV>
References: <20240502222252.work.690-kees@kernel.org>
 <20240502223341.1835070-5-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502223341.1835070-5-keescook@chromium.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 02, 2024 at 03:33:40PM -0700, Kees Cook wrote:
> Underflow of f_count needs to be more carefully detected than it
> currently is. The results of get_file() should be checked, but the
> first step is detection. Redefine f_count from atomic_long_t to
> refcount_long_t.

	It is used on fairly hot paths.  What's more, it's not
at all obvious what the hell would right semantics be.

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

