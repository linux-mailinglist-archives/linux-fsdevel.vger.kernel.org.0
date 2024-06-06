Return-Path: <linux-fsdevel+bounces-21082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A8A8FDE19
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 07:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAEABB22E03
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 05:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AAD38F86;
	Thu,  6 Jun 2024 05:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IyMGwI+B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580ED1754B;
	Thu,  6 Jun 2024 05:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717650983; cv=fail; b=rMHkQ119IC8SHgWtjYy0nCrayTiZgxysDjjWdWcIwR8HFZcZJGubVZuZycP0hdT/ZiD6nRjt9dYwElFiw2tNCWCfl/IfSTfSB5X/AKNldH31eEduKUedJMbQ5jzAMYAa1lTMrAz9b2QSc7Ulf+koFOw6Tw3sPO/aV1so8u9G54A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717650983; c=relaxed/simple;
	bh=mtG1NURpKqbhSowlApmaJiv3CCTZNRpJyRj4ra9nn6E=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=pW56NHwTVWis93kg1BY6gytUedVTAXZQH+O7wncvaemW0X1MZlUdJLIbtLCGlf38DChuOBFi1oiffnhDAb+8THARFKqS2BjA5Gkbqwg4Eil7CqhOR3Zrhv1fqPJABMn2AKwDsMUkpLc6oXasML3irncjI2hh+4tOP3nUKu42/TM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IyMGwI+B; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717650981; x=1749186981;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=mtG1NURpKqbhSowlApmaJiv3CCTZNRpJyRj4ra9nn6E=;
  b=IyMGwI+BGghjBh/BHPvOgecvQ08vk1RN4tamJtBko/q+H7uZqFSjXo6+
   seRodZrbcOjFGi16EdDn+sil0YYLW8LmjeBuMfy2c3tjOLosWMVqwptbj
   kGwoAaKFh8ux07eoPKz9eQyb6QcM2vTb6/4TWEbVqx1tBahxLuCgg2O60
   Lwxt+46J9c97r6quntvoQWmzt5T+9Epb8S8OPB61BN+AMbRdddtcpWO2z
   bNmCiD98CZ56oFil3hcpQv06MQu8kOyUHNH9e7wsY7xbepHpPFkDAoSVB
   LqogwTcVMrKlEqgvU+TmfohdPTXwvuwNkI9MBttDSrODJMGAvSjoD+TdH
   w==;
X-CSE-ConnectionGUID: XMIZBWo6T6y6vzqGXXJiZg==
X-CSE-MsgGUID: ECLUAd+eRUGM17bmUM7pUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="25405364"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="25405364"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 22:16:21 -0700
X-CSE-ConnectionGUID: p9UEp9DETJ6ITeiAg8TZwg==
X-CSE-MsgGUID: LVnUd4hIQBardhCpGl1bDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="37849935"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 22:16:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 22:16:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 22:16:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 22:16:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 22:16:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyDXEGucIvrOs/vgc8hIcmPMeD5ujEbSJ1lplnqt48LgT4IIyDd5mRIRvbniJgwYn9tPaLqT0Wa3aLOWRAVIBpUCdqVmL0IosDhM3v4ucUVJ+Ny3ADBIAkw2H4YAn3BlTR/o6gGTvm7f+uI/bY7/+4rYi9Jz7VokORBvPywStP+uR68hoFfvwIvZGTr1WzhttJkSJCDigUOtxioEVKQSl6Rek6AWUW89eoh4qpP6N29l1pA39nvPanp1Lh+AhaY6Q+hTjXLz26l9XAQeuP4XvU5DmLOBNZ6wUIhBQRyVzGW/Ysk//+izlRKlLoeGw6tmUAUCUG1c1xEYE6NdmnCFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMXVul1CybhlyDjGEJiCfogdMQ1pjh3DJOZA0PhCKLY=;
 b=fQL5mDdiU1Xk3CKTIkFxwCnPZt+d7MejQ6oJOEWydzmdeE7MicR3wjmgbnSLqz8a7lv4S+9lhDLIybcFQohuoqjLBJiahmWKTp7Oi8On44Xr3VIJqQ8FpAX2Zh+/JzLd8nJsWURxLk7SQy1FGb3TjnzJbanirK6pumjUgl9wKSLTTAX1ibrOV4c2V0/9YiHA6ev0sYHiy2W6hP85YNVNclTARJ6V8NTZZTEMlPsuW8VOsUCYnQ/sXxhHRElbioWsvJ9vs+liNkp9gV7lnj6iX1pAZkYcywLVcP0FfK4XDj8HreTMvZby7AwLwzY0wVRyAR1eK39wTm5S4RtU8LMCeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CYXPR11MB8732.namprd11.prod.outlook.com (2603:10b6:930:d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 05:16:18 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 05:16:18 +0000
Date: Thu, 6 Jun 2024 13:16:08 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [jlayton:mgtime] [fs]  0dd26047b0:  unixbench.throughput -1.5%
 regression
Message-ID: <202406061240.e2b14eaf-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0197.apcprd04.prod.outlook.com
 (2603:1096:4:14::35) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CYXPR11MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a71be37-a8ae-4dfe-1713-08dc85e7cb71
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?QuYQJzwy27ohahVIm1JOgfkQYTHJakj4es21smIeaD30YfNEXU9yb9Vk/C?=
 =?iso-8859-1?Q?oySAyNz92UYu2eAVmkqkKBEgIVpUpeBBcNOUeHWnS3aMCDmZB1vUU/3RJ4?=
 =?iso-8859-1?Q?20q2UBJgyTXZ9YVxwpMuNDeTYfrAda5ScE0T9qzVhF+7MnCbcb7Pn4Noww?=
 =?iso-8859-1?Q?WMzalUgqxBSS2ptS12y7y9HWgVBkCB19PzxL7gvATxsAUNaCOhRF3JQ1dY?=
 =?iso-8859-1?Q?Sq1HsZuztA2u6InnbqYzai6xMVhfWFrLVsTRrgmk4CyMu9lr+U+oN8n1fn?=
 =?iso-8859-1?Q?zHz+LaTyFQF0dykxGc4hrZHQ7h02f7bxV7ZE0wIlYJ6u3n49uR6FbUhuNp?=
 =?iso-8859-1?Q?BzEKlIB9OCK1QJ0W6Cs56h7BjUGB4OWH0ZeNr6IeQfxVWZ67jBQyEkw0el?=
 =?iso-8859-1?Q?Cz7pXZsu1d639jneqJok97QxoZBagdXXtkAbqcdiVqgLm00Bun+IY3qgLQ?=
 =?iso-8859-1?Q?rscRBPnIrreRuCUzL3klQZjcBOPJfFuqCOq4RAK4WJ9oK2+lJvbY2htZOp?=
 =?iso-8859-1?Q?aHohdD2YMUbmP/ie4kcVk3PNyNnP/KjVmD32qK0X7KLhgq22HlZHa5Hwjl?=
 =?iso-8859-1?Q?gUZR0o0RAJFUsogOB8DHIwyj8p7GubLoFosBLlhCV2HA2PrDixb/dGI5rC?=
 =?iso-8859-1?Q?O7/wONYohjj4Scp0fjQfpMjyEpkVmyYWnkYL2v9Dz/z8s//df0ESKc5sTa?=
 =?iso-8859-1?Q?tynpnLkWp502Hyq6iAl2BAam8GccWcmbdr54hbGcGbSKfYw/OmPKcObA9g?=
 =?iso-8859-1?Q?ePkYJNShJOg0Ap012D6ZI/1ipCxDNqodpgTbUCoLxBN7Jt16heicpvMorM?=
 =?iso-8859-1?Q?ZCbJlIvyqnBkp66yzNBEMGwBi5D53hMjVy/H/3kU71S/K/P0od13iIxK7r?=
 =?iso-8859-1?Q?51MLZidmFak8Gc/fDVYdB6ql+55WyoyzqLWuAwnfdEAltJaFQK494iokRh?=
 =?iso-8859-1?Q?HM15brQJ2TWV3P+2/n71XvCchdx1swps/1ijz149pWvSbfAXak3bnP9rQB?=
 =?iso-8859-1?Q?o5A+Pv+l0EP9Qd1h+EHU5QOeasHExcz+IPFelqYOeTE+zexWNhmxOC1ZOj?=
 =?iso-8859-1?Q?/+mEVgr9rkLK9iBn0bz9PkUCbL02Amnrqb90JL0w4x5VbN3WA3MrQSdTmO?=
 =?iso-8859-1?Q?ezhjtm++tJ1eoXAy641DBCnBBC7MgzcNXExnlyrZ9XD3KOYXk7Emac+4An?=
 =?iso-8859-1?Q?AylWsr8/Z94sEzZHTb2WMoPntVnTSxER9aVImfXdOEhqXW8/gJtYBTbstK?=
 =?iso-8859-1?Q?0attPbJuhAV0D1JwyMP9/P5fVcllpxbogy91mknKSUPK/l/5w5gp/PIR1p?=
 =?iso-8859-1?Q?ouKDEPWIjhKl8FRzIUpPjHaD5w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SkBKosazLV8Y4EkBq+Z7rU2BENokGAKylhiKg9L5uEid4BHGqCPPX97kTP?=
 =?iso-8859-1?Q?7CeKocRyh1bGJJhR8EAODw7+Q2OXJDFPBksitCbcLlaTF/hmGz6XYfHnZB?=
 =?iso-8859-1?Q?GKhCaEGPV+jnvwIaHCg2Q4v6aOxd3MrA6jFKd8vRnDEXPMFWQJh2qUyMkd?=
 =?iso-8859-1?Q?kq4iyjPAzpLT1y6DtX+UzZ3xrO22kkX4duQNwwTESTbMv+dIBHmax1486z?=
 =?iso-8859-1?Q?eWEknX/3fQ98ZubU6aLrKkV+RwebyU1NX+P9ogMlKV0+s+r28IF7EIdFQF?=
 =?iso-8859-1?Q?FRD2pdJvhPbdLE7hewUgh+MgXV33vAv8YfO/aC7OQtml4lJOQ7G5mCdpcD?=
 =?iso-8859-1?Q?B4BxhVmV8LVzMQ1fgYYYMZbUOapbmwpUl9IOH3+2q0zeHh0qv9cJBpJB+Z?=
 =?iso-8859-1?Q?SHlGbrfaLFiWkYcKIPA4+4Co8iVaAt8ZxfPWcZLrJxa4nRDjY1YCUpRwiL?=
 =?iso-8859-1?Q?aO4G5whFz2SQIobVFgFot/dUPO2TLAGFKYgJrOIkEkIvvyAIcpBmhfZnZn?=
 =?iso-8859-1?Q?QY8LYCR9MjCJ7LaYBJVHco6unfOZMwS+qn5lTwr/CFQEI/k1nP+UeIou4F?=
 =?iso-8859-1?Q?ZziVnASzWdAmyh7TfS4BtY1/9/hkriCuxnpM9vByHgXCdSj/KhZgVZALs6?=
 =?iso-8859-1?Q?mKZmMH8shsUftekWHvqgEvdYrMle5EFP2PJXe3Gw6mgS8s0bFI/QWYLeST?=
 =?iso-8859-1?Q?Q6FWS/80Q7o6ReZgoyvlr0a0GYZ/mE2MIXqe7YEqtmnEbaeypjUFzMelbN?=
 =?iso-8859-1?Q?iownl43I3T0DNop1fYJbeAht9ljez2Xyk3g18f9/RxzF/seprT+gAU7db5?=
 =?iso-8859-1?Q?wPRFJlY/mqeYZTmNzuvsEG/XIAlNzkWvAumqIBsRlE82/BAVXE76oxA7ui?=
 =?iso-8859-1?Q?Owp/UYMqmAFuCi1wXqKslMWfUeTdKHPGIobJKCfbtSe0W5ZC/8QkA7hy/L?=
 =?iso-8859-1?Q?ULU/6KbzL3EAKK81ZxgihgnrltZErhMq/UkZIk0inmeR1LZo1Pu3IrB3E/?=
 =?iso-8859-1?Q?9pw3geNYBHfQCe5bHzlakrBngM9xojZZ4s1dM+8yfH0jNX2n9JDwmYCxP8?=
 =?iso-8859-1?Q?XwvEbthXEtKvjU0t5KgyKWF9Y4LfGXJjXpwkYdK9Ga5+1wI/mbUa39Kz/M?=
 =?iso-8859-1?Q?c701xVQGrcDrqrWApTwHzYqoURYtVHvqaWrjkoitquRxbCkFQvyvx3t8Q5?=
 =?iso-8859-1?Q?zAEHPD/FT2LF2Yf6ht6LpObDtx5xOCqQfS9UOgSsdPlWYX/XGROaBvY4FV?=
 =?iso-8859-1?Q?+GYJ1P46u6NhoEUPAOs025VTi4sYneFzmIF/FOOjcVXjaB1P8Js9LqwQ0C?=
 =?iso-8859-1?Q?gXAya63LLf+3y8XRQoUWzblaScBOOaEb7u8FaqOaOH9YO2JlcQgfuHuSB6?=
 =?iso-8859-1?Q?dOELp4byFrJ4OME/tooLTN48pqykKWH0ZRfmaxsS+gfvhogk2S/cJswci4?=
 =?iso-8859-1?Q?X//bLFN5FW8Hiz8i4S5WdUxOokWt+4ptZf8p+NiMy7a5Kn1NnQT4LImq8i?=
 =?iso-8859-1?Q?lLvCxC21IFFriM35N6sC9U22GmPTx9KM/zbYxKcjwp3BJLwwc1MVngZfNG?=
 =?iso-8859-1?Q?X2dvt+UioDrXythUu2+GpzGhja835A49Pd1WGVPTEQ1lrDs8KT/oxzLVwZ?=
 =?iso-8859-1?Q?YtgdTfFvBszDBl+U4bledQyfDGB1WtVrjQ5jzLlYcjiDKn00uJs2Pj/g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a71be37-a8ae-4dfe-1713-08dc85e7cb71
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 05:16:18.0019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqbF2TPjoMWydBbvQCoAWOTIvMetYl2SOjCB5iF+biyyTRWw22YoBpmOnj+q5Fu3sHq8pVP1wrIC1eHRKjPz2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8732
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -1.5% regression of unixbench.throughput on:


commit: 0dd26047b0b803f7a196f0aee91d22116fdb82d3 ("fs: add tracepoints around multigrain timestamp changes")
https://git.kernel.org/cgit/linux/kernel/git/jlayton/linux.git mgtime

testcase: unixbench
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	runtime: 300s
	nr_task: 100%
	test: pipe
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406061240.e2b14eaf-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240606/202406061240.e2b14eaf-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp9/pipe/unixbench

commit: 
  800a833112 ("fs: have setattr_copy handle multigrain timestamps appropriately")
  0dd26047b0 ("fs: add tracepoints around multigrain timestamp changes")

800a83311219f2ca 0dd26047b0b803f7a196f0aee91 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  16773461 ±  5%     -19.9%   13438976 ±  7%  meminfo.DirectMap2M
     24818 ± 47%     +64.2%      40751 ± 25%  numa-numastat.node0.other_node
     24819 ± 47%     +64.2%      40751 ± 25%  numa-vmstat.node0.numa_other
     62019            -1.0%      61380        proc-vmstat.nr_active_anon
     62019            -1.0%      61380        proc-vmstat.nr_zone_active_anon
     77639            -1.5%      76468        unixbench.score
  96583240            -1.5%   95127283        unixbench.throughput
 3.776e+10            -1.5%  3.718e+10        unixbench.workload
      0.37 ±  2%      +0.0        0.42 ±  2%  perf-stat.i.branch-miss-rate%
   7517646          +306.1%   30525773        perf-stat.i.branch-misses
      0.02            +0.1        0.08        perf-stat.overall.branch-miss-rate%
   7488773          +306.5%   30445089        perf-stat.ps.branch-misses
     32.26            -0.3       32.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     31.30            -0.3       31.04        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     25.43            -0.3       25.18        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     28.12            -0.2       27.89        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     17.14            -0.2       16.93        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.80            -0.1       22.66        perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     54.08            -0.1       53.94        perf-profile.calltrace.cycles-pp.write
      7.76            -0.1        7.68        perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_syscall_64
      5.62            -0.1        5.54        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      6.50            -0.1        6.43        perf-profile.calltrace.cycles-pp._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write.ksys_write
      5.59            -0.1        5.52        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
      6.66            -0.1        6.60        perf-profile.calltrace.cycles-pp.clear_bhb_loop.write
      3.80            -0.1        3.74        perf-profile.calltrace.cycles-pp.touch_atime.pipe_read.vfs_read.ksys_read.do_syscall_64
      3.14            -0.1        3.09        perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.pipe_read.vfs_read.ksys_read
      1.84            -0.0        1.79        perf-profile.calltrace.cycles-pp.mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
      1.06 ±  2%      -0.0        1.02        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.84            -0.0        1.80        perf-profile.calltrace.cycles-pp.mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.68            -0.0        0.66        perf-profile.calltrace.cycles-pp.timestamp_truncate.atime_needs_update.touch_atime.pipe_read.vfs_read
      1.11            -0.0        1.09        perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_write.vfs_write.ksys_write.do_syscall_64
     36.88            +0.1       36.96        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     37.84            +0.1       37.92        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     33.67            +0.1       33.79        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     30.89            +0.1       31.01        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.44            +0.1        1.58        perf-profile.calltrace.cycles-pp.main
      6.70            +0.2        6.92        perf-profile.calltrace.cycles-pp.clear_bhb_loop.read
      2.38 ±  2%      +0.3        2.72        perf-profile.calltrace.cycles-pp.security_file_permission.rw_verify_area.vfs_write.ksys_write.do_syscall_64
      2.89            +0.3        3.22        perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.78 ±  2%      +0.3        2.12 ±  2%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify_area.vfs_write.ksys_write
      4.10 ±  2%      +0.4        4.52        perf-profile.calltrace.cycles-pp.inode_needs_update_time.file_update_time.pipe_write.vfs_write.ksys_write
     25.66            -0.3       25.40        perf-profile.children.cycles-pp.vfs_read
     28.35            -0.2       28.11        perf-profile.children.cycles-pp.ksys_read
     17.82            -0.2       17.60        perf-profile.children.cycles-pp.pipe_read
     68.72            -0.2       68.52        perf-profile.children.cycles-pp.do_syscall_64
     70.48            -0.2       70.29        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     23.47            -0.1       23.32        perf-profile.children.cycles-pp.pipe_write
      4.94            -0.1        4.84        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
     54.28            -0.1       54.18        perf-profile.children.cycles-pp.write
      8.06            -0.1        7.96        perf-profile.children.cycles-pp.copy_page_from_iter
      3.98            -0.1        3.88        perf-profile.children.cycles-pp.mutex_lock
      6.57            -0.1        6.48        perf-profile.children.cycles-pp.entry_SYSCALL_64
      6.66            -0.1        6.58        perf-profile.children.cycles-pp._copy_from_iter
      3.63            -0.1        3.57        perf-profile.children.cycles-pp.atime_needs_update
      2.58            -0.1        2.52        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      3.95            -0.1        3.89        perf-profile.children.cycles-pp.touch_atime
      1.52            -0.0        1.48        perf-profile.children.cycles-pp.timestamp_truncate
     31.15            +0.1       31.26        perf-profile.children.cycles-pp.vfs_write
     33.92            +0.1       34.04        perf-profile.children.cycles-pp.ksys_write
      1.85            +0.1        1.98        perf-profile.children.cycles-pp.main
     13.50            +0.2       13.65        perf-profile.children.cycles-pp.clear_bhb_loop
      4.88 ±  2%      +0.2        5.12        perf-profile.children.cycles-pp.file_update_time
      3.88 ±  2%      +0.4        4.24 ±  2%  perf-profile.children.cycles-pp.apparmor_file_permission
      5.17 ±  2%      +0.4        5.55        perf-profile.children.cycles-pp.security_file_permission
      6.26            +0.4        6.65        perf-profile.children.cycles-pp.rw_verify_area
      4.33 ±  2%      +0.4        4.74        perf-profile.children.cycles-pp.inode_needs_update_time
      4.34 ±  2%      -0.2        4.16        perf-profile.self.cycles-pp.pipe_write
      4.70            -0.1        4.58        perf-profile.self.cycles-pp.vfs_read
      4.77            -0.1        4.66        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.54 ±  2%      -0.1        0.44        perf-profile.self.cycles-pp.file_update_time
      4.69            -0.1        4.61        perf-profile.self.cycles-pp.vfs_write
      2.40            -0.1        2.33        perf-profile.self.cycles-pp.mutex_lock
      6.42            -0.1        6.35        perf-profile.self.cycles-pp._copy_from_iter
      3.17            -0.1        3.12        perf-profile.self.cycles-pp.pipe_read
      1.42            -0.0        1.38        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.26            -0.0        1.22        perf-profile.self.cycles-pp.timestamp_truncate
      1.91            -0.0        1.88        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.82            -0.0        0.80        perf-profile.self.cycles-pp.__cond_resched
      1.02            -0.0        1.00        perf-profile.self.cycles-pp.x64_sys_call
      1.06            -0.0        1.04        perf-profile.self.cycles-pp.aa_file_perm
      1.47            -0.0        1.45        perf-profile.self.cycles-pp.copy_page_from_iter
      0.99            -0.0        0.97        perf-profile.self.cycles-pp.copy_page_to_iter
      0.16 ±  2%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.__x64_sys_write
      1.64            +0.1        1.75        perf-profile.self.cycles-pp.main
     13.36            +0.1       13.50        perf-profile.self.cycles-pp.clear_bhb_loop
      2.53 ±  4%      +0.4        2.92 ±  3%  perf-profile.self.cycles-pp.apparmor_file_permission
      1.08 ±  2%      +0.4        1.50 ±  2%  perf-profile.self.cycles-pp.inode_needs_update_time




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


