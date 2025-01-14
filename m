Return-Path: <linux-fsdevel+bounces-39117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CF2A100C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 07:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6784916336A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 06:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113AD23497D;
	Tue, 14 Jan 2025 06:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlRiEkJG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3380A24022E;
	Tue, 14 Jan 2025 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736835174; cv=fail; b=pjWA1w28CszFWmZgqNoOZkTX3IlFbR2jGmso3wV3zHGW9CLvYyOUp/W7O0cmg+JdO7nWBJQXsCuVId63iJJi2/O+Xh3/+NFA/NN6aL175skBpwOF/NamHfkwxwhWf6CU5QvFjr7nGqeLt8J4IScIzSAAam7nVW/wCQ89ufKIJU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736835174; c=relaxed/simple;
	bh=KEmS1Z299WnqpeOIPpWE9WpBQm5aeOU7PZ93d/CzbY4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e2GH7FjXwogun4LUvNFA/GqAtmmm2LjwulY8cqw+UOVeg9ggOzOuxm0g4lq5kK6Jk+kMOGbSIXM2uGQcui/gDDsPodJj8zQTQUH+yKw/MGAL5EoS4pFSVQbEDEoVLoRAdbBlUSekeAff8spG3CbwEkzZlqIoXZzlm4i8ZD7tpLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nlRiEkJG; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736835172; x=1768371172;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KEmS1Z299WnqpeOIPpWE9WpBQm5aeOU7PZ93d/CzbY4=;
  b=nlRiEkJGgZi/gmiqN0NKS28MSCNT0CdOn+C9KFX0B+WiuNipzmUoc9tL
   YebU91fqOEpPwD8FpdbfW6UP2EX/OpQHuhM63ARF+nLsAmBXc7emI3BUQ
   5yi4Fwihxq8/UuAY5SWT3DvbFqQ+P3WmZkHW2vl5GZO/L3dvAAcutqJxy
   iPBSHj0Xt8S35y1w1+hxP9fZPmlniaswqtnHs6cKTiPtD2MaRgoqXi3p2
   tMya820lc/nEIwnGJS8NR0peRfmUmvsEcvGzthx0BpIcDXkoSjqUsOKtS
   waPQsLgLZuP+hQoyWGKMJYV4tpe2XNwqH4QYiE3d678Fmpr3rq1u+aqft
   g==;
X-CSE-ConnectionGUID: 8eXvamEtQ9Oleq7jeJqdOg==
X-CSE-MsgGUID: Kk1G+pOXSASCAeQVhk7J5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40796906"
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="40796906"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 22:12:50 -0800
X-CSE-ConnectionGUID: O8SaAUFXTs2y/LLUMLcaiQ==
X-CSE-MsgGUID: bdo4BKOQQVCWJjYvwrPZfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105589580"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 22:12:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 22:12:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 22:12:48 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 22:12:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgT5bD1n1UqxcJ1crFhf5RZfepsuq+Z4jyzvG40Pg0wundq6iZ93H0g5AkF7LIKlt5U1o2eWEGMphyE3SXL1Zl6yQgvCC+HiWguZxM5bwU6aT4h74tAds34s6fi2G41sAfyrSii8mpOi91eP3RqCB4WUX0RQl0dzuUNArkn1omfIgev2HCCh0a5bpnzsqsJaMyshjHnymtrl3ut7UivW/SOfetER7TXAnGVjEvn/RAm+S2mhnELrCmO0+RtarkYn7AgWpgWCWTVPj9qaadFpcFAeskaDl3Be2zgJYtePVGWmRXIqRUhehSjZg6ZY0/OaJU15HFr4eXoNYgJrdWMIoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idlcfja3DeNfVAR7I+buYIPJo1gL4lVASBdfhSZYaqc=;
 b=aEOK8SdTx7pRoJsRpQznzSTSAt1xOK3Ua3Whi+y/XDMIIpMkrGeXqCTk4IL90Zj0Njwsu30ZFteJOnWi/RIcApP6vpqcVtw3b1muEJ9zsUzRF0xPoip/1Ybb7QQC+jsXBwoGObAkpw1RPK1Ckw1m06YG1+rnzzqqvGpbZO21uhmiKOVYbOxf+mEHYegu3PP8L4GxDAbmP+CnozNAdZhOWyE+5tjMiSgKN/SNvEna+fJOviwJiVkr7t7ijJjIT4u+zIPkbqTXzKn8eGQrAL3LlhNQbmwPvdNR8XoofD6+bgM0az1Uijymxa0+sap07ZZgofZJ+W1Ix0kQpAqivvQ4xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4676.namprd11.prod.outlook.com (2603:10b6:5:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 06:12:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8335.011; Tue, 14 Jan 2025
 06:12:46 +0000
Date: Mon, 13 Jan 2025 22:12:41 -0800
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
Subject: Re: [PATCH v6 22/26] device/dax: Properly refcount device dax pages
 when mapping
Message-ID: <67860059b200b_20fa294b5@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <7d5416ad49341207e5f3c48d5b9c4b7af5fd9ac6.1736488799.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7d5416ad49341207e5f3c48d5b9c4b7af5fd9ac6.1736488799.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0293.namprd04.prod.outlook.com
 (2603:10b6:303:89::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4676:EE_
X-MS-Office365-Filtering-Correlation-Id: 397e2004-ec33-4c2d-de14-08dd346276c7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ubb35cZFd008eQgbGeHXSwfQx2l9LkE/CzVZ8CXu454g+Z5BkyHj/65VRDN2?=
 =?us-ascii?Q?L3PtsoTtxjijOzIOazA3a6ssovV7mwdiVCWbh6/k1fnO+ucg91JZ/pPeyIv8?=
 =?us-ascii?Q?w5sFRKcgXwCaha26KWhJOxS40xF49OWL908eROXkvwFVVauHaIZQDZYulfwo?=
 =?us-ascii?Q?rhGX7EvS0i1x45wnhtGz8+tph4NWFqHvXpcaijoDnj/0UD6srRhGWi4O4h+g?=
 =?us-ascii?Q?hDqEmvdvY+nrqCC3FvXrB/Fi06cguda9in57OJJOcoGPVWcvt98MzJTiietg?=
 =?us-ascii?Q?sx7kyT9x7nyort90KMAaMgz5uBtSirbRRfI6XesDT0hPKXmxVaWWeORMw6Jt?=
 =?us-ascii?Q?KaIZdXqJAG63MIZVoymryXK862YxkJ6SQCthJOmAVimHksT+qPkRLfZktXKS?=
 =?us-ascii?Q?LXgIUpIE+Occ4UhrpvW1yVOzLJyS9KsjiWhUkxoKhx/aCsK/mhGWST8rDV36?=
 =?us-ascii?Q?Eh5Uhu1CNOp7RIt7Jz61OAf9ENMhoByLzEECwqwqaCYSa+K7ckSQ07/jdzmB?=
 =?us-ascii?Q?1tlQg/k7x2Fx3TNbFgxkk9q/LI7/6ag2u6V0bz4iIWdguAnsYy1kptTpuSLS?=
 =?us-ascii?Q?cEiBgLmejkyhhpjJLtm5/Afn9M1NAJZpttIGC2W/A9S9v87511rlNjvkvIQs?=
 =?us-ascii?Q?db60ov83/T/FLNDMPOcrL+iuzbEJHf7xmMyjjGcfGyrmDZT6HD2kory6Vs/3?=
 =?us-ascii?Q?6P9mV+fX4Nh69/jMB9dX1J0JIPIWMP21DjjaBFBBxRTMDtC+6DarfzoSdlak?=
 =?us-ascii?Q?dVDVuL5p5SebMFhnAAOt2UmOX/wleO/G+roi9Yy2HKXT7kaezfexGpebz13i?=
 =?us-ascii?Q?UBe0ZHDZQ17vGiBmvu6vGhZgkh8Y6Y2CY2lYaYguS6p+c9PaJ0YFwMjbDWxz?=
 =?us-ascii?Q?TWIc7GQqYydnXyzyJsp3yKzyBfcueSSN5/PEQfTAxCgorhPVCwIyoLi+TO20?=
 =?us-ascii?Q?1Xn5cNPry+baM+CJTIktA5Ay2x0nY/I7HMyYcKvve4tuj4lE0YyU6t/fIZjt?=
 =?us-ascii?Q?YrBihU5YUm1kEN7SEiu/BfeNv/+IvsIx/TMYPw+XB9E9jV9A3LsKDzfwOvGd?=
 =?us-ascii?Q?Ms1PZV517DZTpBe8528iMoC9MNqa2cju+yTkJTkXmP+8r3rwugN9rsAkcLiK?=
 =?us-ascii?Q?+nesaPhkZr+UWAKUm8zuFg+lySjsL1GLv8OIacHPagRAmpjyTn11vgepQ/rV?=
 =?us-ascii?Q?V6Mabn7xf9Lirt13o3YofB/ep0M5YGetPJbMrWpO9y/nQ6ouXgB4x6IcQJrt?=
 =?us-ascii?Q?ixm9AfQOyeygA5nZH+if3rdBuGF6L16FOhLCy8sa7uSjlYrsRAOMNg8hhmJN?=
 =?us-ascii?Q?Zx914pckRTZ842j7JnLBcjTyidVo3gI/gVlmfv96nNQwr/XT2+8D4G10o25C?=
 =?us-ascii?Q?LnoQ2EXp8hgB9P9Kl/J5G2/kSDO8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PN15taGIPKxDFj7EX00hMk5j3tlidozrXVnPi8zaSbhD4w736AthXkiMcmcn?=
 =?us-ascii?Q?upksF/7/R1kSCmTQ4B9+S7AOFdXR5wO2BiQ2KWhmfJpMEKvogXiAcZja956l?=
 =?us-ascii?Q?LduF98oPasMfu4Zau8mEJIvosNTKTgp0DwWlyctgkdAd12JOse+IM8qs4t7J?=
 =?us-ascii?Q?DsSiDR+K/NLY2Q+JKlivpdyrgFDMGOtpniy3+hw5gn/nXKqf+y4xaMDEwKkk?=
 =?us-ascii?Q?Pzhg5sRmFOzdLxe2vh1k+kn8GvjDB5i7RwbGEwMoih69yDwN7hNfabyOhf7Q?=
 =?us-ascii?Q?K/kHwgcspd9Alx7pchtZA3n6X1LMpSeiRYJrUY+O7HK2wcR9B+NMjQFD9UNj?=
 =?us-ascii?Q?w20GG+qtkOfUnMvaSkam6N6/GwvLZclR057r5Z7xHCsPviemfU3Nzu98faZ3?=
 =?us-ascii?Q?X7efoz3YvdS6ecsgZcXFA6Zjtgix8azldEoTOZ7JrADbbgtRXb+o8GC4/Y/o?=
 =?us-ascii?Q?ApQs6gB0yhRwdpxD67pWyHs6to03pILPbv6bny1ARFr8qMX7bep0RKqpvp6w?=
 =?us-ascii?Q?QE9rDo2arFZy879HdU8x4NhdK2HO8d10LvfjQBgsZYnKgdRJ7MZ51/os1pgk?=
 =?us-ascii?Q?C096NUdaavbyBK4/TJWNnWT0Kn45Totu5IBm8P/NDe1T/6RSlJ/Sj/lIpaZH?=
 =?us-ascii?Q?K7v3poo0mXGwbROEOGmVwWLxi4V7ZTchF+kPq34qtGkX6EqAHZExuS2lJ4di?=
 =?us-ascii?Q?eMwEpWWydQmJlKN6dUx+mG4Svmz17hhDPOgWmNud/RuQyf8YlagkwGzC21fq?=
 =?us-ascii?Q?+f0ZEo2BIasMjpwWGUe7wHWa4BwhO6J4S6t2enA7sZABJzSRjvblVJ1hYoUn?=
 =?us-ascii?Q?7yYfQVmqqtBcp0p8U6pXdOrUgy2jubF4ntmYB0MH42LmCTWGk2XMXoAqcXq3?=
 =?us-ascii?Q?Ufq2iKozxT8BNdPcSRIGMd1Kq+WtHSwdUR3hauDXxuo6hQHapt0uvYywtos1?=
 =?us-ascii?Q?7ZXMBrvN7kh0H6wQ4S0/dGSxrhdU1f4X5rIZjL2Jk4cE3h14RozlKJf9uaTJ?=
 =?us-ascii?Q?CiXtAPFd1YtHUAd7QFM0LKeYth/jItvvphC7sVZB3iI8S9RsyS9q3CFGr2Yr?=
 =?us-ascii?Q?zIClGjBjb3ocFewoHcUdZ9YoMbwVtLNWxqVEW/8jssJrxscKM+b0CJ2xl/r1?=
 =?us-ascii?Q?T+iTHnFi5mgCr1lWQ1OBjuUSi0iis1bpY+/3Sg6t4u0q2gCxyT6AJqDNb9ZG?=
 =?us-ascii?Q?ea54+ZACTfQEiBSqUTImIy4zzXBe8ijXwjAWX5pVRL0uKCMkt6ieN/9MtFlO?=
 =?us-ascii?Q?4guLwbu8LWY7m/rRIwm1DQnKgZmhKjU5r8QEjJKUoZNWsacC7eMnQolMBhqj?=
 =?us-ascii?Q?myAwn/N3Pdeg8aZQ9ifL4K/RLwjFEvaLppqv4stDzPP7FTls+Sj14DYvJ5E9?=
 =?us-ascii?Q?Cva+fEH9KY9M8t1BCQ0B4rHiMkMmfVzmS11tAsOhp21dgYYShhzj6GlgSyMK?=
 =?us-ascii?Q?q8SgUANCIPL0aTW20jM7AhaMnD5VpFRoO/1kXFNVOnkGmo3z+9nnqd/UrEiY?=
 =?us-ascii?Q?EJFLMTEbIpOMxCxGQJvAK4e8+gaZkV61OlKbNLrXvs+/rPHKz7COE8s3hAkH?=
 =?us-ascii?Q?ztJbJL7A65LWL8lgLllFtPLCIwCROkBHFTtEZoR0oK3DOYoDX9mycOALGaR5?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 397e2004-ec33-4c2d-de14-08dd346276c7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 06:12:46.2175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3BCs1YqIUcRnYVk9zwnblXXOdzusAg8xya7tbVu6H2k6HuEP5VbFPqYftN2iSPgiTG5UkMKi355MHPOOgbAay7x+699o7jt3mU1lsO2Sm4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4676
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> Device DAX pages are currently not reference counted when mapped,
> instead relying on the devmap PTE bit to ensure mapping code will not
> get/put references. This requires special handling in various page
> table walkers, particularly GUP, to manage references on the
> underlying pgmap to ensure the pages remain valid.
> 
> However there is no reason these pages can't be refcounted properly at
> map time. Doning so eliminates the need for the devmap PTE bit,
> freeing up a precious PTE bit. It also simplifies GUP as it no longer
> needs to manage the special pgmap references and can instead just
> treat the pages normally as defined by vm_normal_page().
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  drivers/dax/device.c | 15 +++++++++------
>  mm/memremap.c        | 13 ++++++-------
>  2 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> index 6d74e62..fd22dbf 100644
> --- a/drivers/dax/device.c
> +++ b/drivers/dax/device.c
> @@ -126,11 +126,12 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
>  		return VM_FAULT_SIGBUS;
>  	}
>  
> -	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
> +	pfn = phys_to_pfn_t(phys, 0);
>  
>  	dax_set_mapping(vmf, pfn, fault_size);
>  
> -	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
> +	return vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn),
> +					vmf->flags & FAULT_FLAG_WRITE);
>  }
>  
>  static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
> @@ -169,11 +170,12 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
>  		return VM_FAULT_SIGBUS;
>  	}
>  
> -	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
> +	pfn = phys_to_pfn_t(phys, 0);
>  
>  	dax_set_mapping(vmf, pfn, fault_size);
>  
> -	return vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
> +	return vmf_insert_folio_pmd(vmf, page_folio(pfn_t_to_page(pfn)),
> +				vmf->flags & FAULT_FLAG_WRITE);

This looks suspect without initializing the compound page metadata.

This might be getting compound pages by default with
CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP. The device-dax unit tests are ok
so far, but that is not super comforting until I can think about this a
bit more... but not tonight.

Might as well fix up device-dax refcounts in this series too, but I
won't ask you to do that, will send you something to include.

