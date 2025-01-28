Return-Path: <linux-fsdevel+bounces-40262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C26AA214A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 23:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16C41886720
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 22:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C3C1DFE36;
	Tue, 28 Jan 2025 22:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LFiKVPwr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37831199239;
	Tue, 28 Jan 2025 22:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738105042; cv=fail; b=SaRzRaogyt6Ir1oLVwclhoAjlayL7oEoVAHkrNolaV+xUK5NNxbRx5/K5/sQ8u68XqhNc3DQFk5Hymcs1er61iSimhV/SfsErx0LnsZHlC5NQn6zWvQI0AbJOj5li/8ug15+OZm3d5Q34EjA3H0YDKsP6un4yerXEMqg0NvyREw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738105042; c=relaxed/simple;
	bh=HriR9RN1xvrpD6tGG4iipfMrbB+CmrDjv1/25gZODU0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=YFpq+GYTmNX5VbnwV1G0Cb47hXoH8OwD3Gm5O6at/b2L0Ye69DSGWmvA7IHsNL1Vrv38lL6n/yHu4yEX3uH/5DkYZFuXBRhEOm4CDug4/g2r5B0049K6PEj0JiCgBQn9/k0SVh5VVyoZOQ2mRclsJSWrq+rDyNrUzw5k/Jw5eO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LFiKVPwr; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SG4UV9023571;
	Tue, 28 Jan 2025 22:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=HriR9RN1xvrpD6tGG4iipfMrbB+CmrDjv1/25gZODU0=; b=LFiKVPwr
	d/mOgNmd4wMxQgpnKLKc1WCs7/ggkA0Ze2vDdluhwQ5NgqkRUrulkJqFcuP+/UTS
	6Q+bbSpdRfMUS24B4Zlroi8mVDjsf8hrkg97qzilHwv0lZQ9e1jTLui8yDDZB6yz
	m2jafOe9Qprrt32O6/0eUFKfBxXkNGSruVHb4bFYwHxCvUtR8uoxnnNd8HeA8T3s
	6oY7J/pYCHts7uoe19QAIlvs3fUnqK/sAaowUNY73jHgPh7Dwb5xD/WLJISzNB1c
	2vPpPUieLkAzZX6G4UtmAlzuGVFKACBgkvMu8ZZDFRcmDD7/dmrtTBugz2nw8F1f
	nR8LC9Di0fd8FA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44es27mrba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 22:57:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyfPtF1keRXBRyOclXnvxTToTsVLPAaE78CKgK8KNUC5QuRd76Wjo9//sDfsw3mEVZ1Ic2cWkM4NCoVXs+T8ToPwPNgp9NudsJH4f9zjE4vrFtiPUNsJ/FtRp6OE5+XTZqE7rB0kSlSHUNpQvR8nriTbI+tswoa+3paaHu29sndNSYb+HiyhqAOQ1bUM9QkBVWkpAjuDsYyiHg/pd/7CGKgbFi4V0BxhPRoNJ+6PHFcj9Yq1TLSzZGXoz7Ry+D04WtkVdvJfUNfWRfIJll3Ag/PZOJXXLvatPnOJlghpwdm13f3sq39YEmN7KhkHo4F2HaJKN8A5/B36dbexRBO8/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HriR9RN1xvrpD6tGG4iipfMrbB+CmrDjv1/25gZODU0=;
 b=H1QyohCx7NziQP9xAfeuy/almcyd4/vF/uXeRPVf7iZFaQS7wIPvleg9fPCiHu61sZRT94Ki8v1gJvHQBFyMcvgxDkL7eYGwREMU5bqEhPbFfaoHJKZBwWEf8uZ20D6ckze6VS3Wu1oEQJiWZCnrkbJ0/btw5yY09ziEuf9jzf6GP6RHBw5Ptz+6gObrt1VZ0nI8xbtGf0KxglxkVB6VaamhDFz7a5Poh7XBDsEXf1U/7v2TYI89z81qBINpV4kjRBrpqvQRxDIQXlOv4nLAt2Q6+/NpoyEKroIhTyLBfdfjIHR2SBHEyzNuYuum14I6N/6sOaxgMxPR3OJNk9w8xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA6PR15MB6716.namprd15.prod.outlook.com (2603:10b6:806:40c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 22:57:05 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 22:57:04 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "slava@dubeyko.com" <slava@dubeyko.com>,
        "bvanassche@acm.org"
	<bvanassche@acm.org>,
        "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        Greg Farnum <gfarnum@ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "javier.gonz@samsung.com" <javier.gonz@samsung.com>
Thread-Topic: [EXTERNAL] Re: [LSF/MM/BPF TOPIC] Generalized data temperature
 estimation framework
Thread-Index: AQHbbqDXiGJ8UXK5fEWDdER5m+EPkbMma7kAgAStjICAADPIgIABgTEAgAAEZQA=
Date: Tue, 28 Jan 2025 22:57:04 +0000
Message-ID: <d621a008fd43f26cdc8641b2a842965570f17846.camel@ibm.com>
References: <20250123203319.11420-1-slava@dubeyko.com>
	 <39de3063-a1c8-4d59-8819-961e5a10cbb9@acm.org>
	 <0fbbd5a488cdbd4e1e1d1d79ea43c39582569f5a.camel@ibm.com>
	 <833b054b-f179-4bc8-912b-dad057d193cd@acm.org>
	 <1a33cb72ace2f427aa5006980b0b4f253d98ce6f.camel@ibm.com>
	 <fb27be18-2af6-4f89-b15a-5bd1fb8558e9@acm.org>
In-Reply-To: <fb27be18-2af6-4f89-b15a-5bd1fb8558e9@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA6PR15MB6716:EE_
x-ms-office365-filtering-correlation-id: d066c9ab-cdb1-44c7-4f0f-08dd3fef15a0
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cWtZQ3dBRUMzWGpVYlBWM2phcCtab3FqQXNUQWJzTnVrbURHNnNQYnI4M2Z5?=
 =?utf-8?B?OUNzcWhHUHZyMzFONE1SNHNxcTFDVGRpN3l3a0VkSWw2YmQ0QjNjUitONHAv?=
 =?utf-8?B?TFkxenRBTFRsOUU0RDQzRTVVVHQwWi9XakNqd1hkbFhRZ3ltV1NXSkUzYWtz?=
 =?utf-8?B?VW1tVUx3VFBmN3VPblpUMlhmTjNIRE5uR3RpODRubFdmbEF5b1lOUVhOcEI5?=
 =?utf-8?B?YnBFczJvbERwakhVWUlCYVh5UDErbVR4aGJZUEh4SUVyUkVHWTUvd0U1M2kx?=
 =?utf-8?B?ek4wcUJPUWp0eXpMRFBodUpMNUJKQkEybjJnQzRSdFo2S0pQVDljOWt5Y3hK?=
 =?utf-8?B?anhLTzlnSkZZUy84QVpGRlpramhuaW9pN3p1MmdFZzh0b2FRT0NTVHFaVHlu?=
 =?utf-8?B?cUdsNmFUT1lRTEEzTUYwdVpkQmtTcURGQzBrb2ZzZkhZZmNJZ2ppanZmZWcy?=
 =?utf-8?B?R3FoT0lIRjVTcEFZSWhxVk13V1J5amlqeVl6UWFLVU1IUkdIc1FkOURuZ1dp?=
 =?utf-8?B?YlF1d29OSEc0OXJHcG4zSEpNVkFhVERmWUZxM0k4Y1ZxeFNmdWlmYUw3UjNC?=
 =?utf-8?B?ajlGaG1nVVhCL0ptYTQ3QWJkUXZ0cUtDbWVwbkUrY09WMy9ITGJTQm5VRkUy?=
 =?utf-8?B?VFdoVkc3UUJJcldSTlJEckk4V3M5ZEZJRjJSak9CZlhNZGpXeHAwSXFXRzIz?=
 =?utf-8?B?bC9NSHRqeDZGUkNJdTd1a0N0bWZYQm9YOXgvZ0s3NEE0eERjbE5hOHJ3QVFM?=
 =?utf-8?B?M0VVbmxxb05jOHVkdDBDa3BLOHZPNjdkT1ZCZFhaQkJUc2cyVFpoOGQ4bW1M?=
 =?utf-8?B?SVZEYWFPZmtoZTZSeHdvUVF5Qm9IRWZsL2wvMUo5MEUxWEVjSW9NdS9rcmJn?=
 =?utf-8?B?TXpyZzJSYzdLQng5d29hdWxsQ2pVVDdqa2c4TlVCZFRVWHdZNlMwblB2Qnpm?=
 =?utf-8?B?Z21lbGVmRWs1cTlHK2d3blV6czdHOXdocDJPWW92bCtJTDhwSXFOeVArK3hm?=
 =?utf-8?B?ekc5bDlsellXSVp5LzlaZTBUcUN5SEwwVGhQRHozMGxlL2hyQXRIT1BqQXdF?=
 =?utf-8?B?ZU5FNUVPYk9PdTc5ZWpleEp3OHVrZGVtSGpkTnJFTDB1Ukg1SmlpaWxQNGhs?=
 =?utf-8?B?K2ZncGw3VE1XWUZzY0VnUkZmYVhaRnB6ekhtYmJCSllDT1VGek9kUFNNK1VQ?=
 =?utf-8?B?Vmxkdk12RUxZMkZZWXIrOE9zVU5xRlpmVmtKSXlTdWg1SUd0YTRsb3l1Umxk?=
 =?utf-8?B?RzR4T2luK0JDMHRuUWtwS3cwMW92U0kzSm1MWWUrdGZRT3JHMmdCbDVDdEtP?=
 =?utf-8?B?YmozUzU0b2RRSSs5eUJWYlhuUlYwQllSbHBDZFYyRVc0MERwUEF6N3BJVCtp?=
 =?utf-8?B?SitEU3RxYkw0Ky9OWkZQejFvVzdmemg5SEZHUHNvaFRyWWd1RW5JbmdZbnlH?=
 =?utf-8?B?UGRHc204Z0RuQ095ZzFJOG11QitDSlNqZXQyNDNveDF0bkhGQlQxdkY5dFdX?=
 =?utf-8?B?QmJLWEJ2eXg2OElnbDEyYWxUMzgzamp4MVo5WjVGTGZ0ZTVjOWhMRGZuTW9q?=
 =?utf-8?B?OFE1RnVhUnZ0V2YvSS9KOW4yYmpYTFZrNDFtVlNmc0pSTFhwSU1mTzNOK2lH?=
 =?utf-8?B?b3ZFeFB1dFg0bHBRbWJvNUhZQjYvMFZUWFgyVFdyWTcxTzVpWVp3WlZvR2h3?=
 =?utf-8?B?ei93TEhmdWtDRXU1Y0hhODcxbFhJZlpQeFU5SDdlYzRPc3hYSkVpQW9VemlJ?=
 =?utf-8?B?KzlGVzdNR0Q4WksrZllvbFlIQXBlalVpeldwdHhvdHF2QlRES29vT2VMa2dk?=
 =?utf-8?B?WHJxayt4dWtZS3A2eEVUb2kwV1IvWmlwcmdoZGRlU29iSVZsWGxSNzVzYlhY?=
 =?utf-8?B?dDMrY2ZEcXJ5a21CZWhqWitpc0tmUm5Nak9PMzVaZnlpNnlPbTBtQmZKZHJN?=
 =?utf-8?Q?HNR5DTxXXzGK7iqrdoUc/4znLQuVMMIs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWZ5K3BmdFM1VURIY1MxNEE2ZzdwUEZaMWZWOFlSQ1NaQ1A2YzY4MjM2Ykp6?=
 =?utf-8?B?ZFVOSTFVOXpQQVZ4YndLNEV0dVE4YlF2cng3WTNOQ1Jrb0x0ekt6N2dIWWFy?=
 =?utf-8?B?TTBpZEd6ZzA5ZldSWnBQeGZWNExYMUFVM0RVNUNoNGhyZVJ2dFo0cmswNWxC?=
 =?utf-8?B?RWlmbDhxOUZURHpYNEIyc3d4SzBsNDdWUE1Ra25ySW5BTFdhZENYVGZ2bEkw?=
 =?utf-8?B?ZGlxS0thSmJsdjBCTTdBMENVOE5QWXJKMTFJRnlIMDNObVArMjNJZnVNcmJN?=
 =?utf-8?B?NytYeW9NRWxVSWc4WHJNZmdXa1BvNVdJNFYwVVhDOFJMa0NKdXVPbkxGS3o4?=
 =?utf-8?B?SFNUL3U3KzY5OGVlQjhydElwTTlmblhPSlhtVjBaTEhHelArRTJ5OUpuUFFq?=
 =?utf-8?B?RnA4cEdmcXRZYVNNUlBXMXlrS0FMdHhtZ3ZUSGgyMVFpdGh0YXR1dWh2QmxY?=
 =?utf-8?B?S2FtNVp5OFdPUDdsSWN0alVwakdlRnhwdUdaamFUWUJxWFhYbHlLNUN6a1R6?=
 =?utf-8?B?Y3RLNG1MY2Ryc2ZNTFVNWWJnWTZVZFRHemtQci9GUUJwTEl2aGdnYWsrZVEx?=
 =?utf-8?B?U3dCaEtzc2FkR1pnTEdkbkRKZUh5dUVXNjBUTC9YaVdiTEwrbXBWTmJyUzFh?=
 =?utf-8?B?aVZVeWJ5dkpGWlM4U1UycVZHMHRDM0JiS1E4dTQ4OU8zYStOUVc4a1JxNFJv?=
 =?utf-8?B?UWFJZTRVT2I0WE40WVFrdmRWc2M2dk03SEZJTTNLWVNRamIyWFFUbGlQakN4?=
 =?utf-8?B?SUFCN0dMKzN5aEVtRndSMEdoMzI5cTlsL0F4dWcxVnZDTDRvZU51dEE2Ni9r?=
 =?utf-8?B?dVVMc2p0Zm1nUTh4MEpUN3NjYy9BbEtSTGovS1NCUUxwMk5yRk9uU0VZaVRw?=
 =?utf-8?B?dEtDV3E3c2tGMytSUTMveDBrS3YrT1hVZzdzbEhEbFhyU2cwNlFoUW54MEkv?=
 =?utf-8?B?eCtvNWtmZWN0YXFldEhXczFPREtLWlovanV0WXBHM003QzVXcHFKYzJlcmxx?=
 =?utf-8?B?S1kvOEVLRTJrQjQySFRFSUgzN0ZNWEIyMXRIbmFQY0ZpK0pCUTl3WEhZZFRz?=
 =?utf-8?B?L1JEYmx1cE8zQXVsUXRJNzJ2OG52V053MHRIQ3Bwc2FlZjhDekhESEtMSDFl?=
 =?utf-8?B?MS96TkIxMjIxMzNCcDBMVmVtWjdWN096b3lnSmwrSlZkMGFNNmhlYUdSY1pk?=
 =?utf-8?B?Zk1hMUVlRmNDaUwwZGNSMWpmWFRrY2dDQ2JtanR5NXhrWlVqWksxb0s4VTQw?=
 =?utf-8?B?ZTlSR1RGeDZ4SXZkOEs0VmRSamZMWTRZZEJneXR2ZnU4Rjc0dWl1dWdEV3ky?=
 =?utf-8?B?dnZHeUhPWld2aDIxTDhQVUdaY2t6OHI2UVhsdjBVOVMzZTFWSjJnWHJGVTJ1?=
 =?utf-8?B?M21CZ2tiRVBRYVNTWW1GWnI2QkFBbWhyOWhxc1VqMjBWeWhFdngxdHpHclJz?=
 =?utf-8?B?b1hzRm5iOXlQYWxZWWs5UWdvWkRvRDRlRlVldnRvR2tCWjEwaDRSbXpmejc2?=
 =?utf-8?B?emppaWx3R21ldGt1Zmxud1o5VEhtLzg0UDY1V09ZNHBWMnRjZ1FvRmFpc0xn?=
 =?utf-8?B?Q2x1L1JwRCtLWk1jQ0IxeG82Q2N2WVFGN3JUeWYwRXFuZlhVSnpCcWJGNFE3?=
 =?utf-8?B?TDc3endKSk44UlNUR3VacWgvdHlKelROMzB5WW9aOVkrc0xaVDhGM2w5clFM?=
 =?utf-8?B?SHphQUtna2d2dnd5MFd3Zk4xMzRKKzk3enBFVlorcnh1RE1WZFdIZWFUNWgw?=
 =?utf-8?B?akN2ZC90b055QnlibUJYMFBib20rNnMzWHdMUzF6Y05rNTZZZ0ZGZVFFY2Nr?=
 =?utf-8?B?Q2FEQTJnNU5TQk1KT0J6Sm5sSzZPSFl0UldkdUg2Vm8vTmJkaVZoNlkraFUr?=
 =?utf-8?B?OE5uS2FlOEhtZGhFN0d2OWwwSjI5S09RSFN2bHh1dGdKbmJCbEJiNHhYWmlC?=
 =?utf-8?B?ZVpYUWRiRnZGMGJGZG9ENkRvdUhkTVFuVURMVWtOZVc1QjVuMU93U21rL2hs?=
 =?utf-8?B?clpTVnliNnJyQnQxMHFmTEJaeE1FUUtZTjFNbWNub29YQ0lLcEtmejFXditG?=
 =?utf-8?B?WThHRDJUdHVKRUFOWTlRcm5PVFYzQldJY3pPT1h5UGpRNDl6alRscXl3S20y?=
 =?utf-8?B?NE5JbDNoYi9uM3hqZWFxazArMGtUMUJNQVoxVFNjOWpwL1RwS2grN1l5UTJM?=
 =?utf-8?Q?M8El8ffT/KWjHzUNZ5OMX80=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AF444C2C28C5B4FAD4630824F13C2DA@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d066c9ab-cdb1-44c7-4f0f-08dd3fef15a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2025 22:57:04.8811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4V7yTBK/jMAijQJwbt5f8E1rSOv5LfDfbDWsgheo6voNC5am8yp2FSLM9bCgIJrOrJ9p0LcWRUpxWTs/Ia+ldA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR15MB6716
X-Proofpoint-ORIG-GUID: GrwmocvTrKQO92Mh0OLxqidCFqoApCN2
X-Proofpoint-GUID: GrwmocvTrKQO92Mh0OLxqidCFqoApCN2
Subject: RE: [LSF/MM/BPF TOPIC] Generalized data temperature estimation framework
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280165

T24gVHVlLCAyMDI1LTAxLTI4IGF0IDE0OjQxIC0wODAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6
DQo+IE9uIDEvMjcvMjUgMzo0MiBQTSwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+IFdo
YXQgZG8geW91IHRoaW5rPw0KPiANCj4gVGhpcyBzb3VuZHMgbGlrZSBhbiBpbnRlcmVzdGluZyB0
b3BpYyB0byBtZSwgYnV0IGl0J3MgcHJvYmFibHkgZWFzaWVyDQo+IHRvIGRpc2N1c3MgdGhpcyBp
biBwZXJzb24gdGhhbiBvdmVyIGVtYWlsIDotKQ0KPiANCg0KTWFrZXMgc2Vuc2UuIFdpbGwgZGlz
Y3VzcyBpdCBpbiBwZXJzb24uIDopDQoNClRoYW5rcywNClNsYXZhLg0KDQo=

