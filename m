Return-Path: <linux-fsdevel+bounces-68191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C632C56AF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 10:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A1D3BEB35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 09:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D8B2DF154;
	Thu, 13 Nov 2025 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rRsVfOye"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9475E2C3774;
	Thu, 13 Nov 2025 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763027046; cv=none; b=Beb8fG/CUmEfbHBTEncgFLyWCDlzimgIf71+SD4jTARcWPZLiqVGAKxDc7p/GYcQNpM01vMebyy0SRICp3zGhoPuZFSVpkRjNf0T0BQdEXNi4c8KOeyf8axfNpJJ4ZreLV7gAUNeiW+dcqqrPUC65vPEoED65H0fidi3FKjyP5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763027046; c=relaxed/simple;
	bh=1NgbT2JkXTbPxyNSwZqCsdVIpXqhv39J6ciJotppuqI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mA+UO9wZEu23bge/giPg7BKRBMxxOGVACyqmAQx9mo4X9m99wcD8Ge+bqSacH6WMNWTmOqt7W4i/fm3vuEP48+2uH1AC67z7eXDyRAl4+nXZ31FBMWiPkpjwykBFqXpEWawQAXUNTOyc8qC371EfIRXSFOpCurW2gB9ifo2Kyc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rRsVfOye; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=e3J90mT3jgSsr4uC2Mb9MeZBWMFke22E56m3+qIYpk0=; b=rRsVfOye+5fsgco5G8dTLwh7Yh
	N5itpYhUoDnixiJLhuOhHY78PJ5F0MafwSUNXc+HdLgEXRGxP21LUqIZEdhYMFUKVaXKSAAoN/uvi
	u0zKETRXsrOVXdh9+evZ4dzUFy5orvh64LJS7ZoVSOQr/+7rd73rXoFCi5vR7QZBfwwEs2l/5DUZM
	hVxpV64ajd8PKFXN+tH0oDnRPUrpZ6PBa0PirDoUoUomEuFv9DyFN2GDirXljoJpYg7aJV/T7O8bt
	BrWTjva0LOJTKcAb8UyGoxIqFVsOUWsROjLwbhddE6myRob9pqWSrZjBFF2zxdlhLlXOWRWK1tIRd
	q+Sep1Qg==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vJTrp-005vlc-SP; Thu, 13 Nov 2025 10:43:49 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>,  Laura Promberger
 <laura.promberger@cern.ch>,  Dave Chinner <david@fromorbit.com>,  Matt
 Harvey <mharvey@jumptrading.com>,  linux-fsdevel@vger.kernel.org,
  kernel-dev@igalia.com,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v6 0/4] fuse: work queues to invalided dentries
In-Reply-To: <CAJfpegsy78ZMkodX2+1Y9UiPZwY8dixstPtdcK0A3XphXxGbcw@mail.gmail.com>
	(Miklos Szeredi's message of "Thu, 13 Nov 2025 10:02:39 +0100")
References: <20250916135310.51177-1-luis@igalia.com>
	<CAJfpegsy78ZMkodX2+1Y9UiPZwY8dixstPtdcK0A3XphXxGbcw@mail.gmail.com>
Date: Thu, 13 Nov 2025 09:43:49 +0000
Message-ID: <87a50qz2qy.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13 2025, Miklos Szeredi wrote:

> On Tue, 16 Sept 2025 at 15:53, Luis Henriques <luis@igalia.com> wrote:
>>
>> Hi Miklos,
>>
>> Here's a new version of the patchset to invalidate expired dentries.  Mo=
st
>> of the changes (and there are a lot of them!) result from the v5 review.
>> See below for details.
>
> Applied, thanks.

That's awesome, thanks a lot Miklos!

Cheers,
--=20
Lu=C3=ADs

