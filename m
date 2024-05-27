Return-Path: <linux-fsdevel+bounces-20225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6301F8CFF09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 13:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46751F229CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 11:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E2D15D5C5;
	Mon, 27 May 2024 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="QgIV7eMy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E5B15CD7A;
	Mon, 27 May 2024 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716809541; cv=fail; b=EpVqnqvkKfCAyO9B1cXc6Yi0teX0TMc0H5d2RNUQ7zJ61MgiBdXraD9Sw4lerL94tYIOTWrrkH8K7t7ZkYuWpcyv3GNOC6kKGw0TneVBiajIuJVeLQEd5setl56L1DpD4aElLY0astuTrz8wHc2s2oarQhhnFx1KIkBX8bCNpvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716809541; c=relaxed/simple;
	bh=jSnfzyrFtpu4gWU4H8FUXNsiOGrzkYMkq4MtEYHYeJY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=VEBkkl5XW92aXuae6e7AetPwURL7Tib92UNtnlqkFVYHU4nLvVIyH+7ZLb2VxI7uIQo7sSL8xxZugBmMUscetgT8I6JYbL1MD9epwfKY5DviL/TrXtN1p9FDOfog2SHDyBraLQv/LEfUKMcGDWILy1E4t2Y0lMSa/254jYWyOH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=QgIV7eMy; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RAkdfC015391;
	Mon, 27 May 2024 10:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:mime-version:content-type:content-transfer-encoding; s=S1; bh=j
	SnfzyrFtpu4gWU4H8FUXNsiOGrzkYMkq4MtEYHYeJY=; b=QgIV7eMyZIgyR8N60
	i3/KjeWqcmlX4HjVCi7fEWQNok8uLuY2rp/Yvdr+4+1RNM4wClQs12wfs1jKOaW4
	d6BsT0yrM0w5BKjPmB+K7Q6pjnO19+D3VVw/buWMkypcRXlOFRzzuxGYpZCCI004
	lfi2K5+v7LbLT9XkQrkZDZgBywrmXVTJTzSa5g2C+mqSEXa+EwbXxPGi9xcKX3Au
	QocDYopKUjGtqcFyeiOrLcoelHQK14022BS+gQUqhWhX7seKeWdCOkW+zev/KDN2
	tpYJ8ZMhjBFJFOB+JazUq37OczVrPRcxFUn3xKf74q4mIDciCcObmzYficGeZ/Ol
	uJmPQ==
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2169.outbound.protection.outlook.com [104.47.23.169])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3yb8531qnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 May 2024 10:54:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ynx/SUEvE0NLIb8wr1o5RgIujQuMFhgxPaJNc7jP5a9dQ4BzmO/Au76Bgu6SJRMY8s0VEVS6nLBJly/3ntiM+VyuhC2cY+efVKZdPYVMwIy34+KBeGicOYU1exd73/p3JnptlibX1/PnlH1FaEZEnDC6mqCU3JFVDklpdj/h+8HF9ikl+Ox7vK9+W8HzNGrFMoau9gd2h2RS2GYZpI1TXOTi3ijwA+aMSSQCZpO9FSR20g6lHHqUMhwPbWD+awUpgRiNMvB2BMSUVR2G0v+YMWyvdYyBzGz2c8Un9SVP0QLw00ozLmIa2vxbHQbugpyq/8Kcx+N+cI4X8PV1r4fyrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSnfzyrFtpu4gWU4H8FUXNsiOGrzkYMkq4MtEYHYeJY=;
 b=PHP0NUyCSEEwRAWprlma4L8adtzp6SxUNZLiJef85QbRET3HiCH5bByFlsysOTAMbFcAucji8VKa1mkNkL1wEhC8zZ11kVknSpxbkkbyL3W26YRR+z3LZ3ZN+WG85+VaJyfzpuRL8yqSgyQM356wf/0GSLzOBKQ6tjB09AsEbhiirepBjY0yOWpJaw94DtvFRBzQFdO7WlIuTd4J5ccpTKY0hElAkIwEHgvgtmbmFcWVFFpvvWangrDkGJjs3iun9pRbQyo3RvjLzNZyl6fNV6NJPAGLvS8kHpRCBP4JLxNnc0fIhgnT9hmH7a5eAQKp6iRLIjUt0Tj6BIJ7sQewog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TYAPR01MB4048.jpnprd01.prod.outlook.com (2603:1096:404:c9::14)
 by OSZPR01MB6879.jpnprd01.prod.outlook.com (2603:1096:604:13d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 10:54:53 +0000
Received: from TYAPR01MB4048.jpnprd01.prod.outlook.com
 ([fe80::3244:9b6b:9792:e6f1]) by TYAPR01MB4048.jpnprd01.prod.outlook.com
 ([fe80::3244:9b6b:9792:e6f1%3]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 10:54:53 +0000
From: "Sukrit.Bhatnagar@sony.com" <Sukrit.Bhatnagar@sony.com>
To: Chris Li <chrisl@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
	<djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        linux-fsdevel
	<linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: RE: [PATCH 1/2] iomap: swap: print warning for unaligned swapfile
Thread-Topic: [PATCH 1/2] iomap: swap: print warning for unaligned swapfile
Thread-Index: AQHarBuqt0iiz8Qw0UG+Y68Rik9ClbGjjFiAgAdic5A=
Date: Mon, 27 May 2024 10:54:52 +0000
Message-ID: 
 <TYAPR01MB4048777DF18179228A7A786BF6F02@TYAPR01MB4048.jpnprd01.prod.outlook.com>
References: <20240522074658.2420468-1-Sukrit.Bhatnagar@sony.com>
 <20240522074658.2420468-2-Sukrit.Bhatnagar@sony.com>
 <CANeU7Qn5KmdA2bVmEMjFtxcP+WnE174VgtkXZEHX82fc-gxXhg@mail.gmail.com>
In-Reply-To: 
 <CANeU7Qn5KmdA2bVmEMjFtxcP+WnE174VgtkXZEHX82fc-gxXhg@mail.gmail.com>
Accept-Language: en-US, ja-JP, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB4048:EE_|OSZPR01MB6879:EE_
x-ms-office365-filtering-correlation-id: ac627ef7-458f-48bf-0a71-08dc7e3b702e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|1800799015|7416005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TllLWlBzOTJOWTBBbExlbkEzYW1wS241ZkE4cmNqL0Q1bzlpS2cyaURlSUJ1?=
 =?utf-8?B?MXB0Yjl4aGNmSkdGN3Z6L3BkZ0pENzI3cGM5RW9OWWFabERhb0Q4MjBkM3Vw?=
 =?utf-8?B?dmV2K3hFcDFhM0cyVXU2NDVoZndodzFrWThOQWc3b1J3MDQ5VzdiNkwzSXZK?=
 =?utf-8?B?cUFLOFZOSG4xOHFrTGw3M0thK0VZTWlPNHN2amNzMjNnczJOaWRWU0ZlVWZC?=
 =?utf-8?B?RlVzcSszR3VwTWNvSlFpMWJDU0xvcUdZK2JkWUJHLzZXVHBMYXpscUJCejBZ?=
 =?utf-8?B?bWRxK05XQVEvSk0vWklNQkxuOW1ZVEhubzg4eWtoMXFiZkkyUk5vZEJvdkc1?=
 =?utf-8?B?L0tXZkwzUjZPUWVBOUtuWWUwZFQyWi85TWpKR1c4eUpGU2tQNm5MTEpWVFJ4?=
 =?utf-8?B?KzgwTEVtbGJiSzh4ZU4zNlZpZmNPVDA3WFE0Y1FqS2tkcjNWZ01zaWlFSTVS?=
 =?utf-8?B?V016dmJKT1RtS2w0dXcxeVY1ay9mKy9yVk5qNTZveEo1dDRoTFNlVG5UK0NK?=
 =?utf-8?B?RllQTDB3c2tndHlqeHJOMlZKOWV0cVJXaXJGeFhOSDc1UjVvR0JKOTE2OCtH?=
 =?utf-8?B?UW8xWTZTOXhPRjYxWmtvOVdqTUFGVXovN2RYb3ZmSDJVc0d6VWRRS0p6eW5W?=
 =?utf-8?B?SjA0UE56RlRCOHNGWXlvd1N6TzZYNnRsTy93Z2dibVl6RlBJbE43TzBiaHNu?=
 =?utf-8?B?OVR2LzdWQjdVcGNYTzR4RjgrK1JYNVF3R1hZek1aNHN0SmZpSm45Ymg1OHI2?=
 =?utf-8?B?YjRhTThyUzBhMFNJNHcyZzI2bGxiUnFUcTZSMGthbjZjTm1OeWQyZDlWVlFK?=
 =?utf-8?B?dC85aTJMYUFIcnRsWGFoS0UwcTlpWWZsQkJWUmFtYzVpVDQwSlBXaDcxYWhU?=
 =?utf-8?B?alBwczh6ejZla2dnYndMQU9nWG94bFk3SlFQT283ZzFvZlNZL0NldGxUME9Y?=
 =?utf-8?B?WGFESWxkOWJpVnQ2SDRKRFpPeHpmYS9GeDh0YVdWKzJQaFNRRGtrR0lnZk9x?=
 =?utf-8?B?eUMvWVBPdVRQcG5LWFFXTXJwVi8rZ2pkV21BL1hzUVZGWDFQQU9YL0ovZXlV?=
 =?utf-8?B?cHdwQkRaUTl3RGxBMS9vZ053QnEzUlFWd202RlVtZVR5eTNHYUJ4cHlLVTR2?=
 =?utf-8?B?Y0QvZDB0NjdBMyt3Q2c4M05XTGErVC9WQmxKellLQkZrYmlZVE1MNVdnby9y?=
 =?utf-8?B?OUhKbkZpcU1sR2JXZlJYUWVYanNRenV6NEZMMVdJSmRsMjNlYkRoRjlSQmtq?=
 =?utf-8?B?ZkxiQkNmbGxjdVlkNUNBVjZCN1hYK1o0bVdLUmRmbDZ2ckNEVHA1cWRLVEdr?=
 =?utf-8?B?NDl1eXltQmR0am56REdKNEZIKy9yQUthL09LZjhQM1BHQ2ZNQ1JZWUR0ZWVK?=
 =?utf-8?B?bWpSMXoxNUE5TXNDQUpFK1g1SWxROHI2aldOc1RxNWVMeFdSOVpSUkcvVmZh?=
 =?utf-8?B?Rm5pWEhzTlEvVTU2WTYyZko4VXVXbUJ3T1FleGUvQUtsV2RQUW5hckM2RVQ4?=
 =?utf-8?B?clVjbUlIN1hPU2wyWXFoYThXZnRDU3I1T2YzZE51cWNVWGVRRFpjVHRPTlhU?=
 =?utf-8?B?clBqMkx1Vy9ZNTV2MG0zbk5CSm54ZnZnQjR2WjRvRFlYc3duQ05DaXVwUUty?=
 =?utf-8?B?WXFpUDZBQnMzTVVzVXVNWklkNzlEK3BSYjRnbDZaMEtzYkNFUkg4RkpuVHVz?=
 =?utf-8?B?N012T1pFWWdiTW5TOHVWcEhhV0ZtN2JtUXJtaXI0Si81aitLNG13WTNDcEFS?=
 =?utf-8?B?T2E1aFA3ZFFERkhiWm10dmFseFhGTDN2R1VUYzhuVU9BdzFVNmhWSmVMQ2tK?=
 =?utf-8?B?QzRKSlVZcU5VWitlb2lZdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4048.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZFJ4RDhFRFM0Nnh6MllJYnMrRUl1emxJQW5xMEFvOUdKVTlQMzZ3WDFZRHRZ?=
 =?utf-8?B?L3pSQmErSDlKY01tT1BpWDJJTDF2Ny85TTJrYXJNcjZhajVXTGFaZWh4ZUFN?=
 =?utf-8?B?OC9jdHU5OUxCeXlxU0ZQbHdLU2NtVGlGazJ6aVJBVG9Bb0NlWms3Qklka2Fr?=
 =?utf-8?B?c3JJQW1iMGJiR29US0VWQTZHcm0yVTRLaDYxcVBTMFFsTnlNNm1QM1lHWkVS?=
 =?utf-8?B?QkVLZk9RQ25JSFJJYkt0SHBrMGVITnI0VGVIek1rcmNSY2NKRVEweHdvVlF0?=
 =?utf-8?B?RFNCWGFWenM4VEt0bDYzaE80OGVVWHR0NVpEYW5hdEQrb0pLNHI4VWZBL1NK?=
 =?utf-8?B?V2dKY0t5dGRzUVBSeUdKaWdiQkl5UFhqS044SmxMS2JCWEFxMm9rdHB6MDN1?=
 =?utf-8?B?clB6YVNnb3lBN05SN3htUTh3bUxLSWxpZ2Q4clI3WVh3MkQrS3RMbStCbXhX?=
 =?utf-8?B?Z2hKb0VLMHNwODhjSitDM0tPNDVjS0xoWkVKOVZic1liVmR0alZvcGtKaXhZ?=
 =?utf-8?B?NlNRR2h5WjZta2h1bEQ1NUM1NHhsT0ozc2xaZHRyelY2ZEx2NnJLK2VHYnE5?=
 =?utf-8?B?aWNPeDI0ZUFHTEtpUjZ4RDd5TWdYSllFV052bmplb0FtS29adlJOYi85Mlhy?=
 =?utf-8?B?V255V254QXAzNy9yckdWZVFIdVNRS25uc0VjMUtscVQ3RFUyZDdHOGlaa3Rx?=
 =?utf-8?B?TzNaZlNXR2l6NlZsdm4vYzBGS0xHWm5ac1JpVkd3Z0hDODlBaEErc3IrdXdG?=
 =?utf-8?B?Sk14OUFvWEY5bGxzNWhCQ2cwbmUvb05TdGdLc0lpL2g4Q2c3ZEhEVDNmdlBk?=
 =?utf-8?B?elBodjNGUk5rZm9wZEpaVFlNNzQ1aE10aUFpc3llaTlQT2lQMFd2RFJpMkJR?=
 =?utf-8?B?SGNSUjViOGgyOTY0Y0R6YXlVUkZGOUhIb1h4RXBNMmdBQitmS2tkOXlnVEEy?=
 =?utf-8?B?ZEwzbFQwMlJSSFF0ZTN4eklmeU40c01vc2V3Ti81TVAzU2J2OHVoTTJXZFR2?=
 =?utf-8?B?RjBKTmpmQmpOaFhielFFM2lZQU8yRHpiVHAyVWdVeUZWaVhZaGdHTXRLelhF?=
 =?utf-8?B?dTN1SndMUnZMS1BZMWtMbitQOFdTRmUxcnJtVCs3RkY5ZTUzNjBOK3NqNS9t?=
 =?utf-8?B?TnlFalFmVFpyTU1wbHR6WEo4OVVHaVBxL09nUlhLQ2lyTEtsdlEzdXlNSHI1?=
 =?utf-8?B?eTNXUk5hOTBnOHVIK1BzYVJ2WXNaL2R3dUtXRHBka0dQckovM0YvOUd2SkNm?=
 =?utf-8?B?OU1QdGJSU1dUY2dzQlJiVEtVWm5PRnpUenI1OE1DVmFvVkRpVE1CSkw0NEd6?=
 =?utf-8?B?eXFUV2ZLd0ZzMXBodHpNdEY3MEk5SXY3WmxWeENUSlc0bktRSm5MM3QwT2dC?=
 =?utf-8?B?TlZQd3Z4Y04xbzN5WU9lSXY4WGdQZlM1dWQ1SVVHbmU3L3RVR3kwakdPMC9M?=
 =?utf-8?B?Z3QrRFVLMmxZamdjNEUxMFRpNG5GMWJmNC9POS8wSUlaWnlJVVJLci9FUEVF?=
 =?utf-8?B?bll4WEw4b1grWkRSZzcrMU9ic1BnajZFMlFLemFDc1dVS2dSa1FQWUJLVnFj?=
 =?utf-8?B?UXEwb0xPcEtIaVgvaEg1OUVpNUY3VDJNOWFFbFE5RENYMVBVMTllakpHdDJm?=
 =?utf-8?B?bHRWL0lYb3NqMzdDa1UwRHdiMEZaOC9EL3Z5S2MybERzZGxIcWpkMUZLTTcv?=
 =?utf-8?B?YlRXY3R1ZENzVVV2QjRLM0dKZ1NxVTJPcG9XcFZJYzBFUG9EWkR2Q0IvdVZL?=
 =?utf-8?B?R3Qycjc5NHFSZmlNcnVrZVdHUnE4a1I4bzVqMWJlM3hZR2l3eTd1VzZERlJx?=
 =?utf-8?B?ZmNJaW1lMzBsRUhZeXlZa2V6S3BEY3lVSXZnOWxsMmVFSHpxRW5GTXNKSUZE?=
 =?utf-8?B?d0lZald2eWFmOHAyMFQzUjdTUU0rVm5IRnhReVh6ODgxMUxCaTkwc3JqcUYx?=
 =?utf-8?B?QzdTTXVQaHlqRERBem5DTzFxbHA0RnVrRDYvRnFobXVsRmxabFc3ZEV0L0tk?=
 =?utf-8?B?VlMvSHJXNnFoZno5MUE0YUJjQjRiUkxTSWpYbFA2U2JWc1pSTFkxVlRTMDFD?=
 =?utf-8?B?ZlZPbEgrenZkQjVmOGpXQ1puREg5Z2JVUWVQS3hEam5WZTBEeE9ybGw1ZXlh?=
 =?utf-8?Q?juyHLBblxsDQnA3enGy6Kn2OR?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	m6CZmZIc7W6E8oUSp9fpcYktT1JcAqoeY7guY0qFE2l/PCBP/IYRLHRRRBIsTWmlxlJuSfN6PRVfAhl6KKgNelY7LKwxTfX9XQIHvE+LZU8mRMEWjZywKYBqoqgHKqeD70U9iNRjxNhbotLh+w/o0eCBvgpZzqtQPDSOWvrjJMOcpYAFM7FKUN1gcUy8aYgdB3GKYv0ngNEwsOADnSS/YG78Fp21NzsFoyzuWuRwFWO1+mgd3eftzWGh162pj8izYKPmnYiL1jPWj+spiShz0oa3z1QxyVznerWloU4IMnpDDWn0YGNRmcfN+hUD4JQ9+DP9WMQxYFkwlpBbmems9llRIDy7xiRR12zAdLBkaQu7q7aO4CmTubVX8jJjT95IT2Nv1fE1Mozn6A6N2BdED/ZkVfn7OdBE2TKg0OBySCOZlHF3RosRfIrp3aiLrbfctyPZdjCRWIyD3dFFEZjHCxMafcIGdRH/QoBEri0/VaU1CyY3pgcRoch+0/Jy/CS6ZVPIBbGmgDc1U+/WuXobkY69D0NYdlBng8eUKQxsOfigZAFymRycchyuFk8atmRmiYaNhGWgjDAG8cU7qJmDffeIQNR7ALADQ8HNtB7cMTqMNWn2IsE/wqPfXtu4Pga9
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB4048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac627ef7-458f-48bf-0a71-08dc7e3b702e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 10:54:52.9986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PVHfD4XcJQIH+JUutcdhyxvqphTYV84UmMwa8QHfruAJwApZlPbkVadzhDUtQRveov8ac3kbpsvYkPIEKYGqxPUEihikrvi9rRFZ+1+H2kY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6879
X-Proofpoint-GUID: W2VT2wjnYhTF5sjiqTLVGBdi6eEH6PjX
X-Proofpoint-ORIG-GUID: W2VT2wjnYhTF5sjiqTLVGBdi6eEH6PjX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: W2VT2wjnYhTF5sjiqTLVGBdi6eEH6PjX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01

SGkgQ2hyaXMsDQoNCk9uIDIwMjQtMDUtMjMgMDM6MDIsIENocmlzIExpIHdyb3RlOg0KPiBIaSBT
dWtyaXQsDQo+IA0KPiBJdCBzZWVtcyB0aGF0IHlvdSBuZWVkIHRoZSBzd2FwIGZpbGUgYmxvY2sg
c3RhcnQgYWRkcmVzcyB0byByZWFkIHRoZQ0KPiBzd2FwIGZpbGUgaGVhZGVycy4NCj4gVGhpcyB3
YXJuaW5nIHN0aWxsIHJlcXVpcmVzIHRoZSB1c2VyIHRvIHJlYWQgdGhlIGRtZXNnLiBUaGUga2Vy
bmVsDQo+IHN0aWxsIGRvZXMgbm90IGhhdmUgdGhlIHN3YXBmaWxlIGhlYWRlciBhdCByZXN1bWUu
IEluIG90aGVyIHdvcmRzLCBpdA0KPiBkb2VzIG5vdCBmaXggdGhlIGlzc3VlLg0KDQpUaGlzIHdh
cyBub3QgaW50ZW5kZWQgdG8gYmUgYSBmaXguDQoNCkkgaGFkIGNyZWF0ZWQgdGhpcyBwYXRjaCB0
aGlua2luZyB0aGF0IGFkZGluZyBhbiBhY3R1YWwgZml4IGZvciB0aGlzIG1pZ2h0DQpiZSBub24t
dHJpdmlhbCBhbmQgbWF5IG5vdCBiZSBkZXNpcmFibGUgdG8gZXZlcnlvbmUsIGVzcGVjaWFsbHkg
d2hlbg0Kc3dhcGZpbGUraGliZXJuYXRpb24gaXMgbm90IGNvbW1vbmx5IHVzZWQuDQoNCj4gSSBk
b24ndCBrbm93IHRoZSBzdXNwZW5kL3Jlc3VtZSBjb2RlIGVub3VnaCwgd2lsbCBhZGRpbmcgcmVj
b3JkaW5nIHRoZQ0KPiBwaHlzaWNhbCBzdGFydCBhZGRyZXNzIG9mIHRoZSBzd2FwZmlsZSBpbiBz
d2FwX2luZm9fc3RydWN0IGhlbHAgeW91DQo+IGFkZHJlc3MgdGhpcyBwcm9ibGVtPyBUaGUgc3Vz
cGVuZCBjb2RlIGNhbiB3cml0ZSB0aGF0IHZhbHVlIHRvDQo+ICJzb21ld2hlcmUqIGZvciByZXN1
bWUgdG8gcGljayBpdCB1cC4NCj4gDQo+IExldCdzIGZpbmQgYSBwcm9wZXIgd2F5IHRvIGZpeCB0
aGlzIGlzc3VlIHJhdGhlciB0aGFuIGp1c3Qgd2FybmluZyBvbiBpdC4NCiANCkFkZGluZyBhIG5l
dyBtZW1iZXIgaW4gc3dhcF9pbmZvX3N0cnVjdCBmb3IgdGhlIHBoeXNpY2FsIGJsb2NrIG9mZnNl
dA0Kd2lsbCBoZWxwIGluIHRoZSBmaXgsIEkgdGhpbmsuIEl0IGNhbiBldmVuIGJlIGVuY2xvc2Vk
IGluICNpZmRlZiBISUJFUk5BVElPTg0KaWYgbm90aGluZyBlbHNlIG5lZWRzIHRoYXQgdmFsdWUu
DQpUaGlzIHZhbHVlIGNhbiBiZSBjaGVja2VkIGJ5IGhpYmVybmF0ZVsxXSBhczoNCiAgICBzaXMt
PnN0YXJ0X29mZnNldCA9PSBmaXJzdF9zZShzaXMpLT5zdGFydF9ibG9jaw0KDQpBbm90aGVyIHBv
c3NpYmxlIHNvbHV0aW9uIG1pZ2h0IGJlIHRvIGFkZCBhIG5ldyBzd2FwIGZsYWcgbGlrZSBTV1Bf
U1VTUA0Kb3IgU1dQX0hJQkVSTkFURSBhbmQgc2V0IGl0IG9ubHkgd2hlbiB3ZSBkb24ndCBoYXZl
IHRoaXMgcm91bmRpbmcgdXANCmlzc3VlLg0KDQpTaW5jZSB3ZSB3aWxsIGJvb3QgdGhlIGtlcm5l
bCBub3JtYWxseSBmaXJzdCBhbmQgbGF0ZXIgc3dpdGNoIHRvIG91cg0KcHJlLWhpYmVybmF0ZSBr
ZXJuZWwgYWZ0ZXIgaW1hZ2UgbG9hZCBmcm9tIHN3YXAsIHRoZSB2YWx1ZSBjYW5ub3QgYmUNCnNl
dCBpbnNpZGUgdGhlIGtlcm5lbCBtZW1vcnkuDQpXZSBwYXNzIHRoZSBzdGFydCBibG9jayBhZGRy
ZXNzIGluIGtlcm5lbCBjb21tYW5kbGluZSBwYXJhbWV0ZXINCihyZXN1bWVfb2Zmc2V0KSBmb3Ig
bmV4dCBib290Lg0KDQpbMV06IFRoZSBoaWJlcm5hdGUgc3dhcGZpbGUgY2hlY2tpbmcgY29kZSBp
cyB0aGUgZnVuY3Rpb24NCiAgICBzd2FwX3R5cGVfb2YoKSBpbiBtbS9zd2FwZmlsZS5jDQoNCi0t
DQpTdWtyaXQNCg0K

