Return-Path: <linux-fsdevel+bounces-9367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0850084048E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 13:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08ED91C22054
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 12:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195395FEEF;
	Mon, 29 Jan 2024 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="NG18pTOJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCE45F872
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 12:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529873; cv=none; b=CAb9ZJhreusFtu7u9EzWWaVCdzHScgPFXc7c9AG+H9V5nEQtxUz11M4z//BrbsVQvYFG6ruaoOSSP3bgxIgle0DLu1jvitg4A3BXQPtkwKpbp+uBXAxcWo46qYWescrofcNpfgTvz2fHvxJxaOsAN+V62R80ALCG1m/QVpBIul8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529873; c=relaxed/simple;
	bh=guKqzou9JxhGbLxp78Z+x8FivDPj5sztMuw+LuhgLB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YeoD6+L3ttZUoFNPyoFk7qZmeuCo8VCafqDA35LX4QChyVOjclBQAKoZmmNdJJ61KISH4zvb8iTcvli9vH6iI9NDxwCGoBkDyJbP1eTh6+xBGjqut6UXhNrqfSdWHYSVKAVuXR/ivuM+IECkPaQVFANy5SXA9f0mbA/Q6GQtxVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=NG18pTOJ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 470B53F17F
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 12:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706529863;
	bh=2Exy3GhKosvGbT5X/UC+qA1tj2KKyG0xUp0U1ONjjlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=NG18pTOJ9H+hLXs+iplN+Xyn/E0KPm4/LosURMTtH2Ua/vzH5xHI9UYASZC6g14Ot
	 3qgHKaS+ATk4zI8ZwJFA86iJoTVh8Y4HGLcc9xKpuheIeSN7CtMnyx5LtGcymboRwu
	 DB8u/dbMoA2XG8rX78U6vt4yrz1JHw2rcAjc5YPKOTmnVCxixF189D+auooE5bdj8J
	 ziGQYGc1in0BcSqXLAKOEDy+wa/5lLCn+wBIL7GpuY/6aoPxRuV/oVFrGBO6MAXQsh
	 RzspRb8f8n2VsxfK2JZ5XBfldOcqF6b6Vv7NKy0QxwJKnBOfPqpRyJyLiYvn2sp5er
	 tK+4StZfVHkLQ==
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-603ce32f142so18068177b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 04:04:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706529862; x=1707134662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Exy3GhKosvGbT5X/UC+qA1tj2KKyG0xUp0U1ONjjlk=;
        b=NwmJ+VtOWWORbp3ynQfgV/51poAG1okxaJ95FQIzVpg64PpjaJ4s4Qm3aclln2UaKW
         +aVdlMd9WE08z00eoQ5kCFXUILFEuCOAvyeVQzr43NEy+3LHLjm4khlKzKE7GwGRs+jL
         lTAuxuizC5ZRUEwAuaG46alobWxB8mlqh/QtZJ1BItxBJHzCEj78ZOXqfY7JAKORpZUw
         I6wJdEvoos+VPyHCAEHtY6gAHg+YO61VHBGz8oKrSPSMKpEgMi9yhFlXqJtg2F55aH00
         AukRCGTdnXTw5rtt6GZZfJSs0uOEV62a++ylZVO3nzxKeqWemhhouLaNGkB9Rw1SjiY1
         kAzA==
X-Gm-Message-State: AOJu0YwAYVzQ8iK99bt6VhuBFL+AoeIUpJuwRFyeq3zUOJUARLXQQIvB
	VHTT09VNFlDmFQw+cvsMKRBDoz/DSo1gzGAVfjR+kkeOD+L3Gz32IApUn+JikbOnv7LOlRebJwZ
	mpDvr57iZqEiSIIjjzzj4Guo854TMXHrF3DzVrE+CMZ3y80998zJPjXxp0730iKhcLSWrXzf1mn
	rRL/bRfqtcTWqv8S2ZNd4MVBkfqsoW9fwHyMnSubxxzP55lYFPWpXG1w==
X-Received: by 2002:a0d:f181:0:b0:603:d6fb:48f9 with SMTP id a123-20020a0df181000000b00603d6fb48f9mr1280918ywf.53.1706529862003;
        Mon, 29 Jan 2024 04:04:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMvVtF7sHC+nPzRou36SnaeoG3GSE2k6MAEfptIQ9VxNMPIjPuMEhN0awDUlRRI1mlaO47bL+8+0xptKJ9flw=
X-Received: by 2002:a0d:f181:0:b0:603:d6fb:48f9 with SMTP id
 a123-20020a0df181000000b00603d6fb48f9mr1280910ywf.53.1706529861687; Mon, 29
 Jan 2024 04:04:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105152129.196824-1-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20240105152129.196824-1-aleksandr.mikhalitsyn@canonical.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Mon, 29 Jan 2024 13:04:10 +0100
Message-ID: <CAEivzxddSeykHM2D59EvcGZ7bGKVZtq-t7z+c8+7yEDZuMMTRw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] fuse: a few small fixes
To: mszeredi@redhat.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping.

On Fri, Jan 5, 2024 at 4:21=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> Found by chance while working on support for idmapped mounts in fuse
> (will send series soon :-)).
>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: <linux-fsdevel@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>
>
> Alexander Mikhalitsyn (3):
>   fuse: fix typo for fuse_permission comment
>   fuse: use GFP_KERNEL_ACCOUNT for allocations in fuse_dev_alloc
>   fuse: __kuid_val/__kgid_val helpers in fuse_fill_attr_from_inode()
>
>  fs/fuse/dir.c   | 2 +-
>  fs/fuse/inode.c | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> --
> 2.34.1
>

