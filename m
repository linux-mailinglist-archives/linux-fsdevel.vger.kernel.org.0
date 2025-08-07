Return-Path: <linux-fsdevel+bounces-56965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835B5B1D4A4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 11:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9671D178DCB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 09:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6802206B8;
	Thu,  7 Aug 2025 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="erpoaS/k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D086B1D47B4
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754558504; cv=none; b=JNMO2nL0hLW9gzrzsqqaYzcyAHFnp69IeFjfgo/9hVDewGcuyDWS9+2xE2OYzBxm+uObp7ZuKb2A+civ6/3gPu7GkrfoVf7pVxJH3Wmq+1O6N+1+EjnHXYjUIyomYWhl08zgvuRrdqrBf1gqHhTgL4VYLAG/oTjfCIOogXUtnNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754558504; c=relaxed/simple;
	bh=2kF9Xp/i+CMWgPLaCGqbMiGiYTpga7r7YABuRUKkC+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNicpiayJ5OZZ58s7IcFDgi1UZbHN9Cl4CbPpWifH123M0rALIOLv7dongi7/4+V1S6NgyOjzcKSl+9MdcxhmTS9AzJ6A9oq6vEqnkfiU15V2hPP2R2vvFWQG93pB7RKdq5Q/IJ4f+PbC4GPm1/yNT44oAtMun2AbHrafKXETjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=erpoaS/k; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2405c0c431cso7039995ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Aug 2025 02:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754558502; x=1755163302; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nazhVQn6Jruflxd4sQmZQocx4oQcxFqDx6cnHObT89c=;
        b=erpoaS/ktQ3Qc6Q34OoQEztjQK1yqvAEpPkrcwBhE3P3FByAghn28uN3NjWZDM+MIy
         KrOR1maQNj9fZIZ1+E4p4b3Ru8zBXtFue7Qi2xaayL3GU6tjeXPy3xn/HDwtwfWapZr0
         XoSogb2O7zjF5vXo++1pghafqFfr0c8aHNW0u1MMzxT6ACCeAJa5aBQIjFGrF5gxcz0u
         3owk7mld5hI8RLHbsiCXH+T0rfDKqqKgoYBYhdbFSBKTxjtGYVf17m5teekfKxcEVd6D
         UUKgUweR6D/UPm5CW12Fu5dVIJ5b9NZaIImhoMorYY6CwbrmIb3/WA3lN5DMV90mNbzM
         RD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754558502; x=1755163302;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nazhVQn6Jruflxd4sQmZQocx4oQcxFqDx6cnHObT89c=;
        b=vFKz2fKMRtBZ5pdlRK668MWvAyac9awdOcPMgy0g6aGnPBE+R/uFMnt0lUtulRuKYz
         xQLOt2tisQM0eN/rbmNgB4KXngodeMSF0PU+IuRNtI4ZXd+rRes3tfrJGG1KamBaDs1H
         DW5AIdOGkf6xkz/DQI7JAR3zt8f/wZLQytRb5PlncfmEWOZzLcfptn//LtySg5beLdjJ
         JgGqEa2vJ6TPCo8xNXwbV1auONnsl1F/6/4sZFRKaMPsF8H5bbZOHU/4RMJuK86IAiOF
         hzxyxFAx6fdpzKsHugwtz+oVsQWqQiDGOMZSdFItA/rPgFXjYpIxo6WENSe21avTAEyo
         UpJg==
X-Forwarded-Encrypted: i=1; AJvYcCVZkuHRP4TbFT9Z8AmDeaiFyuj1e3uX/XWftQLkdqGI5EpH0paBhs3zwcsAgsFaifTm/K4fqVZ2GvSjau1f@vger.kernel.org
X-Gm-Message-State: AOJu0YwW4e/eA9tBcJOD5jPj+0gGfnl8odLXYd93vuq5vU69Aq8B5nfZ
	6FJamhkxJtIuoyyrKDBTQwSnnDTYGTvnoB/banwQ4qx9IV4nRhe5fatREYI3coHHRPzNftPQCLo
	jUxIVnnqYQtcwBq+bdr5y0Yc3QWQ3C2x9Lz/gIIWqIw==
X-Gm-Gg: ASbGnctLvl+anIy9Rmanb6Cay6ycxlCGvxDOWV9PGOq7nk4/Addmj/s5q2q656sjIto
	+X7wrt47rPJof1PZMGS3W6QA2CjWxexIkkv88EEl01rTuGOQxJHPk6v4WwAy8eq2mkAq5Wonmj8
	TT08R33Cnz5dFY7x2hw+toLuxxI1Bxh9yKuKvz9RACjonUdKodp1CyKyUiizPzP2T9FQ/+55K6p
	nDOdL91iIaT5tV0Rd9Ng1nAUgqq1mUZ6SgUUCFpZwNCFOIdmB7g
X-Google-Smtp-Source: AGHT+IENUNZHbWNhDkjrlDBP/IMI+ox17dvQGf1pPh/T6DNibPj5t5Kqy2cH1NAjJtx9Hg5ja440tS5wnPkyrNZunu0=
X-Received: by 2002:a17:903:2f89:b0:240:967a:fec3 with SMTP id
 d9443c01a7336-2429f30b074mr82279045ad.29.1754558502039; Thu, 07 Aug 2025
 02:21:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvZtbQLoS=GpaZ_uzm3YiZEQmz0oghnwVamNQ49CosT2w@mail.gmail.com>
 <aJNsreA4FuxalDc8@stanley.mountain>
In-Reply-To: <aJNsreA4FuxalDc8@stanley.mountain>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 7 Aug 2025 14:51:29 +0530
X-Gm-Features: Ac12FXzDGhnu1-S9XsmcuSQdpNl-4x-pjyL4dJsRMo-Zz2V8DR8MxaCT9WEoD8A
Message-ID: <CA+G9fYvEGBAAEetvvtXWsGb3EQ2sTOM=szkxZ4m-Gt2bTszBdQ@mail.gmail.com>
Subject: Re: next-20250804 Unable to handle kernel execute from non-executable
 memory at virtual address idem_hash
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Renjiang Han <quic_renjiang@quicinc.com>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Cgroups <cgroups@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, linux-fsdevel@vger.kernel.org, 
	Song Liu <song@kernel.org>, yukuai3@huawei.com, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: multipart/mixed; boundary="00000000000040a1ab063bc2fcd6"

--00000000000040a1ab063bc2fcd6
Content-Type: text/plain; charset="UTF-8"

Hi Dan,

On Wed, 6 Aug 2025 at 20:24, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> On Tue, Aug 05, 2025 at 12:50:28AM +0530, Naresh Kamboju wrote:
> > While booting and testing selftest cgroups and filesystem testing on arm64
> > dragonboard-410c the following kernel warnings / errors noticed and system
> > halted and did not recover with selftests Kconfig enabled running the kernel
> > Linux next tag next-20250804.
> >
> > Regression Analysis:
> > - New regression? Yes
> > - Reproducibility? Re-validation is in progress
> >
> > First seen on the next-20250804
> > Good: next-20250801
> > Bad: next-20250804
> >
> > Test regression: next-20250804 Unable to handle kernel execute from
> > non-executable memory at virtual address idem_hash
> > Test regression: next-20250804 refcount_t: addition on 0;
> > use-after-free refcount_warn_saturate
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > ## Test crash log
> > [    9.811341] Unable to handle kernel NULL pointer dereference at
> > virtual address 000000000000002e
> > [    9.811444] Mem abort info:
> > [    9.821150]   ESR = 0x0000000096000004
> > [    9.833499]   SET = 0, FnV = 0
> > [    9.833566]   EA = 0, S1PTW = 0
> > [    9.835511]   FSC = 0x04: level 0 translation fault
> > [    9.838901] Data abort info:
> > [    9.843788]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> > [    9.846565]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > [    9.851938]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > [    9.853510] rtc-pm8xxx 200f000.spmi:pmic@0:rtc@6000: registered as rtc0
> > [    9.856992] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000856f8000
> > [    9.862446] rtc-pm8xxx 200f000.spmi:pmic@0:rtc@6000: setting system
> > clock to 1970-01-01T00:00:31 UTC (31)
> > [    9.868789] [000000000000002e] pgd=0000000000000000, p4d=0000000000000000
> > [    9.875459] Internal error: Oops: 0000000096000004 [#1]  SMP
> > [    9.889547] input: pm8941_pwrkey as
> > /devices/platform/soc@0/200f000.spmi/spmi-0/0-00/200f000.spmi:pmic@0:pon@800/200f000.spmi:pmic@0:pon@800:pwrkey/input/input1
> > [    9.891545] Modules linked in: qcom_spmi_temp_alarm rtc_pm8xxx
> > qcom_pon(+) qcom_pil_info videobuf2_dma_sg ubwc_config qcom_q6v5
> > venus_core(+) qcom_sysmon qcom_spmi_vadc v4l2_fwnode llcc_qcom
> > v4l2_async qcom_vadc_common qcom_common ocmem v4l2_mem2mem drm_gpuvm
> > videobuf2_memops qcom_glink_smem videobuf2_v4l2 drm_exec mdt_loader
> > qmi_helpers gpu_sched drm_dp_aux_bus qnoc_msm8916 videodev
> > drm_display_helper qcom_stats videobuf2_common cec qcom_rng
> > drm_client_lib mc phy_qcom_usb_hs socinfo rpmsg_ctrl display_connector
> > rpmsg_char ramoops rmtfs_mem reed_solomon drm_kms_helper fuse drm
> > backlight
> > [    9.912286] input: pm8941_resin as
> > /devices/platform/soc@0/200f000.spmi/spmi-0/0-00/200f000.spmi:pmic@0:pon@800/200f000.spmi:pmic@0:pon@800:resin/input/input2
> > [    9.941186] CPU: 2 UID: 0 PID: 221 Comm: (udev-worker) Not tainted
> > 6.16.0-next-20250804 #1 PREEMPT
> > [    9.941200] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> > [    9.941206] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [    9.941215] pc : dev_pm_opp_put (/builds/linux/drivers/opp/core.c:1685)
> > [    9.941233] lr : core_clks_enable+0x54/0x148 venus_core
> > [   10.004266] sp : ffff8000842b35f0
> > [   10.004273] x29: ffff8000842b35f0 x28: ffff8000842b3ba0 x27: ffff0000047be938
> > [   10.004289] x26: 0000000000000000 x25: 0000000000000000 x24: ffff80007b350ba0
> > [   10.004303] x23: ffff00000ba380c8 x22: ffff00000ba38080 x21: 0000000000000000
> > [   10.004316] x20: 0000000000000000 x19: ffffffffffffffee x18: 00000000ffffffff
> > [   10.004330] x17: 0000000000000000 x16: 1fffe000017541a1 x15: ffff8000842b3560
> > [   10.004344] x14: 0000000000000000 x13: 007473696c5f7974 x12: 696e696666615f65
> > [   10.004358] x11: 00000000000000c0 x10: 0000000000000020 x9 : ffff80007b33f2bc
> > [   10.004371] x8 : ffffffffffffffde x7 : ffff0000044a4800 x6 : 0000000000000000
> > [   10.004384] x5 : 0000000000000002 x4 : 00000000c0000000 x3 : 0000000000000001
> > [   10.004397] x2 : 0000000000000002 x1 : ffffffffffffffde x0 : ffffffffffffffee
> > [   10.004412] Call trace:
> > [   10.004417] dev_pm_opp_put (/builds/linux/drivers/opp/core.c:1685) (P)
> > [   10.004435] core_clks_enable+0x54/0x148 venus_core
> > [   10.004504] core_power_v1+0x78/0x90 venus_core
> > [   10.004560] venus_runtime_resume+0x6c/0x98 venus_core
> > [   10.004616] pm_generic_runtime_resume
>
> Could you try adding some error checking to core_clks_enable()?
> Does the patch below help?

Your patch works.
The attached patch from Sasha fixes this reported problem on today's
Linux next tag.

$ git log --oneline next-20250805..next-20250807 --
drivers/media/platform/qcom/venus/pm_helpers.c
7881cd6886a89 media: venus: Fix OPP table error handling

- Naresh

--00000000000040a1ab063bc2fcd6
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="media-venus-fix-opp-table-error-handling.patch"
Content-Disposition: attachment; 
	filename="media-venus-fix-opp-table-error-handling.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_me16oaig0>
X-Attachment-Id: f_me16oaig0

Y29tbWl0IDc4ODFjZDY4ODZhODllZGE4NDgxOTJkM2Y1NzU5Y2UwODY3MmUwODQKQXV0aG9yOiBT
YXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+CkRhdGU6ICAgVHVlIEF1ZyA1IDA4OjU4OjIw
IDIwMjUgLTA0MDAKCiAgICBtZWRpYTogdmVudXM6IEZpeCBPUFAgdGFibGUgZXJyb3IgaGFuZGxp
bmcKICAgIAogICAgVGhlIHZlbnVzIGRyaXZlciBmYWlscyB0byBjaGVjayBpZiBkZXZfcG1fb3Bw
X2ZpbmRfZnJlcV97Y2VpbCxmbG9vcn0oKQogICAgcmV0dXJucyBhbiBlcnJvciBwb2ludGVyIGJl
Zm9yZSBjYWxsaW5nIGRldl9wbV9vcHBfcHV0KCkuIFRoaXMgY2F1c2VzCiAgICBhIGNyYXNoIHdo
ZW4gT1BQIHRhYmxlcyBhcmUgbm90IHByZXNlbnQgaW4gZGV2aWNlIHRyZWUuCiAgICAKICAgIFVu
YWJsZSB0byBoYW5kbGUga2VybmVsIGFjY2VzcyB0byB1c2VyIG1lbW9yeSBvdXRzaWRlIHVhY2Nl
c3Mgcm91dGluZXMKICAgIGF0IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwMDAwMDAwMDJlCiAgICAu
Li4KICAgIHBjIDogZGV2X3BtX29wcF9wdXQrMHgxYy8weDRjCiAgICBsciA6IGNvcmVfY2xrc19l
bmFibGUrMHg0Yy8weDE2YyBbdmVudXNfY29yZV0KICAgIAogICAgQWRkIElTX0VSUigpIGNoZWNr
cyBiZWZvcmUgY2FsbGluZyBkZXZfcG1fb3BwX3B1dCgpIHRvIGF2b2lkCiAgICBkZXJlZmVyZW5j
aW5nIGVycm9yIHBvaW50ZXJzLgogICAgCiAgICBGaXhlczogYjE3OTIzNGI1ZTU5ICgibWVkaWE6
IHZlbnVzOiBwbV9oZWxwZXJzOiB1c2Ugb3BwLXRhYmxlIGZvciB0aGUgZnJlcXVlbmN5IikKICAg
IFNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxzYXNoYWxAa2VybmVsLm9yZz4KICAgIFNpZ25l
ZC1vZmYtYnk6IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4K
CmRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL3Fjb20vdmVudXMvcG1faGVscGVy
cy5jIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9xY29tL3ZlbnVzL3BtX2hlbHBlcnMuYwppbmRl
eCA4ZGQ1YTliMGQwNjBjLi5lMzJmODg2MmE5ZjkwIDEwMDY0NAotLS0gYS9kcml2ZXJzL21lZGlh
L3BsYXRmb3JtL3Fjb20vdmVudXMvcG1faGVscGVycy5jCisrKyBiL2RyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vcWNvbS92ZW51cy9wbV9oZWxwZXJzLmMKQEAgLTQ4LDcgKzQ4LDggQEAgc3RhdGljIGlu
dCBjb3JlX2Nsa3NfZW5hYmxlKHN0cnVjdCB2ZW51c19jb3JlICpjb3JlKQogCWludCByZXQ7CiAK
IAlvcHAgPSBkZXZfcG1fb3BwX2ZpbmRfZnJlcV9jZWlsKGRldiwgJmZyZXEpOwotCWRldl9wbV9v
cHBfcHV0KG9wcCk7CisJaWYgKCFJU19FUlIob3BwKSkKKwkJZGV2X3BtX29wcF9wdXQob3BwKTsK
IAogCWZvciAoaSA9IDA7IGkgPCByZXMtPmNsa3NfbnVtOyBpKyspIHsKIAkJaWYgKElTX1Y2KGNv
cmUpKSB7CkBAIC02NjAsNyArNjYxLDggQEAgc3RhdGljIGludCBkZWNpZGVfY29yZShzdHJ1Y3Qg
dmVudXNfaW5zdCAqaW5zdCkKIAkvKlRPRE8gOiBkaXZpZGUgdGhpcyBpbnN0LT5sb2FkIGJ5IHdv
cmtfcm91dGUgKi8KIAogCW9wcCA9IGRldl9wbV9vcHBfZmluZF9mcmVxX2Zsb29yKGRldiwgJm1h
eF9mcmVxKTsKLQlkZXZfcG1fb3BwX3B1dChvcHApOworCWlmICghSVNfRVJSKG9wcCkpCisJCWRl
dl9wbV9vcHBfcHV0KG9wcCk7CiAKIAltaW5fbG9hZGVkX2NvcmUoaW5zdCwgJm1pbl9jb3JlaWQs
ICZtaW5fbG9hZCwgZmFsc2UpOwogCW1pbl9sb2FkZWRfY29yZShpbnN0LCAmbWluX2xwX2NvcmVp
ZCwgJm1pbl9scF9sb2FkLCB0cnVlKTsKQEAgLTExMjEsNyArMTEyMyw4IEBAIHN0YXRpYyBpbnQg
bG9hZF9zY2FsZV92NChzdHJ1Y3QgdmVudXNfaW5zdCAqaW5zdCkKIAlmcmVxID0gbWF4KGZyZXFf
Y29yZTEsIGZyZXFfY29yZTIpOwogCiAJb3BwID0gZGV2X3BtX29wcF9maW5kX2ZyZXFfZmxvb3Io
ZGV2LCAmbWF4X2ZyZXEpOwotCWRldl9wbV9vcHBfcHV0KG9wcCk7CisJaWYgKCFJU19FUlIob3Bw
KSkKKwkJZGV2X3BtX29wcF9wdXQob3BwKTsKIAogCWlmIChmcmVxID4gbWF4X2ZyZXEpIHsKIAkJ
ZGV2X2RiZyhkZXYsIFZEQkdMICJyZXF1ZXN0ZWQgY2xvY2sgcmF0ZTogJWx1IHNjYWxpbmcgY2xv
Y2sgcmF0ZSA6ICVsdVxuIiwKQEAgLTExMzEsNyArMTEzNCw4IEBAIHN0YXRpYyBpbnQgbG9hZF9z
Y2FsZV92NChzdHJ1Y3QgdmVudXNfaW5zdCAqaW5zdCkKIAl9CiAKIAlvcHAgPSBkZXZfcG1fb3Bw
X2ZpbmRfZnJlcV9jZWlsKGRldiwgJmZyZXEpOwotCWRldl9wbV9vcHBfcHV0KG9wcCk7CisJaWYg
KCFJU19FUlIob3BwKSkKKwkJZGV2X3BtX29wcF9wdXQob3BwKTsKIAogc2V0X2ZyZXE6CiAK
--00000000000040a1ab063bc2fcd6--

