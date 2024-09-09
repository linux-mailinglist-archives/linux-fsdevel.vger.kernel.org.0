Return-Path: <linux-fsdevel+bounces-28939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F559718CC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 13:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5898F1F21A8B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 11:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472761B78EB;
	Mon,  9 Sep 2024 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhHzZQ7n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD2E13BAF1;
	Mon,  9 Sep 2024 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882983; cv=none; b=dbPZW1xjenvgofKT8nolDMas8Ipyv0JevhQmo/y8ojnnLeRRdAXzCwRmO4qPOsEx3S348rGodbb+aYlz1SfdJVxa9++ZAlQIw7+VrHi1YkFo4rIxdlDEMOKPLfjcnPbEn7lLrMAFut0UrD4/KxitYz5u0xrRGPlvJEJdTio0OCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882983; c=relaxed/simple;
	bh=/YtRu2MORuw03OqntPGRgVqgK255CA2LiMaiIADwXrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UA1F3fDpM6mGTSYs8+SJjrlTzro/O3if+mFyFnEorj2uFOZdxkvT+l1Hdbbdrjq9Ztl1ShRFavsWk363T8B0+/DV670wZq2A3X7lJ1BkYa9L5dyUCKaWMd2Ton37vBGlY7f+zDgy2pUYb0Ala2CenUng2cIxV4erMNUnNsNf6io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhHzZQ7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF93C4CEC5;
	Mon,  9 Sep 2024 11:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725882983;
	bh=/YtRu2MORuw03OqntPGRgVqgK255CA2LiMaiIADwXrk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bhHzZQ7n7PMR2BNbizOYSxL+P4Zy5IkWjJpzjaiNOE1d+Id4GRkgYxIX2MGfzgt6g
	 48a53xifmqGRExB/4QwUBAy86hBjnHe+VL9RW6fLIJjIPGM5doT7wWYsq/aTQn485F
	 007XJGBf3SsAHsDESrFeo2UjYBX+vXAkocffLiKGQLcZTMiWItkSLVVpPAXUnlwka7
	 s+ET6l0Ls0+jcDCsd9txQ5ii3Qir13AWZ1183IQXF9Dz1U2ySN+zRNIHd8SV+a8vYJ
	 sV3rj/7D0++1O4uBmTRetLtwCfBOlWys5ApTCypm/5Wgve6bSNXEUb3QEsWA9Cfs6J
	 xVefcKeJVyzzQ==
Message-ID: <85cb5092-fbc9-4fa7-99ca-e9b26c7a61b6@kernel.org>
Date: Mon, 9 Sep 2024 13:56:11 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 16/17] ufs: host: add a callback for deriving software
 secrets and use it
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
 <20240906-wrapped-keys-v6-16-d59e61bc0cb4@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240906-wrapped-keys-v6-16-d59e61bc0cb4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6.09.2024 8:07 PM, Bartosz Golaszewski wrote:
> From: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> 
> Add a new UFS core callback for deriving software secrets from hardware
> wrapped keys and implement it in QCom UFS.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/ufs/host/ufs-qcom.c | 15 +++++++++++++++
>  include/ufs/ufshcd.h        |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 366fd62a951f..77fb5e66e4be 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -182,9 +182,23 @@ static int ufs_qcom_ice_program_key(struct ufs_hba *hba,
>  		return qcom_ice_evict_key(host->ice, slot);
>  }
>  
> +/*
> + * Derive a software secret from a hardware wrapped key. The key is unwrapped in
> + * hardware from trustzone and a software key/secret is then derived from it.
> + */
> +static int ufs_qcom_ice_derive_sw_secret(struct ufs_hba *hba, const u8 wkey[],
> +					 unsigned int wkey_size,
> +					 u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
> +{
> +	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +
> +	return qcom_ice_derive_sw_secret(host->ice, wkey, wkey_size, sw_secret);
> +}

There's platforms with multiple UFS hosts (e.g. 8280 has one with the
intention to be used for an onboard flash and one for a UFS card (they're
like microSD except they're UFS and not MMC).. We need to handle that
somehow too.

My uneducated guess would be that the encryption infra is there for the
primary host only and that it would be the one assumed by SCM calls.

I thiiiink it should be enough not to add a `qcom,ice` property in the
DT for the secondary slot, but please somebody else take another look
here

Konrad

