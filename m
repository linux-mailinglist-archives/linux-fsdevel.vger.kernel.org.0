Return-Path: <linux-fsdevel+bounces-55975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B41B112CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 23:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2A147B8AB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 21:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DB3229B02;
	Thu, 24 Jul 2025 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUCO+zE1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59F11494C3
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753391265; cv=none; b=pkb2YjuZxI3JltmzOvqqYEJfXNIS5bykt/OdVzw1HK26SFILS40O64teAwefNR7vzVdCHJX4GGiizjeh9CyhfUEC+gKZsShh1O9CPUpyM3mjNr00htDsiWF/lsNjYsKazrNsjoXMWiPC3Ptmr/ic6eMeS6uT5pP+Wr4GIXIdPHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753391265; c=relaxed/simple;
	bh=IoxnjuLOHh1eVRkbgwfVtry8WXxg78KEuMyHo0u/Br8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCc4I21jOw8aEL5mLZtByOgYHZaaQHD9Ck7BubVRhLVBxZ5wsWW8gxiSISzWxNqXCJAP4AWq4zOe40vEpu8igNMjIzTdbhc6nvYQkg3DfDfFOPd8f+Z+XYF1unwm74gfzFtDh+fcVzbVf0BJO7ZzysNLBQWbMdJ78tWrjC8x5/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUCO+zE1; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab8e2c85d7so21276131cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 14:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753391263; x=1753996063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWbfCxXxpyP6dnDyz3AfWbVa4XWBBafVKZW3RWq9Rrk=;
        b=LUCO+zE1bDGBrqF/Fdud6aGLEnIiiyRRT4Sgc75zrA71tjsf+Klw3V+gO6jNiS8Bt8
         MAO7S+DeenLp77O4XRppIYNqkemWzgEkIwtVLssy8wpvIMimT7ay0a2qU3ZM7yuN/PQ3
         1uSoZht2wgBtdYjlm1h5bPY1LV6bdP2UULvF7lCyR67wwHtFiyNk4fSBJRDOEzl6pxoO
         ZgcnS6J96hPL3/dnCzVxYu2IhUd8PiqsTGaCMZLOsG5myEHmWDE4crnxzMSEi5NnpCBj
         RCKFWHhotgW8Z+5YBZDhA/sa90EoTZVS3zUM02GtWWnVfM/Bb1z4zst/zekW8Y688Csj
         E6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753391263; x=1753996063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWbfCxXxpyP6dnDyz3AfWbVa4XWBBafVKZW3RWq9Rrk=;
        b=VPVTaSPWGXj8z3UFCdYpw09lgwyzb4ctR3OUyrQOJlTOsCCyz+hYYpVwJTHvP5DOlc
         fsaHWTOFJDlQNxdMvCZfvM12unGRaoe+4tYKw0b1cps5aKbgNAfVmWlt4S8+KJ9SCIZl
         tvyN3PlL1bvfLLF4w+ueCg7Lm9MJSJOkTD1z3iLZ2Mq62d8muvYE6UK2UdbkPU0BUpv5
         vaR7PoYPUD3qu6D/iCesedMwREhq4CBKHq5+jcwUQKd0o0fABmk2AXkd08QMNz6uUUn9
         sL9Rj6kq1E0jrX9TbJtXoU5IF+pEsGuYo8VCERFbhf2KavfAtCiZqJqK/cdynzsp6IHL
         dcNA==
X-Forwarded-Encrypted: i=1; AJvYcCUCTUp6jp+pHfPjwNs36OVRbTmxbdhBqrDx4kV0/Nefo+Me34K3RVJV5yIvW+6SjWIor+yFIgUsR+7Xl3BK@vger.kernel.org
X-Gm-Message-State: AOJu0YxbJ/CT/tflM2nBaMI3U7ekYBdWXprj7ePtHjTCi6h83eY99zAI
	+Vw+86Axpo+DHpXtmt/IBgZHAteirjOjYdJrsT5iUkcU/+ghPnvcvZQKsq5qUUKD979Bk6R1Zte
	+7XiZFFrieHHmXcM6TTkJeKsgaFyMea0=
X-Gm-Gg: ASbGncsMhaqN8j3dAKNgubkR6YeAbULM22knAYPaWNUFkIBuLh1ouxyeLalT5SJpOqF
	rEYTBy7H/78EwSgAL/u4VpEcAxc2biKpH5DTYnDwu3K3Z15Gxko/XybT4nKvf1RGR0VAGhEYJNx
	atLRUj4fzQjk640BEaXUFxOKInhZz1zWXyAo6rMCAG3FlimbL/oQIKJ3dEQ8FkB0FxjD+KHN9/J
	1QDamIWKGPajo/j+w==
X-Google-Smtp-Source: AGHT+IHyEf1k34UQHUPbc2pfVfi34Q1geQc87mW+9bFj642du88EjwVxKR4sfKtppWkMiMD9KGp0v31Ah6hstLN/Y1o=
X-Received: by 2002:a05:622a:189d:b0:4ab:3ff6:f0e9 with SMTP id
 d75a77b69052e-4ae6de3d55fmr102777831cf.1.1753391262489; Thu, 24 Jul 2025
 14:07:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722-reduced-nr-ring-queues_3-v1-0-aa8e37ae97e6@ddn.com> <20250722-reduced-nr-ring-queues_3-v1-1-aa8e37ae97e6@ddn.com>
In-Reply-To: <20250722-reduced-nr-ring-queues_3-v1-1-aa8e37ae97e6@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 24 Jul 2025 14:07:31 -0700
X-Gm-Features: Ac12FXy-NrExTSxtVSjvcCAD1Z8hOAKQ51Q65pS-IOvQL3fmhfO4UkvWNvLHdW0
Message-ID: <CAJnrk1Y82CRHeO6htyJsdsGEuJj6es9B=hg9CdK+bOuhc74AqQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] fuse: {io-uring} Add queue length counters
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 2:58=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> This is another preparation and will be used for decision
> which queue to add a request to.
> ---
>  fs/fuse/dev_uring.c   | 17 +++++++++++++++--
>  fs/fuse/dev_uring_i.h |  3 +++
>  2 files changed, 18 insertions(+), 2 deletions(-)

LGTM

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 249b210becb1cc2b40ae7b2fdf3a57dc57eaac42..2f2f7ff5e95a63a4df76f484d=
30cce1077b29123 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c

