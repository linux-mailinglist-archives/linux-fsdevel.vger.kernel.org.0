Return-Path: <linux-fsdevel+bounces-48809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5335AB4CC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 09:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5403A8F88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 07:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62351DDA15;
	Tue, 13 May 2025 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="EiygpGvc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9719D2F50
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747121543; cv=none; b=BeYzB2P3WyXYv4+ABfDI6wKjli8qe+EY+ljiYXAFzaWL1oB/NQ11+N7Iu0K6Zs3ByY78ZGWFF8C4zMd7Lo31TN5ywMXuBX/uYwJPZ+7CwK6xfDGUtXPEpjroXSIddOHXpuSPCHzIfs4KQbVreGfCb/JcCmJjA1e0vayjiomngtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747121543; c=relaxed/simple;
	bh=/DjtqgYldkPzgnKKakuAwnR8P2FFT1qB9aGvUM/gJ1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRwSCJJW/1DiiseKv+esc1FP0mWGRu8gS0GB4dVAxkNOmtVlDgwcTAAw6hWIfL5Yv3/85gIdA+gvFPI59Of4M304ryjqdx4o7T/uPiosta++aKHILsiTaCWGmX5MKdChDUhKVyxYaiNaNjzBJbjhfYuabUkH+8Cl5hGu7g/MQQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=EiygpGvc; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4769b16d4fbso29440521cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 00:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747121540; x=1747726340; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l9dxcLHskhfmtsB8c4dIoVaUbALoLmjCAlq+9MDOep8=;
        b=EiygpGvc0KDoQuuikSbsIdb0LB77b5T4D6ltpwa9wCDvzp2WhsZTSvc1W8D1pHBCyA
         GkR3zc/o8vfjnTdin9V0YK7oALkPqJ/BrC1oe3fpADgZQbjTJj41+LYnjKdVTKP7vzUg
         1iIk/IO6bl3HCwqpJXmJ4BItHUQ6f4T3eHiHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747121540; x=1747726340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9dxcLHskhfmtsB8c4dIoVaUbALoLmjCAlq+9MDOep8=;
        b=ID67/zeHUnTB/6uiz9vFNkfAvWouPbsiAdOdMpELU0pDtdnAsh4s+WA5wQ+nUYnxcG
         5eLjGFeLqTiuZO6RhP563vd3GodMzd5jnIdz/VsQbYuaXmDO1JY+boVw8dtKKoTrncNm
         kjDII3w6GS30Fphbdm8K43+U7cFSg+Y2PJeNpCeKBpgVyOa2lFX+X9SvP/uiQOwlUQ+C
         5nl+Z1FctJxm0+kaIllwTu1m1nHvq8p67DigB0Jsyp1CzEevfhq18byE5MsRWDtt8FsE
         w8QLXznbeIQJTHvGPruxL3WmsPkQuunKUyfX2L5Ffp9DBvnslnmO3TKGtFtn8HPJWv0H
         TCUg==
X-Gm-Message-State: AOJu0YzqLOJGpbDIGPH2sqaFvpLqhCLSyXv+HF7DidxtPOFeNP7am18T
	yOJSZPrBtchMHQXujBJAh319y6ozAu0Og5PEZ53TzCkkO+jhvG/jJiqGtPaKd8Qc2p104oluXrD
	+0b/bR99iDDG/UWrkT2jI/JsEI9Wn88yBKTsGgA==
X-Gm-Gg: ASbGncsapGtk4tcywGHdee7MX5AP9FwSHTU2yWd2UVqLrmnAQ/l+p7LBqyu4OGYRy8y
	rzM6NhkuIO2THUfGKtOsLkG5I37oIV3GC/6ihpPXgyEaQw8o+QdM16OvoD5sxEFr5/cliOUS+2u
	7O3BwLGO4bb8O/3tHRUM8NEVh1uxv42fI=
X-Google-Smtp-Source: AGHT+IEkL+mTTKhLXSmqWbuD9H+PTsSpjY+Aum2f4M2kW6pMtG64rh0BSNmltpJ5zTL2+aJuaNWxGIr89a9Lfma3of8=
X-Received: by 2002:a05:622a:49:b0:48e:ef59:db50 with SMTP id
 d75a77b69052e-494527624b3mr214109321cf.31.1747121540520; Tue, 13 May 2025
 00:32:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512225840.826249-1-joannelkoong@gmail.com>
In-Reply-To: <20250512225840.826249-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 13 May 2025 09:32:09 +0200
X-Gm-Features: AX0GCFvOiA_BEFqaWnvR0r4RXWkfO_6h46tyk_uGP83oK8q7fGIq7xChnhZ-BCQ
Message-ID: <CAJfpeguY0c_u1hPiCFap-CdikfOiOnzKUTpaW=A8ZXeK8yTkpQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] fuse: support large folios
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm, 
	jlayton@kernel.org, jefflexu@linux.alibaba.com, josef@toxicpanda.com, 
	willy@infradead.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 May 2025 at 00:59, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> This patchset adds support for large folios in fuse.
>
> This does not yet switch fuse to using large folios. Using large folios in
> fuse is dependent on adding granular dirty-page tracking. This will be done
> in a separate patchset that will have fuse use iomap [1]. There also needs
> to be a followup (also part of future work) for having dirty page balancing
> not tank performance for unprivileged servers where bdi limits lead to subpar
> throttling [1], before enabling large folios for fuse.

Looks good, applied.   Thanks for taking care of this.

Thanks,
Miklos

