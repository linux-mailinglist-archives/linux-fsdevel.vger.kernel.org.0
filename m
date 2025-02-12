Return-Path: <linux-fsdevel+bounces-41566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD691A320B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 09:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48B4B7A24F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 08:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ED9204C1C;
	Wed, 12 Feb 2025 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XqBaO7O9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6CF2046BD;
	Wed, 12 Feb 2025 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348057; cv=fail; b=rs2vrAQ0HWDNltSZ5EIkt6FrPbkddtMZrlrDQ//mOZ2NdVdNngaio3FQwyIVt2eFt9zicgeOF6YEH5tyfX2Yfaxt3zErzOGxVMnhtl7PAEHAKYvI7C1i3OdYtV6FOOBV5w9yTJRDezVn9BkOHervhUYrtGIzMP8KNq7JE1UMYoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348057; c=relaxed/simple;
	bh=+tIeyb/d19NC5ip03rZsD7f1cGTdSNgF2g+jP5bCfA0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=hFG+hcNIfqaMxces8qYeJNbZ8mePDuML17p7UBp6ea+qI+loFn7H7qDanU1SdbOdkTXWo/RUfyYkRVj9vh1RsFo56uV3AfYdM/eyHKAyZM5brqB7oJUU4c4xkuL7kXSVVrotsfqpa/JiYwH/kCtXWO7+WZRuahMGPTWaP0fd/OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XqBaO7O9; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739348055; x=1770884055;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=+tIeyb/d19NC5ip03rZsD7f1cGTdSNgF2g+jP5bCfA0=;
  b=XqBaO7O9NPLppxZ1vuHB9pPlQPmQsQVRh+O6DpBwWCMsEXhPcKhX3gfj
   pGQ601gDcNI1A0G61W3kjLyFpvkL55hUyoX/MP3oPlsBXc1B+y7M36InR
   wdwy/nmyW0tR44pK78l3ZkKEwOcnWyBc3zFkN9EGAmTGLuk5zSUEpbo0k
   aE9S9LrMVzuwcQ0cNIpLv3pT9daOzCHNO1t886qtWiOlq5nMpOEr5s57k
   iWCvcH20MO0sSrFCq4UIqhhSYYweo9VjRg0UzVqVAtBMMHg65g0kmmsCg
   ma+/68GiqBzLI5RuppemkKuT+NvuGN5PVikEQGyQsanj4TT5GgVaiva/Z
   g==;
X-CSE-ConnectionGUID: uQv4hupUTk+eRwACh07pJw==
X-CSE-MsgGUID: bFexw9gfQjmkWHBoz1q+7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50636037"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="50636037"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 00:14:13 -0800
X-CSE-ConnectionGUID: cxwunE+LSsK7kFT7/olb7w==
X-CSE-MsgGUID: qFIpWPQ0QbWOaJ6+/tGw+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="112509170"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 00:14:12 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 00:14:11 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Feb 2025 00:14:11 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 00:14:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofs7FPOBwlIAyNcSXCa9pThukWuRxLYqxm0EdQg+aMdddQXC9gtJWaENw7+QQTo2dFDDsLBHC1ZaDXLrk+VucNugB9otrBQFxbLj3OBo6BeHYLnlS+63J7ql9Ze5zZmipFANcahMdxJp9QuEKCxjKxT9c4y08ltBzPtYGHSkQuhATvuEn3L9rjYNKZ/DlOJbxDQHt/ZMTHGdjNlqFIGzT6vlQ8VOa+X7o/Y4fxr4Qppo0dFdtuORScnHBWfKxFZWxAKqkxhYQavCoC/BRK7P3Hh/3w26ZlBcCXwgCgjZuwLst78l9GARSnm8ZWrv31bAlQtPsjMQBTPNyrvmSBAEPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqcCUO/tpc+n6KblapVeypWcDt0BEWKr1xjabfFV+as=;
 b=lgOX7C4VmvjZCX63n4neoarHAG2eM+Mph2QqhY9bOXbmkTrxZxkRpBnnLn/bGTnG86yuaIAVyEsEWA2LFCWMPprTo0lBcrAY9FTJoxKt0JnlwpF+HJ3LDpQTRzUxLe/tDD7Cos8WaGg+7Bh2LaUHKwgQFc4gBrHGxj7E6P6h1nHcIDPtDJv38TuVIfNp4HCycASw0PLk1ksK5wfGq0f6TGFv4DtFN5MTxeMpywK3tHh6ITIh00pYlGgRPTKo9YaNCjKAEXwEyc0zdw3yXl2wSyKaiEcnxo2BwMFvsWq/SAZe+wZJPhHOLXQI6G6qsAb9ud8YeCd4CWUh0LckUxlMfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB7519.namprd11.prod.outlook.com (2603:10b6:a03:4c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 08:14:08 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 08:14:08 +0000
Date: Wed, 12 Feb 2025 16:13:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Dave Hansen
	<dave.hansen@intel.com>, <linux-xfs@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [daveh-devel:prefault-20250128] [filemap]  bc10506d7c:
 unixbench.throughput 5.1% improvement
Message-ID: <202502121529.d62a409e-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:820:c::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 0703af91-de64-4a4d-b0d1-08dd4b3d38f0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?8x24IZLhW74JYHrzFXrjnO+aegXFiYlh1hp1VVk68lBFJQ5ckXKavYBkrl?=
 =?iso-8859-1?Q?/prAvsacPa35zLR5FeTznAL/gmY40DH9pTo1Ei/FWg/3DePEk6FRWFEmVH?=
 =?iso-8859-1?Q?CXpVIdO0pWk5Y8/ZdJDV/JQahCCBlHZfhWHmY5rqgYAaz7Z9OsgwLb7TH+?=
 =?iso-8859-1?Q?8/lwm7HMA3NWB3JVNVGbUVCu3sQZL/06+fPgKhVPOdCpwPR1c41OuX8uDO?=
 =?iso-8859-1?Q?DuhrjedJDcvv6cqlgF/TOaVkybvhV6TnSVg5GowApt/rZI4oXwkX4lXkxC?=
 =?iso-8859-1?Q?WKAMR/SSHpi3NBvDUJqvUuMfHeE2oJD/Unp09Wtnp9Y4usDzzgLuZC2Qfw?=
 =?iso-8859-1?Q?r2H1I1i/3QBPBSPlSGylZEmpd9IuZ69cGSs8nndOoaBK9oozRQqKOmkCrz?=
 =?iso-8859-1?Q?etXtPPisetbY7OzOfwqg5P5S2EGdLfznqzWvnJMVRZZQQSnJ/B5mQy/+kG?=
 =?iso-8859-1?Q?5eiBF6xzvS8+pv3sY4LicBBPR5ZNebxlDj7Ru0MJIGNmGNkAZC0Llsn67K?=
 =?iso-8859-1?Q?5I9rx8Z9xnUb1eH7E2pCEzGWg4CfvNixd5gIsC1S4mY7bmgPDqeT6NXYEF?=
 =?iso-8859-1?Q?Y/8JRpsSHi9fQcK50zB80TfO015OhITuhpnRsy8U5qAUPoW6yW9b6BJtKd?=
 =?iso-8859-1?Q?RvcKRbPrFC14W5ky1EecCS/LK2zaMtFcm91eQ49yJFW0SwFfWWwNvIVGtP?=
 =?iso-8859-1?Q?LzT8KM6O2xZ5ZpzQ6lYHEdzEi1SHtM/KDyI1GMK1hFPeg4UXzqaXDpKJJ1?=
 =?iso-8859-1?Q?wBUXqw2jtTRC1PCnaIakqey3R13pB6t+0IxPMV8DgHa1l29b6oVJFbkrFT?=
 =?iso-8859-1?Q?TrmXitYHMjUBrcoSkz4aYz8OzzCMdB43omIkVwuvjuH8nO//rge0V/DycW?=
 =?iso-8859-1?Q?KYM9mZ01hYP+28UAGuGZl4oZ0Xfyjn+5kMQFRnnzwA9u3lCHQRqg9rqTc3?=
 =?iso-8859-1?Q?X1KKrwfk9PkEYUtK++adfEoJl3eGQtenAyOIqoXRKki9JoQtFf7VD5YjO4?=
 =?iso-8859-1?Q?oPASmqYPPUlgPJMNEUAVK3Bbp62N6aqa0YIKDYYkeoDlRd34vahfbDANtM?=
 =?iso-8859-1?Q?9BjPGFX/a+jBhxK+ySSnp2+LWhbdfxMEmGhjSP++leFXAwDFDB76LbBu23?=
 =?iso-8859-1?Q?R4/t3BsyT4tJuaiWbEhti8MM2g97Mez/ha4iRCm/Ifun7rlXdvq8sJmAQv?=
 =?iso-8859-1?Q?Aw/7jbjfWZuuKMtCMWyDTme4JvPm29vsVn6yeAN/hA+QjfdrlV1i3HJ5uL?=
 =?iso-8859-1?Q?3c8F+zvELwnMDPVjR9AiWyOqMLgS4JJFlsX90dop648VwdUHPPBiTyBas8?=
 =?iso-8859-1?Q?N0O4WQkeuKoGD4JkuiT+3BHeABhyvvdDFbVVkXc5AcC7M1NVep015LMg66?=
 =?iso-8859-1?Q?GYaGLG5HSkaFUFGQgZXKQqLGXSm8opog=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?E3zxVme75Q9dfWYw+tw4193fN556nQId0LjgtHBiNslcAlZ7uuT04ZByJ2?=
 =?iso-8859-1?Q?4vbB1UNylyus7FR1o0CZmOC48mA0k8eqbY24rOttjqg1ojyY0ITMWByvoy?=
 =?iso-8859-1?Q?D44BYHKUnIMJf80FjPOLEdOOjq0TWhx4EwSwXlqvP0yJgS4gGiYhXliRo7?=
 =?iso-8859-1?Q?XGRei+5TR0X13740sMnc5mRsmveztC1jtM082DxM8b7jxeXUAbv8rGBuAt?=
 =?iso-8859-1?Q?MYt2z7VNZcLfZ2DQT4X0UivPkTRmvbiCGkVHYPGFjreLFQgBAeKJJUyDnb?=
 =?iso-8859-1?Q?9rHjQpu2q8HoOusfym8721lAyfJl43rKLl9Y2a5Ik9SNjNAgEx30D+/yN3?=
 =?iso-8859-1?Q?kCQoH9tRNF50AVgg09BabNxNhcbyiXfjYgG8sY2t2anSS0Z1tcBWnzx0wN?=
 =?iso-8859-1?Q?HMev/Okx/QL3F2jpyWsaAqVOXx32Y/JGOOFLt0/Ge/5d0FQeHOMLIgAHRc?=
 =?iso-8859-1?Q?rlBtoj7vOlsD0WbBMN/6dO2xnx8GJQjyT4qHvc8slYxEYW3ZLkdQznXV88?=
 =?iso-8859-1?Q?G/AEbofAimryjhWm4hZhZJ7AInVczWOTOGeUkatisWSORJjCvkYjUz4fr0?=
 =?iso-8859-1?Q?H0c17Qrf/27HvbJSpeHZvdtsOwnULAx8p6npT/5LzdlFC1vomZRJkH7ywt?=
 =?iso-8859-1?Q?L76OixLEofOeEhMYtCIc6hAe0Lo56Y5ARL4mXKqq6q2qw2/tw0J5h8sgtL?=
 =?iso-8859-1?Q?7tRG1yoeuAX1W0ZdL5lxtjG04Ws+ZXuo27Hpg79rSfjpo7uEXeReh500eh?=
 =?iso-8859-1?Q?ZVNzmBIfoqdW0Hlmg1TaREMJIIVOYDi375XcAyNpxrXtiRoRgoO4rruJqK?=
 =?iso-8859-1?Q?ADFzRXRyVspdQQ7DnVfs3/Ubhh5yhXpo5CKMIasTHjqgPTqvCx9xPFyi/g?=
 =?iso-8859-1?Q?eER3emZs2IhSyludLKn5WzqwhIt5A2MPbdYBOLOqYU0Xxvx8OfsdpyjwVz?=
 =?iso-8859-1?Q?FBM9+w3ZeHb8TAFuVx/jJvTHOvPZGZBp2CXEbzErMGvsk7CqmJxZnact6E?=
 =?iso-8859-1?Q?63BD4lkSDMlBHjUIUln60ucRVjGh35Fxsncop7LOVL3wdFxxdAukI9kg+G?=
 =?iso-8859-1?Q?uXt0BQQ7ysFaiIAHqCctQh/wkKfHJhkeKO7D3jaktNESabklpUIW6FiLju?=
 =?iso-8859-1?Q?ZMhA25DXVPMiv2nczB85gOGRslmgJXebc3sxmw9IjidzEYnvact8PxUtNS?=
 =?iso-8859-1?Q?1RlIZtsRByOMqriZueSkPQyOJKSEIPBbYHO+hgsp5MiGdm0tk+RVHMLmV6?=
 =?iso-8859-1?Q?jAvYcPFvJXKRHRw4OlZUTrFd36Mc7U8Vc+c9UCZ4fUIZiw4SNc1oQK47KL?=
 =?iso-8859-1?Q?akbi/qMWVsv9ae6B+TCiNsMcZOjtCxEkJBv2S/ogSQ2Gh9HLOOD+d8GCPb?=
 =?iso-8859-1?Q?8PM0As7TF6HmNSKFS4+lkcHL9fF76kb4rgQlGIByJj0h0oWkNjfJ1pdLPY?=
 =?iso-8859-1?Q?FqxbVWK0BfXnxHpxIRpuyhbrkS/GOuqxT8tqBJNPBVO1KozokrlCefe7yI?=
 =?iso-8859-1?Q?z05STl3diRDP1V0ny2CvgwsTxJjU7loOMR6Hbj49I0FOLnH1XEUwa8j7/4?=
 =?iso-8859-1?Q?jY9KLCMp593fl/qCI4bgqprNK/XxuSlzgO45iq9Vw3sqHhPJmkSF2qMXAk?=
 =?iso-8859-1?Q?4Hlf3KtPl469a7Cuf6CQr0Uye2IuFQPkmIknqNRJ+PlyKE7xt9NeHiKQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0703af91-de64-4a4d-b0d1-08dd4b3d38f0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 08:14:08.0114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RoPhIvmaGPyFYnAcoJ+XX8XVsgd9SXF3Slj9lFbcSoKri9NZQ0SnKFkI67D451vhw/1kdPVeYOrDEB8T0oI2ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7519
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 5.1% improvement of unixbench.throughput on:


commit: bc10506d7c3cec7a236483876d5c717875d3d5aa ("filemap: Move prefaulting out of hot write path")
https://git.kernel.org/cgit/linux/kernel/git/daveh/devel.git prefault-20250128

testcase: unixbench
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	runtime: 300s
	nr_task: 100%
	test: fsbuffer-w
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+--------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops 8.8% improvement                   |
| test machine     | 384 threads 2 sockets Intel(R) Xeon(R) 6972P (Granite Rapids) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                   |
|                  | mode=thread                                                                    |
|                  | nr_task=100%                                                                   |
|                  | test=pwrite1                                                                   |
+------------------+--------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250212/202502121529.d62a409e-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp9/fsbuffer-w/unixbench

commit: 
  v6.13
  bc10506d7c ("filemap: Move prefaulting out of hot write path")

           v6.13 bc10506d7c3cec7a236483876d5 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1.33 ± 31%     -55.0%       0.60 ± 58%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1360 ± 54%     +60.1%       2178 ± 37%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      1360 ± 54%     +60.1%       2178 ± 37%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
  32677306            +5.1%   34349550        unixbench.throughput
      1889            +4.5%       1975        unixbench.time.user_time
 1.211e+10            +5.1%  1.273e+10        unixbench.workload
 4.557e+10            +1.7%  4.635e+10        perf-stat.i.branch-instructions
      1.04            +1.0%       1.05        perf-stat.i.ipc
      0.94            -1.0%       0.93        perf-stat.overall.cpi
      1.06            +1.1%       1.07        perf-stat.overall.ipc
      5942            -4.0%       5705        perf-stat.overall.path-length
 4.548e+10            +1.7%  4.626e+10        perf-stat.ps.branch-instructions
      5.46            -5.5        0.00        perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
     35.65            -3.1       32.55        perf-profile.calltrace.cycles-pp.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
     58.13            -2.2       55.93        perf-profile.calltrace.cycles-pp.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     66.56            -1.7       64.87        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     71.11            -1.5       69.63        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     77.66            -1.1       76.52        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     79.00            -1.1       77.91        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     98.58            -0.1       98.50        perf-profile.calltrace.cycles-pp.write
      0.60            +0.0        0.64        perf-profile.calltrace.cycles-pp.setattr_should_drop_suidgid.file_remove_privs_flags.__generic_file_write_iter.generic_file_write_iter.vfs_write
      0.66            +0.0        0.70        perf-profile.calltrace.cycles-pp.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      0.58            +0.0        0.61        perf-profile.calltrace.cycles-pp.folio_wait_stable.__filemap_get_folio.simple_write_begin.generic_perform_write.generic_file_write_iter
      0.61            +0.0        0.65        perf-profile.calltrace.cycles-pp.w_test
      0.86            +0.0        0.90        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.72            +0.0        0.76        perf-profile.calltrace.cycles-pp.__cond_resched.down_write.generic_file_write_iter.vfs_write.ksys_write
      0.93            +0.0        0.98        perf-profile.calltrace.cycles-pp.generic_write_check_limits.generic_write_checks.generic_file_write_iter.vfs_write.ksys_write
      0.78            +0.0        0.83        perf-profile.calltrace.cycles-pp.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.76 ±  3%      +0.1        0.81        perf-profile.calltrace.cycles-pp.xattr_resolve_name.__vfs_getxattr.cap_inode_need_killpriv.security_inode_need_killpriv.file_remove_privs_flags
      0.80            +0.1        0.86        perf-profile.calltrace.cycles-pp.__cond_resched.__filemap_get_folio.simple_write_begin.generic_perform_write.generic_file_write_iter
      0.86            +0.1        0.92        perf-profile.calltrace.cycles-pp.folio_mark_dirty.simple_write_end.generic_perform_write.generic_file_write_iter.vfs_write
      1.08            +0.1        1.14        perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.33 ±  2%      +0.1        1.40        perf-profile.calltrace.cycles-pp.ktime_get_coarse_real_ts64_mg.current_time.inode_needs_update_time.file_update_time.__generic_file_write_iter
      1.47            +0.1        1.55        perf-profile.calltrace.cycles-pp.__fsnotify_parent.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.00            +0.1        3.08        perf-profile.calltrace.cycles-pp.__vfs_getxattr.cap_inode_need_killpriv.security_inode_need_killpriv.file_remove_privs_flags.__generic_file_write_iter
      2.07            +0.1        2.16        perf-profile.calltrace.cycles-pp.generic_write_checks.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
      1.57            +0.1        1.68        perf-profile.calltrace.cycles-pp.folio_unlock.simple_write_end.generic_perform_write.generic_file_write_iter.vfs_write
      1.54            +0.1        1.65        perf-profile.calltrace.cycles-pp.up_write.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
      1.00            +0.1        1.12        perf-profile.calltrace.cycles-pp.balance_dirty_pages_ratelimited_flags.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      3.67            +0.1        3.79        perf-profile.calltrace.cycles-pp.cap_inode_need_killpriv.security_inode_need_killpriv.file_remove_privs_flags.__generic_file_write_iter.generic_file_write_iter
      2.34            +0.1        2.47        perf-profile.calltrace.cycles-pp.down_write.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
      3.06            +0.1        3.19        perf-profile.calltrace.cycles-pp.current_time.inode_needs_update_time.file_update_time.__generic_file_write_iter.generic_file_write_iter
      4.44            +0.2        4.60        perf-profile.calltrace.cycles-pp.security_inode_need_killpriv.file_remove_privs_flags.__generic_file_write_iter.generic_file_write_iter.vfs_write
      3.42            +0.2        3.59        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      4.23            +0.2        4.44        perf-profile.calltrace.cycles-pp.inode_needs_update_time.file_update_time.__generic_file_write_iter.generic_file_write_iter.vfs_write
      5.28            +0.2        5.53        perf-profile.calltrace.cycles-pp.file_update_time.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write
      7.41            +0.3        7.69        perf-profile.calltrace.cycles-pp.file_remove_privs_flags.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write
      4.92            +0.3        5.22        perf-profile.calltrace.cycles-pp.simple_write_end.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      0.69            +0.4        1.06        perf-profile.calltrace.cycles-pp.xas_start.xas_load.filemap_get_entry.__filemap_get_folio.simple_write_begin
      7.27            +0.4        7.69        perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      7.44            +0.5        7.90        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      9.73            +0.5       10.20        perf-profile.calltrace.cycles-pp.clear_bhb_loop.write
      0.00            +0.5        0.52 ±  2%  perf-profile.calltrace.cycles-pp.security_file_permission.rw_verify_area.vfs_write.ksys_write.do_syscall_64
     14.06            +0.6       14.64        perf-profile.calltrace.cycles-pp.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
      2.19            +0.8        2.96        perf-profile.calltrace.cycles-pp.xas_load.filemap_get_entry.__filemap_get_folio.simple_write_begin.generic_perform_write
      5.88            +1.1        7.00        perf-profile.calltrace.cycles-pp.filemap_get_entry.__filemap_get_folio.simple_write_begin.generic_perform_write.generic_file_write_iter
     11.08            +1.5       12.60        perf-profile.calltrace.cycles-pp.__filemap_get_folio.simple_write_begin.generic_perform_write.generic_file_write_iter.vfs_write
     12.05            +1.6       13.63        perf-profile.calltrace.cycles-pp.simple_write_begin.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      5.67            -5.7        0.00        perf-profile.children.cycles-pp.fault_in_iov_iter_readable
     36.46            -3.2       33.30        perf-profile.children.cycles-pp.generic_perform_write
     58.61            -2.2       56.44        perf-profile.children.cycles-pp.generic_file_write_iter
     67.18            -1.6       65.54        perf-profile.children.cycles-pp.vfs_write
     71.43            -1.5       69.98        perf-profile.children.cycles-pp.ksys_write
     78.06            -1.1       76.94        perf-profile.children.cycles-pp.do_syscall_64
     79.29            -1.1       78.22        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     98.87            -0.0       98.83        perf-profile.children.cycles-pp.write
      0.33 ±  2%      +0.0        0.35        perf-profile.children.cycles-pp.__x64_sys_write
      0.30            +0.0        0.32        perf-profile.children.cycles-pp.is_bad_inode
      0.37 ±  2%      +0.0        0.38        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.57            +0.0        0.59        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.30            +0.0        0.32        perf-profile.children.cycles-pp.noop_dirty_folio
      0.59            +0.0        0.62        perf-profile.children.cycles-pp.security_file_permission
      0.71            +0.0        0.74        perf-profile.children.cycles-pp.setattr_should_drop_suidgid
      0.34            +0.0        0.38        perf-profile.children.cycles-pp.inode_to_bdi
      1.11            +0.0        1.16        perf-profile.children.cycles-pp.w_test
      0.96            +0.0        1.00        perf-profile.children.cycles-pp.x64_sys_call
      0.77            +0.0        0.82        perf-profile.children.cycles-pp.folio_wait_stable
      1.02            +0.1        1.08        perf-profile.children.cycles-pp.generic_write_check_limits
      0.99            +0.1        1.04        perf-profile.children.cycles-pp.folio_mapping
      1.06            +0.1        1.12        perf-profile.children.cycles-pp.folio_mark_dirty
      0.98 ±  2%      +0.1        1.05        perf-profile.children.cycles-pp.xattr_resolve_name
      1.44 ±  2%      +0.1        1.52        perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64_mg
      1.27            +0.1        1.35        perf-profile.children.cycles-pp.rw_verify_area
      1.57            +0.1        1.66        perf-profile.children.cycles-pp.__fsnotify_parent
      1.63            +0.1        1.72        perf-profile.children.cycles-pp.rcu_all_qs
      1.67            +0.1        1.78        perf-profile.children.cycles-pp.folio_unlock
      1.64            +0.1        1.75        perf-profile.children.cycles-pp.up_write
      2.35            +0.1        2.46        perf-profile.children.cycles-pp.generic_write_checks
      3.58            +0.1        3.70        perf-profile.children.cycles-pp.__vfs_getxattr
      3.93            +0.1        4.06        perf-profile.children.cycles-pp.cap_inode_need_killpriv
      1.20            +0.1        1.33        perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      2.53            +0.1        2.68        perf-profile.children.cycles-pp.down_write
      3.26            +0.1        3.41        perf-profile.children.cycles-pp.current_time
      4.68            +0.2        4.85        perf-profile.children.cycles-pp.security_inode_need_killpriv
      3.62            +0.2        3.80        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      3.38            +0.2        3.57        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      3.74            +0.2        3.96        perf-profile.children.cycles-pp.__cond_resched
      4.44            +0.2        4.67        perf-profile.children.cycles-pp.inode_needs_update_time
      5.48            +0.3        5.74        perf-profile.children.cycles-pp.file_update_time
      4.24            +0.3        4.51        perf-profile.children.cycles-pp.entry_SYSCALL_64
      7.71            +0.3        8.01        perf-profile.children.cycles-pp.file_remove_privs_flags
      5.22            +0.3        5.54        perf-profile.children.cycles-pp.simple_write_end
      0.80            +0.4        1.16        perf-profile.children.cycles-pp.xas_start
      7.38            +0.4        7.82        perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      9.82            +0.5       10.30        perf-profile.children.cycles-pp.clear_bhb_loop
     14.35            +0.6       14.96        perf-profile.children.cycles-pp.__generic_file_write_iter
      2.48            +0.8        3.27        perf-profile.children.cycles-pp.xas_load
      6.08            +1.2        7.23        perf-profile.children.cycles-pp.filemap_get_entry
     11.46            +1.6       13.01        perf-profile.children.cycles-pp.__filemap_get_folio
     12.25            +1.6       13.84        perf-profile.children.cycles-pp.simple_write_begin
      4.36            -0.1        4.26        perf-profile.self.cycles-pp.generic_perform_write
      0.20 ±  2%      +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.noop_dirty_folio
      0.29            +0.0        0.30        perf-profile.self.cycles-pp.folio_wait_stable
      0.36            +0.0        0.38        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.49            +0.0        0.52        perf-profile.self.cycles-pp.security_file_permission
      0.76            +0.0        0.79        perf-profile.self.cycles-pp.security_inode_need_killpriv
      0.24            +0.0        0.27        perf-profile.self.cycles-pp.inode_to_bdi
      0.56            +0.0        0.59        perf-profile.self.cycles-pp.folio_mark_dirty
      0.61            +0.0        0.64        perf-profile.self.cycles-pp.setattr_should_drop_suidgid
      0.84            +0.0        0.88        perf-profile.self.cycles-pp.x64_sys_call
      0.84            +0.0        0.88        perf-profile.self.cycles-pp.generic_write_check_limits
      0.68            +0.0        0.72        perf-profile.self.cycles-pp.rw_verify_area
      0.79            +0.0        0.84        perf-profile.self.cycles-pp.folio_mapping
      0.59 ±  3%      +0.0        0.64 ±  2%  perf-profile.self.cycles-pp.xattr_resolve_name
      1.59            +0.0        1.64        perf-profile.self.cycles-pp.generic_file_write_iter
      0.78            +0.1        0.83        perf-profile.self.cycles-pp.simple_write_begin
      1.16            +0.1        1.21        perf-profile.self.cycles-pp.__generic_file_write_iter
      1.22            +0.1        1.27        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.03            +0.1        1.10        perf-profile.self.cycles-pp.entry_SYSCALL_64
      1.44            +0.1        1.51        perf-profile.self.cycles-pp.__vfs_getxattr
      1.41            +0.1        1.48        perf-profile.self.cycles-pp.generic_write_checks
      1.33 ±  2%      +0.1        1.40        perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64_mg
      1.24            +0.1        1.30        perf-profile.self.cycles-pp.rcu_all_qs
      1.81            +0.1        1.88        perf-profile.self.cycles-pp.current_time
      1.49            +0.1        1.56        perf-profile.self.cycles-pp.ksys_write
      1.46            +0.1        1.54        perf-profile.self.cycles-pp.__fsnotify_parent
      1.18            +0.1        1.26        perf-profile.self.cycles-pp.inode_needs_update_time
      1.61            +0.1        1.70        perf-profile.self.cycles-pp.down_write
      0.85            +0.1        0.95        perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited_flags
      1.55            +0.1        1.65        perf-profile.self.cycles-pp.folio_unlock
      1.54            +0.1        1.64        perf-profile.self.cycles-pp.up_write
      1.89            +0.1        2.00        perf-profile.self.cycles-pp.do_syscall_64
      2.42            +0.1        2.52        perf-profile.self.cycles-pp.file_remove_privs_flags
      2.10            +0.1        2.24        perf-profile.self.cycles-pp.__cond_resched
      2.38            +0.2        2.53        perf-profile.self.cycles-pp.simple_write_end
      3.05            +0.2        3.21        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      3.26            +0.2        3.45        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      4.02            +0.2        4.27        perf-profile.self.cycles-pp.write
      3.78            +0.3        4.07        perf-profile.self.cycles-pp.__filemap_get_folio
      5.10            +0.3        5.43        perf-profile.self.cycles-pp.vfs_write
      0.60 ±  2%      +0.4        0.96        perf-profile.self.cycles-pp.xas_start
      3.58 ±  2%      +0.4        3.96 ±  2%  perf-profile.self.cycles-pp.filemap_get_entry
      1.77            +0.4        2.17        perf-profile.self.cycles-pp.xas_load
      7.16            +0.4        7.58        perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      9.72            +0.5       10.20        perf-profile.self.cycles-pp.clear_bhb_loop


***************************************************************************************************
lkp-gnr-2ap2: 384 threads 2 sockets Intel(R) Xeon(R) 6972P (Granite Rapids) with 128G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/thread/100%/debian-12-x86_64-20240206.cgz/lkp-gnr-2ap2/pwrite1/will-it-scale

commit: 
  v6.13
  bc10506d7c ("filemap: Move prefaulting out of hot write path")

           v6.13 bc10506d7c3cec7a236483876d5 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     14.26            +1.5       15.81        mpstat.cpu.all.usr%
   3452706 ±  5%      -9.7%    3117051 ±  8%  numa-meminfo.node1.Active
   3452706 ±  5%      -9.7%    3117051 ±  8%  numa-meminfo.node1.Active(anon)
    863593 ±  5%      -9.7%     779394 ±  8%  numa-vmstat.node1.nr_active_anon
    863592 ±  5%      -9.7%     779394 ±  8%  numa-vmstat.node1.nr_zone_active_anon
 1.112e+09            +8.8%  1.209e+09        will-it-scale.384.threads
   2895332            +8.8%    3149461        will-it-scale.per_thread_ops
 1.112e+09            +8.8%  1.209e+09        will-it-scale.workload
    966386            -3.5%     932439        proc-vmstat.nr_active_anon
   1575486            -2.6%    1534047        proc-vmstat.nr_file_pages
    702352 ±  2%      -5.9%     660903        proc-vmstat.nr_shmem
    966386            -3.5%     932439        proc-vmstat.nr_zone_active_anon
      0.25 ± 53%     -45.1%       0.14 ±  9%  perf-sched.sch_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64
      8.04 ± 38%     -42.3%       4.64 ± 16%  perf-sched.sch_delay.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.13 ± 45%     -38.8%       0.08 ±  2%  perf-sched.total_sch_delay.average.ms
      0.50 ± 51%     -45.5%       0.27 ±  9%  perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64
    839.33 ±  5%     +11.6%     936.83 ±  3%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64
    873.83 ±  6%     -18.4%     713.17 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
     16.08 ± 38%     -42.3%       9.28 ± 16%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.25 ± 49%     -45.9%       0.14 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64
      8.04 ± 38%     -42.3%       4.64 ± 16%  perf-sched.wait_time.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
 3.505e+11            +3.6%  3.632e+11        perf-stat.i.branch-instructions
      0.02            -0.0        0.02 ±  2%  perf-stat.i.branch-miss-rate%
      0.74            -4.3%       0.71        perf-stat.i.cpi
 1.266e+12            -1.3%   1.25e+12        perf-stat.i.cpu-cycles
 1.719e+12            +3.2%  1.775e+12        perf-stat.i.instructions
      1.36            +4.6%       1.42        perf-stat.i.ipc
      0.00 ±  8%      -0.0        0.00 ± 12%  perf-stat.overall.branch-miss-rate%
      0.74            -4.4%       0.70        perf-stat.overall.cpi
      1.36            +4.6%       1.42        perf-stat.overall.ipc
    466638            -5.1%     442782        perf-stat.overall.path-length
 3.493e+11            +3.6%  3.619e+11        perf-stat.ps.branch-instructions
 1.261e+12            -1.3%  1.245e+12        perf-stat.ps.cpu-cycles
 1.713e+12            +3.2%  1.769e+12        perf-stat.ps.instructions
 5.188e+14            +3.2%  5.355e+14        perf-stat.total.instructions
     45.78            -5.2       40.57        perf-profile.calltrace.cycles-pp.generic_perform_write.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64.do_syscall_64
     59.00            -4.3       54.71        perf-profile.calltrace.cycles-pp.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     67.90            -3.5       64.37        perf-profile.calltrace.cycles-pp.vfs_write.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
     75.33            -2.8       72.55        perf-profile.calltrace.cycles-pp.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
     11.38            -2.3        9.10 ±  2%  perf-profile.calltrace.cycles-pp.shmem_write_begin.generic_perform_write.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64
     81.99            -2.0       79.97        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
     10.15            -1.9        8.22 ±  2%  perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter.vfs_write
     83.41            -1.8       81.63        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_pwrite
      4.16            -1.2        2.98 ±  2%  perf-profile.calltrace.cycles-pp.filemap_get_entry.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
     94.89            -0.5       94.38        perf-profile.calltrace.cycles-pp.__libc_pwrite
      1.66 ±  2%      -0.3        1.38 ±  5%  perf-profile.calltrace.cycles-pp.folio_mark_accessed.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.81            -0.2        0.59 ±  3%  perf-profile.calltrace.cycles-pp.xas_load.filemap_get_entry.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write
      0.60            -0.1        0.52        perf-profile.calltrace.cycles-pp.file_remove_privs_flags.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64.do_syscall_64
      0.71 ±  2%      +0.1        0.77 ±  3%  perf-profile.calltrace.cycles-pp.__cond_resched.vfs_write.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.63 ±  2%      +0.1        0.71 ±  2%  perf-profile.calltrace.cycles-pp.generic_write_check_limits.generic_write_checks.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64
      0.78 ±  8%      +0.1        0.90 ±  4%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__libc_pwrite
      0.70 ±  4%      +0.1        0.83 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.__libc_pwrite
      1.44            +0.1        1.58 ±  3%  perf-profile.calltrace.cycles-pp.folio_mark_dirty.shmem_write_end.generic_perform_write.shmem_file_write_iter.vfs_write
      1.71            +0.2        1.88        perf-profile.calltrace.cycles-pp.fput.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
      2.29 ±  3%      +0.2        2.46 ±  2%  perf-profile.calltrace.cycles-pp.current_time.inode_needs_update_time.file_update_time.shmem_file_write_iter.vfs_write
      3.78 ±  2%      +0.2        4.00 ±  2%  perf-profile.calltrace.cycles-pp.file_update_time.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64.do_syscall_64
      1.58 ±  2%      +0.2        1.79 ±  3%  perf-profile.calltrace.cycles-pp.generic_write_checks.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64.do_syscall_64
      3.34            +0.2        3.58        perf-profile.calltrace.cycles-pp.down_write.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64.do_syscall_64
      3.16 ±  2%      +0.2        3.40 ±  2%  perf-profile.calltrace.cycles-pp.inode_needs_update_time.file_update_time.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64
      3.78 ±  2%      +0.2        4.03 ±  3%  perf-profile.calltrace.cycles-pp.fdget.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
      2.40            +0.3        2.71 ±  2%  perf-profile.calltrace.cycles-pp.folio_unlock.shmem_write_end.generic_perform_write.shmem_file_write_iter.vfs_write
      1.67 ±  3%      +0.4        2.06 ±  4%  perf-profile.calltrace.cycles-pp.__fsnotify_parent.vfs_write.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.94            +0.4        2.36        perf-profile.calltrace.cycles-pp.up_write.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64.do_syscall_64
      0.00            +0.5        0.54 ±  3%  perf-profile.calltrace.cycles-pp.testcase
      3.36            +0.6        3.97        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
      7.16            +0.8        7.98 ±  2%  perf-profile.calltrace.cycles-pp.shmem_write_end.generic_perform_write.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64
     16.72            +1.0       17.71 ±  2%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.shmem_file_write_iter.vfs_write.__x64_sys_pwrite64
     14.98            +1.6       16.57        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__libc_pwrite
     46.84            -5.4       41.44        perf-profile.children.cycles-pp.generic_perform_write
     60.00            -4.2       55.76        perf-profile.children.cycles-pp.shmem_file_write_iter
     68.74            -3.4       65.33        perf-profile.children.cycles-pp.vfs_write
     75.77            -2.7       73.02        perf-profile.children.cycles-pp.__x64_sys_pwrite64
     11.62            -2.3        9.35 ±  2%  perf-profile.children.cycles-pp.shmem_write_begin
     82.48            -2.0       80.46        perf-profile.children.cycles-pp.do_syscall_64
     10.63            -2.0        8.62 ±  2%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
     83.72            -1.8       81.92        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      4.37            -1.2        3.15 ±  2%  perf-profile.children.cycles-pp.filemap_get_entry
      1.18            -0.3        0.87        perf-profile.children.cycles-pp.xas_load
      1.77 ±  2%      -0.3        1.50 ±  4%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.79            -0.2        0.58 ±  2%  perf-profile.children.cycles-pp.xas_start
      0.24 ±  4%      -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      0.66            -0.1        0.59        perf-profile.children.cycles-pp.file_remove_privs_flags
      0.20 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.ksys_write
      0.20 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.record__pushfn
      0.20 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.write
      0.20 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.writen
      0.05 ±  7%      +0.0        0.07        perf-profile.children.cycles-pp.perf_mmap__read_head
      0.05            +0.0        0.07        perf-profile.children.cycles-pp.ring_buffer_read_head
      0.44            +0.0        0.48 ±  3%  perf-profile.children.cycles-pp.noop_dirty_folio
      0.49 ±  3%      +0.0        0.53        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.65 ±  3%      +0.1        0.73 ±  3%  perf-profile.children.cycles-pp.testcase
      0.72            +0.1        0.81        perf-profile.children.cycles-pp.generic_write_check_limits
      0.85 ±  8%      +0.1        0.97 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.71 ±  3%      +0.1        0.85 ±  8%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      1.72            +0.2        1.89 ±  3%  perf-profile.children.cycles-pp.folio_mark_dirty
      1.78            +0.2        1.95        perf-profile.children.cycles-pp.fput
      2.46 ±  3%      +0.2        2.64 ±  2%  perf-profile.children.cycles-pp.current_time
      3.34 ±  2%      +0.2        3.57 ±  2%  perf-profile.children.cycles-pp.inode_needs_update_time
      3.92 ±  2%      +0.2        4.16 ±  3%  perf-profile.children.cycles-pp.fdget
      1.80 ±  2%      +0.2        2.04 ±  2%  perf-profile.children.cycles-pp.generic_write_checks
      3.53            +0.2        3.78        perf-profile.children.cycles-pp.down_write
      2.50            +0.3        2.82 ±  2%  perf-profile.children.cycles-pp.folio_unlock
      3.43            +0.4        3.81 ±  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.79 ±  3%      +0.4        2.19 ±  4%  perf-profile.children.cycles-pp.__fsnotify_parent
      2.01            +0.4        2.44        perf-profile.children.cycles-pp.up_write
      3.51            +0.6        4.14        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      7.58            +0.9        8.43 ±  2%  perf-profile.children.cycles-pp.shmem_write_end
      8.38            +0.9        9.26        perf-profile.children.cycles-pp.entry_SYSCALL_64
     16.96            +1.0       17.97 ±  2%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      3.15            -0.9        2.24        perf-profile.self.cycles-pp.filemap_get_entry
      3.72            -0.6        3.12        perf-profile.self.cycles-pp.shmem_get_folio_gfp
      1.03            -0.2        0.81 ±  2%  perf-profile.self.cycles-pp.shmem_write_begin
      1.53 ±  2%      -0.2        1.34 ±  3%  perf-profile.self.cycles-pp.folio_mark_accessed
      0.56            -0.2        0.39 ±  3%  perf-profile.self.cycles-pp.xas_start
      0.50 ±  4%      -0.1        0.37 ±  2%  perf-profile.self.cycles-pp.xas_load
      0.58            -0.1        0.51 ±  2%  perf-profile.self.cycles-pp.file_remove_privs_flags
      0.05            +0.0        0.07        perf-profile.self.cycles-pp.ring_buffer_read_head
      0.40 ±  4%      +0.0        0.44        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.52 ±  3%      +0.1        0.58 ±  4%  perf-profile.self.cycles-pp.testcase
      0.56            +0.1        0.64        perf-profile.self.cycles-pp.generic_write_check_limits
      0.78            +0.1        0.86 ±  2%  perf-profile.self.cycles-pp.folio_mark_dirty
      0.94 ±  3%      +0.1        1.02 ±  4%  perf-profile.self.cycles-pp.rw_verify_area
      0.85 ±  9%      +0.1        0.97 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.06 ±  2%      +0.1        1.19 ±  3%  perf-profile.self.cycles-pp.generic_write_checks
      0.68 ±  4%      +0.1        0.82 ±  8%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      1.63            +0.2        1.80        perf-profile.self.cycles-pp.fput
      1.63 ±  3%      +0.2        1.81 ±  3%  perf-profile.self.cycles-pp.shmem_file_write_iter
      1.75            +0.2        1.97 ±  2%  perf-profile.self.cycles-pp.__x64_sys_pwrite64
      1.32 ±  4%      +0.2        1.55 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      3.69 ±  2%      +0.2        3.93 ±  3%  perf-profile.self.cycles-pp.fdget
      2.35 ±  2%      +0.3        2.64 ±  2%  perf-profile.self.cycles-pp.down_write
      2.30            +0.3        2.59 ±  3%  perf-profile.self.cycles-pp.folio_unlock
      1.59 ±  3%      +0.3        1.88 ±  3%  perf-profile.self.cycles-pp.__fsnotify_parent
      3.17 ±  2%      +0.4        3.54 ±  3%  perf-profile.self.cycles-pp.shmem_write_end
      3.35 ±  2%      +0.4        3.74 ±  3%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.84            +0.4        2.25        perf-profile.self.cycles-pp.up_write
      4.57            +0.4        4.99 ±  2%  perf-profile.self.cycles-pp.vfs_write
      3.04            +0.6        3.60        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      8.42            +0.9        9.29        perf-profile.self.cycles-pp.__libc_pwrite
     16.42            +1.0       17.45        perf-profile.self.cycles-pp.copy_page_from_iter_atomic





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


