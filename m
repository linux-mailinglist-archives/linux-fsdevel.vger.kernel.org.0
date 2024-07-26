Return-Path: <linux-fsdevel+bounces-24307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC1E93D057
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 11:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4511F216E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 09:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FCB17798C;
	Fri, 26 Jul 2024 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VeWM65iS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CB652F9E;
	Fri, 26 Jul 2024 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721985600; cv=fail; b=Lqftu4kpOTxxnNUkMyzoM6o3LaKyCnZjkj5BCZY1DOJrzh2iheVHnL6JgNa6rOwzsHIxhF2zkJx+cIafEHTXOyifOy2dkbDpINPjmwpfX+s91ZNxGfvW7TmzlsIByAZg2GBjZ3EuJRuSoOPJfhtb5jCnXBPAlV8Eynhw4p2ZKSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721985600; c=relaxed/simple;
	bh=vGioWeue69Jk1jyYsNMnwyG/x/YtebqmZqlNwKf5yW4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p9itJlD7yjJmWF+DbPWYgaVRQIFaNbt2XCmmXE4c0i8EFCnctAOt9szJ57QdpyyyJg3MTuNZJX7bfm4YrHljVKxyVu5bViuizUGgY9glq1ndsxnDLrq3O58+adpotUwIEDOAJslGQ6VFbGKPKHcKyhhh/A0HM6xTD8LmNdOpU2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VeWM65iS; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46Q7OvBx006783;
	Fri, 26 Jul 2024 02:19:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=s2048-2021-q4; bh=vGioWeue69Jk1jyYsNMnwyG/x/YtebqmZqlNwKf5yW4
	=; b=VeWM65iSqyhScBeQjcBuivorra3GXDhubSlemA081+4AyiaSLX9myA13/qg
	tq+9V9Ac2ZM3kKR1MpLN0xpzRXiHtiZ3B6wVB/SyJDy8RRcABzKTTusmd9v65ouh
	/g3d7YpBlwWbNAme8XRvoZEoWxS6YW9Tobx3eEjzQqWwJm96goo6TrbtBr3cY6/W
	JOAcxF/Ut/0vqk6IPYSTMvrofn77Dc+PrIx9z3471ajLmrYCls6zwaIgRuKafkl9
	YLXraILGchgOZMys1EbM0WF6uIdaOUAhuiWj/dP4hHheDno9022bm6HW6upjhsYy
	o60sM88e8VXpOm9ucmaHjA+/ZaQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40m7cr8f4x-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 02:19:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2hphsAkBL6UBbhAObjVcLCiV9fEPB9/bdutRdmT8VrEQFM9Btgkd2LcoYWcgIe4jEESO5sGeG9Gp53+f/XdA2vxTeNv02agC/YHFgIQZfIgPVwpjuUa5a1EP8ZLsrtOveunvtK25y+Pi+lpdsKkjY+eQ+xxMpYM8UQcmsM1wVKJSib8fp/nE6V2Yh6Rf2YL+Qne84CUCrLm0EYpY0BuzFPd47oRQCzJ60CH3EykgcaTqmWPaOZdxsNNwvmbqgkjPFphYhOi0PIb3oJDrzo76DRtC2lr8HGKU1LIKe1kXjOFE9+XjvHgf0WgiQjgjWBRXcx7e9QXso5qKR2WIzeZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGioWeue69Jk1jyYsNMnwyG/x/YtebqmZqlNwKf5yW4=;
 b=Hb0LabMR8F4hRnVR+5LFk47Tnc7HCluSFi2kuMSr079XX+p5qX7nHGZ0nvf3v0BSXyB1KsS7ewxK17eZb5YP3bAj3Ny3YHwUtKnvazKzo3Qmt2ksNVU2DhaqIrDqdWiGap3nRdI/ZGvhsbQPr9Vpj3J/bqstiLbxPsFCaaSaoBg7zD4Kost9obeAju2RXC40yt5vuaSLT0CCLumcvqPYynjrmFJJjtoXolGWqVVcqMzumcugNFzKZK6azdLci6CRY5+BomQ9LWs9Gu8h5u2qSOzVbnGIGC+WIVko+Xx1365RwDU2jBmurXc0lP5HGRIJFAuBYi50ulT2JZdCmpWHhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BLAPR15MB4052.namprd15.prod.outlook.com (2603:10b6:208:276::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Fri, 26 Jul
 2024 09:19:54 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 09:19:54 +0000
From: Song Liu <songliubraving@meta.com>
To: Christian Brauner <brauner@kernel.org>
CC: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux-Fsdevel
	<linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel
 Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com" <eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Thread-Topic: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Thread-Index: AQHa3u0J3x+q9TWVEkq4VV2cIBgMWrIIlswAgAAlQQA=
Date: Fri, 26 Jul 2024 09:19:54 +0000
Message-ID: <1A0AAD8C-366E-45E2-A386-B4CCB5401D81@fb.com>
References: <20240725234706.655613-1-song@kernel.org>
 <20240725234706.655613-3-song@kernel.org>
 <20240726-frequentieren-undenkbar-5b816a3b8876@brauner>
In-Reply-To: <20240726-frequentieren-undenkbar-5b816a3b8876@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|BLAPR15MB4052:EE_
x-ms-office365-filtering-correlation-id: 03dbf38b-b4ce-4d7f-4e29-08dcad541c93
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZFFDV0JPSWEweklCNTNmckNNUm5WMWFXUnByNVl6S0NLdGFVZ2s2cGtMZUNH?=
 =?utf-8?B?dXl3TVRMRFlqU1ZxRHNEbXlUa09vUmRndkFDaGhTaWk3bkpNUkxtZnNPa3do?=
 =?utf-8?B?eFVIZjlvVDE4VHR6a24xenZUV252b0oxTWE4cVVzZUJUTjNVeWNOeEpUOVFU?=
 =?utf-8?B?RWNFOEw4eDhZSnU4T2Eza3R5TUVkQmNVOTQydU1mc1NFVGIzMkU2cEN0a0la?=
 =?utf-8?B?VTl6c25JNHl6QjQ3eGJwdi9RaGF0aVlKWG0zL2d6S083cW9WS0ZkZ0NJOTRa?=
 =?utf-8?B?T3Y3alMxd3JrVE81dHlYZXdlVWNCdncyQ1d5Yno5ejVPaEdYUWRrOE1KVDU4?=
 =?utf-8?B?SVdBSm5iQ29kNlZLTkNwRksvbWowZEhFcmFpQStVeW53ak5UNFZtdzdLd3l5?=
 =?utf-8?B?MkQ5a1dVdExDWVVTUjE5bzl4bmR4TVdhd0E5NmZsT2M0ZXFZUlk5SGJRNTRF?=
 =?utf-8?B?eHcvV3ExOTRVOFIxT2dZM0pyNjBXRFJUR2t6Q0htWEdPdTZPOVJQeHBLb3ZU?=
 =?utf-8?B?UHFkKzlSSXcyRGNjREE0VHk0TVNmWFpUZ2MvZzJWTW1QWVdWOHRvdml3Ly9n?=
 =?utf-8?B?bmU1cW1oRzRPZ1pCOCsxdzljWURHQVpNSmFLKzdUMWV1d0ZiMlduS1N1bmcw?=
 =?utf-8?B?N0pZY2dWdVB6M0lvSEkxU3FEbWFlczVZSDFqM3VKNnk3aGxpZVZQZytKcWt3?=
 =?utf-8?B?NXY5Y1VMS21TaSt0cWsxdTc1RHIzNnUxTjRkc1ZBU2xBSWE0MWpkWmQwUWw3?=
 =?utf-8?B?Q21XWEthekwyU0xTblVDOTJvQlNicU8veVBENVA5OXBKbVl6YlNETEtmYkov?=
 =?utf-8?B?Q3BzeS9LOHdES3Z3akwrdFU0TEV6NlJYdTNVSFNLNWl2TzFzNkFyVFpJYWNo?=
 =?utf-8?B?UkozU2ErR1lmSVpKUGJZQmVhOExLY0hWKzBFSmNQaFgxcDd0a3VEa2VYKzJ0?=
 =?utf-8?B?U3pBT3ZLR2hlTnlHVnhBWlo4QVRBblZ5TVBUd1AyTC8rNFJYYUJnYTF1WDM1?=
 =?utf-8?B?ZTlQZWxQY3JtNnBmK2lsN2laNTJDUy85NENSLzdJT3dqZGNtTHlCWmgvU2ZV?=
 =?utf-8?B?K2g4SDN0eDIxMExCcmR5Q1lQV0tNS2RxQVMySW9Cb1ovWlFjc2gyaVM4Z05j?=
 =?utf-8?B?d21rRDhoOEsrVXJvSldSaUlZbXI3LzZkUUFtY1MyRHhlR1k0MzcwUnQyMHEw?=
 =?utf-8?B?N1JBNWFUZ0ZQeHdHU1AwZnA1REZ0c3F6ZFdRZHoxV1F6WU9JVmJlYURXL1hK?=
 =?utf-8?B?WnEzZTdUWnlKYUxDMWZXNXg0Mi9XeDQ4TVc0YnJ6WW5sU3YvM0pkT3I0Q0Jm?=
 =?utf-8?B?VWpOdTVuVTVMOS95ditGSThOSnliMjdDNCtDOXp1S3Q1ZS9LbU9JUURxMVIr?=
 =?utf-8?B?Q1JBUGJ3cmxwNEFEODRFblpwOGp5dDJBQ2FKUzNjQ05oVm4valU3L1dKSGxM?=
 =?utf-8?B?N0dueERHMWI5TTIwdVJxdGJZb1l6NUhUNVBmL2czdWpUTFhLRUlWRGhva2hY?=
 =?utf-8?B?VUg0NVYrZ3QxaW1jM3Z4QUtEbTVOR3gxQnYyVVNpaVFwbVZLK0wzcmxMRlNj?=
 =?utf-8?B?cFpjbGZqZ1NNOXZxMTQrKzR5cTlrN0dwV3pBeXIzcVhNeGwrVmJpZjNNa0tN?=
 =?utf-8?B?QjR2bTRHSDFXOFBOSUYvVjhKcEpXNWV1bFRzZlBHNGN3a3FpS1hzK3VzWVNm?=
 =?utf-8?B?RSt4WmI0UXB4Nzh4eEtZQUx4YVZkRmprYXQxRjhuT3hLYnRUVTgvK29neXcr?=
 =?utf-8?B?MEJHMDFJYzJHaVI2MkJNWjZBcDFtamFVZ2cvVFMxS1hTV2h6Mi9ldGdqVUc3?=
 =?utf-8?B?a3hubUdKS0tjQ3ZPVHE1MVo3dlVhT2JpdDBaR2pDLzJ5eHpxQitlN2pZczVG?=
 =?utf-8?B?U2xjMjE1RTJrcWZ3bEVtVEJEUmF3K2o2ZFB6Z0liZ05vbVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NXU3aDM5Y1pGSVIzYTFNWjhaOTdtNUNSbWlFR0NLMWE3d2RYWm1kWlA3OHlr?=
 =?utf-8?B?R21CL2N1QTgxSzcvUmtGMkRqUnp5SGU1RnFVY0w5S2NuMmJKSlllN3IwRFFR?=
 =?utf-8?B?UG9qZStDTFBKNVhDcjdLQUhwcHhqakZiaEpuNlhDQm4rN3c5V3haTFNhM1di?=
 =?utf-8?B?ajM1cDNjcVgyTlU5SWxwUlFWck5seFFLMzlvcU5XZ1VkZHg0U3I5QnZTL3J1?=
 =?utf-8?B?c1lHbWZ4Nm1tVE40eWk2Tkt1VDFNTDRoZHpxaUVoZWh3LytUM040aERQdjRM?=
 =?utf-8?B?UXBScWN2NmFOT3MwN3FVV3h3azF2U3htTTVqZ0Z2NGVIcnBaaCtTRkZ4OW9O?=
 =?utf-8?B?ckhrQU5hZDc3dW1JaW8xZ3c0UGFhNUcvRnVqN2ZuYndVdUVaamdqS1dKeTlZ?=
 =?utf-8?B?cWk1R05xSVprNXFFR2swMksxV2RITDVvVFpuMkM5SzN3aCtNL1RyMk5BeTJE?=
 =?utf-8?B?TkIyZ05GQW85VDRockV4UjlZcFdkZlpzdjJhQkl2elRkMnNETHB6d290SVJl?=
 =?utf-8?B?Rmt4T2JLa0JxVjB0elFhS2F3a0trUnpmNkwwRENXczRmQ0ZRSnlSTDFNaE9Y?=
 =?utf-8?B?WDRMdjZYYkwydTBWU1J4RGl2WFBLOG51ZWZSTGpPdG5hWkxVeVltODVQNE5t?=
 =?utf-8?B?cXFmaU1tRVVMM0FIU2ZJak52alBuK2VhOW14RVpPS21NakNOTk4zbGxuVUE5?=
 =?utf-8?B?TVJZVzNWSE8rSTI0WExMTUlzTEdzWWg2Si9rWTZ0VGlSWmNxTkxWL3pVNVg5?=
 =?utf-8?B?eEIyUDZqLzc0N1MwV1orK2pqb1h6WFdJYzRkOWxHMGdYY2VhZytqQ21SaFNQ?=
 =?utf-8?B?VzVqRHVuR1hmTzJHOUhDQVdYUzIrWGFLSHlUejBadlI5VmdjaHdYYkMxMFEy?=
 =?utf-8?B?bVo2R0d4dHY0L1pUVnNKekpUc0JkeisyTEVUSUthSTBTR1NpaCsvZVpKOGd5?=
 =?utf-8?B?Vk5hY0M0c0EwTmZGOEVCOVB2WFNkK2V4UHBkcEhMazltY2R2YlFpZW5jc0E3?=
 =?utf-8?B?Y0k0TnUrTGkwQ1QrY3JZNmttMDJ1dFpwcy9kUE9ucGFrcWlxenh4TWd2YlVN?=
 =?utf-8?B?MXJueHQ3eER5SXU4RjNlM0RmZnpDemgyUk5BUUZXRHhNTHIwMVJ1R1BSbTly?=
 =?utf-8?B?b0FMc3hnNkIwR2JNeWEzQkV6VUE1RkMrWCttQ0RSd2NadVQ2RFpUaklZY1Nm?=
 =?utf-8?B?ZzFxbzJYdUpaR3BMRGVGVUlGdDI1REFWU2FVTCtXS1JOM1NKeWl0Zk4xTzVt?=
 =?utf-8?B?QjkzT0RGWFVMdVJsWUFKU1BPSCthSER4aXhQR0d5eFlqMHdMUmN5NFNIeXdo?=
 =?utf-8?B?MkJVR2NYeUZNTXdZbjJjTlVmQnh4STRFSHRmcDFQelFpTE4vRFRabnNHbFFi?=
 =?utf-8?B?ZUhQRHpKeS9pTHZ6Y0h6bHFpQ040ZWkzZlZtMm1YV3d6RmFyRW1jUy9wZHhT?=
 =?utf-8?B?eEZucWJZRTdkS2laanRrVklCMzNxNXo0QnMrVVEzc3hRR2RtTFpCZTVVdjJB?=
 =?utf-8?B?MUJnWDBXano1eURFeGxZSVN4Nk1hYThsekxSY1BuRElSMUVDZThiK3VRanBh?=
 =?utf-8?B?WjE4QTBmOXN0VWtsWmlHcHF1eXlXS1JoWFd5SVpiek81cFl4akxoZ0tRWmRI?=
 =?utf-8?B?K0dHYjBmdmtwMjF6TDJxREJESUtpVEVUWVh2dmU0cHBaZVljNWs3T3l6d2tp?=
 =?utf-8?B?MVBPUDEwWGxKNTdlaEZvNWZBVmxWSEx6WDBJeXhZVXREQ2FRTnYzbEU5b3Zs?=
 =?utf-8?B?TE1rTmhWbVVQenJ6Sk9xa3paNko5S2srR2pmS2c0alNzN0hZTGtxUE1GSEo1?=
 =?utf-8?B?K2hoU3ZBb3BNdThDRlNBb2V0UTYwNnRYczVnQzNUejdtRVRJQTZOclJxZXFQ?=
 =?utf-8?B?NmhseWhtLzN1WkxCYzdrd0tzbytiN1NLRGF2NnUyb1ZmNm1TN2VuMytMbGt2?=
 =?utf-8?B?dzNQSUtYUVJnbHZRN2hWcE9HSTdUN0tsekltVzJXZjhHYTljRU1VeVBMMHJQ?=
 =?utf-8?B?SElyMUhJNUtwR2NlM21uTnFXczRRTEZpM0VEVmxPa1FxV0NQck5rNmZ4M3VX?=
 =?utf-8?B?Lys3c1FkdnFBUFV2REZHUHUvSTBYV0tHd0Q2aW9Pb2xnVWFJNWJMOHpscGN3?=
 =?utf-8?B?NVN1Zy95RXBXWE9uUkdoQ2szWGFOaWN6eW1wVWVQblowdUdzZ3lVQWx5QzFG?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7C6D3A1C372B4438A10A7E620B7B11A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03dbf38b-b4ce-4d7f-4e29-08dcad541c93
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 09:19:54.7701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LIwQ63s1vA3IZp4+AucO9sgmXvZhMU2AK4lBGNeaeQxvmy46BX/H+sI/871PzYjWLo0bCqM8PMP4LvWC1Q3o/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB4052
X-Proofpoint-ORIG-GUID: rEoXjoxy1tjtg-bVxlwtpBM_1i9AtChG
X-Proofpoint-GUID: rEoXjoxy1tjtg-bVxlwtpBM_1i9AtChG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_08,2024-07-25_03,2024-05-17_01

SGkgQ2hyaXN0aWFuLCANCg0KPiBPbiBKdWwgMjYsIDIwMjQsIGF0IDEyOjA24oCvQU0sIENocmlz
dGlhbiBCcmF1bmVyIDxicmF1bmVyQGtlcm5lbC5vcmc+IHdyb3RlOg0KDQpbLi4uXQ0KDQo+PiAr
DQo+PiArIGZvciAoaSA9IDA7IGkgPCAxMDsgaSsrKSB7DQo+PiArIHJldCA9IGJwZl9nZXRfZGVu
dHJ5X3hhdHRyKGRlbnRyeSwgInVzZXIua2Z1bmMiLCAmdmFsdWVfcHRyKTsNCj4+ICsgaWYgKHJl
dCA9PSBzaXplb2YoZXhwZWN0ZWRfdmFsdWUpICYmDQo+PiArICAgICFicGZfc3RybmNtcCh2YWx1
ZSwgcmV0LCBleHBlY3RlZF92YWx1ZSkpDQo+PiArIG1hdGNoZXMrKzsNCj4+ICsNCj4+ICsgcHJl
dl9kZW50cnkgPSBkZW50cnk7DQo+PiArIGRlbnRyeSA9IGJwZl9kZ2V0X3BhcmVudChwcmV2X2Rl
bnRyeSk7DQo+IA0KPiBXaHkgZG8geW91IG5lZWQgdG8gd2FsayB1cHdhcmRzIGFuZCBpbnN0ZWFk
IG9mIHJlYWRpbmcgdGhlIHhhdHRyIHZhbHVlcw0KPiBkdXJpbmcgc2VjdXJpdHlfaW5vZGVfcGVy
bWlzc2lvbigpPw0KDQpJbiB0aGlzIHVzZSBjYXNlLCB3ZSB3b3VsZCBsaWtlIHRvIGFkZCB4YXR0
ciB0byB0aGUgZGlyZWN0b3J5IHRvIGNvdmVyDQphbGwgZmlsZXMgdW5kZXIgaXQuIEZvciBleGFt
cGxlLCBhc3N1bWUgd2UgaGF2ZSB0aGUgZm9sbG93aW5nIHhhdHRyczoNCg0KICAvYmluICB4YXR0
cjogdXNlci5wb2xpY3lfQSA9IHZhbHVlX0ENCiAgL2Jpbi9nY2MtNi45LyB4YXR0cjogdXNlci5w
b2xpY3lfQSA9IHZhbHVlX0INCiAgL2Jpbi9nY2MtNi45L2djYyB4YXR0cjogdXNlci5wb2xpY3lf
QSA9IHZhbHVlX0MNCg0KL2Jpbi9nY2MtNi45L2djYyB3aWxsIHVzZSB2YWx1ZV9DOw0KL2Jpbi9n
Y2MtNi45LzxvdGhlcl9maWxlcz4gd2lsbCB1c2UgdmFsdWVfQjsNCi9iaW4vPG90aGVyX2ZvbGRl
cl9vcl9maWxlPiB3aWxsIHVzZSB2YWx1ZV9BOw0KDQpCeSB3YWxraW5nIHVwd2FyZHMgZnJvbSBz
ZWN1cml0eV9maWxlX29wZW4oKSwgd2UgY2FuIGZpbmlzaCB0aGUgbG9naWMgDQppbiBhIHNpbmds
ZSBMU00gaG9vazoNCg0KICAgIHJlcGVhdDoNCiAgICAgICAgaWYgKGRlbnRyeSBoYXZlIHVzZXIu
cG9saWN5X0EpIHsNCiAgICAgICAgICAgIC8qIG1ha2UgZGVjaXNpb24gYmFzZWQgb24gdmFsdWUg
Ki87DQogICAgICAgIH0gZWxzZSB7DQogICAgICAgICAgICBkZW50cnkgPSBicGZfZGdldF9wYXJl
bnQoKTsNCiAgICAgICAgICAgIGdvdG8gcmVwZWF0Ow0KICAgICAgICB9DQoNCkRvZXMgdGhpcyBt
YWtlIHNlbnNlPyBPciBtYXliZSBJIG1pc3VuZGVyc3Rvb2QgdGhlIHN1Z2dlc3Rpb24/DQoNCkFs
c28sIHdlIGRvbid0IGhhdmUgYSBicGZfZ2V0X2lub2RlX3hhdHRyKCkgeWV0LiBJIGd1ZXNzIHdl
IHdpbGwgbmVlZA0KaXQgZm9yIHRoZSBzZWN1cml0eV9pbm9kZV9wZXJtaXNzaW9uIGFwcHJvYWNo
LiBJZiB3ZSBhZ3JlZSB0aGF0J3MgYSANCmJldHRlciBhcHByb2FjaCwgSSBtb3JlIHRoYW4gaGFw
cHkgdG8gaW1wbGVtZW50IGl0IHRoYXQgd2F5LiBJbiBmYWN0LA0KSSB0aGluayB3ZSB3aWxsIGV2
ZW50dWFsbHkgbmVlZCBib3RoIGJwZl9nZXRfaW5vZGVfeGF0dHIoKSBhbmQgDQpicGZfZ2V0X2Rl
bnRyeV94YXR0cigpLiANCg0KVGhhbmtzLA0KU29uZw0KDQoNCj4+ICsgYnBmX2RwdXQocHJldl9k
ZW50cnkpOw0KPj4gKyB9DQo+PiArDQoNCg0K

