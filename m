Return-Path: <linux-fsdevel+bounces-47943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AF6AA7A0F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 21:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CAF3B7BFC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 19:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3251F098A;
	Fri,  2 May 2025 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A4a3Ssx4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA051EFFB9
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746213028; cv=fail; b=g20QZM75jfNXbeXE4/g+4/6EWKUfAroIyxTM+qJ0Kdz5uWxk07W9ON4D8WRbto6BTRLdHoAKsA4Zn5YkdtdukS3xPwIT8xW4R67OAIqDvuAQmkegNxMh+oZ/d+qY1sI9BreeHtwHkPtF9eLE2R2a28cZMXRfNM59ss9z7WD8R2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746213028; c=relaxed/simple;
	bh=rKCPKYIdb+WB704W1zmzbDtqOjxL8Lc74QpPsVy09bg=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=rDZYOIXH9rgT5AVp98SWDsEEEifRUgrTppuUMwCWOwPsJW4QXaZPKXcCixQaDn+iu/Sbu0MpbILmkvdBGyXGKitqxREUNxo0hD2zounf31HcZEOc9cfYVkbPktBzvHnXaQT7x/TUdp9sLd3Be02G6JhjKWICtvBbFKvYeiH0PQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A4a3Ssx4; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 542BJkE6005317;
	Fri, 2 May 2025 19:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=rKCPKYIdb+WB704W1zmzbDtqOjxL8Lc74QpPsVy09bg=; b=A4a3Ssx4
	LyghJD7OYZXXXbIgbI5saSgqD8IbG0ZFfukY9/H5AaUK94UxCxG9h28gI0XZHRsD
	7juP/u28bZ19oaHb1gdEJFM8ZUOkUwoSe3xHVtOv+zvgrdEmipvgao8xF2XLPvhz
	JkKp9suUlDPF8GgK9tgBGqA0NeGokUGsta6lUBzCUYJSpuNsKB/Wt1NsE5cmDV4N
	7Jgn8iTJFFJJdUf9WjEClf6fRFpyIKzmHNzGK2cpi/xNMthcnwrwqROcIKy40ram
	/BmYQAL7gyKaqetNWmOlwmzm2HvNaKVydN+Gh0+rLvk1CnFR+4RxGO+o+ylLNQVf
	HLr6byfV7IcBHQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46cghkmu2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 19:10:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjSAa6/E2l79pHHDHRZRJC6wjoan6LSj18YO9RIGpKQzJCcBeiHVyqCR3bTw1E959Q7cF8KJKaD3Qch3U/CctupIX3LS/pTtJYfcQxq5CffwcQVQihzlVp9QTXgxjG/QpB5ietja7yKWpomAgLzRMGVXJ25Xe+dxWXVk+XA6UI7ahwNW62fb4/d1hNCBz8c9DfoHdH6IsZoL420knCnhwO6dZUKM97opmLKSll08ORRvGmrGa64VRT1Udbn2gUi5SnbHVrP1OLThRS98nzzwirNl2EidXQ4bvbbYnLB2GjdXC4kOFLf4V9rXp0dLfA6yC7PQGCT36noPGUf0N7R2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKCPKYIdb+WB704W1zmzbDtqOjxL8Lc74QpPsVy09bg=;
 b=MdVQop+Oj2zS3eCoQCZS9GfKs/a58yJNp4FLKTwKIeeMKWemearpbOE2TLNqGnexaWUmaCTiKoaaHnZSV/Ej8lxa0m9hWTII0I4Yt7jsNSLziH6lNpviMn1Zsw6F6Wlm/j8iggyiWsEvKmtn4GLVcsnpRpIWgv/za1LTNdM4P4mLWH2cUkA5tXeiD8sACz6yWogHcRuB/UpogxI23K4PLpClV6DBVs53OOmAbzM/ZB/knGEySTAMYH9l2t/Gr8Wx0MMJYevxfOc7HIi3/ABExw1PJfEQphY3p7axlaClruY7I8XL5kkonIYdiWyMpyleQcthzdwqicUcJRfy7e3Hsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ2PR15MB5742.namprd15.prod.outlook.com (2603:10b6:a03:4ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 19:10:17 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 19:10:15 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "Johannes.Thumshirn@wdc.com" <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic:
 =?utf-8?B?W0VYVEVSTkFMXSDlm57lpI06IFtQQVRDSCB2Ml0gaGZzOiBmaXggbm90IGVy?=
 =?utf-8?Q?asing_deleted_b-tree_node_issue?=
Thread-Index: AQHbu1xbOcNxf5vddEqadJJSu6baLrO/tPOA
Date: Fri, 2 May 2025 19:10:15 +0000
Message-ID: <c55262e192b2a651bd1b462b5175bcf1c236bb92.camel@ibm.com>
References: <20250430001211.1912533-1-slava@dubeyko.com>
	 <SEZPR06MB52699CD3E9F2FBBF94E3435DE88D2@SEZPR06MB5269.apcprd06.prod.outlook.com>
In-Reply-To:
 <SEZPR06MB52699CD3E9F2FBBF94E3435DE88D2@SEZPR06MB5269.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ2PR15MB5742:EE_
x-ms-office365-filtering-correlation-id: c169d469-a746-46f2-5193-08dd89acf8cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SENTNVJxdytmVGF3Qm5TcDVyTStUekFFdXNiRlVrdXh1blhWVVZRMHdCcnBu?=
 =?utf-8?B?bmpJZ0Ixc2xnUjFsWGZLSm10Mno3SE5oL3BIaTdGZW1NUlpPR0pselR4bzJF?=
 =?utf-8?B?Q3ZsS3U1cW0zVmNQMUVaMnV0cG5hZUhFenY4MlBVam0wZXB6M0RsRnpkRGFj?=
 =?utf-8?B?c00zN01JcE9yUUVodFNwbWlIbEZiY1VPL25qay9PTXZBRFVLRlFkUjRmeDQ4?=
 =?utf-8?B?S1ZSVlVUYllJeVRac1pBdEdWcXZET2NLQUZYRDRqbjRvUlNHWjNKaW94VG1i?=
 =?utf-8?B?eHNyZ1VsMFRwemg3MlpadUJPOWtHVDFZRkZHajFSMlpoRnFYaGZiZzJGZW5D?=
 =?utf-8?B?U0dQd0ViTzlKdFJTQUorOFcvdGZsSUlZRTB3eDdGU2kxNGl6K0QvNnUxblRz?=
 =?utf-8?B?YXhhS1VPUkF6K2RFZjdSejZyOXBVN3NKRUo0TDlzeEhNSnRscHZJTFVQUW1x?=
 =?utf-8?B?Vjc4VExiclg3R1NTaS9QRmN3TC9pN1VWbVZjWWl6bHRBWHB4NGVnZElHSWNT?=
 =?utf-8?B?S29QTGVpcHAwTjEydWpGNkdXTGQ5RlowTFhnTHpMZHBLeS9Kc1JPR0ZOWlFu?=
 =?utf-8?B?R0tveUdpVmFVbDJNdWFTSCswQ0Q2Vm1RM2NydHI1elJRZkg2QzYzV1Z0cXln?=
 =?utf-8?B?eGVHc1R5NENweFJlendtMmFjWlNrWmxlbHZ2S3NYeTB6YitBZHBRejNRQmNh?=
 =?utf-8?B?b1FCR1FZeWtsZVZ3U1VUYzJkNnNsY3IyR3BSYXNWQ0xLelpKUVlwQm13bHVx?=
 =?utf-8?B?WUtOajRINXJmbUdVVVVtVFFIMnR5TVZtdWxYTXVOZlBXd0g1Q2pPRUR5U3ZV?=
 =?utf-8?B?d3pjS3lnY3YwVURKSlJUMytWQUNCdjczRGxhMi83b3A1YjZqcnZEK3pzdmx5?=
 =?utf-8?B?c2tVOUV1R0ZBbG1jV0phaGJ0Z2piZVJYRnBYaDdkRXEydVY4VWE3K2pOL095?=
 =?utf-8?B?d3JGeUdGb3F5ZDhDekRaaGVzMGVYd2cyb0liMENCZU1CVjVpS2NtVzc0eGg1?=
 =?utf-8?B?UU5YMEZQcTA0dmJuZHIvdWI3bUc4N3lyY05TY2xjVlc2SFA0MDRnMyt1YVlK?=
 =?utf-8?B?L3RSdzl6QWVpT3MxYzA3cGFBbWlKekN5SkQ0cHZzUi9WS0VLUzU5aW5mYUpl?=
 =?utf-8?B?NUxXZTRSaHZHWTE4a2R5dk5TcTh4dDJJRWU5KzduNGdYU3k4SU1BNXM4U0Ny?=
 =?utf-8?B?YXNZOEM4elhwNHd2WGFnUjcyd3BXTEVZSnk4V2kzUW5BUkxITThuekthZk9Q?=
 =?utf-8?B?Q1JQMFFRZURtZWJhU3BFV2txVC9raUlZaGpXRzlHeG9OS0NCcEZscGRiMWlZ?=
 =?utf-8?B?ZGY5cnAySCt5VVF4b1BqTmttZU5DWGY5b2N3c3Z3UUdpdjFKRm1yOG5BMkhk?=
 =?utf-8?B?S3dkbFpkVGdUT3JiNkJLMmptMkE3ZVhPTE5KQUkrT1BmT0ptMkhtSVczZWZq?=
 =?utf-8?B?OW9aaUlFeEZ4dWVydmgwNVgxMStGSy9IZ2Z4K0QzR3puMXZNSVZDNWV3c0dU?=
 =?utf-8?B?TTBqYlNYYXpLd2lUNVFUWG9QRW5DOE8wTWlRQVdXRksxS3lSKzFHSTQ4VWl6?=
 =?utf-8?B?QUlZSDlSeERoa2d6cGJDcHdCdmdyMmUwQmlienVwL3hmRklLbzBja25NQUcr?=
 =?utf-8?B?Wk1HTlZsSUZQaWVseWtkSTFFZlpudmZONFZTQXdlTytQMzc0ckUrdW94aHFG?=
 =?utf-8?B?aVNHclB5SG5PUHBJNGdMd0p3TGdPcUJJUCs2WFNjbnk5dlhrRTV0UUkycmdP?=
 =?utf-8?B?L2dxL3U5alhmUzlWSGg3S2xMRGNhdXZkcGx0Y2MwN01ua0owb3ZkTUczS0RG?=
 =?utf-8?B?UHM4UVNoaG5xSGxzMzJFRHo4dUp0MTI5Snhyang2MVRHbGVmKzRyeHRWRm9D?=
 =?utf-8?B?M28yYWJ3UXdicU9GRnIzTDZvWW12NHN1Vk9vK2dsNHVXM1UwY3pLOEM2OEdk?=
 =?utf-8?B?ZTlIRml1ZDcvdk55VUtWeWF3a1pZMGZTWjVuYzNhK3dMSmx5YXhHbklMeXJy?=
 =?utf-8?Q?Bfrq2V0mXIdI0LOf7WruugFT6KydLM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWFsSk1ocVU2Z0g0UWp0QUgvQmZubFpKSGVMT3JvL0NIMTRiY3VhRjlYK1Ax?=
 =?utf-8?B?dTZHamhTVVVOOUVGYkJwMTNpb1JtdWRJNkErNGdQTjhyN0ZTb2htdjBONFhj?=
 =?utf-8?B?MTJvbnZXako2bWtIMzhqWXVqTUhwMGw3UlpNL0VHbi9Nd2tiNTA4dXNIckY1?=
 =?utf-8?B?RENzL2tBakpLT0E4NDBvNk96akR1d0s0MVA1OGM5Y3R5dlpmWXdnak9ZbDc1?=
 =?utf-8?B?WUxpY3RlRXQydFBIR0Y1cU1Xc0NRU0pyT1ZockF4K1JzN1NOeGt0QU1ZOWhN?=
 =?utf-8?B?Z3lLeURJZTBLM2VIbGFwT1Ewd0ltSk5VSlYyNFhCeTV3MStxUk9IWVNYME84?=
 =?utf-8?B?bUtLRzJ3WVpvWFBUWUltQU16dnhpV01BV0pMWEd6ZFI5Z2NHZTlXVTlBZXRO?=
 =?utf-8?B?WjFWaWpQUUlTZ1RITTFqcVFsL0VFUHloclpNNEJtR1pTQzRaU0pHZXZXNjkx?=
 =?utf-8?B?WVJWaVlYVnpCbHY2NXBlTzZVYURkeGw4aURuc1lOYTB6SXR1QUlnNk9WMXgw?=
 =?utf-8?B?b2gxZk4yVVVLOVhNZ1ova0dsYTJGanlETlpOV0ZCT3V0NitVUnZneWxxZ3lv?=
 =?utf-8?B?S0Q4bWlQOW5lRC9kdlhURGxkekJjWHVKU3MvSVhHb3VkSjhSK0RMZzlSbWY4?=
 =?utf-8?B?UzBZdTNWWStXUlA2MWRZeHlESHgwTDZlOXREYzlMNFhGVGNQWXk1cjNXcms3?=
 =?utf-8?B?N2lBVHZjLzZCRGt4OG56bjFMR3JPWXAzODdBME5vUjBVeDRJOXBkRVpuTTFt?=
 =?utf-8?B?bUsyRWhkMnA0NHJiYTVFTzJldGJLY0s3anJ2dzhOSStPczhNS1d1NVZtSlVH?=
 =?utf-8?B?TmZhNEI4T1A2TU1YcWFacmwzZTg5MTg2NmFMU2RyNUZGRlFDOGQ1SmQ0blpY?=
 =?utf-8?B?ODlvdFhxaFZxMWlZMWI4T2p0cVFKVUJyNFpqMml3clJaQnlsVTZsbnJ6cElz?=
 =?utf-8?B?dzBPR2ZLekt2SFFyNUhDSGIwUXE5V2ZLdnRvM2Q0OE5EMTlnVUsyak00cEpo?=
 =?utf-8?B?WGZIMlY5NHFzUnVSRloyUHFJejhmMFdOaE9zY09VK2Vnckswalc3bDVVTGRF?=
 =?utf-8?B?RHpqU01sV21TeHZhQjkreGRReHJxVXl3NjJXRGVvREhGL29pN0E3dzVsUnFh?=
 =?utf-8?B?Y3VrOStCYnhlbTlueEFzZ2Z0VHcrWk05dTMrdVN0SlBwNXVWQ2dhb1c5ZjlI?=
 =?utf-8?B?ZGhJTjgzOTMrUUppOVBGWE91UzhNVjd6Y2hGbHhPdFVWZFh6V3pBb0NGdGdt?=
 =?utf-8?B?UFpHT2svOTArYUxlb29zOUZYVnRoWDlYOXB0ZDYxM05rTklyaXVORnp1cld6?=
 =?utf-8?B?SjVWeDgwS1U5QTlHSlJDUHJFc2VYakp4bG0wcjZoL2lDR2tTdXREV3BVVWty?=
 =?utf-8?B?N0dVK001d3FVaEc5d0JqTXBOcjkyeEphRFRsNmNraDVweWY5cGFCTDNFYnF4?=
 =?utf-8?B?SGhMZEZPV1BZd3UwMTl3bktudzR6Q2Y1cUhVN2VuVitCb000QWFvWmN5MXNm?=
 =?utf-8?B?U1ZPaE5mT1J2bWxpeWhGMTIzNG9SOEhCK0hIN283eC9namIrdmJEU0pMdEtE?=
 =?utf-8?B?UW9lS0E4R3NCR3AzVFR6c3pUbS9CWVQ1d1JFblRKc3BQOU5RRmVnRTlURnVt?=
 =?utf-8?B?YTluS2dtSkxpY08yL3RUKzdlcXo0SWg1UGxxN3U5cFBwWldGcWhEQVJIRE5O?=
 =?utf-8?B?MjVPUmVJWlAvQ2VkR2dkdU51WkpaVm1laFp6OHRlYmwvTzdVRER4STU5MzVu?=
 =?utf-8?B?YW1mN2YxL0JWbjkwOEc3eWJ0citmWThkRWdoMUkyeENFWCtxM0dxenh3M21z?=
 =?utf-8?B?aXZ0cFV1dVMwM2QyOUlld2JaMVhmdCswSlhSRncwRG9SVFkydHVicWNoaExa?=
 =?utf-8?B?WWR4WUZ5aHdxODR3M3pQUXdGUGpvbEI0cmI4WU9Wc3FmU0dNM1ljUzFhbTFS?=
 =?utf-8?B?ZC9RWThuWlV5K3VWUE1LdGlWdmpwNjQ0MmwvWFEyeXNTM1hHczV4UEQ1b3RM?=
 =?utf-8?B?MVVOaGs2dTA3ZXp3N0lHQmVBd2hHK3Z1Vk1nbElRNTltRFY4WjZrUWFWbXhS?=
 =?utf-8?B?WWNMdHVPanRveUtBTUlKN3dvTmw0UXEwaGQzSTk3Z1B4MTZMVnh2TlRwSnVC?=
 =?utf-8?B?MDFRUkhyWlhacUlkeW9vU0U0a2xtdXUvWTdJbHNZaklKQUg2YllzbGxLNWRs?=
 =?utf-8?Q?5VJg42u9VhweJv9aZPhChbI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C973061D72C3246A9CD6B2B5D947266@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c169d469-a746-46f2-5193-08dd89acf8cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 19:10:15.8040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kaC8oe1xebU3ow8PxhWhN6sUYb/PtBGPlsK+qYNaAV3Q7HeG63Cz1aBQdHPJTXNao62BrpDyrgHNg18tyrnIPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB5742
X-Proofpoint-GUID: jmUcjBPSiAALxoqJeQU2Q4PsFAMeIc5Y
X-Authority-Analysis: v=2.4 cv=VY/3PEp9 c=1 sm=1 tr=0 ts=6815189d cx=c_pps a=zz2QubYGG/9FVtTd3zWqHQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=5KLPUuaC_9wA:10 a=hfOgsk63aoOufLPaXhIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jmUcjBPSiAALxoqJeQU2Q4PsFAMeIc5Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDE1NCBTYWx0ZWRfX+6lYN9wpO/1M pVRBSz17erCKUcK4xiLctREwTiXnU+gqOifbu/jzmeiIeK1Mn/GmrollGNnvrm2WUHc+CyXejVE pQ4rWsHSoCWARRzVAIan4PRewqJdbzO60WstmJHhJwovttwG3kuT8XUxMWco4v5A6dASvaXKxPS
 dzvUHSbsSKOOro/v3tzxFHqRlTxH5XPHYS3SmWDHxoHWHMa20acwUqXtBYbZSFcogvpUjGcBSPc wU553JaNibUT1DdX/HPtY1BOuMVwYYkalCJHy5fez0IMVAHOd1qOENyvg6gwltvJDVS2t3HRQjk /PhZsQuguOl1UDTWXKxBUTPEh+1qHxylAoJa+9kBHATaOmXBCrpcbbPKj073yHU4NeWPuK4DZD8
 DjzxtGI5/b26YimQRphyn7sHyhVOwI1UZn2Tl3+76DdQa6YF3gveCwUWBrxo+qK1KFTEnHCY
Subject: =?UTF-8?Q?Re:__=E5=9B=9E=E5=A4=8D:_[PATCH_v2]_hfs:_fix_not_erasing_delete?=
 =?UTF-8?Q?d_b-tree_node_issue?=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-02_04,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020154

SGkgWWFuZ3RhbywNCg0KT24gRnJpLCAyMDI1LTA1LTAyIGF0IDEyOjE4ICswMDAwLCDmnY7miazp
n6wgd3JvdGU6DQo+IEhpIFNsYXZhLA0KPiANCj4gSW4gaGZzcGx1cywgdGhlcmUgYXJlOg0KPiAN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGhmc19ibm9kZV9uZWVkX3plcm9vdXQodHJl
ZSkpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaGZzX2Jub2RlX2NsZWFyKG5v
ZGUsIDAsIHRyZWUtPm5vZGVfc2l6ZSk7DQo+IA0KPiBib29sIGhmc19ibm9kZV9uZWVkX3plcm9v
dXQoc3RydWN0IGhmc19idHJlZSAqdHJlZSkNCj4gew0KPiAgICAgICAgIHN0cnVjdCBzdXBlcl9i
bG9jayAqc2IgPSB0cmVlLT5pbm9kZS0+aV9zYjsNCj4gICAgICAgICBzdHJ1Y3QgaGZzcGx1c19z
Yl9pbmZvICpzYmkgPSBIRlNQTFVTX1NCKHNiKTsNCj4gICAgICAgICBjb25zdCB1MzIgdm9sdW1l
X2F0dHIgPSBiZTMyX3RvX2NwdShzYmktPnNfdmhkci0+YXR0cmlidXRlcyk7DQo+IA0KPiAgICAg
ICAgIHJldHVybiB0cmVlLT5jbmlkID09IEhGU1BMVVNfQ0FUX0NOSUQgJiYNCj4gICAgICAgICAg
ICAgICAgIHZvbHVtZV9hdHRyICYgSEZTUExVU19WT0xfVU5VU0VEX05PREVfRklYOw0KPiB9ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIA0KPiANCj4gU28gZG8gd2UgbmVlZCB0byBjaGFuZ2Ug
aXQgdG8NCj4gIA0KPiAJaWYgKHRyZWUtPmNuaWQgPT0gSEZTX0NBVF9DTklEKQ0KPiAJCWhmc19i
bm9kZV9jbGVhcihub2RlLCAwLCB0cmVlLT5ub2RlX3NpemUpOw0KPiANCj4gb3Igc29tZXRoaW5n
IGVsc2U/DQo+IA0KDQpBcyBmYXIgYXMgSSBjYW4gc2VlLCBpdCdzIG5vdCB3ZWxsIGRvY3VtZW50
ZWQgZmVhdHVyZS4gU28sIGZyb20gb25lIHBvaW50IG9mDQp2aWV3LCBpdCdzIG1ha2Ugc2Vuc2Ug
dG8gY2hlY2sgd2hhdCBmc2NrLmhmcyBleHBlY3RzIHRvIHNlZS4gQWRyaWFuLCBjb3VsZCB3ZQ0K
Y2hlY2sgdGhlIGZzY2suaGZzIGNvZGU/IE1heWJlLCB3ZSBjYW4gZmluZCB0aGUgYW5zd2VyIHRo
ZXJlLiBGcm9tIGFub3RoZXIgcG9pbnQNCm9mIHZpZXcsIHdlIGhhdmUgdHdvIGtleSBiLXRyZWVz
IGluIEhGUyAoQ2F0YWxvZyBmaWxlIGFuZCBFeHRlbnRzIE92ZXJmbG93DQpmaWxlKS4gQW5kLCBJ
IGJlbGlldmUgdGhhdCBpdCdzIGdvb2QgdG8gemVyb291dCB0aGUgZGVsZXRlZCBub2RlcyBhcyBm
b3IgQ2F0YWxvZw0KRmlsZSBhcyBmb3IgRXh0ZW50cyBPdmVyZmxvdyBmaWxlLiBCZWNhdXNlLCBp
dCBjb3VsZCBndWFyYW50ZWUgdGhhdCAiZ2FyYmFnZSINCmZyb20gcHJldmlvdXMvZGVsZXRlZCBi
LXRyZWUgbm9kZSBzdGF0ZSB3aWxsIG5vdCBlZmZlY3QgdGhlIG9wZXJhdGlvbiB3aXRoDQpjdXJy
ZW50IHN0YXRlIG9mIGItdHJlZSBub2RlLg0KDQpUaGFua3MsDQpTbGF2YS4NCg0KDQo=

