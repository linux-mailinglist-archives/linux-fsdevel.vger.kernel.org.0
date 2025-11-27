Return-Path: <linux-fsdevel+bounces-69963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0864DC8CD18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 05:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 816EC344D8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 04:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD49730F548;
	Thu, 27 Nov 2025 04:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIwdEK6B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1912D7DDF;
	Thu, 27 Nov 2025 04:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764219536; cv=fail; b=PMYdDGWJlfcYqoT6Uv7qI/twrQ4j7lBPtFrznDA42XUPskK0kmPgvzydMZFPFjRjbGr7Xjk6E6vk+FojO4deIUAqxEExYoCjrMxLCBzNO5TdXqQJVgG4+eMd63TfD1tGe8TKykWnp+j5FyZIGJcWy7TFNur6Knd8ybpWE8IdsOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764219536; c=relaxed/simple;
	bh=Q07Rsh59dCydbeX9hwttCnvVjcVlEIgTXh3/3Ppvrfo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I/+P9k72nuxADJ4y6ScgC9qoQw7wq8QiNY6yq5cMtpbHzOOyaZNSx0hMShb+CUID/sRpTkFiPl9ebvVnJ776DcbkdipgI2p03ptk0gTbo43Trg4M+pzZ9xw4++M4CMEz+yXGKzBqadkbyil6gm4d/de8lGjzqkZOxVvTe9ub7R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIwdEK6B; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764219534; x=1795755534;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Q07Rsh59dCydbeX9hwttCnvVjcVlEIgTXh3/3Ppvrfo=;
  b=kIwdEK6BcU/PK5VVQ7ePqOL9LXXtbFz0+MazHFmXHO80Xtz7FBYqCIEl
   Z5SAWw2RVZ0igfwfHIC+64+6kIPc8HCyV+PxrcNW1YiT9f7hvl4B51Moz
   zR6Ebk+aNoqGVp8KAkBSyc3u1ucVbX8HlAxLVPNE9LE4FDHEC45urAfRc
   RZL4nR0Sd0W4m72PSiRXk6CIpcGTSualsq9ZaKaCI5lHcv+vlaIcuCU+y
   Ao1hdsTgFxUFQQiUyCgdR+qltzGCLwgDd7hf35u6XvhszaXQK3t+JjJ2m
   pNXgYCRfdlUn60dRjWkKBc6fBZKJx+pXxFPYI+oFqchtYsr0GOxfmoYh2
   w==;
X-CSE-ConnectionGUID: t+u6aXylRCaYbU1/laFcmg==
X-CSE-MsgGUID: 9geUSQRtQ/u7utUpygf7ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66337071"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="66337071"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 20:58:54 -0800
X-CSE-ConnectionGUID: p7/4tPkySw+u/Az/kI29qQ==
X-CSE-MsgGUID: vnK6zhPiSjSqhwHdnPxqPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="197458466"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 20:58:53 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 20:58:53 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 26 Nov 2025 20:58:53 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 20:58:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAo9UW9+/b9ZbyLAlJoayYe9SVJEVISCkQQBEGXzhhiyar40SEVVj+MqjoINk9E6DPZ+NRP6B/n41GThCnOypYkjg/Toft/58uHbVQZrFgjDmw3iV6xnhZKyHcgcbhe0idvl6DePbypnkttlWY6ETJHZrxZ0carF8KKWoBtxWXF8VrPUyF9OHqnP9hzPeztk5toTD4VtwO/7HRYYiyz9LkcKOWl6TK3qTZIqm9ku4/YMdFWIioUAhcumOv9GhmvDWyWfrQnjFdk6KrEbBmhTDMwHy8mnawzfxxv+fEwN/OltvFWYjD1R1BrZCPHjvaSAFZubwrEROdIHYOJpLNci9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0s76UCjxN+XYgOi/Nnu520Q7OIq04S96UHyr8tyLUiY=;
 b=L/mYQaS9a5NbRwF4XT3QHfyWCyAvy8xoKQc1L9T3eS55x0SGdZDRD+OtzEEonlrT+chdu5LYN6xqyNY34ft1TR76pnI5uxDVqtNL63by0O5o+vAzcWcYWHRPp57nXfEmBMbNuKDLoYdnr3Y7LthB0YHuturLGIXpNoEbDm8VGg4v4ozBGmV06qcKTIRLOyBq3li7pe+nFm9/QDcT4qfAld+ffHFvXGTTZKnv6FrtY+mIrq9GZlYUQ3NFvjVmuv9UF8GP6jWDgCu4oeRinl6BlKFsvKfD+2Fqt76UYCuKBL7PL6i6vnuDB/dqrOJ14dzHsRjGYzg85eums2AZR+027g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB5934.namprd11.prod.outlook.com (2603:10b6:303:189::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 04:58:44 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 04:58:44 +0000
Date: Thu, 27 Nov 2025 12:58:33 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: NeilBrown <neil@brown.name>
CC: Amir Goldstein <amir73il@gmail.com>, Christian Brauner
	<brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	<oe-lkp@lists.linux.dev>, <lkp@intel.com>, <netfs@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<linux-unionfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [linux-next:master] [VFS/nfsd/cachefiles/ovl] 7ab96df840:
 WARNING:at_fs/dcache.c:#umount_check
Message-ID: <aSfaeaUN3H8ozEbF@xsang-OptiPlex-9020>
References: <202511252132.2c621407-lkp@intel.com>
 <20251126-beerdigen-spanplatten-d86d4e9eaaa7@brauner>
 <CAOQ4uxgHqKyaRfXAugnCP4sozgwiOGTGDYvx2A-XJdxfswo-Ug@mail.gmail.com>
 <176419027888.634289.8284458326359928729@noble.neil.brown.name>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <176419027888.634289.8284458326359928729@noble.neil.brown.name>
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb1e3e0-0dbb-4064-c6a3-08de2d71a3b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1VnQ0NEekJIcjJYWFZnQnpTK04zbkFuTFRMR1pFdnBBeDhTakF6OXlSaHNS?=
 =?utf-8?B?VzdoWTFWWGFIMEFuOVFjOVpjM0FBNHQ0MkI2RkhiaytGSW9wUVNhYndWL3Mw?=
 =?utf-8?B?Uk15V1B1R085MWt2dnVPanFWcjU3QkNWS1ZTVko4eHVpa1hSWVYyQ0hIbW56?=
 =?utf-8?B?THlpZ2FnNjJEeVJ1QmtFTXNEZjNQdG1EZ3k2aG8zdkQ1L09QMFFHeDdVNUpM?=
 =?utf-8?B?TmNOdDdDTG1MdzkyY1VnYnBNZG1BUnkyaHVmYjU1WVE3WjVndFNNdXhFVmE0?=
 =?utf-8?B?bittSTJxeDNVREZFRzNWU0VVZGhsY2lRTVlpQVVJYXZyTk81MGplYWRUZmZx?=
 =?utf-8?B?VlRSWTdvY1d3U1JGZVVQTEFNdTF2OUIwOTU3WkRsUkt3eFZSNDRWM3VDekZI?=
 =?utf-8?B?Z0I5WUh3dGlNYTN0dklvYU9tTDM5dXZDRkFPOUU5ZjJseVZvWlV2cUpBRFQr?=
 =?utf-8?B?SW12TGl6dnFJb2JwdlozUk5RNGRXbGl2QTR0dnJHRnZrTWEzQzNYQzlPMzhh?=
 =?utf-8?B?ZEVUbkI5MFFHQXZ0aDFUdHo2dWxiRG1ZWUtsam9CZVFWcUdMUXRxbytFdmFE?=
 =?utf-8?B?TFdBL285S1VWZ0tXMW5PYUZuZGM1SlhKSEc3Mk5CdnY5OHdVeWs0TkZ6MXFi?=
 =?utf-8?B?a3BxS3k2Zm1ha0gvRitkWCtydnN4eXJSeE0ySDZ6NVlmUVM5c1l5Y01nYmh2?=
 =?utf-8?B?Zm92YWlSeGdaWVVXSTNPTjNkeWRLamh3bThLWXVWZnZ3MVZ4eXEwQWlsUUdy?=
 =?utf-8?B?MTlGUkkxaFNPOXl0YlNOQ2JEQmd0c3ZUSUp5NDY1NWZpVC9VRmxzTWhKSWJl?=
 =?utf-8?B?bE5WNjdUVGljQUZCcVViLzNzTStKRnRtQkEzTnhaR2o5VzZGQ2RxckxKTlYz?=
 =?utf-8?B?VXZmdDFOa2dlbVIxVVc2QUl0cW9yR2pwZ2ZaUG9hMkJOTnVrMUh4S3FnUFY0?=
 =?utf-8?B?bnJSMExXdVpocEdyUms5dWtoNG15c2ljdTBGQjdUOU5mNjFwbUJVeVZKb2Vr?=
 =?utf-8?B?eVJvZVVEM3dvM2RZWmRVTXFubW9xWDJBNU9ybFpuT0xKa0VHN0pveGxaVmR5?=
 =?utf-8?B?WCtPMFVmNnhObHk0aWpsdlYxQVZTZWszMjFZOXdQSXJGd1I4d1E4NjlKVWNF?=
 =?utf-8?B?ajA1MTY2aTgyc0MrQ0ZZblQrV1VtZGxISWRVZ2xIWFRPcm1WTThsNUY0cUU4?=
 =?utf-8?B?aUcyNWhOYUlDYXRicWtPYmthaENlUlo5aWR1cmlFdThsUkFBaFRpZjN2TWpn?=
 =?utf-8?B?SHBEUkZBTmZjS09LN3RNYXpHd1A3WnhucHAzdHc1WWxMZEwyK0M4alJKck5S?=
 =?utf-8?B?aW8wb3gwSlkwa0R5NlRFeWlDVUM3ZWxFMEgrSmhKWlZ4QWQ4c1k2L21aVzRB?=
 =?utf-8?B?MmRkY3BPcmJ1d09UVmpiNUR5WnRSZ2cwSDVrSHQzRi8yTUNhb0tRQmdrblJI?=
 =?utf-8?B?Zm04U0RUSjNuR1R2ek03SC9YOXNVZXZ5Y1VYckxzYWhwQk95SkcyaWZsQ0du?=
 =?utf-8?B?SFFPRUorN3FBN3gyamJyejlUb2FNckszcUQwSVBDd1BNbkxvcVl6WTZtejlF?=
 =?utf-8?B?cTZuZk5YOWxYbkhTdUhWc2ZndXhyOXRyMVE2bGN4cCtkUkhheGpHUlRsZERl?=
 =?utf-8?B?aC9oTUxadENhU2N4VnZGYkJxbnVqVTFCcE1XSXFOVjJzR2JqZFZ2WTU3dDY1?=
 =?utf-8?B?bm1WdDVxU05SdHk1cXNNeGIrWUN1all1SnZEeDdGUDVNeXV5MWI3Yy91OXc5?=
 =?utf-8?B?U3pUcFlzZzhwa0ZwbjdDTWorUkJwTlJVcjRIVmx3Sm5ENUpjcW5vZjNYTFA3?=
 =?utf-8?B?MHVGOFNTeDVjUXFoRlJ4MGV3R3JtUVp2Rm5KamFmV0lnSGo5dFR1cW1sSFdk?=
 =?utf-8?B?alQxd3Z0VDh0WU8zN2ZkYWFza1NETTZ4K2NzL0ovc28vV0U4akUvQUZDdmNp?=
 =?utf-8?B?S29PZm4wdHhXNUpkb0hPS3FMTDc2VXVSaFo2UG8rUU5QYmFnTCtpbGlESFhW?=
 =?utf-8?B?VWpaMHhRbjV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHZhbndkU3l0RHZNU2tlZm1kU01OOG9mN0ZET3Z2ZWZwcW1KZzZldFVoRU5H?=
 =?utf-8?B?KzFLcklaQ2QrQlkramRiUWl1bERhS2hnd0RhM3U3NW9JUzc1ejg2WjA2UWZQ?=
 =?utf-8?B?MHR6Z1ZnWVpZT2gzVHFjV2dmOGFWS1lFTXRobVRKTUQvVm1VSHpQN3AvM3Bv?=
 =?utf-8?B?Q0syMy8zU1ZkdjRBZ3ZIK3JPbjlSd24rdGVGenU4OE5Na1BPSDRFSWdIRW4w?=
 =?utf-8?B?Rm93YlRpZHNVZ0pyTVdpcTFaY1lIQUlBcSthVjR1dDRGRWxEQVpxZDdSV3ZP?=
 =?utf-8?B?d1ltZ3NQZWxCQVU3am9GVVQzRmdLaUJ0ZVVVZzNGOG0xRmVYK2NDVC9iRzFE?=
 =?utf-8?B?QlJJcXNQM053RDFvMUZYY3BleHJ6dFNER3RuY1N6eWlBQzhmNmVhYk9xdjNO?=
 =?utf-8?B?SmRnaWd2Qk1JbkNaWk1KckJsQkZrV3BxRGNQWk40NzFpYStwQS9Wa0VNU2cy?=
 =?utf-8?B?Q1hreDM2d09GRzRIbm5nN0UvWW1MVDVhdE0rczl6QlhsRDcrdUQzVVFLZjVn?=
 =?utf-8?B?Q0p1OUM1SXUvWUZHY1IzL3ZGdzM4ejloeDJXekZpVUJwcEZjR0JQOG05dktC?=
 =?utf-8?B?aTNUWkNHL2hMbGRSd0xVS3FHb0ttakJsalc4Z3d1cGFITnhsU3BRSEdvVFQ4?=
 =?utf-8?B?OFF1N0tIVnkrdENKUmROYVFQUmkwTnFscjBBSnNGM2FyY3hTUXh3U2NxTWhk?=
 =?utf-8?B?YzJ2RlYxREQ3UlJ6dWRNQTVOTzJQRnhUTHJLS3lVd3pjdnNQd0ZhZHBKak5j?=
 =?utf-8?B?cHJjRWNBVVdtMUJFY2ZBVW8yTzI3L1VjaFM0aWZKZFVzS2U5U0YzRkpnNWhE?=
 =?utf-8?B?WG1lNHZiVEtXbGd1ay81R3VuMjJobDJHMTh0cFVpWUVhSEh6WG5PcFFtM1ky?=
 =?utf-8?B?bE9TampDMEFBd0Z4SUFmeHppRzRrczZPSG5PTU0rOG1wR1lBRGZsUDUxSTlZ?=
 =?utf-8?B?R0pKRkhlSHFnekN1TzczZEVoQzZjL0FWdVcyM0x6UXIvM2FMQitIQTJIRjZk?=
 =?utf-8?B?NkZkdCtxOExJQzcyaE9KazZ6T0ZNVVhIWU83bVhsUklmRDVhN2hTU3VGdTlr?=
 =?utf-8?B?RHl3WGlGQ1NHbUJSdUxvc3BqYTArdnFrU2NWSHlrSDRJL2xOSTcrbHp6blBK?=
 =?utf-8?B?KzRNTmRqVzh2V2p6QVFNUEFuYmRnSm8vYXhLbW9vakdwSmEzdytvdWcwdWVs?=
 =?utf-8?B?TWVlZ1NRNGVZNG1WT21xc3NzLzlQWnRyQklLTnBuYXlLakFIeVlDY2NaTmhr?=
 =?utf-8?B?eDV6NithUlNGbDUxN1VLMndXQ1VESFpvb3Z6bUlHUmlVcjQ5TGdXNTJhVjQw?=
 =?utf-8?B?dU1YSjNsQTVwaCtFSHh2Z1d6aERZQjVTMFlJa201Z2l1Y2sxSW9URm56OWpy?=
 =?utf-8?B?NTFJOHBOZlJwTERabnhDeVhqVFg4UnVSemZxelpUMXBkWVJnMldiazhHcUlu?=
 =?utf-8?B?R3ZPT0E4dkprclRHbmNEaFYzbTBlS0NIWXl6aUVORFlNc0hNSUwxZHcxYmpD?=
 =?utf-8?B?cVFIY0xwSFIvTGNnSlVyMEs0VTZrWG5xUGdVMGZKZktNNXgydnFoSWRLQ29s?=
 =?utf-8?B?R3MxdmVSakJiWjdWVlV0VnBreFBxcWxQSGIrcERkMHBIQmpsa2doVS9EOVdi?=
 =?utf-8?B?Nm91TWRVNmY4MW1ITXAyU3VPYlgvUVJYK2laelQwaDl6a0R6OTltUitrZXVj?=
 =?utf-8?B?M0hldDZvV3lLaFZ5cWVOMERmUFk2TEo0WURYS09Fak81eUU4UGlaY1pINW83?=
 =?utf-8?B?ZmZZRVl1UXdKTkNSaXpZcHU1YkY0TGo4ME5PNGNuckRpYXgvbFN0Ums1QnRU?=
 =?utf-8?B?QmRtaWxydi83THNrOTBiTWFwalBaWkV5cldnUGcxK3hVZWZBZWtIMER2WDBI?=
 =?utf-8?B?OWFkOENKcC8yZjdnM21EQXJnZWhyNHVKMEN3a2RHVXhENThjakFwSmoyMmY1?=
 =?utf-8?B?ZDluZ3JTZk5pUEpibS9YNnV4dmpmTXRaamVUSTdMMk4vdCtkT3Raa2w4WCtI?=
 =?utf-8?B?TlFNRFRYclAxZTZib09WM24zSjExNzNibGJQUzNuT1lWc1BUUGd0ZUZXd3pk?=
 =?utf-8?B?aGxxejV5V0MzRVBzcEJUbXpXTEZjTHZBMjdmdTJJblFqaTVVanBucFlRMU9l?=
 =?utf-8?B?QklJMy9zT0IwZXJ3QTRrdWlNd0ZnemxFVVNBRVFHNW0yd2w3aWh6TGtoY2JD?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb1e3e0-0dbb-4064-c6a3-08de2d71a3b1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 04:58:44.5851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNjkDPj49QB2/ESDmTtwvKtoQSeroxWhK6PTmKK7oMNLArn5ozCM6Ybnp6apP8cvdxRcnU7mN8n+KGIxV1U94g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5934
X-OriginatorOrg: intel.com

hi, NeilBrown,

On Thu, Nov 27, 2025 at 07:51:18AM +1100, NeilBrown wrote:
> On Wed, 26 Nov 2025, Amir Goldstein wrote:
> > On Wed, Nov 26, 2025 at 11:42 AM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Tue, Nov 25, 2025 at 09:48:18PM +0800, kernel test robot wrote:
> > > >
> > > > Hello,
> > > >
> > > > kernel test robot noticed "WARNING:at_fs/dcache.c:#umount_check" on:
> > > >
> > > > commit: 7ab96df840e60eb933abfe65fc5fe44e72f16dc0 ("VFS/nfsd/cachefiles/ovl: add start_creating() and end_creating()")
> > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > >
> > > > [test failed on linux-next/master d724c6f85e80a23ed46b7ebc6e38b527c09d64f5]
> > >
> > > Neil, can you please take a look at this soon?
> > > I plan on sending the batch of PRs for this cycle on Friday.
> > >
> > > >
> > > > in testcase: filebench
> > > > version: filebench-x86_64-22620e6-1_20251009
> > > > with following parameters:
> > > >
> > > >       disk: 1SSD
> > > >       fs: ext4
> > > >       fs2: nfsv4
> > > >       test: ratelimcopyfiles.f
> > > >       cpufreq_governor: performance
> > > >
> > 
> > Test is copying to nfsv4 so that's the immediate suspect.
> > WARN_ON is in unmount of ext4, but I suspect that nfs
> > was loop mounted for the test.
> > 
> > FWIW, nfsd_proc_create() looks very suspicious.
> > 
> > nfsd_create_locked() does end_creating() internally (internal API change)
> > but nfsd_create_locked() still does end_creating() regardless.
> 
> Thanks for looking at this Amir.  That omission in nfsproc.c is
> certainly part of the problem but not all of it.
> By skipping the end_creating() there, we avoid a duplicate unlock, but
> also lose a dput() which we need.  Both callers of nfsd_create_locked()
> have the same problem.
> I think this should fix it.  The resulting code is a bit ugly but I can
> fix that with the nfsd team once this gets upstream.
> 
> (FYI nfsd_proc_create() is only used for NFSv2 and as it was an nfsv4 test,
>  that could wouldn't have been run)
> 
> Thanks,
> NeilBrown

we tested below patch, confirmed it could fix the issues in our original
reports. thanks!

Tested-by: kernel test robot <oliver.sang@intel.com>

> 
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 28f03a6a3cc3..481e789a7697 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -407,6 +407,9 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>  		/* File doesn't exist. Create it and set attrs */
>  		resp->status = nfsd_create_locked(rqstp, dirfhp, &attrs, type,
>  						  rdev, newfhp);
> +		/* nfsd_create_locked() unlocked the parent */
> +		dput(dchild);
> +		goto out_write;
>  	} else if (type == S_IFREG) {
>  		dprintk("nfsd:   existing %s, valid=%x, size=%ld\n",
>  			argp->name, attr->ia_valid, (long) attr->ia_size);
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 145f1c8d124d..4688f3fd59e2 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1633,16 +1633,14 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		return nfserrno(host_err);
>  
>  	err = fh_compose(resfhp, fhp->fh_export, dchild, fhp);
> -	/*
> -	 * We unconditionally drop our ref to dchild as fh_compose will have
> -	 * already grabbed its own ref for it.
> -	 */
>  	if (err)
>  		goto out_unlock;
>  	err = fh_fill_pre_attrs(fhp);
>  	if (err != nfs_ok)
>  		goto out_unlock;
>  	err = nfsd_create_locked(rqstp, fhp, attrs, type, rdev, resfhp);
> +	/* nfsd_create_locked() unlocked the parent */
> +	dput(dchild);
>  	return err;
>  
>  out_unlock:

