Return-Path: <linux-fsdevel+bounces-28439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BAA96A46A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 18:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794DC1C240C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21291885A0;
	Tue,  3 Sep 2024 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PaylS3z9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0431518BBAB
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381115; cv=none; b=lKELNP4g3CUatnHeuqMeUt09Tww2OUnp4pB/B27BFVoWzEH/mmrbKbf4Qx+MmxCkJFVvfwJ/OfhddOMsPgv7coRbi7nL6y/FGryKfcEBt+u9rIm7z1O29VKYHtLpAV70usrQxYDtDtOU4b2KhFqUrxxLPW3x296M7LbyzBvbwRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381115; c=relaxed/simple;
	bh=+tNNtHhNx6ArmzbBGY7E+qH27+MluekkW/2efa04Y1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tAJvwCn4NY81Hw8oCcM7YC/WDEoQdgKXP5qZPQ4Vh2ZKgFj1n2RclQv0HM7ZHnIv3PwKLMpEgcAVbFyrRVlA6PJHjuklPnpxXjhO2Se5HtqSyRqCJ+WOg6D2hdp8DnTy9iSlSwBWEvHr8KQwWIfzmD+hcteJVfKlaafLlK04wWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PaylS3z9; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6d4f1d9951fso29245207b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2024 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725381112; x=1725985912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cA4f6/Q14LkYipHi4xW5E3QoTzXbTWUwWtLbC9c1AmY=;
        b=PaylS3z9BxeToyzg3LOdf1bKGdTfNepyKZS1f0kifDeBnHWWISTnn8s0NlbOxXIoib
         pQMSHxjV9CZOB97vROZQavyIBo/j0NaQ0Xu1sXV2/KuJwLB5zox9OyVGLDVZO3XKqFR5
         Ks6fuqZws2omNYw6fdIYRuU9LpF5/OWo9+KzxtdGnJr0+djv/yAbAjhEW5g8+DLXfwHL
         XaN2G5DueYEYsmz9CUqo6+pwqYeJieGE7f0xz+oCkeRCwjYWrcs2sAD1R0y9y7x0YO02
         fvgeiFoLKI3+8BluF3+7AO+YgHYtRsLuDpMG6Huw8IpAccyMUp/cp9xa/SftWFUbocfj
         mYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725381112; x=1725985912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cA4f6/Q14LkYipHi4xW5E3QoTzXbTWUwWtLbC9c1AmY=;
        b=qea5jiDOEJe+dH0wXE5HYkR9nf+Fb01dUoMR3TNf9+5p5CyAfjLBOAeu+E3w4RfG8P
         DU5G5cEokkmr2bGrT3s8upTAMKk7/Eacd8CsrTD2ud1eDdfo/DgmOqvuHfU7x7/R+HF5
         XDpoXo0tyN8VYTu1G/kbItqyrtywmoRmfmnppQVs3WU6YUQmPZiWm9fZ2H8o39d7jnBC
         fvmmumXhGz/JL9swCkDR6uBcSb+szpTyWtcpkkdUD+wVSXPt5whDzgtvdvQu23gc4mtI
         oLLM9hDxMX4NwkXb74cAajR34/ACMUshZL6iUUZ1/LiN5CCEii7JS9TupZ9G6z9nc5hV
         PP5A==
X-Forwarded-Encrypted: i=1; AJvYcCXgOQo/6p4quc3qu6wd1A/atqVJHGdAmncPAWpRTHNnab0gfYCpChsxPPXcjqz9dxDSGjHuOeJGSp+LKUXI@vger.kernel.org
X-Gm-Message-State: AOJu0YypA4HDu+KuhhA7Lq3NqWHm6xO1M86Sc71OnNsUCuQqT8znN7PA
	qW8bsTjP/TrS2pLs4HlgzwhH0CTBicNZo//eA8/bN3iyDTdP9FAj8xv9F4EeaIpcB5/Hpip6BS1
	HErQxlHHfwkTAho3F9zs1MWzFMwTyMCIptHI7
X-Google-Smtp-Source: AGHT+IHa/01qoE/GHcK9QfmQSjlJsmOjJNv/+Qv5fA4SkJmS+bKSV6Q2r3LgScHAw7u0DobQXFY/bSjBLHtbXnRken8=
X-Received: by 2002:a05:690c:650f:b0:6c8:1e30:5136 with SMTP id
 00721157ae682-6d40f14e2a3mr154433887b3.16.1725381111978; Tue, 03 Sep 2024
 09:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903033011.2870608-1-yukaixiong@huawei.com> <20240903033011.2870608-8-yukaixiong@huawei.com>
In-Reply-To: <20240903033011.2870608-8-yukaixiong@huawei.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Sep 2024 12:31:41 -0400
Message-ID: <CAHC9VhTJXCSduz2R-LOxTQOb40BmE-=wR3HJafzstERX6MpNUg@mail.gmail.com>
Subject: Re: [PATCH v2 -next 07/15] security: min_addr: move sysctl into its
 own file
To: Kaixiong Yu <yukaixiong@huawei.com>
Cc: akpm@linux-foundation.org, mcgrof@kernel.org, ysato@users.sourceforge.jp, 
	dalias@libc.org, glaubitz@physik.fu-berlin.de, luto@kernel.org, 
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, kees@kernel.org, 
	j.granados@samsung.com, willy@infradead.org, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, trondmy@kernel.org, 
	anna@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jmorris@namei.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 11:31=E2=80=AFPM Kaixiong Yu <yukaixiong@huawei.com>=
 wrote:
>
> The dac_mmap_min_addr belongs to min_addr.c, move it into
> its own file from /kernel/sysctl.c. In the previous Linux kernel
> boot process, sysctl_init_bases needs to be executed before
> init_mmap_min_addr, So, register_sysctl_init should be executed
> before update_mmap_min_addr in init_mmap_min_addr. And according
> to the compilation condition in security/Makefile:
>
>       obj-$(CONFIG_MMU)            +=3D min_addr.o
>
> if CONFIG_MMU is not defined, min_addr.c would not be included in the
> compilation process. So, drop the CONFIG_MMU check.
>
> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> ---
> v2:
>  - update the changelog to explain why drop CONFIG_MMU check.
> ---
>  kernel/sysctl.c     |  9 ---------
>  security/min_addr.c | 11 +++++++++++
>  2 files changed, 11 insertions(+), 9 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

