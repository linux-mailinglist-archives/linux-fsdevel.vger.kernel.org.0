Return-Path: <linux-fsdevel+bounces-29798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B0397DFB2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2024 03:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2125A281828
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2024 01:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F4F191F75;
	Sun, 22 Sep 2024 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZbrqucBU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2D51917C8;
	Sun, 22 Sep 2024 01:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726966895; cv=fail; b=lV2dZua+/Kj5bEfaM+E6BsjJe92QVLxwsRHF57IOCdiDig9QWDfial5bCEEQBJVa79XB//s14DWzF+KCCP1hEnicnp7dhAKtccWAmSBaqEUveNh0Kl20DrM0m2HqkqcTiWPC4m3AQ48Tex6OAHiYWyX7x2xUkIKIH76LJSzvFW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726966895; c=relaxed/simple;
	bh=mf7tFu77rwUdtMhSQgsBgX2YHhs88GMP+KunhDTgJak=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XogL1lKKj5aoZRiWILV7rRD+elDHVzyXUi49X9WOwxnhWVMzj1fEZh9lEBJNt6hE8GAQ/0Ioeq1qBBctCvHrZfjmjHjgYuYrX0wXKeFysBNd7xkARG+jIutDLTDeQ69OwzGIX6kL50QmUDCTwYPWSkD2XtWOvUwImMUfjxhwn1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZbrqucBU; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726966894; x=1758502894;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mf7tFu77rwUdtMhSQgsBgX2YHhs88GMP+KunhDTgJak=;
  b=ZbrqucBU2LgsN/jH3n1wPMmppHAuIgMya3qNxQcB/n2yJnPylpDa0vk+
   QuPMaaRVOf5VDSF59AqgaY8Dz8absDU7V+MDyvJzZZ9ExhlSRz+a4VgY4
   5XAKDQWafDRNqPYn7FVnW+ou99ftWmrlPMGeE5GhbcxFR29pDP+jmsJC5
   EnxeuMF0J2MinAnQAA04bz5OhlUf4bFDkkJk9ZknUCTvgpylfCQ4U6aQc
   4N4LyozS4uXSlf9mz516khQNzrxkYFUSeLBewRCrDylXAphNEGXyU2DH3
   8LnGIk13ZE8wXG8CMOGYrMOIQjfGkeqVevRtLl6onSNFFZqeJYCsvLkat
   g==;
X-CSE-ConnectionGUID: T66PyYN/RaeZAoqK7umPzw==
X-CSE-MsgGUID: az3fnnTjR6CxB2vqh7LteQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="48465925"
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="48465925"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 18:01:33 -0700
X-CSE-ConnectionGUID: NYI1IkgQQl+sgltn3Wxn1Q==
X-CSE-MsgGUID: IP9pAA+kTIWjB4vSFN+Log==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="75243542"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2024 18:01:32 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 21 Sep 2024 18:01:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 21 Sep 2024 18:01:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 21 Sep 2024 18:01:31 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 21 Sep 2024 18:01:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnVpWvayjadAI1l44MyXv/qh8uV9f3R+UPTRUt5MPAvOXhlShyuuO1sU7e9IM+vB6gCd0ODFTIvOgFATUeeZlTPnk8bZwH9mUcpGI+130SD15HxC3GJ1JfP+jrd4SKZlGT7oyUFbGZbrGbVB1MZs2jKLetgnhhd+e8AY4jZnW+h+1aPvcAQePW2j/CdbPUoUi0k+Hyv+WhKqqJzaesgBlVQO9s+JFtOgkwMfEVX7Ixpl1fUPty4PEHrAXHbWuXqA0oL84W7WQwgqPsYYK2IgE6i775dn+1AKRMWH+3TaoN1370caEiuY+oLKUEEsI6gOgtNSO9MUGWwoJ4DtD2//vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VLvs86s5Gd/qKv9CVUbnkjI9CU5ykpSNg92NGfa15I=;
 b=vUW3MfzIH33Ue1DhYvLDZ40/nzZ0YvtmaLSoy/erq1/8TVNIhX5RHPjXEk+XGaGBOTCeJCTwREN3TjnLjE8RUbzRQIimoWS5RmrkHmIZFvG8pNKC/P0VqZkfVd88zxyklF1jRNqWG/izHJxJ9QQ1bPsKM8t6GZRbiues2dr7cREvSB3qZQeocSYfqH0rrkuuYrX45AWMdAh9G/YVt+NO71IDrZm2K5dJ4wexfERfRtJd8dXjf5hKzvy45NDdkczy744F3DOYlAMdWvmrVu/bG3ehGwKn9sO/Zv+sYFBvbTJvsN+KLbPi30Q7CUnI93CSM79DlYZrdbJlKQUZWw/lKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PR11MB8684.namprd11.prod.outlook.com (2603:10b6:0:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Sun, 22 Sep
 2024 01:01:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%7]) with mapi id 15.20.7962.027; Sun, 22 Sep 2024
 01:01:24 +0000
Date: Sun, 22 Sep 2024 03:01:18 +0200
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
	<jhubbard@nvidia.com>, <hch@lst.de>, <david@fromorbit.com>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: Re: [PATCH 04/12] mm: Allow compound zone device pages
Message-ID: <66ef6c5ebd068_109ae294a3@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <c7026449473790e2844bb82012216c57047c7639.1725941415.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c7026449473790e2844bb82012216c57047c7639.1725941415.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:303:b7::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PR11MB8684:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb29a64-e011-4a68-7c99-08dcdaa21435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MJIpMqbev/mCQj/ijxAjAHcyHfPPogu9ZemaLsw15Q6uVob+BimcZEo01gc6?=
 =?us-ascii?Q?Yfqa2vc7WmW+rDX7QfBPs0KLVvuj+EKXCnpvHqWV0NG8UzkYIBt4IErZ6E6L?=
 =?us-ascii?Q?V/2gKmH5/GiaKSo2P3g47ZfGSfdsoJpoW19kgVZBk+yJ40NW0dm2n9phYVRG?=
 =?us-ascii?Q?YQIm/aA+pxiBXCJMKyq5eBf5u+tB7cL7/HqJEvA4tmcgzjkYHpCA4n8cTuu6?=
 =?us-ascii?Q?T0TI0Iyf4sG2nH0Z0fbdJG0W723lVT+diYEFcyyKRcwhB1CaGu59Zph+RZg0?=
 =?us-ascii?Q?bcjKUjigexu/RM6AOu+Xf6QNHCYv3GjDSIiNtsMG+IIAxEXCaUBfWh2UxBVc?=
 =?us-ascii?Q?fc1OK7TbJiGzaFiWTtWDxP2uP2vDxd4CgSTUe29Sn93oENnkS0sm2ja1gNpA?=
 =?us-ascii?Q?rlfJpJJPWMbSKZMtRxmtdYih+7IuzdGBFy4T2//r8mEEQ67sXkvSSNu1zH0e?=
 =?us-ascii?Q?KjOhL9t91Xs91ZpS2diYTKpO4azOSXyhrAp7oPjSjLD1wIBNwm1TMY5mhUzc?=
 =?us-ascii?Q?KtHIGmWHvZFJ0+MgZLecuNKMNjWOtcc6x3osT2iPiFs8xsXg1YyG70HkTE43?=
 =?us-ascii?Q?Sq0Nzg+AvirxN2v7kKtqToJI6KrLlm9mP02/rCbCjQ4VLp/6DZ8K8S3C2VLM?=
 =?us-ascii?Q?zlGGFf7wbi4Q/bGPJh523UXJSnhXF5HDRfEvws9E5alFA75E+VtKwxbIlLfK?=
 =?us-ascii?Q?SXQ3hRCjwPg9u7Ab9WLozx2MccaY11gp41Q71SFZWbc4vjF01Q8eyKPm85U1?=
 =?us-ascii?Q?XJIbm7IIRgoE7JFiUc8pkUOuNa2wab/RZlEpj4p0T847sEjqW+gyCULNHj4J?=
 =?us-ascii?Q?DqajUNj7jDO2CDYqX9qe/6gS5NYJIwRyoLa24wYSzX0y6I/gPeHv+yz3JcRp?=
 =?us-ascii?Q?4Ivtm3QvJv3T5unC0us7k9C6+VIo1+vsXrebQZBvIO91ZPVkDxn38ddxxIoz?=
 =?us-ascii?Q?ap3dxO6v8H3mo1fEclrkpCh9taiil94FH5ZPXyjdvOPnn2OQ1S0C8u8CiKqN?=
 =?us-ascii?Q?vZ62DqkrgB6XXt/lCZZ35Hym0IsOziN86atBi9I6igX5aFHZLenSEpAJtxjs?=
 =?us-ascii?Q?Le42Mri+QRWhuK6VtxqmQM1rI/qjwS3PmZafVEACCruX84PE3o1Thg79lY8v?=
 =?us-ascii?Q?AGgleVpCyWYyzWVoF1ohp8uP9J0A74YnAMKts/TFjsjgNj6KikkWQeVD6R0R?=
 =?us-ascii?Q?3fXNShiMYOTXV0+OCGYuOsocifzGXdwEw+/lOZ6nohjI8/d027x/xPoLwDZz?=
 =?us-ascii?Q?x8Rg0gVmvL9Yj9jKERvRqbRL6WUQmr8SMXmAsK2QIco+g+1y9upr9/TcLpGu?=
 =?us-ascii?Q?vuj/tTCnaaRHjJuU5ELTYRu+0IxIhi7WvgZibON6fzrKUg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?09z/FbmqpCOFvEVijs11Bn78Vt+BolupJS3LyO5UGqQY7J7/oOTzFMl6LzRS?=
 =?us-ascii?Q?qG5rdIILyVKXbR1WCclLDga7aDAfwCkmzd8eu3ncLuUc6AqXzJnH7mD2hqOr?=
 =?us-ascii?Q?/BN/voYhLl6s1q1GRQMjkUbx93yw8hxGEzmOVDioyccgP0c41hGqYnv0avas?=
 =?us-ascii?Q?fk50brn0TYNuoWEASRrxeEjo8fnpGVRmher6rx9o9T8vA5qjxcb5gzzK97Db?=
 =?us-ascii?Q?SWOwigrflvbPGs3OtwlbEF3Q21ChVghg/ToZlW1WXC5Wk+weo2cA6m+XkZZL?=
 =?us-ascii?Q?rtQH9WEPNlBhukZcskaoqJ6aMqNtm0zx43zeupNiZjG+M8/SKphz17O6Na/4?=
 =?us-ascii?Q?nCAZMaQkTTzlvJOTSe2v6qZIFNCl1c0THLNzA6NJMwmDG2Sz2Ew0YdxkER7X?=
 =?us-ascii?Q?sCqSsobmV/2h4Wfh1/W7Bh4O5qbRZ8yMCkflmqbn1aGB4NIeZHX3+/VZggAr?=
 =?us-ascii?Q?/4dxHeHwPqa6v/+kOw8j2p+CE8oICh7cDqH73eHz/9SW5moRwOKfOSZUiVxy?=
 =?us-ascii?Q?SibappDfPkDKevO7mTbyeRaWB5ky6TrL9rhXzA4jrwxnrAEYhiesk9xDfY03?=
 =?us-ascii?Q?yslYgiZraIs3izo3ik6qH38X3jb9gmMALiMcaTPsES7GCHe8atX7E8WIxvua?=
 =?us-ascii?Q?BJs5IpeHE2sDE+d+yCIyUogoLa+Mccv/k3+wwLo/63Cbj3Rll4VrfPMul6az?=
 =?us-ascii?Q?/QmLkLKCUxI/U8fl1nuxd3zvPtPdws9DZ2mfxjyz6q9PfvxpWKm19LHo1syC?=
 =?us-ascii?Q?tt7asb9nTv23/aYIgPzWxsm9PEj29NFPSykeFUyeU5JtGcnSm6Mjimg5ZYf0?=
 =?us-ascii?Q?fOkllGye3RrH8BBBz9CwAdpkGB0enwO+D4Wg6z7z7H9uZri22aT4PssaUPLK?=
 =?us-ascii?Q?W2DKnfhPDA/VB2KpSI6rN17Dtfn5vYu9JQqjuK4ZNXqpWYAFpmTt9nsZN9PR?=
 =?us-ascii?Q?PxIBNjVALsGDT7RuC2lEWo+vminumkltenMCWVWKgT4L5bbDQpnhhbV0dWIl?=
 =?us-ascii?Q?9r9FWLFWK9GLQjjNK8hIMA1avZ9BChSUdzWVKAkGbHRMi2v4Q0PW/Q5ejQpZ?=
 =?us-ascii?Q?F8TfXRyMTPrPXil/4FzvDga8KnifLD35d0LwNhg409vdB9nlhGRbqSkoqkje?=
 =?us-ascii?Q?5oYWGYwMQOLuOYeU5kyhIIHnh9dBVmtWwoSZIcFYdet9477nuYAuk+objVqA?=
 =?us-ascii?Q?UxaHtrRt8JI2ckaKOynanrsQfd+5CA9ODscqMghJnSbZEf/fmoh8B/FM3LIe?=
 =?us-ascii?Q?vCXXkpqRhymdGPBZB4GykCAYL4jOlFTmPXLM3e0K8+VA6krOeNf0DvtrQP1M?=
 =?us-ascii?Q?jQ13c7IZmPkWbzUkqvLEOtiDpVYQXsfUfS2RmhhTkpVBhEDaejJ49nX8VmRM?=
 =?us-ascii?Q?OhLAfX8UzQE5ifWjCPoBlEfujdLdqa3QII59zgmGPDJumqcmNMEk+A60FMr8?=
 =?us-ascii?Q?hhm0e58cZ7EIRDkB+kUq4/TAoScbsPdPwgEUO9DsSciKAsBGq4UMi6DeGLMw?=
 =?us-ascii?Q?9DiS9q9jSTLotjyUYpxyL2BMS1StOPOl71QWeqVKr2ImbglkMg39Pu/bNL7r?=
 =?us-ascii?Q?Lik4qjUmvTfMAfvXHV7UccWH56jR5SBoWTAiPJNk0YOEKT1ERITwG1MlQi/X?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb29a64-e011-4a68-7c99-08dcdaa21435
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2024 01:01:23.9523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Wfm0MjrNGZPjW/FRWwmDvYdLUWuz0dNiUEVpiiI76tbnYZtJZeVzFBZlmWDm2R9Kvs6Jj8hsSvVq9Byf4dqXL/qHwIQvA4OEPAXGB30ECs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8684
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> Zone device pages are used to represent various type of device memory
> managed by device drivers. Currently compound zone device pages are
> not supported. This is because MEMORY_DEVICE_FS_DAX pages are the only
> user of higher order zone device pages and have their own page
> reference counting.
> 
> A future change will unify FS DAX reference counting with normal page
> reference counting rules and remove the special FS DAX reference
> counting. Supporting that requires compound zone device pages.
> 
> Supporting compound zone device pages requires compound_head() to
> distinguish between head and tail pages whilst still preserving the
> special struct page fields that are specific to zone device pages.
> 
> A tail page is distinguished by having bit zero being set in
> page->compound_head, with the remaining bits pointing to the head
> page. For zone device pages page->compound_head is shared with
> page->pgmap.
> 
> The page->pgmap field is common to all pages within a memory section.
> Therefore pgmap is the same for both head and tail pages and can be
> moved into the folio and we can use the standard scheme to find
> compound_head from a tail page.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> ---
> 
> Changes since v1:
> 
>  - Move pgmap to the folio as suggested by Matthew Wilcox
> ---
>  drivers/gpu/drm/nouveau/nouveau_dmem.c |  3 ++-
>  drivers/pci/p2pdma.c                   |  6 +++---
>  include/linux/memremap.h               |  6 +++---
>  include/linux/migrate.h                |  4 ++--
>  include/linux/mm_types.h               |  9 +++++++--
>  include/linux/mmzone.h                 |  8 +++++++-
>  lib/test_hmm.c                         |  3 ++-
>  mm/hmm.c                               |  2 +-
>  mm/memory.c                            |  4 +++-
>  mm/memremap.c                          | 14 +++++++-------
>  mm/migrate_device.c                    |  7 +++++--
>  mm/mm_init.c                           |  2 +-
>  12 files changed, 43 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index 6fb65b0..58d308c 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -88,7 +88,8 @@ struct nouveau_dmem {
>  
>  static struct nouveau_dmem_chunk *nouveau_page_to_chunk(struct page *page)
>  {
> -	return container_of(page->pgmap, struct nouveau_dmem_chunk, pagemap);
> +	return container_of(page_dev_pagemap(page), struct nouveau_dmem_chunk,

page_dev_pagemap() feels like a mouthful. I would be ok with
page_pgmap() since that is the most common idenifier for struct
struct dev_pagemap instances.

> +			    pagemap);
>  }
>  
>  static struct nouveau_drm *page_to_drm(struct page *page)
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 210b9f4..a58f2c1 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -199,7 +199,7 @@ static const struct attribute_group p2pmem_group = {
>  
>  static void p2pdma_page_free(struct page *page)
>  {
> -	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page->pgmap);
> +	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page_dev_pagemap(page));
>  	/* safe to dereference while a reference is held to the percpu ref */
>  	struct pci_p2pdma *p2pdma =
>  		rcu_dereference_protected(pgmap->provider->p2pdma, 1);
> @@ -1022,8 +1022,8 @@ enum pci_p2pdma_map_type
>  pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
>  		       struct scatterlist *sg)
>  {
> -	if (state->pgmap != sg_page(sg)->pgmap) {
> -		state->pgmap = sg_page(sg)->pgmap;
> +	if (state->pgmap != page_dev_pagemap(sg_page(sg))) {
> +		state->pgmap = page_dev_pagemap(sg_page(sg));
>  		state->map = pci_p2pdma_map_type(state->pgmap, dev);
>  		state->bus_off = to_p2p_pgmap(state->pgmap)->bus_offset;
>  	}
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 3f7143a..14273e6 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -161,7 +161,7 @@ static inline bool is_device_private_page(const struct page *page)
>  {
>  	return IS_ENABLED(CONFIG_DEVICE_PRIVATE) &&
>  		is_zone_device_page(page) &&
> -		page->pgmap->type == MEMORY_DEVICE_PRIVATE;
> +		page_dev_pagemap(page)->type == MEMORY_DEVICE_PRIVATE;
>  }
>  
>  static inline bool folio_is_device_private(const struct folio *folio)
> @@ -173,13 +173,13 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
>  {
>  	return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
>  		is_zone_device_page(page) &&
> -		page->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
> +		page_dev_pagemap(page)->type == MEMORY_DEVICE_PCI_P2PDMA;
>  }
>  
>  static inline bool is_device_coherent_page(const struct page *page)
>  {
>  	return is_zone_device_page(page) &&
> -		page->pgmap->type == MEMORY_DEVICE_COHERENT;
> +		page_dev_pagemap(page)->type == MEMORY_DEVICE_COHERENT;
>  }
>  
>  static inline bool folio_is_device_coherent(const struct folio *folio)
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 002e49b..9a85a82 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -207,8 +207,8 @@ struct migrate_vma {
>  	unsigned long		end;
>  
>  	/*
> -	 * Set to the owner value also stored in page->pgmap->owner for
> -	 * migrating out of device private memory. The flags also need to
> +	 * Set to the owner value also stored in page_dev_pagemap(page)->owner
> +	 * for migrating out of device private memory. The flags also need to
>  	 * be set to MIGRATE_VMA_SELECT_DEVICE_PRIVATE.
>  	 * The caller should always set this field when using mmu notifier
>  	 * callbacks to avoid device MMU invalidations for device private
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 6e3bdf8..c2f1d53 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -129,8 +129,11 @@ struct page {
>  			unsigned long compound_head;	/* Bit zero is set */
>  		};
>  		struct {	/* ZONE_DEVICE pages */
> -			/** @pgmap: Points to the hosting device page map. */
> -			struct dev_pagemap *pgmap;
> +			/*
> +			 * The first word is used for compound_head or folio
> +			 * pgmap
> +			 */
> +			void *_unused;

I would feel better with "_unused_pgmap_compound_head", similar to how
_unused_slab_obj_exts in 'struct foio' indicates the placeholer
contents.

>  			void *zone_device_data;
>  			/*
>  			 * ZONE_DEVICE private pages are counted as being
> @@ -299,6 +302,7 @@ typedef struct {
>   * @_refcount: Do not access this member directly.  Use folio_ref_count()
>   *    to find how many references there are to this folio.
>   * @memcg_data: Memory Control Group data.
> + * @pgmap: Metadata for ZONE_DEVICE mappings
>   * @virtual: Virtual address in the kernel direct map.
>   * @_last_cpupid: IDs of last CPU and last process that accessed the folio.
>   * @_entire_mapcount: Do not use directly, call folio_entire_mapcount().
> @@ -337,6 +341,7 @@ struct folio {
>  	/* private: */
>  				};
>  	/* public: */
> +			struct dev_pagemap *pgmap;
>  			};
>  			struct address_space *mapping;
>  			pgoff_t index;
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 17506e4..e191434 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1134,6 +1134,12 @@ static inline bool is_zone_device_page(const struct page *page)
>  	return page_zonenum(page) == ZONE_DEVICE;
>  }
>  
> +static inline struct dev_pagemap *page_dev_pagemap(const struct page *page)
> +{
> +	WARN_ON(!is_zone_device_page(page));

VM_WARN_ON()?

With the above fixups:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

