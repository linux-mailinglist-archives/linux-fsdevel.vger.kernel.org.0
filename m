Return-Path: <linux-fsdevel+bounces-19408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF43A8C4DB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 10:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 443A0B22950
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 08:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301541D54B;
	Tue, 14 May 2024 08:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/tD+PUG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CA71CA92;
	Tue, 14 May 2024 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715675130; cv=fail; b=JUNIN9fhiBXVTq7jnDdTH0cUfJ2Jp55Mefm/5M95O0s9ObwHCLGNg8FExR1LYjut5xGEhes7ihGKvxKrERPnohdMD1w0oZwQ905ITLLa155ujHEfHt0VNSkGgb6lgjbOs+GoFn9iUN+WRooglPrDRjwTf+jkJeHLLnUghyAAsoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715675130; c=relaxed/simple;
	bh=7UifgVy1Gc4NlsDvz+UuiioFxlrfTx5ApWVMZO8kS4k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uKDrLzdggUgIHN8sQOwPCi/c9oInFMJmb5bg7B8MXH421asmVmwd2VPihauylf2Fg5l2z4QEauozk6K3y/G5UnIyGOZeEnqKZvtGHTKq6zU1HRJguZC//XakbqVcbNrZKwliKS52KhpDBHf0m5QNC8rQnrDEKSg3m8OSrObtLrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/tD+PUG; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715675129; x=1747211129;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7UifgVy1Gc4NlsDvz+UuiioFxlrfTx5ApWVMZO8kS4k=;
  b=a/tD+PUGtnMpvO3iRO2RPAgvGqGRAZ/NUJ4Q1Whw/k5oRCGNuVvzTmcb
   J58bpKGn/fmZ0U98HaayHGBo9OeN50P94vp4/uSQK24n+pUTCwPUIIot8
   X8FqLIypmFrBqNB9FveqlANDhqtMNDxznx3aCvKm8Q80XK512w6TtsU35
   l3MqR5Z53I0siUVTZMyqwsoHPqTRWL+x1XmgRm4/nhCbltSeS1KU6U7TR
   oPxM8qUO+/JZVsRjKhQ5Qbgdj21GetddErqnInqzj5fTht9qcYhOBCoSD
   W/tuVpuqhLCc5uZuhIBEYjrNCJ3WRKgjPRzMD87Z7MVh5QHt/mYvUzYwd
   g==;
X-CSE-ConnectionGUID: IBqpmBrGREWgKpCkpb0gKQ==
X-CSE-MsgGUID: bQrZAuTQQrCB2uYuHT4WBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11495823"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11495823"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 01:25:28 -0700
X-CSE-ConnectionGUID: iyKXafy+StK//rPKjNk6xQ==
X-CSE-MsgGUID: E4sFqUCiQaaysCpWivRoOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="35138902"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 01:25:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 01:25:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 01:25:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 01:25:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBHPWVchYzoHuHI2xLlM93DdrBUoqnJ1DKWRUBGeuULsr6ETN8tX6VA9PB/A8F2of0YYJybXQucoVtH0ixQsCMY6/bM/NJnTpV1dtCamIe/x/pKmKp/SjbVcBpw12kxlTQ0FXLFRBhX9btA/OGPiTxRJPQTMHWhh/dVEigyku98cxiYpRjEB6zDe6LS6W3KYXoRpyWnOtb3zoIj65VDtOXIKiOedLcqxWIAnFphFLGw71BmTsXJn/S6xlrvBAv3GNutYFLyymvPQzleXzC010Mk95dhg3uZjBcfTVqWU0mkdLazN1Y21zvti+mT5aZjsjIhckVtrP/nr7qwq7gxCxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOdWdmoVmG2w0+9Ln2SBEmNDBG8XImvpac3B9PpyBDo=;
 b=Cbz211TZ/yhRhYdzShDCJSyAn9n47lmgbCKdfUDTKvV5dKTfpH2DsQs1sFqycAMK2l/ZmmO00PunbeTA03Bdti9jVu8tyscLdvM9O3bx481/JggqJc1/yXRMaVgbnUzQNTAmLr/+rFeB/u8mxUuiZGqjtpwGHfFLu9NiQPFCF6APz7W9jSAIn6ROJKVEkTBlofvXCY/mQ0aWMrxu1iXpmcK9X57Llq6dwcOujSBdl5dkWsGsS+zBGnC2iJk9vOhR3ZMparMBNGw6YeLgScCZbpsxTSACEnbQbn329WvSRBbLyGadLpVLDrq602DuWIU6tmlYoJtOnrVGA6G1E3BBtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6900.namprd11.prod.outlook.com (2603:10b6:806:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:25:25 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 08:25:25 +0000
Date: Tue, 14 May 2024 16:25:16 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Steve French
	<sfrench@samba.org>, Shyam Prasad N <nspmangalore@gmail.com>, "Rohith
 Surabattula" <rohiths.msft@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	<netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
	<oliver.sang@intel.com>
Subject: Re: [dhowells-fs:cifs-netfs] [cifs] b4834f12a4:
 WARNING:at_fs/netfs/write_collect.c:#netfs_writeback_lookup_folio
Message-ID: <ZkMf7MhzPVhAwME8@xsang-OptiPlex-9020>
References: <Zin4G2VYUiaYxsKQ@xsang-OptiPlex-9020>
 <202404161031.468b84f-oliver.sang@intel.com>
 <164954.1713356321@warthog.procyon.org.uk>
 <2146096.1714122289@warthog.procyon.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2146096.1714122289@warthog.procyon.org.uk>
X-ClientProxiedBy: SG2PR02CA0079.apcprd02.prod.outlook.com
 (2603:1096:4:90::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 676eb102-b514-4ace-f749-08dc73ef6762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IV9fwNcDUVSbrmetmpR+HcsTRZry0ZLo8H/g41u+5lIAPHbb/H73kS+tckpE?=
 =?us-ascii?Q?e7turQpnhW51jctmSpbkP19ZWGjcObRjI5+DYR84VahMuR3y+4dr3NW5S7+b?=
 =?us-ascii?Q?7lTBmnzMIJaku+Caf2G0vH3RJ10H+6kuVul8rF1qe0PmE7eikeIABgJDXmJ9?=
 =?us-ascii?Q?dAD8lGdQI3EaunEdY59ehL+zP1vRfzaZEJvHcwHMwguC8laPe9oiWjR6SGN+?=
 =?us-ascii?Q?jGjrTgmHYnkiMq4YDtCCsaXPSTBdovbO1eX0sMbiGtMU0BoFJ0DwR+4pgEwj?=
 =?us-ascii?Q?jXSdIudvBuDd2sI71qzvDnBTYO1vHqhTJFZQ2epWj6/VwyFR/4/B1Wnxf10X?=
 =?us-ascii?Q?2miligUmU0N3WAAEtX2OwjcBMh4+u6jzvaUx8S+FPHFFyJcdN1/flSVPaGWK?=
 =?us-ascii?Q?30rltjpxeNxdkP+nfWSTSoHmq0t3rbCp09m9Y1Nnd6vUGs4DUkR1ZGmtqEC3?=
 =?us-ascii?Q?Mb/nGK9/ot9D/zJ1V32nMn8r9eVP2JWl7GYqbZM2iMKULGFSZE0KxGMjIvAr?=
 =?us-ascii?Q?qAAYKpf+nKdiTd450Nw40P3RBwnpmHuEsQz4IiAEK/ncd6liJeYyJdkif8Tw?=
 =?us-ascii?Q?cUBjJwHG8lyA/xaO9q0mzXU6vPP8jKAkyNdplWlTfoYt+J3PJw5OmffdqKDL?=
 =?us-ascii?Q?KeS8eB/1tfnMINivQseLVJKS/yk4ohHIb+DcljsWL9xB29grStbEf959TZMQ?=
 =?us-ascii?Q?+aUsoswkFqjxYe/31KVl0+kNa4Z2sFnJowNJTfn5lg82c9Bg782E3qHgiZMM?=
 =?us-ascii?Q?Ld6HLNNJI8HfalLAa3DLnFg9MfluxujVqC0RVjePgibf2Tm3JZ/LGjiv9sYD?=
 =?us-ascii?Q?bxzxVNqv8AZwX4D+YPYRBSnyF0/X9p59hlrBm7mNb182WcFI7pxHY2/2CFVI?=
 =?us-ascii?Q?e7b8zbRSX9jfSvaSwMQq6I0WCkkQVl9EeFW3CxEmB/Wqg2trYKjOuwXuWdfd?=
 =?us-ascii?Q?oy8aISnGI2tkpT64hkHhhoe/0oDNiYQr+tIGMmOlDfMdSiwyTYPYDXXPOgMW?=
 =?us-ascii?Q?lmOfNwSID2emzsy2Jmu/HUcsIUUGlTnismtyPwJ/kYuNqO2oSK1RsoLm5AA8?=
 =?us-ascii?Q?ICxXEatxZuxTSwaKRSEL0XDJxCqh6RqKQ1BXjqo97Ift3eaORcxBsIBFlp0x?=
 =?us-ascii?Q?Zhn5tG3+BtLtBOxZHtFtKNuaHjH6IAQrXrOSUaUqQWIzEOHWXVhFDna3RtgU?=
 =?us-ascii?Q?li3FDnWQxbgfcapQ3YqzFMTws0FsArgpsF7KENc2v7hnbubUJEPYjDfq7Hr7?=
 =?us-ascii?Q?Ig2XdiKp+qBRrRdMagi07nl1+MlYF47D/44snbBC8w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IQnrqL3ktsa+xbHoKdu82TemJipFMu7SnZ4fMvQ8CSCjr+g88kvt6Pz8TLPL?=
 =?us-ascii?Q?qa6M9YRhfZYtifzKz2P5yb8uX8KO6jy/tTF34fLZeuDosQG1vcNqYBWC1ccF?=
 =?us-ascii?Q?YdCMuQ7IjgZt7hwMpikrl8DgucgFRXgTGKaq9GDP3317FPYUw8Ldzm/uIoHg?=
 =?us-ascii?Q?HSs/bsjtgjvce+eXSumeW0lG4OmlkbMqLKc9SWcJQxlxfhvwu7qdxduI/dQV?=
 =?us-ascii?Q?/e/9WnDWUCeBsslk7CHmNT9dzed1ksS8dWXtrrQQ6uHzcIS7Fxl3Z+7nPg+O?=
 =?us-ascii?Q?pvyJLS3cjQKE05wkV0oWCYEeVnRnWXe9gfZOLJhHRqirnHY+A0LmN3UuFa/7?=
 =?us-ascii?Q?SZc22p9gHWNtEsZ/yusr3IzfVNtT+5cPR/W6UsmyRm5MBahLHH6U7jWkgQrV?=
 =?us-ascii?Q?BmHYHriaHOuHf/yfoM8lPfL/GZo6+sZwtXfSSo+gGoJEv0QzVvKCnx8Qwmry?=
 =?us-ascii?Q?KlnthXUeSTKYK0QKFcMmViDtnYSlJLzCcxJPBWAZdV118erNGNFTWrV2Bm/B?=
 =?us-ascii?Q?ar2Ynu9MvCWxsRQ5rcSJ5B6D7G/8WP0psQUpdCN8QmvOdl1umd9LglpOtJIg?=
 =?us-ascii?Q?lpgnFg3qODS4k+pdqlFW68+yl8ZJQ/nX5DctHVq5ZhSXOwwWIHqTIJDXe+K9?=
 =?us-ascii?Q?TjbzKmoa/7j7WwLl8p3ei/gFoBX/I70yKUrRvV6imgAUNQcuYz9SCWEL7G+p?=
 =?us-ascii?Q?tdeh078KmS8hhf/GwONNt5GCXby0p3ns/LJ3ZwYpVJuZSU5HAloUxyBoFnOm?=
 =?us-ascii?Q?9et5+MIr4NjfMnwh31fSI65xrQiAdDh+TxfxDL8/q8R8YVvXDQVMsF5ZOw4c?=
 =?us-ascii?Q?jAyP/hZQ+d8SMO3IUXQQ0oqyR0Y4xsQk6lh0Ox6C2O6nClZx+66FH0q+gYqi?=
 =?us-ascii?Q?y1sMg5ri3tpMRmPlJX23ySvLbSpa83XqUIQbBJatPSgfjEiQDp9pktWl+FIZ?=
 =?us-ascii?Q?dOMt4RqhXWhaskkR4cVdJlywnhYIjvDJE2RwopybAC5hwz5U+WQFGwhgW+Dz?=
 =?us-ascii?Q?BbRjypvsgqfkn3rqkKX3chKvDcL5qiKdfyMmbxhhSJuFBgwaaHlre1PHDhqG?=
 =?us-ascii?Q?hizNu2YQYXHgGyGJMeKEznbJJSb+t3dV0Bym5a4t5UsVEa9pNrIBHCESVv3P?=
 =?us-ascii?Q?tV64u4pM7DJUEj6AQbLZhImOXQsQRK+aS2eLpP83tNPRvtns2GtEO/O8U7MH?=
 =?us-ascii?Q?ajCorx/0L+w7UTRZqoXrRiKZBjIsTI4KgDMy/c2j9sstSCM6qN4myTgM5lu1?=
 =?us-ascii?Q?hlPXPCIiHz6yjlc6tV5JKiH56bs0QaMJmigGoQBbhBrgCsfIGlEQjxyS7nXR?=
 =?us-ascii?Q?BngEBWlcDQxVkdXM+Y3dYI8v6i/u79LuUySk7CgM6nfW9UX6tKsqYFT0071q?=
 =?us-ascii?Q?bwCl5ww3SoY2DjiBO7oIPNimG4Ulenpds6E5YpURLVpUbYaSWG0zD5GglqD4?=
 =?us-ascii?Q?XOFxYhS9t25/u+QO1/G48eApieHb2PZ2QWPygScrclx+rN4DSLn3gFALJZ4z?=
 =?us-ascii?Q?tMGpzKH59mpwWMExK2I2b50+zIaH4g/S/h6M+UoOFMoT9jW8W4I8HWFPSgLv?=
 =?us-ascii?Q?1PrUohP0NGaohoZJcGlMbfaqQox1TWOyTk7vvmd7X0224Z8lktWL5bCthrz1?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 676eb102-b514-4ace-f749-08dc73ef6762
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 08:25:24.9322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKfd/CJEh6WRFmmiaZ05G5RC0Sg1SOynm58G+fUyAZAj0X5Rg2hp2lM2eFJ0HeKRFdbvl/9/oNMyTF7aIhPSSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6900
X-OriginatorOrg: intel.com

hi, David,

On Fri, Apr 26, 2024 at 10:04:49AM +0100, David Howells wrote:
> Okay I got it to install somehow by moving tmp-pkg to pkg, running lkp
> install (which failed), then moving it back and running lkp install again,
> which succeeded.
> 
> Running lkp split-job gives me:
> 
> /root/lkp-tests/lib/erb.rb:35: warning: Passing safe_level with the 2nd argument of ERB.new is deprecated. Do not use it, and specify other arguments as keyword arguments.
> /root/lkp-tests/lib/erb.rb:35: warning: Passing trim_mode with the 3rd argument of ERB.new is deprecated. Use keyword argument like ERB.new(str, trim_mode: ...) instead.
> /root/lkp-tests/lib/erb.rb:35: warning: Passing safe_level with the 2nd argument of ERB.new is deprecated. Do not use it, and specify other arguments as keyword arguments.
> /root/lkp-tests/lib/erb.rb:35: warning: Passing trim_mode with the 3rd argument of ERB.new is deprecated. Use keyword argument like ERB.new(str, trim_mode: ...) instead.
> job.yaml => ./job-performance-1HDD-btrfs-cifs-filemicro_seqwriterandvargam.f-b4834f12a4df607aaedc627fa9b93f3b18f664ba-debian-12-x86_64-20240206.cgz.yaml
> 
> It looks like some of the Ruby scripting is out of date.

this is fixed.

> 
> David
> 
> 

