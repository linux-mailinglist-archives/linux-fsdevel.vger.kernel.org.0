Return-Path: <linux-fsdevel+bounces-72680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7079CFF9D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 20:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13F4533B78ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 18:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525CA364047;
	Wed,  7 Jan 2026 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MX9HaaIl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2379A3612DD;
	Wed,  7 Jan 2026 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767810443; cv=fail; b=Xzxa+751c+dI+BeAIriOG6qvKeEClCae6XfWNS4warfC3WCecbIJmoFHuhjF3DCrngDvR32DNYGLrMCTNNZcsjqlrIa+GY/K+XxYingYe3DwP83Vj6REHep0lHwmz7J6PRXIH4uwP8GSf7oP/+lHZubQooZpDgk3ZwXH5vV4zSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767810443; c=relaxed/simple;
	bh=SU3Vfyf/kj5++OCHCe6lc0icxkN7Xsi/OmumvG+R5Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sMLS+qjivV1pvcz5ve/+4EdagEU0RpX8HZUJ/Jo2JNwXtclUYLLUWniksFgDfex5AXTk4019YQLR26L43lftawS0NQ32Aw5Ah/96fCGCOG6xPN6HeTinHDQy8BPWMGIVtj7l+3pDo2tP/H00X4QX2ugU57Ad4SG0Rn4mWVLOBps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MX9HaaIl; arc=fail smtp.client-ip=52.101.52.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0A8W5jDn++2945ljVBVUwHKGKR+ZXv03t/iqP9EjqgDh8DIBiTLi7jeu+OXVvLAz9HYeuWXe39r8ijQ2KQ0bxX4Z6VFPS8HElFtzfYVkoS9Bn39PnemtBygYjpxRMyHwjaESxmotPIdsGDiZ4HG+v5DbIj3V1VIaHg3pxBDO5eSX0lnD+VIVPiZClf8iYhPzqt4nXEvRNI3aQ4cveQw5yY6MkiNnjXf2Yjq8ZRUt509wnijmuIpCvnbDKwjR3Lmt1tL+3xouefAGx4l2H+oS16qXl5+C5Ysf9Fo5FV2ChsOl7ZqsGer4ixmGNBdpvALekI4S60X55OOhKYNOUGEtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlTxAEJHUEicfVZZEBbyPoeN1GAzTGru/WcwXmhLEGc=;
 b=SinFwUD+IzTypSYDeWu9epHBDWTNh4DrI0TMhMIogWtyfsdNJqZi3ZzdQVAMYIcVHcEzlt2cLcisGcLI83iLpwULV+mWjcbK3iInlu16Gl77vJehnx3BNL8G+sioHR3trevK4/izkv1f5XR9RmBCenq/txQl0ytG49nJyfvxzZ2mCRpYvTT+atdPrcpLHu2VnZsCSQ2Vqbp2cFKmytRRpSUcMHdjihaI8+fRSuTYHmDuMkwg54OOK4062IT87nJWmuz5lIOTZd6T4QhbdVHvOa7TETIcy7MyZrBoO/9KazzcywG6YjAIMyT65U61iUtDmapk2WROXLd+lwLcWD/YOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlTxAEJHUEicfVZZEBbyPoeN1GAzTGru/WcwXmhLEGc=;
 b=MX9HaaIlNcOl0Qg58NGNBn0f9KVFQJhp2iV5g2z3GWT1MpOZRB7Q5aSG5kqw/JfGAGtj54Pz2qvuC4klji27lv2lv6pTyXU2zW9FWzECxCWbTbnfDUR3H1s7rrPDP0KJV2HiqKeNK+WM388GjKTk6Lizp8PtWwAjRDBb6Ox0mGMZLUs6asf5C7DX9iS5LoHwhQv5aW1B5m39GqMM+5NkHM3T23DZTWldA6Pi0CjCupUnD5uiKYnhAWOEyYrvE93dqsHI+fl9JtJqTy6fYvfJ937s8KoF7gQQR2dAwu2YBisky086n6kGHmr1yInrM1mCns5uXT8jcpEQKR9J7SBEIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB6776.namprd12.prod.outlook.com (2603:10b6:806:25b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 18:27:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 18:27:15 +0000
Date: Wed, 7 Jan 2026 14:27:13 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	rppt@kernel.org, dmatlack@google.com, rientjes@google.com,
	corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
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
	chrisl@kernel.org
Subject: Re: [PATCH v8 05/18] liveupdate: luo_core: add user interface
Message-ID: <20260107182713.GF293394@nvidia.com>
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
 <20251125165850.3389713-6-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125165850.3389713-6-pasha.tatashin@soleen.com>
X-ClientProxiedBy: MN2PR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:208:239::32) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: 419183b1-4c3f-4484-2ba2-08de4e1a6177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sX8hIA3FEPIXFZyUs96y0rs5xzjVcykzqtgiygmiaM9biw+kwWtnbck/LEhL?=
 =?us-ascii?Q?baSTh5an6nV4EEJLvuIJGzBiMwodwRp97OPuxEJp4qbq1Kqbr4aTvH78eIGQ?=
 =?us-ascii?Q?nZDSwLLkVnioVEh68UTGuQKfqpBlPUfMk8imyWagmQ4Gk62iFaHjMUZUxn6G?=
 =?us-ascii?Q?pMRENSWa7fAggdO6LK3e3B00+WjlFsx+A7cmdxYabNl53UlirRoI18/BzF4C?=
 =?us-ascii?Q?OmQuIEsv4TmxR9kNsR3HZHa3Gj73XOj4bo1Uuff7UO4ouGBiGIxYbFX+P5Ku?=
 =?us-ascii?Q?nJp7HbF0ukDmMRQAM0s/STLuvimBKhuW2l+OTKqMOWlb6Bpm8fQ8NG2rFPkb?=
 =?us-ascii?Q?gvPsmIMl4q7J5LnGPKGtsInOzyry+UFQoEQTpeHweWAhcefSv7T5LrtHo/i7?=
 =?us-ascii?Q?xfQavRJC4zKcqMPAXCvTXaFaURJeQaiU5n2laQGvF1STViXX7N/imIeUYokS?=
 =?us-ascii?Q?pcRogIhraya+LY9X+N+PTMg9S/A/YuH/b4EYGgjTuf7IeZo8n6UTMXT7nstV?=
 =?us-ascii?Q?bKuG3+VG6Wc1s7fqVHxLusX67ra6r6IrDtYcOMgVzDjTrgRjNoNeKxsO2L6g?=
 =?us-ascii?Q?xT7lOTjRd4MLzaETItjx6G04dVZT8Ntf1whOAkwqg9746Qm38oY7dQYTDdXm?=
 =?us-ascii?Q?90oA4ixspn8b046WiL2eHwPwhc15zf5XmU2xg4Q5swvlIk6BWOIGd0qn6090?=
 =?us-ascii?Q?UFOZFf0Qly1jUlYmXVwpf5nJHXm+FQKw9hXCbp8i5BWu8nGwqkp8xn7iNme1?=
 =?us-ascii?Q?Rm6awp2j9mvbVqNw9RjJbcGcuf1abFtsmv7KEPIFtTUR69AhWNaAXBYLE8rG?=
 =?us-ascii?Q?8eKkwu6YVUZITobEJhn9wq2R8fNJb/E7K/miD/32F/4uI59RwrHgD1hS6ZNi?=
 =?us-ascii?Q?KnlrSbymuVstg6F59yF8L5CFWWxbnyJZIHxTuAT4RMZ/oIEp3HOqgJ8y/lTD?=
 =?us-ascii?Q?oQiAuHeziy1eaBB4c8gpvVW2W3v/J8xaIWuQetF7bCDEua9eMX+UTPhWLkc/?=
 =?us-ascii?Q?DsY5JWi2SYytWCVjp1GZuvMQN82iaiJBYas0y03esyqxVCmL1QwFFba7psXi?=
 =?us-ascii?Q?Xq+8Y6tuqWnclpJWSomW+ni9rXvah/TXD7Si+UazWfmRqCF3NNQqJHeEqth4?=
 =?us-ascii?Q?ZN5xU9CMhNfWcFmU7hVEPjUSwZZqGFm9RQszTdUZOM6YM2Lscn3XxaEaQf2+?=
 =?us-ascii?Q?p45vzseL/BNw1wUOTZsynn58L/RjLDe1CeHInZXULaUHw3amKwiQ5hIW7C8r?=
 =?us-ascii?Q?Wb2ItTInhGwWE8iZzWLGR0aJTAcyiEdL9QKvIIpTkV+an/MC+l2klw56olvV?=
 =?us-ascii?Q?d34h+VYbBpA3GK7TikTBBMjqqCOA0qIG/kTd42TnUhCjCKvovwjfxaLIzTNF?=
 =?us-ascii?Q?UnSP3FVCL606LcyBVncOmFChs/EEaTEFzKj83Qx0GX85JfkX0onFrWAiUy5h?=
 =?us-ascii?Q?HUptPD0nnu2CV/iBo6Y1P1bwPhrlcLNK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LK6MNhOZm/wWdJL9n35isxBorR1eIEOR/9b+WMb4O3KpE2RhLT6x3rSMk5oJ?=
 =?us-ascii?Q?VSDqayAxksnjV7+01UzHajGigTL0CgI76tbvr6nQCsIwRODWHyD20JevAkG/?=
 =?us-ascii?Q?IZuFz/7HxiYTetE9NkqfCtw3YfatGf/TU87vRjA7Ez2JXjo09yrxmFgGEnvR?=
 =?us-ascii?Q?2ghGQAEGCWcsDrIJyQBTdldDufYmrl8qwbauNbhmFwe8WHcDq9EJIqODXkCt?=
 =?us-ascii?Q?qu+jrceVqg5N9wHxjMKBmqYInD6NLKC6Ncb+2H2EiQ7wAuMBl/+MRs7ZieL7?=
 =?us-ascii?Q?eM0M8ibhiDWhe6HZiYoYnoadxnJ9jmOEarN7m0pW50m5BaGxkhPQfv2V76XP?=
 =?us-ascii?Q?RTHv3fc7PEk1qVEe7Vf1ShhqZzZWpwvj0awKBXPRYNsWuRmWxaVOtSqhnZKG?=
 =?us-ascii?Q?JXVUXc/J5aHe0Fv3r+BUNdIsm1nxPkoGPuJWuVTP698lJJs43boC5WMAM4UK?=
 =?us-ascii?Q?+asLs4OAtAEfFlbt5B/c86Dky8Emgg1X2xUGIvpXGjNcynhp4np2pgZNExQl?=
 =?us-ascii?Q?HDpX3bkPl0ffzktaJsrWe0Xa++XIpO4jhVwo9mvOpEqe10reg+P+BWIKQLko?=
 =?us-ascii?Q?WI6WwdPV8wq/xRFUxkai1qQMBUOfSKSYY4JcVlbN17yuNGsXp/6dbALGAFGB?=
 =?us-ascii?Q?mXh3mjnlKKZJ+bQChoFty7sl0l9OSodf/rJLI1zdZeX344kCfZTG5T3zLGvu?=
 =?us-ascii?Q?FjAcRb9pvMvyb8PetJsITbCuxQ9GypdTXHl+PY+9HhOok6gE5EZ72tfPxtcC?=
 =?us-ascii?Q?cy1Glw+Fsb2hxQT2xADj+hHReX7+0cg7t8pg0jRZjiBXd3kMCDBjnR8VIfKQ?=
 =?us-ascii?Q?IuaT8q6aY7nzm/h2nQAhPvwEizC7Hq5FnpjpmHTIiFZPITSV5iE51RZlZO9k?=
 =?us-ascii?Q?i4QGEaO428wpI+jIcKPIelnilVcfb42gtMoRPMgfm/FXsEeWNccXUfB+DEsn?=
 =?us-ascii?Q?TUcNX30R4YWCpJ9R7znQDlvuHk4/04CJ7Xt7C8S94OIupfI71FPMpqttlKlC?=
 =?us-ascii?Q?Oz/aYkhWq2YD/+MjVVDQzrF1szx+jS3qYJd2DL/wV/vLITFZlzJCbGRf4vRY?=
 =?us-ascii?Q?DUmpfBEueQBIaurlmraY5ejxn6WAKmpkv73VkVftDSg0jAvxZbhs/DeOMWLe?=
 =?us-ascii?Q?9yPNqIMSHeiKlWubfVJE91kFBf4ead1qOPUbwN8cHKQctYOqCu8DAlca+xzq?=
 =?us-ascii?Q?BYwulLey4a87L+iwrhpbSLNu3QcOTq1ihGWsaA4zM0ZinmW0HfQOgM5IcbAs?=
 =?us-ascii?Q?zjcublHhnoDOOEQWw/SJJI2x1l0iMeUzwgrnzgdqxeyaE8MYTnh9qlEil467?=
 =?us-ascii?Q?27sZF+QcKcGxhv0C340geSk5fsnnDM+LCs4/o8ipKVh89IapYr0IPJlF+BIz?=
 =?us-ascii?Q?Z/gf2snhsqHF6wvImKWHgpsp+KbRLSRhkKHz4Iu59FLNQvhzkSvZb+aLdCzy?=
 =?us-ascii?Q?Gc0NMtzEBbpBeRou0+XJZRn1H++MD1lORXlXhHvhRRJ4tDVMPDYtPZW3QTPy?=
 =?us-ascii?Q?xwrRrY+YrX4GPdtBOJTbDNP4LtbYSGuHxAo+CXEKXvasqi0zyZAb9Z7VTQUN?=
 =?us-ascii?Q?1zWWLFNI1+gFECzkQ4BX1b7CxflwCNXttaRToP1qsYNyhetNSAPMsQ04dxu5?=
 =?us-ascii?Q?VfRjKlkILyXAR7FPFUoZZeJTsO2wUCNE81MSAbV4APRUFxTXZ8cdCywdmsau?=
 =?us-ascii?Q?01r1xrm3BxKjR4krl9Gw8Rnaf56NTs9vybsbALqpKsWFQ6C05b+VfLzsKGWM?=
 =?us-ascii?Q?D5c8Zw9BfA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 419183b1-4c3f-4484-2ba2-08de4e1a6177
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 18:27:15.1434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghifGatE5dOtmxaW6JrWo8GJrIsE4r6Kz9CNYZ0d3E5G/qKQZS7UVBN+VaVOxlUY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6776

On Tue, Nov 25, 2025 at 11:58:35AM -0500, Pasha Tatashin wrote:
> +struct liveupdate_ioctl_create_session {
> +	__u32		size;
> +	__s32		fd;
> +	__u8		name[LIVEUPDATE_SESSION_NAME_LENGTH];
> +};

IMHO I would use

 __u32 name_len;
 __u32 reserved;
 __aligned_u64 name_uptr;

And then have the kernel copy_from_user() the name into kernel
memory. That way you avoid making LIVEUPDATE_SESSION_NAME_LENGTH into
strict ABI.

I have also been marking the output members with out_, so:

	__s32		out_fd;

for example

Jason

