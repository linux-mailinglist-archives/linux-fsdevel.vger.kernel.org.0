Return-Path: <linux-fsdevel+bounces-50962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A6AAD17CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 06:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042A1168862
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 04:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B376827F73A;
	Mon,  9 Jun 2025 04:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="s9sv73ca"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020085.outbound.protection.outlook.com [52.101.69.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816233D544;
	Mon,  9 Jun 2025 04:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749443152; cv=fail; b=EYAUuLwNbH0UCGLH08NM/LHfwNlKbeFw+LI7myO65NSSEWTxssi4VLJKc5LzIocP6F/QJe9N2vTC8Wv0RsboDqS8FHTazY69dF/7fKBgcPSEGJgdLITg64z/7+dmbeRoHj5GFABIudkJffFBlaQliLIKsgKr/QGKFEQr9C1l4W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749443152; c=relaxed/simple;
	bh=gaHDWQIXzGULOFfm+bHoDI+lZGRam9fznqQ2djcBByE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p1ylad3gJ8cWOpzgk6ZdmQnoe6Qa4FE5dn724i/eMhaP8eWjlcJpYcclt8EP/VZgz+pDUJbUvw/N2agIiSf7LT9QzNubxOOgo8EvF7xEtf50Wu2pzApqy+Qrv/SFWonXQmKudN5tN0aEy5iYtsIKGjC+83NFpRvLlTSmghG7FII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=s9sv73ca; arc=fail smtp.client-ip=52.101.69.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fadfSvA9SpQKh/gG7aHF/JyON2JjuEGvUFwr14a9/aLyQO+POFPlKdXjApqXHHU9vVS4L3LtbTdcrUSq1tP7rZgxRlOo3IRZZuUDKas8iDAyzZsQOcUPXLkb0AlDlPJ1bQ5z3H8HAOz1OPaz3gUB3B6GgdV8w5+0Hfade14Do38+8KdRqfy7NMNBwpjMT4P9L9CyvAhu+7bBHJC0GpzkRaNcBGP/G8SFxCJHEaeRvK/DyxGVHJzUYZPn3UnG1hLsUBSIuRgTORD+fmXLsBvnUVjLvBWuUB8OMcnzG6sh21+FuaoQ+2pSBDWxLb2/iqBPknThX0eb43iLGMa69CO25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fcN08E04kIhAbMWcqgDt/6g04xP4EaStUEWUE5s2vc=;
 b=p7j+BBj9nUGttSoeguMQkyF4R71kvOvICDcIpljjmedqrRPO0IonbwOVvUFFbjKPvXtf8rMytTLDgXIXb0CV/5y/Vp3snAjuJguLVn5vMd5+3ysWaTaFN4Tf0Qv5PwSvsiRiCKd4J3aa17YnNgG0xNGFpPLK6zs+r41J8mR0B9uPpiTnOMjymVunlX5XjxHF85UXWoyrRfJ5v/g0Tk7tL/5mBNMm3GZ4G9D8k9mnDlXFEtNdfl0WFjEzLRWn4KAyh3sdu6HpgkIgW+spj8DP7iGLBagA7C7gSHXGdWPpHg4T3WgPn9ykG3zDcr/yNdNl0//AZg+o+4Z7qlYevsW7kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fcN08E04kIhAbMWcqgDt/6g04xP4EaStUEWUE5s2vc=;
 b=s9sv73ca+ga42A7tfsqZU37pDz+N23GUzoHKNhWuChUko7YR5J9QjPKTsz8Xsrw+WeE8l2Ak8AznE/z/FqnRIwJmaOpEhqKoOXLIJcfnXMynXkJRmYLpF97EPlCRWGZ9ukWDOmSieLYtIT7gFfw418ak91YMB3ThRPgAEVYYM7Ie80O7cbVmHSFRTPYgpPWb/UdJpkgc87L/bEOYmXSDlugQHbnb056/Eaqy+Bb5+cm2b9Blhy+gDs+/atXvvbgqcdqPGSXrjhmm+pI15RawlueoWX0sb8/ESdGs7Jbe5VqsRS7Emk2o7TxJZUNTLNuEXrk16BbmVgJH+HlktOy2AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by DBBPR08MB10602.eurprd08.prod.outlook.com (2603:10a6:10:52c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 04:25:46 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce%5]) with mapi id 15.20.8792.034; Mon, 9 Jun 2025
 04:25:45 +0000
Message-ID: <08a5981f-fb20-4ff0-92a6-45aaee952b00@virtuozzo.com>
Date: Mon, 9 Jun 2025 12:25:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking: detect spin_lock_irq() call with disabled
 interrupts
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
 Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Konstantin Khorenko <khorenko@virtuozzo.com>, Denis Lunev
 <den@virtuozzo.com>,
 Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250606095741.46775-1-ptikhomirov@virtuozzo.com>
 <20250606105830.GZ39944@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <20250606105830.GZ39944@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ME0PR01CA0005.ausprd01.prod.outlook.com
 (2603:10c6:220:212::27) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|DBBPR08MB10602:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b31810-301e-4d1c-cbac-08dda70db43a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGViN2FqZ05jVjk4ZnhINllmNmlGMDlSMXYvQTViQ3kwY1puNTlMQmRxcWkv?=
 =?utf-8?B?WFJuMjlDZTZMWnkyTXpDU2hIODJzYTlneEZIRm9HWTNEckxIMW41MGRta05p?=
 =?utf-8?B?cGc0V3A3bUtkSGdWNDNWRnBTam1Jd2QwVFJLTWFwdWd5ZEh4T2dYK1FrY3N5?=
 =?utf-8?B?RVQ5VUJpY0VRZ0dDVUpvTDRVSkROTE4xK3ZUbkhhbWo0c1Q4cTc1VDFibEZm?=
 =?utf-8?B?ZmpCazVrcnJBMlo1THZPMWN5SVZHcmdkTlN0dFhISGJ0Lzg0R1RUUUp0NlFx?=
 =?utf-8?B?R01RN1VkNlN0UEdoS3BEL3gxRTE0dithVm1ZZ2RlMnlBRmRRa1dEZzJxSWxx?=
 =?utf-8?B?THdYcDBGYUlwcUYraENEU3JFZFhsOThSWkxYQnNNRGl2RmY5OS8zVDk2TUhY?=
 =?utf-8?B?cDhVUHVhcUlldld6SWdJa2lUTXhIYTE4VDJER1JSdnFEbmtKdDlXWG4xOFJ5?=
 =?utf-8?B?bjNpN1RpbE1ERHB5V3BlRkxyem5mTzNuU0w3azRQWkZZSllxMWFKYjdjVllZ?=
 =?utf-8?B?MzJ0L3A1ZjVwOHk2aUY2N0gzczV4UVVRblNXSjdqcmtHamRmeURpSGtuV25Q?=
 =?utf-8?B?VDhBYWt5RmM5anJkbEtnSnV6ZWcyazVvbS85NVpORjI0NForU1dZVlp4V3Ex?=
 =?utf-8?B?elFYTS9PSk40MXRaSjlGMTJWcVMwenFzYnNCMVJhRzIwMExzcjkzbThWT2RZ?=
 =?utf-8?B?QlE0OGFHenJUNnRrVkREOTNqWEg5bWR0b0xOYStqb09sOE9oM2xQdFBidllL?=
 =?utf-8?B?bHZqSzQwazl6bXJPZnpzbVVvYk1rdzFLTWRNejRIMUNVK0UxMGdoS3ErQXpq?=
 =?utf-8?B?NjgydlplNjJNNGJNN29xUWZRK1VyYnp2eU9mUDBObFkrd0JkTmtFdUoyN21j?=
 =?utf-8?B?NDZ5SXZMWUcxckxsQ1pMNFFtbmtLY3Z0YVBBeitGYzVaVXJIazdYdnRYUklI?=
 =?utf-8?B?V28vckxnR2tsU2FKV28rQnh6SDJsczl0QUh1UDZVVnV2UUdWUGI2Y2hhV0pw?=
 =?utf-8?B?WkdUcG14UkFYN0Y3ZVdDV1Jqajl5TGpBR2tTdmQ0Y3hnZk5hbGdxYlYyblM1?=
 =?utf-8?B?Skl3VzJBQysxYStNT1hRVytkQW1PWlRRSkx5cUc1V0JSbGRpTEg4S0x1d0dB?=
 =?utf-8?B?cWN1ZHpXTWRWeEFWZkFmU0tVVzFzUk9Cb09SZ0RnZUwxWmUxUktQMXZ1cVAw?=
 =?utf-8?B?RHFPZVFzRHY5dzJ2QmZTZktlc0tTUkNvWGRpNWw5U0dCZTRmTjNKQWx5c3dk?=
 =?utf-8?B?Qm9UVHVGR3dnelFWNWQ4eVpWOXpGNjA0VitFNWl2UytQa1o3ZlJDMHdUMDVv?=
 =?utf-8?B?YXFlQmhrMVRQVGEydUhoajc5S21XVDdINmtWZHBGWFhXOHpPRnZnOUpITC9p?=
 =?utf-8?B?eWk0dk41MkRvU2xNb00vajFmTzVheGFuVDlUcnYvdGE2Wjk3amZGTllLWGsw?=
 =?utf-8?B?M0w1SVJ2TTNPYWlkMmxJcUg0N21vV1RxT1Y1R0pXZ3Y5dGlTTzlhb0lvMzlo?=
 =?utf-8?B?TWdyc1ovNlZiRjRTdWxvZUZKSGIxQ1ovRzFHZ1ZQRHllZXdWM1B6Vy9CTmFt?=
 =?utf-8?B?Q1hVUTk3c0dhSmx0dFdtc25nOTRRcWk2T1R2T21ZSnordDBIMThFWGpCNWpZ?=
 =?utf-8?B?dU13eWwwZFhvRHJFZUFvaUk4M0NCUHlpdm1Udnl4SU5FRGt1SDRsd0RxMXRX?=
 =?utf-8?B?VXhoSjRhelB4dXdUMHFWOTBXVkR2dmhGNmx2SXFlOGNIeXVxNDNxVFB3aXZh?=
 =?utf-8?B?ckdHM01LNVZIeUdvNm55V2psZ1Qva1BjTFNrNHBCd1FvUjd0SmxEVnMwRU05?=
 =?utf-8?B?bXBrc2wwdHF4WVlQT1N1ZVVrZ0F6QmRJc2VqSTdyRjBsUHgvUmZ6T1BCaXEr?=
 =?utf-8?B?eUUyaEZFcHc5OWF2MWpseW9ldENLbnEvTzZScCtHbndFaCtsS0hRbnJWL0I5?=
 =?utf-8?Q?L9ZsvMw/2bE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmhLYWR0OUJoeXdCSGlzQjVWSmVCTTJ5ODlIU3ZQQkgyZythb2FSb2ZQWGd0?=
 =?utf-8?B?K1Q2a1h5MzlxdEpVaUR3SExXYWpBejU3cjUyVmNxZUl2c0NFeEFqV1l2RjZM?=
 =?utf-8?B?dzMvc1k2WUdLSTdPTGI3VkxlcDY4UlRuaklySXgvWVJrRCtQVEMybGdrazlO?=
 =?utf-8?B?clhBVVBkb3NHSzN5bnJySU1ydmo4bUFhWnkzTmllbVJ5S1kyenJ5dGh0MFkv?=
 =?utf-8?B?aitiRUhCZDJlcUtMN0VRUkUvYVRxa1ZwTDZqTGFraFI0Q1RrdVlZaVNzTVNi?=
 =?utf-8?B?NU43QzU2a2JndUpaYlZwblNKMjIrSDM1eWhrV3QzMnVHZjZSWm1YN0RMdlpT?=
 =?utf-8?B?QUg4N0hKZ1NLU3NiV3cwTnFmT0NEcytFUG9jblMzYXNHYjFJWVkrLy9KMVNU?=
 =?utf-8?B?VTVRNDhKY1hINGZkeGJJb2NoTVVFNGRFREtMRE1mZzZ4VXA0NHZUMFZQK2Vk?=
 =?utf-8?B?RlIrTGhuV05HKy83TzVPNU5PYTErNEhkbVY2cXJSRXdiWEJPY2RxRVpUUDJJ?=
 =?utf-8?B?bVZURkYxdW9yWXpjWkNldGs3eVlpMjRQSDNDT2I0S200Njd4MHFNMSt6Ymgz?=
 =?utf-8?B?US9yV3JEN0ZkNCt2aE1BcFMvcFYzY1RDQnB4RjN5VWxURGNJZHZrdmJNVjFG?=
 =?utf-8?B?NW1tRndLQ2V1eG0yQWRSZ1RRUHY1c2tyb2Y3bmErWUhvOXR2TjdqSUs4Q0NN?=
 =?utf-8?B?WkhMSUp2cmx4WUhzcWpWeXBMTytpODVrNE1meTV3Tkg2THdsMUpkcldlaDE2?=
 =?utf-8?B?QWp2QVZEWEpFOEZVUXhZTzNVTUQ5aFNQcFA2YWhTeEpjbzdLZGlUdG9kK1A4?=
 =?utf-8?B?RVJIcmNralNvVjNLMGVjK2VOSTVOQmNHVlF2c0grZnNDeDhySGh3Q2NPSm5K?=
 =?utf-8?B?eFBEcm9zWG8wVzB3OWdsQVhhWUZRR3hUcFdUaGV1S1NMYXNIYlZ3ZHBLc0dw?=
 =?utf-8?B?VWtxaEFIZThKMXVOd2t5S0xucDdGZXJHb1VHdVh0ajEvZ2lxRTZJRjhxSSto?=
 =?utf-8?B?U0M5ODl2OUUxUndLWVFSemJYUGFXNHhJWXM1QU90cmE2MFRhejV5RE4wbFdX?=
 =?utf-8?B?NkEyN0U5SGtZZnF6L20zQnc5Q1EvK0RWVy8rbVMrNk1IV1NyK3NId0VuYWxR?=
 =?utf-8?B?N1VpVGJGVis0VU9KYzk1QUhYWDVYU3BvNE0raHowaER6UjlVZFRiTVlUWHht?=
 =?utf-8?B?UmRKdm92Nm03aGs0S3d1eTF0dnlrdkJxakd0T1NWNlErMWQ1ZWs3cXhHbzJU?=
 =?utf-8?B?alZmdkk4bmtrRFRydkIwQWp6aHVxTXVqb0E5Si9BeHVadUdJM0tVSHc3TkdE?=
 =?utf-8?B?Q0VCZjBUaUNXUi92VmlHbS9xSWlLc3ptR1JhbDlMazRuN3VIRFgxZkZ0VjRG?=
 =?utf-8?B?aC9JMGc0Z0RVTU1aZ3NTK1FTcjh1RWg0S0tRbTFPQ3pWeWxSME9lN2JVODU5?=
 =?utf-8?B?ZzBIaVdFU3RSbWxaUDBFWU8wUW1LZk5MNnFsbm9WS1phYnZuMk01UTdWOW9Z?=
 =?utf-8?B?N2pTUjFObTRNdjRDR0dXbThPejBjSkhpY1BxcE1lOG4vN21TM0RucS9RdDZF?=
 =?utf-8?B?S1gvTFRZRkQxSWh3M05JZzVMTCtaUk1sdndnL1lOKzQwWmRoaTgvczU0Ukow?=
 =?utf-8?B?bVdKQ0hrT1d3MVcxTVNzL011ZzdBOVZORkNmVnRYNm05aU4weVUwVVR5S0dN?=
 =?utf-8?B?aWpoVFp6T3JUZmlMSU93VkE2bHRVTklhcFR1TG8yNHIzTHdFWFBUNXJUSzU1?=
 =?utf-8?B?Q3M5RGltaTNPYmtiQTQreE5ZaEl1Y280UmR2N1AvYVBKTXhjL3ovOUw1MGc2?=
 =?utf-8?B?aDNaOTgrRmF5bm4yZlB2TE1GaXQ5cE9xOE5rNWZTdDRPbmg3VkhYRnlXaDFF?=
 =?utf-8?B?SWxvQW1udDYvczZRMWplczJUOWlPdHE3dW94TGVDYUZRVGh2SGM0cXY5c3FW?=
 =?utf-8?B?eVpCZDl4ek04VVBjbnY4c0hJRUU5NTZXdzZyVTJNNUFKY3h5cnYvMVdwUm4y?=
 =?utf-8?B?dUFvaStoakpaaUFrWFpMWkZ2MUZKUDM1OHYvYjkzY0g4OG1Pam1jb2lubU9N?=
 =?utf-8?B?SjFuYVUwMlN1YXFqMVBQdlBZYzdSaU45RGpobE9ZbzFGRjF0WlNOY0Z0SVY2?=
 =?utf-8?B?MDZQV1FWYVk3ZW9tWkVTVERraUFRZnlabktqRmdUVnR6bzBRSkQvVFpNQlhy?=
 =?utf-8?B?Skl0ZFdIajRyeDNPb3E5Mkg1RkxJUkk3OS9KL0RYakc5WDA0TEpvSVByaE4w?=
 =?utf-8?B?R1lIVExValh2elBCYlJoNTlDRHV3PT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b31810-301e-4d1c-cbac-08dda70db43a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 04:25:45.8183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3g2LwcABYt4WWLpg7Ofm49Pd1zXtW/bgJ2M9H7XQTZ2VXL00ZNg1GJ0z5DGKzqyNTwI2xqGz1a3Dhhp6ZeOiCWBRoGZUnXWssRQLBVwDM8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10602



On 6/6/25 18:58, Peter Zijlstra wrote:
> On Fri, Jun 06, 2025 at 05:57:23PM +0800, Pavel Tikhomirov wrote:
>> This is intended to easily detect irq spinlock self-deadlocks like:
>>
>>    spin_lock_irq(A);
>>    spin_lock_irq(B);
>>    spin_unlock_irq(B);
>>      IRQ {
>>        spin_lock(A); <- deadlocks
>>        spin_unlock(A);
>>      }
>>    spin_unlock_irq(A);
>>
>> Recently we saw this kind of deadlock on our partner's node:
>>
>> PID: 408      TASK: ffff8eee0870ca00  CPU: 36   COMMAND: "kworker/36:1H"
>>   #0 [fffffe3861831e60] crash_nmi_callback at ffffffff97269e31
>>   #1 [fffffe3861831e68] nmi_handle at ffffffff972300bb
>>   #2 [fffffe3861831eb0] default_do_nmi at ffffffff97e9e000
>>   #3 [fffffe3861831ed0] exc_nmi at ffffffff97e9e211
>>   #4 [fffffe3861831ef0] end_repeat_nmi at ffffffff98001639
>>      [exception RIP: native_queued_spin_lock_slowpath+638]
>>      RIP: ffffffff97eb31ae  RSP: ffffb1c8cd2a4d40  RFLAGS: 00000046
>>      RAX: 0000000000000000  RBX: ffff8f2dffb34780  RCX: 0000000000940000
>>      RDX: 000000000000002a  RSI: 0000000000ac0000  RDI: ffff8eaed4eb81c0
>>      RBP: ffff8eaed4eb81c0   R8: 0000000000000000   R9: ffff8f2dffaf3438
>>      R10: 0000000000000000  R11: 0000000000000000  R12: 0000000000000000
>>      R13: 0000000000000024  R14: 0000000000000000  R15: ffffd1c8bfb24b80
>>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>> --- <NMI exception stack> ---
>>   #5 [ffffb1c8cd2a4d40] native_queued_spin_lock_slowpath at ffffffff97eb31ae
>>   #6 [ffffb1c8cd2a4d60] _raw_spin_lock_irqsave at ffffffff97eb2730
>>   #7 [ffffb1c8cd2a4d70] __wake_up at ffffffff9737c02d
>>   #8 [ffffb1c8cd2a4da0] sbitmap_queue_wake_up at ffffffff9786c74d
>>   #9 [ffffb1c8cd2a4dc8] sbitmap_queue_clear at ffffffff9786cc97
>> --- <IRQ stack> ---
>>      [exception RIP: _raw_spin_unlock_irq+20]
>>      RIP: ffffffff97eb2e84  RSP: ffffb1c8cd90fd18  RFLAGS: 00000283
>>      RAX: 0000000000000001  RBX: ffff8eafb68efb40  RCX: 0000000000000001
>>      RDX: 0000000000000008  RSI: 0000000000000061  RDI: ffff8eafb06c3c70
>>      RBP: ffff8eee7af43000   R8: ffff8eaed4eb81c8   R9: ffff8eaed4eb81c8
>>      R10: 0000000000000008  R11: 0000000000000008  R12: 0000000000000000
>>      R13: ffff8eafb06c3bd0  R14: ffff8eafb06c3bc0  R15: ffff8eaed4eb81c0
>>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>>
>> Luckily it was already fixed in mainstream by:
>> commit b313a8c83551 ("block: Fix lockdep warning in blk_mq_mark_tag_wait")
>>
>> Currently if we are unlucky we may miss such a deadlock on our testing
>> system as it is racy and it depends on the specific interrupt handler
>> appearing at the right place and at the right time. So this patch tries
>> to detect the problem despite the absence of the interrupt.
>>
>> If we see spin_lock_irq under interrupts already disabled we can assume
>> that it has paired spin_unlock_irq which would reenable interrupts where
>> they should not be reenabled. So we report a warning for it.
>>
>> Same thing on spin_unlock_irq even if we were lucky and there was no
>> deadlock let's report if interrupts were enabled.
>>
>> Let's make this functionality catch one problem and then be disabled, to
>> prevent from spamming kernel log with warnings. Also let's add sysctl
>> kernel.debug_spin_lock_irq_with_disabled_interrupts to reenable it if
>> needed. Also let's add a by default enabled configuration option
>> DEBUG_SPINLOCK_IRQ_WITH_DISABLED_INTERRUPTS_BY_DEFAULT, in case we will
>> need this on boot.
>>
>> Yes Lockdep can detect that, if it sees both the interrupt stack and the
>> regular stack where we can get into interrupt with spinlock held. But
>> with this approach we can detect the problem even without ever getting
>> into interrupt stack. And also this functionality seems to be more
>> lightweight then Lockdep as it does not need to maintain lock dependency
>> graph.
> 
> So why do we need DEBUG_SPINLOCK code, that's injected into every single
> callsite, if lockdep can already detect this?

Hello Peter,

Thank you for your reply!

We are trying to figure out a way to improve the detection of similar 
cases in future, in our tests and even in some cases in production. I 
see that in mainstream this issue (commit b313a8c83551) was detected by 
Lockdep and fixed in the next release, that is very fast. But, sadly, we 
didn't catch it in our QA testing cycles (including runs with debug 
kernel with Lockdep), and it led to repeated complete nodes hang in 
production of one of our partners.

1. This patch, arguably, is less performance consuming than Lockdep (I 
don't have performance results, but my motivations is: we don't need to 
save stacks and manage lock topology tree on each lock, thus saving 
memory and some cpu cycles). Because Lockdep makes tests slow, we don't 
run all tests with it, and hopefully we would be able to run all tests 
with this small check, and it will improve detection probability.

2. If on a production node we have a reproduce of such a deadlock on 
spinlock and we can't easily find the real spinlock owner in crashdump, 
we can probably enable this small feature there and catch the "guilty" 
stack directly on next reproduce. Running Lockdep there will definitely 
be a no go. The suggested checks are really quite small and lightweight 
and we think even release kernels can have those checks compiled-in 
(with static key disabled by default surely) and those checks can be 
enabled without extra reboot on affected nodes and with very small 
performance footprint.

3. Lockdep generates false positives, from my experience roughly <10% of 
what it reports is an actual thing, but maybe I'm just unlucky (or not 
understanding something). And then Lockdep detects a problem there is no 
way to search for the next error (AFAIU lock dependency tree gets a 
cycle), you have to reboot, if I don't miss something. So we have to fix 
even false positives if we want to get possible new detections later on 
the same test. (Or maybe disable Lockdep tracing with lockdep_off, but 
that can skip a real problem nearby.)

4. If lock in interrupt code path will not be triggered in test Lockdep 
will not detect the deadlock. But with this check we only need to 
trigger the non-interrupt code path to detect the problem (having 
enabled interrupt brefore spin_unlock_irq* is always a bad sign) and 
possible deadlock. So we again improve probability of detecting such 
cases by a small fraction.


> 
> 

-- 
Best regards, Pavel Tikhomirov
Senior Software Developer, Virtuozzo.


