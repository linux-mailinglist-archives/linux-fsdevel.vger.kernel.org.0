Return-Path: <linux-fsdevel+bounces-40035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F10A1B3B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 11:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A5D3A49C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 10:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E481CEE82;
	Fri, 24 Jan 2025 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="eoygEK6M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F9523B0
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737715528; cv=none; b=HXykzd4NnrhrsjdMkCm7RiZP1aTq5rTbwczRhEPfDSk1ugYsBU+j03Nh7ZBQ3/7j9+scTWht3DnuhSvGXBGBgzj/qVa0x0fsHQCLI5I2X+kdeH8UkO9W1wVWGwMka07H8lQKAt3V4HN1f+PqSZ+zKc7JGNCrdWI3dYc5LHg/ET4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737715528; c=relaxed/simple;
	bh=y5pWAqugU1CABQqj1WTR4sQuMNq7l3WIAPUGoWd0xmA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a2JwOPM2180COKo9Nrmel2zfAefhquYt40/Isdetfvv+rR3nbFF12yaluCh5E8LuwrERq2bGTZkEMwRmzOJmITsIauRXuE+AfEwnhwzg1JpHz7v5bc0plB3H7BkEFA/9g5HN6fkf3PXYBD+m5MflFooWCt8yLpOZE46g5Jl54UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=eoygEK6M; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UxHG9rGfxeQX3ieRBn2QL7bE9t227E46XXgTV4jegGA=; b=eoygEK6MlwWJCfJIsWUQ/kpb9G
	wylgG3hl/ZF+hTjXLD2NHYkXhzZwVG6gaGmWqWKrqAYA5QHwWWv7sxIr9WeRRJt1V+BNhAtN9JbOU
	LnySWURxp+BDWdrR8fpngpMN3JgXWKN2vNugxZLROKEikUGPwVXQ4LPCMYztWW+FeTMUN8Qt4N95Q
	0mBGwkdL4gxP49O34Vw3HbZNARwf8Z8/Sl0irxghadUIFt1JwH12Iy78UyET8tAzEyWu7Ex1m5n9l
	gwQ3u/rmqiNi+QswEMD+conAM6Z+DCDvXaY+ZD+jiuR2kdst1MFXnf5v555NtjQsN7eBsqO95xkl4
	Mu3V9jpg==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tbHBf-001irz-4r; Fri, 24 Jan 2025 11:45:18 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>,  Dan Carpenter
 <dan.carpenter@linaro.org>,  Joanne Koong <joannelkoong@gmail.com>,
  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] fuse: over-io-uring fixes
In-Reply-To: <CAJfpegsBFBQoiLreevP_Xmbmjgnii7KS_6_i+pKfMixSw65wiQ@mail.gmail.com>
	(Miklos Szeredi's message of "Fri, 24 Jan 2025 11:25:20 +0100")
References: <20250123-fuse-uring-for-6-14-incremental-to-v10-v1-0-8aee9f27c066@ddn.com>
	<8734h8poxi.fsf@igalia.com>
	<CAJfpegsBFBQoiLreevP_Xmbmjgnii7KS_6_i+pKfMixSw65wiQ@mail.gmail.com>
Date: Fri, 24 Jan 2025 10:44:35 +0000
Message-ID: <87y0z0o5ik.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24 2025, Miklos Szeredi wrote:

> On Fri, 24 Jan 2025 at 10:00, Luis Henriques <luis@igalia.com> wrote:
>
>> Anyway, they all look good, and probably they should simply be squashed
>> into the respective patches they are fixing.  If they are kept separatel=
y,
>> feel free to add my
>
> I folded these fixes, except the enable_uring fix, which has no obvious t=
arget.
>
>> Reviewed-by: Luis Henriques <luis@igalia.com>
>
> Luis, you seem to have done a though review of the patches (thank
> you!)  May I add your RVB to the complete patchset?

Yes, sure.  Feel free to add it to the whole series, thanks.

Cheers,
--=20
Lu=C3=ADs

