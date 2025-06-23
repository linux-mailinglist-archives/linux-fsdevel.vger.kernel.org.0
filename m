Return-Path: <linux-fsdevel+bounces-52474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860F6AE34C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 07:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05860160100
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 05:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177C31C7015;
	Mon, 23 Jun 2025 05:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jO/BBkl9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5228BA2E;
	Mon, 23 Jun 2025 05:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750656766; cv=fail; b=VE4WK+gk+gaRa0yviJrPiWWsABnWMJDs3VM2LSEDoZbJvAZwoFRauHDsq4zzF8fc4Ql2ehv6CbvmU5zXQ22ozCSwWydSGS1tAEbcYlxIXN4dqO8U6QAFI7BKmS6FO2uGMm9n+Nsrqr0+6O/rSgdkrfty+iYKTgDvjXQ8qiTaRwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750656766; c=relaxed/simple;
	bh=6RXmmHmtm8ZGvKQtDCTN9zGur91KQUzYVA9+3zbARXQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MDrK8weANR7NRe79i1rVkeV8Zbussh3n41hP90Feiks3SSpswc2fg+nyIcyVwUaw/Ji+UJY4mDrmO7Go3eRqcUpQx0+bhT1anFFuA9iyvDyWEp1Qc0J3gv/7lNTJk8WT5sOG+nLNP1oO+RDndhpb7OmqCxv8Zp7Fr8/Oa/h9RlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jO/BBkl9; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrS9F/palSfrCA7NymqY6vTF3rbn4iuH15pcBiXtCPPKteuPPpANlfczN+PnUSKGoYNJNpOEpAFFS+xlz+pk9jwrxuMfj5RibqIvz0Z+qAunj5Ci51G9xqNawjY0Hb1tyyqiEvxkNm2NdYEb4Sgg0BJgEcUDCDpa3h9plrG43bxkgf2zsCo36VaQyYrbVlippS8eHMmUHDEL8X90lUtyl7kc0fhtQvFJnBi8gRnaeeBIdyEMJ+WI+lODxhbg1YZf2uHxNgkDF9lGAqIRqeKBOEJsqBmiFZhofnkxx3pxIOEUMpvP2XzZjpQLqxIf9DwCsBFrgQXkZ32e3XQ0sa9upg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWz3Tm7gqNGmXhZGN/HkQcvxu2N/bCCDPxnCx6Ijn1E=;
 b=Pgkda/CZAaaQEX/MXywCYWZBHmei1jcZn+TLdCiOtGmxP31Ot2uFC585ynXLImU1KIOhBIDoEBD+zamRFhEcMGFkc/VW1MwbxHN3ICME0P/rbZVl5C1tS+K36ioPKhILUi3WicevTZv66goINpPsFZs9oXWJea2YuJ2NWaTUNO7zFNiWsFypbDSZJHrIbASVUZ3HezQFdFRf1InXJu5ITF+qqy668/WBx4Ak2qOKxG/Vd3dWiJMzz8anBPZoWyIvs6OBnMdA6PEWfMXW9iS+n5hnMEW8Howhfvi/RucIGkUh9XI9M7sh+2nYXwlYzIx2uml3HM0xRdbVgv3yQICadQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWz3Tm7gqNGmXhZGN/HkQcvxu2N/bCCDPxnCx6Ijn1E=;
 b=jO/BBkl9je2PRpHmfSKUt9RjH8mMOWgBV8cjlDh+liiCauOISzchI6HmbQ5SiwlbCD/kPqcwIxasBJH/L+ok901l0EIvWavJW4N0SylmWSJTwMqvptoOZIXXsRCbIf4Fh+ljFbXO6K0n5mLLl69fFDQZHUIAkxygnbDxi3SowJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa) by DS7PR12MB6336.namprd12.prod.outlook.com
 (2603:10b6:8:93::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Mon, 23 Jun
 2025 05:32:38 +0000
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf]) by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf%8]) with mapi id 15.20.8722.031; Mon, 23 Jun 2025
 05:32:37 +0000
Message-ID: <49404594-880d-4f48-a855-1066b295009d@amd.com>
Date: Mon, 23 Jun 2025 11:02:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: export anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
To: Sean Christopherson <seanjc@google.com>, Mike Rapoport <rppt@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 david@redhat.com, akpm@linux-foundation.org, paul@paul-moore.com,
 viro@zeniv.linux.org.uk, willy@infradead.org, pbonzini@redhat.com,
 tabba@google.com, afranji@google.com, ackerleytng@google.com, jack@suse.cz,
 hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com,
 roypat@amazon.co.uk, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20250619073136.506022-2-shivankg@amd.com>
 <da5316a7-eee3-4c96-83dd-78ae9f3e0117@suse.cz>
 <20250619-fixpunkt-querfeldein-53eb22d0135f@brauner>
 <aFPuAi8tPcmsbTF4@kernel.org>
 <20250619-ablichten-korpulent-0efe2ddd0ee6@brauner>
 <aFQATWEX2h4LaQZb@kernel.org> <aFV3-sYCxyVIkdy6@google.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <aFV3-sYCxyVIkdy6@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0243.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::6) To SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFF6E64BC2C:EE_|DS7PR12MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: dc33c665-627d-4938-45cf-08ddb2175d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmEzZklJbmMvNFpZdjFTN25EZGhEa280ZkVha2o4Nnc0cWd1b2lqeFUxYkpO?=
 =?utf-8?B?aTlnUnRCMlJxd1NnRW10Zm1vd1dURnJlcGcxZzdFTmcyQW9DZi85TXJjZ240?=
 =?utf-8?B?cWI3OWFmakdvMGQrNU5wRHVmSmJlSVJqdVIrTjRia2xGbU9rYlE3amFqWUhK?=
 =?utf-8?B?MURCRTErY1dmQ0pkYkhlcXdUa2c5enViSmdKQlVlWW5RbUI2MmVvS1Z2SFVJ?=
 =?utf-8?B?N1hkeDYxd0ZHMlhRMnYrRVZ0RjFUWnRMclBZVnhUSjJXYW84eEJGVHNaSHdH?=
 =?utf-8?B?VVpNdTRUb1ZOclJQZWhmb2RmV0pralBTUzN1bUFhZHBIM1JmdStkcWJaN0h3?=
 =?utf-8?B?b1gySGh1UUZramVMWnM2cXNpU2R0Y1BBMWdFTnZWNWxLUVVIZTZ0cDJuZ1Ju?=
 =?utf-8?B?d2ZHc2R3M09IR1N4YjRoNlIyaC8rek15NGYyeDdIVnJBS0FZMytzZCt0ai9k?=
 =?utf-8?B?dGJtN3ZBS2lzTDNsais1MmdhWnNDc1J5aEpaMzVSUlZCNHZzUWk5SE5RL0pY?=
 =?utf-8?B?RmZGeDZWQkZnaUJxVmh4aFZqK21jdm44cUtCQ0oyNkczaDNPc2VBVGZabktJ?=
 =?utf-8?B?NFU4QitRbEgzbUlIc01La0owcU03bTJEMlNnTFF3b1hoWHMza1o0RzBTSmNQ?=
 =?utf-8?B?SDdneHoxZHliODVqZ1hYUVBnOGN5bGtnVENMQ2N0L2ludUlSQ28wQ2IrNmFX?=
 =?utf-8?B?RjZuTkl4UGpXSTgvWkRZRVpPcEZkdnpUdzNOYTJOaGVVTG1sb0szaWJFVkpj?=
 =?utf-8?B?NHlnZ3BzZXRySDJEakhyMHRJeEVIUmxnV2tBY2tWMlliMGl3aHVwdWVlMjU4?=
 =?utf-8?B?Q0ZLKzFmbTYvUllKQTkwOXNzQit6TmNReGZjd2piY0FtRjBHaUkxZ1UycnQv?=
 =?utf-8?B?L3hKaTRRand0NUlybk4yUDNuOXh0TzFGcEUvSG5lanpIRlBESHRUaDNQazRp?=
 =?utf-8?B?bnJzUFVyaEpWYXNlYnBCVGlRbmtsVXo4dyt1SE10MEh3SG82SzJRWHZaZ1Js?=
 =?utf-8?B?NTFuMFBuR2NIU2pGa0lWa2J5WWxIN0VmZ2I0UkxzRFhoVWVDOVZ5azhGRURT?=
 =?utf-8?B?ZGRrTW9rZ212Q1lhVEZBaHdIUG5uTXM4cjRRcHZVYm1OaGZXcXhRSjI1dFRB?=
 =?utf-8?B?TkdHU1FZMUlvWndSeHRNRlMvcHErRnJ4ZFd2Z0g1T2J3cW04ODU0dEthZCtv?=
 =?utf-8?B?dDNKaElLckFaYkdudGo5d0JEcDNreG1TK2kvN0E5RlZ2TkhLMysrWGFobHhB?=
 =?utf-8?B?Zi9lZ29FSVRPM2FHb3hFY0dnQUxQVGhwamI3eVRwR1NxcithV0FVc2hMbFdB?=
 =?utf-8?B?SmNYanRXaXNjb3VYaExLNDh2OVIrN0hhSEM5UVY1RHdaeitpMUNJV3lzODkw?=
 =?utf-8?B?ZkREOWhvSFBJa1FNdzlLTU1peHNSNE5OTEhTYjQyMGs1QkVLbkQ4YmgwZFVF?=
 =?utf-8?B?WCtPQVJ3VVgxWXpXblFsRWJQUkpHdkJqVllVSTdsWVJCSkpKUWNORjZSd2Iz?=
 =?utf-8?B?TXNjZ0xOMGFmK1pUM1R2VWZ1YUczZFdjU21NcWh2cExweGNHeElESEVpOXQ4?=
 =?utf-8?B?UzZZcHp1NnhEbEE4dFQ3dTVveHN0b2h1NGVjeVpCZzdZODkxRS94aUl5RFNx?=
 =?utf-8?B?Z3d3OElSNTlyS3AySHJXaEh2NUM0Vk5vdzRHa1JVY2xRSkVqd3g3ZWZVWllm?=
 =?utf-8?B?OVJxaU9iUktjSEo2SEw1N05WVGFtc1o2VUpqajR4TTlLL0tDMTlLTW52M012?=
 =?utf-8?B?WXFHSTFrbWNwSktlNEZaNFkwaS9YVXIrbDdkTEtjNkkrcDVXNGNrTldlbHRo?=
 =?utf-8?B?ckdaTXBFbHNVWDQwc2hZMFhTUnBlaUdtUlhWcUUwSDNtRGMxYXI2Z0ZwZkJD?=
 =?utf-8?B?L0xveG1KSDhZd3pxM2VDMTlSL1lmMloyT1pJZUJMKzVQYTVHam9QcHdyODJp?=
 =?utf-8?Q?QYbh4rLaDs0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPFF6E64BC2C.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVUwQ2V1KzRtbHdoQlJrMHdFdkpjS1hWNDQ0MTcwRTJkdHplOXRMT245Z1lm?=
 =?utf-8?B?bFZRMUxYajdFdUZHL0MrSzBpNDdZKytad09NY3p1VHVtaUhnRHUxckhmaGpN?=
 =?utf-8?B?ZGp5YUNOaW0yd1ZIQnE3cGtockRCR0VFR1RxN2pzSllSSlBtWGhWb0NMSzJv?=
 =?utf-8?B?c1FTZ21YMkgrVzFoZUNkcmd5bTA5Y1l5T001MnVtV2Q0TDYwc3EwRWRLRzgz?=
 =?utf-8?B?cFFqV2NOL1QwVmozSkxhc0ZTMXd0NjJXRmt1cjhEcll0TDZmWkZ3MzlERkhC?=
 =?utf-8?B?d3ZVb2ZxT2d4VlQxaVhpMlZkTTltSnQvbkRNZ21CK3J4TFltTnV2WjV0SVFN?=
 =?utf-8?B?MGpnbGg1WkVxbHZ3THBPcVU2N0lzdlRMdkk3RDNIQ21oTUk5cXpQMnVScVJW?=
 =?utf-8?B?ZFowNU9CQXhodGY4MUM0VVFvQk5PTC8wVUJtaXRkdkk2a0xXVGgzb0VjRmVv?=
 =?utf-8?B?OGJWeWsrc3g1eTJRSmxwS25uTnZUNmVseEh1K3NVaGp3RktUSEo3TGtnbDBx?=
 =?utf-8?B?UWJzVTgxUjZhajBGaHZWZWVqZHd0R0RVS3pnZ1BIMlF2ZHl1cmN6UWEzUlZp?=
 =?utf-8?B?akNuKzRsTkQ4MHRhY2RKNkYzdUY1WVpJS0ZMK3lNR3AxNmppd1grc1ZUS1A3?=
 =?utf-8?B?Q0s1ZWtFNGh1RmNmVFlHc3Q2azBQR2FkN3lTeUlqbVdHZGJqeStDbUpVVG5i?=
 =?utf-8?B?Q2VZMi9ydlZNL2FZL0VJQktTNjEyY2tQdkdXUC9XTjZFZVVXZFhuT0MrOVRv?=
 =?utf-8?B?ZGUybkx3ZXlIWXhQcmYvbmVqanVIaHNCRWN4UjBWalIzY01HZkQxTVVHcEdL?=
 =?utf-8?B?OHAybDIzZnU3WUdlV3NYQzFZUmxIRzhGdENkM1YzRjJrVFNaUXp5QmREc0NT?=
 =?utf-8?B?dHMzbHNWenptM3plWkE4UTB2UXJvZ0tHY2ZIOU5rSTBrYU55bUZ4dnJ2clNG?=
 =?utf-8?B?VzRRSDJvdFByQk5rbkJQeXZJWXRhN2tPMnVqSFMwUDZ3V21oS1EwRFRBV2NC?=
 =?utf-8?B?aWQ4a2N6eDZxMERzVW9xeTEySkJoVEw2Y0UxUWx4ODhhL1lkY2EwQnJIbFhN?=
 =?utf-8?B?QXFKSE16Mm82WFJ6c2paNUpIQXlCVm9LVVppL0ZOZEhUWXVsWkFBSmI0aUU1?=
 =?utf-8?B?empwWmlJUGZJZTYxWlFkTDdwSElybzlhcTBvYkJ3K3Q3OFZZZmlTYzBPTW50?=
 =?utf-8?B?S2VaTXpZZVorSzEzOFBjUTVRY0UrRk5zTytEdVBkcHBnanhrNi90L2QrTmxS?=
 =?utf-8?B?cnRKNmZJbHdQak52MWZ5WTN2MmVNUThLaDk1SDFJeWwwU3lWT3lrTEMyMUhC?=
 =?utf-8?B?UGMzOE1UU1pzMmNuN0xVVE5RSVQvdnJINnhXUllwaGkzb01uVy9DdnFJV1Rm?=
 =?utf-8?B?M0FYL2luY2VKclN4WnkvM2IvUW5BQ3ZWdk9URmhYR0l1dnZNcTRtRG9UYUhm?=
 =?utf-8?B?UWk3VkVqT1AwRFVKbXpCY3lOV3NOcWF5a2JVWEVoakZhM2tNTkkzUEI3UEFH?=
 =?utf-8?B?aEo0M2tKZVk4SGNtaVZxQ3JuaVlobjc1ZDA2eVNLQTJWN0NPTSsyV09KSEU0?=
 =?utf-8?B?VUxQdWJNbGV3OXQ3TjZTbzJTZ09PZzNjOFZqZHA3Q0tmekZDVUROVVVDT3Fy?=
 =?utf-8?B?ZGhPeC9HZDdxVzRFbWgxUFVWVDgyeHFEV1lUZzBrL29ndUxGK1lMdEFVMFF1?=
 =?utf-8?B?QkQ5Nzk0Wlc5UVlYREhWaVBFbEZnYW9vNXFLR25YRzJSZEl5ZXg1YmZsZ1V2?=
 =?utf-8?B?ZXRDbzJVQ0k5M0JlL3pDcWRvMW1wVkxvU3RnbzhDUjhwellIZlBsSmRPajY5?=
 =?utf-8?B?SWk5Y1k0dmIzUk1zd21SbzBrVlhVSFdtOElBbDFwZE5GRnZHVmlJcHZzZmxz?=
 =?utf-8?B?Y2I5cmJMRFZSNkpBUFBZYXl6OXEvRjg0d3Q0Z0J3MjU2N3RYMC9UaUVzZXRI?=
 =?utf-8?B?YmtTZ3FyeGVrYlFZNzVjWDVjRk81ZERrd3ltbzlNdjBOcW1PRk5xZE4weWJK?=
 =?utf-8?B?aDRybWROam9aeDUzRFVycVljR05TeFBvWE9GdGNTYnllWjRwSnc3eFZpT1F1?=
 =?utf-8?B?bWlIM3dxY2kvRDU0djRBak9GdlhWU0JNcjBJZWlFZ1U0cXVrZzVwVnhKQktv?=
 =?utf-8?Q?L4dvfY0VZCszb4Dzfhm4kNKIz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc33c665-627d-4938-45cf-08ddb2175d2c
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 05:32:37.7338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5mlB28exQY423Gl6iHlKnQoYF1Jxt77/Xa7zKIQHj+Vetup/18gEc1NbmTk5wcUY8sBqymlbjDGxK6I3XFcMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6336



On 6/20/2025 8:32 PM, Sean Christopherson wrote:
> On Thu, Jun 19, 2025, Mike Rapoport wrote:
>> On Thu, Jun 19, 2025 at 02:06:17PM +0200, Christian Brauner wrote:
>>> On Thu, Jun 19, 2025 at 02:01:22PM +0300, Mike Rapoport wrote:
>>>> On Thu, Jun 19, 2025 at 12:38:25PM +0200, Christian Brauner wrote:
>>>>> On Thu, Jun 19, 2025 at 11:13:49AM +0200, Vlastimil Babka wrote:
>>>>>> On 6/19/25 09:31, Shivank Garg wrote:
>>>>>>> Export anon_inode_make_secure_inode() to allow KVM guest_memfd to create
>>>>>>> anonymous inodes with proper security context. This replaces the current
>>>>>>> pattern of calling alloc_anon_inode() followed by
>>>>>>> inode_init_security_anon() for creating security context manually.
>>>>>>>
>>>>>>> This change also fixes a security regression in secretmem where the
>>>>>>> S_PRIVATE flag was not cleared after alloc_anon_inode(), causing
>>>>>>> LSM/SELinux checks to be bypassed for secretmem file descriptors.
>>>>>>>
>>>>>>> As guest_memfd currently resides in the KVM module, we need to export this
>>>>>>
>>>>>> Could we use the new EXPORT_SYMBOL_GPL_FOR_MODULES() thingy to make this
>>>>>> explicit for KVM?
>>>>>
>>>>> Oh? Enlighten me about that, if you have a second, please. 
>>>>
>>>> From Documentation/core-api/symbol-namespaces.rst:
>>>>
>>>> The macro takes a comma separated list of module names, allowing only those
>>>> modules to access this symbol. Simple tail-globs are supported.
>>>>
>>>> For example::
>>>>
>>>>   EXPORT_SYMBOL_GPL_FOR_MODULES(preempt_notifier_inc, "kvm,kvm-*")
>>>>
>>>> will limit usage of this symbol to modules whoes name matches the given
>>>> patterns.
>>>
>>> Is that still mostly advisory and can still be easily circumenvented?
> 
> Yes and no.  For out-of-tree modules, it's mostly advisory.  Though I can imagine
> if someone tries to report a bug because their module is masquerading as e.g. kvm,
> then they will be told to go away (in far less polite words :-D).
> 
> For in-tree modules, the restriction is much more enforceable.  Renaming a module
> to circumvent a restricted export will raise major red flags, and getting "proper"
> access to a symbol would require an ack from the relevant maintainers.  E.g. for
> many KVM-induced exports, it's not that other module writers are trying to misbehave,
> there simply aren't any guardrails to deter them from using a "dangerous" export.
>  
> The other big benefit I see is documentation, e.g. both for readers/developers to
> understand the intent, and for auditing purposes (I would be shocked if there
> aren't exports that were KVM-induced, but that are no longer necessary).
> 
> And we can utilize the framework to do additional hardening.  E.g. for exports
> that exist solely for KVM, I plan on adding wrappers so that the symbols are
> exproted if and only if KVM is enabled in the kernel .config[*].  Again, that's
> far from perfect, e.g. AFAIK every distro enables KVM, but it should help keep
> everyone honest.
> 
> [*] https://lore.kernel.org/all/ZzJOoFFPjrzYzKir@google.com 
> 
>> The commit message says
>>
>>    will limit the use of said function to kvm.ko, any other module trying
>>    to use this symbol will refure to load (and get modpost build
>>    failures).
> 
> To Christian's point, the restrictions are trivial to circumvent by out-of-tree
> modules.  E.g. to get access to the above, simply name your module kvm-lol.ko or
> whatever.

Thanks for the info.

I have posted the revised patch with EXPORT_SYMBOL_GPL_FOR_MODULES:
https://lore.kernel.org/linux-mm/20250620070328.803704-3-shivankg@amd.com

Please review when you have a chance.

Thanks,
Shivank

