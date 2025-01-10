Return-Path: <linux-fsdevel+bounces-38836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01576A088BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 08:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A161D188B8D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 07:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C71B206F35;
	Fri, 10 Jan 2025 07:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R5Apyg84"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF87C1CDFD4;
	Fri, 10 Jan 2025 07:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736492833; cv=fail; b=NCj5Yf0slCfpclc5X3goy6+2KOj+ICkTK+YmoBACPcH9E5QxdupdBPpcezgAIewWmqNep5UHjLsWLgY6Ril5DOVdR5VzbVEpmVV/XBNPcHqu5cJvxtArPxKnCeLgd0K/HhS/HdRRkSj4wvyVPLW/wTzR3c1YlKPOW24FXpkFudI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736492833; c=relaxed/simple;
	bh=vXXCBo3bO38XUj32AdGRiw5axFr1Jj47iMUm7aZQQ+g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W4vJS9fGdi6FuQxOF7YjC5j8MEhRX/5TN/gSN7MIOnxWicbkPuTeI0s83Ktu4sRPW4YICO/YzmSqgrdDAHQcB/Gl2oP5WOubwMcrJVb2aDlnNRxlRsfQ2JrAS/w/DBk8FRwHdHnoTgH8Ub8UbKN9GMzER5Y81B6d+0mOtp03knA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R5Apyg84; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736492833; x=1768028833;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vXXCBo3bO38XUj32AdGRiw5axFr1Jj47iMUm7aZQQ+g=;
  b=R5Apyg84Vg7rMpyFFaTTlXo/FhdSfUDxufsrne3o3C3pCebRDuDA8HNZ
   cJMtnkKQf0bWW7J3JSbGNBHzJ70l+QXoR5/Y1M02lxG6wwdrt6TI5Ni04
   SN2efM6FiNTm8kX/tbi8R2uZxMDo9+/m3pyXnxyDpZGU8/fQ/nrY97n/3
   XcoFJ//RcujKSm6Yf54E1sMiWtukPgI5Hzs/7Vpeul2YMQxlKg6liBlA7
   QqZM59IaSJE2jNSLHZ2Ae5OOIi/tyMh42iBFHmveiO+H8zdY/EVzk+yAp
   yHgzJvtJpIaTaFJAp0Ua26qfwMAs+QM01yfZJ89gO4MTbXQbk9yhy8Qru
   g==;
X-CSE-ConnectionGUID: 3ZGhNrJGR/6zRsYur8tDuA==
X-CSE-MsgGUID: nmUDxALqROaHk8g75XCMFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36660805"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="36660805"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 23:07:12 -0800
X-CSE-ConnectionGUID: 1CM8iotrQlKqukuVxaaUwA==
X-CSE-MsgGUID: 7TzszsyTR8mgdVrKTRDCLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108758806"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 23:07:11 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 23:07:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 23:07:10 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 23:07:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7W5pIJrzAlHiF1WoLxKYs0SUDvZui3xnn4oGRMKDKPr1tG2QP5EFGGljgwvTkWzLQ4WLrVv4T08wAIzWBmpcT2bD5ngvQrGvUxOR4I5tm6LZO4Y/4cro3hmBccZH0qM5NhZAQ2vuoT33qsgOnJo7+3EHlbYCSzV30htroQkd2LKoFchBRFnlllVC30sx4sxFpJG5kJjFH+ZafL7Kh7lEOuxZ7W9EYMOgOLuiTFjpkMf24cerypz95yc+BSaGe3OJFzgQMoD/AbW0tWXKYzT6wZKWQbACysFCywe+yK9mbmrSEZo1Oc00qe6BRB/8qJaJUi3hprm9wog1GCnuoAJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLKXOSCulfA1uuFXTaC088qJrOUD2yU33fA2PCq2mMA=;
 b=B4eWesnAWhuAnVN1HAFPkAg7ZclTw+GaiHpRr6Yb6Oj2aESsavlO636aOs0JHQ3QYAmayJTac1Zvr6tvNwk58lPwarwmAKBDXMylKaRJ1Z06N0h0QKy7L4pU40G+eWsQKGV7KNQRPAtKfrR6c7uQOAvasJwsIBR7bjqpzb0QD/BkkpD7c6qZNjhq1VDYb5gKAtYyuDfE1dT2qVyJRrKCMctxyTGez8x3LdvLC/HLGTVJyWHtgBnEcXZClkWoiwJ/jeUvCGehWRScN7W+vOyN1Zc59//StazWG6WnB5GUdjNJga+YTufbqcXH+c/KirM45pjFs4im0hWMC4b04JN6pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5887.namprd11.prod.outlook.com (2603:10b6:510:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Fri, 10 Jan
 2025 07:06:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8314.015; Fri, 10 Jan 2025
 07:06:00 +0000
Date: Thu, 9 Jan 2025 23:05:56 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <akpm@linux-foundation.org>,
	<dan.j.williams@intel.com>, <linux-mm@kvack.org>
CC: <alison.schofield@intel.com>, Alistair Popple <apopple@nvidia.com>,
	<lina@asahilina.net>, <zhang.lyra@gmail.com>,
	<gerald.schaefer@linux.ibm.com>, <vishal.l.verma@intel.com>,
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
	<jhubbard@nvidia.com>, <hch@lst.de>, <david@fromorbit.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <loongarch@lists.linux.dev>
Subject: Re: [PATCH v6 00/26] fs/dax: Fix ZONE_DEVICE page reference counts
Message-ID: <6780c6d43d73e_2aff42943b@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0133.namprd04.prod.outlook.com
 (2603:10b6:303:84::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 363585f2-dd8c-40f8-73fd-08dd31453d35
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3ZCroy0IhliaY/ur1sPhTK8fRH9MfkiNXSreQRRo4Puu6Y8j1kb8XMAqRb0O?=
 =?us-ascii?Q?RUyqosd3Lz8Yo5ASCQzgW35d3ezYulqCD1mGL5jDGthshwVM78Nm5kaWoP2c?=
 =?us-ascii?Q?F50Fsb+myrn3lM34GCEc+d8Eu3P1uTACm2AzK7FZBCMZ6QTF8zGegG7ujSLT?=
 =?us-ascii?Q?+/Ah6RvFErIEc6LKt/R9gqLKDI39P9R3zCgK5pJl+jlxCDhD4qv0R1A4ZnH9?=
 =?us-ascii?Q?DTYG3s69pyd98wpUXIV4+K7vaAh8g1wSAH8/6oNcVq33pO9kPF2/N1QI4tA8?=
 =?us-ascii?Q?QQKxENuYXdCWZ+DmCionF+LqeBoRI9C6rtR8FS84afj+0VNNrob2dOwNnJO8?=
 =?us-ascii?Q?LuYCnhMMO4Hdjo9Z4qz0HlsPdVhxG2VQTErD5IJ/A9HOjHmvhlI2mGPA/Etm?=
 =?us-ascii?Q?tC87f9uwHx3mOq3AJyYz02mkqjV911JSaHD3Ap/JcjupQD+3KgmnEk4/Ss6g?=
 =?us-ascii?Q?juI5tYxjfmVUoTwt/MeO8nySF7SchaDSjUn/iEvyJX2f2uHjDrj+5jioLpfb?=
 =?us-ascii?Q?d70T9c1vZkEz2dGr3JfY1xolnu7evXcpBWynz2S79E6dzCL5P9v6k9xeF9RM?=
 =?us-ascii?Q?9+7MCuM8pOG/Kr8CM9w34TGecVpE7m3pl75WcV4kcYsfvokmjkuEKlFb3xt2?=
 =?us-ascii?Q?akWOqJjdxOjqS+nFd33cm2I+xhlRehT/ot/O/xT6GJx5/NI5bcxkvkHKrDC+?=
 =?us-ascii?Q?F+iox8dbq4Pcwe8b1d/NrwiZNuAGAQmopjkLbIuziM7r4AOnKmF9AN0MVGoy?=
 =?us-ascii?Q?kEb8CdW4QkpUUM/VpBA8fgQ4EGaHj6QMo47QiqjLQJUwNx/vGalp+gavmFD8?=
 =?us-ascii?Q?VH8XvZEiqkRErKFmx/glfgEUlNSkHsPm6fjySV4T6gJDAVpG9M7cYD3fGKSl?=
 =?us-ascii?Q?VLkz3amQcpg+kCoxl1XKFhdFnZ8qH7GIg6bvQ25f5Qt+rsR//QrXMTWAs+FN?=
 =?us-ascii?Q?PWfHxJdg0afGDpS7LZiesk105nAqvZVm5VDfoRQwzhAXviNYbuTsrruKdL4o?=
 =?us-ascii?Q?msDVz5jtvGSjFiCSj4daHO8jaNga0ktGqok6kGXMMbMnGYTYe0d6dW5ikJw7?=
 =?us-ascii?Q?kZJpEHp7c10/d4K20ouPpYoGwdbwHFK8pilc33OIgTz3tIGp/kfM/8JVIBai?=
 =?us-ascii?Q?qmlj9+hgQ/+QCrBchyYeBMqdepCZXDPj2/xd7wwxJt+25OulkCYRwZ3NXq+u?=
 =?us-ascii?Q?pUtC62Iqhj5SCq0DnbSxOJDL0itIBapyjqnt2UY33qxg6L1XXrl39AyIXmH5?=
 =?us-ascii?Q?2GbLpf+YsJ0IXhy8UXJ0r0ioetJ/WfI3cbjAWNi8i14T8OxePwBy7QO/5tXY?=
 =?us-ascii?Q?8nwdagps7OwlpbGGiF3tgEWgadJxKP2ZMWNDUEJrTrHEnALi+kBtcdP1SDoc?=
 =?us-ascii?Q?P5vAqbkUdSa76TK5HD4A2O0uo6RJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xy1+slXwzy8tfhBGnUGls4w0BrLy+yYn/h5j3a+VdFbn6zrlV6w25g+MQulE?=
 =?us-ascii?Q?0PI6duc3UKUJPtghiyHdqDjkxH7YpXm87pxVqrv/sj+mYREzkGtt7hiC0DgY?=
 =?us-ascii?Q?t/ewBZkPsd+44DLjJ+PC+o5S4n6x/3jOSqaZpdtMbP90gZiIu3vP6av+cTAX?=
 =?us-ascii?Q?WcWz9l5I3YPmGZUdDBJ4eeZBURvRI2qYn8mX5JW6ijMAgNBIfuUDGb9UezUs?=
 =?us-ascii?Q?Gj1nN4cY0ITqqEBatd8KKnaOabLXMZsRTnu4roetFASAt9OLZQVQ2wiscdMQ?=
 =?us-ascii?Q?2tKerZ+Ynky3DgtrExPC4NXBsoc8h4IcsVRdc1iiIvdlp+XRHyDQn6UrDkIF?=
 =?us-ascii?Q?0rVhdQzuXv9Y5E4J/59hKEpsrqu97C5w88uWBZGJHf90GZ+Qn21+JpLhfEbM?=
 =?us-ascii?Q?9wQQvsQ8gCXeGnmwTQ+KIVH7GEZThB9JUGGptyjSpWgMQJJ0hjhdu4biyJ/L?=
 =?us-ascii?Q?WVYX1U69eE6tGNVCvczAU2VZfYjrlzhh5kxB65Sg2Xhk2s9Fh9QkwhQQmrj6?=
 =?us-ascii?Q?7LQ0jvW2iF/3m3gYgI5z/TExwia1uoScGgHwhrsuzG/uV+p7WaPtKc57PgPG?=
 =?us-ascii?Q?ugs05c/z9rJ0GFb/wmC09SfN80RSdWQ91yMkmTsZ0MW9Kyxsw8RVnkxzRtyt?=
 =?us-ascii?Q?OnbVBfvEreOVKYtHyn9nCIzRmRgcDb0Py1rFGFuApaqo/ToUiEjR8Ihk1fcg?=
 =?us-ascii?Q?/fJNvgZYZhC+TrWhxwhoqvOX3tU6zTTGfCZMjR+KKCfBrQbqfHyfGjf2SVas?=
 =?us-ascii?Q?iSuRg8qC3BnBgol423m4WKfLRp7BMRpFUZYaaUQOsHUD6lEbdLhNuNIewlCX?=
 =?us-ascii?Q?Rfk8okzGeGStgEv5qygXe99Q4KcZBK4qC0p3BJR6wYi1E+VwnR7e3y8Gcw9r?=
 =?us-ascii?Q?20wx73PvOXfnYQoT3bc6PNzwiAuEXxz5e2RiMn8x+OKb97VYvbUNjDjqk7NU?=
 =?us-ascii?Q?W0FTMzldB01hg7vvJ7S6XqvE/Wvror77EHaNLJiFn9nEz/C/Ksf0FsVX8x2z?=
 =?us-ascii?Q?jkMv4tkRBj1kPNtrwHF2hTKSVnqkVovOjtU0LhgrSR/BI5O/lCYOUvrlpu8m?=
 =?us-ascii?Q?RaxUfLm+GVhA/Kps6gI44Io6nHX+v9OXy6joMGEZ8yM/L0rojr6G7M1hbeNW?=
 =?us-ascii?Q?d2fZbJr+lr2eelsTmcbuGMLPb6X6q5jhttWS16j5JFUdfVevwI2QLc9xChCG?=
 =?us-ascii?Q?8silFE6MqRsOvj3ZGnKU/cj29MdDW2ajvEmrlilD1IWG53LgvqE8lpuF9Pq/?=
 =?us-ascii?Q?VGTCCEtmo/Xb1Li13Km1JaQ51o3uzzfpa6FKTtNyAmkyhwwbf274INMIwXHO?=
 =?us-ascii?Q?32qw0CP++vR939H8Iz9HFtvCg4NkaO7ZFe8djT42Kl6jSN3YY2L+1DCQcyV5?=
 =?us-ascii?Q?VH+gMa2bg24t/U4CQTTKHclgNXoqur9YvupNY3/4ZT+w3v+9FNAEhLD0t6bs?=
 =?us-ascii?Q?H38kLSCijiz54cesnDmppK6eeMTIFKKuZLc4J94jQJEn0eCu5xw2kbqLJt1y?=
 =?us-ascii?Q?FXLqzI+M9nfJqLJJg9m+pYd8xwG44Hu4MM1alj73ImMg5zPBwDcUmQMBb6C2?=
 =?us-ascii?Q?MYeQH1bn6ptr9MARh9I5reFD+pRPsLfe1WITg6vCiN8yeAKTwNWimBxJH8NE?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 363585f2-dd8c-40f8-73fd-08dd31453d35
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 07:06:00.6987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7NavPBy9SUnZLPbz/5TL8Aol6A+Q5YDe4OC/Rk699i7Cd9Wu/GEF7Pt7dSlhETuFqddJRqrDKKyiGP3TwSn4d0+gc7LsvNEeSFD2SXuRrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5887
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> Main updates since v5:
> 
>  - Reworked patch 1 based on Dan's feedback.
> 
>  - Fixed build issues on PPC and when CONFIG_PGTABLE_HAS_HUGE_LEAVES
>    is no defined.
> 
>  - Minor comment formatting and documentation fixes.
> 
>  - Remove PTE_DEVMAP definitions from Loongarch which were added since
>    this series was initially written.
[..]
> 
> base-commit: e25c8d66f6786300b680866c0e0139981273feba

If this is going to go through nvdimm.git I will need it against a
mainline tag baseline. Linus will want to see the merge conflicts.

Otherwise if that merge commit is too messy, or you would rather not
rebase, then it either needs to go one of two options:

- Andrew's tree which is the only tree I know of that can carry
  patches relative to linux-next.

- Wait for v6.14-rc1 and get this into nvdimm.git early in the cycle
  when the conflict storm will be low.

Last I attempted the merge conflict resolution with v4, they were not
*that* bad. However, that rebase may need to keep some definitions
around to avoid compile breakage and the need to expand the merge commit
to carrying things like the Loongarch PTE_DEVMAP removal. I.e. move some
of the after-the-fact cleanups to a post merge branch.

