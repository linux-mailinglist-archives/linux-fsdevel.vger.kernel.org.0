Return-Path: <linux-fsdevel+bounces-28999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9098972988
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 08:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C5F286248
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 06:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3CD17B402;
	Tue, 10 Sep 2024 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dysA5KLm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528BE176FAC
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725949752; cv=none; b=tOXtAtu04Y7deqarJVvyazo5dOZt19F+YaBQP9MxsHWwg/V+peaAnlpebHvR5CKMsVH3+8KN5u8kI+lGDBDTzwZGTzbxvlJNCTpWMDDO5Czst3b3C4DxGKTtsMRzlqubnkSsW1fg3nOyAdXzc28S85WevXH80xNZGM9ef7mFF8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725949752; c=relaxed/simple;
	bh=XaQZaTfk+la0ZZ6tSTFKn63D4zVyBwKjnuPD291hcIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=drQhBLvmZzXop8rhAKDVfVtuWHeLMLN1QdvJ8opjX5tLVkLRM3dkwvgjjqjjTCfWTGWmyoMH9Cejsf5pqcih7lUP2ImoD4joUhaX9S+dHtYkL6EtVoCjee3MENK4+JkKcvgMKekMi/8n+pMsckl9Ukw+BEcOZITP2tQIkY7Wx2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dysA5KLm; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6db2a9da800so37466677b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2024 23:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725949748; x=1726554548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nEFwTDycDGvgp9HATFRtFGrgCewYQik9kM4B0MY3fOI=;
        b=dysA5KLmqAyBweRt2T4h621AV13N+MKncHObFdiWm1YdZi7+JmH5gnq2Blo3pA2DMI
         39YEDpmchH9s67fiW7TC8U72jc7YwvZuwCEu+Yy0wmTYE2M1CgyvvA8mhrBrXwFwI8AK
         ge7Imj1dMtpZE2G2MoTfvRpV+XaLadSOjT+o0p8qa8+a0QZa2vtzalps9b72G3zxJq7l
         aB3WUWiraONMVkEDSkSf/6EqH58XMhjNixHnthWdGdov2Fu0fVZ+GUtf3OHbLvjfWiKb
         4pVuXQwNosjE+Pl3qC0zPhToIJOUlixVcF+6uDEbDRprhxK1+/V5AE9Picv6YGRY062z
         gqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725949748; x=1726554548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEFwTDycDGvgp9HATFRtFGrgCewYQik9kM4B0MY3fOI=;
        b=ofNPOPgj39hhcwp3UCMRF60/1AQZsnJDig+/iysyJyHGtpo5qpLcOkQuj46r+eWA3F
         hWRMswCJQUmXmmgSror3bf1wyiuA/4YWwxKUqpfVlvURnVhjvSK/qMYj8DD6t46GfAQD
         OdE8MV+aO74UsaYF3hqarBiZWny6lbDg7TYTc36ynrg/bGnCS8akYUmo1rJHOSn0n24W
         cyZ/43SrqTJZ59pIoE9ge8Zb23HjKOliDG+uLAqme/imvJimiuOIgSGY0C2+UJ9Je1c9
         G5BiO4DVM/YWpE7+Vv67prSCTKNz4kyMdeThpC8U41ZarA1PB684jEwBJuMakvApKb90
         3gnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbNYub9yZWa1kFy316EXccb+s+kdBOilqIyhq3SJlmw45gScHcbsx7goGzuqbB6MiVx9oXEuuwr6uLdy8+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw01Ven8BLmNkqH2FGyzHgjsoXxbvBI/pTafUXO3mmwP6OUVcsI
	B6zXeipam9vwPILFn2JxTlOBsQmNX9eIsqEYWhuQ51F3ROa2m2otgyjXPB3Fb3hlIrc1+KeSVPE
	iz/ecCl1azXXXGkuHffXWI6ZZkNta2re1PLuMwg==
X-Google-Smtp-Source: AGHT+IEBZZt2cdxLKZyy+e7siGVV18SEl42Tj+Khn8l0KILxGsWjLsPof0c5bcFrSsgmQWetWJ2qfPyKs0QRrhKeqaY=
X-Received: by 2002:a05:690c:48c8:b0:6ac:3043:168a with SMTP id
 00721157ae682-6db953817a1mr17208177b3.10.1725949748085; Mon, 09 Sep 2024
 23:29:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906-wrapped-keys-v6-0-d59e61bc0cb4@linaro.org>
 <20240906-wrapped-keys-v6-9-d59e61bc0cb4@linaro.org> <7uoq72bpiqmo2olwpnudpv3gtcowpnd6jrifff34ubmfpijgc6@k6rmnalu5z4o>
 <66953e65-2468-43b8-9ccf-54671613c4ab@linaro.org> <ivibs6qqxhbikaevys3iga7s73xq6dzq3u43gwjri3lozkrblx@jxlmwe5wiq7e>
 <98cc8d71d5d9476297a54774c382030d@quicinc.com>
In-Reply-To: <98cc8d71d5d9476297a54774c382030d@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 10 Sep 2024 09:28:57 +0300
Message-ID: <CAA8EJpp_HY+YmMCRwdteeAHnSHtjuHb=nFar60O_PwLwjk0mNA@mail.gmail.com>
Subject: Re: [PATCH v6 09/17] soc: qcom: ice: add HWKM support to the ICE driver
To: "Gaurav Kashyap (QUIC)" <quic_gaurkash@quicinc.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Asutosh Das <quic_asutoshd@quicinc.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, 
	"bartosz.golaszewski" <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Sept 2024 at 03:51, Gaurav Kashyap (QUIC)
<quic_gaurkash@quicinc.com> wrote:
>
> Hello Dmitry and Neil
>
> On Monday, September 9, 2024 2:44 AM PDT, Dmitry Baryshkov wrote:
> > On Mon, Sep 09, 2024 at 10:58:30AM GMT, Neil Armstrong wrote:
> > > On 07/09/2024 00:07, Dmitry Baryshkov wrote:
> > > > On Fri, Sep 06, 2024 at 08:07:12PM GMT, Bartosz Golaszewski wrote:
> > > > > From: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> > > > >
> > > > > Qualcomm's ICE (Inline Crypto Engine) contains a proprietary key
> > > > > management hardware called Hardware Key Manager (HWKM). Add
> > HWKM
> > > > > support to the ICE driver if it is available on the platform. HWKM
> > > > > primarily provides hardware wrapped key support where the ICE
> > > > > (storage) keys are not available in software and instead protected in
> > hardware.
> > > > >
> > > > > When HWKM software support is not fully available (from
> > > > > Trustzone), there can be a scenario where the ICE hardware
> > > > > supports HWKM, but it cannot be used for wrapped keys. In this
> > > > > case, raw keys have to be used without using the HWKM. We query
> > > > > the TZ at run-time to find out whether wrapped keys support is
> > available.
> > > > >
> > > > > Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > > > Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> > > > > Signed-off-by: Bartosz Golaszewski
> > > > > <bartosz.golaszewski@linaro.org>
> > > > > ---
> > > > >   drivers/soc/qcom/ice.c | 152
> > +++++++++++++++++++++++++++++++++++++++++++++++--
> > > > >   include/soc/qcom/ice.h |   1 +
> > > > >   2 files changed, 149 insertions(+), 4 deletions(-)
> > > > >
> > > > >   int qcom_ice_enable(struct qcom_ice *ice)
> > > > >   {
> > > > > + int err;
> > > > > +
> > > > >           qcom_ice_low_power_mode_enable(ice);
> > > > >           qcom_ice_optimization_enable(ice);
> > > > > - return qcom_ice_wait_bist_status(ice);
> > > > > + if (ice->use_hwkm)
> > > > > +         qcom_ice_enable_standard_mode(ice);
> > > > > +
> > > > > + err = qcom_ice_wait_bist_status(ice); if (err)
> > > > > +         return err;
> > > > > +
> > > > > + if (ice->use_hwkm)
> > > > > +         qcom_ice_hwkm_init(ice);
> > > > > +
> > > > > + return err;
> > > > >   }
> > > > >   EXPORT_SYMBOL_GPL(qcom_ice_enable);
> > > > > @@ -150,6 +282,10 @@ int qcom_ice_resume(struct qcom_ice *ice)
> > > > >                   return err;
> > > > >           }
> > > > > + if (ice->use_hwkm) {
> > > > > +         qcom_ice_enable_standard_mode(ice);
> > > > > +         qcom_ice_hwkm_init(ice); }
> > > > >           return qcom_ice_wait_bist_status(ice);
> > > > >   }
> > > > >   EXPORT_SYMBOL_GPL(qcom_ice_resume);
> > > > > @@ -157,6 +293,7 @@ EXPORT_SYMBOL_GPL(qcom_ice_resume);
> > > > >   int qcom_ice_suspend(struct qcom_ice *ice)
> > > > >   {
> > > > >           clk_disable_unprepare(ice->core_clk);
> > > > > + ice->hwkm_init_complete = false;
> > > > >           return 0;
> > > > >   }
> > > > > @@ -206,6 +343,12 @@ int qcom_ice_evict_key(struct qcom_ice *ice,
> > int slot)
> > > > >   }
> > > > >   EXPORT_SYMBOL_GPL(qcom_ice_evict_key);
> > > > > +bool qcom_ice_hwkm_supported(struct qcom_ice *ice) {  return
> > > > > +ice->use_hwkm; }
> > EXPORT_SYMBOL_GPL(qcom_ice_hwkm_supported);
> > > > > +
> > > > >   static struct qcom_ice *qcom_ice_create(struct device *dev,
> > > > >                                           void __iomem *base)
> > > > >   {
> > > > > @@ -240,6 +383,7 @@ static struct qcom_ice *qcom_ice_create(struct
> > device *dev,
> > > > >                   engine->core_clk = devm_clk_get_enabled(dev, NULL);
> > > > >           if (IS_ERR(engine->core_clk))
> > > > >                   return ERR_CAST(engine->core_clk);
> > > > > + engine->use_hwkm = qcom_scm_has_wrapped_key_support();
> > > >
> > > > This still makes the decision on whether to use HW-wrapped keys on
> > > > behalf of a user. I suppose this is incorrect. The user must be able
> > > > to use raw keys even if HW-wrapped keys are available on the
> > > > platform. One of the examples for such use-cases is if a user
> > > > prefers to be able to recover stored information in case of a device
> > > > failure (such recovery will be impossible if SoC is damaged and HW-
> > wrapped keys are used).
> > >
> > > Isn't that already the case ? the BLK_CRYPTO_KEY_TYPE_HW_WRAPPED
> > size
> > > is here to select HW-wrapped key, otherwise the ol' raw key is passed.
> > > Just look the next patch.
> > >
> > > Or did I miss something ?
> >
> > That's a good question. If use_hwkm is set, ICE gets programmed to use
> > hwkm (see qcom_ice_hwkm_init() call above). I'm not sure if it is expected
> > to work properly if after such a call we pass raw key.
> >
>
> Once ICE has moved to a HWKM mode, the firmware key programming currently does not support raw keys.
> This support is being added for the next Qualcomm chipset in Trustzone to support both at he same time, but that will take another year or two to hit the market.
> Until that time, due to TZ (firmware) limitations , the driver can only support one or the other.
>
> We also cannot keep moving ICE modes, due to the HWKM enablement being a one-time configurable value at boot.

So the init of HWKM should be delayed until the point where the user
tells if HWKM or raw keys should be used.

>
> > >
> > > Neil
> > >
> > > >
> > > > >           if (!qcom_ice_check_supported(engine))
> > > > >                   return ERR_PTR(-EOPNOTSUPP); diff --git
> > > > > a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h index
> > > > > 9dd835dba2a7..1f52e82e3e1c 100644
> > > > > --- a/include/soc/qcom/ice.h
> > > > > +++ b/include/soc/qcom/ice.h
> > > > > @@ -34,5 +34,6 @@ int qcom_ice_program_key(struct qcom_ice *ice,
> > > > >                            const struct blk_crypto_key *bkey,
> > > > >                            u8 data_unit_size, int slot);
> > > > >   int qcom_ice_evict_key(struct qcom_ice *ice, int slot);
> > > > > +bool qcom_ice_hwkm_supported(struct qcom_ice *ice);
> > > > >   struct qcom_ice *of_qcom_ice_get(struct device *dev);
> > > > >   #endif /* __QCOM_ICE_H__ */
> > > > >
> > > > > --
> > > > > 2.43.0
> > > > >
> > > >
> > >
> >
> > --
> > With best wishes
> > Dmitry
>
> Regards,
> Gaurav



-- 
With best wishes
Dmitry

