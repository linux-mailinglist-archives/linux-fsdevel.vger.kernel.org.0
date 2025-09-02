Return-Path: <linux-fsdevel+bounces-59960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBD9B3FA23
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 11:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D208B172F48
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 09:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1502135B9;
	Tue,  2 Sep 2025 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="pPMk8ro8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FE22DF14B
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 09:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804925; cv=none; b=T8j0Qe1Hj6KSPELP0LrVDk8H5KOCOMJ9Rz1S2vtW+94w2YuWRDOFhnKM5oF1C7qOHUrzr/DYHHQ5zolFpsN+EfV01X/w7+83oPFCdMl5cLAdf9aqmI1ccXoPjn+DX/SUwZ0JNOs/aaUzET2hcCNbwOurLH4UdrFaLBbZLOWzSmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804925; c=relaxed/simple;
	bh=oZ/oMsImSwXy0iurVEV8OYWOj1EK5Ol1S2elCURr6o8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEh2/nZt3L5EgXUrqJAswZ86MkHYRoZS8fHhHX2VfVRXxjaM1AZUPt6SqxQ/+ulalzkoNRSCrF6IlgrB1YKWJy99WcgJd25VQ7g1V55TAibhCZ/SpoPHPycFMUGVMdxDbY0x9gDo6gc03FD5B8wjc7K60f12A4iuhRcAUHsrUR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=pPMk8ro8; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b30d09da9dso37858761cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Sep 2025 02:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756804922; x=1757409722; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KlEqu4WxUDiABf2a30g8zFkM2TpzDalMOcCpeUi3kyM=;
        b=pPMk8ro8+Yj2e5GcMg+nnrdCbWMa8u1B2AHCvpmpG4WYnwkCAtHfQf/mPrDcLvVJzI
         vfoKD8hrHyXIyTaeXOhT1Iyo2KSngHpPf6d+8aO/AmL8zWLxIItynXCxDE9ZcClhxjmK
         LGk4n+XYjMdT7QESQ4oENa+2wZK2c6zlQnh8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756804922; x=1757409722;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlEqu4WxUDiABf2a30g8zFkM2TpzDalMOcCpeUi3kyM=;
        b=JDbhkBzbq/3goMK9nsQm8wfVVn5XJ9r80aCQ4dW99ELpyHYmR9ud/cNUyUcR98DJ2S
         idcWcifX4AZpztXWGJIt22JFT+XBDMigcqBWh27C+Gn76uI256JHx38iweJxQaH6yovX
         hpmLKQUbmVMmIiXx1+P4BVt/KQytx/QyMZMyJrIQyk7nnXjRlEsgu6fhmhlTcCzwzVLB
         0FiUfBpyp/YhKeYOJ+F8n06O+ZV0//NI3y8yeOT8GaYu7kCRttbvfng5ljHLR5Xbx57Z
         Ii0XOJY+ChdoGd14J2XHxlXjB5zgRvKCHnyTgxaU9DvnLQt2mV6HBSq8pZnfqagzdmqx
         ov9w==
X-Forwarded-Encrypted: i=1; AJvYcCUkUHlrBcvlrjjUV4VdenOvjNGOo3Ljejk2w+tzwh+T894yG2quto4hfbXklx8tUWLshPoyXcyPuS6j1mrU@vger.kernel.org
X-Gm-Message-State: AOJu0YwBoj1E0equGjGcMO2IZNq/X59bk0r+NNxKk1aL+KJic/I2RcDN
	qxjoh0YX7ynT6w7Uev4uED0lQNjcTFbehNiycemRCvZ/b7DY1wGkw4l8Uj7CZtr7HNhYAabkQN+
	uz6w0xeWl9cK5Fc9FVJzMWWzNpCJ4twKYsXht/U8EeA==
X-Gm-Gg: ASbGncvttNrksTvNbpuhBw+chn9lWYlJC13p3AsW7Oybx7VET10kPj5xnYOAzxTMx30
	PESeWKBzKTFzO3pzHNXWNzzm97wfBEIail/G8PalZ7HULs30j3eJWxyUPUmX7yMCSiUNPBvbOkf
	Oe03ObJrszZuo/FsClg28vxkP+h/Bp9fQ0chD7yHAOwB9VnMXW2ujksmTqQ8Q9i9ePcNMUS8Ako
	x8hrOfd0g==
X-Google-Smtp-Source: AGHT+IHGEIqkQ7T/iYNa57/nLq67pz6kDXn62sDrEEuPOwlRvgJBGGtL0MCc4sflnVaHrwo9btUA3j959kBW+PZAoRU=
X-Received: by 2002:a05:622a:1448:b0:4b1:103b:b67a with SMTP id
 d75a77b69052e-4b31b9c3777mr140959691cf.32.1756804921620; Tue, 02 Sep 2025
 02:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829235627.4053234-1-joannelkoong@gmail.com> <20250829235627.4053234-17-joannelkoong@gmail.com>
In-Reply-To: <20250829235627.4053234-17-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 2 Sep 2025 11:21:50 +0200
X-Gm-Features: Ac12FXymFicVPinwbFSWp8veqgoTeVOVPPlBCbz_Zbd4N-bMcdXkFmiPs4wTQ0w
Message-ID: <CAJfpegvjaNZSJcyNWxyz0gQk-_9AXqcPuX71m7yoT2s0cd53iw@mail.gmail.com>
Subject: Re: [PATCH v1 16/16] fuse: remove fuse_readpages_end() null mapping check
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, hch@infradead.org, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Aug 2025 at 01:58, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> Remove extra logic in fuse_readpages_end() that checks against null
> folio mappings. This was added in commit ce534fb05292 ("fuse: allow
> splice to move pages"):
>
> "Since the remove_from_page_cache() + add_to_page_cache_locked()
> are non-atomic it is possible that the page cache is repopulated in
> between the two and add_to_page_cache_locked() will fail.  This
> could be fixed by creating a new atomic replace_page_cache_page()
> function.
>
> fuse_readpages_end() needed to be reworked so it works even if
> page->mapping is NULL for some or all pages which can happen if the
> add_to_page_cache_locked() failed."
>
> Commit ef6a3c63112e ("mm: add replace_page_cache_page() function") added
> atomic page cache replacement, which means the check against null
> mappings can be removed.

If I understand correctly this is independent of the patchset and can
be applied without it.

Thanks,
Miklos

