Return-Path: <linux-fsdevel+bounces-19406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3246F8C4DA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 10:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3332841A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 08:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3A91CD38;
	Tue, 14 May 2024 08:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M7mBBlMI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682BB17BD2;
	Tue, 14 May 2024 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715675020; cv=fail; b=oaKgPiah+yMAEcbPgiPk5vM7LtCKzOW/IaG6LoXlq3OJ20GpPVczH9FZJdUghmadGGqu/DAGKtj/79jRLGomJGodZ2/mNUtdqP96qFlQhhLMd4TaI5Zds/Jxa3ntqpt5tIgaXa+gjxTDOEqFjUlt1l4Djp+B8yz8musyxq5ct2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715675020; c=relaxed/simple;
	bh=tRQqWJr0hE5546mpbbfzDNa6vpMSKU5tYp371sPOZvI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EfKfdaLm6yKhCy9Dwe1YZVgQdioYjtpmUCNunF+gBDi745G/+3UMWovsEvkO+Cc1Y7dGmx6mVy+Czw0nPddpdfY/a+CfXI16wB/NZEesvNiVQ0O9VFOb73Bx7VaqgbzwaWCyti1g/YqTIdUP5E0wouoLQSE519TKH3WNQjS+nvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M7mBBlMI; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715675019; x=1747211019;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tRQqWJr0hE5546mpbbfzDNa6vpMSKU5tYp371sPOZvI=;
  b=M7mBBlMIW6jFNo55+83vzNXbZVryMbErYE4CvvhtlKaP+JcaTtPCt14a
   xRqFy3RRETS/PFFlLoYKubcYxUGhifS7Cnqbl+f4R3NGU+7xPu0zbDHf1
   ZtaYQwzwtPJzMdeD3SU5q8TpbZo/WyXaFObnTbgn0eGdcHCtQRGDGlSV5
   bjxXU0ZBs+ctv5XiI7Wof/NWRXb9roLHOW7+4l72piUiyGTkcNsJh/umC
   QXSwkuV7CmEKDK+venkCXVQ4tMaTyfppdEA6y+UAF1leNFxMA72Orjj4n
   Of5gSlEuACH/4DOQkuEoKccQ2gzfyEqFD4Cawv2GdNRNqu7KeiElWSxt5
   A==;
X-CSE-ConnectionGUID: bSVPM1H5REOJ4t/B7NH5cg==
X-CSE-MsgGUID: KLsuAmOMS+ikSmC0xuWKgQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11808619"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11808619"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 01:23:39 -0700
X-CSE-ConnectionGUID: +B1yTn5/S021b3qfjEadMQ==
X-CSE-MsgGUID: 3hhlf+SoTP28dkcx6SbS+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="31156023"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 01:23:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 01:23:38 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 01:23:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 01:23:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 01:23:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASRnE8KMvNSY3/GV3ChluNkGAB+RqtWOOFydoZSjONkA7K+Xxr/kasyRgzWO+cSyOqDMNZoOtULcww1KCZ6e+spE7QE7+7hDRON0251R976OElrXsHkawcKTk15t3NEzbIBrdNguoVmHtKebKhFozZ7K87OMaKY3zzYuj7qTL7oJzgqqfxi8v8YiPR6Zb/S/eZ3XsFECTcQz5nlt5dPuP1FPIc7kQAuQmLFeo1rqds3mNajraPGSUahPdarHX1tNVtbf33Skwm2AMSQuf8PbkP/cTUyEjXPWEBlslP8yz/TgTM/Uxey9x1dTpyH43G36nKliN4FcWfPTteCl7IHegg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dc8l9AZWmsAZzCMElYgELrUbtaZxOPjioBUtHGtKS5k=;
 b=IWH9auig98z6d15HypinnMETDSEcn3mFp9EI7O0HiUtkQlORAWX/OLBn0764wnu4oMh6WtDIOrd2LbSr2F3ZduL49a4NBT4mPSQ08dtVIClQRV0XBTqQcPv/Dspo2Bx0fsv0DiUsj+oDskKcjWKWwGtyesLiBxxJD/XZBmYu/YsBJTYN6NiXHJiSJKWHc+c/itBhIK3WKPe3lR/fqWpPEZe8+DcyYPMuZs0Fp2LRfCwFEwUdT4tyXiI4MJla1UxyS1/9CFUH3qIeJJ4RwhMBDCqaKKlQZchrL5zUNKQBSJvOvRLkyKwhWZM8BRjBkR7PlOX8U/wJHslsBugIf3ubIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6900.namprd11.prod.outlook.com (2603:10b6:806:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:23:30 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 08:23:30 +0000
Date: Tue, 14 May 2024 16:23:21 +0800
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
Message-ID: <ZkMfeQOEBFXOxJxL@xsang-OptiPlex-9020>
References: <Zin4G2VYUiaYxsKQ@xsang-OptiPlex-9020>
 <202404161031.468b84f-oliver.sang@intel.com>
 <164954.1713356321@warthog.procyon.org.uk>
 <2145850.1714121572@warthog.procyon.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2145850.1714121572@warthog.procyon.org.uk>
X-ClientProxiedBy: KL1PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::26) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: b5754975-91ea-4279-b461-08dc73ef2324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WaoTs4NWbl0oqeEp/NCh2s6kzQYd0zPV40ZKgJSvPhyqxuaKzkqKbwhc9uj6?=
 =?us-ascii?Q?oFVpGqsBbx0irYCD3ec+XktaG0xc4erZTqqh9ovRsYEbd6ge3DffeglWdrmW?=
 =?us-ascii?Q?nA65aaIcHyaybeDSCYK+3/vI/geAqeFvASQAcyIAlEhsqI9Z+SvQRIBKZsl1?=
 =?us-ascii?Q?0EQNUBs9q7mm2OtsPvLUomRlYb+2/wXUG661EREtddTQiqjOtYLDLygM5N8n?=
 =?us-ascii?Q?T3em6rLM+ZiY0kI8FM7v6srmPr+SvBGO7suxIVz9WwZvoBrNfvUcEpXq0hLT?=
 =?us-ascii?Q?BkO3SfF3j6VscD9pJL659lk+K0m/VoQmVemoPA0Y2doNw2HM7IOZrNHiKFuN?=
 =?us-ascii?Q?x9vXVyQkVHih9iK+fy8pxEfvF/mGrM0aHs9ckLCFz75OgcAatxaSCb8hh5A8?=
 =?us-ascii?Q?Q3369mu9Wph5P2kKIBXe5uhZzBDA7IRoTt71tXS7veLyXbeWq1H5svjq/3tf?=
 =?us-ascii?Q?EyFvw8jDPWoABEQWjlj0N/12/q9NKDFXTJVQkkVaMNQvQjajckiq0xtcUhXI?=
 =?us-ascii?Q?MVzv3cQAlFiSR0Yli0WOVOl3gDQ8p0PMdB2w1rbKBKc32d4yTgBUWUl7pRiL?=
 =?us-ascii?Q?oB7DOf+T+SGVZQif14Guq242BvYj9IU/s/4sga4pme94Yw7tn2qqTR1MlYTY?=
 =?us-ascii?Q?dRO6P/Yr7bAYmoj9KFQ4Gn5JSrmC4zBnbL3X6uLjL/O+5YM9k/WKXiCUlvBh?=
 =?us-ascii?Q?Vq3p0kw3GyQqYHJpPezJ12f3fE37rBMd891taaoqa4t3jNbhSoZhVpAB5pZg?=
 =?us-ascii?Q?ggiDmnjFhpCRsLY1ixGaEKlCEPeYb+K9tSatBKnRGp5k5X6wIAUmsEKD7cNv?=
 =?us-ascii?Q?obdaXDzCZgMugGJIwvb4niEfIMivJPItscYqndj368n/pnTItxM5gUbc8RLn?=
 =?us-ascii?Q?fZNAGvPdsqGhv/c257T1MyH2u2LCmtJuBWlzvucgfzMLcS+s9F0NIKWPf6Bf?=
 =?us-ascii?Q?NuRMphBaN7Sxec1GU1IQmTceZdOgnnaR/XFzXW+OBRtFHRIgNvUW62gRIfWe?=
 =?us-ascii?Q?XpuDuxlW+HdSlaJxvtvH3OP6rR1r+rew8Yx7UHVE/skFTTbnUgr6Ls1mgElb?=
 =?us-ascii?Q?y9L52WyRdpsPbQpupdKErYjwY9LY3ccpv+sHRDCf156CqtnMpeklNWvvOSxa?=
 =?us-ascii?Q?o9BcctlBhr5kZgFmlmfMV9oaOhrMHZ2y/8wt7i1BZssHcWmPhaThO6DIs/+a?=
 =?us-ascii?Q?RJUJjJu/r8mhEjgNk1LEVYUokTXGLoKefwsuwy9JeG0SAjGTiXQuA/bnRHM?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qfjr0te4oOQYpvKHbWUl+hsJllAQxuDxBMBEjYgEfPCb9dIL4YiQ95VArm8m?=
 =?us-ascii?Q?kbKR5c2ubN/8iQiqfZBtbnpUzgGqpyG2UPzwfg92K2EGPiF87NM082jevbwL?=
 =?us-ascii?Q?OSh9MjUR+ZZp5CcWd3gJ+H4h+DhXjJrafP+MeT+fTfGmjC+zrueEQ7BfhXnH?=
 =?us-ascii?Q?nCo9X8udtajlVlBSCFg9ltuYaDBtFktdYQUbnr7/ET9ReZ99Sz4q5dImfN5D?=
 =?us-ascii?Q?qgSRzdS7dar+yrga7y9HYeGw4pDl7T/DUnM9LwK8n6QAck42e0+co0LczwSY?=
 =?us-ascii?Q?R7uFM/91zBwD9zqMc81U1mOBMYgkYnyVwd7B2h4uoHULwvmuBD6qp8E8n+ZF?=
 =?us-ascii?Q?9R60Zbq1CdvnqBoNMTHkOVgOKKN/ZnPWGmp8TBreLWmAYRcAy0B831TX3Ue+?=
 =?us-ascii?Q?D/Nxk4QAz9Jq0DKVd+L2DSz3MOVUBxTtxa8HbwkrxrCMgJJemlw4+Ed8V/29?=
 =?us-ascii?Q?7L4EEEEjjlfw3YIwUmOz4MmZ8wHRroYsxrmUr/SoUdvS6WORw6PU0kLJPsqh?=
 =?us-ascii?Q?wH7nRAED6C4uC8AwegCW9Cj1/VbDDcxeSAIDKfiNnht3CMOqdk3Or8Z52A55?=
 =?us-ascii?Q?egWF2vhHi3MglqTJhoISgjjiHtPaElu+k3f8CiEwPfTrJ2wbPexkug39/2OD?=
 =?us-ascii?Q?19KthjDHquHWQ+YJ2RiP+32087QNQB6nWc+zyuhn1D9A72mSFDVaBAcXjLRE?=
 =?us-ascii?Q?AZ93SY6b3ffYWG3j56GHRERHufmEMCXT/dZ+3Kc1MbpF6xuqlQa5XY/1wsBo?=
 =?us-ascii?Q?7Amfaxze7b/TquyHEhV+LBL6a+0XqycV08rt8Du1BjjPAzWVazirCTJhryYt?=
 =?us-ascii?Q?2Y5AyInqUjMRbL7+anXQSvjQnURBSD1GcKlfv3CXRhnxcq7WUHpp8eZ6o2E1?=
 =?us-ascii?Q?1bJf3jUNlTm6ylWNHmT1nKLKPYa+4ha/lQtyjfNMS/wLLNU+ksvh80O5vH//?=
 =?us-ascii?Q?BXTFA+W81/JgQmXSsq4htOtXKGaph6XndYJlu+Dh1b9ybRwLBWCXwp2pNspM?=
 =?us-ascii?Q?AdWqK4z8GgF+GoNYrepEkSlSOvXecqUuh97XVUdSSpf0u2eQVr2uKgNnfo7x?=
 =?us-ascii?Q?80j96Ul4V8qGl05P2NOqtJh52AzgCmP4XX5TL5EhzGLcFCTHYgQh8UV+bUAL?=
 =?us-ascii?Q?/KUpWGXMF4omPxiPJpJQJzSTJG7KqeELKALJZLhx4Uc7iC2RrEDjPnhnNy9o?=
 =?us-ascii?Q?5V+5jh35zsuYq3dEI6W9vAKFeLBPVpnU46IBhXB0eId9ekH3v9qKWAkjZPcp?=
 =?us-ascii?Q?qfd1aU8JYnb9x/os1yv+iiJpU4LY6DgFGgUHUMw09/Ch/AofcmSoF8PdQjVU?=
 =?us-ascii?Q?h43a3N2AUQnxsi2Ilcu1dcRoXFyRNffA8mtly54I/YuehxzdulNg3T976hO6?=
 =?us-ascii?Q?NI1G8hjmt6gYMWpFxoSJSjNzoP+Rrj7+lCy6fNfM5BQSutdgx00OHPtUb/D7?=
 =?us-ascii?Q?3gQLSjN7j5e5XPDDeN8yNDVfn33zP/WmJZvcROO3wyxrkfKRcWsD7OjNxd2g?=
 =?us-ascii?Q?QoOqYTUT0A89YG70KGYiEn1J7/4rDSYeexMcEKWcaet3KeEiAgm1h6WaSdPj?=
 =?us-ascii?Q?Ve65Cmn07ZlHIAeZYtCDxpn6H1N08KsyYm7Gc7VsQ6TnopCMuFferrgHfoaN?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5754975-91ea-4279-b461-08dc73ef2324
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 08:23:30.4480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhMd5uY+CotpMBuDDlbTry9ZOAQaOxbot+3egeda4n/pdP/H37lqXewku28SL+0hUqZ9yZSYCiTmJSx+moq1dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6900
X-OriginatorOrg: intel.com

On Fri, Apr 26, 2024 at 09:52:52AM +0100, David Howells wrote:
> The "lkp install" didn't complete:
> 
> ==> Retrieving sources...
>   -> Source is https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>   -> Cloning linux git repo...
> Cloning into bare repository '/root/lkp-tests/programs/turbostat/pkg/linux'...
> remote: Enumerating objects: 10112942, done.
> remote: Counting objects: 100% (889/889), done.
> remote: Compressing objects: 100% (475/475), done.
> remote: Total 10112942 (delta 554), reused 549 (delta 412), pack-reused 10112053
> Receiving objects: 100% (10112942/10112942), 2.78 GiB | 4.16 MiB/s, done.
> Resolving deltas: 100% (8300839/8300839), done.
> ==> WARNING: Skipping verification of source file PGP signatures.
> ==> Validating source files with md5sums...
>     linux ... Skipped
> ==> Extracting sources...
>   -> Source is https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>   -> Creating working copy of linux git repo...
> fatal: '/root/lkp-tests/pkg/turbostat/linux' does not appear to be a git repository
> fatal: Could not read from remote repository.
> 
> 
> I looked around under /root/lkp-tests and there's no pkg/ directory.  It seems
> to be using tmp-pkg instead.

should be fixed in latest lkp-tests

> 
> Is there a way to skip the cloning of the kernel?  I already have my test
> kernel running on my test machine, booted by PXE/tftp from the build tree on
> my desktop.  Just tell me what options I need to enable.

this is a bug in our code. there is no step to clone kernel in this test now.

> 
> David
> 

