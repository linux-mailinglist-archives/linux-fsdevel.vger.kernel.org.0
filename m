Return-Path: <linux-fsdevel+bounces-40174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A58EA201D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 00:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 462E97A2A38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 23:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B681DDC0F;
	Mon, 27 Jan 2025 23:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EmvLLoO2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE2A192D8F;
	Mon, 27 Jan 2025 23:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021382; cv=fail; b=FgiC5ihueGEt3hv1Mp/bEHtcqIqz1vCBw64VKNBxlZEZVRVc9B/H1dCbxx5ZORR6f2c3ekX5I868zmV9rOLzfBZwlu3YIn46uWpOlr7MLUSyWLIA+nfk3IBSezv62WGqZN5YQ/togEA31Av0nhS+G/o+/A03VIBzI6uxKccXqbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021382; c=relaxed/simple;
	bh=/4pqtaw2V7ublEKHLOdr8hgo4MhKztnlV3+VClVWP2c=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=SsuRSuR1smk1ubfjBmef5uUyZqRpvgFqdEOl5XuyIRoa+nzz/lU7n2W6cRo3n7UsF+BBf1BuiZna5w5y92PZ65UlJsnje/4iJ4MVhiiFq6kcie9AIzcgcUwCNt3sB3L2VqbDHNvllkjwizoYm/PIS9TWgqcw6fdTPlXKl2LutIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EmvLLoO2; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RLIS9d018731;
	Mon, 27 Jan 2025 23:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=/4pqtaw2V7ublEKHLOdr8hgo4MhKztnlV3+VClVWP2c=; b=EmvLLoO2
	40ggNbasI2LRE6E1IuNM1aE6etDuGjVh4Sp0fl6ATLnqRDcf3ao79GPl5qZzzMGq
	68KSCWppVybpTxuUMHz4CwOLzxCd2cABG9ON3ezou5r7RzepKW+AOWQCIgO4v/Y4
	1qg4kudd5VomnHMbT2ZqzGTHjgQgP31q+ddpVTVKTtezwAXHxW8VNJhL8A0eVXfc
	To7r/XxC2CH4EWXmm7bErFl16LbFuePlAkYXO9wN8yRZQ9KMZVe47tagz5Q8cpU3
	1BV00uPZfad6OtoIng1bvYM2jHXGBx4Ta/qOLMwMgC5DBnhTiI0PZFT0/OirFZOM
	CqynmaTCGcxsxA==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ecyt9xg4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 23:42:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYbda6r1lpDuofdIacRnzh2N5WVlG0T4nz8cEjxTCI2kRQzEW0CJcDOYlFIXLmOz81E8UNrhej2uSqODdYv+GYgfagMLeFtax7YJY8a6c3CI0d4NDtRFftl8jxdP96fViruusHubvQtStUmv/QJY1lOb+fxImFV48nT++VlnHWDv1dyBCd924JGwpTNZgrSe/xH3V6FHZPkR+KPszFFRCzaRLRmtEvTB1z4bJO6Ou54xkBenAOtrTcvU8eRhQfBezTZEclsQkJ4RWq07uuA3+gitKn5urrglX4t1u/eSlMHW2aCwAEfx0oTt64IMawmuiU0hHsWxu/gJFlo2a+1qOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4pqtaw2V7ublEKHLOdr8hgo4MhKztnlV3+VClVWP2c=;
 b=KrDjuW9ZQdy8k5EXwHly+LAL+9OC1IuqCzM7a6Vw3CejRnE3LLSW3w3S/ouRRmGq9XG0tbA6M9EPrevgSvT22fgZ/c/0Q2Ff6PrPBRhdFeF17m7GVLVKo44zNpWQM5J3xWx4DNvbwZShc0GU0opHjug2mDngpaM+ZY9uXRDTrvT5JoclLSQT0Vc37tyVoE9lLrfRQavX3ONKWuZOqhMYVVdUsRLlUV1/PupC6RokCT0CWiGncxdPQ0GpfU0nSSe6gOkB/TKsdAhi2EtVSsdvF5YdfapWdvXAyGASG/Og7pZtRbFD9uUPhKr449bYsx9mBE+CkKcKK7qRBB5wQ+a1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW3PR15MB3852.namprd15.prod.outlook.com (2603:10b6:303:45::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Mon, 27 Jan
 2025 23:42:42 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 23:42:42 +0000
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
Thread-Index: AQHbbqDXiGJ8UXK5fEWDdER5m+EPkbMma7kAgAStjICAADPIgA==
Date: Mon, 27 Jan 2025 23:42:42 +0000
Message-ID: <1a33cb72ace2f427aa5006980b0b4f253d98ce6f.camel@ibm.com>
References: <20250123203319.11420-1-slava@dubeyko.com>
	 <39de3063-a1c8-4d59-8819-961e5a10cbb9@acm.org>
	 <0fbbd5a488cdbd4e1e1d1d79ea43c39582569f5a.camel@ibm.com>
	 <833b054b-f179-4bc8-912b-dad057d193cd@acm.org>
In-Reply-To: <833b054b-f179-4bc8-912b-dad057d193cd@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW3PR15MB3852:EE_
x-ms-office365-filtering-correlation-id: 627f21bd-9c7d-4d2d-9d94-08dd3f2c4b0c
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SDBXeUt6aHZVRFhzWnFrb0RwRkNadEFuMFpsMWltVS8ydjE2T0lxdkZWbk9r?=
 =?utf-8?B?MmROUThmYWF1N2lUZ21SRGR1ajJnQjNMekdUNkNSaDZLRTl4Z1FXVFh4OFZ2?=
 =?utf-8?B?SVFTdkdPZHRRbjdZbk5hdGpOY0t3Y1hzcmRyM3VTZ2c3MlJGeldVY21pdVhn?=
 =?utf-8?B?cURJY3VhSHFHUzhsMnAzSkxweExaR3lmbGNZbEJQdWxNcHJIbHpmRU15WDFa?=
 =?utf-8?B?UkRKVE1WVDRXWmZJQk9aeWRsd3R6UjlUaVp4VkhUTFFjSlc5ZUZPd1lwS2FB?=
 =?utf-8?B?Ym91a2VnQWNwNnl4UnlSSnVTanBJM3g3YUhhVWE2OFJNZElwVEI2SnpZOGFy?=
 =?utf-8?B?RWFjRTMzYStZdHM1QXZRY0RaektiZWp0SW5iaXdNMXlLdHpPN2ZUTndRS2F2?=
 =?utf-8?B?WkpwQ04yYmF5OGFTa0dlVzVRcm1YUlJDQ3ZXMFRhV3dTQVVoNlI3RFUrZFJQ?=
 =?utf-8?B?MlI1VW9JKzYvM296VlhxWFFOc0N3YzF1RjBrRTFkSUtvZDMzTVRsZWdwYTc4?=
 =?utf-8?B?OUhXVnN4a2V6aXBycHUzMVZ4OFR5bENXVW41SjJPSHg0SC84enZjQ0xTTTZY?=
 =?utf-8?B?Z1hLaDdVaW1ncHZ3d2RBMkVZRmNUeHZQSEQ0Y1JVYVJiRFg1Y3FQU3lrd2lX?=
 =?utf-8?B?ODA1UEF5WG5ZVld2bzJzc1lsc0ZWMjJxeS9ZMjNSUVB1blYxTjZEazFNV0tH?=
 =?utf-8?B?RlorSHpxK1JpZTVUbGRNbmIyd09rbGUvM0hKQlN2Vk9DdWNuNkFyMHdUb3d2?=
 =?utf-8?B?UmZmcjVpaGlDY2NXRjA1cm5vOHhnTm5kd3ptRVdObU1ra2IxSVR4aW8vU2tq?=
 =?utf-8?B?dnhpcm1vTERzS1puWHQ3RjRMTUhzSmRPbXZtOUJ5Vk83RXJJV2xGUFRoQWZ0?=
 =?utf-8?B?aHV0YnQ0UFA0bUVSQzUrTkUzcWVHaUhIR3RCclVTREZxejFTODRNOXdMclk1?=
 =?utf-8?B?UjBBT05lYWpUWCtEYTd0NXRwWmJjUEV5RHZnZ3VRZ1ptTkRXaFFybjRPZmx6?=
 =?utf-8?B?dU05RzNGVDNSVzFMNmVKZXZxSkhPSFJMR25uYXBuT3N6MGgxWlYxZjNTa1hl?=
 =?utf-8?B?OGJESERxdlRTZkp5RUpSb3oxRFdqNE9VT0xHdjJ4N2hIclU0RmZzWXRIeTVU?=
 =?utf-8?B?UmRrTXpWejRFWTNEK2NoWlhQdXJ0ekhHUWlGUWFzSG5Sa09reS9MUUQ3QzJO?=
 =?utf-8?B?bTNCRHZUQmtXMGFoRWRYcFBOS1FSbVJFWkJBNHdXRWFkc2xpQ3JQeEJGVVdr?=
 =?utf-8?B?b3RrOFNwY0F6UEVlWlc2OHRxMWVveEJPU1pHRnZKYmJ0NUxYS2RGTStKckM1?=
 =?utf-8?B?Tnk4RkRzWjllcmQ0RXljamh1YUpyOUtQcjNVdDB0UDFMamx2YXcvNk9xNitH?=
 =?utf-8?B?cWVoQ2ZDQUFIVk16andUOGZnNUVsdzFlOE5nOHhQNHVrdTZkWHFkbEZTeHZN?=
 =?utf-8?B?YkUvY2hidGlSSTJSQm9aNWU3Y1I0WGU2VC9mOTNMbFhjYk5vT1FqQmRGZDVP?=
 =?utf-8?B?aDdmYnQyVmljc1VqaGRXU0U4L3V3VTJjUTI3MVowZ1RHcVFSblhvUkFVS2Nm?=
 =?utf-8?B?Qzl0TVRlajgrU2FTUFRIUUFaNWtZTFRrL2ROcm1UTFdOWDN4U3lxS3JqQlRN?=
 =?utf-8?B?ZXVvb0pxV0dkdHJNYnJ6QTZwNmZwTjhlR25UVUE0TFhyMEFNODM5N1RoYjRx?=
 =?utf-8?B?anlNazNieVN4YWFvK1NFS1J4clhNWi9takpLN1J6bmtTOWtPZ1kzcjZpZkh3?=
 =?utf-8?B?M0g4RHFDelh0MG1jK1ZMRndLWjBrTzFMSWJKSXJzVFRldDdWUHRleHlaeHEr?=
 =?utf-8?B?TDYreTg5aEpvRUpJL3pWbFdSUElFUTZ6R1g3Y2o4ZVl3eG1DTkpPdS9oemhP?=
 =?utf-8?B?U2dWd0kzZFNKMzllcFBxUTI4aVpiUDVGOGVPVWlEN2xRN1M5VDcrcGxSZE5y?=
 =?utf-8?Q?b8Jnlv7B3UDRAy8ZUigPvQGLmMUW/mIu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qzl0Um9hZ280dUdiemw4aW91NncvWTlxWkJZd2xoZHV0eDFTdGhqR2phVWpM?=
 =?utf-8?B?OC9rWlJxQjlXWXR2ei9ZSjA3cVhLS3pvT2RGbE94Z05HYS9KYit4d1pHaEZq?=
 =?utf-8?B?L2dzNkFDMTN5Y3hSeGxyb3lxSmRSc3dDZFdxTWowYjlKU2NJTm5zSUdpYW1S?=
 =?utf-8?B?TVgxWXUvbmVidVI5dUlyK1RXRUFyZ0NBN0VFWEZxcGhZYSsyWC9nVkhITkQ1?=
 =?utf-8?B?MmZpYmtDNXlPYXlUWithM2JtZG1GdkJoZDhDN1RGUkxCdW1qbGhDUk8weGY1?=
 =?utf-8?B?TEdBZWNYbWw1bGhqK2FzcUczYnViYjVibUZDdUJWT0pra3E1Zk81SXp3U3NC?=
 =?utf-8?B?SVc1Yi9jS3lGcDQxVkxQSTVFT01UZWVoTjJVYS9jVjFoeVFwM1QyQklkRXVZ?=
 =?utf-8?B?d1NuSTRxcW1GdWVsMVlkUk5kbHhBNXhWVml6bGFyalIweStLWGdBMDlmS0hF?=
 =?utf-8?B?YWtmNjk4aU10SHRSakpmcVZwT1FqZ1V2SklQMkhQWUt2dFJUQkVSTVhKMmZr?=
 =?utf-8?B?cFAwSUdCcUFmV0RFNVc1T2tNU3pZZTh6YVJQbkpLekhaYnFxalRLRkhVc1hD?=
 =?utf-8?B?dFBaZG5XT0oyb1AyRkxRQ0IrMFRsZnQvS3QyYmxuaTY5d3gzbFRiVEVXczVz?=
 =?utf-8?B?ektnT2lsZ1pBYWtyZStQWE9hTjRJZXFIVXNwQi9DMklPTm9vUzJrK1FmaEVH?=
 =?utf-8?B?ZUJsZnk1bGNUSEdyZHcybEgxQzN3ajRaZGZoNi9Pellsa09VYnZjNTVXQ2NN?=
 =?utf-8?B?NDZRM2VwaDRuaVlXVG1NNDRjaGlWWjJJTVNmcHJSQ29uaUI5LzJhcGxIVnZ4?=
 =?utf-8?B?Z2pSSzZYVVVyZmFUV0NOZlpWOHZLWURHcnQxY0xtN1U0cVV5UGdOZmFJU01w?=
 =?utf-8?B?NVAxalArZkpNUE11LzdnUmZzMmVTZGluUmlZNlB0Z3hIYzd6NVp2b0JIaCt5?=
 =?utf-8?B?MStDQis5V3k2STk4L2JBSXpQQjJIdEVGc1VtdFgxMGQyN2lSSGlLN200RkNC?=
 =?utf-8?B?REd3WDhzbFlBSGk2alRMRlNmTUpzbWQ0RjdnZ3dhTDVrOENjRnFKTUd2WmlY?=
 =?utf-8?B?TEdKUHRtMWo3NHUxRGVEbjlqQjVhVWZnR1VUOVQxUGcxYXVoUlRJendQamRJ?=
 =?utf-8?B?TmdDcWZ6cmw4bjVWdk1UTDdzTkR1aWNXdUNaTE0wckQvSkZSaE1WMW90RWlj?=
 =?utf-8?B?bGdPUmR6aU9EdGlXK0FHazZ5VVZsS1ZHcE5tT3ZuTEt6OEhtTmIyWFhvMmpZ?=
 =?utf-8?B?dHd1aUhhQldrekNPc1BIZzdIemxWdWxrWGF5TG9VOG9nbWNtczM5SWxhNUQw?=
 =?utf-8?B?TVdWTEdpZUx1UTNpMDRVcWhpM1hYK3dnRUlsNFVOWm5uZ2c4c1VTaVFmNit2?=
 =?utf-8?B?TEhrL0FtdU1iVHhQNStLSTZXUXRVVzR6eUZsRVJtd1h6NnJKazIwT2tqV1BZ?=
 =?utf-8?B?b1U1dWE4a2pqc21vU2ZDRllwR3pURHpZanFTS1J0TTBsY3VxTlREU0JUSWk5?=
 =?utf-8?B?dkphSEw3WHJNWUFZaGU4djNPR01VTHYvRWdSYUMxeXE4RWk0ZC8xMTRybC9u?=
 =?utf-8?B?bC8vNTZIZkNDNFJGbm9CQU96T3JQaTlIUFAwSXJUS0xZVFNsUXJBZVRwTCtS?=
 =?utf-8?B?YnRWeFdWV1R3NTNpRDdueGl5Mndwd0RuSnBhajZxcVNiWldiOVdLa0xKaGtU?=
 =?utf-8?B?NFgxVS8xaFRYM2QzY2R5bW15QmxhbXpnMVA2WlVOVkQ1WnRLNm9iYWc3NFFJ?=
 =?utf-8?B?bFd4eTBjaGJkQVpGQTJtTWRxUVRhSE0wRG4wK1F1bDYwQ3FqeUplVS9ZaXJx?=
 =?utf-8?B?UEZGOVRDRWhkU29yWUNOSGoxcThNZWdtOHNsMVRpRDNkZmtXN0xYejhyN1c5?=
 =?utf-8?B?N2hFR3V4OGJheWNUYVUxamNYZ0F4WXgxTlZMZDZ5SEZtczR5RDV6SGlieXFj?=
 =?utf-8?B?bFkzdzg1bzlMRVkyc1B4UkdLV0ZpQXdCSkxybHZzYU1ialJIRG1wVG8zYnhL?=
 =?utf-8?B?TGZVZlo4cU5wbzIzVDR4WTNpWWM1cDJNbjBkNWdOd2NrWjdFYnVNVkUvM1pw?=
 =?utf-8?B?ejNBWGR1VERyY0djVVB5YjhhOVVnY2V6VDJIZ1h2RTZxcFFFVGdxbE8zMytu?=
 =?utf-8?B?ZVppMUx1Z2VIQm95WFdad0ZPaXcxWDBXV0QzeXFnY3RDV0tWRklhZzZIY2Fr?=
 =?utf-8?Q?xzSMppiLd5VRpVezeDeXuuw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1A222D24E8F7A4384C1D231DE0CE48C@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 627f21bd-9c7d-4d2d-9d94-08dd3f2c4b0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 23:42:42.6343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rDQJdIECCsC8SUL4E59JNpuWXlh8WjCgbhb9xlaGL2L9yl2ycRzyLlM+0l7x3iJ5NeUdPexTmq76v5oNli4fPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3852
X-Proofpoint-GUID: y9yPwWrOa6AuyvfPVkP29TWfgfFLMD8q
X-Proofpoint-ORIG-GUID: y9yPwWrOa6AuyvfPVkP29TWfgfFLMD8q
Subject: RE: [LSF/MM/BPF TOPIC] Generalized data temperature estimation framework
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_11,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270184

T24gTW9uLCAyMDI1LTAxLTI3IGF0IDEyOjM3IC0wODAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6
DQo+IE9uIDEvMjQvMjUgMToxMSBQTSwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+IE9u
IEZyaSwgMjAyNS0wMS0yNCBhdCAxMjo0NCAtMDgwMCwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0K
PiA+ID4gT24gMS8yMy8yNSAxMjozMyBQTSwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+
ID4gPiBJIHdvdWxkIGxpa2UgdG8gZGlzY3VzcyBhIGdlbmVyYWxpemVkIGRhdGEgInRlbXBlcmF0
dXJlIg0KPiA+ID4gPiBlc3RpbWF0aW9uIGZyYW1ld29yay4NCj4gPiA+IA0KPiA+ID4gSXMgZGF0
YSBhdmFpbGFibGUgdGhhdCBzaG93cyB0aGUgZWZmZWN0aXZlbmVzcyBvZiB0aGlzIGFwcHJvYWNo
IGFuZA0KPiA+ID4gdGhhdCBjb21wYXJlcyB0aGlzIGFwcHJvYWNoIHdpdGggZXhpc3RpbmcgYXBw
cm9hY2hlcz8NCj4gPiANCj4gPiBZZXMsIEkgZGlkIHRoZSBiZW5jaG1hcmtpbmcuIEkgY2FuIHNl
ZSB0aGUgcXVhbnRpdGF0aXZlIGVzdGltYXRpb24gb2YNCj4gPiBmaWxlcycgdGVtcGVyYXR1cmUu
DQo+IA0KPiBXaGF0IGhhcyBiZWVuIG1lYXN1cmVkIGluIHRoZXNlIGJlbmNobWFya3M/DQo+IA0K
DQpIb3cgdGVtcGVyYXR1cmUgY2FuIGJlIHVzZWQgZGVwZW5kcyBvbiBmaWxlIHN5c3RlbS4gU28s
IG15IGdvYWwgb2YgYmVuY2htYXJraW5nDQp3YXMgdG8gc2VlIHRoZSB0ZW1wZXJhdHVyZSB2YWx1
ZXMgdW5kZXIgZmlsZSdzIHVwZGF0ZXMuIEkgaW50ZWdyYXRlZCB0aGUNCnRlbXBlcmF0dXJlIGVz
dGltYXRpb24gZnJhbWV3b3JrIGludG8gU1NERlMgZmlsZSBzeXN0ZW0gYW5kIHRoZSB0ZW1wZXJh
dHVyZQ0KdmFsdWUgaGFzIGJlZW4gc3RvcmVkIGludG8gc3lzdGVtIGxvZyB3aXRoIHRoZSBnb2Fs
IHRvIHNlZSB0aGF0IG1hdGggaXMgd29ya2luZy4NCkFuZCB0ZW1wZXJhdHVyZSBpcyBvbmx5IHF1
YW50aXRhdGl2ZSBlc3RpbWF0aW9uIHRoYXQgY2FuIGJlIHVzZWQgYnkgYW55IG1lYW5zLg0KDQpJ
ZiB3ZSB3b3VsZCBsaWtlIHRvIGNvbXBhcmUgdGhlIGJlbmNobWFya2luZyByZXN1bHRzLCB0aGVu
IGl0IG1lYW5zIHRoYXQgd2UNCndvdWxkIGxpa2UgdG8gY29tcGFyZSB0aGUgdGVjaG5pcXVlcyBv
ZiBkaWZmZXJlbnQgZmlsZSBzeXN0ZW1zLiBQb3RlbnRpYWxseSwgd2UNCmNhbiBpbnRlZ3JhdGUg
dGhlIHRlbXBlcmF0dXJlIGVzdGltYXRpb24gZnJhbWV3b3JrIGluIGFueSBmaWxlIHN5c3RlbSwg
YnV0IGl0DQpuZWVkcyB0byBlbGFib3JhdGUgaG93IGEgcGFydGljdWxhciBmaWxlIHN5c3RlbSBj
YW4gYmVuZWZpdCBmcm9tIGl0Lg0KDQpTbywgYXMgZmFyIGFzIEkgY2FuIHNlZSwgYmVuY2htYXJr
aW5nIGlzIHNsaWdodGx5IHRyaWNreSBwb2ludCBoZXJlLiANCg0KPiA+IFdoaWNoIGV4aXN0aW5n
IGFwcHJvYWNoZXMgd291bGQgeW91IGxpa2UgdG8gY29tcGFyZT8NCj4gDQo+IEYyRlMgaGFzIGEg
YnVpbHQtaW4gYWxnb3JpdGhtIGZvciBhc3NpZ25pbmcgZGF0YSB0ZW1wZXJhdHVyZXMuDQo+IA0K
DQpNYXliZSwgaXQgaXMgdGltZSB0byBnZW5lcmFsaXplIHRoaXMgYXBwcm9hY2ggdG9vPyBUaGUg
Z2VuZXJhbGl6ZWQgZnJhbWV3b3JrDQpjb3VsZCBjb250YWluIHNldmVyYWwgYWxnb3JpdGhtcy4N
Cg0KSWYgSSB1bmRlcnN0b29kIGNvcnJlY3RseSwgRjJGUyBhcHByb2FjaCBpcyBiYXNlZCBvbiBz
dGF0aWMgYXNzaWduaW5nIGRpZmZlcmVudA0KdGVtcGVyYXR1cmVzIHRvIGRpZmZlcmVudCBmaWxl
cycgZXh0ZW5zaW9ucy4gQW5kIGlmIHdlIHByb2Nlc3NpbmcgYSBmaWxlIGZvcg0KcGFydGljdWxh
ciBleHRlbnNpb24sIHRoZW4gd2UgYXNzdW1lIHRoYXQgdGhpcyBmaWxlIGlzIGhvdCBvciBjb2xk
LiBBbSBJIGNvcnJlY3QNCmhlcmU/DQoNCklmIEkgYW0gY29ycmVjdCwgdGhlbiB0aGUgZ29hbCBv
ZiBzdWdnZXN0ZWQgYXBwcm9hY2ggaXMgdG8gc3dpdGNoIGZyb20gc3RhdGljDQphc3N1bXB0aW9u
IGFib3V0IGRhdGEgbmF0dXJlIGFuZCB0byBlc3RpbWF0ZSBpdCBvbiBxdWFudGl0YXRpdmUgYmFz
aXMgd2l0aCB0aGUNCmdvYWwgdG8gY2xhc3NpZnkgZGF0YSBvbiBtb3JlIGZhaXIgYmFzaXMuIEJ1
dCBpdCBkb2Vzbid0IG1lYW4gdGhhdCBGMkZTIHdheSBhbmQNCnN1Z2dlc3RlZCBhcHByb2FjaCBz
aG91bGQgY29tcGV0ZS4gVGVjaG5pY2FsbHkgc3BlYWtpbmcsIGJvdGggYXBwcm9hY2hlcyBjb3Vs
ZA0KYmUgY29tcGxpbWVudGFyeSBvbmVzLg0KDQo+ID4gQW5kIHdoYXQgY291bGQgd2UgaW1wbHkg
YnkgZWZmZWN0aXZlbmVzcyBvZiB0aGUgYXBwcm9hY2g/IERvIHlvdSBoYXZlDQo+ID4gYSB2aXNp
b24gaG93IHdlIGNhbiBlc3RpbWF0ZSB0aGUgZWZmZWN0aXZlbmVzcz8gOikNCj4gDQo+IElzbid0
IHRoZSBnb2FsIG9mIHByb3ZpZGluZyBkYXRhIHRlbXBlcmF0dXJlIGluZm9ybWF0aW9uIHRvIHRo
ZSBkZXZpY2UNCj4gdG8gcmVkdWNlIHdyaXRlIGFtcGxpZmljYXRpb24gKFcuQS4pPyBJIHRoaW5r
IHRoYXQgVy5BLiBkYXRhIHdvdWxkIGJlDQo+IHVzZWZ1bCBidXQgSSdtIG5vdCBzdXJlIHdoZXRo
ZXIgc3VjaCBkYXRhIGlzIGVhc3kgdG8gZXh0cmFjdCBmcm9tIGENCj4gc3RvcmFnZSBkZXZpY2Uu
DQo+IA0KDQpZZXMsIHdlIGNhbiBjb25zaWRlciBpdCBhcyBvbmUgb2YgdGhlIGdvYWxzLiBCZWNh
dXNlLCB3ZSBjYW4gY29uc2lkZXIgb2YNCmltcHJvdmluZyBwZXJmb3JtYW5jZSwgZGVjcmVhc2lu
ZyBHQyBidXJkZW4sIGNvbGxhYm9yYXRpbmcgZWZmZWN0aXZlbHkgd2l0aA0Kc3RvcmFnZSBkZXZp
Y2UuIFRoZSByZWR1Y2luZyBvZiB3cml0ZSBhbXBsaWZpY2F0aW9uIGlzIGltcG9ydGFudCBnb2Fs
IGFuZCBpdCBpcw0KcG9zc2libGUgdG8gdHJ5IHRvIGVzdGltYXRlIGl0IHdpdGhvdXQgZXh0cmFj
dGluZyB0aGUgZGF0YSBmcm9tIHN0b3JhZ2UgZGV2aWNlDQooYnV0IGhvdyBhY2N1cmF0ZSBjb3Vs
ZCBiZSB0aGlzIGRhdGE/KS4gQnV0LCBhZ2FpbiwgdGhlIHByb2JsZW0gaGVyZSB0aGF0IHdlIGNh
bg0KZXN0aW1hdGUgZWZmaWNpZW5jeSBvZiBmaWxlIHN5c3RlbShzKSBidXQgbm90IHRoZSB0ZW1w
ZXJhdHVyZSBlc3RpbWF0aW9uDQpmcmFtZXdvcmsgaXRzZWxmLiBNYXliZSwgd2UgY2FuIGNvbnNp
ZGVyIG9mIGludGVncmF0aW9uIG9mIHN1Z2dlc3RlZCBmcmFtZXdvcmsNCmludG8gRjJGUz8gQmVj
YXVzZSwgd2UgY2FuIGNvbXBhcmUgdGhlIGFwcGxlcyB3aXRoIGFwcGxlcywgZmluYWxseS4gV2hh
dCBkbyB5b3UNCnRoaW5rPw0KDQpUaGFua3MsDQpTbGF2YS4NCg0K

