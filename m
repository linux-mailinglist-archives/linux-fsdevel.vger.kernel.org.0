Return-Path: <linux-fsdevel+bounces-40257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 529C0A21472
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 23:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C46718841AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 22:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3205F1DF731;
	Tue, 28 Jan 2025 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mU2eF9BN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CD318FDD2;
	Tue, 28 Jan 2025 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738103736; cv=fail; b=jPGmo/nGKSLDQnQ1zY6+CczVWlP5uwb5acxc3A5iZnxnuRzPWA5QLJLbWN+CU7lsOPBhKIdwlxjxOwR8dKEibRW+rliKeiyFB6aBh1Og7mAM4pgfJSRfC6okPq/7XOZGYddUYT+mSsqSop9wZwOY67QCq1Qc4qUlbEutk0Tl1lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738103736; c=relaxed/simple;
	bh=KN272VN4/VTa0YqXWW4uWQJTYd4H+/tWNq8ZNevElfU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=OMnUYE9kK9sX6wVVYrOzHp7ol3Lv6UZ1Cx8fGx0bfxGlKViQxloIgqfhh5h9CrQKGv5Uz0kFmrpcxHXisIM6I1eSC3U9+qy4im16+OP8TMhhdAJ6Le5Myz1TeDI+MiPMkgYyaMA7k6n+fYGYXgr5gzp0OpDVdNBczXlYNg8ND1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mU2eF9BN; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SFxKrL023582;
	Tue, 28 Jan 2025 22:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=KN272VN4/VTa0YqXWW4uWQJTYd4H+/tWNq8ZNevElfU=; b=mU2eF9BN
	QZZEzKZwZhrROUgr6L4pFrDioU3Nz1YX9jUPG90/idnEAzHDJzPN42piK57VPmfw
	5NziaX6AC2c/kW77BDFIRYwhwGH1eR7s3VYcfeYXfNtfVmQ6Hdw6oaCsG5S3KbZC
	1LFZ2tin40Ay+rkVyX1DwdBFEZexgScieRyb2IZq4bl7h9yslXLs9yn/M856kV3Z
	cH2t//5HCQMs0X0wLfbAs1YEPYz2KOD/umGWyRjhUGMaLrdgRdlbpBRS2giwkgeN
	zle82DjcaldXWduAvoHvC/7XjVqRLYeyLIpCMOQtAt8Oe2X095VMmpeL3HC++gcj
	/yl3hYEpj3RjGA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44es27mpcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 22:35:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwVPnYmt3mlu2DQjkuBMWqyzDZjKQ109uS4kezA11n7ZNcifboCZzXmng6OOu9JRs4rZvvnil/BkOFxVMIrEccgYTD4TVCmTEHrDi2KBZCgN5MVxUAangNoYDgKT2AFBLLHpc8hq/j4TYNaKUuDP8NEMQXTlkruOQKPA3VnNq0fUujcepn6uCK8qZIA+9qViBDikiSfctajkyEsW984oYsMUR5M0jOK/kvT9vYfCwDvDaEAsIvTv71JzDfWbW/sl96CAC0GRvfeCD4xyY4Ui7Pmfpsf/+d15llyNWtmHN6dlucAqVtOcIG7hlIq02y8Hv+AbdNoSrPdpGbtb50wd1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KN272VN4/VTa0YqXWW4uWQJTYd4H+/tWNq8ZNevElfU=;
 b=ULSV1ownxVV/KdXIvSkHHhvkJ+ZnF/+kmCpU2TTwxKRh4wiee6p5qx7ID15oQ8MzORW4Lf/zeBoEVaenDnYMfYBw6sZm22WsyvT5Lqu0RqvbtdFxbskgv7ixGCn4/xUK0Un8wF9tLkVVnKhhV176rwxzSsgEsSOQG0jkLBD6Ge3hZyB6953KdcCJRQcCm+m1cC6Da7DzfahUQdicJjWRmG7NoW/QnJjpS45WVJO6n3dq6g97eJJ/101klwhMk8TXWNWosEga5PzGWZmLUQoZaCdIEW3Ru+CAEiZLLe3C97mRxPRdTs4R3MIyaxqfIJ81QgP66FAC2lkTFt1Wud29tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA0PR15MB3840.namprd15.prod.outlook.com (2603:10b6:806:8a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.24; Tue, 28 Jan
 2025 22:35:23 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 22:35:23 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "Johannes.Thumshirn@wdc.com" <Johannes.Thumshirn@wdc.com>,
        "hans@owltronix.com" <hans@owltronix.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>,
        "javier.gonz@samsung.com"
	<javier.gonz@samsung.com>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH] Introduce generalized data
 temperature estimation framework
Thread-Index: AQHbcWMAKmbJmSPeLkiOdnUnzZZuZrMsxxCA
Date: Tue, 28 Jan 2025 22:35:23 +0000
Message-ID: <2583d29cdac09b831e4299248234fe2633a6f45e.camel@ibm.com>
References: <20250123202455.11338-1-slava@dubeyko.com>
	 <fd012640-5107-4d44-9572-4dffb2fd4665@wdc.com>
	 <f44878932fd26bb273c7948710b23b0e2768852a.camel@ibm.com>
	 <CANr-nt2+Yk5fVVjU2zs+F1ZrLZGBBy3HwNOuYOK9smDeoZV9Rg@mail.gmail.com>
	 <063856b9c67289b1dd979a12c8cfe8d203786acc.camel@ibm.com>
	 <CANr-nt2bbienm=L48uEgjmuLqMnFBXUfHVZfEo3VBFwUsutE6A@mail.gmail.com>
	 <8369d108-7f11-4989-863f-abccac45c322@wdc.com>
In-Reply-To: <8369d108-7f11-4989-863f-abccac45c322@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA0PR15MB3840:EE_
x-ms-office365-filtering-correlation-id: 587d1f26-5101-4fbe-6ccf-08dd3fec0e13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WFZVa0VRdmNoWWtwcnlXTUI5RjFQbDNUNjF2YmxFclJUUDdUSTh5VStkYUR6?=
 =?utf-8?B?cVJKZWMxL1lwclBueFBPbGUwTWR4MVJNU3g4aitpajFQMWN6NGtNdTk5TDdq?=
 =?utf-8?B?MUh0Vk9IcjhNbHkvNDdpYjQxOVVsTlFjdmx0Tm45YWNzWmNGbHdNQzRyY1oy?=
 =?utf-8?B?eG51UXM3Q2ZGbU9Ya0xhWFdUSTBqanJhQVZ3b0NCeFhiQ3V6dlJxUU93MG16?=
 =?utf-8?B?U0lBTDB4SHF1RE1EelFtYk5DUnc0ek5PeFBUekpqTk5NRDVIUzMvT08xTDBN?=
 =?utf-8?B?bFBzRWZvUEprQkFzVURaeGRsR0JvUWtJd3NIQnIyZXRPZ05KbkVpSnpjMVEy?=
 =?utf-8?B?dk96SDF6aDhaTEgxNGN5K2dRaDduT3hJL3ZDSkNXaDVOYkR3TzBxdFZ6S0Fu?=
 =?utf-8?B?dWNYbEVKRlptS1g4ZmJ0Wko1ampIMnJhQzJNeFhSekRzSXFRQnBhTXZMWmds?=
 =?utf-8?B?UlZNbWpjL2pjSmRjcDg2aVorN2VTQTRyZlM1WlJLbXNGREs2S2R0ZDNVS3NW?=
 =?utf-8?B?OTMzZktTTDJ5MlhBRFlabGV4SklYYVQ4dEE3QVcwdmswWTZ1Y0o1RmNyYW5S?=
 =?utf-8?B?dk5ORFVBQVRJOXdZLzZsaHJZK0dwVnhNb3Z6ZDgwUDNRQjF6TDVkQTl0THV1?=
 =?utf-8?B?MUpRdGRKUEJLVjYxRURaN0xwMjZsTjZpZmlSNk94L3Ard3dVaUxkOUxkTjgw?=
 =?utf-8?B?MlV2aDNrclFKYjEyS3MydzVaMDhSTlhQYWpFNWFnMzZ5U1BoQnlEbFMzMkFO?=
 =?utf-8?B?OW9pWWV5RWQ1QUFaQTFramF2TG1oZkRIR0FsK2JqT1N6UVh4aVRQTmdncHhz?=
 =?utf-8?B?azR5REJ4enpxU2FFZ3FQM05ZeXZLMzR2TGNOc0RHOTMzcUpwSFkwYndQUzdv?=
 =?utf-8?B?d2NMV2lHM2tRcGVIK251bEtGN0VGNjJkaFpMSVNhMzQyeVRFeXNCY0JSSFZM?=
 =?utf-8?B?SEQ1U3Y0UDNtUXJ6NHB4TDVBT1MyMzdNUEhKRllxL1V1R3lkYk5MWEdBbEhB?=
 =?utf-8?B?bUFPazJhNWpyc0t4NFQ5aFFQem9IK0E2WWM3Q2VkMStta3pzalJZWFhBMmo4?=
 =?utf-8?B?em92dTdGK0VEYkFETlhMYXRLWVcyWllFRUFzWnVDSVZOZ25LclFORlFSOEx1?=
 =?utf-8?B?VDkwa0U0UDRoVmtKV1BEblU4MHY5VWVQakpaVTg0OEJNVVA1dVZ1MlpxdVVY?=
 =?utf-8?B?b01TNWlxaW94Y2M0NGxPUkdRdHV4U1BTbU9WNElDUU1rdUxiQ1BVOWljUjh3?=
 =?utf-8?B?QzhuZ2F1WktzRmVNNSs5ZnIxYnFJQlo3c2hLNGxPZDgzb3hOSnBRWmd3NW93?=
 =?utf-8?B?MzAweVRUQ2s5THBQbHdhbk1nSUo2bkFkQUErb1hZL1BVa0pXcTI4d3dsZERN?=
 =?utf-8?B?OWhoQkZqUXBxL0REalNnSVBIVmUrUnhiVUJBSFlpZS9DRlRXUGorWDhHellr?=
 =?utf-8?B?UFdZMFl2UUNxdGJ4UmMzZnMyUDFjMWpNOWJkWktWWFBaVVJ5WjNFcmw3bmJu?=
 =?utf-8?B?UERqSWFmOHR0d2NCa2hha1JGemd6aEFleXNvVFpZNHNBSnVBajRlMVIrYlJ0?=
 =?utf-8?B?aGtYelV6RnNCL0lWQktDblRHUklNYWllZExEQ05DY0RhOWtiTTNscXJkYVZS?=
 =?utf-8?B?L0pxYitXUTZVZEtoc2NtZ0Vyb0JUSDZnTXlVVVpSQXk5S3AyWktBdithemkw?=
 =?utf-8?B?UHNiUmQ5cDluSUlMbWtlVm9FMXBsZlA0TUVMT2ZKeTYrS05YSFNSNnpVTjlS?=
 =?utf-8?B?dU1GbUNJekRyK2RmOGdxSEN0UG10dUR5SGtLOUhoRklRakYvdUZzUndMZ1lY?=
 =?utf-8?B?dXhHTWlNZjU1dVVydjVpSWdzUVQ1NUZyREpudEU2Ky8vZGo0ekhIMWdFRHov?=
 =?utf-8?B?TmRVdThlNjV6YStYWksrQWo0bXRnMWFWNDJvMVoxUm5xQ3gvTkx1dnV0eFhI?=
 =?utf-8?Q?MbPZ7lYC1O/uQZ6qDeJpFx1FOHZZFIJC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFVPdWxST0t0cDllVjhSR1hJbGlvUkFWTmZkWnFKcUNGMVBMbVo2K1A4dFlq?=
 =?utf-8?B?ZHdDQjNJd2hRN0dTa1lOYlZKdHBqNC9lS3gzS2NkeHZxTGhqbDRVc2p6cFlR?=
 =?utf-8?B?Tk10eGM5eENJRGdIdjZWU2w2eVBLT0Z4aU1VaGpkS2Yvem9oblR3QTVXMXhV?=
 =?utf-8?B?TzVEbEFNZXpGNEMvZE1WaFBwcTY2bHplQTU5Q2tEQXl3UWRjSmxiOXNVV2N2?=
 =?utf-8?B?cWorUFNyM0dnRWZtdkRoMEFhbVViRWlEQkFpVndTMDliaHlsandacjhkUkZv?=
 =?utf-8?B?cXNGVll0TFpiOGROcTBBNWd0bFJtQ0JHRlZRdzB1aks0VjU4VG1kb1JWZnBu?=
 =?utf-8?B?dkJjeGEwY0hsQTE1YXF2RWFkTkVjckVVQWY2L1VTeE45Y01SYi92NWdKUHo0?=
 =?utf-8?B?UUtqeDJITElkZHY1b1FGbTVhYnZEYkZoRUFXSXpLa29aMytDWThIK2pYcmhZ?=
 =?utf-8?B?S01MV2hrKzJlRzRCUHBBaDZzVVkrb1NWbTZpU1BmWHQxT2F4SGtzUWJsZDJx?=
 =?utf-8?B?WmpvQk9Ha0YzSzhPeUVWSm8wTjVqZm5xT2RaM2dPVG9uU3VPTEEwbmxVNkxE?=
 =?utf-8?B?SzVOUlpKSzZiQWdrbS80UHNRb2VGSDVTa2E5NFliRkl3V3JSbllqc1h5dGZN?=
 =?utf-8?B?bUhETWJLOGhlZVVhYW9HWnUwY0RRekp0TmlRM0t1bkt1enZxQ1RYZmswQzRa?=
 =?utf-8?B?SnJXM3lyeVk1dHM0UlFNS0J5U2wyclZ6NnE2bVZDczNldTJiZmFzN21Eb3dE?=
 =?utf-8?B?YnUyWWMrcGt0ekFINmFUKzVjNmNvOHljUXdNNG4xa3JSRkMwSHROOVMxOXZ3?=
 =?utf-8?B?d0JvUHNDblJUVmxaR0p1OHBkdjcyOHhJYzQwdkN2WVdvUi9OdDRkZGhEUFN5?=
 =?utf-8?B?ZXN5Ly9iUExvbTNzMFR1aE92MVl5Tmwyc0Q4OGN2eCtKMCtrZUZiVXZ0N05l?=
 =?utf-8?B?SWRTZFptZCtYQlcyOHZZdEtLcnZhc3htTkdJZ1FYUjVsa0sxUG9nbkZDa0xC?=
 =?utf-8?B?Vkl3Q2V2RExYUHo3ek5oWDdGRnFWbDMzdERkYklQK0pnZ2RUcG5LZkpJYjZz?=
 =?utf-8?B?a29sS0FKQ1JvZW5ML1ZzY3NDRGR6TFViU3BqVjArN3c1aXh1NlR1VjRMaENl?=
 =?utf-8?B?cHpuZ2hjZDdDcktMRk5FUDZBNXZ3OXpxbDRGaDY5KytEQTNvbGxoYzJxQUhG?=
 =?utf-8?B?cThUYkFyOXE2cjJ0aHRGUHhDOE9qSmU1OVh2R0dSWURUUk5Uc3pLQWErY2do?=
 =?utf-8?B?SVZ0ZkJ6dzNWVlZhYUs3NU1QUnUzNW83ZHZaVHlQTkZsUHpOSFljU3J3ZkhF?=
 =?utf-8?B?Rng5cXNBdmxFUXdQcWwxZHNlMnVCU2NyejBCK2FsdnVEdDBhZkFrTkdBV2E3?=
 =?utf-8?B?ekZ1ZnJhc1g0OUxyOHBvZFY1RTRQVkdITzZmNHRDdG1vYzhTV2Z5VEtBeEVi?=
 =?utf-8?B?VklJWE94OHo2bGxnRTU4d1hqNkovcXRjT09GdFZUWTNRR1hDeFRWc0U5MHpq?=
 =?utf-8?B?T3pHL1laR3RqdnNaekhZTXJPalFSckNoUzM1REFVNWJvdTE4RjBndmR4M0I3?=
 =?utf-8?B?SGp2Y3RrbU5WRFdEOGxmT3NmTGFXM0Z4MmFrcFJuM0dWeTRUYWVuMTVqUkEx?=
 =?utf-8?B?ZmQzZnlIUmh4azdmLzBYSlE4UmtXcmZUTENRTFY4K1ZJNkVSQnEzNC9Ld3Vr?=
 =?utf-8?B?NnYxeEFmKy9penVvOTE2dHVwaHlNMS85Z29hM3ZlaGhTZWNFTVZ5UnIvbXFr?=
 =?utf-8?B?MHFDTU16cWJFcE9STUROOVYxelR5MURBR0FXcElaTkhQc1ZDMDBjZUpERWI5?=
 =?utf-8?B?UUJiVys5UVExd0xjTjZCZ2pvSVhTbmY2dTRkWUlaVkwwQk5ySytmU1pWWGNy?=
 =?utf-8?B?dFFGSFBmalQzUTJIM1p0NlVzK2dGYWJtOFdCdkp3RmJoS29sWjM0NlNMS1Vn?=
 =?utf-8?B?M3ovTytGVjlJdHVHUFFha3lUaDJPeXN2SXFGTnl5WUlxbGl1UStrRElQZmEw?=
 =?utf-8?B?djZQNklQR1RmQ2JmS2JVZnloRm5wZXJtZ1F0S1VVclQ2TzRrZld3aTZROHIr?=
 =?utf-8?B?VjdQRm0zNTBIYXE1YmJTdENwNng5MFBNbzR6Q3JENVprOUNhTmtSTE8zdm8z?=
 =?utf-8?B?TGNkV284eWt2VkdCYXU1N2g2aXExZS94eWpwWDNDRlFRNG1DNXAvMldMZ3pO?=
 =?utf-8?Q?CUbwCFDKRv8BdhAF3ZkxDZo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA569DDF651B5D4BA579626A45BA44A9@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 587d1f26-5101-4fbe-6ccf-08dd3fec0e13
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2025 22:35:23.7366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z+3JS6b0ugOIZ9SWPIadjbihapIUSXSPsmj8A7G2i4d2A9nrZ7J/Wqg56U9OYzsO1WMGQ7PAFPyZ4P2HuGgvoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3840
X-Proofpoint-ORIG-GUID: CHnvItvHd1NwdoAqscKitG9S6pcUSxDr
X-Proofpoint-GUID: CHnvItvHd1NwdoAqscKitG9S6pcUSxDr
Subject: RE: [RFC PATCH] Introduce generalized data temperature estimation framework
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=550 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280165

T24gVHVlLCAyMDI1LTAxLTI4IGF0IDA4OjU5ICswMDAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IE9uIDI4LjAxLjI1IDA5OjQ1LCBIYW5zIEhvbG1iZXJnIHdyb3RlOg0KPiA+ID4gSSB0
aGluayB0aGF0IERpcmVjdCBJTyBjb3VsZCBiZW5lZml0IHRvby4gVGhlIHF1ZXN0aW9uIGhlcmUg
aG93IHRvIGFjY291bnQgZGlydHkNCj4gPiA+IG1lbW9yeSBwYWdlcyBhbmQgdXBkYXRlZCBtZW1v
cnkgcGFnZXMuIEN1cnJlbnRseSwgSSBhbSB1c2luZw0KPiA+ID4gZm9saW9fYWNjb3VudF9kaXJ0
aWVkKCkgYW5kIGZvbGlvX2NsZWFyX2RpcnR5X2Zvcl9pbygpIHRvIGltcGxlbWVudCB0aGUNCj4g
PiA+IGNhbGN1bGF0aW9uIHRoZSB0ZW1wZXJhdHVyZS4gQXMgZmFyIGFzIEkgY2FuIHNlZSwgRGly
ZWN0IElPIHJlcXVpcmVzIGFub3RoZXINCj4gPiA+IG1ldGhvZHMgb2YgZG9pbmcgdGhpcy4gVGhl
IHJlc3QgbG9naWMgY2FuIGJlIHRoZSBzYW1lLg0KPiA+IA0KPiA+IEl0J3MgcHJvYmFibHkgYSBn
b29kIGlkZWEgdG8gY292ZXIgZGlyZWN0IElPIGFzIHdlbGwgdGhlbiBhcyB0aGlzIGlzDQo+ID4g
aW50ZW5kZWQgdG8gYmUgYSBnZW5lcmFsaXplZCBmcmFtZXdvcmsuDQo+IA0KPiBFc3BlY2lhbGx5
IGdpdmVuIHRoYXQgbW9zdCBhcHBsaWNhdGlvbnMgdGhhdCByZWFsbHkgY2FyZSBhYm91dCBkYXRh
IA0KPiBsaWZldGltZXMsIHdyaXRlIGFtcGxpZmljYXRpb24gZXRjIGFyZSBoZWF2eSB1c2VycyBv
ZiBkaXJlY3QgSS9PLg0KDQpJIGJlbGlldmUgc21hcnRwaG9uZXMgaXMgcmVhbGx5IGh1Z2UgdXNl
LWNhc2UuIEFuZCBMRlMgYW5kIEdDIGJhc2VkIGZpbGUNCnN5c3RlbXMgYXJlIHVzZWQgdGhlcmUu
IFNvLCBwYWdlIGNhY2hlIGJhc2VkIGFwcHJvYWNoIG1ha2VzIHNlbnNlIGZvciBzdWNoDQpmaWxl
IHN5c3RlbXMgdG8gbWFuYWdlIGRhdGEgcGxhY2VtZW50IHBvbGljeSBlZmZpY2llbnRseS4NCg0K
SSBsaWtlIHRoaXMgc3VnZ2VzdGlvbiByZWxhdGVkIHRvIERpcmVjdCBJTyBjYXNlLiBCdXQgaXQg
bmVlZHMgdG8gZWxhYm9yYXRlDQp0aGUgd2F5IHRvIHByb3BlciBtYW5hZ2UgZGlydHkgYW5kIHVw
ZGF0ZWQgbWVtb3J5IHBhZ2VzIGNhbGN1bGF0aW9uIGZvcg0KRGlyZWN0IElPIGNhc2UuDQoNClRo
YW5rcywNClNsYXZhLg0KDQo=

