Return-Path: <linux-fsdevel+bounces-46784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07622A94D40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 09:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B741F1892D9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 07:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEE020D503;
	Mon, 21 Apr 2025 07:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D1gdMZpW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83289199FA2;
	Mon, 21 Apr 2025 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745220815; cv=fail; b=TGnwx88QtobLCp7pT7SdTdnXdaa6XKwtkVzDir4J4SpH9QZgIwSkEJ/654PjVF0YX2/gA7ruOWW9n7lN+XhvRQytBtMoZ583fyTqqsnMHRS69wTuWg2FilkoM5bUA2gjzgqBnH8V/eBCa2yhbgqi4+tcPRnXRgrNC0geZBwd1PU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745220815; c=relaxed/simple;
	bh=UIs8/K21UHld2B+hTscpg+ZtYTW/KW85fXs6LToe3a4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=LWMl74Vns6IPkPvZt9aOAV8eyRyO5lHadyjZHx48XEQs491sV9dKbWc9zFSy5QGyITnvDSMIo0mW35CH78jb4XVR5UQi3E3jzgbo4N9zb4yD5CRhV/4pG8BqKBdL9dtGVy+2MyaekGagsMvuX6K8kTx1ZJ8TWjZ8quVuBfnPKd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D1gdMZpW; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745220813; x=1776756813;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=UIs8/K21UHld2B+hTscpg+ZtYTW/KW85fXs6LToe3a4=;
  b=D1gdMZpWmvyN5PW2MJIXV89w9rYbYRBZzGW3k+ZP1FXED1yQIFUHypVT
   jiueQ4jQbtszKe4UCzfz33yKEq++ncw9ia0jL02Is5dwXSvdcjVbrww7g
   b6Woh9JJB0UV7eo94Q5ndUJLme9WzFMswsn3FY45z0tEpaI+w1l9q314C
   uOeRWQigaamy08936IqW4NomnWhVDgA1YhPH2g97Gx7MbbNqGDVGiuZ0M
   0Gz7U0naP+DXsSqZZ+TZQDChejqWpDK04+ZBBYDgyVvg2x/M7WxcLJ5e7
   7H7iVY5nT01ksT6UC/elFnqguUnv+4HsGp/LCU/4cUw7DHLIY0Ka5zj9k
   g==;
X-CSE-ConnectionGUID: RIEnXQZ5T26bHTCi94yxXg==
X-CSE-MsgGUID: 1b++L5ICSvqOa0lLpV5Sdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11409"; a="57396478"
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; 
   d="scan'208";a="57396478"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 00:33:33 -0700
X-CSE-ConnectionGUID: Gumc7bXYSD+yVo0DWq8G6w==
X-CSE-MsgGUID: BBsRfZdPR1OQKEq+Frky6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; 
   d="scan'208";a="132172964"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 00:33:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Apr 2025 00:33:32 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 21 Apr 2025 00:33:32 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 21 Apr 2025 00:33:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bal2DlUhFmYmvK31/vdX/xQha2NT5LyeqnQbWxJMV4yEbxAB4vhN6Qn6zxZjls5tMSy4x3QA1tYr7zi2v6YP2gAA8Zw4vlSfHqURkI9weflcdROl2/oBMUsaUUOtyMyff73ZRgCEPg5U73BkCv75PXsxyxVymLBBwZ2FMKqwW9MY2IG5OFdEz7hK/CyZAjVH/5dFdfQuRxwqZ+ZaVHMK6BBsr0aPd0F2Qu1DCb1hmwj1eCtBgfw+Y/SQSl2rmaV+FNESXaSVZ64b7lzXm1Lfejx7zYdtLcHimwoAbI50bVhsbZ4zrDiWg4H5UYQDR7tccR5nzwy5vfetogQ5BrqWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubI0lJKQJMZh0vYpHPmIuTxxr5eDaB7fe8ovXYTqcLQ=;
 b=xOulEDJaNq0FwCZRG2zVP8woLs4cwPWvSJzTjzzQzPuuhaftDtpnAu6DpMEDd7weWyNnFe7K5WUb8Gy8NoUmBtU+C+CfwTwS/h72aJDlYdl/V+ko2LRUKkheCLf8tBgct/KS9yv90WGkYOmbxxm6/srtog1KEiNXIkpvl2Y7lJboTw8rZSGvgtNpiQwBtRcc5hzFF1tJ0easGTPHsO3Mt+CGm5f5uYhtMtwtfrYrJBoH3TRNYyRElQ/0k6iEa/dFyO4A0rW8NyM6faFfdwRGkJKyoVqVo3EHYmzDaV47Es6eMC/iYNo8XTK5kAtPrKuc0zkDUPHQsy5r2hlw9s+jOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by SA1PR11MB6845.namprd11.prod.outlook.com (2603:10b6:806:29f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Mon, 21 Apr
 2025 07:33:25 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125%6]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 07:33:25 +0000
Date: Mon, 21 Apr 2025 15:33:17 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Miklos Szeredi <mszeredi@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [vfs]  bf630c4016:  stress-ng.bind-mount.ops_per_sec
 4.4% improvement
Message-ID: <202504211504.5f3ebfe2-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|SA1PR11MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: a174d121-bf08-47f8-1579-08dd80a6cd03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?aORVzjCKlgoxsB+kMQOnx2/AxdNM1kvd6qoDHOeZOkAqagpsTOHOUZijTy?=
 =?iso-8859-1?Q?VVtIKKKH4DT7fWORNLX/wtHX0FamyYpgQihr3G5OX9oQdqrfgjYg0gnJET?=
 =?iso-8859-1?Q?dJ4r/CVKrw8j+rHOftuKJFG6eJ0vNX/Fqk6IS/VqNf80XhQMi7Z1/3B9DT?=
 =?iso-8859-1?Q?+soXkUe3UtfucWwwpkN562J/OrT7oURoaPpL/OWumdV9MuHbQQCeoB7rV4?=
 =?iso-8859-1?Q?TEGrB+Mdwdu8IAYp4ATAtis6+C3MLnuq6ZA26HOlPFv1opuxTGt3vglO8T?=
 =?iso-8859-1?Q?tG/AE6oKzWRpD6u78w7dZwdOSccWFgs5jBqxMZlyypXU08KX+IMiv25nVW?=
 =?iso-8859-1?Q?Ex/jVz04ATadtO9ptARDO1IsO7/KDThFB96CMxJ1+Y/DCAspUyH5FNJG0P?=
 =?iso-8859-1?Q?JTQ8R1kDCGik+hR8Ug1ycP44a/UVDiGEIs2SxQ84BYeVaIf9DQVViYnckQ?=
 =?iso-8859-1?Q?97zW5O/FjGQH6oAaQL6pFRFxWzN8YfQZW55TdyUAQsgiRD4Rcg+SG0Slyn?=
 =?iso-8859-1?Q?iKinIWzhDMHmiT9oDZQbo5Ydecx/IWI/sdA+ar/TE22c2/zOMVaVRrrDeR?=
 =?iso-8859-1?Q?xFo6QBLTitX17yQ76uX4OVrH7hhluDdi0VdIF864I4QaOBqLjs6NlExiVA?=
 =?iso-8859-1?Q?kc0ytdmn2b/NiUlTO887BELDubai5H0WgMIu9ueJIk/VJesHrxa2DHg4qi?=
 =?iso-8859-1?Q?nWq6hOo5T8Rcf7NgvNnqWR2Y+s+aSODucLRoJhnm3Er1kGG7tOTY11PCZH?=
 =?iso-8859-1?Q?WPQpUtdhLb4lqUodVHc4EW1YTpe6VrGyrS4iGsK0p0a+T7j8wmDvcgQess?=
 =?iso-8859-1?Q?RGR9FhxNqx3V3SSlH9EHaG2AgroZgPGfux0hMvExcO07AB93MRZhTBB46+?=
 =?iso-8859-1?Q?lmJQzWnNQNZoaIo1Axnh8Qmp5b7/NGjk62IrNPf9Csqk1DApvXqLWnXCvD?=
 =?iso-8859-1?Q?kuHmzHYMsXmJRdu+Zb4tbswHKnItixt1QBBHoQNGL5e7GND9H1q9vLh9X3?=
 =?iso-8859-1?Q?Tj8u+uUE6Ylq6AJVp6N8d45JT1Do17KD5M+JEjlm79qHiq/2Zi+WztGDKD?=
 =?iso-8859-1?Q?ZALm80wfNJ9VJkVGuSXAofrwyZQh8rOHJC5Fskw9ZPTNWJ65KspnZr/e3q?=
 =?iso-8859-1?Q?iTvy48wSZM3sIsMAoR1fQDKWLjXyeQLPsYRPP+SC80yMxmpfLZjt04j+Db?=
 =?iso-8859-1?Q?XBKKWHw/dG8UMF+iqi+XjQV6vUqaJm9PMinTYHUFrBmSdtVaympjpxj2Bn?=
 =?iso-8859-1?Q?nrvbMQU9QVN8gLSnvV8G6UJrx5R0GUPrzyGzOt3tFjCh9Dy7pSSA4ZywXf?=
 =?iso-8859-1?Q?xC0UHmT0+RNzbhJs2IjIVTXHoHpCWfCtdHM045ltWffmrBvNF+HiLfWEN8?=
 =?iso-8859-1?Q?s7cWFk4IQWO3595/UZ9MLDIDODIJwepH14VsU9PX7mPL6Xy9/LCt9xXX3m?=
 =?iso-8859-1?Q?DrsC7ftCTle6dwl7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6WzmLaV33G+vcWjMWHiyFo2zcT0w0mpqARxf+23DilrSmFTE0m9qn1bVSl?=
 =?iso-8859-1?Q?Suir1MG7Bd8/yRK5X+ffTWLIRUpgBFRR43swWM6ESwhDtkqxS5v1mHYtqV?=
 =?iso-8859-1?Q?ufkrHOc2mnd0cUvcvajxQnVKocdAFYZUSuGRsryTSndUkNarin217zGWYP?=
 =?iso-8859-1?Q?TIIRxrfHrqXDcD0cZ3lp6z3SKO/1ecAcqIbjqDlgTEd716jlnsEmmH2wS2?=
 =?iso-8859-1?Q?Uzr/6vH6CBvRw0tePuFKdllibmiApM1a/A7GR7cCfhsYnNiDmx+iksIQvc?=
 =?iso-8859-1?Q?aConaZ01yxAXNEznhqJ8AGBTPfAlm+8iirIdS1wcrr6sL2KlQYFHDPhGJw?=
 =?iso-8859-1?Q?AQqNqGgBYyW8pa0x8Zp3HatnVCziq3FssVtcvJtiGhy6boySlmbbbMLYAE?=
 =?iso-8859-1?Q?eUarKWv0aIlJM8GpcM+nIRjH5cvGzG81n0/eqlZAzCnzyB1KPEJHAnEm2g?=
 =?iso-8859-1?Q?5Z45bPIkeV27AL19q4vPZXuh0X4bGf8uEUftb96lwLFEmWgSwE3mp/L94l?=
 =?iso-8859-1?Q?CuunGD0x9Wp9+6/s0ImmQTK8NbLS5bzAHRs/CZkHU/zK3HRMJVHFalcGYA?=
 =?iso-8859-1?Q?O8VSBG+tP3a+haL8SsY/x9aLJ2qqS23nIlqvrVNw4EkhMUeonUlEebRx+Q?=
 =?iso-8859-1?Q?nohcZ5Nd+pu3cSyvTxMSCmCf/zswnqjZdpA3kBXpcagmdsMD9Omj3iY5h5?=
 =?iso-8859-1?Q?Hugu/rAv2mjZkFsFvQuurTmhGRy6jIKEymVMJmsZ4WJhus5Dyp2y8PxW//?=
 =?iso-8859-1?Q?wwBCRmYUteyRpEOe6Dq17tMqFlHc7Hh2WP93Fv45T0RYLHVaZCRwTJZbri?=
 =?iso-8859-1?Q?aIoj2I/8OyT0X01/BMWMafJd5uSzIGme3HCZiISY9YUC3Bosp+GU4R/N50?=
 =?iso-8859-1?Q?0EKjaeSdhdM7Z/bcPBs/zYXTop/ZbYL9TBa7pHmCioE+12qR/FMIz4PHQH?=
 =?iso-8859-1?Q?H/HYjVOgCq7CPW9YKgi17IEGgA37Mtqvr8RqGseoXiQjxJOr613CD0b1RX?=
 =?iso-8859-1?Q?WUtlvUMYctN84pBfWQWOLN17+6NWI1fB6o7JhNIcCqZz3H+cNshcyOGqKi?=
 =?iso-8859-1?Q?SN8dM44AHgp9VkfL+NgdIzJJrI03UPQ1a/100gkIQJFI3W2nDfF+WXERLx?=
 =?iso-8859-1?Q?yOd9Q+uaEgAsyTqHH2AkQnWyaXU3wQUMn+BiOxPnVoQ+J2F4SAdGcML8Um?=
 =?iso-8859-1?Q?wOoMbqmUnuzLhbH0Jk7Fkm/tNP9Gh7Li3UckhFmeNxcabrzSbJBjmrUKnF?=
 =?iso-8859-1?Q?6Y0HEfUNgiuYW3HR3GBAL/cuNoKeD5XMMehzBIzz42b8f3DZMZSYCWf/Gg?=
 =?iso-8859-1?Q?ctFtKD/1OPoN5gzAr4Fv7d/UkF5O0hkzK4XBQetgCbNn+EniuH6LrR7EMT?=
 =?iso-8859-1?Q?Tgvu+0Ne/mZp+5v0EHcZKgSTuyAILYg21ACwdFZD9y3KxeaPnsYwgyydul?=
 =?iso-8859-1?Q?p33I8luQhkhpV84acxqzCbW4CtNJmxFL13Dk+1euFD/eSxB8C1dfw8POTQ?=
 =?iso-8859-1?Q?GvEiLcTv3IKB3Lp1tLvcCFNxUtu0CsnpO3lVTBUHARdH8YMaDmpi4HoQvY?=
 =?iso-8859-1?Q?7PcdNTZlrnr3MYgMBxamG48OKUR1WkM1lswN/9WywAOtCf+lxs+x6wmglv?=
 =?iso-8859-1?Q?jR1XinAWYlxKmohUWeMbUI20fc/aimJ7CnQ5tYRC2sYOBBcyPVl8OHfQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a174d121-bf08-47f8-1579-08dd80a6cd03
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 07:33:25.0732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: euTHiylzNQjZrCAQCwNwXCkXTZyZpG2zb7a0IamNeNkubhV7Ui7x0t4ywHR1GXZZlQMFACUkQ6/3bwYNUAQlAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6845
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 4.4% improvement of stress-ng.bind-mount.ops_per_sec on:


commit: bf630c40164162ba1d3933c2f5e3397d083e0948 ("vfs: add notifications for mount attach and detach")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 60s
	fs: ext4
	test: bind-mount
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250421/202504211504.5f3ebfe2-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/ext4/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/bind-mount/stress-ng/60s

commit: 
  0f46d81f2b ("fanotify: notify on mount attach and detach")
  bf630c4016 ("vfs: add notifications for mount attach and detach")

0f46d81f2bce970b bf630c40164162ba1d3933c2f5e 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    239.00 ±  5%     +12.6%     269.13 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    164599            +4.7%     172303        vmstat.system.cs
    191335            +2.9%     196836        vmstat.system.in
     93378            +3.7%      96874        proc-vmstat.nr_shmem
    553581            +2.2%     565891        proc-vmstat.numa_hit
    486549            +2.5%     498853        proc-vmstat.numa_local
      3679            -3.5%       3549        stress-ng.bind-mount.microsecs_per_mount
      1977            -5.8%       1863        stress-ng.bind-mount.microsecs_per_umount
    672707            +4.4%     702611        stress-ng.bind-mount.ops
     11210            +4.4%      11709        stress-ng.bind-mount.ops_per_sec
    393.73            -1.9%     386.40        stress-ng.time.percent_of_cpu_this_job_got
   1717204            +5.0%    1803755        stress-ng.time.voluntary_context_switches
  2.26e+09            +2.4%  2.315e+09        perf-stat.i.branch-instructions
  20796668            +2.3%   21274158        perf-stat.i.branch-misses
    170642            +5.0%     179197        perf-stat.i.context-switches
      2.14            -2.1%       2.10        perf-stat.i.cpi
 1.097e+10            +2.3%  1.122e+10        perf-stat.i.instructions
      2.66            +5.0%       2.80        perf-stat.i.metric.K/sec
      2.10            -2.1%       2.06        perf-stat.overall.cpi
      0.48            +2.1%       0.49        perf-stat.overall.ipc
 2.223e+09            +2.4%  2.277e+09        perf-stat.ps.branch-instructions
  20458454            +2.3%   20926770        perf-stat.ps.branch-misses
    167851            +5.0%     176265        perf-stat.ps.context-switches
 1.079e+10            +2.3%  1.104e+10        perf-stat.ps.instructions
 6.615e+11            +2.4%  6.771e+11        perf-stat.total.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


