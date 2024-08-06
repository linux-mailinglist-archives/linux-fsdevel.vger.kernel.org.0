Return-Path: <linux-fsdevel+bounces-25058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296D89486FB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 03:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746D0283D43
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 01:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6FF8F77;
	Tue,  6 Aug 2024 01:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgCRItyh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1A464A
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 01:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722907584; cv=none; b=bym15sjkF9e4hQXQ3MVOCB+IvhLmTGZqvyNbUvl3NBi4BqPHwx7YwZn1rjMFCg2F0jrFMllEE/Rs8kr1AZOl1eN8gmmXgVUk3AEvVtz8cWzNQxuVEejMJDq88sPhQR2FT0N/WqCEFRtP9y/npAQGJilkwdqbXQmOkdABLj25MZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722907584; c=relaxed/simple;
	bh=ZGjyY1DXPLXO1lIjDqUkjSCiv9VjV3YLcssMQ2BdTHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOQC1JxhRQbJ120KKag74/c+fViW/zamOhsgg3hcyJ4wOdxxMkRBY/ANPU/RCFq9Ng8NfGMcxAlTsBREL0fPkE/Jh4cQPvKsrsyLIzPXhZ86GSVSVu5jRLEP8rYmEidfQ6cEyznz7j1HYL50ZL8BOcWBwYdP0RrBoSySAVNCup8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgCRItyh; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7093efbade6so148710a34.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2024 18:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722907582; x=1723512382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkL3R2kTrZ2ywnkKS+E17R5cI0QCYNnlNJdNt9R+4hE=;
        b=MgCRItyhlWEqSEdNH1uINdss4SYm/TR05DNSHvfApM4N9LuItdND3Ba5gbmhcsIl78
         QfnoCmMRUQ7IQRgVCSoT0BeTTk9tP6P//zHVKUChhGhbvZmqw73xGMK91+eb0yRqvQ7b
         TiNAGj0vXxnW+wX8HODBZ1hJBEWVqS0rYvyEaftg7RMXBCiYILIkOQh+U5aZpSwWddXL
         /pWh14/lzBVjHIXraKg/vlDycGkk0LW6tdeOQdE0OAPjX9zTynmEND9mlQddlWvM/zbK
         vKrfUehaij3Oo+l4ibykLuHuw3htGlvwyMPRnnR0kZxDAduchF19Hj7+SLOny/GnH1CK
         Mstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722907582; x=1723512382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkL3R2kTrZ2ywnkKS+E17R5cI0QCYNnlNJdNt9R+4hE=;
        b=LFKWwXES/ThmF8CTHeaeA1RTTqK6kpga6paoESPVVwGmB0R7/f3srQJG28ug7ISMmX
         KrSUYMSfsmlqOI3hhjhGnNSP/Fhc1HLbmqnTG7SUvQ8LUwQD/ljGRwM0XuWKBy9APq0e
         7SxyIxmEeeSDgwG9t/rE0oXcf8t8j7O1H0RTbFVHEqIq2PcNDN6inCqCLk75FYe6N+Ik
         fPf6ZOnfeOj2WhsucYNpnTCy4RJHzeP2nCGLXdIQjKYz7KGOWHUs7lTQreNTfaNrbIJB
         cEG0LI9yFbpW0w2Fw/e+2mleg3uy36Dh/5Kz7Eppk5NDCMHuQJVmu/D1mswYySwFlscI
         cvYA==
X-Forwarded-Encrypted: i=1; AJvYcCWRm/olfLEcU7Rlhm6r9QGCUtG5s1s+LLJLIHi4DQX1eM0ypOHRvs2QfuZauaMZEPfj4uqpXnR01j2znkqB8PJeRamUM/s2qJDlxcDG5A==
X-Gm-Message-State: AOJu0Yx+p93na7DlKzNB0ZW3xV+6amQvn+wQll72TpYmiJK/tk1e0z4e
	jCX5BZRBW0P1VC2ji2WNbXFDuw8ub4HhJmlVltSxiAFM42TQkxUq3EPA/BUpilGgnvSFNhgWnKm
	jBZeBBg51CsAtqzKNIBTO+i3it/jy8h2GrWQ=
X-Google-Smtp-Source: AGHT+IEF8PIG8oe/7OPE1gGlHoUHBSaomQFDX0zmedpUC3/fUzgLUNnnp4mSmrLCm7EkgpEUZQidbMk3S3JHrGofdyc=
X-Received: by 2002:a05:6830:698e:b0:709:419f:2ae7 with SMTP id
 46e09a7af769-709b9976561mr14563456a34.29.1722907582215; Mon, 05 Aug 2024
 18:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730002348.3431931-1-joannelkoong@gmail.com>
 <20240730002348.3431931-3-joannelkoong@gmail.com> <755d1d59-09e8-40f0-a802-607d3404d853@linux.alibaba.com>
In-Reply-To: <755d1d59-09e8-40f0-a802-607d3404d853@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 5 Aug 2024 18:26:11 -0700
Message-ID: <CAJnrk1azvLYpOX+968FXbyp6S2OPEvh_rMQpN_8sScS7p8QnxQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, laoar.shao@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 12:38=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
>
>
> On 7/30/24 8:23 AM, Joanne Koong wrote:
> > Introduce two new sysctls, "default_request_timeout" and
> > "max_request_timeout". These control timeouts on replies by the
> > server to kernel-issued fuse requests.
> >
> > "default_request_timeout" sets a timeout if no timeout is specified by
> > the fuse server on mount. 0 (default) indicates no timeout should be en=
forced.
> >
> > "max_request_timeout" sets a maximum timeout for fuse requests. If the
> > fuse server attempts to set a timeout greater than max_request_timeout,
> > the system will default to max_request_timeout. Similarly, if the max
> > default timeout is greater than the max request timeout, the system wil=
l
> > default to the max request timeout. 0 (default) indicates no timeout sh=
ould
> > be enforced.
> >
> > $ sysctl -a | grep fuse
> > fs.fuse.default_request_timeout =3D 0
> > fs.fuse.max_request_timeout =3D 0
> >
> > $ echo 0x100000000 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> > tee: /proc/sys/fs/fuse/default_request_timeout: Invalid argument
> >
> > $ echo 0xFFFFFFFF | sudo tee /proc/sys/fs/fuse/default_request_timeout
> > 0xFFFFFFFF
> >
> > $ sysctl -a | grep fuse
> > fs.fuse.default_request_timeout =3D 4294967295
> > fs.fuse.max_request_timeout =3D 0
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>
> Why do we introduce a new sysfs knob for fuse instead of putting it
> under fusectl?  Though we also encounter some issues with fusectl since
> fusectl doesn't work well in container scenarios as it doesn't support
> FS_USERNS_MOUNT.
>

I think having these constraints configured via sysctl offers more
flexibility (eg if we want to enforce the max or default request
timeout across the board for all incoming connections on the system),
whereas I believe fusectl is on a per-connection basis.

>
> --
> Thanks,
> Jingbo

