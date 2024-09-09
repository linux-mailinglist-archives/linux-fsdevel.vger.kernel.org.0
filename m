Return-Path: <linux-fsdevel+bounces-28928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F789712C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 10:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80502847F7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 08:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937AE1B3726;
	Mon,  9 Sep 2024 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d5MHBE/6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83681B29D0
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Sep 2024 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872319; cv=none; b=TmWMLMBm0IixXH1m0KuP7r4nyigE6kuxwHYdoHbn/bJXMEv8JetDL+w8hvG7fHL7poGtzWDCb2iNzQrpF23uYCFu7/3CCmb1byIC1A5amglLWzWkJ5RZd0eGQhy9mvvxVHSHL3UK6ssO0bMSJVzS7B30o2Dz5i7lwVw9k4K//a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872319; c=relaxed/simple;
	bh=hMgy8bX6Ok+Sly2wQ3k/uCmFxdR1J21buj1Oj+8Tu2k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ez/8CBFLz4YJ7ufdakaSONeCcLQRTpOa5ZBQfpPza/hA1hDOskO2iMSBUjzvoOSqI0bE2lyNBFILab4PoTkm5o0UTiemuUdSwKrvQc76yOGf0th5B0tsYYa/p7t9IlWHFWDIaPQ8O/gNo87zV/EykcHtm+7PzyiG7qB/k2NcWl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d5MHBE/6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso14162585e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2024 01:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725872314; x=1726477114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMvHs5Ab7mHAlvlrWenHe3/+itZxK87jYym+SorE/SA=;
        b=d5MHBE/6nV+q3S16jwp9mTU0YKD+3PL9RxdDFilnfCN/sOL49WpQqSGFjp9mHijrqZ
         tUJ6Bqi5A/qSqJMJ9rZAN89zezDJkGTapOpIWrbZekkWsUUEGcuV4lJ3yUmdfu5Nrn3A
         OuPFDb1O/BCL8Fq09KwiIQXoYHCwWZCAL2Pu8yF1ypVLz8Nf7OgO6+MBiabzU4nTsC4r
         IdGvmNbwl5Rswb88gxKHjUo+vwYYI/0n6jX9ErZqraaQ96ws/0MOlqybPi8ZWVXFjkiI
         4HVO6B9QP4pnDVl91nPIk4v7HJwNqIF3qseXJg9mlimPEix/a8XejffrsL/nkMhiG4Ew
         BMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725872314; x=1726477114;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PMvHs5Ab7mHAlvlrWenHe3/+itZxK87jYym+SorE/SA=;
        b=xCc1xGBXjtIVvIX9OX3PLxDK+rpdOs/Fm/rmiiL2tpCwxTOVlguqJWgHQIGBrMJI36
         WcqTduap14oeydd6NDrbxChO/nfWn2yymAwSuQeiggRY0U8Pi/MIOkcFpW89DsD04GTW
         0XlLN5ymddsKcfl6WdCL3bj0pS0BckectU2iPz/3oBRPhNEAn8DUyHCDTrUlYPcnUL3f
         8qW6Dbzos2ygPYkTbPqI6Wl7JZQ/yUiyz6pxCfAEiPWSpJL5Eiq4d/tSp3iSOEr5tftE
         rA6MiNU9peqZ+9PQw/wgJ3MEr4guBdi9z8Q4NVT7o6NbGRrYSMXZ273jPkmojmAMexJL
         6xqw==
X-Forwarded-Encrypted: i=1; AJvYcCWuHqBklerCBQTthJwW5VSauHhUgo6QtwlM7dLwOs8HtuMMPA/0DyK3IwZ4beZOfQOTbWFFAakTggbTbva2@vger.kernel.org
X-Gm-Message-State: AOJu0YxlhVfimLVrdKoN4SROmn7/cz2kkeuCV3ygNQ+3YME2Al7pvCgS
	AZEYepbQR4dGIqK9hbCbLFYq5/oH2c4/ulCPV4Kuc5X3135Upa0GXpbckMSiMTDo8lp14nxIM6V
	6
X-Google-Smtp-Source: AGHT+IG6v8/1xNArCrOhm5mi79N9gIxXGtQTCtPLSsLWPvDJATIAkCocS/kMp98RIRO0ro21ssL4Yw==
X-Received: by 2002:a05:600c:468a:b0:428:b4a:7001 with SMTP id 5b1f17b1804b1-42c95be865emr103023695e9.15.1725872313704;
        Mon, 09 Sep 2024 01:58:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:63a3:6883:a358:b850? ([2a01:e0a:982:cbb0:63a3:6883:a358:b850])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956654f4sm5446815f8f.43.2024.09.09.01.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 01:58:33 -0700 (PDT)
Message-ID: <66953e65-2468-43b8-9ccf-54671613c4ab@linaro.org>
Date: Mon, 9 Sep 2024 10:58:30 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v6 09/17] soc: qcom: ice: add HWKM support to the ICE
 driver
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Asutosh Das <quic_asutoshd@quicinc.com>,
 Ritesh Harjani <ritesh.list@gmail.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Gaurav Kashyap <quic_gaurkash@quicinc.com>, linux-block@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-mmc@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240906-wrapped-keys-v6-0-d59e61bc0cb4@linaro.org>
 <20240906-wrapped-keys-v6-9-d59e61bc0cb4@linaro.org>
 <7uoq72bpiqmo2olwpnudpv3gtcowpnd6jrifff34ubmfpijgc6@k6rmnalu5z4o>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <7uoq72bpiqmo2olwpnudpv3gtcowpnd6jrifff34ubmfpijgc6@k6rmnalu5z4o>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/09/2024 00:07, Dmitry Baryshkov wrote:
> On Fri, Sep 06, 2024 at 08:07:12PM GMT, Bartosz Golaszewski wrote:
>> From: Gaurav Kashyap <quic_gaurkash@quicinc.com>
>>
>> Qualcomm's ICE (Inline Crypto Engine) contains a proprietary key
>> management hardware called Hardware Key Manager (HWKM). Add HWKM support
>> to the ICE driver if it is available on the platform. HWKM primarily
>> provides hardware wrapped key support where the ICE (storage) keys are
>> not available in software and instead protected in hardware.
>>
>> When HWKM software support is not fully available (from Trustzone), there
>> can be a scenario where the ICE hardware supports HWKM, but it cannot be
>> used for wrapped keys. In this case, raw keys have to be used without
>> using the HWKM. We query the TZ at run-time to find out whether wrapped
>> keys support is available.
>>
>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> ---
>>   drivers/soc/qcom/ice.c | 152 +++++++++++++++++++++++++++++++++++++++++++++++--
>>   include/soc/qcom/ice.h |   1 +
>>   2 files changed, 149 insertions(+), 4 deletions(-)
>>
>>   int qcom_ice_enable(struct qcom_ice *ice)
>>   {
>> +	int err;
>> +
>>   	qcom_ice_low_power_mode_enable(ice);
>>   	qcom_ice_optimization_enable(ice);
>>   
>> -	return qcom_ice_wait_bist_status(ice);
>> +	if (ice->use_hwkm)
>> +		qcom_ice_enable_standard_mode(ice);
>> +
>> +	err = qcom_ice_wait_bist_status(ice);
>> +	if (err)
>> +		return err;
>> +
>> +	if (ice->use_hwkm)
>> +		qcom_ice_hwkm_init(ice);
>> +
>> +	return err;
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_ice_enable);
>>   
>> @@ -150,6 +282,10 @@ int qcom_ice_resume(struct qcom_ice *ice)
>>   		return err;
>>   	}
>>   
>> +	if (ice->use_hwkm) {
>> +		qcom_ice_enable_standard_mode(ice);
>> +		qcom_ice_hwkm_init(ice);
>> +	}
>>   	return qcom_ice_wait_bist_status(ice);
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_ice_resume);
>> @@ -157,6 +293,7 @@ EXPORT_SYMBOL_GPL(qcom_ice_resume);
>>   int qcom_ice_suspend(struct qcom_ice *ice)
>>   {
>>   	clk_disable_unprepare(ice->core_clk);
>> +	ice->hwkm_init_complete = false;
>>   
>>   	return 0;
>>   }
>> @@ -206,6 +343,12 @@ int qcom_ice_evict_key(struct qcom_ice *ice, int slot)
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_ice_evict_key);
>>   
>> +bool qcom_ice_hwkm_supported(struct qcom_ice *ice)
>> +{
>> +	return ice->use_hwkm;
>> +}
>> +EXPORT_SYMBOL_GPL(qcom_ice_hwkm_supported);
>> +
>>   static struct qcom_ice *qcom_ice_create(struct device *dev,
>>   					void __iomem *base)
>>   {
>> @@ -240,6 +383,7 @@ static struct qcom_ice *qcom_ice_create(struct device *dev,
>>   		engine->core_clk = devm_clk_get_enabled(dev, NULL);
>>   	if (IS_ERR(engine->core_clk))
>>   		return ERR_CAST(engine->core_clk);
>> +	engine->use_hwkm = qcom_scm_has_wrapped_key_support();
> 
> This still makes the decision on whether to use HW-wrapped keys on
> behalf of a user. I suppose this is incorrect. The user must be able to
> use raw keys even if HW-wrapped keys are available on the platform. One
> of the examples for such use-cases is if a user prefers to be able to
> recover stored information in case of a device failure (such recovery
> will be impossible if SoC is damaged and HW-wrapped keys are used).

Isn't that already the case ? the BLK_CRYPTO_KEY_TYPE_HW_WRAPPED size is
here to select HW-wrapped key, otherwise the ol' raw key is passed.
Just look the next patch.

Or did I miss something ?

Neil

> 
>>   
>>   	if (!qcom_ice_check_supported(engine))
>>   		return ERR_PTR(-EOPNOTSUPP);
>> diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
>> index 9dd835dba2a7..1f52e82e3e1c 100644
>> --- a/include/soc/qcom/ice.h
>> +++ b/include/soc/qcom/ice.h
>> @@ -34,5 +34,6 @@ int qcom_ice_program_key(struct qcom_ice *ice,
>>   			 const struct blk_crypto_key *bkey,
>>   			 u8 data_unit_size, int slot);
>>   int qcom_ice_evict_key(struct qcom_ice *ice, int slot);
>> +bool qcom_ice_hwkm_supported(struct qcom_ice *ice);
>>   struct qcom_ice *of_qcom_ice_get(struct device *dev);
>>   #endif /* __QCOM_ICE_H__ */
>>
>> -- 
>> 2.43.0
>>
> 


