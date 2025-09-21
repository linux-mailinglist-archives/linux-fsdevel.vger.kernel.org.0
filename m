Return-Path: <linux-fsdevel+bounces-62331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1177FB8D8BE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 11:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF973BDEA0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 09:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B655F25484D;
	Sun, 21 Sep 2025 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cpwoLQhf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2322619D8AC;
	Sun, 21 Sep 2025 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758447851; cv=fail; b=RYoTtlqtEWofs8vq0/zt5mn3c8hfs+TCYuh1dPFs144ZJjqROgXaUhc7KeSmlMt3SnkkMcLiEcmf1BAAMrRKnCot6nY9u897Unry0fuNhfnnIYLwMqGS7EfZ1ojOh0HqMFJ8JvpcrUVOZn1a+xaz8+rWaEMTlAsg0hEV/myyzYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758447851; c=relaxed/simple;
	bh=8mvySflC4iFeuPtAzClM5bs6BKXknI7NQadiyFUaCZg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F3nwxnWd3GUGyNZHrfQuqAcR/1UbGkuIemfw8hAGAYURbG9FXbOb0S+JydDC4l7L1TPIDam4bKYFr564IL9z5gYtaCy717d8XJ8lv46tP/e49km6VcKl2CYo67zsBusMlNvjZJQkbCY5sWuknbD+9wgzcQFZnwDGM5hUqOmfXVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cpwoLQhf; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758447849; x=1789983849;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=8mvySflC4iFeuPtAzClM5bs6BKXknI7NQadiyFUaCZg=;
  b=cpwoLQhfVZd9neEMaHYLwcsvU3PoMqGL77FvIq1PtOlK+xh+mVUtBMab
   sRLqIq/7yJSyaeEy5SuzlEhI4MEcU9IJyYvVcDnuY1/j8ALUzsPiTyLJd
   HF0Sx9drhxVcxtRAbYTfhwbWH0xrS8X5RJJecNRYbIDpZEkCLm7Dem0Eu
   ReK38bUTH0tprfYOx+m5wYvcSIwEfIjCKoWkEc/iI32Nd9Njg25YMNGWg
   rO8OE8zR3uYlVTH239OEhEm733QNWrmbywKpk5yEuHD9ZnkFIE6nDPzfd
   YcM+2wGQBFogfImxcJW7GWvZm4YVOXFDbl/Odj+3sIyledx+bq4Fn/p71
   g==;
X-CSE-ConnectionGUID: s7WWvv2lTBSzWXcGDVZEvQ==
X-CSE-MsgGUID: LBUcfw4YQHChd5zb7WzBaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11559"; a="60431797"
X-IronPort-AV: E=Sophos;i="6.18,283,1751266800"; 
   d="scan'208";a="60431797"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 02:44:08 -0700
X-CSE-ConnectionGUID: /3oVBGxQRzGbDvYuqx/t/w==
X-CSE-MsgGUID: B6zIl6ycR225EJDjD0Sozg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,283,1751266800"; 
   d="scan'208";a="180248166"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 02:44:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 21 Sep 2025 02:44:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 21 Sep 2025 02:44:06 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.13) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 21 Sep 2025 02:44:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvHfgOTKiIzuOb1PMlgRyfjaBXfM/EVEiAKcXzcIUFp8+MqPHUWfFmuVcL+Xyio1uXieneJZA2VoMVqkhD6V3fCeNdRikXEzp4etfPsYUpjAchAVn694i63bAm9i90AoK7qAZnEO0v6BzsU4EB9kZLYqrPxrtMmToTt+cXYslQC9shOPm1JNxl6D7EMSxXlyEORLNm14dNzFcEsBtyTTumuG2pUrn//F+bgafEPQqHXSACMmpcUJZSgJ1DRCtN2cUFMzcjLt8r2S4m6LzdOfoOIW2g2i0a9EiatNb4jij1lcs+XyS9kSiX189Kqe3/F+LfhRYNm+yF3ESsjMl/0fqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mRZVCNPO4rbEaIpVrG1W3ZPsbQsGMmq6Pgo7CdGF50=;
 b=L2KFVCkjNhbgb4O1dMRkGfQDR3TD1XA2XMgu9LeoEBlIpz23yyDJuEwBF5ZhmEtjQQhDWbeEIm/lNeQRANh9lfQLKvx3EFcqYh89Cx571G4wN5C2+BIqHK5azJr/sJf/Sc2pidMk5uZjwGde+aduRvoVsEK8sbCwW5qR07Ovv+qy+v+UcvAoFJJ3K4my1BieaypgLnp+aOWmUzVPUCsPButsEh9QydhsAlwVdOB16Z8owe8/PBCGvUiXcoHNisK6Xdq8ZCticN+Eu5sozuzLuOnvLAZI8KjST4LbWvObSnTHI8sfAk5Y/BkXYe9vpbaYQq1AxOYq/aH5FpBs6VbrOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ1PR11MB6107.namprd11.prod.outlook.com (2603:10b6:a03:48a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Sun, 21 Sep
 2025 09:43:58 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9137.018; Sun, 21 Sep 2025
 09:43:58 +0000
Date: Sun, 21 Sep 2025 17:43:46 +0800
From: kernel test robot <oliver.sang@intel.com>
To: NeilBrown <neilb@ownmail.net>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Amir Goldstein
	<amir73il@gmail.com>, <linux-doc@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-bcachefs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<ocfs2-devel@lists.linux.dev>, <linux-cifs@vger.kernel.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, "Jeff
 Layton" <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v3 5/6] VFS: rename kern_path_locked() and related
 functions.
Message-ID: <202509211121.ebd9f4b0-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250915021504.2632889-6-neilb@ownmail.net>
X-ClientProxiedBy: TPYP295CA0022.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ1PR11MB6107:EE_
X-MS-Office365-Filtering-Correlation-Id: ab64e836-ba46-4990-bae2-08ddf8f36340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j87uuGhxwJK9wXF+TSVpzfEST90GYB9Q821zu07WU/Obrjzwqdnm7bjqkJQw?=
 =?us-ascii?Q?jIMoGnbUPgYx95P5hKTewQMMR8odUCIQ21v/za0fIs8lOKLK1gMkhCsKIf6c?=
 =?us-ascii?Q?NFRKYDv/vTsSPeYMVq9WVxxUKIHWHV0m/gCF4UZsIkXkItBwqBUJbjbh2GNH?=
 =?us-ascii?Q?m0o9AuBG+btkT+Z8cR1LeUG9306TklLARoHQuAWmhBVgAY9TACKLbCu7e80P?=
 =?us-ascii?Q?J7VX3DGrYuDG/ZKspDiSgX1Fh17CvjIqc2ohekrTPKclL/6sBDMQjxscKkPZ?=
 =?us-ascii?Q?RW24VGCH4USrkZAEf6dlsxDKHYVMGiGMmDPimTAtySzKpV8DC6hpvC9xT0Cx?=
 =?us-ascii?Q?FBnh/OCdLtdvtvRTynkPUV8/HcRlZ6cUvpWr5Uw2+VuuUc6cOweisVzFvkUF?=
 =?us-ascii?Q?NNJ1U2jwINGxpCbner6Dd8QtR6r1Wav9ACbbkFNn1w/repabC54ejLR5wfVs?=
 =?us-ascii?Q?+3syYBLEQDqN3YTuuvtOs7MA0F7h5NT5pwZmlWcKgWWQIbmJPjgpFpCIHyaM?=
 =?us-ascii?Q?WRGBYLpOHqsXs0yzkK2X5kgJXG/QGweWk5sVIDKJ8Vqc6TIPK2PqzpKQiEt4?=
 =?us-ascii?Q?lgx4NUYvpe2L6kCmkdCN9TT21848lQCHRfPlmZ4gTH/VLJZc6RxBgg7RlVch?=
 =?us-ascii?Q?R02FHuOi4epYxTPeGWhQmFC4A0azJbi6JI50NSJBf25se+h4MsROlsiaQ3tD?=
 =?us-ascii?Q?XG8Qv1SavisgLYo7ceiTtUOlxN6k5rSJ1GuHAojKF8wQcPG+RD5G52O3X7xa?=
 =?us-ascii?Q?Vf6mp4f6+QkmzXPeDdlJ55GYyxjog03OzzP+aFKSiH6X3Uu2e6Lnyv41z3ji?=
 =?us-ascii?Q?jAb9AIVhsHnag7F47XWiXVEdHok7XwmH7wc5q9+eLSqr7EOHs1aJj+Yqibqm?=
 =?us-ascii?Q?49Rk3Ep8p3A5UcMyLkbz3okCZ3UmAlGTau/PYTYRUwzDN2giBNWTy2yh0cn0?=
 =?us-ascii?Q?RKz6FIIMCW7bWr0WrCDGo6alJymPNiPcKE738D4XwQVsxWYTe4w5OuDVEK+N?=
 =?us-ascii?Q?XHb0y99rhEckNIT4xzAB9zaavzN+dSB7SCi5qhBfvg9jvjLD2IoHblG4DabX?=
 =?us-ascii?Q?mwpXBWs38fnVil7VKwLLeHb4+57MgtcNks0BCY9GnbG1JVELbUdL0Di/RsHl?=
 =?us-ascii?Q?IoYWUnw4dWmzIgUYVaI/zUrgaS1c0ux71y2ezlcmTOWuBDi7OHiJ4u4f7e+r?=
 =?us-ascii?Q?EYbhkd7x2UowIkPr+e2be17mL954Y1Oi7or6vVqBK0lPZ28bJLFlNYNmP96k?=
 =?us-ascii?Q?7nnS1ZHi4htxMRgnd/qKwp9HdShbsjflhpSUB9rWixBtZWlXmVqgrKOFUGIr?=
 =?us-ascii?Q?mYTwykHgmSH8F2pqGHqwks7kNJHILnHa6F51CYgYJ324LnZNSiwycr2MvI4g?=
 =?us-ascii?Q?YrRPbAZIQlKfvVvmmiuNxdIynZob?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZfydYbg3H8gz/zMJ1aDd6WTU9MdPi/a5P5QOPIULZRiUYbk6lVpQqyROqWKR?=
 =?us-ascii?Q?cfVQoeje2RPKNL+0rGzRiqawu/gVKOE4/9XGP/fed7vavxSOoXvujELnnpym?=
 =?us-ascii?Q?8PyUvyZ7z7of6ZP4gAeh/ye0uflF2Li2QZOSHZtzSPFaVNbkdZ5XB1dP7564?=
 =?us-ascii?Q?5pViNUphprfB6eXKtQ+e0xp4lNQ2WzbOu4j1jpIKQ2Sths7GDR+RPZ04ixeG?=
 =?us-ascii?Q?DLesgFi0yOV/XaUKfDR5vchnmrotfJGo5lY3AyWKHMRijJmmyqCJwcA6gZJb?=
 =?us-ascii?Q?wXauO4zX6EqpRFs76YRhbOnLEnTpZqTP/YG7fMOZIifWDgZpkkqBaWXlq3DC?=
 =?us-ascii?Q?yNlU5gWLhV2PQWMar4BnHQ0t3vBBPHoWLOfntBfJqaRUrvX3gCKa8t2uxKn5?=
 =?us-ascii?Q?CLPTEU1QELsDp8fOS1j5WtBkjxej6w6pmZ6UMotc+qc9AeqAUQ29lmtwT/JQ?=
 =?us-ascii?Q?y4Bg0HlClVv5oyxjxnsJLRFuccXMkM18QKkz60aWG6C0tqmYi4iSiIpRV1oh?=
 =?us-ascii?Q?FISnP22B19FyUA8lrj3eLvwiml01g3OWFhTlv1m3aPxiAaYRJUinXJFhy1YK?=
 =?us-ascii?Q?lTXTXKKBO8lX829uZVhIchQfSMaRike0vsF2czxa3SC7O37wAMfTBXgvHcvu?=
 =?us-ascii?Q?GNNcuK3V2CBAmYre+xwgTk3precri86FrNV5oHjS9NJQPzWsqmhm/EvyRYMH?=
 =?us-ascii?Q?08Jjel8QzRKqb9alWHLfA8eivBNq+tKDF6cJwUvseb5IN8yBaqku2zNKMeND?=
 =?us-ascii?Q?0L5OmKVlGhOflBNRN5Wnw6RpzVSfcRqHR1e0JKRFVTCEmHRf4kxlrEHQ1tkC?=
 =?us-ascii?Q?tdwgfXXjSy2zSXu75JXj/Qcr/8HJ8SeORRAtcm6zipAz4ONSfsAAgAkyuiu8?=
 =?us-ascii?Q?usAFRaojkHPMBGfzIWMPtflGKI6qYQOlt3S+Jw3/tKM/RE46atTbUVj3rQCG?=
 =?us-ascii?Q?RWvTzYDACVpSqW+RwHxTGnRbkUDTowvfu5fa80nqHzfGzN7NhhGE8dVJxBlX?=
 =?us-ascii?Q?1ictL3yL+V6XvtTUWIKNFXPkytiynNQOQrd1X8IHLPhPsjhVizpyVybJ/cpQ?=
 =?us-ascii?Q?hGwaLoGgn2iUm8dwgn1TawnAFVfSrRuEf0ZPp0urDv2rTKW9RcUdchUiYi6f?=
 =?us-ascii?Q?ckNBh0+X9iObkd7E+arnlrImndIOGuIv+ieWQz/jgllc+Zv9QKaoHNODJL0R?=
 =?us-ascii?Q?P9LAhHZCupBxPsZQBikUY+aUJXJtDTj+PEXXwXLvCDIddRj7amo1e7QHPR6B?=
 =?us-ascii?Q?j3o9VoVvIsOo3oVGwCdqGmq1p06aYSHw7TD76lLJMvBH/8R5aUaWVPbTxD+x?=
 =?us-ascii?Q?pHAN//oWmpKT22Y7bmXkCWWXFNH8pDczuY896VSQcGAbL6OiyAyrhP2hj7th?=
 =?us-ascii?Q?ErCd8noN50A8XgMERVKd3unC+mHNq9m3x385W5Z1STI11TFWbH7dNe1Swlof?=
 =?us-ascii?Q?l9muDQGs/QmT6j6xq3Q9HwqSxrv48B3NgWf8WcCFEJDFnhIQDOr5UDQH67G8?=
 =?us-ascii?Q?6Xh9eMtrYE40NZISJ14ko84mI6s2SnUrawwy9/eh71ebtu9DvKfFLsfIty/U?=
 =?us-ascii?Q?7mQADjyUwGydaxm6n2zH+2/GMTY99AWqCjCi8LiMXEwKtb0V1YHuv3PRMDcj?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab64e836-ba46-4990-bae2-08ddf8f36340
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2025 09:43:58.4864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: auoV7AcMdK4NAm74Zn3SGryEW8EPJe7IYFS6dgGuKvmCjCl8TMntqPEaWf8QiguU1PqC9g8Ww+BsVnIdF8M09w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6107
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:

commit: 747e356babd8bdd569320c29916470345afd3cf7 ("[PATCH v3 5/6] VFS: rename kern_path_locked() and related functions.")
url: https://github.com/intel-lab-lkp/linux/commits/NeilBrown/VFS-ovl-add-lookup_one_positive_killable/20250915-101929
base: https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.all
patch link: https://lore.kernel.org/all/20250915021504.2632889-6-neilb@ownmail.net/
patch subject: [PATCH v3 5/6] VFS: rename kern_path_locked() and related functions.

in testcase: boot

config: i386-randconfig-2006-20250825
compiler: gcc-14
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------+------------+------------+
|                                             | 1c87fa0646 | 747e356bab |
+---------------------------------------------+------------+------------+
| boot_successes                              | 24         | 0          |
| boot_failures                               | 0          | 24         |
| BUG:unable_to_handle_page_fault_for_address | 0          | 24         |
| Oops:Oops:#[##]                             | 0          | 24         |
| EIP:mnt_want_write                          | 0          | 24         |
| Kernel_panic-not_syncing:Fatal_exception    | 0          | 24         |
+---------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509211121.ebd9f4b0-lkp@intel.com


[   12.277015][   T18] BUG: unable to handle page fault for address: fefeff02
[   12.278063][   T18] #PF: supervisor read access in kernel mode
[   12.278982][   T18] #PF: error_code(0x0000) - not-present page
[   12.279886][   T18] *pde = 00000000
[   12.280491][   T18] Oops: Oops: 0000 [#1]
[   12.281158][   T18] CPU: 0 UID: 0 PID: 18 Comm: kdevtmpfs Not tainted 6.17.0-rc3-00100-g747e356babd8 #1 PREEMPT(full)  97a7d9f1f9975edf00ea02f43ed800cec17522a0
[   12.283292][   T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[ 12.283887][ T18] EIP: mnt_want_write (include/linux/fs.h:1908 include/linux/fs.h:2044 fs/namespace.c:566) 
[ 12.283887][ T18] Code: 74 26 00 55 83 e8 30 89 e5 e8 b0 ff ff ff 5d c3 2e 8d b4 26 00 00 00 00 8d b6 00 00 00 00 3e 8d 74 26 00 55 89 e5 56 53 89 c3 <8b> 40 04 05 d8 01 00 00 e8 67 f5 ff ff 89 d8 e8 90 e6 ff ff 89 c6
All code
========
   0:	74 26                	je     0x28
   2:	00 55 83             	add    %dl,-0x7d(%rbp)
   5:	e8 30 89 e5 e8       	call   0xffffffffe8e5893a
   a:	b0 ff                	mov    $0xff,%al
   c:	ff                   	(bad)
   d:	ff 5d c3             	lcall  *-0x3d(%rbp)
  10:	2e 8d b4 26 00 00 00 	cs lea 0x0(%rsi,%riz,1),%esi
  17:	00 
  18:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  1e:	3e 8d 74 26 00       	ds lea 0x0(%rsi,%riz,1),%esi
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	56                   	push   %rsi
  27:	53                   	push   %rbx
  28:	89 c3                	mov    %eax,%ebx
  2a:*	8b 40 04             	mov    0x4(%rax),%eax		<-- trapping instruction
  2d:	05 d8 01 00 00       	add    $0x1d8,%eax
  32:	e8 67 f5 ff ff       	call   0xfffffffffffff59e
  37:	89 d8                	mov    %ebx,%eax
  39:	e8 90 e6 ff ff       	call   0xffffffffffffe6ce
  3e:	89 c6                	mov    %eax,%esi

Code starting with the faulting instruction
===========================================
   0:	8b 40 04             	mov    0x4(%rax),%eax
   3:	05 d8 01 00 00       	add    $0x1d8,%eax
   8:	e8 67 f5 ff ff       	call   0xfffffffffffff574
   d:	89 d8                	mov    %ebx,%eax
   f:	e8 90 e6 ff ff       	call   0xffffffffffffe6a4
  14:	89 c6                	mov    %eax,%esi
[   12.283887][   T18] EAX: fefefefe EBX: fefefefe ECX: c5923640 EDX: c58b9e28
[   12.283887][   T18] ESI: c58b9f0c EDI: c54024e0 EBP: c58b9ea4 ESP: c58b9e9c
[   12.283887][   T18] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010246
[   12.283887][   T18] CR0: 80050033 CR2: fefeff02 CR3: 04780000 CR4: 000406d0
[   12.283887][   T18] Call Trace:
[ 12.283887][ T18] __start_removing_path (include/linux/fs.h:1024 fs/namei.c:2784) 
[ 12.283887][ T18] start_removing_path (fs/namei.c:2842) 
[ 12.283887][ T18] devtmpfs_work_loop (drivers/base/devtmpfs.c:326 drivers/base/devtmpfs.c:387 drivers/base/devtmpfs.c:400) 
[ 12.283887][ T18] devtmpfsd (drivers/base/devtmpfs.c:444) 
[ 12.283887][ T18] kthread (kernel/kthread.c:465) 
[ 12.283887][ T18] ? vclkdev_alloc (drivers/base/devtmpfs.c:436) 
[ 12.283887][ T18] ? kthread_is_per_cpu (kernel/kthread.c:412) 
[ 12.283887][ T18] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 12.283887][ T18] ? kthread_is_per_cpu (kernel/kthread.c:412) 
[ 12.283887][ T18] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 12.283887][ T18] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   12.283887][   T18] Modules linked in:
[   12.283887][   T18] CR2: 00000000fefeff02
[   12.283887][   T18] ---[ end trace 0000000000000000 ]---
[ 12.283887][ T18] EIP: mnt_want_write (include/linux/fs.h:1908 include/linux/fs.h:2044 fs/namespace.c:566) 
[ 12.283887][ T18] Code: 74 26 00 55 83 e8 30 89 e5 e8 b0 ff ff ff 5d c3 2e 8d b4 26 00 00 00 00 8d b6 00 00 00 00 3e 8d 74 26 00 55 89 e5 56 53 89 c3 <8b> 40 04 05 d8 01 00 00 e8 67 f5 ff ff 89 d8 e8 90 e6 ff ff 89 c6
All code
========
   0:	74 26                	je     0x28
   2:	00 55 83             	add    %dl,-0x7d(%rbp)
   5:	e8 30 89 e5 e8       	call   0xffffffffe8e5893a
   a:	b0 ff                	mov    $0xff,%al
   c:	ff                   	(bad)
   d:	ff 5d c3             	lcall  *-0x3d(%rbp)
  10:	2e 8d b4 26 00 00 00 	cs lea 0x0(%rsi,%riz,1),%esi
  17:	00 
  18:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  1e:	3e 8d 74 26 00       	ds lea 0x0(%rsi,%riz,1),%esi
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	56                   	push   %rsi
  27:	53                   	push   %rbx
  28:	89 c3                	mov    %eax,%ebx
  2a:*	8b 40 04             	mov    0x4(%rax),%eax		<-- trapping instruction
  2d:	05 d8 01 00 00       	add    $0x1d8,%eax
  32:	e8 67 f5 ff ff       	call   0xfffffffffffff59e
  37:	89 d8                	mov    %ebx,%eax
  39:	e8 90 e6 ff ff       	call   0xffffffffffffe6ce
  3e:	89 c6                	mov    %eax,%esi

Code starting with the faulting instruction
===========================================
   0:	8b 40 04             	mov    0x4(%rax),%eax
   3:	05 d8 01 00 00       	add    $0x1d8,%eax
   8:	e8 67 f5 ff ff       	call   0xfffffffffffff574
   d:	89 d8                	mov    %ebx,%eax
   f:	e8 90 e6 ff ff       	call   0xffffffffffffe6a4
  14:	89 c6                	mov    %eax,%esi


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250921/202509211121.ebd9f4b0-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


