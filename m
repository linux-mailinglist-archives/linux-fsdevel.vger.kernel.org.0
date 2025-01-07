Return-Path: <linux-fsdevel+bounces-38504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA45A0341F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 01:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6534A7A1C69
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 00:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF073BB48;
	Tue,  7 Jan 2025 00:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHELnDai"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4FE3E47B;
	Tue,  7 Jan 2025 00:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736210610; cv=fail; b=BMMFZtsi4vTw9kM/F1FGdFCQTtrsdP42ocDA3Iz0jFeuN1eR7dtY+Xm2LCT/GB/sEECFIxdk7U/VVwOZxlOxYL8R8+cbTleHA7ptGG0cn+VHkKWAyo8ljN0UFLF+cizDfLqHi9kEULlggdd4SiGjfw5iDT3XXVZZnHruqg771Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736210610; c=relaxed/simple;
	bh=EOt3EV3gcbD1nXFabxwkY8Mpqvtj1UIAVhpyaXYp3OU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eCvehwjfR6FSPzRZd1EhnV0UPGNg5XXrBZ3fg0HlETazeVd8A7Hv2TEN7+uHuaCrt/fwdCiLfD42gz5Uj8tfAT+LAW6yqZbrqYSnvhmuShrrKp6+iHDuQNbhgzQIZe+YYUq7+b5pm/Z/3ZmuwLPBfSXeDuecMNXCC9wEf1PiJlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHELnDai; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736210609; x=1767746609;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EOt3EV3gcbD1nXFabxwkY8Mpqvtj1UIAVhpyaXYp3OU=;
  b=PHELnDaiEfrPdl8Re7duWG7Mdhw1vKKMM/SwTvmNJ54bprTu04wDrfmm
   +L2VfjjG06HSYl/sYseIrSt3o0pa79Xceg7RKApd4yhA6cp/pbpdbLr9B
   eGkOlg7Af9I1kzTLdHDoklhtlMMqXGrOTrwOco8ZzbCFQjt39GvPNGUle
   7IKdIrJS0R2LMjbUmUZGIb5RR4f8GJayKmK9hfJMu2GKoDoRH2KEHPG1v
   zkTDRbbJlCa5cKxBAKWBI09e/VYot12vzMiFt4cHLO5Y5CqOU73yA1SHs
   Co1soZ9ykKo3PxQrreyoLA8bm5z0uLFizB31h7QRPN0HAKa+Ukc3RLD2K
   Q==;
X-CSE-ConnectionGUID: xtcFA467RGmqQe6ny2fSPg==
X-CSE-MsgGUID: uPrnuvaqQrSYJihOWPkW/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="47793498"
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="47793498"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 16:43:28 -0800
X-CSE-ConnectionGUID: 9o7gdNdtSU+qVsQ3K0Gphw==
X-CSE-MsgGUID: WOITpn1zR3WwdCnY2QXq3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="103097751"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Jan 2025 16:43:23 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 6 Jan 2025 16:43:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 6 Jan 2025 16:43:22 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 6 Jan 2025 16:43:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEeYxEmTmF36BohxCYV9wU1oGhUyKnoDzrEdOM5ag8YrGwEkjeakuHyY24Tnc6TqSBKCqwNPnKZyYhfzlejTrUXelNH4+b+rbaTxU9aohz2HLeSD8jJvoti9DerDJbTDyIsqUoxxdhQtvXE1heAQVG/HUIEOZ5nsoCDHeXUCUnW28KxwaM0oC8cmn9UWzEoGANfqB2SBF7Z776F9v/FuIQWBguBgEIwRGKf/CSLQcgtAtWBJFHHGWPmOZoUDtJg7itUgzomrI0+Vr9fm4L70Di+Fziuy1UC3eLJ2X80Q5gfDnBkZYy3gmTYGRrJmp7leDft+VOzZ8oAGghImw6wjaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOt3EV3gcbD1nXFabxwkY8Mpqvtj1UIAVhpyaXYp3OU=;
 b=H/J4acPzVBWkd4fUOXZxjfdTgpBBJ34E/4IM1WjE4bOa7uv2Hq5h1t7QVnFIhuRzjSlM+TF5lfWuclxAaZYzH/6aY580SZNR11A/ldxVpgdE6SecKjM4hLat+uEq9CIl4MP3Y2BZQ9e1SMehuKQWiVcUXToAEAjwg0F46xRibNFN/lM0h6ORSC6F81Ju5m1WBQbifWg+tBSMD2mNUaG5ZcLQBo5v3HFrCfYN0J3FTDwPCU9GnA/c46fd19wiG3A50Y9b+rhM/w8/g2Kz3xvLQZqGCwvZIbvf3vgPjmXhX9u7THKh4AQtK0CIhG3XcpuClgeJ+8JM03fnGIdL8sWcCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6511.namprd11.prod.outlook.com (2603:10b6:930:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Tue, 7 Jan
 2025 00:43:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 00:43:15 +0000
Date: Mon, 6 Jan 2025 16:43:13 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] dax: Remove access to page->index
Message-ID: <677c78a121044_f58f29458@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241216155408.8102-1-willy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241216155408.8102-1-willy@infradead.org>
X-ClientProxiedBy: MW4P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6511:EE_
X-MS-Office365-Filtering-Correlation-Id: 54156174-a886-4922-cc9c-08dd2eb445a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6U7UARNNPOVjxVm7tssVOWFBr7/rEFDe/zSUHRwBnBXZQS0qxQ49FvFsZN4+?=
 =?us-ascii?Q?zM5YhPVuXAifkmprtGKL1EFi6yrRtHnO73TniN/d2CIj62RXqg4WPlMtoD8r?=
 =?us-ascii?Q?ZSTkZGYnkre0O9MANVgF/yTmvLunDz8bEWV/H5qiDe1XBH25EKItxfJOrHZV?=
 =?us-ascii?Q?hu/UPeN8LUWmA6BbbzsvG7QJCb00p78HuXvfQ/t9PTejO/Ai5gf4GKhqGcja?=
 =?us-ascii?Q?+ZS57RkMO1Umj7wAI0CWG0fNfz+1poAmR5vzeB6Bzb/q1Y4BWAkOjam+mVh/?=
 =?us-ascii?Q?q29kgtYmVEcvyfRzb8YjOaITdlcuNDkgDQ+YM/QggWulcTmdDfheKoTbsnSM?=
 =?us-ascii?Q?86p9ow6w1S3Y+EDO6a7MPl56I24052eBi21+DJHOfZrGS5IJ0bKYoQgK6/tK?=
 =?us-ascii?Q?bplUBjM/aa7pRvzqs/rIKbmcQScHgeSZPcDn3mvAG+mSCoZz4nKOfLax0UTU?=
 =?us-ascii?Q?tNWy8X4f6Evmy9FgJG8PdktxkUHMQIUOioNxOrV1i9RVQTGzMAnKv3hNVv1S?=
 =?us-ascii?Q?N+6pXhqFobbB3N2yLmRAi2rk1qzlvsh5UFyMrSFGnfbq5dHibA+SFU9Ca9wc?=
 =?us-ascii?Q?5UoRRroP2U3q7A3FLEAbSMMi5q8BoFTdy78Uzuas4yKPsgmYc7VXjrSXJIYI?=
 =?us-ascii?Q?kaQgrSPEL65PWXi9I2PSDsoqbWZruRhiJO9IZIXvKuvpwVmEbjGR8iOwrtYo?=
 =?us-ascii?Q?Dnal01c17VLQbPtsnt9wHaHpFzu+6rowtRzQhubisl47WiDyf8EciYp2lBat?=
 =?us-ascii?Q?Wif/Il7YkQzdrxZFIBnzDTi+J/KfJ/t4UGSnXRynmJ2siroUjSGKEju3GhkT?=
 =?us-ascii?Q?PCZ7ucOwexCzMiys9r5I7vuHLqL/O1WE4C51lerobYsQSRnvttzTsu77WhIi?=
 =?us-ascii?Q?L8Mz6vAH9R7QhBzeKTbiYYYRxQ2sPtmzq45IJx6aFDmj4DBSwICxszLugcGp?=
 =?us-ascii?Q?cGgWcd5cqdm5l+WrMMiJC0j8iz0BIAp9oPZ8pXTCkzEX9AbuXkrtHj+vRDzM?=
 =?us-ascii?Q?IgiUGLknR2TE43bVsY8d6SyFuX+APSma+D1aY1jW/okHp+I0/pbknV21UOZf?=
 =?us-ascii?Q?63c3iWmvqgiWIe2SmyXEo6Wvo4WFUj8sVOwI/ZYobe7VGnSzPfsyM+Qa2UY6?=
 =?us-ascii?Q?WgtEOtjUaARCr7ISU1trWInwaMeKr6rUW/gb8aOibT7dbBJVgk8M5iOjqfS7?=
 =?us-ascii?Q?7xZaOzx7NSl+UWuMCwVsrQaJn3fLdS4NRW0pLWwzHdrHd3QTCJ3yn0pDjO08?=
 =?us-ascii?Q?ixrhCA9LPpL3D1TCOGDYupl4pC/sXb4NKKp1w3NZMoMk4DdoOkkvYRMRudYQ?=
 =?us-ascii?Q?BKirBobfcEy8gosYzdhDf4ofn1ndh62wUlH0GTuOlmO/kmlEaeX3IiZtmX2F?=
 =?us-ascii?Q?IR0TUfRNpVpkJqrmf1TOhrVvheFZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s9rGif++z4yPfhvGvyJFW2ivXsXWI+K5f9og1b/Wi6FwhrRTvs8j5gD5nBRs?=
 =?us-ascii?Q?jjUoum4pnimVit4+hOd6UdR+BVvBOKoyHJRF+UoLoiqNDB4qfKS/HHJSAFtl?=
 =?us-ascii?Q?m1uEgbZperD6Ig1v45v+nBxyUhRoac/tClW90eUK7oZjW/vpWRdEFSLcYOOr?=
 =?us-ascii?Q?gi2C3UjhQnya3GwqHkBF5S+Kah3trl3O7icTTnT0WCs1sLoenzJTM8O59AME?=
 =?us-ascii?Q?UU0wAEWOWDUWCY8FERPvBWMGQyriZk74o+tkwc4tZEvVagLldZukQ8ewn79g?=
 =?us-ascii?Q?3CQJ8dhM36jhU15rIcPcd3JduzLqJvsHQxA2fcZshAY7y1Sn9MV+DT6ZMlhC?=
 =?us-ascii?Q?WlVQvP3TJDpGDXVMIwR0nZxtkvXSVCmmNqPctQuqdiKeTxXWpXUmaOFPVopf?=
 =?us-ascii?Q?Ww/Yjx/ve9iFKaqtS+JCVaPsU7hCKvKqj/Nll6XKrUcWYXPHw+uBV0OoflvL?=
 =?us-ascii?Q?0h31bHAhKnnXkDGPJA8qER6bfot/P/BmH6GmrpOqDWl4DXWecr7zqWDUcumR?=
 =?us-ascii?Q?GSqiyyuprfcpWQi/GzffmL+G/lhxOWeVAd/lFl4KPTXiLDYBLYyeygaYcsRX?=
 =?us-ascii?Q?NaMjpGjkpnUhiuQQfR3yqWR5miHZkHnRZrmJJ6v7+WCidfy2Iqy/9SF0fHZJ?=
 =?us-ascii?Q?XljSM5SsqY8x+2VZj2f9DIG0H3jjBBPrXCfNWSeIp0vX0iVCMQFN3pb9u0P7?=
 =?us-ascii?Q?F2xBLEJ3xcCfM03Gv/Xbrds/p1CK7w2BHdcLPqisZx1gUaslOq8Ly+nV3y5k?=
 =?us-ascii?Q?E9vAs7BE2a33rvxLvY2rGx90DlTQ7T5qDbNV1//fLkaAfOFLKzKgSMcB6FtS?=
 =?us-ascii?Q?krwibUHF2hXdPIenc8L2y8iHUZYrW0SHvwbJ1X57NoW+ZqPvrdLBcH6jiHD8?=
 =?us-ascii?Q?tiAe3GjpkFrFwQqwElW+xV5ae/o8RWXcl8MaYi77MV2mMY7xME55pPvDjTBO?=
 =?us-ascii?Q?o+uwEirp6Y+V1fC6HwyTkFF5GKHsd+H5fSV0sYLitxfihm/XP8D+NV8hqYQL?=
 =?us-ascii?Q?9B0t6LbFvJLOGP1DhKVGzic0DrpbC7R4tgzHxG7iDI0GpDxzOhJuLsmtSznV?=
 =?us-ascii?Q?MLWrES5mgJzDZClMYvnRcgDBEEUAJAkn25WSukly7G5RouyGfWqrPwh3FI4G?=
 =?us-ascii?Q?airszub+2OmoP78NvV9RMngxRVYapqH1Tu3B5RD6xLQSu93f+15CPrKS/XIp?=
 =?us-ascii?Q?PasBBZrn0EFRa6g58zz7rMe4psZ4t/sP5ngCmn1IhRId3cILf2OV5smLJuKp?=
 =?us-ascii?Q?enIOquLsFyTsR5mrlvTcluZuDqDuROEY5BDZYOlqMKnBi7rcwk43MzqGkFTB?=
 =?us-ascii?Q?/D09qRw4/ENCwe1hzaR5cKspMS30rN5RecGDUMggM2f5G7VHA89maVE+aQ67?=
 =?us-ascii?Q?MA/pClAWh0SWO3ESNRN39Tg992X1d/GgXT2wn+/sLqp2Vah7GSbOlFVLvmmc?=
 =?us-ascii?Q?vmsnDRBguzwhOUaKY+2/MMPXuwryLUUAZxZpqWp8348B1AFH4kmc5FTzrxM7?=
 =?us-ascii?Q?wxYrdzJ6fknJUqE9gJxLBBvp6eYt26CKj0chQVQWYzhLIUKO/L7MX4BkFCSZ?=
 =?us-ascii?Q?+0omWCJ0+jvZxVhmi+44Uahn7fudFZkc9slBLaMoDsrf6ByOuAZ6WFzkGKCL?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54156174-a886-4922-cc9c-08dd2eb445a0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 00:43:15.4776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kp/LQ6mwKXG3mUZNp65S+6WGT00V4zixymxtg82eRE3b8OO+U8qX8PmajMVU4dJ7b7PTG9Mpyk/0n7JXeySXcQzrY1hOgZIunYKdAugmEDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6511
X-OriginatorOrg: intel.com

Matthew Wilcox (Oracle) wrote:
> This looks like a complete mess (why are we setting page->index at page
> fault time?)

Full story in Alistair's patches, but this a side effect of bypassing
the page allocator for instantiating file-backed mappings.

> but I no longer care about DAX, and there's no reason to
> let DAX hold us back from removing page->index.

Question is whether to move ahead with this now and have Alistair
rebase, or push ahead with getting Alistair's series into -next? I am
hoping that Alistair's series can move ahead this cycle, but still
catching up on the latest after the holiday break.

