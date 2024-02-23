Return-Path: <linux-fsdevel+bounces-12572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A583E8612C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 14:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFCB91C21893
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 13:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55E97F497;
	Fri, 23 Feb 2024 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="f96jtLrL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5085D464;
	Fri, 23 Feb 2024 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695231; cv=none; b=vDsfrLRRBkgfJKMnTZXYTfNIRYHbi7S8Y6b5wpFLKNekAj4UanohXRcsicPvx0y+UaePgdGGXhI4rSm1vGbYrdmBEENKUK0RJtj/oz/FlZKEdVvMrTVhQCGhWiqbCAXnwzXKzH6UFk92OZ0ULsD3wqb8ziHFTomSO36XmoRQBuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695231; c=relaxed/simple;
	bh=82xM9lLAtgLWnaztA20ypr52fvBlm2+As3g364oe+eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsNRxzzW3cFt/LbakJWqEgzMMXKOSIwK4hNrsICe55JDa4VWRRRG/e7E0oY9aBmr3/SLHgPnnJO20YsI6zQEFq4QDUKcnV98GiRfKJ8mhZPl3+bWIi+fGmKVQ9d+0sFE8NJxAZtr8258kutV3eTu+UOOHJV27Mqid9TCVgOitYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=f96jtLrL; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4+ALhPuYcxWwH/SNYa5YOlZ50uESGdizB1+wfDCVL6Q=; b=f96jtLrLxOSQvHkUyoney/lDIf
	FmaOuJUbMaIaJWb68rnYYopini8SwEMs+/Z2Demf58VK+ODk26NoNWyv5auWuhV++Hvw+3siDxLuy
	i0fxNvz/QCDRQZlZCnFnN+nLG25EodAgJzt2TTO6aKiZFKkm50C/kxQ4KT1Mgt0sPK7/AlY/vcGQI
	vVvAMiP4R5VaW4IoZ18pgXAkMWWLMGY1vctv9p7STyCLcQxFt0XKHSW8dtMaKCKLOW8oWeNTXDuwF
	96EoJPaS0Z5aDGzBYVg2v36eOqRP44lT9q1futg2cbejcPzC2Mx7nabzisGxmPR73wn7JE+REyOvf
	HSI4atHA==;
Received: from 179-125-75-196-dinamico.pombonet.net.br ([179.125.75.196] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rdVgK-002gkj-IF; Fri, 23 Feb 2024 14:33:41 +0100
Date: Fri, 23 Feb 2024 10:33:35 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH] fat: ignore .. subdir and always add a link to dirs
Message-ID: <Zdier5NF7JeiMFx7@quatroqueijos.cascardo.eti.br>
References: <20240222203013.2649457-1-cascardo@igalia.com>
 <87bk88oskz.fsf@mail.parknet.co.jp>
 <Zdf8qPN5h74MzCQh@quatroqueijos.cascardo.eti.br>
 <874jdzpov7.fsf@mail.parknet.co.jp>
 <87zfvroa1c.fsf@mail.parknet.co.jp>
 <ZdhsYAUCe9GVMnYE@quatroqueijos.cascardo.eti.br>
 <87v86fnz2o.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v86fnz2o.fsf@mail.parknet.co.jp>

On Fri, Feb 23, 2024 at 09:29:35PM +0900, OGAWA Hirofumi wrote:
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:
> 
> > So far, I have only seen expected correct behavior here: mkdir/rmdir inside the
> > "bogus" directory works. rmdir of the "bogus" directory works.
> >
> > The only idiosyncrasies I can think of is that if neither "." or ".." are
> > present, the directory will have a link of 1, instead of 2. And when listing
> > the directory, those entries will not show up.
> >
> > Do you expect any of these to be corrected? It will require a more convoluted
> > change.
> >
> > Right now, I think accepting the idiosyncratic behavior for the bogus
> > filesystems is fine, as long as the correct filesystems continue to behave as
> > before. Which seems to be the case here as far as my testing has shown.
> 
> There are many corrupted images, and attacks. Allowing too wide is
> danger for fs.
> 
> BTW, this image works and pass fsck on windows? When I quickly tested
> ev3fs.zip (https://github.com/microsoft/pxt-ev3/issues/980) on windows
> on qemu, it didn't seem recognized as FAT. I can wrongly tested though.
> 
> Thanks.
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Testing on FreeDOS, it is able to access the directory and create
subdirectories there. "." and ".." are missing when using "DIR" command. And
dosfsck complains about the missing "." and ".." but states it is not able to
fix those yet. But accessing the directory works nonetheless.

Cascardo.

