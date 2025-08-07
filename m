Return-Path: <linux-fsdevel+bounces-56971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C7CB1D681
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 13:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F767721961
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 11:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B6F278161;
	Thu,  7 Aug 2025 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jcZ03XH6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9AA221FD2
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754565626; cv=none; b=ksAknMrX0+pOArpV/0rb0WBcYXwY0BAQH4zyHW0DFjAySVPRC3zxsdw1t6d3LqMr0wrsDQ/lGYkhSuJtJSUpaS5jO2PCEmp9SUWhUzIhCTwWBmSBCoijHzR0a+wA9aSib7UjgGD88R28n9QcNKWoRSCUG9RyFCxfphIEBgloGsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754565626; c=relaxed/simple;
	bh=bT199VEQVqscKcI1ySGvbrsT+zAn6cUa1qjcLrPjd5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJMLC5RW46irknJJP52xedj+1VUDSg+Kgxp7EcYQzaAnK+SSXH5i4DuggLixA94EOdDTni2lyEHvkotdORaQY/J3NGxr1sJl7Vd//kTi6x/bFaQkqNnL5aMo6dZiXjjW1IXlIyM9u5XCmHRjlOUuN3QU2rJxpQwanXRGNd7zvsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jcZ03XH6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-459d4d7c745so8442825e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Aug 2025 04:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754565623; x=1755170423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t+xe2dZhSU0YB/2XKMOmDkqHorIZkYeC9Ed4u60MW1U=;
        b=jcZ03XH6iuRL3ExacLRh3+izApPk6khtidHPYAPhOnPQXGdT5Wtht9ZIFzJwWLakUW
         BDka++7AcfQklFD08BpxQD5LbO9w6OCzFLKG8vs2FNH3MgFNNLKV/WxyGk29X4R/28BZ
         iEDzpK+mag9ib/j/S5BHNboB+J1f2wHuX8/0vpiEHeAVwF6vi2T+8YMqi2VI/8z0Sv3g
         isPMMISWSreKCr0GYyCcs5AleXV5ZqqxzCzi+wkQ0oaC909ebpxvdZJg5PS644hL+xTn
         Zql4q+lZ/xeNvi9DTQm6unEQgIKMb9vSBEhslduDYX8jzFlRlD+jsrTgMaO2TEQpRhIJ
         +V2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754565623; x=1755170423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+xe2dZhSU0YB/2XKMOmDkqHorIZkYeC9Ed4u60MW1U=;
        b=NM9iUWcnNMsl41h7BIv7mtl/mfg7De2w9LFoqi+iggutmkN6QNLTL/ZVPxKzzuwLAi
         UfAgNcglGScqb9oJ9hpqTACKq6wHoi0AsP64Cc5sTZYBgZGxqUXL4UfmsCDwSejf5psQ
         FgjKPENo/43mHY2nuQI35kW3sSaTNO1kXayxkQarLpUO7rrI0L495vv8TbqjZTat7YdM
         qWRO5Owb2B8HLZebtMDtGV6bw2bphiKmlkm+hHDscJUlHR+7vmjs6uusZjG0/uWFsHUT
         TiqsP1WZ9dy3+EVu5cM4DwTRN3oqijvOiLdIkBAkTYUuPWaTj/rUNehZLS0Xd5YLprdc
         Lbig==
X-Forwarded-Encrypted: i=1; AJvYcCUCJkEmFcmw208aQY7ldFJvikh2hhh22e64jWIQAWyAjxjEcclSA/SwPI9du2pVn4ycMjd9pQrGZZChmC2m@vger.kernel.org
X-Gm-Message-State: AOJu0YyGqL6pJTLgdCL71gyDfcdeu2iB0Br0lc4pxhcDUjnIDx6FrrjH
	eWixjcKtovsalUxBCERHJGmfSUTYcwPH6h6SMDITSY37lIgvD1wDmV0K4MeoGt9JWpY=
X-Gm-Gg: ASbGnctGfFHsjWoRPJOtkRzAvuUYzMfYfTDt12R7Q3eSzLaBKwkGm6lXqpjIPKFGMKW
	2Hc00LhUSoqypY5Or9T3PIVjTxTK+ECjmhB1byCqIk7cYb0hOCB31A/cLWaYa/KEzvt5SvpTVj3
	oSZuEGoIiyECa/bwIl/NWdVQgx2J1WQ+zZUqCuiMGNfDk/6e/32P8Dk+jloGKV6jxvwFfePRfxt
	cjttCa9IRJPX3qU615fwHOlvAa470oeqtLZhSBOFbEWmjUkbAqNcHEgH24Uu4CGJDTou3SLJUH+
	WHpvsFjsMzG/0DF4jTf/T4cxlgCKjJeqoGs9+66OoHUoYQdZ7bU+8vD6xgLbpk2APBex09sr1A2
	POwJWwf+VPucebFvaVPPovyll8is=
X-Google-Smtp-Source: AGHT+IHle4/R1ej0UE31AopKf2sNC+DTWDiHvIqjOlfMPaSTgNALiUGVLhXkvILnmSQe+GoiHKqW1Q==
X-Received: by 2002:a05:600c:3b98:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-459f33960a5mr5645055e9.20.1754565622973;
        Thu, 07 Aug 2025 04:20:22 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e6214640sm88873865e9.1.2025.08.07.04.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 04:20:22 -0700 (PDT)
Date: Thu, 7 Aug 2025 14:20:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Renjiang Han <quic_renjiang@quicinc.com>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Cgroups <cgroups@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	linux-fsdevel@vger.kernel.org, Song Liu <song@kernel.org>,
	yukuai3@huawei.com, Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: next-20250804 Unable to handle kernel execute from
 non-executable memory at virtual address idem_hash
Message-ID: <66c0fb9f-c9fc-4186-9450-ecf726b6791f@suswa.mountain>
References: <CA+G9fYvZtbQLoS=GpaZ_uzm3YiZEQmz0oghnwVamNQ49CosT2w@mail.gmail.com>
 <aJNsreA4FuxalDc8@stanley.mountain>
 <CA+G9fYvEGBAAEetvvtXWsGb3EQ2sTOM=szkxZ4m-Gt2bTszBdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvEGBAAEetvvtXWsGb3EQ2sTOM=szkxZ4m-Gt2bTszBdQ@mail.gmail.com>

On Thu, Aug 07, 2025 at 02:51:29PM +0530, Naresh Kamboju wrote:
> Hi Dan,
> 
> On Wed, 6 Aug 2025 at 20:24, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > On Tue, Aug 05, 2025 at 12:50:28AM +0530, Naresh Kamboju wrote:
> > > While booting and testing selftest cgroups and filesystem testing on arm64
> > > dragonboard-410c the following kernel warnings / errors noticed and system
> > > halted and did not recover with selftests Kconfig enabled running the kernel
> > > Linux next tag next-20250804.
> > >
> > > Regression Analysis:
> > > - New regression? Yes
> > > - Reproducibility? Re-validation is in progress
> > >
> > > First seen on the next-20250804
> > > Good: next-20250801
> > > Bad: next-20250804
> > >
> > > Test regression: next-20250804 Unable to handle kernel execute from
> > > non-executable memory at virtual address idem_hash
> > > Test regression: next-20250804 refcount_t: addition on 0;
> > > use-after-free refcount_warn_saturate
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > ## Test crash log
> > > [    9.811341] Unable to handle kernel NULL pointer dereference at
> > > virtual address 000000000000002e
> > > [    9.811444] Mem abort info:
> > > [    9.821150]   ESR = 0x0000000096000004
> > > [    9.833499]   SET = 0, FnV = 0
> > > [    9.833566]   EA = 0, S1PTW = 0
> > > [    9.835511]   FSC = 0x04: level 0 translation fault
> > > [    9.838901] Data abort info:
> > > [    9.843788]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> > > [    9.846565]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > > [    9.851938]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > > [    9.853510] rtc-pm8xxx 200f000.spmi:pmic@0:rtc@6000: registered as rtc0
> > > [    9.856992] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000856f8000
> > > [    9.862446] rtc-pm8xxx 200f000.spmi:pmic@0:rtc@6000: setting system
> > > clock to 1970-01-01T00:00:31 UTC (31)
> > > [    9.868789] [000000000000002e] pgd=0000000000000000, p4d=0000000000000000
> > > [    9.875459] Internal error: Oops: 0000000096000004 [#1]  SMP
> > > [    9.889547] input: pm8941_pwrkey as
> > > /devices/platform/soc@0/200f000.spmi/spmi-0/0-00/200f000.spmi:pmic@0:pon@800/200f000.spmi:pmic@0:pon@800:pwrkey/input/input1
> > > [    9.891545] Modules linked in: qcom_spmi_temp_alarm rtc_pm8xxx
> > > qcom_pon(+) qcom_pil_info videobuf2_dma_sg ubwc_config qcom_q6v5
> > > venus_core(+) qcom_sysmon qcom_spmi_vadc v4l2_fwnode llcc_qcom
> > > v4l2_async qcom_vadc_common qcom_common ocmem v4l2_mem2mem drm_gpuvm
> > > videobuf2_memops qcom_glink_smem videobuf2_v4l2 drm_exec mdt_loader
> > > qmi_helpers gpu_sched drm_dp_aux_bus qnoc_msm8916 videodev
> > > drm_display_helper qcom_stats videobuf2_common cec qcom_rng
> > > drm_client_lib mc phy_qcom_usb_hs socinfo rpmsg_ctrl display_connector
> > > rpmsg_char ramoops rmtfs_mem reed_solomon drm_kms_helper fuse drm
> > > backlight
> > > [    9.912286] input: pm8941_resin as
> > > /devices/platform/soc@0/200f000.spmi/spmi-0/0-00/200f000.spmi:pmic@0:pon@800/200f000.spmi:pmic@0:pon@800:resin/input/input2
> > > [    9.941186] CPU: 2 UID: 0 PID: 221 Comm: (udev-worker) Not tainted
> > > 6.16.0-next-20250804 #1 PREEMPT
> > > [    9.941200] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> > > [    9.941206] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > [    9.941215] pc : dev_pm_opp_put (/builds/linux/drivers/opp/core.c:1685)
> > > [    9.941233] lr : core_clks_enable+0x54/0x148 venus_core
> > > [   10.004266] sp : ffff8000842b35f0
> > > [   10.004273] x29: ffff8000842b35f0 x28: ffff8000842b3ba0 x27: ffff0000047be938
> > > [   10.004289] x26: 0000000000000000 x25: 0000000000000000 x24: ffff80007b350ba0
> > > [   10.004303] x23: ffff00000ba380c8 x22: ffff00000ba38080 x21: 0000000000000000
> > > [   10.004316] x20: 0000000000000000 x19: ffffffffffffffee x18: 00000000ffffffff
> > > [   10.004330] x17: 0000000000000000 x16: 1fffe000017541a1 x15: ffff8000842b3560
> > > [   10.004344] x14: 0000000000000000 x13: 007473696c5f7974 x12: 696e696666615f65
> > > [   10.004358] x11: 00000000000000c0 x10: 0000000000000020 x9 : ffff80007b33f2bc
> > > [   10.004371] x8 : ffffffffffffffde x7 : ffff0000044a4800 x6 : 0000000000000000
> > > [   10.004384] x5 : 0000000000000002 x4 : 00000000c0000000 x3 : 0000000000000001
> > > [   10.004397] x2 : 0000000000000002 x1 : ffffffffffffffde x0 : ffffffffffffffee
> > > [   10.004412] Call trace:
> > > [   10.004417] dev_pm_opp_put (/builds/linux/drivers/opp/core.c:1685) (P)
> > > [   10.004435] core_clks_enable+0x54/0x148 venus_core
> > > [   10.004504] core_power_v1+0x78/0x90 venus_core
> > > [   10.004560] venus_runtime_resume+0x6c/0x98 venus_core
> > > [   10.004616] pm_generic_runtime_resume
> >
> > Could you try adding some error checking to core_clks_enable()?
> > Does the patch below help?
> 
> Your patch works.
> The attached patch from Sasha fixes this reported problem on today's
> Linux next tag.
> 
> $ git log --oneline next-20250805..next-20250807 --
> drivers/media/platform/qcom/venus/pm_helpers.c
> 7881cd6886a89 media: venus: Fix OPP table error handling
> 

I feel a bit bad about this, because I saw this bug as a static
checker warning:

drivers/media/platform/qcom/venus/pm_helpers.c:51 core_clks_enable() error: 'opp' dereferencing possible ERR_PTR()

But I figured that leaving out the error checking was probably
deliberate so I didn't report it...  I'll go through my list of old
warnings and review them again.

$ grep "dereferencing possible ERR_PTR" smatch_warns.txt | wc -l
115

regards,
dan carpenter


