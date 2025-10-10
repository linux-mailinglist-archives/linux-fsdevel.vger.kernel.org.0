Return-Path: <linux-fsdevel+bounces-63807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1B9BCE90D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 22:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84DC2547B91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 20:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA70302CA3;
	Fri, 10 Oct 2025 20:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9PMw+xv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F5B21FF38;
	Fri, 10 Oct 2025 20:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129404; cv=fail; b=Fp7OseMi4Q2csGQ44sgNSLIu150hOEGSM2ZsWnBNhw6oyZ0xO742C1zec85jbEQB5udfzmzuXGlO9tRpfLNf+A4C+VUFDYyfQrCU8ITajc6XK6vAenBKJmWmXgtOse72gwhzMti37M5YFvhLNTzgIkCPngEe3zoi//GaT/RD/VU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129404; c=relaxed/simple;
	bh=ZFLJrtBeX6Li5vmEpNZYPjPO2pydsd3Q5UIpoKOcwoo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=in6yEclp+oWmg4zXsV3jlSNMOg02FhfbChRTlR3DU4+xGM0+vBddG5S+hAu9VjjkDAWAe4PAB+MsRu4B4Q7ysa1jKNjnlR+zV6+wrRv3aiLZ69Sv2ovFk/N8ipvZiQ+mnFojzzN387ewHzoCoggqHLfFb9As7Qbb6rzpVXhCthU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9PMw+xv; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760129404; x=1791665404;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZFLJrtBeX6Li5vmEpNZYPjPO2pydsd3Q5UIpoKOcwoo=;
  b=U9PMw+xvjUeaCNHs8exvElaGeZxl38ZBIrJeJPLPNkF3fJJJpwpqhAiE
   g5ykOyZLFWF1e8MUMXZKzMp2x1wX6fFWmGlHmJoqAqJVakaqewV43wqc8
   U09FJfgz1fh/jv5Xnufp0nNeE8ZK5H4wSB+IOz/buWvnuuCpFKS8O6hp9
   Cu/A7K33inlzOz7Vw3IU6QM8jAcSbrRVL9ydGmhq1w45WphQwA9h0niEE
   aYBY+CRHWAZqO3PZ8OUSO/ucpLbUcwiv5E8rqfv6uerzA+PT5n5LKsag3
   zONrMji9SkMfyLWHgveEXoTHHCDaPpY0dj5/rHIcnl4QNYCYAls3dUjTk
   w==;
X-CSE-ConnectionGUID: mrz4C7OvRhe1agO1Zxqi5g==
X-CSE-MsgGUID: jaRgpg5HTmKGIaol3XpkWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="49914949"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="49914949"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 13:50:03 -0700
X-CSE-ConnectionGUID: 7x+cKwT7RuiZ0H/5z0gA6w==
X-CSE-MsgGUID: w6ZkujnBRayz9zSJCCwLZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="181079390"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 13:50:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 13:50:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 10 Oct 2025 13:50:02 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 13:50:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebAWIMLHQBFDxBaqKr7ZchRaUk3djf8ZNQZLUoPSbfdv3JgxtNmD517qP6d72q94Kr8Nv8NTLMTOkQA6LIt3Nag9YOhT3fvBvXmtVPEbtPQjdrGis2mT5Y9RFlNaNY/q002GnznMEvK6Ur7VA/RFCHJUyuD9BsrefKLV2M50Rspfc1MNhGqb1Usd2Omnis3TZ7WKvYvStRPljOuAePGegfJLJ5sBn7elfuQb/FjcjcZqGG97RSP3k+cQtD9MgMwo5/hUmvDEHZOnwkMWnBInNU7Ax8UfXQpqYaA0CYcKZdgfnhTYrKBH+iq60bqRLG0H0AKK0nw7GYEUrrbSFheadA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SL4xh8BS4zeg9LnrqoEiDCmoV1iStx1LvjVixaY9HXo=;
 b=KwFS30gs08mYNS6zXzs9MUC2BgOZQ9MMzSY00oJdS1wCgPEOW05j/bMBdAg1A88kXtl7G5n2Pjc3piVd0aZzrxkgXzlF2nk6Ei8cJFojV/jES/Fwj0fW3EtNcPXQ0UyF0C5M30bq8gIZ2fSSXxM0tfkA7WRtky2CllmGhUYv1d3Sxc3YlAtevIGXQZGXUewV9mhhSVUho8CNc4hKMaBjNqNRJasVzxCPgFQ5xSNjSPvDr4j7oRUw3kcc1B4PIz9iDY7u8bOBgWFsnjzPjototw957/h5le4jevFMpiElB94YKzjMfbTrZSVNf8U84/OyYtfm6nVuDkf5lK4bjTA6HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH7PR11MB6650.namprd11.prod.outlook.com (2603:10b6:510:1a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 20:49:59 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%7]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 20:49:59 +0000
Date: Fri, 10 Oct 2025 13:49:53 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, Matthew Wilcox
	<willy@infradead.org>, Jan Kara <jack@suse.cz>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@kernel.org>, Li Ming <ming.li@zohomail.com>, Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>, "Ying Huang" <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
	Greg KH <gregkh@linuxfoundation.org>, Nathan Fontenot
	<nathan.fontenot@amd.com>, Terry Bowman <terry.bowman@amd.com>, Robert
 Richter <rrichter@amd.com>, Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Zhijian Li <lizhijian@fujitsu.com>, "Borislav Petkov" <bp@alien8.de>, Ard
 Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3 0/5] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL
Message-ID: <aOlxcaTUowFddiEQ@aschofie-mobl2.lan>
References: <20250930044757.214798-1-Smita.KoralahalliChannabasappa@amd.com>
 <aORp6MpbPMIamNBh@aschofie-mobl2.lan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aORp6MpbPMIamNBh@aschofie-mobl2.lan>
X-ClientProxiedBy: SJ0PR05CA0095.namprd05.prod.outlook.com
 (2603:10b6:a03:334::10) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH7PR11MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: f3bd3b80-0fc9-4a29-b5fc-08de083e9352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?98mw6g4sDuoS9JvOpajSDGUFwrb837LzX03hAKiNCIRzpKlUE2kFOn2imc8K?=
 =?us-ascii?Q?Kfj1a3m0P8UqzVCFGSDIRvr0UyDmFo9t362KkDovpcJqHZ0VpADrVQiKwvJu?=
 =?us-ascii?Q?OW4gxICHyFDazFajS1ZHuNBbV601wkOBI8nBXC9NW8un99CE8DTIs3AMNLTK?=
 =?us-ascii?Q?MZdQ/NoGoJC1+1O5LU/NRvVOBxuvx4BXr5r+x3bE8fKSjrd0rb91R37K2bTN?=
 =?us-ascii?Q?EO5rCiK+n6SnRDSd09EJ7AKOqbK75pZXRStztC341UxCD1vFPtKWsf5a5bC4?=
 =?us-ascii?Q?v4n3gmu0LLlpeLui8WD5gtujktft889bSJBtZsqKA1KDJ473BBpUjA5wa17S?=
 =?us-ascii?Q?nz+A94NLzKFbRxCVrOBd9j5Xybvg6TiC1EEqgaHf4DX5GeeHeg9fS3/mKdgz?=
 =?us-ascii?Q?yWZqK09Z3vkLazFFgN1cPLKqIFhseh+LjjKt8iyp9OvXcA9LG7mGrCib8CMU?=
 =?us-ascii?Q?temMgyMpnVaFD78qQVOvh0I3W4puyykLk47todf3TLfEb1yB85jYv+Xb2S94?=
 =?us-ascii?Q?+kvsT/QgzzKzMi9dzCQwrX3Sa4zyhGZy6LHYWn4wpY6pQ1YELnYh0dGcyB+9?=
 =?us-ascii?Q?x7uek80WwIM7T3CIh54Ec85qLQxhQvF+cLBWHmdX/SfC2McNBV0x5YOdXy6d?=
 =?us-ascii?Q?AyPcnSFFlonm9NZWNYRZijaDI78NNFKS2pmQIw2s16I8IJ0f3Ygv+esJ3AOu?=
 =?us-ascii?Q?zSU++VUIZdiTO3WvHBhpSlQQbU4ppcLP9aRinof9aNlWPAUL4NwxGbyIN/7j?=
 =?us-ascii?Q?vReBxkzXY7d+3bW3aSAxlf+iHdu/vxeBbX3nfXm3PX61Vnys68kM8Kr/bVju?=
 =?us-ascii?Q?RFVlG9z46uMNS0j1eOdjSW+gVz+bShL46Z/4kPlpZMWlslitS+VtJ6Wt0tY/?=
 =?us-ascii?Q?hzABow15QnpQTApLiw3pAqTtgJXBo8IIjQa94PvL8xgwldUQ3HR7KRJ1a6sc?=
 =?us-ascii?Q?jeOcgn7mSrVGxg63znXJsDkh2rGktbElRyyQ+4usG8oqkDa4onTCHaAE2U4n?=
 =?us-ascii?Q?6+2hT3O0aj+o+MTgqc/xcXz9896fZP6ndVhOq7OkV64VrSRwr1xDrJsxnUWR?=
 =?us-ascii?Q?fp56XXh9i6MQPbse9qs+KmPjfD1EWFNGy5Tho28Gwa4Lw+UejS7m/aIORxCF?=
 =?us-ascii?Q?t1LAkRhxExHJIubN1G2uJHrLqfzzDIYwnuafZxHCWocW+XiXcqaUmrlVzj1V?=
 =?us-ascii?Q?TxTu5G3QJAKRX8xGFxGvTvUt0jIJWW15iOya7G0Ek5W9wxOP4ZhmbmaJWh/g?=
 =?us-ascii?Q?yZZeWnUABuiThD5HI6UR+3+fCREqUm5JWMY2C6qFDayYzb3XpJOTMZNNtH8a?=
 =?us-ascii?Q?UyWTIlK1Ap52poZ1ES+SUO7mgUeIXCSd3kteyGpb8sAcTHLIIRfOtpZrE++9?=
 =?us-ascii?Q?Vt688M9bjLco2iBYbvhofInZV6lfh3Rdfgm9i9TjPBEYTCIPrQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5dmaGNNPsZuRtvfGD8g/oxGpO3SZi63AP/00tBFOUn5Z2d89381mAL1Sp6jR?=
 =?us-ascii?Q?H+xv7WgW1raT9IxtW7QlLQvUyML6ZmUV5BZnHjHx3McrogttjPC1ixxW3jCE?=
 =?us-ascii?Q?1OHrGhu2LsAkOXhn5o60EegrsXIYSo75UauDjy4rCoAG3SkebwCLgu7B7QDn?=
 =?us-ascii?Q?eGIs6A4UdpW9EbJ+Rw0C3Nv0G4DigZuWaZgc6EytUwJ5R0pO0uIUHMANBaT1?=
 =?us-ascii?Q?7yHh3Vlcul9sGxK9fxucOyxf9aNF5LAQhzkxY8VLh517+fayxotGaJWxLgg6?=
 =?us-ascii?Q?kNJ0sF8KnAzGJhXqVAsG0sb73vbeonhdJEXYZx41Y+8s+mQCvq0iAuRTYNqf?=
 =?us-ascii?Q?RLU7ptHh9i/N2PD08UsPMXC87qCcCidS7hAZgi/3hQulPSaHEi+Xnzrgtxan?=
 =?us-ascii?Q?jkLvUwTIvmA8FA8mmLQtCavbuhjNcqXS0Y0o3TAS0+hZa39VJgLoYtdti/lb?=
 =?us-ascii?Q?VXDngvnXCmz4K1emCrnkSVF477R/JV8or7hnzRC6vB9lYgTaOmDn4kN6i7sZ?=
 =?us-ascii?Q?jzBTLTYfLk3EhHMgM2RZjmEDyT3IN6ImfnWhE+9XOr+mJBToUNZnuXpRknL6?=
 =?us-ascii?Q?VC3GshEFobW2klhb88PPo1rWGje2mU9fQV+pOFFyBfchEt6/y6pwCHNIM0KO?=
 =?us-ascii?Q?sfGBQddrrA+5vd/ya6GVjuGGF4ANxi3Jzq7LZYJFIiwUdMICUzrG9tEusT3L?=
 =?us-ascii?Q?cYcJZqKy9KK4tqF17pMc7LFLxl6hOGFeyLnyq7/eVPSIrFVSDIMIqH5HVZkD?=
 =?us-ascii?Q?qV3mqsV6y36Y5S6M9mPis+kAMylqJ4uE8U2VFqWibp2BPUY4B14cNYsQ0kq2?=
 =?us-ascii?Q?nmtBn7HtI85AojWxZfzC+LZjeBesInG1nqs9jDbvJw2WKINidabe31V6MZpR?=
 =?us-ascii?Q?oT6Jp9xk+HQ9S2iVu4in20kD5GmStCG+TV0gZnPaQ3ptJK/ZNalthsmNhbhs?=
 =?us-ascii?Q?kYJMDaioj2tNspM6bry/122itPwBBGwernJZh1kNGsmgxTFXaQClzMZm8WNf?=
 =?us-ascii?Q?Oka7jNDDAld/tt6pT/Zg/4oVe2Nv1LNXNWNzm2/xw3Aj96yR436jYhkm6vY0?=
 =?us-ascii?Q?Yu5CsRr6KZXi9lYkLDEmUzMQjMxcQdXOUgcb4roERouF/f+y2s6bZ794qsrU?=
 =?us-ascii?Q?oKEa/9GT8mFueTejIP0wRR2z2HusfB0dOQM5dL5JZ1Wt22+OWM1C6D43zcQy?=
 =?us-ascii?Q?kIUcngy6OxiSKtxtiYehVwtka+Vi/swu1otiPVR2hcUU3JZcn8vIOYZa5NZo?=
 =?us-ascii?Q?FeTkNeVgFoYx6LLQglO+kgPpf3jF8XuVnx/VEzWE3wCgknIwG/JNg5doNHNv?=
 =?us-ascii?Q?0Yb+RsuW0s3ubJShGzWES7vJFpasKI2NEe0tNEtcqKerCkKS9UlD/4YlJCEY?=
 =?us-ascii?Q?3rkKsXLEJxT1vYf5+ImnbDyMAcyMZGBXEAiRonsSisFd6EA7t58mGfKH9qvf?=
 =?us-ascii?Q?QCO+CbFT5j3RClZDuWCiTYPJo6q26Q5ZT/mDj3AcHG78dqletVkwNzg8kraq?=
 =?us-ascii?Q?o168+nhGyTd+53OavzJWCT263lGgSvR6NOz8QOUkA55LK+S/0kPFuUXcfosg?=
 =?us-ascii?Q?sgK+gIaIGvGOJpucKciMK6WO/YkDQrgaFr+7q7YmkNBkoI9KjsNbsSDkTQik?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3bd3b80-0fc9-4a29-b5fc-08de083e9352
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 20:49:59.1244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gj6Pg4poGCsqKca4YGVucHsgJkcHIRnTEMmRRZzDDtYeNhIyWkI46d88RmfkTNpNfxMu7j6ftwo+vYNj7WDc6/BiRQN1dd7I1G3csmHF7fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6650
X-OriginatorOrg: intel.com

On Mon, Oct 06, 2025 at 06:16:24PM -0700, Alison Schofield wrote:
> On Tue, Sep 30, 2025 at 04:47:52AM +0000, Smita Koralahalli wrote:
> > This series aims to address long-standing conflicts between dax_hmem and
> > CXL when handling Soft Reserved memory ranges.
> 
> Hi Smita,
> 
> Thanks for the updates Smita!
> 
> About those "long-standing conflicts": In the next rev, can you resurrect,
> or recreate the issues list that this set is addressing. It's been a
> long and winding road with several handoffs (me included) and it'll help
> keep the focus.
> 
> Hotplug works :)  Auto region comes up, we tear it down and can recreate it,
> in place, because the soft reserved resource is gone (no longer occupying
> the CXL Window and causing recreate to fail.)
> 
> !CONFIG_CXL_REGION works :) All resources go directly to DAX.
> 
> The scenario that is failing is handoff to DAX after region assembly
> failure. (Dan reminded me to check that today.) That is mostly related
> to Patch4, so I'll respond there.
> 
> --Alison

Hi Smita -

(after off-list chat w Smita about what is and is not included)

This CXL failover to DAX case is not implemented. In my response in Patch 4,
I cobbled something together that made it work in one test case. But to be
clear, there was some trickery in the CXL region driver to even do that.

One path forward is to update this set restating the issues it addresses, and
remove any code and comments that are tied to failing over to DAX after a
region assembly failure.

That leaves the issue Dan raised, "shutdown CXL in favor of vanilla DAX devices
as an emergency fallback for platform configuration quirks and bugs"[1], for a
future patch.

-- Alison

[1] The failover to DAX was last described in response to v5 of the 'prior' patchset.
https://lore.kernel.org/linux-cxl/20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com/
https://lore.kernel.org/linux-cxl/687ffcc0ee1c8_137e6b100ed@dwillia2-xfh.jf.intel.com.notmuch/
https://lore.kernel.org/linux-cxl/68808fb4e4cbf_137e6b100cc@dwillia2-xfh.jf.intel.com.notmuch/

> 
> 

