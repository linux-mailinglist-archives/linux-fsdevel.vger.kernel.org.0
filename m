Return-Path: <linux-fsdevel+bounces-43077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE28A4DB7A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 11:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9913AFAEF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 10:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF8D1FECA0;
	Tue,  4 Mar 2025 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LEZmafJe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1701FDA7B
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 10:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085457; cv=fail; b=Q/06frik89ORxON/KbNKkjQG8ztk4phfWQmIFOQ5Swju71XfyXihk7snQWI+PcKwiBN+sFQbcWnP5hb99pwBMcYLbcUuUQJhqewnpDr/YvlFtFvbJ8JlVpn898V2C7r/DyKWDK1DGwOtIxgZ39bdfDmOXBPqXHvJbA4uRYTO1Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085457; c=relaxed/simple;
	bh=tsuRXHBm0On4X5LTZx98IPj1nXNiuLHUJ5FNRG5jLxg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uLsus+p2Qgo7yklIDeSAM/td0q67DYVLhu125s+rBc/bHnN/P0h9MNziU5czjP6+DMbrGxNz31uJGz7p86+i76DUAqk5d6L07XIDHw3Yqa37AB5kkcONCLfuOWwS59VPc+nXUlPmRyDf58kXzw0s4e3IGQVeFasdQoBgR4J2SLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LEZmafJe; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741085455; x=1772621455;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tsuRXHBm0On4X5LTZx98IPj1nXNiuLHUJ5FNRG5jLxg=;
  b=LEZmafJeMd6nHBmpHwoGKkutUCTwhNh0Nm5R//zNXm8tKS8xP0ZRk+P9
   oJLofu0dkFoY1z+hdNhS54ln8QhcZ/KB8b09goIw5pgZ67CAeDNJ5J9Wp
   SDTR/N1Hh0yh9tZqBM3OwsvcsmWC9H1QosmVRnLkz8pKdrljx6dGUTIpt
   eGS1xrWWU1SYaX93TdgkQcXQqB+ygohAd3YeK4cGPxITRxfxhqLQvKs7T
   zYI1YLkvT/yMQzOQNvSLfMBSISBeRUOK8mo/r95Sm9DZyY/R2m5KIvEMm
   LWwzu6Or+6FAXa5NFXlfwjlTiUNSSKXbHBoNCoQLgY7G+AztZms7h83bN
   g==;
X-CSE-ConnectionGUID: vPhwE18iRkCe8cTqs4swJQ==
X-CSE-MsgGUID: eoIMwru7S9KJ3095su27QA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="29585612"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="29585612"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 02:50:54 -0800
X-CSE-ConnectionGUID: Hl0DNU3pQGK/qBRYybKl9w==
X-CSE-MsgGUID: UXViMplXRfqMw+AYYE/oKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123538854"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 02:50:54 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 02:50:53 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 02:50:53 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 02:50:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b492LmFFEghhUaDSWdLDHkOYYsnmiANOf+U3BR9B/8MDCWKtfCca/BAdGkhngJxAqaT9wUl/+Y9GtL2xn3ojf2dwFeinptewKhkVCoxoBPd/qtsO8GfIq7lTSFUBHg1UC2WXl4c7OhckIYWuQS2AwP7oq7AwSji/C1z1HAp00yozZMOw6PZCzZhDFxqMMra56uARYwCOjZG+LvY54AwcuaRs0ehk3YC7sbQL/P2a5eg1MivEo6sSNzcgrDxost5oBoVtfErSZx9g3YC0FymAaU4J8omMvEkBl5vGvE0HbIg7lBSDI1yhXuhWtP3TljQDjHX65BY1dPeZ8USBv94hzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHfqKAuxjCAf/+rvCVbZsS7Ekjx2ND6nidGXOE8r4nw=;
 b=avLDz3jiufTbtWdTkpOTNzmvY/7gA4E9mvrY+WI+m9B1mIm+k8MPP61zFksiv9RVbMO/Ve7471Z2f+KxzqeyvGcVdTi9sC6fxwGsYiRd6UCd6mnB/5kHoicH3aDaFWqxTk5Q1IzTcnEzpWgUcJqqUiuBXIULyVrDM15FezYUlhlzpqmFu9DzmU5X+VkIC7FSLlkUre0xuza72x1nO+NZeJC40bAjzEUvsei5RpDwb4asNv3nWfo/bFiRuQP42d91K2K6q2nGqx7jPos1+e1lRJdX3mXvbrQaGmzN+xnGsuRPu/A4Uw9bnRqhe6dIlYvqYyzKoULWeTb73eI18HJb9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3260.namprd11.prod.outlook.com (2603:10b6:5:b::30) by
 DS7PR11MB7859.namprd11.prod.outlook.com (2603:10b6:8:da::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.29; Tue, 4 Mar 2025 10:50:46 +0000
Received: from DM6PR11MB3260.namprd11.prod.outlook.com
 ([fe80::8d90:8679:bcfa:43d6]) by DM6PR11MB3260.namprd11.prod.outlook.com
 ([fe80::8d90:8679:bcfa:43d6%6]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 10:50:45 +0000
From: "Deng, Pan" <pan.deng@intel.com>
To: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
CC: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Li,
 Tianyou" <tianyou.li@intel.com>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "Zhu, Lipeng" <lipeng.zhu@intel.com>
Subject: RE: [PATCH] fs: place f_ref to 3rd cache line in struct file to
 resolve false sharing
Thread-Topic: [PATCH] fs: place f_ref to 3rd cache line in struct file to
 resolve false sharing
Thread-Index: AQHbiYSNHlwn3nzYsEynZ0FOkfyEOLNdIUWAgADvGACABL8nAIAAA39Q
Date: Tue, 4 Mar 2025 10:50:45 +0000
Message-ID: <DM6PR11MB3260ED787C9100936D9678D296C82@DM6PR11MB3260.namprd11.prod.outlook.com>
References: <20250228020059.3023375-1-pan.deng@intel.com>
 <uyqqemnrf46xdht3mr4okv6zw7asfhjabz3fu5fl5yan52ntoh@nflmsbxz6meb>
 <20250301-ermahnen-kramen-b6e90ea5b50d@brauner>
 <upzftocvmcmbqrtnquww5zwtobeguhdx4arewbxayb7bdjagru@peb5hktbtv7u>
In-Reply-To: <upzftocvmcmbqrtnquww5zwtobeguhdx4arewbxayb7bdjagru@peb5hktbtv7u>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3260:EE_|DS7PR11MB7859:EE_
x-ms-office365-filtering-correlation-id: f204cad2-3393-4365-718d-08dd5b0a6ade
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?nQZIlcwYPNDsjQ/uCu8M/uwQxGlpudFMHdTmtSiy9JXLYIa6Ug9fjAZkwyPW?=
 =?us-ascii?Q?42HV0FpnCyvRkjZ2aYEuuoKcQj1v4k476I9ap+r/Cdnh9gkxDL+qxjTqp3L5?=
 =?us-ascii?Q?cY3oZhypy7iX6aTkdjOT6Hb/zkV/0GjAmvL0aDYi3ilxPH3Doyyqfm1cu3UE?=
 =?us-ascii?Q?WS6rwJaqA6uAFBFsUEyh48gRnBxK4x/B6HSfFti/qwa5B58iXPEZXKSXBvvK?=
 =?us-ascii?Q?P9gYzcBQMbiId2Xq9g3wtLoAd5yoIw/ayLmz/NgcN3MOd7QQeocE9GU4Int0?=
 =?us-ascii?Q?07bltS4Y7WIvVw4Co1S2/pX16zCGuGiLXRco1W5RVns1EjzNj581W6RneN1F?=
 =?us-ascii?Q?L43iowIvcHMbiHmcnhI1twX/dN0OHQT0ZWj+e1hCn4X8ueDksv/cXtiZWeFL?=
 =?us-ascii?Q?J0mLkAlI/kjij0jsSGhct0cVDRebza5I+KBPUY0YnMq7hRSRkuvMb9ztWfHq?=
 =?us-ascii?Q?o8P8sXvrAZvISDBtAnGCTkXdlDV3Y/GNyZPCI9gLrU5m3W2/Mi1hgjliLGmx?=
 =?us-ascii?Q?gfdRrJP0wQVKXSnNEMFcEg+wuIA6Lr3/9csuGWP/a1Z5M+Z7LdGymXPYFL9A?=
 =?us-ascii?Q?j4RRvZZyxsWz9X4YWdVa3VIY6Q48TTk9wPodwEDEwki6F9WG85zzzR9dcW2M?=
 =?us-ascii?Q?IwdXtQhuH67SNoi4h6XX5XS2jE0T8fNP9NrZ+DI7g6UNYFR7XYk65kVFyePp?=
 =?us-ascii?Q?HUoHYD8/i6mFDHFpUV+wFCkkNHBZBgX+5N/pYTNRJn4X4Bcyj10DmdKDFfX7?=
 =?us-ascii?Q?2jfQRpo+XGt+al73ADri16+r93vVJOkAyeyLKyYTzp+jUH7razEs+lvmxVHZ?=
 =?us-ascii?Q?FwHeK/l2JpCI2ue6qDoZgkmgWEa21pjP9CUqJEkSfRkplxNUuKwsX+jt2Yry?=
 =?us-ascii?Q?FUG8m3imnJ9T0edJ3mSv0BS+qDr/5NFnabfp4Y2KAlrUdML3AaLaBRsWHqpE?=
 =?us-ascii?Q?Ej9FikBKO8YEcFO0SWRfUrz6Pnv6FGAmnZ0PNHiaxi6RZ/WnaQZnqWcCW6nv?=
 =?us-ascii?Q?lUrRSBB+82T9g5CPgojOKfsxr6o1hyRLoeVLTT5t12fgnWE+NYCxqrLKbEf5?=
 =?us-ascii?Q?amfiJbuTJB9cO54jHI1BUgUm6xTZwa2HnPuT8dITFAg2xCabxL3QVUepqyKX?=
 =?us-ascii?Q?CnviplqbRXLAyNFv9fNjs3e//00FHrXcTEfUdSCIPxqBrj/2EBgAxJd6w54T?=
 =?us-ascii?Q?zvU6Ni4P8rWf13lTc5HY1ac+zYWPFnb2pElyo2JEhtnpavmSw+bkhoaLU7lZ?=
 =?us-ascii?Q?CvcdpUALIcwiBFDUDp0RrML0OVil2cW6VD64EVeCb1coVGBp88BbygcAGrRb?=
 =?us-ascii?Q?krQiP43I9psSsrkWVQSHuZkYxK/pwz5jOWdg/92KbAdvuqFxDsdrIGakTZp1?=
 =?us-ascii?Q?E71Pk6skVqO7gJ8KcBUEJPz1NrpEbMHMlXsBJaYQyKwLIevI6dEmMlgOsZv+?=
 =?us-ascii?Q?9fjbHCc6s9y66mrHmopwOXrj2uTV8AGf?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3260.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WFdDt9mAK+6e3YnSc8g1qyfNFzV3x8dYqTav2kE+ecMbqiTIGKH5F1V591Lf?=
 =?us-ascii?Q?KVzfbyKeWY7SuHJ0vHPx6wXcxxu/yArCF3rbAC+MJnT/9lgT69BI5L4qZdwS?=
 =?us-ascii?Q?dVFQspQqhW9YrZCb7k69381IAfUX4BPYA34kh7ZRFtfWGNbp8YfutM7d6apP?=
 =?us-ascii?Q?h534UXxEpGn7vHWv5dVzwjxl+VfbPfe2fAsGQW6S97U5ltgejPFZkGxmZT9S?=
 =?us-ascii?Q?9y7dRHqfZR/XAZLd78VgtJlUgP7H2lkxizu5n4fh4gENDXgqynNRNQEI9pXY?=
 =?us-ascii?Q?SmKtHNpk9oU5WCLllNnnk9REFR45/JjbF7HrtqdlKIS5V2ShqEb8WK22UdKb?=
 =?us-ascii?Q?8wGyQa+F6s7xaJeR9UrscMtqvBlvqM6Jrk8Jyh431ruFrmoDCfZ1847QbQuB?=
 =?us-ascii?Q?jdq+QY0k5IyY90vVA6Oi/nXwjDhonKvVgocUGypWngrWbOxrTZcMdfe+qS4q?=
 =?us-ascii?Q?Jo8uHBOKY5fbJXee8M0M4aYgO5vpNcgPe/Wmd2xADqhwsCPErqpy3Wm49FqU?=
 =?us-ascii?Q?JCXROI9xfflde2zzInjR1MA7M79AlZTaI717B2clVVhbCGpghcW80QWLt86d?=
 =?us-ascii?Q?4YA0ygrk5k8eIt4UMNf3uBe6SCD50CO5FxbnK6bxIGd5NQZxHyUr/4EynX9l?=
 =?us-ascii?Q?J0At8d6lg//q9VCUgOTmV/DoV6w6qz2UkDMHVwOoBdvxPGFfukE5krsfoEk7?=
 =?us-ascii?Q?uJnpF2w7aDpMtINLHupWVhSVP3RhBhx93eWDnBqsvNleDAsYzNSc7uM7jZgH?=
 =?us-ascii?Q?F+uOyrd3gVuYr927ELx+56X7vInXvn1ptu8Dcj+SQHR96atNngwiapxQrHKS?=
 =?us-ascii?Q?vlwqgeqz86p8Xn9QhasRcRj/e9jg2AxFpHAC87ziXH3deu9OFpqwTEZxGbDW?=
 =?us-ascii?Q?lybsVcCw2rBNuiYbJrlfr7j3DsHfxouUriI3E/F6THKBQoWxZL4OHhIkxTnW?=
 =?us-ascii?Q?hkYR+R7VZXKff7sd9rWbFP8IVYkaMhKWY9+EERvB72gvAotTvOOE6f/iUlCJ?=
 =?us-ascii?Q?DA4EnVJzH4829tXbHTGv2ROpJc9nCxXrrJasujJPfb/Dbum3WDoPBbMwaRv+?=
 =?us-ascii?Q?HN9HY2KeOuN2uX7luRz9vKaeW6eQCyKnrfxDKzn2iXNFMxKSY8BOAl0LaBf4?=
 =?us-ascii?Q?M82aYAg8tMryZxznuyggZeSyV1PKxRDomo84ur8yfwsHA/Jti/VIQBjGzbrY?=
 =?us-ascii?Q?DHKDtjwmdtbQJ9tYnS4oIkZUbUVIaGvF4q+Ei8KDS8xOL9wkUsrpK8RqXXnn?=
 =?us-ascii?Q?pvd66GTDlYsEk9I64hYIjLsYNE+Z4KLC1jcZKrvRI3GHIB4gvVOxlBTEhEeb?=
 =?us-ascii?Q?+KF220gmKkCXhVxlfCPnVNOt3/aUmeKh07kVMSsQJ3cmX5k0/qctMkwStUHS?=
 =?us-ascii?Q?l4C7NNZgnIXZp7a7g618QamypLoJKQbm2PXZbwz5cTRVHLkFMDG/oYHme4i2?=
 =?us-ascii?Q?tInKaV9u4zEXrM+ozFwmHLOWMLAudwANLtxYw3YbXzxmH9Br/zQaNuvWHIKy?=
 =?us-ascii?Q?/Oe5JRV/jQLL+QaHR5mxUfV4oGRzjo+W9i40F7m8EHEn93EnqoHuTCN5BKOQ?=
 =?us-ascii?Q?6q3NnboN/dK0TUVz1A76uxBm1rWSgbzg6tA8n3r8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3260.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f204cad2-3393-4365-718d-08dd5b0a6ade
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 10:50:45.6840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g84VXIfsQZDTB3GXlUq9+vfEhLnaY4mLP4FgEX7ZP0vtMzPKcruNt4Ziw7cdacEIM4P4rcnpvdWFXAJ3E/zXLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7859
X-OriginatorOrg: intel.com

Thanks Honza and Brauner,
For the question moving f_ref to 2nd cache line, in rocksdb readwhilewritin=
g test, f_ref contends with f_path, f_pos_lock and f_security; while in 3rd=
 cache line, it contends with prev_pos of file_ra_state; the score of placi=
ng in 2nd cache line(exchange f_security) is observed ~10% worse than in 3r=
d cache line.
Moving f_owner to 1st cache line(in vfs-6.15.misc) keeps the same performan=
ce according to rocksdb test.

Best Regards
Pan

> -----Original Message-----
> From: Jan Kara <jack@suse.cz>
> Sent: Tuesday, March 4, 2025 6:36 PM
> To: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>; Deng, Pan <pan.deng@intel.com>;
> viro@zeniv.linux.org.uk; linux-fsdevel@vger.kernel.org; Li, Tianyou
> <tianyou.li@intel.com>; tim.c.chen@linux.intel.com; Zhu, Lipeng
> <lipeng.zhu@intel.com>
> Subject: Re: [PATCH] fs: place f_ref to 3rd cache line in struct file to =
resolve false
> sharing
>=20
> On Sat 01-03-25 11:07:12, Christian Brauner wrote:
> > > > @@ -1127,6 +1127,7 @@ struct file {
> > > >  		struct file_ra_state	f_ra;
> > > >  		freeptr_t		f_freeptr;
> > > >  	};
> > > > +	file_ref_t			f_ref;
> > > >  	/* --- cacheline 3 boundary (192 bytes) --- */  }
> > > > __randomize_layout
> > >
> > > This keeps struct file within 3 cachelines but it actually grows it
> > > from
> > > 184 to 192 bytes (and yes, that changes how many file structs we can
> > > fit in a slab). So instead of adding 8 bytes of padding, just pick
> > > some read-mostly element and move it into the hole - f_owner looks
> > > like one possible candidate.
> >
> > This is what I did. See vfs-6.15.misc! Thanks!
>=20
> Thanks. Looks good! BTW now I've realized that with struct file having 18=
4
> bytes, the cacheline alignment of the structure need not be the one descr=
ibed
> by the struct definition due to the allocation starting in the middle of =
the
> cacheline. It will introduce some noise in the results but I guess overal=
l this
> should still be a win.
>=20
> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

