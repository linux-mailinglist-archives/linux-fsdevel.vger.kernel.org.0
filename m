Return-Path: <linux-fsdevel+bounces-72574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88659CFBD10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 04:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7ADA303AEBA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 03:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BC6256C61;
	Wed,  7 Jan 2026 03:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hCpVa5ty"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB8E24A044
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 03:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767755513; cv=none; b=rG/4uYvwK/rgqZAeYAf8eJ0Kf5NybCgZ0ISfaHG9Vm9KQ/H88CIdcWzXGV/19wanIcKS0YSPzSXAtsxyWyva9jiE00VfCguM5MxOsTeENC682ftV8hGVj02kRMiTTbtKBk0j2+Qkszd7uXmCDE/uPnIA1mCM/n3/mgSXEjSPE8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767755513; c=relaxed/simple;
	bh=UMiOIo0AEhI+Ah5+oKBr97SiEAtqyx7d+chKwMjJfFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKoGGwgFTDK06yrl1nPaATR4YE7VB4erAg8SDQ1fTjenoWEU0AwCPmWkS40u6FpSpWhmNbIX++MOFscvVfRUHLf19zy3U+5+0E54de64JmZ0XG7czEMtFp+6zBlm7QCl4S39vCvdclxmeSmoH6VdeBmI/SdnQ1YXlD5caTAUC2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hCpVa5ty; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34c9edf63a7so1450581a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 19:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1767755511; x=1768360311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UMiOIo0AEhI+Ah5+oKBr97SiEAtqyx7d+chKwMjJfFg=;
        b=hCpVa5tyg5toVAKq/+3Uw2/h3eD48v/shbQ+9/D1xqLEN0+bOXpxGCDGBUIcoAPFgB
         VcQuzm8SmZnG2cTzneKBCTWoMJMCKOLCJFmuaDkJ+Xq57LhoVCB3OfLfp8ieb1fOlHYg
         l30Zv18XpyYXtaRJcqJiNpi7uPOuovq3ceWKAdEdmKa93LfHtaYPjya98ZOpCviX/yCs
         g+KA+AxxVNcHPVXG2EUlWyMPaFovrPISI+6rsisqZDGP7eCf1eoAnGQWLUgsPK3S7r/M
         6rbSxo6nd+imBeRVARMt2xgMGgbjmJhztbZeLTH5hdRzyCV8XgNBPuxejXhyU1pkwGVu
         A4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767755511; x=1768360311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMiOIo0AEhI+Ah5+oKBr97SiEAtqyx7d+chKwMjJfFg=;
        b=l5M8FX2ipHr2prCv+W0QZNmqYfH5QJBx3IGpAl4TU4Yp9e9iJexsNrOm50rgdBXwd2
         qg2ZLBLF5yvQC2h9c7M3ZDfw7pXWwEAVNcdD9FFP9FsHMWTseIqCd2Sfpllg67ADFYK/
         i8MbDZTiBJzaIjUCK8iu0BqeY+JvXrI0iMucVSoteg/ZyVRlRV5qy6BQ9oqRj/TLIQR/
         gDsjY41Kv31cMx1V+0gqr5dOM0Q2RsBAofCSlIxW33oC9km2/R4VkMHC21Vciuxf1qq+
         ORXr6Bg0tUMjRH30Ayj38IgtJORFDko7f1DsF+EwHoPWgoQJbdTSuJtU1Q5ogC+zc6yd
         il/g==
X-Gm-Message-State: AOJu0YzYOfQuVju2nQM1scCQs6m2itDHy/Nii0t0RWmZNpu2tF1Oq26v
	hRpH7fuRnCjAz3hMMrfULbhRymWW0Vpk83eWkvILWOvdtGqTIjsgkUE9mVhoH3RrmJgHVt8oRIh
	wCo4jGYc1bHCLZtlQDXCDvKcXSj9MUXhgglsi8b7hDA==
X-Gm-Gg: AY/fxX68NqNHDfKWu2DAXuvVfTAhxkYGsuAf8IigWohhNRFQX+5MP3nkQ9yi29osDRR
	EbwVB7wlDzIspILJ4UAaJcy+9MyIW2tUh8AYiqTQYccI7zSGWYbskVNd7pwXFa+7IZjyvlD/bNA
	7QCz/vtSoUZ1N483M9BOc37sif9Vyqb6tL//ESTMnRzkDrEWQLagEuienm2OOZWN7+2ve/tdeIA
	y2ughKGeACn6VSPiovX4YPrnUPHXSFQwNssbO8Ru8L3zJ/7H7obxuSteB0RcTuItWJLIEJjs9me
	6s7VufLS
X-Google-Smtp-Source: AGHT+IHf1kx0nkkOIIn/ft2o9afHpulzLo2mW+z+U6Cd2sRzzbgH/zNboBvh9M+uVJRAA9GG9pE3+M0g2hptCtDIel0=
X-Received: by 2002:a17:90b:580c:b0:340:b908:9665 with SMTP id
 98e67ed59e1d1-34f68d53310mr1127589a91.37.1767755511355; Tue, 06 Jan 2026
 19:11:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251225111156.47987-1-zhangtianci.1997@bytedance.com>
In-Reply-To: <20251225111156.47987-1-zhangtianci.1997@bytedance.com>
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
Date: Wed, 7 Jan 2026 11:11:40 +0800
X-Gm-Features: AQt7F2qe5mpXtYXkJy0G8PXV_BjM-QSJM3H4cNkWx4KVM6zh5b_wWGBheV95j0k
Message-ID: <CAP4dvscqk1Z2M_aJtFYh8_RXGO_LUjsDuXFamfkitaPuce_qEw@mail.gmail.com>
Subject: Re: [PATCH] fuse: set ff->flock only on success
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xieyongji@bytedance.com, Li Yichao <liyichao.1@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

gently ping...

