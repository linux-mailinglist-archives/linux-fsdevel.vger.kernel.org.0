Return-Path: <linux-fsdevel+bounces-24214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F6193BA81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 04:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D702BB22E37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 02:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C8179E0;
	Thu, 25 Jul 2024 02:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP0ah8ja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082C54687
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 02:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721873233; cv=none; b=R/sQaWAYdvpUDcQFU0k2aw6EApAOj5s9zWWY8oVkoApHMUNT9zKia6g/5RMYNWlCYQUSiTFFxHg5+byG5pMX5xYoJcrNF0WX7rhdi2OLxxMyIYQLevUHAUKRdM+k3rDRrjFZkS+T04hAcQfOdMkRTYWIj6p/JPgU0QlQwBSMmvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721873233; c=relaxed/simple;
	bh=WuhZcclKTJjGOqq8kTC0RNwMZwEP3Pd3/weUXTsrZsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crY0Qmon0KmnNgGHytU1xhCrgnTDM869anhZT+FpqLFaAZEGNrfvlvFfULcTObw9LheqapFdLGPPVFU1axL2636wjRYCBqaFTCkj8SxVwgRkVQFqNLKDJOuPmRxehgAIv+8FKzyGPwhadsCzp9RM9DNDyT8JECJ6FHMyA9x/VO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SP0ah8ja; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b798e07246so3181666d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 19:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721873231; x=1722478031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuhZcclKTJjGOqq8kTC0RNwMZwEP3Pd3/weUXTsrZsM=;
        b=SP0ah8jaA0YEKH+BM0qeOXUhRH2YyC/Ne0dP5dAvKaLGR+v2SN2O7PbhJhJZSFMuAQ
         pmwUTfh8QFh9LsGahLN94K8Ee1zncecdsLunGX6edKIyTyBwdGwd2xJZf9ipfpoOAXsg
         sn20g7pXTNjmJf6tVbDxm9U6VqzD36jHOW3m64rmX6QA1qQqozm1ih8QOyUlsuuHBLcT
         P2QdM/8dLyd0mGi6IgYVOIxYTJlnRTirgN3notCZV9p6r+s8PL3Ukqb6i2cDCHEIflAS
         FbU11e2osDN2neO/0TP23+6I67aZ0RPD8lzfc4gQogn1tPmwV88RVvkMgj9x7r2IwDwI
         1fdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721873231; x=1722478031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuhZcclKTJjGOqq8kTC0RNwMZwEP3Pd3/weUXTsrZsM=;
        b=w22zlmG3nvVKlhuqOz5VnVuVSTIsrCvqUpSdTuSnFiXbdO1uxkFXqW4Aj5V/m/0Z41
         YV/OpOyr5ex7OOMT/MudU1bOsZPJJ0yEX/Y4ECdGZ3Y+4wSZjJvUXpM52FUxcEQO7udr
         Dp7lV8ADlq69rRFWjy8o0y2Or2dKOCJdmhPUctsOTSr5IukEs7h7t4rRAwbu8bs5NgDW
         VStrqqOrbaTRsH5u1WWO9o2wlBa+mBRpcbQEwT4n8i5wTxyBwPrGZo6jMY9vbW/6GJf3
         TRvNMaPUBl50ZDG5HCcqDi9EiMW/2TEUwz63oCSS2zgP4nG5Cb+atz/SJ+XI71tfOQDf
         uOVA==
X-Forwarded-Encrypted: i=1; AJvYcCW3k/x4pOwkhOk1cjO3ELpdMgFNM+GdhrgxZZrIQDK3LDsmgBw8mVCgoa5Bn0n7q8x4vxR8hdfXDvgjcAo6puQCbvEEecjJxF+oaPpbWA==
X-Gm-Message-State: AOJu0YzEYvRyv365zYbdIDLa88H8PVsZUBlnn4KXqkiAM/cKxHHqT645
	n5AZfH1Rsbna4ASXKSSRmGwZQ2S/YfdnQtocVY+59IyQsqvQJUecMQ19HIKhv+fq0Abl8VNFUI0
	YH1jDjR4O18LAsZcarhptOUpotyU=
X-Google-Smtp-Source: AGHT+IFtBgr4MVVBpE8ju5jilfeHgiIhiw76yNTBpkX/sn47fY7/5/Dh6Jv073UjBH3mAIsC2a3OTRqa1lCodS+GbCc=
X-Received: by 2002:ad4:4ee3:0:b0:6b5:4a87:4034 with SMTP id
 6a1803df08f44-6bb40878ceamr5286606d6.49.1721873230828; Wed, 24 Jul 2024
 19:07:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724071156.97188-1-laoar.shao@gmail.com> <20240724071156.97188-3-laoar.shao@gmail.com>
 <CAJnrk1a7pb3XoDWCAXV5131gbf_EzULtCaXKn-4-jnGaCrKxKQ@mail.gmail.com>
In-Reply-To: <CAJnrk1a7pb3XoDWCAXV5131gbf_EzULtCaXKn-4-jnGaCrKxKQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 25 Jul 2024 10:06:34 +0800
Message-ID: <CALOAHbCt1Hcu+9O0xB-+jeTT2kDRPdvWD1sE86nDDo-pV9Qqzw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] fuse: Enhance each fuse connection with timeout support
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 1:09=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Wed, Jul 24, 2024 at 12:12=E2=80=AFAM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> >
> > In our experience with fuse.hdfs, we encountered a challenge where, if =
the
> > HDFS server encounters an issue, the fuse.hdfs daemon=E2=80=94responsib=
le for
> > sending requests to the HDFS server=E2=80=94can get stuck indefinitely.
> > Consequently, access to the fuse.hdfs directory becomes unresponsive.
> > The current workaround involves manually aborting the fuse connection,
> > which is unreliable in automatically addressing the abnormal connection
> > issue. To alleviate this pain point, we have implemented a timeout
> > mechanism that automatically handles such abnormal cases, thereby
> > streamlining the process and enhancing reliability.
> >
> > The timeout value is configurable by the user, allowing them to tailor =
it
> > according to their specific workload requirements.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> Hi Yafang,
>
> There was a similar thread/conversation about timeouts started in this
> link from last week
> https://lore.kernel.org/linux-fsdevel/20240717213458.1613347-1-joannelkoo=
ng@gmail.com/#t
>

I am not currently subscribed to linux-fsdevel, so I missed your patch.
Thanks for your information. I will test your patch.

> The core idea is the same but also handles cleanup for requests that
> time out, to avoid memory leaks in cases where the server never
> replies to the request. For v2, I am going to add timeouts for
> background requests as well.

Please CC me if you send new versions.

--=20
Regards
Yafang

