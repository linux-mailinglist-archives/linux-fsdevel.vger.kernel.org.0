Return-Path: <linux-fsdevel+bounces-28925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006F69711E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 10:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A707B28843E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 08:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9C61B14F8;
	Mon,  9 Sep 2024 08:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZpA8SLk9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C451B14F1
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Sep 2024 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870382; cv=fail; b=gQOwcou5kxZv/8XlY0MMZbZc3kS0oveDSSi9LdtbBSzOBc4G2zQOCHVMjECAj7OfSklCvlx7zpWVarwLw2N0ww7whtyCwEof0yvuGY37dGz+F8nUha0nZejwGeQfQN2pLa+iMITpugzLV6VtNoJED0kP5xA22tTGPY8g8izllN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870382; c=relaxed/simple;
	bh=sTWcVxfxSQsdbcX7PlAO18owjYG63zhbUet8ff0jMmQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=bFL81ScsuUGDL/u0T7RSevNnRpgPG+eJiQsk+7Md2IxmbujaxofJna0lXwexz2JJbMlHY0dzip7uTLrv+8+/gAhsBW+Zp1YZzdZxbJnuObA0Bb4fQBaxHwXccTBMt9c3GXjjpjBvAEJetfc1jdkC+d5wKQLVTFL/SWCkISooqcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZpA8SLk9; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725870379; x=1757406379;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=sTWcVxfxSQsdbcX7PlAO18owjYG63zhbUet8ff0jMmQ=;
  b=ZpA8SLk9oAJtMhROEKdGmDt22lgzxltp62B4wAAbBKY3+Hc2U6lBcfiS
   VbXKY2XS9je2c0hNlZ/KQmj/WRmkEIUF5uW7B80Hzf6IlvzHvt3Ay787Q
   UMZwbU8CFOqap1sbMnHh2NFQEYpXuSL9q8AYiDJucpEuTht1F1uL0Zte3
   FgHLJoq+QMsxKMxVqoZcZN55Vsrf3e/YZpmJ3c1WFwgkhxBJBJrtF9NNB
   9vKyqVPE4OkQws8ob+nRKsEUsQvmA9J11m+qX2ivWrPVgy5CAMdAkd0Jl
   ISAWDCdIkOH4aNbJVqRss9rffDb/7bp/z5339U+k2dQyC0Gok022WR5LT
   w==;
X-CSE-ConnectionGUID: fs+sc67fRzGvaW3cN6BRaw==
X-CSE-MsgGUID: L3JgHvhWS+aA9fxSmZVcaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="35144388"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="35144388"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 01:25:00 -0700
X-CSE-ConnectionGUID: 0UASMBVeRJaFfkGlEzpmNw==
X-CSE-MsgGUID: CbkRXJHASkeYDFSV2kPdlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="89870661"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 01:24:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 01:24:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 01:24:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 01:24:58 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 01:24:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axGg/JLyHgl1GbCchNl4a3IWRXLqUH+L30D45PHCWWI678IOIeyJRgcvi2O9R/Ay4LvqfpobGwNqqJiZ5rF67ylDgMk+2dW4rSK+jwk/SqoOVNH/y1WU/f3xHkkl01bP/gMFaS5dquLqv9SeAYbWnPKLFsymMMPgDQ+9rJ1iKlw34PmFBy+T9C9ZEhIcljZVEri07J+OGAQvutfWVyF/4Viok1DR4ZGOAZNWzpD6kgWazrRn0nKV/F+EY1wPHHzEXjI7zmK0N9/E5yRVP/W9vQ0HjZpqh67YOeaCvO2pOf8BREIE0rDv1YVQp2iKTMj2qGjjw64ogdaepsZooUx7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8i9mYsXPMoG9IY4Djxqx6miVQMsMiJq3qmv0KmwmNY=;
 b=BHrjNpyuV4Y7TA4EfHJ4L6TS7+32xq7wj+5wGggrjSadOhGm3Im3Wx4eusR0/H1nr1vXAP2WJP1KxKbvbxKa0ibWsmv+BCzFKLFC7/ZTY0IiCNg9aAxkMeKujau7v4EDV73LUc0Zf766s9rppuWGM33sbfrPxIHxKaDSpAjRlGFO3PUAQLYHGfDGKcuQXhtrR3yGLr6FrmiGcIJIZTW1H0LRi5taKZiWz/UyT2AAzdoKpSi7GwlaOOcPz98EjRZC4FlSaFAlOkdHUkv787LYCjRc+1VxfHFBH8b22V83uTsbjHbqFTv/h/VjwGNuKXf1NtbGsnLXowue7Ago5ot5JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB5784.namprd11.prod.outlook.com (2603:10b6:510:129::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Mon, 9 Sep
 2024 08:24:50 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7918.020; Mon, 9 Sep 2024
 08:24:50 +0000
Date: Mon, 9 Sep 2024 16:24:38 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<christianvanbrauner@gmail.com>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Jan Kara <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [brauner-vfs:vfs.mgtime] [fs]  a037d5e7f8:
 will-it-scale.per_thread_ops -5.5% regression
Message-ID: <202409091303.31b2b713-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0185.apcprd04.prod.outlook.com
 (2603:1096:4:14::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ffcbbdc-6c47-4ad2-1617-08dcd0a8df64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?vaf3JdX71HjLtNWUWrb4LXUsksStT6r2FvDU0AjykP19vDAQQpX3TtZago?=
 =?iso-8859-1?Q?Y60IYN2rq5wYy5Gn4JLC81hx8uFN2vjwWho0S6zEmyAWQVv+XyqD5TIZnQ?=
 =?iso-8859-1?Q?r4ytczb9NDcJrHXJIboHPuYNdMkQvyctDdFbRd256dmAQdd+UOlKAZ3Y8U?=
 =?iso-8859-1?Q?oYZZFxv4WLX/jl9mXMBFTzVcSwXVDFFTQ1qubvPRLICF6JELFrSdJrEstV?=
 =?iso-8859-1?Q?tWJiJDqole5YWzYf4hekQoapB3iNJHpr6Ktz6FJrDDwGIhtAxr/SzX+qAt?=
 =?iso-8859-1?Q?nYgxUsQtlZ6tQl9ggmmT4xHfJ5D4QPFHZulGJd31RPol+DTFJmGly4uLvm?=
 =?iso-8859-1?Q?6BJmi4GpAoyd/b83P6jqMjygBeTpRPlu0W2KHbN8qq6b6lft5PD/Kynd0G?=
 =?iso-8859-1?Q?kxS6taQCvteNoVIPECvbYPpSGbG9/YWOglc1HK1ADZW8cYL+7LDuHA72d3?=
 =?iso-8859-1?Q?DTkDQk292boKcFHuroGO9ha5SYPG4OSi/LhAnQiZGp/ndQcBxnwYdJAsZV?=
 =?iso-8859-1?Q?VLIf3aY8uzyyQClF2vcAOmOTSl5BQqkvte3KkOX4jVW4bWH5Oi5sKktGuI?=
 =?iso-8859-1?Q?iFp3/mlX+IOAzQdvhEQNMGQ8H8iFo7fs+8EK3ZvhEiRChdvBt8VgE7NBh1?=
 =?iso-8859-1?Q?jMjEJKb2ZpihYEpHUEXas/GsIhm2Jy3FWNMxj8BuRjWflKvWZovhq9UTvc?=
 =?iso-8859-1?Q?cb54MpwhEb7LsLpZ/9cGC0U95PynAhsKHmKsdEWH7aJv74z3wYaPtJsXpy?=
 =?iso-8859-1?Q?LW+qVGDNberX6024uwteQKuW3ZXh6cCYkebAgGphR85G2vsQsKfzauj58J?=
 =?iso-8859-1?Q?B7hpJeazdcUXnObLiokZPjvq8Gr4huA0k2cs9tw/dXdCOvorZyEnHjP4lI?=
 =?iso-8859-1?Q?8gSc8FO3TiRK4s/Ma5aYRRcHAsv1q99cUE/4qvaS/x1Tidt5vLiaPzBzxf?=
 =?iso-8859-1?Q?s1zmaeHMG5O3/BnEWIRHQ/qO0kie5EMQjiBWf8wBg4z/mY+b2TBC3tYhL+?=
 =?iso-8859-1?Q?OzEKo4PFEHL0N42oMHtoYQlxgt93CeJSeN9sUwPzZ0j2E1agF8tbB7f01u?=
 =?iso-8859-1?Q?CLylFXDGydkmyEr2Buw6V+g+TILqI0A4qf5zRVYZK40R2Y2idgV3Kb/fk8?=
 =?iso-8859-1?Q?3qj+6cg2KRBXdxuei5o7Nqo6GhiiFqKRYTD6ftbzRUX6Jk5przqyP4z/Rb?=
 =?iso-8859-1?Q?xTxJzIozEa5txH3w9dM+X3FNcme7su39dHV8d419UfpPyY9zs5k3eClzum?=
 =?iso-8859-1?Q?ttUJnnLdGmbtQA50HgoShpE89/tuWlvE2ghMfyEhbsy3ttg+rNSx+5SvTG?=
 =?iso-8859-1?Q?yWbITyOHFXXB/q1BEVbFCE/DK3DjlmwBIwn/homk+navH2cwShzHoal+4t?=
 =?iso-8859-1?Q?SL+M3FgNDykjv+IHgH+1B0TdH89FRZP6HmNy2qOwqnd9EbwCRep1s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?uVj0Msh3JrL+NmByPd7P+UEOTrC4TJ4Wk2WeLTmR6ktxtCAxqRZrGONYY3?=
 =?iso-8859-1?Q?roJtyKQ+H+iVZSF0Lj7Pow0D9UInLU+GhJ+ZDW3eVmGvyqpzpvCe43hvwu?=
 =?iso-8859-1?Q?A41MitQfPJEkeFxwzhPLNJJrTtnixYEDiewABQQOUIve563Zp4qkYPMyx8?=
 =?iso-8859-1?Q?4tHtFWzjjYuQCRx7RsPyYy7JmugIuMcn5vhmbkGQY1yoV2ZtUbua0O/JqQ?=
 =?iso-8859-1?Q?QldX7ysD2Tsc2/Vg1zdoy1/NqOJay2loGoGGq6k8WSYrqxt+cMmB9R5pAB?=
 =?iso-8859-1?Q?nbnZUobHexeSYJWV8yL4F2TzoFF0n793uH6FjhiCUS+9S/7jrzcH2RDCKw?=
 =?iso-8859-1?Q?wR1Ze0Fthrei1sPEq8NZhd1uFSBqgbg3J5TbGdRtE9GUhcrTC4F0L+kEHO?=
 =?iso-8859-1?Q?3vOcXflx/+f/Yy7cgmZUQkn8mMv6OPjZ+IQcTEf6QHssChNpTYgS0+fmW9?=
 =?iso-8859-1?Q?5L3SQF7wERdiedjeAV/e5XShelgO+np9u22pXcAqzdl5X3ADsJNG3iiw+f?=
 =?iso-8859-1?Q?AfExb9BpwryuAxnArus2/ko6Z5SzgtxUeEiJpRKMLr3FLiM/ThXxFlpExD?=
 =?iso-8859-1?Q?sQERlD8NvwHpbNOrOqGYMU531ab3bH5MhAQiomUWIBBsxTrXEzCUUCyOlv?=
 =?iso-8859-1?Q?ATpRJB71ayrbNiZwgkCWSaMhTNnR9wdvSTU9HPuIzWU4LMYGelrFmAYWB9?=
 =?iso-8859-1?Q?GGD3FttaZOQiXm/WQys3fSNByRxy/D6OZpnsv81SgkCLckDxPtINWJw1+u?=
 =?iso-8859-1?Q?pSBMkkL/azuQl0/5x9EpPfV3ik69WHCjByL6fOUUqRjYtO3S14UWnQ8t5O?=
 =?iso-8859-1?Q?k1TtbhnYmtwzgkhFeO6lRsOhbREuHC6Zf7yx/Cs4QwbuVeRUbx0gG/4Bye?=
 =?iso-8859-1?Q?uK5EeHUc+ccuGG+L80NBUpAN8CG+sKCCARO/Q8tL0AxLA3XxBC34r8xpuA?=
 =?iso-8859-1?Q?/vW2tTWTu1qV/nDIDR0gTTzeew/i9imSnxkAzQC05Dug3+O8lgnKfNya4q?=
 =?iso-8859-1?Q?rW6YHDQA2LrFyY2OhC8s7ECeNz4aWbV04azS3c6WSDhb8aREinppBMWzly?=
 =?iso-8859-1?Q?qE9spg/RnIwXbHqkLwyZRkdNwSX2NUMFU4HIYego9un9WMQlcm8JwIkfzz?=
 =?iso-8859-1?Q?Lpa/zbHTMWG5XMA7PaOscPW7ZQnrMZtywpVIhhuJdPKkdQiaHc0xeEzJ+3?=
 =?iso-8859-1?Q?wJO4DiRrwV0wTbtp4eNlwmLPLRqou7fYjKo+qpLG4nd81gK1gb4LbxT6+e?=
 =?iso-8859-1?Q?LfHMwaT1kBc3dJzl+Q/X1QXG/D1fjhFzDAvNFlhenu/0lVyT2QqpnJcgqN?=
 =?iso-8859-1?Q?ClRpK5O7cLT1sFATl2TZncF+zlvnK2NNgDx1/z9AvIA/2MilQEtAkA2qcK?=
 =?iso-8859-1?Q?TgG9ZXhDZb3yU1U2iKO6AiRD2ZLZs1M1XfGufXOMUgLQCQebQLxvdQBq21?=
 =?iso-8859-1?Q?65igLHsGTilXXxnzg/XTBXSy2SQcvJJbe/RcG1VZ2ZhFYIzKtoiOXw5USH?=
 =?iso-8859-1?Q?Fk/LOZm9poURkXi5dWV7PVVE83mMgQSl0heca/Sbp74InS5SQRfT19yW8c?=
 =?iso-8859-1?Q?dFhFSPlFXNcZuQS4+UfWKwmW4ffIKcKQG/ekhlxIPn8RWuXA9AqnBURqjs?=
 =?iso-8859-1?Q?Q3z/PhgBUk4Gz5jOy6uEo/Rlr5DPEe10Kr3Y3UKQ7nNeGWte7neIU0GQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffcbbdc-6c47-4ad2-1617-08dcd0a8df64
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 08:24:50.4673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOaaR58/KzOMEZ5wO112fJvvgsmAMbBo9e0S6P/BEb/6HAnz3uIVW+65/msjxZTideKFhP01xOBe6ukiMwgUaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5784
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -5.5% regression of will-it-scale.per_thread_ops on:


commit: a037d5e7f81bae8ff69eb670b2ec3f25ad4d2cc2 ("fs: add infrastructure for multigrain timestamps")
https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.mgtime

testcase: will-it-scale
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_task: 100%
	mode: thread
	test: pipe1
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops -2.4% regression                                       |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory          |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | mode=thread                                                                                        |
|                  | nr_task=100%                                                                                       |
|                  | test=writeseek1                                                                                    |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops -5.5% regression                                       |
| test machine     | 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | mode=thread                                                                                        |
|                  | nr_task=100%                                                                                       |
|                  | test=pipe1                                                                                         |
+------------------+----------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409091303.31b2b713-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240909/202409091303.31b2b713-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/thread/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/pipe1/will-it-scale

commit: 
  v6.11-rc1
  a037d5e7f8 ("fs: add infrastructure for multigrain timestamps")

       v6.11-rc1 a037d5e7f81bae8ff69eb670b2e 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     98752            +1.3%     100032        proc-vmstat.nr_active_anon
    103972            +1.2%     105220        proc-vmstat.nr_shmem
     98752            +1.3%     100032        proc-vmstat.nr_zone_active_anon
  84330110            -5.5%   79683588        will-it-scale.64.threads
   1317657            -5.5%    1245055        will-it-scale.per_thread_ops
  84330110            -5.5%   79683588        will-it-scale.workload
 4.678e+10            +1.2%  4.733e+10        perf-stat.i.branch-instructions
      0.03 ±  7%      -0.0        0.02 ±  6%  perf-stat.i.branch-miss-rate%
  12781080 ±  7%     -19.2%   10321748 ±  6%  perf-stat.i.branch-misses
      1.01            -2.3%       0.99        perf-stat.i.cpi
 1.946e+11            +2.4%  1.993e+11        perf-stat.i.instructions
      0.99            +2.4%       1.01        perf-stat.i.ipc
      0.03 ±  7%      -0.0        0.02 ±  6%  perf-stat.overall.branch-miss-rate%
      1.01            -2.4%       0.99        perf-stat.overall.cpi
      0.99            +2.4%       1.01        perf-stat.overall.ipc
    695016            +8.4%     753440        perf-stat.overall.path-length
 4.661e+10            +1.2%  4.717e+10        perf-stat.ps.branch-instructions
  12713767 ±  7%     -19.3%   10263468 ±  6%  perf-stat.ps.branch-misses
 1.939e+11            +2.4%  1.986e+11        perf-stat.ps.instructions
 5.861e+13            +2.4%  6.004e+13        perf-stat.total.instructions
      7.03            -0.4        6.60        perf-profile.calltrace.cycles-pp.clear_bhb_loop.write
      6.89            -0.4        6.48        perf-profile.calltrace.cycles-pp.clear_bhb_loop.read
      6.72            -0.4        6.35        perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_syscall_64
      5.69            -0.3        5.37        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
      5.46            -0.3        5.17        perf-profile.calltrace.cycles-pp._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write.ksys_write
      5.68            -0.3        5.40        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      5.30            -0.3        5.03        perf-profile.calltrace.cycles-pp.copy_page_to_iter.pipe_read.vfs_read.ksys_read.do_syscall_64
     49.56            -0.2       49.34        perf-profile.calltrace.cycles-pp.read
      4.39            -0.2        4.17        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read.ksys_read
      0.56            -0.1        0.43 ± 50%  perf-profile.calltrace.cycles-pp.aa_file_perm.apparmor_file_permission.security_file_permission.rw_verify_area.vfs_write
      2.66            -0.1        2.52        perf-profile.calltrace.cycles-pp.__wake_up_sync_key.pipe_write.vfs_write.ksys_write.do_syscall_64
      1.71            -0.1        1.61        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_sync_key.pipe_write.vfs_write.ksys_write
      1.81            -0.1        1.72        perf-profile.calltrace.cycles-pp.mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.77            -0.1        1.69        perf-profile.calltrace.cycles-pp.mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
      1.04            -0.1        0.97        perf-profile.calltrace.cycles-pp.fput.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.86            -0.1        0.80        perf-profile.calltrace.cycles-pp.testcase
      1.11            -0.1        1.05        perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.12            -0.1        1.06        perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.88            -0.0        0.84        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.read
      1.04            -0.0        1.00        perf-profile.calltrace.cycles-pp.fput.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.72            -0.0        0.68        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.65            -0.0        0.61        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.55            -0.0        0.52 ±  2%  perf-profile.calltrace.cycles-pp.aa_file_perm.apparmor_file_permission.security_file_permission.rw_verify_area.vfs_read
      0.58            -0.0        0.55 ±  2%  perf-profile.calltrace.cycles-pp.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
     53.26            +0.1       53.34        perf-profile.calltrace.cycles-pp.write
      0.00            +0.6        0.56 ±  5%  perf-profile.calltrace.cycles-pp.ktime_get_coarse_ts64.coarse_ctime.current_time.atime_needs_update.touch_atime
      0.00            +0.6        0.64        perf-profile.calltrace.cycles-pp.timestamp_truncate.current_time.atime_needs_update.touch_atime.pipe_read
      0.00            +0.6        0.64        perf-profile.calltrace.cycles-pp.timestamp_truncate.current_time.inode_needs_update_time.file_update_time.pipe_write
     32.72            +0.8       33.51        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     31.75            +0.8       32.58        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     36.32            +1.0       37.27        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     28.50            +1.0       29.49        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     35.33            +1.0       36.34        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +1.1        1.08 ±  2%  perf-profile.calltrace.cycles-pp.coarse_ctime.current_time.inode_needs_update_time.file_update_time.pipe_write
     32.09            +1.1       33.20        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +1.2        1.23        perf-profile.calltrace.cycles-pp.coarse_ctime.current_time.atime_needs_update.touch_atime.pipe_read
     23.02            +1.3       24.30        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     26.62            +1.4       27.97        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     19.03            +1.6       20.60        perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.11            +1.6       16.71        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.48            +2.1        3.56        perf-profile.calltrace.cycles-pp.current_time.atime_needs_update.touch_atime.pipe_read.vfs_read
      3.51            +2.2        5.72        perf-profile.calltrace.cycles-pp.touch_atime.pipe_read.vfs_read.ksys_read.do_syscall_64
      3.05            +2.2        5.28        perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.pipe_read.vfs_read.ksys_read
      1.81 ±  2%      +2.4        4.20        perf-profile.calltrace.cycles-pp.inode_needs_update_time.file_update_time.pipe_write.vfs_write.ksys_write
      2.23 ±  2%      +2.5        4.71        perf-profile.calltrace.cycles-pp.file_update_time.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.00            +3.3        3.26        perf-profile.calltrace.cycles-pp.current_time.inode_needs_update_time.file_update_time.pipe_write.vfs_write
     14.06            -0.8       13.22        perf-profile.children.cycles-pp.clear_bhb_loop
      7.01            -0.4        6.62        perf-profile.children.cycles-pp.copy_page_from_iter
      6.63            -0.4        6.28        perf-profile.children.cycles-pp.entry_SYSCALL_64
      5.61            -0.3        5.32        perf-profile.children.cycles-pp._copy_from_iter
      5.46            -0.3        5.18        perf-profile.children.cycles-pp.copy_page_to_iter
      5.00            -0.3        4.73        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
     50.00            -0.2       49.78        perf-profile.children.cycles-pp.read
      4.46            -0.2        4.24        perf-profile.children.cycles-pp._copy_to_iter
      3.88            -0.2        3.69        perf-profile.children.cycles-pp.mutex_lock
      2.87            -0.1        2.73        perf-profile.children.cycles-pp.__wake_up_sync_key
      2.38            -0.1        2.24        perf-profile.children.cycles-pp.mutex_unlock
      2.23            -0.1        2.10        perf-profile.children.cycles-pp.fput
      1.81            -0.1        1.71        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.53            -0.1        1.44        perf-profile.children.cycles-pp.x64_sys_call
      1.10            -0.1        1.01        perf-profile.children.cycles-pp.testcase
      1.26            -0.1        1.19 ±  2%  perf-profile.children.cycles-pp.aa_file_perm
      1.48            -0.1        1.41        perf-profile.children.cycles-pp.__cond_resched
      2.14            -0.1        2.09        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.35            -0.0        0.32 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.57            -0.0        0.54        perf-profile.children.cycles-pp.__wake_up_common
      0.51            -0.0        0.48        perf-profile.children.cycles-pp.kill_fasync
      0.26            -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.__x64_sys_read
      0.49            -0.0        0.47        perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.25            -0.0        0.23        perf-profile.children.cycles-pp.__x64_sys_write
      0.30            -0.0        0.28        perf-profile.children.cycles-pp.make_vfsuid
      0.23            -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.write@plt
      0.00            +0.7        0.65        perf-profile.children.cycles-pp.set_normalized_timespec64
      0.71            +0.7        1.43        perf-profile.children.cycles-pp.timestamp_truncate
      0.00            +0.9        0.93        perf-profile.children.cycles-pp.ns_to_timespec64
     28.79            +1.0       29.76        perf-profile.children.cycles-pp.ksys_read
      0.00            +1.0        1.04        perf-profile.children.cycles-pp.ktime_get_coarse_with_offset
     32.43            +1.1       33.54        perf-profile.children.cycles-pp.ksys_write
      0.00            +1.2        1.15 ±  3%  perf-profile.children.cycles-pp.ktime_get_coarse_ts64
     23.24            +1.3       24.52        perf-profile.children.cycles-pp.vfs_read
     26.88            +1.3       28.22        perf-profile.children.cycles-pp.vfs_write
     19.69            +1.5       21.23        perf-profile.children.cycles-pp.pipe_write
     15.78            +1.6       17.35        perf-profile.children.cycles-pp.pipe_read
     69.41            +1.7       71.14        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     67.61            +1.8       69.42        perf-profile.children.cycles-pp.do_syscall_64
      3.65            +2.2        5.86        perf-profile.children.cycles-pp.touch_atime
      3.34            +2.2        5.56        perf-profile.children.cycles-pp.atime_needs_update
      2.08 ±  2%      +2.3        4.35        perf-profile.children.cycles-pp.inode_needs_update_time
      2.45 ±  2%      +2.4        4.85        perf-profile.children.cycles-pp.file_update_time
      0.00            +2.7        2.72        perf-profile.children.cycles-pp.coarse_ctime
      1.63            +5.9        7.55        perf-profile.children.cycles-pp.current_time
     13.92            -0.8       13.07        perf-profile.self.cycles-pp.clear_bhb_loop
      1.04 ±  3%      -0.3        0.73        perf-profile.self.cycles-pp.inode_needs_update_time
      5.38            -0.3        5.09        perf-profile.self.cycles-pp._copy_from_iter
      4.83            -0.3        4.56        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      4.55            -0.2        4.33        perf-profile.self.cycles-pp.vfs_read
      4.37            -0.2        4.15        perf-profile.self.cycles-pp._copy_to_iter
      3.34            -0.2        3.14        perf-profile.self.cycles-pp.write
      3.21            -0.2        3.02        perf-profile.self.cycles-pp.pipe_read
      3.34            -0.2        3.15        perf-profile.self.cycles-pp.read
      2.06            -0.1        1.93        perf-profile.self.cycles-pp.fput
      4.43            -0.1        4.30        perf-profile.self.cycles-pp.vfs_write
      2.21            -0.1        2.09        perf-profile.self.cycles-pp.mutex_unlock
      2.54            -0.1        2.42        perf-profile.self.cycles-pp.do_syscall_64
      2.37            -0.1        2.27        perf-profile.self.cycles-pp.mutex_lock
      1.88            -0.1        1.78        perf-profile.self.cycles-pp.entry_SYSCALL_64
      1.73            -0.1        1.64        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.46            -0.1        1.37        perf-profile.self.cycles-pp.copy_page_from_iter
      1.79            -0.1        1.71        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.36            -0.1        1.28        perf-profile.self.cycles-pp.x64_sys_call
      1.33            -0.1        1.26        perf-profile.self.cycles-pp.security_file_permission
      0.87            -0.1        0.80        perf-profile.self.cycles-pp.testcase
      1.05            -0.1        0.99        perf-profile.self.cycles-pp.rw_verify_area
      0.99            -0.1        0.93        perf-profile.self.cycles-pp.copy_page_to_iter
      1.05            -0.1        0.99        perf-profile.self.cycles-pp.aa_file_perm
      1.27            -0.1        1.21        perf-profile.self.cycles-pp.atime_needs_update
      0.83            -0.1        0.78        perf-profile.self.cycles-pp.__cond_resched
      1.38            -0.0        1.34        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.34 ±  2%      -0.0        0.31 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.50            -0.0        0.48        perf-profile.self.cycles-pp.__wake_up_sync_key
      0.18            -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.__x64_sys_read
      0.17            -0.0        0.16        perf-profile.self.cycles-pp.__x64_sys_write
      0.43            +0.1        0.49        perf-profile.self.cycles-pp.file_update_time
      0.00            +0.5        0.51        perf-profile.self.cycles-pp.set_normalized_timespec64
      0.58            +0.6        1.15        perf-profile.self.cycles-pp.timestamp_truncate
      0.00            +0.8        0.78        perf-profile.self.cycles-pp.ns_to_timespec64
      0.00            +0.9        0.88 ±  4%  perf-profile.self.cycles-pp.ktime_get_coarse_ts64
      0.00            +0.9        0.89 ±  2%  perf-profile.self.cycles-pp.ktime_get_coarse_with_offset
      1.07            +0.9        1.98 ±  2%  perf-profile.self.cycles-pp.current_time
      0.00            +1.2        1.17        perf-profile.self.cycles-pp.coarse_ctime


***************************************************************************************************
lkp-icl-2sp7: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/thread/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/writeseek1/will-it-scale

commit: 
  v6.11-rc1
  a037d5e7f8 ("fs: add infrastructure for multigrain timestamps")

       v6.11-rc1 a037d5e7f81bae8ff69eb670b2e 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     79.00 ±  9%     +38.8%     109.67 ± 20%  perf-c2c.HITM.remote
  75816166            -2.4%   73999365        will-it-scale.64.threads
   1184627            -2.4%    1156239        will-it-scale.per_thread_ops
  75816166            -2.4%   73999365        will-it-scale.workload
      1.29 ± 15%     +32.0%       1.70 ± 15%  perf-sched.sch_delay.avg.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.46 ±221%     -99.7%       0.02 ± 15%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2.57 ± 15%     +32.0%       3.40 ± 15%  perf-sched.wait_and_delay.avg.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
    846.14 ± 37%     -64.5%     300.69 ±117%  perf-sched.wait_and_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1.29 ± 15%     +32.0%       1.70 ± 15%  perf-sched.wait_time.avg.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
    839.24 ± 37%     -64.4%     298.49 ±116%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
   8283953           +18.7%    9832101 ±  6%  perf-stat.i.branch-misses
      1.13            -1.7%       1.11        perf-stat.i.cpi
 1.746e+11            +1.7%  1.775e+11        perf-stat.i.instructions
      0.89            +1.7%       0.90        perf-stat.i.ipc
      0.02            +0.0        0.02 ±  6%  perf-stat.overall.branch-miss-rate%
      1.13            -1.6%       1.11        perf-stat.overall.cpi
      0.89            +1.6%       0.90        perf-stat.overall.ipc
    696240            +4.1%     725044        perf-stat.overall.path-length
   8247837           +18.6%    9784317 ±  6%  perf-stat.ps.branch-misses
  1.74e+11            +1.7%  1.769e+11        perf-stat.ps.instructions
 5.279e+13            +1.6%  5.365e+13        perf-stat.total.instructions
     26.93            -0.8       26.10        perf-profile.calltrace.cycles-pp.llseek
     31.20            -0.6       30.58        perf-profile.calltrace.cycles-pp.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64
     12.61            -0.5       12.12 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.llseek
     11.70 ±  2%      -0.5       11.23 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      8.91 ±  2%      -0.4        8.50 ±  3%  perf-profile.calltrace.cycles-pp.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
     13.72            -0.3       13.38        perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      6.36            -0.2        6.16        perf-profile.calltrace.cycles-pp.clear_bhb_loop.llseek
      6.60            -0.2        6.42        perf-profile.calltrace.cycles-pp.shmem_write_begin.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      5.69            -0.2        5.52        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter.vfs_write
      5.85            -0.1        5.72        perf-profile.calltrace.cycles-pp.clear_bhb_loop.write
      5.05            -0.1        4.93        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      4.86            -0.1        4.75        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.llseek
      3.23            -0.1        3.14        perf-profile.calltrace.cycles-pp.shmem_write_end.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      2.23            -0.1        2.17        perf-profile.calltrace.cycles-pp.filemap_get_entry.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      1.55            -0.0        1.51        perf-profile.calltrace.cycles-pp.down_write.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64
      1.52            -0.0        1.49        perf-profile.calltrace.cycles-pp.mutex_lock.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.98            -0.0        0.95        perf-profile.calltrace.cycles-pp.fput.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      1.56            -0.0        1.52        perf-profile.calltrace.cycles-pp.mutex_lock.__fdget_pos.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.95            -0.0        0.92        perf-profile.calltrace.cycles-pp.folio_unlock.shmem_write_end.generic_perform_write.shmem_file_write_iter.vfs_write
      1.06            -0.0        1.03        perf-profile.calltrace.cycles-pp.mutex_unlock.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      0.84            -0.0        0.82        perf-profile.calltrace.cycles-pp.folio_mark_accessed.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.64            -0.0        0.62        perf-profile.calltrace.cycles-pp.folio_mark_dirty.shmem_write_end.generic_perform_write.shmem_file_write_iter.vfs_write
      0.76            -0.0        0.74        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      0.00            +0.6        0.57        perf-profile.calltrace.cycles-pp.timestamp_truncate.current_time.inode_needs_update_time.file_update_time.shmem_file_write_iter
     75.78            +0.8       76.57        perf-profile.calltrace.cycles-pp.write
     61.25            +1.0       62.22        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     60.37            +1.0       61.35        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     57.56            +1.0       58.61        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +1.1        1.11 ±  3%  perf-profile.calltrace.cycles-pp.coarse_ctime.current_time.inode_needs_update_time.file_update_time.shmem_file_write_iter
     49.83            +1.2       51.07        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     39.42            +1.4       40.86        perf-profile.calltrace.cycles-pp.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.95            +2.1        4.04        perf-profile.calltrace.cycles-pp.inode_needs_update_time.file_update_time.shmem_file_write_iter.vfs_write.ksys_write
      2.33            +2.2        4.54        perf-profile.calltrace.cycles-pp.file_update_time.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64
      0.00            +3.1        3.14        perf-profile.calltrace.cycles-pp.current_time.inode_needs_update_time.file_update_time.shmem_file_write_iter.vfs_write
     27.11            -0.9       26.24        perf-profile.children.cycles-pp.llseek
     31.79            -0.6       31.15        perf-profile.children.cycles-pp.generic_perform_write
      9.30 ±  2%      -0.4        8.87 ±  2%  perf-profile.children.cycles-pp.ksys_lseek
     13.81            -0.3       13.47        perf-profile.children.cycles-pp.copy_page_from_iter_atomic
     12.33            -0.3       11.99        perf-profile.children.cycles-pp.clear_bhb_loop
      6.76            -0.2        6.56        perf-profile.children.cycles-pp.shmem_write_begin
      5.95            -0.2        5.77        perf-profile.children.cycles-pp.shmem_get_folio_gfp
      5.77            -0.1        5.64        perf-profile.children.cycles-pp.entry_SYSCALL_64
      3.43            -0.1        3.34        perf-profile.children.cycles-pp.shmem_write_end
      3.51            -0.1        3.42        perf-profile.children.cycles-pp.__cond_resched
      3.34            -0.1        3.26        perf-profile.children.cycles-pp.mutex_lock
      2.37            -0.1        2.30        perf-profile.children.cycles-pp.filemap_get_entry
      2.01            -0.1        1.96        perf-profile.children.cycles-pp.fput
      1.57            -0.1        1.52        perf-profile.children.cycles-pp.rcu_all_qs
      1.68            -0.0        1.63        perf-profile.children.cycles-pp.down_write
      2.15            -0.0        2.10        perf-profile.children.cycles-pp.mutex_unlock
      0.11 ±  4%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      1.76            -0.0        1.72        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.02            -0.0        0.98        perf-profile.children.cycles-pp.folio_unlock
      0.89            -0.0        0.87        perf-profile.children.cycles-pp.folio_mark_accessed
      0.55            -0.0        0.52        perf-profile.children.cycles-pp.shmem_file_llseek
      0.77            -0.0        0.75        perf-profile.children.cycles-pp.folio_mark_dirty
      0.26            -0.0        0.25        perf-profile.children.cycles-pp.__f_unlock_pos
      0.22            +0.0        0.24        perf-profile.children.cycles-pp.inode_to_bdi
      0.00            +0.3        0.30        perf-profile.children.cycles-pp.set_normalized_timespec64
      0.00            +0.4        0.42 ±  3%  perf-profile.children.cycles-pp.ns_to_timespec64
     74.20            +0.5       74.66        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00            +0.5        0.47        perf-profile.children.cycles-pp.ktime_get_coarse_with_offset
     72.54            +0.5       73.04        perf-profile.children.cycles-pp.do_syscall_64
      0.00            +0.6        0.56 ±  6%  perf-profile.children.cycles-pp.ktime_get_coarse_ts64
     76.24            +0.8       77.00        perf-profile.children.cycles-pp.write
     57.97            +1.0       59.02        perf-profile.children.cycles-pp.ksys_write
     50.19            +1.2       51.42        perf-profile.children.cycles-pp.vfs_write
      0.00            +1.3        1.29 ±  2%  perf-profile.children.cycles-pp.coarse_ctime
     39.96            +1.4       41.40        perf-profile.children.cycles-pp.shmem_file_write_iter
      2.18            +2.0        4.17        perf-profile.children.cycles-pp.inode_needs_update_time
      2.52            +2.1        4.67        perf-profile.children.cycles-pp.file_update_time
      0.00            +3.5        3.46        perf-profile.children.cycles-pp.current_time
      1.13            -0.4        0.72        perf-profile.self.cycles-pp.inode_needs_update_time
     13.62            -0.3       13.28        perf-profile.self.cycles-pp.copy_page_from_iter_atomic
     12.19            -0.3       11.86        perf-profile.self.cycles-pp.clear_bhb_loop
      2.31            -0.1        2.24        perf-profile.self.cycles-pp.llseek
      4.25            -0.1        4.19        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      2.18            -0.1        2.12        perf-profile.self.cycles-pp.shmem_get_folio_gfp
      2.18            -0.1        2.12        perf-profile.self.cycles-pp.do_syscall_64
      1.72            -0.1        1.67        perf-profile.self.cycles-pp.filemap_get_entry
      1.88            -0.0        1.83        perf-profile.self.cycles-pp.fput
      2.14            -0.0        2.09        perf-profile.self.cycles-pp.mutex_lock
      2.01            -0.0        1.96        perf-profile.self.cycles-pp.mutex_unlock
      1.66            -0.0        1.61        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.18            -0.0        1.14        perf-profile.self.cycles-pp.rcu_all_qs
      0.54 ±  2%      -0.0        0.50        perf-profile.self.cycles-pp.timestamp_truncate
      1.94            -0.0        1.90        perf-profile.self.cycles-pp.__cond_resched
      1.09            -0.0        1.05        perf-profile.self.cycles-pp.down_write
      1.56            -0.0        1.52        perf-profile.self.cycles-pp.shmem_write_end
      0.10 ±  4%      -0.0        0.07 ± 11%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      1.62            -0.0        1.59        perf-profile.self.cycles-pp.entry_SYSCALL_64
      2.68            -0.0        2.65        perf-profile.self.cycles-pp.__fsnotify_parent
      1.13            -0.0        1.10        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.95            -0.0        0.92        perf-profile.self.cycles-pp.folio_unlock
      0.83            -0.0        0.81        perf-profile.self.cycles-pp.folio_mark_accessed
      0.42            -0.0        0.41        perf-profile.self.cycles-pp.shmem_file_llseek
      0.49            -0.0        0.47        perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.34            -0.0        0.33        perf-profile.self.cycles-pp.folio_mapping
      0.15 ±  3%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.inode_to_bdi
      0.39            +0.1        0.48        perf-profile.self.cycles-pp.file_update_time
      0.00            +0.2        0.24 ±  3%  perf-profile.self.cycles-pp.set_normalized_timespec64
      0.00            +0.4        0.35        perf-profile.self.cycles-pp.ns_to_timespec64
      0.00            +0.4        0.41 ±  2%  perf-profile.self.cycles-pp.ktime_get_coarse_with_offset
      0.00            +0.4        0.44 ±  8%  perf-profile.self.cycles-pp.ktime_get_coarse_ts64
      0.00            +0.6        0.55        perf-profile.self.cycles-pp.coarse_ctime
      0.00            +0.9        0.89        perf-profile.self.cycles-pp.current_time



***************************************************************************************************
lkp-cpl-4sp2: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/thread/100%/debian-12-x86_64-20240206.cgz/lkp-cpl-4sp2/pipe1/will-it-scale

commit: 
  v6.11-rc1
  a037d5e7f8 ("fs: add infrastructure for multigrain timestamps")

       v6.11-rc1 a037d5e7f81bae8ff69eb670b2e 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    101460 ± 14%     -40.5%      60365 ± 54%  numa-numastat.node2.other_node
    101460 ± 14%     -40.5%      60365 ± 54%  numa-vmstat.node2.numa_other
    214956            +1.3%     217796        proc-vmstat.nr_shmem
 2.864e+08            -5.5%  2.706e+08        will-it-scale.224.threads
   1278568            -5.5%    1207975        will-it-scale.per_thread_ops
 2.864e+08            -5.5%  2.706e+08        will-it-scale.workload
      0.29 ±220%    +486.6%       1.70 ± 71%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.14 ±104%    +238.3%       0.49 ± 26%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      4.33 ±196%    +426.6%      22.79 ± 55%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
     15.03 ±101%    +153.2%      38.05 ± 19%  perf-sched.total_sch_delay.max.ms
      0.07 ±141%    +201.5%       0.20        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.usleep_range_state.ipmi_thread.kthread
      0.70 ±100%    +137.6%       1.66 ± 20%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     35.83 ±143%    +476.3%     206.50 ± 56%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.usleep_range_state.ipmi_thread.kthread
      1.40 ±100%    +116.9%       3.03 ±  6%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      2.43 ±143%    +472.3%      13.90 ± 56%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.do_pselect.constprop
      0.64 ±100%    +137.0%       1.51 ± 20%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.14 ±104%    +229.2%       0.47 ± 25%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      2.33 ±101%    +114.3%       4.99        perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      4.45 ±143%    +600.8%      31.18 ± 64%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.do_pselect.constprop
 1.612e+11            +1.6%  1.638e+11        perf-stat.i.branch-instructions
      0.42 ±  2%      -0.1        0.37        perf-stat.i.branch-miss-rate%
 6.629e+08            -9.0%  6.034e+08        perf-stat.i.branch-misses
     13.77 ±  3%      +1.3       15.04 ±  6%  perf-stat.i.cache-miss-rate%
      1.12            -2.6%       1.09        perf-stat.i.cpi
 6.635e+11            +2.9%  6.827e+11        perf-stat.i.instructions
      0.89            +2.7%       0.91        perf-stat.i.ipc
      0.41            -0.0        0.37        perf-stat.overall.branch-miss-rate%
      1.12            -2.6%       1.09        perf-stat.overall.cpi
      0.89            +2.6%       0.91        perf-stat.overall.ipc
    702093            +8.3%     760166        perf-stat.overall.path-length
 1.604e+11            +1.7%  1.631e+11        perf-stat.ps.branch-instructions
 6.591e+08            -8.9%  6.005e+08        perf-stat.ps.branch-misses
   6.6e+11            +2.9%  6.795e+11        perf-stat.ps.instructions
 2.011e+14            +2.3%  2.057e+14        perf-stat.total.instructions
      5.47            -0.4        5.04        perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_syscall_64
      6.78            -0.4        6.37        perf-profile.calltrace.cycles-pp.clear_bhb_loop.write
      6.84            -0.3        6.51        perf-profile.calltrace.cycles-pp.clear_bhb_loop.read
      2.72 ±  2%      -0.3        2.41 ±  8%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify_area.vfs_read.ksys_read
      5.38            -0.3        5.08        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
      5.36            -0.3        5.08        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      3.98            -0.3        3.70        perf-profile.calltrace.cycles-pp._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write.ksys_write
      4.16            -0.2        3.96        perf-profile.calltrace.cycles-pp.copy_page_to_iter.pipe_read.vfs_read.ksys_read.do_syscall_64
     52.78            -0.2       52.59        perf-profile.calltrace.cycles-pp.write
      2.09            -0.1        1.95        perf-profile.calltrace.cycles-pp.__wake_up_sync_key.pipe_write.vfs_write.ksys_write.do_syscall_64
      1.04            -0.1        0.90        perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_write.vfs_write.ksys_write.do_syscall_64
      3.17            -0.1        3.06        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read.ksys_read
      1.56            -0.1        1.46        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_sync_key.pipe_write.vfs_write.ksys_write
      0.99            -0.1        0.90        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.67            -0.1        1.59        perf-profile.calltrace.cycles-pp.mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.64            -0.1        0.56        perf-profile.calltrace.cycles-pp.testcase
      0.96            -0.1        0.89        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.24            -0.1        1.17        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.24            -0.1        1.17        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.98            -0.1        0.92        perf-profile.calltrace.cycles-pp.fput.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.15            -0.1        1.10        perf-profile.calltrace.cycles-pp.fput.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.94            -0.1        0.88        perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_read.vfs_read.ksys_read.do_syscall_64
     50.06            +0.1       50.13        perf-profile.calltrace.cycles-pp.read
      1.64            +0.1        1.75        perf-profile.calltrace.cycles-pp.mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.59 ±  6%      +0.3        0.86 ±  2%  perf-profile.calltrace.cycles-pp.anon_pipe_buf_release.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.25 ±100%      +0.4        0.68 ±  2%  perf-profile.calltrace.cycles-pp.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.00            +0.5        0.54 ±  2%  perf-profile.calltrace.cycles-pp.timestamp_truncate.current_time.inode_needs_update_time.file_update_time.pipe_write
      0.00            +0.6        0.58 ±  3%  perf-profile.calltrace.cycles-pp.ktime_get_coarse_ts64.coarse_ctime.current_time.atime_needs_update.touch_atime
     35.68            +0.8       36.45        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     34.78            +0.8       35.61        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +1.0        1.03 ± 14%  perf-profile.calltrace.cycles-pp.coarse_ctime.current_time.inode_needs_update_time.file_update_time.pipe_write
     32.94            +1.0       33.97        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     32.05            +1.1       33.13        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     30.48            +1.1       31.57        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     25.24            +1.2       26.49        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     27.80            +1.4       29.19        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.00            +1.4        1.42 ±  4%  perf-profile.calltrace.cycles-pp.coarse_ctime.current_time.atime_needs_update.touch_atime.pipe_read
     22.79            +1.5       24.30        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     17.46            +1.6       19.04        perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.85            +2.2       17.02        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.02            +2.3        6.29        perf-profile.calltrace.cycles-pp.touch_atime.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.72            +2.3        4.02        perf-profile.calltrace.cycles-pp.current_time.atime_needs_update.touch_atime.pipe_read.vfs_read
      3.63            +2.3        5.94        perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.pipe_read.vfs_read.ksys_read
      1.78 ±  8%      +2.3        4.12 ±  4%  perf-profile.calltrace.cycles-pp.inode_needs_update_time.file_update_time.pipe_write.vfs_write.ksys_write
      2.06 ±  8%      +2.3        4.41 ±  3%  perf-profile.calltrace.cycles-pp.file_update_time.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.00            +3.3        3.34 ±  5%  perf-profile.calltrace.cycles-pp.current_time.inode_needs_update_time.file_update_time.pipe_write.vfs_write
     13.71            -0.7       12.97        perf-profile.children.cycles-pp.clear_bhb_loop
      5.60            -0.4        5.15        perf-profile.children.cycles-pp.copy_page_from_iter
      6.87            -0.4        6.48        perf-profile.children.cycles-pp.entry_SYSCALL_64
      4.28            -0.3        3.98        perf-profile.children.cycles-pp._copy_from_iter
      4.06            -0.2        3.83        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      4.23            -0.2        4.03        perf-profile.children.cycles-pp.copy_page_to_iter
      2.06            -0.2        1.86        perf-profile.children.cycles-pp.mutex_unlock
     52.98            -0.2       52.80        perf-profile.children.cycles-pp.write
      2.14            -0.2        1.96        perf-profile.children.cycles-pp.x64_sys_call
      2.18            -0.2        2.03        perf-profile.children.cycles-pp.__wake_up_sync_key
      2.60            -0.1        2.45        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      3.43            -0.1        3.31        perf-profile.children.cycles-pp._copy_to_iter
      2.14            -0.1        2.02        perf-profile.children.cycles-pp.fput
      1.58            -0.1        1.48        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.74 ±  2%      -0.1        0.65        perf-profile.children.cycles-pp.testcase
      0.77            -0.0        0.74        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.36            -0.0        0.34        perf-profile.children.cycles-pp.__x64_sys_read
      0.39            -0.0        0.37        perf-profile.children.cycles-pp.__x64_sys_write
      0.14 ±  3%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.make_vfsuid
      0.26            -0.0        0.24 ±  2%  perf-profile.children.cycles-pp.__wake_up_common
      0.30            -0.0        0.28        perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.42 ±  3%      +0.1        0.48 ±  7%  perf-profile.children.cycles-pp.rcu_all_qs
     50.24            +0.1       50.31        perf-profile.children.cycles-pp.read
      1.36 ±  3%      +0.1        1.44 ±  2%  perf-profile.children.cycles-pp.rep_movs_alternative
      1.27            +0.1        1.41        perf-profile.children.cycles-pp.__cond_resched
      0.60 ±  6%      +0.3        0.86 ±  2%  perf-profile.children.cycles-pp.anon_pipe_buf_release
      0.00            +0.5        0.54 ±  8%  perf-profile.children.cycles-pp.set_normalized_timespec64
      0.46 ± 10%      +0.7        1.11 ±  3%  perf-profile.children.cycles-pp.timestamp_truncate
      0.00            +0.9        0.94 ±  2%  perf-profile.children.cycles-pp.ktime_get_coarse_with_offset
      0.00            +1.0        0.98 ±  7%  perf-profile.children.cycles-pp.ktime_get_coarse_ts64
      0.00            +1.0        1.04        perf-profile.children.cycles-pp.ns_to_timespec64
     30.73            +1.1       31.81        perf-profile.children.cycles-pp.ksys_write
     25.42            +1.2       26.66        perf-profile.children.cycles-pp.vfs_write
     27.96            +1.4       29.32        perf-profile.children.cycles-pp.ksys_read
     22.87            +1.5       24.37        perf-profile.children.cycles-pp.vfs_read
     17.63            +1.6       19.19        perf-profile.children.cycles-pp.pipe_write
     68.90            +1.8       70.69        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     67.06            +1.9       68.95        perf-profile.children.cycles-pp.do_syscall_64
     15.15            +2.1       17.30        perf-profile.children.cycles-pp.pipe_read
      4.10            +2.3        6.37        perf-profile.children.cycles-pp.touch_atime
      3.73            +2.3        6.02        perf-profile.children.cycles-pp.atime_needs_update
      1.90 ±  8%      +2.3        4.20 ±  4%  perf-profile.children.cycles-pp.inode_needs_update_time
      2.13 ±  7%      +2.3        4.48 ±  3%  perf-profile.children.cycles-pp.file_update_time
      0.00            +2.5        2.52 ±  5%  perf-profile.children.cycles-pp.coarse_ctime
      1.76            +6.0        7.77 ±  2%  perf-profile.children.cycles-pp.current_time
     13.63            -0.7       12.89        perf-profile.self.cycles-pp.clear_bhb_loop
      1.07 ±  5%      -0.4        0.67        perf-profile.self.cycles-pp.inode_needs_update_time
      3.81            -0.3        3.46        perf-profile.self.cycles-pp._copy_from_iter
      4.10 ±  2%      -0.3        3.80 ±  2%  perf-profile.self.cycles-pp.vfs_read
      3.58            -0.2        3.34        perf-profile.self.cycles-pp.pipe_read
      3.35            -0.2        3.11        perf-profile.self.cycles-pp.read
      3.92            -0.2        3.70        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      2.90            -0.2        2.70        perf-profile.self.cycles-pp.do_syscall_64
      1.97            -0.2        1.78        perf-profile.self.cycles-pp.mutex_unlock
      3.00            -0.2        2.81        perf-profile.self.cycles-pp.entry_SYSCALL_64
      2.90            -0.2        2.74        perf-profile.self.cycles-pp._copy_to_iter
      1.71            -0.2        1.54        perf-profile.self.cycles-pp.atime_needs_update
      2.01            -0.2        1.85        perf-profile.self.cycles-pp.x64_sys_call
      3.39            -0.1        3.25        perf-profile.self.cycles-pp.write
      1.32 ±  2%      -0.1        1.18        perf-profile.self.cycles-pp.copy_page_from_iter
      1.87            -0.1        1.76        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.15            -0.1        2.05        perf-profile.self.cycles-pp.mutex_lock
      1.66            -0.1        1.56        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.89            -0.1        1.79        perf-profile.self.cycles-pp.fput
      0.61            -0.1        0.51        perf-profile.self.cycles-pp.testcase
      1.52            -0.1        1.43        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.81 ±  4%      -0.1        0.72 ±  2%  perf-profile.self.cycles-pp.copy_page_to_iter
      1.16            -0.1        1.11        perf-profile.self.cycles-pp.ksys_write
      1.06            -0.0        1.02        perf-profile.self.cycles-pp.ksys_read
      0.36            -0.0        0.32        perf-profile.self.cycles-pp.__wake_up_sync_key
      0.37            -0.0        0.34 ±  2%  perf-profile.self.cycles-pp.touch_atime
      0.76            -0.0        0.73        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.26            -0.0        0.24        perf-profile.self.cycles-pp.__wake_up_common
      0.27            -0.0        0.26        perf-profile.self.cycles-pp.__x64_sys_read
      0.27            -0.0        0.26        perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.12 ±  3%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.make_vfsuid
      0.29            -0.0        0.28        perf-profile.self.cycles-pp.__x64_sys_write
      0.26            +0.0        0.30        perf-profile.self.cycles-pp.file_update_time
      0.30 ±  4%      +0.1        0.37 ±  9%  perf-profile.self.cycles-pp.rcu_all_qs
      0.85            +0.1        0.92        perf-profile.self.cycles-pp.__cond_resched
      0.89 ±  5%      +0.1        0.99 ±  4%  perf-profile.self.cycles-pp.rep_movs_alternative
      0.56 ±  6%      +0.3        0.82 ±  2%  perf-profile.self.cycles-pp.anon_pipe_buf_release
      0.00            +0.5        0.52 ±  7%  perf-profile.self.cycles-pp.set_normalized_timespec64
      0.43 ± 10%      +0.6        1.03 ±  3%  perf-profile.self.cycles-pp.timestamp_truncate
      0.00            +0.9        0.86        perf-profile.self.cycles-pp.ns_to_timespec64
      0.00            +0.9        0.90 ±  2%  perf-profile.self.cycles-pp.ktime_get_coarse_with_offset
      0.00            +0.9        0.94 ±  8%  perf-profile.self.cycles-pp.ktime_get_coarse_ts64
      0.00            +1.0        1.02 ±  4%  perf-profile.self.cycles-pp.coarse_ctime
      1.06 ±  4%      +1.3        2.38 ±  3%  perf-profile.self.cycles-pp.current_time





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


