Return-Path: <linux-fsdevel+bounces-56845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21216B1C7FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 16:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C681756572B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 14:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C4128CF70;
	Wed,  6 Aug 2025 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZCj680Pc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F4D1DE2C9
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492086; cv=none; b=r6hr5sVCc7VEa6MaD56ie0We69dsCdeuiW2XuwMNIy8dzStf0XwRL9uSST/ulSN9K/+UrYoN4LIfXCQ3rvbJcd/2HsINoNuSmybSRDeVer7A57AiNIADS/6DxZzZwxc7up+nZxtLnHLp3KqkxEp3zkaceQEDnbBZoQlMc2uWvdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492086; c=relaxed/simple;
	bh=SVRodG0zvxGlUaxaLrK8qGufNosvgynL6uZXyT49/cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e42O38q6J8sh9hv9iudPgW4XfhIYNUWb0emcyeC8nHOYUueTqscbbu8qHMyGyvh172f0RH/ugey9mSVPfjhkbSyqG+6OOwNnV6BxEmpwFeTRo0ubOQyI76mbgH54U5B2UvvDiFPZu0UejEs1duyAN2IThLxnb2g9Mcu2KlPLn4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZCj680Pc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-458aee6e86aso35880875e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Aug 2025 07:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754492082; x=1755096882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ql+4yjN6PZwgyy3U3y1Oboq9QPVkpHzAUjvgGZhwmxY=;
        b=ZCj680PcVmLZcLuVQP7a4f9l+CJ/chNDLVXkkh+3v1gCZAg4ZgP4WU06xJGwpvyNRc
         lhVuR66Pyj6DkBkHRNluFVkEunTmB3mTBB/tbNabRjcgyjjNr0FLNyXzn5STOlCBy5yp
         SHEwiwpw2fOVI36DmYyXFGJCjyKfJZ3trt4eb0F8DUMSj9dic28qVcxvmr7F1MMy93Bo
         wpF23XspMN4k7VkkdxQ6vrY6/pD8DqK/UJqTO14I7ptevHh6YXKUHHQvPxR61NNH1/oz
         ZugCbi7e0t0uQ7HOIVMODfhgygDjFICAH+rI3RQ97DVIm2KdBFuJBiIouoZNbtnkIZ94
         1DcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754492082; x=1755096882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ql+4yjN6PZwgyy3U3y1Oboq9QPVkpHzAUjvgGZhwmxY=;
        b=uRHjDjtHmbzTSa+GeDcuL+E3C3RLvbT0ftgMRZ3GUhs921+gAI7Hq02ThGGDVWaZUO
         WQ4tNNuJINq1wcXaLD/UE/w3+0QsIZuRw8e/vfkG0H1MgDTPnre8taqllIdE48Pm0v0Y
         PEd8GURjHtIouI66cK23K5Nr3Az1OYfZJ1pc4p9E/nnn0wEB2pppBC8JA8MNz3x6MPhH
         /SroNftqQfuznqDu+lZabStl+8pGMyLTb/f100byQCsfxwcjZ5TtV5yTRowmb+Dj6ZuP
         785ADh3G3rHHqG90PXjpqiygJGWInmygtKQY0k7DNvJ0qn+v9ao0P5Q51Au0+Cs6XAv7
         M8RA==
X-Forwarded-Encrypted: i=1; AJvYcCWfusGsaamWHwHwDaMKmQMZd/qdKV1yW35Efk95IIEXK25dsz79j/ApKEVr3JgVCeIzlC5YLC2re4Tw8EaW@vger.kernel.org
X-Gm-Message-State: AOJu0YxwfqHL2piL/QlWI9QfxLuLSn936hZxUQaGp+S2QVrDtbljDaqM
	vE7rYrYbW441LW8OC6Ynxt4szlX0nocrGjWWkOWCM1265KEPpXwxQwHVyJNOkUmD15E=
X-Gm-Gg: ASbGncv8b0hncMwXcwOkUw47ndo/9YnIPoLVcLz3E07JYegwXGJv7j8mqKi1ABs5G/2
	klrYdbmN66/Fawv+/NUeYyiH6XcjCzeA3Tx2/ZmH4jMbrpvfylMpb0ZozcSqM6RhPq0FxFp5kOY
	c1WkHqgwqlojDWrja+jObkSlBintlm0OGFBaU/5T1Xh748H5sEXJPB/l9HZCR9QehrWmzmyOMry
	ppClCLQ3Hi/yFJsHEIRkHut41YOFlfTZdFKAqZy27XesWo9qHHzc1Nl5z/Mk1oltX3Ffd5IvASQ
	VBCJxsxznOGGzTlpKJkGYtlHjSPweVxUcVqCCt31ckMTi0lrNCB04cCdALrLGOuzPmEd6bBgbhk
	bD0qZNB25LwPIOB9YW7neKCKMip4=
X-Google-Smtp-Source: AGHT+IFLfARKLnKG0ew9cJLuoJmdpZs2Rnsn27k701nGj9Fp5OVnMoF/Mry4CzCGpK3knANGl3SVRQ==
X-Received: by 2002:a05:6000:40e1:b0:3b7:93d3:f47f with SMTP id ffacd0b85a97d-3b8f414034emr2455867f8f.0.1754492082016;
        Wed, 06 Aug 2025 07:54:42 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c4530a8sm23346602f8f.38.2025.08.06.07.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 07:54:41 -0700 (PDT)
Date: Wed, 6 Aug 2025 17:54:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Renjiang Han <quic_renjiang@quicinc.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
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
Message-ID: <aJNsreA4FuxalDc8@stanley.mountain>
References: <CA+G9fYvZtbQLoS=GpaZ_uzm3YiZEQmz0oghnwVamNQ49CosT2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvZtbQLoS=GpaZ_uzm3YiZEQmz0oghnwVamNQ49CosT2w@mail.gmail.com>

On Tue, Aug 05, 2025 at 12:50:28AM +0530, Naresh Kamboju wrote:
> While booting and testing selftest cgroups and filesystem testing on arm64
> dragonboard-410c the following kernel warnings / errors noticed and system
> halted and did not recover with selftests Kconfig enabled running the kernel
> Linux next tag next-20250804.
> 
> Regression Analysis:
> - New regression? Yes
> - Reproducibility? Re-validation is in progress
> 
> First seen on the next-20250804
> Good: next-20250801
> Bad: next-20250804
> 
> Test regression: next-20250804 Unable to handle kernel execute from
> non-executable memory at virtual address idem_hash
> Test regression: next-20250804 refcount_t: addition on 0;
> use-after-free refcount_warn_saturate
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ## Test crash log
> [    9.811341] Unable to handle kernel NULL pointer dereference at
> virtual address 000000000000002e
> [    9.811444] Mem abort info:
> [    9.821150]   ESR = 0x0000000096000004
> [    9.833499]   SET = 0, FnV = 0
> [    9.833566]   EA = 0, S1PTW = 0
> [    9.835511]   FSC = 0x04: level 0 translation fault
> [    9.838901] Data abort info:
> [    9.843788]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [    9.846565]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    9.851938]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    9.853510] rtc-pm8xxx 200f000.spmi:pmic@0:rtc@6000: registered as rtc0
> [    9.856992] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000856f8000
> [    9.862446] rtc-pm8xxx 200f000.spmi:pmic@0:rtc@6000: setting system
> clock to 1970-01-01T00:00:31 UTC (31)
> [    9.868789] [000000000000002e] pgd=0000000000000000, p4d=0000000000000000
> [    9.875459] Internal error: Oops: 0000000096000004 [#1]  SMP
> [    9.889547] input: pm8941_pwrkey as
> /devices/platform/soc@0/200f000.spmi/spmi-0/0-00/200f000.spmi:pmic@0:pon@800/200f000.spmi:pmic@0:pon@800:pwrkey/input/input1
> [    9.891545] Modules linked in: qcom_spmi_temp_alarm rtc_pm8xxx
> qcom_pon(+) qcom_pil_info videobuf2_dma_sg ubwc_config qcom_q6v5
> venus_core(+) qcom_sysmon qcom_spmi_vadc v4l2_fwnode llcc_qcom
> v4l2_async qcom_vadc_common qcom_common ocmem v4l2_mem2mem drm_gpuvm
> videobuf2_memops qcom_glink_smem videobuf2_v4l2 drm_exec mdt_loader
> qmi_helpers gpu_sched drm_dp_aux_bus qnoc_msm8916 videodev
> drm_display_helper qcom_stats videobuf2_common cec qcom_rng
> drm_client_lib mc phy_qcom_usb_hs socinfo rpmsg_ctrl display_connector
> rpmsg_char ramoops rmtfs_mem reed_solomon drm_kms_helper fuse drm
> backlight
> [    9.912286] input: pm8941_resin as
> /devices/platform/soc@0/200f000.spmi/spmi-0/0-00/200f000.spmi:pmic@0:pon@800/200f000.spmi:pmic@0:pon@800:resin/input/input2
> [    9.941186] CPU: 2 UID: 0 PID: 221 Comm: (udev-worker) Not tainted
> 6.16.0-next-20250804 #1 PREEMPT
> [    9.941200] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> [    9.941206] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    9.941215] pc : dev_pm_opp_put (/builds/linux/drivers/opp/core.c:1685)
> [    9.941233] lr : core_clks_enable+0x54/0x148 venus_core
> [   10.004266] sp : ffff8000842b35f0
> [   10.004273] x29: ffff8000842b35f0 x28: ffff8000842b3ba0 x27: ffff0000047be938
> [   10.004289] x26: 0000000000000000 x25: 0000000000000000 x24: ffff80007b350ba0
> [   10.004303] x23: ffff00000ba380c8 x22: ffff00000ba38080 x21: 0000000000000000
> [   10.004316] x20: 0000000000000000 x19: ffffffffffffffee x18: 00000000ffffffff
> [   10.004330] x17: 0000000000000000 x16: 1fffe000017541a1 x15: ffff8000842b3560
> [   10.004344] x14: 0000000000000000 x13: 007473696c5f7974 x12: 696e696666615f65
> [   10.004358] x11: 00000000000000c0 x10: 0000000000000020 x9 : ffff80007b33f2bc
> [   10.004371] x8 : ffffffffffffffde x7 : ffff0000044a4800 x6 : 0000000000000000
> [   10.004384] x5 : 0000000000000002 x4 : 00000000c0000000 x3 : 0000000000000001
> [   10.004397] x2 : 0000000000000002 x1 : ffffffffffffffde x0 : ffffffffffffffee
> [   10.004412] Call trace:
> [   10.004417] dev_pm_opp_put (/builds/linux/drivers/opp/core.c:1685) (P)
> [   10.004435] core_clks_enable+0x54/0x148 venus_core
> [   10.004504] core_power_v1+0x78/0x90 venus_core
> [   10.004560] venus_runtime_resume+0x6c/0x98 venus_core
> [   10.004616] pm_generic_runtime_resume

Could you try adding some error checking to core_clks_enable()?
Does the patch below help?

regards,
dan carpenter


diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 8dd5a9b0d060..afc1c69f2f45 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -48,7 +48,8 @@ static int core_clks_enable(struct venus_core *core)
 	int ret;
 
 	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
-	dev_pm_opp_put(opp);
+	if (!IS_ERR(opp))
+		dev_pm_opp_put(opp);
 
 	for (i = 0; i < res->clks_num; i++) {
 		if (IS_V6(core)) {

