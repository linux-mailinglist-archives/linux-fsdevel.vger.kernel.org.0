Return-Path: <linux-fsdevel+bounces-14706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA85687E2FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 06:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0571F211F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 05:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B47A219E1;
	Mon, 18 Mar 2024 05:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="VzxYMJM6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734F321342
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 05:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710739337; cv=fail; b=Ptk079yERGoVnGN5l8Fce8pGCa/iJWpCwgljuk29VfHRlHbolOw0eezDaZJtddaXMcscKZA16vCXucoSc1QMFTAEc9XtsqKZqMKZXPo34joN9vHFImzKq0tnCB4k4NDvOHYjPWNeS61fIlr0HRCQNw2z1Saf3HV+GD3vEYM0/PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710739337; c=relaxed/simple;
	bh=nBeDhgFFZs3r4BPA/Amce/1ugnuxpfBM4oUoncKMbPM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rC+txWvmXGoMpbck1dUkYgwW/6hA/VAtnz+azI/9ioC9euKy8eeIbXm00M2w82qrk5o6fetDuxZQ61jstmcAuEoS9hfyxgu5rOupYPCCj7+mWWQO7gechHqryH69LeHlD44XmVXkwxY8znrTFMHyLcLyBXneLAG2OBV+oSsU+qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=VzxYMJM6; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42I4i96p027621;
	Mon, 18 Mar 2024 05:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=nBeDhgFFZs3r4BPA/Amce/1ugnuxpfBM4oUoncKMbPM=;
 b=VzxYMJM6QHZL0kLsScZ0e5iECelKh6pYUnWr7ZNVrJ9UnjSMk+jXH5Ln5+IjyBaAqooE
 N76pc6AlrJmeqngKvCbDY9e1gnU72dDbMIYGC5oJzNHi9N02LERkyuJgKSrxSo0Nj0Ej
 zf9ynq0DK3ToqjqIekRVANezBDlV25SPw3TmZ+GoK64s+S2C7UYFdiA4gB5m/YDJZJ1t
 nmpS1aRXDAglLsOsQNMYlugGfdVmUTzAP41zLE6uIuxDkpk1cbubYG3jNqBnIufAKVPF
 hG2iAb87jz1WKzga6+qLiv9ZjerXzkb27KEujkfE3u8EbP9GUOcj/DKeJh4H2ibGd0w5 Rw== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3ww2769h1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 05:22:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L21p7taaqmI9wlQOhFb026MbkytHzCtwzW14Q2ihqBft23QTKJvp9DuAYJP9DspGut5aLx3/LbS7i0Vx3kywA+cgQH9JM6xyj5AuFHSWFdjeDUaPdjMHTkPw9uhXTx9+djmKOLCjCftr7BlDbim9EoxirYM3bjNBe6oGNtcoVsiZCyE+Sn4TaQm86CLlY6MK9o5j0mBGKsWn2xWjH4owUgxN8VgpKWl+zgzZ+aMGmfRSqCvqqRbTmIOpZwdifcuPKQrFYiUvUZDQin0drg5e5tbbj2y4SEF+BVafcLJBFh1i9eP/mw6djsUoQNwPvcidhTdI2O8ehBV2LsY5pJXHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBeDhgFFZs3r4BPA/Amce/1ugnuxpfBM4oUoncKMbPM=;
 b=m5JFScLYDzpP82ISMQCkd58n7Gu/wYVd2eqI4UQ0dzRtrE3Z5eUMLVHyaAHLFasls6GrX631udb8KsHSaWgzlSOmHybwWOD1L7Ny8Yd0f5rufaaYcB6qlIZsWrTebzHSKBM6nd5vxXMARJAeAB8jKcy/NrSbW7x99BZP63E73Zf+IVz9hGpUC+PMTEE0lTSuS6GXXlzHiYbDspZ1NFVmFVwt+hAmhtoi//0DSfUMyYy6Zzp817oBEvfgqqgY+9bb8bCJ1eDw/WKM5G2gU867K5jHU0UyxnUioOwDQ00sYWGhZEbSFgGdf9RSvPOgsjQaXCWo0WhUEekC+wBMoZsYyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SI2PR04MB5895.apcprd04.prod.outlook.com (2603:1096:4:1eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 05:21:59 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::7414:91e1:bb61:1c8d]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::7414:91e1:bb61:1c8d%7]) with mapi id 15.20.7386.022; Mon, 18 Mar 2024
 05:21:59 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v4 05/10] exfat: move free cluster out of
 exfat_init_ext_entry()
Thread-Topic: [PATCH v4 05/10] exfat: move free cluster out of
 exfat_init_ext_entry()
Thread-Index: Adk2K2RlKDzYiUB2RIeEGX1cod9h91CxyGog
Date: Mon, 18 Mar 2024 05:21:59 +0000
Message-ID: 
 <PUZPR04MB6316DBC3129059AA1EA07899812D2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SI2PR04MB5895:EE_
x-ms-office365-filtering-correlation-id: 027461b9-6e2a-498f-4263-08dc470b563f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 w6A6j+DXkTvkw/ZaGGyL7rXo9N6x/IF6ujHGRV9lNZyCi8+CKBln/Vgskaod+LlOl7UeKGDmvC5iv5OATp4ANBx2YKOQfgiRC6Q+9EAozMd3txvGf4ZyFErMqNcadlB8Q7PfrCNFc0midyruU3FQBTX0VBBM/T7e36xl/iEosrqKJLBhLvjkWMBC1loVVifUJqeyde6iKySLd3Qg1CSCRoIUnbzjKXwWBsZ2+bIv5WdmtqXOJFqFSadRht8B4lQr4RiPzyhM443CXq71eDCgu2ntGukhaMOLCHvJBT6YuZetmiSc8U9rPC1tiPpwoBhKoA+/qgg0tPfLJV4+XNrfcLGLCVK6OLjvJn5/IbNwNYDvzZxqIBpRt81XVcKB04C0D+Vib82alzM5PcuvIyoP3uIzMG1tgw7zUNEQFUJcegSjD1Djd5PhJCEXw8Qa/2wu2bD1YXDe6dpnu6U0mlDSb6bMnFB7ZRBy8bwGOfVqicO98HAei27TLUo0aPsiEOxm7coPNiLqBPBuO0IbO0MdrDi8eu9FFq1JWyoSKUZQHa2Q1wxr3kYb9oROxm2o6K7Z2+V+i7yn34vvs7Dpjf1UUeBVCflFDkHkoZe64kt/AxwvTbdSk4j0bDORn6KXQErUr4YZXTSfGJVE5XdjAw/cr2g1NjaGfVJM0idPMFnHFzg/IremSNbfMZKggFCcQ8hBC5ux0FzqDJqpzdoasP9MJsK3G96ZBSmo7JPgfbjfHbw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZkdlMm1uU0Z4Zk96VXlaM29SYjR6azRYT1hiRHBORUhicWhORlBUR1p6U2g4?=
 =?utf-8?B?M045YlRCb1VNZXpmd0JQazhmTUd5OXhUSTZrNDRqWkpGQlZKbmJldklkVXor?=
 =?utf-8?B?MEZScmQ4MjNHS3lpYTVucmdOQndqVU05Q3NlbDViNldXNmZQa0FXbkpOQW44?=
 =?utf-8?B?V05BN3NJTVlUM29SY0hHd1dPTUZwaDc3VVFMOWRiZTBER0J4OUhic0tYUkM4?=
 =?utf-8?B?MHRlQWlMUHpmRDYyanh0RmZ1aDF1T2xjcnUwVytObWdFdVFtNHVHM0trYURp?=
 =?utf-8?B?UGdXZ2ZxOXNFT21lbmJVSG44TXRZOVpMTzVYS042b1NnRWN1cmVubm9Qc0k1?=
 =?utf-8?B?Q0pGNlNHOUtjQ0dUYVcyWkJsbUs3b1NOcEVVR0s5YXhxUHhRVkI5SSs1blFa?=
 =?utf-8?B?aHhPeksvYXFObHo5ek10Vjd5cEl0NDVlRmhNUzRGbTZLVFg5dUdjOS9lK0tB?=
 =?utf-8?B?L3lBQ3VWYVVIaEx6MGVIeHVHRGdHL0tCUjAzTlNONzZHcXNSdWI4aDlrU0Z4?=
 =?utf-8?B?dkg3dnJHU3VtQ2VEekVNYTZvRVZLTHo1L2ZmdzV6OEdheEc2NEhJNUwyQUVh?=
 =?utf-8?B?aXdwa093M1g1TTh4UWlPZ1JRRlA3U2g0MnAvTDJ0SEZzV1UwbG01Qk1seVgx?=
 =?utf-8?B?L3Q1b2d3NVIxb0o1MDVuMEtEZFc1V1pYeTFGbFZpMlJqSVkrdkNQbTBEcTZD?=
 =?utf-8?B?U3ZpeFBBcHBwMDlDcHFocndKTHh4MWRHcnphS3lsYnB1NHRaYmxaQkpuVG10?=
 =?utf-8?B?M1ZTditoVDJMNng3cktFV1pSMWEwNzJqK1BsNE4rNjgyeVR3bGpzSE9FM1pI?=
 =?utf-8?B?WUJ4OHRpcHdqWjNnL1RrWVBDMlhWV1YyQXkxTXhISHpHYWdxN2VDL1k4NVZO?=
 =?utf-8?B?YTVob1dvMEJZVGxYN2VpU0NoN3VpUnpCUWVUVVBrZS9qR3c5a0JjLzNJWnRn?=
 =?utf-8?B?QmVJZ0t0Kzh3Y3RpeUMweWFnTmNrdVB1U0Via1JrbGRXNm5xNHlYQ3NESkVD?=
 =?utf-8?B?Vml6TGwzU2dMZHp1Qkk3Q1lEczB5UG1SWmJCbnBERkNPZ3FCazg1YktrN3NO?=
 =?utf-8?B?dDRrbzJYdlFwWW1seHpWc1dMbmNoWTJNSm9vbUFQbHdNbjNzTXVYdTlMaEFH?=
 =?utf-8?B?dEF1YnBCUWlDamdhalRuaW95VHNNRGliU09iWWNCUWkvYVNWR0Z3N0dZY290?=
 =?utf-8?B?TU1ua3EwQ2JDUDA0WGN6eUhjc2xadWhKVkNkL01kSGphc2tlNXFIb1lMNEJJ?=
 =?utf-8?B?MVB3c1QyOWVNSUJLTW1hbTVMTHlZNVVTbVhNUWhmRFp3RExoK0Q1djBFdkla?=
 =?utf-8?B?NzZQVlVaa1lNT2VPbU9Bbm16Vld3UHR5NXl6dkdIem1IYnpzOW16OG5sRWJj?=
 =?utf-8?B?RDJqcWE2d3lldWJDNlFzbUtnMVhJUGpSYndpaFJZSFgxbWFRbE43c3FFRE54?=
 =?utf-8?B?QU10NHVpYS9HVEhWTFBwbUlqRTlDdmVzV3VvM2hjKy9HdytIZzRZazJuNUlP?=
 =?utf-8?B?a3lPS3FTWndtQmd6SS9pc3RJZnBUNWpaVkczTy9Dc3pJR3BlQXBQaWQvUEJV?=
 =?utf-8?B?NDMwaml5d0xUTmcxYUR6VitJQWRpRFl0RldTYTUyeGVmeHR5dUxXS01FdFVn?=
 =?utf-8?B?dEordHZOMUxqSmcwSkoxd3ZtU0RFcnNLMWFYVlZlZHR3NVRrbERWZjJ4dlJP?=
 =?utf-8?B?NEtlWm92U09wdURxVVFCWkdwK0t5UklsVTBVNUR0ZlNmaE81VUFEc3hvd0pH?=
 =?utf-8?B?elV3Qnl0Ty94cWtJZ0VXTFRBV2g5bmpVaTVLWGo2bGh6ejdNdkZublBWTTAz?=
 =?utf-8?B?RllNZHBpQ1ZCR0FVQ0VuUGIya1VnZ3lzOHpJUjhVWStVd25DUnFpMXFDQ2gy?=
 =?utf-8?B?VHplTUZLWDQrREdDT3BKMjJOTVN1aFFMQkJSemFWMUYzWXBwVFpGV1dwTWdZ?=
 =?utf-8?B?UFA3cS9acGUvZ2o1Mzd4RG8vN2ZiNlV5b1d1OUFkZzdtUTVBWm1tN3dtc0xw?=
 =?utf-8?B?cXZYMlFuQy94SFoyalpyek4xV2hTZlpLeGsxSWN1dWY0SVlMYnNYNUdVS0Ja?=
 =?utf-8?B?d2thSEpUNHlkOHdKRnA2OUxQcWMweDVTWURWd2ZJNG81N3c3b212QWFTeEpv?=
 =?utf-8?Q?kJwa2amw+/Gk7yW1wmrzu1mec?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IyR6MwO47sY+wlLXolcIYdBx20o+sYTdnlwFylwBjhv53OEPOi6CjemFXLwjIpAwZTI4IvV+QWYWQoD+3JBrmuP0Yb4cyLCpNdLch85//F8dNpKo5VaIpjZ2Y13Yxz7yL2VFYcglL68SejK5cPIVsRJxmtgyJVE7nyCo/mCfJisNCR/Haov8RL+izQsXRqZJW/EXh6EWbEKrAIVr+cep0QvTrFU/PNi9U3qKAzrytUhjTTGqdXnaI2VvkM4yAP9iZFQ+eAnu1HKgILc9/i9qKLzvjPvVhzejFar6uNFifca7rjolFCpppDEy3Wx+wIJRPcm80LkY1eSGHGCTAuY54TQDA2348Bd9s2dSxTLHEpxQ7YfO84IQRqQUKbsq6TL+KD87xwlNAWAdKRj6LuBtTqXtp/0CMdgj3LUq6u5BKm5yB9eaL2CGbILCs658zccdI82pJmhLsa1D9msvnNJ2U60yLz3S1GiWIXFe/AHt0gWv5L7PsTTgcsqFIsfdUFtvsG1Wb4qBrkhuFT0eEbeWvvaT0WFYY0jMifPZkFzO64HwjRotssrT222q885UBlIlkgSas+zGE7LfGjDsDeR3QlpI+rsxZtKAd0Q/bUdQ+vx1GaXqu0ijaYdqfWddy5kg
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 027461b9-6e2a-498f-4263-08dc470b563f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 05:21:59.6764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K7QG/vsUiwoZdZDxX5T8XrjIqNj86ObJBqZEGO/ZQVLDMIecVhtSMLFRiraD5JAylKn6/45KVL5bWuWFzlSFHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5895
X-Proofpoint-GUID: xzeC6bYr1SIbkw9au3SkVoIS0vVP0G3r
X-Proofpoint-ORIG-GUID: xzeC6bYr1SIbkw9au3SkVoIS0vVP0G3r
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: xzeC6bYr1SIbkw9au3SkVoIS0vVP0G3r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02

ZXhmYXRfaW5pdF9leHRfZW50cnkoKSBpcyBhbiBpbml0IGZ1bmN0aW9uLCBpdCdzIGEgYml0IHN0
cmFuZ2UNCnRvIGZyZWUgY2x1c3RlciBpbiBpdC4gQW5kIHRoZSBhcmd1bWVudCAnaW5vZGUnIHdp
bGwgYmUgcmVtb3ZlZA0KZnJvbSBleGZhdF9pbml0X2V4dF9lbnRyeSgpLiBTbyB0aGlzIGNvbW1p
dCBjaGFuZ2VzIHRvIGZyZWUgdGhlDQpjbHVzdGVyIGluIGV4ZmF0X3JlbW92ZV9lbnRyaWVzKCku
DQoNCkNvZGUgcmVmaW5lbWVudCwgbm8gZnVuY3Rpb25hbCBjaGFuZ2VzLg0KDQpTaWduZWQtb2Zm
LWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW5k
eSBXdSA8QW5keS5XdUBzb255LmNvbT4NClJldmlld2VkLWJ5OiBBb3lhbWEgV2F0YXJ1IDx3YXRh
cnUuYW95YW1hQHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IFN1bmdqb25nIFNlbyA8c2oxNTU3LnNl
b0BzYW1zdW5nLmNvbT4NClNpZ25lZC1vZmYtYnk6IE5hbWphZSBKZW9uIDxsaW5raW5qZW9uQGtl
cm5lbC5vcmc+DQotLS0NCiBmcy9leGZhdC9kaXIuYyAgIHwgMyAtLS0NCiBmcy9leGZhdC9uYW1l
aS5jIHwgNSArKystLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA1IGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZGlyLmMgYi9mcy9leGZhdC9kaXIuYw0K
aW5kZXggNTk5ZGM4MWM5YTA4Li4wMDA4ZDQ2ODFkMjkgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9k
aXIuYw0KKysrIGIvZnMvZXhmYXQvZGlyLmMNCkBAIC01NjQsOSArNTY0LDYgQEAgaW50IGV4ZmF0
X2luaXRfZXh0X2VudHJ5KHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBleGZhdF9jaGFpbiAq
cF9kaXIsDQogCQlpZiAoIWVwKQ0KIAkJCXJldHVybiAtRUlPOw0KIA0KLQkJaWYgKGV4ZmF0X2dl
dF9lbnRyeV90eXBlKGVwKSAmIFRZUEVfQkVOSUdOX1NFQykNCi0JCQlleGZhdF9mcmVlX2Jlbmln
bl9zZWNvbmRhcnlfY2x1c3RlcnMoaW5vZGUsIGVwKTsNCi0NCiAJCWV4ZmF0X2luaXRfbmFtZV9l
bnRyeShlcCwgdW5pbmFtZSk7DQogCQlleGZhdF91cGRhdGVfYmgoYmgsIHN5bmMpOw0KIAkJYnJl
bHNlKGJoKTsNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9uYW1laS5jIGIvZnMvZXhmYXQvbmFtZWku
Yw0KaW5kZXggZjU2ZTIyM2I5YjhmLi5iZTY3NjAyOTdlOGYgMTAwNjQ0DQotLS0gYS9mcy9leGZh
dC9uYW1laS5jDQorKysgYi9mcy9leGZhdC9uYW1laS5jDQpAQCAtMTA4MiwxMiArMTA4MiwxMyBA
QCBzdGF0aWMgaW50IGV4ZmF0X3JlbmFtZV9maWxlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVj
dCBleGZhdF9jaGFpbiAqcF9kaXIsDQogCQkJZXBvbGQtPmRlbnRyeS5maWxlLmF0dHIgfD0gY3B1
X3RvX2xlMTYoRVhGQVRfQVRUUl9BUkNISVZFKTsNCiAJCQllaS0+YXR0ciB8PSBFWEZBVF9BVFRS
X0FSQ0hJVkU7DQogCQl9DQorDQorCQlleGZhdF9yZW1vdmVfZW50cmllcyhpbm9kZSwgJm9sZF9l
cywgRVNfSURYX0ZJUlNUX0ZJTEVOQU1FICsgMSk7DQorDQogCQlyZXQgPSBleGZhdF9pbml0X2V4
dF9lbnRyeShpbm9kZSwgcF9kaXIsIG9sZGVudHJ5LA0KIAkJCW51bV9uZXdfZW50cmllcywgcF91
bmluYW1lKTsNCiAJCWlmIChyZXQpDQogCQkJZ290byBwdXRfb2xkX2VzOw0KLQ0KLQkJZXhmYXRf
cmVtb3ZlX2VudHJpZXMoaW5vZGUsICZvbGRfZXMsIG51bV9uZXdfZW50cmllcyk7DQogCX0NCiAJ
cmV0dXJuIGV4ZmF0X3B1dF9kZW50cnlfc2V0KCZvbGRfZXMsIHN5bmMpOw0KIA0KLS0gDQoyLjM0
LjENCg0K

