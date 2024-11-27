Return-Path: <linux-fsdevel+bounces-36023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4209DAB81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 17:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6254D281F16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 16:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0B8200B8E;
	Wed, 27 Nov 2024 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HuhYe1c5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433C720013B
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724075; cv=none; b=ADcxY4PvKGJZa3fuqfvoVAzf2JsWarGGV++71c7DgBeNqxI/zKm2QtjecZP52GXzsTYI8FouBNSY/ccbmG0H1a1A6LQeTOZzn051BdLHRknAXENiDvHEhbvE+b1xXk61sbmnUGUcznejZzI/nDxtSVuGCyUQjVXCn2mIwIVlJRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724075; c=relaxed/simple;
	bh=wdNY7HX2WspIyz6Q35Nz/LQqzU4lAK3ST4AREKvs+EM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+/g3jn2KkL84qChkUT7KQ2Utf4vSLIHbYj2n4ZF3tAm2b52Z1RuvDFzCqZpJOZWBmnLV3rvCWyBoDjZGgUHloguedf9F3fnVB7jOeuoZHKH6PR9xtnO0lDuSHS9lYfBCV9V/Nuj4st3rM01rOtMFtpU79HCN1zZg12dumTlQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HuhYe1c5; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa520699becso786362166b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 08:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732724071; x=1733328871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fvjj15h+61TIjL9fWQW0WlE61jSKFQDeRBQ9KAl+OOw=;
        b=HuhYe1c5tZRQI2cZnAvlur0MOwKqsftMpv7uTXLAyMjsG09ToJeuiTAVkBXEfVj+hr
         3v5jwGiYO+EP6hnSSGatn7n/tHMrGLwytsJCgi6le+aSjhKTg/dCWX4eMbXMc9bbiatz
         5gm8sWSo6uTF9nJVa9GLfjCuV8bRq9Q3q5Scc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732724071; x=1733328871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvjj15h+61TIjL9fWQW0WlE61jSKFQDeRBQ9KAl+OOw=;
        b=UUqUpwP9qhPXvjGTreA9II42F3PxDNwvtwgrUHqCkUwhfuPKtFB4UFhLarLZuBUtvk
         mjDSUDQBEb+JAG6YKFK4aKB1bNfv2x65+O2glo+yDTbbD2gYQ8VI3psyws9Vy9ndqXQI
         y1uUKGIm6vKe4Q1qLHES1mvyv7zwUF06RwCYGbna9Dcyg9AgNGM36m/3sR0cp0ubIrzm
         Bw5TXB971si7Mq8LYpSjLzCPcCPzY1YWmXGKsbUH/15zcwFF7wQUkDfMngsbWzixwpZ3
         V39benzQdbt8Dpl3K6/T9xzuZPb70hiGGJR9PpB6EIioNQQELzafeFGPdoASpGCrKLLi
         HaDQ==
X-Gm-Message-State: AOJu0YzJri1xkPZivQhk/Xc02pJnjKxve8NG5D1pD5HP8VAfc6AOLSEx
	Jwt3oc8lio/6LYkOQyorRdhJ50h70IBsG16cbtSImEwBMeZmrb29YgZxS/xo6Gi2/dyVW7gHsWc
	hVITb7g==
X-Gm-Gg: ASbGncsQdDQ0HT8lw9mTDMXmjqelLN9NwHeTLcpbHNXLUHW+4zJ9wj8zKvmxUd4/0/5
	ppj+8d06DSjjmlEMvqCoc3hisDU7g7MhPX7Q1BLSiLVPsdI4X0XoEbtwExxsmnUvSC3d23lL9LB
	tBaNlw6O0kmrEQ0ZMc3td/cIv+YryzjlvgS98VyObYpZ1Zd4YXJ4bRI42Fw6LP52p3L2HUN5+Pz
	npOR4ClNiR8zBx8wbJPvPV3j4GgmNilSmo/F5h9teHxJhp6S0o7co+sihPuO5U2nzaF7LgW/Qqf
	a3nCNcKsmVPpHuck61NGJ0gL
X-Google-Smtp-Source: AGHT+IEmipQgihp2T2WJiDqTqGF49lu1PPJsSk0dLc25MleSmwk6HsLnXpsCS8IGhiCPZ4/WkTCm1A==
X-Received: by 2002:a17:906:319a:b0:aa5:1ef5:261e with SMTP id a640c23a62f3a-aa580f01a3bmr302425866b.17.1732724071475;
        Wed, 27 Nov 2024 08:14:31 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa53afa8eb8sm536655566b.197.2024.11.27.08.14.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 08:14:30 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa520699becso786357766b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 08:14:30 -0800 (PST)
X-Received: by 2002:a17:906:310c:b0:aa5:1dc0:7c1 with SMTP id
 a640c23a62f3a-aa580ed01d1mr234195366b.9.1732724070395; Wed, 27 Nov 2024
 08:14:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-vfs-fixes-08465cd270d3@brauner>
In-Reply-To: <20241127-vfs-fixes-08465cd270d3@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Nov 2024 08:14:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjQC9pt4s3K0Be57ay2kSyDbUjiF2Jq4V1BPYi1z3Qx0A@mail.gmail.com>
Message-ID: <CAHk-=wjQC9pt4s3K0Be57ay2kSyDbUjiF2Jq4V1BPYi1z3Qx0A@mail.gmail.com>
Subject: Re: [GIT PULL] vfs fixes
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Nov 2024 at 07:41, Christian Brauner <brauner@kernel.org> wrote:
>
> I was sent a bug fix for the backing file rework that relied on the
> overlayfs pull request. The vfs.fixes branch used an earlier mainline
> commit as base. So I thought how to resolve this and my solution was to
> create a new ovl.fixes branch which contained the overlayfs changes for
> v6.13 and then apply the fix on top of it. That branch was then merged
> into vfs.fixes with an explanation why. Let me know if I should do this
> differently next time.

Thanks, this looks good - exactly like I think it should have been done.

Pulled,
             Linus

