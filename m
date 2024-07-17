Return-Path: <linux-fsdevel+bounces-23884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0421934486
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 00:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B971C20FE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 22:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27236F2FD;
	Wed, 17 Jul 2024 22:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LllAD/pV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DBA6F30E
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 22:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721253776; cv=none; b=GcYjyIQJQyv7nxnoogoRyRUeC/5VXIzp2hqNu3GHXoEX7n/uwSX6607aoAXgtbx4FtGNKnOzzQ6YTDvZ0vejXMBRi3LqJTkIMf+MhIX7bfqarUE1EbsJErfRmDm8yXLAmsApJBmxc0Uf0RTWQbztDMg9aWZ3anSMI1UzP7CYwRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721253776; c=relaxed/simple;
	bh=gz92oaozKiwEqyalYHMDbf3an/qPSDxNgp13WyCuoA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PO5FmXubNwQrlqk/w7kEvabOQLZFDsOy3jBcYlanAbSb8sWeQYsTtncsRMBAyeWFCg+sqI48CPiEeLddJ2CtdzUYFpyy3kVuh+P7eC4OwUDaoWC+eOg7Oo16mhPATg98XTsKmwPlr2z9pSP76X2ZyBMkYWjAp2hXjrbGSWfZTGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LllAD/pV; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-79ef7635818so6635485a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721253770; x=1721858570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gz92oaozKiwEqyalYHMDbf3an/qPSDxNgp13WyCuoA4=;
        b=LllAD/pVFKHw9Wm2jEX8UfmtRuAAWrd05M5G8afQXNR1CgRVVADqKfKE5MCFgwK/7c
         RMoKyYkvTvV7YicWjx8+Q77TkV1zMVr2TLKcX5/BOC8U/xQX+BDVpDQA7u3wowxCtA09
         ysWl2LlMU3Rn3t5jRRlJFnAR7xsi1dF/l5mtLWcEdUJLCQSOPy0pOCfI3X/0XKXu8+zB
         6iFvZ+tLQtUEh3QR/I8oiFmaIxe2vCTATUDWppHzLreF6v5NvlNeJpksGZbA7uOClNIk
         nG5dsRd8SPU/DLAgPD4kPpBVfpUWN0An5Q7WkPGjI3VMk9cNaGKqd5gsg5xYBmADH2jG
         ar1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721253770; x=1721858570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gz92oaozKiwEqyalYHMDbf3an/qPSDxNgp13WyCuoA4=;
        b=UmDBiaVLWVC4xrT7s48uc4ezUwUZl03nw8SYTlQKNJNRTENAGawA6V9l1unAIr2FWT
         i4TctCbuoPj6aMHt8MIOOqn80d5/v04abGjK0Yfc818W4QZMbmeipwkLIY66qCP8FOD+
         Z+DlFi7YBELY3GSgU/ZqaVOnqR0h8NpRTn9bsRcduslapJk/hAp0w8lwbqJwNGlOk+2q
         5JSynBDuDzQjTyzs+DK3F59VJksS0wu/DV+xG8MB6FNR92ilKVmaVn+WjYXEw4bmPSFw
         6g+korY17pNTvnojI/J1O9pPrrpxyHzom4l+0ezcr5rX7byV3JCSbUtoh8lBvdCb2GQZ
         tiEA==
X-Forwarded-Encrypted: i=1; AJvYcCUlWy7VCTChNRvxjZq01SYQGU4TdeDqvCitusaSpCJlGCEKR4Dua2RDY7RPFCpisSVomk/EbBxCbFxgksmJHmFFYw6w+NVOu/VAgbxvzQ==
X-Gm-Message-State: AOJu0YzZKxfhIgqE5zZI7p9XdEFbxi01eet1+4IcbNzqZi9I4BAu9UNz
	rUftP5NoyoHC2u3GxuFUvbBToIz5EJPIpQ0Vu+qg5uPK2apt/Gz/rMEwBXzRgYFEtAzqTtkrMH4
	7GPAL3CTXeDh6g2elGM28PhSkEpYyQT/7
X-Google-Smtp-Source: AGHT+IGuc66TIDXt82PEmXs9oll9aFQdzFtTswcuHimw97zhBkHL8i9J2lJ4fGWrimIROKnry13qYq7kSIkTyZ0LFAs=
X-Received: by 2002:a05:620a:318b:b0:795:5b60:a1ff with SMTP id
 af79cd13be357-7a18749d1bbmr345224185a.40.1721253769788; Wed, 17 Jul 2024
 15:02:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717213458.1613347-1-joannelkoong@gmail.com>
In-Reply-To: <20240717213458.1613347-1-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 17 Jul 2024 15:02:39 -0700
Message-ID: <CAJnrk1ZccdrmzOCEsecc=6e8++toyzbredCMxsq-fCkKR2SaQw@mail.gmail.com>
Subject: Re: [PATCH] fuse: add optional kernel-enforced timeout for fuse requests
To: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, osandov@osandov.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 2:35=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> There are situations where fuse servers can become unresponsive or take
> too long to reply to a request. Currently there is no upper bound on
> how long a request may take, which may be frustrating to users who get
> stuck waiting for a request to complete.
>
> This commit adds a daemon timeout option (in seconds) for fuse requests.
> If the timeout elapses before the request is replied to, the request will
> fail with -ETIME.

For reference, this is the userspace program I've been using to test
the timeout paths:
https://github.com/libfuse/libfuse/pull/994/commits/bb523c2db3417adfd939bae=
f2345a485ad3f8c52
To locally simulate some of the racier conditions (eg request handler
handles the request and timeout handler re-adds the request to the
waitqueue), I manually added in sleeps in the kernel handlers to hit
those paths

> --
> 2.43.0
>

