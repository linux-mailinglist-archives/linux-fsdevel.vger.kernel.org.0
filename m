Return-Path: <linux-fsdevel+bounces-50018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 617E5AC75DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 04:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133FC1C021FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 02:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA66244E8C;
	Thu, 29 May 2025 02:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="rAptHgMO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013054.outbound.protection.outlook.com [40.107.44.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A34E19E968;
	Thu, 29 May 2025 02:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748485516; cv=fail; b=Rq6Gm5FE0YObpP/S+tCqssunKmkVDpauv/01IUMS7TtIQdJHMHO9leh2jl6D2T/KNDxaIDjsfaO1IH1tzHywdQcoL7MBNwr0oqugJ+/OaJXbRRwbr1UfJMGu5roDgPG0QZRcES98FG1GKg3Xtip1ZVHO35U4Q9NkUEUJGK8NXl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748485516; c=relaxed/simple;
	bh=3/FR7WAm1+TnnN4WlMBH5h4e6wDtEa/RRjtX0/xaqOg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y/a+yB+TATuCZOLAFHkE0m9gv5p4d4hyZVUrkTbIjHK9xafEQO0EmTZrG1znp6X8Vqsgbt0iZd3XBSofiTRVuw8eU8rO8BphgfCuAim55++1W0zN63OQtY36FnAVmczEWmmn35UPqGBbNQmbCh/aT74iOybq+penzV35+k1DCmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=rAptHgMO; arc=fail smtp.client-ip=40.107.44.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuUoyo1KXeqf/FFwGmmAvwmLlb1/oxusqjzathriPqG+Bx+rE3yLlwMBHNhc3XQ6WTNfg1/0N4BujNbKt9yIyHrXqg2JE1h4zgDgn0FkW7L3dyo4ZIc0En/r4YRbQgW4f+D4JoAjunhe1EHKnOfWUtpmTh9sUwpsVPFD3s4iOYIBDcfo6/VP+q14oy8ESf9GT8R/dSedmpp9j7iNvTifW8soUsHH0T5Ymio3o9wmdD92Ypf2UlndomKkcYNrlTlAUv2pf+SC/awKZken7cjpRu/7BtQpxfLsk3A86chO4V40e3aySfZBAqCbb45a7U/v8QoWXAjoW/VJUXWw6ljh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aJ8bBkJ2VUXSAjGYKvTaaZ9/NBqsf9jSAiwLkijtFk=;
 b=X654IFTInMoniKhHHWvcNjjZJSvRnV0ZnVj3QidKeh0EOXrnf44gfImK1I3cqx2eHOASaN2EN8dG345Jo6mfSF7fR2tERdEGTqvXLurl66cSL9EvfK1n280iP757HFSmcAr8hArroXdF64iAdXi21SZIKYOe+EEcT3FgToow6rIDUDACZN+Oocvwek58q2G6E8F3WAQjL0ixIHTR0pS4xBDPGlLB1+MK2vSbU2UCMlVJDghtHcRUnuZ0F/3W1Ls2Zk/VQPJOZF60oaoU1jaOBxFbkhl+yJGUjXYQHFALBZiZCkjSEOWAMXo11iHC7v21mFQK8vE1Ckbzvk2SiAx6+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aJ8bBkJ2VUXSAjGYKvTaaZ9/NBqsf9jSAiwLkijtFk=;
 b=rAptHgMObtPcK3woauvkFc8zJHVqqAgPMk+zVawKCRearYEoA66NevkyeBFtnM6JMGEifLQQ2Un43uSq6NXdD1Mhrga61zvgBjf0Um1xGofxDueSQ1F5tNvAPE5V7EAOrlKclNrnpta1ocNJi9ccyLqxMCexJcq5FaZ6IHEpM1UH5MPB2FJmGfBfVSAKKQvQUHpr1CLW4EQVuOR/E55bMo1Z2g5ufPEMK8hNnW6cYNGTcuPldU7Hw6+6h5Hsde1Hwv2HsHccRw6pZGhL3487G4qRNR8WfVgtkRdaPrBSKO39KFTlOQk7FGPMCcp5MS4koPMOgz37R7DoZu/5QsaU3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6616.apcprd06.prod.outlook.com (2603:1096:101:168::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 02:25:07 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8769.022; Thu, 29 May 2025
 02:25:06 +0000
Message-ID: <7deb63a4-1f5f-4d6c-9ff4-0239464bd691@vivo.com>
Date: Thu, 29 May 2025 10:25:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] hfs: correct superblock flags
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
 "slava@dubeyko.com" <slava@dubeyko.com>, brauner@kernel.org
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250519165214.1181931-1-frank.li@vivo.com>
 <20250519165214.1181931-2-frank.li@vivo.com>
 <ca3b43ff02fd76ae4d2f2c2b422b550acadba614.camel@dubeyko.com>
 <SEZPR06MB5269D12DE8D4F48AF96E7409E867A@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <e388505b98a96763ea8b5d8197a9a2a17ec08601.camel@ibm.com>
Content-Language: en-US
From: Yangtao Li <frank.li@vivo.com>
In-Reply-To: <e388505b98a96763ea8b5d8197a9a2a17ec08601.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0359.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::13) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a644911-bd90-4ae4-7908-08dd9e58064a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzZlN0dab0pvOWxyTE5ITzdLQmZQL2R3U2RxcC82QytQQTVBV1JxQTd2L1Zx?=
 =?utf-8?B?NnBTeHdCV0pSSVpDMloxbVFxUmxGYnpwQ0RqTzUvVXJWOGtvZ04wMDdPQ3Rr?=
 =?utf-8?B?VlVwa3dMYWdtNGZQbnJ0cU44aXNmRmJCcXJKTnh5VVdZa292Q3BtczBuSzBa?=
 =?utf-8?B?NXFSQ3Uvb1ZoVUVFSmkweXU3blZpL0VxOWo3WmFSV1RtbldTdHYvakZlVkxX?=
 =?utf-8?B?YkFBeXl1NDZoZkE4VEtoNnBmbVR1NDVwMVB2MmFwUlBUNFl3TUIxVlFoakZq?=
 =?utf-8?B?alE2S1duTkRNODRCUzNZeG5HejJnUThzS2lvVlp5UzZKOTN2MGs3RjRWMHB5?=
 =?utf-8?B?RnZkdFpoRmZqbDBtalBFMWw2c0lubUJuRHEwd0NPMmVLZjJlUzFXSWRMOGFu?=
 =?utf-8?B?d3M1ajdHM25xbzNNUWNQSnIvN3VwTDlnNyt6TjVjalZ3RUdWUDY2dVA1NkJs?=
 =?utf-8?B?SkU1R3piaURYU0JVZy94STdSOTRhZTRoOXh5bGNUVTZvNmxSOXFNNy9Icmh5?=
 =?utf-8?B?UnovbEVTUUlPNkUwK1ZFSlVMWERzSGxtRHJxRkNVK25yM3F4WDdUZ0RHY2Q5?=
 =?utf-8?B?SzZrKzJiKzNtT3pLMThPYktDdVIzajUzdVJtazRpU0ZFTkRCdTIxTFV5ZC8x?=
 =?utf-8?B?b3pXNjRkeDJaY0c3T0VxQTdWRzk1M3dpN3N1dlVMaUpIS0tTdCtya3NPRmZv?=
 =?utf-8?B?MHViR0R6WWlQSkhBWjAycTJZSDVUVFU1dFk4NGtPNzkzWExkczZxdHZCUXFa?=
 =?utf-8?B?S2ZMejdWOTFzcS9DSkVKMzVPb3JXa3BVUVNvekozSGFaTFg1VllFaFNjQmpK?=
 =?utf-8?B?OUVHaTZlaFZwaitYZlViT3pvaHJJV1lyanlIOGZvZ2xkNTJUc3ptZjcrWDlT?=
 =?utf-8?B?MmhGVWlDc1lkbU42b3RQT0UrN3ZTQXBFVjF0ekpWczV5eXk5Tnp2NnhqbjJu?=
 =?utf-8?B?TGlzMFhuOU1GWUNQOFFQQTQ5SzNtNGRzNkY2aXdkUHpMTm1MNEs3djIvS1RF?=
 =?utf-8?B?d2ZXT00vYXh1SkpjdTAwVHBHUGgxRXBycVlTVkliYmFoUFF0ditmTHpBY2NF?=
 =?utf-8?B?MUhlUUVRdVFrQkpNS3NNM3dTS3pqTnhjUENwOWtPME5EQlEzQ0FSQlRlVFFY?=
 =?utf-8?B?Unk1VmQxeE9EM2VUTGhMWGx0Q1I0VEVJOHFQb1BBRnJTbGtoUFZ4Vy9FZVZx?=
 =?utf-8?B?UjVVeTI2YnpjOVV6SEhnVW5MRkxsaTJzYTRpc0lpMGxMYjRlWnZZVU1TWUUw?=
 =?utf-8?B?NUNmRG5GWFRwMW1UNm0xQ2tiYVp1K0F3bWdJdVFzY2drT055dUw3UWRSdW91?=
 =?utf-8?B?T0NGL2lXRE1yaFZ1dGNWM3pCdXgzK0pabmNNUEFsSk8wUmU1UzY1eitobzRs?=
 =?utf-8?B?R1Zhcml2c01IV0FZQ0EyZCtLUjB1RnNYU29LTHVTVkU1UlEyd0gvbExrVE1K?=
 =?utf-8?B?cnNJQ3VDbUlNR3cvdmEvN1RKY2ZTbjFBOGg1VVJ1ZFNtTEp0dW5TczdKQ3ly?=
 =?utf-8?B?SlcxS0t4UVh1eURIdlQyRTFvK3FDbnVpaHp3azI5cmxZUXlRQm9BTHBrcUY0?=
 =?utf-8?B?K3hHQjF1REZrZTdBN09ubmFHeFJIRWhNcXo1d1hvUzFyZ3VWU1FjNlM1RXdC?=
 =?utf-8?B?eVpSUUliNFNxbXVzNW9zVTNtakVUMlJmWHBBdy94L3lpUDJXRkIrOENUN1pX?=
 =?utf-8?B?RG5WQWZpVFdyUzBXVEFQaitTbVNmdFhpWk40YWY5YzRlR1dxdko0ZEd4V09F?=
 =?utf-8?B?WGMzZjFtYnc4RGRNTGwweW42NUFyNnN6V1M3R3Z6dXBkSUJWK2JyTFl4Z0l0?=
 =?utf-8?B?NjUwZkd3Yit2emxaUlpWRHRrMEFsblY4a2lmMXBlYkdHbHAzdWpqSEhqWnFk?=
 =?utf-8?B?dW9QZlNGVGJsOXVVUk5TMzdlS1dqT0loMVVhb3c3bzFjMGt4RHlFTnlEU0da?=
 =?utf-8?Q?G1uH26GBd5U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1JYQ2E4WGhubXNVMHFTeG44WjdJeFBmTWNxMG04WmQyOFVONVp0VXQ0OTA2?=
 =?utf-8?B?UTd6UWFLUWFiZ3J4R1lhU0hGWXBtV1RxRUhnODJ5b2lmQnBIcStxL0VDUDVD?=
 =?utf-8?B?WnJjaWxoZ2VBMWExVStPZnBZeUlNaW1QUXlSejJZWWUrWk9OMXF1QnpheXVj?=
 =?utf-8?B?Mm9Wd1hMMmhITGxYemZzcXRJU3h2ZXdFQUxIRXhmZlIyQjZtbVVqZ09BSWtj?=
 =?utf-8?B?Z0o0ZFRXOEl1bDg3dGd6RkJ3cHNCbG9LTVcyYXZGNGwwMGpEU3VYa05KdkRi?=
 =?utf-8?B?NFNHdE9JWXNhaEE4a095bWZVcjhIdCtkNDhOSUxiRUtlM0pxQzNOMHNVTm9D?=
 =?utf-8?B?ZjhkSTB4ZXhLVE85bWhYa2tyQ04rajNHQzBIQlBCWWt0UE5SWlVWWUhrSTJk?=
 =?utf-8?B?c2ovRUxiNDZoaEVPc251VUFXQWkzZ3BDQmtXS2czdXJMdlEyODFwcGxyVkZx?=
 =?utf-8?B?MUNGTktyUGkzUUdOd3diS0VrUHk3R3dSWDF4S3IrSzZsQlprSW95RFFUVStz?=
 =?utf-8?B?ZUdmU1ZwS1FicEd2WEZrbE9UUysxTXBKS05yRTVsVXJtdGFKcWJTL2I1bHpK?=
 =?utf-8?B?aXo0MDhCYXVkYURYMzE4c0NRMWZ3dGRYajl2bmhKYnF1NnhWYjBaZ2pwWW42?=
 =?utf-8?B?RTI2Slo2QlY0N2psbm02S1N6bXpnaUZDeTVYK3VkV1diR0VqaE5DTWdKeGlO?=
 =?utf-8?B?QlE2bUVrbjFTQlBkZ2loRVhvVThodUZYVXF4R0JCbjl3UzRacS9NZExPQVBJ?=
 =?utf-8?B?disvbTFqQW9UbEt3OEV3RkluUEdvaHBVeW1lSm1nZXlQL21kMk9PVlpRYWhv?=
 =?utf-8?B?WnlDVjNTd01FRGtvbEczZWFTU25sazlEZEl1SitxN0lTcTFheEtSaGdwRWYz?=
 =?utf-8?B?K0pzMld1eFpSZW1SbWZJRG84dW9ZKzNyT2tSVEh1UGhpU1BpQThVNHZSVzEr?=
 =?utf-8?B?MEEvaUgyenN2RXc1NlNtdCsvZnZqU1VoREkrT1VUQ3hLRWQwTHdaaTlJMHpp?=
 =?utf-8?B?WURLbGdNZGl2d2NqU1UrTXFhN2xKUkJ5WTAvQVM5QmVZdFpoeXMrSVhBa0p5?=
 =?utf-8?B?Q2VsVGE3eGJPdFExeGJaU0FwaDlHWkpCZzF1TXJhcElhTTlBeldDTE9JM0Zj?=
 =?utf-8?B?b0EyWDYxTVNlQncvRmRlN1M5cUZjRDRLY2NJQUFLK0Zyb2NabTJMcGJZZDJu?=
 =?utf-8?B?Nkw3bEx5cUFjSk5Tb3B4U3c5eGlqcXRpOTJneElvUmpkdWFEUm9hcnlUejFN?=
 =?utf-8?B?MG1iNEVPQjhDMVBXa1g3M2NqUDZ0aXpaa3lGSndKeWJkaVMyOWtqWm55bHFJ?=
 =?utf-8?B?U3EvZDZMYUNHUzdjamZaaWMxSVY4WUxoSDFNeHpPVzcxbk0xR0dKQ2xIYUU2?=
 =?utf-8?B?UWlqbTZHa2VsTUg3a2krYTRLOTNMRXkrS1BKZklPT2dwYlNrUU9zWXhlc1pv?=
 =?utf-8?B?MkRqNHpDRG4vM2RVNEFiellTZEwyRFpnQXZwZVdnb1ZSdkM0MTF5T0ZzV3Y1?=
 =?utf-8?B?NTdIWXdMT0UxMUVDYTFLbzVkckMvTGY4R0F5VDZ6WW9pdTU5MC9VeWgyNFdj?=
 =?utf-8?B?Wlk2R3ZvSHZEanBYc2xqSDFuWjNpeVlmdDNROW15c2psKzNobWhjelFNaTIr?=
 =?utf-8?B?MnRYejBGdE5kUm1WQTUzckxMY0NiTkFibDA1RTZwa1JXQkFjbzVLaytOR1Z4?=
 =?utf-8?B?TERzVUVJTi9BT0wvQVdIQlNnNXdmU1djaTlEUHlFMXRPWUE1MDk3UjJoWjlL?=
 =?utf-8?B?MTdhNlBYeWoyRjhqekVoRWMxcEI2Zkd0L0V5K21nZ285MFdsRjNLdmN4YjAz?=
 =?utf-8?B?YnlRQWZSNFByTmpGY1lQYzlDSTRDWitVb0h0U3hvU1BHVGxyNUwwdDYzVEI1?=
 =?utf-8?B?OHNVYWh4MVVOOVR6ODY4R3lpVWpyNEtDTHQybmkrVm9kMUk4aWxEMkY2WEVM?=
 =?utf-8?B?elBjWXl1UjJSY1lucytiS1hPV1prZjRwbWdNOVRxZW9MdENTbjlZeXczMWRD?=
 =?utf-8?B?WDhFK1lDZmkvZCs1ejNIVkt6S2N2UDIyT2grYnd1RUg0dnV0NzJXeXB1Y1Z1?=
 =?utf-8?B?OFdHREpwT0R2WEpzd1dJM2YrcGFTZThJRVVqNVlQdlZzOXkrK05lakhQVDIr?=
 =?utf-8?Q?mT50b8hIbtfgTG0ZAii8NQEbz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a644911-bd90-4ae4-7908-08dd9e58064a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 02:25:05.9103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: taZFwbU/f9VizYYGllN5tglFlj6ZG1WEUo2B36OXxkwA5sG6kmf4ZpacjC+Uxj42pMn6ruYaNS4qHv2Wmf3n1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6616

+cc Christian Brauner

在 2025/5/29 05:26, Viacheslav Dubeyko 写道:
> On Wed, 2025-05-28 at 16:37 +0000, 李扬韬 wrote:
>> Hi Slava,
>>
>>> I am slightly confused by comment. Does it mean that the fix introduces more errors? It looks like we need to have more clear explanation of the fix here.
>>
>> I'll update commit msg.
>>
>>> s->s_flags |= SB_NODIRATIME | SB_NOATIME;
>>
>> IIUC, SB_NOATIME > SB_NODIRATIME.
>>
> 
> Semantically, it's two different flags. One is responsible for files and another
> one is responsible for folders. So, this is why I believe it's more safe to have
> these both flags.

To be honest, from my point of view, SB_NOATIME is more like disabling 
atime updates for all types of files, not just files. I would like to 
know what vfs people think, whether we need to use both flags at the 
same time.

> 
> Implementation could change but setting these flags we guarantee that it needs
> to take into account not to update atime for files and folders.
> 
>> So we should correct flags in smb, ceph.
>>
> 
> I am not sure that it makes sense. It's more safe to have both flags set.
> 
> Thanks,
> Slava.
> 
>> 2091 bool atime_needs_update(const struct path *path, struct inode *inode)
>> 2092 {
>> 2093         struct vfsmount *mnt = path->mnt;
>> 2094         struct timespec64 now, atime;
>> 2095
>> 2096         if (inode->i_flags & S_NOATIME)
>> 2097                 return false;
>> 2098
>> 2099         /* Atime updates will likely cause i_uid and i_gid to be written
>> 2100         ¦* back improprely if their true value is unknown to the vfs.
>> 2101         ¦*/
>> 2102         if (HAS_UNMAPPED_ID(mnt_idmap(mnt), inode))
>> 2103                 return false;
>> 2104
>> 2105         if (IS_NOATIME(inode))
>> 2106                 return false;
>> 2107         if ((inode->i_sb->s_flags & SB_NODIRATIME) && S_ISDIR(inode->i_mode))
>> 2108                 return false;
>>

Thx,
Yangtao

