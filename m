Return-Path: <linux-fsdevel+bounces-28934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AADD39716BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 13:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37BACB21CF6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 11:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256B71B78F5;
	Mon,  9 Sep 2024 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIxa7MfC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBF21AF4E4;
	Mon,  9 Sep 2024 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725881033; cv=none; b=aAQnIIIJZzudhpLL1BrY2wHeUFhITBw4JqxxO1z79R1A/C8IHC77QS2poP3Vcuvh2FQW8T3clhbxTfHfU5vxZtkHQIAi1Z4zwS45rRiPyR9RCGPUWvlae8KkGB4BuclkORdG0Myvttx5clDh8Cy0xK+rwi5TYmlWzvNXKNwZUYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725881033; c=relaxed/simple;
	bh=AQzT3bAV2JDDv98lxn2LYC9mXTmymBsjkG6LCRpyPxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gVZttwQ8tMcHh9fKPkulXvK/6ruxXE/VKglyyEKUkAr85jIpNTU1klaEgQDyGt9z/wMCzEE0SEzab4AJA4M44M45T/3IMwMUXxR0RYaoaWvokRBYvsCnpPwwv+iSo/EqPCYeZymUTMZ7GjDdSNtFTGtgK8QOTjqs+vQU507MhaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIxa7MfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E05C4CEC5;
	Mon,  9 Sep 2024 11:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725881032;
	bh=AQzT3bAV2JDDv98lxn2LYC9mXTmymBsjkG6LCRpyPxU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fIxa7MfCpT2NrhKQOzTCEcsR2Jj//3XNpMa32fzJWiV2Se2PY0rkOeaEEQI9zn5Cd
	 bVsbJiFRXl6JbG9+j1hSknxLqbm5Igqm0wLyebgDU+ilL1yFpOEshwYSpF8xphZ0fO
	 pNrGlj1uDMqDVJ2+SwefLeb3jg3dR9LLurP23ztS+FGFZfkneaPXMHZPiagCedVUCM
	 Bex8xTF362cqZPzzT3DONjUW0lcaPkrjok9ogTrD3B9FWo2oEKB49ixdHuLsEY61OU
	 Z3O+NUB4VeUdkFz666hVip30pCIEHrNJ0BJcP3eQLCGXlwkvY65VmEio0tued3SUtz
	 dyippi+O8W0Kg==
Message-ID: <fc780dc2-5a69-48d8-8caa-ca2ee97d10ef@kernel.org>
Date: Mon, 9 Sep 2024 13:23:38 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/17] firmware: qcom: scm: add a call for deriving the
 software secret
To: Bartosz Golaszewski <brgl@bgdev.pl>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Asutosh Das <quic_asutoshd@quicinc.com>,
 Ritesh Harjani <ritesh.list@gmail.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Gaurav Kashyap <quic_gaurkash@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240906-wrapped-keys-v6-0-d59e61bc0cb4@linaro.org>
 <20240906-wrapped-keys-v6-6-d59e61bc0cb4@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240906-wrapped-keys-v6-6-d59e61bc0cb4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6.09.2024 8:07 PM, Bartosz Golaszewski wrote:
> From: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> 
> Inline storage encryption may require deriving a software secret from
> storage keys added to the kernel.
> 
> For raw keys, this can be directly done in the kernel as keys are not
> encrypted in memory.
> 
> However, hardware wrapped keys can only be unwrapped by the HW wrapping
> entity. In case of Qualcomm's wrapped key solution, this is done by the
> Hardware Key Manager (HWKM) from Trustzone.
> 
> Add a new SCM call which provides a hook to the software secret crypto
> profile API provided by the block layer.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/firmware/qcom/qcom_scm.c       | 65 ++++++++++++++++++++++++++++++++++
>  drivers/firmware/qcom/qcom_scm.h       |  1 +
>  include/linux/firmware/qcom/qcom_scm.h |  2 ++
>  3 files changed, 68 insertions(+)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 10986cb11ec0..ad3f9e9ed35d 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1252,6 +1252,71 @@ int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_ice_set_key);
>  
> +/**
> + * qcom_scm_derive_sw_secret() - Derive software secret from wrapped key
> + * @wkey: the hardware wrapped key inaccessible to software
> + * @wkey_size: size of the wrapped key
> + * @sw_secret: the secret to be derived which is exactly the secret size
> + * @sw_secret_size: size of the sw_secret
> + *
> + * Derive a software secret from a hardware wrapped key for software crypto
> + * operations.
> + * For wrapped keys, the key needs to be unwrapped, in order to derive a
> + * software secret, which can be done in the hardware from a secure execution
> + * environment.
> + *
> + * For more information on sw secret, please refer to "Hardware-wrapped keys"
> + * section of Documentation/block/inline-encryption.rst.
> + *
> + * Return: 0 on success; -errno on failure.
> + */
> +int qcom_scm_derive_sw_secret(const u8 *wkey, size_t wkey_size,
> +			      u8 *sw_secret, size_t sw_secret_size)
> +{
> +	struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_ES,
> +		.cmd =  QCOM_SCM_ES_DERIVE_SW_SECRET,
> +		.arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_RW,
> +					 QCOM_SCM_VAL, QCOM_SCM_RW,
> +					 QCOM_SCM_VAL),
> +		.args[1] = wkey_size,
> +		.args[3] = sw_secret_size,
> +		.owner = ARM_SMCCC_OWNER_SIP,
> +	};
> +
> +	int ret;
> +
> +	void *wkey_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
> +							    wkey_size,
> +							    GFP_KERNEL);
> +	if (!wkey_buf)
> +		return -ENOMEM;
> +
> +	void *secret_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
> +							       sw_secret_size,
> +							       GFP_KERNEL);
> +	if (!secret_buf) {
> +		ret = -ENOMEM;
> +		goto out_free_wrapped;
> +	}
> +
> +	memcpy(wkey_buf, wkey, wkey_size);
> +	desc.args[0] = qcom_tzmem_to_phys(wkey_buf);
> +	desc.args[2] = qcom_tzmem_to_phys(secret_buf);
> +
> +	ret = qcom_scm_call(__scm->dev, &desc, NULL);
> +	if (!ret)
> +		memcpy(sw_secret, secret_buf, sw_secret_size);
> +
> +	memzero_explicit(secret_buf, sw_secret_size);
> +
> +out_free_wrapped:

Is there a reason to zero out the buffer that's being zero-allocated?

Konrad

> +	memzero_explicit(wkey_buf, wkey_size);

