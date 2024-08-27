Return-Path: <linux-fsdevel+bounces-27418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AE3961560
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 19:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93525282006
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 17:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066471CDFC3;
	Tue, 27 Aug 2024 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cf/NoVE/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2FA1925AC
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724779512; cv=none; b=sVa5nh/1yuISGu19QsF7Jkkqg1YpDQd9sqGKodyKSwXHNME2bR8IN5cOEXOgJSXJxq0k4Ak8b2pWq9PU8ZT48VleRUPgzY7+D4YSOD3eVBiT5B/tTSnHwQGWzkCsN6nXmymnqYi+bVUW1LWTi1fVsoHWrpWfoR/+mACs8i6v99I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724779512; c=relaxed/simple;
	bh=vCfxOC2ainczcuPuyGtGUEZqc3Bg8NThE+Bc1xKjfPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1WzsZe6HpYX2q2gipCIX9OJZupW4RSdtRv8BDLD5zmUpTGIuyhCJkAumQO+FMi3cj3RWs6AblZT5rf1RJubQV+WlluZ6/BkIa4JqP7ad3I1o9vQheKTyO7XJAuO5Gu0Z34c9Ia9R3hqKFjo+7tvNaNrA0wp40k0qHZZsTq0hfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cf/NoVE/; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44ff6f3c427so30525181cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 10:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724779510; x=1725384310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUCMUXebVhFk4jscCAXgGDK2hFv0VKq2xHJV+fi/Fq8=;
        b=cf/NoVE/2fGcDZ1swFpipGAPpwajK3Lpeh716/wCBpPSHBhtu5EdRDoIUQCHsoT1kQ
         BZlcW9McrKAYLd1+FbDSSlM+Od2DS0AC0kG48shRwBRO6c+DgCiG4hUlcaKIc+SZumU8
         jtLHRWqDMl2bLDfZFGvjqgX+IrQ791NKWaBRDii+pUSOKiYc5trN1SeHyAc4k+MAII2g
         hUSLh9qgtAXhnWXVQU4psGqIEhOIl/VRXdTMxDcsUthdbrsr292XjYw7xsNB9/F26zkw
         RpvmLAthWGYSRcrpktEEyh3nSlGh/LWYxbs+8FFwP5BrPK4sLjONu9XrNV6Y4fNEmDXm
         ZKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724779510; x=1725384310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUCMUXebVhFk4jscCAXgGDK2hFv0VKq2xHJV+fi/Fq8=;
        b=X1CGlHt6JlbfW5OqwASQtW1NXSGuiyACzsoX+U+30sa5Ue3uXU0OiDkn3wNOn+Ds6r
         u6lczXaU13Sm7XnhPrsdWO0G+oxy/gV9CuQTSMq7acgVbsGCL2LWQx4yagZ+BIy4xZIy
         1l55k9zW1jRtnpRhlO1f+eLDJPXcNbO8F2ZvWLySyk9u0UwZ/baZMk9Z4EuMveYCvMwD
         g6ER2ioyQqoim8eNC4WlHLm6XLaZNaIaZLjpc86uGd5YsqiCy4gaKNTWdewpj/bc+IZY
         ZAtKzrD5Qd71HZ1secrxFYcSvyTK6XIqv3vP4tHrEbic/85VnkDjXp8xKO8wuvhXBxlU
         fpEA==
X-Gm-Message-State: AOJu0Ywad5Fj2ipAmHHQy1cvV2Ykn9JQzK4/LNRt9snkErzgHgkDDg67
	B5cG/C9iklVOQH9XSoy0bbibidDLKOAhMfujcSQIeVWAq8GUarivcYcynRBAfxfpwZO/ghbtMV/
	YCsU4Np8C87k+VTXNqDqXAjrvRT8=
X-Google-Smtp-Source: AGHT+IFrpUoBsvj/BuB0m9mdx3b8Z80YRjQw0rVFWuQHPUHsNVav9CmAvoeF3YqHEcFtBKAKAtPV7E7ispeQ+5BU5Gg=
X-Received: by 2002:a05:622a:400f:b0:455:9db:777b with SMTP id
 d75a77b69052e-456606794cemr45462751cf.0.1724779509717; Tue, 27 Aug 2024
 10:25:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826203234.4079338-1-joannelkoong@gmail.com> <CAJfpegud2cp6EoGa+Q5og3rEXKf8Ds32wXeReUMMktjDJvtMmQ@mail.gmail.com>
In-Reply-To: <CAJfpegud2cp6EoGa+Q5og3rEXKf8Ds32wXeReUMMktjDJvtMmQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 27 Aug 2024 10:24:58 -0700
Message-ID: <CAJnrk1ZvSAgLhC1NYwt-yHhHAiTCFQPk3rgVZFp6dpvR4GMBYw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] fuse: add timeout option for requests
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 11:49=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Mon, 26 Aug 2024 at 22:33, Joanne Koong <joannelkoong@gmail.com> wrote=
:
> >
> > There are situations where fuse servers can become unresponsive or
> > stuck, for example if the server is in a deadlock. Currently, there's
> > no good way to detect if a server is stuck and needs to be killed
> > manually.
> >
> > This patchset adds a timeout option for requests where if the server do=
es not
> > reply to the request by the time the timeout elapses, the connection wi=
ll be
> > aborted. This patchset also adds two dynamically configurable fuse sysc=
tls
> > "default_request_timeout" and "max_request_timeout" for controlling/enf=
orcing
> > timeout behavior system-wide.
> >
> > Existing fuse servers will not be affected unless they explicitly opt i=
nto the
> > timeout.
>
> This last paragraph seems to contradict the purpose of the system-wide
> maximum timeout.  If the server can opt out of timeouts, then
> enforcing a maximum timeout is pointless.
>
> Am I missing something?

Ah by that last paragraph, my intention was to convey that for
existing systems that run fuse servers, pre-existing behavior will
stay as is and they don't have to worry about any functional changes
from this patchset if they don't explicitly opt into it. I'll change
this wording to "Existing systems running fuse servers will not be
affected unless they explicitly opt into the timeout".


Thanks,
Joanne
>
> Thanks,
> Miklos

