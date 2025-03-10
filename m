Return-Path: <linux-fsdevel+bounces-43568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9D2A58CF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 08:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7610A3AA754
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 07:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CFC21660F;
	Mon, 10 Mar 2025 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUmV3OXI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE441C54A2;
	Mon, 10 Mar 2025 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741591951; cv=fail; b=BxtGuIt6hp/VDR9PzTzlznQEtP+PZ10aJ5DP0nraC43L6lb3pCjvoQ/8c1mSc+J267WB5MKzHS7A3bP2jL0APveXLQyLcVuoCe9rOa8WTauqY3r64naaBLli6SeeSTrRHC6nVqRvtIWUi61MD0pXzchZO3tPcC1c1rr6sORVHlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741591951; c=relaxed/simple;
	bh=cabMZ2aAjSyD7Px2N2O/zDcOnCMObdfVadksox+7lm0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u4T2wMQaJIplbfKrglcCF/j3u3kN+e0s4vevJ2ljyZAIIVenOzWC0UZa7z8/ffO5FAVUVcnn18sBK86F33ar/pFBs3PvBQRzenSKVZB8Ac4qEQvPVBVbPmSyjdqNvIHzMwyGV06L2/14cjf3IqNI7zTUbulS3NL4KvphrXkLJ3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUmV3OXI; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741591949; x=1773127949;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=cabMZ2aAjSyD7Px2N2O/zDcOnCMObdfVadksox+7lm0=;
  b=QUmV3OXIdvHrELhS8WWhighlxzpRfjDa8adgnR19b1UhcBXugyKVRcbS
   m+5sgwRIB0QwI0KqaLPhjgeyEzzNe7dy/ZS9KLcRMta9xT+gt2JI7ohQF
   /Yc9lyy+9xsWi6Cg4TP358c2EkrZX+BhJ7grFzuJNefn+Vyo6OCy83tj7
   LqTO/KPyJKoiwTkgKLmsQPnhoXfZNfW/nKj12wtPVdvZ5Lq+dFeJ5M6f4
   UI4DgUoj1llqYFncYgEHgSeeh/RBH6qzigtaSFRH/fZgS//rpTWX1uwzQ
   VJ3dZ+DBtuuKHcIRGiL9ABQc2UMzRHHfaD/nUWUHtdmKs/KqF8ZmVNYwD
   A==;
X-CSE-ConnectionGUID: W6/6m4LGRuanQ47zEg0gWA==
X-CSE-MsgGUID: 3Ga7tcomRo2aQrA4UN2m2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42788160"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="42788160"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 00:32:28 -0700
X-CSE-ConnectionGUID: QyXgC9OBQ3qUaQg2tJ44mQ==
X-CSE-MsgGUID: JsssPuLnQ3uTDxj1aBZsKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="119750375"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Mar 2025 00:32:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Mar 2025 00:32:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 00:32:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 00:32:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ct0mKKyvaSKIKX/YqQk/y2FMguK1tAZU23cU6/odk8sywuDgffWM+xRNfOOMtNCg/AQLxJ9V8lXOnlLWb2JTvsNHsmWXWFDrGHINN2U8DffnK/hbmET1wefozSpu5oyrAD2BUtOQ1M6s1s60dS0KGlMls+8486HOf/bg9uNKVROq2Ew+SiOhBa+EyDFiscodHkwn1+st0/nCLFxCtx8UwT4ivyBFv5Gm6fF6RvvLgLUIvOqkMfOhn4aLN425IzvIq84kTlbuu0w147M83RZshU5dsrepo33ViVxG4PxAtkqKPzfIQx2l1v1RIBuKxEzUKaSSMgwg41hfSL/B8qgNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAckOfFMHOjMbE/pL9aL5KETwJ8Od2wLeYTCUKuXvQo=;
 b=mLTIp6ebHGqcLezAz72IfFoSH7LCXrtNfdE2C9FY67hvYhOpQ2ZyDKdbdxkHtmMOQuPtXwjD0RUBemCNSwAJ8kph37eyDQIm1EtcrRIJikBxt7dGUEV3DUTF6QfLuW1eTlKv6/uqsSLxzVN6KNM7SNZWnol+FYeEEmwG1UQkSQZqfSRFrVmkeREDEigQan9seN4/m2rjPEDk+lo9hCTrejf5P/mPS/ChMGHk9tTS+NtFNxzxc7vuLD5G/P7IE4268ZuPtd1wbvr8OmItbXLY3xJL7SSO6EVEVghDUqPWsnD9NdkEruiQftnP1r6RbK0aNYG+ObkRvpLaouV8Qk3fmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH0PR11MB5233.namprd11.prod.outlook.com (2603:10b6:610:e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 07:32:24 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 07:32:23 +0000
Date: Mon, 10 Mar 2025 15:32:11 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, Alexander Mikhalitsyn
	<alexander@mihalicyn.com>, <linux-doc@vger.kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Kees Cook <kees@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, "Eric W . Biederman" <ebiederm@xmission.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, Oleg Nesterov
	<oleg@redhat.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH 1/2] Revert "pid: allow pid_max to be set per pid
 namespace"
Message-ID: <202503101532.348576bb-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221170249.890014-2-mkoutny@suse.com>
X-ClientProxiedBy: SGBP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::33)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH0PR11MB5233:EE_
X-MS-Office365-Filtering-Correlation-Id: a37a66a3-e55b-40e7-ddb5-08dd5fa5b2fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?dkWVhDKytm9yusM50eCnqwTuLwwwapShTuG8fZK/B3zw7LfHh+EQLQ9uaT?=
 =?iso-8859-1?Q?8cklXtU9jNB5piYWaogir+jC/2WB2TN7eTD4pdtCXnhLXH8WyBVJppRIEM?=
 =?iso-8859-1?Q?1UbW7Jc1vdfFIMjL9lsy8WKKDeyQo9/tzwv5CBeOWAmT2GtRgRDJDpEAbC?=
 =?iso-8859-1?Q?236zlxdlEZMiXdtxeaoFSnxfhah2EnHWYDjlIXyAflDRsh3NntfCC1EK90?=
 =?iso-8859-1?Q?7BmxPNdDYROXE4gSTvm6tg7YoSg4d93tZQgXUBIcO7s/fc36y5quuIXjTG?=
 =?iso-8859-1?Q?+oGzwdkSJRbwZOJTaLIibRdUVcAa2KAocTyOgQYSCfvwrimglCdHBWc7lZ?=
 =?iso-8859-1?Q?LcZEPGMziyB7FeJH2n9MS/UDgBIJ9LVZUolXv9j6DqwP206n0g+eWFWe64?=
 =?iso-8859-1?Q?mutmahhQZkCaPHoaFg2pyla2n6N1J4Z4UZtxlFRpwp00v7TQ1T20y4VD9q?=
 =?iso-8859-1?Q?QGH0x6t8fu/nN5IyHpjPwipxnXGy8BsskfW1Qsz2IQOau8xdEik2Ko+3vK?=
 =?iso-8859-1?Q?qCvwsXangkSyAh7cYPIrizx0ZA8CcTdECTDh9Q2q+iW3Cs/4BzV/jbPCYm?=
 =?iso-8859-1?Q?djo5NF8juOjxWSuzcmlKD9q9WFmAZmZdEAd9N+pYwCgV+sr+kRAoTVfLti?=
 =?iso-8859-1?Q?3w6W+W2oFoo0GunJRijEcRCMGdqhRKXZQHGzghjEv8ri/oz0WeUOigQnk1?=
 =?iso-8859-1?Q?b8v5fwgLWSDkk3E0ytqAeHrHYx8i+3Qn6q0B+Ub1ViPvPeS4K8kmSBYrQw?=
 =?iso-8859-1?Q?Ve0JjKTkF2LDmvUbALd4bKsKALhoBaqm4f6bXECsks+pvb9qVgpkDJ0/+u?=
 =?iso-8859-1?Q?07pYMv8gy9RhnASkBmTMFlAxT+mVN92GhuTN0yQ4USE31jobR+G8FOkPTC?=
 =?iso-8859-1?Q?9KJRrKvQGg/1VJ5qO5wyEf2kXeXm7GEmgnshsfOERFJkfI+r/vLzEXRf6v?=
 =?iso-8859-1?Q?o82XK6Y9cU3NfBr30sxCJio1VG7ghWYN0q3JLhC637G8EywVwgRd2bOs87?=
 =?iso-8859-1?Q?Xfz3M6aBm/2ELcHQ4tFhEuEmXNNmnzgFcpCI88wAIWu+V61b8UwWWc4bgx?=
 =?iso-8859-1?Q?R89C+b3Yxz1SGDt/z9+FpmzvbseNNc7XhDwK+sY5vWKtKh6TJFaw/ceXsD?=
 =?iso-8859-1?Q?BAsMIXQKrmNG8vEEfS2fhVXc7JZyyDuz7G6L2cwkRTcY8n3ZXnQrZ5PeOS?=
 =?iso-8859-1?Q?58uXcyvMwKeZzuXlBsfn2YoXrNKxEnA1GNMgxeb/EwVwc1dClNsegksE4S?=
 =?iso-8859-1?Q?7lB89ED5Zzoj7wRitzIQSjjvOZrDJE/yfjYKs4TcKf7F1+meQ1qoMipTJT?=
 =?iso-8859-1?Q?nOk3S27n+qaBhbHM3p3dfHIP95Qw9dT6VhcYQDZEBp6RFfJArdXQSkj0n8?=
 =?iso-8859-1?Q?ufbXL2y58s0kCy7BF2t7tFI49iicegaA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1UD1Fldo4B03NsZghQgRrTlwOM7NXm/a/9AxLre0iQIaUqMwUPk/eNIbPC?=
 =?iso-8859-1?Q?bvsYjtsmV3TTNLYPe0IKEyTrpnY90CwDyjPAxWKl/86zp9RhdCUbO8lPQg?=
 =?iso-8859-1?Q?2FHm3Np6hIAaQ1vFZffRgcEDlNtUiMExcPfYkYgMKlscwdHMOOP8q6juAY?=
 =?iso-8859-1?Q?VU2S02+qyWSkG+p/VHb/lgGRp7gdy1WO1bYFGvp+iUp3cpFyVARt36AQsL?=
 =?iso-8859-1?Q?fXjkCUQAvfL1AJdT7/Fmvc+b8H2vcEwHZAbbMX9cyHyLtPX03wLQCs7Pj3?=
 =?iso-8859-1?Q?dVhjqS9eIzhsGsVGUNXJsZZFMIeoiy++cDS4SXweb4sTgp+yfVpRpzMbUS?=
 =?iso-8859-1?Q?En6dwVnEniENm9sFSAhBn9SsDQ6y/vk/oCRiY1RMsN4ZnCJn5q+u6lOxAM?=
 =?iso-8859-1?Q?cLNKKsi55JyNUAMmHi19/dWbYj+wLolG6JaNf2blYyL42YbIkaENNfY2Vv?=
 =?iso-8859-1?Q?Z1Gph1R2VB2ylqSqw25TVYdcWw6YxRLc9NMTKs2pK9HElKkAk8K4hg00vr?=
 =?iso-8859-1?Q?/1mm1S68g+medqF1fWVdXjKF00rg257QpxbDIp/jClMm8l9qTaNhyVs/Qt?=
 =?iso-8859-1?Q?DHeLmAxS/Kwti72+VaSTYtBsraChsVH3BoFgpqivCNH+rgtIdpQOYLYC6T?=
 =?iso-8859-1?Q?AWoAVmqdGaatyHIPbraoza3ztzhAgVlvSMFA6TvCLD2QUObW1qK6vdutxE?=
 =?iso-8859-1?Q?CJC0eJkQ+mjYpK327nJ707nLLmdIZAEir/DRzwvoPny8J+3PelYTcEiKCH?=
 =?iso-8859-1?Q?wY1x6EtwLMUUxDwOpsGRcFTshFbUEUEZYFy3N1BORnZp+S+aJnllKNvzLU?=
 =?iso-8859-1?Q?l9lzyCnRw9STV1zyqEsA2T291gQgEbJ5w389Dg30qluD62X8rpG8agdmZY?=
 =?iso-8859-1?Q?DhNch2vpIakDUNUUGFdIL5Dpxp2jAwI8lpZ38ygOkw1/zKj1W7WBE5WyH0?=
 =?iso-8859-1?Q?+jw8mriTJmGu0bI0tAc+bYvkvYRRHi3/kYsFyXRWc8jjzgA4gVBJrZvCws?=
 =?iso-8859-1?Q?iRLRRoi3ty22NVIygxpahGItKA499JRmx6iM9A0BllCUZ4y3olRLDFCEqA?=
 =?iso-8859-1?Q?v1gGGha0+wiZPFaGWbROXTgsgqEVTrfzLn2kzwYack8Hz1N04yDAP0mW+w?=
 =?iso-8859-1?Q?avdIbbwUKCU6kP8IY/E6o+7s9IHXt4NZ7rkeT3wIxTKYieA3fjCh+l8BKi?=
 =?iso-8859-1?Q?ZJa9LkwDIPCl03+c1iZ83iR/nuiakX+QAV3ALedemfIMzfnbMIKijRH5XE?=
 =?iso-8859-1?Q?alVmXjEmCsp5qqAYnLj6XmNYPNxPrpbJT9rGeV88IG4TaQ3yndmf6L/iMq?=
 =?iso-8859-1?Q?uBRqcxbjmQ839krgDfBdITAj1kMt22smyZl/P1ri4ik1lh5BEywA2ikxXt?=
 =?iso-8859-1?Q?CprqhDlu8uD/k1O/42EdjkuF7scejcyW5oZNyKbUeQBJtn219xvzztnNgE?=
 =?iso-8859-1?Q?Jfcn/trtRR8zCUKDxVguwQi2ZZoyxIcCmBQPcACrE7Y4FORzyVNhRnSxfv?=
 =?iso-8859-1?Q?+whFc6u+ywRKwmr/0HwMJwRMC7kdPn6eAqjISFs/vlG1l5jwTQyaKmMBBT?=
 =?iso-8859-1?Q?k39JcuTA9JhWGdIBxEwzJaIlUJ6w43hRibvCdxwQFGrywc5zPfYrpLMwXq?=
 =?iso-8859-1?Q?GoUoSKZkcnpqVYA+PlfBIkuy02e3A1wbX82/bfjbJ+xGamOE0B0laQoA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a37a66a3-e55b-40e7-ddb5-08dd5fa5b2fb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 07:32:23.7093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OgukyPjXSi4GNr1jFy/O4INUINx7lX5ExswDMao/inSene81KTWamnzylqN9qEI3cRk6+Ow8MzCJ2dhEhvbog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5233
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 23.4% improvement of stress-ng.sigxfsz.ops_per_sec on:


commit: ee2a5c3e36093d0ff5709bc8f21d3793cf55f746 ("[PATCH 1/2] Revert "pid: allow pid_max to be set per pid namespace"")
url: https://github.com/intel-lab-lkp/linux/commits/Michal-Koutn/Revert-pid-allow-pid_max-to-be-set-per-pid-namespace/20250222-010942
patch link: https://lore.kernel.org/all/20250221170249.890014-2-mkoutny@suse.com/
patch subject: [PATCH 1/2] Revert "pid: allow pid_max to be set per pid namespace"

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: sigxfsz
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.mprotect.ops_per_sec 4.5% improvement                                |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | nr_threads=100%                                                                           |
|                  | test=mprotect                                                                             |
|                  | testtime=60s                                                                              |
+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.sigrt.ops_per_sec 15.7% improvement                                  |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | nr_threads=100%                                                                           |
|                  | test=sigrt                                                                                |
|                  | testtime=60s                                                                              |
+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.sigbus.ops_per_sec 20.6% improvement                                 |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | nr_threads=100%                                                                           |
|                  | test=sigbus                                                                               |
|                  | testtime=60s                                                                              |
+------------------+-------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250310/202503101532.348576bb-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/sigxfsz/stress-ng/60s

commit: 
  3344260945 ("Merge tag 'for-v6.14-rc' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply")
  ee2a5c3e36 ("Revert "pid: allow pid_max to be set per pid namespace"")

334426094588f817 ee2a5c3e36093d0ff5709bc8f21 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      5.11            +1.3        6.43        mpstat.cpu.all.usr%
      3737 ±  6%     -38.8%       2286 ± 42%  proc-vmstat.numa_hint_faults_local
   1212920 ±  4%     -10.4%    1086901 ±  5%  sched_debug.cpu.avg_idle.max
     35.50 ± 16%     -30.0%      24.83 ± 20%  perf-c2c.DRAM.local
      1517 ±  4%     -46.5%     812.17 ±  3%  perf-c2c.DRAM.remote
      1808 ±  2%     +57.0%       2840        perf-c2c.HITM.local
      1360 ±  5%     -49.9%     680.83 ±  2%  perf-c2c.HITM.remote
      5.22 ±  3%     +19.8%       6.26 ±  7%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     53.33 ± 15%     +25.0%      66.67 ± 15%  perf-sched.wait_and_delay.count.__cond_resched.vfs_write.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe
    953.83 ±  3%     -16.5%     796.33 ±  7%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      5.21 ±  3%     +20.0%       6.25 ±  7%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    163515           +27.8%     208915        stress-ng.sigxfsz.SIGXFSZ_signals_per_sec
 6.668e+08           +23.4%   8.23e+08        stress-ng.sigxfsz.ops
  11113966           +23.4%   13716156        stress-ng.sigxfsz.ops_per_sec
      3623            -1.4%       3573        stress-ng.time.system_time
    163.26           +31.7%     214.98        stress-ng.time.user_time
      0.25           -54.7%       0.12 ±  2%  perf-stat.i.MPKI
 1.125e+10           +22.1%  1.373e+10        perf-stat.i.branch-instructions
      0.54            -0.0        0.50        perf-stat.i.branch-miss-rate%
  59748239           +10.9%   66264440        perf-stat.i.branch-misses
     33.30           -17.9       15.38 ±  2%  perf-stat.i.cache-miss-rate%
  13040640           -45.8%    7066419 ±  2%  perf-stat.i.cache-misses
  39047103           +15.5%   45098530        perf-stat.i.cache-references
      4.39           -18.2%       3.59        perf-stat.i.cpi
     17823           +97.0%      35113        perf-stat.i.cycles-between-cache-misses
 5.144e+10           +22.0%  6.275e+10        perf-stat.i.instructions
      0.23           +21.3%       0.28        perf-stat.i.ipc
      0.25           -55.6%       0.11 ±  2%  perf-stat.overall.MPKI
      0.53            -0.0        0.48        perf-stat.overall.branch-miss-rate%
     33.40           -17.7       15.67 ±  2%  perf-stat.overall.cache-miss-rate%
      4.40           -18.0%       3.60        perf-stat.overall.cpi
     17350           +84.6%      32027 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.23           +22.0%       0.28        perf-stat.overall.ipc
 1.106e+10           +22.1%   1.35e+10        perf-stat.ps.branch-instructions
  58763534           +10.9%   65180843        perf-stat.ps.branch-misses
  12827760           -45.8%    6951883 ±  2%  perf-stat.ps.cache-misses
  38411225           +15.5%   44365626        perf-stat.ps.cache-references
  5.06e+10           +22.0%  6.172e+10        perf-stat.ps.instructions
 3.106e+12           +21.9%  3.787e+12        perf-stat.total.instructions


***************************************************************************************************
lkp-icl-2sp7: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/mprotect/stress-ng/60s

commit: 
  3344260945 ("Merge tag 'for-v6.14-rc' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply")
  ee2a5c3e36 ("Revert "pid: allow pid_max to be set per pid namespace"")

334426094588f817 ee2a5c3e36093d0ff5709bc8f21 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     10205 ± 25%     +33.5%      13621 ± 16%  numa-meminfo.node0.KernelStack
      0.02 ± 37%     -37.8%       0.01 ± 13%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.82 ± 32%     -37.7%       0.51 ±  7%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    807.17 ±  5%      -8.5%     738.67 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.down_write.vma_prepare.__split_vma.vma_modify
    433709            +4.9%     454923 ±  5%  proc-vmstat.nr_active_anon
     61940 ±  3%     +31.3%      81315 ± 35%  proc-vmstat.nr_shmem
    433709            +4.9%     454923 ±  5%  proc-vmstat.nr_zone_active_anon
 4.903e+08            +4.5%  5.124e+08        stress-ng.mprotect.ops
   8163833            +4.5%    8533021        stress-ng.mprotect.ops_per_sec
    239.55            +4.7%     250.91        stress-ng.time.user_time
   3960356 ±  7%     -16.0%    3325457        numa-numastat.node0.local_node
   3990670 ±  7%     -16.1%    3348370        numa-numastat.node0.numa_hit
   2608139 ±  6%     +34.5%    3507199 ±  4%  numa-numastat.node1.local_node
   2644058 ±  6%     +34.3%    3550893 ±  4%  numa-numastat.node1.numa_hit
   3986137 ±  7%     -16.0%    3349506        numa-vmstat.node0.numa_hit
   3955823 ±  7%     -15.9%    3326594        numa-vmstat.node0.numa_local
   2639425 ±  6%     +34.6%    3552253 ±  4%  numa-vmstat.node1.numa_hit
   2603506 ±  6%     +34.8%    3508559 ±  4%  numa-vmstat.node1.numa_local
      1.11 ± 20%     -38.9%       0.68 ± 31%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      1.11 ± 19%     -38.6%       0.68 ± 31%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
      5890 ±  6%     -10.7%       5262        sched_debug.cfs_rq:/.runnable_avg.max
      1064 ± 20%     -41.1%     626.67 ± 33%  sched_debug.cfs_rq:/.runnable_avg.stddev
      1151           -12.2%       1010        sched_debug.cpu.clock_task.stddev
      1.11 ± 20%     -39.1%       0.68 ± 32%  sched_debug.cpu.nr_running.stddev
 1.861e+10            +4.5%  1.945e+10        perf-stat.i.branch-instructions
 1.264e+08            +4.1%  1.316e+08        perf-stat.i.branch-misses
  1.45e+08            +5.3%  1.526e+08        perf-stat.i.cache-references
      2.28            -4.3%       2.18        perf-stat.i.cpi
 8.533e+10            +4.5%   8.92e+10        perf-stat.i.instructions
      0.44            +4.5%       0.46        perf-stat.i.ipc
     63.03            +4.5%      65.90        perf-stat.i.metric.K/sec
   4035009            +4.5%    4218051        perf-stat.i.page-faults
      2.29            -4.4%       2.19        perf-stat.overall.cpi
      0.44            +4.6%       0.46        perf-stat.overall.ipc
 1.829e+10            +4.5%  1.912e+10        perf-stat.ps.branch-instructions
 1.242e+08            +4.1%  1.293e+08        perf-stat.ps.branch-misses
 1.424e+08            +5.3%  1.499e+08        perf-stat.ps.cache-references
 8.385e+10            +4.6%  8.767e+10        perf-stat.ps.instructions
   3966080            +4.6%    4146673        perf-stat.ps.page-faults
 5.154e+12            +4.6%  5.389e+12        perf-stat.total.instructions
     36.24            -1.9       34.36 ±  2%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.stress_mprotect_mem
     38.30            -1.7       36.58 ±  2%  perf-profile.calltrace.cycles-pp.stress_mprotect_mem
     14.45 ±  2%      -1.7       12.80 ±  2%  perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_page_fault.stress_mprotect_mem
     17.12            -1.5       15.58 ±  2%  perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_exc_page_fault.stress_mprotect_mem
     17.06            -1.5       15.54 ±  2%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_page_fault.stress_mprotect_mem
     12.44 ±  2%      -1.5       10.92 ±  2%  perf-profile.calltrace.cycles-pp.do_dec_rlimit_put_ucounts.__sigqueue_free.get_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode
     12.46 ±  2%      -1.5       10.94 ±  2%  perf-profile.calltrace.cycles-pp.__sigqueue_free.get_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.54 ±  2%      -0.1        0.43 ± 44%  perf-profile.calltrace.cycles-pp.up_read.__bad_area.bad_area_access_error.exc_page_fault.asm_exc_page_fault
      0.84            -0.1        0.75 ±  4%  perf-profile.calltrace.cycles-pp.down_write.__split_vma.vma_modify.vma_modify_flags.mprotect_fixup
      1.60            -0.1        1.51 ±  2%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.stress_sig_handler
      1.59            -0.1        1.51 ±  2%  perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_exc_page_fault.stress_sig_handler
      0.82 ±  3%      -0.1        0.74 ±  2%  perf-profile.calltrace.cycles-pp.sigprocmask.__x64_sys_rt_sigprocmask.do_syscall_64.entry_SYSCALL_64_after_hwframe.pthread_sigmask
      1.44            -0.1        1.37 ±  2%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_page_fault.stress_sig_handler
      1.03 ±  2%      -0.1        0.98        perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigprocmask.do_syscall_64.entry_SYSCALL_64_after_hwframe.pthread_sigmask
      1.29 ±  2%      -0.1        1.23        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.pthread_sigmask
      0.68 ±  3%      -0.0        0.64 ±  2%  perf-profile.calltrace.cycles-pp.up_write.vma_complete.__split_vma.vma_modify.vma_modify_flags
      0.58 ±  2%      -0.0        0.54 ±  3%  perf-profile.calltrace.cycles-pp.__bad_area.bad_area_access_error.exc_page_fault.asm_exc_page_fault.stress_mprotect_mem
      0.58 ±  2%      -0.0        0.56        perf-profile.calltrace.cycles-pp.fpu__clear_user_states.handle_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.62 ±  3%      +0.1        0.67 ±  2%  perf-profile.calltrace.cycles-pp.mas_prev_slot.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.01            +0.1        1.07        perf-profile.calltrace.cycles-pp.copy_fpstate_to_sigframe.get_sigframe.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart
      1.23            +0.1        1.30 ±  2%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_mprotect_mem
      0.84 ±  3%      +0.1        0.91 ±  2%  perf-profile.calltrace.cycles-pp.vma_interval_tree_insert.vma_complete.commit_merge.vma_merge_existing_range.vma_modify
      0.84 ±  2%      +0.1        0.91        perf-profile.calltrace.cycles-pp.mas_preallocate.__split_vma.vma_modify.vma_modify_flags.mprotect_fixup
      1.75 ±  2%      +0.1        1.83        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__mprotect
      0.59 ±  2%      +0.1        0.67 ±  2%  perf-profile.calltrace.cycles-pp.simple_dname.perf_event_mmap_event.perf_event_mmap.mprotect_fixup.do_mprotect_pkey
      2.41 ±  2%      +0.1        2.50        perf-profile.calltrace.cycles-pp.clear_bhb_loop.__mprotect
      1.77            +0.1        1.88        perf-profile.calltrace.cycles-pp.get_sigframe.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode
      2.02            +0.1        2.14        perf-profile.calltrace.cycles-pp.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.98 ± 18%      +0.1        1.10        perf-profile.calltrace.cycles-pp.change_protection_range.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      2.57            +0.1        2.70        perf-profile.calltrace.cycles-pp.handle_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_page_fault.stress_mprotect_mem
      3.13 ±  3%      +0.2        3.34 ±  2%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__mprotect
      0.00            +0.6        0.55 ±  2%  perf-profile.calltrace.cycles-pp.prepend_copy.simple_dname.perf_event_mmap_event.perf_event_mmap.mprotect_fixup
     34.00            +1.1       35.12 ±  2%  perf-profile.calltrace.cycles-pp.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
     46.05            +1.1       47.19        perf-profile.calltrace.cycles-pp.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mprotect
     46.28            +1.2       47.43        perf-profile.calltrace.cycles-pp.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mprotect
     48.43            +1.2       49.61        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mprotect
     48.86            +1.2       50.06        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mprotect
     55.84            +1.6       57.41        perf-profile.calltrace.cycles-pp.__mprotect
     39.48            -1.9       37.62 ±  2%  perf-profile.children.cycles-pp.asm_exc_page_fault
     14.48 ±  2%      -1.6       12.83 ±  2%  perf-profile.children.cycles-pp.get_signal
     18.72            -1.6       17.11        perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
     39.92            -1.6       38.32 ±  2%  perf-profile.children.cycles-pp.stress_mprotect_mem
     18.52            -1.6       16.92        perf-profile.children.cycles-pp.arch_do_signal_or_restart
     12.47 ±  2%      -1.5       10.94 ±  2%  perf-profile.children.cycles-pp.__sigqueue_free
     12.44 ±  2%      -1.5       10.92 ±  2%  perf-profile.children.cycles-pp.do_dec_rlimit_put_ucounts
      5.00            -0.2        4.83 ±  2%  perf-profile.children.cycles-pp.up_write
      0.47 ± 10%      -0.1        0.34 ±  7%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.47 ± 10%      -0.1        0.34 ±  7%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.16 ±  3%      -0.1        1.05        perf-profile.children.cycles-pp.recalc_sigpending
      0.35 ±  7%      -0.1        0.24 ±  6%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.89 ±  6%      -0.1        0.79 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.34 ±  8%      -0.1        0.24 ±  6%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.86 ±  2%      -0.1        0.78        perf-profile.children.cycles-pp.sigprocmask
      0.28 ± 10%      -0.1        0.21 ±  6%  perf-profile.children.cycles-pp.update_process_times
      1.05 ±  2%      -0.1        0.98        perf-profile.children.cycles-pp.__x64_sys_rt_sigprocmask
      0.30 ±  3%      -0.0        0.26 ±  3%  perf-profile.children.cycles-pp.fpregs_mark_activate
      0.17 ± 10%      -0.0        0.13 ±  6%  perf-profile.children.cycles-pp.sched_tick
      0.47 ±  3%      -0.0        0.43 ±  3%  perf-profile.children.cycles-pp.complete_signal
      0.54 ±  2%      -0.0        0.51 ±  2%  perf-profile.children.cycles-pp.up_read
      0.58 ±  2%      -0.0        0.55 ±  2%  perf-profile.children.cycles-pp.__bad_area
      0.61            -0.0        0.58        perf-profile.children.cycles-pp.fpu__clear_user_states
      0.12 ±  5%      +0.0        0.14 ±  4%  perf-profile.children.cycles-pp.__get_user_nocheck_4
      0.13 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.ima_file_mprotect
      0.22 ±  5%      +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.security_file_mprotect
      0.25 ±  3%      +0.0        0.28 ±  4%  perf-profile.children.cycles-pp.stress_mwc16
      0.18 ±  5%      +0.0        0.20 ±  6%  perf-profile.children.cycles-pp.stress_mwc16modn
      0.34 ±  3%      +0.0        0.37 ±  3%  perf-profile.children.cycles-pp.mas_ascend
      0.12 ±  4%      +0.0        0.15 ±  5%  perf-profile.children.cycles-pp.copy_from_kernel_nofault_allowed
      0.30 ±  8%      +0.0        0.33 ±  2%  perf-profile.children.cycles-pp.rcu_all_qs
      0.26 ±  4%      +0.0        0.29 ±  6%  perf-profile.children.cycles-pp.mas_pop_node
      0.44 ±  2%      +0.0        0.47        perf-profile.children.cycles-pp.vma_set_page_prot
      0.49 ±  3%      +0.0        0.53 ±  3%  perf-profile.children.cycles-pp.save_xstate_epilog
      0.66 ±  2%      +0.0        0.71 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.02 ± 99%      +0.1        0.08 ± 11%  perf-profile.children.cycles-pp.anon_vma_clone
      1.27            +0.1        1.33        perf-profile.children.cycles-pp.do_user_addr_fault
      0.84            +0.1        0.90        perf-profile.children.cycles-pp.mas_prev_slot
      1.04            +0.1        1.11        perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      0.73 ±  7%      +0.1        0.79 ±  2%  perf-profile.children.cycles-pp.__cond_resched
      0.46 ±  3%      +0.1        0.53 ±  2%  perf-profile.children.cycles-pp.copy_from_kernel_nofault
      1.30 ±  2%      +0.1        1.37        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.50 ±  2%      +0.1        0.58 ±  2%  perf-profile.children.cycles-pp.prepend_copy
      1.68            +0.1        1.75        perf-profile.children.cycles-pp.mas_preallocate
      0.61 ±  3%      +0.1        0.70 ±  3%  perf-profile.children.cycles-pp.simple_dname
      2.77 ±  2%      +0.1        2.87        perf-profile.children.cycles-pp.clear_bhb_loop
      3.27            +0.1        3.37        perf-profile.children.cycles-pp.handle_signal
      1.78            +0.1        1.89        perf-profile.children.cycles-pp.get_sigframe
      2.05            +0.1        2.16        perf-profile.children.cycles-pp.x64_setup_rt_frame
      0.99 ± 18%      +0.1        1.11        perf-profile.children.cycles-pp.change_protection_range
      7.00            +0.2        7.24 ±  2%  perf-profile.children.cycles-pp.vma_prepare
     34.09            +1.1       35.22 ±  2%  perf-profile.children.cycles-pp.mprotect_fixup
     50.17            +1.1       51.31        perf-profile.children.cycles-pp.do_syscall_64
     46.24            +1.2       47.39        perf-profile.children.cycles-pp.do_mprotect_pkey
     46.33            +1.2       47.49        perf-profile.children.cycles-pp.__x64_sys_mprotect
     50.61            +1.2       51.78        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     55.94            +1.6       57.52        perf-profile.children.cycles-pp.__mprotect
     12.44 ±  2%      -1.5       10.91 ±  2%  perf-profile.self.cycles-pp.do_dec_rlimit_put_ucounts
      4.36            -0.1        4.22 ±  2%  perf-profile.self.cycles-pp.up_write
      1.14 ±  3%      -0.1        1.03        perf-profile.self.cycles-pp.recalc_sigpending
      0.87 ±  6%      -0.1        0.78 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      2.83            -0.1        2.75        perf-profile.self.cycles-pp.down_write
      0.28 ±  5%      -0.0        0.23 ±  5%  perf-profile.self.cycles-pp.fpregs_mark_activate
      0.19 ± 10%      -0.0        0.14 ± 12%  perf-profile.self.cycles-pp.__perf_event_header__init_id
      0.40 ±  3%      -0.0        0.36 ±  5%  perf-profile.self.cycles-pp.complete_signal
      0.52 ±  2%      -0.0        0.48 ±  2%  perf-profile.self.cycles-pp.up_read
      0.15 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__send_signal_locked
      0.10 ±  4%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__bad_area_nosemaphore
      0.30 ±  3%      +0.0        0.33 ±  4%  perf-profile.self.cycles-pp.mas_ascend
      0.10 ±  5%      +0.0        0.12 ±  5%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.copy_from_kernel_nofault_allowed
      0.21 ±  6%      +0.0        0.24 ±  4%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.40            +0.0        0.43 ±  2%  perf-profile.self.cycles-pp.change_protection_range
      0.44            +0.0        0.47        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.24 ±  3%      +0.0        0.27 ±  6%  perf-profile.self.cycles-pp.mas_pop_node
      0.34 ±  2%      +0.0        0.38 ±  3%  perf-profile.self.cycles-pp.mas_preallocate
      0.37 ±  8%      +0.0        0.41 ±  3%  perf-profile.self.cycles-pp.__cond_resched
      0.72            +0.0        0.76 ±  2%  perf-profile.self.cycles-pp.copy_fpstate_to_sigframe
      0.41            +0.0        0.45 ±  3%  perf-profile.self.cycles-pp.mas_prev_slot
      0.66 ±  2%      +0.0        0.71 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.30 ±  4%      +0.0        0.35 ±  2%  perf-profile.self.cycles-pp.copy_from_kernel_nofault
      0.02 ±141%      +0.1        0.08 ± 11%  perf-profile.self.cycles-pp.anon_vma_clone
      1.21 ±  2%      +0.1        1.30 ±  2%  perf-profile.self.cycles-pp.__mprotect
      2.73 ±  2%      +0.1        2.83        perf-profile.self.cycles-pp.clear_bhb_loop
      2.76            +0.1        2.88        perf-profile.self.cycles-pp.do_mprotect_pkey
      3.48 ±  3%      +0.3        3.74 ±  2%  perf-profile.self.cycles-pp.stress_mprotect_mem



***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/sigrt/stress-ng/60s

commit: 
  3344260945 ("Merge tag 'for-v6.14-rc' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply")
  ee2a5c3e36 ("Revert "pid: allow pid_max to be set per pid namespace"")

334426094588f817 ee2a5c3e36093d0ff5709bc8f21 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1345 ±  9%     -15.8%       1132 ±  5%  perf-c2c.HITM.remote
   5328778           +18.0%    6289475        vmstat.system.cs
    197362            +2.0%     201296        vmstat.system.in
     45.97 ±118%     -85.4%       6.71 ± 55%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.shmem_alloc_folio
    582.79 ± 39%     -39.2%     354.28 ± 31%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range.do_sigtimedwait.isra.0.__x64_sys_rt_sigtimedwait
      1260 ± 46%     -43.7%     709.74 ± 31%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range.do_sigtimedwait.isra.0.__x64_sys_rt_sigtimedwait
     45.97 ±118%     -85.4%       6.71 ± 55%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.shmem_alloc_folio
    705.59 ± 50%     -48.9%     360.90 ± 32%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range.do_sigtimedwait.isra.0.__x64_sys_rt_sigtimedwait
     83250           -16.0%      69935        stress-ng.sigrt.nanosecs_between_sigqueue_and_sigwaitinfo_completion
 3.362e+08           +15.7%   3.89e+08        stress-ng.sigrt.ops
   5601334           +15.7%    6480915        stress-ng.sigrt.ops_per_sec
  65582158           +17.7%   77176472        stress-ng.time.involuntary_context_switches
      3423            -1.4%       3375        stress-ng.time.system_time
    335.13 ±  2%     +14.5%     383.80 ±  2%  stress-ng.time.user_time
 2.714e+08           +17.4%  3.185e+08        stress-ng.time.voluntary_context_switches
   4202907 ± 15%     -24.2%    3184715 ± 12%  sched_debug.cfs_rq:/.avg_vruntime.max
     82.07 ± 12%    +391.9%     403.68 ± 94%  sched_debug.cfs_rq:/.load_avg.avg
    169.48 ±  8%   +1182.4%       2173 ±115%  sched_debug.cfs_rq:/.load_avg.stddev
   4202907 ± 15%     -24.2%    3184715 ± 12%  sched_debug.cfs_rq:/.min_vruntime.max
      1239 ±  8%     +14.2%       1415 ± 12%  sched_debug.cfs_rq:/.util_avg.max
   2593172           +17.4%    3044316        sched_debug.cpu.nr_switches.avg
   1526897 ±  3%     +66.4%    2540867 ±  2%  sched_debug.cpu.nr_switches.min
    606805           -67.2%     198918 ±  9%  sched_debug.cpu.nr_switches.stddev
 1.902e+10           +14.8%  2.184e+10        perf-stat.i.branch-instructions
  1.42e+08 ±  3%     +16.2%   1.65e+08        perf-stat.i.branch-misses
      6.65 ±  4%      -0.9        5.77 ±  7%  perf-stat.i.cache-miss-rate%
 3.931e+08 ±  9%     +17.1%  4.605e+08 ±  6%  perf-stat.i.cache-references
   5534190           +17.4%    6498045        perf-stat.i.context-switches
      2.71           -14.3%       2.33        perf-stat.i.cpi
 8.694e+10           +14.8%  9.976e+10        perf-stat.i.instructions
      0.39           +14.2%       0.45        perf-stat.i.ipc
     86.53           +17.4%     101.60        perf-stat.i.metric.K/sec
      6.82 ±  5%      -0.9        5.91 ±  9%  perf-stat.overall.cache-miss-rate%
      2.59           -12.9%       2.26        perf-stat.overall.cpi
      0.39           +14.7%       0.44        perf-stat.overall.ipc
 1.871e+10           +14.8%  2.149e+10        perf-stat.ps.branch-instructions
 1.396e+08 ±  3%     +16.2%  1.622e+08        perf-stat.ps.branch-misses
 3.868e+08 ±  9%     +17.1%   4.53e+08 ±  6%  perf-stat.ps.cache-references
   5443676           +17.4%    6391319        perf-stat.ps.context-switches
 8.552e+10           +14.8%  9.813e+10        perf-stat.ps.instructions
 5.251e+12           +14.3%      6e+12        perf-stat.total.instructions



***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/sigbus/stress-ng/60s

commit: 
  3344260945 ("Merge tag 'for-v6.14-rc' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply")
  ee2a5c3e36 ("Revert "pid: allow pid_max to be set per pid namespace"")

334426094588f817 ee2a5c3e36093d0ff5709bc8f21 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      7.64            +1.7        9.30        mpstat.cpu.all.usr%
     36.50 ± 16%     -42.9%      20.83 ± 31%  perf-c2c.DRAM.local
      2312 ±  6%     -68.7%     723.17 ±  4%  perf-c2c.DRAM.remote
      3690 ±  3%     +44.9%       5347 ±  6%  perf-c2c.HITM.local
      2155 ±  6%     -71.8%     608.17 ±  4%  perf-c2c.HITM.remote
      4477 ± 69%     -70.3%       1328 ± 35%  proc-vmstat.numa_hint_faults
      2459 ± 11%     -64.8%     866.33 ± 47%  proc-vmstat.numa_hint_faults_local
    140611 ± 21%     -33.6%      93302 ± 45%  proc-vmstat.numa_pte_updates
 7.197e+08           +20.7%  8.685e+08        proc-vmstat.pgfault
 7.201e+08           +20.6%  8.682e+08        stress-ng.sigbus.ops
  12001759           +20.6%   14469786        stress-ng.sigbus.ops_per_sec
      3526            -1.8%       3461        stress-ng.time.system_time
    261.31           +25.4%     327.64        stress-ng.time.user_time
      0.03 ± 55%     -64.6%       0.01 ± 17%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.86 ±150%     -90.1%       0.09 ±201%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.02 ± 50%     -58.7%       0.01 ± 14%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.08 ± 18%     -34.1%       0.71 ± 14%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.31 ± 72%     -65.9%       0.11 ± 71%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ± 10%     -23.4%       0.01 ± 15%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      1.91 ±218%     -99.2%       0.02 ± 11%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      4.00 ± 49%     -71.6%       1.14 ± 56%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    261.25 ± 37%    +199.1%     781.43 ± 15%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     81.02 ± 59%    +274.1%     303.13 ± 50%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      6.60 ±  2%     +16.9%       7.71 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    108.83 ± 63%     -81.2%      20.50 ±113%  perf-sched.wait_and_delay.count.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      3107 ±  3%     -12.6%       2714 ±  5%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
    124.17 ± 63%     -70.1%      37.17 ± 60%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    751.00 ±  2%     -17.0%     623.50 ±  2%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1550 ± 31%    +119.7%       3406 ± 19%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    261.24 ± 37%    +199.1%     781.42 ± 15%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     80.16 ± 60%    +278.0%     303.05 ± 50%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      6.59 ±  2%     +17.0%       7.71 ±  3%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1550 ± 31%    +119.7%       3406 ± 19%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.18           -49.0%       0.09 ±  3%  perf-stat.i.MPKI
  1.59e+10           +19.7%  1.903e+10        perf-stat.i.branch-instructions
      0.28            -0.0        0.25        perf-stat.i.branch-miss-rate%
  40989724            +5.3%   43173098 ±  2%  perf-stat.i.branch-misses
     32.63           -15.8       16.81 ±  2%  perf-stat.i.cache-miss-rate%
  12733301 ±  2%     -40.3%    7597041 ±  3%  perf-stat.i.cache-misses
  38933806           +14.5%   44591128        perf-stat.i.cache-references
      3.17           -16.4%       2.65        perf-stat.i.cpi
     18224           +75.2%      31921        perf-stat.i.cycles-between-cache-misses
 7.098e+10           +19.6%  8.489e+10        perf-stat.i.instructions
      0.32           +19.0%       0.38        perf-stat.i.ipc
    184.67           +20.6%     222.65        perf-stat.i.metric.K/sec
  11819123           +20.6%   14249011        perf-stat.i.page-faults
      0.18           -50.1%       0.09 ±  3%  perf-stat.overall.MPKI
      0.26            -0.0        0.23        perf-stat.overall.branch-miss-rate%
     32.70           -15.7       17.04 ±  3%  perf-stat.overall.cache-miss-rate%
      3.19           -16.4%       2.66        perf-stat.overall.cpi
     17772 ±  2%     +67.6%      29795 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.31           +19.6%       0.38        perf-stat.overall.ipc
 1.564e+10           +19.7%  1.871e+10        perf-stat.ps.branch-instructions
  40314687            +5.4%   42478375 ±  2%  perf-stat.ps.branch-misses
  12525837 ±  2%     -40.3%    7473864 ±  3%  perf-stat.ps.cache-misses
  38300912           +14.5%   43866104        perf-stat.ps.cache-references
 6.982e+10           +19.6%   8.35e+10        perf-stat.ps.instructions
  11626044           +20.6%   14016280        perf-stat.ps.page-faults
 4.284e+12           +19.5%  5.117e+12        perf-stat.total.instructions





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


