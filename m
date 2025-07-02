Return-Path: <linux-fsdevel+bounces-53594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB28AF0AD2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 07:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D05B1C045CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 05:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544E71F416C;
	Wed,  2 Jul 2025 05:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qGy9YGZX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E7D1F1301
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 05:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751434955; cv=none; b=LxfoIJbMPA6oiwCD3sqMBxoNppfAVEBmtjhTZhUW91z2ypv31NRmYUoCO9xxgdVYdfKbUekOpoD9wiEv9lysHsQiNyppymRwedjtYqjut1fmVStBw5he38+Vnd3Sl0/TmGirVpYJGNvx4Qin/6rUVU8FeVzxuhkzPpiUzqK+ypk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751434955; c=relaxed/simple;
	bh=S+zPo5ERTStSzH9D1C3v8My4jIfYm5tnWHrJvNIMhwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCI+DV7rpe/6ZBBI8mI+4gnLzRUVVs2A95OBTl878oeU6a+YigaqITfugt0Hl9r7WwvrQrn9YDYiNxxg6sXZGSikQLnDQRIXx9p3EH43xKwJ6NgIIkBfWIbzetluJGZXFI4DkIiOAeJ3V0B89Mc65eePDZfzeslAArzJYMesjQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=qGy9YGZX; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a97a67aa97so1301381cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 22:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1751434953; x=1752039753; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S+zPo5ERTStSzH9D1C3v8My4jIfYm5tnWHrJvNIMhwU=;
        b=qGy9YGZXINSWPLzA2HADUEchXJ96N+b+mEM1ug5pTErWrDPRhnutDpibx5ubIuN49c
         iqYdldnKdhAcv2svT8pgw7Up9Z48hgcncyZhK5gQ6EmnhF2H27b2xg5rzNiymhRdiaOh
         tHSlw+6XCOtFSKrWGjU3c7A5rB9PBjfWB23vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751434953; x=1752039753;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S+zPo5ERTStSzH9D1C3v8My4jIfYm5tnWHrJvNIMhwU=;
        b=Xp82PwMwFB8GCdNRk/nOiU5u7J7vVWcSYZhOIFzcTlnbgg+Vp/18tz74LNy3STTsdi
         NjayX1BpsA72U5CB66j1bWEnUcZDN7AznS21wjBLQi6knja3W9gAYWMcbcL0UYu13Neh
         ynNrJNCd3weDEVjFv1iXNmo7AXXZ3pvlbggFPsHhRh9sBW9hJnbCTaEZsBO+WaoemkNO
         VWW028VcODQ6pEAv3JrogIN0QBO251P1xVFqlA3sePJbi1QoZazCxJQAoUabYx7G+q/l
         hymSlJ6ZD+T84CNFWFNq0y400ba3gRBi+EFO5Z9lxFwtDz8yQzYW6d4s1RYwPXH7BPad
         MJrg==
X-Forwarded-Encrypted: i=1; AJvYcCXmcpxFcuj9HcKGmJB1jLroGf9uCagoR3lZuxAQJy9lcw9Hu8NfzEtNRvb7KCKvr/+g5gItqQWNmHCDHakH@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe9bc1LEPpgaoSKnlU2SAWkmjhN9uQG6d0JyqWxV1ykBrVZ6gd
	E+YqeJiDWNnlnK87+T1poNVWkcZRZ2/ryNKMM6bGTbfPBzcYl2joWgQ/VE4AS4eo1kbV6EsiVHI
	U5/HsVrupVLA8SPIx0qN3ATXOtLaXazhPZhMEq3VH3A==
X-Gm-Gg: ASbGnctEUczrgR7o/6CeiR9zaNzZ+/QdYKRgtq3G961gWOvXGI7j4mhPgNESnXGDd4x
	bpRicRG7Q40hmJbGHc/4y6qT91Ig8kOZhxcWlwm+wfYNPQxsBJSLakq10MvbDyT2qC7v7m1/qpv
	ZknBaXY9/Tpf8siYsUxm+H/fsJ+XrXuhfY8xiY1m+SuRZYEB/ovVK/mX31qiH6CvKtfVPPTLe3I
	Top
X-Google-Smtp-Source: AGHT+IHIs1Nc8ZsOhKfJDquXC4dpDHews6mYsGdn6IsKTHmk+3HLxuHFUSsoGWU8khtMjUXM+53CCCsHY5/gWF+66IM=
X-Received: by 2002:a05:622a:1889:b0:4a7:6f1e:6fa7 with SMTP id
 d75a77b69052e-4a97690acf4mr30954751cf.19.1751434952762; Tue, 01 Jul 2025
 22:42:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615132039.2051-1-lirongqing@baidu.com>
In-Reply-To: <20250615132039.2051-1-lirongqing@baidu.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 2 Jul 2025 07:42:22 +0200
X-Gm-Features: Ac12FXzxs43CUldwYNNzjBZVxbrBptY9qCnaMpf-lB08P-9mnEL0MjBx8JxcZDc
Message-ID: <CAJfpegvBFDLDQCKTi-rY1zZWukQkn0nN7kU8QcXLs_QYZK5w8g@mail.gmail.com>
Subject: Re: [PATCH][v2] virtio_fs: Remove redundant spinlock in virtio_fs_request_complete()
To: lirongqing <lirongqing@baidu.com>
Cc: vgoyal@redhat.com, stefanha@redhat.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Jun 2025 at 15:22, lirongqing <lirongqing@baidu.com> wrote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> Since clear_bit is an atomic operation, the spinlock is redundant and
> can be removed, reducing lock contention is good for performance.
>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Applied, thanks.

Miklos

