Return-Path: <linux-fsdevel+bounces-17292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2C88AB03A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 16:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6344C1C2330A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 14:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18426135A4C;
	Fri, 19 Apr 2024 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQLzxwWi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8E12E1DA;
	Fri, 19 Apr 2024 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535432; cv=fail; b=XYeUOT3NYALMoar8eiXul+kdYcydoenc3w5H8wabreNiQ38CnIoLOONHucsmCMfiXQyvwJeduR1VLmJ6Wf6TZegBBawKdiE9tGSdcshCYbWhht63tlKjKn5ktD3tKWfHAWJDKgh040y7jr4v143cDqXLrvoCsIgSabttfP+4F/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535432; c=relaxed/simple;
	bh=UG6XfUIznco2/7yu1aNnErUjLp/GKVOZH526qD57GRs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b73wBW4fpeIZwlmbg25+DTWGCnCPYn938fK3YKF8Z8R20p98fSNdhNVswwPYWRLf8vyHhUXn7nkIe1KKlRE6YdOgN0HJcqJE7a1EcIMyDQQ7hIAl/tzykNXtpT892wWMRNDJkzPrhhogbSLyIKTarKMsLtq8/CkZnp0DwnO8O/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQLzxwWi; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713535431; x=1745071431;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UG6XfUIznco2/7yu1aNnErUjLp/GKVOZH526qD57GRs=;
  b=KQLzxwWiVo2E5tobX/acc6g33NfTAwQiqcX9keqZ+LKBSDfhXbbVe3cv
   U1RaiAzJiItp14axxyHUwhzpYMLJUJUJvKD/7kq1oUfsQMhznbqu9UWH8
   6soeUfnxiBiHLsOC6hKN4IjUZrd39tWtNtnlstKh/L3cv5LoYamWkfIso
   XoJhzoPgmn5kVunmevIWQTVjIDvZE7KsbdA6AIp0e1DKKvmwe4HmY0mBb
   DPjxSzlkfRMdrs7URyJ8BVhDt2YqR5WXP7yFooqQdSU/cm4i+0dVrm67Q
   Q6HKsn+ay5NS/nGFBOoWTTZ5EA3TY3rT+gX6ncEVvLPQ9qYOYXOVYPJUW
   w==;
X-CSE-ConnectionGUID: xR72OyYCTGWXgCH8s8Ck1A==
X-CSE-MsgGUID: YLaxgWg8S0qNK7NGC8K1dg==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="9358544"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="9358544"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 07:03:50 -0700
X-CSE-ConnectionGUID: WuVTZSu9QxOkIcXqffCYhw==
X-CSE-MsgGUID: hVy+WprxTAqEHiHEhpMjGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="27991106"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 07:03:50 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 07:03:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 07:03:48 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 07:03:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXxvKwLEHwmIXLSxahon2nY97H272knPzC7wb+K6uP4Q6B3yPZ6ptz3rrrmeT3lHN0HfeoVNOzKUnG4IrzmRpgC8zCqA98+6hvtdskueqQZuJUcYcKx6uGZeM9VhUkq5bhGJ226MFBR319xkNAYd1yNOqmTEfSh3c1fhyMF0NeFO90KtDFi99lHfAbMndsTRp8MirsHYTgeE8zyLgukvzL+uF9dwKZd4HKGfn0u5hb938yHokUvypCxn7NXI7Sar4RDvUDz4O5RQLPmeSTO1lY4k7KcafLwuIE1XEkyTlf9Rar5NZgMdmQ3cQPJuetpNL/++z16aVlyWglmn5o6V0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQL+ytKr3AujoHnbY3pmF5U3RLLhvouaEkXYSfORvSE=;
 b=YzF87yH9FXK/5JnrdIDpzLZkkNbclNABL0v/8NiRPCR/RmaNqtfXhiCetv1ZeXSOOOY61GoHdvlCP52f6F1Y/Obv2XCaeipl0ZjaopxGDokch2RPuqJst7kfR1XNAb6aLYKqHu48hlZr7T+SFqFcAbC3JLqMG54yxXPQDIcRePcgB4ylFngWRC5AIlDz0peLEqF/NFwhpDjcV16VKKXe9VaGzuP+jvuTWIfFKhCCzbYZVzQV1X26Az5LIKOSPNkANZN1I12EU4u6WWXiKTMrUkQ2a3uCgA/lNiBy9z27XlWcnGRdbadZeJ78Qk4N4Z1Hw7xVedEiwDmYF4Lrm/Md4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by IA1PR11MB6100.namprd11.prod.outlook.com (2603:10b6:208:3d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Fri, 19 Apr
 2024 14:03:31 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b%7]) with mapi id 15.20.7472.025; Fri, 19 Apr 2024
 14:03:31 +0000
Message-ID: <c66b2ce5-6f98-46be-bf0d-3172c17fa0f5@intel.com>
Date: Fri, 19 Apr 2024 22:03:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/18] mm: improve folio_likely_mapped_shared() using
 the mapcount of large folios
To: David Hildenbrand <david@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
	<cgroups@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>, Peter Xu <peterx@redhat.com>, Ryan Roberts
	<ryan.roberts@arm.com>, Yang Shi <shy828301@gmail.com>, Zi Yan
	<ziy@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Hugh Dickins
	<hughd@google.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
	<dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, "Muchun
 Song" <muchun.song@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>, "Naoya
 Horiguchi" <naoya.horiguchi@nec.com>, Richard Chang <richardycc@google.com>
References: <20240409192301.907377-1-david@redhat.com>
 <20240409192301.907377-6-david@redhat.com>
Content-Language: en-US
From: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20240409192301.907377-6-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|IA1PR11MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: be38a5a3-2bc0-49ac-3d44-08dc60797e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTFSN29LTG9vY1NJQkEwbG5obCt6Q2pIV3B4SUlxOEpYYzhzMG5TS2syRjhG?=
 =?utf-8?B?RzIvVjhTZVYrNVhHVmxsSDArZ0kwUTJmNWxLTFVMa0tKTXd4N3BUR01HY1k1?=
 =?utf-8?B?NTJIQzhuOXNNeXZKazcwN3RBdVd0ODB4ZTdtWXpuS3hmVmtiYXRJQThJT3Q4?=
 =?utf-8?B?ckU5QzJ1ZlMwSU8wZmhVN3R2aUR3Zkt3dHR4RlFEYldDcmZ1bFlIWFU4NStW?=
 =?utf-8?B?UVlad3NTY2N5ZGdxYnNiWUlVc0ZLWnZ3eVh3R1p6dXh6aDFXU3l1aldCSzN2?=
 =?utf-8?B?Z2pUS05sQjZER0ZvdjBLaFZSK3NBUDhKaXloL0NORkh4Rml4R3RFdlR1YnJQ?=
 =?utf-8?B?ZEpBNGZmcExsSjJpYk9OdkFIWEk4K0xTVDl2Qmpja0FNcVkwWDBFUHc5VEp3?=
 =?utf-8?B?dVdHQzBUUVRneGV6SWF1UjFHUUhKS28vd2lLcDF2NW1ReGpvYkYxT0V2SHZi?=
 =?utf-8?B?YThGSUdkRmVuQ3JuUkVrWUp2R2xQZFFnNTJrczduRXIwS0k5YnV4Q3NXZFVo?=
 =?utf-8?B?dExpYStGMkZTUkJjKy9Jb08wTU5qRzJVL3NXVDFrVkNFZFNaVW8veS9Idnpw?=
 =?utf-8?B?a0Z6Rm5MRThYODEvL0h1QktDMmJjejg4TFRlU1g3WUsyVkE3L0dsTGgrZ3VX?=
 =?utf-8?B?T3BQSWtUOE4rY3ZCaW9NbnB2ZVBwWnN5ZGtVYmZ3Z0I0UnpsWUszVDF1SFVB?=
 =?utf-8?B?TkR1N2FCSmxkZUpSS09aVWNTNnZPck9iYzA0c3duWXdBZzVtQjlHZWpmcUJk?=
 =?utf-8?B?aE5vSkdtWDVRNkplSml5SjdhcFFhMDJBMmEzR3hoRlVHTWszbHpDZTZzV0VO?=
 =?utf-8?B?UnJ1dHBGN2xzT0c3aUJVVGE3VEZtNngyRE9wL1g0QmhrQ3YrYktZUXpLMU0w?=
 =?utf-8?B?MWlhU0hFSmJuMGI3aGcyU0N4WldUaDM4Vm1EbVQ0OVZaaFdubnFnVStuRnda?=
 =?utf-8?B?NmJJVEtGYy9nRjhXZ0NiVmtBZ015ZGgwTkNveEZGenI5WEFJTENzQ2dncldO?=
 =?utf-8?B?YVAxcXprb253dlZ3djBCZ2ZKMjZqSDZUM2FOOTVUaXZsSE9tY0d4VXBMcXcx?=
 =?utf-8?B?MHRVVkxtbXFRaHBFckVRWHR0SVRSSUdhNTY0ZjZYbHJOVVJBN25FZzZhYS8v?=
 =?utf-8?B?SGhxZitaMmJQTmc5ekN3aHZQRnBoVFJyRXQySFVQMDl5MmxuT1JZbk5teThV?=
 =?utf-8?B?djdsZEJqMDdBTzU0cUlDUHVGR296TGxhZkRxU2JzbThpWCtpYVJ4Y09td0xp?=
 =?utf-8?B?Yi8zNVh3R0h2cjQwdTk3bXFYM21haG1tcjUxTXZRVk1kRHpVOUd2bXh1Smx3?=
 =?utf-8?B?VWdSbnRrYkMzNlR6QU1DaHpCMWdtY2RuVVRMMkZXVjlOMC9ialRkWDV1NWNp?=
 =?utf-8?B?bzZ2aVM0eUVwcmM2anZIc3JJN2lRb3Z4QzhYcGZ0VEFOS3VqNDljVUZseEt2?=
 =?utf-8?B?SmkzZDFjay9HQk84VXFNL0d4bjQzc2FEdTJ5VFpjQnF4RkVWTWdHRWh6VDEv?=
 =?utf-8?B?V3RENldMbWlTTGdVL1dWK3F6c3Z0NUFoYlA0NkNackMyT2JCbDY0cVRTRjJV?=
 =?utf-8?B?NjllbDZaditBMjJuY3dWMmF1NzJnNC9sVzdMcnFNSEJacWF2eG1jKzhaZjF3?=
 =?utf-8?B?alJENjlSQkJvcjlBM21TOXFuVTNFemIwdytsVHJQZmdVUENUVVo1VUNnOU9K?=
 =?utf-8?B?aFhHRXJFcmxRMGREbStqQ3d5Q3RrdU1HWlVnYitGekxJQUtSanBsUWJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGUyOWEyY01lajlhcVJtWTlWN295eHkvbE9xdkJKcE1ZcXdyRml2dmF3dHkw?=
 =?utf-8?B?djc2T2ZTVjRqdllJNzVHVFBhWWRhK29DLzN2UXk2YWkwLzFwa0tpYW5xVmN5?=
 =?utf-8?B?Y0U3eFdNL3MwNHZtbEhVZXVwdCsvTjVOUEY4WDYrWjlMeXVwRW0yaFZYeDJx?=
 =?utf-8?B?UG55YkpWY1NYTGgrOXYzNUYzNTBHU1hyeUJDT3NpZlgxSXNzNnpiQU5MMkxL?=
 =?utf-8?B?RFA3d3NnMnNEdEpmTjduRitYc1Q2dlp6NGY0a2ZhZzNtaittV2ZuMEV2QXpi?=
 =?utf-8?B?cjNRU2lCUzJOdDhwMVVwL09nTHFFUzZoU0VORS9DcUZZTFRrYTdvV1NXZ0ov?=
 =?utf-8?B?cXZCVEJsRFIwYmhmdkhZbm1FTDJMd1NQR2wzSlIyVDBWWm9wSkJSSzNDS2Y3?=
 =?utf-8?B?MHdZRzhEMDAycmlKZURqRjJRZ3NweDNHS3p3MHE5SnNEWFFMb3d0RVlJYVZW?=
 =?utf-8?B?a0dUcWJXTWtsWTBHTEp4eGpXKzAvcXYreVNiak9GbVhwUGhsZ250WG5FZUwx?=
 =?utf-8?B?VC91SlVzWmhTdzBqMUZNcEcwODBaTkxNd0EvSTc0dUQ5Z0QvdnlwQXVYa1p5?=
 =?utf-8?B?K1hQdHN2MExMcXdYaENaT3dFOUo4Z3EvK3Vxc1czNWlqMFhJYUlpTUhjODI3?=
 =?utf-8?B?UUlvS2lTNEFaQ0J0bHFnT3JOT2FTZUFJTEZQaS9yOS9sejA2UVNjbjlVendI?=
 =?utf-8?B?WkkrTm5RODRuVDFEdTFVNEo0OHJoOEN5eTlZcGRUQnVuRFI2M0JEM3BUYmlH?=
 =?utf-8?B?TzlMc3dteTV6NElNbzZxYXBFUjYyTmxQa0ZZK1VobUFkL2gvaHdhbURJRTkx?=
 =?utf-8?B?SG5admFNQnZBSmVnUjJvT2pZSlV2SE9Sa2V6dXVIbHE4dnByL3lnSVFYMUs0?=
 =?utf-8?B?LzV6Q3crNyt1MmRocVRWZTB1dWNadjUvaDVaMVBOdnd4RCtwZmFkYStqNzZO?=
 =?utf-8?B?Ujh5ZHY2cEl1ZXc5NEgzLy9pdUMxVC95ckVZL1ZycjhpV0UxN2dUVFVQQnBU?=
 =?utf-8?B?RldjK1JlbnluMkhOditEZUZBc3gxNzhHb0NLSUxsaER2aGF0L1lXNnFSSEc4?=
 =?utf-8?B?Qmd2S3poaVorWXFLK2JxVUZ6ZkNISzlJUGYxb245bUNqdnFHbEV5cVBsditN?=
 =?utf-8?B?ZVp4YmR4ZEI4Zm9LaFB2b3hndUpsNmNxV3ZQSVVRL0E3U0QwU0lreFQ5djhi?=
 =?utf-8?B?SVptQTN2QzE2bC9XMU1EWHZ1QUdlMVdtRU41OC96a1hEV1FKRGNaNXNYNUVB?=
 =?utf-8?B?YUZkdWVlVUZ0TklGL0QxSFBrR3h2ZFF5bFcvR2U1ZTEyMkF1ZGNPKzk3dDY1?=
 =?utf-8?B?cUs1Y0JyVHEzNEV5WWl1Yk5iTVJQL0ZJODlEUFFkSWtKS2FWZUc1clV0Smoy?=
 =?utf-8?B?aU9EdVVkYnF6dFVxakwyUUU5Mll5OUxxeDNmRXFsVm50cW1NL2tlYjZOUGdI?=
 =?utf-8?B?T0swYmgrSWFjelc3NHMxelNnUUY2eVc0S2hoMzF4QS9ranUyOFd0TldVdUgw?=
 =?utf-8?B?S3YyZFQ1SVhSdVhDS2NDWU1hakxmVEJibUdlMDNvbjJ2YVU1M0tBZDlCMDRM?=
 =?utf-8?B?djZ0Nm1HTmxYK3FidjFueTJ1emhXNXBXL1ZHY0I5OE9JNmVJdDM1cnFMVzBt?=
 =?utf-8?B?aXFQRTUwTTRlbHhmRDBJWXVuUXlvMFNmYU1vM1A4WkpZRTdNMzdJUTJYeG96?=
 =?utf-8?B?dU9KSkFwM3JCdWY0NjBjU3A0WWNRbWd0VWhBanBicHNNNVk3Tk5nbU91cFJM?=
 =?utf-8?B?b3JKTjNFbm9jVEVTa3ZkY1FwVCtMNlVwTkVBeVhqRzVXV1puVzlCS0JtVTZu?=
 =?utf-8?B?Q0RWM2JyOFNBVTRBRjUrbi9UeWxJMjh1aDVkRXB1Q1FJSVlrUlVJdVFRNENP?=
 =?utf-8?B?NGpOYWpOakh3eFdBc0ppRURCRTVwZkM1U1d0MHY3TDJOeDVuVDlVV0ZIZHc1?=
 =?utf-8?B?b2g3UmgrZXVIcWtudkRCZ2VLZEZORTdOVzFiQmxiTnZNcndzQUFZc2NCdXJC?=
 =?utf-8?B?RFZLNW9ic1ZSM0YxQ0hjMWtCTjdCeVBZdW04czNCZkh1bHNQK2Fab0JUbWFS?=
 =?utf-8?B?cXVadzE3NnNZSVpQUmNIdFh0KzFoNi9MNW10NjluTUtMTXJFN2NxWWxFTkRz?=
 =?utf-8?Q?/uA7Uiid2t7mnOhxbn55RRI87?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be38a5a3-2bc0-49ac-3d44-08dc60797e7c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 14:03:31.1577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjAAXNb/G8TM+cw8S88tz6psomGpOvLF2HMdBW+Ue3wKW1IBtnZrTq1b0Koew3rVgRwNyBhMCOFhPHFadgyUgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6100
X-OriginatorOrg: intel.com



On 4/10/2024 3:22 AM, David Hildenbrand wrote:
> We can now read the mapcount of large folios very efficiently. Use it to
> improve our handling of partially-mappable folios, falling back
> to making a guess only in case the folio is not "obviously mapped shared".
> 
> We can now better detect partially-mappable folios where the first page is
> not mapped as "mapped shared", reducing "false negatives"; but false
> negatives are still possible.
> 
> While at it, fixup a wrong comment (false positive vs. false negative)
> for KSM folios.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

