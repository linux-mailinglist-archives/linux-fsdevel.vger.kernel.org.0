Return-Path: <linux-fsdevel+bounces-39960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60232A1A666
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 15:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2D41889730
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 14:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB83E211712;
	Thu, 23 Jan 2025 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="EQcKW727"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22D62116EC
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737644355; cv=none; b=EPF/KNJrOfkE59Q1DVTYz9TYh7EcQGbF7FWwnh4rtPCT7SzoD+bztGUb8ns/vD2T1viZ+hnimItQmSK1dx+s0fRWiTuIoN4K2TWHBooTh0yWwpG+SfRDyxbU3WAbhxWq9vnmv9fhgr7BnGYdjyUwv13uWxf3G0EDT+xGBB3+yT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737644355; c=relaxed/simple;
	bh=z26xlDKgvZKtW8xFUP//1YfDYaLt8vBs4G/b1DE1BMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXhjrex49nBcC0Nn1ps5H7PqEcHPcuUDQ/S4PVFPSaHL7OU8RPqLq6QkhkU9wEaBDSRm1SzW/MVe5Ulu7kRbVBYuqi4o0oCBweEkEZsxlKi9cSg1sktvMDRApMi3+MHT52e8rTnI7suwy7SBNUfFH60/geDq/qHNGKym0Yuq6ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=EQcKW727; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-467b086e0easo5742291cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 06:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1737644352; x=1738249152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fiyNvYzvY7+Pwcm/ebtlPGQx1xTMZdiGPfoYmHfCncs=;
        b=EQcKW727kin45K6MXpLjdfmWXkIl6lUu7FskUWIVzNXS2tWSOUfYRjbLW20hGNzhmX
         tzKS8ndsxxQLA2TD1HGDavMdowuuAhM56rKdgp6ywuMo80jWFxJcQvDGFKeLc7Pl81jO
         FRVRaqxjb7LWHjUoC5d+c0+pRu0rLiT0HEQeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737644352; x=1738249152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fiyNvYzvY7+Pwcm/ebtlPGQx1xTMZdiGPfoYmHfCncs=;
        b=BLCJ3Dim3JEIYt+Km76rCO4U3OWgDO6eiYhU3a+Gf+PrmGjCeGy4YLyTvQjYml9aw9
         FD0BFke63Y3H3n+iA4U1Izr2MFTgB2NFmRpCOGy/YZ813reN3HCn5yZgUV33L6UZMfnS
         e6B1nkS4uIelixDKffKfuUghJfwtQdL+ccWQbvicX1X6Y8YLes+uZ29UYD88w+WVdJ/A
         Cc9U43CfrHF1wBVQk7GQXoRtvCqGbb5hWKAJoKL5KZ9X0iZ2G7TWjfA4+xAQoMgqAeH+
         9bmuNZuQQmgirQpzrntZYDk3qVqTWgPawwd50quaTMIe0HA0keOwzqxQP10le0Q3lRQc
         ZXZA==
X-Forwarded-Encrypted: i=1; AJvYcCWAPRHDq3CakUATiq87Ihp34rmm1Dmji+dkdmOjvzEIMbG5LcM0O1iMUfa2LSKU08s3RfFbE/da7KJ2rB7/@vger.kernel.org
X-Gm-Message-State: AOJu0YzEvOztqWN4LHktjIrtoNjtqbozQxFfGG0sj9LSAtozfV1C/40G
	UkNeLHqfv0Lh43ab3ObV3LMX1XA4PU6MHotTnK6L/b9YeNmUiCbO71pTkliYJUlYNu99ypCQBE3
	1I4BDZcVNwtAqlgFkjpIZypR7pAN9G3ynOl3Sg5x+r8mx9ij8
X-Gm-Gg: ASbGnctzBo/tKoul4mzh7Gi2pMF+SmjRyNe+GHDAyVXP/ihfT2smEBMhtlv+sjaBTEj
	MINtw84jcZNHPo+okjSBrybvIyk4ymEPTbkb9wL66NZ8U3MZhg8i4DYpLGe5eD6/yo+9oTOw=
X-Google-Smtp-Source: AGHT+IGAxRTvyq9Qh9+hNzJteVyh8T3Pgjt4r2NQHIiY+TXFoZjWLamCCgorLYlkp5a+33J4E3MmD3iN0YOW2czaYU4=
X-Received: by 2002:a05:622a:180c:b0:468:fb3c:5e75 with SMTP id
 d75a77b69052e-46e12b688e8mr372922561cf.38.1737644352481; Thu, 23 Jan 2025
 06:59:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123-fuse-uring-for-6-10-rfc4-v11-0-11e9cecf4cfb@ddn.com> <9516f61a-1335-4e2b-a6e7-140a0c5c123d@bsbernd.com>
In-Reply-To: <9516f61a-1335-4e2b-a6e7-140a0c5c123d@bsbernd.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 23 Jan 2025 15:59:01 +0100
X-Gm-Features: AbW1kvZxir6v28FyzmjhMPKyMd4bk2rSjT78Jr9fN3U-UK1SQOLnPbhmps_25LI
Message-ID: <CAJfpegu0Pyxo3qLHNA=++RHTspTN-8HHDPNBT0opL0URue3WEQ@mail.gmail.com>
Subject: Re: [PATCH v11 00/18] fuse: fuse-over-io-uring
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>, 
	Ming Lei <tom.leiming@gmail.com>, David Wei <dw@davidwei.uk>, Luis Henriques <luis@igalia.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Jan 2025 at 15:53, Bernd Schubert <bernd@bsbernd.com> wrote:
>
> Hi Miklos,
>
> or shall I send you a fix-patch instead of resending the entire series?

Yeah, you should send incremental fixes.  Much less bandwidth that way
making review easier, and I can still fold it into the original series
if it makes sense.

Thanks,
Miklos

