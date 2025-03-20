Return-Path: <linux-fsdevel+bounces-44642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C63AEA6AF3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 21:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA29B465845
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 20:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C5D229B2C;
	Thu, 20 Mar 2025 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QKNZnxrA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411F11E25F2;
	Thu, 20 Mar 2025 20:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742502896; cv=fail; b=VCicbvAe9UlGTzFhX2YVQkLmrZtUDM+XAkqwTV47c42ZpEBxFRRgjC48H44+0vSr4Y1zL0ywqQaKI3xVF9Bf6XpHTs1Xrkc3VmfHPjY3QmVLI+ScXJKnddFiBCHajj3vjjc5uCgbp6tdWNcuaKEtT5dbtv9icKQ0uCi4QFmxrx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742502896; c=relaxed/simple;
	bh=HCkujb1qThv0TjXXM2qMFKGLhyATY5w3GK0/zWeF80g=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=sHZQhWM9Dyg5nSI/Goq9Zka7YaGaKyDpkNsFRH618D3f+MtW6xSEyJbIOGChgyhvTR5MPt1dgsH1Et2Sg39dXRpLtcj21aRkwYq4Wmmdv1sRe6eyd5a1+r3z2LRpnYAYNwViAqOLt2dGkExmfRaqqDLyF0TtJGQ2l+xZM5tUxeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QKNZnxrA; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KFM6nI031471;
	Thu, 20 Mar 2025 20:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=HCkujb1qThv0TjXXM2qMFKGLhyATY5w3GK0/zWeF80g=; b=QKNZnxrA
	RqxDh53TNHkedzLNOKzu5ornHFVRnkr/jhjQ4m4vWcVggNGGlUH20nBat9AJaTcZ
	o+uE+EwPNpBuhPrtJJyZHj10947HT9jTFY0k9itvkpBO1QRlidbG+AYsxmJGOixW
	x/rrzFCBPTBRO4uqXVhm5IU8yJ18dG5ytqA3DdMHRrs9DqqDQKvNaa7Qh1vpgF03
	5aIOEbGavdRhpxwGp6JvigEDREaZ3s8rbm65bxsY3xmg7sHiyL+ComSXi98xzr/b
	Us5Zvw7cnF5Fsv3Z7Xq18QcS3OPs5iAOeSDICZpVbe/KmV4C7deZ4pKQ7Nl0a0ZS
	+ZI57Gr1RWloqg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45g5506hn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 20:34:43 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52KKPWZc021984;
	Thu, 20 Mar 2025 20:34:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45g5506hn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 20:34:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w116+2MP7WdE9KcENWwit43eBVwKgygFkB9O5LeZN9bP7+FXCfXvz5ecjax5d/OpnPPFzDelc7/NRf6PuRPtEyNZCLDmKlAdIDDin/j6IJjSDsFYCsSd16dhN09/jEQ0xsX3lRvvIkZOFKPUGeYanfPCTPdG+I+aZP2m0SQtZ3IgVI1r/54sbocfdLZZPYIRl5j2TmiHnNr63cQwUNXtsgrjWoKvntgJQqcHwN54UG939YATotDs24RdqT7nbM3jH442mF4BNtu/A+HLwrtivglwpLMXP5o1LMAaezX657O0cJPq3jyZwpCPP9yJ/DOmm/5nGyXmr5XluEB0ly818w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCkujb1qThv0TjXXM2qMFKGLhyATY5w3GK0/zWeF80g=;
 b=xWEGlknKscRKNMIL4yBJ31DpH0OMoqwDU30c2lmPil+813qU1if0v57F6wHVeK5LisOsmoMCfW05Gy8/FrnP+VYW6uWcsyPdG5yj2KgFKoAYpmEWfUHBXSLWJP+wh9IDntvUb0Mpc5VEdZRIA3LfOVsqZC1LGQ8/uL+oJ8WOqozyLFOzZhiX89ScnPuY8mlW6IsfY1lxLgz8BmovHexGziYp4Wrf0win6PXKfFdQc3KOrsXIzPXwfSP0RdokFOVFMpyiGdobQxbeRYjHuQZcnQTi3GjRAid41W5z0lPxETD+xW29uOcjkFWn3UAWcQxMklJ7N51ndDHa2YQ4WS4Svw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA0PR15MB6365.namprd15.prod.outlook.com (2603:10b6:208:405::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Thu, 20 Mar
 2025 20:34:40 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 20:34:40 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "slava@dubeyko.com" <slava@dubeyko.com>,
        David Howells
	<dhowells@redhat.com>
CC: "dongsheng.yang@easystack.cn" <dongsheng.yang@easystack.cn>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH 04/35] ceph: Convert
 ceph_mds_request::r_pagelist to a databuf
Thread-Index: AQHblTBejsh9CAd3806rYkHZTncQa7N3O+AAgAVIwIA=
Date: Thu, 20 Mar 2025 20:34:40 +0000
Message-ID: <3fa0bf814ce79765c88211990644a010197b11bf.camel@ibm.com>
References: <a62918950646701cb9bb2ab0a32c87b53e2f102e.camel@dubeyko.com>
		 <20250313233341.1675324-1-dhowells@redhat.com>
		 <20250313233341.1675324-5-dhowells@redhat.com>
	 <2161520.1742212378@warthog.procyon.org.uk>
In-Reply-To: <2161520.1742212378@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA0PR15MB6365:EE_
x-ms-office365-filtering-correlation-id: c975840a-8279-478e-b7b5-08dd67eea3aa
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eGViSU1OdWQ5SHRaaXBXYWp3VWJmcEVVZEdCLzZkSHdHek5NNzZ2cGduQWpk?=
 =?utf-8?B?YWxTL2RWSFEvdkF3OHRnbDBJU015eHFMQUJUUVRtWVB6Q2JyWHBpeDd1SHlo?=
 =?utf-8?B?d0pZbERZZ1hDQk53SGc1M2lpK0tVcEdENlprbThjanRXMm9PMEt4RlhKR1dN?=
 =?utf-8?B?aWpLY1ZCUG5OSlVTNnk3WWtPYlMvNkpsMnc3NjNkNSs4L0FiS0NPSnpJWEdN?=
 =?utf-8?B?TzVTRGtFYnFYYk5NdXF3eHVnbHIrdEpvbnVIbUlVZEdPRHNhc0htVUVhMlhN?=
 =?utf-8?B?WkRPbHNvOC9WWUVJMXcvVTNsK2pKRHFpTVo5WXhHK2lEZnZ5VU5DU3NFSGFh?=
 =?utf-8?B?OVRHYlNOVksvY3NzVDR6cmpSQnZXb0Nmdm9sQnlIcGxiemlwNDZzTDhoN3BC?=
 =?utf-8?B?Si9pZWZWeVJTYVpWVjZyWEp4Yk55MVVya0tISkV1TzlyYTRVRU8reFZJVlNY?=
 =?utf-8?B?TVVuYWVUUEFNNWdyM29Wb29LZG9sS2tqcXpCOU1aWHM2R2R1cXcwb201SExy?=
 =?utf-8?B?ajl4WWMzb2E3SU9UamZwVTZEVEhPUDRlL3RsM3I4U0NNVkRmQXdqUDBSQys0?=
 =?utf-8?B?NXBKbjh0U1c5MzZhSTlGZU1EVEZOS2tJcGtyY0pXOWtkRHY0VTlTWVFjd2Zo?=
 =?utf-8?B?am84QVlhRHBWVzdWcXdVOHFleFNBZ0ZxaHQ2T1plSVMrS2g4TmFhZncrQnpo?=
 =?utf-8?B?bUVIK3p0ckYrak5Ma0tqWW9VWlQxUlRod0ZSS2hRM1YyUnBqNkx0MWdQTUt6?=
 =?utf-8?B?UHdnMldReHBIMVFkWHQ1U1lxUER0dmxudkNZTXpHVGo0eGY2cTB4UEFpWUhG?=
 =?utf-8?B?QW54dElJeVdLVEVpV21JU0lXWEdZSFFUZEtvZy9FZmJYU0o3TURZUFZvZ2hv?=
 =?utf-8?B?aENXZnorZ09TK1k4Wm9jVVhKRTRvaWJhY1VwYyt5QzQ1MXo0TnV3ekd0dzlM?=
 =?utf-8?B?MW5zSXhDbHJIaHIyQ2oyV3J2OFRVUkgxazMreEp0MnphYXJhYU9oZ09LQVg2?=
 =?utf-8?B?RmlONGlIejNDWWVXZ3hTTVRjYmZIYnoyWThVVXFVRkNTb0V5THlnM212YnNq?=
 =?utf-8?B?ZWVyWGNuY1BsVUY4YXozdm9SbkpGRUNjVXE0cktUaFZuc3c5a1BLQ0hnUjFt?=
 =?utf-8?B?dmQrZFJCMExyOHVyM1dMcUJRTlJOM0JKNENrbDlwaUZpT0RDR3FFOVV2STZD?=
 =?utf-8?B?L0E1OTNUWklCOXdGMEdSVTNxekdNTVcwbGdJdFdEeWFmc2dERjk2emRGNHdI?=
 =?utf-8?B?SUxHYWxpa0ZSVmg5bGxyYkREdWl5UFNrVUo2WUV5ZUVDWlBEdWRoN00rN2V1?=
 =?utf-8?B?a2RhYmw5bkMzdUozRVgrRVV0Nko1NjFVdnJQUERUa0VBR3VUOWwxMlloSmRp?=
 =?utf-8?B?WlZva3ZBclJ6NFVETjVTNlhHN0lyeTJVZSt2R0NIQUpPZ3EyZGZUS3dQbDg4?=
 =?utf-8?B?RWErSXdhSmVWWWhncEdlQWtMZCtqVE03RFA0aVVMSjdDNWRGTitGbEVDYnI4?=
 =?utf-8?B?S0Z1U0R6bThhM2swbGRsaUt2VFdPSnp3KzZ0bTN4TVVMK0FTbmgvMWFNS0pD?=
 =?utf-8?B?U1VWaDQ1WDV1dWREQk1jcGhZU1lVaUNLRlorN1JQZG4yOFk1dUZnbWtxQ1N4?=
 =?utf-8?B?SGp4dk9NanZRTXhaWnU3Rkp4NmVJd2FOeHU5YmFXeHlSd21RYjNSNVZmMnNt?=
 =?utf-8?B?TXdkVk1xMWsydWV2YldtSnY1TUtsWDZpZE1JMWZpalFiODdtbWs2MDRNWDI5?=
 =?utf-8?B?cnFVL1RQdm9VMU96K0tlc2wvNG1jQmVtU0NVZFNaVCtNTDV3bW9Ic1E1Uytj?=
 =?utf-8?B?dnNPZHordXpPbk96dzJEeFppbWtIUUQvWjV4ZVRIRG9sWlFKMEV0cDNIM3pY?=
 =?utf-8?B?Nlp3czdZdG5mTEl2T2tsZGk2YXdrNUJUc1E3S0VvandmeXVmWmYwaGZNQ3B0?=
 =?utf-8?Q?4Og+ykBsi9qQjOFy79q3uKMot/4VLrik?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFdJK2I3VEhFdHl5OUNNaXJtNVJwTHQ4TVdtbUVPejE3cUg4SlRVeHltWWph?=
 =?utf-8?B?czhqSzNid2FmQlFpckNFWnp0R2RtNXNoUFdBZEZlQm1KL0N0TUpIWnJNTUt5?=
 =?utf-8?B?ZDVWUVhnQ2syTmM2K0l3eVNOeGFjTjNrSm84bjl1SVJOaWFoWUZESU1YMys0?=
 =?utf-8?B?cXFnWFVEeEpyVXpHVHVMTmdZd2ovRU9HeGtUS25NMmFMS0dETEJld0Q4YWsw?=
 =?utf-8?B?UkluZm5JRUgyTkRKdGIxM251UkRzU1lqaER2dytuSE9xaHBWQ0tBUXhwNFlM?=
 =?utf-8?B?Z3EyYVNUZkJMV3FOV05kSjBqMU5JN01yQU41MEJLc1ZoT0w4d2hrbmFvQVJ0?=
 =?utf-8?B?cGVzZnBEdVFCbDRJdWg0NVRWTDZueTlvRlMvM2JmOXBpRXNDU0NjUG1OV25C?=
 =?utf-8?B?R0lNcktNUXpXdnpqVVI3Q2VlS0NqMVVmaHhKcG1ocWhxck5hM3NVbytpbE5r?=
 =?utf-8?B?NWswVnJJbWIwc3JpMXJvbGJLTVVaWkMxVzJ0UUJkeHc0eEVVN1NxNGx4aUV0?=
 =?utf-8?B?UlZlRjZjY1V4MUtaZy9RYWNETElsQ3VaNDEwMnlqTFFYcGNQSDB0aVE5aWIy?=
 =?utf-8?B?czJxalQ3UktnL0hCdkhBS2dLd1lWaGpmTEtSbnh3UjNadzlpSXRHbGdHTFhY?=
 =?utf-8?B?czBNQmkzWFFkaHJZZjRnMEhDbUhrMzVmYk5tSGhuS0VWUG5JaWViOExpaUV4?=
 =?utf-8?B?dktzQmVOQ1FUaU1ER0ZUeEFKNlhXc3lYc2RFeU92SEhTWngyZXlKRmh3S3Y0?=
 =?utf-8?B?MGhEVW1YQXpvcEVxQlhtWFo5a20rd3RwNXljME5VdlV2d080VmZGYkY5eEJQ?=
 =?utf-8?B?Rk55bnR5Qm0wWDhsdk1MRmFjMkFsc25USU9wM21MTmJYdFVjR1c3cVVSdDk2?=
 =?utf-8?B?Skp0VmRjaFpjaS9jTWhjRDVEM011V054WG9VQzcrK2hiZEVLSlRZYnJ3YS85?=
 =?utf-8?B?eG9OYzNhUWdTbzZiTk8vVlNmRVdGTU5PcU1iVkw4WGV0UG10MlhQbm8vblhG?=
 =?utf-8?B?N2Q2Zk9xRmZzMlJMSTUwNFJra0ZJQWpQMXJSVTlGR1gwTUErMW12UFhiYlZC?=
 =?utf-8?B?R0o1YnZ3V2s3SjJWUVhVdHprMHA3Q0NRMzBWdXBxZGUyeURmUVE3VHpIUW1m?=
 =?utf-8?B?MXRPWkZmSHByL2FEenRCTVcxRkpMNjlhTlhpb0d4ZVcycG1uVUtib2NoUHRl?=
 =?utf-8?B?ak0yOXJLYTlWMWZTWWxhWkVNQ2pqd0M4ZXZTSW9sNFE0bzM5RTNORE5pYmVE?=
 =?utf-8?B?QTliVUdTcDgzSit2eWRpYlI1MzZpQVBESDNNZnpiZUFGU0kzZ1hkOXlaNFVF?=
 =?utf-8?B?RUNDQStFUkJZT1pZTDRHaktDZGZqaGkrYnhwbzlXUUlPeVVVZkMyclFnT2Rm?=
 =?utf-8?B?ZEg4clV6R3VTMmJpcGJwakREcS9yMFc4cWhLVTk5UkRNbjhPdjc2Tk1oYXJz?=
 =?utf-8?B?L1M2aDBYOVdEL3E5eUQ4R0JLZkxuVmVRWUFxZGJrVWF1dlp5SnBoZ2QyZE5s?=
 =?utf-8?B?TWJMM1dHQS82YTJaMGxpRjN6TzZiTEo2ZjdYZFZRaFFUaVNTTlQ0UVdqWTJU?=
 =?utf-8?B?aVV1QVhOUEhBVFFLRVdJd3IxL0xaNEZOeWs2UG1ZWk15YmcyVktXVnZsYkNm?=
 =?utf-8?B?TkVnR1diam9OWEZBcllGT0JVQmFxSVhYR2tUSS9mU3luYkIvazJmSFFOeUpR?=
 =?utf-8?B?RS8wbm02QUJhQkUzTXdxZ0NVS1lIY0U0NnUvNzBRbXdYTmtGdHdiQ3dLcjlE?=
 =?utf-8?B?bnpPZ1RJM2xTcUlBM0RQV294TElwL09DdDRvbUNRK0txS1MwMW9hejlHWHhm?=
 =?utf-8?B?UHlmNHhPWkVKOVBGQk9CMjlhRGJOa25tcnFyZVJHUUg1bWdWa09hMmhBUG9G?=
 =?utf-8?B?NGhxSVRqR3NPbjVrZXh3SFVQY1lJZWhFTUpwSUhkVm1taEQyR0hIbWNGYUpW?=
 =?utf-8?B?TTRjOWJiMzRUc0tWVHFHWFpzZW9TTVU1ZkxSWHFUN2VLdllQUWx3Z2xSTDI5?=
 =?utf-8?B?RDlwM0k4bTNCcFFLQmY2cllYaGp0ZnoyN3p1cXFPdkpscjNpbDZ2d2lMT21q?=
 =?utf-8?B?YVpTSFVZajlpZmJUQUZXeXVqZVlvd1ZnTmVQSWZtZVdwMzg4cy91MW9McWVv?=
 =?utf-8?B?UFRyZ2tKd1JXVkhiMjdsblBmenJHUUI5aEpUMzBzVWk3bFpuSk8xaU85SGZU?=
 =?utf-8?Q?n+YCYxr+mDFQhjoX/8lWKL8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9ADCFA4144C3044BBC711AEEBD97B6EB@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c975840a-8279-478e-b7b5-08dd67eea3aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 20:34:40.1626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRnQ5I5BIpbLm8t2qP1OrrWMqL5Gd7DgfxL6GzSPo/2DrOQQsdKWOScpltQ24SCXxpORWhiAFuvl3dRAkgKZ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR15MB6365
X-Proofpoint-GUID: _NfCLDPKhUfPkh2NrXdcoVgF-h7xUVR-
X-Proofpoint-ORIG-GUID: rTDaTYNqFvCszxIfPrYo8gfrtK0VHkqd
Subject: RE: [RFC PATCH 04/35] ceph: Convert ceph_mds_request::r_pagelist to a
 databuf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_07,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=623 spamscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503200131

T24gTW9uLCAyMDI1LTAzLTE3IGF0IDExOjUyICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBzbGF2YUBkdWJleWtvLmNvbSB3cm90ZToNCj4gDQo+ID4gPiAtCQllcnIgPSBjZXBoX3BhZ2Vs
aXN0X3Jlc2VydmUocGFnZWxpc3QsIGxlbiArDQo+ID4gPiB2YWxfc2l6ZTEgKyA4KTsNCj4gPiA+
ICsJCWVyciA9IGNlcGhfZGF0YWJ1Zl9yZXNlcnZlKGRidWYsIGxlbiArIHZhbF9zaXplMSArDQo+
ID4gPiA4LA0KPiA+ID4gKwkJCQkJwqDCoCBHRlBfS0VSTkVMKTsNCj4gPiANCj4gPiBJIGtub3cg
dGhhdCBpdCdzIHNpbXBsZSBjaGFuZ2UuIEJ1dCB0aGlzIGxlbiArIHZhbF9zaXplMSArIDggbG9v
a3MNCj4gPiBjb25mdXNpbmcsIGFueXdheS4gV2hhdCB0aGlzIGhhcmRjb2RlZCA4IG1lYW5zPyA6
KQ0KPiANCj4gWW91IHRlbGwgbWUuICBUaGUgJzgnIGlzIHByZS1leGlzdGluZy4NCj4gDQoNClll
YWgsIEkga25vdy4gSSBhbSBzaW1wbHkgdGhpbmtpbmcgYWxvdWQgdGhhdCB3ZSBuZWVkIHRvIHJl
d29yayB0aGUgQ2VwaEZTIGNvZGUNCnNvbWVob3cgdG8gbWFrZSBpdCBtb3JlIGNsZWFyIGFuZCBl
YXN5IHVuZGVyc3RhbmRhYmxlLiBCdXQgaXQgaGFzIG5vIHJlbGF0aW9ucw0Kd2l0aCB5b3VyIGNo
YW5nZS4gDQoNCj4gPiA+IC0JaWYgKHJlcS0+cl9wYWdlbGlzdCkgew0KPiA+ID4gLQkJaWluZm8u
eGF0dHJfbGVuID0gcmVxLT5yX3BhZ2VsaXN0LT5sZW5ndGg7DQo+ID4gPiAtCQlpaW5mby54YXR0
cl9kYXRhID0gcmVxLT5yX3BhZ2VsaXN0LT5tYXBwZWRfdGFpbDsNCj4gPiA+ICsJaWYgKHJlcS0+
cl9kYnVmKSB7DQo+ID4gPiArCQlpaW5mby54YXR0cl9sZW4gPSBjZXBoX2RhdGFidWZfbGVuKHJl
cS0+cl9kYnVmKTsNCj4gPiA+ICsJCWlpbmZvLnhhdHRyX2RhdGEgPSBrbWFwX2NlcGhfZGF0YWJ1
Zl9wYWdlKHJlcS0NCj4gPiA+ID4gcl9kYnVmLCAwKTsNCj4gPiANCj4gPiBQb3NzaWJseSwgaXQn
cyBpbiBhbm90aGVyIHBhdGNoLiBIYXZlIHdlIHJlbW92ZWQgcmVxLT5yX3BhZ2VsaXN0IGZyb20N
Cj4gPiB0aGUgc3RydWN0dXJlPw0KPiANCj4gU2VlIHBhdGNoIDIwICJsaWJjZXBoOiBSZW1vdmUg
Y2VwaF9wYWdlbGlzdCIuDQo+IA0KPiBJdCBjYW5ub3QgYmUgcmVtb3ZlZCBoZXJlIGFzIHRoZSBr
ZXJuZWwgbXVzdCBzdGlsbCBjb21waWxlIGFuZCB3b3JrIGF0IHRoaXMNCj4gcG9pbnQuDQo+IA0K
PiA+IERvIHdlIGFsd2F5cyBoYXZlIG1lbW9yeSBwYWdlcyBpbiBjZXBoX2RhdGFidWY/IEhvdw0K
PiA+IGttYXBfY2VwaF9kYXRhYnVmX3BhZ2UoKSB3aWxsIGJlaGF2ZSBpZiBpdCdzIG5vdCBtZW1v
cnkgcGFnZS4NCj4gDQo+IEFyZSB0aGVyZSBvdGhlciBzb3J0cyBvZiBwYWdlcz8NCj4gDQoNCk15
IHBvaW50IGlzIHNpbXBsZS4gSSBhc3N1bWVkIHRoYXQgaWYgY2VwaF9kYXRhYnVmIGNhbiBoYW5k
bGUgbXVsdGlwbGUgdHlwZXMgb2YNCm1lbW9yeSByZXByZXNlbnRhdGlvbnMsIHRoZW4gaXQgY291
bGQgYmUgbm90IG9ubHkgbWVtb3J5IHBhZ2VzLiBQb3RlbnRpYWxseSwgQ1hMDQptZW1vcnkgd291
bGQgcmVxdWlyZSBzb21lIHNwZWNpYWwgbWFuYWdlbWVudCBpbiB0aGUgZnV0dXJlIChtYXliZSBu
b3QpLiA6KSBCdXQNCmlmIHdlIGFsd2F5cyB1c2UgcmVndWxhciBtZW1vcnkgcGFnZXMgdW5kZXIg
Y2VwaF9kYXRhYnVmIGFic3RyYWN0aW9uLCB0aGVuIEkNCmRvbid0IHNlZSBhbnkgcHJvYmxlbSBo
ZXJlLg0KDQo+ID4gTWF5YmUsIHdlIG5lZWQgdG8gaGlkZSBrdW5tYXBfbG9jYWwoKSBpbnRvIHNv
bWV0aGluZyBsaWtlDQo+ID4ga3VubWFwX2NlcGhfZGF0YWJ1Zl9wYWdlKCk/DQo+IA0KPiBBY3R1
YWxseSwgcHJvYmFibHkgYmV0dGVyIHRvIHJlbmFtZSBrbWFwX2NlcGhfZGF0YWJ1Zl9wYWdlKCkg
dG8NCj4ga21hcF9sb2NhbF9jZXBoX2RhdGFidWYoKS4NCj4gDQo+ID4gTWF5YmUsIGl0IG1ha2Vz
IHNlbnNlIHRvIGNhbGwgc29tZXRoaW5nIGxpa2UgY2VwaF9kYXRhYnVmX2xlbmd0aCgpDQo+ID4g
aW5zdGVhZCBvZiBsb3cgbGV2ZWwgYWNjZXNzIHRvIGRidWYtPm5yX2J2ZWM/DQo+IA0KPiBTb3Vu
ZHMgcmVhc29uYWJsZS4gIEJldHRlciB0byBoaWRlIHRoZSBpbnRlcm5hbCB3b3JraW5ncy4NCj4g
DQo+ID4gPiArCWlmIChhc19jdHgtPmRidWYpIHsNCj4gPiA+ICsJCXJlcS0+cl9kYnVmID0gYXNf
Y3R4LT5kYnVmOw0KPiA+ID4gKwkJYXNfY3R4LT5kYnVmID0gTlVMTDsNCj4gPiANCj4gPiBNYXli
ZSwgd2UgbmVlZCBzb21ldGhpbmcgbGlrZSBzd2FwKCkgbWV0aG9kPyA6KQ0KPiANCj4gSSBjb3Vs
ZCBwb2ludCBvdXQgdGhhdCB5b3Ugd2VyZSBjb21wbGFpbmluZyBhYm91dCBjZXBoX2RhdGFidWZf
Z2V0KCkgcmV0dXJuaW5nDQo+IGEgcG9pbnRlciB0aGFuIGEgdm9pZDstKS4NCj4gDQo+ID4gPiAr
CWRidWYgPSBjZXBoX2RhdGFidWZfcmVxX2FsbG9jKDIsIDAsIEdGUF9LRVJORUwpOw0KPiA+IA0K
PiA+IFNvLCBkbyB3ZSBhbGxvY2F0ZSAyIGl0ZW1zIG9mIHplcm8gbGVuZ3RoIGhlcmU/DQo+IA0K
PiBZb3UgZG9uJ3QuICBPbmUgaXMgdGhlIGJ2ZWNbXSBjb3VudCAoMikgYW5kIG9uZSBpcyB0aGF0
IGFtb3VudCBvZiBtZW1vcnkgdG8NCj4gcHJlYWxsb2NhdGUgKDApIGFuZCBhdHRhY2ggdG8gdGhh
dCBidmVjW10uDQo+IA0KDQpBYWFoLiBJIHNlZSBub3cuIFRoYW5rcy4NCg0KPiBOb3csIGl0IG1h
eSBtYWtlIHNlbnNlIHRvIHNwbGl0IHRoZSBBUEkgY2FsbHMgdG8gaGFuZGxlIGEgbnVtYmVyIG9m
IGRpZmZlcmVudA0KPiBzY2VuYXJpb3MsIGUuZy46IHJlcXVlc3Qgd2l0aCBqdXN0IHByb3RvY29s
LCBubyBwYWdlczsgcmVxdWVzdCB3aXRoIGp1c3QNCj4gcGFnZXM7IHJlcXVlc3Qgd2l0aCBib3Ro
IHByb3RvY29sIGJpdHMgYW5kIHBhZ2UgbGlzdC4NCj4gDQo+ID4gPiArCWlmIChjZXBoX2RhdGFi
dWZfaW5zZXJ0X2ZyYWcoZGJ1ZiwgMCwgc2l6ZW9mKCpoZWFkZXIpLA0KPiA+ID4gR0ZQX0tFUk5F
TCkgPCAwKQ0KPiA+ID4gKwkJZ290byBvdXQ7DQo+ID4gPiArCWlmIChjZXBoX2RhdGFidWZfaW5z
ZXJ0X2ZyYWcoZGJ1ZiwgMSwgUEFHRV9TSVpFLCBHRlBfS0VSTkVMKQ0KPiA+ID4gPCAwKQ0KPiA+
ID4gIAkJZ290byBvdXQ7DQo+ID4gPiAgDQo+ID4gPiArCWlvdl9pdGVyX2J2ZWMoJml0ZXIsIElU
RVJfREVTVCwgJmRidWYtPmJ2ZWNbMV0sIDEsIGxlbik7DQo+ID4gDQo+ID4gSXMgaXQgY29ycmVj
dCAmZGJ1Zi0+YnZlY1sxXT8gV2h5IGRvIHdlIHdvcmsgd2l0aCBpdGVtICMxPyBJIHRoaW5rIGl0
DQo+ID4gbG9va3MgY29uZnVzaW5nLg0KPiANCj4gQmVjYXVzZSB5b3UgaGF2ZSBhIHByb3RvY29s
IGVsZW1lbnQgKGluIGRidWYtPmJ2ZWNbMF0pIGFuZCBhIGJ1ZmZlciAoaW4NCj4gZGJ1Zi0+YnZl
Y1sxXSkuDQoNCkl0IHNvdW5kcyB0byBtZSB0aGF0IHdlIG5lZWQgdG8gaGF2ZSB0d28gZGVjbGFy
YXRpb25zIChzb21ldGhpbmcgbGlrZSB0aGlzKToNCg0KI2RlZmluZSBQUk9UT0NPTF9FTEVNRU5U
X0lOREVYICAgIDANCiNkZWZpbmUgQlVGRkVSX0lOREVYICAgICAgICAgICAgICAxDQoNCj4gDQo+
IEFuIGl0ZXJhdG9yIGlzIGF0dGFjaGVkIHRvIHRoZSBidWZmZXIgYW5kIHRoZSBpdGVyYXRvciB0
aGVuIGNvbnZleXMgaXQgdG8NCj4gX19jZXBoX3N5bmNfcmVhZCgpIGFzIHRoZSBkZXN0aW5hdGlv
bi4NCj4gDQo+IElmIHlvdSBsb29rIGEgZmV3IGxpbmVzIGZ1cnRoZXIgb24gaW4gdGhlIHBhdGNo
LCB5b3UgY2FuIHNlZSB0aGUgZmlyc3QNCj4gZnJhZ21lbnQgYmVpbmcgYWNjZXNzZWQ6DQo+IA0K
PiA+ICsJaGVhZGVyID0ga21hcF9jZXBoX2RhdGFidWZfcGFnZShkYnVmLCAwKTsNCj4gPiArDQo+
IA0KPiBOb3RlIHRoYXQsIGJlY2F1c2UgdGhlIHJlYWQgYnVmZmVyIGlzIHZlcnkgbGlrZWx5IGEg
d2hvbGUgcGFnZSwgSSBzcGxpdCB0aGVtDQo+IGludG8gc2VwYXJhdGUgc2VjdGlvbnMgcmF0aGVy
IHRoYW4gdHJ5aW5nIHRvIGFsbG9jYXRlIGFuIG9yZGVyLTEgcGFnZSBhcyB0aGF0DQo+IHdvdWxk
IGJlIG1vcmUgbGlrZWx5IHRvIGZhaWwuDQo+IA0KPiA+ID4gLQkJaGVhZGVyLmRhdGFfbGVuID0g
Y3B1X3RvX2xlMzIoOCArIDggKyA0KTsNCj4gPiA+IC0JCWhlYWRlci5maWxlX29mZnNldCA9IDA7
DQo+ID4gPiArCQloZWFkZXItPmRhdGFfbGVuID0gY3B1X3RvX2xlMzIoOCArIDggKyA0KTsNCj4g
PiANCj4gPiBUaGUgc2FtZSBwcm9ibGVtIG9mIHVuZGVyc3RhbmRpbmcgaGVyZSBmb3IgbWUuIFdo
YXQgdGhpcyBoYXJkY29kZWQgOCArDQo+ID4gOCArIDQgdmFsdWUgbWVhbnM/IDopDQo+IA0KPiBZ
b3UgbmVlZCB0byBhc2sgYSBjZXBoIGV4cGVydC4gIFRoaXMgaXMgbm90aGluZyBzcGVjaWZpY2Fs
bHkgdG8gZG8gd2l0aCBteQ0KPiBjaGFuZ2VzLiAgSG93ZXZlciwgSSBzdXNwZWN0IGl0J3MgdGhl
IHNpemUgb2YgdGhlIG1lc3NhZ2UgZWxlbWVudC4NCj4gDQoNClllYWgsIEkgc2VlLiA6KQ0KDQo+
ID4gPiAtCQltZW1zZXQoaW92Lmlvdl9iYXNlICsgYm9mZiwgMCwgUEFHRV9TSVpFIC0gYm9mZik7
DQo+ID4gPiArCQlwID0ga21hcF9jZXBoX2RhdGFidWZfcGFnZShkYnVmLCAxKTsNCj4gPiANCj4g
PiBNYXliZSwgd2UgbmVlZCB0byBpbnRyb2R1Y2Ugc29tZSBjb25zdGFudHMgdG8gYWRkcmVzcyAj
MCBhbmQgIzEgcGFnZXM/DQo+ID4gQmVjYXVzZSwgIzAgaXQncyBoZWFkZXIgYW5kIEkgYXNzdW1l
ICMxIGlzIHNvbWUgY29udGVudC4NCj4gDQo+IFdoaWxzdCB0aGF0IG1pZ2h0IGJlIHVzZWZ1bCwg
SSBkb24ndCBrbm93IHRoYXQgdGhlIDAgYW5kIDEuLi4gYmVpbmcgaGVhZGVyIGFuZA0KPiBjb250
ZW50IHJlc3BlY3RpdmVseSBhbHdheXMgaG9sZC4gIEkgaGF2ZW4ndCBjaGVja2VkLCBidXQgdGhl
cmUgY291bGQgZXZlbiBiZQ0KPiBhIHByb3RvY29sIHRyYWlsZXIgaW4gc29tZSBjYXNlcyBhcyB3
ZWxsLg0KPiANCj4gPiA+IC0JZXJyID0gY2VwaF9wYWdlbGlzdF9yZXNlcnZlKHBhZ2VsaXN0LA0K
PiA+ID4gLQkJCQnCoMKgwqAgNCAqIDIgKyBuYW1lX2xlbiArIGFzX2N0eC0NCj4gPiA+ID4gbHNt
Y3R4Lmxlbik7DQo+ID4gPiArCWVyciA9IGNlcGhfZGF0YWJ1Zl9yZXNlcnZlKGRidWYsIDQgKiAy
ICsgbmFtZV9sZW4gKyBhc19jdHgtDQo+ID4gPiA+IGxzbWN0eC5sZW4sDQo+ID4gPiArCQkJCcKg
wqAgR0ZQX0tFUk5FTCk7DQo+ID4gDQo+ID4gVGhlIDQgKiAyICsgbmFtZV9sZW4gKyBhc19jdHgt
PmxzbWN0eC5sZW4gbG9va3MgdW5jbGVhciB0byBtZS4gSXQgd2lsDQo+ID4gYmUgZ29vZCB0byBo
YXZlIHNvbWUgd2VsbCBkZWZpbmVkIGNvbnN0YW50cyBoZXJlLg0KPiANCj4gQWdhaW4sIG5vdGhp
bmcgc3BlY2lmaWNhbGx5IHRvIGRvIHdpdGggbXkgY2hhbmdlcy4NCj4gDQoNCkkgY29tcGxldGVs
eSBhZ3JlZS4NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCg==

