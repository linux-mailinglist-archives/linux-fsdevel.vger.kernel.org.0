Return-Path: <linux-fsdevel+bounces-14704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDEB87E2FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 06:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177F71C20B68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 05:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0395421379;
	Mon, 18 Mar 2024 05:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="CbODJunq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A04C21360
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 05:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710739326; cv=fail; b=ana/fyxE0mVgl4DRSVZfR8GcGXCB/uOV+i58L9EcEPb4PvYiSyyiIOX7BqOqoq+ferEkwIOHQd9zAy2b3a0yu154DlbbqSjEmRnEtxyZ/sKZ1IkrEOSCxsdTP+Qypwmh5ConBZ0gOZV0k2rjCTQ9PGJeIOZQaBOgDNvYsTJJLjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710739326; c=relaxed/simple;
	bh=tGGczJ9m9PcWARzDZadMOKJG0URnpH6jy1dU3BbjM3g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oAF0GkRbqx5E9xQLxJQ8X2OU3V1mzJU+O7800nK5tNcEBoy9GYgwVqNnV+mDcpej0itktu4NbKh1VXF2/x1Q7xJbAby3BW3ZOtrwTcBbX7owS7YXGD+rP60rPsrBsqCVVQNhxRvq4XYpEFYn+sCtYFKWkfVw3ELhxCLqoKY3y9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=CbODJunq; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42I4lDBB008885;
	Mon, 18 Mar 2024 05:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=tGGczJ9m9PcWARzDZadMOKJG0URnpH6jy1dU3BbjM3g=;
 b=CbODJunqvgMHGEhxFSS6OvnEmMriBAi6grplJKS1JPdYyNvcqyTfG+e2cvwCp9jpXojY
 IX7CvBREQp0kmvc1fqxFl45TEuFIlaGqEX0evaP1nwPowaqY+30j+AftlUhrxgsJy1JA
 gWRSbN3fDM6kCQ4pYRtoEY10hoBMOaDFanPaF+9952ZAN9baaK2iT8VNhXPTPa8Zakwd
 xACFvrUL4BW6WGMmUCUQO1+yS9vVWqC7RtG6fod95B1RKeVsfe0yKSaURJ+SXd8MsDdB
 EqMaJbFIWip/NxXSd8SbZXqkCyMFZ4BMDcnPpZaM9jLFSNl64SOMSVflbnqvCZm3UOh6 Tg== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3ww0k4hrhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 05:21:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7jJYTOxX0RZJUwRMo7D6HdVSJa7Cxr4A9FOriCuzACpcKdovh7/ppbslWJnQyDWeWa/udTN4W+0vTEEBwq5SlqEJGZdlne832sbANp0rvrchvGTfjrqgPAE+NTLWBI35BswF1C+QNVbIbYF2Ql5JXxpfgGfJ90qy2ks0ZsVNxgF9vs6Vj/luT+k9p2fibpF8V7p+r4IKR9YjdXIwamdh2cn3UMeWWoBSP+MfCzX0lFPsJov3RYolDQq3vqSeaEp/GIiRs2qDjs2AYZewik4Y+k+vSuXGEpI1/B3nnuqwLcohvCNaOLZZT+LGhsh8ZWN9PDnZsIuDugTUpoyZnl21Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGGczJ9m9PcWARzDZadMOKJG0URnpH6jy1dU3BbjM3g=;
 b=g0ko7p7G0gAqHrQE9sRUsOvkU4QLuqoVbRgPRRRpTPJRIyyuXuM7puqB8DzulkUGANT4/YOmpzTZ02fkwihbaeJlrjneEmERxsB5injIn11oq9IxpQvbiIJFc1UQ5gxHSY6YwSIb0ZtM6uxqJRyj3BkxSO/YCs15kI1EbqwkrTADcl2ssS8hhTAQ16vWCeWS0Dmt4reR0dfR3/wws2MX3UJvSBbuiwnkc5hDVdhq74wlrdDe6rl8HJH1+iqBaugOgf0sMS+nhbNDBCZl6kHuAqwxbLoCs2Wdljo5IK6jdP3fu4etA2lZIJZpWbPMelbT4TcUsXC62sQbPqgsii6GgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SI2PR04MB5895.apcprd04.prod.outlook.com (2603:1096:4:1eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 05:21:48 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::7414:91e1:bb61:1c8d]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::7414:91e1:bb61:1c8d%7]) with mapi id 15.20.7386.022; Mon, 18 Mar 2024
 05:21:48 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v4 03/10] exfat: convert exfat_add_entry() to use dentry cache
Thread-Topic: [PATCH v4 03/10] exfat: convert exfat_add_entry() to use dentry
 cache
Thread-Index: Adin2HOA2tU4zpe2RByNSy9FrS5gf3RGYqUA
Date: Mon, 18 Mar 2024 05:21:48 +0000
Message-ID: 
 <PUZPR04MB631616CF533E46C99C242D25812D2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SI2PR04MB5895:EE_
x-ms-office365-filtering-correlation-id: 132814f5-2de2-440e-6d98-08dc470b4f94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ELGLP7T8dqqxNXfFmejjkFmBbywP5MwrcKd4uDBqzIBikeRYyeMu8H9qZQE1okek8OQmxAwazD1TsAHqilYEbyM3DxhalLu3AGhh7HvvTooV4J0oWYZr+8hRulskWAROuddTrhUj8KtL5neQ9IDyFp6y6W2alF4buSLIiISZQGEQdOrsujc232DN3AJAOG6GwyPfVTK/iFjw7dpHOJ7axUsjp5XLduEzR2nk716U+BQuPhl6IOSLuGjRzQVso4dLygj4kk3cGsi1jHqeL48l5Unl5HbJVAQI0+gH/YnsIuLNjirsun5aElEjKXO+UzuTQR/UT0n6A8Ib9xbQr3+ddD2LyDTqmlPKBBdy0ZT+Hjkk73elKtVPKGg+iS9kcvslOzhWLwOTMFbjdf1vJ3Cd4rlWfmssUmhnMYhNopUe21O9FWHrA57Umd/61pI3TeKp7vABvN/X8NIXvzkyS/y4TK1lIRs6FPcutmBOzJ9tq8O+xAA9BaYELVHk+2LZLZIOF+FIxWopIcPxxR4EA3dDvBpANIw7cLB6a7vjcjmLFaode73TbwD/4RfH2tUnG4jrlBUgd73/4VlV9hSt/S/3g5UXSp8oO4/5RP/uEhTxX+sY4ZP+nW6oBo3iu++JwThb8kBXrBzZPu47K3uWNP3xjl0+9zjoudNLlZFnW5CbUeIkaEd93ugY1ezm3fff/ci0dCSMkgH4IsgNcjLv+2QZ2A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?N1lhR0NwdVQ2UzZVS3luSk9iaWtRZCszTmNSWUQ3UDA1RFZlUlFxakNoZS9l?=
 =?utf-8?B?b0ZHNHJKeVJaeGdiUFJOOWdyalBuMlQwRmtuQ25rY3V3T00xamc3QjNzRXZY?=
 =?utf-8?B?dVc2d2t4SU53cXdSQjFyMUtqMkt0QVFQTXBhQjlyMDF5UFpLc3pSbldlKzdP?=
 =?utf-8?B?UzFZYnN5djZya3Q4QXlFbHo4aUkzSnZUTFE3OHU1bnJkT0hiN29nZ1hsNWg0?=
 =?utf-8?B?am9uV2Z4aXdFUlJ5ZlBLUUdWSG1Vays4ZTd0a0xOQjBoMkUxdUQxQVc3NHFt?=
 =?utf-8?B?TTU2RjQydGhIMjJGUmt5WVJHRzBTM3I1QTNQb1lEL1ErN3VRbEZjbmpuN2VV?=
 =?utf-8?B?U01IWmx3Z3BxTmNnbnBsTFFJcUM0Um1kRjJ1VVg1MkhNU0lqTGp5QmZtaStv?=
 =?utf-8?B?ejRyZWMzM3d4WEpTcEdrelpzbFlpSm1wenhyZmZaa0kvTVhRUTV5alFJa0NC?=
 =?utf-8?B?QWZWZHlaT21hVTFNZm5GNkxPd2NuT2Jmc0Y3VmRML09SeTVaSEEwUXpSd0JN?=
 =?utf-8?B?MlZQdW9wRmVYeWk2T1JTRTFHcFRpOWRlWU1YcmJQU0JINjh1Sk9kUSt0NWwx?=
 =?utf-8?B?Z2JpWnBoejU1U3lUcUhrTWUyOE1wSUo3R05SMUpPa3N0NHdlMlhQVXlMaCtN?=
 =?utf-8?B?dDBKK0JPQUpwY1EyNVlZRGx1VzNCZDVEb1JjQUNwYnJtZ3E2VzhzU0ZuTlZq?=
 =?utf-8?B?RlVWbFFPckM0dVhVdzd0TGt6QUF5MkpPY1hBUVRZVWIwRHRZSDU5Sk1XYWVx?=
 =?utf-8?B?eVBjUTFxdnUzY2JaV1U4QUdUZmZnRExQZnRwbURNNGJSY2JBRzZtYk1oWXpT?=
 =?utf-8?B?WCtQRXc2UDZLUUlSRWJPcWxPK2l1UkhOdHk5Tlg2R0x6ak9QM0pUYkkvV2NX?=
 =?utf-8?B?MHdSWDB3QjNESWVpT0o5M0hjaGNxZGJyRk5adExVajZRRTRxNnFUS2lLSVlW?=
 =?utf-8?B?UUZ6Q1d3bnRMVXdyQ0dxM1pEWm1tY0pXZlRRQVZZZ3llVnpOTGtmbjY2bmw3?=
 =?utf-8?B?L3ZKSTBtQ2h0Mi82SmNaUFNNK21oWnB4UERDUEpUVC9kRm1PSHBGU2VZTTN0?=
 =?utf-8?B?UDJIdnZ5Z0Q1R3QzdUVoRFlaSS9DQ09CS2ZoWHlrRjFJblEwWVNQTWJQcGYz?=
 =?utf-8?B?VW1FYW04dXY5dDE4MVZmZHBQK2NRc0tlSS9RTlI4a0doUWpHTVMyMXdKWHhC?=
 =?utf-8?B?ZTlwRCt1OXVQR1RYOHVCSFVrLzJSQkFlR3dzZG5SOTJuRDg5cmd3YlZha2dp?=
 =?utf-8?B?Y2dMV0pzN2tnMTBUMUw3dnkzaVR2R0ZzNU5QVGF2WE00dWVOUC9tdktmVE9K?=
 =?utf-8?B?YmFvTkViWERtcnNPc0haa2NRQk1pNUxQNXJ6ZlJRcVIvTksvbzlJMEZvcHpT?=
 =?utf-8?B?cy9SemdWV2huN005NmtsWFV0cjdMbnVrb3VkWDcxeFpOOStHRlFYdzJyU0FC?=
 =?utf-8?B?K2lwQmhOLzk0VDZzeDBWNWpHTEgrMW94WlR2UjdpVjltclJtdGsyTG9iSER5?=
 =?utf-8?B?NXYvelIya2NZaGFFaVhKY29MaDFjMGhLbTBxb3laMzlQeFN2R2phaG1qTnVo?=
 =?utf-8?B?U2g4NlhTWlpMbmxKSjN5Wm5tS3lWcUVxQ1M4bnZkS3M2NzBLR2dScldQbzBL?=
 =?utf-8?B?SjBHaGRtWitMcklJZUJ3SHcyeklVQ3d3ZU9zc3habkRmS0Mxc1I2ZGlDQnow?=
 =?utf-8?B?M0svZHcyaDc4S2prVXBRVGJ0bzllTXRoTE5ic3ZvL3JaZ1NYdmJDVHA0amUw?=
 =?utf-8?B?dEFEUFdqN29wZ0hJalVVZkNGMDFVUHJ3Z3lFY2RyaHNFVkRhTkdSakN4Znp4?=
 =?utf-8?B?UVJhVzBlZU9zcnNoUkNjTjdra2RVMEZsWGtTbFAzVGp5dElRRG1qWWFobDNJ?=
 =?utf-8?B?YTR3OXRsZ0dVTFdjYndYVXJxdjN6TUl3RWxVeWlzVDJkUi94STlBWXIvUXBR?=
 =?utf-8?B?SUFZclZ4SUVtL1R0OS9QdnhQRitPUFFoYTN3bmJsSW5lWEF1MHF0TkFGYmhV?=
 =?utf-8?B?QnNYTU4rSDJUSit2VzE2eFpLb1FzWUQ5Z0hNTHBEeU1xbGpYZGdqMkIycklH?=
 =?utf-8?B?cFNrOVAzdEhUanhmYmhnbDJCSXBzcWFQeHMvbFZuZTd6WW9YOENMbTJUOU5q?=
 =?utf-8?Q?53/KfxEqREmiHo0JOzeG7QP4h?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aF3mza3dVLo5ETriLAjOBSn+G+ZAUqh/tFAhbWR8LZ/1B0ZCLQ6cgRxMabTtX7PAxY9njK9iPhAXAAA9p67y1NmYU2uyhI+5M/6s15zl2r5aguurEVQWDu2Otx5epq4IGAf0iWBKp9OoPgvAKyvmP1dEHyLyoCxduDLoOgaYGXOYoCJPYJ4Eo7fc79cJ1ycSy7DZLY57bAEtvH/BgSA+1dWNJIZjJ772oUKjom1sUY4tnf3OgnaEQU7otsiz1FAGq/sfS1EJlVz6u+K9RwHkCwAu78MUxWhoLnru3h2h3NT5VdtAsi7ZUFnzbx/FDToy4Kd7tACBnak7HMzaGX9RStKrGJ8iSdDftx2Dtgi46WFyAtSRehf3G0hUPAamAEzusShrDNu/zLQPYNp2WVmm4VXNKWPPe8X3qDOTMQ9d6aKNs30I75gDMfbh4RSUF2dClFAqO57lQGNl6Hyvh5mdChwIaxA0IVwFurDL5U9qkjHG1vNceF5QkRRGNPG8cPBnMAB185WFEL8kS6DmxIvFIkH34tZLcJZ+NHH/0b1Q+1uApmbeHloYxZ71AhDUTdj6awR+HV5XdZ0YY/pkjADdm0+L0c8PYNdkKjiiWs6jyKkhAUWqzvPRs+Pfm0tZMnOB
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132814f5-2de2-440e-6d98-08dc470b4f94
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 05:21:48.4549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CP0xi+wmOAd/oaaesjAaJovQ7xHJuDEXJvTHgTXPPkYDM1QIuqBfVoJeXuYyV/KGIkzbJJTSPvsFXCddxug2KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5895
X-Proofpoint-GUID: 9ArBJt-qUJF2-HrEm71HoiPBcWbkiry9
X-Proofpoint-ORIG-GUID: 9ArBJt-qUJF2-HrEm71HoiPBcWbkiry9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: 9ArBJt-qUJF2-HrEm71HoiPBcWbkiry9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02

QWZ0ZXIgdGhpcyBjb252ZXJzaW9uLCBpZiAiZGlyc3luYyIgb3IgInN5bmMiIGlzIGVuYWJsZWQs
IHRoZQ0KbnVtYmVyIG9mIHN5bmNocm9uaXplZCBkZW50cmllcyBpbiBleGZhdF9hZGRfZW50cnko
KSB3aWxsIGNoYW5nZQ0KZnJvbSAyIHRvIDEuDQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1v
IDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NClJldmlld2VkLWJ5OiBBbmR5IFd1IDxBbmR5Lld1QHNv
bnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFveWFtYSBXYXRhcnUgPHdhdGFydS5hb3lhbWFAc29ueS5j
b20+DQpSZXZpZXdlZC1ieTogU3VuZ2pvbmcgU2VvIDxzajE1NTcuc2VvQHNhbXN1bmcuY29tPg0K
U2lnbmVkLW9mZi1ieTogTmFtamFlIEplb24gPGxpbmtpbmplb25Aa2VybmVsLm9yZz4NCi0tLQ0K
IGZzL2V4ZmF0L2Rpci5jICAgICAgfCAzNyArKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQogZnMvZXhmYXQvZXhmYXRfZnMuaCB8ICA2ICsrKy0tLQ0KIGZzL2V4ZmF0L25hbWVp
LmMgICAgfCAxMiArKysrKysrKysrLS0NCiAzIGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMo
KyksIDMzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZGlyLmMgYi9mcy9l
eGZhdC9kaXIuYw0KaW5kZXggZTIyOGNkZmNjOWM5Li4wMDY1ZDJhYmM5ODMgMTAwNjQ0DQotLS0g
YS9mcy9leGZhdC9kaXIuYw0KKysrIGIvZnMvZXhmYXQvZGlyLmMNCkBAIC00NDgsNTMgKzQ0OCwz
NCBAQCBzdGF0aWMgdm9pZCBleGZhdF9pbml0X25hbWVfZW50cnkoc3RydWN0IGV4ZmF0X2RlbnRy
eSAqZXAsDQogCX0NCiB9DQogDQotaW50IGV4ZmF0X2luaXRfZGlyX2VudHJ5KHN0cnVjdCBpbm9k
ZSAqaW5vZGUsIHN0cnVjdCBleGZhdF9jaGFpbiAqcF9kaXIsDQotCQlpbnQgZW50cnksIHVuc2ln
bmVkIGludCB0eXBlLCB1bnNpZ25lZCBpbnQgc3RhcnRfY2x1LA0KLQkJdW5zaWduZWQgbG9uZyBs
b25nIHNpemUpDQordm9pZCBleGZhdF9pbml0X2Rpcl9lbnRyeShzdHJ1Y3QgZXhmYXRfZW50cnlf
c2V0X2NhY2hlICplcywNCisJCXVuc2lnbmVkIGludCB0eXBlLCB1bnNpZ25lZCBpbnQgc3RhcnRf
Y2x1LA0KKwkJdW5zaWduZWQgbG9uZyBsb25nIHNpemUsIHN0cnVjdCB0aW1lc3BlYzY0ICp0cykN
CiB7DQotCXN0cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBpbm9kZS0+aV9zYjsNCisJc3RydWN0IHN1
cGVyX2Jsb2NrICpzYiA9IGVzLT5zYjsNCiAJc3RydWN0IGV4ZmF0X3NiX2luZm8gKnNiaSA9IEVY
RkFUX1NCKHNiKTsNCi0Jc3RydWN0IHRpbWVzcGVjNjQgdHMgPSBjdXJyZW50X3RpbWUoaW5vZGUp
Ow0KIAlzdHJ1Y3QgZXhmYXRfZGVudHJ5ICplcDsNCi0Jc3RydWN0IGJ1ZmZlcl9oZWFkICpiaDsN
Ci0NCi0JLyoNCi0JICogV2UgY2Fubm90IHVzZSBleGZhdF9nZXRfZGVudHJ5X3NldCBoZXJlIGJl
Y2F1c2UgZmlsZSBlcCBpcyBub3QNCi0JICogaW5pdGlhbGl6ZWQgeWV0Lg0KLQkgKi8NCi0JZXAg
PSBleGZhdF9nZXRfZGVudHJ5KHNiLCBwX2RpciwgZW50cnksICZiaCk7DQotCWlmICghZXApDQot
CQlyZXR1cm4gLUVJTzsNCiANCisJZXAgPSBleGZhdF9nZXRfZGVudHJ5X2NhY2hlZChlcywgRVNf
SURYX0ZJTEUpOw0KIAlleGZhdF9zZXRfZW50cnlfdHlwZShlcCwgdHlwZSk7DQotCWV4ZmF0X3Nl
dF9lbnRyeV90aW1lKHNiaSwgJnRzLA0KKwlleGZhdF9zZXRfZW50cnlfdGltZShzYmksIHRzLA0K
IAkJCSZlcC0+ZGVudHJ5LmZpbGUuY3JlYXRlX3R6LA0KIAkJCSZlcC0+ZGVudHJ5LmZpbGUuY3Jl
YXRlX3RpbWUsDQogCQkJJmVwLT5kZW50cnkuZmlsZS5jcmVhdGVfZGF0ZSwNCiAJCQkmZXAtPmRl
bnRyeS5maWxlLmNyZWF0ZV90aW1lX2NzKTsNCi0JZXhmYXRfc2V0X2VudHJ5X3RpbWUoc2JpLCAm
dHMsDQorCWV4ZmF0X3NldF9lbnRyeV90aW1lKHNiaSwgdHMsDQogCQkJJmVwLT5kZW50cnkuZmls
ZS5tb2RpZnlfdHosDQogCQkJJmVwLT5kZW50cnkuZmlsZS5tb2RpZnlfdGltZSwNCiAJCQkmZXAt
PmRlbnRyeS5maWxlLm1vZGlmeV9kYXRlLA0KIAkJCSZlcC0+ZGVudHJ5LmZpbGUubW9kaWZ5X3Rp
bWVfY3MpOw0KLQlleGZhdF9zZXRfZW50cnlfdGltZShzYmksICZ0cywNCisJZXhmYXRfc2V0X2Vu
dHJ5X3RpbWUoc2JpLCB0cywNCiAJCQkmZXAtPmRlbnRyeS5maWxlLmFjY2Vzc190eiwNCiAJCQkm
ZXAtPmRlbnRyeS5maWxlLmFjY2Vzc190aW1lLA0KIAkJCSZlcC0+ZGVudHJ5LmZpbGUuYWNjZXNz
X2RhdGUsDQogCQkJTlVMTCk7DQogDQotCWV4ZmF0X3VwZGF0ZV9iaChiaCwgSVNfRElSU1lOQyhp
bm9kZSkpOw0KLQlicmVsc2UoYmgpOw0KLQ0KLQllcCA9IGV4ZmF0X2dldF9kZW50cnkoc2IsIHBf
ZGlyLCBlbnRyeSArIDEsICZiaCk7DQotCWlmICghZXApDQotCQlyZXR1cm4gLUVJTzsNCi0NCisJ
ZXAgPSBleGZhdF9nZXRfZGVudHJ5X2NhY2hlZChlcywgRVNfSURYX1NUUkVBTSk7DQogCWV4ZmF0
X2luaXRfc3RyZWFtX2VudHJ5KGVwLCBzdGFydF9jbHUsIHNpemUpOw0KLQlleGZhdF91cGRhdGVf
YmgoYmgsIElTX0RJUlNZTkMoaW5vZGUpKTsNCi0JYnJlbHNlKGJoKTsNCi0NCi0JcmV0dXJuIDA7
DQogfQ0KIA0KIGludCBleGZhdF91cGRhdGVfZGlyX2Noa3N1bShzdHJ1Y3QgaW5vZGUgKmlub2Rl
LCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyLA0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2V4ZmF0
X2ZzLmggYi9mcy9leGZhdC9leGZhdF9mcy5oDQppbmRleCBjNmY2ODRiZjdiOTIuLmVjYzVmNmEz
YWQ4NyAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgNCisrKyBiL2ZzL2V4ZmF0L2V4
ZmF0X2ZzLmgNCkBAIC00ODAsOSArNDgwLDkgQEAgaW50IGV4ZmF0X2dldF9jbHVzdGVyKHN0cnVj
dCBpbm9kZSAqaW5vZGUsIHVuc2lnbmVkIGludCBjbHVzdGVyLA0KIGV4dGVybiBjb25zdCBzdHJ1
Y3QgaW5vZGVfb3BlcmF0aW9ucyBleGZhdF9kaXJfaW5vZGVfb3BlcmF0aW9uczsNCiBleHRlcm4g
Y29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBleGZhdF9kaXJfb3BlcmF0aW9uczsNCiB1bnNp
Z25lZCBpbnQgZXhmYXRfZ2V0X2VudHJ5X3R5cGUoc3RydWN0IGV4ZmF0X2RlbnRyeSAqcF9lbnRy
eSk7DQotaW50IGV4ZmF0X2luaXRfZGlyX2VudHJ5KHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVj
dCBleGZhdF9jaGFpbiAqcF9kaXIsDQotCQlpbnQgZW50cnksIHVuc2lnbmVkIGludCB0eXBlLCB1
bnNpZ25lZCBpbnQgc3RhcnRfY2x1LA0KLQkJdW5zaWduZWQgbG9uZyBsb25nIHNpemUpOw0KK3Zv
aWQgZXhmYXRfaW5pdF9kaXJfZW50cnkoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMs
DQorCQl1bnNpZ25lZCBpbnQgdHlwZSwgdW5zaWduZWQgaW50IHN0YXJ0X2NsdSwNCisJCXVuc2ln
bmVkIGxvbmcgbG9uZyBzaXplLCBzdHJ1Y3QgdGltZXNwZWM2NCAqdHMpOw0KIGludCBleGZhdF9p
bml0X2V4dF9lbnRyeShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBf
ZGlyLA0KIAkJaW50IGVudHJ5LCBpbnQgbnVtX2VudHJpZXMsIHN0cnVjdCBleGZhdF91bmlfbmFt
ZSAqcF91bmluYW1lKTsNCiBpbnQgZXhmYXRfcmVtb3ZlX2VudHJpZXMoc3RydWN0IGlub2RlICpp
bm9kZSwgc3RydWN0IGV4ZmF0X2NoYWluICpwX2RpciwNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9u
YW1laS5jIGIvZnMvZXhmYXQvbmFtZWkuYw0KaW5kZXggOWM1NDlmZDExZmM4Li4wNzUwNmYzODgy
YmIgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9uYW1laS5jDQorKysgYi9mcy9leGZhdC9uYW1laS5j
DQpAQCAtNDk5LDYgKzQ5OSw4IEBAIHN0YXRpYyBpbnQgZXhmYXRfYWRkX2VudHJ5KHN0cnVjdCBp
bm9kZSAqaW5vZGUsIGNvbnN0IGNoYXIgKnBhdGgsDQogCXN0cnVjdCBleGZhdF9zYl9pbmZvICpz
YmkgPSBFWEZBVF9TQihzYik7DQogCXN0cnVjdCBleGZhdF91bmlfbmFtZSB1bmluYW1lOw0KIAlz
dHJ1Y3QgZXhmYXRfY2hhaW4gY2x1Ow0KKwlzdHJ1Y3QgdGltZXNwZWM2NCB0cyA9IGN1cnJlbnRf
dGltZShpbm9kZSk7DQorCXN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgZXM7DQogCWludCBj
bHVfc2l6ZSA9IDA7DQogCXVuc2lnbmVkIGludCBzdGFydF9jbHUgPSBFWEZBVF9GUkVFX0NMVVNU
RVI7DQogDQpAQCAtNTMxLDggKzUzMywxNCBAQCBzdGF0aWMgaW50IGV4ZmF0X2FkZF9lbnRyeShz
dHJ1Y3QgaW5vZGUgKmlub2RlLCBjb25zdCBjaGFyICpwYXRoLA0KIAkvKiBmaWxsIHRoZSBkb3Mg
bmFtZSBkaXJlY3RvcnkgZW50cnkgaW5mb3JtYXRpb24gb2YgdGhlIGNyZWF0ZWQgZmlsZS4NCiAJ
ICogdGhlIGZpcnN0IGNsdXN0ZXIgaXMgbm90IGRldGVybWluZWQgeWV0LiAoMCkNCiAJICovDQot
CXJldCA9IGV4ZmF0X2luaXRfZGlyX2VudHJ5KGlub2RlLCBwX2RpciwgZGVudHJ5LCB0eXBlLA0K
LQkJc3RhcnRfY2x1LCBjbHVfc2l6ZSk7DQorDQorCXJldCA9IGV4ZmF0X2dldF9lbXB0eV9kZW50
cnlfc2V0KCZlcywgc2IsIHBfZGlyLCBkZW50cnksIG51bV9lbnRyaWVzKTsNCisJaWYgKHJldCkN
CisJCWdvdG8gb3V0Ow0KKw0KKwlleGZhdF9pbml0X2Rpcl9lbnRyeSgmZXMsIHR5cGUsIHN0YXJ0
X2NsdSwgY2x1X3NpemUsICZ0cyk7DQorDQorCXJldCA9IGV4ZmF0X3B1dF9kZW50cnlfc2V0KCZl
cywgSVNfRElSU1lOQyhpbm9kZSkpOw0KIAlpZiAocmV0KQ0KIAkJZ290byBvdXQ7DQogDQotLSAN
CjIuMzQuMQ0KDQo=

