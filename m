Return-Path: <linux-fsdevel+bounces-67934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DBCC4E3C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16683189879B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 13:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE0F34251E;
	Tue, 11 Nov 2025 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gfurCczb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CB3331205
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868786; cv=none; b=nFgu398+DD8cJPM+eAlr/A1mhkP2RImF1Hg+iB0ad0MrA1NjuPNpBdDZgdo79B1qEAIGjf3IUMWyqNyTJxf5hs6wvmO9yXYPXBxHOGqZAncQf68AdKM+ORR/lcpKo38mnxjvK2+ElE6Fv0sd1/H8hVjFeILfUN4Zbwu0d90LRDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868786; c=relaxed/simple;
	bh=Yv7mlppcLZYSmWNorp22QWXnxvCItf3UYF1UqRBP2Jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VAfUwA5fkY5mGnaJHWEutSBkoFVi5isEnoUYWheIO5VQfbjG4p3/C5UMe4A7NQ91QA7CA08gCq0zhw0nIpxwxn2kFl3Quk4tGr5m6lVVS/SnYM1Vqw4qP78CUhz8RsYXiCO6l9u5iMGMMzIZLV5KzWKOsi65Rh4PZ5A7uZPcWaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gfurCczb; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b26be00d93so252219785a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 05:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1762868783; x=1763473583; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yv7mlppcLZYSmWNorp22QWXnxvCItf3UYF1UqRBP2Jc=;
        b=gfurCczbx1YQBRV2bQBzxXNJOu8YMwRcg0npsIs1GONK3dQvqfzVPUbg37Ied7o7Z2
         +8NdKyCIENTsG2M4E2fKdZUB3jgQSgDPlk8jw9eDxxvT4Oxl381cVcdpfY4VDXmUqik2
         62e+rlaGF+Pi41cxhCwYrMF/DNBC+NkmN8/LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762868783; x=1763473583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yv7mlppcLZYSmWNorp22QWXnxvCItf3UYF1UqRBP2Jc=;
        b=VBDbTaRvabhT0fTlX2ljoVPJNixaxdHJLqBqgUO2pR9LZ5apQuiMmzmsBFapts0Cbl
         wUnmYcFNIJM6mjIqq9kHlLKTq8gwlJoEtLEDLDKZpdR12NF/ew/kF+DrX/LvmfRTXmlB
         QigQshV2Iy27uVRpkSHQ6Hrchv0J12X1S28Nn6ezbKepjbWdqDKHVm924+15bPNPA2rP
         J2xmZu2VKVSJivMiGkHrFX3C1Jcb/kIAxt08SDX1x7FLLwCGVLQl309w76yCBHtKYV/b
         OOZuzMMRr/K1Gl36c4UFmCePHsuLn2ViegZSV7j2nYaYziykoCgIbMrdstRm7JZYCCod
         /esQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgfKBE6dlEOLD7jILtSHC6MMRZwUZrw/9OV7ByV4mM9z3BsPn7p5HCdqTz8hzPyE0JZ8LB6XTHJOOGV0aq@vger.kernel.org
X-Gm-Message-State: AOJu0YypAAdLi8fQTSqADQTd4Fuu+O5w+2vAZTZJpwmstTI2J9xHgOQd
	S7GbN+PnQvL9WBYGKZnzdBPAhqUfNrMto9wg2R1QZi+d0lOZPfwdHUF5h3x8+s6i1NMGT3rupnd
	mA1CRhSnG3YySD9IVAv7KJwEwAzjtrpEnSI2dmPo33Q==
X-Gm-Gg: ASbGnctVIU5YrsFg0I4rYR+oYmEwuMAplFaMSkyz0pYZ97mB4K1ce3ediFQOUJn6tP7
	ynqAKpkQb8D1BiH7cZha/wMc3zu5nZOcrxQxAByG78kpV0X4jhsW5LVXMxFT32TGv1+8A/EAnIF
	IEMqiqReo/T8VNgtXGiA8jQae9HoDLgWJNXkeEajkY8T50ZGFAZOzWADNwf10W18HxEkEOsuKJA
	YcxnkEtKcafZ+dcw1BU+bQets/Bb8UH3pEelVRPtd0Uav+WqoO1y0OBtbc=
X-Google-Smtp-Source: AGHT+IG5vcQXFjZiSgEdx+o6aIt0/smZYpl+mfQwx80MIaPrbNHOb76Oz4/pJJkxZJs+rRVb/6+dP9n42BTc9DbVq+g=
X-Received: by 2002:a05:6214:242e:b0:87c:2c76:62a1 with SMTP id
 6a1803df08f44-882387176e3mr159785486d6.67.1762868783396; Tue, 11 Nov 2025
 05:46:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-io-uring-fixes-copy-finish-v1-0-913ecf8aa945@ddn.com> <20251021-io-uring-fixes-copy-finish-v1-2-913ecf8aa945@ddn.com>
In-Reply-To: <20251021-io-uring-fixes-copy-finish-v1-2-913ecf8aa945@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Nov 2025 14:46:12 +0100
X-Gm-Features: AWmQ_bm1pWPP4pD-WM53YStRnA87z3w29zov4PZEY44yourOp5vgEvxJGwHHMaI
Message-ID: <CAJfpegvirkqw3xV8MNFn+qZW3C_NBujZg1Y9+X9yYN7Zixdsaw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Fix whitespace for fuse_uring_args_to_ring() comment
To: Bernd Schubert <bschubert@ddn.com>
Cc: Luis Henriques <luis@igalia.com>, Joanne Koong <joannelkoong@gmail.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Oct 2025 at 22:47, Bernd Schubert <bschubert@ddn.com> wrote:
>
> The function comment accidentally got wrong indentation.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Applied, thanks.

Miklos

