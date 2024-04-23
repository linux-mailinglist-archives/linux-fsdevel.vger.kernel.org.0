Return-Path: <linux-fsdevel+bounces-17506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B798AE6DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 14:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D545F1C23029
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 12:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA223136E1A;
	Tue, 23 Apr 2024 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="THByUl8V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527A41369BD
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 12:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876388; cv=none; b=nPMWhYk5OscanNQtMpjPw0tw1A2bcVYtQZMyz+qiHbOKlpBrgpX66o2aaQt8ubJS6Cn3JYwL23PZZUZmmzVk682VBec3UWKY3mLzjwi1+8m2ls63NGcVsuRD1fwNPis5lZKSgkhNdcuLJiWSq4X69GNGxKVFx071S15TV8TluKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876388; c=relaxed/simple;
	bh=BC6FTNsUGuIlrLM2Rp5W+aQ6lg37ZMuIKZwa5j3idhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbLRqf8wdy1J4RGs60aGHAc+oIlnlT7JtjbVM50rhAEFs+A2ZTquL5WyFuFcwQFxJP7Qpsg2e8jvALK+4OM6Rgn4FRF38ou91dnsX3LJLp014QMQS/MDgbS2AgATX4JE44IxNqWjY/Dz/tUuoZt0zY1khWKFe6ujr1BSfgRmWVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=THByUl8V; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34b3374ae22so1810042f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 05:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1713876385; x=1714481185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFYZcy7U6iVPGxM+zXj/599YUrcDFIGpq3chkEIZB5M=;
        b=THByUl8Vtpuj85apUP6oOL954DSlZ3tCN18J8f3aKR3/tRv49Nhy5u+/IM4Iyd8Hvl
         aJHShjD7o53F9YDAYm0WtKDKUYxAEqjKtEdHeFDqMnIflNbBVxoWRER2MtHsVsoYoHxz
         //z0AbRKTyTgwxvNwxYh99aJHF62rrnldiOMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713876385; x=1714481185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFYZcy7U6iVPGxM+zXj/599YUrcDFIGpq3chkEIZB5M=;
        b=VlpMB9/YXILUoD2+zryyWKldlS7c3d21DeHC9ug1WCgm28bo2pbLAgB3jyiSradciZ
         evmr6z7fpAPM6qdrsdF3rvgAoxSvI1QOL9/SfQCSIREUJsZBbO7SUYXAS0qVUq422qLy
         Dr4FtaRptExLJXWsMTwvppAOeMJ+ZBhSw0zzITveFjv8MY0BNeJioQiz8m4Or4wr5TfI
         KhGo4BQIFMDo043PYqiP/Zd6eGCZ6SoDRxA5Ynfp2qlLIsPacFszs2sNPzD2itFwArsZ
         qsjjBPh8cBF7dseM/b9Q0fNG4BepiyjAQQdufAy7KEaF/TctBJcweL2abmBJ6W88xCR7
         QWbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1y35Nsse/q64jMilsN9gz2hPIqa7nDb731CDhZmCkLkVSwd7RbmuYNp7Pi3lCDarG3FSaF+3i60M4gBF87Q1gZai3pV7Bweu0jNBWqg==
X-Gm-Message-State: AOJu0Yz0pA6V5FQR/P2rY6HleXTUKBb3gy4GiKzWE7bjk+S6ltFwxA2N
	al5nNujb08m7zQsbzbzLMcJwtppm2H5Q949495+ux78xGFo/qDAkaIxN1nTD9ebw4z0FTat2ID6
	FEVCkzidA+/7Pz60mp462CngheEdID3DToOsdfg==
X-Google-Smtp-Source: AGHT+IEzDwo6mzUdY0zXLlSGDVdWKc4IhVCEOfnmNKH5+jnvUQMorHhCaEdzmlpa9nsOWY3rEGNzzFDrHFMhaHhflHw=
X-Received: by 2002:adf:cb83:0:b0:33e:dbc0:773 with SMTP id
 q3-20020adfcb83000000b0033edbc00773mr10252491wrh.44.1713876384663; Tue, 23
 Apr 2024 05:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1b946a20-5e8a-497e-96ef-f7b1e037edcb@infinite-source.de>
 <fcc874be-38d4-4af8-87c8-56d52bcec0a9@spawn.link> <0a0a1218-a513-419b-b977-5757a146deb3@infinite-source.de>
 <8c7552b1-f371-4a75-98cc-f2c89816becb@spawn.link> <ff9b490d-421f-4092-8497-84f545a47e6a@infinite-source.de>
 <1db87cbf-0465-4226-81a8-3b288d6f47e4@spawn.link> <f7c97360-8f5e-45f4-876c-3dcbf9522a3a@infinite-source.de>
 <032cfe2c-a595-4371-a70b-f6d208974b0f@spawn.link> <f764ac09-bd84-41f0-847b-bc89016a4613@infinite-source.de>
 <aaabfbe6-2c61-46dc-ab82-b8d555f30238@spawn.link> <58766a27-e6ff-4d73-a7aa-625f3aa5f7d3@infinite-source.de>
In-Reply-To: <58766a27-e6ff-4d73-a7aa-625f3aa5f7d3@infinite-source.de>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Apr 2024 14:46:12 +0200
Message-ID: <CAJfpegv1K-sF6rq-jXGJX12+K38PwvQNsGTP-H64K5a2tkxiPA@mail.gmail.com>
Subject: Re: EBADF returned from close() by FUSE
To: The 8472 <kernel@infinite-source.de>
Cc: Antonio SJ Musumeci <trapexit@spawn.link>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 20 Apr 2024 at 01:04, The 8472 <kernel@infinite-source.de> wrote:

> If it is the official position that the whims of FUSE servers have
> primacy over current kernel API guarantees then please update
> the documentation of all affected syscalls and relax those
> guarantees, similar to the note on the write(2) manpage.

Which note are you referring to?

I can see some merit to both sides.

If it's an issue that can be fixed in the fuse server ("Doctor, it
hurts when I do this." "Then don't do that!=E2=80=9D) adding complexity to =
the
fuse client is not warranted.

Obviously most fuse servers don't want to actively confuse caller, but
if such behavior can be used to exploit a weakness in an application,
then it becomes more than just a correctness issue.  If you came up
with such a scenario, then this would turn into a serious bug.

Thanks,
Miklos

