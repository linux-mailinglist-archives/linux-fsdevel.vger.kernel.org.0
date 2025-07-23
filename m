Return-Path: <linux-fsdevel+bounces-55770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3F9B0E7AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 02:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132B61C281C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 00:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F585156C40;
	Wed, 23 Jul 2025 00:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OjPKEWla"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEAD156CA;
	Wed, 23 Jul 2025 00:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753231540; cv=fail; b=YBo1Kg8JpFwDl9Ac5W74fkOxdAsn2spST+ykU8XjVwKGcg4W77vg8xXDN4BcrlqMz1Dmm4Z9IYaIltQJ2OoM0xPL9avb3rlqfIbJXx+9dlwVq0Hkfix0ZzeLy/q6gd+hnw7kR2LwCxCPg4EcvYqVqTdDYhS6AeS3ZerK3Jub7P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753231540; c=relaxed/simple;
	bh=hhDwV70xsk4sjHYW53HVusafDqiBtuHJUWZDFxCJObk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kDzQyU3fWtD2fSO2LARKJeoc6t6Sqxihp1GcDoq/yvb05GCI8OpvgTfb8Rcfek1cJGeiqIUIbVI0ikL95hA+MkBGkuNVxivO+9BVM5rOIdjfxbjjJkUIyD+lok8M77TNEOyYh6e3a8UJ7B/Yvvx3lJxRdxLoKwezvZFVetNTAaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OjPKEWla; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753231539; x=1784767539;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hhDwV70xsk4sjHYW53HVusafDqiBtuHJUWZDFxCJObk=;
  b=OjPKEWlapBoZxcHnuWNvdb82czkBjlxzas7ae/LP1VkRRcB1wqgArYLA
   HOaLokRjkbxu2MvBWY+z1BazdJ90hcZR4w17BG+07eUbtHYJSq0RQFTAq
   0owLYQTmCPF9Rhxumj2zyYBN7zqTtW7wq84aOLpveBnyi2S2lZN2pK5sD
   FtPKLJMkv9KjvpKByHiMlyJkI9g56WJhBVsiLrkqXCSzU/PLOHkJoNBv0
   otxmxI4JIj/cohGPDZZwgLOD/mahdVzYakNBZoJVhZXz77VyBkLnnww9H
   MuHQqycp5j68UNalZ0/kPdpBGARL82kdwQlXFWA0YpStLiN2pYUPAFqoT
   A==;
X-CSE-ConnectionGUID: /5iikPUeRzi9ZGDAZIUxZg==
X-CSE-MsgGUID: hgw1YCQbRr6R9wgV69I7vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55595646"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55595646"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 17:45:34 -0700
X-CSE-ConnectionGUID: 8cM+ZS8WTuWyvQtFBRsPYg==
X-CSE-MsgGUID: a8867n9jTvypkiztNUNwHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="158948264"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 17:45:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 17:45:31 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 17:45:31 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.67)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 17:45:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THm9In6viCM7b8Ts6+NkPd8Cvw98tvnP/pKiiSYqGyUTiqcXX14h5lTdm4xQZG31x6Tib+CwcUvyY5jakdtkQ+GLQuZG/ZLvnqLCYA+KvVyvEGaehMDGCtwtBB8psUuAZLFKyATDk1HOS7IvhIyMse2FcPy02hD/PgD3ZsNxAJlcqd9SAVDoKNdgFRKlCszgNw3qH81Y+LjSxyWpl5ldPywjMg+YWyvxoblIuzZGNOlWSlt7CFnutLiekdETYwZfH2oEjGoqQ8VqVddto9VOnXLJIBQEw++eD11ZdAQSU9XOyI+jyoSqiyMiNpe3fKrp+yqr3YmL0i1XW4rh/A2w1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kY8Tm1ZLXoESjGLXw4/2Sx1CAh7aCMXkTZyr6jLm7Cs=;
 b=iAcP4c4ajjQerQVROs5ed8Jx58tCqLgqzNSa2b3mbD6uNEHnxab7lnn+SYUErqtwLzDj60oXXa/1O2usbO6UOBbD6alEOq4mfwjOc8p3MTLdf/T8L4m/oZPUVetv0aEzHNIF3PBr+PrYIaoxDBD9fjmVhKpU7sVAo9kII5r7UrNNJb8ugwltpKOMdI+LqNtvPEPzyIxwJnVG3VNvDsrL8vnnPlviMY2I5PvTlzG81gooarb2EmMYIhf+0wQLafZSn6aaoiLvuxByxhJJ9Zi+Zi1qCSny3PkIwAEwGqIwHP2gEm4fO0sq/KuLClk79kbRfRBIojLjHt9Zqov/X/PgOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ2PR11MB7475.namprd11.prod.outlook.com (2603:10b6:a03:4c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Wed, 23 Jul
 2025 00:45:26 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808%7]) with mapi id 15.20.8922.037; Wed, 23 Jul 2025
 00:45:26 +0000
Date: Tue, 22 Jul 2025 17:45:16 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <dan.j.williams@intel.com>
CC: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@kernel.org>, Li Ming <ming.li@zohomail.com>, Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>, Ying Huang <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
	Greg KH <gregkh@linuxfoundation.org>, Nathan Fontenot
	<nathan.fontenot@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Robert
 Richter" <rrichter@amd.com>, Benjamin Cheatham <benjamin.cheatham@amd.com>,
	PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>, Zhijian Li
	<lizhijian@fujitsu.com>
Subject: Re: [PATCH v5 1/7] cxl/acpi: Refactor cxl_acpi_probe() to always
 schedule fallback DAX registration
Message-ID: <aIAwnACBeWindJ-s@aschofie-mobl2.lan>
References: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250715180407.47426-2-Smita.KoralahalliChannabasappa@amd.com>
 <687ffcc0ee1c8_137e6b100ed@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <687ffcc0ee1c8_137e6b100ed@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR21CA0016.namprd21.prod.outlook.com
 (2603:10b6:a03:114::26) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ2PR11MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b15d03-7056-411e-0d38-08ddc9823706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dnDlpeMid9Vm6jfmGjgCyt1xijANJopbzcCx2imBBqyZDfJ5t0I0ydBows33?=
 =?us-ascii?Q?AGiEtLLD8L1WV2f6Z5Psc2PdUFS6XuxaF4X3m/NqMMbX2YQ8BVKXAU0EA2J+?=
 =?us-ascii?Q?jZ53+cdxgTlG/gOuipgHu6izAXrZUzgDLpomBfCRM8O7Rxk6PcYxnRvBLHlh?=
 =?us-ascii?Q?FnYXPYyRdTBcRKUgwusOI3NpKo+tGANJ+gM8AzsTaJpwXKHOlQXIDWxjsJe6?=
 =?us-ascii?Q?5at0IgBLRLd/xTxNi/W5awmcu4xCinPqZUa794LSp2cuiwNCLfjhMFbN5T5S?=
 =?us-ascii?Q?p5GkdyQDde5uvtIIPvhqvHjxT8DZ53CdTro1fBLU1FyDEXcFneJoxRjJiBcR?=
 =?us-ascii?Q?Ynh0K2vBJeE8zjHWtgNlURaBmhW/hr+8SffVlUQQjSflbAPFzwBR9uzs0LJ6?=
 =?us-ascii?Q?qKm7k8kmOFXs+FnN3Spv49B6L9kcjt2oXz1fuJJd7FIu4oTx0B451ZSkOGcu?=
 =?us-ascii?Q?1tZSlu+TkCaexmLkiZU+kY1Vg0LTiNQ1JLpagtjbO6ZFrl1IgnLRCsoOMftn?=
 =?us-ascii?Q?VptBMkOfr1bQdgMsBt28SiHW6+pSlbAn3ESLiQ8Wnvyv5GmDv2sYo+0Z9WUL?=
 =?us-ascii?Q?827NA+fGQmeLrg8rzOE0JZ1SNdxxQUfZA46JuqXs8rVTDlry7BLexadmHNtf?=
 =?us-ascii?Q?0+yufJJsEgTSyvwOyfNDNhU0hcAOqy/ztx02IyNJfAgXQGSMG3WRU/67RVTF?=
 =?us-ascii?Q?rB7A1Q7eSrwNrjOYpYzjXITZKVWGjGIKkVRQTzsiA3vV+8VDqHPyqcTEoZKV?=
 =?us-ascii?Q?2Klba6F7vXYhzgaCKRUsmXhroVVm5p+rRjLqIz66UkDtPy5C3FoH4d1LF1Rh?=
 =?us-ascii?Q?bwDTWzFhgr5ekvCUjwAduAasAhbVG1WyQQZMI/wTrhbC4veCYk7/GIWZp+CK?=
 =?us-ascii?Q?+yW0O0yB1aNZsv3OeOuMc+vDe0c21vO1WmKeEmlAonOyCSQUTl45o2NkPA8S?=
 =?us-ascii?Q?XN1EkCzUj2ukSXDGbSHbuLZZzPAG1+QeT0ck9Au/KzLsSNwVUT/+cFdc7+YQ?=
 =?us-ascii?Q?qqWOrHHkrL9UwwAHAOdwMmJ2B7nzXvECDDRh4UGnOWUF+G4dhBGAyDFq+UHC?=
 =?us-ascii?Q?GEnvpsaVwKbvZDWufuifqffbLu91zfKXyjn8XmypuqTHlT0o1icMnVKtszu2?=
 =?us-ascii?Q?3O9E5KY/E7daJZKhLp/UzEcPj809/+lGUCxCbz2jT5aZR8awYNNQwIGjtO0G?=
 =?us-ascii?Q?uQkbiQxWKYg1au+98abP8Kv3SCs5dTgaoqz4da2aHN85ZnbGgLxs8t3ovbFt?=
 =?us-ascii?Q?thNfKqR/61AzpnQR0UtyKczZbBUjiBpkImq3DZlDM6LAYkIaYufi5kYfTV0K?=
 =?us-ascii?Q?BD9DOU6wLUx0k0qNKRFBgOGZhVEDUdCSHt8/HDGm0MKn1Jnz1oQ7v0i+Zp2l?=
 =?us-ascii?Q?fZrPNc+udtExKyW6Tdxkw4lwQDxhlUX4DJlbx7IqaJP2dc23Sg4H/aXGCBb7?=
 =?us-ascii?Q?LOIoLTcRbhQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EIOvbHIpsX1Zc+PEVjLStGIV6bkPw/F3UEs77iPgyG0AkGb53ZXlorC6hz1H?=
 =?us-ascii?Q?Yqp5gc9+Rrq0dcey2852YnWBeRqlbs+XcQDxxCFs0EZHemv8693hb6YrJYQo?=
 =?us-ascii?Q?4zBe3drMpgtX3bvzSJ+WV1W/0Gcypp8ThUpMh4GjtJasDl5YIpLxGJD7RHYJ?=
 =?us-ascii?Q?mQQmeV0B1KDTlUFWE7fJnFJLa1VX/+fEZT187CL43OPuI04jijdPkGqC/61a?=
 =?us-ascii?Q?M+dsSS8kklQIO4TQ74BoqaM+sHskwOzJl5n+4wswt/Et/NupuAN49wEYG1+L?=
 =?us-ascii?Q?cfqGV36LtHl8x1l+eQLK3jBEH8cmBTjnXKL2jVDHPGsGeu0XVm6U+2/BYZnw?=
 =?us-ascii?Q?qduikcVcbOi4tfVvTLfb7gf3oTpx+lq8j5ftIyOKp9AgSLAwtJMzhecqC3rL?=
 =?us-ascii?Q?XTO4uHpQYa96y32d9Q9U4Z93GvlQsjDfN5MzfsVVnb5lPdLKu9olYFRMuV0k?=
 =?us-ascii?Q?sGF4ewA6cVHW0rVKz5nJndZQ00fou/Zp1Fu64GUlyQv4fPezGJMkIg9Kq1RE?=
 =?us-ascii?Q?hH0tfsM7ylRbaMPPcZhsFF0hFg8ULFHIto47mboH8BLtSF4Eg8INDbBPgnH2?=
 =?us-ascii?Q?WaIo+m4KpGdblejFlyfDQAF9rHEbtGG0DestNuY1qT2U4d0sOt6/kBtQ2ArQ?=
 =?us-ascii?Q?hxS8aRtTxugmfyPgw3JODAOBjoCjCfK/p30fFnmiOB4ZWAhkuBQtOtewNp/h?=
 =?us-ascii?Q?DVV9qxFa6twNdB79X7JqEoKMw8/OhgLFj5eYAuunnUJSPvCBQ1EYNzqE40fQ?=
 =?us-ascii?Q?ajvP8HmJiM7CC817tgDyRmG8M/dtQ3aZtW0fcLfRdoSc+1S4d6Byt6ijMavW?=
 =?us-ascii?Q?2IsXFwK9d5mvfriCg/YWj1PXNsUzuBGq5ghH1WMXlGeWTlv9ZbkkseLuFAQj?=
 =?us-ascii?Q?zpcVpy03QXEXr6hKKf6bZ4/sa8mj7NCbZFW+/lR0erCtZv4rLQjatCEwViU2?=
 =?us-ascii?Q?TkzVCp7J3DQVdLRfzjf0RUeb4r9HjSzX3tn3EP5awIazTOPdrAKQIoIw4jMW?=
 =?us-ascii?Q?i8A/Z9FKjxKO3XJP/sB8C2tMIEKb4j8pouJzlYEIuf7rr3zYAFIiCB6eOWlD?=
 =?us-ascii?Q?YZxBZHJvP11XS5Jm1WZwgjj9U2PpHOPFhp8qIn46r6qPc9N09K2XJ19zxqey?=
 =?us-ascii?Q?dbH7wM+3qEq50UrsmOKn2QeFF+PEUfthqWvczOtlByRTi0JibJcbexzALm+m?=
 =?us-ascii?Q?qDeB+r63oOraj5M+lAAjmd9WH/cbT9+NM/zXk06ptaxbhzzJP1syOBIDiR1j?=
 =?us-ascii?Q?0L9W9GrwCCRM4Oz60c5wrBPXBDBvKi4HOfCmbOYhADSgcWsLkGyny4+ssAnY?=
 =?us-ascii?Q?aQVWOuz4ufBc4yadIbTRm2xJro5kiwWLIApHV3o756nH3/gP6XU76Dqg86fG?=
 =?us-ascii?Q?5oDjyj5KS9nsN29NtQFpPYxDhkyNz7BfGxIgD0csA+RqxVhJbR/WvhlDRvWR?=
 =?us-ascii?Q?PeeE24lXidEjVuvJVdt8buGINZcY/xpcuFyD/6iEtC3Q6BKmJw5EchdiTJCt?=
 =?us-ascii?Q?TBbvOIDnohC1KdcE7GUq/1B0MSaSZRybKnGDBK4LRY26fe4CLIcLx9JRZmVa?=
 =?us-ascii?Q?g5KL45B1N93YLmM7a4DtJZ1bvtkTQ6GqHvGrpDlYuHG7hEkdi9JXNe2W2n3T?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b15d03-7056-411e-0d38-08ddc9823706
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 00:45:26.5197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KIykSo/OiY82RNhb3w+PaLJbGE9LScVN20GKMe31aKBcmNlCTIdCg/kExrs1Z9rDzIJYvCDMXxesxAgp4ANfLPdxDkErllUzU1YJgV63zs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7475
X-OriginatorOrg: intel.com

On Tue, Jul 22, 2025 at 02:04:00PM -0700, Dan Williams wrote:
> Smita Koralahalli wrote:
> > Refactor cxl_acpi_probe() to use a single exit path so that the fallback
> > DAX registration can be scheduled regardless of probe success or failure.
> 
> I do not understand why cxl_acpi needs to be responsible for this,
> especially in the cxl_acpi_probe() failure path. Certainly if
> cxl_acpi_probe() fails, that is a strong signal to give up on the CXL
> subsystem altogether and fallback to DAX vanilla discovery exclusively.
> 
> Now, maybe the need for this becomes clearer in follow-on patches.
> However, I would have expected that DAX, which currently arranges for
> CXL to load first would just flush CXL discovery, make a decision about
> whether proceed with Soft Reserved, or not.
> 
> Something like:
> 
> DAX						CXL 
> 						Scan CXL Windows. Fail on any window
>                                                 parsing failures
>                                                 
>                                                 Launch a work item to flush PCI
>                                                 discovery and give a reaonable amount of
>                                                 time for cxl_pci and cxl_mem to quiesce
> 
> <assumes CXL Windows are discovered     	
>  by virtue of initcall order or         	
>  MODULE_SOFTDEP("pre: cxl_acpi")>       	
>                                         	
> Calls a CXL flush routine to await probe	
> completion (will always be racy)        	
> 
> Evaluates if all Soft Reserve has
> cxl_region coverage
> 
> if yes: skip publishing CXL intersecting
> Soft Reserve range in iomem, let dax_cxl
> attach to the cxl_region devices
> 
> if no: decline the already published
> cxl_dax_regions, notify cxl_acpi to
> shutdown. Install Soft Reserved in iomem
> and create dax_hmem devices for the
> ranges per usual.

This is super course. If CXL region driver sets up 99 regions with
exact matching SR ranges and there are no CXL Windows with unused SR,
then we have a YES!

But if after those 99 successful assemblies, we get one errant window
with a Soft Reserved for which a region never assembles, it's a hard NO.
DAX declines, ie teardowns the 99 dax_regions and cxl_regions.

Obviously, this is different from the current approach that aimed to
pick up completely unused SRs and the trimmings from SRs that exceeded
region size and offered them to DAX too.

I'm cringing a bit at the fact that one bad apple (like a cxl device
that doesn't show up for it's region) means no CXL devices get managed.

Probably asking the obvious question here. This is what 'we' want,
right?

> 
> Something like the above puts all the onus on device-dax to decide if
> CXL is meeting expectations. CXL is only responsible flagging when it
> thinks it has successfully completed init. If device-dax disagrees with
> what CXL has done it can tear down the world without ever attaching
> 'struct cxl_dax_region'. The success/fail is an "all or nothing"
> proposition.  Either CXL understands everything or the user needs to
> work with their hardware vendor to fix whatever is giving the CXL driver
> indigestion.
> 
> It needs to be coarse and simple because longer term the expectation is
> the Soft Reserved stops going to System RAM by default and instead
> becomes an isolated memory pool that requires opt-in. In many ways the
> current behavior is optimized for hardware validation not applications.
> 
> > With CONFIG_CXL_ACPI enabled, future patches will bypass DAX device
> > registration via the HMAT and hmem drivers. To avoid missing DAX
> > registration for SOFT RESERVED regions, the fallback path must be
> > triggered regardless of probe outcome.
> > 
> > No functional changes.
> 
> A comment below in case something like this patch moves forward:
> 
> > 
> > Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> > ---
> >  drivers/cxl/acpi.c | 30 ++++++++++++++++++------------
> >  1 file changed, 18 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index a1a99ec3f12c..ca06d5acdf8f 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -825,7 +825,7 @@ static int pair_cxl_resource(struct device *dev, void *data)
> >  
> >  static int cxl_acpi_probe(struct platform_device *pdev)
> >  {
> > -	int rc;
> > +	int rc = 0;
> >  	struct resource *cxl_res;
> >  	struct cxl_root *cxl_root;
> >  	struct cxl_port *root_port;
> > @@ -837,7 +837,7 @@ static int cxl_acpi_probe(struct platform_device *pdev)
> >  	rc = devm_add_action_or_reset(&pdev->dev, cxl_acpi_lock_reset_class,
> >  				      &pdev->dev);
> >  	if (rc)
> > -		return rc;
> > +		goto out;
> 
> No, new goto please. With cleanup.h the momentum is towards elimination
> of goto. If you need to do something like this, just wrap the function:
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index a1a99ec3f12c..b50d3aa45ad5 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -823,7 +823,7 @@ static int pair_cxl_resource(struct device *dev, void *data)
>  	return 0;
>  }
>  
> -static int cxl_acpi_probe(struct platform_device *pdev)
> +static int __cxl_acpi_probe(struct platform_device *pdev)
>  {
>  	int rc;
>  	struct resource *cxl_res;
> @@ -900,6 +900,15 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int cxl_acpi_probe(struct platform_device *pdev)
> +{
> +	int rc = __cxl_acpi_probe(pdev);
> +
> +	/* do something */
> +
> +	return rc;
> +}
> +
>  static const struct acpi_device_id cxl_acpi_ids[] = {
>  	{ "ACPI0017" },
>  	{ },

