Return-Path: <linux-fsdevel+bounces-13255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F2B86DE83
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 10:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7447E1F25F5A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 09:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4DE6A8B5;
	Fri,  1 Mar 2024 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="TWnH0C6x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BAA69312
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709286209; cv=none; b=dWTYZamRcOAwjNDBE6KlTyHuH7wLJM3DlPSQE/hmXHRyqRYuJRot7Xf3RUOtu6S1yQsKf/hqhc2vUgsAoubHCuDU2hTRE7LAnZm5/AndTZDqhbNd5ws+21MYEn7ZCeQvBJ6GFuwrIZY+7vVFW298rUgtRotzPH6Nl+CpY3OmXxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709286209; c=relaxed/simple;
	bh=jvNtlkMKRXojd6LCKL0lNfi7cvfSgs2JDbl+z9B/20c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQew2kZnle6ivQNLgBSy5T9MoucH4L5tXzZJZ4B7+dB5WR6/3cEoSAP4zyriOE1pi74CWhfO/gp2W7LzzJMe/wVJtlTL7xhB/hYRi2XtLsxx8mo+3DdwDYeNWZhV0zBEqjcXqGlZEpdZ8YEMYr2JSQzXGZmxSeL7emefoWWo9Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=TWnH0C6x; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a36126ee41eso306896766b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Mar 2024 01:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709286204; x=1709891004; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aXxGYrYcCUx0cEDq525FO3LAoTjys9Goe54VhnMRH4o=;
        b=TWnH0C6xvoCY3P7Fu0m3LBLc5n1t9MHMpqypok8nBlSrnWyT78TWV+OxwLBz5H0PZ3
         cYlV6tpvq0Uv1DF32XgUTC2mzKpkHL2NnUWY93PqS/5C6t1sxK0mTxuaxEiyxpOS48vm
         0GxdvyzmYsby5tPcCGFWwgTQ118wRAcRDAfG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709286204; x=1709891004;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXxGYrYcCUx0cEDq525FO3LAoTjys9Goe54VhnMRH4o=;
        b=ffruTxOHurEY15iRy5B3GP+lf2JqgbJH5iEIIpnlRWfYt6WHBcQ6+FtWM9xWo/GNGt
         zbL/bdcXg5A+UbB0pluEpbhX2kyPTF0a2hAtLps066YxM5Di+lA7hn3VueiUQ9HI3RUP
         TqlVnXVyALPsQ4oA9/k7AfRgTaPOFEamGhN5MNt9lm6oesO2nSSZY/b4WZs5k6cWNDTP
         d7CMHPCnSnHx+D2DCboWJX2IGP05mWmj/OEDHrjmwovS9D0l3rwXI/67ZrUJFs1uPTk4
         p3uN3BIdDcIqyw9JlGZwyQaTLU3i42jw0Cys7pGwqPrht3YyNisyW7fjqnRUbQ98MAtT
         Ek/g==
X-Forwarded-Encrypted: i=1; AJvYcCUaDf2h4shrdiiV6kwR93QMCuVmoodZBTKMj7SOwFfdpmHMT3GBBPNJw5KxjMGTyw9imZ3Oyf+8pygmsVBuJXyJgoEPvdt9tGMNkagT/w==
X-Gm-Message-State: AOJu0Yx75RniQH1q6WfKnZ+0dun3c2s1ABFDav5wwjB150m2TWwCQrx0
	HefdfDSzvm0gi1ykeMxWWEZ70PH6C7C06vlK4k8Fnzl8g2UeXZEPUN6y8ILY5qHPM8y1loryraV
	yoqFWrDxoC6NfAC1MyvhEm/sDladBdkG1d0yQ1g==
X-Google-Smtp-Source: AGHT+IGA4N9J8aSMFiKMSMz6o9VdxtEjDJ+XxlWQrpec6ty87BS9ypPZN3DOcRTrWWpcdacMYgAXY1rQhl4VrGgeaUA=
X-Received: by 2002:a17:906:5a9a:b0:a43:ffe3:70a with SMTP id
 l26-20020a1709065a9a00b00a43ffe3070amr865124ejq.9.1709286203895; Fri, 01 Mar
 2024 01:43:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115071505.43917-1-lirongqing@baidu.com> <20240115182944.GA1143584@fedora>
In-Reply-To: <20240115182944.GA1143584@fedora>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 1 Mar 2024 10:43:12 +0100
Message-ID: <CAJfpegtbDamxV2DMEPcjb5qS-tmG8obe8rziO4hDWYvKYYuDRA@mail.gmail.com>
Subject: Re: [PATCH] virtio_fs: remove duplicate check if queue is broken
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Li RongQing <lirongqing@baidu.com>, vgoyal@redhat.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jan 2024 at 19:29, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Mon, Jan 15, 2024 at 03:15:05PM +0800, Li RongQing wrote:
> > virtqueue_enable_cb() will call virtqueue_poll() which will check if
> > queue is broken at beginning, so remove the virtqueue_is_broken() call
> >
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > ---
> >  fs/fuse/virtio_fs.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Applied, thanks.

Miklos

