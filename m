Return-Path: <linux-fsdevel+bounces-46643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDE5A92CD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 23:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 139497AD8C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 21:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1111B20E310;
	Thu, 17 Apr 2025 21:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mko+9ySO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08A51CEADB;
	Thu, 17 Apr 2025 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744926406; cv=fail; b=ZKiz4l2IEOKftZHdX/qSgyUct6UxZz4z/f3BdgM6Y4Q9mxBm8kaHKWeCANQrJ55VIfA7HXMURMUwH3+GmzL3Cu0YiAp5fh10iQbNi55Qo05irDdDB2gnyWoaSRnkXOWs2xhAi2drdRhEendbnaZUnFXxnaqMSKfWEBe8/r79+oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744926406; c=relaxed/simple;
	bh=pU+vYXz9pIBTLvfD7icFi7eG1mtNXyC3qyi24iXH//g=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=CCLwSbjesFRzbs9Dj5vlUqmFZJaHw9qWxxs3ltY+ob0limJefsFAAwjfmw4cyncVSetDMmveCaL1zsaE7Br/NYGrqdTMMPCBlzqTtg2ltjdpnCg4hf31itU7falaL6vGR9PaaXC3w/dHI9yoLx3RiXF6kGHAEonCOHTaX1aj28g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mko+9ySO; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HLYAT4031522;
	Thu, 17 Apr 2025 21:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=pU+vYXz9pIBTLvfD7icFi7eG1mtNXyC3qyi24iXH//g=; b=Mko+9ySO
	0VlnN1hEBls3v8/8WcL5O/H5hnFz7PJIvSzmBQJjukE/NS2AfhZjYIMcvVzTSgtu
	6mz06IDKFJJdJjYiRgkTbPKbdMmHwKJDdiKjJglaAup8UcTfTxYEp5sXI6d2DWSv
	k9DGiV4DPCkkiwJnMqCpDdzNql5BQT+jyzsuDozH/e9aqcjlRvNl3A1oEFbB8YXP
	RiQLKvCJBOPiin1W0ih9AUFovSjGTpWUyAJhGfaKSUjHMSPtihPhFWT8tVobHT1Z
	1nF8U1nz+wuabK2nPXI7psuEpnRqZh4Z12sQCDMAAqh/T79lamNVfGk5FG5l593J
	uysZhg2sj/po3Q==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462yjjb92e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 21:44:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oY47nRAswn1a4xaRdCA97wsXkbJfOmDlcV+JfLvgviXKTn8zAl4iVIsgeEFq+Y76nACWikUwceXzhPNS7uC4/hBWikJe9bo0XiF/Fzr4XI1OFF3eUD8D5E0Q5DR/xHrWIpcokUBFUu4Z/8UYzrkaq2LkeRPovpiHTZfw9Z37EU6JyY0EVHsaHgK9oAor04so+x51uzeo5ZM1Xphp0OuS86TdK74uqAtekqh67HbUUPrCx9p8WjOwT9OC7AS4fw/yWdbY7VLZVbRMBaUwSNjSvGjaPuOWJNNn3HGJrfl9Ng33x13dDdMVVBUD9WWk2M6ySGRT7woMR9dKijLSv30W8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pU+vYXz9pIBTLvfD7icFi7eG1mtNXyC3qyi24iXH//g=;
 b=BtI+xxP3P4djbBoaVEUp4xcQOnnqOip19D1rx8iWdRJ9SBTV8c48ZJw8W0oFFDeRCggem2DHse1gOqV8o8WJ+bIL3Tq0+AUxgPMlm/f4ECyt/em5gXlQgaYtmzKTJo2jm/ATPYqpeo4HPAR399NnosR4sNGHnJdIe3suGsHPUPJkTYCtrJsaPJUVsB9eXMAppd3mO2m+K6Fax1sORrAA67DT3A1g4Sn/6TARgv2KHb+Qf3T1eEi3+NphJqyYW+8cMKWJsjv3taij1IqaLDdjS+4b3kk0+0zIaVc18vP/OSApj6TP3XfMxLf73ct/UYmH/ogfy7ZNjSor+UFwdgp6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BL1PPF97109ECA9.namprd15.prod.outlook.com (2603:10b6:20f:fc04::e36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 17 Apr
 2025 21:44:49 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 21:44:49 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org"
	<brauner@kernel.org>
CC: "jack@suse.com" <jack@suse.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "sandeen@redhat.com" <sandeen@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org"
	<torvalds@linux-foundation.org>,
        "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>,
        "willy@infradead.org" <willy@infradead.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfs{plus}: add deprecation warning
Thread-Index:
 AQHbrhWWXaRwwnXSdkukdsi2+kZKRrOl1QqAgACQ7wCAAC+YAIABBJgAgACRlICAAAEmAIAAOtSA
Date: Thu, 17 Apr 2025 21:44:49 +0000
Message-ID: <5e5403b1f1a7903c48244afba813bfb15890eac4.camel@ibm.com>
References: <20250415-orchester-robben-2be52e119ee4@brauner>
					 <20250415144907.GB25659@frogsfrogsfrogs>
					 <20250416-willen-wachhalten-55a798e41fd2@brauner>
					 <20250416150604.GB25700@frogsfrogsfrogs>
				 <4ecc225c641c0fee9725861670668352d305ad29.camel@ibm.com>
			 <0e27414d94d981d4eee45b09caf329fa66084cd3.camel@physik.fu-berlin.de>
		 <6fcb2ee90de570908eebaf007a4584fc19f1c630.camel@ibm.com>
	 <1d16c046a5c9e1ee83f1013951d77d9376d8fb64.camel@physik.fu-berlin.de>
In-Reply-To:
 <1d16c046a5c9e1ee83f1013951d77d9376d8fb64.camel@physik.fu-berlin.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BL1PPF97109ECA9:EE_
x-ms-office365-filtering-correlation-id: c7d55db4-9d68-4099-54c3-08dd7df91442
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bU1aZW9FV3gvSU92RFY0bklWRjhaWGEwbE1qdGJWRHhzeDR5ejJ6U01VT0hL?=
 =?utf-8?B?Vis1ZTBVU2lRcEZwb01JeFpReWRXbnhLSHV5cklvbmx0d3NjamZjVDJCMHRR?=
 =?utf-8?B?SkVDbnR6VDFpUjIzdUt6ZWZhUGc3RHVPTjc5SktoUXV2aWNiNk1ib0hGV2li?=
 =?utf-8?B?eE1yRG9FOGhGb005QmY1T1BaY2xwR2JaenFqTFVheHlwNlRNUzY3NEE1TVox?=
 =?utf-8?B?T3Jzd011QUxuS2piN0VtZk1INnNmTEFFOGJMcTlVL3E1K3pCaWRsNVNqSVg2?=
 =?utf-8?B?bVA4VUplVTJwaktaTE0vNWtlcjFGM0NTSnRPZmpDdlFtZldOQVhRVUpOZmRo?=
 =?utf-8?B?aGZxT3dRNHVNNzhaVktBT3lOdjM0K3diY2ZFNlBxMmtLQVYyY01NOGNkRnZH?=
 =?utf-8?B?TDlXZVJ2ZFF3Y0R4aTV3aEJOQitDdnppUG4yUUFCRUhHU1hDMmpUTjZpV3hB?=
 =?utf-8?B?ZEFQRlhhVm9Wd2hldk5kVTdHZ1pLeW1DaStiRHRnWU8vYVo1Z3orMXB4elE5?=
 =?utf-8?B?dFVpVXJvc0RjMVh1ZEwwdld6RnhTZVc2enBMcW5pTU1BV0lwV3lJT0Y0UE54?=
 =?utf-8?B?VkxZbmpYYUlsaFdLNXpVT1RJUVVJajdDOE1CcWlBZmJtUSttQVhmNGx6MVZy?=
 =?utf-8?B?NG5sditESEJvR3paa0pLQXY2cG5BRUVDa0plY2lKZWdqdzVXMmk0dEV5dndC?=
 =?utf-8?B?L2FUTWxqWHBGN2t3MjNObkJxZm1BaTE3WGtGVTdkUTdUWGhSeXdJWVppb2dx?=
 =?utf-8?B?dVgwS0lrVUtYNk0yR0hDWnczQnB6UkpmSDhVWHMxaHdsNnZVaDh5U2RNazdG?=
 =?utf-8?B?L2JMWWQxQmp6S0NyNldobTY4b3dFV1VrNWFvYWNoWm9rTGtnSmdRZWh5amJZ?=
 =?utf-8?B?TDZDNkpaSlRrU1dySVRDV2JWR3p3Ykc5U2kzRmtnWm1lQTIzQUtPK0syYXVC?=
 =?utf-8?B?bUV6azFoM0JWdUxGc3MxdW1VL0tLRm15QW5oTXZyYjhGSWFpYWlPRy9zUjRI?=
 =?utf-8?B?YjAvM01GYngvKzFvemY1U1F1dU9xWHd4eGRnMTZQcVpLZkdHZFQ2YVVmNU81?=
 =?utf-8?B?b05hR244UTNnVlRtT0xvaVZzRThyVk43R1l3bnJkVGorc0I4VDd1a1ZzaWRI?=
 =?utf-8?B?OC85WktjTUpWcTFnWU5NK3RtMnk1cjNQUVAwM2tsYlRONUwzK3FLdE9zaHVU?=
 =?utf-8?B?SVdWbE14TnR1bzVyRGlZQXlpSFFPR0R2dWlhY1h1OWEvVFMxSFNjaUFmK0pS?=
 =?utf-8?B?VlppQUdUQ1RkMTdzSDdoRHJWaVpETFA2TmxaZi82RDlGbEl4MzBhb1BpV3Fs?=
 =?utf-8?B?UW1JdEhxbFQ0R2FlWnVYSXQvaFpmaWlmK2ZlUy9rOXc0dUpYVlJJbnA0NXJE?=
 =?utf-8?B?TEx1RDFrZjdJWGoySWFTOC9nYUk5TmxHenZMb2wrMFJBdC83eXdMSjB2KzRY?=
 =?utf-8?B?aFFrc3VHRGxwRnVLc2U0UTQrRzhRTXBCTlZhTmhUeG55UXJueUhpQUp5SHFu?=
 =?utf-8?B?M0NGSUZxQVQxSGJUOWJMZUxGTGFHQ1VrWEZncXdDNkpRaEtMb2huNFhyMnpn?=
 =?utf-8?B?V1NwbG1nTnAyc1NEanJEdG1GWjdVME5DeDRwVVhWNHhQTklzamFaRWVKTmRy?=
 =?utf-8?B?Ulc1WWNoQUtIMjg3T0s4c21QdEt1TG81R3YzaDdXaExOWlNDcEJlNmJNK2xm?=
 =?utf-8?B?SEwwM1hqbWRpTm9CZytNUWRMMm02Z0daYTZQS1gwN0hQcVg3dEF6dkV4TUpa?=
 =?utf-8?B?N1hrKzh4aXAwQjJpbUtFbjV4dnlFb3FRL0p6YzNxd1g2YnZXK1hJZWFpUGtZ?=
 =?utf-8?B?bllKOVppL1V6STlUcHl6eDlJc1paK2Z5U0VhVlBWc2h1UDR1MCtETWtEb2tu?=
 =?utf-8?B?Q3RrN01VM0JVWFdKVFdZRkNsOGcxWXppZVp6ZFhzSmwrVzRucUE5RDBFODBD?=
 =?utf-8?B?bGRpTFdDVkh1aHBiM3Bia1czTEJEQVZhOU82Z3c3dHBiK053Skk3ZTc3UlBi?=
 =?utf-8?B?VlpMNmZrUnZRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXNKQURyQkhxSW5YUnBEUTBNa2pQS1lsL3p1WGFzTXRFbU9qTGM3bEcrQWZQ?=
 =?utf-8?B?NDB6UnZqQXY5TWV1c2xxbkZwVFppZjc1QTJ0VmJpQnNiZW5WY2tLL0RxWGtD?=
 =?utf-8?B?NlFlcHQydHdkeGpSVWc2V1NYUmh3TDhXYUFyOHVHZEg3eGhEOFRRWnVyVFla?=
 =?utf-8?B?M3VFeGw2L3ZuTkJoYjRUUXNXMkxQQkkwUTVXaldGYSt0MHo0MG9kUDdINnFP?=
 =?utf-8?B?TXRNNFFlSDhQV2lFWHhMLzFtUHVveW9hOTVWMk52cDI2RWZRTEh5YjV6OVRo?=
 =?utf-8?B?bnlQSUlUWFRiYlRKeTMvS1E5ZEZGT0VzY3pjQjhVMkxYd0JPWnA4Y1Z4QUtW?=
 =?utf-8?B?Y0pBOVU4M3poVTJOM0hMVDdTWVBrRnV1bElCOHhYOXZaUVBvZ0xsQmpTUGhO?=
 =?utf-8?B?eFFqTm9SdThrUE1WTXlTcXdTN2krcWM3YkRMbmtrWG5mU0FpQnYvZ29pUkZL?=
 =?utf-8?B?NTNuU3hZVkd5aUJrdkRhbEZsVVBwL2taajgvUGNncmpYVXAxYzF1VzU5MmF6?=
 =?utf-8?B?ejYwc2hIdis0TXlIbWllZW13UDNVNkVIdHZOSGVUSXZ2TVBhM1BxWXRBSVlq?=
 =?utf-8?B?OUdPdVAvYjltOW5NaHBYZlcwYk5hdEZUVVIwcVRheEg3OHZJYUFKaDVoYjNi?=
 =?utf-8?B?RDdsOWRmVTIrUGFkb2k3a3FrTEh4enNOTDBQaXVlTEJia3dNWktxcmoyT0VK?=
 =?utf-8?B?dkVsUlh3RUVjVlNVQzFZUEFPczhEbmh6VjZKRzZFK2RKazh4T1dRSzEwRzJL?=
 =?utf-8?B?UEJmOVRPR1dNN3g4ZVdzM3Y0dXhIL2ZYMnBkckpYbmRaYkNSYWNoaC9rUHNm?=
 =?utf-8?B?T2ZWTTNrQno5bXNySjZWaXVvZS9HaHpFa0p3YWZHeHo2b3FoSEFFdlpFQ3JR?=
 =?utf-8?B?Um9peG5iZzZyelBQRUhvcEFhVGFoT3lYSytVTnBESmNmU3JROCtJdnVwRm5Q?=
 =?utf-8?B?WnRjL04wamRYeVYzTFdWb2k3SDQ3VGVzaUFIM2I5OXdVeW45NnpNVVVWYUw5?=
 =?utf-8?B?aEdzVjd1ajBuanpOblhPZytOWEdGK0p5UmIwODcwc0JQSy9VWC9Ib0RkUDND?=
 =?utf-8?B?cEYrZjRrZFFHckpZKzI5QWRUTzJwS05OVElkempsWTN6UUs0cW1pWVBrdnAz?=
 =?utf-8?B?alRsOWpVM0dDeFQ0MDlBWUI2MVI0ZXN0TkpzL01OMGhCOTBNOFA3NDZ6TjU4?=
 =?utf-8?B?c1pLRVhnd2ttcnlMSk1KeVFPcml5cGlMeW1XUFJMbW9wMTZGVnNVL1ZMeFlu?=
 =?utf-8?B?ME1sMStpSlRPSmtBT1NIamdqWUQvby9BbVZyVkNCRzVzcWt2WlhmdGQ5V2M4?=
 =?utf-8?B?N2NGeXJlUllzSkRFKzNLTWJ1ekxCTHpsZkU0K3Y1OFgrTGpSck5yc2RZSXI1?=
 =?utf-8?B?UmkxYktqV2pucERyVk1jd3REOXJYZWlYZk1welFxZEMyNzkwaWpnQTdmcElO?=
 =?utf-8?B?M2o4Q2F4UEd1Nm1YNWZiQWVHalJlK29yZWJWc2JuNDg3Tm5TV2c0cTB5RnMx?=
 =?utf-8?B?OXJiQmV4ZG9KVTZsSm8rdzBLaDN3SDJvRmF2azR1eFdmZU9wQklYRXdiVm02?=
 =?utf-8?B?bjlQc2RiY3J5cGprM1NvQ0NpVklIM1YvUTQ3OFloWGJzMmJKS2xiL0lramc4?=
 =?utf-8?B?SXZCNkk3Mk80YlJWSjZCakd1Q3NJNmNyZi9Jcll1ZWp4dUZqbXVobnp4bzll?=
 =?utf-8?B?cjBpT2kxVkJhN3JQck5BNUh2MlQzNmQxN1VId01VOExjZnlhOUhWcWVqU2RB?=
 =?utf-8?B?dDRDOEhEakljcFlKdFZYcGZvdjRFTUNoVGxFeEIzUWtOWlAwT1M1bkhIQkpG?=
 =?utf-8?B?Vm5idUVsTGlSYVNBVzl3OHYrM1I2dDdlclVUM1FaYVpyekxvUWZScDdFYlFU?=
 =?utf-8?B?ZXF1YWRPT2dHOXd0MjZuNXNxV3lYZFNINnppak5yNjRKSHV5RWpvN1lnbHB1?=
 =?utf-8?B?TFEvcXEwUUlXSTliQUhCNVo0QVBVSU9ua2VGVUZzdDdDRTF5NTFQY3pWVTBq?=
 =?utf-8?B?YXRJSTlaeU5XNXpsUGw2REtxb1h4aHM2UVVvQzQ0OUltcUllVjdTKzdTL3Ay?=
 =?utf-8?B?WVVJOFpHWXlCdTZ2ZUdsd1ZxSjZza3M5cUk5cE1BQStRNzgva0p5bHQyb2E0?=
 =?utf-8?B?dXZlWXQ2b3IwRjBwcUQxczg3aklqWjZPRDNwbU04MlMwSkkzN1I4UFcrRnUv?=
 =?utf-8?Q?tawNrRYwaOSiRoRa4GMY2Uo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE9F1E46DE7E7842BF1D1D1E54969DED@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d55db4-9d68-4099-54c3-08dd7df91442
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 21:44:49.6477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K65MJM51xNpA/4EBkiLWkoG0UXqcMtPD+/2MvOuYuhXtuzPYXzmCdbtW/wHU0byHBvUZdEOauIzhIyz4XxzTow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF97109ECA9
X-Proofpoint-ORIG-GUID: zOosj7d-4MuD63KWxirwbvpnIKrR4f9g
X-Authority-Analysis: v=2.4 cv=MsNS63ae c=1 sm=1 tr=0 ts=68017654 cx=c_pps a=PK5aExQQjalka8oDlC/sVA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0thV8z8ouDnOtpEuCUIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zOosj7d-4MuD63KWxirwbvpnIKrR4f9g
Subject: RE: [PATCH] hfs{plus}: add deprecation warning
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=743
 suspectscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170159

SGkgQWRyaWFuLA0KDQpPbiBUaHUsIDIwMjUtMDQtMTcgYXQgMjA6MTQgKzAyMDAsIEpvaG4gUGF1
bCBBZHJpYW4gR2xhdWJpdHogd3JvdGU6DQo+IEhpIFNsYXZhLA0KPiANCj4gT24gVGh1LCAyMDI1
LTA0LTE3IGF0IDE4OjEwICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3JvdGU6DQo+ID4gU291
bmRzIGdvb2QhIFllcywgSSBhbSBpbnRlcmVzdGVkIGluIHdvcmtpbmcgdG9nZXRoZXIgb24gdGhl
IEhGUy9IRlMrIGRyaXZlci4gOikNCj4gPiBBbmQsIHllcywgSSBjYW4gY29uc2lkZXIgdG8gYmUg
dGhlIG1haW50YWluZXIgb2YgSEZTL0hGUysgZHJpdmVyLiBXZSBjYW4NCj4gPiBtYWludGFpbiB0
aGUgSEZTL0hGUysgZHJpdmVyIHRvZ2V0aGVyIGJlY2F1c2UgdHdvIG1haW50YWluZXJzIGFyZSBi
ZXR0ZXIgdGhhbg0KPiA+IG9uZS4gRXNwZWNpYWxseSwgaWYgdGhlcmUgaXMgdGhlIHByYWN0aWNh
bCBuZWVkIG9mIGhhdmluZyBIRlMvSEZTKyBkcml2ZXIgaW4NCj4gPiBMaW51eCBrZXJuZWwuDQo+
IA0KPiBPSywgdGhlbiBsZXQncyBkbyB0aGlzIHRvZ2V0aGVyISBXaGlsZSBJJ20gYWxyZWFkeSBh
IGtlcm5lbCBtYWludGFpbmVyIChmb3IgYXJjaC9zaCksDQo+IEkgd291bGRuJ3QgY2FsbCBteXNl
bGYgYW4gZXhwZXJ0IG9uIGZpbGVzeXN0ZW1zIGFuZCBJIGZlZWwgd2F5IG1vcmUgY29tZm9ydGFi
bGUgd29ya2luZw0KPiBvbiB0aGlzIHdoZW4gdGhlcmUgaXMgYSBzZWNvbmQgcGVyc29uIGFyb3Vu
ZCB3aXRoIGV4cGVyaWVuY2Ugd2l0aCBoYWNraW5nIG9uIGZpbGVzeXN0ZW1zLg0KPiANCj4gQ2Fu
IHlvdSBzZW5kIGEgcGF0Y2ggdG8gdXBkYXRlIE1BSU5UQUlORVJTPw0KPiANCg0KU3VyZS4gTGV0
IG1lIHByZXBhcmUgdGhlIHBhdGNoLg0KDQpUaGFua3MsDQpTbGF2YS4NCg0KPiBNeSBtYWlsIGVu
dHJ5IHdvdWxkIGJlOg0KPiANCj4gSm9obiBQYXVsIEFkcmlhbiBHbGF1Yml0eiA8Z2xhdWJpdHpA
cGh5c2lrLmZ1LWJlcmxpbi5kZT4NCj4gDQo+IEFkcmlhbg0KDQo=

