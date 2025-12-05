Return-Path: <linux-fsdevel+bounces-70818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6094FCA7FFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 15:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BB843222A53
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 12:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7363F32E752;
	Fri,  5 Dec 2025 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ZrSnYuT/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D420325721;
	Fri,  5 Dec 2025 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764939443; cv=none; b=dWzS2mgPsk9HRn/oKyZ2OuTO8N8Pm3/QRpIeIYCtuL5asADcVADrdGmfOg8z0Jt2cPxNcx+s5lbY1Po0WphpPtv+RqUIdJScKNT/9ZT+DTwy8kBF+fMrCh7+t2Ay+RA7ThAyi9b3ae5IzoZxhdTKjuS0txr6Qki/ap27WdozIH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764939443; c=relaxed/simple;
	bh=IZ9AioMDV2hbSbJftYZbWSoJ0XqPG2Sf5u2fNUuLXkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GatFUP9R7Ih/HERMkLWTK19IE6m5N5mA5qW+O8Ov55CkqvKTqNIfkylDiM/CiZxl+T0/Hv6KCQux3yZkYd51PWB00DvHB33CoyssJHPuIySuh+8s6b/AsgbNk9uE6Tm184RWRKyGFfgvHT6UTZ51MBJwiCslUC4aEWbhi7vvV9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=ZrSnYuT/; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id E019714C2D6;
	Fri,  5 Dec 2025 13:57:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1764939430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UyggHV2TuZn3sZG4L/FPwISUjRvCO8P7c60l6aEhf3M=;
	b=ZrSnYuT/AUbqO4Dsk7WUYK9VZvpw/xbMpKodLaaVgdihEhtT/pSPe8Nx7jrQ3r8D8/CPxJ
	3byaVyxQ8FeUvgH91ps3s5v/2eV7T0o3lFa/kT5SYx/eGVM9UXD2WKvp6bfe21lTLLsE7h
	DUtNwj26q0HNP0dPV1e+mfnIYQedo83/PUsjFkwB4/RqIj1YmV+YVAstmA3Xvidkt4wZPj
	o4J8yBW6Eg5tDwD2I1/aXpqrMfaYk4oTRL7W7X/4dRDw2O0GbcB/sHlu34iU90j1zZUBLP
	Kl+PiXgAPCKVGcBklF2SW9nUrGtmoeAUvZapL17hoCMY+lDaNor7QYDvLOkIsQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 84e362b2;
	Fri, 5 Dec 2025 12:57:06 +0000 (UTC)
Date: Fri, 5 Dec 2025 21:56:51 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Remi Pommarel <repk@triplefau.lt>
Cc: Eric Sandeen <sandeen@redhat.com>, v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	eadavis@qq.com
Subject: Re: [PATCH V3 4/4] 9p: convert to the new mount API
Message-ID: <aTLWkzb8ttU22FZ8@codewreck.org>
References: <20251010214222.1347785-1-sandeen@redhat.com>
 <20251010214222.1347785-5-sandeen@redhat.com>
 <aOzT2-e8_p92WfP-@codewreck.org>
 <aSdgDkbVe5xAT291@pilgrim>
 <aSeCdir21ZkvXJxr@codewreck.org>
 <b7b203c4-6e4b-4eeb-a23e-e6314342f288@redhat.com>
 <aS47OBYiF1PBeVSv@codewreck.org>
 <13d4a021-908e-4dff-874d-d4cbdcdd71d4@redhat.com>
 <aTBTndsQaLAv0sHP@codewreck.org>
 <aTLHoPiC93HTc-VM@pilgrim>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTLHoPiC93HTc-VM@pilgrim>

Remi Pommarel wrote on Fri, Dec 05, 2025 at 12:53:04PM +0100:
> > Remi - I did check rootfstype=9p as well and all seems fine but I'd
> > appreciate if you could test as well
> 
> I just tried your 9p-next branch and the issue is gone for rootfstype=9p
> using cache=loose (I've also made sure that I reproduce the issue without
> the last two commits of your branch).
> 
> So yes for me that fixes it, thanks for the patches.

Thanks for testing! I've added your Tested-by to both patches.

And I'll submit this all to Linus on Sunday, hopefully won't get much
more breakage... :)

-- 
Dominique Martinet | Asmadeus

