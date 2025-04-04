Return-Path: <linux-fsdevel+bounces-45711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D78A7B6CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 06:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 569F97A76DD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 04:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6EA433A8;
	Fri,  4 Apr 2025 04:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UNeG0TGM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87B3C38
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 04:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743739994; cv=none; b=pHjjm/pIpAQpYBECYo3ad/MsG7VT0uDaMlRal5wUu8btVS0QLhTa9SSBTDzDHi2uN5lb1hl2pFapop8jOa+FSL+FKN43rQSR71zql8OV675o4fZaB/adxSEF1fY5ll2sjeTsv28IblNnC0j3s76PgkhIZCxooxkQWuUl4p62MM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743739994; c=relaxed/simple;
	bh=E7Kq6eiLzi/haIhJ85TKfg6mRUB86EtMqsMasmwkVCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jtpyRo6VbLRkj67oDxLeQ66GDtexvuBQl4Oozg77kr5Zt7vnVXZkh4gUEuFfJlblSbqGF7OcCJR0MBdyi7CT2o+N3rDWzfOxQReIcu++wZVSBuqR+x7bzf4OZrdIkh1Qv+Tk97ps0iLVEHc6aiRziCHoeUutmxLwIqqIeS3cfeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UNeG0TGM; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso3025662a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Apr 2025 21:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743739990; x=1744344790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m++NGLjDQrbMI/d+pb2nOWN4mJQpGi+7Zpj4gC8z0RA=;
        b=UNeG0TGMJGg56/OJzr/48+BHH4RHBBkRXVqBw2v62+5kSmbUZuh91v5DvUdSrWwXGB
         EFoGJgx3/DurFTs7kuWqTbfW1CPa+G6pXL18Hw0AnNX72gXdF7lHxzJ+lTzm6zo3xrOn
         JkZN4BEWjLYbRUpqO0w56r+RUDcurGJwpEwLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743739990; x=1744344790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m++NGLjDQrbMI/d+pb2nOWN4mJQpGi+7Zpj4gC8z0RA=;
        b=NKcGA6a68/Ay9eP/1k28JsczypZGXe/hb/a+9tFdxc1EVjMiQxIR/F3furR8CTshCT
         F6Nw8i2uKEhFstwTSGvStd5lyal9wGWQBYilmv3LzAypE7IMJQCFa1M0w0dZS4H2CgfC
         UVKB726l+w5vPQyQLi9yCOpU0ifKuRCT5htSLg7moBDeo6vEgfji50nJ9XoxhntKtNnQ
         +oicgGfiLYJZJC3fX1YylKrkJt8eKg3tg7GCFs1/cxw/SEeEn4uDNSyDJvWFx4QcPAts
         xFERAlrorT9v6nz8yLRsgzghO18zqg5EKTTLNjSziDFH5ReCkHNGRl4xSAlEpWsgbeCc
         V0MQ==
X-Gm-Message-State: AOJu0YzuTLGiGVV8UqlpiMsaj9FNWO/Rr7ArO8QKGFdC/3I0Wpgv0FHJ
	KlNvu8OlcVcmHhtvEYOH5AwS8MKNbHHMbfNw/PnZ0gX88sTYJo8EXujP1Hfac3fy6grDMn48H0F
	2Kyg=
X-Gm-Gg: ASbGnctuuc6RWoIYUmvd0wfU0m9n8k1mqxJo8WKz6mSntpl0ja0/OJUUoHXyXRrOQEf
	yOSvn7pLLOpY5Cmm4uJ1V47KP+TUhAvFa7P0o1lrTrbq8Ly1kzxZUnSfv5QJn1Xj5w/aOo2Cb46
	1Gz7P9o0FLZTpg5yj9IC1233QOaDta+AuC+vIVLVqJjHA62eBV4F7ZYkELlXllu7bRotxfvdF5D
	Qz0WoQlCKFQ4t+b2ig5CLP7hs/fYkYDq2gE0Yt3lxoSKhEzD42LpA5wK4y0tID+Xhuf9uqrQhV1
	pL8nMnlGn2eO3pNtCyCqCZytxqXc+zz7ln1tjlbceuTKBXyvt3cesIEA0ddN99+hY0mqig23EVq
	fCybKRU9Ws2a2IT6Wr/g=
X-Google-Smtp-Source: AGHT+IEG3qOv+hPdeXtBD7FLr7iucuGcp6gxE71G2z0K1vPYKFtdAYcVv5zevxwxL+vDLGDrcalJ/g==
X-Received: by 2002:a05:6402:51c8:b0:5ec:cc79:84f5 with SMTP id 4fb4d7f45d1cf-5f0b3b65b20mr1119307a12.7.1743739990431;
        Thu, 03 Apr 2025 21:13:10 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f0880a476bsm1770659a12.72.2025.04.03.21.13.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 21:13:09 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abec8b750ebso259384266b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Apr 2025 21:13:08 -0700 (PDT)
X-Received: by 2002:a17:906:c153:b0:ac4:16a:1863 with SMTP id
 a640c23a62f3a-ac7d191b1bcmr160065266b.26.1743739988181; Thu, 03 Apr 2025
 21:13:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404030627.GN2023217@ZenIV>
In-Reply-To: <20250404030627.GN2023217@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 3 Apr 2025 21:12:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEsEnLC-PXfTHXtKQMjxZGi8VoJa3H0s39CoCTMmpz3g@mail.gmail.com>
X-Gm-Features: ATxdqUEbceBVttGNI5YMJu2jM0vtkPm_MUJ_12v7gTdK2ZDJ_nCAlSf-K6wy2mw
Message-ID: <CAHk-=wjEsEnLC-PXfTHXtKQMjxZGi8VoJa3H0s39CoCTMmpz3g@mail.gmail.com>
Subject: Re: [GIT PULL] fixes for bugs caught as part of tree-in-dcache work
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Apr 2025 at 20:06, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Fixes for assorted bugs caught in tree-in-dcache work.
> Most of that stuff is dentry refcount mishandling...
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

Uhhuh - can you humor me and make it a signed tag?

             Linus

