Return-Path: <linux-fsdevel+bounces-63561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB45BC24CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 19:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94D919A3ADA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 17:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A232E8B9A;
	Tue,  7 Oct 2025 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UCHfvNLL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013051.outbound.protection.outlook.com [40.93.196.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D128C1BD9F0;
	Tue,  7 Oct 2025 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759859451; cv=fail; b=oqVMnV81T3Suh5fC6j7pRWDxvhUTcRu5iJ/pU3umSOy2ihxodg1OWFJB0z1R0mzoBKhTyilf0b0ysbEWAxxOFjaJ7NIopCrCRywmb5KbE79D4FX43iFOMnoLdoMXtpHCPj1HdIOEolrGwCp+iuA7YxTCN5bgVb4fgNkSuqBeTC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759859451; c=relaxed/simple;
	bh=Y2h+pVLNAmgtc8ICZm6yAKox8ZbCKJkMe5XrYzrBwsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jknduRLYeDv/in666//TRfimZANPsTbBRq/bJuDejegAw0ENTOwFY8nHIXaU0ewZM4BpxRuFxBewPzzGP44EB1WNqLA9+9YxUT64qctDZPfktLX+cJEq4BcBoW2mKW9wwVEJJYTrZnnN0VReL904DAmcORRE4log7a1ut9uLPR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UCHfvNLL; arc=fail smtp.client-ip=40.93.196.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGPaMZHDWn4AhylH8nvyPS8WIsgXetvWptxqSDqFMRtX/NbqaI/OOlE05Wt9KaATsuhWLp9qOcOWAOTaVqaEC5an8MVXH99CuFDaFVjqGPl0TTcSLH30/waFXZg+/EXvZoT/zLhqXB+7eYZr/R2knXMOej7D4jiAWbmr4lbnhYVU3trqKe+w2ZEwL9na+XYf370l1g4RsFoGGfD9QnLdTFMCET3BMegrXy5Yx+O7eB0VacHQ3VB0rS/qBsClegruNvQ6kPTI6jvgLfyw4UBHrwSFIvgTSWA2Is9HEUqOM4NCXsGcZ+yKWgdVWHCU0QVllydsLvz3OJDZFdmlt71Kag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xA5qxHVl7roq/nsAFtS9I+tsBRwoXQdPMH+1A6Xk6Xc=;
 b=YZUbok7O61hfk7gXnfOlP5KGyLuVPd6x1wLWcYWcpfGZMtJK0O+ZYvueIVuVjeSBgipofGcz+9KlU5nssMKXuR6XbGF1n5gajlxojyqpnfrvCzYQ/HeM6glsAE+BaYU91fnobifTGLOC/Ph2nqj5hnLOf+r6glhblzJqXFW3103pj7BP9/oBBq3QcKIevm26XG/rUPHjtcZqfbaqImmzxaCFNhXyfW1w/SpGT52Ee0/yk4vRWeHXz58EWZySDB1tS8frJHNiZ2K/LYmoTc6itV7CIcQ/04XljG91EEGktocnRkTZy5BC15rW/OLpJDglr9zhZKYosNaqS+L8YWu9Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xA5qxHVl7roq/nsAFtS9I+tsBRwoXQdPMH+1A6Xk6Xc=;
 b=UCHfvNLLhJvP984O1iN5AVkXFvMxb4ySToB4EnwTK7BSTOy6eO2+lOOerVLkbuedx3IHbU93EaIdMvXO1TTkgpKqTv32UsN4B4D5FmtDN/B57SRMcaSIQhwqdn6/U0GxyDkjHNofSZKTLZoHyX2xVdLRVJaMzypWYjc8dydjFpvnRUBEYrUIOitKaAobceZMvQDaw+AKCDTs+wxIcl1MO1NbO7DMccPVXRj9YDH11srwYvftUjB36wnflwAj3y++QUyWV/EGS9O15x2dCz9goM9P46EuSlPG2bM+Uzq/rjsCZe1tUG9ohYGst6gcBsvFCU2tc4mIa/PQBylKNHDAuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 17:50:40 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 17:50:39 +0000
Date: Tue, 7 Oct 2025 14:50:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com, hughd@google.com, skhawaja@google.com,
	chrisl@kernel.org, steven.sistare@oracle.com
Subject: Re: [PATCH v4 00/30] Live Update Orchestrator
Message-ID: <20251007175038.GB3474167@nvidia.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0444.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::29) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 491d8759-74ff-4093-848c-08de05ca0737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?26Y0iQXTYKCm91ui7VsawlPXFY/zPbApLH+S8fHH1+bQp5j/mKKP0qWSKsl/?=
 =?us-ascii?Q?Yr/Dmmk1F/+i9UbwZy/mhs2HJJp0I6j8qwhNdg+UCsn0vNo/EFcuU/aSu86m?=
 =?us-ascii?Q?fcCzyJLDVI5m1AmZN3ZG5pFSzQ8S5gs6ev1WSeHKmDfgavv75YYkhRP62Vjf?=
 =?us-ascii?Q?EDrDCeybadsTukX/nUGyWu7GSGUuhXNTCCjK5VtGP7UJ1ja1+ExdZbtJ2H3g?=
 =?us-ascii?Q?4mI5mlL6MbtA2dPbbP0Q2vTGuLyahU/NCZi6RMsnCIoSo19wyWLV2o3YgShX?=
 =?us-ascii?Q?DWVCKvNgwgNkEOTxLWLIVr5kEx7Q+FdPlGZc6IZooyetO5XL0D6lPGJUjp0p?=
 =?us-ascii?Q?EPSP9ba5UaHsrJilJ1hXM+ekAhvRIUbkxMl8Thbq/tktWcfUOc3ngQW5kzg+?=
 =?us-ascii?Q?AVqBAu4pBmaWgv5WdPenSZYAQ77fWL1b6UePU3NowFeE+WUJei7STb5sK0rX?=
 =?us-ascii?Q?67fzzlGAYhx49KwhjuZcxbwhwRGl1WzUEsOUrR5FBc6U1nQEEimCURyAj27M?=
 =?us-ascii?Q?2j1nAi2cAMi45LqwWwaa3GElSAsdqFfZxSFMgBnieeHjkujPK+hfVQuCVdIm?=
 =?us-ascii?Q?UJDLXpwRgB1dSLfdVqrZcu8fEBLYJcUceHEyRlnkofLIvAzd/lcrbK2q6Nmu?=
 =?us-ascii?Q?te6AojZF9JnOZ2S6ywt0d7t/jyUL9ichjYz/1ktKmYbIQtJr44+ZanU72U/+?=
 =?us-ascii?Q?iWAfhW610hzl7TmVXw3IKDjIMvSCHjYdnsWO5KkcJjTQyvyWDgZQ3Edkhhlw?=
 =?us-ascii?Q?gbKFXLfQxR0QB4rzhiBwObtZATl9ZN0TJxQk46pgcSnoWSr5mSR1yhhEDQ6z?=
 =?us-ascii?Q?kohSSxEA5LnEh7Ub4jJIxY5K0JXQucJ2DYSZW3JLcuTNew2jkpwbcl+5Z4Ny?=
 =?us-ascii?Q?NKWG7bP/FkodxS6M2qX2W59RssR5cajVLuKjM3dPaVkD5C6GByIfqYaPLSIg?=
 =?us-ascii?Q?8cLIKEZZh0IAl9377jg/IlO/XvE7A2rD3xKGUAlHoRm3Gw4F7EfC4+bvvVSo?=
 =?us-ascii?Q?wfcY387icmh0EBmTr78zqevCI4ZcPXuax45jFfba2B69VgbSQbcOnq9Mg9TF?=
 =?us-ascii?Q?I1klUC93VPQl/NMYnnIHaR74s/GXnhZWO7RuGxgkhCAXmi52f6tstvJll+m1?=
 =?us-ascii?Q?b/raG5aNkWv4JEl3q5a+7OGumqdSJeCwfxzVJ02mL4uxDKPEM4L5SFVvV/ZE?=
 =?us-ascii?Q?wwUL+1CfUyLagPE1YoHAsfS0q4hwnstEz3kONW7q6vq/psT5aBptXxmw15qb?=
 =?us-ascii?Q?IlkQdq3x6ybzHjeH+VmSb1kMHUgNJ8k/1tOngcrpU/DWQtghQLqiOjUWKNZi?=
 =?us-ascii?Q?94JrZJsrqBp1QTdeICCoLKoqG41y+dYFkpI5tJGRCVW4m0OcQdqp/lwEehgx?=
 =?us-ascii?Q?/cWZkyTYyt/AelMrA5WoIuvBWSRN0PjAMkJ/z0zb092Wi+XOTn3ysJCYbCv0?=
 =?us-ascii?Q?8lVH4E1JqzmysKwB6xiauCEt2/Jn01Nn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?194rzCorbHCnJW/tsKiKqLhvWuAR9OBX+JTMDVsWL/NIAxmQaJp+R6TqehDF?=
 =?us-ascii?Q?FBglgf+FdihXKM1I1VDiyxDTqC907jAZ1cJQMV330s4kbAXldr3RojWwnMsk?=
 =?us-ascii?Q?HimWmxsEPcoXtLWdeJKOXsMx8B68t3+M2IT/SXcBtRFjv8MJj0LL+T06QzpF?=
 =?us-ascii?Q?QZ22o4TdR8TxI28qI99Nx2HmB7GwgBZ/Z6TVoy9hDS1yRTFiFWYt5LvbB79+?=
 =?us-ascii?Q?wSthBlFlaxFYTveQICnELKlIcNXJVjHiIuxXDCElsoUv0K0k5VYU7/qpLjuR?=
 =?us-ascii?Q?OkX7IrPmxm1QeXRKAOYJfzemOPYjIeUVy0+psBtsqGD+utbY9TyRDjA6f0nw?=
 =?us-ascii?Q?IczzYRntuOvDbyUpenRsFNpISZrRKS0TwgbdQAdnn6Od2HSrOkgJNnqq5qSH?=
 =?us-ascii?Q?JKe4mjR8JmcTH+1kTRwb14oCbJp8sRDhJYoCoIQALd2Lx6wQ2lNsbmNEeYMP?=
 =?us-ascii?Q?xqCnFAhs8EtlxXJUJAh8deqtuGDpJ3TJVwWzS8GjWAk/zIz9u8q/+M3zWhc6?=
 =?us-ascii?Q?lMi/s/SwY8tlHh9x6iyzXBKk/++xKvRjGTb4Qe0qImaToCKCUEj6mx7Q6Pko?=
 =?us-ascii?Q?b1+w8V/5VVyzcWI6fe1w2wBzqkXTirMxCA7wj76ncwPBpGVHr2Uig/tGr26S?=
 =?us-ascii?Q?69OwG77TRUVCfXsVp7TxatL7lNZ6NffNU6Ab93LHNm5GghwZuoUdpKboRHcI?=
 =?us-ascii?Q?zskW96wyZB6r0kYmhbzhsO6Ws2NyMle+trUNhRlWf6Nwe3V+5mZTpagWiUBO?=
 =?us-ascii?Q?Q9AoWti70XlhZHf3Q7CD6PGJult3Ii/XdkTafBrCxKNxoUiEmfJw+eEUfGYB?=
 =?us-ascii?Q?g84t5TwB9k6/4Mxh1rA/w8ecq50HO70gxaEZWhUtH7JXTGbJVB1rxd2iBkh9?=
 =?us-ascii?Q?3jMB3JS2kHzWHwy0ma10ADIYfuWjvCBD6Kk0s1+gM/I5D3eFajUIuzyNS2OZ?=
 =?us-ascii?Q?C4JHItv7osNfLrO3aYYbPNd2i0uzn4tV5HN8jD0sgUZ8BLj5PyDeiAQ34qxa?=
 =?us-ascii?Q?yEGQvsQIhMHpfRMsIr7xSmKLtxDBuqokoKwZ+pqGkzdiAW/u1gpSUaVJFp53?=
 =?us-ascii?Q?im74OWc4Hx8tfUGThBhpRYNi2af+fjJ8Km1y0B0UT94fXSryDHMheBciGFes?=
 =?us-ascii?Q?UKEcHY0/bgGuJpnYW/bGySfNxjOxX1K8BMCu8oKugc3r1k22NIo6rdJAECDl?=
 =?us-ascii?Q?ooYyJStH/ZizkEjgU/EgOL5BZORPx1T1KXxhpeL2eb0FAR5EMjMrKAzHRMC/?=
 =?us-ascii?Q?S1+XKutymoT+d/MuBpU/wEkw76IScLlSGPVgjBqPqAdpy36/SbgviJ4V4San?=
 =?us-ascii?Q?J4dMrY47bS7KAJqx7dNXdahLyime6/LRZZY1NiK+kMwjfUFHz3ZxgSj8dpX3?=
 =?us-ascii?Q?a4aFb90YJecNpRGyFXK5JIPP7b5o3b/vat96dk1fd0XBmPRm41baC0lX1/8g?=
 =?us-ascii?Q?b/dxvoOuTKtJWxcKAhDhM69IPV1X73a2+a0nK7DtFATfwCs91dUttoLwJwqu?=
 =?us-ascii?Q?lQ3ap4GIrC2knU6AFwq4N7S2IeGg24fqpDtr3c9FGAvJhIbePZrBi8rHuXMQ?=
 =?us-ascii?Q?bCoUFVSQED71vHI89co=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 491d8759-74ff-4093-848c-08de05ca0737
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 17:50:39.7585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TT/Hn3tb0Jss0oKGEYUlQOXl+5foHgI0I9QqJrGAjclvf73FXWNveKG0x+ZyB47C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190

On Tue, Oct 07, 2025 at 01:10:30PM -0400, Pasha Tatashin wrote:
> 
> 1. Add three more callbacks to liveupdate_file_ops:
> /*
>  * Optional. Called by LUO during first get global state call.
>  * The handler should allocate/KHO preserve its global state object and return a
>  * pointer to it via 'obj'. It must also provide a u64 handle (e.g., a physical
>  * address of preserved memory) via 'data_handle' that LUO will save.
>  * Return: 0 on success.
>  */
> int (*global_state_create)(struct liveupdate_file_handler *h,
>                            void **obj, u64 *data_handle);
> 
> /*
>  * Optional. Called by LUO in the new kernel
>  * before the first access to the global state. The handler receives
>  * the preserved u64 data_handle and should use it to reconstruct its
>  * global state object, returning a pointer to it via 'obj'.
>  * Return: 0 on success.
>  */
> int (*global_state_restore)(struct liveupdate_file_handler *h,
>                             u64 data_handle, void **obj);

It shouldn't be a "push" like this. Everything has a certain logical point
when it will need the luo data, it should be coded to 'pull' the data
right at that point.


> /*
>  * Optional. Called by LUO after the last
>  * file for this handler is unpreserved or finished. The handler
>  * must free its global state object and any associated resources.
>  */
> void (*global_state_destroy)(struct liveupdate_file_handler *h, void *obj);

I'm not sure a callback here is a good idea, the users are synchronous
at early boot, they should get their data and immediately process it
within the context of the caller. A 'unpack' callback does not seem so
useful to me.

> The get/put global state data:
> 
> /* Get and lock the data with file_handler scoped lock */
> int liveupdate_fh_global_state_get(struct liveupdate_file_handler *h,
>                                    void **obj);
> 
> /* Unlock the data */
> void liveupdate_fh_global_state_put(struct liveupdate_file_handler *h);

Maybe lock/unlock if it is locking.

It seems like a good direction overall. Really need to see how it
works with some examples

Jason

