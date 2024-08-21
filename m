Return-Path: <linux-fsdevel+bounces-26493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A477395A22F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 18:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31F66B28604
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 16:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF361B2539;
	Wed, 21 Aug 2024 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="oDxAhA+e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802511B1D7B
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255807; cv=none; b=Mz398109bwSBXSAtVMZXrwNBZsB7bmTvL+qgKxagoQMbXcgU6T12LOzDP7RRoYgGbOQAB8wXeSeRVB97o/QPX64lTd8er9GBXARcgAIIxWVbY5ZKu4tOnd/U69rs1o2bBbsl3+psWSJVtYjkbDoQuh6o7UOLjO4cpSfRCg/bW5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255807; c=relaxed/simple;
	bh=Xk6hO+Q4MqbM/I8xf5CP06O0ko1LWu34LBHXkRnJiDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JizwLoK+1j+A5zG4PuqP1mufcsdm0ymG+D2O2BysESNkhkAQtDjhu0o1U5k2zgYnvv5xHsiNaZ05KTKJJl5Tb5xHvenmYOthW7qiXZcFiNit3d3ZGVEJ6f0Tkx5UCQhYb1eHR7RCMomtES3OAyxpyUeeVOiT3AxDodVlK43yWUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=oDxAhA+e; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-533496017f8so1054909e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724255802; x=1724860602; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2OMQig7FSTWJDtQJLSmSCDOS2TT2Np0HXtAub7QjpCg=;
        b=oDxAhA+ey25aCstBl6Mm7lle4q6ZSOT1aSoP9nkzofqeKMw2bN9KgSVIrdSmw8W7+L
         9YN9Vh17dd/fmFSsXdPnIOkkmYdaqoGevIwY4AUP31m+lhDTsflKpz5mrS8n5HVROyty
         9fQnJgFuxco6GGLw+g5t/xKTgMiwm7r2DjVzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724255802; x=1724860602;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2OMQig7FSTWJDtQJLSmSCDOS2TT2Np0HXtAub7QjpCg=;
        b=LSa15ahsizIWojB1WLOvhVJMUPXF6l6cJSLYRo1UHCwqs4MhmljsFjOSag75zWiCpQ
         nFuTitPbEihx5pUJEU/SsRVEZtq/izpnuRI9+PWNND7Ldh/N4RTNVMo4mcrrTiGTFi0d
         4+2sri8MzAEBS932CrN7dJERCeFTxsF/Zrjrc3tMXYR9Oe0XR3jDyJgS/+YALnPlbUpR
         gMRXJ9ThewY0Wsh+UnfMCxpDvseCCeut37z2fasp2lpLuHZhEPyPz3MNi3yBRNO4PI4S
         ZSbtLFTUBLulALkzBBqscpYg5JFN005RkRH7FPzQiaMuCLch0AebIo9bJrdZnRDfrBzm
         zopw==
X-Gm-Message-State: AOJu0Yy/R7KxETQg3fl6oilWpTXO1EqmVIrsOtzZ/puzS2qvowOvELSt
	vGEZEmczFlwx4avFlcyqpAipYSntSm81ovDrMXNvSXWtwfv1vW8XZMTYRw51vxI2T54WM/eEpGg
	FeHyVn4GtQmtSS3p+TH4K4+FBmhxUJ/3VoQqR+w==
X-Google-Smtp-Source: AGHT+IHTa2gvztS6DVAGTMW95z1FYV4y22vD+YE1BHVg7ISO0VBths1uD/B8IXQGF5KK/tswrVTKUnFJ9zPONTvIvY4=
X-Received: by 2002:a05:6512:2310:b0:52e:9cc7:4461 with SMTP id
 2adb3069b0e04-53348553508mr1773856e87.5.1724255802319; Wed, 21 Aug 2024
 08:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819182417.504672-1-joannelkoong@gmail.com> <20240819182417.504672-2-joannelkoong@gmail.com>
In-Reply-To: <20240819182417.504672-2-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 21 Aug 2024 17:56:30 +0200
Message-ID: <CAJfpegswvvE5oid-hPXsSXQpFezq3NLVdJWTr_eb4shFLJ2j4A@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: update stats for pages in dropped aux writeback list
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 20:25, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> In the case where the aux writeback list is dropped (eg the pages
> have been truncated or the connection is broken), the stats for
> its pages and backing device info need to be updated as well.

Patch looks good.  Thanks.

Do you have a reproducer or was this found by code review only?

Thanks,
Miklos

