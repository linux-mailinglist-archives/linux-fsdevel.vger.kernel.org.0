Return-Path: <linux-fsdevel+bounces-31821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5285D99B9C5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 16:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14521C2091E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 14:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DF614601C;
	Sun, 13 Oct 2024 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="euIMs9ph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AC413D50A;
	Sun, 13 Oct 2024 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728830777; cv=fail; b=p/Ae7N8s1xP6NCq1mklymp4n4htQELxrPRinnxxe0TEYDxU1mgJMH9UmEkWqDewKT/hkbSfmwIQQchBjYPAXYgKDIGp8NFLIPGrYKxJD/t3PpVU0F6BRKq/hCJYRD5/SVNBkSBQLbwLXtUQkMQ2Sh+jtHm9TUAFAzr5dQAU6Yvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728830777; c=relaxed/simple;
	bh=n9MCblUixWRLlGYf6XOSt6cby4jJO3ahtN5+e8rPyig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QuQEWaNleMBjHM96EZo7j+nTYvs1zl1T/x4daGbfgSpxASoSNEPFVCHOOwh4Rjcje6jl05cX5twxBpsqYO16HwfW+aYC0zUP8AMqEV114GiuybbL4GqwrsbEsyRmny0J4yWUtM4gLuD08q2wVARe+gxjWP5mD0oUDvZRAp9qixs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=euIMs9ph; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49D5ictR022324;
	Sun, 13 Oct 2024 07:46:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=n9MCblUixWRLlGYf6XOSt6cby4jJO3ahtN5+e8rPyig=; b=
	euIMs9phquvYh4baIj3yH1g4t/T6NBdk7CFOJd+QBqixQ/CnZrQY3mNoJfSZIePq
	pXzphNILgH4LK3KZNEYdSryXCt7h4Nep42ctpDAHZcPBUsi4swRZOt+gpb0HX0z6
	Si3j9BdE3XRRIfhV0Mlx9KCN1x+C5+7BenIUAqmFAAUBeKUDrrpPiRRojO7MPWdo
	7Aa1e+RaRuGumb6E2PfjLByvbzHFuxAYq3oV+n3Dm06UcbYe54Qd9XpNWCfD8CUn
	DgyihF5tDoz8yXkFVBARm3qSBY9FyxWAZK+hNeFaHZoMppNndh+DfgjSH8cUQSqo
	hCn80fvK16oTlPAH4To6fg==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 427p7umccb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Oct 2024 07:46:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmyPZLPVA6Crv/r8frWIysS+VP7SMc9LUY9tCDJHciDkTZTAQcNk31Vwn8BXBlhpJ8tGQ3TOSFxF6Sav3mzc1yPgCI7CmT8mquMnJ3o2AqpXecIO9FtRacHLfNmplWt35CLxC3pEFyeIp5C8mBJsHAT3jXu3ns+Q9z6sz6ogeOaecjqhhcToWDvUCB7hUeC48e2x3MKd5UEKEho6trcRcZwUZmSg4+TReyw7K4H6Ah7DSWZQqnugBGYQP956PJpsuhp8cY4tslq7Jf7F64PXg1EHklhjDl5tdVFRk76qz/axa9mFa3hBa5WaxpsOYuPGDvUqCYMJ73YdGIuxbqyAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9MCblUixWRLlGYf6XOSt6cby4jJO3ahtN5+e8rPyig=;
 b=I4mnSZznBUgdddG7VmL8WJhnJ2rNVn+FCtKm6JZYGAt5X8lwmS0Qv4GC/RAnCGs3RKVyKStYQjecSAYUnF8JNRKl/x1+odW94nFxxlxRJaEGMAnDUp1E5yyCeeQVSAkgqVBsZJyNTInSLX8XOSk7wMWUvzMV2vEB3o1kKS1JvgVCGKm/XCo8G7IgpVy5SNZy+0R1a/GQV9lC6YDdx/1guYGBgWKWT54K89JZb5G6lMEbfsX0HforjcL0NtgZTXy4TF7DJtGzP9umZTVtoRb7awb8M2nBeypxe5rE+AuJZjsOpVxj0mO5WuI8bMSxOSTrEUvLDfvmNftPaWQ1aGWFjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB4997.namprd15.prod.outlook.com (2603:10b6:806:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Sun, 13 Oct
 2024 14:45:54 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.8048.020; Sun, 13 Oct 2024
 14:45:54 +0000
From: Song Liu <songliubraving@meta.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: Song Liu <song@kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM List
	<linux-security-module@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"
	<serge@hallyn.com>,
        Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH v2] fsnotify, lsm: Decouple fsnotify from lsm
Thread-Topic: [PATCH v2] fsnotify, lsm: Decouple fsnotify from lsm
Thread-Index: AQHbHQYU7IXwvol1R02dEc1wVkE4brKEbUeAgABV1AA=
Date: Sun, 13 Oct 2024 14:45:54 +0000
Message-ID: <AE7ECD50-A7DC-4D7D-8BC7-2A555A327483@fb.com>
References: <20241013002248.3984442-1-song@kernel.org>
 <CAOQ4uxjQ--cBoNNHQYz+AFz2z8g=pCZ0CFDHujuCELOJBg8wzw@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxjQ--cBoNNHQYz+AFz2z8g=pCZ0CFDHujuCELOJBg8wzw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SA1PR15MB4997:EE_
x-ms-office365-filtering-correlation-id: 5a43ac9f-f7bd-4118-273f-08dceb95bda0
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MlEvUTMzeDVxQWEyUGpaemRlbnpIQXF3WHlUaUptUUpObFp1L1A1Z1c4bHVq?=
 =?utf-8?B?OTZXQWJkTlA4SWs5M3FLSUxHUXN2M3hlUnR2UkY4Q0VaWXlheEp4dXBCSnhK?=
 =?utf-8?B?Q01OOVBGOXF5bm02MTZJM0RNcE9hYzkrQ1JTaDZvNmdkaEZ4UnIrdWM5RWJU?=
 =?utf-8?B?V21mRHcycEN2MkdVdjFlS0Q0ck5qNzlFMTlOMXVrUXA3cEpFVkJ4Sm8yZGxl?=
 =?utf-8?B?OGUyMWpFTUhZZ09ya2pqbWN2MHdqVHU5aXdXeVFTcVFNdy9yVWpTR0NLWTVB?=
 =?utf-8?B?VmhlWGkvQUxPMzFSSnpNWm1mYzBBbGVlS3QzMEdMZGlFZUh4QmduaTh3NW01?=
 =?utf-8?B?UFB0YjU3K0J1V2Z5T1RVb2RwYkxCRTdKUVdpMTB3SVVybTRIWitVWHNVTEJx?=
 =?utf-8?B?SzZZLzZwbnAxTHZBdmJvbkYxNlpjNVNaRlVOMWRacXJBUVBtUHN2LzNWNk9q?=
 =?utf-8?B?MXo5cjJhcnkyMS83RlhicGNteFlvdEkwRmZIQ3lUZW1rTDN4d1pBYVByRnFi?=
 =?utf-8?B?MklhcGk1QkpwaE1GN01TT3p1WmIvempuTERLZ2ZyblFvaURXSHY3bmduK2w1?=
 =?utf-8?B?MUhuSmFlTVBtanhSNjVoL0N6NTk4dzVCRWI5N0h1Qzd3SHBTL2tCTXIzeFhX?=
 =?utf-8?B?N29jS2FkY29xaktYTFQ0Q200cW00RHdGTy9jQVBzNXdKNUZCK08wSUE2KzNi?=
 =?utf-8?B?NFE4Vi9oSGJHMnlRN0FYZ0FRcjYrZ0c3cHRLZjJLNnd4RUtQRm1mdVZYa2RN?=
 =?utf-8?B?VzM0OENwaElPTmdxZkoySk5lQ2p5NStxaEpJeUo5ZG5sNEZOVWMrcDd2eUZq?=
 =?utf-8?B?SVlBcS93R3ljZ09pL3k1bS9PZjIzNTQ4WVFZdlhjdUhVR3ZpWXpTTTlwd09R?=
 =?utf-8?B?dXBGNGp4dWFZKzZKV0NtbDduTkNSc0piNFdkS0dOemd6T2dMajJtK20wRUVs?=
 =?utf-8?B?ZWNlRWNzZ2xSMDZVakhZdE9rcmUxdnRzRDlVMnAvNnpleG90dlRacWlqREZ5?=
 =?utf-8?B?bXVTV1B0M1c0RzN4MzZPaFJkamhQdjJ5YmNjM092YngvTEROYVFzcndYM0RI?=
 =?utf-8?B?K25ZVmpZMnkzQVozYTFwTWI0UkF3TEJORDhDNEdaNHBYb0NJdi9oMVF0cnIy?=
 =?utf-8?B?UHU0TmJUZnJIdE9TTEt5d1Jrc3hub1ByN3hlcnp2azI0UWRHNmRESXBtak51?=
 =?utf-8?B?ZWpZQytOTDR3VUw4ZzNVb08yQ0VkZFZBbUp1UVNxclhzdE5GTVZTYnZRSStv?=
 =?utf-8?B?SUJHS2oyUTNpbmpPeEJ2YWxxMmJKNXlpREQ0RnBmcW5wcUQ2WFB1SmNWWUd0?=
 =?utf-8?B?eDdvMEN3MzVBRmRPRkk5RVVsQURXVDRHOXR5MVh3R1RiaWZwN2lMSFpFOFA4?=
 =?utf-8?B?YUtiYmZwYjU2T0pCMWtyeW1SZEtZcUQvMFJsaEZoZndtNWtscnZSTTB5YkJP?=
 =?utf-8?B?SVpwN1ZUOVpSWTZyVk9hQ0MxaXNKeHI1d3dtbWRYbEMwWElkNnhuMTZ3aGdT?=
 =?utf-8?B?ZXRLOVI4VHc1bWplL1ozWm9sM2FaUHJMcGpyMHVBY21PTmJrcmdoalVTdEJx?=
 =?utf-8?B?Y3NHdDNmTllHbENsSG1pTU4zTWNSMG85bVJnZFE4Y2dYdHlCN1d3bVlvNVJ2?=
 =?utf-8?B?UjNaTk52L01vYm83eEs5c09RZWtHZ2M5WTIvTHltK25pVmFzUVExN0F6eW5z?=
 =?utf-8?B?bEV6WUw4cWJDTlFFeEovaFFQWlNQYURxMktLR0tRdkRhUXp2dVZwbTYwbG90?=
 =?utf-8?B?NEROOXpJZjlRQmhKQzdVNnNidW13THIxdm1aZktxNWMwaHA1SVVnTjRFZ3hY?=
 =?utf-8?B?eXI5ZkJPdFpLbVU3bTZlQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VzdiK3d1SVpXUXJ5UnduSk5VYUtQd3VZUXk2NGc1T2lISFcyNElFRjYvVzRS?=
 =?utf-8?B?eFh5aUJ6YTBvK2p5ZGFSL0liRG0vSDZvL3dsYTZldGdId1g2eFJUWEpSdzJt?=
 =?utf-8?B?My8xT21rRGVOOVNQaEFwaGhxZUlPMDk5VUwzV0xqTndSbGhxdHN2M0diT25E?=
 =?utf-8?B?aFcwN1VHdzRudklXS0ZXVEZXcU8ybU42RlF1a05nUkZjczlCaGVOTkNhMXdl?=
 =?utf-8?B?TDVPUWZwZ09HZFRzcGFnYzdQY016cWpLZ2dvdDRCblI0YTZnT3JXUUYxYVZZ?=
 =?utf-8?B?RWd1YzVWbXVUQ2JQbUtqK3NSSUtNc2V2Um9ZMU9CWjdIMmhwUXB0MGtqNFJx?=
 =?utf-8?B?c1VObjYzV0pKNERFaEpmQXMxbGZaVWNXNkFzeDc1UCtxb2FsWWtqakkxRnBJ?=
 =?utf-8?B?c1FNK25rTW9GSUJCMGRsRzN5ZVlWc0xyOFdMUlF6Q2M5NlNoM0R4dThYalZJ?=
 =?utf-8?B?RzlmTDIwQW05bHVUNUZGRis0U09Oem9ZcnBYMHVXR2hsTTJKMytvcWZjbHl2?=
 =?utf-8?B?V0dweG1RTXBJZGRXc0hacnlSbkMwcmF0SkhIeUhpSVZiT2RKRWJvYUd2RzRU?=
 =?utf-8?B?bitJaVUyckY2ZGpBYnJ4NE5QQ1BOc3NiazhpdmdJZVJDWSsyaitMSHJnZ2sy?=
 =?utf-8?B?d1R6MjlWcm1aQThZSlFPaTM4UVVLcVFML2NDZGsrd2lNM0dxMi8vTlpOR1Z2?=
 =?utf-8?B?M25ZRXI4SG5WRFlYYTc0WFJvRGxIb2VVQitFSHExWTlNeHlFQmliRk1Damox?=
 =?utf-8?B?OFdYQ0hPOFoya2NmdERic1czSWVPQ0FrRnNiVDVOYlJFbjNWQXhYV1lHTlhB?=
 =?utf-8?B?NzVUeW5pZ1ZwL2VBSWpWRGVZTE15QnFTejlVSnFtRjArbXlmUVJ3c0V4cVJE?=
 =?utf-8?B?aE1WL0w1Q2F4bjdKNUttZFlJRVR4TEVoU2Nsai9zWC9UVFdBRnp0azRXckdN?=
 =?utf-8?B?LzZpYTh2eDgxTmpXQTVhaDR4YXZIZERidzZ5Rys4bDJMMG5NaGRReFNZWi8x?=
 =?utf-8?B?NmVUdUhJTkkvRFlvTjVqUkdDelZ6NHF6RHpBcmlXRU9uek12NmpaVkdhYTdZ?=
 =?utf-8?B?Rk52ZlIxdUY1ZGtLVjFjSGNNeUx6cG9STm1KbGI5RTdxbSt6M1NXa1V3UXIw?=
 =?utf-8?B?ZFNYcTNzVy91dTlXVTNnOFBETjBMWU0zQk5kZldDNE5iYUpyUFRDWXJrcWg2?=
 =?utf-8?B?TW4rSHkvV1BoTXg5cm1JUWgwb0k0ZERPWG5qa3V1OGZSUDRLd1lxVDFuRVBk?=
 =?utf-8?B?VFlqMk41UGNYYTlZTFFETG9iNlJpT3FHbHV6QTRFWkRsbW5CSExhbC9zVFQ0?=
 =?utf-8?B?ZGI0L3VhK2FMVmU0N1RiUWV4ek55T1lzYmZMQjZ3S3prdGk3d2NZbE8xdkMw?=
 =?utf-8?B?cWNVVDREbnRxREQ5K0Y1YmhaTDlmRHMwU2kyQmUxUmZ1Vm4yNVZGeXN2US9o?=
 =?utf-8?B?eFdSMnZzNWlVZGVFMFVrRy9icE1vMTJTajJuTW9NOGRkM3NYRWU2TVRFcFZy?=
 =?utf-8?B?S3NKTENyYk5sdlhDcmYyVkE4YWd1b0xBL3ZpRy9LMmpXTS90aGFXVS9leW5X?=
 =?utf-8?B?MjZvU2N3THZSTllsZEhjTHFTaUZDZm9haXMwM3ZBWkZuSm5VOUNhbCtHaElp?=
 =?utf-8?B?emVYVmFpcm5ScHdnUkFWMTB3MlgxNkFWYVhOMmVqdXJITUFpRWlHQ29TdWJy?=
 =?utf-8?B?Sk4rTi91cENsUDM3TlNEWEVnWG1PK2xSY09wR25CcU5UdlVKNzZoemttQUlW?=
 =?utf-8?B?QWIxMUIwOHJVSGtGbnJrdkVZK3NxY1BtQW9DeG1Pa3psRzFNN1ZMSVdqMER4?=
 =?utf-8?B?Q1ZXZ3hwTnBuSTk4bkZmdXhpUVVGOGgyR2x2WGF4UWZoeXNxWC85eGJWb2t3?=
 =?utf-8?B?WVh5a1VzdWxOUXpGY2IzNEtZQjhRYk9obzNnNHNZWE5pb0VlRHYrSGxKK2xa?=
 =?utf-8?B?OUFIMGJDNjRlUVloNGVUcTB1M0dGVkZVWHJ0M0hmWHh0bmFMSDRlUyt5NVNa?=
 =?utf-8?B?c2xydVJGY0FJRTNhaXFKZS9ZMGpTQVh1RzRzTVBGT0NlQUJiRGMrN2VKaVJZ?=
 =?utf-8?B?VVljY1VPUjlhNFpCZXR3Z0p2VkVTd25hcC9VQ0JXOVorZFdxL1c4ZmZ4aFJV?=
 =?utf-8?B?OFJhTjhkdW5TRnk0RExLckEzNXlUdkdQajQwWmo3UEIxRXNIT1hRbTNhWmNN?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7530F0A43B0A8C43A1F9F07F940C98E5@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a43ac9f-f7bd-4118-273f-08dceb95bda0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2024 14:45:54.3663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jQyfp9S+QRSDLX06y1uFcf1wmQpAX/4W/+vCy5ZAI+yyocjffSyO0bNRI2Q7HqP45sfj/caxnHQVJm45NyltKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4997
X-Proofpoint-ORIG-GUID: 0G8pBUNlU05Sijl8CYwqpZ0kK3XvJr54
X-Proofpoint-GUID: 0G8pBUNlU05Sijl8CYwqpZ0kK3XvJr54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

SGkgQW1pciwgDQoNCj4gT24gT2N0IDEzLCAyMDI0LCBhdCAyOjM44oCvQU0sIEFtaXIgR29sZHN0
ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gU3VuLCBPY3QgMTMsIDIw
MjQgYXQgMjoyM+KAr0FNIFNvbmcgTGl1IDxzb25nQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4gDQo+
PiBDdXJyZW50bHksIGZzbm90aWZ5X29wZW5fcGVybSgpIGlzIGNhbGxlZCBmcm9tIHNlY3VyaXR5
X2ZpbGVfb3BlbigpLiBUaGlzDQo+PiBpcyBub3QgcmlnaHQgZm9yIENPTkZJR19TRUNVUklUWT1u
IGFuZCBDT05GSUdfRlNOT1RJRlk9eSBjYXNlLCBhcw0KPj4gc2VjdXJpdHlfZmlsZV9vcGVuKCkg
aW4gdGhpcyBjb21iaW5hdGlvbiB3aWxsIGJlIGEgbm8tb3AgYW5kIG5vdCBjYWxsDQo+PiBmc25v
dGlmeV9vcGVuX3Blcm0oKS4gRml4IHRoaXMgYnkgY2FsbGluZyBmc25vdGlmeV9vcGVuX3Blcm0o
KSBkaXJlY3RseS4NCj4gDQo+IE1heWJlIEkgYW0gbWlzc2luZyBzb21ldGhpbmcuDQo+IEkgbGlr
ZSBjbGVhbmVyIGludGVyZmFjZXMsIGJ1dCBpZiBpdCBpcyBhIHJlcG9ydCBvZiBhIHByb2JsZW0g
dGhlbg0KPiBJIGRvIG5vdCB1bmRlcnN0YW5kIHdoYXQgdGhlIHByb2JsZW0gaXMuDQo+IElPVywg
d2hhdCBkb2VzICJUaGlzIGlzIG5vdCByaWdodCIgbWVhbj8NCg0KV2l0aCBleGlzdGluZyBjb2Rl
LCBDT05GSUdfRkFOT1RJRllfQUNDRVNTX1BFUk1JU1NJT05TIGRlcGVuZHMgb24gDQpDT05GSUdf
U0VDVVJJVFksIGJ1dCBDT05GSUdfRlNOT1RJRlkgZG9lcyBub3QgZGVwZW5kIG9uIA0KQ09ORklH
X1NFQ1VSSVRZLiBTbyBDT05GSUdfU0VDVVJJVFk9biBhbmQgQ09ORklHX0ZTTk9USUZZPXkgaXMg
YQ0KdmFsaWQgY29tYmluYXRpb24uIGZzbm90aWZ5X29wZW5fcGVybSgpIGlzIGFuIGZzbm90aWZ5
IEFQSSwgc28gSQ0KdGhpbmsgaXQgaXMgbm90IHJpZ2h0IHRvIHNraXAgdGhlIEFQSSBjYWxsIGZv
ciB0aGlzIGNvbmZpZy4NCg0KPiANCj4+IA0KPj4gQWZ0ZXIgdGhpcywgQ09ORklHX0ZBTk9USUZZ
X0FDQ0VTU19QRVJNSVNTSU9OUyBkb2VzIG5vdCByZXF1aXJlDQo+PiBDT05GSUdfU0VDVVJJVFkg
YW55IG1vcmUuIFJlbW92ZSB0aGUgZGVwZW5kZW5jeSBpbiB0aGUgY29uZmlnLg0KPj4gDQo+PiBT
aWduZWQtb2ZmLWJ5OiBTb25nIExpdSA8c29uZ0BrZXJuZWwub3JnPg0KPj4gQWNrZWQtYnk6IFBh
dWwgTW9vcmUgPHBhdWxAcGF1bC1tb29yZS5jb20+DQo+PiANCj4+IC0tLQ0KPj4gDQo+PiB2MTog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZnNkZXZlbC8yMDI0MTAxMTIwMzcyMi4zNzQ5
ODUwLTEtc29uZ0BrZXJuZWwub3JnLw0KPj4gDQo+PiBBcyBmYXIgYXMgSSBjYW4gdGVsbCwgaXQg
aXMgbmVjZXNzYXJ5IHRvIGJhY2sgcG9ydCB0aGlzIHRvIHN0YWJsZS4gQmVjYXVzZQ0KPj4gQ09O
RklHX0ZBTk9USUZZX0FDQ0VTU19QRVJNSVNTSU9OUyBpcyB0aGUgb25seSB1c2VyIG9mIGZzbm90
aWZ5X29wZW5fcGVybSwNCj4+IGFuZCBDT05GSUdfRkFOT1RJRllfQUNDRVNTX1BFUk1JU1NJT05T
IGRlcGVuZHMgb24gQ09ORklHX1NFQ1VSSVRZLg0KPj4gVGhlcmVmb3JlLCB0aGUgZm9sbG93aW5n
IHRhZ3MgYXJlIG5vdCBuZWNlc3NhcnkuIEJ1dCBJIGluY2x1ZGUgaGVyZSBhcw0KPj4gdGhlc2Ug
YXJlIGRpc2N1c3NlZCBpbiB2MS4NCj4gDQo+IEkgZGlkIG5vdCB1bmRlcnN0YW5kIHdoeSB5b3Ug
Y2xhaW0gdGhhdCB0aGUgdGFncyBhcmUgb3Igbm90IG5lY2Vzc2FyeS4NCj4gVGhlIGRlcGVuZGVu
Y3kgaXMgZHVlIHRvIHJlbW92YWwgb2YgdGhlIGZzbm90aWZ5LmggaW5jbHVkZS4NCg0KSSB0aGlu
ayB0aGUgRml4ZXMgdGFnIGlzIGFsc28gbm90IG5lY2Vzc2FyeSwgbm90IGp1c3QgdGhlIHR3byAN
CkRlcGVuZHMtb24gdGFncy4gVGhpcyBpcyBiZWNhdXNlIHdoaWxlIGZzbm90aWZ5X29wZW5fcGVy
bSgpIGlzIGEgDQpmc25vdGlmeSBBUEksIG9ubHkgQ09ORklHX0ZBTk9USUZZX0FDQ0VTU19QRVJN
SVNTSU9OUyByZWFsbHkgdXNlcyANCihpZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5KS4gDQoNCj4g
DQo+IEFueXdheSwgSSBkb24ndCB0aGluayBpdCBpcyBjcml0aWNhbCB0byBiYWNrcG9ydCB0aGlz
IGZpeC4NCj4gVGhlIGRlcGVuZGVuY2llcyB3b3VsZCBwcm9iYWJseSBmYWlsIHRvIGFwcGx5IGNs
ZWFubHkgdG8gb2xkZXIga2VybmVscywNCj4gc28gdW5sZXNzIHNvbWVib2R5IGNhcmVzLCBpdCB3
b3VsZCBzdGF5IHRoaXMgd2F5Lg0KDQpJIGFncmVlIGl0IGlzIG5vdCBjcml0aWNhbCB0byBiYWNr
IHBvcnQgdGhpcyBmaXguIEkgcHV0IHRoZSANCkZpeGVzIHRhZyBiZWxvdyAiLS0tIiBmb3IgdGhp
cyByZWFzb24uIA0KDQpEb2VzIHRoaXMgYW5zd2VyIHlvdXIgcXVlc3Rpb24/IA0KDQpUaGFua3Ms
DQpTb25nDQoNCj4gDQo+PiANCj4+IEZpeGVzOiBjNGVjNTRiNDBkMzMgKCJmc25vdGlmeTogbmV3
IGZzbm90aWZ5IGhvb2tzIGFuZCBldmVudHMgdHlwZXMgZm9yIGFjY2VzcyBkZWNpc2lvbnMiKQ0K
PiANCj4gQmVjYXVzZSBJIGFtIG5vdCBzdXJlIHdoYXQgdGhlIHByb2JsZW0gaXMsIEkgYW0gbm90
IHN1cmUgdGhhdCBhIEZpeGVzOg0KPiB0YWcgaXMgY2FsbGVkIGZvci4NCj4gDQo+PiBEZXBlbmRz
LW9uOiAzNmUyOGM0MjE4N2MgKCJmc25vdGlmeTogc3BsaXQgZnNub3RpZnlfcGVybSgpIGludG8g
dHdvIGhvb2tzIikNCj4+IERlcGVuZHMtb246IGQ5ZTVkMzEwODRiMCAoImZzbm90aWZ5OiBvcHRp
b25hbGx5IHBhc3MgYWNjZXNzIHJhbmdlIGluIGZpbGUgcGVybWlzc2lvbiBob29rcyIpDQo+IA0K
PiBUaGVzZSBuZWVkIHRvIGJlIGluIHRoZSBjb21taXQgbWVzc2FnZSBpbiBjYXNlIEFVVE9TRUwg
b3IgYSBkZXZlbG9wZXINCj4gd291bGQgZGVjaWRlIHRvIGJhY2twb3J0IHlvdXIgY2hhbmdlLg0K
PiANCj4gVGhhbmtzLA0KPiBBbWlyLg0K

