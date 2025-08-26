Return-Path: <linux-fsdevel+bounces-59330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EEFB374E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 00:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DF93B3629
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 22:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E9629BDAE;
	Tue, 26 Aug 2025 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PJyLQ3FJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B371F956;
	Tue, 26 Aug 2025 22:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756247647; cv=fail; b=WTtl9X+6aMo2AJPJtnDSRb4eoGljTIDqL/7OtELhrgadWMPpJvsNd9ebj9aCOOvsOA3x8SXM9FUs+0uXmok1tKULrUumJiNMjc5yrlJsZ8XA298Sl8iO1GZBFK1ascu7GR/ovP/If1d4gsVKtYCjGDZISh+sg34wVBADL4FDK2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756247647; c=relaxed/simple;
	bh=gofja3l7/3XRhStLWI2BO2pvPmo9MYwUHBN4pYXCa6g=;
	h=From:To:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=kzG0VN/rNKUmrxDgkoqoq18YVxYGyXcUAuCy5x0bPf7XzCzvT7NGUE318KGaZrttemlCBSd7YvR2guQFO+FMtd7lZpywEcmaycOYGcmmzu0wxSOmMOHswP480+E7Q+4yuNqY7LbwYu22uUt/URx2z8ZMs0X0zb8X8/qWgPEuXyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PJyLQ3FJ; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QIhKvr009468;
	Tue, 26 Aug 2025 22:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=gofja3l7/3XRhStLWI2BO2pvPmo9MYwUHBN4pYXCa6g=; b=PJyLQ3FJ
	8UV4jnovs24EHntwTj4TJDljLRgWpHbGY4GDv1wPSxiALHKRoxrlQd/zHWG7IJmj
	PcBV/pBavYeMIVcOVIWFqBhYCOvCGNuiAk79yjjD+kgXVLb6ZIQGPy1qzbQ87Cxr
	SS+CSfmpu/wfz2Lx1lEJ4E2qhYK4QyTMEyOy/wA3ucDKAPtwN5puiyL7f8Y8VtDY
	PMGFIbaxL5OV6zttkMG9otE+gKtjdVwILNs0ipiQDvfZx7XvrmJp4IY58Mu8Bbi9
	r+QhMj6gipyqhaQ843GYQ+ou7mWxeiabWNFs6kiDHmn2K6tkcHDiGCj4+1t2b+mn
	Quc/VP5uTjdFXw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q42j16nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 22:33:49 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57QMXmqa010539;
	Tue, 26 Aug 2025 22:33:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q42j16n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 22:33:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UT2RySDpEEHrFNO+2th1LXVurqVO5h5Q5o4JkH7h75M89HSjD0T2MzJ7z7uhW/v0+EP26FkCYwrTp13B87mYfLEwexb9UujfQZ8OhzIzgP05AyASYMdm3UKRaXwQyO+T7xXnOEZ/5owziydRcSq760KZKw7lTUHUhDayGYKjlrMLLxWveiQiLv4PoEbSkCvfmfIgJ8CNjerrqTkzfaeNafsGPNlH6uWZjD1jrwAwaW9VsUuTq6Non3+xqWPmGs46pqJGSEULO+AKGc3qbGCsoUiVRJF2q7Bjvo1aRr0it4BzJfDCLKQ/q2DWG39NmRbku+eHZVIZzCZ4IiDgxTOsMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gofja3l7/3XRhStLWI2BO2pvPmo9MYwUHBN4pYXCa6g=;
 b=Mb+t69CE1IY/v1yG8RvgMQWQI6vDjZRIOasRazKUnGoyhH/dGGhFQyP8nlSPY0yjoIDqEK8DoBWmSi7nSgceo1tYaYqkxg6D3g4mNJ7xkgZJFQg7wKET2P2UfRxEL3k/T5UDhieAWbdIWSjbNrxJX3xw3wZw81mOQXimIbxqfue9VFKyrrJ8qNjQvT/Z68X+bHc/7fG/B6OrCS7zzsjehAWu9WhARTguwKkgEWqNnV0k/1gQYMMog0jUKWf8jTfb4bEg8SkZN5htxPxFS1oGF8w0y1q8JDrs17TFzUye3y8Li77Rwkmkdu9p8vF4a0MfKC7Xrg5a20Q5eMACmGcwAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BY3PR15MB4884.namprd15.prod.outlook.com (2603:10b6:a03:3c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 22:33:46 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.9031.023; Tue, 26 Aug 2025
 22:33:46 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "brauner@kernel.org" <brauner@kernel.org>,
        Patrick Donnelly
	<pdonnell@redhat.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        David Howells <dhowells@redhat.com>,
        Alex Markuze <amarkuze@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH 3/4] ceph: introduce
 ceph_submit_write() method
Thread-Index: AQHbfyUJV+HgPSNl2UGP49ZlSz2c/LR2rRGAgAAHm4A=
Date: Tue, 26 Aug 2025 22:33:46 +0000
Message-ID: <c2b5eafc60e753cba2f7ffe88941f10d65cefa64.camel@ibm.com>
References: <20250205000249.123054-1-slava@dubeyko.com>
	 <20250205000249.123054-4-slava@dubeyko.com>
	 <Z6-xg-p_mi3I1aMq@casper.infradead.org> <aK4v548CId5GIKG1@swift.blarg.de>
In-Reply-To: <aK4v548CId5GIKG1@swift.blarg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BY3PR15MB4884:EE_
x-ms-office365-filtering-correlation-id: fe6d1a62-83b4-4b5d-d213-08dde4f09ef9
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|10070799003|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?bFF6WDMwbEd1Smt1UnJHSnhiQjlabGZua1dXVko4OW9pMldIbklqbmJzL3Ns?=
 =?utf-8?B?VDBPYmZBREFLT2d5RWpXSmNHVXA2RUIvQmtFdE5qRmhSaUphMU5RaUdET1NI?=
 =?utf-8?B?dmFxQTdBUXZuZGhUaVFxZm1PeFVrajBSdWZ0ekdzaGc3NUJvUGJ0RmVTR0tn?=
 =?utf-8?B?Q3NXcjF5Wkx2TW5USVE1VkQwWXBXZFl5TGpZb29DYTZHZUxxT2ltRXZYL3Yr?=
 =?utf-8?B?bk12UDN1SExsSEhOWEJneU9iVkZXQ29oS0dQK3J3ck1oRlBKRzBsWUYvM2V1?=
 =?utf-8?B?alRZczczaUdKUk9YMjhyY0xvNEI1RVFHMytOVTZ5aGx4aUl3SndoRGdraHZr?=
 =?utf-8?B?Wjl6dXIzSCtLdlVMV3lYQ1cxdDNrUTBNbzBhV2RCc0xkT2k3QkkrODg2ZkFi?=
 =?utf-8?B?N2NoU3RrV2lXYW43UG9odVJvWVY2K3hnRVdxSmZUUFgyNVBqSTBMTGQvRWRZ?=
 =?utf-8?B?aU0xWTV3U3QrbzB2ZDB1bFB4MUwyYUJNRi9yRnRJdG5mc2VYUzJOeVN1bWtv?=
 =?utf-8?B?SlpoV1hZM25TeEM2RlVnOEs3Nng3RFFrWkU3ZUpKK2dkVHd1L0hpUDlYZEJs?=
 =?utf-8?B?WGlUYXBKbVFrM2RXdi9Lc0J3aWRvRjRwaGR0KzI5Q0NjTWhxM2t2aGppLy9H?=
 =?utf-8?B?c1UydXRPRCtBNThoT2RJWVVRMjZTeXhyckZ3cGVEUW81VlFyRHVsbzBPMVBJ?=
 =?utf-8?B?QnVXNklhRTZYZ3QyUVZDKzdxaDVuM0docVJDN1RybnZ6cjUxRllyYUU3dW9O?=
 =?utf-8?B?cUJIekN1akp2aW9ZNkdVNHM2TWhaNmREWWptUkRvWlNGOXNNR2Y3ZjZZaUt3?=
 =?utf-8?B?SzVYWlNRUnV3TytrRVB4OXVkOU96c0Z6QXM4YTJvYmtDM2RLZkxPbURLSGVO?=
 =?utf-8?B?VUZlYjJCZGY5UWY5ZzdWdGN5MkJ6M1g0YnZKT3FLZURYQzVOT0pDRkpjRGRw?=
 =?utf-8?B?MlNtZ2c1cGlmSm1KRmN3SVkxUldxOVA1c1lrNFppWUdTQjU5T1lQSjdqYjRO?=
 =?utf-8?B?UXNYS1VaZFVSS3NudUtXSmh5WVNGYXJBRFgwcmNYclVFak5KR0ZQS050dElE?=
 =?utf-8?B?eHN6cy9scWRkeHkyQ1JIRFZueGpkK2JwSDlyNW40SWVnZ3cxaldyZ0l5WXJx?=
 =?utf-8?B?OEZnR2JaQlBDNGhMUDZsSXgxQTFYbFRmc0t2aDh3ejJhd1J5dDhra0RKNjMy?=
 =?utf-8?B?a2FvcFpiUTRPZ2QyUU84YnZHd2p3M2lyYzVtcUErT3dWbC93WlBrK2dOWHVj?=
 =?utf-8?B?cTdEMEZOT3oxUWZwZUFvbmVhaUdGQ21WeWxRbXNldHFURm5Mdk92a3ZsVStR?=
 =?utf-8?B?Q3E0bWk3SjQ0dFlEN0p6MFo2VWg1MmxJNWpBYmh3S0FnTVZ2b0FPdk9KTEFa?=
 =?utf-8?B?RDk2dUFUenFCWjF2MVNKNk1Hb0ExbExFYno3aUE3d3N3UWRkOTdGclpOTVhs?=
 =?utf-8?B?NGZtcVorUkMwWFJCVUtsaWxLdDBHaWx2d3E3d3dBcVRmTlVWZmhWVUo4Vms4?=
 =?utf-8?B?OThEZ0ZEQXNCRDc0RGl3Unk5Q2JRc0ZDY2tXRXlseVVWUXJTR1M3d0tMOFpM?=
 =?utf-8?B?bUdpcHFvNGptVmdlT1lZaVp5WGVDSWhINWlhNi9MeXYwOEZ3K3lvMHVEWm8r?=
 =?utf-8?B?cHNQT1UrdkZMYk5RYzhZRXltMDJyK2h1aytXM2R5K2dVS2ZsUkhHeEJyOHl3?=
 =?utf-8?B?N0duVkQxQ3MwUkFTdm1XdGNKZUo2ZHVFWUttNGQxd0xRbE84bHcvY05sVnNE?=
 =?utf-8?B?UjhOTDRIcnBLbnJHeEFwSW13U1VobmhFZTZlNCs4dFo0VzA4aStjRUxWK1hZ?=
 =?utf-8?B?Smc1MlZmZWIxNmtMQ243aU85L2dDM2VDb0ZvMWh2eTF1RmFNckNrZkl0MUdo?=
 =?utf-8?B?NDhqam95b29tZFM4WFNZQ0xhaUN1SkswWnpsZ21oWEM3NkVOSUJkT3R0cHJI?=
 =?utf-8?B?aXBMdkgvcnlEMExTU3pFd0hVMkgwbWdyQWpMRGE0b3dvSUVYdXNCbG5HUy93?=
 =?utf-8?Q?6nR49U1dVoTOisvAqaemwtxUb2eyrU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(10070799003)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3JCd2dJaE1HRG0rZ1hCK0pIRUdYd3QwNEw0dVRKeS9TQ0ZTZFkyL2Y5eTV0?=
 =?utf-8?B?Ym00dEFVamIwL0t6NXUzTEdPVGk3aUVjQk1TQmR1NlNWcis4S1d4Yjg3c0sv?=
 =?utf-8?B?M0xEc1dDVkF1aE82aW9TWVI1eHBvTElCOUFDSGtNVDJKcVdEQTdQT3AzbitW?=
 =?utf-8?B?OWNtaWdTRkE4c3lCMHlJTlZlN3VFWTdDQlRBRTV0Ni9scEYvTlgxQ2N4enFl?=
 =?utf-8?B?L05OcnJVS3A0Q053QTBrZFJNczRpMFJGL0Q0UnBnYmIvQTRHMHBQWTE1dzAx?=
 =?utf-8?B?RUtMOTZ0NWU0WTZkd3FpdHJkelRVWEk5S1dKNEJYaHVocjJ2NTkzL1NrQlV0?=
 =?utf-8?B?Wkp3eWNKeWhEK0UvVjQyYjdPbmpCYWEyNVpKTHFyaC9wRWdtK1lkeTcrclY5?=
 =?utf-8?B?RWU4QUNVb3Y2YUhZVDk0SjF2ckhnMDRrZFBkV3VHcU8rZmJCY21mM1liOUhr?=
 =?utf-8?B?QVovTGVmdWl1emxZV0JHRzFiaWptWnAvSndqZUNRcVVPL081UlFzUXJ1ckdO?=
 =?utf-8?B?eW91OVg4OVg4R2Z6WXlRQzlMaGZVZG1aZmJGbDl2cHRVaUxxd0pmZm9mbkpD?=
 =?utf-8?B?dmdrdVl0akJkemo3QXVmMm1uMWR4elFqODhpcGdhenEzTC9jM0prYkNVYlVp?=
 =?utf-8?B?NmQrVXk1czhORGZMQXhpWmNwdUVTRnpuMXpxckdMb3kwSGFlUU0rWFlDUXYw?=
 =?utf-8?B?SDNDNXVOZ0JrU1oxR29TT0RaaFVDN0NQZk9scTRkdEJJUlpjMjF0R3R6aTAz?=
 =?utf-8?B?Y2NNaE8weWd4MjlJWXk4bkxDa1dmeXhBUkZQeHlqczV6ZndTcEgrMnQwTlVO?=
 =?utf-8?B?QS9uYVBpUWI4ZXpNODlKNWFaOTM2WVAwREY4cHZhdVlDWkV1REtRbTVvS2NW?=
 =?utf-8?B?Y0Yvb2h6NVFxKzJpRWt0c3ovbkdGZVdtaXYyMVNNUHphem9mczZ4NzFMQkdD?=
 =?utf-8?B?ZC84YUN0VElncVVySGRGWkVidndydGlZY2JpMmw2OUJUSE5KanVJODZzZyto?=
 =?utf-8?B?MVVVa3crT1hjUnhla1VhNzdhMVB4RXZYVGFIL0tMNFRTcUQyZnJxcks5MnB1?=
 =?utf-8?B?L2cxUGt1M3I1U3dQUlJBcy90cHljMkVpSDVmNEpCV1lrdnlYOXU1RzJSZnk2?=
 =?utf-8?B?ZVFodFNtdUdqV0Fia0EvYjRZWnZvOUhRdnJTMU5KOVRTdGd3WTJWcVp2YlNP?=
 =?utf-8?B?Sk9xZ2pzYkVKTGx2R2F3T0x4VHRBZVJOcy9YSXRSY0FHTURXSVVXV0hiQWVz?=
 =?utf-8?B?VFlUMmRBcVowb2FTTUtDWndacm02K0p2QU1OOFkvRzh4MWRQS1JDdkJCUVgy?=
 =?utf-8?B?MXJoQjRULzl0TXYydmowU053T0EyVzNyOTdhZ2gwMmpGMkVrL0NLOVVmK1Zk?=
 =?utf-8?B?K3BGdkJxb08xU1BEOTBGcVU3OXV0UG9MT1AxV2hETEZnbTdha0taMWI3RHIv?=
 =?utf-8?B?ak5JWnZ3eDY5NTZsajhFQSs0Y0VjaVZNbzY4bE9ZNTV0MC9JZDljN3BhQnFk?=
 =?utf-8?B?S3JaZmJnQm9FdjlTbFJ0Q0tNWFpkc2lEd1FES2hsRnhwQUU0eFVUZTQxbjRK?=
 =?utf-8?B?cFk0OGxnNGVVamFGMFF4cXo1UHZscSs2TzJvcTFmdUVXZk93cmdUKzZtdVJu?=
 =?utf-8?B?QW81T1RKNnV4VlNXY3U1K1MyVS9GOU1ldjFKNE51OVArZ1lTRFBsVE9IN0s3?=
 =?utf-8?B?Zm1MbTZyd0RaTHJHMlNvZkJ1N2ZNd0RwTnpIN0w4WmpHbS8vMm1ZMHI5ZVhv?=
 =?utf-8?B?QTlZaXNiNkdSK3RmUGY1Wm0rMnhLZW1NTll3dWRxamRhUWxTems1MUR5WkpD?=
 =?utf-8?B?LzlwVzBud2dhSVI3RGFXS3BNOXFwS3E5VnZsNFdObmNQSERtUGt6aStXcWsv?=
 =?utf-8?B?a3poTXNmejNqdEZoSmxGWENDNHcwenh1Mmpwd2RNWDBSdVNEa21jWE9VOE5t?=
 =?utf-8?B?eWN3R3pRNDBSUGx2ZXhtM2xBV04yeVd3K1U3eWc3RDgvRmEyRUNRaWd5MTVS?=
 =?utf-8?B?Ymc2N3hqTWpmWEVYZHhKSlRQSTc2aHFpdy85RHBRZjhPQmN4dDJYUWtzMTZ1?=
 =?utf-8?B?S0pWdUo2VHQ5d1NpbmJrT2pTZklzS2JYRkZhUTNsYlpETmhvTmZWZE95OC9J?=
 =?utf-8?B?dDBNdEZjdUhRR1o0cE9LNGJoaUZ5Ky9nQXprTjJPVUtJdlNMU3U0L0xIRVl3?=
 =?utf-8?Q?G53NfcVTwXnJPwIIZP6C4IQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EC6D968A7A63A46BD6DB55C9E004128@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6d1a62-83b4-4b5d-d213-08dde4f09ef9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 22:33:46.6491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AaoqEiAt6ZO2afA/FcZZdbmXdcQH5vIw7P3zfCfmOrJnAhR08Bz5mcVLDDcjeBNCLGfr2IzKqRB6prNs7PARiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4884
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMCBTYWx0ZWRfXzxO7iX4ZpQLy
 3LnNGHWxuGHZFDFt+jIF+cX07tZocff5mSrNRrwgPyPLSdhHV4JtGuUvBZxzOZZZqSKEF4NtMAl
 T6jPodzlV3mpr3Yt10AgKuc6vKfUBcuPCv9guNHBdvaIHaJEfKFyiopUa6SaMJUJCMsXkq+QCyA
 0SStqtwuu1e7+WlG6KZzsaHcVNG3Vq0YFME/PizjIV/jSa4+Ps6Sc28QyNUfai/E9KyfMx5sjB+
 Q36DXcDMMT3X5tCvA4taRzcQVB5Sh989l65xyuwJuUyrpjQA26+CrIHe8edpOaiou2pBtsU1CUa
 g139E6QYR68dK7C+phYddYlJ42rT7uZ6NdkiAlt947J0TEtdS0+Iix4AN888NLeFqaLbsAkkFrJ
 ErdeZIY+
X-Proofpoint-ORIG-GUID: pXkwXnlFCP2HJ-A6_nCdwRxawBQn0R7J
X-Proofpoint-GUID: EQdVOgsk75d5ioeejopprpze6R1aXpFw
X-Authority-Analysis: v=2.4 cv=evffzppX c=1 sm=1 tr=0 ts=68ae364d cx=c_pps
 a=t7FPbsrzSg/TVobB0oTxVQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=JfrnYn6hAAAA:8 a=VnNF1IyMAAAA:8 a=od1cWFrPbYTxRdgSxjEA:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
Subject: RE: [RFC PATCH 3/4] ceph: introduce ceph_submit_write() method
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230010

T24gV2VkLCAyMDI1LTA4LTI3IGF0IDAwOjA2ICswMjAwLCBNYXggS2VsbGVybWFubiB3cm90ZToN
Cj4gT24gMjAyNS8wMi8xNCAyMjoxMSwgTWF0dGhldyBXaWxjb3ggPHdpbGx5QGluZnJhZGVhZC5v
cmc+IHdyb3RlOg0KPiA+IE9uIFR1ZSwgRmViIDA0LCAyMDI1IGF0IDA0OjAyOjQ4UE0gLTA4MDAs
IFZpYWNoZXNsYXYgRHViZXlrbyB3cm90ZToNCj4gPiA+IFRoaXMgcGF0Y2ggaW1wbGVtZW50cyBy
ZWZhY3RvcmluZyBvZiBjZXBoX3N1Ym1pdF93cml0ZSgpDQo+ID4gPiBhbmQgYWxzbyBpdCBzb2x2
ZXMgdGhlIHNlY29uZCBpc3N1ZS4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogVmlhY2hl
c2xhdiBEdWJleWtvIDxTbGF2YS5EdWJleWtvQGlibS5jb20+DQo+ID4gDQo+ID4gVGhpcyBraW5k
IG9mIGdpYW50IHJlZmFjdG9yaW5nIHRvIHNvbHZlIGEgYnVnIGlzIGEgcmVhbGx5IGJhZCBpZGVh
Lg0KPiA+IEZpcnN0LCBpdCdzIGdvaW5nIHRvIG5lZWQgdG8gYmUgYmFja3BvcnRlZCB0byBvbGRl
ciBrZXJuZWxzLiAgSG93IGZhcg0KPiA+IGJhY2s/ICBZb3UgbmVlZCB0byBpZGVudGlmeSB0aGF0
IHdpdGggYSBGaXhlczogbGluZS4NCj4gPiANCj4gPiBJdCdzIGFsc28gcmVhbGx5IGhhcmQgdG8g
cmV2aWV3IGFuZCBrbm93IHdoZXRoZXIgaXQncyByaWdodC4gIFlvdSBtaWdodA0KPiA+IGhhdmUg
aW50cm9kdWNlZCBzZXZlcmFsIG5ldyBidWdzIHdoaWxlIGRvaW5nIGl0LiAgSW4gZ2VuZXJhbCwg
YnVnZml4ZXMNCj4gPiBmaXJzdCwgcmVmYWN0b3IgbGF0ZXIuICBJICp0aGluayogdGhpcyBtZWFu
cyB3ZSBjYW4gZG8gd2l0aG91dCAxLzcgb2YNCj4gPiB0aGUgcGF0Y2hlcyBJIHJlc2VudCBlYXJs
aWVyIHRvZGF5LCBidXQgaXQncyByZWFsbHkgaGFyZCB0byBiZSBzdXJlLg0KPiANCj4gSSdtIHZl
cnkgZGlzYXBwb2ludGVkIHRoYXQgbm9ib2R5IGhhcyBsaXN0ZW5lZCB0byBNYXR0aGV3J3MgY29t
cGxhaW50Lg0KPiBWaWFjaGVzbGF2IGhhcyBvbmx5IGhhbmQtd2F2ZWQgaXQgYXdheSB3aXRoIGEg
bGF6eSBub24tYXJndW1lbnQuDQo+IA0KPiBGcm9tIERvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJt
aXR0aW5nLXBhdGNoZXMucnN0Og0KPiANCj4gICJ5b3Ugc2hvdWxkIG5vdCBtb2RpZnkgdGhlIG1v
dmVkIGNvZGUgYXQgYWxsIGluIHRoZSBzYW1lIHBhdGNoIHdoaWNoDQo+ICBtb3ZlcyBpdCINCj4g
DQo+IE9idmlvdXNseSwgdGhpcyBwYXRjaCBzZXQgdmlvbGF0ZXMgdGhpcyBydWxlLiAgVGhlcmUg
YXJlIGxvdHMgb2YNCj4gc2VtYW50aWMvYmVoYXZpb3IgY2hhbmdlcyBpbiB0aGUgcGF0Y2hlcyB0
aGF0IG1vdmUgY29kZSBhcm91bmQuDQo+IA0KPiBJbiB0aGUgZW5kLCBDaHJpc3RpYW4gQnJhdW5l
ciBoYXMgbWVyZ2VkIHRoaXMgaW50byBMaW51eCA2LjE1IGFuZCB0aGF0DQo+IG1lcmdlIGhhcyB3
cmVha2VkIGhhdm9jIGluIG91ciBwcm9kdWN0aW9uIGNsdXN0ZXJzLiAgV2UgaGF2ZSBiZWVuDQo+
IHRlc3RpbmcgNi4xNSBmb3IgYSBtb250aCB3aXRoIG5vIHByb2JsZW1zIChhZnRlciBEYXZpZCBI
b3dlbGxzIGhhZA0KPiBmaXhlZCB5ZXQtYW5vdGhlciBuZXRmcyByZWdyZXNzaW9uIHRoYXQgd2Fz
IHN0YWJsZS1iYWNrcG9ydGVkIHRvIDYuMTUsDQo+IHVnaCEpLCBidXQgd2hlbiB3ZSB1cGRhdGVk
IGEgcHJvZHVjdGlvbiBjbHVzdGVycywgYWxsIHNlcnZlcnMgaGFkDQo+IGNyYXNoZWQgYWZ0ZXIg
YSBmZXcgaG91cnMsIGFuZCBvdXIgb3BzIHRlYW0gaGFkIGEgdmVyeSBiYWQgbmlnaHQuDQo+IA0K
PiBUaGlzIHBhdGNoIHNldCBpcyBvYnZpb3VzbHkgYmFkLiAgSXQgcHJldGVuZHMgdG8gZml4IGEg
YnVnLCBidXQgcmVhbGx5DQo+IHJld3JpdGVzIGFsbW9zdCBldmVyeXRoaW5nIGluIHR3byBwYXRj
aGVzIGRvY3VtZW50ZWQgYXMgImludHJvZHVjZSBYWQ0KPiBtZXRob2QiIHdpdGggbm8gcmVhbCBl
eHBsYW5hdGlvbiBmb3Igd2h5IFZpYWNoZXNsYXYgaGFzIGRlY2lkZWQgdG8gZG8NCj4gaXQsIGlu
c3RlYWQgb2YganVzdCBmaXhpbmcgdGhlIGJ1ZyAoYXMgTWF0dGhldyBhc2tlZCBoaW0gdG8pLg0K
PiANCj4gTG9vayBhdCB0aGlzIGxpbmUgbW9kaWZpZWQgYnkgcGF0Y2ggImNlcGg6IGV4dGVuZCBj
ZXBoX3dyaXRlYmFja19jdGwNCj4gZm9yIGNlcGhfd3JpdGVwYWdlc19zdGFydCgpIHJlZmFjdG9y
aW5nIjoNCj4gDQo+ID4gKyAgICAgICAgICAgICBjZXBoX3diYy5mYmF0Y2guZm9saW9zW2ldID0g
TlVMTDsNCj4gDQo+IFRoaXMgc2V0cyBhIGZvbGlvX2JhdGNoIGVsZW1lbnQgdG8gTlVMTCwgd2hp
Y2ggd2lsbCwgb2YgY291cnNlLCBjcmFzaA0KPiBpbiBmb2xpb3NfcHV0X3JlZnMoKSAoYnV0IG9u
bHkgaWYgdGhlIGdsb2JhbCBodWdlIHplcm8gcGFnZSBoYXMNCj4gYWxyZWFkeSBiZWVuIGNyZWF0
ZWQpLiAgRm9ydHVuYXRlbHksIHRoZXJlJ3MgY29kZSB0aGF0IHJlbW92ZXMgYWxsDQo+IE5VTEwg
ZWxlbWVudHMgZnJvbSB0aGUgZm9saW9fYmF0Y2ggYXJyYXkuICBUaGF0IGlzIGNvZGUgdGhhdCBh
bHJlYWR5DQo+IGV4aXN0ZWQgYmVmb3JlIFZpYWNoZXNsYXYncyBwYXRjaCBzZXQgKGNvZGUgd2hp
Y2ggSSBhbHJlYWR5IGRpc2xpa2UNCj4gYmVjYXVzZSBpdCdzIGEgZnJhZ2lsZSBtZXNzIHRoYXQg
aXMganVzdCB3YWl0aW5nIHRvIGNyYXNoKSwgYW5kIHRoZQ0KPiBjb2RlIHdhcyBvbmx5IGJlaW5n
IG1vdmVkIGFyb3VuZC4NCj4gDQo+IERpZCBJIG1lbnRpb24gdGhhdCBJIHRoaW5rIHRoaXMgaXMg
YSBmcmFnaWxlIG1lc3M/ICBGYXN0LWZvcndhcmQgdG8NCj4gVmlhY2hlc2xhdidzIHBhdGNoICJj
ZXBoOiBpbnRyb2R1Y2UgY2VwaF9wcm9jZXNzX2ZvbGlvX2JhdGNoKCkgbWV0aG9kIg0KPiB3aGlj
aCBtb3ZlcyB0aGUgTlVMTC1zZXR0aW5nIGxvb3AgdG8gY2VwaF9wcm9jZXNzX2ZvbGlvX2JhdGNo
KCkuICBMb29rDQo+IGF0IHRoaXMgKHVudG91Y2hlZCkgcGllY2Ugb2YgY29kZSBhZnRlciB0aGUg
Y2VwaF9wcm9jZXNzX2ZvbGlvX2JhdGNoKCkNCj4gY2FsbDoNCj4gDQo+ID4gICBpZiAoaSkgew0K
PiA+ICAgICAgICB1bnNpZ25lZCBqLCBuID0gMDsNCj4gPiAgICAgICAgLyogc2hpZnQgdW51c2Vk
IHBhZ2UgdG8gYmVnaW5uaW5nIG9mIGZiYXRjaCAqLw0KPiANCj4gU2hpZnRpbmcgb25seSBoYXBw
ZW5zIGlmIGF0IGxlYXN0IG9uZSBmb2xpbyBoYXMgYmVlbiBwcm9jZXNzZWQgKCJpIg0KPiB3YXMg
aW5jcmVtZW50ZWQpLiAgQnV0IGRvZXMgaXQgcmVhbGx5IGhhcHBlbj8NCj4gDQo+IE5vLCB0aGUg
bG9vcCB3YXMgbW92ZWQgdG8gY2VwaF9wcm9jZXNzX2ZvbGlvX2JhdGNoKCksIGFuZCBub2JvZHkg
ZXZlcg0KPiBpbmNyZW1lbnRzICJpIiBhbnltb3JlLiAgVm9pbGEsIGNyYXNoIGR1ZSB0byBOVUxM
IHBvaW50ZXIgZGVyZWZlcmVuY2U6DQo+IA0KPiAgQlVHOiBrZXJuZWwgTlVMTCBwb2ludGVyIGRl
cmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDM0DQo+ICAjUEY6IHN1cGVydmlzb3Ig
d3JpdGUgYWNjZXNzIGluIGtlcm5lbCBtb2RlDQo+ICAjUEY6IGVycm9yX2NvZGUoMHgwMDAyKSAt
IG5vdC1wcmVzZW50IHBhZ2UNCj4gIFBHRCAwIFA0RCAwIA0KPiAgT29wczogT29wczogMDAwMiBb
IzFdIFNNUCBOT1BUSQ0KPiAgQ1BVOiAxNzIgVUlEOiAwIFBJRDogMjM0MjcwNyBDb21tOiBrd29y
a2VyL3U3Nzg6OCBOb3QgdGFpbnRlZCA2LjE1LjEwLWNtNGFsbDEtZXMgIzcxNCBOT05FIA0KPiAg
SGFyZHdhcmUgbmFtZTogRGVsbCBJbmMuIFBvd2VyRWRnZSBSNzYxNS8wRzlESFYsIEJJT1MgMS42
LjEwIDEyLzA4LzIwMjMNCj4gIFdvcmtxdWV1ZTogd3JpdGViYWNrIHdiX3dvcmtmbiAoZmx1c2gt
Y2VwaC0xKQ0KPiAgUklQOiAwMDEwOmZvbGlvc19wdXRfcmVmcysweDg1LzB4MTQwDQo+ICBDb2Rl
OiA4MyBjNSAwMSAzOSBlOCA3ZSA3NiA0OCA2MyBjNSA0OSA4YiA1YyBjNCAwOCBiOCAwMSAwMCAw
MCAwMCA0ZCA4NSBlZCA3NCAwNSA0MSA4YiA0NCBhZCAwMCA0OCA4YiAxNSBiMCA+DQo+ICBSU1A6
IDAwMTg6ZmZmZmI4ODBhZjhkYjc3OCBFRkxBR1M6IDAwMDEwMjA3DQo+ICBSQVg6IDAwMDAwMDAw
MDAwMDAwMDEgUkJYOiAwMDAwMDAwMDAwMDAwMDAwIFJDWDogMDAwMDAwMDAwMDAwMDAwMw0KPiAg
UkRYOiBmZmZmZTM3N2NjM2IwMDAwIFJTSTogMDAwMDAwMDAwMDAwMDAwMCBSREk6IGZmZmZiODgw
YWY4ZGI4YzANCj4gIFJCUDogMDAwMDAwMDAwMDAwMDAwMCBSMDg6IDAwMDAwMDAwMDAwMDAwN2Qg
UjA5OiAwMDAwMDAwMDAxMDJiODZmDQo+ICBSMTA6IDAwMDAwMDAwMDAwMDAwMDEgUjExOiAwMDAw
MDAwMDAwMDAwMGFjIFIxMjogZmZmZmI4ODBhZjhkYjhjMA0KPiAgUjEzOiAwMDAwMDAwMDAwMDAw
MDAwIFIxNDogMDAwMDAwMDAwMDAwMDAwMCBSMTU6IGZmZmY5YmQyNjJjOTcwMDANCj4gIEZTOiAg
MDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmOWM4ZWZjMzAzMDAwKDAwMDApIGtubEdTOjAw
MDAwMDAwMDAwMDAwMDANCj4gIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAw
MDAwODAwNTAwMzMNCj4gIENSMjogMDAwMDAwMDAwMDAwMDAzNCBDUjM6IDAwMDAwMDAxNjA5NTgw
MDQgQ1I0OiAwMDAwMDAwMDAwNzcwZWYwDQo+ICBQS1JVOiA1NTU1NTU1NA0KPiAgQ2FsbCBUcmFj
ZToNCj4gICA8VEFTSz4NCj4gICBjZXBoX3dyaXRlcGFnZXNfc3RhcnQrMHhlYjkvMHgxNDEwDQo+
IA0KPiBWaWFjaGVzbGF2J3MgdGhpcmQgcGF0Y2ggImNlcGg6IGludHJvZHVjZSBjZXBoX3N1Ym1p
dF93cml0ZSgpIG1ldGhvZCINCj4gbWVzc2VzIHVwIHRoZSBsb2dpYyBhIGJpdCBtb3JlIGFuZCBt
YWtlcyBpdCBtb3JlIGZyYWdpbGUgYnkgaGlkaW5nIHRoZQ0KPiBzaGlmdGluZyBjb2RlIGJlaGlu
ZCBtb3JlIGNvbmRpdGlvbnM6DQo+IA0KPiAtIGlmIGNlcGhfcHJvY2Vzc19mb2xpb19iYXRjaCgp
IGZhaWxzLCBzaGlmdGluZyBuZXZlciBoYXBwZW5zDQo+IA0KPiAtIGlmIGNlcGhfbW92ZV9kaXJ0
eV9wYWdlX2luX3BhZ2VfYXJyYXkoKSB3YXMgbmV2ZXIgY2FsbGVkIChiZWNhdXNlDQo+ICAgY2Vw
aF9wcm9jZXNzX2ZvbGlvX2JhdGNoKCkgaGFzIHJldHVybmVkIGVhcmx5IGZvciBzb21lIG9mIHZh
cmlvdXMNCj4gICByZWFzb25zKSwgc2hpZnRpbmcgbmV2ZXIgaGFwcGVucw0KPiANCj4gLSBpZiBw
cm9jZXNzZWRfaW5fZmJhdGNoIGlzIHplcm8gKGJlY2F1c2UgY2VwaF9wcm9jZXNzX2ZvbGlvX2Jh
dGNoKCkNCj4gICBoYXMgcmV0dXJuZWQgZWFybHkgZm9yIHNvbWUgb2YgdGhlIHJlYXNvbnMgbWVu
dGlvbmVkIGFib3ZlIG9yDQo+ICAgYmVjYXVzZSBjZXBoX21vdmVfZGlydHlfcGFnZV9pbl9wYWdl
X2FycmF5KCkgaGFzIGZhaWxlZCksIHNoaWZ0aW5nDQo+ICAgbmV2ZXIgaGFwcGVucw0KPiANCj4g
SWYgc2hpZnRpbmcgZG9lc24ndCBoYXBwZW4sIHRoZW4gdGhlIGtlcm5lbCBjcmFzaGVzICh1bmxl
c3MNCj4gaHVnZS16ZXJvLXBhZ2UgZG9lc24ndCBleGlzdCwgc2VlIGFib3ZlKS4gIE9idmlvdXNs
eSwgbm9ib2R5IGhhcyBldmVyDQo+IGxvb2tlZCBjbG9zZWx5IGVub3VnaCBhdCB0aGUgY29kZS4g
IEknbSBzdGlsbCBuZXcgdG8gTGludXggbWVtb3J5DQo+IG1hbmFnZW1lbnQgYW5kIGZpbGUgc3lz
dGVtcywgYnV0IHRoZXNlIHByb2JsZW1zIHdlcmUgb2J2aW91cyB3aGVuIEkNCj4gZmlyc3Qgc2F3
IHRoaXMgcGF0Y2ggc2V0ICh3aGljaCB3YXMgbXkgY2FuZGlkYXRlIGZvciB0aGUgb3RoZXIgNi4x
NQ0KPiBjcmFzaGVzIHdoaWNoIHRoZW4gdHVybmVkIG91dCB0byBiZSBuZXRmcyByZWdyZXNzaW9u
cywgbm90IENlcGgpLg0KPiANCj4gVGhpcyB3aG9sZSBwYXRjaCBzZXQgaXMgYSBodWdlIG1lc3Mg
YW5kIGhhcyBjYXVzZWQgbXkgdGVhbSBhIGdvb2QNCj4gYW1vdW50IG9mIHBhaW4uICBUaGlzIGNv
dWxkIGFuZCBzaG91bGQgaGF2ZSBiZWVuIGF2b2lkZWQsIGhhZCBvbmx5DQo+IHNvbWVib2R5IGxp
c3RlbmVkIHRvIE1hdHRoZXcuDQo+IA0KPiAoQWxzbyBsb29rIGF0IGFsbCB0aG9zZSAiY2hlY2tw
YXRjaC5wbCIgY29tcGxhaW50cyBvbiBhbGwgcGF0Y2hlcyBpbg0KPiB0aGlzIHBhdGNoIHNldC4g
IFRoZXJlIGFyZSBtYW55IGNvZGluZyBzdHlsZSB2aW9sYXRpb25zLikNCj4gDQo+IENhbiB3ZSBw
bGVhc2UgcmV2ZXJ0IHRoZSB3aG9sZSBwYXRjaCBzZXQ/ICBJIGRvbid0IHRoaW5rIGl0J3MgcG9z
c2libGUNCj4gdG8gZml4IGFsbCB0aGUgd2VpcmQgdW5kb2N1bWVudGVkIHNpZGUgZWZmZWN0cyB0
aGF0IG1heSBjYXVzZSBtb3JlDQo+IGNyYXNoZXMgb25jZSB3ZSBmaXggdGhpcyBvbmUuICBSZWZh
Y3RvcmluZyB0aGUgQ2VwaCBjb2RlIHN1cmUgaXMNCj4gbmVjZXNzYXJ5LCBpdCdzIG5vdCBpbiBh
IGdvb2Qgc2hhcGUsIGJ1dCBpdCBzaG91bGQgYmUgZG9uZSBtb3JlDQo+IGNhcmVmdWxseS4gIFNv
bWUgcGVvcGxlIChsaWtlIG1lKSBkZXBlbmQgb24gQ2VwaCdzIHN0YWJpbGl0eSwgYW5kIHRoaXMN
Cj4gbWVzcyBpcyBkb2luZyBhIGRpc3NlcnZpY2UgdG8gQ2VwaCdzIHJlcHV0YXRpb24uDQoNCk9m
IGNvdXJzZSwgd2UgY2FuIHJldmVydCBhbnkgcGF0Y2guIFRoaXMgcGF0Y2hzZXQgaGFzIGJlZW4g
c2VudCBub3Qgd2l0aCB0aGUNCmdvYWwgb2YgcHVyZSByZWZhY3RvcmluZyBidXQgaXQgZml4ZXMg
c2V2ZXJhbCBidWdzLiBSZXZlcnRpbmcgbWVhbnMgcmV0dXJuaW5nDQp0aGVzZSBidWdzIGJhY2su
IFRoaXMgcGF0Y2hzZXQgd2FzIGF2YWlsYWJsZSBmb3IgcmV2aWV3IGZvciBhIGxvbmcgdGltZS4g
U28sDQphbnlib2R5IHdhcyBhYmxlIHRvIHJldmlldyBpdCBhbmQgdG8gc2hhcmUgYW55IGNvbW1l
bnRzLiBJIGFtIGFsd2F5cyBoYXBweSB0bw0KcmV3b3JrIGFuZCB0byBtYWtlIGFueSBwYXRjaCBt
b3JlIGJldHRlci4gRnJvbSBteSBwb2ludCBvZiB2aWV3LCByZXZlcnRpbmcgaXMNCm5vdCBhbnN3
ZXIgYW5kIGl0IG1ha2VzIHNlbnNlIHRvIGNvbnRpbnVlIGZpeCBidWdzIGFuZCB0byBtYWtlIENl
cGhGUyBjb2RlIG1vcmUNCnN0YWJsZS4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=

