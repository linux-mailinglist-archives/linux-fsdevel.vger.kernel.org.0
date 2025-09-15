Return-Path: <linux-fsdevel+bounces-61461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 432A4B587E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFAE1206098
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 22:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB8C286D60;
	Mon, 15 Sep 2025 22:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="i4JEoAmb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D437A2B2D7
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 22:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976746; cv=fail; b=sBLC+AjBAw6m1dVM2YsqOdpawX4JWdVv8pEnzxT/oame5BoT4+bjGuIBzjzQKWzh93sDHZSQHcQnUMIcvOs7oQsnX5XtcuXJnygUKjmrNHU5syJI3DC/ZAw4qUwTPSosTz93lgEsg8IpLx0negS9l7MzS8TeWU4SGTJDLffdO08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976746; c=relaxed/simple;
	bh=RXKv0EYYgAEed0HV18gtYlT6IGwowDtEBOz8MLdCfEI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o0LT4N6KjHLQmgnh8wxWdzS7sR0w0/igt1+nsEz7E2I3+QhRqF4TGZTwLHBCXXiMJHbFkOAZxp0Ji+6BTAojfN/+L2hQ7XIdS7AKtcNBDK3MaSgc7RZzWJCG0DhLnNV8WQsdoZGYmN8duvwy73ECQkkBin/s4BnrsI9sYg3gF/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=i4JEoAmb; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2131.outbound.protection.outlook.com [40.107.220.131]) by mx-outbound-ea18-75.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 15 Sep 2025 22:52:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fc2DwlmDhVPuIDuPDOfBWFvUKW9H2m07BUeO5DmrhyH6XpSGr50AD/7oR/Kat4+sRCk+2JpHj93bHx0cnuDn4dc7owHnLLL68blfe90mFUGXchfLWHeGajg4KQRPaZg4JBOVKyGMukfaXas1qp7wf5QlcroF5Uwdugc/ey5+6dijcjc/urhPRPhpJOX8WgcXbmOJoY7YW7vUMB59c8qcSJF7teXctr76/fibH0dZ59ynYxS4yhhJ/+Vn0iNrflQ+9k/flNzyEiqoQY+lrLEdSAITb2A7aOiWUYidpY7PNfxLeIs4rJqZhzwwVBUQnaSZ0FFbe95ej0pyvZTpeUTKug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXKv0EYYgAEed0HV18gtYlT6IGwowDtEBOz8MLdCfEI=;
 b=GbOtl69nQM4ThzlkrMN+o4oeYmmcLa4QPmYh6e8CkylMWDBVLiUMct6A9Tj+ffR0dLMA3LSw7o43uUYOjq/2uac0PT1DCD5KytzZpJeYeBMd8NycGNaqDzdguicbLO5W/Ro4A/EQmUSaBXm723ERpdC17mtwJmrYvuGnsGI7izdQNHJjuZokes70oug8+3sLBFfopdKNmsRsKHs79OTV4/lls3W5cHc+qaI7HOqoPWlP1e5zervSK4jjulSDzbZL9QXt5DMf8K+9B17vbqeXJAtO62TqhPjiNOF0gls3cTfd0USeyEB1b8TB5Z+0Tx2X08pnhPiV0NLZCN4hRBvQcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXKv0EYYgAEed0HV18gtYlT6IGwowDtEBOz8MLdCfEI=;
 b=i4JEoAmbv9hPUzjIQnV5GSjMifXz5N+RCMekOYE5sM3+SyKLmMHW+Edi1mNSP69V83QsJ7eutC/bl9b5ArGJeZWHMt3ysGucMAIeM3qJgcI4yYy9AjQjFS6JTOMgSyWnwVWBfloB6xy0Mq5SXbqFqJygkQQVLpI1IpZie/saXi8=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by CH2PR19MB3943.namprd19.prod.outlook.com (2603:10b6:610:9e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 22:18:15 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%7]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 22:18:15 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Joanne Koong <joannelkoong@gmail.com>
CC: Miklos Szeredi <miklos@szeredi.hu>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 5/5] fuse: {io-uring} Allow reduced number of ring queues
Thread-Topic: [PATCH 5/5] fuse: {io-uring} Allow reduced number of ring queues
Thread-Index: AQHb+1O1Ba/9brBA1kOcsMl9osqwDrRCA7yAgBBXpwCAQss4gA==
Date: Mon, 15 Sep 2025 22:18:15 +0000
Message-ID: <e82be32a-922b-4905-9b69-c07bb8771354@ddn.com>
References: <20250722-reduced-nr-ring-queues_3-v1-0-aa8e37ae97e6@ddn.com>
 <20250722-reduced-nr-ring-queues_3-v1-5-aa8e37ae97e6@ddn.com>
 <CAJnrk1Zn=f9Y0xxgrrVPnuFT+zP3aLeLwbL8gxC5gLsyiJO=MQ@mail.gmail.com>
 <23982cdf-6447-4967-8d5a-56f9a7741046@ddn.com>
In-Reply-To: <23982cdf-6447-4967-8d5a-56f9a7741046@ddn.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|CH2PR19MB3943:EE_
x-ms-office365-filtering-correlation-id: f21e6d4e-ae17-4b74-9de7-08ddf4a5c434
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VWo1ZWF4OU5EMXp4bzhJZzVHa0dxaXBIRWRvZkJVeE8wSDBDa041NCt4RTR1?=
 =?utf-8?B?U2l4WUp1OSsyeFY0WWRMQ2xaWldNOUFDUXNNcG1lbmgrNnZhQzRIUGVHdi9i?=
 =?utf-8?B?c2RTM0lOVXN4Y3E0QWV0bDZOamMwaFI2b3hGaTZoTTFnaUdKZUsveFVieDBB?=
 =?utf-8?B?ZTRwQTkxd2I1c0pRZGMydWMzYlZuMmpmMzU1aGdXeElmbjBxbk1NeFRyeTNz?=
 =?utf-8?B?WWJ2UUdFWUg1Q0RRaHNlZElBTE5OVVFyZXBEQVdyZ3ZXdm5QdkJvODhmdXFQ?=
 =?utf-8?B?SVN2Y1phUnkyYkxPUWRoblgva2lVSEJMMWVlZzFvcFN2Zm9ZZklzbStmM1RQ?=
 =?utf-8?B?OW9EQ1hJblpDcmx3MmtLcVlGVkt2TVZtZE9LaTdBeDhZMmdrRWJXMUNhbndR?=
 =?utf-8?B?SWpWZjlBV0Frb3U4Vmx0Z1BiU1BBSnloNUQrc3Z2UFg4WlNnQ0R3R3NMczJu?=
 =?utf-8?B?VlFBN21iU2NNa24vcWg5MFlmalNJSC8wQ0M5aU9HRlVkRG83d2lyV215L3hp?=
 =?utf-8?B?dzJGallWZ2x3NGE3dUdIRjZLQlRaSlBNZm5mZXdGcHM5c0JkNlg4TU4rZzNj?=
 =?utf-8?B?NGZwd0FST2srazFLc1JZcmNtaS9vdTlVeTZ5dEdINERtcDNFTUNGN01mWHFF?=
 =?utf-8?B?YTk4MFU2VjV4L1ZwNlgwRk9DVVRPUTYxcEo0NWNLVHN0QUFBdmdJSy9nMU0r?=
 =?utf-8?B?MUNvTWRjazlSSzU5T3VjVm81TmU3ZW41ZjI3ajVWeXMrZ0FmMU9hdjd4Wk9p?=
 =?utf-8?B?TEpuUXYvQ2xZZDZicWxwUko0UktQZE9CU3NuYXRTUk5GMUZSQitOVUtETFdG?=
 =?utf-8?B?K2dBT3VNMWxHRk85TnpMWk8vT0cyVDFvaFVMajRJUTFxdktzemQ1RkpKK1U3?=
 =?utf-8?B?K0VYb1AvUURseWZWTEdiQVJJQzIxRHA1WGttbUN4MmZWUWV1WFhzekRSWDRr?=
 =?utf-8?B?VjhMU1dIM3BvVTVRUE5zOHdPS0gzQ0loeW9QME1sdU10R2Uwb0kxTDcyaEFw?=
 =?utf-8?B?clB2RlNaWFkzb0x5cEUydm5VQ1hsM1BBS2dHekx6RnJRcEdoTTNEMkFoaVVT?=
 =?utf-8?B?VVBnaWh5NUZyRlJ5SDRpMkdyQ1ViZDFvQm14ay82OHVzcE1mQmJCRGFmbW1C?=
 =?utf-8?B?WXU5R3Y5T1lVc2NacWxQVENuQ3czRUpZRmFtWkswYVpSYnFpd1Erd2FZT2ZZ?=
 =?utf-8?B?ekV2M3UvSXNQS3ZCalRydzRjczd2UWh4N2ZEaS85NTB5SnJJcCtvbjBWVUJI?=
 =?utf-8?B?ZmJOTDh2N2xEcVNpODRGSUlNMHdFM0U0TFMwYUwwcU9wY25OYzFYQTNOa1p5?=
 =?utf-8?B?Mm5WQUtsVmtNMno4ZW5sV0g0ZzJ2Sm52TEVUUXo5SCs2U3o2cWZFbVV1S2NH?=
 =?utf-8?B?WjJoVG52VmY3NVZ5K2RRa241OGJ1UWlBNWdTTmh6TG1uNjBJZjdRQkFzSmVa?=
 =?utf-8?B?NFlrYjdIbEoyS3hFUDVzZFBrbmNHS0t6UlhxK1JRZ0dWMjV2WU5ESHBCbFUr?=
 =?utf-8?B?a0h3RTROWkxJVWs4OXlsR01wcW96QXJVTElWd2ZQQjVSSkVDU1VleFNlVCth?=
 =?utf-8?B?QUsrUnNJb3dMek80R3ZMQ1NUcUFlQWdDQlg0TXVzWU1XYXM4N3JEY0ZrTUg1?=
 =?utf-8?B?czRTSFk3N012dWlhN0FmN1Z2MEV3REdrclJ1NnBoVGpPVmFRM0JLVWZrNU0z?=
 =?utf-8?B?SzlkVTkwdmxQK0U2YXJyeXU3YmlhRzZLT3dDVXo3aTNuTEpUV1g5QUs4WHdJ?=
 =?utf-8?B?Sm1ONmVwMWFjRDRaeXQ2MFNGNVBsUm1Eb055QVM5cWU1c3ltYXFXSjJxSUw3?=
 =?utf-8?B?bXR6aWZJNFJkWGt6bGV0azB6NHh4R0F6SFVTZ3ZjTmh0TzBkeEVSSjNocWt6?=
 =?utf-8?B?UTZodGJRMDFtTUk3VWFyU1FPUnBCdU4wcUdLcDZoTUNxOXZMMjJYUzFTaitS?=
 =?utf-8?B?NzRqR2UvTFNjU0lIV3VxZVpOdllxK2hGTlVIdnJRRG1oZGV4eWd2RkN2akFF?=
 =?utf-8?B?WVYwM0ZlY0xnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?emIwdXE1YWdERFdhRFNwcUMxSW9vYzFiM21PMnR5SWRqTk5zbVFLNExueTFH?=
 =?utf-8?B?c1BJQWZ3SXcrcktUVk1RUm9nSmVZVlROSFdlU1hyc0dDS0R5cDB1dkVpVEFV?=
 =?utf-8?B?MCtsQTVPMVk4b0YydVBTWjBVVFQyaW1QSGdqankvTVVEeW40UTBGbjUrM1VW?=
 =?utf-8?B?dUhVV1ZRUlN4MlhjeVVuRUViSUhGZmVrMUNZc1gyWEtwM2RBakVoKzR4MTRa?=
 =?utf-8?B?c1pzQjdWRVRseVk3U20raWJBTDA2TzA0TGl2QjJENkh4dEJIQXk2UnYyRGxN?=
 =?utf-8?B?bVowRW8yT1FvSmRUT0ErcWdxaTdJbjRxM3Q2Y0Z2N3B0OWtYQ1VMc3lLc2xP?=
 =?utf-8?B?NTNZTmpUY3lEUE9PelRBQzVKaHFrWEZEZVJWVlg3LzhXZGFZZVdneHpqOTln?=
 =?utf-8?B?UUVWejhyZk9Td3lvWDdXOEtFbWhxSCtYZmkrOHdhT2JsVnBTeC9haXNwckxZ?=
 =?utf-8?B?MFloSGtHM3ZLVXBmRFpJSVloM0pobnZQY1pLSVhSTXBrcnd0VWNscmJQYXZL?=
 =?utf-8?B?dlo2SlJabUppODdhTXVob0tVbDhhdEdvdno1dWdkKytvTGpiaDI5dU5VTzRH?=
 =?utf-8?B?czlrL1FXZUtoUjdLTXlwTVdIMStVb244RlBNL2MwMVg3M3pITnNicVlRVjVu?=
 =?utf-8?B?alpTMWR1RDZYWkZETUlUcFZKdUV6TUF6ZEtTY2FYMlI3bkRieHZRM2tEM01j?=
 =?utf-8?B?MmdOQWx3bFIwYVlKZGRKcGI5L285RjVHRDRpdmllMWwydTU0cm9yUGJTSStm?=
 =?utf-8?B?Q0wxczNIa3JGS2phNEZsbW4rSHhIZUpaTWsyZ0pBakxkZEdpUHJkeXU3U0Uy?=
 =?utf-8?B?U3dRSkFVa2JHS1NUeThOcHlHOEJKVXpqTzkzeEJOaDZ5b0MxOGdlTXk4SzN5?=
 =?utf-8?B?WWM3NHFTamFQOUNaM0xBTko2NGpzSmg5RitrcmF1VEdhV2dwZ2R2cG5ySU4w?=
 =?utf-8?B?N0taOTJKcWMyb3JSaCtEV3BYU3R0c05RVXFwdE9XK0ZyWTV4ZlF4SFFEL2I5?=
 =?utf-8?B?VmtUYUtTdytuZ2czb0FENyt3WCt6N2E4UGNJOGVMU0F5ZjRibUNrVGx6Mlpn?=
 =?utf-8?B?cWlXdHNJU2tmWHIxMDN4STJLdDdpanlJYlJLbnVUY2QvMXRrdUVyZW1CMHhR?=
 =?utf-8?B?S25IZHR5c1B4ait0U29PeiswWE9BanJGZUFSK21aelM0TSs5enZwY0dpU0VJ?=
 =?utf-8?B?Y3I0b3Q0aXFScHQ4YmdFeTUyR1ZHNVRBOVZIelFqa2FPT25MQW5Rd0dVMTlm?=
 =?utf-8?B?My9MZnUwZk5ZR3VYV0VqbnpteHJ4KzIxV0c4b1lDZkxYSTFuaGJ3OHg1NlZN?=
 =?utf-8?B?RGZITXFDU3lJRmRqOTViQVp0WW5zYlEzUzEvWjVuYnIvQWdkanhMTFl2M3hR?=
 =?utf-8?B?YmdkY2lCRE5SeFJEaVZFRDJSbHAyOXBwTS9DN0QzWGtyOTVScFFMem5iZjdV?=
 =?utf-8?B?R3BYdm1MTjRyeE80czhQK0ZwcERITWIxbWljSGRwZC9yN0p2ZCt6QzVwRUNV?=
 =?utf-8?B?QXIwWUhpcCt1blIxYVd3VnY1M1htYklTQzJrbm9PZDhYVDUyNE4vQk13OWRM?=
 =?utf-8?B?UkxpbW5QQktWYjJwWktJWGExQmRwUlkrUEJCL0hPNlNxa3BQNzcxNFdhNStt?=
 =?utf-8?B?Q3RSVVNvWEF3ZnRlR1V4dDdSeGdEaHN3WUZVMG5Xb3JONHJ4L1BrNXdsekV2?=
 =?utf-8?B?R3hoK1dJR1E2b0d3MDNXSDZOVTgxUFh2Ly9SODVLd0pxWGhKTVAzWWxjcHlZ?=
 =?utf-8?B?azRqZEtaOXVDcUIxNlAraDc3bnk4cTZjR2U4LzUxdk1qOUhETmJaOEhnQk41?=
 =?utf-8?B?Y2FTRkIrVmk3dHVORHcvYTljZkd3bFhKOUpDd0x2UExkTzJOWDM5QStWajJ5?=
 =?utf-8?B?eElYcFN4MXNmUlljdjJLaFJIcEJub0JCWWZrNDEyV1k3ZEYxbFoxaEhyNGVV?=
 =?utf-8?B?NmUyanBkQWRXd2prNzQvN2VHaGl4YTBMdjJYTTZrN29sdGNDanZMN21BQyt2?=
 =?utf-8?B?MmpINXF6Vm9ZNVk1Z3NqTGNDcWptQkMyczl1cTFRaUc2UWgyUkNNOXdHZTVG?=
 =?utf-8?B?SVdtNUp3eUJsYVFjT2VDVHRoNGlJQ3FBakZKeDliVTk0Z1hVU2R0S3Qvc3Rx?=
 =?utf-8?B?WTFTc2ovK01PWklnaDN5d0NhdlIrODlndlpSN05nSXpiWTM5djRTenRqSTlz?=
 =?utf-8?Q?ddwDR32gkH1ocnp0dov5KWU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F3785BBE87C0B45A35A9B91423B330E@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 OHX1F5Uispx+1YYiRNMOtsNJiySHtvbsIJqQTUjU2kH8FTesM2E003Xp9q+NW+vF3WvCDvnGPa0tJ+UWoycG97bfVI8e/WSHjwzPQsS4iq9KsOxmdohdG9Z79e2WoGOche3aebPJ9CehZpjWeTJ77pl1ecq5+TnraTX2tCLN6bqnA5xTjaY5R3VdAsBWqO8RcrR4AhZZa+pWdvXa74/i9A0qac5fNtkCDmIc3+SLvMtD4CIunb1RzaTten8Dl4e1fs6wUzWe2S9KwM/IS7fzTlki8sw3o2hVCbFj9Yqwih78AVovVUQH5gTuiC0QbC5AybqhWsT+tSnx/1uFLT3yXPZkn8bLOzETIBcU0fHfrO/uiZBAE9vAV4PkuUMHlm+ZRBITkSFpqaAecBt4x75NVRVMDquNsbWX/nd9HHTQsz5GKYe9XQVAL9ifj2EA8iGmaaalFZkUlu9UMBJYrGhJIeBRHC8hQuQPzojt608wpzHanTSvpBX4W0lSCtdc7MV384rItxGXnRvlCnPCM+nOtrVQVJ6lV6l7hd+1yUVSdYRzuUqSmZ6crdNV+2bWSfY3bUB8ogB6vfeFjW3uWN+2QdJwHwKm7wa3wj4WSccHqvqEzzOsQXOtmT/lXeQ5l9T8O8LE+YCiy4TQxTd0VogiYQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21e6d4e-ae17-4b74-9de7-08ddf4a5c434
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 22:18:15.4642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0NagTrPw0WPGmcBP6RuiiLIONort0IFgs0BfoFcAMxcPXgfSie2vJCzRENPkybqxzWsl67Dmry4P26lY3xoRGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3943
X-OriginatorOrg: ddn.com
X-BESS-ID: 1757976737-104683-381-6798-1
X-BESS-VER: 2019.3_20250904.2311
X-BESS-Apparent-Source-IP: 40.107.220.131
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkZGlsZAVgZQ0MLCItHUzMTA0s
	ww0TAlJc3C0NzIyNzMzDTNItnCwNxcqTYWAN5rWI1BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.267518 [from 
	cloudscan11-206.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

T24gOC80LzI1IDEyOjE3LCBCZXJuZCBTY2h1YmVydCB3cm90ZToNCj4gSGkgSm9hbm5lLA0KPiAN
Cj4gdGhhbmtzIGZvciB5b3VyIHJldmlldyBhbmQgc29ycnkgZm9yIG1lIGxhdGUgcmVwbHkuIEhh
ZCBzZW50IG91dCB0aGUNCj4gc2VyaWVzIG5pZ2h0IGJlZm9yZSBnb2luZyBvbiB2YWNhdGlvbi4N
Cj4gDQo+IE9uIDcvMjUvMjUgMDI6NDMsIEpvYW5uZSBLb29uZyB3cm90ZToNCj4+IE9uIFR1ZSwg
SnVsIDIyLCAyMDI1IGF0IDI6NTjigK9QTSBCZXJuZCBTY2h1YmVydCA8YnNjaHViZXJ0QGRkbi5j
b20+IHdyb3RlOg0KPj4+DQo+Pj4gQ3VycmVudGx5LCBGVVNFIGlvLXVyaW5nIHJlcXVpcmVzIGFs
bCBxdWV1ZXMgdG8gYmUgcmVnaXN0ZXJlZCBiZWZvcmUNCj4+PiBiZWNvbWluZyByZWFkeSwgd2hp
Y2ggY2FuIHJlc3VsdCBpbiB0b28gbXVjaCBtZW1vcnkgdXNhZ2UuDQo+Pj4NCj4+PiBUaGlzIHBh
dGNoIGludHJvZHVjZXMgYSBzdGF0aWMgcXVldWUgbWFwcGluZyBzeXN0ZW0gdGhhdCBhbGxvd3Mg
RlVTRQ0KPj4+IGlvLXVyaW5nIHRvIG9wZXJhdGUgd2l0aCBhIHJlZHVjZWQgbnVtYmVyIG9mIHJl
Z2lzdGVyZWQgcXVldWVzIGJ5Og0KPj4+DQo+Pj4gMS4gQWRkaW5nIGEgcXVldWVfbWFwcGluZyBh
cnJheSB0byB0cmFjayB3aGljaCByZWdpc3RlcmVkIHF1ZXVlIGVhY2gNCj4+PiAgICBDUFUgc2hv
dWxkIHVzZQ0KPj4+IDIuIFJlcGxhY2luZyB0aGUgaXNfcmluZ19yZWFkeSgpIGNoZWNrIHdpdGgg
aW1tZWRpYXRlIHF1ZXVlIG1hcHBpbmcNCj4+PiAgICBvbmNlIGFueSBxdWV1ZXMgYXJlIHJlZ2lz
dGVyZWQNCj4+PiAzLiBJbXBsZW1lbnRpbmcgZnVzZV91cmluZ19tYXBfcXVldWVzKCkgdG8gY3Jl
YXRlIENQVS10by1xdWV1ZSBtYXBwaW5ncw0KPj4+ICAgIHRoYXQgcHJlZmVyIE5VTUEtbG9jYWwg
cXVldWVzIHdoZW4gYXZhaWxhYmxlDQo+Pj4gNC4gVXBkYXRpbmcgZnVzZV91cmluZ19nZXRfcXVl
dWUoKSB0byB1c2UgdGhlIHN0YXRpYyBtYXBwaW5nIGluc3RlYWQNCj4+PiAgICBvZiBkaXJlY3Qg
Q1BVLXRvLXF1ZXVlIGNvcnJlc3BvbmRlbmNlDQo+Pj4NCj4+PiBUaGUgbWFwcGluZyBwcmlvcml0
aXplcyBOVU1BIGxvY2FsaXR5IGJ5IGZpcnN0IGF0dGVtcHRpbmcgdG8gbWFwIENQVXMNCj4+PiB0
byBxdWV1ZXMgb24gdGhlIHNhbWUgTlVNQSBub2RlLCBmYWxsaW5nIGJhY2sgdG8gYW55IGF2YWls
YWJsZQ0KPj4+IHJlZ2lzdGVyZWQgcXVldWUgaWYgbm8gbG9jYWwgcXVldWUgZXhpc3RzLg0KPj4N
Cj4+IERvIHdlIG5lZWQgYSBzdGF0aWMgcXVldWUgbWFwIG9yIGRvZXMgaXQgc3VmZmljZSB0byBq
dXN0IG92ZXJsb2FkIGENCj4+IHF1ZXVlIG9uIHRoZSBsb2NhbCBub2RlIGlmIHdlJ3JlIG5vdCBh
YmxlIHRvIGZpbmQgYW4gImlkZWFsIiBxdWV1ZSBmb3INCj4+IHRoZSByZXF1ZXN0PyBpdCBzZWVt
cyB0byBtZSBsaWtlIGlmIHdlIGRlZmF1bHQgdG8gdGhhdCBiZWhhdmlvciwgdGhlbg0KPj4gd2Ug
Z2V0IHRoZSBhZHZhbnRhZ2VzIHRoZSBzdGF0aWMgcXVldWUgbWFwIGlzIHRyeWluZyB0byBwcm92
aWRlIChlZw0KPj4gbWFya2luZyB0aGUgcmluZyBhcyByZWFkeSBhcyBzb29uIGFzIHRoZSBmaXJz
dCBxdWV1ZSBpcyByZWdpc3RlcmVkIGFuZA0KPj4gZmluZGluZyBhIGxhc3QtcmVzb3J0IHF1ZXVl
IGZvciB0aGUgcmVxdWVzdCkgd2l0aG91dCB0aGUgb3ZlcmhlYWQuDQo+Pg0KPiANCj4gSSBoYXZl
IGEgYnJhbmNoIGZvciB0aGF0LCB0aGF0IHVzZXMgdGhlIGZpcnN0IGF2YWlsYWJsZSBxdWV1ZSBm
cm9tDQo+IHRoZSByZWdpc3RlcmVkIHF1ZXVlIGJpdG1hc2suIEluIHRlc3Rpbmcgd2l0aCBvdXIg
ZGRuIGZpbGUgc3lzdGVtDQo+IGl0IHJlc3VsdGVkIGluIHRvbyBpbWJhbGFuY2VkIHF1ZXVlIHVz
YWdlIGFuZCBJIGhhZCBnaXZlbiB1cCB0aGF0DQo+IGFwcHJvYWNoIHRoZXJlZm9yZS4gQXNzdW1p
bmcgdGhlIHNjaGVkdWxlciBiYWxhbmNlcyBwcm9jZXNzZXMNCj4gYmV0d2VlbiBjb3JlcyB0aGUg
c3RhdGljIG1hcHBwaW5nIGd1YXJhbnRlZXMgYmFsYW5jZWQgcXVldWVzLg0KDQpIaSBKb2FubmUs
DQoNCnNvcnJ5IGZvciB0aGUgZGVsYXksIHdhcyB0b3RhbGx5IG9jY3VwaWVkIHVudGlsIGVuZCBv
ZiBsYXN0IHdlZWsuIEkgaGF2ZQ0KdGhlIG5ldyBjb2RlLCBidXQgdGVzdCBpdCB0b21vcnJvdy4g
RXNwZWNpYWxseQ0KcXVldWUgZGlzdHJpYnV0aW9uLiBQZXJmZWN0IG1hcHBpbmcgaXMgcmVtb3Zl
ZCwgc3dpdGNoZWQgdG8NCnJhbmRvbSBxdWV1ZXMsIGFjY29yZGluZyB0byAiVGhlIFBvd2VyIG9m
IFR3byBDaG9pY2VzIGluIFJhbmRvbWl6ZWQNCkxvYWQgQmFsYW5jaW5nIi4NCg0KDQpUaGFua3Ms
DQpCZXJuZA0K

