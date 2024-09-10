Return-Path: <linux-fsdevel+bounces-28969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AF1972669
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 02:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39185285E2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 00:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09837E101;
	Tue, 10 Sep 2024 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ehxsuuz1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456696CDC8;
	Tue, 10 Sep 2024 00:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725929510; cv=none; b=jJuSeK1w0jyJAdkU9N8TGF/8C+W9LiaTHNu79MSVmhW9dmy2v4xCgA3xI2rsKAa32DfCZV3GW6ReLOwmw8rm9m4EtbA02qPRGcHwWjAhnnh9vgOyKR1jhFdJdm7vD9QyDII+eoyEQKk2tMglYzgZ4fdpIRbEiQDr/sMieLPq5Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725929510; c=relaxed/simple;
	bh=Csud0RlnT8anqQHc+ZyO/EriLFaA42PrHHzw0yHBLTE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GONtSH0YG2CwszQwm3u9+PvnG8M1fhE4BGEBxmBygpYDrIjY7WYgatq+O3LsB9LX99ok5hiAurN3nxAg7gelqluz9ByYlTEnVuTb/RhwY89vBUk1wvOFaRnGJXDNOpu+9rfUmqN3rRCjYUiEXHNW47h4ocimRaZusiMiypYuV1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ehxsuuz1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489DRRc4020315;
	Tue, 10 Sep 2024 00:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4oKJPKyj6ZvcvxK2qU5p0TjHabQ19gP7gUp081B6C18=; b=ehxsuuz1bDpMQpPF
	zRBpvPc8/fYHOhEz2iEXiboyDzIOmSfCRQe265TkDmzZ458PjP0T8p4KJzSIzZ5e
	Pt+X+CwKhskaGHVs7TUCZvsepOW7HNvpegUJjORRI7xlx8QYX2Zz3RPnZ4cbcQdW
	qAfW3yEaSJ2rUPc7Dg6s1lx3MMm7XOSiniWUt/Pf79LMY6btPTM2cI/2q1AKlt1d
	tepVi0hjlgsdFMRXDlC4HnrgHOUYFvBsNPu4rt1isv+wvyLh+ve6wxbmKv8RTHrP
	CqCi8wTqU+WFPwoqtCnq8g9A+7YdWZd2LkYjNFa5anstKG541NYP71MUMrsS3Xhn
	xlAXXg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41he5duhdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 00:51:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48A0pJGp011420
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 00:51:19 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Sep 2024 17:51:19 -0700
Received: from nalasex01a.na.qualcomm.com ([fe80::d989:a8e3:9d0f:9869]) by
 nalasex01a.na.qualcomm.com ([fe80::d989:a8e3:9d0f:9869%4]) with mapi id
 15.02.1544.009; Mon, 9 Sep 2024 17:51:19 -0700
From: "Gaurav Kashyap (QUIC)" <quic_gaurkash@quicinc.com>
To: "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "Neil
 Armstrong" <neil.armstrong@linaro.org>
CC: Bartosz Golaszewski <brgl@bgdev.pl>, Jens Axboe <axboe@kernel.dk>,
        Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
        "Mike
 Snitzer" <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "Adrian
 Hunter" <adrian.hunter@intel.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley"
	<James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen"
	<martin.petersen@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Theodore
 Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Alexander Viro
	<viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>,
        "Gaurav Kashyap (QUIC)"
	<quic_gaurkash@quicinc.com>,
        "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "dm-devel@lists.linux.dev"
	<dm-devel@lists.linux.dev>,
        "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>,
        "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>,
        "linux-fscrypt@vger.kernel.org"
	<linux-fscrypt@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>,
        bartosz.golaszewski
	<bartosz.golaszewski@linaro.org>
Subject: RE: [PATCH v6 09/17] soc: qcom: ice: add HWKM support to the ICE
 driver
Thread-Topic: [PATCH v6 09/17] soc: qcom: ice: add HWKM support to the ICE
 driver
Thread-Index: AQHbAIeyLfp38xTz0EaUtiNODewOx7JLxo0AgAPangCAAAy4AIAA/Xzw
Date: Tue, 10 Sep 2024 00:51:18 +0000
Message-ID: <98cc8d71d5d9476297a54774c382030d@quicinc.com>
References: <20240906-wrapped-keys-v6-0-d59e61bc0cb4@linaro.org>
 <20240906-wrapped-keys-v6-9-d59e61bc0cb4@linaro.org>
 <7uoq72bpiqmo2olwpnudpv3gtcowpnd6jrifff34ubmfpijgc6@k6rmnalu5z4o>
 <66953e65-2468-43b8-9ccf-54671613c4ab@linaro.org>
 <ivibs6qqxhbikaevys3iga7s73xq6dzq3u43gwjri3lozkrblx@jxlmwe5wiq7e>
In-Reply-To: <ivibs6qqxhbikaevys3iga7s73xq6dzq3u43gwjri3lozkrblx@jxlmwe5wiq7e>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QH7Gmo-QPx85xU5L5kGW3w4npqSQk_1K
X-Proofpoint-GUID: QH7Gmo-QPx85xU5L5kGW3w4npqSQk_1K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409100004

Hello Dmitry and Neil

On Monday, September 9, 2024 2:44 AM PDT, Dmitry Baryshkov wrote:
> On Mon, Sep 09, 2024 at 10:58:30AM GMT, Neil Armstrong wrote:
> > On 07/09/2024 00:07, Dmitry Baryshkov wrote:
> > > On Fri, Sep 06, 2024 at 08:07:12PM GMT, Bartosz Golaszewski wrote:
> > > > From: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> > > >
> > > > Qualcomm's ICE (Inline Crypto Engine) contains a proprietary key
> > > > management hardware called Hardware Key Manager (HWKM). Add
> HWKM
> > > > support to the ICE driver if it is available on the platform. HWKM
> > > > primarily provides hardware wrapped key support where the ICE
> > > > (storage) keys are not available in software and instead protected =
in
> hardware.
> > > >
> > > > When HWKM software support is not fully available (from
> > > > Trustzone), there can be a scenario where the ICE hardware
> > > > supports HWKM, but it cannot be used for wrapped keys. In this
> > > > case, raw keys have to be used without using the HWKM. We query
> > > > the TZ at run-time to find out whether wrapped keys support is
> available.
> > > >
> > > > Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > > Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> > > > Signed-off-by: Bartosz Golaszewski
> > > > <bartosz.golaszewski@linaro.org>
> > > > ---
> > > >   drivers/soc/qcom/ice.c | 152
> +++++++++++++++++++++++++++++++++++++++++++++++--
> > > >   include/soc/qcom/ice.h |   1 +
> > > >   2 files changed, 149 insertions(+), 4 deletions(-)
> > > >
> > > >   int qcom_ice_enable(struct qcom_ice *ice)
> > > >   {
> > > > + int err;
> > > > +
> > > >           qcom_ice_low_power_mode_enable(ice);
> > > >           qcom_ice_optimization_enable(ice);
> > > > - return qcom_ice_wait_bist_status(ice);
> > > > + if (ice->use_hwkm)
> > > > +         qcom_ice_enable_standard_mode(ice);
> > > > +
> > > > + err =3D qcom_ice_wait_bist_status(ice); if (err)
> > > > +         return err;
> > > > +
> > > > + if (ice->use_hwkm)
> > > > +         qcom_ice_hwkm_init(ice);
> > > > +
> > > > + return err;
> > > >   }
> > > >   EXPORT_SYMBOL_GPL(qcom_ice_enable);
> > > > @@ -150,6 +282,10 @@ int qcom_ice_resume(struct qcom_ice *ice)
> > > >                   return err;
> > > >           }
> > > > + if (ice->use_hwkm) {
> > > > +         qcom_ice_enable_standard_mode(ice);
> > > > +         qcom_ice_hwkm_init(ice); }
> > > >           return qcom_ice_wait_bist_status(ice);
> > > >   }
> > > >   EXPORT_SYMBOL_GPL(qcom_ice_resume);
> > > > @@ -157,6 +293,7 @@ EXPORT_SYMBOL_GPL(qcom_ice_resume);
> > > >   int qcom_ice_suspend(struct qcom_ice *ice)
> > > >   {
> > > >           clk_disable_unprepare(ice->core_clk);
> > > > + ice->hwkm_init_complete =3D false;
> > > >           return 0;
> > > >   }
> > > > @@ -206,6 +343,12 @@ int qcom_ice_evict_key(struct qcom_ice *ice,
> int slot)
> > > >   }
> > > >   EXPORT_SYMBOL_GPL(qcom_ice_evict_key);
> > > > +bool qcom_ice_hwkm_supported(struct qcom_ice *ice) {  return
> > > > +ice->use_hwkm; }
> EXPORT_SYMBOL_GPL(qcom_ice_hwkm_supported);
> > > > +
> > > >   static struct qcom_ice *qcom_ice_create(struct device *dev,
> > > >                                           void __iomem *base)
> > > >   {
> > > > @@ -240,6 +383,7 @@ static struct qcom_ice *qcom_ice_create(struct
> device *dev,
> > > >                   engine->core_clk =3D devm_clk_get_enabled(dev, NU=
LL);
> > > >           if (IS_ERR(engine->core_clk))
> > > >                   return ERR_CAST(engine->core_clk);
> > > > + engine->use_hwkm =3D qcom_scm_has_wrapped_key_support();
> > >
> > > This still makes the decision on whether to use HW-wrapped keys on
> > > behalf of a user. I suppose this is incorrect. The user must be able
> > > to use raw keys even if HW-wrapped keys are available on the
> > > platform. One of the examples for such use-cases is if a user
> > > prefers to be able to recover stored information in case of a device
> > > failure (such recovery will be impossible if SoC is damaged and HW-
> wrapped keys are used).
> >
> > Isn't that already the case ? the BLK_CRYPTO_KEY_TYPE_HW_WRAPPED
> size
> > is here to select HW-wrapped key, otherwise the ol' raw key is passed.
> > Just look the next patch.
> >
> > Or did I miss something ?
>=20
> That's a good question. If use_hwkm is set, ICE gets programmed to use
> hwkm (see qcom_ice_hwkm_init() call above). I'm not sure if it is expecte=
d
> to work properly if after such a call we pass raw key.
>=20

Once ICE has moved to a HWKM mode, the firmware key programming currently d=
oes not support raw keys.
This support is being added for the next Qualcomm chipset in Trustzone to s=
upport both at he same time, but that will take another year or two to hit =
the market.
Until that time, due to TZ (firmware) limitations , the driver can only sup=
port one or the other.

We also cannot keep moving ICE modes, due to the HWKM enablement being a on=
e-time configurable value at boot.

> >
> > Neil
> >
> > >
> > > >           if (!qcom_ice_check_supported(engine))
> > > >                   return ERR_PTR(-EOPNOTSUPP); diff --git
> > > > a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h index
> > > > 9dd835dba2a7..1f52e82e3e1c 100644
> > > > --- a/include/soc/qcom/ice.h
> > > > +++ b/include/soc/qcom/ice.h
> > > > @@ -34,5 +34,6 @@ int qcom_ice_program_key(struct qcom_ice *ice,
> > > >                            const struct blk_crypto_key *bkey,
> > > >                            u8 data_unit_size, int slot);
> > > >   int qcom_ice_evict_key(struct qcom_ice *ice, int slot);
> > > > +bool qcom_ice_hwkm_supported(struct qcom_ice *ice);
> > > >   struct qcom_ice *of_qcom_ice_get(struct device *dev);
> > > >   #endif /* __QCOM_ICE_H__ */
> > > >
> > > > --
> > > > 2.43.0
> > > >
> > >
> >
>=20
> --
> With best wishes
> Dmitry

Regards,
Gaurav

