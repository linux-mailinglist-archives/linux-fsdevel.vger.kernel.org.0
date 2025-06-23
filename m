Return-Path: <linux-fsdevel+bounces-52562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 067FCAE4160
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5573A3746
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AF724C68D;
	Mon, 23 Jun 2025 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIe5k82e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320C0248F63;
	Mon, 23 Jun 2025 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750683395; cv=none; b=rrW//STmZrwNX4KgMLM8oTs+sRVCEqzVGII2f3RvAxsLfqyqaEiFSRQwD6aROyl2VnIvzkawskg4aN6YFx6GEb7N7lPyeJHvOTT+PaXIZk7Vb9qs0/FZEFJppap3m715eHTKeR4ZAhHCwaWuQBwEHoGUDVhX0ULpFsZakNE3PEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750683395; c=relaxed/simple;
	bh=/Ru9AP2QGbA67LIOI47cR1sT7LARCHOvoI+J1683xFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTcnD81LR5jeWtuCo6TDqlnhrUTSYIAuWeDYAH1ZaSlmn8ZqCl3GfAprH10ETxEfLxTU89wm/2RCjH5Eyg2Jz16aDUEGVAByRM/sLNGJ/2ZmES0gU8iInw23bbsOYXgGq5nwo8vaf6fQSQmZUaMCk6seWdpm+mPjfwDflB3sOaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIe5k82e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BD8C4CEEA;
	Mon, 23 Jun 2025 12:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750683394;
	bh=/Ru9AP2QGbA67LIOI47cR1sT7LARCHOvoI+J1683xFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oIe5k82e1gXkUxRcP5vq15pTzRC8oSL8F1QZIZfAffKflmpHK5GKO5TxIz3Ye6p29
	 Klz/FHt2tyxSmLlxQRa4H4Xeg4+CEKxJERBrUNXsLjuu4CTMOdbl7u1lYY3A7d72RW
	 EXuM3kuUxcW4C5hJ91Yao1xaTeW4Go4ov4umKihyVUQ5AH5ZidxppOrocc1uofjvnz
	 3paZ/GqgH72ywIPlJLkLqw8kgC0WUIXBo3F6FF9Z7VgKU/o42jaoZyJT7KySqZSi8o
	 R0w5KO7kHwibgOh3GqwyFIHE/lEWvBY3VJ1mVjECiuztSo6l9G/opO5OQjo630JoEj
	 1PAKIuqt1oPtw==
Date: Mon, 23 Jun 2025 14:56:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Subject: Re: next-20250623: arm64 devices kernel panic Internal error Oops at
 pidfs_free_pid (fs/pidfs.c:162)
Message-ID: <20250623-salat-kilowatt-3368c5e29631@brauner>
References: <CA+G9fYt0MfXMEKqHKHrdfqg3Q5NgQsuG1f+cXRt83d7AscX5Fw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+G9fYt0MfXMEKqHKHrdfqg3Q5NgQsuG1f+cXRt83d7AscX5Fw@mail.gmail.com>

On Mon, Jun 23, 2025 at 05:29:38PM +0530, Naresh Kamboju wrote:
> Regressions on arm64 devices and qemu-arm64 while running LTP controllers
> and selftests cgroup test cases the following kernel Panic Internal error oops
> found on the Linux next-20250623 tag.
> 
> Regressions found on arm64 device
>   - Kernel Panic Internal oops @ LTP controllers
>   - Kernel Panic Internal oops @ selftest cgroups
> 
> Test environments:
>  - Dragonboard-410c
>  - e850-96
>  - FVP
>  - Juno-r2
>  - rk3399-rock-pi-4b
>  - qemu-arm64
> 
> Regression Analysis:
>  - New regression? Yes
>  - Reproducibility? Yes
> 
> Boot regression: arm64 devices kernel panic Internal error Oops at
> pidfs_free_pid (fs/pidfs.c:162)
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ## Test log
> [   67.087303] Internal error: Oops: 0000000096000004 [#1]  SMP
> [   67.094021] Modules linked in: snd_soc_hdmi_codec venus_enc
> venus_dec videobuf2_dma_contig pm8916_wdt qcom_wcnss_pil
> coresight_cpu_debug coresight_tmc coresight_replicator qcom_camss
> coresight_stm snd_soc_lpass_apq8016 msm qrtr coresight_funnel
> snd_soc_msm8916_digital snd_soc_lpass_cpu coresight_tpiu
> snd_soc_msm8916_analog videobuf2_dma_sg stm_core coresight_cti
> snd_soc_lpass_platform snd_soc_apq8016_sbc venus_core
> snd_soc_qcom_common qcom_q6v5_mss v4l2_fwnode coresight snd_soc_core
> qcom_pil_info v4l2_async snd_compress llcc_qcom snd_pcm_dmaengine
> ocmem qcom_q6v5 v4l2_mem2mem videobuf2_memops snd_pcm qcom_sysmon
> drm_exec adv7511 snd_timer videobuf2_v4l2 gpu_sched qcom_common snd
> videodev drm_dp_aux_bus qcom_glink_smem soundcore qcom_spmi_vadc
> mdt_loader drm_display_helper qnoc_msm8916 qmi_helpers
> videobuf2_common qcom_vadc_common qcom_spmi_temp_alarm rtc_pm8xxx
> qcom_pon qcom_stats mc cec drm_client_lib qcom_rng rpmsg_ctrl
> display_connector rpmsg_char phy_qcom_usb_hs socinfo drm_kms_helper
> rmtfs_mem ramoops
> [   67.094437]  reed_solomon fuse drm backlight ip_tables x_tables
> [   67.189084] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted
> 6.16.0-rc3-next-20250623 #1 PREEMPT
> [   67.194810] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> [   67.234078] pc : pidfs_free_pid (fs/pidfs.c:162)

Thanks, I see the issue. I'm pushing out a fix. Please let me know if
that reproduces in the next few days.

