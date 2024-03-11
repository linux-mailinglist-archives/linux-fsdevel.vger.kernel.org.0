Return-Path: <linux-fsdevel+bounces-14100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B73F877A5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 05:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A543EB2112D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 04:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DE314271;
	Mon, 11 Mar 2024 04:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="nimLOjro"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DFC12E59
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 04:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710131126; cv=fail; b=IN7KD6TNTwLQOPEPczcAo9+ehpW2mvlofDN+jgtX4XZdTYfxj2MnlrIoclPmYKa4c2iPS5qup5Xvn/LmCtHbhe4Pep8CCpQrJQVFjyphZLagjHDt50C5/oi1TmHSUpvt42WXs42ECA340fdp97gUMuuweLCcFAS1Xky6lNuJZcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710131126; c=relaxed/simple;
	bh=LSseWpTBss8HB1jgOajD1UyQVm6JwpPaoMd4hyF8D0w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WBEiBUvScFPDPz5UETuKG6rSExULIqyaWyn7XoB5PpUOvhP43CWxYeAQr2mtZVJCG0Lb8d9myI4Fjo1P4E1wqDIkK8qkTTvxemQzKwSDeqjQ1E0TvcjGZO4CZfrdazrdsy4fjXfen6hhUS/W7E6f3yNA/HXQicng0gHmZ8NIMFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=nimLOjro; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42B3b5gh004320;
	Mon, 11 Mar 2024 04:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=LSseWpTBss8HB1jgOajD1UyQVm6JwpPaoMd4hyF8D0w=;
 b=nimLOjroKtZ3iXl1409TMMK12RcCfKf/0PxvM6uG5jJLZfc79PehUcJIRUO4HKtjlNvQ
 krg8rTF8nJN6bmiqLI3S2KIUIbHdbaLt5f9NxTj009UCusCcvi6ksxmUvhiEqM/9zllS
 +lYQ5dtJmlj52UK+U0wSqChd0SmpoKFSQrZGZtsJHE8jGC3crOsImw3XiNSGDBoA4zSa
 2TCtjUYlw6RDNHHYOrYbRXQxHWhpj051Ve35bBYGQ95r2gpJ8pEYrzafOkTID02hNcqa
 JPUPHYb820FrNpT8zqVFxjKeKL9gYDiTOpFl1Ibok8eovxkfePcDIH/rvRBR7xQBmPHF PQ== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3wree19k8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 04:25:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuaDDRBgHDK3fmOc0Sr+P3Tuhghsot+o7RbobynMvEdBW4LulyQHcTS4h4D9EtvKXrqYGejxOOpDfoIoQy6DOViDdqhFyy+oD3T2I0jqEcaadcJj46TpDMl2Ea1xuf4QYVQogBpAoOeahjmv4G9IW+3RHmjhoS1SOEG63s/We3p4VvTOuKvWCP35O9em2jGXhHPmG3q/vI/NtNM4qwrFb0GKhY4VUPSUAnD1TVLzxJ+E79ikB/Ou9m+C7rbJdg/1pqbh9CBGfBl7wM/HMSo0StEQwcDKhN/QGKRzxUohs30o2FZ143Ub3erT069wO4xQvbK3LQXjUUnjgrBl3qkTpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSseWpTBss8HB1jgOajD1UyQVm6JwpPaoMd4hyF8D0w=;
 b=JcOb3Vdnl9C3qqWXMqo2dx79BO0vuQGMbmNDZPjfBbcauIk+Oj2RkCnsNXqtPzsBC1dYhu1Iii682CIz8jby9I+wqNfO6PH5+nKRWnF7mLagdg8PRyW/mFvlDRaroulE3kfwTLatEbpOFN3/xfocAgxXuDJQz239s9p4g0hdW0yM0CRcB5mCQwY2jxFQwUQyd7ODoaRBXaPvTC9fMp36hqvHhYqKZtGGFWi1MSOFqq90eCr1r9Fhc7V6/vU0653axB//7iPO12nJ4SNuKTLCqYbE9XbxKT/oeoLPrvQ8UsKOectXlge26Kc24Gm3+AHVI8qNy4yZzDtmdkj4zMOhbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com (2603:1096:400:279::9)
 by SEYPR04MB7362.apcprd04.prod.outlook.com (2603:1096:101:1a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Mon, 11 Mar
 2024 04:24:58 +0000
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::c5b0:d335:658e:20bd]) by TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::c5b0:d335:658e:20bd%7]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 04:24:58 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v3 03/10] exfat: convert exfat_add_entry() to use dentry cache
Thread-Topic: [PATCH v3 03/10] exfat: convert exfat_add_entry() to use dentry
 cache
Thread-Index: Adin2HOAChBhARZuQnuqPVclenHi6HLkXrfQ
Date: Mon, 11 Mar 2024 04:24:58 +0000
Message-ID: 
 <TY0PR04MB6328C569E8A0BB820C3F088081242@TY0PR04MB6328.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6328:EE_|SEYPR04MB7362:EE_
x-ms-office365-filtering-correlation-id: 7a8fa726-4296-45b7-a5c3-08dc41833668
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 trY8gC7vBepCd0gWRYzWUBzrmbQvxyR68S8FacLPV8qk3e8kn0QAO6Ir+GpWoqOU34Gkr7CFZ4eXoyTDhpwlHWJkzbFInx2P3QRk8U93YfNz5lNIato4lWXOQq0+f9xc4uMnQUKmSu0ow8YX2mr2WEgvJHU3EUY7wSAw779y3ri4EhzJkLIuKQ0nXkbAHx6an8U/Apu4Aorifd4o0ON4HwEPgXttDTfVAXO+NNmRL23p/dD63Xt23F/82LYkW243QmFMVLTAKlSX3nP+0XU4Fb8kvHJ1g9xHxyE9ft+3FbdkvkWhJdWUY3gbtoUcYibBTxBQmZjs5QaaeTroJ92wW7pP7wAoHAtepyWzKjvUzGHWDnqlEYGbt3LEjikD/6f8in27MQPxBxsPr4hWdyKjCO5XP6Z+74chJ6EhS1J8LlliVzKgLGar/iAnrLQBkjeD4wWxfvtHVbo/Opb9IoXHr37zqpvhQGBp0BNdhspv6vaC+Bj4B3MZWROmxhLiyN/JE0db6WU7UjoXcQIcaYs1su6VdDDzUeL/TgTnnq11JXMBXu7sr6iy/kVDnbsKI1rvy8MtguQKlzEvda1VaJrHBlvtbqShUyEBwUbV/ETGec1evqUYoHGzV7E/7PPuSsvCK8D43pOZnkeyVU9DtfYLc34rX0XgqrnH+UtPSw8EHALcGA8D6sI8g2IiAT3pcfrx7bgRrKq7pBqeyn+usaCYcg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6328.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MC85QUg1d1ZxUXRPdnZYeFNrMHhkc3ZIYmVqMVZoSkhyRm1SMVg0UGxxTTEr?=
 =?utf-8?B?aWdLRmJsVVVwczFPbVljK0piZzNhYWpqTk9VUlRPN0gwamZ1MFhJZitTYVhq?=
 =?utf-8?B?WE9kUVpoOTRLcEw3cTdTM0pkMllwS25wWmd5cmluTXU2WHNFQVNlS21JdVVJ?=
 =?utf-8?B?UklUVE1hdWpyc3lINHBvVTdhWC9vdjQ2NlByVUdlVE5YYk9zRCt5TEhzTlds?=
 =?utf-8?B?aGhPakFWQUVTVnZOSTJYa3M3NmV2cSs5YXpoUEo2a21PREFUMmN1Qm1SL0NR?=
 =?utf-8?B?YW5yWlprNVpYRHdWTXR4OXpncExjWFovWkFLR3pqR0FNemlCM3YvTWFHRVRz?=
 =?utf-8?B?cGhtUUVhSDJaUjRVS1YrWlBuYllyemRvb0NBcG9wWTVGL0RqbkNLZ21XNDlp?=
 =?utf-8?B?TWZMMkp5eTZmclVmSitrZ2R5QlYxM1IzL2xNOC9ZVjVJR3A5VWp3eVlwc3dY?=
 =?utf-8?B?a3dINlhuTkQzdVdJbnVxYk5ydkJ1TDVzOHc3RTc4TktFSk5TZjlaRnVLMmE1?=
 =?utf-8?B?NFpsRzJkYythSW01YXpYekN6QzJNVjZCMUpMVWRVRHQ2TVY3NmVYdkg5UTdJ?=
 =?utf-8?B?cnVXRmRGZW1LQ1VqZ1BaOHU3VU9sSnNNQnJ3Vndlc0pCTTRKZXJReG9BdHQr?=
 =?utf-8?B?a1U3cjJsbEordSt2ZFFSRVc1OTRqSnIwTC9UOFRsc3lYUUpCT1hjWFR0NDZD?=
 =?utf-8?B?eXBXNmN1Q2prOUFmOHZMMjdlakIxVmc0alZtV0VTVVZ0N2xaM2JsZ00zaitE?=
 =?utf-8?B?a2kyMWk1ZmY1aUUzK2NxOGdSZHFQK3NpSVBnWTRvRzNwVU83Vllid2hNM3lo?=
 =?utf-8?B?SnlIZFUxMGVVaEl6YnplczJtVEdvckRiZjZ1aXNqS2l1bndxVTF1RnZUenF1?=
 =?utf-8?B?STBVT2cwVWI5dDBpQlJhRjBuTVpWMlBISkwwZjA5RjM4WmZaMTVxU3piTXJV?=
 =?utf-8?B?SHF5UTNKYXhsOGo4dWhYR0NhNlFyaXBNTzltNlZHMGFVNncxeWF4cksxdXYv?=
 =?utf-8?B?Q0p1RStUZjB1WDJVd2dsU3Y4dzdnMHpSVkZUcGpYU2k5MjVsZVVFZWVMU1Rw?=
 =?utf-8?B?UmNoRFdPRWZaWUxlTVJES1M1Q3lwV3Z4NjY4eFRoVURhbUFxVHZUUCtENjh3?=
 =?utf-8?B?Q3dLdnlJUlZzRDlGbHJJYm9oUmc2UXg3QXBVbFdXaHpKbGcvamYxMUF0Wm1H?=
 =?utf-8?B?aFlqclduY0E2bk5Gbk5IbHpoUkw1NWRRL0NQblQ0Z2xHZFVienlQSW82QWVu?=
 =?utf-8?B?S0VYOWMwSnVNVFowRmU2OVM3dUF6RUZFV2M4dmlQZ3R2c3NhMEFEVFNVdVVv?=
 =?utf-8?B?YWFUTFdjWFFNQ0dzUzBPRnk3L2crNERXb1FKYisra1NqSzVza1BUTlBPMHFv?=
 =?utf-8?B?T1lkWFNVbng2OXNEL0Q1bjUzYUhtQjNBd1Q5Y3VlZ3dyc0M2dTBqZW13cElz?=
 =?utf-8?B?anF2NVBISVZaZ0ozRmFTd3hzcWRsUllFY3JLSUM3TXM3ZnZWZHFwdXdRVUdz?=
 =?utf-8?B?TVl6eXBzRFZlZVJ3RWE5VjJWSTlnZjlHaEwzaFl2cDRRUWZPalJJWWh6Y3Ns?=
 =?utf-8?B?cThjL0E1SGRnRlEvM0l6SHZUWnZpb29BOHU2ZjYvWjVVd0VySTN5emgybjN1?=
 =?utf-8?B?U0ZMV0FJS2o5M1J3TEdobVpTeHNsbkFrcDlxV01lYmVjMGloNGhGRWxUMVBU?=
 =?utf-8?B?R0tvREdGOWNBZllnMEFJRUdsdHpZWEFERVlrb0w4OFF4bENWNkliRXV1L3Ra?=
 =?utf-8?B?QUdqOHllSmdtSVdvengxY1c1T28vbUNiZXBBcUM5UVV5ZmR5NW51T2hFaG1Q?=
 =?utf-8?B?S3NyWWVSQWxWZHBlSHU1a3BwaWhEb1dKck5VNWtGVDR0N2JmSXV3ZzdyWklX?=
 =?utf-8?B?ODZYTlN4SnJZOE42TFNtSDFaT3UwWDhGeDRlT0N5eGxNdzZ2RHVTMGpwMi95?=
 =?utf-8?B?WDl2WXNXVkdVMjU4aGxOWHVkV0czcFBUQ2dwU0I5dzJnRXd2Ry80RUZaV0Nn?=
 =?utf-8?B?TUsvWXI4L01SN1pZZ2hkbVdyb2srTVEwZjZHK29iWUZjNEhpVGlWdGRTSmdU?=
 =?utf-8?B?RUtmVXNZeWxNMnBCbFZQRTlnVEdPVHVXSThTd09rZmhVR2dyK3VwNXE3MFFC?=
 =?utf-8?Q?NO3a5TxdjCkFfLr+t527bYH4M?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5E1aSeVk9BKHyF3+eOaZXHMtpMtycan1bAAX+0gh+2AJwRNI25SMgP1vRiNVBD3avDcAcZBTAtdtviSY8DFx1LP9/0IhhPNWF2CAyiwHIzIeiEOn0lXWhwGRBUdtRe5GMSZPdS7mdfGgedqv6nxFPRqklON27t+MXEeDWFLof0PZrKYPcYrKaQmdV6GHNYREuoxwaFJfdDAkr6UU+E1V8MZL9q+oqm2BohWQHqzxjMASWptdgkUJEVuT06ulwFIcqcIV10qZ7sRmxr3QItpcI9i7x0iEalSYsjZGB4rYsoR41Cm9xIAMgYMawTQkLHvWhTpNssO7udEsrJcEQ45VoEUVl8xzhhHug7MDS07YQrMzWY0cfvjnYz6bPnXk1mm/AJJbmLmslVLn+aajeInbaYUvOX+/qyjUrdjprQCgq5Wn0R81gDvrHunTz2KgjcJkVu8pJPWSBSYboJIG1arvazefvWwjWsw4up0Dfn4iBlNEgsQieIvyAfvaxfTebca3HcnkX6sdEHNl60aHk9IIXGbI+2/O4tX8XzCDM3pOLqLo5FBs21FYvNKBNl9tJITyXByFdH9/+7FJXm1rIGQWnws0SuqIqc5Zc7G7cb0tkeRnnG/CF7puu9Vos4PSDrNo
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6328.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8fa726-4296-45b7-a5c3-08dc41833668
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 04:24:58.8693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fB60+eTgGLUSH+YewbyzdXRyMj41dqW7xAlseJM4LEBGmeqdmx3Cg43P4b5QP42eU6LlfQ+FJ0ykqNzAieS0xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7362
X-Proofpoint-GUID: qmIA_UVdtDqaZoonxpSnLUqr_cpdc_t7
X-Proofpoint-ORIG-GUID: qmIA_UVdtDqaZoonxpSnLUqr_cpdc_t7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: qmIA_UVdtDqaZoonxpSnLUqr_cpdc_t7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_01,2024-03-06_01,2023-05-22_02

QWZ0ZXIgdGhpcyBjb252ZXJzaW9uLCBpZiAiZGlyc3luYyIgb3IgInN5bmMiIGlzIGVuYWJsZWQs
IHRoZQ0KbnVtYmVyIG9mIHN5bmNocm9uaXplZCBkZW50cmllcyBpbiBleGZhdF9hZGRfZW50cnko
KSB3aWxsIGNoYW5nZQ0KZnJvbSAyIHRvIDEuDQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1v
IDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NClJldmlld2VkLWJ5OiBBbmR5IFd1IDxBbmR5Lld1QHNv
bnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFveWFtYSBXYXRhcnUgPHdhdGFydS5hb3lhbWFAc29ueS5j
b20+DQotLS0NCiBmcy9leGZhdC9kaXIuYyAgICAgIHwgMzcgKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KIGZzL2V4ZmF0L2V4ZmF0X2ZzLmggfCAgNiArKystLS0NCiBmcy9l
eGZhdC9uYW1laS5jICAgIHwgMTIgKysrKysrKysrKy0tDQogMyBmaWxlcyBjaGFuZ2VkLCAyMiBp
bnNlcnRpb25zKCspLCAzMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2Rp
ci5jIGIvZnMvZXhmYXQvZGlyLmMNCmluZGV4IGQ0YjJjZGQ4NzkwMC4uMWQyMGFiYjBiMzliIDEw
MDY0NA0KLS0tIGEvZnMvZXhmYXQvZGlyLmMNCisrKyBiL2ZzL2V4ZmF0L2Rpci5jDQpAQCAtNDQ4
LDUzICs0NDgsMzQgQEAgc3RhdGljIHZvaWQgZXhmYXRfaW5pdF9uYW1lX2VudHJ5KHN0cnVjdCBl
eGZhdF9kZW50cnkgKmVwLA0KIAl9DQogfQ0KIA0KLWludCBleGZhdF9pbml0X2Rpcl9lbnRyeShz
dHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyLA0KLQkJaW50IGVu
dHJ5LCB1bnNpZ25lZCBpbnQgdHlwZSwgdW5zaWduZWQgaW50IHN0YXJ0X2NsdSwNCi0JCXVuc2ln
bmVkIGxvbmcgbG9uZyBzaXplKQ0KK3ZvaWQgZXhmYXRfaW5pdF9kaXJfZW50cnkoc3RydWN0IGV4
ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQorCQl1bnNpZ25lZCBpbnQgdHlwZSwgdW5zaWduZWQg
aW50IHN0YXJ0X2NsdSwNCisJCXVuc2lnbmVkIGxvbmcgbG9uZyBzaXplLCBzdHJ1Y3QgdGltZXNw
ZWM2NCAqdHMpDQogew0KLQlzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiID0gaW5vZGUtPmlfc2I7DQor
CXN0cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBlcy0+c2I7DQogCXN0cnVjdCBleGZhdF9zYl9pbmZv
ICpzYmkgPSBFWEZBVF9TQihzYik7DQotCXN0cnVjdCB0aW1lc3BlYzY0IHRzID0gY3VycmVudF90
aW1lKGlub2RlKTsNCiAJc3RydWN0IGV4ZmF0X2RlbnRyeSAqZXA7DQotCXN0cnVjdCBidWZmZXJf
aGVhZCAqYmg7DQotDQotCS8qDQotCSAqIFdlIGNhbm5vdCB1c2UgZXhmYXRfZ2V0X2RlbnRyeV9z
ZXQgaGVyZSBiZWNhdXNlIGZpbGUgZXAgaXMgbm90DQotCSAqIGluaXRpYWxpemVkIHlldC4NCi0J
ICovDQotCWVwID0gZXhmYXRfZ2V0X2RlbnRyeShzYiwgcF9kaXIsIGVudHJ5LCAmYmgpOw0KLQlp
ZiAoIWVwKQ0KLQkJcmV0dXJuIC1FSU87DQogDQorCWVwID0gZXhmYXRfZ2V0X2RlbnRyeV9jYWNo
ZWQoZXMsIEVTX0lEWF9GSUxFKTsNCiAJZXhmYXRfc2V0X2VudHJ5X3R5cGUoZXAsIHR5cGUpOw0K
LQlleGZhdF9zZXRfZW50cnlfdGltZShzYmksICZ0cywNCisJZXhmYXRfc2V0X2VudHJ5X3RpbWUo
c2JpLCB0cywNCiAJCQkmZXAtPmRlbnRyeS5maWxlLmNyZWF0ZV90eiwNCiAJCQkmZXAtPmRlbnRy
eS5maWxlLmNyZWF0ZV90aW1lLA0KIAkJCSZlcC0+ZGVudHJ5LmZpbGUuY3JlYXRlX2RhdGUsDQog
CQkJJmVwLT5kZW50cnkuZmlsZS5jcmVhdGVfdGltZV9jcyk7DQotCWV4ZmF0X3NldF9lbnRyeV90
aW1lKHNiaSwgJnRzLA0KKwlleGZhdF9zZXRfZW50cnlfdGltZShzYmksIHRzLA0KIAkJCSZlcC0+
ZGVudHJ5LmZpbGUubW9kaWZ5X3R6LA0KIAkJCSZlcC0+ZGVudHJ5LmZpbGUubW9kaWZ5X3RpbWUs
DQogCQkJJmVwLT5kZW50cnkuZmlsZS5tb2RpZnlfZGF0ZSwNCiAJCQkmZXAtPmRlbnRyeS5maWxl
Lm1vZGlmeV90aW1lX2NzKTsNCi0JZXhmYXRfc2V0X2VudHJ5X3RpbWUoc2JpLCAmdHMsDQorCWV4
ZmF0X3NldF9lbnRyeV90aW1lKHNiaSwgdHMsDQogCQkJJmVwLT5kZW50cnkuZmlsZS5hY2Nlc3Nf
dHosDQogCQkJJmVwLT5kZW50cnkuZmlsZS5hY2Nlc3NfdGltZSwNCiAJCQkmZXAtPmRlbnRyeS5m
aWxlLmFjY2Vzc19kYXRlLA0KIAkJCU5VTEwpOw0KIA0KLQlleGZhdF91cGRhdGVfYmgoYmgsIElT
X0RJUlNZTkMoaW5vZGUpKTsNCi0JYnJlbHNlKGJoKTsNCi0NCi0JZXAgPSBleGZhdF9nZXRfZGVu
dHJ5KHNiLCBwX2RpciwgZW50cnkgKyAxLCAmYmgpOw0KLQlpZiAoIWVwKQ0KLQkJcmV0dXJuIC1F
SU87DQotDQorCWVwID0gZXhmYXRfZ2V0X2RlbnRyeV9jYWNoZWQoZXMsIEVTX0lEWF9TVFJFQU0p
Ow0KIAlleGZhdF9pbml0X3N0cmVhbV9lbnRyeShlcCwgc3RhcnRfY2x1LCBzaXplKTsNCi0JZXhm
YXRfdXBkYXRlX2JoKGJoLCBJU19ESVJTWU5DKGlub2RlKSk7DQotCWJyZWxzZShiaCk7DQotDQot
CXJldHVybiAwOw0KIH0NCiANCiBpbnQgZXhmYXRfdXBkYXRlX2Rpcl9jaGtzdW0oc3RydWN0IGlu
b2RlICppbm9kZSwgc3RydWN0IGV4ZmF0X2NoYWluICpwX2RpciwNCmRpZmYgLS1naXQgYS9mcy9l
eGZhdC9leGZhdF9mcy5oIGIvZnMvZXhmYXQvZXhmYXRfZnMuaA0KaW5kZXggNWE1YTRmZDNjYmVh
Li43MWI5MzFjZjg0YzMgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9leGZhdF9mcy5oDQorKysgYi9m
cy9leGZhdC9leGZhdF9mcy5oDQpAQCAtNDc5LDkgKzQ3OSw5IEBAIGludCBleGZhdF9nZXRfY2x1
c3RlcihzdHJ1Y3QgaW5vZGUgKmlub2RlLCB1bnNpZ25lZCBpbnQgY2x1c3RlciwNCiBleHRlcm4g
Y29uc3Qgc3RydWN0IGlub2RlX29wZXJhdGlvbnMgZXhmYXRfZGlyX2lub2RlX29wZXJhdGlvbnM7
DQogZXh0ZXJuIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgZXhmYXRfZGlyX29wZXJhdGlv
bnM7DQogdW5zaWduZWQgaW50IGV4ZmF0X2dldF9lbnRyeV90eXBlKHN0cnVjdCBleGZhdF9kZW50
cnkgKnBfZW50cnkpOw0KLWludCBleGZhdF9pbml0X2Rpcl9lbnRyeShzdHJ1Y3QgaW5vZGUgKmlu
b2RlLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyLA0KLQkJaW50IGVudHJ5LCB1bnNpZ25lZCBp
bnQgdHlwZSwgdW5zaWduZWQgaW50IHN0YXJ0X2NsdSwNCi0JCXVuc2lnbmVkIGxvbmcgbG9uZyBz
aXplKTsNCit2b2lkIGV4ZmF0X2luaXRfZGlyX2VudHJ5KHN0cnVjdCBleGZhdF9lbnRyeV9zZXRf
Y2FjaGUgKmVzLA0KKwkJdW5zaWduZWQgaW50IHR5cGUsIHVuc2lnbmVkIGludCBzdGFydF9jbHUs
DQorCQl1bnNpZ25lZCBsb25nIGxvbmcgc2l6ZSwgc3RydWN0IHRpbWVzcGVjNjQgKnRzKTsNCiBp
bnQgZXhmYXRfaW5pdF9leHRfZW50cnkoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGV4ZmF0
X2NoYWluICpwX2RpciwNCiAJCWludCBlbnRyeSwgaW50IG51bV9lbnRyaWVzLCBzdHJ1Y3QgZXhm
YXRfdW5pX25hbWUgKnBfdW5pbmFtZSk7DQogaW50IGV4ZmF0X3JlbW92ZV9lbnRyaWVzKHN0cnVj
dCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBleGZhdF9jaGFpbiAqcF9kaXIsDQpkaWZmIC0tZ2l0IGEv
ZnMvZXhmYXQvbmFtZWkuYyBiL2ZzL2V4ZmF0L25hbWVpLmMNCmluZGV4IDljNTQ5ZmQxMWZjOC4u
MDc1MDZmMzg4MmJiIDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvbmFtZWkuYw0KKysrIGIvZnMvZXhm
YXQvbmFtZWkuYw0KQEAgLTQ5OSw2ICs0OTksOCBAQCBzdGF0aWMgaW50IGV4ZmF0X2FkZF9lbnRy
eShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBjb25zdCBjaGFyICpwYXRoLA0KIAlzdHJ1Y3QgZXhmYXRf
c2JfaW5mbyAqc2JpID0gRVhGQVRfU0Ioc2IpOw0KIAlzdHJ1Y3QgZXhmYXRfdW5pX25hbWUgdW5p
bmFtZTsNCiAJc3RydWN0IGV4ZmF0X2NoYWluIGNsdTsNCisJc3RydWN0IHRpbWVzcGVjNjQgdHMg
PSBjdXJyZW50X3RpbWUoaW5vZGUpOw0KKwlzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlIGVz
Ow0KIAlpbnQgY2x1X3NpemUgPSAwOw0KIAl1bnNpZ25lZCBpbnQgc3RhcnRfY2x1ID0gRVhGQVRf
RlJFRV9DTFVTVEVSOw0KIA0KQEAgLTUzMSw4ICs1MzMsMTQgQEAgc3RhdGljIGludCBleGZhdF9h
ZGRfZW50cnkoc3RydWN0IGlub2RlICppbm9kZSwgY29uc3QgY2hhciAqcGF0aCwNCiAJLyogZmls
bCB0aGUgZG9zIG5hbWUgZGlyZWN0b3J5IGVudHJ5IGluZm9ybWF0aW9uIG9mIHRoZSBjcmVhdGVk
IGZpbGUuDQogCSAqIHRoZSBmaXJzdCBjbHVzdGVyIGlzIG5vdCBkZXRlcm1pbmVkIHlldC4gKDAp
DQogCSAqLw0KLQlyZXQgPSBleGZhdF9pbml0X2Rpcl9lbnRyeShpbm9kZSwgcF9kaXIsIGRlbnRy
eSwgdHlwZSwNCi0JCXN0YXJ0X2NsdSwgY2x1X3NpemUpOw0KKw0KKwlyZXQgPSBleGZhdF9nZXRf
ZW1wdHlfZGVudHJ5X3NldCgmZXMsIHNiLCBwX2RpciwgZGVudHJ5LCBudW1fZW50cmllcyk7DQor
CWlmIChyZXQpDQorCQlnb3RvIG91dDsNCisNCisJZXhmYXRfaW5pdF9kaXJfZW50cnkoJmVzLCB0
eXBlLCBzdGFydF9jbHUsIGNsdV9zaXplLCAmdHMpOw0KKw0KKwlyZXQgPSBleGZhdF9wdXRfZGVu
dHJ5X3NldCgmZXMsIElTX0RJUlNZTkMoaW5vZGUpKTsNCiAJaWYgKHJldCkNCiAJCWdvdG8gb3V0
Ow0KIA0KLS0gDQoyLjM0LjENCg0K

