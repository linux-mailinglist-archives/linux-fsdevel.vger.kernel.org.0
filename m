Return-Path: <linux-fsdevel+bounces-33095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5AA9B401C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 03:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12321F20B53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 02:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB1D187560;
	Tue, 29 Oct 2024 02:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1kjhWpX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944E615B0F2;
	Tue, 29 Oct 2024 02:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730167479; cv=fail; b=F5JN1H8ZSSPGnldGgTZaheznIZDDwMudeDpW02xgptkoirrQpMzHp2aoX3WY77vrla+SkvjQ455cT/w1ieDa0Z0vt+s+/g0mTkbTrpJWAqAjtbOJ1tAatUYQRKZh+3XB+ZzGmUyH2Y8aeWcATgmTMbXyVlcsD5RZrxfycpYLcME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730167479; c=relaxed/simple;
	bh=K2ZfybCrzkAsLmHDYJyV5b0HEEp9lIXG/MjUcI04DEI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U4UEfTQ/XsmWVWlHtJxS2oN2jrRtSZimnoZE9TcIuzLCUlAQ1QPdX1y466ibyNQUe/udN7StnDvxMxz/nM/5/kv2KOHwbCnANa3R+kqzOMqJTd9iXbPoL8zlS7vEEnamuxZ6WGKvxjyekREIBaUzDbyf1TBhLG2ap/CRfXWWy84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1kjhWpX; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730167477; x=1761703477;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=K2ZfybCrzkAsLmHDYJyV5b0HEEp9lIXG/MjUcI04DEI=;
  b=N1kjhWpXcoJStAq7VKQPmAkLe2vWSXlE6RhM2Sq9yKtif1UWzH/3oY/4
   pczpDHlrxXN1E65inagJFabrYzzpJYDBH+M5YAIqKivIcdI0NVEuejV5w
   NmhD9uszJA2Qvl3GphPQ6Q1FqlGfZU6ZlJU+0ngbx8IQ0Ub6RMEuBIwjY
   dXTJ+WlTaGQr0cbcWu1yHx8nIiqPnfFvuduLlZdVj9kvW5/87siZD0sl2
   VzeryYVj5dZCEkNktlL2nA6Q6O+iQ5b/nhCKV/UBOIgFMXdp7iRR59UWo
   Y9YveFr6Yr8+FQAiANS2W4mQT89ISB7kXS5Li0RulinWrKXaNAnpVkzlm
   g==;
X-CSE-ConnectionGUID: KYeWLok4T2udB+kjnVfA4Q==
X-CSE-MsgGUID: dHPh6/ZaSQKcerbs6uCTqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29220012"
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="29220012"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 19:04:32 -0700
X-CSE-ConnectionGUID: 8fka4D9mS7uhPL7WEThPgw==
X-CSE-MsgGUID: Wg/BnqAfSemgywnvb42oxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="81898620"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Oct 2024 19:04:09 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 28 Oct 2024 19:04:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 28 Oct 2024 19:04:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Oct 2024 19:04:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+dQ4OPlkUcQ7/V/jCOFGCpCDO928lfVZB7jLfpmav7c4Kd/SBtzWyyB0Abn4bJH4ymwxC6EdOJ1ecSiuu3vfMIrWQyop0/A4r/KDaK7FNqxos+Hjd3hVF17mLTr1cj67lEEU63lZ577z6DwHef3SXe9EEMZfP5z9SadgYqT+Jm6dRfKAyDA62yDoN6m2oBNGSmlfH96iDGkPug95ocWjQFJ3cWu+tA6/cmRZhOTsPmrwBB6QhPpSdxuLaj8/x2Nm+rxUfAovYyOzwSHqubPXtuQkWrz6y8MLjuydKosNqMWq7e02liEnsEvZ/ntcpViYqySiwUzJ9lKgAxpjOzNpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ipd3R0XPPqBvXqkhdKucx+TiJlGjpp7/oLrHqojklQM=;
 b=Fm9PmP8OVWwDS2Q5WyBFHM3wWnQWmc9EGOHoCscPA/DxaFGx63+1Jj6jMvFWxsiVhONUl2oaodBvcQfPscC9PC/AafAcYXHbRSI3Cy1RoPMJB0VAe8Wa/0EQgDhB31VAOlIlYV7/yhJa/z2lCgLGCkX0cFU8iMxigvB/VPuzJZQKk3KSxgWx+YeYGwF+t/t1THZvOmlfiruANZgI1FCWtgy/NoDe8vFJrVtFN2zEutef65ybPzRZULaQuXvyHBoly/d31YnRMxpIfeg0oyZh86syr0ps/+yBJf+tOsnXYqjAw/u6YPgQxHfQwTrvW5n9NpN3XNuQBe1IeF4UlN2Bqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6223.namprd11.prod.outlook.com (2603:10b6:8:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 02:04:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 02:04:00 +0000
Date: Mon, 28 Oct 2024 19:03:54 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-mm@kvack.org>, <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
	<logang@deltatee.com>, <bhelgaas@google.com>, <jack@suse.cz>, <jgg@ziepe.ca>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <dave.hansen@linux.intel.com>, <ira.weiny@intel.com>,
	<willy@infradead.org>, <djwong@kernel.org>, <tytso@mit.edu>,
	<linmiaohe@huawei.com>, <david@redhat.com>, <peterx@redhat.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
	<linux-xfs@vger.kernel.org>, <jhubbard@nvidia.com>, <hch@lst.de>,
	<david@fromorbit.com>
Subject: Re: [PATCH 10/12] fs/dax: Properly refcount fs dax pages
Message-ID: <6720428aa1fcc_bc6a929439@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <9f4ef8eaba4c80230904da893018ce615b5c24b2.1725941415.git-series.apopple@nvidia.com>
 <66f665d084aab_964f22948c@dwillia2-xfh.jf.intel.com.notmuch>
 <871q06c4z7.fsf@nvdebian.thelocal>
 <671addd27198f_10e5929472@dwillia2-xfh.jf.intel.com.notmuch>
 <87seskvqt2.fsf@nvdebian.thelocal>
 <671b1ff62c64d_10e5929465@dwillia2-xfh.jf.intel.com.notmuch>
 <87a5eon8v3.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87a5eon8v3.fsf@nvdebian.thelocal>
X-ClientProxiedBy: MW4PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:303:6a::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6223:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb67051-17bd-4e5c-4cac-08dcf7bdf382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S/LeL2+Ae4N5LRTUvNDLwuOUHIMLEQ8iHGzDfPrnKZMNAW+FUJO95Rt5iiZg?=
 =?us-ascii?Q?zfBdVj/gHywFtrJUg3ZnwAqMBxgBWu05ysK40M9nOeKEGkZE7hPgrYPl6f41?=
 =?us-ascii?Q?meZ7H7U/9UtZOJCNNR3LdXwkq/yImpaBX/XPg9JXSjwYXyPtJleTdk4WWOsN?=
 =?us-ascii?Q?Ex83PdkY+i4MoB7RdVk1i2D4B7C01falR9kuzKSEaYlG/9Un6JxqkZueRhFU?=
 =?us-ascii?Q?AQDQ0cunAbZhV94yCOvNiQG+8Y5ibA/W0VQf8q4jSnZt2P0wqpVnJT0P7YQm?=
 =?us-ascii?Q?fnhlq1JTYuLcxwPNmygy1LkgV0vETfKb0AB8IchAJUXQhTTEFXxFo7Rs3eBM?=
 =?us-ascii?Q?x4bEOV02okrBoRUVcBTX67WD8M+uMOOGTunu7qQn1J/INNKEL9vRYX87ksMn?=
 =?us-ascii?Q?EV453R8tgzM0NCBXkkR8cIHP7ydSTJY+wFpe8IYB1+WU3tE3fClXXy2u63Hi?=
 =?us-ascii?Q?TzZgnPlFtBOMMHIKV8LqaUXJA4bMoC/H1vUgOerTFyQoyOmuOk2VGKSwyrg4?=
 =?us-ascii?Q?n8TTDbDdmPIDb/jtxGdIzMjYG9fCHXjcw0gyaLcpdQNQJ43JHwPUYo9+pQgg?=
 =?us-ascii?Q?WLTIm6REVv/OE0q1/CurmbzvaVfNmT05aUTcyTVRKhKgto/6jcUV+Jubtq1l?=
 =?us-ascii?Q?kVOB8w0QwI93nlTk8v3S4ySm8gxECXjp60S9ESpPMeXxktCXhM9YhftspPVt?=
 =?us-ascii?Q?hnqkXucZ/dPNjPT5ddlA20kNdKkVxqAwapo2LH592GOfIbPxWdukWIPd/gxk?=
 =?us-ascii?Q?lUzzpnioe0w2tbYrWcRmWFG07vimOKsukCimjWu/aYekIDbJ/e66rpgQRuiy?=
 =?us-ascii?Q?925N2Uws+O9RX32hMRK4YdhSdGjy2cX1o1//+oLcMmz9FuUSUzek/EJGSvsi?=
 =?us-ascii?Q?XrQGqoQz92Sy3/YxF7vQkBsTAvM3rHeeK2P1VdcET7IqdnUyz+LOMw1KVaTe?=
 =?us-ascii?Q?k5BEweY8dNP3UDCVC+4O3dns3/Lkik37xa+uRCf8GN/x0LAOUFKBWJdU8zbY?=
 =?us-ascii?Q?Oi3cod1mRZ4l/LR2ooqDTcerIOo+CLkizSjRdnLORYJ/zqIGGd3i8HczbpsZ?=
 =?us-ascii?Q?vmzgTYyY3XXQB1yUDO5YFaWVvRSuI3k8oEGujMsbtrQhnavtGPspACN0aQ+3?=
 =?us-ascii?Q?XW/zUSb2euvwYNVrJpkO0ZOFZU9u0VB7zZMDXrE95OrYZgWCVN8HNjKC1qXD?=
 =?us-ascii?Q?dTzy0REhZnIAGTWA3sQj/uAZKlow2vdF4Ap6wm6ysh8Vr5005NCYA8om8ZJw?=
 =?us-ascii?Q?S1WFBTdsJiQUjKuJURxyYHo3LO4/whJFfYegQvVuNW61ZV7EVxiwK54vqxOF?=
 =?us-ascii?Q?jA19VJY2goOLXezInfJLW5V/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tFId78MkabJ3o5Yezskz9rIFEZB5ZIyxPzfu93B1EmjzixYKXDkT26NIbN/W?=
 =?us-ascii?Q?gUYQ4auvdVq6TZjt8WXtbjU4RGTr/+HmJGjmWbgwL8kDT66LpYiCAN7jSrx0?=
 =?us-ascii?Q?3Yg9ik7nble2lOg4SNCOA7ZcQFZHg/HLrc+l0WAXJgNneN3gYRfE8d89niuG?=
 =?us-ascii?Q?qtEYOYQnkpXuNi8+qxsxCBtDYAMPaHExeL/dD/BIWyqg1YEx1wmsAVlELxdo?=
 =?us-ascii?Q?Rb3qhsi+Bwi68fjmzQ2DSm6oHSaijBqQSgdh7Av+85MKRN/ev2HSAP8ZeINk?=
 =?us-ascii?Q?JGGG4ActNgybldEcAEFtAht1OiR0B5O57/S1R8YFjPi5sPI30ZJoSdGHE7WD?=
 =?us-ascii?Q?3I6pxgfQZtC/2c15UNvrjRbvg+Nd10bMYO29Xg2wRfVRHbzzg4vbJB3cd31c?=
 =?us-ascii?Q?50JpxTencmaOxjy1yMFaVpj3F2qU7co0FDjUjmwYJIngXDPt0xVzL7l3UMrj?=
 =?us-ascii?Q?dTeOy4owdg6sTxTuNAvFRkBrjbpQoZSdkm2vngRH+h0pG1O15hSPTtEUn2ie?=
 =?us-ascii?Q?8h3kWToJB8//vT0I7oPWmDQ2/xyMKYjbYNDbKmReh7SwB/UOHy8MYl1bYYWd?=
 =?us-ascii?Q?cRlOS2yQT8Q4gHnsqBBrP+6frIHMWr5GE7UG5V9DjoUUCd1ihdKgrV9YGB+p?=
 =?us-ascii?Q?xPVGHAmMZvVZtOHMZQczDYRq5sL543HW/iJmpGMK95bCvwphHsq/wol/2+2F?=
 =?us-ascii?Q?ptKnHjkHY2e2agydNQNLwoRr83ox3JiJmUpRfff9nPrUPyVF7k+D6ANqZq/Q?=
 =?us-ascii?Q?wFISAOmLwPbU2blG7qs5V3zXpSJZ6TouV7/OJ9Jcmd8+9EYAmpeE2DgQGzbx?=
 =?us-ascii?Q?BF9Pn+fTd2eZ1BZXLogRb3l2i3tLaYVt1rV4gUjoQ5AGEOMGP+FaJU0aovfe?=
 =?us-ascii?Q?ZfUyZIc7/sQ+LCBR2v1KlxQLKQC0PzxYC02NvP7ccSVfGwXD1QvCbDZd1P10?=
 =?us-ascii?Q?o/3FTSq9turAkkvaHfwnvKcyDAVbF8nbb4PQ7QU4JiSixKX4DxSIr/wuW/Db?=
 =?us-ascii?Q?JaNy4C75Z3/B26B1zgTPeksl1h7PkDGTBhm/PsYhuvDrlam/xZBCDewRjdwy?=
 =?us-ascii?Q?WOx1l1gkxlcYgTFB5Js6YM4o1F9+JzcmkbRPLDAvG41WFAtUZuhufH0/A0bn?=
 =?us-ascii?Q?F+ZtIXJASaXoRljMY0qrZnocA+k0VM46MA5OleQ9EVPwfd1eW+XQ5r7/o4KU?=
 =?us-ascii?Q?HzCBOqxRT4PIvaqdxlAzyEIrXDsFFOmFAtqYvwVKKzhAchk0CzbKxWFMglDQ?=
 =?us-ascii?Q?DabsESpCTnpTGeSUDjD5VwW8cfIlVzdXscpqNyiK5zP2qaJo5M5sE8GY+Q7N?=
 =?us-ascii?Q?eEHTYjN1WU2RZkrZ9hM+MF54cf5LtYn+eaUQp5QaJEhv6a8YPo2FthT4I+tJ?=
 =?us-ascii?Q?o0PCLxOhCIRZdYAtnPfulsBPiBWnEBTQw3NCwf+ib1LOJHhz3imZA5dLzsyu?=
 =?us-ascii?Q?M+tiTuHcEx8CrfZ+GuO7pQiYRTnKPOKf7V+ROEi5qS4pr/XTRLK+rLt3/PZT?=
 =?us-ascii?Q?1g8xWeJJbjmwhZY9ejJyHT6d2EzCXhPgDzIyaftpClUmu1VU1atNvNT/yDKP?=
 =?us-ascii?Q?m+KQAPrc+LFeWEUtCI+IN2haqrEKIohxzR0k4vhlxvieSkRzu0czUGiCCHwr?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb67051-17bd-4e5c-4cac-08dcf7bdf382
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 02:04:00.6704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fB+OmcDZMgJ0kthijVpM0QQhxb8QAcAct2PA9o2lL6+66IMjprEtw/FfcS2b07zsi7so+vi2M/3PPIXriyfjxkdhHa3RyECs5gX+R5xa0bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6223
X-OriginatorOrg: intel.com

Alistair Popple wrote:
[..]

> >> > It follows that that the DMA-idle condition still needs to look for the
> >> > case where the refcount is > 1 rather than 0 since refcount == 1 is the
> >> > page-mapped-but-DMA-idle condition.
> 
> Because if the DAX page-cache holds a reference the refcount won't go to
> zero until dax_delete_mapping_entry() is called. However this interface
> seems really strange to me - filesystems call
> dax_layout_busy_page()/dax_wait_page_idle() to make sure both user-space
> and DMA[1] have finished with the page, but not the DAX code which still
> has references in it's page-cache.

First, I appreciate the clarification that I was mixing up "mapped"
(elevated map count) with, for lack of a better term, "tracked" (mapping
entry valid).

So, to repeat back to you what I understand now, the proposal is to
attempt to allow _count==0 as the DMA idle condition, but still have the
final return of the block to the allocator (fs allocator) occur after
dax_delete_mapping_entry().

> Is there some reason for this? In order words why can't the interface to
> the filesystem be something like calling dax_break_layouts() which
> ensures everything, including core FS DAX code, has finished with the
> page(s) in question? I don't see why that wouldn't work for at least
> EXT4 and XFS (FUSE seemed a bit different but I haven't dug too deeply).
> 
> If we could do that dax_break_layouts() would essentially:
> 1. unmap userspace via eg. unmap_mapping_pages() to drive the refcount
>    down.

Am I missing where unmap_mapping_pages() drops the _count? I can see
where it drops _mapcount. I don't think that matters for the proposal,
but that's my last gap in tracking the proposed refcount model.

> 2. delete the DAX page-cache entry to remove its refcount.
> 3. wait for DMA to complete by waiting for the refcount to hit zero.
> 
> The problem with the filesystem truncate code at the moment is steps 2
> and 3 are reversed so step 3 has to wait for a refcount of 1 as you
> pointed out previously. But does that matter? Are there ever cases when
> a filesystem needs to wait for the page to be idle but maintain it's DAX
> page-cache entry?

No, not that I can think of. The filesystem just cares that the page was
seen as part of the file at some point and that it is holding locks to
keep the block associated with that page allocated to the file until it
can complete its operation.

I think what we are talking about is a pfn-state not a page state. If
the block-pfn-page lifecycle from allocation to free is deconstructed as:

    block free
    block allocated
    pfn untracked
    pfn tracked
    page free
    page busy
    page free
    pfn untracked
    block free

...then I can indeed see cases where there is pfn metadata live even
though the page is free.

So I think I was playing victim to the current implementation that
assumes that "pfn tracked" means the page is allocated and that
pfn_to_folio(pfn)->mapping is valid and not NULL.

All this to say I am at least on the same page as you that _count == 0
can be used as the page free state even if the pfn tracking goes through
delayed cleanup.

However, if vmf_insert_XXX is increasing _count then, per my
unmap_mapping_pages() question above, I think dax_wait_page_idle() needs
to call try_to_unmap() to drop that _count, right? Similar observation
for the memory_failure_dev_pagemap() path, I think that path only calls
unmap_mapping_range() not try_to_unmap() and leaves _count elevated.

Lastly walking through the code again I think this fix is valid today:

diff --git a/fs/dax.c b/fs/dax.c
index fcbe62bde685..48f2c85690e1 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -660,7 +660,7 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
        pgoff_t end_idx;
        XA_STATE(xas, &mapping->i_pages, start_idx);
 
-       if (!dax_mapping(mapping) || !mapping_mapped(mapping))
+       if (!dax_mapping(mapping))
                return NULL;
 
        /* If end == LLONG_MAX, all pages from start to till end of file */


...because unmap_mapping_pages() will mark the mapping as unmapped even
though there are "pfn tracked + page busy" entries to clean up.

Appreciate you grappling this with me!

