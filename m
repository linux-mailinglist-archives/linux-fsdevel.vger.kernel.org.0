Return-Path: <linux-fsdevel+bounces-53400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F4227AEED8E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 07:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28BE81897227
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 05:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C961214A6E;
	Tue,  1 Jul 2025 05:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A7z4sANY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42488A47;
	Tue,  1 Jul 2025 05:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751347628; cv=fail; b=PqgDY8e/yxSjTdLQq3zRK6K9gnFZHphlLP2Enlk/fKvl7omZW2oGv+Kio2jBDvegwAUYL5pJAGHF0UDFbxqZrMZ9/NCvgMCaggvICRinMqolXjYRpXTMJU8M8IHdobz13fI1nf8EXORmKlk36rvksstJKuV7FM32tZ3frMcn3yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751347628; c=relaxed/simple;
	bh=hpeW0xwkegCennoyaKG/U2hz+UA+0ZgrkVFCMGF/RTE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lVkLuYlHxKwQr4+cUzubNeHiAuLeYOHUDRzbvn4c5QO4pfnwzQY82rGGskmdpi/lI3rO6qQmRt5ZvPpkqbZzBwUStEAf59cRWcK6x3h4TgQ9N8CN6aIdVoPbjHPkEX8+U5Oq4t5bxdwXCm4CCGenB8fr+uc0YHb3psqlPcYyORU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A7z4sANY; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751347627; x=1782883627;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=hpeW0xwkegCennoyaKG/U2hz+UA+0ZgrkVFCMGF/RTE=;
  b=A7z4sANYw1FaInBt0XE7eTdJ7n2X3qP+uO32ERvKhL3TXYCckYGiByrD
   9EoT6zAiuRU6HN0WcCgNf4FR2HVXXsMapnDj6gzQywAX9FVw5JUA/VjK0
   f7fg4z/nc99+i2FDAs4mg+kLGN2Rzr8nGv1iYkrEn5y/KbDiGkZwqZs5O
   5On7P5j+flWuBkTr+0hrqXIfBWg50yGDvhX7fQweFJ2rc+6DORbYjDHD0
   xIw99go4UeyD6Td3hgL+fYv9PPLZV7ub1YS5xk2rL31ZeACPHlvOk3sHL
   Zi4oMqyVUTdWa6Pm7TTe5NGPvZomZUuYVLKcBmOMDXwB+H5M8g26dF2ej
   w==;
X-CSE-ConnectionGUID: lfLYWbUzSFyxR/LHepNeHw==
X-CSE-MsgGUID: XY35EQKyQRK/6COIy+Gm2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="56215468"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="56215468"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 22:26:58 -0700
X-CSE-ConnectionGUID: kJXuaYYpRwKrjaFrWhVeaA==
X-CSE-MsgGUID: Tm/o5SvcSB6/oJhVlyh09Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="184589502"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 22:26:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 22:26:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 22:26:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.69)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 22:26:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ppEE0Y6ubXcYrq2hz4HV6/riwZ8xUM8nX8PFXw01cYyCjdgbYZr/aXPDWOJqYBGebepLVI4zkl69Q/3oRoJ0CQvhj7gX9lkML9Lh3ON3mIg8+3hgQTzw/0wUaETiWKHCO4lxEGYWF+wZ6qxOQWgKOg4MEcznG53ppEBQ3nyxdDhXcvpuJVEHp5YrlukePJz+eeceVje6Rel9Iv2kEl7a708kxyWdXriCDmME1LclP47/owgYHPmqqiVnimaUOM7ZIqoDAM0Q8uRaeBQkfwnwqGr6DUA8QtGDW2AWNuw3UHWZatKbr5BZmh8FU+iLi9WjwBG1gpxrDjIjn22uNh9JWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1puZtl8F9l218O2+cltVWUbWyJ3YyAbyLJz08xE5WQc=;
 b=Ldf0MDOW4bCY5mbUvTaeCC4kn91lb4AVP9YNFXacxm1YcfdEfhK3ullAIlu3LKCwryZmYFjo/kMSyz1RuhC3zI08b4wDYrOP1GD7vH3R4TCpoOtqg7QcJ9gSmjNn4fYbRONv89JbClu3wa59BOpHCCdz1RAKomBuU9tQab4HLBUT4TA/zSKHnYciQyDRu+CL4lHC4GKQ41FoC3wTe45p6oTXsZjrzd0vaCjnXMCkQvzmuhtGbY8p0X8i8yGJJad7ixpMBHPBXV0WpUtcieAu/j6dYHfcmo3ZpeN7z4YljERVyVk+1m582OHbVJfqiuh4BRORdYhR0m6hQxC1FBb2nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB5964.namprd11.prod.outlook.com (2603:10b6:208:373::17)
 by PH8PR11MB6853.namprd11.prod.outlook.com (2603:10b6:510:22e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Tue, 1 Jul
 2025 05:26:46 +0000
Received: from MN0PR11MB5964.namprd11.prod.outlook.com
 ([fe80::7a0e:21e8:dce9:dbee]) by MN0PR11MB5964.namprd11.prod.outlook.com
 ([fe80::7a0e:21e8:dce9:dbee%6]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 05:26:46 +0000
Date: Tue, 1 Jul 2025 13:23:45 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Vishal Annapurve <vannapurve@google.com>
CC: Xiaoyao Li <xiaoyao.li@intel.com>, Ackerley Tng <ackerleytng@google.com>,
	<kvm@vger.kernel.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-fsdevel@vger.kernel.org>, <aik@amd.com>,
	<ajones@ventanamicro.com>, <akpm@linux-foundation.org>,
	<amoorthy@google.com>, <anthony.yznaga@oracle.com>, <anup@brainfault.org>,
	<aou@eecs.berkeley.edu>, <bfoster@redhat.com>, <binbin.wu@linux.intel.com>,
	<brauner@kernel.org>, <catalin.marinas@arm.com>, <chao.p.peng@intel.com>,
	<chenhuacai@kernel.org>, <dave.hansen@intel.com>, <david@redhat.com>,
	<dmatlack@google.com>, <dwmw@amazon.co.uk>, <erdemaktas@google.com>,
	<fan.du@intel.com>, <fvdl@google.com>, <graf@amazon.com>,
	<haibo1.xu@intel.com>, <hch@infradead.org>, <hughd@google.com>,
	<ira.weiny@intel.com>, <isaku.yamahata@intel.com>, <jack@suse.cz>,
	<james.morse@arm.com>, <jarkko@kernel.org>, <jgg@ziepe.ca>,
	<jgowans@amazon.com>, <jhubbard@nvidia.com>, <jroedel@suse.de>,
	<jthoughton@google.com>, <jun.miao@intel.com>, <kai.huang@intel.com>,
	<keirf@google.com>, <kent.overstreet@linux.dev>, <kirill.shutemov@intel.com>,
	<liam.merwick@oracle.com>, <maciej.wieczor-retman@intel.com>,
	<mail@maciej.szmigiero.name>, <maz@kernel.org>, <mic@digikod.net>,
	<michael.roth@amd.com>, <mpe@ellerman.id.au>, <muchun.song@linux.dev>,
	<nikunj@amd.com>, <nsaenz@amazon.es>, <oliver.upton@linux.dev>,
	<palmer@dabbelt.com>, <pankaj.gupta@amd.com>, <paul.walmsley@sifive.com>,
	<pbonzini@redhat.com>, <pdurrant@amazon.co.uk>, <peterx@redhat.com>,
	<pgonda@google.com>, <pvorel@suse.cz>, <qperret@google.com>,
	<quic_cvanscha@quicinc.com>, <quic_eberman@quicinc.com>,
	<quic_mnalajal@quicinc.com>, <quic_pderrin@quicinc.com>,
	<quic_pheragu@quicinc.com>, <quic_svaddagi@quicinc.com>,
	<quic_tsoni@quicinc.com>, <richard.weiyang@gmail.com>,
	<rick.p.edgecombe@intel.com>, <rientjes@google.com>, <roypat@amazon.co.uk>,
	<rppt@kernel.org>, <seanjc@google.com>, <shuah@kernel.org>,
	<steven.price@arm.com>, <steven.sistare@oracle.com>,
	<suzuki.poulose@arm.com>, <tabba@google.com>, <thomas.lendacky@amd.com>,
	<usama.arif@bytedance.com>, <vbabka@suse.cz>, <viro@zeniv.linux.org.uk>,
	<vkuznets@redhat.com>, <wei.w.wang@intel.com>, <will@kernel.org>,
	<willy@infradead.org>, <yilun.xu@intel.com>, <yuzenghui@huawei.com>,
	<zhiquan1.li@intel.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Message-ID: <aGNw4ZJwlClvqezR@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
 <aFPGlAGEPzxlxM5g@yzhao56-desk.sh.intel.com>
 <d15bfdc8-e309-4041-b4c7-e8c3cdf78b26@intel.com>
 <CAGtprH-Kzn2kOGZ4JuNtUT53Hugw64M-_XMmhz_gCiDS6BAFtQ@mail.gmail.com>
 <aGIBGR8tLNYtbeWC@yzhao56-desk.sh.intel.com>
 <CAGtprH-83EOz8rrUjE+O8m7nUDjt=THyXx=kfft1xQry65mtQg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGtprH-83EOz8rrUjE+O8m7nUDjt=THyXx=kfft1xQry65mtQg@mail.gmail.com>
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 MN0PR11MB5964.namprd11.prod.outlook.com (2603:10b6:208:373::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB5964:EE_|PH8PR11MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: a44cb4c4-c0fb-490b-6cd0-08ddb85fdf1c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnFxdkpPaHc1QnhVWmtkMHJuVXJ1aDJYbFVjNU1DeTlkUGh6ZFNlSm1XVjMw?=
 =?utf-8?B?QTNqb2JDMTZOUGVnVCtZNTdhSDNYdWVGOVZNT3J5eVhkYnE3cmx6NmZCZFFw?=
 =?utf-8?B?TWEyNjI2SHh5S0RFdjBVaUxZYTM1UXVOTko1YlVaMEkzSWFwL3lFSUJ5Nzh4?=
 =?utf-8?B?VDd4N2dqU2hCa2tZU1B2V1ZxaVBaVG90WjFNUEsxZ2JJNWt0cHdOWjdXMmdr?=
 =?utf-8?B?OVFISXYrclQyTHBSUCtnVE5LKzdncU1nVEViS0FLUjRBdlNsOVlRcStHd09i?=
 =?utf-8?B?MVdlNnFsKzloQ2VkMGlNTGpzM2tyeitPUzJtY3AxSVJFc3cxS1BSUnU0cXlB?=
 =?utf-8?B?VjIzcEFLMTYxWUhKMkphY2Nma3lKMDh6VWxmcmZ4Y0szRkxtVzB1YWp5MDJp?=
 =?utf-8?B?eHJQVm02Zm10L0VEcUQwQjJkMy9URkl2WmlWQmhEaWlmbEJ4amhHaitpa1hI?=
 =?utf-8?B?azN5MGlqeElvWHV1d1VhNUpyYUpLdGcvWE1nYU5lOGsxRzhxRlNHR0paV0ww?=
 =?utf-8?B?TFdrdlJxLzNCT0FURkhDMmczZFRSeWRaaFVFZ3gyYlhiT3ZxdnI3WFRlWm5i?=
 =?utf-8?B?ZFJsRlhueFZWblhNVFZkQ09wb05nUFltTDZscEFkVzF0U3BUa1ZYZW52M0Zw?=
 =?utf-8?B?RER5d016OTRnWTd4ZDFkWTFoMzJFSUlGNHBCaEFvbUdNQ0RnU3FiQmc3UHhT?=
 =?utf-8?B?eDUrK3dVS1FrejNHaGk1aUNRb2RaMUJUekJ0ZE95MXRqc09IWGk0TFNDc1k0?=
 =?utf-8?B?ckgwbU1RZCtaTTlxd1VEeDNUdHRJdlh5Y0ZJWmRPOUhIemJ3bE12TENFek1q?=
 =?utf-8?B?T2VoU21OeXQ1ekoxMExXTkZ3T3FTTkdSbzRJaWxsVGRqZHc1WDBUMER4Z2hX?=
 =?utf-8?B?cjdtTVdNN1gwVzhrL2tSNEFYTFlrYlQxbCs0NTZZNVZldHlOR0dhc3R0NWZI?=
 =?utf-8?B?TmVjeTVBM0VSV28xSWtna0NhL1ppbFBHTitZS3JUSGNZbUtwRUIvY2FTQ2Vx?=
 =?utf-8?B?cndRUllMQUpNOUFxTm8vSHlJVnVLcW9EcVlaREJXYlNtb0g2a3hlT2JwUFcw?=
 =?utf-8?B?dWhRVnRxMlh2Y3pYRG9NcC9wVkY4ZFNtKzJ5cGRSeXA5dTZTNkhhMjRTM0lG?=
 =?utf-8?B?ZkhCanMxMStFT0t3Uk82RmhGTTJSeDVzQktiZmdzUVpRVVhBbXQrUDlXdlNo?=
 =?utf-8?B?QklwanYxd215bFFvaktuWmlpL0ExcHMwQlp1RlNTTDhwSzk5cit4QnUyQ0NX?=
 =?utf-8?B?WWZzRUJPZlIzMjlBTUpyWEh3R28rcHpIU2VVUytGa3BSWWo0UHQrRldZRlVu?=
 =?utf-8?B?NlExV1gxa01ld3FPQ3RkUnJqTTVEL3hnams5YUV3SlRLNHUvM1ErKzJTTkxB?=
 =?utf-8?B?Vnh4Z2FaaVZwcFYrRDM1NzVLOEVUaXZVQUluUFh1UldpWDdxSENwcXRDdXVC?=
 =?utf-8?B?eUxKb0ovUFpON1hnbU4rYmRYcmtJRzMvWXJxM1RJRHVCaGFUM1IyaWl5Z2Mw?=
 =?utf-8?B?THNqZ3ZnVE9lcWdqNEIrc3ZwNm1yRkdzZVJqUjY0V24zVmxFYmRCYTdtSkw4?=
 =?utf-8?B?VktGcldtNWJIN0VTV0N4THRmUWJCc01rTGJyWVF5bWxORHNXVzA0VWxjTGU3?=
 =?utf-8?B?K1pkbmRBbEJKZjFVOGd5b05KZjRpS3M2ZVlqTWZIb1k0NjZpcDRpQ1E5MUtO?=
 =?utf-8?B?TVcwTS85U1VZRkxaMi9ZT1VoTjhpanNRZXE1S3VLRk5BVVd1b1VmT0FmZUZB?=
 =?utf-8?B?TlpiRlVZSU9hL2tyZjljb1k4ek0rWTBHNWV5YTFtNzN6cnlEN2diQ2VNdFFC?=
 =?utf-8?B?YkFHbDZCSXJrVHVFc2xkYW9jem5vWHo4cm5CRU5nZk5CYTVNVUlORmpTRFdy?=
 =?utf-8?B?dWJKSmd0a2ZLVkFPdmVxSWNlMDdMVmlTUlRIb3Z0c0p1Rktobkp1MFBRYVVN?=
 =?utf-8?Q?jLRMxJsFS1U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5964.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWY2akkvZUpLSVFjMGViWlFaYjZ2V1RGUW5IQ2VDckhvUWNSVHRNZFlBcEdq?=
 =?utf-8?B?WVAyamJrRmQwTDNDUFFST2pabUVNL3gxdW9FSEhFbXRIdmlINFZsNk00U3FG?=
 =?utf-8?B?SnlucjdOMldGMGR0Vmdzd1laY2p3RE5FcGZabnNQWnVQU1psTXVuUFRQZElB?=
 =?utf-8?B?a2FMc1AvenNqeHhRa0RicVVORzkvNitCRVBIS2lud1IvWUUvSTd3WE5IeHpW?=
 =?utf-8?B?NUROVmY1UzdPL3BxQ2J1ekozbi8yaWo2MEw1MDc2T0JpTENvNjEzSHB1RzVF?=
 =?utf-8?B?Wjg3RnFRTk9HcXA3dDkzZDErSVcvRjZRbHNGWGlUb1ErVTdrYW0vWkhPT3Nq?=
 =?utf-8?B?MkJTVXFVRkVvRm9KdU9Ja1YxclR2T0Q4Q1p0ams0WVJJNjBHZXlkTnE2R0lL?=
 =?utf-8?B?TzVJY1VFSDNBVkU2aUwvanRldmFOMk14Q2lOYUZNT09zSkYrYWZFVlQrVTlL?=
 =?utf-8?B?YjNwVmtSb0NDbVF4N0JLc053S2VxMzIrY1M2RHZwdDRFMlA5Q1pROFRtN1pt?=
 =?utf-8?B?RE5YWHZwbnlVUWY0YmtISFRIUWhuL0VpQzJXVXltMjAzZU8xSXdVaWR5aGZr?=
 =?utf-8?B?dFljWVZmQUIrb0NneERTSTUvbXV4NFM5YW9KdW8zQU9pUENPU2R3VVlvSE41?=
 =?utf-8?B?ckVQNzJhcmVJeEVXLzB6T1RqYjFFOXcvVllNTEI2MFMxMGQvdUpsdFY4Rmls?=
 =?utf-8?B?QkxHTHAwcDQwak9SVnR0eDVNaUh2eTBNblhOOFFma0s4VklEK2pEcGdqSlMv?=
 =?utf-8?B?czF2SkYxTkJ3aDh5MXlZUUNseTc4YWUrSTEvZ2UreDhNaXB0cWJzOHhyWW5s?=
 =?utf-8?B?a1luZzRCamhlalNwQ2tWYW8rTlhtM1REMVNBU2FKalZRaFJ6K2REZjF5VE95?=
 =?utf-8?B?cVphWDRXMFVYcDA3OVJ1KzZQbFZyb3I5VDlKb2NqVzdVcGsxVmlUVGVidnBL?=
 =?utf-8?B?WFhOd2Z3S2JTKzh2R002elBWSHVURVZNRFVKanQ0RjUxY0U5RFRUOG9LK3di?=
 =?utf-8?B?Y0NITlRUa1hGUWIvazNaMVhKWjNHZGszdjhIWXkwYTlGS2pBUFFzbWNwVTVM?=
 =?utf-8?B?WmZVcTI5ajl5MFhWdGhTMGQ2UVgzY0xuZnExalUxR0tvYjFybGFGR010SU5H?=
 =?utf-8?B?L1JKdnFaTFhUdzNwd0RBWG4wR0lHeTJVc0VJdmUxWGJFWlFjZEpzT0RRenAz?=
 =?utf-8?B?YU1Tdm5ubGRFVU42ODdBMlNKS21icUF5eVdUQWF0UXZKUWR2RG81ZGIxOWpY?=
 =?utf-8?B?aGdFWnNHM1R1bXRwYnB2RVNSdG1Bclc4cnFqUVVGVVlNWnJiQVpnWDB4UmRq?=
 =?utf-8?B?MmFwL2U5ZFliTlFEYStiZXJLREtqTzE4eGYxNGpJa2NxQitZTXlxZG1SeHBB?=
 =?utf-8?B?aEtobmJhU2VJWVFVU1hBeGpsekVuUW1GZlNqNXp5eUx4Y2l5Kzhnd2xhNHdD?=
 =?utf-8?B?MytxbFhKVEZ0NW1YMTFQckxBd3ExOWFUY01hcUt2c2hQcEcvUHZENXh3dGVW?=
 =?utf-8?B?STZKWEZTcEVtR2Zza01KUy9nek05VmNqaVQ0RE5PMzhyUWI0ZlYvd29OVjVF?=
 =?utf-8?B?Unh6ekFqcHZmdjVwT3ZvSW1TblpxaWFiaTFrTTgzV3Q3b1IwdTBzV2hYTWZE?=
 =?utf-8?B?NThoZGRCbmV4WGhwazZOcTcyOTZlbUtJdHpYZ092Ukh1UHZtSWswamRuaEM2?=
 =?utf-8?B?Szh6M3pmRlFpcTZXNDU5ODc3dWlVVjhWZ1pDdUNQT3pyUlVkL3hMLzl5cEdq?=
 =?utf-8?B?QWkzWks5R01ReDFtNDFIU2FjdmM1c2pocVpsYWI3ZDBydi8xYWRIV0tWa1dk?=
 =?utf-8?B?L2dzUXArNkZ5dXBET1FMQ1ROZzh0eFc0Vm15enBkRjlBS0pvcmpPVW9ueCtZ?=
 =?utf-8?B?QVQwSWxBbk9wWnFqYTBFN0lLV1FBR0c2T0hjcjF0Tlc0NXpWUkdzaFdrdmhl?=
 =?utf-8?B?YytPL3Rvc1hWWHg2NktkOUlFL2daMWFFOTdyemxsbEZIWVJod3ZZVlFuaGVK?=
 =?utf-8?B?ZTVUNENKb25zMEVUMi8xOUs0VVlQT01tSy9vM1dmSWVxTFN1VWtrb1hzbnpJ?=
 =?utf-8?B?UFNLUTM1aUI2TTg4OTVKekxvY1dqUkNtYlZXMHB4TW1NbmxabGdwb2VsSXA4?=
 =?utf-8?Q?ZA1Zxx13ZwFYMPqdakPHZsFNF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a44cb4c4-c0fb-490b-6cd0-08ddb85fdf1c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5964.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 05:26:46.3248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0RI0ffcihV15CF7nfqL8hldlv6dMqV/sU4XOCvdlRFDu2wyZiqSqG8xuzyNJwZn2RDVyC6kDqR+v/Pomf/VfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6853
X-OriginatorOrg: intel.com

On Mon, Jun 30, 2025 at 07:14:07AM -0700, Vishal Annapurve wrote:
> On Sun, Jun 29, 2025 at 8:17 PM Yan Zhao <yan.y.zhao@intel.com> wrote:
> >
> > On Sun, Jun 29, 2025 at 11:28:22AM -0700, Vishal Annapurve wrote:
> > > On Thu, Jun 19, 2025 at 1:59 AM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
> > > >
> > > > On 6/19/2025 4:13 PM, Yan Zhao wrote:
> > > > > On Wed, May 14, 2025 at 04:41:39PM -0700, Ackerley Tng wrote:
> > > > >> Hello,
> > > > >>
> > > > >> This patchset builds upon discussion at LPC 2024 and many guest_memfd
> > > > >> upstream calls to provide 1G page support for guest_memfd by taking
> > > > >> pages from HugeTLB.
> > > > >>
> > > > >> This patchset is based on Linux v6.15-rc6, and requires the mmap support
> > > > >> for guest_memfd patchset (Thanks Fuad!) [1].
> > > > >>
> > > > >> For ease of testing, this series is also available, stitched together,
> > > > >> at https://github.com/googleprodkernel/linux-cc/tree/gmem-1g-page-support-rfc-v2
> > > > >
> > > > > Just to record a found issue -- not one that must be fixed.
> > > > >
> > > > > In TDX, the initial memory region is added as private memory during TD's build
> > > > > time, with its initial content copied from source pages in shared memory.
> > > > > The copy operation requires simultaneous access to both shared source memory
> > > > > and private target memory.
> > > > >
> > > > > Therefore, userspace cannot store the initial content in shared memory at the
> > > > > mmap-ed VA of a guest_memfd that performs in-place conversion between shared and
> > > > > private memory. This is because the guest_memfd will first unmap a PFN in shared
> > > > > page tables and then check for any extra refcount held for the shared PFN before
> > > > > converting it to private.
> > > >
> > > > I have an idea.
> > > >
> > > > If I understand correctly, the KVM_GMEM_CONVERT_PRIVATE of in-place
> > > > conversion unmap the PFN in shared page tables while keeping the content
> > > > of the page unchanged, right?
> > >
> > > That's correct.
> > >
> > > >
> > > > So KVM_GMEM_CONVERT_PRIVATE can be used to initialize the private memory
> > > > actually for non-CoCo case actually, that userspace first mmap() it and
> > > > ensure it's shared and writes the initial content to it, after it
> > > > userspace convert it to private with KVM_GMEM_CONVERT_PRIVATE.
> > >
> > > I think you mean pKVM by non-coco VMs that care about private memory.
> > > Yes, initial memory regions can start as shared which userspace can
> > > populate and then convert the ranges to private.
> > >
> > > >
> > > > For CoCo case, like TDX, it can hook to KVM_GMEM_CONVERT_PRIVATE if it
> > > > wants the private memory to be initialized with initial content, and
> > > > just do in-place TDH.PAGE.ADD in the hook.
> > >
> > > I think this scheme will be cleaner:
> > > 1) Userspace marks the guest_memfd ranges corresponding to initial
> > > payload as shared.
> > > 2) Userspace mmaps and populates the ranges.
> > > 3) Userspace converts those guest_memfd ranges to private.
> > > 4) For both SNP and TDX, userspace continues to invoke corresponding
> > > initial payload preparation operations via existing KVM ioctls e.g.
> > > KVM_SEV_SNP_LAUNCH_UPDATE/KVM_TDX_INIT_MEM_REGION.
> > >    - SNP/TDX KVM logic fetches the right pfns for the target gfns
> > > using the normal paths supported by KVM and passes those pfns directly
> > > to the right trusted module to initialize the "encrypted" memory
> > > contents.
> > >        - Avoiding any GUP or memcpy from source addresses.
> > One caveat:
> >
> > when TDX populates the mirror root, kvm_gmem_get_pfn() is invoked.
> > Then kvm_gmem_prepare_folio() is further invoked to zero the folio.
> 
> Given that confidential VMs have their own way of initializing private
> memory, I think zeroing makes sense for only shared memory ranges.
> i.e. something like below:
> 1) Don't zero at allocation time.
> 2) If faulting in a shared page and its not uptodate, then zero the
> page and set the page as uptodate.
> 3) Clear uptodate flag on private to shared conversion.
> 4) For faults on private ranges, don't zero the memory.
> 
> There might be some other considerations here e.g. pKVM needs
> non-destructive conversion operation, which might need a way to enable
> zeroing at allocation time only.
> 
> On a TDX specific note, IIUC, KVM TDX logic doesn't need to clear
> pages on future platforms [1].
Yes, TDX does not need to clear pages on private page allocation.
But current kvm_gmem_prepare_folio() clears private pages in the common path
for both TDX and SEV-SNP.

I just wanted to point out that it's a kind of obstacle that need to be removed
to implement the proposed approach.


> [1] https://lore.kernel.org/lkml/6de76911-5007-4170-bf74-e1d045c68465@intel.com/
> 
> >
> > > i.e. for TDX VMs, KVM_TDX_INIT_MEM_REGION still does the in-place TDH.PAGE.ADD.
> > So, upon here, the pages should not contain the original content?
> >
> 
> Pages should contain the original content. Michael is already
> experimenting with similar logic [2] for SNP.
> 
> [2] https://lore.kernel.org/lkml/20250613005400.3694904-6-michael.roth@amd.com/

