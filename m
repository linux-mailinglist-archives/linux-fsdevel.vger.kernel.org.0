Return-Path: <linux-fsdevel+bounces-45474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E6DA7824F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 20:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D6E16E491
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 18:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4412021420A;
	Tue,  1 Apr 2025 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dwItfBL6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163CF212FB0
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743532152; cv=fail; b=rM9Ov5aeHwp/iPGfy3QUqdrS/r1tV48yjTCqQsHelXYDFP3jE4Tdb0hBanQojbMMyrX6XV18qwgAKtC/Wza/d+FvSw1r87dIb6AZFsnlh+D+Lw/GVQRiTWVnwtus9oi1ov0nSUOjTgjkcIzEGSALOTKz+eAAq6L+k3auxusrxyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743532152; c=relaxed/simple;
	bh=TFMJDw/fjnLMemoWpv2cqy7nchDe/O7bb5tGqrSvpfg=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=sPncnpV4DiFMN7fAo4PJnZz3ZFDlSAlakD0r+2dBVabbkCqupuz6uDqcw9ZBJULjUWCgyOe6N6Tj7XFaeBI/PqGabmL2hPhMywBwf0ZuyeMrDkxn9MnEj3ijX5amITT3Mfonj5arq2hUexp+M80vfeKpNi/wNN0rvO7qaXYvlfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dwItfBL6; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531Gf6dv026002
	for <linux-fsdevel@vger.kernel.org>; Tue, 1 Apr 2025 18:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=Atgt/B3z+WhShkMau7u7lT5VC4C7GmVSGnVjfV3Pczg=; b=dwItfBL6
	zpfPB4v+3sVhkBImuS5X91vTD/LockcsTl5WgJYOnfcBO8ka88v0mzzoL7NULAfN
	VkG9uhE79A35BJb0t6/aelfvseKOADqMdhaMOQTo953tSlEAhM6+mpDivq0dJ0X2
	bPktt92MNzIOTKRfsmaP5NOUT1drLAY9SZPPLjNwtb98yBabOp0j8cD3XshLmhjL
	l7nq352Ks0V+qaMk0ch0WyO8vSCQKJGJKbJ5WNkwW2z+tBVMuhgBxUBbOimZTiiN
	Zwj7k/UP4fZgngG4MVO493bnoWTdV14DE4wmGUeR1MkGdf3qTvHLoKSjYrpZGLZi
	r0Db4L3EBYWCPQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45r27q5ere-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 01 Apr 2025 18:29:10 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 531IT9P2008831
	for <linux-fsdevel@vger.kernel.org>; Tue, 1 Apr 2025 18:29:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45r27q5er8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 18:29:08 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 531IPoRw001186;
	Tue, 1 Apr 2025 18:29:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45r27q5er1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 18:29:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTGFvlM+6k072q5f2bbLhdq7q1hMkopPPXT3idlO85V6nlgUa4TdhLlGaDdnRcn13x9wW37/vJ30TeSIWbc16znZahEVD5h/RwuFwG8cb0zr8U5fI6sQJund6ppdyaA4MMb8W0eXAl7YrnO0FrFRh3V8u/iZsyKIM/GGSsZFQZWxuOmB8iHvOivCY4uqZ8N6bAM599kv6kUvx4r67f5hS2KFERZ8iwd47dk7p02e2nKuYl2Nc5F4R/1KAJv+DjOb57ysphbfsYQcNatUbZoyCwMLtmiLyjOeZfw+5gD3g16VzbtfugCY3EWUQB+575uXPg+58qPwbHqKaq0WDIFf5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W13TqJO8eKIpWwGBp3tTVbUq0JRCVeikrgxdHEtYSrc=;
 b=MZSR1d0a7hm1t5aSCcYsvxz7Tk6hrDzGyJhyrAaOmOt8n32UeClxKQNwM8vDdEjT3Mu68R4R9Fzo8ndXYE9x7NemZeExTUF9SgTo4RnL9FrUhmdHHxNqOsY7LM4CYEyJ6UbE/CD1JuDIVMMkHln7B5/ystc/lSOIdK3j3W18ZMSxjwkBal/sUGIR+ZnWKMABMOSB56TYqoUDKZdtD/gCIdxmRbu3wAdF/ehNUoG7s/AIOvCIrtqp58qJk87slg46eHDu8M8ivyn6BxWJdOCyYhIKu31AN3yDu9oZCr7NadYem63ic0tQkIU9ql7O6s1JBOCcOmfwG6Re3zUEzgTldA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS1PR15MB6669.namprd15.prod.outlook.com (2603:10b6:8:1e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Tue, 1 Apr
 2025 18:29:06 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8583.038; Tue, 1 Apr 2025
 18:29:06 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "brauner@kernel.org" <brauner@kernel.org>
CC: "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
        "lkp@intel.com"
	<lkp@intel.com>, David Howells <dhowells@redhat.com>,
        Patrick Donnelly
	<pdonnell@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] ceph: fix variable dereferenced before
 check in ceph_umount_begin()
Thread-Index: AQHboBFWOIOjo1BdNEKndu3nF/bxmbOI74AAgAW05oCAAINcgA==
Date: Tue, 1 Apr 2025 18:29:06 +0000
Message-ID: <3eca2c6b9824e5bf9b2535850be0f581f709a3ba.camel@ibm.com>
References: <20250328183359.1101617-1-slava@dubeyko.com>
	 <Z-bt2HBqyVPqA5b-@casper.infradead.org>
	 <202939a01321310a9491eb566af104f17df73c22.camel@ibm.com>
	 <20250401-wohnraum-willen-de536533dd94@brauner>
In-Reply-To: <20250401-wohnraum-willen-de536533dd94@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS1PR15MB6669:EE_
x-ms-office365-filtering-correlation-id: dedaaae9-02f1-4462-83b1-08dd714b160e
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OXBpMk1FTWV5dUM5VWdEVVhGQzFIMmVyTVlVWTEvTHdSaTNrZGM0Z3A2WjNY?=
 =?utf-8?B?ZWdJY2VOU3QxMktoaExkMWhCY3hneEVzc2xNNUtmQndVV2UybzJ1YjFLa0xy?=
 =?utf-8?B?M2NkUktDL1grN2dmZ0pQdFZYcTZ6MkdsWS9EVTZPM2NwL1lMRmFNaWhqR21P?=
 =?utf-8?B?THhrNnBkMWpCeTBkQ3hIY0FYbm1JemRXMVNVYm5SYWpaSHZqVnJneE9ZSnBn?=
 =?utf-8?B?SUZXclFMNktzVDJOaGpqM2xOa2hrY1EzV2Exd1E5V3pMc2FRV28yTkYwTWZz?=
 =?utf-8?B?dTR6MEdJM05RSThOaXVUTzZXYy9yRnJGaUp1ckY5MWNxU291KzF4dEFIRTVi?=
 =?utf-8?B?c1FyREtPVUdEN0hXRzNtZER5b1RKTHFqdFUzazM4QzlXZHcwUGtIRm5XNVVN?=
 =?utf-8?B?dk1CVUdRelVOUm1KNzlqT1VlcVlUWTdhbFlsV0xkZ1M5RXBWSGFCQTA5UXhM?=
 =?utf-8?B?dEhUVnp6dCtmVllVQmhnVXUxUVQ4WUJPNUVIL2NNellwQlVSbUJqVGh1RlV6?=
 =?utf-8?B?Wll6TFdGQmhxb2w5K2w5Z240VWE5aUVFdEZOQnkxYittZWpJa042cWFKVklO?=
 =?utf-8?B?TzJVZ0xtNWkrRURVdGRBejdoRzJpWGJ6RnBnd3BYaHRuVE13cnhIYm1aS2tv?=
 =?utf-8?B?WVRkK0tLb0VURUNoQW8vR2hZVng2aWNmV3RPbzBpTmllTmxub1VTRnpTSFVt?=
 =?utf-8?B?NmdTUERmRmVjVlV2aXBRT1JnQnJHaVpuRWp3ZkpBeTlGMTJhOHFacHpoaWxV?=
 =?utf-8?B?L2dxN0V4VmxkZjBKRVhrWG9vcEZhSkRHWTNQcG52WXJ1T0NFc0hsVG4zeUdE?=
 =?utf-8?B?UnZKWmlvbXpVcm9KQmVqK0ZYUGpDSmFjVE5TY0hvMnJtLzdmQnBkcnE3UENl?=
 =?utf-8?B?bHBJWkdTN2ZqRi9sM3ZlRzRweDJnckZvN2pWaDdxZFdkejNPMlBGQ2I3R3FV?=
 =?utf-8?B?MW12M1pNSmIxNnlLS3I0SktSbWlmcytnQys0QUlVVjc5eGVZclllM0RoQmJK?=
 =?utf-8?B?QlRPU0wrREZEelB1cHRrd1pmRm92dTdYa05tMWdFZ3FkYWpzS2VCT3hJbXA5?=
 =?utf-8?B?ZlhyUkZwSjgyZ3pGa1doVGV0c1hWVmxVbmJZRTlMbjM4bndxSUNRdG9WTmo3?=
 =?utf-8?B?T1I1NmY2aTNJMVNDVk5IQ1FOc2hLdVdXc2dUS0RVK05ERzVwL1BlbFJ4U0hp?=
 =?utf-8?B?V2hjL3h5VjNPSHNaa2psaTdXaWJMZlhIR2hJMGtrb3JzVUkvSzY3UnpMeVR6?=
 =?utf-8?B?eWRYTkRHZTRNNXVLelpwck5DZzEydXJsVDYvN0w2UUNsbkNLNE9MUU1wd3hw?=
 =?utf-8?B?aEZpY1FqM0ZOOTV0UVhZZmdVT0VybWh6NHhvRU9odTlmTkhlN3pnUy95dmtz?=
 =?utf-8?B?YzhSRWczY0srMjF1N2kwb1BwTzN0eGtZeXZIbTVJS2I3ckxTQ1pwMWo0MENz?=
 =?utf-8?B?ZEhBYmp2THc5dkxMVkRySUxpOElMdXd6aHZzWHZoRVl0TkNubkZJajZ4Rks4?=
 =?utf-8?B?ZTVyT3l3bFR2VlJLdFE5WU4xYjdpZWFtbkdUcGhtS3pEbEVXUUJTVUdjQXhX?=
 =?utf-8?B?MlA4OVRqblFWTGJTTytaWU8reFZyODlkZ045U0NLK0l3MExZdnYraVFrdjI0?=
 =?utf-8?B?UUxDd2NyQ0hFVzQ3eHI3Ly9YNndkRkkxaW5XSEp2ZHlLR0MrbzZyNnFXVC9a?=
 =?utf-8?B?M2xiaHJzVFRsY3l2ZERoNDFhTFlRdTQ1U25seFFGN29Ud2REWE5VcTJFNU5N?=
 =?utf-8?B?SGlzVkpHSHp1Y1lUdzB3d1p5YzZINXhWaVArK2ZCZVgrenlpTFJ5Z3Fielht?=
 =?utf-8?B?NlluajNHekNNbWQ3a1RLU3ZPOU5sbDVma2NTVnRMNzFwc0pyREQ4YStwb0c4?=
 =?utf-8?B?WVVhUUQza2pNOTl1M2xtQ2QzYWF3K2VrbzdFZTlNblU4VUlHMGpKN3RpWnl0?=
 =?utf-8?Q?m3ebTZUwM7Np9RtHZnTcoF9GFrxtUsN5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0RkSjZIakZ1cjFkQnBudHhTNENOMURzOEppWnlmZFIveno2UjcxbFB1Unlm?=
 =?utf-8?B?cDRqWFA2ZklZWVZSRWNuVmVoaVRvQWdDeTBZbys3UGFwYUpzYlZuWkxFZXcz?=
 =?utf-8?B?S29XQ0ZwZSs0UHRjMFUyUUViYTAzMjlLdTJPRm1UVHR1RitSTnhZeE5wME1G?=
 =?utf-8?B?Z0ZNWmlHc2w5REh0cWRRQndXajNMWWJhcno5SzU0UnI3WmtMdmNxRHBqUXJU?=
 =?utf-8?B?T0c0S2NUbDNaTzdjTFp4bWdFaDMyS3JXL3lTUFk5RmlQNXp6aXRQQ0s4NEMv?=
 =?utf-8?B?V3p3QVF0bGFGcXpUcmQ5dU91elo4RmtUc0tnMUc2SXF3Tm80bkpicHZwMVI3?=
 =?utf-8?B?c1Frdmh4by8rZ29OQTRwV3AxWWt0SjZOZHR3aDVOQUMxNHhFaXVZTFBSeU02?=
 =?utf-8?B?NDhHMHp5MjZSNHJXbk1aeFhmUFlaK2hXUDQwMlRiVGJaVXNGWHk4RVdEM3R1?=
 =?utf-8?B?VFRYR3RkYWVzeG9icktSeit3WW8yNUdPckNlcmpJTW1UMXI2OWd1ZXgvZkVv?=
 =?utf-8?B?MTd6RDI3R0tXbm1TRmM4T0g0eU4rWUZkWS91RVdsaUhydDlXbzJYdHFldUcr?=
 =?utf-8?B?VkZXMmlCQ2hCb2crUVBaVTlFaWpJU01LcHF0Nm1SL2pyTldZb3owbjMwMmI1?=
 =?utf-8?B?QWVCaUJUTHYrLzVPL09RREgyQWEwYTdOS25ZRE5pZVNCckF1dTQzaU1YR2Mw?=
 =?utf-8?B?NVRVOFFtYXZNLzdKTHdZTm5FZGNiMVI2WHIya3craWN5YmRiWUpOWmlON0Qz?=
 =?utf-8?B?WTYxTmJNTVF0VEpkOGkrY01tSkgyaVYwdDR5Ris4MGphR1ZkZ2RYZ3B0Z0xE?=
 =?utf-8?B?bUFINmcyTjNsa2hiU0o3UXE5c0ZnSlhBa1F1YnNsYWpZWUFzUktXQmxFN0NP?=
 =?utf-8?B?RVo1TkNwaEljdE5ES0ZwYXY2aFJHSXJnWmtQZzBmdFBCWks2d0dnS1NSbEgr?=
 =?utf-8?B?TUl3SFFxNXgxdlpkMEcxZG04U3RTc0tPRTdGSHR4UDNjUVlnZ0FQM1BTa292?=
 =?utf-8?B?VjBMZ21lN09rc1lrbDZCMCsrNEVpTWFJblFoczgwYjJQaTZ0RnpMcTJpTW5O?=
 =?utf-8?B?ek83RzhvcFpQU2hMYUUrZjhDQitNMWF4V0NLR0gzdnFGU1V5dklDK2RnRjlp?=
 =?utf-8?B?YnRWcXBkbzdxNWs2dFc2aTZCM3hJaENZb25lWENOZXdJV1pieGUxdHVLbDZq?=
 =?utf-8?B?dGRaUmlFQk50VGxLdHhlTXQ1VzlOZUNLUmw0Y0VRQzdOUXk3UUdHT25sMmtU?=
 =?utf-8?B?N2hLL2ZZeEFIOHN5Smk0cTRNRGNkMnBySHFkY3NxU2JOdk9SN2tNcWxWS0ZQ?=
 =?utf-8?B?QnowRWZsZ2hoOEVIM0IzNE1DcWlRb0d0NHRoTFB3V3djMm4yd0VmWURQWEdX?=
 =?utf-8?B?S1lJNUVVWUt0T3QwTkNDcC9nMEcycU1TTjFFN3RRcjVqN3VPYmFzYnJCSVpv?=
 =?utf-8?B?QUEvU2VIeXg3eURXbWRGK2w5TXZ0MW5Zc2lheWthYUUxNng2ZWJPQXMxQlNl?=
 =?utf-8?B?cHkxY0ZyemE2c1dJWm5HSDBXL2s0VEVwc05QenREWTRYM2licEovNGZ6QTJt?=
 =?utf-8?B?bCs1WkFXTWN5SWFoQXQ0cm52RnV2Ujg1WXd6aGg5emRUNkd2SStjVitMZERi?=
 =?utf-8?B?bmVhUEZQSFRjbEFiNFBBVTAvS1dHUTN5US91VStYRjQ0VlBvMTYxRzR1Z1JZ?=
 =?utf-8?B?Z2tXeGJJMDhXMHVvS2pUSFhIb3FEQmg1eCs5U282VGttcW9qdVJGQld6Q2lU?=
 =?utf-8?B?ZGRWL2RDdFBkaVNPY25nRGI1bC8xSGZPVEQwV01JRjBZUTJkMTY4U0VqTVFV?=
 =?utf-8?B?bm5kbnRkMjcwN1VpNHhJZXhXMTJGYVdXUEZoZDNvSFE4b3EwdjZaNHpzM2Ir?=
 =?utf-8?B?S3dkcUxPQk5zbkZzWW1MV3BoQ3crV3BHUmJvSGdLK0h5UjAveFl3VG93RFFO?=
 =?utf-8?B?VmozRXhvczJoemRXNEFNY0NUTnlxR00wTjVQRjNlNWlWZTdiQS9OckJpR1B6?=
 =?utf-8?B?UzZPQXVlT3VjMHB5dEVwWEEzTVdseENMZ1VCR0o4UExuQ0NXMlBudXhYMmF1?=
 =?utf-8?B?STlPeG1HUWhXRk5zSElVbFBxNEFnNy9OaUcwODByVmFSZkpIeUFRVGowRUlS?=
 =?utf-8?B?RHZMdU5oNGEvVzQyZnpsWUhQQ2lvb1BseU1UeEVIaWwyQlh3MG5kUUI3OU53?=
 =?utf-8?B?V1E9PQ==?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dedaaae9-02f1-4462-83b1-08dd714b160e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 18:29:06.2960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T/3CEMvDYAXbLvZLdepVZ7dgdyCr3Uq6GHqfgYI7nIaeYoPBkgCYTkxeUMf98yGQjI4BioXuqMwlNH5aviQv5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR15MB6669
X-Proofpoint-ORIG-GUID: olo_dS-GNhntWIX2oCFUguU-iyZskgDP
X-Proofpoint-GUID: VcnBFgQ9IXlAfje2atkGD6uxGkwOG__O
Content-Type: text/plain; charset="utf-8"
Content-ID: <F555B59C07F4174F973255A56441C3B9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH] ceph: fix variable dereferenced before check in
 ceph_umount_begin()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_07,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=610
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=2 engine=8.19.0-2502280000 definitions=main-2504010113

On Tue, 2025-04-01 at 12:38 +0200, Christian Brauner wrote:
> On Fri, Mar 28, 2025 at 07:30:11PM +0000, Viacheslav Dubeyko wrote:
> > On Fri, 2025-03-28 at 18:43 +0000, Matthew Wilcox wrote:
> > > On Fri, Mar 28, 2025 at 11:33:59AM -0700, Viacheslav Dubeyko wrote:
> > > > This patch moves pointer check before the first
> > > > dereference of the pointer.
> > > >=20
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > Closes: https://lore.kernel.org/r/202503280852.YDB3pxUY-lkp@intel.c=
om/  =20
> > >=20
> > > Ooh, that's not good.  Need to figure out a way to defeat the proofpo=
int
> > > garbage.
> > >=20
> >=20
> > Yeah, this is not good.
> >=20
> > > > diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> > > > index f3951253e393..6cbc33c56e0e 100644
> > > > --- a/fs/ceph/super.c
> > > > +++ b/fs/ceph/super.c
> > > > @@ -1032,9 +1032,11 @@ void ceph_umount_begin(struct super_block *s=
b)
> > > >  {
> > > >  	struct ceph_fs_client *fsc =3D ceph_sb_to_fs_client(sb);
> > > > =20
> > > > -	doutc(fsc->client, "starting forced umount\n");
> > > >  	if (!fsc)
> > > >  		return;
> > > > +
> > > > +	doutc(fsc->client, "starting forced umount\n");
> > >=20
> > > I don't think we should be checking fsc against NULL.  I don't see a =
way
> > > that sb->s_fs_info can be set to NULL, do you?
> >=20
> > I assume because forced umount could happen anytime, potentially, we co=
uld have
> > sb->s_fs_info not set. But, frankly speaking, I started to worry about =
fsc-
>=20
> No, it must be set. The VFS guarantees that the superblock is still
> alive when it calls into ceph via ->umount_begin().

So, if we have the guarantee of fsc pointer validity, then we need to change
this checking of fsc->client pointer. Or, probably, completely remove this =
check
here?

Thanks,
Slava.


