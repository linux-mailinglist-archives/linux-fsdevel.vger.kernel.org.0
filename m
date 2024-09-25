Return-Path: <linux-fsdevel+bounces-30020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 614A1984F69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 02:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84AF51C21014
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 00:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03066DDD9;
	Wed, 25 Sep 2024 00:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wh0owYJv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB807483;
	Wed, 25 Sep 2024 00:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727223435; cv=fail; b=Va1PxzIxhvz/BOV12RbiU2dFYjCGVjWRv+Q7Rl8geQfjkFH0XxTBA0R3kuaBjSAOjnsk9Ss1vDvKM7JTXyUht8FtAK92JOfnH/9EYJ7ODmic8nT2MvIDo6/dZEtfapANQ+3mm//iOJTSt/+fuiinFIP9F2Cm35CLbKdhob5e1hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727223435; c=relaxed/simple;
	bh=GJUX1tDgZccI3gDUkLY42AH2sufdAK+FPRo0xE6yNQY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pj/4opOWCaJMs94sIWSmAaFavjDuQ/H/yCDF2cZ8G9l4LhLh4lYJzilSfA2aiSriNI7Tak2DXExpFnMQB2tonsjtmsZO5BSCa7NeUe6QpMaa+Dby69RdFLM6DciN68ln08S42IJg1nIpEsVKLGeM6H19tp1ByA9sS3gImyWmaFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wh0owYJv; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727223432; x=1758759432;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GJUX1tDgZccI3gDUkLY42AH2sufdAK+FPRo0xE6yNQY=;
  b=Wh0owYJvEgPxctQOvKRutq0SpAHsNle9POdzfFto4Hobut9OQQxJ+3Ui
   6l1Vu0oHpmDizhNsuAhtAOsXlXTHWP5kToSSfYvKDp2B+pazPk4Nm2CUP
   kmpOzvh1DGSFB22JA9EWf3/tl1emOoapd24v0iR7LQQJCjZNiEUwiEUZa
   7ZaMw+ck8lllPQhgiMM9BcrsnyKyaDnc7J4jWZsxhlUoOMoyWY5smG4g1
   AAUNipPclaCEH/paQ44N3ZEOU7he5QW+/4nZVDsR4hSriaOF3c01X6lt2
   IiNi3yZiDGNIPpE2+bjUXcB+KYhBeQZwSydCrP0s7B1YLyd0JfVE5xv3v
   A==;
X-CSE-ConnectionGUID: rGfPyGs8Qo2qM66KwoZJIQ==
X-CSE-MsgGUID: rW/uhMKNR6iyY4HGVcqOdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26373595"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="26373595"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 17:17:11 -0700
X-CSE-ConnectionGUID: GuXdUZiLTY+5rUDKPPSNeQ==
X-CSE-MsgGUID: N1BIjOjQRcSvloMewWHNfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="102412223"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 17:17:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 17:17:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 17:17:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 17:17:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfrG4ZA7RoUUzvsM3MxjPJcr0SMNZNq9NwafSdfRxTUekph+YH6nGKm6Ph5qrouXj6f2SBi5qkOepFQ5KA4ODgQfASXuPsOga1qpYtFRxlpxL/n2PSR8rlehOi9x7QSmw3s0MrjmWR60mqtB9ZOYAXhOvZdcLA9AN0nlaSUN2WspEVBToeI6vKUR/fRQfW4d3TzTmPeBTfNbAtzL75tP7+pVxenUTuH3hxaBQJvGbWO65D/qmxZjkpn9FA5WXV2bep9HNw17IuAyCc58fr/BEV3VDFMg7RGxQY/8ODUr0relb/RVpGgbKAiJuyrxOqkWWz60dVFHm/LcyzHO/TDYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xxti1EliHpWziCeoLvCXgN7zfMCyYcvZ1HLt9sZbgwA=;
 b=rWwfwEibr3didVbD+zB7GW7EzzcrEVufJ4EYewRcXqO3jziAqcNABDfh2+lK8vyFF2BJz0N39Ht9iyh9PPTHkoeWvKG/04voec6f6MvujCDan8bPxOhiVozjZRnOP9KQFqWmSWb9/T7EMUXrNPmT7Bl/NQUZxUAwT/XkUn2LBTfhHfV5QFppx6vvd/Fjx1YCO0pKmzN2whkDh0jyHvkzO/dYkZp7nc1+indNsa9k0t7fsndwxTd2lqHUG7Kp7zMm2uQMWr8UWqkk9tUicFJEJMPnqX+HqN654Gi8zU/BIXcubHBK5i6iUmyBVjLIoK/ci6yJHcrdkj3K+BYFovk36g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB7096.namprd11.prod.outlook.com (2603:10b6:510:214::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Wed, 25 Sep
 2024 00:17:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%7]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 00:17:07 +0000
Date: Tue, 24 Sep 2024 17:17:03 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <dan.j.williams@intel.com>,
	<linux-mm@kvack.org>
CC: Alistair Popple <apopple@nvidia.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <logang@deltatee.com>, <bhelgaas@google.com>,
	<jack@suse.cz>, <jgg@ziepe.ca>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <willy@infradead.org>, <djwong@kernel.org>,
	<tytso@mit.edu>, <linmiaohe@huawei.com>, <david@redhat.com>,
	<peterx@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxppc-dev@lists.ozlabs.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<jhubbard@nvidia.com>, <hch@lst.de>, <david@fromorbit.com>
Subject: Re: [PATCH 08/12] gup: Don't allow FOLL_LONGTERM pinning of FS DAX
 pages
Message-ID: <66f3567f76762_2a7f29441@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <78b49fc7e0302be282b4fcbd3f71fa4ae38e2d5f.1725941415.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <78b49fc7e0302be282b4fcbd3f71fa4ae38e2d5f.1725941415.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:303:6b::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c78880-c113-4cee-ea98-08dcdcf7643a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pHFDg1iCoOwwjYWaordOtr+oILDC8TY1URxQuzabUgg9vNPT3P5t0LnRQXdO?=
 =?us-ascii?Q?yBF6+8q5OZaSbSWpXEzSpUH97zwtYNfbRxEi76P29xomNbdL+P22svuK4EX1?=
 =?us-ascii?Q?N088UPpGo/Ll/ReOvtEA+4vRVUVSTTHEcjS00J3yMOaOcRhn1lN920gH+tfu?=
 =?us-ascii?Q?6sukLE+8qfpeWpbtnyT4RaOm9XhEU1IdHRANfFod0Z7/6vHDfJQGUs3d+JDX?=
 =?us-ascii?Q?MxFHgURq0ar4/j5PkWQ2zIUZ25mrKw3h+LTqFjsYryAZCfgtQvEtcWBIszrF?=
 =?us-ascii?Q?VMPjC3ASX5051wO9jxMExiBlrWSAaHmfcsK8wq4krXnZGsrKXDdX97TUIepT?=
 =?us-ascii?Q?nHqSA3st+oH/wlHKbd1NCX1bRBaYdJnke0xyNj4+xiRafnp0Vpp+dB4uKWeD?=
 =?us-ascii?Q?QBqqHNQBBMECD749sX1E1dTr+DrNqgDcgMCcIrvPKWbyKR7jpMFniMh5kBBJ?=
 =?us-ascii?Q?861fHorjr8YlbQ8sUJuPttRhjGEJw2NlmO897syPfC7kniahqVyhc2vAnK2n?=
 =?us-ascii?Q?/AhiGm2aCp078MRQC1qvLXVXtdf2j/85I2bDOfCqLakCqC7Yo/lSI90f4Hm/?=
 =?us-ascii?Q?ONzNJVcSSWZqb91RMLbk18iir6n9JozPBNnYaaqVwq/QbVlnxEm7a8uq4XeV?=
 =?us-ascii?Q?Z8PK7jceAujDnIsh+f8YVY9UXfUOj4Zjm68S+FrNK5nLQ4VxYCW7VRLHNSPn?=
 =?us-ascii?Q?yR9aFrWWI7Wsst6g1BYEnhNle4wt1Q4vlpEJhTnxOqVYXSJ66ERlqa2dFyeI?=
 =?us-ascii?Q?8cmcPylx3fR43lRB65qE1cJoPALTpxrMxMw+mrNmV9y0x5UpEenZB1Hl2YBX?=
 =?us-ascii?Q?7llnye7EoILLyGMVFDqsSjGsF7RhwIItch1dawfakLkP5hz+1rpHJqvDMYVA?=
 =?us-ascii?Q?dmL8tw+MDvmSs2Nq4b98ctsqBG7vuQeCK3LiyODKPSIQjrWL1M1c2mKZumb+?=
 =?us-ascii?Q?cWnT9HhYc7fN9Ugd37OnWSDSCEdZgjzsfoRi6STV6qu/eX/BlLILdVzrlLxg?=
 =?us-ascii?Q?22kGggoErfS949Ihhk9wDAKp9/hs/n/HmLlNIgJds075ynpVF7WwAJTqsdmZ?=
 =?us-ascii?Q?5MJeUXp5Kd5UQNKFK8r5YyaXtCNSqItPT8Zde+jOrVDku1OYir+yxDG9dKU/?=
 =?us-ascii?Q?L71D/D/dSw8DJUKw+5+mID1Q3itFBEaqdGvvcTz+n2AEz+hAGzUCw35Cu3X5?=
 =?us-ascii?Q?1jd4EHofG4fcwYEHPchHZjjusmc71cwufGc7WxH99d2QI1KhkbUnRmFKViW/?=
 =?us-ascii?Q?rjt/f2vZq5iRSuibn4msf0XaYcLQwrWZF8DtgK2Cjg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hWAMbR9t/89CJUQIotnGN8cHSlPEsi2ha9pkghPHoJGd6Ndc8ay9HCK8uNez?=
 =?us-ascii?Q?tcBqZSZwj3XQpKMDQ7g8mxYPJJzeoeSKizE/XZ5YNrjHKPflX2569g5RKd0U?=
 =?us-ascii?Q?3r0ZThKbuQ+CBU3/7p4r6CVY3LIoOSuTdzZgpyaCroO7l9mznl+5uNgmVi1z?=
 =?us-ascii?Q?yACaUcxmUSqBp6z9J/xWb10BvKJzlJQTiiXNiPz5pj/t8wIT7pAHBvLCwqJT?=
 =?us-ascii?Q?B42v5c1o5Wi1q3a/Vq9hC3RLQEutzmWeLB6qx1j+Weclnue0Rumg/WuFtU3l?=
 =?us-ascii?Q?TLhR5pWj10fWAkW2NzYWT0gf4B8nwGjDQ6sOOe+3JF985i40aSxNbptbNCQ/?=
 =?us-ascii?Q?AVoKl2UgNAFc1xjWRebkgxWizNHiowwednUIxgmqTUM2K6Ski4dAxCBGe2fB?=
 =?us-ascii?Q?DKlBIy4hwDIY6pRsv7B23EyTUMHhzAQ2+FDtsZV0A+0gWVQqZc1bt3OEMlss?=
 =?us-ascii?Q?Vm7jpn2PL2iUMts5yKcacnWOxgYxzdkguz4xpw0eTC//iur0XFbwKtiAhdOn?=
 =?us-ascii?Q?vnOAT8aVZr+KixL0vfVXD5eN1ZS0rUma5bs1+QemZkRu//Vpe+/BT41OTEGq?=
 =?us-ascii?Q?Ab/8qW7DHaK4BZffSwTcZH4aBMJg5yCO/TLggyRUBvSU9+KOojR5XnbZ9qvU?=
 =?us-ascii?Q?4vO31Q4VbRw4trMD/RzbJgV8EggAsdClrwQXqDHXepkdJaJwjOyu4AXiJ91c?=
 =?us-ascii?Q?qGOJWxbYtqyQ9GdemKDsb3If/xV7KOFazOiM4Ek/xlN0vtR4/HpVJrRrdsmi?=
 =?us-ascii?Q?0vbzAZe4Be21s8agx4HYx2V9aJJU+K/btZb3PemhJlCMEwNoBNtWSP3HnL83?=
 =?us-ascii?Q?fIdwnw67hWJskwS5Z/pk6n35JhjD6xx8VkdrjrPN3ybh3ObmxcolvIkekbMV?=
 =?us-ascii?Q?McGtiqh1r17yT3sWhDeGjlSe/pRSeZmIEKNTEQ9/pO2v2wfaUWD1rDQNkwcV?=
 =?us-ascii?Q?7rgBneLA4MenI1VYgacZb0im1VNh0yYgYeTwOfF0N5/FEWkRjmU1BWNzaDu8?=
 =?us-ascii?Q?0ULoTnmsBsapt6zMvUkhgWSWnu4dejFPEgXEH7ymMis1HPtwYLgfapMeGt3x?=
 =?us-ascii?Q?swsZ4bR0KmTkr8d+5FmewZr70muIKl33w8pNu7+aVlMy/KNM86bJjQUy7F/S?=
 =?us-ascii?Q?CQTyFnK5LH6I0oNArk0s11gJW/+DSr0Kd2anxuCd/4aC8weXLleotf6T7hKb?=
 =?us-ascii?Q?O5is8tqlT5BT/PX2/fK1CTsKS1+p8B3hfkR0dbKBzrJ6yDiaXfVzR0/B8WFj?=
 =?us-ascii?Q?6jYer9gCgNhKj7GV1hEyCaKPGQjiMN+qmOF8yFmcyXByE8ArHuz8tKmJKiwO?=
 =?us-ascii?Q?v1GaxT9qC2B70gz1DDIR1a7LNw5lmWdQ9ZFhdfT+BNhPnFsagHod4BCUJzI3?=
 =?us-ascii?Q?mx2IUCMTuhcccBUVgP4N5Fa1G42b2nVxMcKrcXQ7oLOkV5bWeVV2iCGkGxWp?=
 =?us-ascii?Q?W3JdlizzCLFWf0hyHns74xYYWRI1mV/LDByCi/6U1FFpqktygIPO0xtSNLbk?=
 =?us-ascii?Q?5KgwA84L97UmdQW+3L4tChRfp814iywjNqiQ5IlY0lyPH1E0kNsNedPpUvQA?=
 =?us-ascii?Q?zcqFpeHgvNt/3iiwALg19qrFAuHpUjHT4hG2FfJjgHh+Nbe2RTtmYCKymnZS?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c78880-c113-4cee-ea98-08dcdcf7643a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 00:17:07.7597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88NOV4F3ADBEkGtRXBaBlp+VLQb2UwQqPMPxQtObcpETut73ZIecitOuh7aFg+NkJKudojKC5LGfJL6FbChBvfJJux8lYS7P52k8i3ar63A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7096
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> Longterm pinning of FS DAX pages should already be disallowed by
> various pXX_devmap checks. However a future change will cause these
> checks to be invalid for FS DAX pages so make
> folio_is_longterm_pinnable() return false for FS DAX pages.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  include/linux/memremap.h | 11 +++++++++++
>  include/linux/mm.h       |  4 ++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 14273e6..6a1406a 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -187,6 +187,17 @@ static inline bool folio_is_device_coherent(const struct folio *folio)
>  	return is_device_coherent_page(&folio->page);
>  }
>  
> +static inline bool is_device_dax_page(const struct page *page)
> +{
> +	return is_zone_device_page(page) &&
> +		page_dev_pagemap(page)->type == MEMORY_DEVICE_FS_DAX;
> +}
> +
> +static inline bool folio_is_device_dax(const struct folio *folio)
> +{
> +	return is_device_dax_page(&folio->page);
> +}
> +
>  #ifdef CONFIG_ZONE_DEVICE
>  void zone_device_page_init(struct page *page);
>  void *memremap_pages(struct dev_pagemap *pgmap, int nid);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ae6d713..935e493 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1989,6 +1989,10 @@ static inline bool folio_is_longterm_pinnable(struct folio *folio)
>  	if (folio_is_device_coherent(folio))
>  		return false;
>  
> +	/* DAX must also always allow eviction. */
> +	if (folio_is_device_dax(folio))

Why is this called "folio_is_device_dax()" when the check is for fsdax?

I would expect:

if (folio_is_fsdax(folio))
	return false;

...and s/device_dax/fsdax/ for the rest of the helpers.

