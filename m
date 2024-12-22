Return-Path: <linux-fsdevel+bounces-38006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AA69FA530
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Dec 2024 11:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4251888AF7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Dec 2024 10:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75B6189BA2;
	Sun, 22 Dec 2024 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4pO863C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B122166307;
	Sun, 22 Dec 2024 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734862329; cv=none; b=CG/1gBM8KZunnpsrLhMcTylNdlGGIH3uPeYqDAExzo9bFovRXczDBE60NeSdUVSlnCv17t+FcIer95GPLSTUc+3+gQykCv16Fw3QjVAhG+3bihCqPi72ZF85AIbrgFiRcgcYrorTGtUVGMcuL2KbmkwCAab5ibHCVm8kMOSp32Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734862329; c=relaxed/simple;
	bh=1a/VWzSTWvMsj0hpc/06I4Wuwlht3P8XrS/Yg3s+rHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwwM6Y1+qhMjca1YKfWcAh3DeyOdGKvSp6TmYDGk2EbRRJzyibPgh4t0X/iX+E6/LJc8Y1lFBi1nYuUnp9ERm+dO7v2f4MihEE0KiNgTvOzlVnpJKKfsABFnz1VFqGY+ksySJxRV9jGNMoi8xVA+DbUtm9rP+9tTtMNnUAsqdH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4pO863C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82C4C4CECD;
	Sun, 22 Dec 2024 10:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734862328;
	bh=1a/VWzSTWvMsj0hpc/06I4Wuwlht3P8XrS/Yg3s+rHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b4pO863CNudzApW679dCKY6oEHNfLnRGrTgF7YgWRdi9hQkPU5EIWwKLy2Hxa5MCe
	 KhTdDDZaS+vKKf5dU7ZtgH80yduLz9x/zDVi1OvZ2+acALsm1t7/+XGdvRvTAz4gUH
	 aqWqjceV7UhvmAVWjFrxdge07Jkk2D4GS0MTCF83NtzKd7PARSAgjhxbOaSa65s0Qa
	 Nzph0cXb5vuv1iMhoDDT1AjjN/dDYFiS4oh2jlJKxuMCY6nE+rCbsKQKwgbOnHQfNB
	 5kijrs+eKQPjRdKctZApnCQLAbtGQsys2nOqFOh7ZJL8hwuVKiX8xpbnI93TtOoLfX
	 UQYTDR8bYQEkw==
Date: Sun, 22 Dec 2024 11:12:03 +0100
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>, 
	Christian Brauner <christian@brauner.io>, Lennart Poettering <mzxreary@0pointer.de>
Subject: Re: [PATCH 6/6] efivarfs: fix error on write to new variable leaving
 remnants
Message-ID: <20241222-anmut-liegt-fe3ab4c1fee5@brauner>
References: <20241210170224.19159-1-James.Bottomley@HansenPartnership.com>
 <20241210170224.19159-7-James.Bottomley@HansenPartnership.com>
 <6e09c8a812a85cb96a75391abcc48bee3b2824e9.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e09c8a812a85cb96a75391abcc48bee3b2824e9.camel@HansenPartnership.com>

> Do the fs people have a preference? The cursor mark is simpler to
> implement but depends on internal libfs.c magic. The actor hijack is at
> least something that already exists, so would be less prone to breaking
> due to internal changes.

I think making this filesystem specific is better than plumbing this
into dcache_readdir().

