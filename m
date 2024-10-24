Return-Path: <linux-fsdevel+bounces-32785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39099AEBBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 18:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4E51C21BEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 16:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CAC1F80A1;
	Thu, 24 Oct 2024 16:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKVTYMJw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7CF1EF08D
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786777; cv=none; b=HyG3AemmBYbBsVtq1Nq12a623D0gs+qifgo9IlMd9rRt2N9rN7nTEdEwY66y+OMa1dD9XEXK+4NexrlhtOTzEgDuff8ZEEcDomNT/J5IDJ/hviH+tXucHuUfd4liwBovn3g8qP7NFuXWcuSy08QyjOdS3he37b1nMQWMVkhFyE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786777; c=relaxed/simple;
	bh=QNKlbg+9FnjGVGUdZaBsIKqMVhWzw/1WxYi1qOo6XSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GsorJgt0t6qdYxiho0y9G+aRuyY6z0bZhpTo2zSIJuOiTAF35r+jBgKn9tSyDJ4xRleQj4Hh1viDnF4PK6C42zFuMRR3iiiGK4Z/A0FWMNfaaOcjKkUzVYXvWpwi7qfz8YP1jh8Eh7fHMvi82aPsyYuEOsqLYYnZVQwNXiB3R3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKVTYMJw; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-46090640f0cso7422701cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 09:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729786774; x=1730391574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYeUbOKa306q6I12krc0EQx0Papi5FUOsJbXPHIzdgg=;
        b=FKVTYMJw9s6VqGIR7SnnNGhxwoKnEFrGbRbHHBfGHFYkkCpbdbGRvRx1GeUCgftwA6
         Leh4Occkw7gs0sxFbSx+Dta9TgMeb+R4gIANUUwMqKVXGSBeePo5vOi56lDKFapF/8XW
         6YXUvIwqyFGTznZiw1uCQbpuqLiiD5eSCP8MwVrKANLYoazvPCXNguPzklOVDC47IFdr
         ipu8laMpX1u7rt81HZAsNu3ttMvB4p//LxYFpBw8YFIaPCgL9iBIlOMxrnCquGaHf2cS
         XyBPSpz3wIuXfd9lHXkmbCIGHmSGCc4X9zwk/PzJqAvCf8+TmHWolwrilSKjkEN2+646
         nQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729786774; x=1730391574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYeUbOKa306q6I12krc0EQx0Papi5FUOsJbXPHIzdgg=;
        b=cGquLA/uTxPQbI6HZ477PSnYBzoDr4yBRvlYwN1Pb1c1Fc83MNbwtZD+DBdmhOMty3
         uw1Aw+DJs8y0i5EVX04WjMMt2NepO5jAupRbWGiUdi+KXbRPRNHzJKov79BzxGB/l1wk
         wh4uv0K0OtftbFZAtYn2jBUM0Fb+ow6He5koMvYqvBxYaRRPT9WYpxuuT/Kz6/aN8YQC
         UyEgvHZgmvfQEBXn8sWTKKNZnu6++32l8TcesIkic4nc5VdIwCvzmf7yekaKJ9RDqVLR
         P2Bg/N8VpLVbItGKfVMelqlpYvxz/dxFIvSBMa1hyyS8zQJU+bbjO6f9bvnebPAuDvF7
         NJlA==
X-Forwarded-Encrypted: i=1; AJvYcCWSA+TSI/ZT3Buck1yspabSvWUd/BOgdLOzevCS3sS/ai67qK3Wkf9+7iAsaqNCbUZBaDeoPOWeJZ4tvsGM@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqld28zTakvYLxsCd9mPhuult3G6PDR3Cd8isXh5j4q8rs1yZO
	ZzWGzZNXHJZjvosAG/Z4EkPI8zvawNj2cnw8cZdpDT6Xz8kJTAt/dMOIBHuejMf85lwzS2b2vke
	B48u7w5uw7Kmbnt+DjpWn/dv1liw=
X-Google-Smtp-Source: AGHT+IHqRN9l0IUefAm1IKWd69uN0YVoo7MUs1wFbBZaxoUZOSrpM1bCIjgUWfQKgUZxPGvcWafmYRmzqZB8bCkQKRg=
X-Received: by 2002:ac8:7d54:0:b0:460:a9ec:b506 with SMTP id
 d75a77b69052e-46114754d21mr94344431cf.49.1729786773795; Thu, 24 Oct 2024
 09:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011191320.91592-1-joannelkoong@gmail.com>
In-Reply-To: <20241011191320.91592-1-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 24 Oct 2024 09:19:22 -0700
Message-ID: <CAJnrk1YH4J2rCbxLbZu+qGKSGbR66ppaEbEPQZfiE9KVXeaoUg@mail.gmail.com>
Subject: Re: [PATCH v8 0/3] fuse: add kernel-enforced request timeout option
To: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, 
	jefflexu@linux.alibaba.com, laoar.shao@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 12:14=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> There are situations where fuse servers can become unresponsive or
> stuck, for example if the server is in a deadlock. Currently, there's
> no good way to detect if a server is stuck and needs to be killed
> manually.
>
> This patchset adds a timeout option where if the server does not reply to=
 a
> request by the time the timeout elapses, the connection will be aborted.
> This patchset also adds two dynamically configurable fuse sysctls
> "default_request_timeout" and "max_request_timeout" for controlling/enfor=
cing
> timeout behavior system-wide.
>
> Existing systems running fuse servers will not be affected unless they
> explicitly opt into the timeout.
>
> v7:
> https://lore.kernel.org/linux-fsdevel/20241007184258.2837492-1-joannelkoo=
ng@gmail.com/
> Changes from v7 -> v8:
> * Use existing lists for checking expirations (Miklos)
>
> v6:
> https://lore.kernel.org/linux-fsdevel/20240830162649.3849586-1-joannelkoo=
ng@gmail.com/
> Changes from v6 -> v7:
> - Make timer per-connection instead of per-request (Miklos)
> - Make default granularity of time minutes instead of seconds
> - Removed the reviewed-bys since the interface of this has changed (now
>   minutes, instead of seconds)
>
> v5:
> https://lore.kernel.org/linux-fsdevel/20240826203234.4079338-1-joannelkoo=
ng@gmail.com/
> Changes from v5 -> v6:
> - Gate sysctl.o behind CONFIG_SYSCTL in makefile (kernel test robot)
> - Reword/clarify last sentence in cover letter (Miklos)
>
> v4:
> https://lore.kernel.org/linux-fsdevel/20240813232241.2369855-1-joannelkoo=
ng@gmail.com/
> Changes from v4 -> v5:
> - Change timeout behavior from aborting request to aborting connection
>   (Miklos)
> - Clarify wording for sysctl documentation (Jingbo)
>
> v3:
> https://lore.kernel.org/linux-fsdevel/20240808190110.3188039-1-joannelkoo=
ng@gmail.com/
> Changes from v3 -> v4:
> - Fix wording on some comments to make it more clear
> - Use simpler logic for timer (eg remove extra if checks, use mod timer A=
PI)
>   (Josef)
> - Sanity-check should be on FR_FINISHING not FR_FINISHED (Jingbo)
> - Fix comment for "processing queue", add req->fpq =3D NULL safeguard  (B=
ernd)
>
> v2:
> https://lore.kernel.org/linux-fsdevel/20240730002348.3431931-1-joannelkoo=
ng@gmail.com/
> Changes from v2 -> v3:
> - Disarm / rearm timer in dev_do_read to handle race conditions (Bernrd)
> - Disarm timer in error handling for fatal interrupt (Yafang)
> - Clean up do_fuse_request_end (Jingbo)
> - Add timer for notify retrieve requests
> - Fix kernel test robot errors for #define no-op functions
>
> v1:
> https://lore.kernel.org/linux-fsdevel/20240717213458.1613347-1-joannelkoo=
ng@gmail.com/
> Changes from v1 -> v2:
> - Add timeout for background requests
> - Handle resend race condition
> - Add sysctls
>
> Joanne Koong (3):
>   fs_parser: add fsparam_u16 helper
>   fuse: add optional kernel-enforced timeout for requests
>   fuse: add default_request_timeout and max_request_timeout sysctls
>
>  Documentation/admin-guide/sysctl/fs.rst | 27 +++++++++
>  fs/fs_parser.c                          | 14 +++++
>  fs/fuse/dev.c                           | 80 +++++++++++++++++++++++++
>  fs/fuse/fuse_i.h                        | 31 ++++++++++
>  fs/fuse/inode.c                         | 33 ++++++++++
>  fs/fuse/sysctl.c                        | 20 +++++++
>  include/linux/fs_parser.h               |  9 ++-
>  7 files changed, 211 insertions(+), 3 deletions(-)
>

Just checking in on this patchset - any comments or thoughts?


Thanks,
Joanne
> --
> 2.43.5
>

