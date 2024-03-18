Return-Path: <linux-fsdevel+bounces-14709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 601CC87E2FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 06:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA8EFB2189B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 05:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C6320DC3;
	Mon, 18 Mar 2024 05:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="j9MGtWFY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BCE22339
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 05:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710739350; cv=fail; b=O/mY1VEDmcxqss+ykb8z6rJ9ZcQg053taz9KojjVddlEzQaBwbu1E4Gx/Y+MiVf414kZzsEGu4+Hqu+NQR6KjbTRQKFrfc1t1lrgJcAsNcSJcbowUagBdCfr8YzQsTEni7mHYqkq+P8U8EkT9iEwoppUYHnft04Q9S+jPsmH8BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710739350; c=relaxed/simple;
	bh=2cxotguNhqg5IjeDU8nUGkFrzttsCG2jjRUoPC1cEIs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BM7Exw7IHce0mBgb0lZJ0GE2uYm/ORkO+clmMLfGA2vti3Qu1sQ0cMD4VHhCGI4hGzxxvXf8NEs3fCwtfJEj/wmO2Xw94sBH87kVnlDxx8JwJeAmtp4pEhZr4mauXWYlmDXB+nr8pjTL6767xVjX1R1v9TPWOmRQh/jdFN59B4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=j9MGtWFY; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42I5EI9u018209;
	Mon, 18 Mar 2024 05:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=2cxotguNhqg5IjeDU8nUGkFrzttsCG2jjRUoPC1cEIs=;
 b=j9MGtWFY+FbPiZWziN+OM3Tnx1MK+FdOOXqw15ot8l7I8GwvebsyqWUp0ZLVTdK9h3AQ
 RGvipaT8CplOCoFpjaYVSytnQioU3CAhAyMwFk6Y1JhLL7PXc6srWGhphlPvCmhi+ERY
 fyfiI8OyiPcSg7vJZttK3a8dABllI29unmUhwXkt0hYHoRwITs/dgkKm29hYjodRT0zq
 2PpEkN8/wGMClv+1DtDYELXRWx1D9T39YtgBbTlw1oTHdFOUMpqnXhNu5JoH7KI2pHOG
 Z4DK+3KQ1hNTMvljwVGdJcnUpi+pFaq3QkPWIN4UkQalj8ld5XFb/We0370TS64ImDQj 2g== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3ww3ts1fph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 05:22:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jzdo67qDXAazLoG7lKyuntyr7dLGW4LVpP8wPDbYzO8OqHVZTP0fGuDwKk5pLICoytmf5enaXkwtTvraL6LcOQUkIcYiVIJ//nvNlJUE5M8+2BBaYiA1qcgfo+TejnNHsbbCII+BFvT/ym46QFUgkQLdEimvV6jg1HTIbTV4MPskux+DGyULliaXDbYayQucQ7zG+R9kvxtuXBMMQwKnq+SdktMe4GsIpKC1tH0D0wy4uxdSKdxg1sGC+BN5QoRuKD/7qlpj5RGhWYVq83iVKceXIkJIXeBz1fjARFSZf+jg6S76hmZr3Z9lQeIbMWhjOZadgEK9pn2x3aS0YiTgtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cxotguNhqg5IjeDU8nUGkFrzttsCG2jjRUoPC1cEIs=;
 b=Jv3NMwkTHLkcuMSa6o4y9OXgw2M60tifa/EmGALleMHEq4bzrTWYZfz7HOk1kWs9n7fUoLYSfNEBpE3d58jOLKe7Bf2WQPZ4jjyyCxu20GGReFOLeqJ+/7a8+Hr/APP2t7DWiH7c+VxlnSoVAbp5JBNLJtVhiojlECbUM92ZqbiiieRnWd7T+aon2BpGD6lVXtla5mJ8UIoXnTiJTJAHkYRdD7BU5TN6d9f/NvH2OA0uETxs9dhQbZLc2K2qKe4ZbKv4MZq2kIquWDseHVVVclDAosEMoau1IfzXDr5bKteXb3gO+BNsFJ0fsfvKPYpOwKUn5KgUgg+e8aVe3ROX7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SI2PR04MB5895.apcprd04.prod.outlook.com (2603:1096:4:1eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 05:22:12 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::7414:91e1:bb61:1c8d]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::7414:91e1:bb61:1c8d%7]) with mapi id 15.20.7386.022; Mon, 18 Mar 2024
 05:22:12 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v4 08/10] exfat: remove unused functions
Thread-Topic: [PATCH v4 08/10] exfat: remove unused functions
Thread-Index: AdioqVU2JWS0suJNSvGQTvtgpxEVZnQSY7fw
Date: Mon, 18 Mar 2024 05:22:12 +0000
Message-ID: 
 <PUZPR04MB6316966FCD0851AADD623BB3812D2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SI2PR04MB5895:EE_
x-ms-office365-filtering-correlation-id: f1bb8146-0220-4e8e-5d84-08dc470b5e01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 nfCVTTFTo2yt0s7VtRiikPgee5JiSHiC5kxK/HeVYSoHgW9LZAGyDfdEBT+EQvDwr+gc4WswvxtiRkRqrWz/+yeTloZ9unWOqwBEY2Vo4y+7UmGky3ZY6RHozi/zaE2JYtt52wdGVboCXNnBvn/NsJcMi4rbSFpZg99N2iKfJnZT5UefAiPPTolWwHgB4WL0BNhwibFjP9dsKTWlN+qrMA5KD5MakFRCLLEctJRo6oQI4oHO9BMkytHVn1QRl6m9eLoPBGXbGJ3Cq7mRzhOFXFNmx6v+Hi5iXXKw5wcIAd2OcZWhRQQHvBj9m2jJ0oKAAnYmrLBGmVA0rFFkeP0Oplz2TxVD/dNnEb+GsrPaPLAsZNmzit0VfMQvwMtBQr99wlBGk5ZLvTzk5omKVCGbBKbA+BotvCqBahp7gtftEhCG0NbilXRAXYwm+CabE0H2mh0a1VaTcJlkXfCBTNFSN/JkwLeXpcbGlu3D1pU3mttMXw5hS7mVmfvL9zBZ69UQxIg2WbpI+SZciRkdce44ynl3kQWn3rHQFxZ1K3MoZdkW2eBU70OA4k8Pgy9Xynplo0qcujR8BkUk6Pp0h/SX+qzUUVcMmXm7PggG4sGHNCevEOxgTD7dWYkY+aOEGLC999RvocTI59UZIC5iuEo/td0QptbeUg1XViTFnnBV+Zp6JwhTDKH/1FkB+hBCnxiuQOOH90LVmic5r5isUmvpvZhR/+QAhNSeL2kSKRadWKE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aUpRdkxnSzhQSGpDa054MVUzaVFNa1E4Wjd6Sm15SThSNG0yWkRaemZ4U3Rk?=
 =?utf-8?B?alhtcWZTY3loczV2NU5GWnl0dGhROHhZSUtRTDd3SERmTDhJaHd1QzJsK0hJ?=
 =?utf-8?B?MnovaUdMMHVZTXhRYkxaY2twTjJIVTBDT0NQNVZMUXhjVEU3ZjVyWC9IV00w?=
 =?utf-8?B?NVAwNDF2ZkJnZ3pVTFk0ZGQ0em1WOURjL2J6RXljemdzeW9MYWI3R0lsSWEx?=
 =?utf-8?B?eHhGUkRUV3pML0l2ZExTRGJDUnFMUzBkczJGb0VJYk1tQmxHbWNIS3Q1aytI?=
 =?utf-8?B?WkhsMk51bEdRMHNEYTI3UURxVU9wZEE3RHJpOGsyWXh6cS9qZUlRNmJiZ1lD?=
 =?utf-8?B?M3hrYzVScWI3a290RHU1K0swV2QxQmJidEgyQkRnWDAvdzNIWmtsMlZ5L1Zy?=
 =?utf-8?B?UUtNMEkyT3B3dTFhTU1qczhYSlQ1dGt6TzJFWjdGZ3R4d0VOK0tsU3F4bUNq?=
 =?utf-8?B?SjA4ekxSYkhZL2dCUG83VmJNRzEyekxkZUt4QXlxeE85OEVMQk1XN1l0NEJZ?=
 =?utf-8?B?MXVOOGw0YitZWFRFZkZhbS9ZeWxmSUpXekdxNG5iZERUeUNiUWltRFpzajdj?=
 =?utf-8?B?SHhOSWNUdnlTMEp3ejVUQ2UxN2VmMmZIWk95d1dFUDFTRnByVENWZ3BsOUtK?=
 =?utf-8?B?ZGRWL29pYmRnU3VaeTZzbW8yVU9UaCtxOHhvS1hXajkvMEgyVEFseDAzSHB5?=
 =?utf-8?B?dG5LL0JnZVhtNUJCc2UweVg5TDBPMUFBK3pma0FrY0FtRzZ5b1Z1aFpZZlZa?=
 =?utf-8?B?SXFmbU5oNWdKUVErQTYvVUo1Z2ZzTGI2aU5rdG42UmpSMmNXM1BBenpON2tv?=
 =?utf-8?B?dytGWTZHbjY1MFZpM2ZXTmJFWWZTUC8xdlAvSms5SURXOVpIVTVlL3RBTmty?=
 =?utf-8?B?Y2J6ZWhnRyt1bUVFZm5lcm5xTGx0aUVCbzZwODFkbXRVWkdpeDBwVnpnY2Y0?=
 =?utf-8?B?WXNSVzNScDJsaUdBL3d6MGthMzgwTnM0NHZXcUtFZWtjcFl3Zm9TUHBHOXAx?=
 =?utf-8?B?YXhEYzkvTjBDRWhxaVAveitQRHNJd3F0MzJnMExJLzRVOHhmN1dtT0QvZk4z?=
 =?utf-8?B?Y0J6VEErdFZPUml0SXQzbmhVQjFvSTJFUGJEMGNmUXg2eDcvNTFOcThDaEdh?=
 =?utf-8?B?ai9rY1FoZTlUTHV6VFJnRVJrOVgvcHJPK3JxOE5ZK0NpQXNQUnFZWUJ1T053?=
 =?utf-8?B?UXhwM0dMMFhFNE5aSkhUdnRaVnVLVHlRYWNtN0ppbnJOOFZka28wWHVYWVJl?=
 =?utf-8?B?VFBOSC85MWlLcFVTUWw1dW5LNWhxOFYvV1JVR0F0VG42RGl6b1Q5TzFtUzVO?=
 =?utf-8?B?MzZ1aUtsNFFjNENYOFJ2c0JETTVrTk1OL1cyNmVBU3JCbEl4UkNBZW1zWExk?=
 =?utf-8?B?ZFRIZUZYTGptZi9NM29xaENFQTN1dkt3R3R6NHZ2S25Ua0hiMSs3RnE4ci9H?=
 =?utf-8?B?bTV4MTNEUG9OcFRGWmx5YllIWGJlTjh2cStXRzZ2bHRLRFdDV09KaXhHZysz?=
 =?utf-8?B?bmU4dFNpZEtURXo5RmV0a2NNT1JGTXFoUURvUlVrQ0RxQnhSdEhEbSs3bFh1?=
 =?utf-8?B?V1h2aVJObElsaVNZdU9DcDVSOXpQcm9jREhtMDBrZkpVZkJlbUFKcHd4aUs4?=
 =?utf-8?B?Yi96UVlRK0V0NnBVZ2s2Y1lXbW5Gc2taSG4rVDdGNlNXUWY3Y0JVT3FHaWs3?=
 =?utf-8?B?aUI2SmlNbDRWWFE0SnRJVW9TeTBOOHVRbWl6UHZHUlhQelZZRmRoN0paRkV4?=
 =?utf-8?B?ODR1QXhzM24zNFZRVzMrTFRiRVhMK2JoZXdHNzZDRzZMUWQ2S0RRaXowRG5u?=
 =?utf-8?B?MHNHdkNZRWQ2eG9KRnVWTlkzc3diYVJla2RwblRpeEhKQXZUUEtBU3hOT3kv?=
 =?utf-8?B?aTNEMDAvSUVLRkUwSnhNNDh0d1Y5SCtVamZ1Z2RTY3hnRWNCc20wbHFkWlBk?=
 =?utf-8?B?Z2xpaUp1bG9sYjVKVm9zUXpRR0s2ZCsvTjFVdEhnOXNhYjRIVHVGWHU2aEwz?=
 =?utf-8?B?cWdMS2RWZXhBOFJIb1hwQ3BMdnR6YWo3Tk9rVDU0VlZCQ1pCQkVhTGwvci9Z?=
 =?utf-8?B?ekx3UnVwa0hTaVo2R1lvZjdaWC9lRERYK1NyYjNxLzVJMW5ycjVsWFR3WW1U?=
 =?utf-8?Q?Hn6vbtJN64k1/MB5wvFveOr9R?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JxRp29nI+1MxRzjhXipEUTRi3Ui98L9QvtP3vyphJNscvodieGhvsK78fO76lALBcaKmwORm4MN1XQrFc74SUCXSg4bsMNDNc2GYT50Nym44LuPwr20B6SWxyxAAds72LjvYaAGJiSOWpZQFDmsQqf7w7yJGkaFTlu3B7IySxsUVLGj2mZwAEYCsEm2BYT4/wxn2gX2aWFZ7LvBoChfyTkODr+RxqUHKU8fGHuwVBP/FJG/ccB4SRd1H7LHbGCwPYJhYAuLApwKov0tY3fbRKyQ8Cc3Ri3Luai4GVHmAGfi0s+ng7zlzpSfwkco3kX0uGASVkkV4rsEN0TtJAAoJfe5xd2ARE9uskSPCiKYsQLVNeCJ4g1XJpGyU7tRhA3ouSl5ZXAE5hoQGtO2+4GPf8fcNcWMspCjD7ClsRw6jCaaj/oAkIWwIauEV/bZYVl5o6Ff5Ur8NDS2eRbSlquW4Ik/WpAxwNtfFEgF8dnGttJQ2UicmQpiAXB7T6jlAGJIDFuXRCQdDCYUGm7tapcb5/mxhsabZ5yW+EmlbqPAy06yK60KOP3XPu1h/A9/Qufi4U5kRCfQ9yy4BEmjMWPOACrb2J/UJOq470OB0LaoHRPMkH8yHPwpCsuI+9F8AJ/SP
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bb8146-0220-4e8e-5d84-08dc470b5e01
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 05:22:12.6659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BKNw6i8XNHqSKohnTRkEFOTH2I9Nb+DyI4N3dniyHacX0BkpPxm8fXoBQi9vyPnMb7m0uEgRW7E/C4SsQC/oIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5895
X-Proofpoint-ORIG-GUID: of5lH21tgx7VgD6L6_pvoCeRdNPepPYR
X-Proofpoint-GUID: of5lH21tgx7VgD6L6_pvoCeRdNPepPYR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: of5lH21tgx7VgD6L6_pvoCeRdNPepPYR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02

ZXhmYXRfY291bnRfZXh0X2VudHJpZXMoKSBpcyBubyBsb25nZXIgY2FsbGVkLCByZW1vdmUgaXQu
DQpleGZhdF91cGRhdGVfZGlyX2Noa3N1bSgpIGlzIG5vIGxvbmdlciBjYWxsZWQsIHJlbW92ZSBp
dCBhbmQNCnJlbmFtZSBleGZhdF91cGRhdGVfZGlyX2Noa3N1bV93aXRoX2VudHJ5X3NldCgpIHRv
IGl0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+
DQpSZXZpZXdlZC1ieTogQW5keSBXdSA8QW5keS5XdUBzb255LmNvbT4NClJldmlld2VkLWJ5OiBB
b3lhbWEgV2F0YXJ1IDx3YXRhcnUuYW95YW1hQHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IFN1bmdq
b25nIFNlbyA8c2oxNTU3LnNlb0BzYW1zdW5nLmNvbT4NClNpZ25lZC1vZmYtYnk6IE5hbWphZSBK
ZW9uIDxsaW5raW5qZW9uQGtlcm5lbC5vcmc+DQotLS0NCiBmcy9leGZhdC9kaXIuYyAgICAgIHwg
NjAgKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogZnMvZXhm
YXQvZXhmYXRfZnMuaCB8ICA2ICstLS0tDQogZnMvZXhmYXQvaW5vZGUuYyAgICB8ICAyICstDQog
MyBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDY0IGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvZnMvZXhmYXQvZGlyLmMgYi9mcy9leGZhdC9kaXIuYw0KaW5kZXggZGYzOWUyNDU2
NzFkLi4wNzc5NDRkM2MyYzAgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9kaXIuYw0KKysrIGIvZnMv
ZXhmYXQvZGlyLmMNCkBAIC00NzgsNDEgKzQ3OCw2IEBAIHZvaWQgZXhmYXRfaW5pdF9kaXJfZW50
cnkoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQogCWV4ZmF0X2luaXRfc3RyZWFt
X2VudHJ5KGVwLCBzdGFydF9jbHUsIHNpemUpOw0KIH0NCiANCi1pbnQgZXhmYXRfdXBkYXRlX2Rp
cl9jaGtzdW0oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGV4ZmF0X2NoYWluICpwX2RpciwN
Ci0JCWludCBlbnRyeSkNCi17DQotCXN0cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBpbm9kZS0+aV9z
YjsNCi0JaW50IHJldCA9IDA7DQotCWludCBpLCBudW1fZW50cmllczsNCi0JdTE2IGNoa3N1bTsN
Ci0Jc3RydWN0IGV4ZmF0X2RlbnRyeSAqZXAsICpmZXA7DQotCXN0cnVjdCBidWZmZXJfaGVhZCAq
ZmJoLCAqYmg7DQotDQotCWZlcCA9IGV4ZmF0X2dldF9kZW50cnkoc2IsIHBfZGlyLCBlbnRyeSwg
JmZiaCk7DQotCWlmICghZmVwKQ0KLQkJcmV0dXJuIC1FSU87DQotDQotCW51bV9lbnRyaWVzID0g
ZmVwLT5kZW50cnkuZmlsZS5udW1fZXh0ICsgMTsNCi0JY2hrc3VtID0gZXhmYXRfY2FsY19jaGtz
dW0xNihmZXAsIERFTlRSWV9TSVpFLCAwLCBDU19ESVJfRU5UUlkpOw0KLQ0KLQlmb3IgKGkgPSAx
OyBpIDwgbnVtX2VudHJpZXM7IGkrKykgew0KLQkJZXAgPSBleGZhdF9nZXRfZGVudHJ5KHNiLCBw
X2RpciwgZW50cnkgKyBpLCAmYmgpOw0KLQkJaWYgKCFlcCkgew0KLQkJCXJldCA9IC1FSU87DQot
CQkJZ290byByZWxlYXNlX2ZiaDsNCi0JCX0NCi0JCWNoa3N1bSA9IGV4ZmF0X2NhbGNfY2hrc3Vt
MTYoZXAsIERFTlRSWV9TSVpFLCBjaGtzdW0sDQotCQkJCUNTX0RFRkFVTFQpOw0KLQkJYnJlbHNl
KGJoKTsNCi0JfQ0KLQ0KLQlmZXAtPmRlbnRyeS5maWxlLmNoZWNrc3VtID0gY3B1X3RvX2xlMTYo
Y2hrc3VtKTsNCi0JZXhmYXRfdXBkYXRlX2JoKGZiaCwgSVNfRElSU1lOQyhpbm9kZSkpOw0KLXJl
bGVhc2VfZmJoOg0KLQlicmVsc2UoZmJoKTsNCi0JcmV0dXJuIHJldDsNCi19DQotDQogc3RhdGlj
IHZvaWQgZXhmYXRfZnJlZV9iZW5pZ25fc2Vjb25kYXJ5X2NsdXN0ZXJzKHN0cnVjdCBpbm9kZSAq
aW5vZGUsDQogCQlzdHJ1Y3QgZXhmYXRfZGVudHJ5ICplcCkNCiB7DQpAQCAtNTUyLDcgKzUxNyw3
IEBAIHZvaWQgZXhmYXRfaW5pdF9leHRfZW50cnkoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNo
ZSAqZXMsIGludCBudW1fZW50cmllcywNCiAJCXVuaW5hbWUgKz0gRVhGQVRfRklMRV9OQU1FX0xF
TjsNCiAJfQ0KIA0KLQlleGZhdF91cGRhdGVfZGlyX2Noa3N1bV93aXRoX2VudHJ5X3NldChlcyk7
DQorCWV4ZmF0X3VwZGF0ZV9kaXJfY2hrc3VtKGVzKTsNCiB9DQogDQogdm9pZCBleGZhdF9yZW1v
dmVfZW50cmllcyhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2Nh
Y2hlICplcywNCkBAIC01NzQsNyArNTM5LDcgQEAgdm9pZCBleGZhdF9yZW1vdmVfZW50cmllcyhz
dHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlICplcywNCiAJ
CWVzLT5tb2RpZmllZCA9IHRydWU7DQogfQ0KIA0KLXZvaWQgZXhmYXRfdXBkYXRlX2Rpcl9jaGtz
dW1fd2l0aF9lbnRyeV9zZXQoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMpDQordm9p
ZCBleGZhdF91cGRhdGVfZGlyX2Noa3N1bShzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlICpl
cykNCiB7DQogCWludCBjaGtzdW1fdHlwZSA9IENTX0RJUl9FTlRSWSwgaTsNCiAJdW5zaWduZWQg
c2hvcnQgY2hrc3VtID0gMDsNCkBAIC0xMjQxLDI3ICsxMjA2LDYgQEAgaW50IGV4ZmF0X2ZpbmRf
ZGlyX2VudHJ5KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBleGZhdF9pbm9kZV9pbmZv
ICplaSwNCiAJcmV0dXJuIGRlbnRyeSAtIG51bV9leHQ7DQogfQ0KIA0KLWludCBleGZhdF9jb3Vu
dF9leHRfZW50cmllcyhzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgZXhmYXRfY2hhaW4g
KnBfZGlyLA0KLQkJaW50IGVudHJ5LCBzdHJ1Y3QgZXhmYXRfZGVudHJ5ICplcCkNCi17DQotCWlu
dCBpLCBjb3VudCA9IDA7DQotCXVuc2lnbmVkIGludCB0eXBlOw0KLQlzdHJ1Y3QgZXhmYXRfZGVu
dHJ5ICpleHRfZXA7DQotCXN0cnVjdCBidWZmZXJfaGVhZCAqYmg7DQotDQotCWZvciAoaSA9IDAs
IGVudHJ5Kys7IGkgPCBlcC0+ZGVudHJ5LmZpbGUubnVtX2V4dDsgaSsrLCBlbnRyeSsrKSB7DQot
CQlleHRfZXAgPSBleGZhdF9nZXRfZGVudHJ5KHNiLCBwX2RpciwgZW50cnksICZiaCk7DQotCQlp
ZiAoIWV4dF9lcCkNCi0JCQlyZXR1cm4gLUVJTzsNCi0NCi0JCXR5cGUgPSBleGZhdF9nZXRfZW50
cnlfdHlwZShleHRfZXApOw0KLQkJYnJlbHNlKGJoKTsNCi0JCWlmICh0eXBlICYgVFlQRV9DUklU
SUNBTF9TRUMgfHwgdHlwZSAmIFRZUEVfQkVOSUdOX1NFQykNCi0JCQljb3VudCsrOw0KLQl9DQot
CXJldHVybiBjb3VudDsNCi19DQotDQogaW50IGV4ZmF0X2NvdW50X2Rpcl9lbnRyaWVzKHN0cnVj
dCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBleGZhdF9jaGFpbiAqcF9kaXIpDQogew0KIAlpbnQg
aSwgY291bnQgPSAwOw0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmggYi9mcy9leGZh
dC9leGZhdF9mcy5oDQppbmRleCAxY2M5MTQ3NmI5YzUuLmVjYzVkYjk1MmRlYiAxMDA2NDQNCi0t
LSBhL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgNCisrKyBiL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgNCkBAIC00
MzEsOCArNDMxLDYgQEAgaW50IGV4ZmF0X2VudF9nZXQoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwg
dW5zaWduZWQgaW50IGxvYywNCiAJCXVuc2lnbmVkIGludCAqY29udGVudCk7DQogaW50IGV4ZmF0
X2VudF9zZXQoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgdW5zaWduZWQgaW50IGxvYywNCiAJCXVu
c2lnbmVkIGludCBjb250ZW50KTsNCi1pbnQgZXhmYXRfY291bnRfZXh0X2VudHJpZXMoc3RydWN0
IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGV4ZmF0X2NoYWluICpwX2RpciwNCi0JCWludCBlbnRy
eSwgc3RydWN0IGV4ZmF0X2RlbnRyeSAqcF9lbnRyeSk7DQogaW50IGV4ZmF0X2NoYWluX2NvbnRf
Y2x1c3RlcihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCB1bnNpZ25lZCBpbnQgY2hhaW4sDQogCQl1
bnNpZ25lZCBpbnQgbGVuKTsNCiBpbnQgZXhmYXRfemVyb2VkX2NsdXN0ZXIoc3RydWN0IGlub2Rl
ICpkaXIsIHVuc2lnbmVkIGludCBjbHUpOw0KQEAgLTQ4Nyw5ICs0ODUsNyBAQCB2b2lkIGV4ZmF0
X2luaXRfZXh0X2VudHJ5KHN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVzLCBpbnQgbnVt
X2VudHJpZXMsDQogCQlzdHJ1Y3QgZXhmYXRfdW5pX25hbWUgKnBfdW5pbmFtZSk7DQogdm9pZCBl
eGZhdF9yZW1vdmVfZW50cmllcyhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZXhmYXRfZW50
cnlfc2V0X2NhY2hlICplcywNCiAJCWludCBvcmRlcik7DQotaW50IGV4ZmF0X3VwZGF0ZV9kaXJf
Y2hrc3VtKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBleGZhdF9jaGFpbiAqcF9kaXIsDQot
CQlpbnQgZW50cnkpOw0KLXZvaWQgZXhmYXRfdXBkYXRlX2Rpcl9jaGtzdW1fd2l0aF9lbnRyeV9z
ZXQoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMpOw0KK3ZvaWQgZXhmYXRfdXBkYXRl
X2Rpcl9jaGtzdW0oc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMpOw0KIGludCBleGZh
dF9jYWxjX251bV9lbnRyaWVzKHN0cnVjdCBleGZhdF91bmlfbmFtZSAqcF91bmluYW1lKTsNCiBp
bnQgZXhmYXRfZmluZF9kaXJfZW50cnkoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGV4
ZmF0X2lub2RlX2luZm8gKmVpLA0KIAkJc3RydWN0IGV4ZmF0X2NoYWluICpwX2Rpciwgc3RydWN0
IGV4ZmF0X3VuaV9uYW1lICpwX3VuaW5hbWUsDQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvaW5vZGUu
YyBiL2ZzL2V4ZmF0L2lub2RlLmMNCmluZGV4IDA2ODdmOTUyOTU2Yy4uZGQ4OTRlNTU4YzkxIDEw
MDY0NA0KLS0tIGEvZnMvZXhmYXQvaW5vZGUuYw0KKysrIGIvZnMvZXhmYXQvaW5vZGUuYw0KQEAg
LTk0LDcgKzk0LDcgQEAgaW50IF9fZXhmYXRfd3JpdGVfaW5vZGUoc3RydWN0IGlub2RlICppbm9k
ZSwgaW50IHN5bmMpDQogCQllcDItPmRlbnRyeS5zdHJlYW0uc3RhcnRfY2x1ID0gRVhGQVRfRlJF
RV9DTFVTVEVSOw0KIAl9DQogDQotCWV4ZmF0X3VwZGF0ZV9kaXJfY2hrc3VtX3dpdGhfZW50cnlf
c2V0KCZlcyk7DQorCWV4ZmF0X3VwZGF0ZV9kaXJfY2hrc3VtKCZlcyk7DQogCXJldHVybiBleGZh
dF9wdXRfZGVudHJ5X3NldCgmZXMsIHN5bmMpOw0KIH0NCiANCi0tIA0KMi4zNC4xDQoNCg==

