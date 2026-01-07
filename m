Return-Path: <linux-fsdevel+bounces-72573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2A4CFBD04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 04:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1DE2304DE0B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 03:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDE9256C6D;
	Wed,  7 Jan 2026 03:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RlAQeWpq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEAA1DE89A
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 03:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767755491; cv=none; b=m1blRftuRJJ/zNjLD+H+Z3ZF2hmp7GKLAaIO1O8TO3H9TLkQXh14+Daf3hgMScd/swfwa/dywHi5utYIQ9rArmmHnDI/qN6QvCEbXj0g1PQRMIS1vZLV5xB19nkB5b7/qDjP+4xNANUQA0lG4rQbb1cWaHczAJuIywLJXYM3ZSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767755491; c=relaxed/simple;
	bh=UMiOIo0AEhI+Ah5+oKBr97SiEAtqyx7d+chKwMjJfFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZx/lM3TNdOxrMzVLtJ4EizTUYZITXW6fNdCGEeM2p58+zxwOGYsuVJVpiDl7vp5uiZ01MDkenVTQnBYWM/nXmQw7WjjmdkU8MTRrLvsv0bVxnEedMyaaLzqdTokNjaznRkewhA4E5YrU6g4GICPVmHIzaqOvW4Ho4jAbj3I7RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RlAQeWpq; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so1142401b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 19:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1767755489; x=1768360289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UMiOIo0AEhI+Ah5+oKBr97SiEAtqyx7d+chKwMjJfFg=;
        b=RlAQeWpqszFUygj51ldmRTY1088N9G+w0esLbFzZYvUreTBH7qPQQvK3dCC1K03n9l
         pxoyfO11JT3m56+hqWSuzSiteN1+kmH17CA1J4B4gO4Fml+DF6XoDz6rr4DXsYV0uV0k
         BPlahO+jfhy1C0hL8Kj7bD4ViuLOhuW7ONMvw/VFI6CsWTtT8SPGn0hDMp3ivkFoGkOX
         mva+CHcADsnr/9DfKEmK381In94soOqRXKJiom0pcvkQh5YYtk8Dl+YTGGGsMsuV+Zlr
         1BXgsNzZh05aOHkO2TZnjQVYUN/VQXg6RK7knd72Ajhq/qmUCzrMbVy+zlximgzzuLGl
         8pqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767755489; x=1768360289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMiOIo0AEhI+Ah5+oKBr97SiEAtqyx7d+chKwMjJfFg=;
        b=FYwyzERVBB5o6KRDlVUmyL3hqd6paQ1UC8vBzKFHuIknJ1ct/MLWBmyZGUA4YU1KAF
         Ma7yZbrkFrenqJpI7mpqba5xW6ohjR9BQPkJB0/NsCz02mWb9wrJcpycstZqwt+D+Ab0
         dkehiEA29C6Auntm7uaJiDtCHbSSSwqbWVEceMfzDa5zZh5SNHh/zzLCmVbpC0XHeRtR
         8s1566Ikmds0BXYDbys+cR+jXE2Hm4OPr4vdGIiJVF95EKHImQZ+YTcL/LVrXjLWP7rR
         DPwMiViyYHMtlM1CAfOOXLPsA2oP7YvSojBMJ3BuKAOIJ+DDxAZiiJcMP8+kOd+Bsqtx
         9X2A==
X-Gm-Message-State: AOJu0YyNTGrmwb/hgTz59fKReAuCs+Bzq4pnkJTnmOhP75iBNG1E6wca
	2jkH4yqrZvSQmNrqdwVbaMCB9iUNV1LPTezy+ChvgJJcHkua9aDCcHmFtOnoyUxriI/rPPCM7Ql
	FNF5mj2lFGVL99GXwV58tG5RHIGqNIGO6lpbq+Ulf96BvT5oNoAZtUqtfpg==
X-Gm-Gg: AY/fxX4RPRLPYlrmzzDemZzsFxIlB0cdVTcrjGyTJyYJ02ormsvkR5IYO3EiEnFOY5/
	AQFZpscA4/2iHBFduQDa/Frj2DGtCfPg/uNcR+Ko/Qd0t1adP2zumQU22vtUNglXzDyQQ1CD9UY
	Vz35jOsc9E+u4SetBNEKB791WMfu61fvlUdCVBVexq9vuSdkd36+RrtTv4bp1L0gKgI/twa2khr
	R4UbNYCOyThKVi2aOT5i7a/VL2j/nOnog1GBVeYWeVtmYJ3iOqgLpUIKJmnlVcWp3ZOF6Pc5Le+
	/wMt9Svb
X-Google-Smtp-Source: AGHT+IG83fhbQBn+3sQipu1TnUDN8/rf7YT+BsgqrSd8d9mgyceKli6adnUJ+zgTIEWZX0piBSlu08j8zE9n1y95/mg=
X-Received: by 2002:a05:6a20:7f9b:b0:35d:ce99:cc23 with SMTP id
 adf61e73a8af0-3898f9cd6a6mr959781637.49.1767755489598; Tue, 06 Jan 2026
 19:11:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251225110318.46261-1-zhangtianci.1997@bytedance.com>
In-Reply-To: <20251225110318.46261-1-zhangtianci.1997@bytedance.com>
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
Date: Wed, 7 Jan 2026 11:11:17 +0800
X-Gm-Features: AQt7F2pVQ7nx3_51gb-TooyIfq-YMqepVg4b29iGRu_ujuBra30Y6NJ3r61HjZU
Message-ID: <CAP4dvsczdjAp7MLMp+qY_HkgGH3OoHYBJ29-c76vVHp9hgFdZQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix the bug of missing EPOLLET event wakeup
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Geng Xueyu <gengxueyu.520@bytedance.com>, Wang Jian <wangjian.pg@bytedance.com>, 
	Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

gently ping...

