Return-Path: <linux-fsdevel+bounces-28888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B97996FDCE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 00:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE9B282FD0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 22:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F8615AAD7;
	Fri,  6 Sep 2024 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kaQN6uA+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A0215A87C
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725660442; cv=none; b=MvHMX3foTe/WuFHeaSzt/fYR8dnKVLuTR3g/EITHvEwnVqWA6FB/2dPpQVvaOBVOiQP/l1cvGelwdo5ejwAdXMcLc6DgN8kSKJFlv6R8pzSLdABUkhHAKFdyizBxkYXeCRRCOoYK7aWDPNXuUOf6u+X58eSAhxOcEYNqhYOa1as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725660442; c=relaxed/simple;
	bh=DMDXUtr2tKydRZROnQMaVv9GRGluLW3xfbvWKrH84YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oY7EG3efB5F3XzBb6TbE2hjBvwY3J94X7k0z416Ky+iwyy8kjhgaDTw74vWkSqIJrnTUggaLZ+zmdAP+Tm9cuNWbP3puAOi/vGKwXLZ3RRRcrqi6RnMa6Ce4RytnaTgYz4UjkXxnFRbl1kUpIFrbPWyciibmDzEOYli6ROyWhZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kaQN6uA+; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5365cf5de24so480362e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2024 15:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725660439; x=1726265239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6HOhtyEYYt7rA6jCBX+L1mlm8hngGJHlfFCxxooVTC4=;
        b=kaQN6uA+5cYL38uaZLKBGyobZmQgr12YaaCLn80DRzBTFtLrZuxB9OfNnowN+YWS0/
         EZ0gQ3vWXINxF5r6dptQxWlxL/HsAJSIa84VDdlUnGPTF5YbPo+W6DfbkDoaMcVR15/x
         wFYLJhsb3PRYorSk0ZQaKryX5jPKwfekTUBAabltz/SA2X/sfyn5OaZMVJMgh/Apcdek
         61nJUyQ2IXVMaSJKQdyr/p+3t8Q8WSzxqpGCL6dBAsHVzmADYQ/vBUUrEnRy0xC9jOc6
         5SFk5FiKfO6nWnqqYh04CF4UcyB1vemf2TMzQb4F5yBJ+klIumSK8vzj0NAZAjlnccDI
         J2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725660439; x=1726265239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HOhtyEYYt7rA6jCBX+L1mlm8hngGJHlfFCxxooVTC4=;
        b=TCqUx2KCpdJVfXB91hKd2PkgwR2LKFAWnW7xFdiCdPuTAOHA+ldOPsLNj5G6gsevt7
         WDp4BKOChBBH+Z99a9wZS40HQHv+YH42/4bW6hC30t6xE7NxKd1aAPN34SDqp6/3+ASS
         ThaqCcf2AoCHALJeWl1YaW+mQUuwcJRpLo2kjABAnBQjSyT9PwRgAoMR3ew+sj2s7Ckv
         fRZWRbGbo1MAIKybtR82QrRRm6hPKLkk+VQ/qMem5UaUC7+zqsMoyqknX8a9wtW58zfE
         gXY2dqNWHYbrR4hkdYfYiyxc49jIVWlVIaiifzRmJj1HxwSeiyU6IRowinKcKZqjZgk2
         NiHg==
X-Forwarded-Encrypted: i=1; AJvYcCXlDzk6izoy/17tYUfTrGeU6cnYgEu9b996lXD52fq3DQvt3jIBVMTe6df6t6W6P5vHHbaMivzY9cl92FZ6@vger.kernel.org
X-Gm-Message-State: AOJu0YwpZC4GtE0WW3JJJKmiD0G15TR1URhApmH8hThq2AtBPQGcQsB8
	OBl55J4chHXdKtfnLR9xgflAJDQzhfGXEJ+cuO/LHwsgF1BXb/4z0YK8y6fo6+U=
X-Google-Smtp-Source: AGHT+IGo5Rf50EbBmOUBUAeWLcQnh0sLqD8vtwGBMm3Zld7y3VkY79ttTtwoqkfdSYGppGMy/IXnlA==
X-Received: by 2002:a05:6512:280d:b0:530:ba4b:f65d with SMTP id 2adb3069b0e04-536587b4b74mr2903071e87.28.1725660438133;
        Fri, 06 Sep 2024 15:07:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536536a12f4sm529135e87.230.2024.09.06.15.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 15:07:17 -0700 (PDT)
Date: Sat, 7 Sep 2024 01:07:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, 
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Asutosh Das <quic_asutoshd@quicinc.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Gaurav Kashyap <quic_gaurkash@quicinc.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v6 09/17] soc: qcom: ice: add HWKM support to the ICE
 driver
Message-ID: <7uoq72bpiqmo2olwpnudpv3gtcowpnd6jrifff34ubmfpijgc6@k6rmnalu5z4o>
References: <20240906-wrapped-keys-v6-0-d59e61bc0cb4@linaro.org>
 <20240906-wrapped-keys-v6-9-d59e61bc0cb4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906-wrapped-keys-v6-9-d59e61bc0cb4@linaro.org>

On Fri, Sep 06, 2024 at 08:07:12PM GMT, Bartosz Golaszewski wrote:
> From: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> 
> Qualcomm's ICE (Inline Crypto Engine) contains a proprietary key
> management hardware called Hardware Key Manager (HWKM). Add HWKM support
> to the ICE driver if it is available on the platform. HWKM primarily
> provides hardware wrapped key support where the ICE (storage) keys are
> not available in software and instead protected in hardware.
> 
> When HWKM software support is not fully available (from Trustzone), there
> can be a scenario where the ICE hardware supports HWKM, but it cannot be
> used for wrapped keys. In this case, raw keys have to be used without
> using the HWKM. We query the TZ at run-time to find out whether wrapped
> keys support is available.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/soc/qcom/ice.c | 152 +++++++++++++++++++++++++++++++++++++++++++++++--
>  include/soc/qcom/ice.h |   1 +
>  2 files changed, 149 insertions(+), 4 deletions(-)
> 
>  int qcom_ice_enable(struct qcom_ice *ice)
>  {
> +	int err;
> +
>  	qcom_ice_low_power_mode_enable(ice);
>  	qcom_ice_optimization_enable(ice);
>  
> -	return qcom_ice_wait_bist_status(ice);
> +	if (ice->use_hwkm)
> +		qcom_ice_enable_standard_mode(ice);
> +
> +	err = qcom_ice_wait_bist_status(ice);
> +	if (err)
> +		return err;
> +
> +	if (ice->use_hwkm)
> +		qcom_ice_hwkm_init(ice);
> +
> +	return err;
>  }
>  EXPORT_SYMBOL_GPL(qcom_ice_enable);
>  
> @@ -150,6 +282,10 @@ int qcom_ice_resume(struct qcom_ice *ice)
>  		return err;
>  	}
>  
> +	if (ice->use_hwkm) {
> +		qcom_ice_enable_standard_mode(ice);
> +		qcom_ice_hwkm_init(ice);
> +	}
>  	return qcom_ice_wait_bist_status(ice);
>  }
>  EXPORT_SYMBOL_GPL(qcom_ice_resume);
> @@ -157,6 +293,7 @@ EXPORT_SYMBOL_GPL(qcom_ice_resume);
>  int qcom_ice_suspend(struct qcom_ice *ice)
>  {
>  	clk_disable_unprepare(ice->core_clk);
> +	ice->hwkm_init_complete = false;
>  
>  	return 0;
>  }
> @@ -206,6 +343,12 @@ int qcom_ice_evict_key(struct qcom_ice *ice, int slot)
>  }
>  EXPORT_SYMBOL_GPL(qcom_ice_evict_key);
>  
> +bool qcom_ice_hwkm_supported(struct qcom_ice *ice)
> +{
> +	return ice->use_hwkm;
> +}
> +EXPORT_SYMBOL_GPL(qcom_ice_hwkm_supported);
> +
>  static struct qcom_ice *qcom_ice_create(struct device *dev,
>  					void __iomem *base)
>  {
> @@ -240,6 +383,7 @@ static struct qcom_ice *qcom_ice_create(struct device *dev,
>  		engine->core_clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(engine->core_clk))
>  		return ERR_CAST(engine->core_clk);
> +	engine->use_hwkm = qcom_scm_has_wrapped_key_support();

This still makes the decision on whether to use HW-wrapped keys on
behalf of a user. I suppose this is incorrect. The user must be able to
use raw keys even if HW-wrapped keys are available on the platform. One
of the examples for such use-cases is if a user prefers to be able to
recover stored information in case of a device failure (such recovery
will be impossible if SoC is damaged and HW-wrapped keys are used).

>  
>  	if (!qcom_ice_check_supported(engine))
>  		return ERR_PTR(-EOPNOTSUPP);
> diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
> index 9dd835dba2a7..1f52e82e3e1c 100644
> --- a/include/soc/qcom/ice.h
> +++ b/include/soc/qcom/ice.h
> @@ -34,5 +34,6 @@ int qcom_ice_program_key(struct qcom_ice *ice,
>  			 const struct blk_crypto_key *bkey,
>  			 u8 data_unit_size, int slot);
>  int qcom_ice_evict_key(struct qcom_ice *ice, int slot);
> +bool qcom_ice_hwkm_supported(struct qcom_ice *ice);
>  struct qcom_ice *of_qcom_ice_get(struct device *dev);
>  #endif /* __QCOM_ICE_H__ */
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

