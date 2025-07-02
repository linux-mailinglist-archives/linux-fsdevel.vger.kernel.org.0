Return-Path: <linux-fsdevel+bounces-53592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0429DAF0AC3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 07:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506024A4391
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 05:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5561F1301;
	Wed,  2 Jul 2025 05:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Tm3qmSM+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1B160B8A
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 05:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751434493; cv=none; b=qaRXWPOZI6686rRFonAbVSFcXRKDw8vVMPDTlUPpA4qpGgnf4RYAgQOgrtGXPcDhT2giKiOe3Ub9sDyiEt/Wk8q/ROhnWrzfbVsTc/W8DPuG7rYEuoRZd37c2jNHnophaDOnNZ5m2qRLpib58gQzDBODNRR24SVFAWdko6nj3BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751434493; c=relaxed/simple;
	bh=j/nJWaa5fsLM/3Fdphqm2plFbLgIbO6bw+18ujbICR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8+Y8HwhLKPpZSr7n+dnQhivxXGDaiJcaOJfXII2iw0ivVeh1FTv6lznh6cNwS8H13KqU3mMUZGUKTqbM1B81bnvdlVgfYCoNXdVTPNIU5bwYvrOL2NjhYbRecsjOETolq3A5cllb1wxb4hIyNTqshIcEGbVxincX6imODMVMwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Tm3qmSM+; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a58ba6c945so60813841cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 22:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1751434491; x=1752039291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j/nJWaa5fsLM/3Fdphqm2plFbLgIbO6bw+18ujbICR8=;
        b=Tm3qmSM+St0MiAHyOLGr1cy+bKiIbNb4xSOFKIm13bOHzwlOnsvX1j0Sw7KozmhroU
         fHOPhp2aVLrf/okWVtxHMJG9FTC3nIdHuLht6r3IQT4gbL3ib9GsDXxSNFJVqTQhEEjE
         fJYM1hA+8sfcc+iBiirKmonGrpg9wENsujvlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751434491; x=1752039291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/nJWaa5fsLM/3Fdphqm2plFbLgIbO6bw+18ujbICR8=;
        b=icCIsoMMAi4aY3My7t+kx9Cajfz45Hd6b/XTSn66QMqahkLnm1spZxvMoFhIaL1oSM
         /MFUCK5S/P+F6pmcsBJ/yWY/B8fsi34DHpv+K4c78siNVlovX1fDHxdDjqujH4EBC+ZH
         wmTIf0xUBKlC1iZinV9TvxCtsf9eFVVgu6aaRtuTiQuOi4d2ompDd6NHyvmnZyaDukAe
         sbWJawgRRvCbSGXq1s2cgbTydgxZId6FIOWZ1jwSamvHxhQJE3EKuOje9z2okNfsUhPD
         GLPzczVuH1hWytm+8j1NIXAiN0bTokTc8xz9vdxmicJ4wa+r7xrIsrUY6gpoa89k0Fix
         8Egw==
X-Gm-Message-State: AOJu0YxPV4KIJOSrs79K16fi4zp0ovuUfQUg7BCSzXY6VOS5o3WVnBnk
	W8CVO1JKpfxPfSwwqhPsQd0/1B06D0HgyqU416IilqCDeFEZBLs+654nyRpjJ0fmr34zqsHiE5t
	FjW8UgfHGzVcRPUBiZgiC5MsGK+B3D4T84mfU6jmzwQ==
X-Gm-Gg: ASbGncuqcNbz+nS6Hh6J3N7zaLrbo7a7EYUsCPTSei7oRWYBdZ+VC7p6w7y3RC7uJtf
	QA+tTrqUJ+QEKyOwvqqrRx7Xki2JZPxgNZlslFuaA+Wpd2+b6tPGfJ2K7OcOysmlvFT+G8f/6Nt
	YVf7H0hN5QrfGj9DAkanmrcCd5DBkCTSnholsVUXyPE1hwhc8/aqlJvOkSqvRsVqtcSx1rNwcYD
	WsE
X-Google-Smtp-Source: AGHT+IG11RBCOEKFUL2/rBKQv4WB0MyV8b5RRG9N8NLG36pRirgFT/ofEss1s5GjqeuVfFpv1QK8kZ6ydL0UiiRiOgA=
X-Received: by 2002:a05:622a:1a14:b0:474:e75e:fccc with SMTP id
 d75a77b69052e-4a976a2463dmr28150251cf.35.1751434491229; Tue, 01 Jul 2025
 22:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523181604.3939656-1-joannelkoong@gmail.com> <20250523181604.3939656-2-joannelkoong@gmail.com>
In-Reply-To: <20250523181604.3939656-2-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 2 Jul 2025 07:34:40 +0200
X-Gm-Features: Ac12FXwaQNUhNfDRKWMywlBRFzrIyQ2tqx6xCiD_cPBjV39UE6sTt6Q2u0WdDMw
Message-ID: <CAJfpegudqgztbQb1z1c9TKhvdAz1usspVi1Cx3qFOj_RjSb=vw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: clean up null folio check in fuse_copy_folio()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, dan.carpenter@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 May 2025 at 20:18, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> In fuse_copy_folio(), the folio in *foliop will never be null.
> fuse_copy_folio() is called from two places, fuse_copy_folios() and
> fuse_notify_store(). In fuse_copy_folios(), the folio will never be null
> since ap->num_folios always reflects how many folios are stored in the
> ap->folios[] array.

Hmm, well, did you verify that none of the callers leave any holes?
ISTR there was a reason to put the NULL check in there, I just don't
remember what that reason was.

Thanks,
Miklos

