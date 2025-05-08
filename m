Return-Path: <linux-fsdevel+bounces-48452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7581CAAF4B4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 09:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89CE4C721C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 07:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AD0220680;
	Thu,  8 May 2025 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iGGmGo13"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCBD195FE8
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 07:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746689595; cv=fail; b=sd4M29gM9jsyQvuZVEwX+fVFyAruhV/LvU3swar686ualLKqO/gnwZ24lphtDPJsH9si8DiKsKyIaQIz0EPZe4dIAzX5yukHdVjdbeJnkvEjlFNdmMP/bNQOweXoNs90wfe/Zc1i/tvM1WywskOVmwtIx19YcUnS4FXw2rsmarY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746689595; c=relaxed/simple;
	bh=45tZmsN/LdS/xhRaKhSNa8Wxjm/TijVWH7NJxh11uaI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fZgyjDyhWMeRnTB9ZqUyx2tQ+6G2mjhBTqVh3DjPOTZybsWqYH7KyzjbwW/Z4J8rfodrWksRw9PhyHFJFUeh3SYVB1JDjpJ+zPqJtke7JjSFKfHOTI0eHmz/xIzpzIuruPw2AgiUvm6mokidtt7hrFJG+ghbUJdMxoVHLeF0CYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iGGmGo13; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdCUufM15OSRcumdzQ62PQU3DQ3KXh4jYiU5fNti/t2+RkPyG88Fnk0/EqxvcPtyybc/lbIA79zvm1e30XaJMUaGGRz/u+HlY1o5UG0xeYTXMyodnI3K28Mtu4t2Bo3HhngFBzBCzer9AuEEG9TZoSwDfH0FctcdL2kGEJ2AdFs4Yj88bLlxezQNdITPNoxcZ+JzdItAfz/iW8JIYAzlGilO31IYGEaxvjxnssMryrvzu2Kel88lQzGaHimuQuV+jAj0oQFfw0g2JJlnOgqVgpmdyJz/CEel9vLZELD66Xaj7hzOIil97D1OC4A97IGnzaTV2ZDI8S31zwKnv21afg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIYFrx5x98gvvtxAgJyN+Sfo1FI3TeV60dHEsWMPH7E=;
 b=Y6sLP/DqeajxrMUVfjyPxxRhQ0TaW7KHeU/jrJdzqNAZyiJ7HswjrZzxiGHwpiXw+HEfAblh/2ptg3XgEJYLnGhCt3khcJ+Qy2idFvGTh8vwS75ckuSogzs6oBGvkbKCv9b+uuqboT58igEdVWD++Zv+yAvGdKPEMN/r9YTGcCIDSTrbKz/Ni+TuMFej7JnfnjTarf49O3uDotIC1xEdhEjJgSim4AuSolqwPFlr/EM1n6HJay+WYfv0DbAUqsL3xrGMcv5lf7lXxmP//wo6ygun0DGAOIUrhNMnrDbKYEs52N0sgcOM1Q1bQM2SL0we73SBrrd0ihi5Q92jEsHvUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIYFrx5x98gvvtxAgJyN+Sfo1FI3TeV60dHEsWMPH7E=;
 b=iGGmGo130MdM1gBjdk77HybEprQ36ZxsPouRlB+bSeO+XEOs0N/3+MAzYkuNJDeKai3O8qe+ZNMTq4BKYfopxjcwuwqamiFGulGh1MB9rgUnZyoDrKZd+xPY5hNvqhSkS2p+BzHpHbNj3tSpvmDptmlellsoSltNC13sduxz5CGSSk59K0UtLpv6zT3KKoIStHy32cv+fjC/2HIbx/LQoGzlH+3Fv9f/1q8Tvq4W6l5XQ1i3SuU/20rLVnLFGa+biQ08iT/jZP8yXA4Xuc0b6vxpCkQDUNsCZy/3g93mrgNF+A/w+bsy2qJJ3vC6tv/lUW5boAu2x1mGVzjdHSHnng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 07:33:05 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%7]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 07:33:05 +0000
Message-ID: <89ff7ea9-fadc-49ec-9ab2-36a737a154c4@nvidia.com>
Date: Thu, 8 May 2025 00:33:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] selftests/fs/statmount: build with tools include dir
To: Amir Goldstein <amir73il@gmail.com>,
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org
References: <20250507204302.460913-1-amir73il@gmail.com>
 <20250507204302.460913-3-amir73il@gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20250507204302.460913-3-amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::18) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|CH3PR12MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb05413-c1f1-43e1-e857-08dd8e029281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U20yOFF0aTRvYThMcmFVMW05WkNMODk1QW92Q0VaWnhCWGYrajNacDluenN0?=
 =?utf-8?B?NmFUR3ZuSmlqdnZiQnNBekFTaUthYjA5UnJ0OU1aaDk1VWc4U09wRmFyU1gz?=
 =?utf-8?B?bWpOc3R5cnBTQ0JqcUpWTHd0ZDVRSnFNdHpjd2VscUJBWUlaRVRrb01xZGlV?=
 =?utf-8?B?MGNBcURqczNzd252Q09XRzcxbFczTDJvcFpnRS9rcDljbjlTdE9yVVprcEs5?=
 =?utf-8?B?NEd4dVp6WkFvZmJrcWxQN3U1cUxDbEFQN3ZHVnRmKzVjV1R1QXJDK3dHQjNl?=
 =?utf-8?B?U29xQlpMSEJsdlgyV0w1QjFPdFVpT3c4OWV0a2FzNUl5SlZocmhpbSsveSs0?=
 =?utf-8?B?V0dBVlhLMlJTNldVRUZIOFYvNUNuSExNdHNHbkdTbVFFbWRYY1RzWk9XUTNv?=
 =?utf-8?B?S3RaOGFSNEVlWml2OFYrelJtMGdxc21maGNKbi9MUEtmV0l1N3puMGlUZ0JZ?=
 =?utf-8?B?NmhOSTd1ci9oZ01RUnkwMkdPS2NWQkR5cWJ4V1phajdaOENua3VqdHZxOHJz?=
 =?utf-8?B?bFFBYmEwbnd2NUl3TzlyYVRsSHI1eTg0dnZjOU5RTjJMR0YzbWxpSmlhZkdF?=
 =?utf-8?B?Yk96SzFQMldWWjhaSjRKK2NuZWY2ZGJaYy9tQVI5elJyZmZrZmhPKzBwNm1t?=
 =?utf-8?B?ZlBPZ3U2bXlJcVl5MXZ2RFVWYWs1Y1BTcUZjem5qbHh6bzBObi90RFY2RUtM?=
 =?utf-8?B?bVorTlQxMHduWXhOcmZFRzZqQlQxeUFYYjhFY05lTmlydFFhWCtCaE5wNEFr?=
 =?utf-8?B?by90K0M4aDZQNVFyOXhIczVRSldDTnlZakZQWmhTUFBuVG9WVWhnejVWeEpa?=
 =?utf-8?B?MDR3ZlJHbkhGVHB1ejJuNkpRckMrbGtvTTgyaHpHcTVEcFBqazROTjJhTFA5?=
 =?utf-8?B?VkZLUE9DUFg0Zmd6OXRYbk9CRFg5ZWVDQU9TRVZuS1pHdTM3VGJPdGRBSXF6?=
 =?utf-8?B?U3k2OHlnck90SEQrTW1aRVVrYlkwSkM2clJNS1NpMXM3c2xUc0pJSjQzbnJy?=
 =?utf-8?B?dVFicHZaVENUVEp3WTRGbTBhQm9oc2ZkLzlsK0piYjk3YjZMcllSTnVSMkE1?=
 =?utf-8?B?VmorZWNTUzZMUE5qSWtCYlREMTZmUTJUUW9NNHFpM2tvZHMyZWhxVU9ndEw0?=
 =?utf-8?B?Nkh2ZmllbkRFK0lDWHR1SmF2b3d0N3NtakpEcjVOVzRoSEpmd1Y5ZklTRG1O?=
 =?utf-8?B?WWFWUUhjOFZRaWdFY2hoZDhIL0lVNUlJbjQxOUlUdVZPOXQ2WUVFQk9wNlpS?=
 =?utf-8?B?T29zUmV0eG1Bait5aWtacTlnUFpRMW5KOTlEclVyL2EyRmllbll0aWlWem4z?=
 =?utf-8?B?QW5RUG9kNjNidTMwZzRwSEVJdXU3dWVydjYrbGFOSC9sWUtvdzhuWjM4QVNU?=
 =?utf-8?B?RHZaQm9reHRqMzhyTkRJeDVQTHpqdE03ZEx2ZEpVRE9BUHZDcnlNaEtMK2h1?=
 =?utf-8?B?SlNzQ1JOdmJmTUxJTk1pZWVPc1BFTktTOEltbTJ3K0FsaCtKQnpaWXJGcmpz?=
 =?utf-8?B?UWdPVkFIUU1aSERLdHB3dVJGcUtyVXVlSjduRm92RU1yczRjY25pVGt4OVVO?=
 =?utf-8?B?WVJzTUlaakRZay9IQ0xZR1JNVXczUTRCbS9aWXowWE9BcWc4MXIydWgwc1E1?=
 =?utf-8?B?SXF6OUtWVXVBaEJTdGx6eEYySmZoaTl3Z09zVkZYblZpWC8wamNsMzI3QUht?=
 =?utf-8?B?M0xsWXZTaVc0SjZ2Ri9qWXUxRTM1VVhTM2Z0SDlualpqcERGOHVSOTNBZDF4?=
 =?utf-8?B?R1ZVSUFHMzVnSWVSQUxMSUdXSUNZNjEvanhrNnNFMlVMK2p1NitkT2tCVERx?=
 =?utf-8?B?THJReEdiS1k4ZVRvbk1iQmlUdkN1M0g4SWQ5Nm5pWFNLdWkyL25yY0hJTy9G?=
 =?utf-8?B?MDJPSm1yVWJpbzFXV0gwMmxPZjViRjAyK2FVV09pMk5XeHFDWkVrMjhudUl3?=
 =?utf-8?Q?Jwv0u1DOiMQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlY0YVFacFBWUXFjSWNqUW93eTRYaXlNOG9HNWxnekZCTExRMWtVTE5MU1lH?=
 =?utf-8?B?QlVFTTVhUE56VUJVNkFqcDlvdXp5bU9rUzJmUE9aa2xQb1JXL2ZEcUFBMFF3?=
 =?utf-8?B?Z05QRGhUSjYrNVdZMTlmS3l1Zll4ckNqVy9IelJqMlMvMUxJY1lsYXdRYkpZ?=
 =?utf-8?B?aC8xT2ROSGFYWVZkaTk3d2xINENRS3BxNzJMbFdnTWp3YlVGN3prakFsNndr?=
 =?utf-8?B?TTlHVmxJTVk4ZFhyRmwvckZDVkJUbndRUElEaDRiMmZRTlcwam1zbDFTK1Ju?=
 =?utf-8?B?aGtqWllnYWFGd3pERXhJNXo3VEVYQjE1elFpazdYcVVEME9QWEd2Q1VWUGh4?=
 =?utf-8?B?V2k2Y2c3WW51eGRUZGt6L0s2VGlhOCtEdzhwU3I0ajVLdjFFQXRWM2d2c0l2?=
 =?utf-8?B?WkJRdDlFekFkeDN0a2N3bENkaGhxQnJtc1JjbEM2ZnlvWlE4TTNDVHQ3T09K?=
 =?utf-8?B?bXhXSGlmT2dWSXhIMmE1MFI4czRjMDgzUkR0Rms2cVBsK3E0MWJRMm1pd1ZP?=
 =?utf-8?B?a0FsaDd0L3g2VFRxS3E1eTZrbnZtTUI1L1VjVmMxN0ZKcnhnZnZVeUlINkZx?=
 =?utf-8?B?K0hMRU1vT00xTXhoQkZmc2hiV2tRVGw3bUh5S3pVQmVNaURBTm91UVg2OTRY?=
 =?utf-8?B?R1ZKNWJtZHBsM0MrbFRQWFdxdTR5QStmenBtVkticlROcmQ5R05SblAzWkI4?=
 =?utf-8?B?T0VqaXkxYnB5dHpKTlh4eDV5NmdPTWY0bFltSkdFVE9PeFVGNjZQZ1hZcjlE?=
 =?utf-8?B?NFhycERSSVVMUjNHQ1FSRy9jRXVpQmRMOVNOY2JKVXpycnlGdGpiMG9GREhD?=
 =?utf-8?B?SGo1ZExXR3pIczBldG5NeldhSVU0Ym53dDRmTE1tOXo2Vi9uWnl4Mm92Y0Fz?=
 =?utf-8?B?b2hqbUQrTnNraUx6Z0hWcHlZNVhWekhNR3N6WXliWU9CSlZrYWI4ckw4dkZz?=
 =?utf-8?B?YXlXRG9yUmxVaEtyeC9jV001RDNGUGNQbi9aZnlTNDdGKzBxVzFUQkx2M2V5?=
 =?utf-8?B?dGZjZzZ6VTBpNnRSNHFOVWtkSnlQckExdmpPT3dwWTQxdWxXUnhhR0NIcURU?=
 =?utf-8?B?NVhpL0NNa0I2TUdUOU90b0Uwdmc0TGN2eXFiZlZlbmhmdUtxd3ZxMFhvc1ND?=
 =?utf-8?B?MFp0STBnU083UXFzYllPU2o3MjQwU3dIV1JpUzZQSjZZUmNlb3ovRThrcUVm?=
 =?utf-8?B?SVd3alRXbXhEVUZVS2VzSU5UN3FzOGFkalR1Ti9EQ1F3cmRyYWRJTWNIZUJD?=
 =?utf-8?B?TWtseUc4eVZWakZ0ZlFCeXVac3RlTWNya1VzcjNUcjNpc3JnL2x3OElVS2xQ?=
 =?utf-8?B?Z28zNmJWYXlSRXFrSUk2dGNzbjEzRDVWcTdGZmpwV1F2bUs2YWE4QkxVaUdU?=
 =?utf-8?B?WHNYRjh2YVhreTYzaUh5WjZDT2p6M0c3WERwQUIzQW9KOWdCTGhvcWZPQmJi?=
 =?utf-8?B?ZXZOWjhabTN3QThuSzk1VTI2ZW85S2ZWTkI4VFZwRGlJSnI5MHd0em5vRmxC?=
 =?utf-8?B?RlJ2SHl0NUlYTldtcW81UXRraUxMSktEcDBnd29tcWpUekpDeS9iZktORzhE?=
 =?utf-8?B?U1psZGUzdDNMMm9TZTJiQUhlL0dLSlFGeVArNjVJaEVwMEFOKzgvRlVoemZi?=
 =?utf-8?B?SHVYVEgxcHFHVGw5UGs2eWJhTzdLdXMzME9PSk9LdW55cUdsdVMwUTkvYUhw?=
 =?utf-8?B?VC94RUl1S2o4bUFMSE5FdWhsdDdZbWNHbWRQUEJRQjAyWUUzTWRCNDczVnhJ?=
 =?utf-8?B?ME0zUXo3NEZQU3NZakhVREZ2UktFcVgwRnBNTm5lNXd0OTJiRUZScWh3MXNp?=
 =?utf-8?B?ODRlRGdWZjdXUEJyakozQnhiR0FIYVllY1hoQzRWL2xEOE93dTFpMmoyaWhi?=
 =?utf-8?B?WTlwMmNQeTNSWmllamhGbE1wZFYxcDFHQjBQWmV5RkdIOHRoY05pbnc2aTA2?=
 =?utf-8?B?ZFk1ckZ0SGZDcGtHVFFvYjU3NDdxWmdKaWY0RnBHeSszQ0E4VENWTkdTYmxa?=
 =?utf-8?B?QWdQMTVUbHRRY1JIZHRxWGxqb1AveHpjODJjMHEvM0xSejdVYlNNaVJ6emty?=
 =?utf-8?B?aE9qcnZMNXFzbTZGSzBpd200Qkx3V2lQWTYzZE9pdWFiaThCWkV5bzF4MXpi?=
 =?utf-8?B?OHNaTUhMQ1BuWmVDb0M5M1VHTTFMcDd2SWZjN2Z3ZTdTMmRQREZiL1lzRUFt?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb05413-c1f1-43e1-e857-08dd8e029281
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 07:33:05.6577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjduoF1H1ZzPv/wuSReIL162u2Q4fUBPdGgLL7ybULc/WHZWYzp4HZtvUzKmRmSJEYbVceKAEeS5VgKPQB70IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354

On 5/7/25 1:42 PM, Amir Goldstein wrote:
> Copy the required headers files (mount.h, nsfs.h) to the
> tools include dir and define the statmount/listmount syscalls
> for x86_64 to decouple dependency with headers_install for the
> common case.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>   tools/include/uapi/linux/mount.h              | 235 ++++++++++++++++++
>   tools/include/uapi/linux/nsfs.h               |  45 ++++
>   .../selftests/filesystems/statmount/Makefile  |   3 +-
>   .../filesystems/statmount/statmount.h         |  12 +
>   4 files changed, 294 insertions(+), 1 deletion(-)
>   create mode 100644 tools/include/uapi/linux/mount.h
>   create mode 100644 tools/include/uapi/linux/nsfs.h
> 

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard

> diff --git a/tools/include/uapi/linux/mount.h b/tools/include/uapi/linux/mount.h
> new file mode 100644
> index 000000000000..7fa67c2031a5
> --- /dev/null
> +++ b/tools/include/uapi/linux/mount.h
> @@ -0,0 +1,235 @@
> +#ifndef _UAPI_LINUX_MOUNT_H
> +#define _UAPI_LINUX_MOUNT_H
> +
> +#include <linux/types.h>
> +
> +/*
> + * These are the fs-independent mount-flags: up to 32 flags are supported
> + *
> + * Usage of these is restricted within the kernel to core mount(2) code and
> + * callers of sys_mount() only.  Filesystems should be using the SB_*
> + * equivalent instead.
> + */
> +#define MS_RDONLY	 1	/* Mount read-only */
> +#define MS_NOSUID	 2	/* Ignore suid and sgid bits */
> +#define MS_NODEV	 4	/* Disallow access to device special files */
> +#define MS_NOEXEC	 8	/* Disallow program execution */
> +#define MS_SYNCHRONOUS	16	/* Writes are synced at once */
> +#define MS_REMOUNT	32	/* Alter flags of a mounted FS */
> +#define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
> +#define MS_DIRSYNC	128	/* Directory modifications are synchronous */
> +#define MS_NOSYMFOLLOW	256	/* Do not follow symlinks */
> +#define MS_NOATIME	1024	/* Do not update access times. */
> +#define MS_NODIRATIME	2048	/* Do not update directory access times */
> +#define MS_BIND		4096
> +#define MS_MOVE		8192
> +#define MS_REC		16384
> +#define MS_VERBOSE	32768	/* War is peace. Verbosity is silence.
> +				   MS_VERBOSE is deprecated. */
> +#define MS_SILENT	32768
> +#define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
> +#define MS_UNBINDABLE	(1<<17)	/* change to unbindable */
> +#define MS_PRIVATE	(1<<18)	/* change to private */
> +#define MS_SLAVE	(1<<19)	/* change to slave */
> +#define MS_SHARED	(1<<20)	/* change to shared */
> +#define MS_RELATIME	(1<<21)	/* Update atime relative to mtime/ctime. */
> +#define MS_KERNMOUNT	(1<<22) /* this is a kern_mount call */
> +#define MS_I_VERSION	(1<<23) /* Update inode I_version field */
> +#define MS_STRICTATIME	(1<<24) /* Always perform atime updates */
> +#define MS_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
> +
> +/* These sb flags are internal to the kernel */
> +#define MS_SUBMOUNT     (1<<26)
> +#define MS_NOREMOTELOCK	(1<<27)
> +#define MS_NOSEC	(1<<28)
> +#define MS_BORN		(1<<29)
> +#define MS_ACTIVE	(1<<30)
> +#define MS_NOUSER	(1<<31)
> +
> +/*
> + * Superblock flags that can be altered by MS_REMOUNT
> + */
> +#define MS_RMT_MASK	(MS_RDONLY|MS_SYNCHRONOUS|MS_MANDLOCK|MS_I_VERSION|\
> +			 MS_LAZYTIME)
> +
> +/*
> + * Old magic mount flag and mask
> + */
> +#define MS_MGC_VAL 0xC0ED0000
> +#define MS_MGC_MSK 0xffff0000
> +
> +/*
> + * open_tree() flags.
> + */
> +#define OPEN_TREE_CLONE		1		/* Clone the target tree and attach the clone */
> +#define OPEN_TREE_CLOEXEC	O_CLOEXEC	/* Close the file on execve() */
> +
> +/*
> + * move_mount() flags.
> + */
> +#define MOVE_MOUNT_F_SYMLINKS		0x00000001 /* Follow symlinks on from path */
> +#define MOVE_MOUNT_F_AUTOMOUNTS		0x00000002 /* Follow automounts on from path */
> +#define MOVE_MOUNT_F_EMPTY_PATH		0x00000004 /* Empty from path permitted */
> +#define MOVE_MOUNT_T_SYMLINKS		0x00000010 /* Follow symlinks on to path */
> +#define MOVE_MOUNT_T_AUTOMOUNTS		0x00000020 /* Follow automounts on to path */
> +#define MOVE_MOUNT_T_EMPTY_PATH		0x00000040 /* Empty to path permitted */
> +#define MOVE_MOUNT_SET_GROUP		0x00000100 /* Set sharing group instead */
> +#define MOVE_MOUNT_BENEATH		0x00000200 /* Mount beneath top mount */
> +#define MOVE_MOUNT__MASK		0x00000377
> +
> +/*
> + * fsopen() flags.
> + */
> +#define FSOPEN_CLOEXEC		0x00000001
> +
> +/*
> + * fspick() flags.
> + */
> +#define FSPICK_CLOEXEC		0x00000001
> +#define FSPICK_SYMLINK_NOFOLLOW	0x00000002
> +#define FSPICK_NO_AUTOMOUNT	0x00000004
> +#define FSPICK_EMPTY_PATH	0x00000008
> +
> +/*
> + * The type of fsconfig() call made.
> + */
> +enum fsconfig_command {
> +	FSCONFIG_SET_FLAG	= 0,	/* Set parameter, supplying no value */
> +	FSCONFIG_SET_STRING	= 1,	/* Set parameter, supplying a string value */
> +	FSCONFIG_SET_BINARY	= 2,	/* Set parameter, supplying a binary blob value */
> +	FSCONFIG_SET_PATH	= 3,	/* Set parameter, supplying an object by path */
> +	FSCONFIG_SET_PATH_EMPTY	= 4,	/* Set parameter, supplying an object by (empty) path */
> +	FSCONFIG_SET_FD		= 5,	/* Set parameter, supplying an object by fd */
> +	FSCONFIG_CMD_CREATE	= 6,	/* Create new or reuse existing superblock */
> +	FSCONFIG_CMD_RECONFIGURE = 7,	/* Invoke superblock reconfiguration */
> +	FSCONFIG_CMD_CREATE_EXCL = 8,	/* Create new superblock, fail if reusing existing superblock */
> +};
> +
> +/*
> + * fsmount() flags.
> + */
> +#define FSMOUNT_CLOEXEC		0x00000001
> +
> +/*
> + * Mount attributes.
> + */
> +#define MOUNT_ATTR_RDONLY	0x00000001 /* Mount read-only */
> +#define MOUNT_ATTR_NOSUID	0x00000002 /* Ignore suid and sgid bits */
> +#define MOUNT_ATTR_NODEV	0x00000004 /* Disallow access to device special files */
> +#define MOUNT_ATTR_NOEXEC	0x00000008 /* Disallow program execution */
> +#define MOUNT_ATTR__ATIME	0x00000070 /* Setting on how atime should be updated */
> +#define MOUNT_ATTR_RELATIME	0x00000000 /* - Update atime relative to mtime/ctime. */
> +#define MOUNT_ATTR_NOATIME	0x00000010 /* - Do not update access times. */
> +#define MOUNT_ATTR_STRICTATIME	0x00000020 /* - Always perform atime updates */
> +#define MOUNT_ATTR_NODIRATIME	0x00000080 /* Do not update directory access times */
> +#define MOUNT_ATTR_IDMAP	0x00100000 /* Idmap mount to @userns_fd in struct mount_attr. */
> +#define MOUNT_ATTR_NOSYMFOLLOW	0x00200000 /* Do not follow symlinks */
> +
> +/*
> + * mount_setattr()
> + */
> +struct mount_attr {
> +	__u64 attr_set;
> +	__u64 attr_clr;
> +	__u64 propagation;
> +	__u64 userns_fd;
> +};
> +
> +/* List of all mount_attr versions. */
> +#define MOUNT_ATTR_SIZE_VER0	32 /* sizeof first published struct */
> +
> +
> +/*
> + * Structure for getting mount/superblock/filesystem info with statmount(2).
> + *
> + * The interface is similar to statx(2): individual fields or groups can be
> + * selected with the @mask argument of statmount().  Kernel will set the @mask
> + * field according to the supported fields.
> + *
> + * If string fields are selected, then the caller needs to pass a buffer that
> + * has space after the fixed part of the structure.  Nul terminated strings are
> + * copied there and offsets relative to @str are stored in the relevant fields.
> + * If the buffer is too small, then EOVERFLOW is returned.  The actually used
> + * size is returned in @size.
> + */
> +struct statmount {
> +	__u32 size;		/* Total size, including strings */
> +	__u32 mnt_opts;		/* [str] Options (comma separated, escaped) */
> +	__u64 mask;		/* What results were written */
> +	__u32 sb_dev_major;	/* Device ID */
> +	__u32 sb_dev_minor;
> +	__u64 sb_magic;		/* ..._SUPER_MAGIC */
> +	__u32 sb_flags;		/* SB_{RDONLY,SYNCHRONOUS,DIRSYNC,LAZYTIME} */
> +	__u32 fs_type;		/* [str] Filesystem type */
> +	__u64 mnt_id;		/* Unique ID of mount */
> +	__u64 mnt_parent_id;	/* Unique ID of parent (for root == mnt_id) */
> +	__u32 mnt_id_old;	/* Reused IDs used in proc/.../mountinfo */
> +	__u32 mnt_parent_id_old;
> +	__u64 mnt_attr;		/* MOUNT_ATTR_... */
> +	__u64 mnt_propagation;	/* MS_{SHARED,SLAVE,PRIVATE,UNBINDABLE} */
> +	__u64 mnt_peer_group;	/* ID of shared peer group */
> +	__u64 mnt_master;	/* Mount receives propagation from this ID */
> +	__u64 propagate_from;	/* Propagation from in current namespace */
> +	__u32 mnt_root;		/* [str] Root of mount relative to root of fs */
> +	__u32 mnt_point;	/* [str] Mountpoint relative to current root */
> +	__u64 mnt_ns_id;	/* ID of the mount namespace */
> +	__u32 fs_subtype;	/* [str] Subtype of fs_type (if any) */
> +	__u32 sb_source;	/* [str] Source string of the mount */
> +	__u32 opt_num;		/* Number of fs options */
> +	__u32 opt_array;	/* [str] Array of nul terminated fs options */
> +	__u32 opt_sec_num;	/* Number of security options */
> +	__u32 opt_sec_array;	/* [str] Array of nul terminated security options */
> +	__u64 supported_mask;	/* Mask flags that this kernel supports */
> +	__u32 mnt_uidmap_num;	/* Number of uid mappings */
> +	__u32 mnt_uidmap;	/* [str] Array of uid mappings (as seen from callers namespace) */
> +	__u32 mnt_gidmap_num;	/* Number of gid mappings */
> +	__u32 mnt_gidmap;	/* [str] Array of gid mappings (as seen from callers namespace) */
> +	__u64 __spare2[43];
> +	char str[];		/* Variable size part containing strings */
> +};
> +
> +/*
> + * Structure for passing mount ID and miscellaneous parameters to statmount(2)
> + * and listmount(2).
> + *
> + * For statmount(2) @param represents the request mask.
> + * For listmount(2) @param represents the last listed mount id (or zero).
> + */
> +struct mnt_id_req {
> +	__u32 size;
> +	__u32 spare;
> +	__u64 mnt_id;
> +	__u64 param;
> +	__u64 mnt_ns_id;
> +};
> +
> +/* List of all mnt_id_req versions. */
> +#define MNT_ID_REQ_SIZE_VER0	24 /* sizeof first published struct */
> +#define MNT_ID_REQ_SIZE_VER1	32 /* sizeof second published struct */
> +
> +/*
> + * @mask bits for statmount(2)
> + */
> +#define STATMOUNT_SB_BASIC		0x00000001U     /* Want/got sb_... */
> +#define STATMOUNT_MNT_BASIC		0x00000002U	/* Want/got mnt_... */
> +#define STATMOUNT_PROPAGATE_FROM	0x00000004U	/* Want/got propagate_from */
> +#define STATMOUNT_MNT_ROOT		0x00000008U	/* Want/got mnt_root  */
> +#define STATMOUNT_MNT_POINT		0x00000010U	/* Want/got mnt_point */
> +#define STATMOUNT_FS_TYPE		0x00000020U	/* Want/got fs_type */
> +#define STATMOUNT_MNT_NS_ID		0x00000040U	/* Want/got mnt_ns_id */
> +#define STATMOUNT_MNT_OPTS		0x00000080U	/* Want/got mnt_opts */
> +#define STATMOUNT_FS_SUBTYPE		0x00000100U	/* Want/got fs_subtype */
> +#define STATMOUNT_SB_SOURCE		0x00000200U	/* Want/got sb_source */
> +#define STATMOUNT_OPT_ARRAY		0x00000400U	/* Want/got opt_... */
> +#define STATMOUNT_OPT_SEC_ARRAY		0x00000800U	/* Want/got opt_sec... */
> +#define STATMOUNT_SUPPORTED_MASK	0x00001000U	/* Want/got supported mask flags */
> +#define STATMOUNT_MNT_UIDMAP		0x00002000U	/* Want/got uidmap... */
> +#define STATMOUNT_MNT_GIDMAP		0x00004000U	/* Want/got gidmap... */
> +
> +/*
> + * Special @mnt_id values that can be passed to listmount
> + */
> +#define LSMT_ROOT		0xffffffffffffffff	/* root mount */
> +#define LISTMOUNT_REVERSE	(1 << 0) /* List later mounts first */
> +
> +#endif /* _UAPI_LINUX_MOUNT_H */
> diff --git a/tools/include/uapi/linux/nsfs.h b/tools/include/uapi/linux/nsfs.h
> new file mode 100644
> index 000000000000..34127653fd00
> --- /dev/null
> +++ b/tools/include/uapi/linux/nsfs.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef __LINUX_NSFS_H
> +#define __LINUX_NSFS_H
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +#define NSIO	0xb7
> +
> +/* Returns a file descriptor that refers to an owning user namespace */
> +#define NS_GET_USERNS		_IO(NSIO, 0x1)
> +/* Returns a file descriptor that refers to a parent namespace */
> +#define NS_GET_PARENT		_IO(NSIO, 0x2)
> +/* Returns the type of namespace (CLONE_NEW* value) referred to by
> +   file descriptor */
> +#define NS_GET_NSTYPE		_IO(NSIO, 0x3)
> +/* Get owner UID (in the caller's user namespace) for a user namespace */
> +#define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
> +/* Get the id for a mount namespace */
> +#define NS_GET_MNTNS_ID		_IOR(NSIO, 0x5, __u64)
> +/* Translate pid from target pid namespace into the caller's pid namespace. */
> +#define NS_GET_PID_FROM_PIDNS	_IOR(NSIO, 0x6, int)
> +/* Return thread-group leader id of pid in the callers pid namespace. */
> +#define NS_GET_TGID_FROM_PIDNS	_IOR(NSIO, 0x7, int)
> +/* Translate pid from caller's pid namespace into a target pid namespace. */
> +#define NS_GET_PID_IN_PIDNS	_IOR(NSIO, 0x8, int)
> +/* Return thread-group leader id of pid in the target pid namespace. */
> +#define NS_GET_TGID_IN_PIDNS	_IOR(NSIO, 0x9, int)
> +
> +struct mnt_ns_info {
> +	__u32 size;
> +	__u32 nr_mounts;
> +	__u64 mnt_ns_id;
> +};
> +
> +#define MNT_NS_INFO_SIZE_VER0 16 /* size of first published struct */
> +
> +/* Get information about namespace. */
> +#define NS_MNT_GET_INFO		_IOR(NSIO, 10, struct mnt_ns_info)
> +/* Get next namespace. */
> +#define NS_MNT_GET_NEXT		_IOR(NSIO, 11, struct mnt_ns_info)
> +/* Get previous namespace. */
> +#define NS_MNT_GET_PREV		_IOR(NSIO, 12, struct mnt_ns_info)
> +
> +#endif /* __LINUX_NSFS_H */
> diff --git a/tools/testing/selftests/filesystems/statmount/Makefile b/tools/testing/selftests/filesystems/statmount/Makefile
> index 14ee91a41650..19adebfc2620 100644
> --- a/tools/testing/selftests/filesystems/statmount/Makefile
> +++ b/tools/testing/selftests/filesystems/statmount/Makefile
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   
> -CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
> +CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
> +
>   TEST_GEN_PROGS := statmount_test statmount_test_ns listmount_test
>   
>   include ../../lib.mk
> diff --git a/tools/testing/selftests/filesystems/statmount/statmount.h b/tools/testing/selftests/filesystems/statmount/statmount.h
> index a7a5289ddae9..e84d47fadd0b 100644
> --- a/tools/testing/selftests/filesystems/statmount/statmount.h
> +++ b/tools/testing/selftests/filesystems/statmount/statmount.h
> @@ -7,6 +7,18 @@
>   #include <linux/mount.h>
>   #include <asm/unistd.h>
>   
> +#ifndef __NR_statmount
> +#if defined(__x86_64__)
> +#define __NR_statmount	457
> +#endif
> +#endif
> +
> +#ifndef __NR_listmount
> +#if defined(__x86_64__)
> +#define __NR_listmount	458
> +#endif
> +#endif
> +
>   static inline int statmount(uint64_t mnt_id, uint64_t mnt_ns_id, uint64_t mask,
>   			    struct statmount *buf, size_t bufsize,
>   			    unsigned int flags)



