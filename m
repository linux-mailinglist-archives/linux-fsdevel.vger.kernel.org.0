Return-Path: <linux-fsdevel+bounces-39561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7505FA15961
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 23:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B0737A1B6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 22:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E4C1B394E;
	Fri, 17 Jan 2025 22:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jbXFnJjK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A8F1A840F;
	Fri, 17 Jan 2025 22:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737151689; cv=fail; b=uh7ZF/KGKS2pw/wzmh+KdX1fOMlUKkGduCapnImhhEbRpKN06cQO+jFYUw4I2N7tj57KgdqyjNfhzIIl8ud+enhgHmgonohghr+EQNFpDMsPCRINaTLTeLnpyetNx2u4yg50qkBX8KPwd/jvnlrjyl4eHCIl4mAimoS1vkiCgeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737151689; c=relaxed/simple;
	bh=knyoxtc7SyvZXxB5bTXsr9gf5MVMpcu8szY8fWhdDy8=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=FgRaulDdEfEvIklx+qcpm1GZBoxieEvWVya93hR1weHTyWepkZXe9/4GgowQlDlb3JJ50lQXA+Cb4nkqLjlopvekxztcXe3eGDj4FNikcisqIY29YHnBpHsucORGNiSO8bZO4PYaLdaVACBPkaqVP9Uc5ORF08H+l00mIx+czJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jbXFnJjK; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HIcsDB000508;
	Fri, 17 Jan 2025 22:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=knyoxtc7SyvZXxB5bTXsr9gf5MVMpcu8szY8fWhdDy8=; b=jbXFnJjK
	A0g+Fd0HDRPxlQeIBM8DaVHzMv8fmjnHc7136rIlydI7sQ0ul2gZztvE4KBkSuLI
	NIDsEXORhx0dxeInERSPRPgVh27YLyTNSZg59mJitVrP5A4m78EcF87+unLrIZEd
	nBD+YhpzThsEtD4yqp3WmgAN+IuW6zceWOgbkkKh8kyCCAQER4+kR/4OrA5u1F+E
	JtaDx2BTYDItTNqEUjXDqhYn0KSsk7VRFnr3CZO5di/PX89yPCx64OUFsZCxburu
	AYj3+eFsUrh+65vYIcfPnTp2XF4xTk9o5uNieZDPhKY8bUdqEvQ+3Z+YoeFF7Hoo
	qrNeWM+XqFh36g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447kd3kpr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 22:08:05 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50HM84pD026391;
	Fri, 17 Jan 2025 22:08:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447kd3kpr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 22:08:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EW5bVjPreaJEPf+xnAeE8DLMIIKcp+GTXZIue3E8ofmbe1AYUzSBQsYDx5BhtVHF1AJLpNxQjFB0eudGxV6PP8VQf7njnlyWOpsIpgZ83ax2KCP/8VEqPXaV5BKD5einSFGNwby4iu/+l3F/r+VrAQ2VO3ueQgTkIPVwG0nRiqnX0lkExdoaj62SxGyncQ4rPlDplRruz1cobICgRMF1pDjb68/zOQcAbo5hK61NP2bBUBRYjWhZBbbnlUpBrP+tML/Vp2QYABj0Pj5c3shj8ZjszmtzSVdqfF/HQbufQqOgkPMyWoMWPhDRm595dbeTSZI7c9K3tGaUWVRidldBgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knyoxtc7SyvZXxB5bTXsr9gf5MVMpcu8szY8fWhdDy8=;
 b=Q5bqxgaikiBes8znjOdShaHDWpsusp3JcXh4cfQmSwv9mu0B0vk5wsg1Kig7DxTRGewLenve3OEW90wwIxdh8/Y51OP7e/AvTkEcREJqreXWXoduqK8woI3EED4D4F9CxyQ6t4SIUApiMSTWu/NyY6px+KfdgSu61NwIBO9hpGUPThTcKv1zRZn+zTnbgJSoMLQ7bLjsuBs7dXw2xSJAMjlAjLYNtSqkH6sXG5W2tscretYYT1VqilPfwWBNgqGwAQQowXt3sLTZ6k7q+RpdlhMqVHqfyIlqS5XSWxe/XkbyC4Iy99d+iGT9gC5Zjm9Okce/OgNtW6FSqVgMea17uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CO1PR15MB5049.namprd15.prod.outlook.com (2603:10b6:303:e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 22:08:02 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 22:08:02 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "slava@dubeyko.com" <slava@dubeyko.com>,
        David Howells
	<dhowells@redhat.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        Alex Markuze <amarkuze@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] ceph: Fix kernel crash in generic/397
 test
Thread-Index: AQHbaSdV1V3ZbFHxXUKRkzWcEU1A2rMbhj2A
Date: Fri, 17 Jan 2025 22:08:02 +0000
Message-ID: <577c0d17cfa4e4625fcfb9cf4a484b8db11d6f61.camel@ibm.com>
References: <20250117035044.23309-1-slava@dubeyko.com>
	 <887442.1737149548@warthog.procyon.org.uk>
In-Reply-To: <887442.1737149548@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CO1PR15MB5049:EE_
x-ms-office365-filtering-correlation-id: 6e46f16c-266e-4e65-7944-08dd37436927
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZG8xU0svWDh5TEVWbjVwVnp3ODZDMG5oTEVCbmRxL0RYb1o1cFdUNHUyQkp3?=
 =?utf-8?B?QzkyVXY0VmxlY0pOU3pRRHF5TUpHZEZvdEVFMTY4ZGtqcEovWnQ0QkU2eFpT?=
 =?utf-8?B?bmRMSnJGOXZJWFAvdXh3WHh0STJ5clpZZkpjR0c2aEMyTGxBTnBtdStRN2RY?=
 =?utf-8?B?WDlwOHJwRFdDUHVBYis1SlJnMjlLdGNTMXBmM3V1OE9Oa252WENVT1pDYndh?=
 =?utf-8?B?Q1VHUGp0ZjM0cUQ2UmhjTENES3pZOC8vTUxwUDNpZG1rNDJFVzc3THV5NGdG?=
 =?utf-8?B?NFZjMEN3Q2VGMGFuZVdpMXJheTFuTGExTG5QZ1JwUDBPMVhvODRKMEY4YzZ6?=
 =?utf-8?B?K2NZWnV1a2hhWWRHdlFSdGY1eXNLSkRtb3pHRFF4VnM1S3NJZlpoSTA4RnNp?=
 =?utf-8?B?dVZjcDV0Ymc4Y1dNREFaOHhXTTRQK2QwY0FSb1FDY1FUb2ZCYnVsTHVZNlFF?=
 =?utf-8?B?YWppOHhicWlwbGsyTzVXRTBsUndXS1Q2V0hTUUloaWFIRzBpU3IzbFRZKzln?=
 =?utf-8?B?cFd2cHZpRzk4cXkzTHdrdFlna21EMSs3UmpoQU8wdE1BT3dhb3phUjFBNzJZ?=
 =?utf-8?B?Vzl1MVVtUDgzdGFOdzBPN0NZbFYwd0tZbjZVWmpWVFJhTXpVVDRwRE9jRCsv?=
 =?utf-8?B?WE1KL3FYb3JHSUovbFpwVFh3aWtMR0w1aHVkVmtubTZtTm1NUkw5aENEand2?=
 =?utf-8?B?MlRtMmU2ZVRxQXd4WVprMnVFN0xkOUdnczQ4ejBacnRHMVhZZFpTeXBPOWJN?=
 =?utf-8?B?cEp0cmk1eDlkd25BQlRuQUZVbE5CWVpiRWZaVEV1NmE2QUhtdTFDQTROSFYx?=
 =?utf-8?B?UlJ5QmNBU2ZKVFI0VGlvUE5xVXRzSWdZVE1lUnhMc1hqcWFHeXQzck1wOWhv?=
 =?utf-8?B?aC9MTzhuSkxVcHVYWXRRQndoN0tac3dyYTY1RitiRkphTCswN1NEaGVGckpM?=
 =?utf-8?B?OG1DSjF6b2ZYY0docVMrOWp4Z3ByUHJsOTIzbGdNTmR0QkNLeERUN3hQbk5Q?=
 =?utf-8?B?d3pmclhHOVlZZnhPTjlENHVYdE1CT3FScHEvYjNNUmZVQVpsYnZPQm51YU1R?=
 =?utf-8?B?MlRqaW5yc2daakhKYWpnOFJqeUZOUFY5bERvR3ZFa3hVcUdNMndnRE41cmhF?=
 =?utf-8?B?YUtoSG9ZdSs3bUc4NUZzN1lNU0JWdFV0cHFtMENJTDJDOGxkemRZUzhBamJJ?=
 =?utf-8?B?VzRlSi85V1kyLzBwZGMvSmowOEx3UU9sc1BYYVVnbTgzY3lDOVFJUHZPT0dy?=
 =?utf-8?B?bkRIeTdaZ1VSSDFvZUlSaCtOZ2hOcXRsbGJJZEJlWktESFdjclBqRENvRTJX?=
 =?utf-8?B?c1dqT0FBUVlISzdYdTJQUHcxSnVzTDJGY0x2KytrZEhvL3RHNXYwMTNBc2ZK?=
 =?utf-8?B?VUpBTzdvQWpiclBjRlNBRjd6NC9mc2dhcjYxeUJUbDF0TmRDd2RDZWk0T3Jm?=
 =?utf-8?B?Qi9IdmFVRDh0RU5xbW0xODU1bkVEQW5wamZIaFQxTGdyeC8ybHM4cmdjUDVv?=
 =?utf-8?B?d21oSWRYc2VYbzFYNHp0NDRvYk1YT1NMZklxZml3LzlONTFmVjVxTUYveHZD?=
 =?utf-8?B?d3pIWnlINTdQY3FsSDQ4SGxhNGE3K2ozdWxRYWVnNTNiZXZqUFRmTW0rbHda?=
 =?utf-8?B?NWhYanZ3QlJUTVNjck9oLzVDN0R3dmxZY3BJY2RnTWhERmIzc3RDazhRTnYy?=
 =?utf-8?B?bDIwZ2xQaDFsRzlKYVMwYmozMUFrcmNqdGFIMUZOT21CYXNIZzUvanR0enJ4?=
 =?utf-8?B?NGVzRFR5cXl1VmVYaFhqTFdCSHk3cDc0cVJVNUs4UGszV2k5Y0hXdXlHNW5Q?=
 =?utf-8?B?ZnV4bjUwd2o0R1MvU3ZUeHRlTjZsNTVHMGtsMzNSVk5ESlBEa1owVmcyMzYy?=
 =?utf-8?B?enhxUXVvb0tybE53bkZtZ1BwWUsrUUd5V2tyZGZuQ3NrRjM5RGhlNEUxbjgz?=
 =?utf-8?Q?1PqhmgQK0LqO8REmzOCVhn4WDLoUl8s6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bitVZ2hQTUZLemIwbGlUejhFb2RNclpsYjNqODliNXVkZWVWT2tOMHQ4STlr?=
 =?utf-8?B?ZE42NlY4YVJhRllzMkQrV2lsbG9UOUdhUG44ek9PZnVlNVhLMGZyOFowN1dl?=
 =?utf-8?B?SDB4WVpaRjdiSm1Fd3BIS1krWnR4YjJQS05EVzk4K1NqeDV0Wk9mUVFNWEhh?=
 =?utf-8?B?TXNITjk0WlVZNEZHN0YyM1ZjbHJkS1l2eHg5QVZYY2dsWFEzM3ZycEJTRzhJ?=
 =?utf-8?B?dmdCakZmdDY4aEFRbHVwWEJsZ0RNYzZZQnNKeG03cm5TMXVHVVQ4Qm9QOWZT?=
 =?utf-8?B?TnpDRk9DcEgwMm1Rd2NhaTRpNXN0WjRIOHgrb0ZSS2ZCem4xRmNTVUVLRFc1?=
 =?utf-8?B?V0ZjenJGR2hvYWRocTdMVlNWTXdQRUZHZWdDTnF2OE44b0ExVEQrcWFoaEgw?=
 =?utf-8?B?NHRZeGVwQ3ZYOGJTZ0FIZ2VEUkZ1UGRoS2RkN1VpQ1I1emNxK2VsVkxYaGdm?=
 =?utf-8?B?VTY2NXdTa0ZGYmcwKzM5WDRiVTRlVGEzdlBtSVM2a3ppVFVsVEo0a0RpY0dt?=
 =?utf-8?B?Q3BRUXBVVkdJSmpFTWthZE5EM0hIbmxTbDZWazJCUmRKMVBJaDdrcTBTb09p?=
 =?utf-8?B?TjhKZjFvT1dXUEdoeXFoRGd2QldXTWRlWDErRGRudU11WUQ4R2xBcUd4UjJY?=
 =?utf-8?B?ZGs5OVZtb2Y3eU55eWFLSTJOMUY1bDlpZTk1bXRTd3RFWENTQXBhaDVuWjg1?=
 =?utf-8?B?eFBDNWYzN21BNTY1NG5uNG9ySVE0UllyMW12N2hRNVlXYmpqcGtKMEltaE13?=
 =?utf-8?B?S01NN2tuWnVqOExaNkpLZmk4eGUrVFBFc0pjaVRZeTFNeUFYV1ZlZHlXL05Q?=
 =?utf-8?B?ZXQvZUYreHNROVJHcE44L1EyT2VmcldnSnE5cDl5blptRjJ0MjdRbEFwNWNF?=
 =?utf-8?B?ejQvMDRpNUxLSGNvZkIyQnp3K0xPNTVteTZabG5tN0ZLbFRXYlo3OVlySDdH?=
 =?utf-8?B?V2c0aHpZRy94eWVGc2RqSzFwR3ZOZ0R4VnFUdVBJaVhCTDFuL3hiUDVBbXNS?=
 =?utf-8?B?RG93cmdPU0NITjN1TUJEUUErdkE3dG1zcUhKOHA0L21sZDRnNjZzQWo5bm5i?=
 =?utf-8?B?dHMwRXdRd1h0bGtycUlhM3BzRlRxaWZiRG0rTnpjZnJEcVZnNmFReVdvUUly?=
 =?utf-8?B?akdaZzdrTDdXekQ3STlQcHp5QTRGUjdFZmQweUJ5ak5MWEZpYlJzUWVLalhN?=
 =?utf-8?B?dE10RVpPSHZONHhVSXUzY01DZ2JtVjlBbHg2Rm1ubzJwK090OFZRUHpmWStj?=
 =?utf-8?B?WGEvRStNWHpMaDJBTXJlUFFKRENZNHRXTUVlVFJMdXJZUE5iMkxkYzZZOXlp?=
 =?utf-8?B?VWRmeDhxcGZzd0lFQXU1TVF0TUNJb294RGxTOGJZNHRxVUxkVEF3UXBTcHpU?=
 =?utf-8?B?am9OTGFjTGxrREQrci94WnA1R1Nzd1RKbzRDMkZaaXk1a09GSkpaTmJwL1Zs?=
 =?utf-8?B?S2tZTFBwaWo5THJ1R0NWSk96UVQ2Z3JxV2NwRlgwcnhjYWZBeFg4Q0dPbVBI?=
 =?utf-8?B?enU5eFpUNGVOeFFXT3V1Y2s3Wms3Z2pEYUdBb3VyL21rUHJaS05RMG52OVdK?=
 =?utf-8?B?aHM0SEV5V2doSEVnaXRGNk5yMER3ZkFqOWYvaXlvN3BVVUhFblJmRzNEY0hB?=
 =?utf-8?B?ZHg1YlZyQ0MwczF5c1laa2ZDbTlPWGZHUFZJNFN6QVM4MGowQXlkcnpqTWRZ?=
 =?utf-8?B?Y1hFUDdLblBBTGhQVno5UmROblVBQjlqbzRZSm1yc0VObW5NWmY4LzVCYlpk?=
 =?utf-8?B?UHhJdEVCWTNqVlcwOE05Y1IvOVV1ZmdQaHYwUFFvSmliQmY5VG9HZVR6bDNm?=
 =?utf-8?B?MERNem5NZGZaUFNVbGE2NSsvWlhNUG51NHMzdzFmakRrNlFhUXNERzgvbXdM?=
 =?utf-8?B?WVRZbWFsdkNBRmR4bzEwajNPNCtQZllpdXVpb012Zm1DR0QzT1FROHZmT3I5?=
 =?utf-8?B?ZkVKUnpYMzl5a3EwNUZmcWc3eDdrcjN6cU9pSUxLa3BreVFzU2dVVGNHbTZ3?=
 =?utf-8?B?WTMyUFN6NUs3dGVqRU5tSEoweXRrQmRvTFh0STd3YWxsYWovbnlxbWpWOUZr?=
 =?utf-8?B?eW55a2Z6SVJqNjdNV2VIbms3YmpHb2R1UjI5S2RUYWtVNWRBS1pOU2lHcGh3?=
 =?utf-8?B?UGpwY3VRY0RhZjJ1V01teFZsZUlOQjVsY2JWUlg0M01SdlVFbXkzeDcxN1BX?=
 =?utf-8?Q?zZsUsuMN7LfDnFWisznD4eI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F21E72A58D5B064C82A5AD377ABB36BF@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e46f16c-266e-4e65-7944-08dd37436927
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 22:08:02.2626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sRlyez7dI1pz8i809oAxsAGbi4XugTHb6fL1r2kSbDOmvIDPoKctJXUg7tPdQ1IIphy1gxia4UEXDf+ZF0EXpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB5049
X-Proofpoint-ORIG-GUID: UngebHp3aIiGzxuywdwZWTOI5Tn4RPud
X-Proofpoint-GUID: y7llUqGjMntQv3kMrJZXL6T5-9OKFVmN
Subject: RE: [PATCH v2] ceph: Fix kernel crash in generic/397 test
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_07,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=879
 priorityscore=1501 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501170169

T24gRnJpLCAyMDI1LTAxLTE3IGF0IDIxOjMyICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBWaWFjaGVzbGF2IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29tPiB3cm90ZToNCj4gDQo+ID4g
VGhlIGdlbmVyaWMvMzk3IHRlc3QgZ2VuZXJhdGUga2VybmVsIGNyYXNoIGZvciB0aGUgY2FzZSBv
Zg0KPiA+IGVuY3J5cHRlZCBpbm9kZSB3aXRoIHVuYWxpZ25lZCBmaWxlIHNpemUgKGZvciBleGFt
cGxlLCAzM0sNCj4gPiBvciAxSyk6DQo+IA0KPiBCeSAidW5hbGlnbmVkIiwgeW91IG1lYW4gd2l0
aCByZXNwZWN0IHRvIHRoZSBjb250ZW50IGNyeXB0byB1bml0IHNpemU/DQo+IA0KDQpCeSAidW5h
bGlnbmVkIiBJIG1lYW4gcmVhbCBmaWxlIHNpemUsIGZvciBleGFtcGxlLCAzM0sgb3IgMUsuDQpB
bmQgImFsaWduZWQiIHNpemUgaW1wbGllcyB0aGUgY29ycmVjdGlvbiBieQ0KY2VwaF9mc2NyeXB0
X2FkanVzdF9vZmZfYW5kX2xlbigpLCBmb3IgZXhhbXBsZSwgMzZLIGFuZCA0Sy4NCg0KVGhhbmtz
LA0KU2xhdmEuDQoNCg==

