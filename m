Return-Path: <linux-fsdevel+bounces-51117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3D0AD2F3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 09:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3851893CDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 07:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5629280320;
	Tue, 10 Jun 2025 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PV9MPXeB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5975E21018F;
	Tue, 10 Jun 2025 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749541890; cv=fail; b=c7EwDeGPE8CwFCdsGeWCGUpBFnkJq1Mt4pkciPRPqHfGXwhfYj5Bt3msFmyEM/9zr3p9hniPgLlbiHs/QYnkwnEW7eqOEnSO6TNMLWnaANAXSNRnHpiwpd+EIGI4R0H0Ve0kmykXHuYkOVTpzOHAz1l8RQIjvJWP5E9i0Zvp6fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749541890; c=relaxed/simple;
	bh=tZwt7kgg330FahBHONmBlQsf9kWRFnwQrtNJRMGayic=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NQvUx+axboT0FAnMn/liPhFvCoGPzEw7xAOiFfwhX09kLlm3KUl8puehobw/MXyAKy+LeeQfYbmWTB4MqtS9dV4SUh35YEWmDDn1kEp688NlURMFKeUcDVY18zc3T+ZPmKwwqmcgPPmr95O1jdg5QMEn19Z3LLTFZKyK15MbZtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PV9MPXeB; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749541888; x=1781077888;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=tZwt7kgg330FahBHONmBlQsf9kWRFnwQrtNJRMGayic=;
  b=PV9MPXeBrWk1E52Kf9P+tc4QtinB8CY6fuP8jj3oGaSbMbgH0aiU2XnN
   qKwR652MIr/MARLDMPCUTi7qOrtfZTzva+AFQa9h2Rfof+Jsb71ZxTt8C
   JHoO2KHiYm1Tj6gNk96y+QG5AkWRFoZdZ7eCDqBQK9mCysPv9LMvMCTNH
   y62n0JlhhWj+3S2788v6KLRoRTcVugJU/cFQBqilpzaUq41qVL2iodmac
   WPpVSOgPTE8qaG6vis6JiC7XQ7ZnR6uxKX/9N0UVcKFn1DU/b9Ad5AwkI
   /bsRkpZSaYK5xO02I4dWNz3wzpjeMTBTijUUvZSThR2cZXJKxu4Ld75jE
   g==;
X-CSE-ConnectionGUID: ylCGaHIKRf2cf0Iv7xHCJQ==
X-CSE-MsgGUID: XdbqOp6GQHKsKTHRzC3F7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51516021"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="51516021"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 00:51:27 -0700
X-CSE-ConnectionGUID: BpQ/UILLSTiOrrMKqaI5nQ==
X-CSE-MsgGUID: k3rBZRybTqe6So/dg8K8Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="151907557"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 00:51:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 00:51:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 00:51:25 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.81)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 10 Jun 2025 00:51:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzDzVSW8pd1y4ty+FHelINjunkMAW+HNWQkjycv8w/kNMnAtdVoGBKpDxRHnmXHSuZ8Wez02xSHRkRiZUUuefBSHVE+njHKTF8t8X/PZd0D7XJjKbE4WOyiK2DXEwJtlF83JFrGAS0Sc49MySVUO1Tb1mRUgy7RFh3eEBq80oX7oKeUAsxF4wGmN/9N0v8RUrcSKugMBZnj8HC0ihY61qLxYLTlztehFhSYwBQn6fbHZqu1QuQ85JH+7cKh7+JDwFihAWEhdtBnd4YZL/+FIrWrGUm5qS4E3WFqWxtv1s/EFlvi/59FqEO8d3p1S0cL43t9LWTwwW1KprQbhv9msDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NSYIXNDODrDzvpXxnguYUZj5+xneSJrxsQum9Gs5Fk=;
 b=lfCEW/4LBLOajnxIsqv0oXG9dzdXE7kZD9cP4/kQFACB+sl3AJSF9PHIiBX00vAReeuY4KL/Z+jS8YXHLcNUHbHUMywc9sMvSZSy93drhpnrrlMW8wPJq+ZXhkeXbVYF5HVf0JvQJto+IZ2Mlj27h7gfit/2JP8mhK0WfFxVZj1QuxeIXIIsMMH/+PryVot644YKR1VHACpX5ayJCCQ8/YadEfD+PSWc7UEdRyHAlTDrpy6lzn2hJ/Tu31otrohFdO2u18FLr5JG9FxMYi8s9o4OIBXeKeSrctPedjryOeqIBw1k35VdgmazsyT6sKD490PkDoUaZ31kpE1TFFBSzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB8455.namprd11.prod.outlook.com (2603:10b6:510:30d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Tue, 10 Jun
 2025 07:50:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 07:50:42 +0000
Date: Tue, 10 Jun 2025 15:50:26 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Suren Baghdasaryan <surenb@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <akpm@linux-foundation.org>,
	<Liam.Howlett@oracle.com>, <lorenzo.stoakes@oracle.com>, <david@redhat.com>,
	<vbabka@suse.cz>, <peterx@redhat.com>, <jannh@google.com>,
	<hannes@cmpxchg.org>, <mhocko@kernel.org>, <paulmck@kernel.org>,
	<shuah@kernel.org>, <adobriyan@gmail.com>, <brauner@kernel.org>,
	<josef@toxicpanda.com>, <yebin10@huawei.com>, <linux@weissschuh.net>,
	<willy@infradead.org>, <osalvador@suse.de>, <andrii@kernel.org>,
	<ryan.roberts@arm.com>, <christophe.leroy@csgroup.eu>,
	<tjmercier@google.com>, <kaleshsingh@google.com>, <linux-mm@kvack.org>,
	<linux-kselftest@vger.kernel.org>, <surenb@google.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v4 6/7] mm/maps: read proc/pid/maps under per-vma lock
Message-ID: <202506101503.903c6ffa-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250604231151.799834-7-surenb@google.com>
X-ClientProxiedBy: SG2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:3:18::32) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: 5481c793-4168-42e6-25c9-08dda7f37ff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sElkAi5b3tR1WXAyy16Ff7KU+nlWL1KjtXvvEWFQYC5bU6Eh5k5tAvCivKGd?=
 =?us-ascii?Q?udHu/nzkDxQ1tWQ9W0mSt1KnUMJvPHYMWRPUzjgpCmEkhEVS+9G3uzvpv5LO?=
 =?us-ascii?Q?Bzt1YtuZ1BQ95kYfBgowLG11Th/6ssF1wrEzxnbbDY1Y9p0cuAedWnnS2H9v?=
 =?us-ascii?Q?lSvw7HTL0kM2X2ldR+RPxD3Ucx6DPRr2aZvXdRgTvrO3oESRLF9TVm/cxjAE?=
 =?us-ascii?Q?BncQzMBwHq4jMeRnWUi400ISlx7nSfVTZQLdvp1tmD2LHcbkakUkcgoJkPhG?=
 =?us-ascii?Q?ayF51eNISJ9WKSPSW/67PUG7ex1L5UH6IOUYtKvHKyKl9XhRwZp+Lb3X7VeE?=
 =?us-ascii?Q?agXcpCbxmY8+uItb6KkTfkARDnSMfKDR0iF/yain/h/uUQGOaGqmsfTitolm?=
 =?us-ascii?Q?XR2WWRy9WO/0qs/MievrlIy1R6eD5A3AGwjG7E7ztwqhmKuGJEEEDJzTeB/L?=
 =?us-ascii?Q?pzQYF3WVKOf2Pqow8Zlguf+dex9AGUWTKId8DnbutZ/lfwDYi9cUl/i6MR+e?=
 =?us-ascii?Q?SOvmKfNw3NHL+Jwq2CTFLy7fNfsnwJ9VikU7wKM5dzVAj1hwqxT5ZPtV8WKE?=
 =?us-ascii?Q?ro6fPtZQZ1XlPzBKy5gUrpF8zjmOSVa7bdoxS7uMb4+TkWREhkG2j277frmL?=
 =?us-ascii?Q?tIRvdlY0mByOq0+MVXK5REeCge9Q82/RUAKuZj+lTIEDruUHjOJlJOco4ntX?=
 =?us-ascii?Q?MGbSgkDWBZxALGMk3QH1IrXQ3IumIbOwSXGh4kHMSrrkOtwZBb8NR1XHXoi+?=
 =?us-ascii?Q?gKBS3q/WbIdrY/jVzRrPFJe30RxB10CzMzlmgZ5KNLrDXnQ7shtEl2VnoU7q?=
 =?us-ascii?Q?GBTh+uXB7vsh27OX42TFd273gs2pX1c4IdzUTWZTHAIYLCQ82JulWdzguHQc?=
 =?us-ascii?Q?JbDWWA9nL5mtbNIkKS8NIJ3O2I1Ecf/M8jWEOKkonfX9nhSHdzu5LoP44+t6?=
 =?us-ascii?Q?azRup9ZZtMI3FM8naRUioZfSUht1EOzg57if/8lVjXRfBI2Hs3Ho1Lai/EsD?=
 =?us-ascii?Q?1gtyyczs2KCIeKwcD5vhxJUjazGJWD6l+ZcvlXCBdll7WrdvAJ50CvoHwNbe?=
 =?us-ascii?Q?ORYsAIPx6ldaZJ/P5OCVqKI1eZLpmRoPUTXWVH/OTEnB90VptxaxZza0KSHh?=
 =?us-ascii?Q?kF5h0Ci+84deHL7xymfD41AtGV/EI1Jh8YFG2fg290LYFE5FvJAf9XfJw9cL?=
 =?us-ascii?Q?6eUjmA0tiS2/vkXq+8nraL+AEdslhBp08Pljbpz/y8oRjSZ5E4HN0gRs0ZDS?=
 =?us-ascii?Q?o39mNhOLRFzeftzB9TGwD9lWeXCJBJSfPEufb5Gc+brdfkFBdGAGVq1iVA8z?=
 =?us-ascii?Q?Z9he/okZPlHj+a5L9StBT7dTLTuVKhewXV9NjfZaMtiKd6tuWoZEpZAAK8NK?=
 =?us-ascii?Q?59TtLFgNtOuG91aAGBHkKKnfyycs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JgyDdMioIHHqc8aAGjKqx9HK2FZlMbTaQN8fVumlRYnj1E1pZBs82yUYHyNH?=
 =?us-ascii?Q?8F62Qhn4lwteMUi5X/YiOei/rH93Mi3rlA1PADT+n36D3pA978eoGFBeAc+j?=
 =?us-ascii?Q?z4J5hHnRJoNpj0N7gdKnihUE0rTJJJodiMCLktBvXj8YxoxBROePbwr+qQth?=
 =?us-ascii?Q?gez+TjV+EvUqMqHww4+O9QibNb8T+ItrgXaLJYTvyAu6IFy4zu/l0yNCGg0L?=
 =?us-ascii?Q?rGrwjJWuIzrBGsLXRPb6aHjsO6EkcZqlvbi1TBLFDppyxBBHLxdFpmvx+pO6?=
 =?us-ascii?Q?ckd9J268Ns80UtTsfIuQn2TYCkN2hY+0SYpo77A9BS0//tN6sGY738VIrVt7?=
 =?us-ascii?Q?bpIwGW48ysur4BDkxGaLbVqawaTowyTQFi8XQLZXzGwSO8uDoWPJpieZOKCg?=
 =?us-ascii?Q?g2NpyXjLwJ9OdGZlY2SM+Sh3M8DbGy8tFhqiXsPn5IG9DDhbMAs5E0mrZTNi?=
 =?us-ascii?Q?FD0W8LrDZhomBm2lTefIubbXwzFn9UgfyHVJ95lr8yGt7aQ1AOYCKD6mL0PR?=
 =?us-ascii?Q?0UyYVRcQaEqstU16Y22ENizbcjovKZNz5qRRIQY+NziOLArMQt+UxW8IEQWH?=
 =?us-ascii?Q?beGJF3KdDLCXZnRr5PXKagiUkWstR5AW3xgNvs0/Rml8zmMBMmxSrfl+UkAH?=
 =?us-ascii?Q?ZrwW8wwX0seGgav4m+x8QssHB5VB3DI0S6KtTjrFrvWL+doIijGqKJXQEiuW?=
 =?us-ascii?Q?gfFhw96/IyEURi6DQ9m1N3c9pSlYS1bezgqjFJjLBm4yTuIFxVHRl4bcmhsn?=
 =?us-ascii?Q?fmPf+iAVAOmyd0tKEKGv9qAUWWn+9+ipnpV4Y4g662L5Sb1R+v9lAq9GQCim?=
 =?us-ascii?Q?Y4U0QMaYgMe9uUWTFwxvbeuOBNJin7yrv7Rw2L1gSMZLlHs2qNayvLM1Pq2/?=
 =?us-ascii?Q?tkydDVw1b22eH2v361UBJK32wqXy7tXPGr0glR6iTzN0OZisvIpWNfrCvkIw?=
 =?us-ascii?Q?nTSmud8j3+7L2/VOFNbxyRjcQM81C05LnGcpi+P12GnuAQ3mJnYxMpbZj6jf?=
 =?us-ascii?Q?BfmBBTXwbwqNKwx75cLwp6m2i9S5NTMC9DqEhhwDcqaVFlVN7egUZ3r6AdNo?=
 =?us-ascii?Q?KUvlJMSOH5x0e/evrTnxKOwwcMF4PSHB8NEAlOQ4TlQhFhBrMsaTaakRWyG8?=
 =?us-ascii?Q?JhgT9tV/J8yayYFP8iEqYONWG1ztkKx3qo0PQAh+URSa0uhV5kTh1c5Uar4L?=
 =?us-ascii?Q?Zazf5QmllD66WnBMMBlxX/da+fusVOFQSklD2Qle4mQyGcA+zYBdDTK1TcVB?=
 =?us-ascii?Q?aFPdLEqed+e295Jw73yczOhPSrjuRI4hJ48AAxnGav5NOSqxOWDipQRjYzmH?=
 =?us-ascii?Q?cVD4F+75xyFnuxYfQOuWH63aOGIoGSmBCG5oCWYV3uvclqc2xQFO4iT/z+RU?=
 =?us-ascii?Q?jKyMIXl5DCxHDq2BxCuwH8GVSeRaeMAF+VG0A5D3QxKPC7o0oHmIfWT0LjOk?=
 =?us-ascii?Q?OIbiuOZMieRl5QktMI7MuBgVcEkJ7utyIhL4TdMfcIVBdcVZs0gsXi1+FFg5?=
 =?us-ascii?Q?mwI8vfcTXZZo6j8uK/58UtqsUmj5Y2+VIYa+ltCuvDQ/RweC4hneiXquKfAO?=
 =?us-ascii?Q?xgcOCzBXrt0f36+0Bb+72l86TYUrWG8/kuuVtA3yIngxHFcy20uoG1GUeSCL?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5481c793-4168-42e6-25c9-08dda7f37ff6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 07:50:42.5337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyQtpCzhgPbkJ3sCLdsl52J3XaoP9bPH6Oa4SyIprr3pZkTPEmqeAstg4LG7jDXDEIG7pRc1zkFmZsZ5CU+4iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8455
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_include/linux/rwsem.h:#anon_vma_name" on:

commit: 5c3ce17006c6188d249bc07bfa639f2d76bbd8ac ("[PATCH v4 6/7] mm/maps: read proc/pid/maps under per-vma lock")
url: https://github.com/intel-lab-lkp/linux/commits/Suren-Baghdasaryan/selftests-proc-add-proc-pid-maps-tearing-from-vma-split-test/20250605-071433
patch link: https://lore.kernel.org/all/20250604231151.799834-7-surenb@google.com/
patch subject: [PATCH v4 6/7] mm/maps: read proc/pid/maps under per-vma lock

in testcase: locktorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug



config: x86_64-randconfig-005-20250606
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------------------------------+------------+------------+
|                                                                               | fa0f347301 | 5c3ce17006 |
+-------------------------------------------------------------------------------+------------+------------+
| WARNING:at_include/linux/rwsem.h:#anon_vma_name                               | 0          | 10         |
| RIP:anon_vma_name                                                             | 0          | 10         |
+-------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506101503.903c6ffa-lkp@intel.com


[   41.709983][  T353] ------------[ cut here ]------------
[ 41.710541][ T353] WARNING: CPU: 1 PID: 353 at include/linux/rwsem.h:195 anon_vma_name (include/linux/rwsem.h:195) 
[   41.711251][  T353] Modules linked in:
[   41.711616][  T353] CPU: 1 UID: 0 PID: 353 Comm: grep Tainted: G                T   6.15.0-11198-g5c3ce17006c6 #1 PREEMPT  ce6b47a049c5ee6720891bd644c96f2c3c349eba
[   41.712738][  T353] Tainted: [T]=RANDSTRUCT
[   41.713101][  T353] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 41.713902][ T353] RIP: 0010:anon_vma_name (include/linux/rwsem.h:195) 
[ 41.714327][ T353] Code: 74 28 48 83 c3 40 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 ac 4b 02 00 48 8b 03 5b 41 5e 41 5f c3 cc cc cc cc cc <0f> 0b eb d4 48 c7 c1 74 46 b4 89 80 e1 07 80 c1 03 38 c1 7c 87 48
All code
========
   0:	74 28                	je     0x2a
   2:	48 83 c3 40          	add    $0x40,%rbx
   6:	48 89 d8             	mov    %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 ac 4b 02 00       	call   0x24bc8
  1c:	48 8b 03             	mov    (%rbx),%rax
  1f:	5b                   	pop    %rbx
  20:	41 5e                	pop    %r14
  22:	41 5f                	pop    %r15
  24:	c3                   	ret
  25:	cc                   	int3
  26:	cc                   	int3
  27:	cc                   	int3
  28:	cc                   	int3
  29:	cc                   	int3
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	eb d4                	jmp    0x2
  2e:	48 c7 c1 74 46 b4 89 	mov    $0xffffffff89b44674,%rcx
  35:	80 e1 07             	and    $0x7,%cl
  38:	80 c1 03             	add    $0x3,%cl
  3b:	38 c1                	cmp    %al,%cl
  3d:	7c 87                	jl     0xffffffffffffffc6
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	eb d4                	jmp    0xffffffffffffffd8
   4:	48 c7 c1 74 46 b4 89 	mov    $0xffffffff89b44674,%rcx
   b:	80 e1 07             	and    $0x7,%cl
   e:	80 c1 03             	add    $0x3,%cl
  11:	38 c1                	cmp    %al,%cl
  13:	7c 87                	jl     0xffffffffffffff9c
  15:	48                   	rex.W
[   41.715798][  T353] RSP: 0018:ffffc90002dcf9d8 EFLAGS: 00010246
[   41.716286][  T353] RAX: 0000000000000000 RBX: ffff888135319c40 RCX: ffffc90002dcfa78
[   41.716889][  T353] RDX: ffffc90002dcfa70 RSI: ffff88816ea2bc30 RDI: ffff88816d7485a8
[   41.717509][  T353] RBP: ffffc90002dcfa80 R08: 0000000000000000 R09: 0000000000000002
[   41.718117][  T353] R10: 0000000000000000 R11: ffffffff81ebd610 R12: dffffc0000000000
[   41.718710][  T353] R13: ffff888135319d10 R14: ffff888135319d10 R15: dffffc0000000000
[   41.719318][  T353] FS:  00007f17e7a81740(0000) GS:ffff88842312b000(0000) knlGS:0000000000000000
[   41.719998][  T353] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   41.720503][  T353] CR2: 000055c5de49dc78 CR3: 0000000135bcc000 CR4: 00000000000406b0
[   41.721114][  T353] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   41.721717][  T353] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   41.722373][  T353] Call Trace:
[   41.722640][  T353]  <TASK>
[ 41.722881][ T353] get_vma_name (fs/proc/task_mmu.c:?) 
[ 41.723253][ T353] show_map_vma (fs/proc/task_mmu.c:509) 
[ 41.723617][ T353] show_map (fs/proc/task_mmu.c:525) 
[ 41.723922][ T353] seq_read_iter (fs/seq_file.c:231) 
[ 41.724311][ T353] seq_read (fs/seq_file.c:162) 
[ 41.724653][ T353] vfs_read (fs/read_write.c:570) 
[ 41.724981][ T353] ? do_syscall_64 (arch/x86/entry/syscall_64.c:113) 
[ 41.725384][ T353] ksys_read (fs/read_write.c:715) 
[ 41.725703][ T353] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[ 41.726174][ T353] do_syscall_64 (arch/x86/entry/syscall_64.c:?) 
[ 41.726538][ T353] ? find_held_lock (kernel/locking/lockdep.c:5353) 
[ 41.726900][ T353] ? exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:109 arch/x86/include/asm/irqflags.h:151 arch/x86/mm/fault.c:1484 arch/x86/mm/fault.c:1532) 
[ 41.727288][ T353] ? do_user_addr_fault (arch/x86/include/asm/atomic.h:93 include/linux/atomic/atomic-arch-fallback.h:949 include/linux/atomic/atomic-instrumented.h:401 include/linux/refcount.h:389 include/linux/refcount.h:432 include/linux/mmap_lock.h:142 include/linux/mmap_lock.h:237 arch/x86/mm/fault.c:1338) 
[ 41.727706][ T353] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:473) 
[ 41.728190][ T353] ? exc_page_fault (arch/x86/mm/fault.c:1536) 
[ 41.728590][ T353] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   41.729073][  T353] RIP: 0033:0x7f17e7b7c19d
[ 41.729432][ T353] Code: 31 c0 e9 c6 fe ff ff 50 48 8d 3d 66 54 0a 00 e8 49 ff 01 00 66 0f 1f 84 00 00 00 00 00 80 3d 41 24 0e 00 00 74 17 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 5b c3 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec
All code
========
   0:	31 c0                	xor    %eax,%eax
   2:	e9 c6 fe ff ff       	jmp    0xfffffffffffffecd
   7:	50                   	push   %rax
   8:	48 8d 3d 66 54 0a 00 	lea    0xa5466(%rip),%rdi        # 0xa5475
   f:	e8 49 ff 01 00       	call   0x1ff5d
  14:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  1b:	00 00 
  1d:	80 3d 41 24 0e 00 00 	cmpb   $0x0,0xe2441(%rip)        # 0xe2465
  24:	74 17                	je     0x3d
  26:	31 c0                	xor    %eax,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 5b                	ja     0x8d
  32:	c3                   	ret
  33:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  3a:	00 00 00 
  3d:	48                   	rex.W
  3e:	83                   	.byte 0x83
  3f:	ec                   	in     (%dx),%al

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 5b                	ja     0x63
   8:	c3                   	ret
   9:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  10:	00 00 00 
  13:	48                   	rex.W
  14:	83                   	.byte 0x83
  15:	ec                   	in     (%dx),%al
[   41.730862][  T353] RSP: 002b:00007fffc13c12e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   41.731448][  T353] RAX: ffffffffffffffda RBX: 00007fffc13c138c RCX: 00007f17e7b7c19d
[   41.732038][  T353] RDX: 0000000000002000 RSI: 00007f17e7a20000 RDI: 0000000000000003
[   41.732635][  T353] RBP: 00007fffc13c1390 R08: 00000000ffffffff R09: 0000000000000000
[   41.733252][  T353] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000000003
[   41.733850][  T353] R13: 0000000000001000 R14: 000055c5de485951 R15: 0000000000002000
[   41.734481][  T353]  </TASK>
[   41.734719][  T353] irq event stamp: 3793
[ 41.735058][ T353] hardirqs last enabled at (3805): __console_unlock (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:109 arch/x86/include/asm/irqflags.h:151 kernel/printk/printk.c:344 kernel/printk/printk.c:2885) 
[ 41.735754][ T353] hardirqs last disabled at (3814): __console_unlock (kernel/printk/printk.c:342) 
[ 41.736478][ T353] softirqs last enabled at (3488): handle_softirqs (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:426 kernel/softirq.c:607) 
[ 41.737219][ T353] softirqs last disabled at (3835): __irq_exit_rcu (arch/x86/include/asm/atomic.h:23) 
[   41.737925][  T353] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250610/202506101503.903c6ffa-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


