Return-Path: <linux-fsdevel+bounces-27233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7426295FAAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 22:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B725283335
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 20:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF4013A899;
	Mon, 26 Aug 2024 20:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9Jaq/lU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CD8364A9
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 20:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724704272; cv=none; b=sjZKeyHrDWpruufXnFHrtqB9v0Ggq07jYji6DJyoHDl6HZ38NLCn5IyGxuxu1kRYt+sfSMoEYx1Ux5qy/6YezXZWxHALdemdyyXwzu9sFJLTtKbvRUP5nb5c+K6tjWu1znSf+3Cb/XKo62IDRlfQTlIvSpT0ZghR4QafzySxI3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724704272; c=relaxed/simple;
	bh=AGzka+M5hLNncDJUr1buHYkP1KZZCo3v3Bw9O9YPUuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPWcatlA5Hyg4k2YfegJkwX4SB6yjhuDEqjGDaRvy70kI268u4mVSNB+VRbyK6yeWJQaQ5XRJJ4OClKpHu6iq9L06ydIWKt2EhAcJusa/1Oz+QCfBRC9WTUfWVRGB1JOVK99dCe5yu63HXhUun+27UH3wMizr8yyiC75IwHqVzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9Jaq/lU; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44ff6dd158cso27001911cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 13:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724704270; x=1725309070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kv03WFxy8WiAlpJoxkdwkUBYxv5EDHmfT1sFywJ5HHI=;
        b=h9Jaq/lUN91g1oEOM7OmE4VzOPgnshV/dp9TNj+RoFAG9i/V4zxeXLSRs405dQi2Sk
         lRY4gJyRC9nFXsdm5P3p1KzMhPb1HSFsT3Z0RYAf73J092eHsYYqK/ig4Vkpl7AEbvtr
         vyw94ghhnP5ybjsMsj9wkJQ859JC8/DouFyziD9zgJODYxWhLAVvVvFApzLD7Ts235Zs
         f8w2Y47kaFSATz04nObQi0IPoBbf2Z7WU5ki/bR0PxqctWIoK8KckGSsxT0xzj2c8G1J
         HIj06r1x/dlyCYeVpRohGNQVhlbToe7kkIyqsEAGvdpGtQSbX+5JS6MZ5dgYORC5sOJR
         aO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724704270; x=1725309070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kv03WFxy8WiAlpJoxkdwkUBYxv5EDHmfT1sFywJ5HHI=;
        b=tjAFtjvx8qGo3GML9HwoseAJ7rSGdSf/5d0XK2IEGnyp67chNAIjB1GxlDtfHW7iy4
         Dv5bwzUmIg9isvFyES47LlCyt3Ipgz53kZEXv/KeHR8SpoLoJ26KABZM4R6Ry+KNYR+7
         s8Hue8S0MII7LDGwAn1fTt+BQnxnD+NNP+zkSOlMzK8+Bp9Z6Xt3YFbg0Uxniu0UvkIF
         GaG7jLgnUmIkqcWdSFbG5dUAVyIw4QOj94wzuWGCW8LcTW7iObhSIdMNXtCGHRHA69Xw
         m4YMeB/Rhc1zL0rkiCezGtEzdOo3Ekh0+X4sK4kIt3B2DRw/qK20Iju2H4idAWpZtkri
         cZmA==
X-Forwarded-Encrypted: i=1; AJvYcCXBMrNUmBBMSwfitAKbM8HAJrZ7Z/SZrdGuyhiG8xJy+tKRNJPQoHJEEhm868NIyozlZgTsOXC/Hym281Gi@vger.kernel.org
X-Gm-Message-State: AOJu0YwGnYH0TaVnrAaycgBszKhP+JTZMqxxFHikwRizqG/jyiKoPyTl
	3JB384A3PuJLSo67SPiunz/i7S1/Kge155jqIp4Wv0g+Pta2l3VeN8stTv2gxtMrfyvh/nTZBUy
	m5/+Y2KNoRDfmr2e3yceoAfr2ITE=
X-Google-Smtp-Source: AGHT+IGxV8vs7VELnmVTRnfNKf/d7qPOaSeLWpRLBHT9l6MwxYyx3Rx0AA2r+tKyJWPq3lrn3WUmslgnjSuQ+6DXtug=
X-Received: by 2002:a05:622a:5a09:b0:453:14cf:aa07 with SMTP id
 d75a77b69052e-45509d59833mr139540521cf.55.1724704269929; Mon, 26 Aug 2024
 13:31:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813232241.2369855-1-joannelkoong@gmail.com> <CALOAHbD+_2rPd6BX5z-RHBw-9vpu59LrGiiZz9C750MHx4vAQQ@mail.gmail.com>
In-Reply-To: <CALOAHbD+_2rPd6BX5z-RHBw-9vpu59LrGiiZz9C750MHx4vAQQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 26 Aug 2024 13:30:59 -0700
Message-ID: <CAJnrk1Y2FRhWJwLS=SBNrc6hEQ9RUMfqu2Rt0fWxgQ+NoWXtOw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] fuse: add timeout option for requests
To: Yafang Shao <laoar.shao@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 7:02=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Wed, Aug 14, 2024 at 7:23=E2=80=AFAM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > There are situations where fuse servers can become unresponsive or take
> > too long to reply to a request. Currently there is no upper bound on
> > how long a request may take, which may be frustrating to users who get
> > stuck waiting for a request to complete.
> >
> > This patchset adds a timeout option for requests and two dynamically
> > configurable fuse sysctls "default_request_timeout" and "max_request_ti=
meout"
> > for controlling/enforcing timeout behavior system-wide.
> >
> > Existing fuse servers will not be affected unless they explicitly opt i=
nto the
> > timeout.
> >
> > v3: https://lore.kernel.org/linux-fsdevel/20240808190110.3188039-1-joan=
nelkoong@gmail.com/
> > Changes from v3 -> v4:
> > - Fix wording on some comments to make it more clear
> > - Use simpler logic for timer (eg remove extra if checks, use mod timer=
 API) (Josef)
> > - Sanity-check should be on FR_FINISHING not FR_FINISHED (Jingbo)
> > - Fix comment for "processing queue", add req->fpq =3D NULL safeguard  =
(Bernd)
> >
> > v2: https://lore.kernel.org/linux-fsdevel/20240730002348.3431931-1-joan=
nelkoong@gmail.com/
> > Changes from v2 -> v3:
> > - Disarm / rearm timer in dev_do_read to handle race conditions (Bernrd=
)
> > - Disarm timer in error handling for fatal interrupt (Yafang)
> > - Clean up do_fuse_request_end (Jingbo)
> > - Add timer for notify retrieve requests
> > - Fix kernel test robot errors for #define no-op functions
> >
> > v1: https://lore.kernel.org/linux-fsdevel/20240717213458.1613347-1-joan=
nelkoong@gmail.com/
> > Changes from v1 -> v2:
> > - Add timeout for background requests
> > - Handle resend race condition
> > - Add sysctls
> >
> > Joanne Koong (2):
> >   fuse: add optional kernel-enforced timeout for requests
> >   fuse: add default_request_timeout and max_request_timeout sysctls
> >
> >  Documentation/admin-guide/sysctl/fs.rst |  17 +++
> >  fs/fuse/Makefile                        |   2 +-
> >  fs/fuse/dev.c                           | 192 +++++++++++++++++++++++-
> >  fs/fuse/fuse_i.h                        |  30 ++++
> >  fs/fuse/inode.c                         |  24 +++
> >  fs/fuse/sysctl.c                        |  42 ++++++
> >  6 files changed, 298 insertions(+), 9 deletions(-)
> >  create mode 100644 fs/fuse/sysctl.c
> >
> > --
> > 2.43.5
> >
>
> For this series,
>
> Tested-by: Yafang Shao <laoar.shao@gmail.com>

Thanks for testing this version. For v5, the behavior will be modified
(if a request times out, the connection will be aborted instead of
just the request being aborted) so I'll hold off on adding your
Tested-by sign-off until you explicitly give the ok on the newer
version.

Thanks,
Joanne

>
> --
> Regards
> Yafang

