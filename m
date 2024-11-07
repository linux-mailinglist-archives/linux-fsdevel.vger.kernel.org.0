Return-Path: <linux-fsdevel+bounces-33972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8149C10F1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 22:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6221C229B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 21:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB0E21831F;
	Thu,  7 Nov 2024 21:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="es2HGL1K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6773E21833C;
	Thu,  7 Nov 2024 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731014671; cv=fail; b=h2p9AaBDei49I7n93zcHyHNGYKHvsjAiVu+VwX5YeedSjtR/0hvdQ/k2phN+tijIaL35qI14km0BMfEgh8plp9v4JcIEp4hCz3TdJivwjkH6imhb7+LAKVFSRNTuHEQ2wVqVCCOUyaO1yLLJiq2dLjP4RWe2qrJYbePPx2U4oDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731014671; c=relaxed/simple;
	bh=Lyyw9L/OXiKmise3+3IwF+ZFqEbVn4kh19WKr/g0Dxg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oW+CG9/vsvxJHDg5LiBh1GRcfDQgVOxjFzOktjgYJ/zLmYA4QCCr1gVygA7xofskgIHhEJE19QKI/914ziKopUlA2qGsV+wS8l1UJrDxAN8SULz9XsWoN+U8Fz827lnkUrfaahr37K8FFovFQc7oE6LnPG/cWGNWHRsO3+XNyzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=es2HGL1K; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731014669; x=1762550669;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Lyyw9L/OXiKmise3+3IwF+ZFqEbVn4kh19WKr/g0Dxg=;
  b=es2HGL1KA9KKNwUXHy1C9T0evOKPUI5EzNd08vM0wEpVPypGSQEbzi/g
   Wo4hzrARaPC20uG4KlQAYz/55GtdmcafpoWs2DF12ccqopAR7yL7JRq0F
   kNNNMIKXY5mf48EewK624wjoK8Or1ABnKHM8cftw5ujjI+ivLvBT8iuRS
   4Xj0cG3fGj8DlE99++xqj4qtPmzoZsvwUzmPNVTXtsxnPi/+PeDUJzgo3
   mRxbm0kJyUg6zqpWE5xXnxRZykgzAC3uLnNxerB8YDobUH+MlRPK9QBaf
   W+UAY+9QFUkp3QwqdMxukb6+5jC5exAb4RKTF08ZM9E6Y//kXX4jsEsfR
   Q==;
X-CSE-ConnectionGUID: a/wJc90CQr6wvMUuyoWo3A==
X-CSE-MsgGUID: AwzC00TgRROkOwl4Gaj0QA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30738667"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30738667"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 13:24:29 -0800
X-CSE-ConnectionGUID: onUshBELTU+gmsMNG3FCUw==
X-CSE-MsgGUID: +wZWVnhdSfK1e01R8V9p3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="85356669"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2024 13:24:29 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 13:24:28 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 7 Nov 2024 13:24:28 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 13:24:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJGrzbbUIp5CCFGbncQqo3mDJ91n3v0gEltxTUbt/ItDri1CupZMx7/wRfXaE4lkjGrHjZbR90qEAbnQD4EtwWSsjckokG48gLGjhGvxKQ7cEI7eAxaMSVtif/iZcnSNuAoIN1ZFgOo9r8B4eWPBMHYZe/HKHrpC5FrLqAKXHy5pk3zBF5iOiC1zsmK1kFWx9NC142thl3EJxiFJPePK57wfF3P0WEhmgdM5vlWGdKhJkcvhTTzd8RWK4TMh9+Y3/HP9PGjP2Q6VytkklLX6V+jdnfaxSCYMKyVzTE97ladStLmVhwNd6EI8OMB9DV09KLCWeaOLmoV4YQts99VW8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiiiC+3mWA4NBQJHxr1bSfXHhBop+DHxclwrzXzUOkc=;
 b=nAFFbj7x3fEH4JpCCvwpz++76ZYP0NTrui/2D3swtLzbckQEP2Z778NTQLQFey15sCnlo1/InN21Cf2ZGqPLqQd+RBF46NeGcRUX4QwhGf0x3V957e8MxrRlbz9DcXmCdDSQrv8iGsjlqjOYJc1sdfoRdz/AYfvhqNjjJWPAWEGexxCMScjKt2Ksy+naOeSowRpKP7IogiowLQgCV63OEckMXhx4F3knxFjvtEBcdEgN6mUuXuj8WnkJ+q9p6B1vhuM1trVEXzqst+yATsElGl3gZGhtojvjrny0hnlug4aFijVjepD+7ZO8CzW2B8jIZ8EuEWe+rsIlqQHrcvxNUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW6PR11MB8339.namprd11.prod.outlook.com (2603:10b6:303:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 21:24:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 21:24:23 +0000
Date: Thu, 7 Nov 2024 13:24:21 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Asahi Lina <lina@asahilina.net>, Jan Kara <jack@suse.cz>, Dan Williams
	<dan.j.williams@intel.com>
CC: Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Sergio Lopez Pascual <slp@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <asahi@lists.linux.dev>
Subject: Re: [PATCH] dax: Allow block size > PAGE_SIZE
Message-ID: <672d300566c69_10bb7294d7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241101-dax-page-size-v1-1-eedbd0c6b08f@asahilina.net>
 <20241104105711.mqk4of6frmsllarn@quack3>
 <7f0c0a15-8847-4266-974e-c3567df1c25a@asahilina.net>
 <ZylHyD7Z+ApaiS5g@dread.disaster.area>
 <21f921b3-6601-4fc4-873f-7ef8358113bb@asahilina.net>
 <20241106121255.yfvlzcomf7yvrvm7@quack3>
 <672bcab0911a2_10bc62943f@dwillia2-xfh.jf.intel.com.notmuch>
 <20241107100105.tktkxs5qhkjwkckg@quack3>
 <28308919-7e47-49e4-a821-bcd32f73eecb@asahilina.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <28308919-7e47-49e4-a821-bcd32f73eecb@asahilina.net>
X-ClientProxiedBy: MW4P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW6PR11MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: ae79bbf3-5f89-4305-a432-08dcff728d11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ESVC/6YQfQiszgG470BaJEwr/O97Q4JOcdiHqRn+KVA/lQFBDOL4fBYCaX6w?=
 =?us-ascii?Q?yuzhzaDI6Jj6S09oKFd4/7I2dZ+wS+w1E6XCjVV3TEf1vpWlbW1qdeE0d99y?=
 =?us-ascii?Q?xTPUrQKzRtz2Z9YRhYPVa8gXqzepMbzhCmm1hIFHzyoCjYTbQKErv6IrsGN7?=
 =?us-ascii?Q?+iGteQ3Xj5aWZeLikXNvlZITCG8wbJ50hPFqdZ2PtSL/kKyrIcTAWHmGp4tv?=
 =?us-ascii?Q?N+kwDnRbcqfWe6oSIJZfGRHXSqllGxOlPQbjxyfB2clkQerL+BnXjRI419J0?=
 =?us-ascii?Q?kia5BgrEwj83LrQ6CiDUT8VQ6xk1Rgg0WwgDQRfwvs61qRhldQRrKSPJdyO/?=
 =?us-ascii?Q?z0Znl5ibE/M9Zj1wkvee887DRyFOqVv8FpQOLEdexFiyh9vpwk1Q56aH7uYZ?=
 =?us-ascii?Q?6dod0dxnB+pxtjmxxta6uspyWsND2cOlgB+mRi50bxpvpi0f/oQA1eWb5wA2?=
 =?us-ascii?Q?JEcMmUyrwECrtNWNcLQe+Msh+wZ2xIJpL4go71X360T5y7PECC1HXl5YhE4c?=
 =?us-ascii?Q?i8qWVqPp5+jqLjcO7p41vvPbzqjJ4ng2j/ihpp2vqPQ9grI/TI76cG2ps8hC?=
 =?us-ascii?Q?jzh6IeWJuK17j+86Yqp44dfwjaXPBsnQmy/ROc5VQhE0WtkYT4u6S2IrdHnO?=
 =?us-ascii?Q?RrrN6L7VbZErtp/FDBcHj25WtDsANIfZOcNGZnPBzp9jQoh97EEl5neMy6Y6?=
 =?us-ascii?Q?qz6Nhe/OixCyk9MoqI0Cwdvj9crfH84Tm3D4B8DEViXx2DowFT9ZvevZJ+qM?=
 =?us-ascii?Q?RfkuKywz60QtbVCBq3iHaPfxT/gh3juYpHqPiBMMARve5X5QcUva0Q6pCP95?=
 =?us-ascii?Q?zoFDlibLsY3oCclWHQ8gS753xB39c/BEPfV1+ddAdyYyu0vbkWKwhULZQ2GI?=
 =?us-ascii?Q?28ggt/nGC0xrfBf9xfONLZz32K+/aAw6b7u+SeKNU24sEaOcDp8aqpdbqDBX?=
 =?us-ascii?Q?Vt9KlZzgiaCXtWDzH59+2aOw2kI62atvQHAc8QqYtMvISjOaRxBzDnNtiWip?=
 =?us-ascii?Q?4/Tkd10CtuPVlOog4z8JJSH2IQexIG2UdOLmM732fHDb9KCn7pvgiV/QrjUM?=
 =?us-ascii?Q?2HZIgkF7YYcIdNxxJTmnOQPplOxJ1UwKLPpUHoMsrRohCnf0X7u9rngnBSC7?=
 =?us-ascii?Q?7ttO7nizbeQSZBlntNFjyhQ5fZLr6E6MfJHXlPGcLhKMGQC6XAdczoPmeZJ1?=
 =?us-ascii?Q?h2iyrwhVwALPwTxWG80ITP2C7SCUrMqFZUliwddhJhw1WuvobvDuu7CBE4uN?=
 =?us-ascii?Q?fj3wHopJ6DxOeURpKE8/wdZtTZfBT9r+chGA+AGmumu0Hum84BgPqrJw6G2y?=
 =?us-ascii?Q?od6MiPN0eiAh/jS5iLkM1+UJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pxLJIwl6eeHLSTcPZ/zfDVb04tZRpIOBhUaEwIXoy0zixYXVXxkdHn/jkhwV?=
 =?us-ascii?Q?wbmC68k60LPJuXo9OvhLjv3Xn7mCIpAHVEhwlgnXqHzpA4CRTinSsfgxI5l3?=
 =?us-ascii?Q?joBZCwoIkYKrCG3GXJyVoU5r4J7XG6TJQXomIXTZfcMFqLJznhTLstETXnFw?=
 =?us-ascii?Q?dMZDpNemWUyT3ezm5Nt2KTooJUJZ5H71hgt+CN9R5T/ztz5gc26k4gRE/Njm?=
 =?us-ascii?Q?9dewZu/wvDnnCPVlHCZbdgdVvolb6a+iRBa2zqoi6l02Si9f69r6U2DzzGtx?=
 =?us-ascii?Q?HhcFw8HhQR3eRBnvLDZaRRoBdo0FNxCo4oKt55YCFnRkfcAqKNZ4HM1QjMrQ?=
 =?us-ascii?Q?PDDifrI0WCAewJwDPrts4HbcVEnOL41oUCMfNuP0cPXg/A0UhO1Yxi7E17DA?=
 =?us-ascii?Q?I7zrlBCQrA63MoPSuW8kilZXPwQ22dOmle51dPwL2JUoqD5woCEA8VLotYZM?=
 =?us-ascii?Q?yAqbD5LILNFa9uGEuyNHjcCinO8eMvGdFZzV981cvSIe1bPFjevkoO34pgwR?=
 =?us-ascii?Q?BYOPPTUmQOHMb+50cgapmYqilmJuaM3qXXnTpCIt06jx40+bCre3ApAHjGQP?=
 =?us-ascii?Q?2TBaqgidkPKAHerqAsSBYxxVZnxmE3LxMDuvf/al8ijXR96At6VatkSXWML/?=
 =?us-ascii?Q?PnV+aitn3/RPY8vWqv4Hk+XGRnKplrSPmLG9T4NXjfMzABc/vxwA58c2kLTN?=
 =?us-ascii?Q?aisRmE2GN8myWRZ6JM6qjFxdgsivwQGlg5bnJ2p6acCzu+FS19yhTVNwhVyp?=
 =?us-ascii?Q?qUjeI1HgABynmvH78c1X/N+NNb/NlEfOtGpvkM7pX7NmV90Kz7OKMVubyjFN?=
 =?us-ascii?Q?Uk5n0DKHyVWTCkO/g8UioCJn+9wBEF1/wARw/jBnP2ZrcpbVwPpz++DLbnuv?=
 =?us-ascii?Q?5UpMN5Pkqhr4FmEc80qx4svI7A4qI862wixbt//uAg6qfuHQNkwHeoyjT3Si?=
 =?us-ascii?Q?XBYvvASx5F9ED2vgxPKulFD+tVqUn0shk8xbC3vEQ63YVSF9zZi1AfA+0U7S?=
 =?us-ascii?Q?jUW83bdvHZRmH58uVwN5JqAI2EkR2/WSqtEFhw96Q+6cPGcOnXszqTUO02RN?=
 =?us-ascii?Q?sZWJZ7y5e9V2Oqezbp2240dXpBu4Tuh/QiVV17Yer8Nza7ypBriqcjhTy/Y0?=
 =?us-ascii?Q?1sKquNRNhKctcS6uA4mq2ZYRjP1ogDqS3bdJQWeEGMMB6ilaZfSrnJVFts9L?=
 =?us-ascii?Q?iev2GXCVqcBwimjh6ophZ50IlKcliM3R7U1Y4/tVHHES4rzEgHO2QGj7jdKF?=
 =?us-ascii?Q?6PgOOhPLIIUFsXQ9V13Q7MHmj/eYpJLyIiKXrK8QIup04Nv2qyKyohYvxwuM?=
 =?us-ascii?Q?OsQHqOU8VPiM+4J4EOiSpIh3a1sZK2o8XEcE139m28F6b89FAJjVIeTbTTvq?=
 =?us-ascii?Q?3PKKS3OPiNU5skSo8QMHh7hFuVtNDF6jFLQebsbkX9qAtT8kr/4y7lIuUyo7?=
 =?us-ascii?Q?+FhGxF+o2E1z0psj5tar912WwaABqv6mruV8hI9czp/GIemXdEg/XerzETr0?=
 =?us-ascii?Q?QL3O/2KM2gJCBJEB9b0NkfvnVa/Ih/87aSpFm9mbQr96o4l391bz/VnXUt2Z?=
 =?us-ascii?Q?TPpvE27NH7q8EKr773Iyjy0j2rIfmTH7Ij+2LUKAkRNFUEZZeRnJwJQDvjR+?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae79bbf3-5f89-4305-a432-08dcff728d11
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 21:24:23.9026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7jOg72GHkuf8pgW6jakWF4d5M/sBx/C3n6bRcBj07u/MmvzLCAwfpje3OaKtluCQxZinfDljf7EsZCyqX23c4Ym0WR3fxvPHJnPoIibXgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8339
X-OriginatorOrg: intel.com

Asahi Lina wrote:
[..]
> I don't think that's how it actually works, at least on arm64.
> arch_wb_cache_pmem() calls dcache_clean_pop() which is either dc cvap or
> dc cvac. Those are trapped by HCR_EL2<TPC>, and that is never set by KVM.
> 
> There was some discussion of this here:
> https://lore.kernel.org/all/20190702055937.3ffpwph7anvohmxu@US-160370MP2.local/
> 
> But I'm not sure that all really made sense then.
> 
> msync() and fsync() should already provide persistence. Those end up
> calling vfs_fsync_range(), which becomes a FUSE fsync(), which fsyncs
> (or fdatasyncs) the whole file. What I'm not so sure is whether there
> are any other codepaths that also need to provide those guarantees which
> *don't* end up calling fsync on the VFS. For example, the manpages kind
> of imply munmap() syncs, though as far as I can tell that's not actually
> the case. If there are missing sync paths, then I think those might just
> be broken right now...

IIRC, from the pmem persistence dicussions, if userspace fails to call
*sync then there is no obligation to flush on munmap() or close(). Some
filesystems layer on those guarantees, but the behavior is
implementation specific.

