Return-Path: <linux-fsdevel+bounces-51687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6727ADA1E7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 15:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAECC3B1FA2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 13:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87220322A;
	Sun, 15 Jun 2025 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiMX6TN6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA17262FFD;
	Sun, 15 Jun 2025 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749994165; cv=none; b=hyM0ZRVWlEOhBluG02prWav+DjqHC4KOXsZgS9HoBJvAAWiMxMvPv8jTK7CHCS9CwsgzK+xNSzXXY9axqThcZ0LpQL6Nx7XWDs2wcqtQuQvhnuTtk+QK6j/HhLLrAAuCyW/4kI6hBmMbY6iBti7gMZSBCpmo6lYpm1Ti4lOTuZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749994165; c=relaxed/simple;
	bh=v7dGi/p+QSLBmuZdO0Pxmvmie/0m+xW4GL9DCkwJXzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ooL6NiZ1P/XxzWutL+nfCMZK1aMdj8ulOXEPfWEFbi3MPiIISApizeYsRpHZbKqsaBg5xoy4OFZiIcbsZ3DvivGoGCmGJQ/+qOEXspwn/F23Q8lrNWLXV8Eyawp2dgx0epfASktEhCyZbGonh9SEsUst7B9eZ1xx2Mzc7dIxpQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiMX6TN6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad1b94382b8so673835366b.0;
        Sun, 15 Jun 2025 06:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749994162; x=1750598962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9zzygSfhWf1n304tmrO/WQZpUfmYOrJexVlvQBWi7o=;
        b=RiMX6TN6TG/eN0Djvl6gpGdCpDnIz79XrBnoIW7o809yYRe7SluzzQSLcLBI06U3EG
         5Ni/3HwBWMXLPeiw4IjbkD2klcy36Gv1t3BxI+UxHOBfyj0Hk0oohKwi1tqyweMJK49R
         myfwcER/WR7Hh2HYOrPM+xjl//8bc8IGdtRF6hjPtWLiorbBKpur6gupC9M0QnSLkBg4
         /BT3slQnKnmqPi2PGfAHIH0I9LBfx0/EysRc7F+sTMDR6PQ6H9gmv/7X1JYnmKv2QbdD
         5XCZv7RavsKuqzGuGdFC/2r27MwneB9/ohrR9SHZ8gzQhMReS34rqQnllqtVCIqL+u1a
         HgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749994162; x=1750598962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9zzygSfhWf1n304tmrO/WQZpUfmYOrJexVlvQBWi7o=;
        b=txNdn6bIIpihDpV10VMfhXSUzc0Q8kslcrcLlz4cFsuPChwHcS8W657p8z5g5R8fhV
         K6G0Qat3H17O7xxVXK0GZYZ48zdUuMfFrCjfg3rgw9DSut5LNWO02Zrq48VZpNshnzFY
         s5ORQYg6KakVFRTv7XY4j5dNvhmBwOHHDsTxlwjenlYtmiS2N7jrFhO4b/ahz83EbOv6
         fl4fjZ5z12REsG07JPtbSAOKolwiBsfx5VLaZcbK/R3VjMfwxNUdBwJUBLYwOxQrfSHX
         YMqnZnuP/TVo17E8iyyK7w7pv6yLdngGgbxHuEG6FFpQc6AfIREFyP9JZcn4Vh8V6Bge
         Srjw==
X-Forwarded-Encrypted: i=1; AJvYcCVUUMYPeiVXlppWMLuno4DLuuWW1qyLoKHqwvWewkf3x8ar6LsX9bJ3cDRNFkvl7o6H0gdJ3G82T8xJE3ji@vger.kernel.org, AJvYcCWaIvIEKp0J7Sj4UMXV2ivCdoAVdqq8PHjdNiBfHBhmk7BL08LJvRGn35WZWbkqKtQE1x/FdLnQtIUNvt/b@vger.kernel.org
X-Gm-Message-State: AOJu0YzbXW5UeW+YheGZKgS8OoIYlyrwaabneecq8kxx6AGfcfvMB5Sk
	rGGKpNB9UF0vmrxcoEGx/OWjUtEjFRRAi61yYH3qJjg/lmysoqZGXyWMf6Cd+8L8cCn10h3Lkao
	APMPsfxiUIdJzrDdvkw5FxmYO/SHKFKk=
X-Gm-Gg: ASbGncvf0Mqyt9m3Ha1ldNNL7iV984adcyGxq4FctQeAqLEXnCoxgCEqy2vxJ16gtd5
	DIItqGdDdSdf3tWq8nlvKmcbYhqMBfRHvp3/9FH559eUOfVT+J+mC5WYRyEPw2D1t3n2fzrbb+f
	Dd6GnAaZIKp0JTl25FDpjY9VxLZaadju83Jd30rkTeDg==
X-Google-Smtp-Source: AGHT+IE8bk707t0OYabD32X0uuptPAFaenGnljG03MN2dCI0Nn1BAVcSVQibvjvVSWlhTEkC4lLoL94xTmuXxM5uUMU=
X-Received: by 2002:a17:907:7e94:b0:ace:d710:a8d1 with SMTP id
 a640c23a62f3a-adfad3cf8cbmr453975066b.24.1749994161696; Sun, 15 Jun 2025
 06:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615132039.2051-1-lirongqing@baidu.com>
In-Reply-To: <20250615132039.2051-1-lirongqing@baidu.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 15 Jun 2025 09:29:09 -0400
X-Gm-Features: AX0GCFskEWnSzjEVlyduxkbxWa6zBOSHODMc9LMP88HxKFSkOWF8KXIB41_td1I
Message-ID: <CAJSP0QV8bq_zbxAQD35c_D_3uYO8jnXoVHgp_c2h=FOjPxBgrw@mail.gmail.com>
Subject: Re: [PATCH][v2] virtio_fs: Remove redundant spinlock in virtio_fs_request_complete()
To: lirongqing <lirongqing@baidu.com>
Cc: vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu, 
	eperezma@redhat.com, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2025 at 9:21=E2=80=AFAM lirongqing <lirongqing@baidu.com> w=
rote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> Since clear_bit is an atomic operation, the spinlock is redundant and
> can be removed, reducing lock contention is good for performance.
>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> Diff with v1: remove unused variable "fpq"
>
>  fs/fuse/virtio_fs.c | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

