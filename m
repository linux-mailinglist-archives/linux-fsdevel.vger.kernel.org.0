Return-Path: <linux-fsdevel+bounces-55995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3854BB1155A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 02:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 341117B4AC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 00:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17DF14A4DB;
	Fri, 25 Jul 2025 00:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lv5AnshT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA41F2BAF4
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Jul 2025 00:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753404247; cv=none; b=r+VlJELxbFlD8hRayeeb30pvU0Ypo0NbGr9quMo2UtbvVebjv4qYjBEGDJByDRzAwzzC4bzpxNiWfxJ74OJ9C476tulacCAihuXvMbiufzuls/nkay5IqV5jrZbP9+H82B3tn/BI7pnYGwvVKLq06BqZFlcn9bxO8LYhrsNWi+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753404247; c=relaxed/simple;
	bh=QBRtzPaWpWyTnGdstje+QE8WI6r00erExi+OAG5rKm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgSTPZdIv2LMSWeUqldLa/RRkuVpF3uO1Yy/xUQ/Ox4/mhPXQGKS8jCzYMXcH8U7LeKhQfZk7y58nDWoc8bFDnniP5/GxT/w1Q+Ir8/B1dVS9Ayh7Rabhz0QtE3oF2PU9Z6dTmGdvhgnzVkPbDIjA29ewPcEkEoU5jT33x5vER8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lv5AnshT; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ab8e2c85d7so23221881cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 17:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753404244; x=1754009044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBGOG8kZjuM1NIVTCxUH4ca0kCodC7kmW+eGjPEQ+EY=;
        b=Lv5AnshToX2s3QWJOobJClGkpSeI8YyE8Ly0a5Qtu2pO4zdsI5gOk/dNDXelQk/pyQ
         pNI90bZ7wl7lD12I1VXSkT/zPSVzEKm7aiSFHIkMkJ2oEzT4mUf5COyHfVavlQT8yUbh
         QyRbi2zOszjiZNWwx/MCjKVVKCjikEwrzGQT5fhwmOf4LT0JyoP/lrYumyFZ7S66RTH9
         xGHe578emK8UnvlpazBBd7Rc7K1wPtkBJrAJ4OZwSGxWN8EBQHHMOEJR/n05gF18Fd72
         g0bknf1QqTjgou29+fZmv5pZyRs7DjTUGJH7DBCzH1hvg9RDSONWFRRN9WjuNmnLmjrm
         fgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753404244; x=1754009044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBGOG8kZjuM1NIVTCxUH4ca0kCodC7kmW+eGjPEQ+EY=;
        b=FD0QGkcaRVAWfS8GFZFy5WdGc6BTwAHmu4Cxq6mFCLY6T3tUpgXI+rVqxWurfmMHft
         2gSvkqxEnQmyudYBVe6LPX6AaRgIil8NyOr2kYcBdOWLWdG3J101xDUyiKkrbou688FG
         76+i58Mja2VsdjeZY0K6fV72Fa8Lrhm+5Z2RcMx6Ezx8PwDLfVeeFcOCOoPd6sSHDPwR
         i5m+3+hgUHzKT7pJuGUk++zp+NzRVOVnTORDeTR/hBWEsSas0TWRGnoSa8Bf6QJiays+
         JNMj1o53g38w+G7xTGsz7WhiWwuKIqAJMLInV4fl2BSOzllZYlV8bct/Eus75RPUF+Fk
         irJw==
X-Forwarded-Encrypted: i=1; AJvYcCWNfRNiRrlJsT8NcfeGAWuM3vShOBc68RKvXR5zguxoZTwnayfiVrMpjIaMiTK4swSNdJMNtcKN88X+HvFx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4mxPwzmh47zQrCNKlxpPZwZTL0hrnKSktAbnfDnfv2NmlTb22
	IuSaPX+lbJ9iPp+gCWNeQQpir6r+pfubA3VEW76FWQDylv/2L2WGrtTUpwZ7NODOovMaQuNnjhI
	x1OUHQ8EerJpiCKPDKC+foyky7xL5GlvKJc9Pu1A=
X-Gm-Gg: ASbGncvLLE88stvJyRtJ7NHcCyQIoy4tuk6IGhfXphIlPXMmpMWDbeOgMHm1AJFqPTb
	Bni5E/g92lh48txwdvUvMKYq98EeahnvPerWm12IwW4be0wy42da8a6pBFM61mlwk5RLhq0f/MC
	bRtPeMgBkSwwmTQHusIWgWAJOSJsA4JlI1wi4tM3lvRnFlqdNZMQW8chlrsM4Rc914lQwkkDrJ3
	1B4zcGFDSO707uM+Q==
X-Google-Smtp-Source: AGHT+IHroVltNcv3u+nF5n+NFIi2MamQ+1Os1Glkb3/CmI5FqDWK60Lt4dx+VftP9SB/I4CQXOPGrCSa0EW1VRW37t0=
X-Received: by 2002:a05:622a:5591:b0:4ab:6005:7186 with SMTP id
 d75a77b69052e-4ae6de730b9mr107536781cf.16.1753404244328; Thu, 24 Jul 2025
 17:44:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722-reduced-nr-ring-queues_3-v1-0-aa8e37ae97e6@ddn.com> <20250722-reduced-nr-ring-queues_3-v1-5-aa8e37ae97e6@ddn.com>
In-Reply-To: <20250722-reduced-nr-ring-queues_3-v1-5-aa8e37ae97e6@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 24 Jul 2025 17:43:53 -0700
X-Gm-Features: Ac12FXz6ZqYzfc4G_yyQT1BWXBiiGF5eonZJYm9eG3PxThU-51AcTqv0C4KBiz8
Message-ID: <CAJnrk1Zn=f9Y0xxgrrVPnuFT+zP3aLeLwbL8gxC5gLsyiJO=MQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] fuse: {io-uring} Allow reduced number of ring queues
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 2:58=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> Currently, FUSE io-uring requires all queues to be registered before
> becoming ready, which can result in too much memory usage.
>
> This patch introduces a static queue mapping system that allows FUSE
> io-uring to operate with a reduced number of registered queues by:
>
> 1. Adding a queue_mapping array to track which registered queue each
>    CPU should use
> 2. Replacing the is_ring_ready() check with immediate queue mapping
>    once any queues are registered
> 3. Implementing fuse_uring_map_queues() to create CPU-to-queue mappings
>    that prefer NUMA-local queues when available
> 4. Updating fuse_uring_get_queue() to use the static mapping instead
>    of direct CPU-to-queue correspondence
>
> The mapping prioritizes NUMA locality by first attempting to map CPUs
> to queues on the same NUMA node, falling back to any available
> registered queue if no local queue exists.

Do we need a static queue map or does it suffice to just overload a
queue on the local node if we're not able to find an "ideal" queue for
the request? it seems to me like if we default to that behavior, then
we get the advantages the static queue map is trying to provide (eg
marking the ring as ready as soon as the first queue is registered and
finding a last-resort queue for the request) without the overhead.


Thanks,
Joanne

