Return-Path: <linux-fsdevel+bounces-29237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE0A9774F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 01:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2D41C24221
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 23:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C9E1C7B67;
	Thu, 12 Sep 2024 23:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxnUtKpV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C841C331F;
	Thu, 12 Sep 2024 23:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183058; cv=none; b=NfR5F9EsaDiP1E3L/+eGXNwH+U7mRPs0C8fx44+2YavcqnEfxz2ka7Q75YkBIPMeLw2JtLfeiQIrZOG5G54gKisnrFUiRsl1iwDtY+pet74EuFYMV9f8JiylEoZCfsHzX2jPOJNENQ1sYP04nuDsb3JOvO7sd1lWV5gn+Va6m5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183058; c=relaxed/simple;
	bh=YaJo61HhL8bk4+3Kg/wrh9laHfa8R3LG7ANDKpkQ1SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOVl5VLHIg4lymfhpAZ3ombKD3OXnPDPTdiyz02J748nF08hhNOfmFGDPxeuDrKsZJih4IcvtIIHTqrimQHRfP5vcxxEh8AA9s1WTThL8Jkl4NzZ9Fi3ru+wezi0lH8UFZeVHJrPaaVsxyzY1NnL32d1nzo5Y4+y/vWKCjGgAec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxnUtKpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270E5C4CECD;
	Thu, 12 Sep 2024 23:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726183058;
	bh=YaJo61HhL8bk4+3Kg/wrh9laHfa8R3LG7ANDKpkQ1SM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gxnUtKpVVS5HqpyPN5WrtAQXu5LD/5LZyBYiQh8/YFL6Legocdv6B23rt/7ZWyYvz
	 2jFQa+FLlbL/+mg6mzZaDQwua3jAEnh4sZ2RWWrMcIWH3lmiQ2mnlaLOpMcq2ojJn1
	 f1JyqYyd1pobctkKLih5PUPqusrYMOIdZmmf9BYtuXAlWdKZ7ZNocpQJuUlC7DN28v
	 4H3pPpF6Mgt04GLYm+7YccLbnKjyajD4VdoUiMxgCfhIQ6/CQCGjAkO6ymaAj+7e1z
	 xyCJTXdPMxXcZuwrR5PglRMFje4EmJee0Dk0/3sCyJjyqwdWDDsOv84I7aZEnxIUBz
	 pa4MzXMCDQo0A==
Date: Thu, 12 Sep 2024 23:17:35 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: "Gaurav Kashyap (QUIC)" <quic_gaurkash@quicinc.com>
Cc: "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Asutosh Das <quic_asutoshd@quicinc.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
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
Subject: Re: [PATCH v6 09/17] soc: qcom: ice: add HWKM support to the ICE
 driver
Message-ID: <20240912231735.GA2211970@google.com>
References: <20240906-wrapped-keys-v6-0-d59e61bc0cb4@linaro.org>
 <20240906-wrapped-keys-v6-9-d59e61bc0cb4@linaro.org>
 <7uoq72bpiqmo2olwpnudpv3gtcowpnd6jrifff34ubmfpijgc6@k6rmnalu5z4o>
 <66953e65-2468-43b8-9ccf-54671613c4ab@linaro.org>
 <ivibs6qqxhbikaevys3iga7s73xq6dzq3u43gwjri3lozkrblx@jxlmwe5wiq7e>
 <98cc8d71d5d9476297a54774c382030d@quicinc.com>
 <CAA8EJpp_HY+YmMCRwdteeAHnSHtjuHb=nFar60O_PwLwjk0mNA@mail.gmail.com>
 <9bd0c9356e2b471385bcb2780ff2425b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bd0c9356e2b471385bcb2780ff2425b@quicinc.com>

On Thu, Sep 12, 2024 at 10:17:03PM +0000, Gaurav Kashyap (QUIC) wrote:
> 
> On Monday, September 9, 2024 11:29 PM PDT, Dmitry Baryshkov wrote:
> > On Tue, 10 Sept 2024 at 03:51, Gaurav Kashyap (QUIC)
> > <quic_gaurkash@quicinc.com> wrote:
> > >
> > > Hello Dmitry and Neil
> > >
> > > On Monday, September 9, 2024 2:44 AM PDT, Dmitry Baryshkov wrote:
> > > > On Mon, Sep 09, 2024 at 10:58:30AM GMT, Neil Armstrong wrote:
> > > > > On 07/09/2024 00:07, Dmitry Baryshkov wrote:
> > > > > > On Fri, Sep 06, 2024 at 08:07:12PM GMT, Bartosz Golaszewski wrote:
> > > > > > > From: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> > > > > > >
> > > > > > > Qualcomm's ICE (Inline Crypto Engine) contains a proprietary
> > > > > > > key management hardware called Hardware Key Manager (HWKM).
> > > > > > > Add
> > > > HWKM
> > > > > > > support to the ICE driver if it is available on the platform.
> > > > > > > HWKM primarily provides hardware wrapped key support where
> > the
> > > > > > > ICE
> > > > > > > (storage) keys are not available in software and instead
> > > > > > > protected in
> > > > hardware.
> > > > > > >
> > > > > > > When HWKM software support is not fully available (from
> > > > > > > Trustzone), there can be a scenario where the ICE hardware
> > > > > > > supports HWKM, but it cannot be used for wrapped keys. In this
> > > > > > > case, raw keys have to be used without using the HWKM. We
> > > > > > > query the TZ at run-time to find out whether wrapped keys
> > > > > > > support is
> > > > available.
> > > > > > >
> > > > > > > Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > > > > > Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> > > > > > > Signed-off-by: Bartosz Golaszewski
> > > > > > > <bartosz.golaszewski@linaro.org>
> > > > > > > ---
> > > > > > >   drivers/soc/qcom/ice.c | 152
> > > > +++++++++++++++++++++++++++++++++++++++++++++++--
> > > > > > >   include/soc/qcom/ice.h |   1 +
> > > > > > >   2 files changed, 149 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > >   int qcom_ice_enable(struct qcom_ice *ice)
> > > > > > >   {
> > > > > > > + int err;
> > > > > > > +
> > > > > > >           qcom_ice_low_power_mode_enable(ice);
> > > > > > >           qcom_ice_optimization_enable(ice);
> > > > > > > - return qcom_ice_wait_bist_status(ice);
> > > > > > > + if (ice->use_hwkm)
> > > > > > > +         qcom_ice_enable_standard_mode(ice);
> > > > > > > +
> > > > > > > + err = qcom_ice_wait_bist_status(ice); if (err)
> > > > > > > +         return err;
> > > > > > > +
> > > > > > > + if (ice->use_hwkm)
> > > > > > > +         qcom_ice_hwkm_init(ice);
> > > > > > > +
> > > > > > > + return err;
> > > > > > >   }
> > > > > > >   EXPORT_SYMBOL_GPL(qcom_ice_enable);
> > > > > > > @@ -150,6 +282,10 @@ int qcom_ice_resume(struct qcom_ice
> > *ice)
> > > > > > >                   return err;
> > > > > > >           }
> > > > > > > + if (ice->use_hwkm) {
> > > > > > > +         qcom_ice_enable_standard_mode(ice);
> > > > > > > +         qcom_ice_hwkm_init(ice); }
> > > > > > >           return qcom_ice_wait_bist_status(ice);
> > > > > > >   }
> > > > > > >   EXPORT_SYMBOL_GPL(qcom_ice_resume);
> > > > > > > @@ -157,6 +293,7 @@ EXPORT_SYMBOL_GPL(qcom_ice_resume);
> > > > > > >   int qcom_ice_suspend(struct qcom_ice *ice)
> > > > > > >   {
> > > > > > >           clk_disable_unprepare(ice->core_clk);
> > > > > > > + ice->hwkm_init_complete = false;
> > > > > > >           return 0;
> > > > > > >   }
> > > > > > > @@ -206,6 +343,12 @@ int qcom_ice_evict_key(struct qcom_ice
> > > > > > > *ice,
> > > > int slot)
> > > > > > >   }
> > > > > > >   EXPORT_SYMBOL_GPL(qcom_ice_evict_key);
> > > > > > > +bool qcom_ice_hwkm_supported(struct qcom_ice *ice) {  return
> > > > > > > +ice->use_hwkm; }
> > > > EXPORT_SYMBOL_GPL(qcom_ice_hwkm_supported);
> > > > > > > +
> > > > > > >   static struct qcom_ice *qcom_ice_create(struct device *dev,
> > > > > > >                                           void __iomem *base)
> > > > > > >   {
> > > > > > > @@ -240,6 +383,7 @@ static struct qcom_ice
> > > > > > > *qcom_ice_create(struct
> > > > device *dev,
> > > > > > >                   engine->core_clk = devm_clk_get_enabled(dev, NULL);
> > > > > > >           if (IS_ERR(engine->core_clk))
> > > > > > >                   return ERR_CAST(engine->core_clk);
> > > > > > > + engine->use_hwkm = qcom_scm_has_wrapped_key_support();
> > > > > >
> > > > > > This still makes the decision on whether to use HW-wrapped keys
> > > > > > on behalf of a user. I suppose this is incorrect. The user must
> > > > > > be able to use raw keys even if HW-wrapped keys are available on
> > > > > > the platform. One of the examples for such use-cases is if a
> > > > > > user prefers to be able to recover stored information in case of
> > > > > > a device failure (such recovery will be impossible if SoC is
> > > > > > damaged and HW-
> > > > wrapped keys are used).
> > > > >
> > > > > Isn't that already the case ? the
> > BLK_CRYPTO_KEY_TYPE_HW_WRAPPED
> > > > size
> > > > > is here to select HW-wrapped key, otherwise the ol' raw key is passed.
> > > > > Just look the next patch.
> > > > >
> > > > > Or did I miss something ?
> > > >
> > > > That's a good question. If use_hwkm is set, ICE gets programmed to
> > > > use hwkm (see qcom_ice_hwkm_init() call above). I'm not sure if it
> > > > is expected to work properly if after such a call we pass raw key.
> > > >
> > >
> > > Once ICE has moved to a HWKM mode, the firmware key programming
> > currently does not support raw keys.
> > > This support is being added for the next Qualcomm chipset in Trustzone to
> > support both at he same time, but that will take another year or two to hit
> > the market.
> > > Until that time, due to TZ (firmware) limitations , the driver can only
> > support one or the other.
> > >
> > > We also cannot keep moving ICE modes, due to the HWKM enablement
> > being a one-time configurable value at boot.
> > 
> > So the init of HWKM should be delayed until the point where the user tells if
> > HWKM or raw keys should be used.
> 
> Ack.
> I'll work with Bartosz to look into moving to HWKM mode only during the first key program request
> 

That would mean the driver would have to initially advertise support for both
HW-wrapped keys and raw keys, and then it would revoke the support for one of
them later (due to the other one being used).  However, runtime revocation of
crypto capabilities is not supported by the blk-crypto framework
(Documentation/block/inline-encryption.rst), and there is no clear path to
adding such support.  Upper layers may have already checked the crypto
capabilities and decided to use them.  It's too late to find out that the
support was revoked in the middle of an I/O request.  Upper layer code
(blk-crypto, fscrypt, etc.) is not prepared for this.  And even if it was, the
best it could do is cleanly fail the I/O, which is too late as e.g. it may
happen during background writeback and cause user data to be thrown away.

So, the choice of support for HW-wrapped vs. raw will need to be made ahead of
time, rather than being implicitly set by the first use.  That is most easily
done using a module parameter like qcom_ice.hw_wrapped_keys=1.  Yes, it's a bit
inconvenient, but there's no realistic way around this currently.

- Eric

