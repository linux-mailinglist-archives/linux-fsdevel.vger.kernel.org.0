Return-Path: <linux-fsdevel+bounces-12556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13208860ECB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 10:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C148F286E0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 09:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE83D5CDDA;
	Fri, 23 Feb 2024 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VYm1icMT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2C45C912;
	Fri, 23 Feb 2024 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708682360; cv=none; b=UYaOhJZkTOD0U7GwJewFAHhJPrGjfvd/qWU7EpmMadLtkQn+Os9hHi6y0IHIMCoaJja7kRujWo8rwGylqondMTLTV3HzWSqiHSYRfvxiYllCjtB0XVNMVctEK8gIGMetZp/QVuC+S5K12av1TxpHk7gJJCsp/u2ds8pINk5fYq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708682360; c=relaxed/simple;
	bh=ypp+li3WDyr1XgKdhqQo23FL0DmPh0rbnUd3jDfC1xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZ1VPz/3ItPnZXz7sogVprMKscOwdL3hPhpu/EfivK3I9c5nr76uSI7oxZsRLVGWzc1kuQHPaZTdAlLLEySxjDeI4cTSHSub6M2v7UEEFuO0P00JjyaOoUsjLVP3oZd4HiRRvTP7fy9yNHsT6fYqpiw7yd9ZPKII8XPXqgceC1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VYm1icMT; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=91eZlYfF9t9UL1ZmDb9X25hoe2Z5HivbHvwbCpyCGw4=; b=VYm1icMTpRUDkVeYgkbJCXKUQw
	cR0yZF3bVBb1mzgntwWkCPUwzSAE8JzPfQk4hOjx5AiOEA5yzXuwDVHvhLXujudoL1VSzFi4i7xh2
	2BnP1FURZ4m7qr8wgb2agi8i0r1flcWBMbMvF64RdxjiT0WocoshTQmsELZB7jxbZcbpQq6VVTN9a
	8VY6cJ4MUUzrZxqJJFlR12P9EBINqujBb7FMfYeK702oX9olAHlbxNJHjtMHT22hs1cPjMOiHZ2Cj
	HDN5231t0bwcD0kGZJ5dc3HllzlC5SyZpmCdfyrT+czn0t96FPCdgoTKuwLMDbC+/fLzQrXZsxORb
	XYI17aDQ==;
Received: from [179.93.188.12] (helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rdSKd-002dNb-Tv; Fri, 23 Feb 2024 10:59:04 +0100
Date: Fri, 23 Feb 2024 06:58:56 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH] fat: ignore .. subdir and always add a link to dirs
Message-ID: <ZdhsYAUCe9GVMnYE@quatroqueijos.cascardo.eti.br>
References: <20240222203013.2649457-1-cascardo@igalia.com>
 <87bk88oskz.fsf@mail.parknet.co.jp>
 <Zdf8qPN5h74MzCQh@quatroqueijos.cascardo.eti.br>
 <874jdzpov7.fsf@mail.parknet.co.jp>
 <87zfvroa1c.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfvroa1c.fsf@mail.parknet.co.jp>

On Fri, Feb 23, 2024 at 05:32:47PM +0900, OGAWA Hirofumi wrote:
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:
> 
> > OK.
> >
> > If you want to add the workaround for this, it must emulate the correct
> > format. I.e. sane link count even if without "."/"..". And furthermore
> > it works for any operations.
> 
> Of course, it must not affect the correct format. And it should not
> accept the other really corrupted format.
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

So far, I have only seen expected correct behavior here: mkdir/rmdir inside the
"bogus" directory works. rmdir of the "bogus" directory works.

The only idiosyncrasies I can think of is that if neither "." or ".." are
present, the directory will have a link of 1, instead of 2. And when listing
the directory, those entries will not show up.

Do you expect any of these to be corrected? It will require a more convoluted
change.

Right now, I think accepting the idiosyncratic behavior for the bogus
filesystems is fine, as long as the correct filesystems continue to behave as
before. Which seems to be the case here as far as my testing has shown.

Thank you.
Cascardo.

