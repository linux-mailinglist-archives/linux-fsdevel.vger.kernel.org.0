Return-Path: <linux-fsdevel+bounces-63661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3770BC976A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 16:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F56D4F9DFD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 14:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5D52EA736;
	Thu,  9 Oct 2025 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bOXf8qsu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDD72E6CBE
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760019432; cv=none; b=rFY8WOi5WZF+9alqH0iBDIr1eknyAcDy9rcQTgy9V1s79I1tS9RFfn/9yuFzjSsFd6N9IMj79o9MZK2ts8cafi7sFPmmvYegA+61owDwDJomV38A1vSOpz8gjUokkiomvFLRjXYNnz0CC1q1eULxnPU8jQIEtOaWqhIndD8U2K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760019432; c=relaxed/simple;
	bh=7Le//TLbRQX2OcIE7gej9WwJJwT4QWsdnDPQ1EXhgv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocqh+RXrS4dviv0zzmabois8081h23QWPtB56/kYsBFplci/YmybRTdKDp0IsRCFEa/zrh3dzDY8ZJ0QxBNN1jy/LEOMLC2vjMrZrM2YEOC9NIbXbujBO1LjsPnnHFjHlKLiZqqyR5mj/G6XhJ6p9hkoJIKoygPba72TFTrMh54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=bOXf8qsu; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4e4a24228c4so8349491cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 07:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1760019428; x=1760624228; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kw875aKjiXn7LHzRQlkKAsSNQqYG1Fwo0TZ4KpBkKHs=;
        b=bOXf8qsucETMDyQXSDfTecS6jYTbrlr1OlYjxw7n4FpnIvfm6g8Ih1b5D7M8ygPF3E
         UHYWwgId/pbTs2xirXAEav50Kktw3OASidHx5Qnuy1ZCkmfWPLNp6qc85/u1AEpeqMAT
         pUCkUMaj2OqBHQA1dMtVkJ22Yl+55I/RMHTWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760019428; x=1760624228;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kw875aKjiXn7LHzRQlkKAsSNQqYG1Fwo0TZ4KpBkKHs=;
        b=srCFrwrZBY+o3bI5tIGD6sRLUVGtwbHTiQ0N5++nak+3UrWgpouIggkn8I6i8R6ZQy
         ik/ve7nasV2l+vkqSL2y+BRSHkrxBK5GL1V0rR4fwDxoG399NMfygSZKLTEpaDdcHZlZ
         iWF+rgrk2SbRWCDdleX1nFzMla/VXCoWOZfB1hpgASptEu7Bhfoulhi5Ph7eRMDJipH/
         Ub7F8Ntk1rKQ4lX+95HwqkE6TdejQdnW9XEkYQ5dquHkXCfRlGzDEXsBHAyHbI7kzRfI
         uutWOfXMbhfSILBQ0Prb9x4J99YlrNSLMCMDuV0UjKw8+rLIx42OGuuom2TZTHQtPJzn
         eC4A==
X-Gm-Message-State: AOJu0YwG1+slhfztzO356NC8ko3aL5JceLFk/RgDXxNQVTPhOyDEmOkM
	poCGN9j+N/Ouq9RM+WSbjbkIzS5fnG9JwehKgqjz/IEZhpOqiOs83DPYmsqJuJzH9visqwM0DHl
	aKKs6SmG4Lm5leiqAEW4mJt3vuCGcdKWNSdrEsQjujw==
X-Gm-Gg: ASbGncs1FFhmHquQxo4SSp/XrAX1creo0JQAXvEJy/OGC7gMOE7IGY+zMas+VLs663o
	2BNz/tfsSOYHf2DNN9A4EJ8bP2oMdHEuhC242vFBhS0KPJAEOLEl7pbRHXbD81mcscIyDlaLmLX
	xHcywfk2sVOVPFXuw+CUO4pJF+jz4pkN0nY0ldfFP85sqezVDk1BjD/+siXzsJnxOkQ5MF1J57S
	yaE6DPLO9obWtw+7NAW21xzYkBI0QYpWeaFRYjYqOttutUd5kZougZCVjxhAkOVVfnGF0NtzEo=
X-Google-Smtp-Source: AGHT+IFmT6ugu6bnN9+OoaWf28wEKFrDJaHd44KEAiGRCLJ7v4Pfwz3ZscJOCq/fdrEgYZKhQ8kPGWeTIZvIV2z4RfM=
X-Received: by 2002:a05:622a:4ce:b0:4b9:d7c2:756a with SMTP id
 d75a77b69052e-4e6ead709e5mr105480261cf.77.1760019427791; Thu, 09 Oct 2025
 07:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008204133.2781356-1-joannelkoong@gmail.com>
In-Reply-To: <20251008204133.2781356-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 9 Oct 2025 16:16:56 +0200
X-Gm-Features: AS18NWCdFvnxq3uSxtfnPEwEWrDvj2PIQDcMC5IKQcEWCkEbUorjhM80YTITMlA
Message-ID: <CAJfpegsyHmSAYP04ot8neu_QtsCkTA2-qc2vvvLrsNLQt1aJCg@mail.gmail.com>
Subject: Re: [PATCH] fuse: disable default bdi strictlimiting
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Oct 2025 at 22:42, Joanne Koong <joannelkoong@gmail.com> wrote:

> Since fuse now uses proper writeback accounting without temporary pages,
> strictlimiting is no longer needed. Additionally, for fuse large folio
> buffered writes, strictlimiting is overly conservative and causes
> suboptimal performance due to excessive IO throttling.

I don't quite get this part.  Is this a fuse specific limitation of
stritlimit vs. large folios?

Or is it the case that other filesystems are also affected, but
strictlimit is never used outside of fuse?

> Administrators can still enable strictlimiting for specific fuse servers
> via /sys/class/bdi/*/strict_limit. If needed in the future,

What's the issue with doing the opposite: leaving strictlimit the
default and disabling strictlimit for specific servers?

Thanks,
Miklos

