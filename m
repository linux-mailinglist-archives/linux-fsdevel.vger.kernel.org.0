Return-Path: <linux-fsdevel+bounces-29615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9B197B6C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 04:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11361C20983
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 02:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4638312E1D1;
	Wed, 18 Sep 2024 02:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WEJltr8g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEF21BC5C;
	Wed, 18 Sep 2024 02:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726625918; cv=fail; b=HWjpw93T9jilyc8JY2rle6pgcVHyfeFFP88znS89Ts6WdSncWJZMgPucohqqGpcD+Dzi+4XJQ71zbDRlcooya0X1uLm17wutnBoPyHysSstadxTv0GaDAAZSUam+BUExfDNzwQstv+6TAXHphWqhk0gv5SP7L6XO+5kwJMe/Qm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726625918; c=relaxed/simple;
	bh=bALa9jV78xN0siI1c6EyanUE8H4pdivZOmkZaxk7dZw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ZAcIWS8DXl6vqzBw2Iab8JLqe8l5xusW+ZxnInImG/R/bq26WhBibFPSqOsq6tqz5oQBZfDI0JOLFJSnAMq1vlVsYfJ6tgRzBh3VBHbeXBwjyoEamngKMiaiFdhBSN4oVbn+1YOaYmzKyXyZ1EGsBdU5AFo3lX1TF/J1IQMqRIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WEJltr8g; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726625917; x=1758161917;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bALa9jV78xN0siI1c6EyanUE8H4pdivZOmkZaxk7dZw=;
  b=WEJltr8g59eputPJgnHXrNb17Map3w1vhIAKCyAE7bEvDRSQf1rG+VUw
   yzx2zwv1XUA4Fg1XyJGcOui7Di6b8FW52orYNrGNhi+LyFdt/uWKjRArT
   VEHbu4dpl/bahOFq6XU1rICa8Bie1/ivm8v1OinhMsuEpKGI66ZdAjk7A
   dtxx2s2vcbO0ZyhSp70CAitfhZUS0O8TRsocUGRg+TxYq8tNWNGweY45c
   fE6WDb7FAIFyDQTkvk8G3tjUoi9QFeQQlo4t0DZO1y3YPHWjfW0UWQM+8
   /5bOw2laLCPKuNkWQArkPgljHmuYJbyWK6c2T6YeT2X0a/DirXBcrhyWY
   g==;
X-CSE-ConnectionGUID: 8fZtItuCTP+nB+aXN7rbxg==
X-CSE-MsgGUID: T44XYIluSReglewYKjp1zQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="29412208"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="29412208"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 19:18:36 -0700
X-CSE-ConnectionGUID: Dcnjw9n5QnGDyPE1fBFEcA==
X-CSE-MsgGUID: Hvpnf8O4RhGTRkuDGFjA8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="69031092"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Sep 2024 19:18:36 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 17 Sep 2024 19:18:35 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 17 Sep 2024 19:18:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 17 Sep 2024 19:18:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 17 Sep 2024 19:18:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dB48po8mKd2VOFRQ6MnzB08JsnBQ+NOUQQkYRnbITiIe2tKJAg1ehkDRUcy33M47G+zPuoJlREjMmfaRdp9ZRnOUG1P+NzfiTgosADdg0Cls4FlFFaqWqW6gWiSjdaBsy8CAy7Kg/fSVTgHbPBPySsoAtZQSna4CkLBaBupzYv5r4+aGJsrQQIkBv7FTOD4JTe6GUaYOzW3y/T5Sv3qjVthbOI7Yx+R86voqXPbBRg64AWcH2afRIPH7O7H4zUUqo+cIMVMsLxXnsUmwPp1weNpa7stNvZG3oHIfTJqzgNhIFMvJkLoZUIv5zEHyCK6xfMkFiVGJbK6DopRehSF3gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBHEZw6/cMXIrUNln19Rpd9a+Kpq9KQXsyW61OX6eX8=;
 b=R3IUwcbP5dAOB8P1dbD/fHY3gWOtexkfii4HJ3Ox2YAgGEPoLi7HP6mUkDfIQaUSt+/X8WrGIqks/wtIdUtktjMuL8UJ+DwKoSQW4pPYAC8Y/jPV2smpWJNJH6GNIhFwrDtc/WPFMTBSUy3cNN7U/xt6Z7tEf0NupzcF6ehEwqMlReex0yrB8Hqffz4pac1rUCvNi59qOcDPssQ/88zprih28VTaxS78rKJf4Hn9bHWfTY+Dy8J82QAXFwHJx/fNTktZDpekYKzKUc8pMych8bDO5tfZzZua/Ngfq+UzfZ549dCCCNXz7qRLSaYEWFzW82AVZgl5y9k6IxY6rm2Ahg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH0PR11MB8141.namprd11.prod.outlook.com (2603:10b6:610:18a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 02:18:32 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 02:18:32 +0000
Date: Wed, 18 Sep 2024 10:18:23 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	<netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [netfs]  cd0277ed0c:
 BUG:KASAN:slab-use-after-free_in_copy_from_iter
Message-ID: <202409180928.f20b5a08-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH0PR11MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd0f1f4-3703-475a-1f6a-08dcd788314b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E0pV6q3y+AYQOIH4W9VhUiNNrBnaNeP+WiLiNPym+BFTS8bMegZpxbYYd5lH?=
 =?us-ascii?Q?/LEMSp32n17dKC755UEABXvjQOtG93ngghH9w8Luhma3Ca7Qv52T8GyMbtrl?=
 =?us-ascii?Q?U93dhbEPoQd9DRqmHlv+5Gh8QQCMXqE55bLcTiMEthZyvZpA9to9OTbjFs66?=
 =?us-ascii?Q?iU3X9C0NyNZp+c2jcH1OalZclRbx8OYqDyrRhbkCGk0gib7rGeGncHMChjHJ?=
 =?us-ascii?Q?wQLESO8KPIgeSzAja29/kIjJaSqz12eZ99z17MC+siTSi7FaGUpVDvKsvACW?=
 =?us-ascii?Q?6J3p9tQo0S7vNyNUgbffltzSupULjc87He0c1/BOZ5Frls+H8difSy+Ezfcl?=
 =?us-ascii?Q?bG5PP2kGp2ANblOHlD1XvOPtqH2Hs7jTFm9vYRIaFZEibe8nIxCtXd21KLb1?=
 =?us-ascii?Q?96bojAizbaOhvA5IBEqWWnEISlMbUbGAcSesNQTK9eckfI5EuFpo90VeP9H3?=
 =?us-ascii?Q?+QrtxjAk0fp3oExwaY6Wezq4Bttrtai8fUN9yhF1TyAJ2TtW7fZHFxyNb/vQ?=
 =?us-ascii?Q?EtY4Tm37QLF4txtXRpUG+/FAypq3oc9AYKaeFHTIwNZJr9NOFSXsoRSWTfB7?=
 =?us-ascii?Q?XIJdTEJ9kAKEF8bNjvKFCdpVVr4SdlTjNyRMFib1vxEVe9o/H7QBoUPCXBsY?=
 =?us-ascii?Q?HQdShWTeR/LIP4MTY0zOf6KjsD584YpwU/4LkdydIVxLGj+IOQq4PU0oObQu?=
 =?us-ascii?Q?U8rpC8yWpnMlm8qbBrAtiPqqmOMb59wBUANpxSXB/syGNxb3pjc067eLJjVw?=
 =?us-ascii?Q?kKoLumaj5mSlOJld1x/R7QwQ4STxucdxANsCpBIo22TlEv1PA1wqUCjgJdMs?=
 =?us-ascii?Q?EzhJMea/8OGZRTYl1go3SqgWy60xBH9SPg/GasMTRqYN6N3UtauEDpPojsL1?=
 =?us-ascii?Q?pKwW7xKMEpTSQd3LdV16FD4RF9rE76pcPaeq63iDf/SFR6DpiE9A+0bIWaK7?=
 =?us-ascii?Q?B2fNixnloYEsuOymm1CkEPXEl6h+ARbdNc4ulNWpv3omXIDyBndZyKFwWWoY?=
 =?us-ascii?Q?a+2yd95OGvo12BXHwaD0cw5/zHqmjzfHKzV6FvYyGzxD7FSZxzD5pDjMZusT?=
 =?us-ascii?Q?MiIA0Udj8tps0daIyAx6BcjB1zVDGg8If0Ziv4gkhwYnIu1jV69J3ixIHZfF?=
 =?us-ascii?Q?TVQtfnl2IKar6mLJCc7yi5hUnHFejmWtiAvUPp4T6ItpuxR2DSsaJfkRwbxV?=
 =?us-ascii?Q?Fqc5rP8SysHqSGauGUD2srt4AOe8TnuZ1DRh+rSKuPPGl5g3gxf0n4Tj+N8+?=
 =?us-ascii?Q?nTtNsY59Tlk6u5KSi6A/HXcbxyeROyksVKYNviMcpDaZbjZdpV1gJGJmg/et?=
 =?us-ascii?Q?c7jmBkXjFF4L5aTxFY8xSGc12gc6trPXrv1raTsJsJeKo83ha2FMjDrJnh/M?=
 =?us-ascii?Q?q+yU9sw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?93LGOKDfTxrUx8RyBUzEArsb0RypG03ql6Lf8rDoQAMMkF0+H8N4wlLoQmxe?=
 =?us-ascii?Q?5W7cqFceHHU8/EKIDjVUR7bQUh9vG03BiHz+DV3AY+hV1qcaBtcixfUXv9oG?=
 =?us-ascii?Q?1Lda7loqU9pbJdDMj7TGjF45MlSa+eGIft8emVMvXb0Ukyel9UkJezc8EdGM?=
 =?us-ascii?Q?AqS9slavYWyNRWoa7QeUPRWu5Npz+kWGaSeAuNHfx5lfejAlWTJfReuyn1BS?=
 =?us-ascii?Q?k3n+PdH5xYP+TnzddxQ4tKVGux4tUnIH0IrwV/yal01pyqoLCc+ZICAlFff8?=
 =?us-ascii?Q?Jcg+uXN0swz96jRryb81bLqiOYyC+bKIRSn/MkZ1BpTTBRlWgiTuHaulkIQ9?=
 =?us-ascii?Q?Z+1s7YW/9P5p74K3CrXlpy7qds1I0JVYy9A2x1qE0tM9JuKrzeZSXiehy8PL?=
 =?us-ascii?Q?VsmsAhvjsEnca+Vrzo9Jm+OysPPdyCT9bDEC3nzlVB341V4nPrikl8pnGB76?=
 =?us-ascii?Q?YCF9FDp0REgmIXHEGFNaIVmkCIxOLrsBPsVMM2L8kmNh5uRI9s81hBZpM20M?=
 =?us-ascii?Q?Y2ioE15vEQvIWf+ZIwQ7MnpHeq79TRhsnptP8Ig0NUZOd1BRs6xS/kPtYV1m?=
 =?us-ascii?Q?SuAtkg6q3ESAY3Mf1CLrJBgc6gX4ZJppOKTfK/5DKbP+lLjBHnvJUY9WacsZ?=
 =?us-ascii?Q?n8QQQB0aFDvSRtIzS6AdBXpz5QaRoyQqSDRJGnVDPD0NcxKQpJ1weXUc/2Aq?=
 =?us-ascii?Q?THaCv5jtPpxZ3tPNnmZzZ1B+vaXJwTL5iBF0Z1Std6k9SjPPHx4ehw5G69MH?=
 =?us-ascii?Q?BB8FoSphnxkbESmP3RI5Tl3Yw2U6porwJzLIsmWo8WtxMmUCtqvSj6xv3b4T?=
 =?us-ascii?Q?AKMfOUktsula5mcVUeI8jKXsWJlmak9sxB5U/X9CJPySzQW8mXTHFIWS6ih7?=
 =?us-ascii?Q?A/9Pxvvt4+a68Mvb0XaRo2sM8Pyck4pCj8DI14um1Q9+mzgPfajKXt0xKazs?=
 =?us-ascii?Q?qEJO9c4NeV/VMZkA6HlZTQdSNcuhhMMZKPuow8Ytve0xUkEadk22/8nSyBQD?=
 =?us-ascii?Q?cCm2557gj78lfJqGEYW8atumwGFy3HP98s3U4xayRTztcs1wZSJ6Hk+BmT0M?=
 =?us-ascii?Q?j76y9Qcmb0RO5jMlPpHf1j2nf5vZKYSwYF2/u6Kx+kS4JITD5HG4d51nfR07?=
 =?us-ascii?Q?UTlELlCYghY1qybIhK5ngK1GLCEjTA2AH9efS6Xqoup8tdITrarVajrKH85I?=
 =?us-ascii?Q?5fxueBhE2B9A7BwZAM788+vcPs/nQAiSXzKemATf9wqmddpU6Wabc5uc0sAs?=
 =?us-ascii?Q?t1NJ8XFr+IEWsi7mdd0C+QtEOe7l31eEr5bIxPEW78UzcLtpZfDAOSoxeoQG?=
 =?us-ascii?Q?noqAKOcrUan7FE2CWNiO724RYSGxRVnMNmpbT5PI5p/TMGsLVZ+13LDiCWNV?=
 =?us-ascii?Q?Vc5qTzA3gHepdgHUBpwHy0T8RAifId/huEym/UVf0WhCjrBwXsjLMKAeKW8Y?=
 =?us-ascii?Q?DgVKzkgXCksMXOhiFUb6r8MkL9etG26uOFEGqMJkeYr8+DFDsWN8J0KeAwer?=
 =?us-ascii?Q?fzcZNwB0Zx1s5ByZmaaweopGQkF58cYjgVi2f6pSRTwNoP/dbPnXgOUH5jmE?=
 =?us-ascii?Q?vvpRDt4tceoXuBj+I3vAADNv0YSCXizv2GYGPmDT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd0f1f4-3703-475a-1f6a-08dcd788314b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 02:18:32.5533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIfTMyTkoJ7eko6Qy79FciFV0WyJmtKpx8exZPcvPG7KSTsonJlt0BKk+F42ABIqzXKfQrEuugKuxF4dgzeK4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8141
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:slab-use-after-free_in_copy_from_iter" on:

commit: cd0277ed0c188dd40e7744e89299af7b78831ca4 ("netfs: Use new folio_queue data type and iterator instead of xarray iter")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      a430d95c5efa2b545d26a094eb5f624e36732af0]
[test failed on linux-next/master 7083504315d64199a329de322fce989e1e10f4f7]

in testcase: xfstests
version: xfstests-x86_64-b1465280-1_20240909
with following parameters:

	disk: 4HDD
	fs: ext4
	fs2: smbv2
	test: generic-group-11



compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409180928.f20b5a08-oliver.sang@intel.com


[ 461.422026][ T2594] BUG: KASAN: slab-use-after-free in _copy_from_iter (include/linux/iov_iter.h:157 include/linux/iov_iter.h:308 include/linux/iov_iter.h:328 lib/iov_iter.c:249 lib/iov_iter.c:260) 
[  461.429760][ T2594] Read of size 8 at addr ffff8881ec497520 by task aio-stress/2594
[  461.437419][ T2594]
[  461.439617][ T2594] CPU: 2 UID: 0 PID: 2594 Comm: aio-stress Not tainted 6.11.0-rc6-00065-gcd0277ed0c18 #1
[  461.449270][ T2594] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
[  461.457360][ T2594] Call Trace:
[  461.460504][ T2594]  <TASK>
[ 461.463295][ T2594] dump_stack_lvl (lib/dump_stack.c:122 (discriminator 1)) 
[ 461.467658][ T2594] print_address_description+0x2c/0x3a0 
[ 461.474100][ T2594] ? _copy_from_iter (include/linux/iov_iter.h:157 include/linux/iov_iter.h:308 include/linux/iov_iter.h:328 lib/iov_iter.c:249 lib/iov_iter.c:260) 
[ 461.479060][ T2594] print_report (mm/kasan/report.c:489) 
[ 461.483327][ T2594] ? kasan_addr_to_slab (mm/kasan/common.c:37) 
[ 461.488112][ T2594] ? _copy_from_iter (include/linux/iov_iter.h:157 include/linux/iov_iter.h:308 include/linux/iov_iter.h:328 lib/iov_iter.c:249 lib/iov_iter.c:260) 
[ 461.493071][ T2594] kasan_report (mm/kasan/report.c:603) 
[ 461.497337][ T2594] ? _copy_from_iter (include/linux/iov_iter.h:157 include/linux/iov_iter.h:308 include/linux/iov_iter.h:328 lib/iov_iter.c:249 lib/iov_iter.c:260) 
[ 461.502295][ T2594] _copy_from_iter (include/linux/iov_iter.h:157 include/linux/iov_iter.h:308 include/linux/iov_iter.h:328 lib/iov_iter.c:249 lib/iov_iter.c:260) 
[ 461.507081][ T2594] ? __pfx_try_charge_memcg (mm/memcontrol.c:2158) 
[ 461.512301][ T2594] ? __pfx__copy_from_iter (lib/iov_iter.c:254) 
[ 461.517445][ T2594] ? __mod_memcg_state (mm/memcontrol.c:555 mm/memcontrol.c:669) 
[ 461.522420][ T2594] ? check_heap_object (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/page-flags.h:827 include/linux/page-flags.h:848 include/linux/mm.h:1126 include/linux/mm.h:2142 mm/usercopy.c:199) 
[  461.527414][ T2594]  ? 0xffffffff81000000
[ 461.531417][ T2594] ? __check_object_size (mm/memremap.c:167) 
[ 461.537080][ T2594] skb_do_copy_data_nocache (include/linux/uio.h:219 include/linux/uio.h:236 include/net/sock.h:2167) 
[ 461.542472][ T2594] ? __pfx_skb_do_copy_data_nocache (include/net/sock.h:2158) 
[ 461.548385][ T2594] ? __sk_mem_schedule (net/core/sock.c:3194) 
[ 461.553191][ T2594] tcp_sendmsg_locked (include/net/sock.h:2195 net/ipv4/tcp.c:1218) 
[ 461.558236][ T2594] ? cifs_strict_fsync (fs/smb/client/cifsglob.h:1577 fs/smb/client/file.c:2658) cifs
[ 461.563805][ T2594] ? __x64_sys_fsync (include/linux/file.h:47 fs/sync.c:213 fs/sync.c:220 fs/sync.c:218 fs/sync.c:218) 
[ 461.568431][ T2594] ? __pfx_tcp_sendmsg_locked (net/ipv4/tcp.c:1049) 
[ 461.573822][ T2594] ? do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 461.578348][ T2594] ? _raw_spin_lock_bh (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:127 kernel/locking/spinlock.c:178) 
[ 461.583134][ T2594] ? __pfx__raw_spin_lock_bh (kernel/locking/spinlock.c:177) 
[ 461.588464][ T2594] tcp_sendmsg (net/ipv4/tcp.c:1355) 
[ 461.592569][ T2594] sock_sendmsg (net/socket.c:730 net/socket.c:745 net/socket.c:768) 
[ 461.596921][ T2594] ? stack_trace_save (kernel/stacktrace.c:123) 
[ 461.601618][ T2594] ? __pfx_sock_sendmsg (net/socket.c:757) 
[ 461.606491][ T2594] ? recalc_sigpending (arch/x86/include/asm/bitops.h:75 include/asm-generic/bitops/instrumented-atomic.h:42 include/linux/thread_info.h:94 kernel/signal.c:178 kernel/signal.c:175) 
[ 461.611464][ T2594] smb_send_kvec (fs/smb/client/transport.c:215) cifs
[ 461.616599][ T2594] __smb_send_rqst (fs/smb/client/transport.c:361) cifs
[ 461.621910][ T2594] ? __pfx___smb_send_rqst (fs/smb/client/transport.c:274) cifs
[ 461.627741][ T2594] ? __pfx_mempool_alloc_noprof (mm/mempool.c:385) 
[ 461.633311][ T2594] ? __asan_memset (mm/kasan/shadow.c:84) 
[ 461.637750][ T2594] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 461.642275][ T2594] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153) 
[ 461.647320][ T2594] ? smb2_setup_async_request (fs/smb/client/smb2transport.c:903) cifs
[ 461.653633][ T2594] cifs_call_async (fs/smb/client/transport.c:841) cifs
[ 461.658940][ T2594] ? __pfx_cifs_call_async (fs/smb/client/transport.c:787) cifs
[ 461.664762][ T2594] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 461.669288][ T2594] ? __asan_memset (mm/kasan/shadow.c:84) 
[ 461.673740][ T2594] ? __smb2_plain_req_init (arch/x86/include/asm/atomic.h:53 include/linux/atomic/atomic-arch-fallback.h:992 include/linux/atomic/atomic-instrumented.h:436 fs/smb/client/smb2pdu.c:555) cifs
[ 461.679842][ T2594] smb2_async_writev (fs/smb/client/smb2pdu.c:5026) cifs
[ 461.685454][ T2594] ? __pfx_smb2_async_writev (fs/smb/client/smb2pdu.c:4894) cifs
[ 461.691472][ T2594] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 461.696006][ T2594] ? __pfx__raw_spin_lock_bh (kernel/locking/spinlock.c:177) 
[ 461.701323][ T2594] ? cifs_prepare_write (fs/smb/client/file.c:77) cifs
[ 461.707116][ T2594] ? netfs_advance_write (fs/netfs/write_issue.c:300) 
[ 461.712257][ T2594] netfs_advance_write (fs/netfs/write_issue.c:300) 
[ 461.717218][ T2594] ? netfs_buffer_append_folio (arch/x86/include/asm/bitops.h:206 (discriminator 3) arch/x86/include/asm/bitops.h:238 (discriminator 3) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 3) include/linux/page-flags.h:827 (discriminator 3) include/linux/page-flags.h:848 (discriminator 3) include/linux/mm.h:1126 (discriminator 3) include/linux/folio_queue.h:102 (discriminator 3) fs/netfs/misc.c:43 (discriminator 3)) 
[ 461.722870][ T2594] netfs_write_folio (fs/netfs/write_issue.c:468) 
[ 461.727743][ T2594] ? writeback_iter (mm/page-writeback.c:2591) 
[ 461.732460][ T2594] netfs_writepages (fs/netfs/write_issue.c:540) 
[ 461.737161][ T2594] ? __pfx_netfs_writepages (fs/netfs/write_issue.c:499) 
[ 461.742379][ T2594] ? copy_page_from_iter_atomic (arch/x86/include/asm/uaccess_64.h:110 arch/x86/include/asm/uaccess_64.h:125 lib/iov_iter.c:55 include/linux/iov_iter.h:30 include/linux/iov_iter.h:300 include/linux/iov_iter.h:328 lib/iov_iter.c:249 lib/iov_iter.c:481) 
[ 461.748225][ T2594] do_writepages (mm/page-writeback.c:2683) 
[ 461.752665][ T2594] ? inode_maybe_inc_iversion (arch/x86/include/asm/atomic64_64.h:101 include/linux/atomic/atomic-arch-fallback.h:4256 include/linux/atomic/atomic-instrumented.h:2858 fs/libfs.c:2020) 
[ 461.758140][ T2594] ? __pfx_do_writepages (mm/page-writeback.c:2673) 
[ 461.763099][ T2594] ? __pfx___might_resched (kernel/sched/core.c:8418) 
[ 461.768230][ T2594] ? shmem_write_end (arch/x86/include/asm/atomic.h:67 include/linux/atomic/atomic-arch-fallback.h:2278 include/linux/atomic/atomic-instrumented.h:1384 include/linux/page_ref.h:205 include/linux/mm.h:1152 include/linux/mm.h:1157 include/linux/mm.h:1489 mm/shmem.c:2934) 
[ 461.773015][ T2594] ? balance_dirty_pages_ratelimited_flags (mm/page-writeback.c:2084) 
[ 461.779621][ T2594] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 461.784146][ T2594] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153) 
[ 461.789190][ T2594] ? generic_perform_write (mm/filemap.c:4044) 
[ 461.794495][ T2594] ? wbc_attach_and_unlock_inode (arch/x86/include/asm/jump_label.h:27 include/linux/backing-dev.h:176 fs/fs-writeback.c:737) 
[ 461.800236][ T2594] filemap_fdatawrite_wbc (mm/filemap.c:398 mm/filemap.c:387) 
[ 461.805469][ T2594] __filemap_fdatawrite_range (mm/filemap.c:422) 
[ 461.810860][ T2594] ? __pfx___filemap_fdatawrite_range (mm/filemap.c:422) 
[ 461.816951][ T2594] ? mutex_unlock (arch/x86/include/asm/atomic64_64.h:101 include/linux/atomic/atomic-arch-fallback.h:4329 include/linux/atomic/atomic-long.h:1506 include/linux/atomic/atomic-instrumented.h:4481 kernel/locking/mutex.c:181 kernel/locking/mutex.c:545) 
[ 461.821303][ T2594] ? __pfx_mutex_unlock (kernel/locking/mutex.c:543) 
[ 461.826174][ T2594] file_write_and_wait_range (mm/filemap.c:788) 
[ 461.831566][ T2594] cifs_strict_fsync (fs/smb/client/file.c:2660) cifs
[ 461.836956][ T2594] __x64_sys_fsync (include/linux/file.h:47 fs/sync.c:213 fs/sync.c:220 fs/sync.c:218 fs/sync.c:218) 
[ 461.841414][ T2594] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 461.845780][ T2594] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  461.851526][ T2594] RIP: 0033:0x7f8302baab10
[ 461.855793][ T2594] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 80 3d d1 ba 0d 00 00 74 17 b8 4a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
All code
========
   0:	00 f7                	add    %dh,%bh
   2:	d8 64 89 01          	fsubs  0x1(%rcx,%rcx,4)
   6:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
   a:	c3                   	retq   
   b:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  12:	00 00 00 
  15:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1a:	80 3d d1 ba 0d 00 00 	cmpb   $0x0,0xdbad1(%rip)        # 0xdbaf2
  21:	74 17                	je     0x3a
  23:	b8 4a 00 00 00       	mov    $0x4a,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 48                	ja     0x7a
  32:	c3                   	retq   
  33:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  3a:	48 83 ec 18          	sub    $0x18,%rsp
  3e:	89                   	.byte 0x89
  3f:	7c                   	.byte 0x7c

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 48                	ja     0x50
   8:	c3                   	retq   
   9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  10:	48 83 ec 18          	sub    $0x18,%rsp
  14:	89                   	.byte 0x89
  15:	7c                   	.byte 0x7c


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240918/202409180928.f20b5a08-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


