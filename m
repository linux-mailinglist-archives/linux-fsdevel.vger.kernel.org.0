Return-Path: <linux-fsdevel+bounces-51426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCBDAD6BDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 11:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA20C18870DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 09:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B53225761;
	Thu, 12 Jun 2025 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="DNsxDZQc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA6922D9E6;
	Thu, 12 Jun 2025 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749719423; cv=fail; b=e9CL6er/Y4esDuM2Dh77A/V0w+pEQg+m8mVqSNQycA8+x1Zi33gio/xIjJVqbXyFrFmqWP3YGjUIwj4lfxPyujcCg6uqSePcnUHD4iKo8zv/DIl80gndHVC+UWbrN/SvVUAducv3vrN9sLKiXj7x6YP8woK9oZF9FkYELD+ghyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749719423; c=relaxed/simple;
	bh=9aNLnZMptO7pOWsU+38gtnQUClwHDElX8Vi+JOVocCQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bEEvGGGyR4vHceMsqpnmDZLVUCuGebDCzelFADnu/Jyz1fcvZYDW7IuOhQmqqYckkDYp+hTTz7VLlps795UHziGwtkNzTkq+A2nDBCfTha1Fq34T36vMA/cUkqrcrlX75QwVU36Hsw6IinpoMo4tJGxNNS1GaZ1QjsvK+n85NNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=DNsxDZQc; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2133.outbound.protection.outlook.com [40.107.237.133]) by mx-outbound-ea9-35.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 12 Jun 2025 09:09:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZ6fFrnHVvp5n7QfGaL1Nn3TgBK1Eaopuu2hPya3ZHerJuM9MluwpUlwpI75HETkaRjUkKOfHeSVwLvFlmm5ygNSS/NspNne6GXaOW30anh9nWCtVDhmD0QPh7swl2Z3l6PlvDpYdxmwiOANhUWOD3YFzlhlSTJxn1RHmZ7oXz+mdCY788OAGe9Vw3QHqzrbGbb/4Rd0YewBNQ1t/2NuztXJBJZUDAsfgHO7XJORGmRIZN0A9JEQZ2p7fZqfEBxn79hhFPV5Tatxe34lIDLplU2StBcRAUfLm/q90bJqCUT2dKZR1ms/SH/npy+GtdvcxU973apcpIfZAYV25ZYRPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXDJAE0GxIsvXhayphMRUIoOUwXI1S3oKnteslKoa6Y=;
 b=yv/KZeoWxvekjV/YN2Uy4lKrkj92xpl3yAHPeOiQap+sx5AFh2L7WgH1Sg+sZaKsUzPl2XEE3R67Z2iD7x/FDsSJggV03V0jYfTxunXObJXOYybAQrSTGuXfp9+3n1gMNb0Ls1P3G90aSH2DF0Y1OMRyJKlTKKFG4Jdm/itmv+3ARTtz8im0rbzVA4IlYd+WLe05o/jvnI4sCAVjN5iQKwwHGT8t397GBwN/npEkplxt1EX1PDN7ROKXbBLSmslLR7EsSwwJXcJnE+iag9KoBjlXmOtAXqTO9j1qCYE4awVmONZyL3wrfaqvQ6tA1Z4kUKzjzODgcgZIj6eby7KEmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXDJAE0GxIsvXhayphMRUIoOUwXI1S3oKnteslKoa6Y=;
 b=DNsxDZQcEh7iY4mdsz7zkKs127lfg1nvXcqEKHLZog9ZxmOdI6UVSAwquxSQqBTIMLG9kdzXR0JAqkdR9ts1U7F4EVHFqn8Zr6+MRUeqKAJcZ4ZIhMR5qhEaj9bHbuEnfPmprlOEW/twk7Je0794JAL+IWQmDTOBEUGj8NWK03I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by PH7PR19MB6532.namprd19.prod.outlook.com (2603:10b6:510:1f4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Thu, 12 Jun
 2025 09:09:43 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 09:09:42 +0000
Message-ID: <d50c69ff-c0dd-4429-b75f-98cda2339540@ddn.com>
Date: Thu, 12 Jun 2025 11:09:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: fuse: Consolidate FUSE docs into its own
 subdirectory
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi <miklos@szeredi.hu>,
 Luis Henriques <luis@igalia.com>, Amir Goldstein <amir73il@gmail.com>,
 Chen Linxuan <chenlinxuan@uniontech.com>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Jan Kara <jack@suse.cz>, James Morse <james.morse@arm.com>
References: <20250612032239.17561-1-bagasdotme@gmail.com>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250612032239.17561-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P191CA0041.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::16) To MN2PR19MB3872.namprd19.prod.outlook.com
 (2603:10b6:208:1e8::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|PH7PR19MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: ea1b95fe-2de1-4670-d8e2-08dda990ddcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1dOUGMrWU55RktXSFM5Z0F4UkZTbGxxMWhCWnZ4c2paZm01RE1LQXUvTm9a?=
 =?utf-8?B?b1ZOTUJpYStDQi9sTkZnSHB1ckIwc0ltd0ZNSjFhSlBNSmtkT2pFb3BqOEVB?=
 =?utf-8?B?ZWpSVUNJOHJvMS9jTHd3ZTdwT2dBUHJZa0JSam1PckMwL3dKVU5QZW1rdWg5?=
 =?utf-8?B?dm51ZVNYbmFLWWdYc05ZVkJldUFuNVd6eTZZaHo0aXB5b2ZKTnd1WXFjMzU2?=
 =?utf-8?B?T3NnRFcyV2lYdmZXM1VWR0cyNjFQa2Vuenk1R2Iva3dUVWtrSk5NSUVrbnc3?=
 =?utf-8?B?anV4aGl0cDl2c3hYa3QrZ2swZStMSDVoSDAxNEx2S1J5MS9YMlNLRHFsOWhJ?=
 =?utf-8?B?YTI5RG9EcTRDMU5oR2NCb2FNMEQvaTFXYmtOSEJOSkJsaGtOaFVTMndzNzVW?=
 =?utf-8?B?emtiYmVBK2VueFN0NTVhUUVSaU5ZWG9KQk1iVmtNQ2ZUS3Z3WmdqWTBFZnFx?=
 =?utf-8?B?Y3JzUC8zSE53N2ZsK05lNXQvZ1V5YTFxM1dNSTV1bHBmRENQSXhJZ2o3REhO?=
 =?utf-8?B?VzlCZmdMcUNRRjE0RlNOTnBKeVdZUjE3ckxRTnV0bDhuUlNWTnZxZW9RN2JW?=
 =?utf-8?B?WCtwV2wzT0VwZ1BTa2xyd1NEVXlNWXlUOVNjcDlLVW95WEJEZHdlMVdlVXlq?=
 =?utf-8?B?YWxtWFJrYkU4MUhKR1NEUm9EMURRMHVTRk82eDRueHRUaVIvM2RjTVVpSDB2?=
 =?utf-8?B?eWtXSjl6OWgrYk9OUVU5YituSVhGNUdPcktnVElxd0p6R25HQ3UxTytVb2oz?=
 =?utf-8?B?SEdpbE13U3FLV3VDL2VHVmQ4V1JvVE9nN2VPZm4wQmhpbllwSFY5dzlKc1BT?=
 =?utf-8?B?MldJVmUzSEE0V2tsdExOd3dOOEV4VDlLWWJScmxoRmc1MXBRYXdyZld3Y2xP?=
 =?utf-8?B?RXVLc1NQZ0huQ1VqWEN6dzg5amFnRkJkbTFTWXB2SVNIek4yV1F2ck5Tb3ha?=
 =?utf-8?B?UVh2Unk3NGlLdEtJV2ZPVUs0Ym10b2ZHalg3REtoNUhyS2tqVlFBeC9tY1pz?=
 =?utf-8?B?dGwxazVYalhCVXRvQTVOSFh0bG1KS2lFamZJZlRmMmVCdElJVHgzUVZPNnZC?=
 =?utf-8?B?VlBTY0h0SnpmSUIxVlZSQlY2M1RVNVVSQ2ZjL0thS3lkZ0ZwZStOVjFWbmpZ?=
 =?utf-8?B?eTA2NzY2c3FXa2hQYkFyVXQ3K3E0VVcvWlkrMXBhTEJ5Qlo4WlNjOCtrMm5q?=
 =?utf-8?B?SllYVlp6RVd1eEJkSEt0UXJ6b0tMUzEvQzJhdmJGdnlzM2NWVDlWTk56SnlN?=
 =?utf-8?B?Mlh1UDk5WVUvS2lZQ1J5dGsrYnRYbktiWmJwVmdJL3pUbnhFZHhIVnREbGgw?=
 =?utf-8?B?QzRSL2pPSVRhNlJsWUFRWE9QMFpVbWpsMmRGSG5yWW1xVW9FYyszVjdocUNQ?=
 =?utf-8?B?SDhYL0hIcEFnbGZMR3U2RW55ZHRXaDJQdHlFVW0reXg4YzZSOWhoQmc3U3Zh?=
 =?utf-8?B?ZzV4Lzlmd1RNM1hyRytMK1RsTUlRcE1NVDNneHR0SE1OSmxGYXlzRG43NnhC?=
 =?utf-8?B?VXIxZ05HdkRnd0ExNE9LdTdXbXAvNmxVcXhqRmloak9IMUhGdUdNN1JTN0pK?=
 =?utf-8?B?UTQ0REhHc0xiYXJqMTlSTXpOVlNaMEhzeC9zNGZxWmxBRzJHL1ZXbGloM0pF?=
 =?utf-8?B?OHdPcmFONm1jRlBYTWl5TS9XUng5STJVK2ZTWkpJOXh6bHc2cXExM0VZMUFB?=
 =?utf-8?B?WXNLVVFxYU95OGVhOUltK2taSUJwK3VmL1FwOWhNK2hQNlU3L0lJNWxnclJt?=
 =?utf-8?B?bzVjaExYUVhUNVFlT3gxUkd1Z21URFVWSmNOSk9LYmJQdEZGYkdrdjY5RGFW?=
 =?utf-8?B?MlBoeldhSllWeVM4TVY4dUVYbytidGxxZHl4SUYyWngrcHVmZXFCclpNdklP?=
 =?utf-8?B?djl6cW5xSWpDaXd4VCtRVlVGUytOQkJXSi9CVlF4VTBSK1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFlLc2R2YnBtRkNpS0QzZzlURURyTldwTnFlRmRoYmo5Nm95SGg0SUNPV1hB?=
 =?utf-8?B?L3JVcE0xNmxYaXdSL0ZXUmtCalNJMlVlOXp1T3ZlNkJTNGZWKy9raGhIbk91?=
 =?utf-8?B?MVg2aG5YdEF6b210VkcwTVlqR1A4VDBVVCtFS3hOM3c1RTMwYzFWR1E2NVFR?=
 =?utf-8?B?WFkrRGFsNTRVRGtLaDFHcmxLelAxano4SDZWSEZUZEpLRngzWWwvek8rMFJt?=
 =?utf-8?B?eW4zK1NyT3NSd1BGR0x5M1RsSHU2djMyYnVsbmZJTFhuNjFvWWRkUkdnWlo1?=
 =?utf-8?B?ZldBVFkwTFBONlgrcGhtMVRNVSsxcUhLN1R6NGFpbS9XSzJIZUZhK3Nzd1pE?=
 =?utf-8?B?OVF6UnltUUNyTWNpN0xpRmlqSlRTSTlsRjNVbnRCR1hmV3VySlpWemlYRVNW?=
 =?utf-8?B?TmkzU2RHbWNFWXNRNW5Yc3pQUDFKL2hGakVDdXRWNVdJUTR2QkY2cjVjbk03?=
 =?utf-8?B?S1NoSHVFR21LZGhrVmV3Q1k3NS83WWdXWi93aXBoNTBHVFJxSXVNT1NpMTlu?=
 =?utf-8?B?Mk5iaGlaa3NsaUZ2VEdWQ2NCSVk2ZXJ1MFZQUnhwOVJQb1l3WmJHOXg4Vzk3?=
 =?utf-8?B?SkdOOU1NTVgxZ0JyNjJ6dTlXMjdpdkx6NHh3clVaNjhvRGRFTXBGbzlvQWlq?=
 =?utf-8?B?VXFuMzVwWWM1T3h0WnlrTW1kWHloSHdyRUEraGswT3Q5dXdXNW9ORzh0RVJm?=
 =?utf-8?B?THkzS3Y3WkhZZGZjdFNrRXlMQjR1WEF5Y3k4eldoSloyZFRLMElnMFFKeEQ1?=
 =?utf-8?B?UVJVcUVMS0xQMUxVeE42L0lFSHRsY3luUkdMSGVlSjlENk5zMU5uUUp4V1pV?=
 =?utf-8?B?aVNwdHRwdU5CUnhjRjNSWWVxYVUrdFZJVlh6QXVBd2E4QzZ1QkU3Y3VpSGV1?=
 =?utf-8?B?c0RjdjhmSjB4ZTE2TmZqMk0xRElRZ0ptcmgvUmxqWEl1S203QzZzbTBKcUdk?=
 =?utf-8?B?VmhTU2pNdzNzaE42MWlPSmpOWGJoSGxoZGdMUjRib2FlN0FEbTRMMnBpdWZC?=
 =?utf-8?B?QXVLdUlMYm40K3JGT2F0SzJNWTFBNVVpc25MWWJCS0h0N2VneENzeTNadWlB?=
 =?utf-8?B?QmtYaStpeG9zbkxjTW5mRzc3bkRLdUJWbWpaeUpYZW1qL3p5VjNSU2Z1UlE4?=
 =?utf-8?B?dDRHbm82VWVsenlUY1paeXhPYTYwamNyZm8wVC8yWkNza3BuYzlDWGtOdVEw?=
 =?utf-8?B?THd4MlJaRVhHT0QxaUQzWlhLa01rQ0owUitpSUhMUEU5cnRML2Q3MzhKVXA5?=
 =?utf-8?B?dTk4SXBRNXRMNmI1QlNEWTlXTU5ZZnlKQThxR2c3VExIQ3Q5WklBYUpnQ3hu?=
 =?utf-8?B?cmhUNkFSQkRKVGU3YnFkc3JIWUNybWFEeXR4RGxmUlR3UnB6cWY0NFIzVVZw?=
 =?utf-8?B?QTlDSXBrc2IxZG5VKzQvQ01VZEpGK1RIdDdPZjB0L2p4azNKVEg1VVhqMm1T?=
 =?utf-8?B?eC9pU01HSWJ6MHQycnlRZnFoK0tJMXJ0VmxvV0ovTldqU01lSDI5Zld1YTE3?=
 =?utf-8?B?am1Fc0daaGkyNjlVS3d2TjRRTms2M0xXZHBUMkkwSUk0ZmZPalhmQ2t3VEVQ?=
 =?utf-8?B?OTNXY1czcnl0MHNYMURRanREa3E5ajEyN3l1VW1wN3hrbkNWdHFkWkV1aXpZ?=
 =?utf-8?B?U3NsNGlmZW1RMGFEdG9aOFZaRUgwVURWSFBhaHA4SnI4eDd5VDdVNTVYY1Fw?=
 =?utf-8?B?NzhSMlJVbmFneXJZNGpSR3ZjVTdQOWY0SjVISjNUQ3k2NmpNL3ZVV0FTM05L?=
 =?utf-8?B?cjJITDdQSUxpV21XR0pGaFFrRVVFc05lRlBOTWxwbTIzWFR4UG9XNVNJZEVx?=
 =?utf-8?B?K1FIZEkrLzE5SXdzcWppSFZPNWdOYWtVd0Nram9xRDg4R0ZuT05DaDZ2azdz?=
 =?utf-8?B?N2xGUUJodUdxakVsYU8vdTYyK0RyVnNGd0VUQm1TYUFqQzY4bk4yNmxjVGNq?=
 =?utf-8?B?cEJsa2xYeFVzcEh1RUpUbG50NjM3cXdEM0xVSmhXSWhma1JpUWg0NDRZbGdL?=
 =?utf-8?B?QkVXOHdSV0NrU2VWZW50ZUx0WUlpMXdXWXdFcDlHeUsyNVZyWWlVdWtFRE8z?=
 =?utf-8?B?ZzUyUUZTbDJvKzFjR0NyTC92c2h3eUx1YXN2U04wUlhUUWtIREE3eExQNlEv?=
 =?utf-8?B?WXZwRWhmQTFwK2JCdnpHVmJvOUpmcG5keXFpOU1DQ0FJbTBXbHM3aVI3YndR?=
 =?utf-8?Q?QfMvgBD5VH32u1dCUSFE2+xRwQEHeAeJkNWkqi4sTMlv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OPsZPdWHdCnE3kpKVekBbwx26gpwbqletlS+ehuKP+JjUICxZOjh7NMSdjOZoWlYBGacjqxr7v4War+T8tpcRxUIvIGWNN3YheR1XhDNiuKjjg7vjKogDF4sLRgrB5TJc+04qOVvRsbzzvD/T+H55C8T7Ok1umckiStgEWZ2eL5G+/jNW6ZjDM2cwvyH01/9CZtgwYedbnFGuuwRm2RBwWadFJdZxQF/sP/gTvXL6/XBB95TB4BWwUr4jvQAKYGsxk+dt7QYNvVJEm2EFGdF6XGuHAZz4iODxUj6hgRBREqsg4m+WbuluDsdnMxrhpdi7PEtlTXUqnb1Ha+GOcCabQz+gA9OEpychJ2hb4+WhGPemw6XHjC4cm+AnQXnokTeslvvdE0JmEOdfhy0vIb9cE60RD7qaqeVWZJQI7dS9itDkJqNYzc5K6defin2qyCbOw0M0YjbgbdGRBHQXdtdi4qdTdcZjefktNZGs8zjk8HNnpkeyhffAuI46IdoWwVFQ/a2vAtTBPaWe25a6ulmPFnPnru8TbglxxwO4M4rJY/yLQr3mQPTjLYD2BVoDB4E7e0TBzSQRoPQt+FZWfHGshdf7Z5rkOjV7B9nPnZSCGIOjdX4EMcdXqkj5wP+minZ109AOUIEMIgXWnAIOk3i5A==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1b95fe-2de1-4670-d8e2-08dda990ddcb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3872.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 09:09:42.6583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zYJIEWHdsoTxZyTkB9WkrC4bXdSWv9LtXCNm1WkpJsY3nNjMoW3piCt+o5b20aycpF8U18fHMqgnQWc6TwvCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6532
X-BESS-ID: 1749719385-102339-21049-132028-1
X-BESS-VER: 2019.3_20250611.1508
X-BESS-Apparent-Source-IP: 40.107.237.133
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViYGBkBGBlAszcDIMinVyCw1Od
	HSOMXQICUNyDcwNk5OSTK2SLVIVaqNBQDoyKMUQAAAAA==
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.265278 [from 
	cloudscan20-98.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.01 BSF_SC7_SA959_1        META: Custom Rule BSF_SC7_SA959_1 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC7_SA959_1, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 6/12/25 05:22, Bagas Sanjaya wrote:
> [You don't often get email from bagasdotme@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> All four FUSE docs are currently in upper-level
> Documentation/filesystems/ directory, but these are distinct as a group
> of its own. Move them into Documentation/filesystems/fuse/ subdirectory.
Good idea, thank you!

