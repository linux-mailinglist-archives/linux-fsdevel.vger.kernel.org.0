Return-Path: <linux-fsdevel+bounces-27011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50F195DAB4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 04:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F41A283F3F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 02:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E1125762;
	Sat, 24 Aug 2024 02:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Hcb3fMlO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5AAE56E
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 02:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724467254; cv=none; b=IzcLifcPRlpWjhrdUzIhObhMr/1c1yoyYpCSqk5MzrVmrhBzzz5Yyu2tyflp6DpR40ujEOuHNGcHSci7ipYxyNWyWuK4SNKb/3Za59OifIT4dSkCnK0mawJu/zBPChgb4ka87V1MUd9gPkG/PQQdH31bhMjXqnccxqSm6xySGHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724467254; c=relaxed/simple;
	bh=Azva8laTZ/2BkvfzyODM+ZKSQYox1Eu/+5PSMYsEbtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnV+dpFNDPX/e4bRePzjVpAPrDdp4G6H1WxsTpuBL3MxLP60vsIpIkiR+9ohXyX6UcuMuCCCiHw8m8PrI+HTTEYYNxxNIycycJX5wlHza3zW1ajT8NvHM12vRtr2VSx7jo8MQ7mqy9MNABoyIdXFiZZxnEXaarFphtIeKLRdN1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Hcb3fMlO; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a869332c2c2so378583166b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 19:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724467251; x=1725072051; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g+tZBKZfR9xLINW1ciKZzSilx+udfG+brXdL2+OvlBY=;
        b=Hcb3fMlOSN78loNkIAmehRWUHWwjNVuCGkN2bvgfSxYvByJI+lqqiydE0P2PJhbmgx
         xJa0dnoEmIMGREDsR/0IiLy6yCOfkxhrLOZW2mnNFFLb2t+efZvnE3RFRE6XVm1q2GSL
         L5scbiMVtMARuHUGXelLYIjVcfMgXJuKa6h08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724467251; x=1725072051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+tZBKZfR9xLINW1ciKZzSilx+udfG+brXdL2+OvlBY=;
        b=Pj+q03VL0l5WKp58Vs+DesM2Qp6FhrRzz0i0sXaJH09OnTkybSxSSRIQ3UbNmtO13a
         HLPEy0CmfS91s3rVn2HEzMJdQDMBvKWTYJzKoz960gbEGlQ/Ys1Q1wWlxb52Dug3yvmH
         jiv4DrFxdzRRRj2jZmss4SRDRa2Zf9MemWuG9ka+Ex6PhGO+Y8RnqjAdLtrw2nXbJsId
         Sj3T+kgdxrTdsQD1NGv1L5FQ1tUIMiV22L9VmDumhUzMWmlVRESKasaUyi2xDseIq/hA
         5+oayN2WIjbD0vNQFrB4p+EhazZT0MpIRjaaISsJZM+Wo3vuTeJ5SZFEuus3BqzGXjOJ
         Pmug==
X-Forwarded-Encrypted: i=1; AJvYcCXgdd4m7XVR4x1LTuDcjOjI8/NL4MU8rkuWka82r7dVEHqHx6SIh5uIEu/0UoZVCE9+C2fDsBBI0YgXoAPq@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv7w1D/R9UQsL+hitgG6k3cWx3tWKTy+pBOMZ19rObk+pSmnQd
	k42O2vr7ZQh0DdYS91k7wUCOR17UFizLp5RupEA/KpoBxUhZede30ULnbCUFWulG0WUB2hA+6h0
	dTBsw9Q==
X-Google-Smtp-Source: AGHT+IGkPUV5NOlTnWOj/pYUN3QOFfqN1Yv0oAhokPDkF1p296cF2WfkPo2FEJSrXIcnRd4ZO6UvHw==
X-Received: by 2002:a17:907:9811:b0:a86:84c3:a87 with SMTP id a640c23a62f3a-a868a84e735mr735729766b.24.1724467250734;
        Fri, 23 Aug 2024 19:40:50 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f29a4e0sm338927966b.58.2024.08.23.19.40.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 19:40:50 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bef295a2b4so4203153a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 19:40:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZ2zzEmfJu+5hhuDeHBwz1cwc1bUPTWBxU10BwsPSCfyij+svTnOUjMcx5urQbJpyR8iqwqc3aTepQYcsI@vger.kernel.org
X-Received: by 2002:a05:6402:26d3:b0:5be:fc0b:9a6b with SMTP id
 4fb4d7f45d1cf-5bf2bfd55f4mr9202951a12.5.1724467249913; Fri, 23 Aug 2024
 19:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <sctzes5z3s2zoadzldrpw3yfycauc4kpcsbpidjkrew5hkz7yf@eejp6nunfpin>
 <CAHk-=wj1Oo9-g-yuwWuHQZU8v=VAsBceWCRLhWxy7_-QnSa1Ng@mail.gmail.com>
 <kj5vcqbx5ztolv5y3g4csc6te4qmi7y7kmqfora2sxbobnrbrm@rcuffqncku74>
 <CAHk-=wjuLtz5F12hgCb1Yp1OVr4Bbo481m-k3YhheHWJQLpA0g@mail.gmail.com>
 <nxyp62x2ruommzyebdwincu26kmi7opqq53hbdv53hgqa7zsvp@dcveluxhuxsd> <CAHk-=wgpb0UPYYSe6or8_NHKQD+VooTxpfgSpHwKydhm3GkS0A@mail.gmail.com>
In-Reply-To: <CAHk-=wgpb0UPYYSe6or8_NHKQD+VooTxpfgSpHwKydhm3GkS0A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Aug 2024 10:40:33 +0800
X-Gmail-Original-Message-ID: <CAHk-=wghvQQyWKg50XL1LRxc+mg25mSTypGNrRsX3ptm+aKF3w@mail.gmail.com>
Message-ID: <CAHk-=wghvQQyWKg50XL1LRxc+mg25mSTypGNrRsX3ptm+aKF3w@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc5
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Aug 2024 at 10:35, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> What is to be gained by having release rules and a stable development
> environment? I wonder.

But seriously - thinking that "I changed a thousand lines, there's no
way that introduces new bugs" is the kind of thinking that I DO NOT
WANT TO HEAR from a maintainer.

What planet ARE you from? Stop being obtuse.

           Linus

