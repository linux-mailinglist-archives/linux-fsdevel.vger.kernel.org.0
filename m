Return-Path: <linux-fsdevel+bounces-5583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2481980DD62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 22:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C262A1F21C08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 21:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C3D54FAC;
	Mon, 11 Dec 2023 21:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWIOKCpj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBA091;
	Mon, 11 Dec 2023 13:41:50 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d06819a9cbso29516075ad.1;
        Mon, 11 Dec 2023 13:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702330910; x=1702935710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwLQENTdPffBkpFzdzONQopDme87OdDEkg8KOD7qZcw=;
        b=BWIOKCpj9TSD72QBM+kpKDtbTMQLChK7WRMKNSwrwXbmsaXUkMFukL9TiJr0t5790V
         JHRGzHnt+uyWhK5rvHRsixcH7LtCbhVnQY4ujYrYXBt/uLgrTqbh0Sy17mHEUKtRmIGL
         UKTN9Vk9/m1nxpPPnQvbrKe2uogTH5E7Zw5xQBIhY4fV7iNIt7TvzCh9BnleFqeZeBBe
         8Fbgn3POUn7n9g7iCfmIdv+liAKh28TQe7ChdLionyEgN4iHavIjwnPu97/3gwYy6XzP
         BnE16aNdcr9L6c7uvkTiOjUFELezVIBeSUrmFQz0z18QHJq59JMpf/SZFFTVk7BxLX/v
         kdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702330910; x=1702935710;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JwLQENTdPffBkpFzdzONQopDme87OdDEkg8KOD7qZcw=;
        b=FF0V4oAE5Bguxzun2Po2A3tjP3Iz+o367GrJmjxzn6Q/HkyKwmLof8tlJSdbhgMsmI
         EkahYIPUC77n6U9xd/rsqSCqKhC8zfXbgkwriDMkbu9O9n5+faDvLxISFuewWAhUkqZK
         n4MorGMfXHbw9q2+p/7HrUzzcvnb+zTUTb8YylC+Zi6Rjzf6Q44Htqqh2kzDKI8sMX0F
         SfpiIt10APvW3zs+itYzYPhWuA+wonOxFctiYMYxkeSU9xBVsCP32aJAOFX5Lnfim6+N
         cjmbx/ldCED1DYRqYWCTCXs5oKgROUIJEQhDZboSPfvIoTZDBWgR1sO5SvTP90xC6LA7
         wBwg==
X-Gm-Message-State: AOJu0Ywy3TcUomnes/aLLAu6rmGe7FaQiatNEYUxgspjKu5551jXasUq
	OPPYD/pWamM3Z2DNk7fWsZ0=
X-Google-Smtp-Source: AGHT+IEeVr/GDnsmgh2icFesJUABi9RlgouwJNRHVFKdCi31zyBc8B30a0lY4gCWixwMMJy68PcyjA==
X-Received: by 2002:a17:903:190:b0:1d0:6ffd:ae0d with SMTP id z16-20020a170903019000b001d06ffdae0dmr2454556plg.116.1702330910099;
        Mon, 11 Dec 2023 13:41:50 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902dacf00b001cfcd2fb7b0sm7144800plx.285.2023.12.11.13.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 13:41:49 -0800 (PST)
Date: Mon, 11 Dec 2023 13:41:48 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 paul@paul-moore.com, 
 brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, 
 keescook@chromium.org, 
 kernel-team@meta.com, 
 sargun@sargun.me
Message-ID: <6577821c86fab_edaa208bb@john.notmuch>
In-Reply-To: <20231207185443.2297160-5-andrii@kernel.org>
References: <20231207185443.2297160-1-andrii@kernel.org>
 <20231207185443.2297160-5-andrii@kernel.org>
Subject: RE: [PATCH bpf-next 4/8] libbpf: move feature detection code into its
 own file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Andrii Nakryiko wrote:
> It's quite a lot of well isolated code, so it seems like a good
> candidate to move it out of libbpf.c to reduce its size.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/Build             |   2 +-
>  tools/lib/bpf/elf.c             |   2 -
>  tools/lib/bpf/features.c        | 473 ++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.c          | 463 +------------------------------
>  tools/lib/bpf/libbpf_internal.h |   2 +
>  tools/lib/bpf/str_error.h       |   3 +
>  6 files changed, 480 insertions(+), 465 deletions(-)
>  create mode 100644 tools/lib/bpf/features.c

Acked-by: John Fastabend <john.fastabend@gmail.com>

