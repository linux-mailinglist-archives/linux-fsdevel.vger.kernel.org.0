Return-Path: <linux-fsdevel+bounces-58197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D168B2AFD5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 19:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5373B188F87E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 17:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2C032C309;
	Mon, 18 Aug 2025 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T/LFmFS9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6312D248A
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755539836; cv=fail; b=UyWCa5rhfqs6ZSDgmpV2xDuR2jKKz3iVo4W+hmgPA9F73i5BCfxn6R/EheArgw1pxEpI4GyJJuo6A/NDqmoHpTengUmwRZhMddDU3Vsr2D7dimdEx4g8TKbPUDuIo504lOihSYeASXkExAlzPkpuASI44yVI3sXoPUNk1AEiduE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755539836; c=relaxed/simple;
	bh=PaC2oVyBxndPTh6r4IeoAJnL99kShbomXffrlqGcssE=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=HbCJqKFLMNR266BjH5I4xhlxaJ+huMCE/C/9X7xF62aX3dbNGu2VjjzNKXaLXk2iCDwT/awZcR4FXrtneY11dbYlnZVnvSEpbQMmp5KmRve0jUWfQRZ7Z5vSPmrrXlBpqWRVb7B4oi/u0euJDJgnWj+QKjEjYtMYBf1kp5r8xyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T/LFmFS9; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IAdo7K005381
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 17:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=N1a3o5YM27IKCBWigsXr6RxCNq0nLAXsCewosDt61cs=; b=T/LFmFS9
	0X/SDryVEfkL6Yrv3CtwLdyj4HeXCMgovoe1bBfCCS8tsnCRq2QcbS8FCAylRjyl
	cdOJjmzig2/60qNO6SDVnMv38maSVbk/JEIdOIy8IUEG49HVy86Md1X77t0IHGZL
	d0CI86q09HCsmd3t8a19+UiQJd/KHyeykagLZj7D5lBFmmOfUvVOLTisI5HaSpLd
	UFp6ar+miMNdlLaEC5WUag7Pw4cxCr5S/wjVFJvV055+kvh7QdMfCjVUNu1Fmbtd
	cDi3eNWIKX/Vd6WxoDL8PBIdwTwtc4h+2rB2e6hb1aHgGtclGa05WF9vNagOzq70
	Df+Lp5qPX2zbRg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhq9tmh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 17:57:13 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57IHvC8v029259
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 17:57:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhq9tmgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 17:57:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7WZ2/cxc8zdHO8hsj7XJDKj40mdEzWJQrcFWnunQFM4EVe7Yhh2eYe5AoNpVuHO/m79M/4ntS8bgMlquGIO0nZyh7b5RWSw9tf4ESKysf+/j9b/GnjmdQ1qIl4K08vJo/LuMomdOO/SiaUeZ5CNA4kgGwWbGqGU+Ugg5m4lRU0Lr3cE/vgPjkoEdjU/lXailCwsx1kQ+BeZmIm1metz6oy8RN/u6t2NsN+gUHtJ10ifk2MFLDUUF2v1GOC+VlodIkS4cW4iYx87P/76uZIOwRBwKNmYMeCAbmmLwFThUxEHBHAi+AEglUhUyjBHF5TjIeMUrFJ+tP+cTDB9FfhspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKYjAgbahITTB1p3j4cbdMZyA7S4qkfozv89vjZqgTc=;
 b=ZcWKVbCTikXuEzJeDuXw059XQ56QJyLgGGH82pJwbI3O5S5Q8iApXmRi/p5U2NbC9ZMqqXe3F3UxVrr8gYc+8R0affKUAJA4WnyQ6OZVfhlGpkjh4UR3VC/FMojpFYrAb5gnz8CXmpqGsKtj/6y+MypSWLcW81TyzTGnuCG3G4ITsmsRwUmK40c2xjlHMbptQWE06lSD3S5u6fd7i2rSdQzYPVG9aRsBNGBcSf2j/omSuGREURfx/jt6p7Oe7k+x9I2/DsbZoI8n0v/XsXsmAhW3Q/wcAHU1C913/bavulGfTLRT27ZcRzcL8L5nrvcTw8Q4Ex3/gkRdNoTNzA1AkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com (2603:10b6:a03:4e4::8)
 by CH4PR15MB6728.namprd15.prod.outlook.com (2603:10b6:610:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 17:57:10 +0000
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::266c:f4fd:cac5:f611]) by SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::266c:f4fd:cac5:f611%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 17:57:10 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "yang.chenzhi@vivo.com" <yang.chenzhi@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+356aed408415a56543cd@syzkaller.appspotmail.com"
	<syzbot+356aed408415a56543cd@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] [PATCH 1/1] hfs: validate record offset in
 hfsplus_bmap_alloc
Thread-Index: AQHcEE4N8uix2B3IpkSNxde5cG5NbrRosmyA
Date: Mon, 18 Aug 2025 17:57:09 +0000
Message-ID: <8b6963fafb952d386800cf3fa7e823a9992adbb1.camel@ibm.com>
References: <20250818141734.8559-1-yang.chenzhi@vivo.com>
	 <20250818141734.8559-2-yang.chenzhi@vivo.com>
In-Reply-To: <20250818141734.8559-2-yang.chenzhi@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB5821:EE_|CH4PR15MB6728:EE_
x-ms-office365-filtering-correlation-id: 553d8cf7-309b-4e02-8c00-08ddde80a73c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VlUwR1ZzY3hnSlBwQW1wUEZQalJEakZxRHllS2FXeGdnR1NkU05udFZVUXpQ?=
 =?utf-8?B?UjUzcHMxWG1nQzlReUR4bHd3TkttMjVDMm9yK0FFYTZuc0dmZ3pSMDhSZHFV?=
 =?utf-8?B?SnhIY1hEM1hiOU5HYytOSC9sRUd4SGU4Y20waE9KazZDTlJ5TEh1Z1V5KzVy?=
 =?utf-8?B?M0cyU0RHSlpUZ0NmV1ZsVGorM1k2T1FYcDRQMDhCR0RudjgrK1UyOWl5VG9n?=
 =?utf-8?B?V2ZFUHlXNjIxSlFKQzZCSGxFMTNsSTJxeTZVVmJrbGhvSFdadUlRZ21FTDhL?=
 =?utf-8?B?cHlzV05YQTlXcXI2TGJhV211Rjh6NWZQU1NLNDFEb1V3V1FNekpJVmEvdGs1?=
 =?utf-8?B?ZUNuSGdVaGd5bzBGREU5M0hxT2NkWDlITXNiSjJUNzZGcUpUZEJnYkpFTUpr?=
 =?utf-8?B?Y3BYZzNGa25RNzRscXVsc2R5b1lYUlA3a1MvOXV0dHc1UGhiU0RScWNsQXhu?=
 =?utf-8?B?NFVNcGN2SEVLK1dtMEVKaWdRYjZBNTU2N0lJSThKM1Y1QllBaW9vTUtvQjV4?=
 =?utf-8?B?WE5NWkR1RXVGNkxrNXJTOTUrUHJRVXNvWitZMWVRZG5rWlJ0cjlCOUM0VFor?=
 =?utf-8?B?M0ZmcU5XNTErbXI0MXNxbEdaNXBnS0lBWStWMzh4bnhaNGtTVzlTbFBCdU91?=
 =?utf-8?B?bWNjS2VqZmZFL3c1RjJQVHIzTFpGd2xzNExoazNRcm5zNno3OUlUNVVCYmdC?=
 =?utf-8?B?aUtXcU54MnZBRjEyZlJ4WWZFUE1tMXlpMkUyVzFTTDRUamRiVlRXOE9QTjhs?=
 =?utf-8?B?RHZQSnNrZnI0ekNHOGVKZFFRdUJzdW45VmVzWFNzcWxIQnJUUmg3WFVtTy9S?=
 =?utf-8?B?em9JMGs4dlhqTVUyZ3JiNE9IMlNMUXNSbzJpWDVESHhnUlU2L1JJL2xCbEdC?=
 =?utf-8?B?T0lyQ2hWckh6cU51dEcycS9BcjV2bTVMY24yOTVid1l1Ujl1WXVzeEo4UnRF?=
 =?utf-8?B?YkVSb3RQT0E3dDhCZ3VpaDJjMHEydFpQY0ZNZVBqc3RGellscjFHbkhmZU53?=
 =?utf-8?B?akEwNjFhRk9pK05lUEpOTlBrVjVDclhQSjgzaWd1SWs2a05yazdDaXRBUEJT?=
 =?utf-8?B?Vk03eUkzNjZBejdzN1BaZjlRR3JzUTZxa1loQU5WWnVrNEVEeFRMMEFYeWJ4?=
 =?utf-8?B?QzUrbjN0dTdiS2NZM3lGQXVrN2h0KzhoeENqTmlZdjJkdTJMbFZSN05wcGNK?=
 =?utf-8?B?TXI5NjluNm02RUNLejEwYzZGRjI3aTV1ZDZBelVraGJIZjg0ajNGeGswUjZp?=
 =?utf-8?B?eEZTa1JYVEVWUm51MmtaUjlweENBQVo0N1pDaFVFTUpwaWdUSUpySStDMVRW?=
 =?utf-8?B?UGMwUkZ6UzBwMy90Ti95WkpMcVMyQ0JsbWtIck1uOWFMYlUrbEVpT0MvSXpE?=
 =?utf-8?B?QkZaa1p6WFZ2ZFBqSUxwTDFNUDJTdStKaEpwZjJmRWFRczBOcHo4VFJ3QVAx?=
 =?utf-8?B?c1BEbEpHRHIvMC9ySGw0QzdlMUd3NFN1T2RQeWlpNmJBMkxZb0RNc09QQUVU?=
 =?utf-8?B?UEI2M2VRb1Z1UENyMFhyRHdZQ1NBRlpGdWFGQWxwRXFzTENwaXU4NkVKcnZu?=
 =?utf-8?B?elkwTjJnYmUzSEVndVBHVXkzY2JqZ1IvWW1lQzgvVGo5THUvRG1GVURNT2lm?=
 =?utf-8?B?eHlVWGM2N0ZaQnFUZHdmTVVEZmcrWW1PKy96QXJ4dHVQK2syMmFKV3JZRmZQ?=
 =?utf-8?B?cGwyYkJ1WHpKbTIvMlA4WFgyU2prYVlja1duRVZPc290MVRKZllPbzk2OEFa?=
 =?utf-8?B?UUpmZktzOWpYZzUvM3lCWExEUGdBMDNoQTcyYktwbGZodWJOdE0xQXhvMDlu?=
 =?utf-8?B?YUJ5VmNmL1BaM09MbENRYnFPWkY5dzBtdGNBMTZYSUNtM2swd2EvOEI5dFhZ?=
 =?utf-8?B?ME9sc2pEWXNxa3FRc00yRkxCNlBsS3Z3bllSN1Q5WWxPSS9taityTkFLMGRL?=
 =?utf-8?Q?+X5oLWo61hc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5821.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cGdtSlh5NFo1Qm1EclFVRENLeDJ1bEVjaURzdzhzSjhCN2NZcDd6NG9iaEpl?=
 =?utf-8?B?RFJnLzI5NEMzaWhmWTdNTlZPazV0a2pKdTVhN1FHUzQ4OTB1K0hsNUREQWY2?=
 =?utf-8?B?QkdVMUZPK0VzNUpRc01tUFd2UitkMHdwSElBRWJJci9lYzdEMjdCeHkwaCt4?=
 =?utf-8?B?NytsUXRJVzU5ZzJ0TWk4UzdmQWVrVGJzSUNOUzNWMzcyZXc0Ky9CalRXdGJI?=
 =?utf-8?B?Z09kRy9ESDNBbU5oeXd0TmRydm9EdVh5TEdqcXRlQkV3aCtXOU9vaUNkZUtK?=
 =?utf-8?B?L2pOMmJtRFVFa2xJdWpVWHU2RTdJeEVmSDNsSVlyOWllYkxQUG1iNXhQS1Bk?=
 =?utf-8?B?WWhjTjNNVTN3dW15VjA4aDk1VGNtaEZaTyt0aVJBejhmOFZFMUFzMjVaZ1Rj?=
 =?utf-8?B?QUlyWHdya1dzUFVXK21vK1B0RnVpaXlVTGMrcGpIWHduNS84UGtjdHV6WUNU?=
 =?utf-8?B?d1ZNSmdjbm5PMnNOUGxYazRzTVV0OXlKVGtTaTMyQk03TlE3Q1hpK2F5eFA1?=
 =?utf-8?B?MkZwNjVGeStMNEVFL0k2WUtuNEJVRDI5WGhmdlZKZzhnQjUxVFpXUzNra01C?=
 =?utf-8?B?Y1hEZFp1ay91RFlHcHl2cktSazhjblRKQzZCc3FDNkF2eUUxRmRQZVlha2o0?=
 =?utf-8?B?dTZkalJEa1daNnNpeGxIK0Z4KzMxMEVrbnVoU1JYM1RZd2p6aUZPamtqTGI5?=
 =?utf-8?B?NGlIRjhhZjBaMjJwNDFXakNOakJJaDJXSW9JUnRjRW9qWHJ6VU1YUmRNd3Jl?=
 =?utf-8?B?NDRRdVlCMGoyV0tqcEVjLzlBZFQ0ZUM1QS9YN3RHamoyeFlMbWVEblJYY253?=
 =?utf-8?B?ZVllNGtSeUl3UGlIQUFRRTZkZ2VqNE1wWDQybWl2NmdWSVEzNTNRQU9nbm9t?=
 =?utf-8?B?Z3JMcy9YK2VGYVhyNFRDUDVYcjJ1U2RRUGJwdVJHTmhITGNRRk1aR0srV0JC?=
 =?utf-8?B?TnczQi93ZWtCci9xU1Jldld3TlMxOUoyYThVOUVZOE1MSG5iNmFLMGdjOW5W?=
 =?utf-8?B?Uy9WUlpZZkhFWUlsM0QrK2hTZ2d3ZndFTmpla3JKaEw5d1cxejdYYTdNei92?=
 =?utf-8?B?a1Q5QVdZcUx5a3JVYndrUHhzZ1NXR1hzTWNEa00zU1J4R2JkRUJkT3dEQXZL?=
 =?utf-8?B?aW9ndUVQVzFpYVdWeWxoalJleWdCSkJyaWF2UTN2dE1Ud0tYc05uU2VOb2ZX?=
 =?utf-8?B?L3J3Yis2U3VmZTcyT2hJU0VlaGc3RC9vYkZPRWxacXphWUhMZTZOZnFaODdL?=
 =?utf-8?B?QmRCNkFhUGdIMjJ6MDliS0YxUEE4RDhDMzFnS3V4TDZvTEFQbzV4MGhVdzFI?=
 =?utf-8?B?NkI2aVdSQUtjcnVFQUt3YTNOQzRIV0QraEdmNXp0N29PK3BONUNDVDJSdlV6?=
 =?utf-8?B?Qk1nSFdYVGVGVmVkR1o1WTc4ZVY0dHJBNEFJVGxNOVVwa25vS0pEeDhYRjNU?=
 =?utf-8?B?Ri85VWc4MkZxaCtuZGVPOUtmQWpUSWZ3cGNNMGc5dGxUcCszOFdHa1RTeXI3?=
 =?utf-8?B?MEM2SlhOdHlYSDhibVhGVDg4aXkveW1wRCtqVktMR1ZMVUFTRHFuN2ZNTEY3?=
 =?utf-8?B?RzZMdlRhQnhNV0ZidDVBUXJCMXY1VndVTFZTTDRjT0s4dU1XVzZDUWhsWmZu?=
 =?utf-8?B?cmFPQ2JXRmRWZkhMT2cvYURsbXV5ZVdxS2k3LzhVQk1BazBPeUNucHA3RmNk?=
 =?utf-8?B?VnVKRldsWEkrOUdKbWVHaDJscEYxdnZSV1Q5QUdGSmttdXd3MmdCbVR3WHd3?=
 =?utf-8?B?MHpDUzlPY215eU9QYTkzZ3BCU3FnUTduSXFJbmtlZDFRK1FzVmhpc3p6OU5m?=
 =?utf-8?B?V25zSzlBcHJPOU0vY1hPTHBKMVhHS0FXQm9neVFaRkdZWlJpRnZJalN0OVBm?=
 =?utf-8?B?MEowSDVJZHdoOThwa1hKSi9MMVlCalJyZXV3TDZXRnJKZ2RTck14TXRmY2F5?=
 =?utf-8?B?bFRRazZaeVhHNXZuaHRaWFFPT3BGOC9rbWRMbmF2UkZhY3FGRWxVS0tUSE1I?=
 =?utf-8?B?dTJYWHExcitlRlh2THZtSUVQSC8rQktWODJGSGdON0hiMFJVUVh1czltZ2Jm?=
 =?utf-8?B?N2E5RXVMdytSczlsSEVUQWlVbmdtNmRJbm9jMFh5eUlzbGRNVGxsbmw1bGlp?=
 =?utf-8?B?ZmRMMjJrTUg2dkVrOVc2Z2k1UWc2aEk3TzFVR0dGZmZlWTJIMzczMkhzTU9X?=
 =?utf-8?Q?013d+wJm6hWrlvGyQHhZnIQ=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5821.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553d8cf7-309b-4e02-8c00-08ddde80a73c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 17:57:09.9209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: faLs3EhF4QUgyUKg1o8mbi3yH4CO3c5rkpPjruEKWmnZnpARyt8ZdBumBAIqZdmd1rJ6hedbbnr8ICcCb7PfLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR15MB6728
X-Authority-Analysis: v=2.4 cv=N50pF39B c=1 sm=1 tr=0 ts=68a36978 cx=c_pps
 p=wCmvBT1CAAAA:8 a=b6iQ4nEtd725l5RCOKWvWQ==:117
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=1WtWmnkvAAAA:8 a=hSkVLCK3AAAA:8 a=JVQ107xQeHzyCC4DeowA:9
 a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNyBTYWx0ZWRfXwXCxlKVYszPv
 phiVTi1+lgJm3P0tB9tVyY4Ib16i851lMDmATPeMOUM9ieekhPtcIeGb6JaVxhgn9sOs5v/pzpZ
 940VGER9fOcS/rbPBI1qNi/CkOPxphqER8b8bCSLYGS0/sHL8OjVFxD7INX63WKCg/3R4Q3axa+
 /YFHmVj4J+l/z+rP8VsXPaLymbi73DazfD/GGGEIkmlC8GXSbLCZQVw8TQ7+Lii9xWWRA1rGG+8
 aPD5tMR9KCDnRjnTJtn42Pq58mbadcVgQKFUw0H978gKqtdbDfRaQnqUkmWo3tgLIbFGj4m/eIk
 6uz9YvD71+B4eqL/ICV18TaapSBDS+U/LXRM250Nmp9n5ekETY7PWDmdo2IfM2rSgZ1XrpQxvrL
 Y3BVSKT8
X-Proofpoint-GUID: UFoxbCz9iaeCfMpiGSFg-Hl_j1nVqbgi
X-Proofpoint-ORIG-GUID: UFoxbCz9iaeCfMpiGSFg-Hl_j1nVqbgi
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E977492BC2FD94CA6C942E82D98DC88@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH 1/1] hfs: validate record offset in hfsplus_bmap_alloc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=99
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1011 classifier=junk
 authscore=99 authtc=spam authcc= route=outbound adjust=0 reason=mlx
 scancount=2 engine=8.19.0-2507300000 definitions=main-2508160027

On Mon, 2025-08-18 at 22:17 +0800, Chenzhi Yang wrote:
> From: Yang Chenzhi <yang.chenzhi@vivo.com>
>=20
> hfsplus_bmap_alloc can trigger a crash if a
> record offset or length is larger than node_size
>=20
> [   15.264282] BUG: KASAN: slab-out-of-bounds in hfsplus_bmap_alloc+0x887=
/0x8b0
> [   15.265192] Read of size 8 at addr ffff8881085ca188 by task test/183
> [   15.265949]
> [   15.266163] CPU: 0 UID: 0 PID: 183 Comm: test Not tainted 6.17.0-rc2-g=
c17b750b3ad9 #14 PREEMPT(voluntary)
> [   15.266165] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996),=
 BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   15.266167] Call Trace:
> [   15.266168]  <TASK>
> [   15.266169]  dump_stack_lvl+0x53/0x70
> [   15.266173]  print_report+0xd0/0x660
> [   15.266181]  kasan_report+0xce/0x100
> [   15.266185]  hfsplus_bmap_alloc+0x887/0x8b0
> [   15.266208]  hfs_btree_inc_height.isra.0+0xd5/0x7c0
> [   15.266217]  hfsplus_brec_insert+0x870/0xb00
> [   15.266222]  __hfsplus_ext_write_extent+0x428/0x570
> [   15.266225]  __hfsplus_ext_cache_extent+0x5e/0x910
> [   15.266227]  hfsplus_ext_read_extent+0x1b2/0x200
> [   15.266233]  hfsplus_file_extend+0x5a7/0x1000
> [   15.266237]  hfsplus_get_block+0x12b/0x8c0
> [   15.266238]  __block_write_begin_int+0x36b/0x12c0
> [   15.266251]  block_write_begin+0x77/0x110
> [   15.266252]  cont_write_begin+0x428/0x720
> [   15.266259]  hfsplus_write_begin+0x51/0x100
> [   15.266262]  cont_write_begin+0x272/0x720
> [   15.266270]  hfsplus_write_begin+0x51/0x100
> [   15.266274]  generic_perform_write+0x321/0x750
> [   15.266285]  generic_file_write_iter+0xc3/0x310
> [   15.266289]  __kernel_write_iter+0x2fd/0x800
> [   15.266296]  dump_user_range+0x2ea/0x910
> [   15.266301]  elf_core_dump+0x2a94/0x2ed0
> [   15.266320]  vfs_coredump+0x1d85/0x45e0
> [   15.266349]  get_signal+0x12e3/0x1990
> [   15.266357]  arch_do_signal_or_restart+0x89/0x580
> [   15.266362]  irqentry_exit_to_user_mode+0xab/0x110
> [   15.266364]  asm_exc_page_fault+0x26/0x30
> [   15.266366] RIP: 0033:0x41bd35
> [   15.266367] Code: bc d1 f3 0f 7f 27 f3 0f 7f 6f 10 f3 0f 7f 77 20 f3 0=
f 7f 7f 30 49 83 c0 0f 49 29 d0 48 8d 7c 17 31 e9 9f 0b 00 00 66 0f ef c0 <=
f3> 0f 6f 0e f3 0f 6f 56 10 66 0f 74 c1 66 0f d7 d0 49 83 f8f
> [   15.266369] RSP: 002b:00007ffc9e62d078 EFLAGS: 00010283
> [   15.266371] RAX: 00007ffc9e62d100 RBX: 0000000000000000 RCX: 000000000=
0000000
> [   15.266372] RDX: 00000000000000e0 RSI: 0000000000000000 RDI: 00007ffc9=
e62d100
> [   15.266373] RBP: 0000400000000040 R08: 00000000000000e0 R09: 000000000=
0000000
> [   15.266374] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
0000000
> [   15.266375] R13: 0000000000000000 R14: 0000000000000000 R15: 000040000=
0000000
> [   15.266376]  </TASK>
>=20
> When calling hfsplus_bmap_alloc to allocate a free node, this function
> first retrieves the bitmap from header node and map node using node->page
> together with the offset and length from hfs_brec_lenoff
>=20
> ```
> len =3D hfs_brec_lenoff(node, 2, &off16);
> off =3D off16;
>=20
> off +=3D node->page_offset;
> pagep =3D node->page + (off >> PAGE_SHIFT);
> data =3D kmap_local_page(*pagep);
> ```
>=20
> However, if the retrieved offset or length is invalid(i.e. exceeds
> node_size), the code may end up accessing pages outside the allocated
> range for this node.
>=20
> This patch adds proper validation of both offset and length before use,
> preventing out-of-bounds page access. Move is_bnode_offset_valid and
> check_and_correct_requested_length to hfsplus_fs.h, as they may be
> required by other functions.
>=20
> Reported-by: syzbot+356aed408415a56543cd@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67bcb4a6.050a0220.bbfd1.008f.GAE@goog=
le.com/ =20
> Signed-off-by: Yang Chenzhi <yang.chenzhi@vivo.com>
> ---
>  fs/hfsplus/bnode.c      | 41 ----------------------------------------
>  fs/hfsplus/btree.c      |  6 ++++++
>  fs/hfsplus/hfsplus_fs.h | 42 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+), 41 deletions(-)
>=20
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index 14f4995588ff..407d5152eb41 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -18,47 +18,6 @@
>  #include "hfsplus_fs.h"
>  #include "hfsplus_raw.h"
> =20
> -static inline
> -bool is_bnode_offset_valid(struct hfs_bnode *node, int off)
> -{
> -	bool is_valid =3D off < node->tree->node_size;
> -
> -	if (!is_valid) {
> -		pr_err("requested invalid offset: "
> -		       "NODE: id %u, type %#x, height %u, "
> -		       "node_size %u, offset %d\n",
> -		       node->this, node->type, node->height,
> -		       node->tree->node_size, off);
> -	}
> -
> -	return is_valid;
> -}
> -
> -static inline
> -int check_and_correct_requested_length(struct hfs_bnode *node, int off, =
int len)
> -{
> -	unsigned int node_size;
> -
> -	if (!is_bnode_offset_valid(node, off))
> -		return 0;
> -
> -	node_size =3D node->tree->node_size;
> -
> -	if ((off + len) > node_size) {
> -		int new_len =3D (int)node_size - off;
> -
> -		pr_err("requested length has been corrected: "
> -		       "NODE: id %u, type %#x, height %u, "
> -		       "node_size %u, offset %d, "
> -		       "requested_len %d, corrected_len %d\n",
> -		       node->this, node->type, node->height,
> -		       node->tree->node_size, off, len, new_len);
> -
> -		return new_len;
> -	}
> -
> -	return len;
> -}
> =20
>  /* Copy a specified range of bytes from the raw data of a node */
>  void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
> diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> index 9e1732a2b92a..fe6a54c4083c 100644
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -393,6 +393,12 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *t=
ree)
>  	len =3D hfs_brec_lenoff(node, 2, &off16);
>  	off =3D off16;
> =20
> +	if (!is_bnode_offset_valid(node, off)) {
> +		hfs_bnode_put(node);
> +		return ERR_PTR(-EIO);
> +	}
> +	len =3D check_and_correct_requested_length(node, off, len);
> +
>  	off +=3D node->page_offset;
>  	pagep =3D node->page + (off >> PAGE_SHIFT);
>  	data =3D kmap_local_page(*pagep);
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 96a5c24813dd..49965cd45261 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -577,6 +577,48 @@ hfsplus_btree_lock_class(struct hfs_btree *tree)
>  	return class;
>  }
> =20
> +static inline
> +bool is_bnode_offset_valid(struct hfs_bnode *node, int off)
> +{
> +	bool is_valid =3D off < node->tree->node_size;
> +
> +	if (!is_valid) {
> +		pr_err("requested invalid offset: "
> +		       "NODE: id %u, type %#x, height %u, "
> +		       "node_size %u, offset %d\n",
> +		       node->this, node->type, node->height,
> +		       node->tree->node_size, off);
> +	}
> +
> +	return is_valid;
> +}
> +
> +static inline
> +int check_and_correct_requested_length(struct hfs_bnode *node, int off, =
int len)
> +{
> +	unsigned int node_size;
> +
> +	if (!is_bnode_offset_valid(node, off))
> +		return 0;
> +
> +	node_size =3D node->tree->node_size;
> +
> +	if ((off + len) > node_size) {
> +		int new_len =3D (int)node_size - off;
> +
> +		pr_err("requested length has been corrected: "
> +		       "NODE: id %u, type %#x, height %u, "
> +		       "node_size %u, offset %d, "
> +		       "requested_len %d, corrected_len %d\n",
> +		       node->this, node->type, node->height,
> +		       node->tree->node_size, off, len, new_len);
> +
> +		return new_len;
> +	}
> +
> +	return len;
> +}
> +
>  /* compatibility */
>  #define hfsp_mt2ut(t)		(struct timespec64){ .tv_sec =3D __hfsp_mt2ut(t) }
>  #define hfsp_ut2mt(t)		__hfsp_ut2mt((t).tv_sec)

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.

