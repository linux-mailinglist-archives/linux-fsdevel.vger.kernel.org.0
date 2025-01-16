Return-Path: <linux-fsdevel+bounces-39400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A762A139C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 13:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5BF161B0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 12:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24161DDC15;
	Thu, 16 Jan 2025 12:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="IcL0v4uO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701A124A7C2
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737029522; cv=none; b=qaVnpf1flzeMc/3uhOWrZFdVnHBf1L1NpTXvJqGed5PmQ/gnX8kJQKDwOVHexPYU0jRb3Enxo4XKwCzvH536ga2Wzv4USkjskDsYNhDZ6cMU1mFK14YCwKi0GnO5yI4Z1QTGKwWnh4dqFWeWFL0g9TrPf+MzEb4xrWT+LoBE+Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737029522; c=relaxed/simple;
	bh=9P66ZeaydQILs00C7ih9ikN6dr3tUSud5WPHO3uR8tE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXaoC798VNo0VINxtIH/yfEAmtj6Ca/IURBpPKhrwsk+bnG1pKT6KiTE4G4B8Hne1u1QFlCVkhtfDrxs9PHt/cpePMjl75iEm91f1PokJ9Qg9O4Yvrgk9H1jq6/o9j/JLENynC87XF6XNcW2N4wT24e0CLE51Msj9A1Yky4sDgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=IcL0v4uO; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46defafbdafso9532171cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 04:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1737029519; x=1737634319; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W4v7hS3YN6yInBsFtzs+Nq1cp9laMOaL2wFYLffLmsA=;
        b=IcL0v4uOTX3W/kMrPAVokEbjorZZ9a9J6wa3Bez3tbzHkYW91OBFvuPsSJ1qc4Ml01
         RmWtgoxo8S0URutBw+ZxONol+ZZH3+Bd8kbmsvgrekqUt+PMC6bCr7RL9EklPAsBNhbK
         2u2DVf6FB4GbvSWVUbiSseqsGBlDXFzR3gKsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737029519; x=1737634319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W4v7hS3YN6yInBsFtzs+Nq1cp9laMOaL2wFYLffLmsA=;
        b=lxwEteCo5I42vsBuE1bUHnk9zNuW4dVadDiRA1miR6YkiwMLCZDHIf2hovrI+V71SE
         WD6aBEJYxcycUfhL+2IxA2iGZH5Hzkq96AGpSGsAABk53bsJX2vr+oS1uPz3WiLNYsdI
         tEbto/Q//XDHcFH0aQHmh7MD5nak2wRnFFMU6wrflQOkJb8HPhFUHJrexxp+FrNid0bF
         KCAhxxmvoMjHvwrFx1h81ol53/P1rSDMGcx02+vQjUj8z2FAQ4QxnVo3F0/JsOao5gnx
         i0nBKANEruDVNiX5Dw9NIpdfCRvkrcITs2YeF3HsL9SkwtQBxHiPubSumF1Oms1pKzkO
         LvrA==
X-Gm-Message-State: AOJu0Yye2Xuot+jACVNxiYzBVaFtrG0MB4MpG+H50oneG2dP314wV+bb
	NqMBolgIkYsD/RIGolH7fEviQ8KaQMaZ72QXRXnnQsh4Fq8vDC4mqMIeBAT00Q+CPwFHdBkuVtL
	YRuvJqrDbTiGef/jgU56z8MqDSo8afSdilMpN3g==
X-Gm-Gg: ASbGnctRmJpsSN6UeI1eiCNyLYmhsbu3v5Fc0k9rBzUlpC67A93xgu7S+yY/zsjl9eE
	kGS7zi/eGA99vKw7LcGn5H3ChnqobHmR3sbDk
X-Google-Smtp-Source: AGHT+IFzKByFDBq1b/rQ2i/J5PQUYBL13gllsC+cpEB8Sql2tyi0AeftPSGYciTnN1xKCwI9EBWkY8aEXF52AB0yBh0=
X-Received: by 2002:ac8:7f14:0:b0:467:5642:5917 with SMTP id
 d75a77b69052e-46c710aead0mr477285521cf.32.1737029519284; Thu, 16 Jan 2025
 04:11:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218222630.99920-1-joannelkoong@gmail.com> <CAJnrk1YNtqrzxxEQZuQokMBU42owXGGKStfgZ-3jarm3gEjWQw@mail.gmail.com>
In-Reply-To: <CAJnrk1YNtqrzxxEQZuQokMBU42owXGGKStfgZ-3jarm3gEjWQw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 16 Jan 2025 13:11:48 +0100
X-Gm-Features: AbW1kvar0B0eLI2aCqLEGjrR18ULlEBfbhWwO9AXhcRWl0dJ65jfq7r0AlBNjUo
Message-ID: <CAJfpegus1xAEABGnCgJN2CUF6L6=k1zHZ6eEAf8JqbwRdAJAMw@mail.gmail.com>
Subject: Re: [PATCH v11 0/2] fuse: add kernel-enforced request timeout option
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	jlayton@kernel.org, senozhatsky@chromium.org, tfiga@chromium.org, 
	bgeffon@google.com, etmartin4313@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Jan 2025 at 20:41, Joanne Koong <joannelkoong@gmail.com> wrote:

> Miklos, is this patchset acceptable for your tree?

Looks good generally.

I wonder why you chose to use a mount option instead of an FUSE_INIT param?

Nowadays the new mount API allows feature negotiation (i.e. it's
possible to check whether an option is supported by the kernel or
not), just like FUSE_INIT, so the two interfaces are more or less
equivalent.  But we've not added mount options to fuse for a long
time...

Thanks,
Miklos

