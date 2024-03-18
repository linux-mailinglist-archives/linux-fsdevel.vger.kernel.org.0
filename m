Return-Path: <linux-fsdevel+bounces-14711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CA687E303
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 06:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B45AB2187E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 05:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D4F21104;
	Mon, 18 Mar 2024 05:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="mpwA+Zb7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B597A20B12
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 05:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710739356; cv=fail; b=mjmyEliMxRvzfObbcHQINgQUsR3w78+AeeUa1rygDhdC1lqX9uUnZQ5ArvsfMuehVkVtose3HXmRNckATyJUXc2wg/vlVZUzizxRlFavJhD9ST/vXZSed+Lk5XQY/ojMchDHZHdCf6viYgudSEyNCSlZH5SjzkPzqM/+KTn58fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710739356; c=relaxed/simple;
	bh=pB5Db+NPIE+eGQ4NcuvpOEt3DjdZrMQJZgnF35Usd8I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X9gClIfNuxW3vj2LJHBKzNWkG1l/bMopt75NrwapK7rXjd/nswgDFYae9T86PRWhYwrteNw3oYqqZeV2ouGyptsVBna67p4msFNN6PS/RK+WSJsVh7HmazxARsnqWSk/6vek8ECOq+hGhaeKgtHCk0FGUXOJ2xgHLfNT+32nu50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=mpwA+Zb7; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42I46nua011235;
	Mon, 18 Mar 2024 05:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=pB5Db+NPIE+eGQ4NcuvpOEt3DjdZrMQJZgnF35Usd8I=;
 b=mpwA+Zb72K4Bw8Z4Pc7KPN8Pc4W7NltEkjx2NQANuRFaqDNDVjwMoKrQ5mykGCkulGUT
 Mp6NMJFjgxlu7euwTJwTRgpYH8/LQ5jAr72XJ2R3SGAdU3j452B1tKyTfbc3nL8HrbI3
 JdXTCPuYshPtTKWTIgGfW98I93yX9ftiHwyv5kwDXRnat0pzWjNdc9cAK8PwdX7YgFKQ
 p/DX5jvtXShDr4ZySZG2VWdJzYWDcw99o5CuFpbxbG2NoYxchfF8tt5C9yhO/S/vPcQl
 92NzNPOjG7B+XkjM1ecpopQxUE9scUFYznC4ejjVVDabTGRlh4QG5cKA8b1MA68ijqdD kA== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3ww0k4hrhy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 05:22:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YH4oyPViAcAq/4pAmiR74EQC0hdqIr5tH2GlhdmyKtiIbKyOqC2HoXvQrxn1iRCrfs4DjfNxVdXePvwjDiC6VMIEKXKQpKWt4sX4P20CjspxwXUz75fc9FpBg9oRyuGlB8ydIuprCJXJBMxYVGojlgLvgewVtFJhQ6uhPlysxgimz9m4V/Zu6s0digJKVWHzkja+pW/ZpxQn1D4Nx6fVErYIRt3HnW/1rkGrgLefbW5/HBG7PdRvbLJUXCOPsF3iWr7w4uyK9ie6QXBpatX97ROXRsd+vfZuXNMp6sG9ypmSzwGtykymP7vDjBqiyDOlWLNrTp70UF1nZocSVbAxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pB5Db+NPIE+eGQ4NcuvpOEt3DjdZrMQJZgnF35Usd8I=;
 b=jH/c3Hzqxw/T1TQebCNVVmyTm2ZBVdKaC2O3baNGNiE/4zOHSEc0j+h0uDcy3+ktARo2t3KKuxrN8CQ+JXCRtCiq6/ICmnEWKeAhnJ5cDbiTnh2QcvyXSr4mq/maWzl7d5bIhyzY/nvqrVdhe1w1b8DhUFh6Fr2lgSQF/hJ+iTTCK4oSATkg7EZsgCPpj8ZvJ5rYwdKMbA8mhofdbkl1yXEyzCCkCWyP8iXNIHC7VyDnRD0Dt/AsEY0FC+O4A/9qHOQC5lls+VAgZnpbp7HqXVl+2rjMCLDIZv5P5SgBJgYcLyInsL2hz6t1doGAtj37rtw1/7jKJP7Ei1L9MNCxUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SI2PR04MB5895.apcprd04.prod.outlook.com (2603:1096:4:1eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 05:22:21 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::7414:91e1:bb61:1c8d]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::7414:91e1:bb61:1c8d%7]) with mapi id 15.20.7386.022; Mon, 18 Mar 2024
 05:22:21 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v4 10/10] exfat: remove duplicate update parent dir
Thread-Topic: [PATCH v4 10/10] exfat: remove duplicate update parent dir
Thread-Index: Adj06Ci13KwnqdD7TBKYMvBVkuBBi2ECueOQ
Date: Mon, 18 Mar 2024 05:22:21 +0000
Message-ID: 
 <PUZPR04MB6316DE38CDA18577B44EEBB4812D2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SI2PR04MB5895:EE_
x-ms-office365-filtering-correlation-id: 3fb9812a-b416-4e52-e79a-08dc470b62fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 t06Jl9hT43oNMPLyRPlgPkOBT9YuAh5Agc7QlMAi6dOs4Hg41EK2kaMo5dZ7Hdf6YA76hajKYQLeQpqEYjj4gMbGYsVsOCI9CM5K0PwJTFIqvUFoK+1n1r9CdabKhHf9tJahkIitD9g6AijmK+tamXz/PP+zjWlkKlnNxhTLY33AozDYMZXZ+PFIymABCAwIa/4uhQDaZg/CwFGIjPZXPgyxSSp1of1l3wGnlg2lHzMZvT2xjG/GWlacSg2l6ehO/3Tj7TbmjjEg1EA9Eof9uCV2ck4hzdX8RLYhhNatvyMGtths9JPekpz9uWpnVXHIi9ib2qEyEzWiDknCaD1/7FGlKB4Gfb7WqyxGy0hn8qo6tAkRSuMDHjdcrpDtGPOS6FQFSYwebVL+fDOpTqsZ9WQBzacxFI/71C+Ba8wGvfXSxBsQk/SnFXrxH42YNv5/ViXGCjguBBzcvqwgZFYwwljv5b27TglzBDM4l7RHqN4DdeN/KdjFAaRF5sJRScsI+Q+6vpRcv1SN4BXETix2sWfgSaSLNxhMOd2Dt6nJ7Kws8RyQBjQjkAA/B+SzlYQnD7QoEmbUu3PYpZ9uc118R1vMlNqQzI7+NCJWZFca3iab5uvN6ep86bH9zmToRk0GrgySsVms7KOu3WA/UNBYRZ4ccxnWsdPDaP9TP7sVnvJ4Qd+L3atoH4y/xrojOQOAenMgL3PfhB58tLsTRJNGbw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UERNS0E2Ym94UElyR0pkUXZmNGFnbEdzVWZQb05mWUYwVHFmNkpOTUlqNVhX?=
 =?utf-8?B?Nlg0Z1c2S2pQZEwrbVJ0SmFaSzFkRWZrMjlkWTVQSWhiaXUzdzFqeU43UzJO?=
 =?utf-8?B?RVd4WXNEMHE1c0JYTDJKWXZBYTB4RW43V1VvUXVuL2NINVo3QUE5cFM3cWdM?=
 =?utf-8?B?OXhuUXNLVnp6T0tjMi9IN0hhTnYrYS82WU9LZVJoTS9JNHQzRUNudkJoUXQ0?=
 =?utf-8?B?eU16aUZhWndlZ3YwT3pMREdNMDAyUDZBcWRQQmFuT2RVVDhUSlNWV2grM1Zh?=
 =?utf-8?B?NnRtZHl6cmkyeTZsSEM0Qkh1WnJEU0owNCtzdlB4OUtlOXB5ekdMaWxFbTkw?=
 =?utf-8?B?eUxLNk5BclBoUDJ0Z1k4ZGZ0ZUFkL2RidlFpTVhYYmdRN2p0MkpsU3I0b1RL?=
 =?utf-8?B?RFJYd3VmcUIvcWNrSXRHNGdjZGM2VXJDNmp4QWxhdHJMUitkaW5xSmQ2ZXRH?=
 =?utf-8?B?UHRxaW1iR0ZMOEtmTkFrSmdpMGxkRGE5bGxJZ0NlNXR5R2ZEcFk2VmpPQUZY?=
 =?utf-8?B?cUhXTG5LZkRXR1o4QzhGVW5vMnk0VzV3Tmpld0JQYXp5N0JTRW94REdkLzlu?=
 =?utf-8?B?cUdzWkN5M3JUMDBQVDR5ZFdtb0FYeUVnL2J4b1AvMGlZVzFoanUxRDU0Q25K?=
 =?utf-8?B?OTdUNGlxVVFCeldwbFI2Q1g2YVM3NFlqV3UrNlZEMFh0VjE2cUQrOXRmdnZU?=
 =?utf-8?B?VkVNK1lSdFJhbzVMUnN1WFhCRllSTTFqcU0vdy8xb1lNbVd4STNGSU5sNHI3?=
 =?utf-8?B?N2d5eTBxUCsvOE5seXI5OVkwMjAwZXQ1UHl3Q2dzMUJyakRZU2crZGxyV0tw?=
 =?utf-8?B?TzhzMkc1L2E0WnE2U3VHdjZlQWhYaW4rNytkeUxaclFVZmFvMXI0M053eXpL?=
 =?utf-8?B?Z0hMTHBoODEyR1BpVEZFWXNMRVlQSkJHdFp2TXp4cWpIUmlqLzlvZS9ablJW?=
 =?utf-8?B?bzdxcm5ZOGkyeEJEaDNvVnpUZ1hjbGR2UWFGTGhMRHJsSzNmdC9pNHJHdk9t?=
 =?utf-8?B?UitKc3VIZmdFaGltL2lkZVBONWxPUDE2bHZidldpVVdXRlBzd2RUNXNnSVc0?=
 =?utf-8?B?TEVKUVBLUDZYQVltYm1EdDNNQWlWdjdLZG5RcnMrSEI4U1FIM2FBVFc0azhU?=
 =?utf-8?B?c0Z5a2F2WUEvUGJoamlMQzRUN1JLWmV5UXNUL1ZDTWNydUlwT0o3d3BteDBW?=
 =?utf-8?B?d3lXTTlwTXJHbGlDSTdEbG5sUUZpLzg1S08rZHBXMWZoNFl3TzJBVGFXU3Jy?=
 =?utf-8?B?ZXdYZmxXSGU4bFloSDl6M3FoY0tYcGRETk5Ub25UOXh4NmgxSDhRTnlQNFV4?=
 =?utf-8?B?MDVxS2dKQUYxRnljbU1UVEdZZXowdGRaY0h1NWdBUEZ1VXdkd3dMcVRMWXF1?=
 =?utf-8?B?ZFJXNVdZSDJnWHc4cEdYMzZzV0xKbDFZMWhsWlR6NXZzcUg4TFFISlpweU05?=
 =?utf-8?B?aUFPSmxlVVp3Rm53eHY1M0xoZ3ZtdVpBN0IxeDU2a2c0SldFWHFWNWdPNkNk?=
 =?utf-8?B?LzQvbWxiSU15Z3VGNDVEaWU4a1kyNk1UUm5YMngwZXV4bjJSNHlvWnBIRFpu?=
 =?utf-8?B?N1p0UmZHOUdVUjFqaGV0STRCVzd6d3BPajRQNVJaemErWnN5dFZiVGdqY3VV?=
 =?utf-8?B?OEJwQ0kwUzB2NWNDMWQ5Rlc5QzBkV3Axc2wzTzhSSk1GS1lvMFRjWW5GN3Mr?=
 =?utf-8?B?c0xpMkxHM3JOODhEQVJ4Q0VkMEJlM0Y3Sk92bDh2eHI0a3QrUUdJM09EelFQ?=
 =?utf-8?B?NlduS3pYTEIzNHVtU2t0VnFXR29lNEZQWWh4Wm9KV1RMWDBVclF5V2t2RHU4?=
 =?utf-8?B?bDRvNHhqVjlWcis1NFJZSHc5TWZNMGpUUU11RkF3SnAyWTBDaU1sazlBQW9U?=
 =?utf-8?B?TlFuZGI2bXVieXlQRG92MEd1ZmR1akJBdXcvekwwSGJXZnVUVGhuZUR4WjBQ?=
 =?utf-8?B?NGVOL1hoRWFaVzJlMTBrREloSVo5Sld6MlMzRU1IckNxc29OOGlpS1N5bXhq?=
 =?utf-8?B?OGlvbUpjVU0wMVV2RUNhZElUY3JUdFpjSFV2OFZkM20vQXZHbjJ0SXdpVkJN?=
 =?utf-8?B?S2RnU3BFMmZxUjJ6QkpSMkZwUHdsbjRJaGFWU2pjazJOZ0hqMzBCTEF5R21z?=
 =?utf-8?Q?4DD4yipZgD7whChW7046TLU5F?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VUbWeFLLsQjhQt/6uPwyaunYvr3qZT/eV1VCD6xT7K85k7F9302GrER/VjPvnhlx9/qFp/3alxd0iN2mh3CoQEilbLSghvj5XYxJcUol7PcMvMNhY1aFYwNBSPaKkC5LDXYITnE0O9mJv/9ib8rhmq1KJi4lEG2qUaQBrVlh2jfngANmRop+DeMtgR9SrOEcnp8cynQPKE0/i+a7iCgEBinubLcUAaPckrs1YpMGXjOhxs89q9eUfgdaZmHBmlIRtedem+wMBmdEFBJx5PbfNv9RQWE4kky0+4JDp2EJzkCd0ztFHpYgGfvCTfqFoB9f/n0FgI48draBytP6QJvVZPImMeVJd7K7F1qZ9denvYOpRGSVFgCJEHsp2zOcMrvuhZMxwZY/cV79LLYrQWnJcP05hn6eH/gedhLyIv7S7HnGsIuF5ExnBH9Q7tp5r/RPR3IPILZSCBmNQ9HgwM5F1FIBdiwFPKTEX56ypQ5KkU0pMMtpVjzF+PT1Q24L6DAulx1+q5dUUqlZWFuPfyvyEQc6J44ImAc9Yk4VINUQI9+FienbPP/Wn3B+txEGvih94LjCZLyZ5rYxls3l/BYIuDhdd4Tqs8F/N/eoyfU6JVcqguVtDMaBZBuh8e+beXHN
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb9812a-b416-4e52-e79a-08dc470b62fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 05:22:21.0418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adMVN/Ns+3vO/jcAYHyTvC1Jg6TcLzDzCuWKNpFy2TUk9ZQxQMQpUKY/Q3RiN75VGE2yU3aGRnE0yfW9iMgnYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5895
X-Proofpoint-GUID: K18Ggh7m5LMVmPCpOCdPgcbZuF7Km9mc
X-Proofpoint-ORIG-GUID: K18Ggh7m5LMVmPCpOCdPgcbZuF7Km9mc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: K18Ggh7m5LMVmPCpOCdPgcbZuF7Km9mc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02

Rm9yIHJlbmFtaW5nLCB0aGUgZGlyZWN0b3J5IG9ubHkgbmVlZHMgdG8gYmUgdXBkYXRlZCBvbmNl
IGlmIGl0DQppcyBpbiB0aGUgc2FtZSBkaXJlY3RvcnkuDQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpo
YW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NClJldmlld2VkLWJ5OiBBbmR5IFd1IDxBbmR5
Lld1QHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFveWFtYSBXYXRhcnUgPHdhdGFydS5hb3lhbWFA
c29ueS5jb20+DQpSZXZpZXdlZC1ieTogU3VuZ2pvbmcgU2VvIDxzajE1NTcuc2VvQHNhbXN1bmcu
Y29tPg0KU2lnbmVkLW9mZi1ieTogTmFtamFlIEplb24gPGxpbmtpbmplb25Aa2VybmVsLm9yZz4N
Ci0tLQ0KIGZzL2V4ZmF0L25hbWVpLmMgfCAzICsrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L25hbWVpLmMg
Yi9mcy9leGZhdC9uYW1laS5jDQppbmRleCBiMzM0OTc4NDVhMDYuLjYzMWFkOWU4ZTMyYSAxMDA2
NDQNCi0tLSBhL2ZzL2V4ZmF0L25hbWVpLmMNCisrKyBiL2ZzL2V4ZmF0L25hbWVpLmMNCkBAIC0x
MjgxLDcgKzEyODEsOCBAQCBzdGF0aWMgaW50IGV4ZmF0X3JlbmFtZShzdHJ1Y3QgbW50X2lkbWFw
ICppZG1hcCwNCiAJfQ0KIA0KIAlpbm9kZV9pbmNfaXZlcnNpb24ob2xkX2Rpcik7DQotCW1hcmtf
aW5vZGVfZGlydHkob2xkX2Rpcik7DQorCWlmIChuZXdfZGlyICE9IG9sZF9kaXIpDQorCQltYXJr
X2lub2RlX2RpcnR5KG9sZF9kaXIpOw0KIA0KIAlpZiAobmV3X2lub2RlKSB7DQogCQlleGZhdF91
bmhhc2hfaW5vZGUobmV3X2lub2RlKTsNCi0tIA0KMi4zNC4xDQoNCg==

