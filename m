Return-Path: <linux-fsdevel+bounces-63520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A81BBFEAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 03:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59B164E276E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 01:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141241F3B96;
	Tue,  7 Oct 2025 01:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VOk+rXiU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46EB129A78;
	Tue,  7 Oct 2025 01:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759799808; cv=fail; b=Zgt4ovyaE0l23HXSvaFe9znoahH+nNqMSLna+DQGEVLFgpIBQO0+U+4loQXx0kpp383aoaqVbeoWr5Lr/lCZrWUdmMYHgQxCnuVo3LPm+GRaTqjUyCYXAPRZmvdhvXOl2nal0bcImkMtwYl/nAykB1hKIHpv7T7u0/a0+ku9DLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759799808; c=relaxed/simple;
	bh=j7IyHduOlfYsrJRfUoVGvRO7M+58kNhjtSScY90UqHM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L2hfX8SQuCp1eXkWuYczFzjpzHu5AQ4ohbjEhgjAni45vI4Z0oTCxB7irpBtSRzY03wkRZWktln1Jkh5vqAYoLJe5kTrFk7zfpKeJsJjDxhscDbv8HfFfBA6wEXo3wbX7JremA1Fk2bnPfdwnset7k2jfQub9buHBD6KqyORZ5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VOk+rXiU; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759799806; x=1791335806;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=j7IyHduOlfYsrJRfUoVGvRO7M+58kNhjtSScY90UqHM=;
  b=VOk+rXiUsD2EgVFHUU4djPsBaXBNvy9ZHp1ovgj+qNZappXaGZFtl8DH
   2r4uAgevNkR+NbxYX9VCnMgnLJhW5nwYiQCfbuN8tZ4AX7x3o6n1PA6BN
   qjaOur4WLjQM/ajPdP/vQS93f4gZqZx6bzZbku1ReXn804EJzmR1Tn7ec
   3QU78kOKEGhI9clDkaYFDU7Q9izbPAeUS003UpfDjprYxkeqoJw8RlTRm
   FLxZeiwc2zZucAN9si3I24AKDhXhvRSrougMdBLVHNvlWfyW7YMgzs+d2
   bFpyQkSvWdGuDVBVHDIIR0Fuu+g6wgrmDP9NynqrcX4ntCieuTLyZ7e7A
   Q==;
X-CSE-ConnectionGUID: 9scHOURLQKO0ZXtCocFmTw==
X-CSE-MsgGUID: r18ePl5hTVSzSLG6CbE0nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="87445510"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="87445510"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 18:16:45 -0700
X-CSE-ConnectionGUID: 3/VcDlSCR929Zq3jNauoCQ==
X-CSE-MsgGUID: gpbOQwgeQXqF9xN1Xep3Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="217104705"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 18:16:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 18:16:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 18:16:43 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.56)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 18:16:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxypR4BRKR2e+enkq3dhjNHcVPwYP/6BhHDLmj6dyASVgC33x4sImXywDG4soM4Ocgi4PNRBZTZ+fX5PS+Ggx5VOdi/G82DidOBh98wiDgG4ce4HRa0IG/B5gq7HTHjl0u8+EctoNAJLGl0EOEyCMqQqkDovRceuD1klMeRJZPdNuWtSpapL1x5Bfik3JwfE1Y+ts7VYcGb3TYYMiiC43JTj7oh0sUA9dKJuGhrUllAfRVhkgRj5Ce3tsp2kfWly8evu/bjQl0Ffoe5C4kgWkJmptwJrcT7Ziy7JLXXk42KpSlMWhj4/yMaiCRykakcED9afkJD0PWOJrMaEEXi0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIdN3mXzo5R/PVPb3BzJDzY5kmZk9NNWBM+AASXVFB8=;
 b=M0h1p8b5lEAe2xHelO9WpGCMPTPw4NIw/wKfY69ZI0vHGWO12tUpy/FpzVc8Xzv2GG6ujZamodDyFYaoNgL52GjyLOA6y70n6b0uNdLsoEq38X2qjCPUQGz2YwEfZrAbJAGxkeToQCJkxo/bBSAvU5/wM3dFhZMRcM8RUrI1l+T09q3OJ2AxBzABMJX5dy2/uCU1qgwJG+3/+fUPDWgGJtvN1TGh9CoBltg0j+iPEzCG4orIPtO1j7VfJCqVc0hSwHncEUpKmKq53ZKqrvwsTd02FnXhPOkq9BBjf/1S+0wkNJyLOFfeyzJArKndEQAwP6AMJaUxNPWHs4Th6VDw+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH7PR11MB6860.namprd11.prod.outlook.com (2603:10b6:510:200::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 01:16:37 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%7]) with mapi id 15.20.9182.015; Tue, 7 Oct 2025
 01:16:36 +0000
Date: Mon, 6 Oct 2025 18:16:24 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, Matthew Wilcox
	<willy@infradead.org>, Jan Kara <jack@suse.cz>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@kernel.org>, Li Ming <ming.li@zohomail.com>, Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>, "Ying Huang" <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
	Greg KH <gregkh@linuxfoundation.org>, Nathan Fontenot
	<nathan.fontenot@amd.com>, Terry Bowman <terry.bowman@amd.com>, Robert
 Richter <rrichter@amd.com>, Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Zhijian Li <lizhijian@fujitsu.com>, "Borislav Petkov" <bp@alien8.de>, Ard
 Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3 0/5] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL
Message-ID: <aORp6MpbPMIamNBh@aschofie-mobl2.lan>
References: <20250930044757.214798-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250930044757.214798-1-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4PR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:303:8d::13) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH7PR11MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6cb2e3-063e-4a24-e192-08de053f28ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lWaTJ+k2wg2RHbcY7vl7WJcmtR1O3SWutO1G5joMR0aT/P7pCd2n0WoxJHyN?=
 =?us-ascii?Q?2PBWu941YNSe/f6xxcNjXRCf+9/B1gfj2e6ubRLoR8OCI+jWIL2X5VfI496B?=
 =?us-ascii?Q?BENzs0SFywUUNHNnBQXgMSJ0lIiDDrr3/DC/3azH4o79KvOU4uDdFoMMGDIn?=
 =?us-ascii?Q?FY2xjccveZHOUMk6wmNvcU5aFlnVk1UhE3SjlpXf2EflAPuIsFtZ2d6xmbjp?=
 =?us-ascii?Q?giAls2OvVAZJdLLlVv297i9yn3rhCwS7Z+RnF9hN3tHXiLof6balwsQGgUOi?=
 =?us-ascii?Q?mr0cqTObBst13wwfqO2jy9Px69NZziXD9YzV4eH/9iq8XBU1vB4if2DiB9FG?=
 =?us-ascii?Q?sNLawqnBJwIQVBzhK4dMUVD3MZyDlmBWEZwd3yEMOsmglc9PgFTeIFxbHtzL?=
 =?us-ascii?Q?QMTnZJ+0iBUX5A0KSiZB/t7L+xTWyYc7CPZ3nDhxGDGP8Rs9/R3JpZz8Yb2h?=
 =?us-ascii?Q?fiZJzMefPyS/Wc9fZdf6BHi+iSbFAb59mQsS5cAvdma6OfBG3PWSgJJlCTB4?=
 =?us-ascii?Q?wbc0+yAa9Y52R5WE9rsRL7BYAAekTYa4sJ6P3vNiuuTOJafMT7S0pcatc9JP?=
 =?us-ascii?Q?hFjauZOSSRUTuq0YzRxKPi94zZM2h+HLkXxhGSPXsXEQ7jQITqJEZKPL+Eb9?=
 =?us-ascii?Q?BnferhWoHsYtuRZVmeLwf4+w6rekbMwV+fk0wSC9yPpoaQl6+QK36vKlcwqU?=
 =?us-ascii?Q?GmqcBk8B4lpSPCw7h1aBYvTcUhzn5nHWTY2SmBo60o07dRvRt4greOQ5D8fO?=
 =?us-ascii?Q?Za5E8JWBJk0wnomlmoCWXyPfunskMmXHAh+1qe+XlSWcfCe2gMXZ6D2HqQ4N?=
 =?us-ascii?Q?tM9oKRZnyJzrJpVRjU/8IHUqZEdGxsM7vANcW8VGMXmdjI3yl4x+3dU6zXWx?=
 =?us-ascii?Q?77hCCuh1Sw7P6GuA5ItgLkIybHPXI+s5JB6KjeALII7sfvxkE5zHBzMVU2YE?=
 =?us-ascii?Q?luOMyo//lYxQkQCA+JLOsI/dfPb7eeu/G42LCUjygX7ArwJU+ESZ4/g39hop?=
 =?us-ascii?Q?b/fjOd2fkMp7f3bBtwZVHPPvn+ankUm6IxK6ihWu9zNGxGJbjPl1rjORSMWw?=
 =?us-ascii?Q?9LFioWUZTcJLln6v84lmfCfsTXwEPoX9lyf+qz7v27GpX8usbYZHQ3jtCHJ9?=
 =?us-ascii?Q?G1NmGJtozpahWpMgKuwIzJ+/9i22DqdVy7OwO9kLJhwpRVDD75W/1o9Q6f0c?=
 =?us-ascii?Q?icrZGzt9xJ5/YaYk7Bujwk3g6mwVlKlDLh2AiQL8UifaLBi4ubiIv2K00PR+?=
 =?us-ascii?Q?IrG6irB8kvrNP9C1eR7X+ZGNcCpy2U0M8ZJgM6/jk1sl++TXKQf/s1mIbXlo?=
 =?us-ascii?Q?Agy2JcrbTOviwUk1JUyUr0U6Pd0jKHk7dhecu6PE0p1rBU7+tB0SUZVl2bRV?=
 =?us-ascii?Q?5GG9nSHuxG1i7kHi7bNwpkC3UrbEsO1iyNxkdGYEJ8MXjcDW/QMzQzCYjtDp?=
 =?us-ascii?Q?smZXXQCLEa7F+4tOdm75H3YxPCnlPlLK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5QFtZX9EaRdrGSQ/jIrhXgGcDiriq169gFVFD35mZX6BIvnRHEIbAkfLnp8z?=
 =?us-ascii?Q?ZaC5bBXB7AuMMES0yU2NRBy3HWRV3dirHVrMabTp9n8cMU59Wb/EQo9PoiEv?=
 =?us-ascii?Q?zO1mufy/xCTrZYldWDagkMHB3zj3hzl2LT0l/kXreoRSOoItb0Vxn/VK+eyZ?=
 =?us-ascii?Q?qK7QfTB9zNv6yHVFPIyFmyQvkNv8KCgK6aPCdsRcPtIhzaWDoWeqCKKMZuTE?=
 =?us-ascii?Q?j71IaCZLTgloMzkxhuOM2TA+nlHgjr7xnDNFLmk4kt4eftL7+P2nmIiRdNme?=
 =?us-ascii?Q?OHLVy+5nzV2M8EGDVbgmu0BWeh/wxyUUATa6KZUnMJDDdxr3c8dgx4oEc/LF?=
 =?us-ascii?Q?yEq2CGnVajIBk6kTkOiDdpKy966Qijj1Q++RYiSJzvhxeLPHaAli3hd3M+hP?=
 =?us-ascii?Q?OLt9BqXJOys+QZOim8E9/kzBjr3C1ddbgh7DVRNzLlQvTdD0GOWYL1Y/b8yc?=
 =?us-ascii?Q?1418mWMF4yN9Glqs9Ont8RlC4B1jhneBFVSkQEFP8/KPXkWK9PWMM3YJAeks?=
 =?us-ascii?Q?VgCQIqZ+X6w9t1wd79QkaKCbjmbNG1lxZiPjiiBTB7V+ScAUG9qVToXqsE4m?=
 =?us-ascii?Q?0DKVNZe8py+kAX5F4S1Ao2SVlxGDbOnkldM/Wr7GpWCnOewDKd2/XGFr0rEG?=
 =?us-ascii?Q?o32E6juGjaf6/iYNyeeL88hALyU/o5QonNS4ytaLlWV657tbBuhqxgx92iaO?=
 =?us-ascii?Q?eBtEk1gxZuOAUhqEbGVbsNxbxeCUhyvV9LEyRnhCES/HUtxKZ8fuohcmpjhC?=
 =?us-ascii?Q?FjeLyJeHmSdSf6LX6MymFsM1JukHNX55wxDAPEP4itYPO0SCTQgYrtRFvKak?=
 =?us-ascii?Q?IBYwvpJ9C2IrGWocxANEDXBBKSoyFAuijoNa48tn6h1c1NRB8yHUq9rUKy+v?=
 =?us-ascii?Q?z8o241jbkPj1nEg6v6TW6V+vntyUruol1B+9YQxR5xH9tKUXjqhIC1JxSLuP?=
 =?us-ascii?Q?xzYGSRLK0aaIMLj3rJzi4rxxR4Pt4eN24duBVzaCdrTfTbOrY/QsxSzw+BjC?=
 =?us-ascii?Q?f+TC9XrHS5CGUllHJMeBm9XuQCj49CMDKHiRbgSoRxtzTLPrc/IRa99TK5gH?=
 =?us-ascii?Q?Dfw0xHO4jeio2luxlBdQ3RmAOSD+wD3CrPFx01w4zQbKxbg5/PNdrvje9rfd?=
 =?us-ascii?Q?Ri0h+Xx+349PhUDKUOtzneElBbZhdfojaseZgUngdP4V+gcsc9XEPb2LG4Qf?=
 =?us-ascii?Q?m89JFxkwLxqb/tvhbOo5ZFr+duAeSoPOGzNs1jT1LGio/9KgxYsLNqbPCSZq?=
 =?us-ascii?Q?NOffQcMKGZsi0sdTf8toqT2sIbhIILhKcyLHfKWMjHNd1JZtV91OsRzwa47N?=
 =?us-ascii?Q?B26CKxcQW3bHJwzLdoOBoBCclnsYfAhtr4835bHIu+NvyPctvZ5pF91gwQHc?=
 =?us-ascii?Q?0h45G+Vf5v4lqt1bmVPIn2whY2UpI/cp2MKaGOrfbfytFVGmDAb6qKHiz16F?=
 =?us-ascii?Q?Xct5YzjHk+b2P/R0PZWMx8NX/k3DGpEpCjZHU/3TtZO6p+EDkFTW13Wov3fD?=
 =?us-ascii?Q?3WLuzn5LzyszhpLU4XWvFo2bCU/fEjjD/glefQxA74RwOW0vQLIJxV8RD6mN?=
 =?us-ascii?Q?qiECCQq7+rM+S+WJ2MGPpN2o3BlpT3oiQvDKeu/22GGtmF0f+VI0pE1WVqcj?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6cb2e3-063e-4a24-e192-08de053f28ff
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 01:16:36.6478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5XjlUcsYtF9TdW+UwdICo8W/ddn+wFbzbnYxjYxCm9O5XC9o24phsctcMlkIfidmwc9PVsZlQJSI5dn9oELIy+ysjLyq5bOr2UjNjQWpZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6860
X-OriginatorOrg: intel.com

On Tue, Sep 30, 2025 at 04:47:52AM +0000, Smita Koralahalli wrote:
> This series aims to address long-standing conflicts between dax_hmem and
> CXL when handling Soft Reserved memory ranges.

Hi Smita,

Thanks for the updates Smita!

About those "long-standing conflicts": In the next rev, can you resurrect,
or recreate the issues list that this set is addressing. It's been a
long and winding road with several handoffs (me included) and it'll help
keep the focus.

Hotplug works :)  Auto region comes up, we tear it down and can recreate it,
in place, because the soft reserved resource is gone (no longer occupying
the CXL Window and causing recreate to fail.)

!CONFIG_CXL_REGION works :) All resources go directly to DAX.

The scenario that is failing is handoff to DAX after region assembly
failure. (Dan reminded me to check that today.) That is mostly related
to Patch4, so I'll respond there.

--Alison


