Return-Path: <linux-fsdevel+bounces-45685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 985BFA7A9BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 20:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C276F17392A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 18:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12759252907;
	Thu,  3 Apr 2025 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SSvQ2DUz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C79C8E0;
	Thu,  3 Apr 2025 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706248; cv=fail; b=CGChf38g71AYKxa38zTA3hzyb4kvJwlkwH2fMedF/5LD4nKpv8xiZ9M5P+w+rowjI1ilXcpuh0Kz24CrYpUcWdnn1LaGOBcqN2ChX0sqaKXEOTMQ60+xtbgnwhH2AYH2+tzhnj1q7ZDnZSSVAwjKQ5dMx4Tg94c/N69yz8czhus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706248; c=relaxed/simple;
	bh=gi/HiRVhrayln6tTuxMnwRDelKIvVdEdHaT8GOEaX9o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tR4Q52aKPq6YOqTkFi/ImP2nmC6mXChWOGx756hpBlmKTXf8DiVM/aZD5cC4Vk1JT6p7ujBWHuBjja9gKC+j5NNKhP4FBPf2Lyx3aepQ6XWo9a15QjoQfCFOnbPtq7cDPBNJSZJe59kKos5+twKFdECQgtIsPJ4WPO9bRAv8CVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SSvQ2DUz; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkGRL1UiW3YmrOwIYsSfbjuH4r4HPm/ieGWuOGldT60DhetmU4+fxXt6MCVBgfLrskoQNo3rEBedrbv+L/h38VYajs3/w+xHE04HNgc7grO3wrXEGsDpF7QLFPICXLJDt3bbNRnJ5/UpajNVwIg8HzlvYysEXqQrgYHuSu7Jsva8ZYJQmCnZ0Z5HjzwESuYKAU3YYrp4GXJfQTzOUPMbu+nPvuUAf5vskMjD8WTfrGvPHlBU5Vm1Cw5N+4MOsSjKk+TwWmKOwyA1f+z/5TdHjOFkUmRvzdFRexxZ6e6hlV4m1OS/b9u3+b8SOPvUeSAyOgHxzcfMAlELixmpLjG5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfUMwuZ4Yh01CSuO4FPzWW3orDskLuA15cxgJ5Cw0Jg=;
 b=YoS/5RdOy/bSPEH2+1Lm2V8ZFx0XOBoUnDvND7yW2sLa1EzQUschhnsWSrsMgCC2JiYwTiIvXYABxIB9M501wZOyE2zxTxTw0eJF6DUDrxMuRtiCVl9z6y4e81tex0La8rAI/TEFXkTADlTfQ7VUXUnvsZ3KfMN5f1s4JOPWrwHGh7JfQhL7GXRhfDs2h4I9wohik0hwMBPBM7gMirrmfmIDz/CSY5ylgJyUzhedcFDbTqVVpkQk99uD2nAzd4DCVhoW9eseGbTN63NHYhPDpKYetwFG69sQYT0dhpXC5eJGq67ftoP3exAKZj5V2Z0tfuBZWXuNWJn3vuE+b7flkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfUMwuZ4Yh01CSuO4FPzWW3orDskLuA15cxgJ5Cw0Jg=;
 b=SSvQ2DUzzgT4uMzzneVpszcoYqSNkWVy97qG04blqXnZlHBrhwLp1tpKtvWCF/zv0A7a6M2OroLJZf0Iljjn5pMu18mYyh7R9nKIi3NXumBqQc1MON9mwytpt0wt7w9Sck8JRpm9rP1qisOjBhdQzdwvj/rx7qjh5TiH2LS8noA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 18:50:43 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8534.043; Thu, 3 Apr 2025
 18:50:43 +0000
Message-ID: <dd9ef946-2d8e-4a43-ac62-dab09f97934a@amd.com>
Date: Thu, 3 Apr 2025 13:50:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] kernel/resource: Provide mem region release for
 SOFT RESERVES
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
 rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz, ming.li@zohomail.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 huang.ying.caritas@gmail.com, yaoxt.fnst@fujitsu.com, peterz@infradead.org,
 gregkh@linuxfoundation.org, quic_jjohnson@quicinc.com,
 ilpo.jarvinen@linux.intel.com, bhelgaas@google.com,
 mika.westerberg@linux.intel.com, akpm@linux-foundation.org,
 gourry@gourry.net, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, rrichter@amd.com, benjamin.cheatham@amd.com,
 PradeepVineshReddy.Kodamati@amd.com, lizhijian@fujitsu.com
References: <20250403183315.286710-1-terry.bowman@amd.com>
 <20250403183315.286710-2-terry.bowman@amd.com>
 <Z-7WImoc5Dg3Xtyq@smile.fi.intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <Z-7WImoc5Dg3Xtyq@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0180.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::17) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ed4e56-5ed5-47cc-6157-08dd72e06fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sk5KOHZETlhGbkxXZnEvS3ZENlVXd2hmVnFUT2xXTEhQN0xtSXdqTUNXS3BN?=
 =?utf-8?B?RmpUYURoSGZQamZ3QWF2VEIvdFZjKytpeGhISEJ5SFErOXh6OFZFTlhJSjdZ?=
 =?utf-8?B?ZjY0Uk8zdDRVMkJhOWpuTkRITFQ1eTlmKzhtZGZGU3Z4ZmlidC9uekI1L3Zy?=
 =?utf-8?B?L01IcHdjcGpZbjc1TGoyUk1mdTZwN2R0NXI4OXl3Z0JsckNPYWJnanhaL25q?=
 =?utf-8?B?Z0ZRZXovZkNxbkduVnBNSzZPWU80azk5bThDajh3RmVhbk1rNm1vZllGNXhE?=
 =?utf-8?B?Sy9rWmc4UVdaUjFHcmFreWEwTFh2QVRlME9id0lTcVREbDV6THRxYTU0Z21D?=
 =?utf-8?B?Y09iMlVHeHNaaGVOSUVLSHB5YjVZS2NRNHhMZG9CMFN2OThOd3NiR0UzN1hJ?=
 =?utf-8?B?UjJIMEwrbEltM2tuUnl1WnZRcHJ2Yk9oUk1PSWVCUDBVTUtTVm9DSkZFc0ZR?=
 =?utf-8?B?S1hycnFsYUk0SnFlZEVaRkQvQmhXak03QjZZN0NLcFo3ZGFpakV3TUlWR3BP?=
 =?utf-8?B?VmlMQzZKamFERTJ2amxuY3l3MjlQSDlheHdFdVFUVWxQMzJyNzN0Y1VjLzI2?=
 =?utf-8?B?RHgxODQ5cGkrT2x5R0ZDWC8wZXlibGo4TiswQkxCYTd0c3lQUnkrS0R5K0lJ?=
 =?utf-8?B?bC93bFZYOE9CUExFd1pKZjFXOElMVVRicVpITTU2VjVCV3dvZVkrb2xsbnZq?=
 =?utf-8?B?UGI5SlN5dzNQQWlDblFDeVJ0dmV2ODhlZGhnWGF1TG5hSVgyWHYvTURZWjhr?=
 =?utf-8?B?SW9XUmJKSEtyczh5QS9OaFpFWXF0TnhQenB0TFMxeGlFWDIzTFNscENCY0VT?=
 =?utf-8?B?bTM0WHJiekkzYit6U29ZV3BuMCtnbGh4V2RPZUI0ZVJ0SElzODFsSGxEUFln?=
 =?utf-8?B?M2c3WkJhQk5yNzE3WG9JU3dyQkhsaDlQazBFYVRuODV3cER5NFNKRm9lSkdP?=
 =?utf-8?B?SkhPZ2dVMXYxaUU3WCtET1VvV1hZcENwVitvNmZCbzdBMDI0eDkwelNISnpl?=
 =?utf-8?B?cXk3ZlQvQUZBejVhQ25oTnFXeWRZVXY4OXoydjcyMDlpY0NZZWNXTDB5eE9G?=
 =?utf-8?B?ZUJtK01lRTdlNFc0eUdEaHhNdjhnYVI2ZEhML0pIaUZYSU1mQkVTNjBXMmV6?=
 =?utf-8?B?K3pqSnl1TEljRmRrVXg1RCtCRGRnUTNFK0NBcWpCbVArQXpGNU13RW8zOWhV?=
 =?utf-8?B?ZVFPSENmb0QrOWxmaGdLV0xJdDJiVWtKQUEwTW9IVnBQMnRIKzZrV045T3lq?=
 =?utf-8?B?NWtWNkQ1WmN3Ti96REhHalJxQkU5QklENHNDVkp6OWwwMHFCZXM4UUFFWEIr?=
 =?utf-8?B?M2N6SFh5eFA4WnFTamwwZmxJRVFxUnlyOEwyZW5leFppeFRvMldUZFdJTU93?=
 =?utf-8?B?SDJTVU9JaGV5dUxPWWY3TmwwRC9tRnJEUFVacWxZY3VNbFRldUdnSE9lSEdJ?=
 =?utf-8?B?dnRIUGVDdXVhb2lHUGoyQTlZQzNGS0xVeFdwM3ZtWmwraTloanhFblZsSjZF?=
 =?utf-8?B?d0JGQ0lINWxReWZEdmVuUHpUNDJEeC9QbEZkTnN2SEd5ZGFUMnR0bWF5cGFn?=
 =?utf-8?B?OWRkalpabEhyNTFXTngwVW9PRTgzV1M5ZGFaWkNrWVNTMnhIemxvNnFWV1Iz?=
 =?utf-8?B?aWdZdDJ1SXJ2MzMwWlh5MlhZMDIrZmNyTm9WR0NiMDhieXJtNWd4SFQ1ZjA2?=
 =?utf-8?B?M2tGRmk1R2FGWWZvc3M3S3ZyNm1EUlY4Tmt2Q1grN3NzLytlaTVUQTFNakJa?=
 =?utf-8?B?SDg4VnRhazVLNG5xcWEzMlo0d0owWFFhNVY5ZWRlTW9iYU5KeWJxVGxQNUZp?=
 =?utf-8?B?NUt3Mm50RXByZ2pYRlhUU25yeGlkUm12TlFXaHh5aHlaNXRsWVh1SXZlWW5T?=
 =?utf-8?Q?DSuHmccW8rIWu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGZiVXhnajBwVU9mSFA5SXI1dE45YloyYy90dDQzT2ttcWxoLzFVRjlFYmEx?=
 =?utf-8?B?ZURFSmVJOGZaNzFqclVjd0I4Wnp4ZndpUDB6TW5NeHpCNzhDR2ltbFhPK0xO?=
 =?utf-8?B?d0xjd1JXN1ozQTliMjlNaUlweExrTDlRQVFuYmJaaElFemlteTFiTWEzUUZn?=
 =?utf-8?B?WXhmOHptVXlTY21iVDF6aXE5MlpGRjAyZ2p4emZueHFwamVOQ24xYmxFd2gy?=
 =?utf-8?B?UGIvek5uK2dxby9mMFo1NWZqZktGL0ZUbUNiMk9hdHVRRXVVcW5TaEFVQU9G?=
 =?utf-8?B?U1NDbVEvQmZBNUVUUmc5V091ejl1TWVuY21QWDBEVWxDcnkwcXRpbTYwb2Fm?=
 =?utf-8?B?N2VBRWo2UjVpQ202TDI4ZjdFd09wWCtyV1ZrZGQ3VXBJNHl2NFN5OUpRcTBF?=
 =?utf-8?B?NWNob0JXOTNSbng5ZU8zYTdBQU1ja3ErM3hrcnQrSmtyTVdsVDdDemVpVVZW?=
 =?utf-8?B?eVpHclA2RlBUWVhQT1c2clBtdEZqanZSbkxqaEVySmhMZm5ZRGlOMjN5Rkx4?=
 =?utf-8?B?Q2lIWVBoSURzdnlpNzExWGlPOW8zclpOZ2JRYnphR0Y0NzRhV1U3ZDgvWFc2?=
 =?utf-8?B?UkVmSHpxMjc4RC96dmVTU0dTQVhJM3R0Z0xrdGdMUTBmdTFDK0l4NUxPMk9V?=
 =?utf-8?B?L0RGa2VUOWZXdHpCRUdtUlF6UUlOb3ZQQjZqczFUS0JmV1lHVzllTHVOcWN6?=
 =?utf-8?B?N1I3d01ZY2k0eVlOaUVjWk93K1hqTEhRb2NEeFRlTm1yMnhpUGU2ajhZTTNn?=
 =?utf-8?B?a0tTUVRjMDk1TmZ3ZzM0RzF0bW80bkhFRzlYejFiZmZRcVkzaDA1QVY5M1FS?=
 =?utf-8?B?RHk2ZW9jZmtWM1pjZFFYV0ZGZmZyQjBnZHJwVDlGdDZMcldyVlJQQ3pkbmhm?=
 =?utf-8?B?REV3blc2SFdrQ2lqaVhwU1V5TVc2UHFpS0EwZVBhQUFDd1VwcEVXYko0bTZL?=
 =?utf-8?B?djJRM2luNHJXSDg3eXVoWDBzVzhaczhjYU40b0lsNEhXYys1UmF1dFppZHNL?=
 =?utf-8?B?d2Vvb0Jja1VQdzdDYlp2L0cyL3gxQVhsRkRlRXJGcGRUUmducnZwZ0x5YTdV?=
 =?utf-8?B?TXJuUWtPdEdDekpqU3U4ODF5ZnE4b2dpVEorM1ZOUlVnSi9UaXAyeGhFaXhP?=
 =?utf-8?B?d3Vka09Tdkx1VEMyK0hsYWVoS3Y0U2FKWVlHVjIwUUVLRktZWUcvZmo5bW9w?=
 =?utf-8?B?QXBDeFJvZzhmMThkclRYYzN1TkVmOXhTc2hMa3NoSDJKQUVjZEdMc0NtU1Rp?=
 =?utf-8?B?L05OVEx1ZFFZMmIvdVgyS0ZrSFJGei9vUmhUVlhaNGlCVXdJY05uR1VvbHhZ?=
 =?utf-8?B?bE1TUjYvbHpJblY1WXExaS96THVlbUo3N0xiV20zK3pDK2wvbjFhSmFzN3Fz?=
 =?utf-8?B?NW9RdUUvTVRpT0x5QVlUSVhDZlRIKyt1VlZxT3AxcEo0MDYzaGZEbSt0REEw?=
 =?utf-8?B?UVdRUndQdGp4emFsMkhxT3ZydERlRnlEazJiaFdvUTlFQkFvSUVneVczbkNp?=
 =?utf-8?B?VFlaR1pDbFV5a3FvSWlrK3ZRSlJpMVVjTnpaekhNWFIxVXpoWFl6RjE5cWhV?=
 =?utf-8?B?VGpDYnlFTUpTYkhLS2J3U2JJRll6cWVJdFc1cWd5RmJrU0ZybWYzRWt3OVJn?=
 =?utf-8?B?dlZlMGhVZk9VQjd6SHJrVTV0ZkQrdnFZTXREQy91b2JRcHdDN1RZMm55NDFw?=
 =?utf-8?B?eTNoRTR1Y0dMUTZoemxQaHR4LzJXK0ZQWFBzY3ovQlNETGlKQno3L3BiSjJl?=
 =?utf-8?B?V1M0UEFvQ3hwejV6VGQzYTRUcG9pc2E0Y2FPWU9jQWJDVHhWWFRxajJuRHQy?=
 =?utf-8?B?TTg2Wk1LZUkxSkNMZEV4N3gwek9QbnJ3MzNSbGV6ZmNEYzNoTEt4SkU5V3gx?=
 =?utf-8?B?T2U4SzRLUnR4aWpCc3B3L3dKbGVKZXFqL0JmclZnelJndlhsNjVMRld3c2M2?=
 =?utf-8?B?VmNLdUhnRnNuWDBFWm9TVTJHMGxRbERUQythSmVsSTEzN2Y0bU1kY205K002?=
 =?utf-8?B?N0QyZ252RG95cmhtSzZGSEw0ZVpQamhwbzlYRngzRVc1ZVpabGJPT2pQRDE0?=
 =?utf-8?B?UjBIWU5mR3p3TXNXWmhOZlBWN2JvUWI1dnY1R09ES1I0RExYN1pGeVlLQXRQ?=
 =?utf-8?Q?Wfkf+hYIWXMDTsi+ZvIUW9pyu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ed4e56-5ed5-47cc-6157-08dd72e06fd5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 18:50:43.2672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSLpIi7kHIYcs/KltF6F2m4TuuCgmeDQ7L2qYHvBdaYMDK1/G+UuOs7Wq4EnSTjX/0lGvM/V9JtylM6emjlP+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758

Hi Andy,

Thanks for reviewing this. I'll make updates for all you pointed out below.

Regards,
Terry

On 4/3/2025 1:40 PM, Andy Shevchenko wrote:
> On Thu, Apr 03, 2025 at 01:33:12PM -0500, Terry Bowman wrote:
>> From: Nathan Fontenot <nathan.fontenot@amd.com>
>>
>> Add a release_Sam_region_adjustable() interface to allow for
>> removing SOFT RESERVE memory resources. This extracts out the code
>> to remove a mem region into a common __release_mem_region_adjustable()
>> routine, this routine takes additional parameters of an IORES
>> descriptor type to add checks for IORES_DESC_* and a flag to check
>> for IORESOURCE_BUSY to control it's behavior.
>>
>> The existing release_mem_region_adjustable() is a front end to the
>> common code and a new release_srmem_region_adjustable() is added to
>> release SOFT RESERVE resources.
> ...
>
>> +void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
>> +{
>> +	return __release_mem_region_adjustable(start, size,
> You have still room on the previous line for the parameters.
>
>> +					       true, IORES_DESC_NONE);
> Return on void?! Interesting... What do you want to do here?
>
>> +}
>> +EXPORT_SYMBOL(release_mem_region_adjustable);
>> +#endif
>> +
>> +#ifdef CONFIG_CXL_REGION
>> +void release_srmem_region_adjustable(resource_size_t start,
>> +				     resource_size_t size)
> This can be put on a single line.
>
>> +{
>> +	return __release_mem_region_adjustable(start, size,
>> +					       false, IORES_DESC_SOFT_RESERVED);
> Same comments as per above function.
>
>> +}
>> +EXPORT_SYMBOL(release_srmem_region_adjustable);
>> +#endif


