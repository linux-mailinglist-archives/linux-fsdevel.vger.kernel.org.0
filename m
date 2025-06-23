Return-Path: <linux-fsdevel+bounces-52605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C89F0AE47BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 17:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A483B01D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D79026B2D2;
	Mon, 23 Jun 2025 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ez0PILI9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344DB1A4F12
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690607; cv=none; b=XbIp9lBviopJvMNCRMlKZjcUgXNqhvAE6SzXwKww77ymEXTgnV+SZztpJwnSh6YnC6LQ2cjMmetex3SxExlkgBHxv+XIvlLhe5wdBxbudGAw884EWwEiap8+q6om61H4w7vnWlkIMH1Wb0xIj5h6j52XM372dWHZ6QYHwgHMjyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690607; c=relaxed/simple;
	bh=PTheay7cqvAMWhBs58Vb6OQ7Z7KjQixzFF93fRAnSyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZAOjGuOTkf9umv7g2BT8uFjoaiYg/UvkBSyBE1Ma0UbXVOn5cyqNKKRCkLnsr6geR4vSU+BaA5fQLvONL8dy18FB/iDn81ETN3ue6zSkloDlyV4+VN7A48HSFpwTeJZ/JXcXbFv5WhfrPuH/1T844YBkgcBsNdXyFYsseZFzqT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ez0PILI9; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-312e747d2d8so3399399a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 07:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750690605; x=1751295405; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KTLGxkEd9m/ohum4J2ofOjH/RIT6fhplw5eh9xDXXuk=;
        b=ez0PILI9CNymRn4QzGP2QYjt5gOfQMcC59LjoAQT0xVrW9jQW9e2wPHHZyMmR8OSF3
         CHskm89vr8TUwn+gWKSxmGGG/yLy9pp/MoIyz/C5FXuQQze1N0SQ3fCUgFWeguia9rz/
         a9H2HIP+7SbYRxk/8XYL2oyHTwt2biBDEWYEYSW/65shY4z/sH+wjWJjWDuNs8rZJxDb
         2hDEAJ0xQoUXSzMQhVcQp4Ib8/wkRT3XClazM8xikXPlnWRi2UbvASOLnILitn689rFa
         BJKov3fTJ1htA+Vmnt1uEZEN5R6T182/LZdWbuoVeBRrsM6beOoEEuw/rhmF3TNz+Gj5
         Xc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750690605; x=1751295405;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTLGxkEd9m/ohum4J2ofOjH/RIT6fhplw5eh9xDXXuk=;
        b=dViEgtbrn36JxOtLhjE75AApza7ip8r6torpE9CvWaaCFq8napS41BtE+oULEkaj4o
         xvd/JExfjWe8Y/W77JnCFODjNZ4orph1f8GFguBmn/by0EHNSqT7eBAW7qvioqT8tZNo
         aDVhEEx/HPh61AYGv11GXgQCKZXOZMquyPmj/TZkCiRLn9iJ+omujocmfFts0OgcRmMB
         ZF3Y685GHp8y8dDGn1A/qzfHFyDeMqOJHM9KIYvICsegmcBRt/E1abvwF1c8AviZhZNa
         vaFxtX6h7VHeTVZc50HPJgznkWEAuAYJiAVM2GrN9GPpZ4MxbR+WbWB2mbx1BmbCSZe6
         yIDA==
X-Forwarded-Encrypted: i=1; AJvYcCXWU1XuTYQwziK0tfh7sxDQHb07sR5/oz7b8PlgTwg0xN6Rq90zkMGG9m/IPCK5F1Bxth4uG4iXs89D+kUQ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa84N/i58E80Xs6CZqXyxxGXzmtr/NQDwKnmQ4C1zNIvp6FCfY
	sGPGvGzmWqn8yCXpj5ZeRBLu0cBMxg2v5yHlNpt8GuRUA38q7qvDZg1OZkl/MPOApYKbUWPm/aW
	/sEpTBncKBVk/yB6qVUyBW/jD3xyMIre6TVV6kKnccKw6dTIFGsMm8/w=
X-Gm-Gg: ASbGncsp1XSr5Yk9dqP2Q/3bwg5Oy8VzMvqJ4oHaW6eb6JbiOt3agTsywI6dCm5TaGK
	JBLfrlqqBrvFwG8lWdw21FwEnYgrjgiTWPP/Zyf6JWrlcCLLIJb0fAzHSlvEhITIGDEZzD6qO/J
	1/S/J9TUG6cfyC/DONqAWGisgpy+a9Aj8D9PKB0tm8IM9uwK0cmXaksZeLhPU77SoGWl38AVfiC
	bAg
X-Google-Smtp-Source: AGHT+IGN6hc0miGmfJoHfDU2FV0k8m6pfGQp/A0ZiCKWE/+McAFvqhxhob22QI70xmwcMwgDJ9SU8M+KsoVRIAs1OaU=
X-Received: by 2002:a17:90b:2e51:b0:313:f995:91cc with SMTP id
 98e67ed59e1d1-3159f44ecf0mr17824061a91.2.1750690605304; Mon, 23 Jun 2025
 07:56:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYt0MfXMEKqHKHrdfqg3Q5NgQsuG1f+cXRt83d7AscX5Fw@mail.gmail.com>
 <20250623-salat-kilowatt-3368c5e29631@brauner>
In-Reply-To: <20250623-salat-kilowatt-3368c5e29631@brauner>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 23 Jun 2025 20:26:32 +0530
X-Gm-Features: Ac12FXyxH7JtOsEuDOUVutNxwzlGKjtIs9Inv83qyi2-2ZPb1hg6eu6Cm1sN6DE
Message-ID: <CA+G9fYsfOg9uiwgYA1mHkBzwEkU6eLweneWJhFybt+X1Ekp55Q@mail.gmail.com>
Subject: Re: next-20250623: arm64 devices kernel panic Internal error Oops at
 pidfs_free_pid (fs/pidfs.c:162)
To: Christian Brauner <brauner@kernel.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Jeff Layton <jlayton@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Jun 2025 at 18:26, Christian Brauner <brauner@kernel.org> wrote:
>
> On Mon, Jun 23, 2025 at 05:29:38PM +0530, Naresh Kamboju wrote:
> > Regressions on arm64 devices and qemu-arm64 while running LTP controllers
> > and selftests cgroup test cases the following kernel Panic Internal error oops
> > found on the Linux next-20250623 tag.
> >
> > Regressions found on arm64 device
> >   - Kernel Panic Internal oops @ LTP controllers
> >   - Kernel Panic Internal oops @ selftest cgroups
> >
> > Test environments:
> >  - Dragonboard-410c
> >  - e850-96
> >  - FVP
> >  - Juno-r2
> >  - rk3399-rock-pi-4b
> >  - qemu-arm64
> >
> > Regression Analysis:
> >  - New regression? Yes
> >  - Reproducibility? Yes
> >
> > Boot regression: arm64 devices kernel panic Internal error Oops at
> > pidfs_free_pid (fs/pidfs.c:162)
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > ## Test log
> > [   67.087303] Internal error: Oops: 0000000096000004 [#1]  SMP
> > [   67.094021] Modules linked in: snd_soc_hdmi_codec venus_enc
> > venus_dec videobuf2_dma_contig pm8916_wdt qcom_wcnss_pil
> > coresight_cpu_debug coresight_tmc coresight_replicator qcom_camss
> > coresight_stm snd_soc_lpass_apq8016 msm qrtr coresight_funnel
> > snd_soc_msm8916_digital snd_soc_lpass_cpu coresight_tpiu
> > snd_soc_msm8916_analog videobuf2_dma_sg stm_core coresight_cti
> > snd_soc_lpass_platform snd_soc_apq8016_sbc venus_core
> > snd_soc_qcom_common qcom_q6v5_mss v4l2_fwnode coresight snd_soc_core
> > qcom_pil_info v4l2_async snd_compress llcc_qcom snd_pcm_dmaengine
> > ocmem qcom_q6v5 v4l2_mem2mem videobuf2_memops snd_pcm qcom_sysmon
> > drm_exec adv7511 snd_timer videobuf2_v4l2 gpu_sched qcom_common snd
> > videodev drm_dp_aux_bus qcom_glink_smem soundcore qcom_spmi_vadc
> > mdt_loader drm_display_helper qnoc_msm8916 qmi_helpers
> > videobuf2_common qcom_vadc_common qcom_spmi_temp_alarm rtc_pm8xxx
> > qcom_pon qcom_stats mc cec drm_client_lib qcom_rng rpmsg_ctrl
> > display_connector rpmsg_char phy_qcom_usb_hs socinfo drm_kms_helper
> > rmtfs_mem ramoops
> > [   67.094437]  reed_solomon fuse drm backlight ip_tables x_tables
> > [   67.189084] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted
> > 6.16.0-rc3-next-20250623 #1 PREEMPT
> > [   67.194810] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> > [   67.234078] pc : pidfs_free_pid (fs/pidfs.c:162)
>
> Thanks, I see the issue. I'm pushing out a fix. Please let me know if
> that reproduces in the next few days.

Thanks. Please share the proposed fix patches.
I would like to build and test in LKFT test framework.

- Naresh

