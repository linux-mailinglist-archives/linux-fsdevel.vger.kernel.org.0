Return-Path: <linux-fsdevel+bounces-79736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDoRANxfrmlbCwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 06:51:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9057A233FF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 06:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68F9230065C2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 05:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5268C34C98C;
	Mon,  9 Mar 2026 05:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CpWYGmAm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630B9313E34;
	Mon,  9 Mar 2026 05:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773035480; cv=fail; b=nDPKmGF2eHh9bLwIc9OBnIrVkUSfWaWBNoIZBQ+ZDaexjNKZJfp/audHgAr09g8ZLakEXDawBiAvE1aAf78rdLSw+qxLeBPk7mwl65pawl952/mFVrXPNE3DCW9NV3ym8v+m9PHnTaP42tOCazT8W4xLfuJpYQsQ9DozNG4bgUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773035480; c=relaxed/simple;
	bh=hDs5SsrKv/Z53UOKX0iUYZoX2JiYqFj3VcwRUvBrg/E=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=YAifopBbwiw8XZKUZHaIujKmspeYKY0ebNbpmuc8uC3Wh8WjEQ+ARrvUEexnqis0rgbkv/Q0UF7B57HhylC2si7URVwjmRs5JCAufLpQlG/Uml4THk48EqevBg20nf6l43ndUPz6Cm3jDblNfmnY4InkKjrBfevt7KmBAviF5cI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CpWYGmAm; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773035477; x=1804571477;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=hDs5SsrKv/Z53UOKX0iUYZoX2JiYqFj3VcwRUvBrg/E=;
  b=CpWYGmAmnNUtwCK7gNRNBvjOmBMxv0gkBX/KbK05uX2aFqUBLIBx1PSu
   Ohe0aPyFbOzDryrCieMLpU5/KE7HpEl/zxAFvoIew71I/PoeiYTUwBGBH
   36xWX/+p61h6bgjY5ltqkznnRkbfeMdNyhLjnxfyr51B0RegAGYthdOwf
   hIe+wMoIEe9CE9KdLqeuZfSwC2Ps7zWKOSC5BIPMBuDqzmbT/RA8CXyHz
   4wJOyvuX52Q5srga5RGjupcUFIc/B/S8rvlRGvqxBtezIrn9TavRsjjxo
   gdx6iyW5HEiaa+paNz21nONBCXqoJDXgci/Qw6jUEWP45BB4sy4qq1MLX
   Q==;
X-CSE-ConnectionGUID: 9N0CuwG6Slije1hHOdMHWg==
X-CSE-MsgGUID: BO9SYbjEQVOHmaHKcWaOzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="85405285"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="85405285"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 22:51:16 -0700
X-CSE-ConnectionGUID: pU3JETYiTfChTYNYs5RB1A==
X-CSE-MsgGUID: Ng8XhfrHQDK1e/o7QDP+Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="250125906"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 22:51:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 8 Mar 2026 22:51:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 8 Mar 2026 22:51:15 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 8 Mar 2026 22:51:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FigNVXXg0lFoHwpQlMlnx2HM0AqC+g8e+ia1pvFoTUMPZAopNtIiWSmWH8P13GmDLW3izamr1+UD4cv8cPwHGXeI9qopRKA1ooobddZT8Z0tcL6VhhlDraUPl+4XsejoNdeXdw23Wu0PXnoDbQDhY6bOsigvOAgwrhXwJ2mwbb4U3ZWLADbhFb6Iu/JIBKYbrBcVd2LEir+NwHD8N794+mOpDfCWBB7hzwlBPDa8RYvLbr4Kd8ButQDtdXawgzOQX8WsZjFQNAMiI4OlSx3d8YvL4jCgEr8sbFUmJJ4s0b8ewnaqJkW3XJoXxng/7Fj03yVnAQz+UJTPj5Cn2ADIVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqYU5KTaiabHJ1RHgY5km17h20rKwsm+grIf9ctsuZI=;
 b=KLD2D/rUp/WoLA4W/k1cis2UZBffXj0jKGMLRmTivvuxUxtkdTBob5vnh+vVLozIBQVQ8VwP4kAHq5m3cP9tmL3os9DkYYjO+Yyhr/8/o4Ph3MUcN6CxbXe/qv9Un4y7PbKre9OCOq/3grXEl/DOpMynmrlKci501oH8DVTxmyHLJgKGN1NP2uIl5ZJZtRJC+xmB7nrwCuFvsEptfkMKExbwJvCVFAa+WrHK6D/P1SkhC5wjbGPMz9854OHLKu5l14THAX1rgrrCtD3JA5gX1z5Go3sRiRRw9IFhQPmR9ULm6AzllN910MSHeGU3b4JSl5wCg1UGL81bw+YhzqeeJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB4044.namprd11.prod.outlook.com (2603:10b6:5:6::23) by
 BL1PR11MB6027.namprd11.prod.outlook.com (2603:10b6:208:392::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.6; Mon, 9 Mar
 2026 05:51:12 +0000
Received: from DM6PR11MB4044.namprd11.prod.outlook.com
 ([fe80::dc22:71ab:1604:5586]) by DM6PR11MB4044.namprd11.prod.outlook.com
 ([fe80::dc22:71ab:1604:5586%5]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 05:51:11 +0000
Date: Mon, 9 Mar 2026 13:50:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [pidfs]  8021824904: stress-ng.pthread.ops_per_sec
 115.4% improvement
Message-ID: <202603091347.982f38c4-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: TPYP295CA0053.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::10) To BY5PR11MB4038.namprd11.prod.outlook.com
 (2603:10b6:a03:18c::33)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB4044:EE_|BL1PR11MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: bb0b2b57-0b94-420c-a025-08de7d9fddc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 02/oCl2/FZPi/OT7mH/BknRDTr/kYkbijXO108RNv4kF0VHYVRAOYOdG56d7K1fgNEurkLEakhQpePubeuu25mXnr6UmvzgQ07rnsrnVtt+7juioTn4ZF8ka59m6+sEmWIK+d8qxg8dtjoDLHpCmPppR80P0H0KDSW3zhXSCLJpJ9uk5GGDmFIZpww7zlLryi8PjtHzS8x79jZLfUXR1w6iM89kJrMgcHR3p1g/89aGWYF4IhNBzkc65fbUB5iMy761PGX/ConqQzBSY+gm15iRw6HLvAk+SFQrB+BeDzNqwofFQm0NeUVcvZt5QmbbITIunmAccz829KtKbVTkrC6fBt+SNOhWt1YIKtv3X25mYl3/m7u/uBy5SjKsTjD/I84PfWqxsS4rKwOUXH23sWivIaODqH9AOYzz9CMN0bm4AR3xxuEzYkaelUQ9+liNF9Ow4gIqY56T6GAk3wv4eoQR7gznxIr6+FW47vG/NzO/aoLBKTUmO8oeveYVMLMHC+ETuG5CoyuNHYSKeCzZW4hQWC8gkL7i8QHSHCi0be0xv6UsQ45quXC5p4oHordEBl21hOlIlggZvqZL7km/XLX16vHMUAAjaHhaWatSiQbO55X0MOHOlezgmhzXKoe10T8xEMWJ47a7Sj7v6iw9R5C5KzwyfoW5XCoBE+kCHYJAbCr/8l68IdD3VrjU2KhL+04RD2+vlVFypFgicN4/GgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4044.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?85qL/vN1+si0ANNCnf5xH+rjcxVZ3SbuHpJRyEPpHPdvPZwcccuzvGywB5?=
 =?iso-8859-1?Q?mipuQsyo34IUUdLz2QSd5r1HBz8qZ8MiiRzoayCCoPiD+WXxT4PAw+lIBx?=
 =?iso-8859-1?Q?8ktIhRdxnLkn/LWgXzWDA5wxzxDnuBv8iSPg+ZfJ6wIMKzF6P5SzX0Y3OI?=
 =?iso-8859-1?Q?zcTho14tHgpC13687uLhKjOXtv+N+2cZ6lmJmLcf94DY1ha1OghK2WK8A4?=
 =?iso-8859-1?Q?DInggzpwvXm+kXqHT+Z5ZbNZnbnTgAP/ODwhKJEMXQMUveUixYurJ0cjnt?=
 =?iso-8859-1?Q?tkcjIfre/CygSPPMM1aJ4aYnr4Xowc6yqjiHqua1yd+9DRvoY4cekP1ZVb?=
 =?iso-8859-1?Q?2006J/4BzmtIsjUxNe3VlZsVw+pT1idIX8o1xJ6DYiI/aRv5uChz7QVPNR?=
 =?iso-8859-1?Q?6DO2DVGWfpLpr+AO8Ii3dYE79IZ+EYyZIiGOaVvDuFaNDVdR7CndIFC9YK?=
 =?iso-8859-1?Q?b54Rlqr2MWrm7Z0Q7kl3RgW98DflfOjPLIpVczwBQRRcIMYHJVzkYTg7Ya?=
 =?iso-8859-1?Q?zb1E4Rn9OiKyODko9uAq8g3h2X7+8LNaotegZguCiIMFrJPO99l31nW1w8?=
 =?iso-8859-1?Q?T1F/tUjmTBresl4k9QuI1IKH3DYzJ+urvrLBQJKI9p3MUPYnThPmAr47Yk?=
 =?iso-8859-1?Q?Fyx8EFeeS4PV6fkPUMkxGIQkLX5GSS2KOXktxNRhb/uEXDh/fOKMtSjzR/?=
 =?iso-8859-1?Q?KhHBVhg33shDUQHTOIx8twXSPkPzX6KiGAZSzNkqmH3Y+gioh/vQPGPGSJ?=
 =?iso-8859-1?Q?dR2ue6dka3VmjipyvTt74W9xEjE5foXFEewZHzckSL8FhinAVaYQqRHA7/?=
 =?iso-8859-1?Q?O2Jn+LS8bCfhS26p+uAkUTIXtsXDiA04rGFmq9Zy8vg7LblMM0D6cA8Suw?=
 =?iso-8859-1?Q?II0s/2uTiJq4bUq5U3nroZvWLZXjhSz4PNp52FuIAj4+HzRdAaZj/ytE5C?=
 =?iso-8859-1?Q?tpJT4DOA1rUrDcqE1JQrmT8NdKZBKENl4TVJaJay19DcEBz22htCHj5+UY?=
 =?iso-8859-1?Q?4salx9L0g7rlSTp+fnkevWndeEGV0ip2CpytLQ25TBV9bkASxHgkH67fz8?=
 =?iso-8859-1?Q?dQBmiYGGK+6MZ2Cs3EOuOTCC1TirXm4ugp0MDHyv1G3s48Veu8W+Ny20E8?=
 =?iso-8859-1?Q?bZN8x1ug/J1+0yVEhseknFDnbI66ZdS7O9UKYwLg4qvjQKGQCKJkb5y+U9?=
 =?iso-8859-1?Q?5shaN0zaHIgWfXcLrNEuIzDB3o+hYzGw4tDPs76HyGmVA0BEfhBNhwGwcQ?=
 =?iso-8859-1?Q?34xXgJR7zuNoWW1NFl44hntqoHTG69gaVKs9zFe4uqsItJsqBh1mhpeL4q?=
 =?iso-8859-1?Q?ylptpgSr9IiydwupPpBljucz42/+IczTtJkSSgwdQ4IuwfpK1pHbGx8sqh?=
 =?iso-8859-1?Q?c7APaTShS4rB2e+/7Ns1gBxTnitM2Cek1zRp7cPrETZ12IKOUcNvJQh0Wb?=
 =?iso-8859-1?Q?hekPZMMJqGMzuEmb1Wz0Asa3v2kgR8YG/ivW5WGX7iqf2eUxulDRiSIiXB?=
 =?iso-8859-1?Q?YH5ceRKkZW5rMfdptNWG8uhLUjE94o1loIYcXIsKS/XIBndaMsNhm3KWT4?=
 =?iso-8859-1?Q?J8aHwi8g+9iUl8PBLZLgW/Fjc/MBRWKrEBp+/76ARBXJiHz2mNRfapgavK?=
 =?iso-8859-1?Q?CEwm+OxW87pqgQoc1Te0AG7LRWlu2b7gqSXfT//W3MnEVkcE02aaXvhOvg?=
 =?iso-8859-1?Q?GsWeBMhQbUTUj8NAI4gUrEb64euAvc91GSJwN1LMw5+0zij9r0MCe+NwkJ?=
 =?iso-8859-1?Q?pwv2SSKfCfMojw18KY43ZUzke0xw4+S46iYhZITBxvvmMBxBi2yom+Pg1o?=
 =?iso-8859-1?Q?asAIF+d+CQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: oqPaSO866U9kD8388TTLaieeSqypXm8fv87VfY5jLNd1ROqPG3GG8kEiP//PXnbIhajpUOki2WWkHyWigRWbdbJR2cNI3B0JbWVbreLF60GfUVvDGCHEIANEvnaR81C4m9rVxG0UeraHWCrZf+eSv1SI9GjbQxVY5Mj7KtGChXDvEx96r2soMXtyEUOYjmDbyvM+tlQ0jIAv0WsAUoGSupkTC4leA4hPPv7vgMyA8aSedcjgR5QlY1ORGhcK9i3kA1kTX7nVR/iTKiwvx7+HLb/1AAL6DOWqi0ru6B7oyO0D4eGQ+Bxw+o4GiR4/SRcK1f5OWvZZo6T+RoCX/IUK3g==
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0b2b57-0b94-420c-a025-08de7d9fddc7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4038.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 05:51:11.7897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWP7qkz6vLRA5ErEsNyJ+bllwxIelx5Hw2PKu9Te8n5t/3bNznuNuBSlYBF4JJlRONs9R09lmq6rZ8nOk5MLVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6027
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 9057A233FF5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79736-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,01.org:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,hitm.total:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.981];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



Hello,

kernel test robot noticed a 115.4% improvement of stress-ng.pthread.ops_per_sec on:


commit: 802182490445f6bcf5de0e0518fb967c2afb6da1 ("pidfs: convert rb-tree to rhashtable")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: pthread
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260309/202603091347.982f38c4-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-srf-2sp3/pthread/stress-ng/60s

commit: 
  a344860211 ("ipc: Add SPDX license id to mqueue.c")
  8021824904 ("pidfs: convert rb-tree to rhashtable")

a344860211f5c07d 802182490445f6bcf5de0e0518f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    238962 ±  2%     -56.6%     103737 ±  4%  stress-ng.pthread.nanosecs_to_start_a_pthread
   8502955          +115.5%   18320200        stress-ng.pthread.ops
    141479          +115.4%     304813        stress-ng.pthread.ops_per_sec
  11806823          +128.1%   26934722        stress-ng.time.involuntary_context_switches
  34893919          +112.5%   74144888        stress-ng.time.minor_page_faults
      8732           +13.1%       9872 ±  2%  stress-ng.time.percent_of_cpu_this_job_got
      5152           +11.6%       5748 ±  2%  stress-ng.time.system_time
    119.70           +79.2%     214.54        stress-ng.time.user_time
  17274026          +115.2%   37181651        stress-ng.time.voluntary_context_switches
 2.536e+09 ±  2%     +27.7%  3.237e+09        cpuidle..time
  11624156          +112.2%   24669418 ±  2%  cpuidle..usage
     21.06 ±  2%      +6.3       27.39        mpstat.cpu.all.idle%
      0.75 ±  2%      +0.1        0.87        mpstat.cpu.all.irq%
      0.45            +0.7        1.11 ±  4%  mpstat.cpu.all.soft%
     76.23            -8.2       68.00        mpstat.cpu.all.sys%
      1.52            +1.1        2.63        mpstat.cpu.all.usr%
     15273 ± 39%    +115.0%      32841 ±  6%  perf-c2c.DRAM.local
     11312 ± 42%    +462.1%      63587 ± 11%  perf-c2c.DRAM.remote
     17041 ± 39%    +521.2%     105868 ±  9%  perf-c2c.HITM.local
      5959 ± 41%    +610.3%      42332 ± 11%  perf-c2c.HITM.remote
     23001 ± 40%    +544.3%     148201 ±  9%  perf-c2c.HITM.total
      0.10 ±  9%     +44.6%       0.15        turbostat.IPC
  41291979 ±  9%     +46.8%   60611834        turbostat.IRQ
    262.50 ±  9%     +16.0%     304.39        turbostat.PkgWatt
     19.84 ±  5%     +23.0%      24.39        turbostat.RAMWatt
      0.02           +50.0%       0.03        turbostat.SysWatt
     23.63 ±  2%     +26.3%      29.83        vmstat.cpu.id
  10289045 ±  2%     +44.9%   14908391 ±  5%  vmstat.memory.cache
    781.86 ±  4%     +13.9%     890.45 ±  6%  vmstat.procs.r
    760169          +123.8%    1700926        vmstat.system.cs
    624448 ±  7%     +46.3%     913594        vmstat.system.in
     94.93           -94.9        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     94.92           -94.9        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     48.28           -48.3        0.00        perf-profile.calltrace.cycles-pp.__do_sys_clone3.do_syscall_64.entry_SYSCALL_64_after_hwframe
     48.27           -48.3        0.00        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone3.do_syscall_64.entry_SYSCALL_64_after_hwframe
     46.51           -46.5        0.00        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone3.do_syscall_64.entry_SYSCALL_64_after_hwframe
     44.15           -44.2        0.00        perf-profile.calltrace.cycles-pp.alloc_pid.copy_process.kernel_clone.__do_sys_clone3.do_syscall_64
     44.00           -44.0        0.00        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
     44.00           -44.0        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_exit.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
     44.00           -44.0        0.00        perf-profile.calltrace.cycles-pp.do_exit.__x64_sys_exit.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
     43.77           -43.8        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.alloc_pid.copy_process.kernel_clone.__do_sys_clone3
     43.74           -43.7        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.alloc_pid.copy_process.kernel_clone
     42.86           -42.9        0.00        perf-profile.calltrace.cycles-pp.exit_notify.do_exit.__x64_sys_exit.x64_sys_call.do_syscall_64
     42.71           -42.7        0.00        perf-profile.calltrace.cycles-pp.release_task.exit_notify.do_exit.__x64_sys_exit.x64_sys_call
     42.36           -42.4        0.00        perf-profile.calltrace.cycles-pp.free_pids.release_task.exit_notify.do_exit.__x64_sys_exit
     42.32           -42.3        0.00        perf-profile.calltrace.cycles-pp.free_pid.free_pids.release_task.exit_notify.do_exit
     42.15           -42.2        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.free_pid.free_pids.release_task.exit_notify
     42.06           -42.1        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.free_pid.free_pids.release_task
     96.27           -96.3        0.00        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     96.25           -96.2        0.00        perf-profile.children.cycles-pp.do_syscall_64
     87.32           -87.3        0.00        perf-profile.children.cycles-pp._raw_spin_lock
     87.27           -87.3        0.00        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     48.28           -48.3        0.00        perf-profile.children.cycles-pp.__do_sys_clone3
     48.27           -48.3        0.00        perf-profile.children.cycles-pp.kernel_clone
     46.51           -46.5        0.00        perf-profile.children.cycles-pp.copy_process
     44.15           -44.2        0.00        perf-profile.children.cycles-pp.alloc_pid
     44.01           -44.0        0.00        perf-profile.children.cycles-pp.x64_sys_call
     44.00           -44.0        0.00        perf-profile.children.cycles-pp.__x64_sys_exit
     44.00           -44.0        0.00        perf-profile.children.cycles-pp.do_exit
     42.86           -42.9        0.00        perf-profile.children.cycles-pp.exit_notify
     42.71           -42.7        0.00        perf-profile.children.cycles-pp.release_task
     42.36           -42.4        0.00        perf-profile.children.cycles-pp.free_pids
     42.32           -42.3        0.00        perf-profile.children.cycles-pp.free_pid
     86.50           -86.5        0.00        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      3.91           +39.0%       5.44        perf-stat.i.MPKI
 1.071e+10           +39.3%  1.491e+10        perf-stat.i.branch-instructions
      0.55            +0.3        0.89        perf-stat.i.branch-miss-rate%
  58562752          +125.4%   1.32e+08 ±  2%  perf-stat.i.branch-misses
     33.04            -1.1       31.91        perf-stat.i.cache-miss-rate%
 1.846e+08          +103.4%  3.755e+08        perf-stat.i.cache-misses
 5.592e+08          +110.8%  1.179e+09        perf-stat.i.cache-references
    791816          +124.8%    1780366        perf-stat.i.context-switches
     10.42           -34.7%       6.80        perf-stat.i.cpi
 4.923e+11            -6.9%  4.584e+11        perf-stat.i.cpu-cycles
    124149           +94.6%     241625        perf-stat.i.cpu-migrations
      2676           -52.5%       1270 ±  2%  perf-stat.i.cycles-between-cache-misses
 4.769e+10           +45.8%  6.954e+10        perf-stat.i.instructions
      0.10           +55.4%       0.15        perf-stat.i.ipc
     10.82          +128.3%      24.70        perf-stat.i.metric.K/sec
    584711          +110.0%    1228050        perf-stat.i.minor-faults
    722714          +111.3%    1527264        perf-stat.i.page-faults
      3.89           +39.3%       5.42        perf-stat.overall.MPKI
      0.55            +0.3        0.89        perf-stat.overall.branch-miss-rate%
     33.04            -1.2       31.87        perf-stat.overall.cache-miss-rate%
     10.34           -36.2%       6.60        perf-stat.overall.cpi
      2659           -54.2%       1217 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.10           +56.8%       0.15        perf-stat.overall.ipc
 1.041e+10           +40.0%  1.458e+10        perf-stat.ps.branch-instructions
  57180163          +126.3%  1.294e+08 ±  2%  perf-stat.ps.branch-misses
 1.804e+08          +104.2%  3.683e+08        perf-stat.ps.cache-misses
  5.46e+08          +111.7%  1.156e+09        perf-stat.ps.cache-references
    774516          +125.5%    1746770        perf-stat.ps.context-switches
 4.797e+11            -6.5%  4.483e+11        perf-stat.ps.cpu-cycles
    121274           +95.3%     236908        perf-stat.ps.cpu-migrations
 4.639e+10           +46.5%  6.798e+10        perf-stat.ps.instructions
    568315          +111.7%    1203024        perf-stat.ps.minor-faults
    703458          +112.8%    1496627        perf-stat.ps.page-faults
 2.724e+12 ±  9%     +53.6%  4.184e+12        perf-stat.total.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


