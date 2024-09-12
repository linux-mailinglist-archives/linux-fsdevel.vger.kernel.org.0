Return-Path: <linux-fsdevel+bounces-29226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD24977438
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 00:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4341F252C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 22:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ABB1C32EC;
	Thu, 12 Sep 2024 22:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SIsZM924"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D3E1C174B;
	Thu, 12 Sep 2024 22:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726179454; cv=none; b=L/xUuTWO6XaGVos+akvNg9ZCDzM15dPUS92i5Doiz/Q+HYuHsJzNypRQ1y4ZuHY1ebI7Mvf2d9zyo3L2DAo+2PDI643DycIdmgxUtwyBKDLLleGmyeZSlDVK2ThugNKNMVt7pBX2EW4rhI7cEmXd4BlnTHDANIKEvyUk7Fk8IMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726179454; c=relaxed/simple;
	bh=djsXfsdiTpWXfqTuq417uuzaiBveUzFpyYvLIhztgFM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q6MUa6swK5BUnsWiAaLICeRtD3PyOYaCRAPHrombF4seQZZMoxlZbS6I+vFHMn+AouBx2MSCyyurXHgqqFcQXpiGQOMuri3uVf5sXDcXfMlG0bjek0A4EPcH6GIM4TfstkkwtHytO6Vtrre2aolV7oDW/stJXbaNu5bRnJyEhXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SIsZM924; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CMBuvn013065;
	Thu, 12 Sep 2024 22:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	djsXfsdiTpWXfqTuq417uuzaiBveUzFpyYvLIhztgFM=; b=SIsZM924BW4fFZZT
	bF26l7D8+7rMLItlJbdBmrBqHIqgfZkTR1rxOKoCe6MaVPn0VNmvcuTRYeW3sqDD
	B/jQzkMqw8DiYk5ntQPR/hAMfvjIblbFCH78EgDEGHWMRS+h9vh2u2u26d/rMvGb
	iAPtokFqPCm8DUZ0texRwLEN2l/ezbnfwluZei0kdswQn4FE1PQ1sUdndQUDfnW4
	LSaMGD6qrNh2KZpn+EXswIzAI/qfBpSkeZVfIY7S3VFoS93RhfTUnf1FK8zLkyNM
	+y9WCJ4NiknZn75gABLCywUni2awWK4FCjSstjfVBYzBW5PMiTNy52r8IdXSn8p3
	oLkjHA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy51eq9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 22:17:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48CMH4fC016986
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 22:17:04 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Sep 2024 15:17:03 -0700
Received: from nalasex01a.na.qualcomm.com ([fe80::d989:a8e3:9d0f:9869]) by
 nalasex01a.na.qualcomm.com ([fe80::d989:a8e3:9d0f:9869%4]) with mapi id
 15.02.1544.009; Thu, 12 Sep 2024 15:17:03 -0700
From: "Gaurav Kashyap (QUIC)" <quic_gaurkash@quicinc.com>
To: "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "Gaurav
 Kashyap (QUIC)" <quic_gaurkash@quicinc.com>
CC: Neil Armstrong <neil.armstrong@linaro.org>,
        Bartosz Golaszewski
	<brgl@bgdev.pl>, Jens Axboe <axboe@kernel.dk>,
        Jonathan Corbet
	<corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer
	<snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Adrian Hunter
	<adrian.hunter@intel.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Ritesh
 Harjani" <ritesh.list@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Alim
 Akhtar" <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "Bart
 Van Assche" <bvanassche@acm.org>,
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
Thread-Index: AQHbAIeyLfp38xTz0EaUtiNODewOx7JLxo0AgAPangCAAAy4AIAA/XzwgABeWICABC2NgA==
Date: Thu, 12 Sep 2024 22:17:03 +0000
Message-ID: <9bd0c9356e2b471385bcb2780ff2425b@quicinc.com>
References: <20240906-wrapped-keys-v6-0-d59e61bc0cb4@linaro.org>
 <20240906-wrapped-keys-v6-9-d59e61bc0cb4@linaro.org>
 <7uoq72bpiqmo2olwpnudpv3gtcowpnd6jrifff34ubmfpijgc6@k6rmnalu5z4o>
 <66953e65-2468-43b8-9ccf-54671613c4ab@linaro.org>
 <ivibs6qqxhbikaevys3iga7s73xq6dzq3u43gwjri3lozkrblx@jxlmwe5wiq7e>
 <98cc8d71d5d9476297a54774c382030d@quicinc.com>
 <CAA8EJpp_HY+YmMCRwdteeAHnSHtjuHb=nFar60O_PwLwjk0mNA@mail.gmail.com>
In-Reply-To: <CAA8EJpp_HY+YmMCRwdteeAHnSHtjuHb=nFar60O_PwLwjk0mNA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5DuWQYTI-SuNT7fFaCe6avs3DaXnNRcH
X-Proofpoint-GUID: 5DuWQYTI-SuNT7fFaCe6avs3DaXnNRcH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409120159

DQpPbiBNb25kYXksIFNlcHRlbWJlciA5LCAyMDI0IDExOjI5IFBNIFBEVCwgRG1pdHJ5IEJhcnlz
aGtvdiB3cm90ZToNCj4gT24gVHVlLCAxMCBTZXB0IDIwMjQgYXQgMDM6NTEsIEdhdXJhdiBLYXNo
eWFwIChRVUlDKQ0KPiA8cXVpY19nYXVya2FzaEBxdWljaW5jLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBIZWxsbyBEbWl0cnkgYW5kIE5laWwNCj4gPg0KPiA+IE9uIE1vbmRheSwgU2VwdGVtYmVyIDks
IDIwMjQgMjo0NCBBTSBQRFQsIERtaXRyeSBCYXJ5c2hrb3Ygd3JvdGU6DQo+ID4gPiBPbiBNb24s
IFNlcCAwOSwgMjAyNCBhdCAxMDo1ODozMEFNIEdNVCwgTmVpbCBBcm1zdHJvbmcgd3JvdGU6DQo+
ID4gPiA+IE9uIDA3LzA5LzIwMjQgMDA6MDcsIERtaXRyeSBCYXJ5c2hrb3Ygd3JvdGU6DQo+ID4g
PiA+ID4gT24gRnJpLCBTZXAgMDYsIDIwMjQgYXQgMDg6MDc6MTJQTSBHTVQsIEJhcnRvc3ogR29s
YXN6ZXdza2kgd3JvdGU6DQo+ID4gPiA+ID4gPiBGcm9tOiBHYXVyYXYgS2FzaHlhcCA8cXVpY19n
YXVya2FzaEBxdWljaW5jLmNvbT4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBRdWFsY29tbSdz
IElDRSAoSW5saW5lIENyeXB0byBFbmdpbmUpIGNvbnRhaW5zIGEgcHJvcHJpZXRhcnkNCj4gPiA+
ID4gPiA+IGtleSBtYW5hZ2VtZW50IGhhcmR3YXJlIGNhbGxlZCBIYXJkd2FyZSBLZXkgTWFuYWdl
ciAoSFdLTSkuDQo+ID4gPiA+ID4gPiBBZGQNCj4gPiA+IEhXS00NCj4gPiA+ID4gPiA+IHN1cHBv
cnQgdG8gdGhlIElDRSBkcml2ZXIgaWYgaXQgaXMgYXZhaWxhYmxlIG9uIHRoZSBwbGF0Zm9ybS4N
Cj4gPiA+ID4gPiA+IEhXS00gcHJpbWFyaWx5IHByb3ZpZGVzIGhhcmR3YXJlIHdyYXBwZWQga2V5
IHN1cHBvcnQgd2hlcmUNCj4gdGhlDQo+ID4gPiA+ID4gPiBJQ0UNCj4gPiA+ID4gPiA+IChzdG9y
YWdlKSBrZXlzIGFyZSBub3QgYXZhaWxhYmxlIGluIHNvZnR3YXJlIGFuZCBpbnN0ZWFkDQo+ID4g
PiA+ID4gPiBwcm90ZWN0ZWQgaW4NCj4gPiA+IGhhcmR3YXJlLg0KPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+IFdoZW4gSFdLTSBzb2Z0d2FyZSBzdXBwb3J0IGlzIG5vdCBmdWxseSBhdmFpbGFibGUg
KGZyb20NCj4gPiA+ID4gPiA+IFRydXN0em9uZSksIHRoZXJlIGNhbiBiZSBhIHNjZW5hcmlvIHdo
ZXJlIHRoZSBJQ0UgaGFyZHdhcmUNCj4gPiA+ID4gPiA+IHN1cHBvcnRzIEhXS00sIGJ1dCBpdCBj
YW5ub3QgYmUgdXNlZCBmb3Igd3JhcHBlZCBrZXlzLiBJbiB0aGlzDQo+ID4gPiA+ID4gPiBjYXNl
LCByYXcga2V5cyBoYXZlIHRvIGJlIHVzZWQgd2l0aG91dCB1c2luZyB0aGUgSFdLTS4gV2UNCj4g
PiA+ID4gPiA+IHF1ZXJ5IHRoZSBUWiBhdCBydW4tdGltZSB0byBmaW5kIG91dCB3aGV0aGVyIHdy
YXBwZWQga2V5cw0KPiA+ID4gPiA+ID4gc3VwcG9ydCBpcw0KPiA+ID4gYXZhaWxhYmxlLg0KPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRlc3RlZC1ieTogTmVpbCBBcm1zdHJvbmcgPG5laWwuYXJt
c3Ryb25nQGxpbmFyby5vcmc+DQo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBHYXVyYXYgS2Fz
aHlhcCA8cXVpY19nYXVya2FzaEBxdWljaW5jLmNvbT4NCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEJhcnRvc3ogR29sYXN6ZXdza2kNCj4gPiA+ID4gPiA+IDxiYXJ0b3N6LmdvbGFzemV3c2tp
QGxpbmFyby5vcmc+DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICAgZHJpdmVycy9zb2Mv
cWNvbS9pY2UuYyB8IDE1Mg0KPiA+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLQ0KPiA+ID4gPiA+ID4gICBpbmNsdWRlL3NvYy9xY29tL2ljZS5oIHwg
ICAxICsNCj4gPiA+ID4gPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxNDkgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAgIGludCBxY29tX2ljZV9l
bmFibGUoc3RydWN0IHFjb21faWNlICppY2UpDQo+ID4gPiA+ID4gPiAgIHsNCj4gPiA+ID4gPiA+
ICsgaW50IGVycjsNCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICAgICAgICAgICBxY29tX2lj
ZV9sb3dfcG93ZXJfbW9kZV9lbmFibGUoaWNlKTsNCj4gPiA+ID4gPiA+ICAgICAgICAgICBxY29t
X2ljZV9vcHRpbWl6YXRpb25fZW5hYmxlKGljZSk7DQo+ID4gPiA+ID4gPiAtIHJldHVybiBxY29t
X2ljZV93YWl0X2Jpc3Rfc3RhdHVzKGljZSk7DQo+ID4gPiA+ID4gPiArIGlmIChpY2UtPnVzZV9o
d2ttKQ0KPiA+ID4gPiA+ID4gKyAgICAgICAgIHFjb21faWNlX2VuYWJsZV9zdGFuZGFyZF9tb2Rl
KGljZSk7DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArIGVyciA9IHFjb21faWNlX3dhaXRf
YmlzdF9zdGF0dXMoaWNlKTsgaWYgKGVycikNCj4gPiA+ID4gPiA+ICsgICAgICAgICByZXR1cm4g
ZXJyOw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKyBpZiAoaWNlLT51c2VfaHdrbSkNCj4g
PiA+ID4gPiA+ICsgICAgICAgICBxY29tX2ljZV9od2ttX2luaXQoaWNlKTsNCj4gPiA+ID4gPiA+
ICsNCj4gPiA+ID4gPiA+ICsgcmV0dXJuIGVycjsNCj4gPiA+ID4gPiA+ICAgfQ0KPiA+ID4gPiA+
ID4gICBFWFBPUlRfU1lNQk9MX0dQTChxY29tX2ljZV9lbmFibGUpOw0KPiA+ID4gPiA+ID4gQEAg
LTE1MCw2ICsyODIsMTAgQEAgaW50IHFjb21faWNlX3Jlc3VtZShzdHJ1Y3QgcWNvbV9pY2UNCj4g
KmljZSkNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgIHJldHVybiBlcnI7DQo+ID4gPiA+
ID4gPiAgICAgICAgICAgfQ0KPiA+ID4gPiA+ID4gKyBpZiAoaWNlLT51c2VfaHdrbSkgew0KPiA+
ID4gPiA+ID4gKyAgICAgICAgIHFjb21faWNlX2VuYWJsZV9zdGFuZGFyZF9tb2RlKGljZSk7DQo+
ID4gPiA+ID4gPiArICAgICAgICAgcWNvbV9pY2VfaHdrbV9pbml0KGljZSk7IH0NCj4gPiA+ID4g
PiA+ICAgICAgICAgICByZXR1cm4gcWNvbV9pY2Vfd2FpdF9iaXN0X3N0YXR1cyhpY2UpOw0KPiA+
ID4gPiA+ID4gICB9DQo+ID4gPiA+ID4gPiAgIEVYUE9SVF9TWU1CT0xfR1BMKHFjb21faWNlX3Jl
c3VtZSk7DQo+ID4gPiA+ID4gPiBAQCAtMTU3LDYgKzI5Myw3IEBAIEVYUE9SVF9TWU1CT0xfR1BM
KHFjb21faWNlX3Jlc3VtZSk7DQo+ID4gPiA+ID4gPiAgIGludCBxY29tX2ljZV9zdXNwZW5kKHN0
cnVjdCBxY29tX2ljZSAqaWNlKQ0KPiA+ID4gPiA+ID4gICB7DQo+ID4gPiA+ID4gPiAgICAgICAg
ICAgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGljZS0+Y29yZV9jbGspOw0KPiA+ID4gPiA+ID4gKyBp
Y2UtPmh3a21faW5pdF9jb21wbGV0ZSA9IGZhbHNlOw0KPiA+ID4gPiA+ID4gICAgICAgICAgIHJl
dHVybiAwOw0KPiA+ID4gPiA+ID4gICB9DQo+ID4gPiA+ID4gPiBAQCAtMjA2LDYgKzM0MywxMiBA
QCBpbnQgcWNvbV9pY2VfZXZpY3Rfa2V5KHN0cnVjdCBxY29tX2ljZQ0KPiA+ID4gPiA+ID4gKmlj
ZSwNCj4gPiA+IGludCBzbG90KQ0KPiA+ID4gPiA+ID4gICB9DQo+ID4gPiA+ID4gPiAgIEVYUE9S
VF9TWU1CT0xfR1BMKHFjb21faWNlX2V2aWN0X2tleSk7DQo+ID4gPiA+ID4gPiArYm9vbCBxY29t
X2ljZV9od2ttX3N1cHBvcnRlZChzdHJ1Y3QgcWNvbV9pY2UgKmljZSkgeyAgcmV0dXJuDQo+ID4g
PiA+ID4gPiAraWNlLT51c2VfaHdrbTsgfQ0KPiA+ID4gRVhQT1JUX1NZTUJPTF9HUEwocWNvbV9p
Y2VfaHdrbV9zdXBwb3J0ZWQpOw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gICBzdGF0aWMg
c3RydWN0IHFjb21faWNlICpxY29tX2ljZV9jcmVhdGUoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+
ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCBf
X2lvbWVtICpiYXNlKQ0KPiA+ID4gPiA+ID4gICB7DQo+ID4gPiA+ID4gPiBAQCAtMjQwLDYgKzM4
Myw3IEBAIHN0YXRpYyBzdHJ1Y3QgcWNvbV9pY2UNCj4gPiA+ID4gPiA+ICpxY29tX2ljZV9jcmVh
dGUoc3RydWN0DQo+ID4gPiBkZXZpY2UgKmRldiwNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAg
ICAgIGVuZ2luZS0+Y29yZV9jbGsgPSBkZXZtX2Nsa19nZXRfZW5hYmxlZChkZXYsIE5VTEwpOw0K
PiA+ID4gPiA+ID4gICAgICAgICAgIGlmIChJU19FUlIoZW5naW5lLT5jb3JlX2NsaykpDQo+ID4g
PiA+ID4gPiAgICAgICAgICAgICAgICAgICByZXR1cm4gRVJSX0NBU1QoZW5naW5lLT5jb3JlX2Ns
ayk7DQo+ID4gPiA+ID4gPiArIGVuZ2luZS0+dXNlX2h3a20gPSBxY29tX3NjbV9oYXNfd3JhcHBl
ZF9rZXlfc3VwcG9ydCgpOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhpcyBzdGlsbCBtYWtlcyB0
aGUgZGVjaXNpb24gb24gd2hldGhlciB0byB1c2UgSFctd3JhcHBlZCBrZXlzDQo+ID4gPiA+ID4g
b24gYmVoYWxmIG9mIGEgdXNlci4gSSBzdXBwb3NlIHRoaXMgaXMgaW5jb3JyZWN0LiBUaGUgdXNl
ciBtdXN0DQo+ID4gPiA+ID4gYmUgYWJsZSB0byB1c2UgcmF3IGtleXMgZXZlbiBpZiBIVy13cmFw
cGVkIGtleXMgYXJlIGF2YWlsYWJsZSBvbg0KPiA+ID4gPiA+IHRoZSBwbGF0Zm9ybS4gT25lIG9m
IHRoZSBleGFtcGxlcyBmb3Igc3VjaCB1c2UtY2FzZXMgaXMgaWYgYQ0KPiA+ID4gPiA+IHVzZXIg
cHJlZmVycyB0byBiZSBhYmxlIHRvIHJlY292ZXIgc3RvcmVkIGluZm9ybWF0aW9uIGluIGNhc2Ug
b2YNCj4gPiA+ID4gPiBhIGRldmljZSBmYWlsdXJlIChzdWNoIHJlY292ZXJ5IHdpbGwgYmUgaW1w
b3NzaWJsZSBpZiBTb0MgaXMNCj4gPiA+ID4gPiBkYW1hZ2VkIGFuZCBIVy0NCj4gPiA+IHdyYXBw
ZWQga2V5cyBhcmUgdXNlZCkuDQo+ID4gPiA+DQo+ID4gPiA+IElzbid0IHRoYXQgYWxyZWFkeSB0
aGUgY2FzZSA/IHRoZQ0KPiBCTEtfQ1JZUFRPX0tFWV9UWVBFX0hXX1dSQVBQRUQNCj4gPiA+IHNp
emUNCj4gPiA+ID4gaXMgaGVyZSB0byBzZWxlY3QgSFctd3JhcHBlZCBrZXksIG90aGVyd2lzZSB0
aGUgb2wnIHJhdyBrZXkgaXMgcGFzc2VkLg0KPiA+ID4gPiBKdXN0IGxvb2sgdGhlIG5leHQgcGF0
Y2guDQo+ID4gPiA+DQo+ID4gPiA+IE9yIGRpZCBJIG1pc3Mgc29tZXRoaW5nID8NCj4gPiA+DQo+
ID4gPiBUaGF0J3MgYSBnb29kIHF1ZXN0aW9uLiBJZiB1c2VfaHdrbSBpcyBzZXQsIElDRSBnZXRz
IHByb2dyYW1tZWQgdG8NCj4gPiA+IHVzZSBod2ttIChzZWUgcWNvbV9pY2VfaHdrbV9pbml0KCkg
Y2FsbCBhYm92ZSkuIEknbSBub3Qgc3VyZSBpZiBpdA0KPiA+ID4gaXMgZXhwZWN0ZWQgdG8gd29y
ayBwcm9wZXJseSBpZiBhZnRlciBzdWNoIGEgY2FsbCB3ZSBwYXNzIHJhdyBrZXkuDQo+ID4gPg0K
PiA+DQo+ID4gT25jZSBJQ0UgaGFzIG1vdmVkIHRvIGEgSFdLTSBtb2RlLCB0aGUgZmlybXdhcmUg
a2V5IHByb2dyYW1taW5nDQo+IGN1cnJlbnRseSBkb2VzIG5vdCBzdXBwb3J0IHJhdyBrZXlzLg0K
PiA+IFRoaXMgc3VwcG9ydCBpcyBiZWluZyBhZGRlZCBmb3IgdGhlIG5leHQgUXVhbGNvbW0gY2hp
cHNldCBpbiBUcnVzdHpvbmUgdG8NCj4gc3VwcG9ydCBib3RoIGF0IGhlIHNhbWUgdGltZSwgYnV0
IHRoYXQgd2lsbCB0YWtlIGFub3RoZXIgeWVhciBvciB0d28gdG8gaGl0DQo+IHRoZSBtYXJrZXQu
DQo+ID4gVW50aWwgdGhhdCB0aW1lLCBkdWUgdG8gVFogKGZpcm13YXJlKSBsaW1pdGF0aW9ucyAs
IHRoZSBkcml2ZXIgY2FuIG9ubHkNCj4gc3VwcG9ydCBvbmUgb3IgdGhlIG90aGVyLg0KPiA+DQo+
ID4gV2UgYWxzbyBjYW5ub3Qga2VlcCBtb3ZpbmcgSUNFIG1vZGVzLCBkdWUgdG8gdGhlIEhXS00g
ZW5hYmxlbWVudA0KPiBiZWluZyBhIG9uZS10aW1lIGNvbmZpZ3VyYWJsZSB2YWx1ZSBhdCBib290
Lg0KPiANCj4gU28gdGhlIGluaXQgb2YgSFdLTSBzaG91bGQgYmUgZGVsYXllZCB1bnRpbCB0aGUg
cG9pbnQgd2hlcmUgdGhlIHVzZXIgdGVsbHMgaWYNCj4gSFdLTSBvciByYXcga2V5cyBzaG91bGQg
YmUgdXNlZC4NCg0KQWNrLg0KSSdsbCB3b3JrIHdpdGggQmFydG9zeiB0byBsb29rIGludG8gbW92
aW5nIHRvIEhXS00gbW9kZSBvbmx5IGR1cmluZyB0aGUgZmlyc3Qga2V5IHByb2dyYW0gcmVxdWVz
dA0KDQo+IA0KPiA+DQo+ID4gPiA+DQo+ID4gPiA+IE5laWwNCj4gPiA+ID4NCj4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gICAgICAgICAgIGlmICghcWNvbV9pY2VfY2hlY2tfc3VwcG9ydGVkKGVuZ2lu
ZSkpDQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRU9QTk9U
U1VQUCk7IGRpZmYgLS1naXQNCj4gPiA+ID4gPiA+IGEvaW5jbHVkZS9zb2MvcWNvbS9pY2UuaCBi
L2luY2x1ZGUvc29jL3Fjb20vaWNlLmggaW5kZXgNCj4gPiA+ID4gPiA+IDlkZDgzNWRiYTJhNy4u
MWY1MmU4MmUzZTFjIDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvaW5jbHVkZS9zb2MvcWNvbS9p
Y2UuaA0KPiA+ID4gPiA+ID4gKysrIGIvaW5jbHVkZS9zb2MvcWNvbS9pY2UuaA0KPiA+ID4gPiA+
ID4gQEAgLTM0LDUgKzM0LDYgQEAgaW50IHFjb21faWNlX3Byb2dyYW1fa2V5KHN0cnVjdCBxY29t
X2ljZQ0KPiAqaWNlLA0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgY29u
c3Qgc3RydWN0IGJsa19jcnlwdG9fa2V5ICpia2V5LA0KPiA+ID4gPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdTggZGF0YV91bml0X3NpemUsIGludCBzbG90KTsNCj4gPiA+ID4gPiA+
ICAgaW50IHFjb21faWNlX2V2aWN0X2tleShzdHJ1Y3QgcWNvbV9pY2UgKmljZSwgaW50IHNsb3Qp
Ow0KPiA+ID4gPiA+ID4gK2Jvb2wgcWNvbV9pY2VfaHdrbV9zdXBwb3J0ZWQoc3RydWN0IHFjb21f
aWNlICppY2UpOw0KPiA+ID4gPiA+ID4gICBzdHJ1Y3QgcWNvbV9pY2UgKm9mX3Fjb21faWNlX2dl
dChzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+ID4gPiA+ID4gICAjZW5kaWYgLyogX19RQ09NX0lD
RV9IX18gKi8NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAtLQ0KPiA+ID4gPiA+ID4gMi40My4w
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gLS0NCj4gPiA+
IFdpdGggYmVzdCB3aXNoZXMNCj4gPiA+IERtaXRyeQ0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBH
YXVyYXYNCj4gDQo+IA0KPiANCj4gLS0NCj4gV2l0aCBiZXN0IHdpc2hlcw0KPiBEbWl0cnkNCg0K
UmVnYXJkcywNCkdhdXJhdg0K

