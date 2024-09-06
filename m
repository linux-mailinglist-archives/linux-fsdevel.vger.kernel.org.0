Return-Path: <linux-fsdevel+bounces-28877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5302696FB1E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 20:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1025628D457
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 18:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E92B1D5CDA;
	Fri,  6 Sep 2024 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I4PoFpii"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8E0EAE7
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725646210; cv=none; b=YP50KmYEuNko3oW/92kFCCrjTaadYWC5qxJJN+7+1yGOXhRvv+bHlAvrg22l/ZaOx5zVfHuPA1VvpPhrGrYsJJ5H8yVOzLj57zq8ijUtmgWkdoi1/DHuNHSrsrJrvdvNH3T0isOkYCTMXokDR7btAuMzwmETdVwL63v8+xSBIrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725646210; c=relaxed/simple;
	bh=+cNVUCZm/4SgXA1pRgCwUDGH/pbLFm3vQpD8oyRVgWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbGOyglmtgMYRaWEWrqs4axNeShjq7/OgOtOSYv58slre2/8Rl84gJD3BON2Y5Xj/PFugtOGGuOnKdUwjZKuItlZcRyX2fobdQtGkLNWnqcay98SaIvs0u1utsIlUk/sg9xnmFAzaY4g0FGnOUWFc/S5EmACB7+41kWVO3sFlr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I4PoFpii; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5365a9574b6so1262304e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2024 11:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725646206; x=1726251006; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RofQPa26p6qwTuMAs4MAzsstLUv0296JsNd9bkxDS8A=;
        b=I4PoFpiiexAx+0p0wzkTl8qskDq+2mISHtMT9ET0ZToiqGq4sB4qBk3PAdiLY48qSo
         yC5XBs7DCJahyHHNSPZJGyw7azpwznKY0M+vkTcUYjrF6041phBiRE1oWhwUomHPBPeq
         0piiACBrrkzHZ2pkTJ1a4W+TT1ReVFZENkAUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725646206; x=1726251006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RofQPa26p6qwTuMAs4MAzsstLUv0296JsNd9bkxDS8A=;
        b=EnimM2LcfnBpO2vjlV6UZItYeGHU3f5CbFyJ0KJhJFy/gfRd0VRu9PwFx+fPnQ8DVQ
         ryiXrKGpk4CzdF8Ft+kh775akxf/aqfeVEjewZ0zbUFo4V6LqepXN2GtT54FEbDWxo2s
         6IJXwYM98lkJegLUsxpw2uQdvl8ReCxC+NdwDzvho7koFc0CD95AKQfn6FSykhybc20D
         oGLG389rHZPLxfHGVqft7ltp0DW9njfhjOD5Lci/3u32s4zoHMuR2gRQDJHOneTNd3H8
         OEd6CiTbHNLaeHcjDsY/ZcEm/PAXeOPe6bKyj+tBI27AwjpdU/ClSOi/e3SuTBuOi1rS
         9o9A==
X-Gm-Message-State: AOJu0Yxsn+Beu4ZaTe2FqihakrCQAOzjNfLthpyu/QUHoWd82XGXO9Sm
	9+eM3b6vNuAvPBjwGTd+BjJyDnubXaIcmTRVgucn/WfUCxo18EPmrXySe2H0fRauV0NdrKQ3I66
	59nE=
X-Google-Smtp-Source: AGHT+IGQHe1krm/EN/U9y3RoIlonlt4mofGva4qHlhUGNjPMGu3uFmkZRLoCklqsGvQO1f+1Kh4NBw==
X-Received: by 2002:a05:6512:114f:b0:536:55cc:963e with SMTP id 2adb3069b0e04-536587f873bmr3300374e87.44.1725646205510;
        Fri, 06 Sep 2024 11:10:05 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53540841966sm2923888e87.228.2024.09.06.11.10.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 11:10:05 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f75428b9f8so14722761fa.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2024 11:10:04 -0700 (PDT)
X-Received: by 2002:a05:651c:19ab:b0:2f7:5777:cf14 with SMTP id
 38308e7fff4ca-2f75777d254mr17309111fa.35.1725646204503; Fri, 06 Sep 2024
 11:10:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906-vfs-hotfix-5959800ffa68@brauner>
In-Reply-To: <20240906-vfs-hotfix-5959800ffa68@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Sep 2024 11:09:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNZG2c3zWdGv9=PHazac3usXu9h-FrYCBr+05Zo+GT2A@mail.gmail.com>
Message-ID: <CAHk-=whNZG2c3zWdGv9=PHazac3usXu9h-FrYCBr+05Zo+GT2A@mail.gmail.com>
Subject: Re: [PATCH] libfs: fix get_stashed_dentry()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	syzbot+f82b36bffae7ef78b6a7@syzkaller.appspotmail.com, 
	syzbot+cbe4b96e1194b0e34db6@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Sept 2024 at 09:24, Christian Brauner <brauner@kernel.org> wrote:
>
> Would you mind applying this fix directly?

Applied.

                Linus

