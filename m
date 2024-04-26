Return-Path: <linux-fsdevel+bounces-17884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0528B3630
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 13:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E1C284C1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 11:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB191144D22;
	Fri, 26 Apr 2024 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ThBjmSAp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67CA143C67;
	Fri, 26 Apr 2024 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714129235; cv=fail; b=PIahMSNRdUrUdjoPHQeB9TFGl/TAIMtGrJ7+rBM4hk1DhAegTztS2+c6fEsmDglOas+eM8i8wu2Bbi/P1Pc9iw7o+RudGjzhK2kGpZS1XlLyiAN4w/TNdGoUgXOalb7NCoJimCdptWDChVcg1l3cUfjNjvvvZZbtl3WLZWUeQZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714129235; c=relaxed/simple;
	bh=wQq2M+SOuuWjqaS5A9w9QvHqZYE02vXUkvoLEqd2gd4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cipjWUl9R3gYL5KX9UHwQZHyaC/5hCb7WhfyYezSUwqSEJhYIawttTYr5pNGAYl7Y0a9mwJfegKREyHvOdSJYzID5bwzpdmIzEygUK4Y44BTSPsrjHPENZTcbyGtT9D3vCrJ35aAazgUEHNwzivKZHskJ00azGrx5DhKmbQq8is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ThBjmSAp; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714129234; x=1745665234;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wQq2M+SOuuWjqaS5A9w9QvHqZYE02vXUkvoLEqd2gd4=;
  b=ThBjmSApNvBJjw2VlDGI8cRbVeIr+oR+WHB0ch/qFJw7ZSwOPS9Oysgh
   gjHJy7E1ECEp6rhdHww5rs8hk//s5DAPOmoIzYyuS0R2tsLbw8zZKA6bM
   qb4YsFsQzRuAFZUfOTFOFCiH1ia+vDbWN2JwIbnEpxl2wh5MWbrADiJ6Y
   WUfSy3JWeg8Nzj/HQQDoDWE++OVbs5ygtHt91eHFOUhP6w2vx8+wLOzgB
   svi8Rgo9yQ+47Od8y/uqBYysfecf49sBGvquZouvLbwSSXAzWsWwA78rp
   x1thO2EE89uqhJ+umvJYJsRo0vVJRZFbdc09CWhJK/3tEsPMincGgmrta
   w==;
X-CSE-ConnectionGUID: MlCIi0osQPWx7kRkOO6d7A==
X-CSE-MsgGUID: fjU2cnnmS5mUDRKVRcEV3Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="21265473"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="21265473"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 04:00:19 -0700
X-CSE-ConnectionGUID: mvxPq2bMQJGvrIOYCrlBEw==
X-CSE-MsgGUID: m4bkqqFVTHCulCUpRq1hRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="25392278"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Apr 2024 04:00:19 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 04:00:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 04:00:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 04:00:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 04:00:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/9tkottrSqA9HfbatSaO2ZsYHOb7Yx+wgdMcTMuB7v9ayDpQWfp04SRMEFLHB7TdnguPtSVN4/XzCfr4TGYkkUctrbD5vFVZOjFLZFVj8ICCIzPMZbmdOoD2oi8niY45TfVf2k1jHvV1tQQtvCH+BdDdcxuH7KYZYy3RFUYv7BJxTmGnjNczRxH1L9yUVtsjbFWvfzkRjJ5rzzqMKtTmV7bRKKlk50BEKf86A6aNXQEVEaQAtAoPzjgr8pJS1p0Fd5XLN1a2agJ2E7U0e/9l+YYD25kaSzI0grSHqQoc++4VZA6vgI6vAn2P0JUjE9U2K3SOgBZ6M+Wr2W6SZ9sLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjC41+9URa1wl5CIH2oVvFAur6GxGC1nh7nRfQlKb9M=;
 b=Z+YZk4YtVHJVF3r94yL8qwi/69TGMHWr1TDG/soaoMAoz5znqjzb8tII+NwJroTjHQxpgmkoA4vpllcW371oIEdejXteKVE4THUcePp5Exr7DBCH/IUIwT1b5PmZfIX6HkomMfa1VeSWf/vshAd+ix0rUtYIcjAsrtA9FX7YsJE45za+SczZ9HM39kQIuK391Yd72fLQJljj5JY3L5xInmlZYLDCLuaXsvmOlXxzs7PR++vUnDgWR8JSf/f9nl6XP3Ee/iuOicsLxSzyeXPZni+osyDg3b1xqeYkorh8oBlV2+ay9R/2Ux1kp7SyaEBnhJG+2U8+3lULsP06nFKk6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
 by LV2PR11MB6048.namprd11.prod.outlook.com (2603:10b6:408:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Fri, 26 Apr
 2024 11:00:09 +0000
Received: from SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::35d6:c016:dbf5:478e]) by SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::35d6:c016:dbf5:478e%7]) with mapi id 15.20.7519.030; Fri, 26 Apr 2024
 11:00:08 +0000
Date: Fri, 26 Apr 2024 18:59:59 +0800
From: Philip Li <philip.li@intel.com>
To: David Howells <dhowells@redhat.com>
CC: Oliver Sang <oliver.sang@intel.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, Steve French <sfrench@samba.org>, Shyam Prasad N
	<nspmangalore@gmail.com>, Rohith Surabattula <rohiths.msft@gmail.com>, "Jeff
 Layton" <jlayton@kernel.org>, <netfs@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-cifs@vger.kernel.org>,
	<samba-technical@lists.samba.org>
Subject: Re: [dhowells-fs:cifs-netfs] [cifs] b4834f12a4:
 WARNING:at_fs/netfs/write_collect.c:#netfs_writeback_lookup_folio
Message-ID: <ZiuJLxQYruL16vzT@rli9-mobl>
References: <Zin4G2VYUiaYxsKQ@xsang-OptiPlex-9020>
 <202404161031.468b84f-oliver.sang@intel.com>
 <164954.1713356321@warthog.procyon.org.uk>
 <2146614.1714124561@warthog.procyon.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2146614.1714124561@warthog.procyon.org.uk>
X-ClientProxiedBy: SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36)
 To SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3230:EE_|LV2PR11MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: c87c7538-ce13-41c9-ce08-08dc65e00957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m3I1Cqne5/kzMapms7GO/d1J7KmzlYoP1mXMP0ayqf9eNS348EkBhBaZ2no9?=
 =?us-ascii?Q?qiOEQ1rhFrrafSrN64eIQ+lrYYgy0eZUXfYmuIsgq+o43fAWumJp0icNIUX0?=
 =?us-ascii?Q?VXY2zTw9wwP+YcdyYN8ADWTzPdyd1fyA/MbkQVg29OM18uyhw8EAx7sehmuc?=
 =?us-ascii?Q?i1Zz6//4gvcK6BtpuclfxUEpPdSahTGqHpq6vg5hOGWPPOS24lBL+CO6cGb2?=
 =?us-ascii?Q?5pdfUdyur7hhQjfauP7VrVIk3L5b3zOAXTPlJyTZ0ZQKVa20yVTfN8PAy4nv?=
 =?us-ascii?Q?TUp7FL3vwFDh46wPzk+PteWo74IbX+uj9sn4Sb9a0wf8BuZNVv+dCRT09zvq?=
 =?us-ascii?Q?u2Awqkp0u+p9xQS5rn66fMrDe/iyqcCTZ+peXlWtANGr++0Yeoga2H0K7APX?=
 =?us-ascii?Q?NG8LLXBpHvs57/ggLM7YcMOyk3yS4+OSTKwFpT2Ux2u/Bu38Amo3nLdZmxjd?=
 =?us-ascii?Q?deQAx9123EC9/69xDjDhUCxTY4L5Ty7SD3FvqjPaAjqWW7elRZv+eYkaXIJD?=
 =?us-ascii?Q?CoTsE0+sGZMM0TzeDJDK53jtwqtGnzufiJxY1BPBfnKyZYfpGEfv8UCR4gRA?=
 =?us-ascii?Q?mKvNURN9cBFoW4RaKVAx+jJfm9PekOPvGgDaSqE/yXQLH5u3YgiWIrsu9Ad5?=
 =?us-ascii?Q?RKXvQPKbxyXEGNT9Rh6Hj5Nm75/++GrKoos6bxfaZbwJAFvWoF8qdiiGhCVj?=
 =?us-ascii?Q?4lDCq8dXq2zErY2WdYhlTsnLmfP8U6sPfRIEG05J1Dj3XT18+vvbs0iJxhCw?=
 =?us-ascii?Q?dVQy7MLx/0d6TZbw3pZW1mmljPi+MuAVqW4dK5lZr6WLBZoT0ufoG4J6K0GR?=
 =?us-ascii?Q?Nt5mKHodgUxk+/9kok9rUrkfJYCZ3PFI67/Pc3cXZFodqcGkWl2D+8f9DB7R?=
 =?us-ascii?Q?q8lwib2jjFxinrxaSiPKsRUSKwK5jZowuTs3OgxTPIb6khTR6RkKjV/re8/Z?=
 =?us-ascii?Q?BdCqXtXVuz9jJdpCdPVREae0qhF56kb/BVozc/JQJ1a1rEIm0z7xH7SxzxwQ?=
 =?us-ascii?Q?OQDhHHofLAY10zqq2O8J8ZuFa3QhrA5lWsQwggNQUGYbNjElO10JKpGGpqoo?=
 =?us-ascii?Q?+VHbOGtbHiHLJMaj/UVAmtNtm/LEqrSIA9xh41PNvwwAFZ2cpj6Ksr8oDdbx?=
 =?us-ascii?Q?qJYXZoJX7B65tQAmAWxv0ITSXwJ29FqCp4iAuk9O6mUcz83mXZe8jbOYbpmI?=
 =?us-ascii?Q?OzXYR8I0PLGBe3EdDoyXfUMzxLhsEUYTdM3Npj/KPGRnNbdpWmeKdz8N+aWT?=
 =?us-ascii?Q?40sePuAlbrlhOSP65U0/IhWY/si6n2rCtjwrI1JReQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ixIOMM4MoJksx9DXi9iG93CRxUmSW99KVrNMZ8ZALWvbW+AVP2ADkFZQIW7p?=
 =?us-ascii?Q?eYaR9WQ92bhV+H5wcxvw6zL8G8joYQgNMzVY4oI+B9yITK01PUAzhSBYJyi5?=
 =?us-ascii?Q?rWNuaPK8fTXDIKrcNMdkv29i0dyU5gj67VoSbHgDWEbWOtdyUVR1FsU2VLJr?=
 =?us-ascii?Q?QvsGnCpcwc1OpOzdx77WitB1sBW+wWDUMcJdJ85yzcRBnTjufaMiOC0gKhiX?=
 =?us-ascii?Q?wa1ZEKIdsxklI0++ldEsrIyc0xQyDLIsm+hki0SojudJG1lKbq/lY3RYSnZd?=
 =?us-ascii?Q?mNPeXvxkXHVDblaIzv67eEF03h3UV2MKSYXkX2wqTAsR/WMydVv/cmeBnyEl?=
 =?us-ascii?Q?SpQaBC0SgSltZZgoKMqrzLrBB4yiQijPPh74CZmVrCCgRXgIUgJIAkbcTCn4?=
 =?us-ascii?Q?wfwJmTBPZWaxbpYBS6LhgmAhaDSlLwdeyMnl18OHo7KDwu1M7YPD5z4kB0Sd?=
 =?us-ascii?Q?b2TR7Uvp6FkLwPJejlTYdItRdG2+qDUn/0D+2uJC5d29Q06fvBcOPztUSZbB?=
 =?us-ascii?Q?qynIt5wUyUtfIEn63U8bdRf15KrJNwTw3QrRBtwKvPxOWkTMoi4w6quJ7jwe?=
 =?us-ascii?Q?z7o1HqPI4QHUarFNCvXQVE2CnL4SwLSzeNLf+B6wbB6lW/ZviHupaH7rbN4V?=
 =?us-ascii?Q?cgw1XQWfH/iBayoOJSaj3llEQPhUqq1szsDpfs+gXc6vtsIf3vD4pII+yYP+?=
 =?us-ascii?Q?g20DvcIASIlcazfOgciuS6diG3WVXlOImRmV+oAhFi6BbFqwkcrhlqzg9Qn+?=
 =?us-ascii?Q?y9gXfCHgoXlK2tlyKh8fyTwnR+tAlbIsG1cxebtMVgxiiRYQ1VzNTgM/Hkuw?=
 =?us-ascii?Q?56aoAezNnzZdq7awqBo5MmjCeQYsbNqU2z6i+Xl3/z4yIRyePfqERIcdMKnJ?=
 =?us-ascii?Q?AnNw7o/MyF5eULQvcADBSj6ZTArA5RjM5YlhUvaNn4Ln9Psljj5qbcWCDBe1?=
 =?us-ascii?Q?Lh06fVhufhzs/SoozgfhDLbpXCo56O2hidaB2zbnt+xRE5gMA7x6UlnRcrC9?=
 =?us-ascii?Q?oq5JYLp+Cm+kxuzami4bXEz/bwqZVaBhFyMSJk/qbJgkfnSmrlTOLxDxbAWM?=
 =?us-ascii?Q?JxGMya38Q+4nIQaPTa4lMXcfFV0v8wAojN71vQB713WqygqbQ5KYCbp0+mTd?=
 =?us-ascii?Q?/1wMLZv62BMTUfiqxTTcQ0dncnuzMvP0zQGEH5iA6UYW3DlYX5m2rrX5GHa1?=
 =?us-ascii?Q?jqjwM0BhPtfyIgHugG8xbSgu8OzQxR42e9vdQzfTglG0/JWX+r9UyTKS8d3v?=
 =?us-ascii?Q?KXFCEXn2GBQxmlcLNVDZ205khugy18nc0yhdLQ1CopihyLs6DoU7hHX1vQZq?=
 =?us-ascii?Q?Yk/2X7QHCO60yAoPZQas16RmcwfIbxz108A/m9eFj8Zggwt6EO0zeCg/XrLD?=
 =?us-ascii?Q?heSeb333w6ln8/zHXOO5j2/JxArazM3xm8nLf8IfSi/ww9uSDU8/bQnJhdaC?=
 =?us-ascii?Q?n2gauQC40AQ04rtH1HoUhOKYHxVKTcwMubcyaIFOyjZONscH9+Nf2rEj8y2Y?=
 =?us-ascii?Q?IWNDXG4d01eo3u625ZHjQkjGasOW6HdKEGyWA3TLupkcv7ovisJGdp0SJUiG?=
 =?us-ascii?Q?a6hOl9M5qAwUUm8MQ4BWC4GClgSRLhGolpMtiFK9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c87c7538-ce13-41c9-ce08-08dc65e00957
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 11:00:08.6403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgb5kOWVZkdeOUG5wtQZltIdwG2963/7vyFJ50OErVoNHQzxbZTb8epVe0C2Z+Vz/nKmTa3ScvRTOCQBPQ0KcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6048
X-OriginatorOrg: intel.com

On Fri, Apr 26, 2024 at 10:42:41AM +0100, David Howells wrote:
> Trying to do "lkp run job.yaml" doesn't work:
> 
> /root/lkp-tests/filters/need_kconfig.rb:20:in `read_kernel_kconfigs': .config doesn't exist: /pkg/linux/x86_64-rhel-8.3/gcc-13/b4834f12a4df607aaedc627fa9b93f3b18f664ba/.config (Job::ParamError)
>         from /root/lkp-tests/filters/need_kconfig.rb:176:in `block in expand_expression'
>         from /root/lkp-tests/lib/erb.rb:51:in `eval'
>         from /root/lkp-tests/lib/erb.rb:51:in `expand_expression'
>         from /root/lkp-tests/lib/job.rb:646:in `evaluate_param'
>         from /root/lkp-tests/lib/job.rb:694:in `block in expand_params'
>         from /root/lkp-tests/lib/job.rb:79:in `block in for_each_in'
>         from /root/lkp-tests/lib/job.rb:78:in `each'
>         from /root/lkp-tests/lib/job.rb:78:in `for_each_in'
>         from /root/lkp-tests/lib/job.rb:691:in `expand_params'
>         from /root/lkp-tests/bin/run-local:138:in `<main>'
> 
> I tried to run the filebench directly, but that only wants to hammer on
> /tmp/bigfileset/ and also wants a file for SHM precreating in /tmp.  I was
> able to get it to work with cifs by:
> 
> touch /tmp/filebench-shm-IF6uX8
> truncate -s 184975240 /tmp/filebench-shm-IF6uX8
> mkdir /tmp/bigfileset
> mount //myserver/test /tmp/bigfileset/ -o user=shares,pass=...,cache=loose
> 
> /root/lkp-tests/programs/filebench/pkg/filebench-lkp/lkp/benchmarks/filebench/bin/filebench -f /lkp/benchmarks/filebench/share/filebench/workloads/filemicro_seqwriterandvargam.f
> 
> It tries to remove /tmp/bigfileset/, can't because it's mounted, and then
> continues anyway.
> 
> It should be easier than this ;-)

Hi David, really apologize for all the problems you mentioned here and early mails
during the reproduce. We will address them one by one ASAP to see make the reproduce
useful instead of this kind of bad experience.

BTW: if you have any patch (like debugging) to try, we are pleased to test it directly in
our testbox.

Sorry again to cost your a lot extra time for this.

Thanks

> 
> David
> 
> 

