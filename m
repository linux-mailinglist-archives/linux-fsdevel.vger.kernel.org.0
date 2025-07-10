Return-Path: <linux-fsdevel+bounces-54422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838CDAFF7F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 06:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65678483DBD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 04:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF482820B7;
	Thu, 10 Jul 2025 04:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0aMOeChw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E142F3E;
	Thu, 10 Jul 2025 04:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121377; cv=fail; b=XuAsjjU08kVUN0A95WyIRgnAdvbIgNjGnmQGFQHkA/7jVNRAtQom5Hy7uLGB0pYWgQEQ94agWRw4dfbz6Wdw2OJT5kJd3voD+yKBy9hXoQxsW1Cen7FsV6qqMiDonEELw04zaxMF/Jd3tqt4dKJKh3G9gMalGxFyaBzb0iljFds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121377; c=relaxed/simple;
	bh=bOfTKD1gh89jyscNTuIXzR16TOzi5biy21tRrDteAhg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qF5siqChRdPRWA5EfuJdNYOB3GtbPmy41b/wOfDCrgBKpidrV64P8HVNNuruumOMyEF/qVBSDr09zc4C0D13HXPYZBVyi0tGcP5ZLQALW7fc22C5YBZH0u2Pq6wTzVAFx6bz1V2KexlGdE6Xbvz+TcQ2/U4Z7uEdFbWd/S8z270=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0aMOeChw; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZG8/puVIgECdk6qd36COhTyMq+iyEH1Tj6EpJq/Qy7Vs1AT5jtznWnH5DeJUtADS2yan+Yf2KLpw3tqzGwqlnFVa4gtl9KIJl7aqTD59SnDwnXP8g8tLhjSMF5eGC2uYnYZmb49wYVxPpzYt18SZGN4cdCJS4xO0Uki1v5RXN8n4zGSx6bGssgNOyjqy7QDghAkFt4o1vNGhY6Y5cLiWbf1Ruh3wCfvWkNlbVnx5jIRZeXQg3QIOsTqyGRzC4lRGiH6TeOPwa7d7QYsdJG+I7hQmm/yedh5kBpkWy0TSwJhMGD2LVwk/HHlrAJQoHgvSMgD0PVftzN4aZXyZUnd0ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaPtGqHodzsj+NZTCDM9PCT9jcSXw2VXFlzXWgif/d8=;
 b=IqKk0ZEp5AoanVaY0ZpFaDfLYo59VZKFxA4zUF+iWOMqHDeUw9gZtljp/yDyBL2ZZ8OhkSXKETsn4dRJyOfpBMgxdVRFRMJHrnqxsN4C3Fxpi12VisbFLhDj13YhRpXUCGVBJ59nbsi7FjyAkK5FyCvednohQxOj2yVzlVdXA0zbIRHILT5GJgeQ7yzQeyajfL+46HHEv58b7qcjp4hrUTORGied8e5Sz57BJAnPGkaOcfgyeIqTZjO+jFIZ+GjF0sZOulH90dVrkcDQQptLqj1GPhZI5lq6LWrYj4RgXMJYV+p/vvHe9d2hW0VCQc7SHSsCZxz+TEjz/pcc6J1P2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaPtGqHodzsj+NZTCDM9PCT9jcSXw2VXFlzXWgif/d8=;
 b=0aMOeChwzITu85DQYyDfVpBioqJzlIDdIb5Uox24PUoHK2eZjCLrbyiVTkJAOctQIOQrR+2haX36ARBnA4MWZJjVGdb+yOxU3lpAI4w1jKwqC/kGT6QgvpZwJ6TP2IEqsFzqIy1a6w8xNMxvNaZOxB5wMsPJb6Qerv+GP5pRNbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by DS0PR12MB7828.namprd12.prod.outlook.com (2603:10b6:8:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 04:22:50 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%3]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 04:22:50 +0000
Message-ID: <a4860c1e-e6ec-4f5a-a039-bb2066740523@amd.com>
Date: Wed, 9 Jul 2025 21:22:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] cxl/dax: Defer DAX consumption of SOFT RESERVED
 resources until after CXL region creation
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>,
 Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250603221949.53272-8-Smita.KoralahalliChannabasappa@amd.com>
 <aac45d58-afca-487c-8d14-62d5e7fd490e@fujitsu.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <aac45d58-afca-487c-8d14-62d5e7fd490e@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0158.namprd05.prod.outlook.com
 (2603:10b6:a03:339::13) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|DS0PR12MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ccaea5-1ca9-490b-4456-08ddbf696e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elNrcXRoWW1qa0RxWFNhTmlKNS9xVTZOWXZrMzlYSGdnM1dWN044aHpNVWx5?=
 =?utf-8?B?UG1SQm15TlpCVjJLcUQzM3ljTzZYVkJhblAwV0FGbHRaQnh1MkFHdzZqd2F3?=
 =?utf-8?B?VVozOGpxSTlPQ1cwYnlIcGVaeEdTSGVaYUR5alo3a21NYXdpSmd1M0hOY2px?=
 =?utf-8?B?VVR3S2N3ZjdHVkgxdCtMSTBoWmJNZ1BHV1JCWnJqcUlrdDduY3BvZEZLZWtG?=
 =?utf-8?B?dmxXSVRqdW0rRjl6NVJjcHRjVm11UVFJUS83R28vUmladlRXNWZyMjlzZVRQ?=
 =?utf-8?B?c1U2TGl0b0Z1RmVTMUlzYzY0YWdZWVVOcTRqVGFLNWdjcGxqOFNUaGJjMW0y?=
 =?utf-8?B?MmZlSDJMWUdFYm1CT256dFJoa3M5SDhMcmhoeERiYk1HN0haeXlObUVTUVBG?=
 =?utf-8?B?U3hiTEdPeFF0eUlyRkdoTmNCaHB1UEdtZjJHOGJDckltMXFWekQ4SUp0bTZY?=
 =?utf-8?B?MGZDTit6MDhHUVhMRVZSa3ZCS1JENlZUWlh1amFWbUJEb0M2L3VoMHljOEFh?=
 =?utf-8?B?eXZRbHB2dSsxdzlCODJwNzdLU3lMQkZ2RkdFdlhVaGtFY25hQXBQaG1KeXFQ?=
 =?utf-8?B?NlZlOFdrbWY0c2gwdWV3Nm9pUXFpSU1sK1F5NDdlT0treXNmN05GbDdnOGVx?=
 =?utf-8?B?NWVFZjdpUFdKUTdvRXBnSjRBRlZYcE5NVFROY0U5Wk00R2Z0cGhYOG5Majhu?=
 =?utf-8?B?WXNnVmFWc1h1SWNUQllpQTlpZGovRUQ1K1VhUzlPZS9IVTBzZFQ2YkwwMkQx?=
 =?utf-8?B?OUIvYkZOSUYvZnhiQWMyVmJoOEEyU21hcTFzMXJ4aFl4MzQranZNSWJ6NVkv?=
 =?utf-8?B?d1JtODFod203M1RFMi94cENHT3lsZ0t3QWN0N3ZLNDBDaEE4c1FrSW1BZ2Uv?=
 =?utf-8?B?RTBFS2NoNDh6VkNkSUZUdENFYWZMUTVaZUU5RklxZXhicERrQTF4dCtkYXRW?=
 =?utf-8?B?UTdBZnU3eVlQaDdlbzFsU1JkM0wxRHN4L2ErbGNxbVd6MnM2c0orTHhHTm8z?=
 =?utf-8?B?eW14Yis5a3dOKzFNK0czRVFBSzlFZ2E3aWlrVUVqR1NWMmQ1YWlLYXV1dkxw?=
 =?utf-8?B?d28rSGxmSEdKWlY1RVRxSGdyQ2lDVnd2b0ZpMUVBRGNobzY4MXQ2eFRhRnBG?=
 =?utf-8?B?VG9iVEw2cUIvWjRjQ2lvdHN3Y1JxRXptbFZ6TWtKNzdrSXFramxZdmxsR2Z5?=
 =?utf-8?B?eEV5N3hVVTBpZFJEd003SSt5dzA3WmQxYkUxSzhwa0NURExET0JRRko4YUdj?=
 =?utf-8?B?ci91UktqSXg4MjRoTWJzclluVnpGTmJTMjRXRW54b2tHamlidDNqQVVwYUh2?=
 =?utf-8?B?UVNRdGRicnUxNWhlMlhiTnFNWndOVVlnVmNQQXNaSkw3dmtmaWNzMVFJbTY4?=
 =?utf-8?B?dFQ5Qm1OdWR2R2d1a2JpTml2TEFtaVlsdUdiUGlpck44MkluL3Z1MzdhSEh4?=
 =?utf-8?B?UFNXREh1QWk4ejA5KzBLZFRkTHNza2JqMHM2eHFkSmpnMndxUU44OXQ4ZTU1?=
 =?utf-8?B?MWtRTXpQZk56NlZVNko2dWFteGs1SWErT2xscmovY1N4WE1tYkk3Uml3VnBW?=
 =?utf-8?B?Y1Y3aEdPUFBoaU82dGg3TjlHbzN3Z1IrMmtIREtGTnFQdGV3L0JtNFR5elM1?=
 =?utf-8?B?cGJtWjU2NFJ5YWd4d3VHeXRIVXhYUVZjQnhBMklHamw2QUxzYTY4VUhObnU5?=
 =?utf-8?B?TUlqanhmUk9aQjV4Y0sySyttTlBYd2hwaEVIY1Npa3RRSWdLb3RRRGt2aCt5?=
 =?utf-8?B?WDY5bTcyWXg1cWFjWHMvMklydUs0SEFqTmtGYkhqa1ZPL0tUMmV5eHh3R0VP?=
 =?utf-8?B?MG5INWJlbnNGcmxiR09jZFNkNFhQRE4ySnN4RGRNaSt2clozZ1hlZnhVY3VW?=
 =?utf-8?B?VmpZdkpDVk5tNlhoN05Qb2MwbElJUTRucjN3K2NzWGNPU08rajQ3ODVFNHVx?=
 =?utf-8?Q?IeZxmOmA2rM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkpMNjJPR0JNdnBHVFlkNjdiZXJlZDhCYWk2YlZ0WHMzckRDdTZNODh2SmR1?=
 =?utf-8?B?WU05dUc3bFBWS1VxQitsQzdBLy9vNEt6VzBFUmMwSXdnd24vT3lxNS8vZ05q?=
 =?utf-8?B?UHdJdWRGNGRIcHlvNHJ0b1YyakcyS0cvaFpnQzR4UDR5WkZXWStNSEN3cnY4?=
 =?utf-8?B?b245R21HR20ybjNXaTVIRk5yN29MUFVlZjIwNTgwZUJCY2RWTjJjY1BUb3E4?=
 =?utf-8?B?aEU1bS9FSWRUTUdPMElDc3lVbVR1UjM2SUM5MEsyMnNiR2NWU1VJa3U0eTZX?=
 =?utf-8?B?d043YTdKWkVmWk4vUmpmamxnMDdDNEZZbmJuUXJPM1d3cXkvdEZ0ZXBOQS9p?=
 =?utf-8?B?K1c5UVN0NXlkT0psOCtOcUprc003cGF2WWlSREdSazZITHZON0ZHTlFNaVFr?=
 =?utf-8?B?ekxUeHczQ2NOMCtMKzVHR0k4bzZHeUJucTQvVTJqcXpVZjBnRGV3QVp3bXph?=
 =?utf-8?B?UjluUFllN1Z0TUZZOHd2c0VoTFhZMnF1ZzkvUDlQalhOa255Z01KWG1NN1dn?=
 =?utf-8?B?ZGpDK0txdmZITk5TRnlNWmlwcFhLb2hJMVlYdlkzWW1pd1I5bzZmWWt2NW5N?=
 =?utf-8?B?U2VwSzdNTWwrdDl5VzFXSzFMd25xbmNRaFB2K2t4WU9WbkNpMTg2aFJDelFC?=
 =?utf-8?B?S1pBQ0dVVm83NzcwYTNqaHVlR2M1THFocFF6QWR6SVRaaEpmRXFHakZRQi9n?=
 =?utf-8?B?MUlyQ1FRYjN2ekFtY3JQaDJCYjV4ajJlUTRyOFFQeW1wYjNCeDM5TTlZbTRo?=
 =?utf-8?B?NW9iRi9nWisraTlNbloxQjJPU3h5bTJMQjJQR3huZ3VEVXhmVzBNWjMwVFBr?=
 =?utf-8?B?MFhYZmNjVnBXanZYL3VybHJTNmxuRzdSSXd1dWpYRFNMZ2JQdnBnZjBKTUFL?=
 =?utf-8?B?bklWazVDa3dpU29XYm1FVHZTRkxmMnlHSGRGY00vcGt3MFNFdjV5RHE4UVRn?=
 =?utf-8?B?Z2dwT2IzRThSMU1paXBQUnBZQWprbWVUTmVjUzBPNEZaOGtya2xpOWRxdER0?=
 =?utf-8?B?aXFoSytnRmdyelorNzJNSzF1WjUzb3hmTzVRblRMM3pyVDdmWWVhSFo1b3o4?=
 =?utf-8?B?Z1pMcG0yVFgxbmNuTldHdlJMdE1iZFZLSlhwQlQwK0JQdmd1b0xTTDZHUTZq?=
 =?utf-8?B?blF2NmdTT0ZWKzdHOG1VUzRSNFpINmQ0c0hGQ0hJbzVTMEUyMU9USmtlcmtv?=
 =?utf-8?B?TDY3cmgxa01pNk1ncURuNlFEVE4zYVdHZTEyVEludjRMOUxTampYWGV5TzE5?=
 =?utf-8?B?WGJMeDJYNXBiNlRJRFlIM2o4TTRORVFMbEQxSGt5R2lxWVpSMU5JeElnWEo1?=
 =?utf-8?B?Q0xuYTlMRmE4T1J6c05oOWl0NkRhSlIxL25vMmJhUjZqOTIwc2xpcXJvd3l6?=
 =?utf-8?B?Vy96SmVoNnI5SUJwSVVMUHU3aTR5K3Y3N2dldktrYmQrbFdGNnZSaERsNUtT?=
 =?utf-8?B?Y0pnQXhRRGNvbnpCbEZqMkROTUQ3OWNqVWZYdmZFY1dJdGFLbzJUOFpoVHl6?=
 =?utf-8?B?U3FPTERxMzV2RlQ0VGlEZVJkeGNwN1dpMEJzRFhUOERRTi9wbU9NcDhMaHJs?=
 =?utf-8?B?U3lUeThNVGVocUZzVGVDN3J6bEgyZ2JtNWVVOEh6RU0xbkVHOTg3U1BLcDZx?=
 =?utf-8?B?citVMjB6NC9XYzR2ejV0Q0kyckcxdkdHQXZPWWtiSWVERWUwamRJV2xCdjdS?=
 =?utf-8?B?amtwanNWK3F1ZTYxTXhQdFJFQVhsSHc2V0tnQSt1UmcreTVjVHg0Y09KbFB5?=
 =?utf-8?B?K1pwbWZxYmFCK1ZYTWJOc1BkK2g4VE5xTE81UjU5Qno2amZDWS91cGN4OUMw?=
 =?utf-8?B?TVpGN2VsdjlkcUJydENsK0ZWRG4zUGU1WHdIWm5tUWZ4SGthVlFsUUFuVEYy?=
 =?utf-8?B?ZFVtcGN5alNZUUtuR2I3cXBKd08weE85dS9vRkZRL1BvbWJnencyeHBWbjRJ?=
 =?utf-8?B?a1g0UEVNVTh5TzlPQXZEeHVFUmpBWlh6NlJtU0hySlRaUzlXbmZQcXJwdEtk?=
 =?utf-8?B?bC84WFVGUWR3QmZ1cm51d3RLdStxRnlvZ0xMVnBuUWQxQ1dlaEhMcStrYXR0?=
 =?utf-8?B?ZHg0QjhrWjA1bFJFOVN2WXJ3ZExZcGVod2NObXhaL01pR1ZMUFB3dDJmUC9o?=
 =?utf-8?Q?8ydk3ST6iNBG2XKTV5dCJqfFq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ccaea5-1ca9-490b-4456-08ddbf696e0b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 04:22:49.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gdBCWzwVBUGUlg/ILqDhxycmORXiC9ORSN+h83K4gXG4JEVjKrMb9kn7Xzl++/l33m9UvXgHCsa4TatRbAsxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7828

Hi Zhijian,

Sorry for the delay in getting back on this. It took me a bit of time to 
fully understand what was happening. Responses inline.

On 6/12/2025 7:12 PM, Zhijian Li (Fujitsu) wrote:
> Hi Smita, Nathan, Terry
> 
> I am struggling to understand if this patch is truly necessary, or if I haven't
> fully grasped the scenario where it provides value. Without applying this patch
> on a QEMU/VM with both HMEM and CXL.mem installed, I observed no issues. (Are there
> specific config options required to reproduce the problem?)
> 
> Here is the /proc/iomem without the patch:
> 180000000-1ffffffff : Soft Reserved  ### 2 hmem nodes
>     180000000-1bfffffff : dax1.0
>       180000000-1bfffffff : System RAM (kmem)
>     1c0000000-1ffffffff : dax2.0
>       1c0000000-1ffffffff : System RAM (kmem)
> 5c0001128-5c00011b7 : port1
> 5d0000000-64fffffff : CXL Window 0  ### 1 CXL node
>     5d0000000-64fffffff : region0
>       5d0000000-64fffffff : dax0.0
>         5d0000000-64fffffff : System RAM (kmem)
> 
> On 04/06/2025 06:19, Smita Koralahalli wrote:
>> From: Nathan Fontenot <nathan.fontenot@amd.com>
>>
>> The DAX HMEM driver currently consumes all SOFT RESERVED iomem resources
>> during initialization. This interferes with the CXL driver’s ability to
>> create regions and trim overlapping SOFT RESERVED ranges before DAX uses
>> them.
> 
> When referring to "HMEM driver" in the commit message, is it
> `dax_hmem_platform_driver` or `dax_hmem_driver`? Regardless of which,
> what is the impact if one consumes all SOFT RESERVED resources?
> 
> Since `hmem_register_device()` only creates HMEM devices for ranges
> *without* `IORES_DESC_CXL` which could be marked in cxl_acpi , cxl_core/cxl_dax
> should still create regions and DAX devices without conflicts.

You're correct that hmem_register_device() includes a check to skip
regions overlapping with IORES_DESC_CXL. However, this check only works 
if the CXL region driver has already inserted those regions into 
iomem_resource. If dax_hmem_platform_probe() runs too early (before CXL 
region probing), that check fails to detect overlaps — leading to 
erroneous registration.

This is what I think. I may be wrong. Also, Alison/Dan comment here: 
"New approach is to not have the CXL intersecting soft reserved
resources in iomem_resource tree."..

https://lore.kernel.org/linux-cxl/ZPdoduf5IckVWQVD@aschofie-mobl2/

> 
>> To resolve this, defer the DAX driver's resource consumption if the
>> cxl_acpi driver is enabled. The DAX HMEM initialization skips walking the
>> iomem resource tree in this case. After CXL region creation completes,
>> any remaining SOFT RESERVED resources are explicitly registered with the
>> DAX driver by the CXL driver.
> 
> Conversely, with this patch applied, `cxl_region_softreserv_update()` attempts
> to register new HMEM devices. This may cause duplicate registrations for the
>    same range (e.g., 0x180000000-0x1ffffffff), triggering warnings like:
> 
> [   14.984108] kmem dax4.0: mapping0: 0x180000000-0x1ffffffff could not reserve region
> [   14.987204] kmem dax4.0: probe with driver kmem failed with error -16
> 
> Because the HMAT initialization already registered these sub-ranges:
>     180000000-1bfffffff
>     1c0000000-1ffffffff
> 
> 
> If I'm missing something, please correct me.

Yeah, this bug is due to a double invocation of hmem_register_device() 
once from cxl_softreserv_mem_register() and once from 
dax_hmem_platform_probe().

When CONFIG_CXL_ACPI=y, walk_iomem_res_desc() is skipped in hmem_init(),
so I expected hmem_active to remain empty. However, I missed the detail 
that the ACPI HMAT parser (drivers/acpi/numa/hmat.c) calls 
hmem_register_resource(), which populates hmem_active via 
__hmem_register_resource().

Case 1 (No bug): If dax_hmem_platform_probe() runs when hmem_active is 
still empty.

walk_hmem_resources() walks nothing — it's effectively a no-op.

Later, cxl_softreserv_mem_register() is invoked to register leftover 
soft-reserved regions via hmem_register_device().

Only one registration occurs, no conflict.

Case 2: If dax_hmem_platform_probe() runs after hmem_active is populated 
by hmat_register_target_devices() (via hmem_register_resource()):

walk_hmem_resources() iterates those regions. It invokes 
hmem_register_device(). Later, cxl_region driver does the same again.

This results in duplicate instances for the same physical range and 
second call fails like below:

[   14.984108] kmem dax4.0: mapping0: 0x180000000-0x1ffffffff could not 
reserve region
[   14.987204] kmem dax4.0: probe with driver kmem failed with error -16

Below, did the job to fix the above bug for me and I did incorporate 
this in v5.

static int dax_hmem_platform_probe(struct platform_device *pdev)
{
+	if (IS_ENABLED(CONFIG_CXL_ACPI))
+		return 0;

	dax_hmem_pdev = pdev;
	return walk_hmem_resources(hmem_register_device);
}

Let me know if my thought process is right. I would appreciate any 
additional feedback or suggestions.

Meanwhile, I should also mention that my approach fails, if cxl_acpi 
finishes probing before dax_hmem is even loaded, it attempts to call 
into unresolved dax_hmem symbols, causing probe failures. Particularly 
when CXL_BUS=y and DEV_DAX_HMEM=m.

ld: vmlinux.o: in function `cxl_softreserv_mem_register':
region.c:(.text+0xc15160): undefined reference to `hmem_register_device'
make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1

I spent some time exploring possible fixes for this symbol dependency 
issue, which delayed my v5 submission. I would welcome any ideas..

In the meantime, I noticed your new patchset that introduces a different 
approach for resolving resource conflicts between CMFW and Soft Reserved 
regions. I will take a closer look at that.

Thanks
Smita

> 
> Thanks,
> Zhijian
> 
> 
> 
>>
>> This sequencing ensures proper handling of overlaps and fixes hotplug
>> failures.
>>
>> Co-developed-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
>> Signed-off-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
>> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>    drivers/cxl/core/region.c | 10 +++++++++
>>    drivers/dax/hmem/device.c | 43 ++++++++++++++++++++-------------------
>>    drivers/dax/hmem/hmem.c  |  3 ++-
>>    include/linux/dax.h       |  6 ++++++
>>    4 files changed, 40 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 3a5ca44d65f3..c6c0c7ba3b20 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -10,6 +10,7 @@
>>    #include <linux/sort.h>
>>    #include <linux/idr.h>
>>    #include <linux/memory-tiers.h>
>> +#include <linux/dax.h>
>>    #include <cxlmem.h>
>>    #include <cxl.h>
>>    #include "core.h"
>> @@ -3553,6 +3554,11 @@ static struct resource *normalize_resource(struct resource *res)
>>    	return NULL;
>>    }
>>    
>> +static int cxl_softreserv_mem_register(struct resource *res, void *unused)
>> +{
>> +	return hmem_register_device(phys_to_target_node(res->start), res);
>> +}
>> +
>>    static int __cxl_region_softreserv_update(struct resource *soft,
>>    					  void *_cxlr)
>>    {
>> @@ -3590,6 +3596,10 @@ int cxl_region_softreserv_update(void)
>>    				    __cxl_region_softreserv_update);
>>    	}
>>    
>> +	/* Now register any remaining SOFT RESERVES with DAX */
>> +	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED, IORESOURCE_MEM,
>> +			    0, -1, NULL, cxl_softreserv_mem_register);
>> +
>>    	return 0;
>>    }
>>    EXPORT_SYMBOL_NS_GPL(cxl_region_softreserv_update, "CXL");
>> diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
>> index 59ad44761191..cc1ed7bbdb1a 100644
>> --- a/drivers/dax/hmem/device.c
>> +++ b/drivers/dax/hmem/device.c
>> @@ -8,7 +8,6 @@
>>    static bool nohmem;
>>    module_param_named(disable, nohmem, bool, 0444);
>>    
>> -static bool platform_initialized;
>>    static DEFINE_MUTEX(hmem_resource_lock);
>>    static struct resource hmem_active = {
>>    	.name = "HMEM devices",
>> @@ -35,9 +34,7 @@ EXPORT_SYMBOL_GPL(walk_hmem_resources);
>>    
>>    static void __hmem_register_resource(int target_nid, struct resource *res)
>>    {
>> -	struct platform_device *pdev;
>>    	struct resource *new;
>> -	int rc;
>>    
>>    	new = __request_region(&hmem_active, res->start, resource_size(res), "",
>>    			       0);
>> @@ -47,21 +44,6 @@ static void __hmem_register_resource(int target_nid, struct resource *res)
>>    	}
>>    
>>    	new->desc = target_nid;
>> -
>> -	if (platform_initialized)
>> -		return;
>> -
>> -	pdev = platform_device_alloc("hmem_platform", 0);
>> -	if (!pdev) {
>> -		pr_err_once("failed to register device-dax hmem_platform device\n");
>> -		return;
>> -	}
>> -
>> -	rc = platform_device_add(pdev);
>> -	if (rc)
>> -		platform_device_put(pdev);
>> -	else
>> -		platform_initialized = true;
>>    }
>>    
>>    void hmem_register_resource(int target_nid, struct resource *res)
>> @@ -83,9 +65,28 @@ static __init int hmem_register_one(struct resource *res, void *data)
>>    
>>    static __init int hmem_init(void)
>>    {
>> -	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
>> -			IORESOURCE_MEM, 0, -1, NULL, hmem_register_one);
>> -	return 0;
>> +	struct platform_device *pdev;
>> +	int rc;
>> +
>> +	if (!IS_ENABLED(CONFIG_CXL_ACPI)) {
>> +		walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
>> +				    IORESOURCE_MEM, 0, -1, NULL,
>> +				    hmem_register_one);
>> +	}
>> +
>> +	pdev = platform_device_alloc("hmem_platform", 0);
>> +	if (!pdev) {
>> +		pr_err("failed to register device-dax hmem_platform device\n");
>> +		return -1;
>> +	}
>> +
>> +	rc = platform_device_add(pdev);
>> +	if (rc) {
>> +		pr_err("failed to add device-dax hmem_platform device\n");
>> +		platform_device_put(pdev);
>> +	}
>> +
>> +	return rc;
>>    }
>>    
>>    /*
>> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
>> index 3aedef5f1be1..a206b9b383e4 100644
>> --- a/drivers/dax/hmem/hmem.c
>> +++ b/drivers/dax/hmem/hmem.c
>> @@ -61,7 +61,7 @@ static void release_hmem(void *pdev)
>>    	platform_device_unregister(pdev);
>>    }
>>    
>> -static int hmem_register_device(int target_nid, const struct resource *res)
>> +int hmem_register_device(int target_nid, const struct resource *res)
>>    {
>>    	struct device *host = &dax_hmem_pdev->dev;
>>    	struct platform_device *pdev;
>> @@ -124,6 +124,7 @@ static int hmem_register_device(int target_nid, const struct resource *res)
>>    	platform_device_put(pdev);
>>    	return rc;
>>    }
>> +EXPORT_SYMBOL_GPL(hmem_register_device);
>>    
>>    static int dax_hmem_platform_probe(struct platform_device *pdev)
>>    {
>> diff --git a/include/linux/dax.h b/include/linux/dax.h
>> index a4ad3708ea35..5052dca8b3bc 100644
>> --- a/include/linux/dax.h
>> +++ b/include/linux/dax.h
>> @@ -299,10 +299,16 @@ static inline int dax_mem2blk_err(int err)
>>    
>>    #ifdef CONFIG_DEV_DAX_HMEM_DEVICES
>>    void hmem_register_resource(int target_nid, struct resource *r);
>> +int hmem_register_device(int target_nid, const struct resource *res);
>>    #else
>>    static inline void hmem_register_resource(int target_nid, struct resource *r)
>>    {
>>    }
>> +
>> +static inline int hmem_register_device(int target_nid, const struct resource *res)
>> +{
>> +	return 0;
>> +}
>>    #endif
>>    
>>    typedef int (*walk_hmem_fn)(int target_nid, const struct resource *res);


