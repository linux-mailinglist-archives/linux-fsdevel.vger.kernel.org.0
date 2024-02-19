Return-Path: <linux-fsdevel+bounces-11975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B27A859BC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 07:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D429B21545
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 06:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A658200AB;
	Mon, 19 Feb 2024 06:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IkaEMGyP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48761F951;
	Mon, 19 Feb 2024 06:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708322437; cv=fail; b=S7KJ3FrmddD74pJRxJnKPfDQrY5dBRSPshAxy1bx2c714oOEFkmoTbPyQiuEd41wjeCedHRw8wAsljBMEsF7Lp9etDH+CwSc9Q8+AHOXcBa7vhewLgbcSYoEnHz8qFkbF0LgLtHLBWgmZh71LY0ZVJ7OG/ey0nAfRNgyNYNJZRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708322437; c=relaxed/simple;
	bh=VrPi68byKij78kakQKzkgipuhchVyQgf9IkobkqzMu4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WvaIqP14u9NFoYI+fMJcQxdAQZxdmglfbFLSnx8INilBeWvFkv0voRhl1ag5LRN+uRcgjiMaJRHp7vfsjSZVbLToBYrZXXHnx3EaYiNTs6dhFPHR2I9T97duTsFQUy8m5mU3bXMn5D0UpnYfg29vVS6wol5BBV1abL7KJUw7Ggg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IkaEMGyP; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708322433; x=1739858433;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=VrPi68byKij78kakQKzkgipuhchVyQgf9IkobkqzMu4=;
  b=IkaEMGyProLZhpBqEXQK3Asz1Hlpvh6FKrHkYp3vVX7nb6YMcYSXkv27
   udPmaMRefwq2TO7NWblpT8Sv0UnP8DSWsCnSYMFQD+X3ZPuzmhQQrqHTA
   m1Ewec58pAlYXcy4hUKsiKBdmd/Xhw8EFrWUB9qWUc9Sc8b7A8EAr5Qbu
   zn156adGtdy3pMD1DutUlCd8gV05d0FpOJhl2Oy86ChD09d1Rg+iyUzvG
   WT8+A13rax4SjHaETU8+jAeydHPcjhuXlVTyWR/NhA5vK5OOG0jO1koDC
   Ed3KKmhpasXVS3NAdQNa1YnBtEtaI8I3t+GAGzqh/c4f+1T3zSij/RqQw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2250640"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2250640"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 22:00:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4539824"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2024 22:00:31 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 22:00:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 22:00:30 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 18 Feb 2024 22:00:30 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 18 Feb 2024 22:00:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8qz4C7rXxFc+QWqRofKog2h6syUjsy0atQ/AWSrcCI2WqPtCc53VwBBpo5kghU1FWsTsg4P85pQh7WPoyKreLjb1NAxWyLq+nHjYopVsLhbIn3K6q2ayntwE0ychSTIsEbwF7I5b/UjrqroWP+xGx8QOFGowfgMTNat7Q6szQCPWFyyAZwrWPM05USstw9OSZodQN579EIEbaBKTvKiv9BlFrYiIjQ6tKDY9Y9jiNPL3vbASJWO2L+8gF+TuVksTLsTFk9N8ewBjRcuBCWS8ERq7UEvUbbDw166cWlhB3bsX7EZ30btHZQQsg9tM23Sx3qjSrTaVk+KchPABMvJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvJVs0MhTDqws4FuSDi4Rgtl/C/79uPVJXZDrnD1GBs=;
 b=MIcpoYmgaeM7U5DYSJt0zV4u2qd7W9ya7YId1vacbrVHqBkP4qquQoQwg4fUYqun4P5xS0qyF2G7iP2NeJ2lTyJWGYjnshAhfbEjPjMMiLQLyA1IqEJ4J/dCLN0lJ6hJRVoV8NFH1jq/gVR33LqEkfd6JoN5OgslGDXubUxBoIt3WboGEMU+tlTyxfahkTHGF3vOkozo9SeVgajSLT6JHWBGFhZEEMgelmaLh8IzTST5Sy1VruKT/N5Om+P7/Pi7ShE+8B6QpPK1xCja3RRo58bfsWX0JTgp9Vsv9BY43vyMOweIrvzRZ50NDE91g9j1iXl3XlU8Hphpk8fvXf7mMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH0PR11MB5233.namprd11.prod.outlook.com (2603:10b6:610:e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Mon, 19 Feb
 2024 06:00:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 06:00:27 +0000
Date: Mon, 19 Feb 2024 14:00:18 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Chuck Lever <chuck.lever@oracle.com>
CC: Jan Kara <jack@suse.cz>, Chuck Lever <cel@kernel.org>,
	<viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <hughd@google.com>,
	<akpm@linux-foundation.org>, <Liam.Howlett@oracle.com>,
	<feng.tang@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <maple-tree@lists.infradead.org>,
	<linux-mm@kvack.org>, <lkp@intel.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH RFC 6/7] libfs: Convert simple directory offsets to use a
 Maple Tree
Message-ID: <ZdLucnSQfjU/dFRi@xsang-OptiPlex-9020>
References: <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
 <170786028128.11135.4581426129369576567.stgit@91.116.238.104.host.secureserver.net>
 <20240215130601.vmafdab57mqbaxrf@quack3>
 <Zc4VfZ4/ejBEOt6s@tissot.1015granger.net>
 <ZdFlPbvexMir0WZO@xsang-OptiPlex-9020>
 <ZdIo0yNCFpkN_zBH@manet.1015granger.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdIo0yNCFpkN_zBH@manet.1015granger.net>
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH0PR11MB5233:EE_
X-MS-Office365-Filtering-Correlation-Id: 0506e88f-7a89-4d29-451a-08dc3110121b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IaG/Vqo99BQw/KdW5VyEFm7XScnIYJHva/joEp1N9Fymcak51iCdjlE1svTMLE4I9XK0bUJGfrb98TmBXH/IyKfhCro+KdoKCCJ1c8d5wy2bVC+6QvbJrG2xAFxYAfVEepw4iBntK1JtSK6P1QgyosJykefmJqGvGfIPmo591InOMtx8AeUy7qE2pZkstquH4siy3J8bMUKn7caS2LE3VSUNw8NI07ZT0+MQBeL0k9olbbaeSu5JoMQXW9Mi+N0ctpQEg3lmDqN3EWKCCirb1XmbtycbcTDPB6kx6AYb3MR6G7kFp1lpPKKDr9I442/cfi3uJwUek7qJYA7pgHfJbYo/Ef9cOh6qmTdeyMFC2TgxKx4tBgcWhPghwY6LbHwEMtB9qj2yl3LdmOxi3JoibzfqBK0TC4evuSfMl+3rr05zbNdFc4TSKnYqfz2Fkti9CyYKzUkDNUzNnvOpFNmby6jBsGeM4j5fYDwPP2r2aex8zLZ80w+0OBg5PJVwc3sv00YWmHBFprjtQ8fNiPxSw/sFEr6naMR8SUQj3nvdVeE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(346002)(366004)(136003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6666004)(54906003)(316002)(33716001)(7416002)(30864003)(5660300002)(44832011)(2906002)(4326008)(6916009)(66476007)(66556008)(8936002)(66946007)(8676002)(86362001)(19627235002)(41300700001)(966005)(6486002)(9686003)(6512007)(6506007)(107886003)(26005)(478600001)(83380400001)(82960400001)(38100700002)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?OlcBrw+74jHiTsLxBQXPFmDPSgOuSniqOfY8fi+5ar8Ie6gX9W64LglfqD?=
 =?iso-8859-1?Q?E/V0d6SNG8JAi9LKQPl7zaLFPer3Lsp0XDWhZjMH24kWtYwabuLiXicCs6?=
 =?iso-8859-1?Q?F5d9pmCLOChVdxdfFY8h+Onen4Al2wOEV4Sp06/16qbZy08V5zVSmwH7x6?=
 =?iso-8859-1?Q?oCS15EGv2gN1cluUxBypGPGDaTZ6ZH7xpTpP/l/n+pOaDt6P3kw7cVXr4R?=
 =?iso-8859-1?Q?tKjxntclIK5vyXrnyK56u2I9GYL0sLpn1jk+KjWr+O8u9SNiOFZDvDJnrm?=
 =?iso-8859-1?Q?Or6TxZ6179ZfUD3M1QwajfhtuYZJqNfeCxGn96WLJaCpY0BL/ChRZOXMZT?=
 =?iso-8859-1?Q?XhVihXun53ECW6SpGlhmmHpOXjQrzvwlG3tM8s+gDGp6KUu4bxPhPA65V0?=
 =?iso-8859-1?Q?2TAM9g7lZNCv7fTsRGQQ/qApmspjlbbisV7v732D8YNT2qD325uErryKYR?=
 =?iso-8859-1?Q?m+Z/3nR3tbxyrGQ4q4NbZ2wv0+aeI3rGcIGpzheqCF20vf7d0UE0waRopA?=
 =?iso-8859-1?Q?LfXDJZ7n3tdkD4l4Hkcgdo/Eak0Wrj1ex/OEnc6ARg92WmA6Xe77FtXWqT?=
 =?iso-8859-1?Q?N/nl8hSKObTppmzqJDJGYshmdWL9EQ6p3/Fkmr01sXV3FKoD+7ZaQQA+98?=
 =?iso-8859-1?Q?9tQUnj1X0c9hHhUIUxIWJ1sMkNiHMbk70/B8aQA7h8RHVKgpJwQcEUZVsz?=
 =?iso-8859-1?Q?rVNbX21s9swt+fXEMslaHVMOYofZv8O2OdDrHkIl7QrHRGYKlLYeAySAmr?=
 =?iso-8859-1?Q?qy4LhbH3FqJ9ZorzcieJvusOFdY+qFYh1c+Io8TPgO6KPEyAN3uYHbyGAS?=
 =?iso-8859-1?Q?YjOMocpW3fusrFpGOIhwKWL4zS+NOXiAwjuSfecy9u5Nz46dEysKjR0P2T?=
 =?iso-8859-1?Q?WRBh+40LygiA9pg2scbE8iZFKBC2/VUe2okfh1lCktJ3DNzVtOZadvl1a7?=
 =?iso-8859-1?Q?AioODmtYOKB65YGwV76MlP8Ns5fhBoH1etkMdIvwGBdhauwQwgcRWkM125?=
 =?iso-8859-1?Q?99NskZoKYdRaJUEsJqBMvxd6z07fsmiZ2AUwLaUSA7ZgucnbP2be1olJm5?=
 =?iso-8859-1?Q?qa8ifbu7zM88MEgZ2AkyejOLdLqov6NLDdETeoPfhYbiUZB8aABPG9IN2E?=
 =?iso-8859-1?Q?LqsYrwuR/CU82/64WfuTA/H8uo4golF4bKyF0J0lXx4H2q0SWDXuiZzfr3?=
 =?iso-8859-1?Q?feQFVbaD9TrchPCmlyt5QrO1Gr14A2kY46r5hhK3bHQT7wHXj3Uu7uKite?=
 =?iso-8859-1?Q?ZuJF7XMjLlmOT4XyxPIPnU45e11hwPKsR6Hm/I+d4GzzXzABCU1+kdpLCP?=
 =?iso-8859-1?Q?0DZU9ascZRyLEQPUQ0As1DcUPJ0zLJngM8l64MDtg5Jn9cbH6Ld+rhPZyr?=
 =?iso-8859-1?Q?eEy7w2MqETXfXwVeFZtM9l4xgYzr4JYwGVvjtxnC3eoi+oL0VNyc0Nh3qu?=
 =?iso-8859-1?Q?ASA2YBoTxWJthIHH7r93dgI6FKWPVHrWO8t31+yhA3IsL+Kr6Qe4e3EfiO?=
 =?iso-8859-1?Q?LOKGj1TV9KKP0eqWyenVw8ut0FuJX0zRcEdglTO6aNiGPijjni0iNVzrJU?=
 =?iso-8859-1?Q?ceEigJoprcySSyaP2CZLDMhbazL8F+17g1rifbeMM4SEKTOz6UyOLp9o7w?=
 =?iso-8859-1?Q?FFSm/laIjlA7VqQVLaUSSqLitQLCoyzFLEQQb7T0gKSRS036IrljX2GA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0506e88f-7a89-4d29-451a-08dc3110121b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 06:00:27.6480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Qg9E0FsiGqjaAnyWHjeS6wcuFzxCHhe9btSBd7WnS69/g+7wCbRpFew64NPI1unkuvt+jXWGObvK0rFTpcejA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5233
X-OriginatorOrg: intel.com

hi, Chuck Lever,

On Sun, Feb 18, 2024 at 10:57:07AM -0500, Chuck Lever wrote:
> On Sun, Feb 18, 2024 at 10:02:37AM +0800, Oliver Sang wrote:
> > hi, Chuck Lever,
> > 
> > On Thu, Feb 15, 2024 at 08:45:33AM -0500, Chuck Lever wrote:
> > > On Thu, Feb 15, 2024 at 02:06:01PM +0100, Jan Kara wrote:
> > > > On Tue 13-02-24 16:38:01, Chuck Lever wrote:
> > > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > > > 
> > > > > Test robot reports:
> > > > > > kernel test robot noticed a -19.0% regression of aim9.disk_src.ops_per_sec on:
> > > > > >
> > > > > > commit: a2e459555c5f9da3e619b7e47a63f98574dc75f1 ("shmem: stable directory offsets")
> > > > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > > 
> > > > > Feng Tang further clarifies that:
> > > > > > ... the new simple_offset_add()
> > > > > > called by shmem_mknod() brings extra cost related with slab,
> > > > > > specifically the 'radix_tree_node', which cause the regression.
> > > > > 
> > > > > Willy's analysis is that, over time, the test workload causes
> > > > > xa_alloc_cyclic() to fragment the underlying SLAB cache.
> > > > > 
> > > > > This patch replaces the offset_ctx's xarray with a Maple Tree in the
> > > > > hope that Maple Tree's dense node mode will handle this scenario
> > > > > more scalably.
> > > > > 
> > > > > In addition, we can widen the directory offset to an unsigned long
> > > > > everywhere.
> > > > > 
> > > > > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > > Closes: https://lore.kernel.org/oe-lkp/202309081306.3ecb3734-oliver.sang@intel.com
> > > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > 
> > > > OK, but this will need the performance numbers.
> > > 
> > > Yes, I totally concur. The point of this posting was to get some
> > > early review and start the ball rolling.
> > > 
> > > Actually we expect roughly the same performance numbers now. "Dense
> > > node" support in Maple Tree is supposed to be the real win, but
> > > I'm not sure it's ready yet.
> > > 
> > > 
> > > > Otherwise we have no idea
> > > > whether this is worth it or not. Maybe you can ask Oliver Sang? Usually
> > > > 0-day guys are quite helpful.
> > > 
> > > Oliver and Feng were copied on this series.
> > 
> > we are in holidays last week, now we are back.
> > 
> > I noticed there is v2 for this patch set
> > https://lore.kernel.org/all/170820145616.6328.12620992971699079156.stgit@91.116.238.104.host.secureserver.net/
> > 
> > and you also put it in a branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> > "simple-offset-maple" branch.
> > 
> > we will test aim9 performance based on this branch. Thanks
> 
> Very much appreciated!

always our pleasure!

we've already sent out a report [1] to you for the commit a616bc6667 in new
branch.
we saw 11.8% improvement of aim9.disk_src.ops_per_sec on it comparing to its
parent.

so the regression we saw on a2e459555c is 'half' recovered.

since I noticed the performance for a2e459555c, v6.8-rc4 and f3f24869a1 (parent
of a616bc6667) are very similar, so ignored results from v6.8-rc4 and f3f24869a1
in below tables for brief. if you want a full table, please let me know. Thanks!


summary for aim9.disk_src.ops_per_sec:

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-ivb-2ep1/disk_src/aim9/300s

commit:
  23a31d8764 ("shmem: Refactor shmem_symlink()")
  a2e459555c ("shmem: stable directory offsets")
  a616bc6667 ("libfs: Convert simple directory offsets to use a Maple Tree")


23a31d87645c6527 a2e459555c5f9da3e619b7e47a6 a616bc666748063733c62e15ea4
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    202424           -19.0%     163868            -9.3%     183678        aim9.disk_src.ops_per_sec


full data:

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-ivb-2ep1/disk_src/aim9/300s

commit:
  23a31d8764 ("shmem: Refactor shmem_symlink()")
  a2e459555c ("shmem: stable directory offsets")
  a616bc6667 ("libfs: Convert simple directory offsets to use a Maple Tree")


23a31d87645c6527 a2e459555c5f9da3e619b7e47a6 a616bc666748063733c62e15ea4
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
      1404            +0.6%       1412            +3.3%       1450        boot-time.idle
      0.26 ±  9%      +0.1        0.36 ±  2%      -0.1        0.20 ±  4%  mpstat.cpu.all.soft%
      0.61            -0.1        0.52            -0.0        0.58        mpstat.cpu.all.usr%
      1.00            +0.0%       1.00           +19.5%       1.19 ±  2%  vmstat.procs.r
      1525 ±  6%      -5.6%       1440            +9.4%       1668 ±  4%  vmstat.system.cs
     52670            +5.0%      55323 ±  3%     +12.7%      59381 ±  3%  turbostat.C1
      0.02            +0.0        0.02            +0.0        0.03 ± 10%  turbostat.C1%
     12949 ±  9%      -1.2%      12795 ±  6%     -19.6%      10412 ±  6%  turbostat.POLL
    115468 ± 24%     +11.9%     129258 ±  7%     +16.5%     134545 ±  5%  numa-meminfo.node0.AnonPages.max
      2015 ± 12%      -7.5%       1864 ±  5%     +30.3%       2624 ± 10%  numa-meminfo.node0.PageTables
      4795 ± 30%      +1.1%       4846 ± 37%    +117.0%      10405 ± 21%  numa-meminfo.node0.Shmem
      6442 ±  5%      -0.6%       6401 ±  4%     -19.6%       5180 ±  7%  numa-meminfo.node1.KernelStack
     13731 ± 92%     -88.7%       1546 ±  6%    +161.6%      35915 ± 23%  time.involuntary_context_switches
     94.83            -4.2%      90.83            +1.2%      96.00        time.percent_of_cpu_this_job_got
    211.64            +0.5%     212.70            +4.0%     220.06        time.system_time
     73.62           -17.6%      60.69            -6.4%      68.94        time.user_time
    202424           -19.0%     163868            -9.3%     183678        aim9.disk_src.ops_per_sec
     13731 ± 92%     -88.7%       1546 ±  6%    +161.6%      35915 ± 23%  aim9.time.involuntary_context_switches
     94.83            -4.2%      90.83            +1.2%      96.00        aim9.time.percent_of_cpu_this_job_got
    211.64            +0.5%     212.70            +4.0%     220.06        aim9.time.system_time
     73.62           -17.6%      60.69            -6.4%      68.94        aim9.time.user_time
    174558 ±  4%      -1.0%     172852 ±  7%     -19.7%     140084 ±  7%  meminfo.DirectMap4k
     94166            +6.6%     100388           -14.4%      80579        meminfo.KReclaimable
     12941            +0.4%      12989           -14.4%      11078        meminfo.KernelStack
      3769            +0.2%       3775           +31.5%       4955        meminfo.PageTables
     79298            +0.0%      79298           -70.6%      23298        meminfo.Percpu
     94166            +6.6%     100388           -14.4%      80579        meminfo.SReclaimable
    204209            +2.9%     210111            -9.6%     184661        meminfo.Slab
    503.33 ± 12%      -7.5%     465.67 ±  5%     +30.4%     656.39 ± 10%  numa-vmstat.node0.nr_page_table_pages
      1198 ± 30%      +1.1%       1211 ± 37%    +117.0%       2601 ± 21%  numa-vmstat.node0.nr_shmem
    220.33            +0.2%     220.83 ±  2%     -97.3%       6.00 ±100%  numa-vmstat.node1.nr_active_file
    167.00            +0.2%     167.33 ±  2%     -87.7%      20.48 ±100%  numa-vmstat.node1.nr_inactive_file
      6443 ±  5%      -0.6%       6405 ±  4%     -19.5%       5184 ±  7%  numa-vmstat.node1.nr_kernel_stack
    220.33            +0.2%     220.83 ±  2%     -97.3%       6.00 ±100%  numa-vmstat.node1.nr_zone_active_file
    167.00            +0.2%     167.33 ±  2%     -87.7%      20.48 ±100%  numa-vmstat.node1.nr_zone_inactive_file
      0.04 ± 25%      +4.1%       0.05 ± 33%     -40.1%       0.03 ± 34%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.01 ±  4%      +1.6%       0.01 ±  8%    +136.9%       0.02 ± 29%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.16 ± 10%     -18.9%       0.13 ± 12%     -16.4%       0.13 ± 15%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.14 ± 15%      -6.0%       0.14 ± 20%     -30.4%       0.10 ± 26%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.04 ±  7%   +1802.4%       0.78 ±115%   +7258.6%       3.00 ± 56%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.05 ± 40%     -14.5%       0.04 ± 31%   +6155.4%       3.09        perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±  8%     +25.5%       0.01 ± 21%    +117.0%       0.02 ± 30%  perf-sched.total_sch_delay.average.ms
      0.16 ± 11%   +1204.9%       2.12 ± 90%   +2225.8%       3.77 ± 10%  perf-sched.total_sch_delay.max.ms
     58.50 ± 28%      -4.8%      55.67 ± 14%     -23.9%      44.50 ±  4%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.usleep_range_state.ipmi_thread.kthread
    277.83 ±  3%     +10.3%     306.50 ±  5%     +17.9%     327.62 ±  4%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.10 ± 75%     -47.1%       0.05 ± 86%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.path_put.vfs_statx.vfs_fstatat
      0.10 ± 72%     -10.8%       0.09 ± 67%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      2.00 ± 27%      -4.8%       1.90 ± 14%     -23.7%       1.53 ±  4%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.16 ± 81%     +20.1%       0.19 ±104%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.path_put.vfs_statx.vfs_fstatat
      0.22 ± 77%     +14.2%       0.25 ± 54%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      7.32 ± 43%     -10.3%       6.57 ± 20%     -33.2%       4.89 ±  6%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
    220.33            +0.2%     220.83 ±  2%     -94.6%      12.00        proc-vmstat.nr_active_file
    676766            -0.0%     676706            +4.1%     704377        proc-vmstat.nr_file_pages
    167.00            +0.2%     167.33 ±  2%     -75.5%      40.98        proc-vmstat.nr_inactive_file
     12941            +0.4%      12988           -14.4%      11083        proc-vmstat.nr_kernel_stack
    942.50            +0.1%     943.50           +31.4%       1238        proc-vmstat.nr_page_table_pages
      7915 ±  3%      -0.8%       7855            +8.6%       8599        proc-vmstat.nr_shmem
     23541            +6.5%      25074           -14.4%      20144        proc-vmstat.nr_slab_reclaimable
     27499            -0.3%      27422            -5.4%      26016        proc-vmstat.nr_slab_unreclaimable
    668461            +0.0%     668461            +4.2%     696493        proc-vmstat.nr_unevictable
    220.33            +0.2%     220.83 ±  2%     -94.6%      12.00        proc-vmstat.nr_zone_active_file
    167.00            +0.2%     167.33 ±  2%     -75.5%      40.98        proc-vmstat.nr_zone_inactive_file
    668461            +0.0%     668461            +4.2%     696493        proc-vmstat.nr_zone_unevictable
    722.17 ± 71%     -34.7%     471.67 ±136%     -98.3%      12.62 ±129%  proc-vmstat.numa_hint_faults_local
   1437319 ± 24%    +377.6%    6864201           -47.8%     750673 ±  7%  proc-vmstat.numa_hit
   1387016 ± 25%    +391.4%    6815486           -49.5%     700947 ±  7%  proc-vmstat.numa_local
     50329            -0.0%      50324            -1.2%      49704        proc-vmstat.numa_other
   4864362 ± 34%    +453.6%   26931180           -66.1%    1648373 ± 17%  proc-vmstat.pgalloc_normal
   4835960 ± 34%    +455.4%   26856610           -66.3%    1628178 ± 18%  proc-vmstat.pgfree
     11.21           +23.7%      13.87           -81.8%       2.04        perf-stat.i.MPKI
 7.223e+08            -4.4%  6.907e+08            -3.9%   6.94e+08        perf-stat.i.branch-instructions
      2.67            +0.2        2.88            +0.0        2.70        perf-stat.i.branch-miss-rate%
  19988363            +2.8%   20539702            -3.1%   19363031        perf-stat.i.branch-misses
     17.36            -2.8       14.59            +0.4       17.77        perf-stat.i.cache-miss-rate%
  40733859           +19.5%   48659982            -1.9%   39962840        perf-stat.i.cache-references
      1482 ±  7%      -5.7%       1398            +9.6%       1623 ±  5%  perf-stat.i.context-switches
      1.76            +3.5%       1.82            +5.1%       1.85        perf-stat.i.cpi
     55.21            +5.4%      58.21 ±  2%      +0.4%      55.45        perf-stat.i.cpu-migrations
  16524721 ±  8%      -4.8%   15726404 ±  4%     -13.1%   14367627 ±  4%  perf-stat.i.dTLB-load-misses
  1.01e+09            -3.8%  9.719e+08            -4.4%  9.659e+08        perf-stat.i.dTLB-loads
      0.26 ±  4%      -0.0        0.23 ±  3%      -0.0        0.25 ±  3%  perf-stat.i.dTLB-store-miss-rate%
   2166022 ±  4%      -6.9%    2015917 ±  3%      -7.0%    2014037 ±  3%  perf-stat.i.dTLB-store-misses
 8.503e+08            +5.5%  8.968e+08            -3.5%  8.205e+08        perf-stat.i.dTLB-stores
     69.22 ±  4%      +6.4       75.60           +14.4       83.60 ±  3%  perf-stat.i.iTLB-load-miss-rate%
    709457 ±  5%      -5.4%     670950 ±  2%    +133.6%    1657233        perf-stat.i.iTLB-load-misses
    316455 ± 12%     -31.6%     216531 ±  3%      +3.5%     327592 ± 19%  perf-stat.i.iTLB-loads
 3.722e+09            -3.1%  3.608e+09            -4.6%  3.553e+09        perf-stat.i.instructions
      5243 ±  5%      +2.2%       5357 ±  2%     -59.1%       2142        perf-stat.i.instructions-per-iTLB-miss
      0.57            -3.3%       0.55            -4.8%       0.54        perf-stat.i.ipc
    865.04           -10.4%     775.02 ±  3%      -2.5%     843.12        perf-stat.i.metric.K/sec
     53.84            -0.4%      53.61            -4.0%      51.71        perf-stat.i.metric.M/sec
     47.51            -2.1       45.37            +0.7       48.17        perf-stat.i.node-load-miss-rate%
     88195 ±  3%      +5.2%      92745 ±  4%     +16.4%     102647 ±  6%  perf-stat.i.node-load-misses
    106705 ±  3%     +14.8%     122490 ±  5%     +13.2%     120774 ±  5%  perf-stat.i.node-loads
    107169 ±  4%     +29.0%     138208 ±  7%      +7.5%     115217 ±  5%  perf-stat.i.node-stores
     10.94           +23.3%      13.49           -81.8%       1.99        perf-stat.overall.MPKI
      2.77            +0.2        2.97            +0.0        2.79        perf-stat.overall.branch-miss-rate%
     17.28            -2.7       14.56            +0.4       17.67        perf-stat.overall.cache-miss-rate%
      1.73            +3.4%       1.79            +5.0%       1.82        perf-stat.overall.cpi
      0.25 ±  4%      -0.0        0.22 ±  3%      -0.0        0.24 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
     69.20 ±  4%      +6.4       75.60           +14.4       83.58 ±  3%  perf-stat.overall.iTLB-load-miss-rate%
      5260 ±  5%      +2.3%       5380 ±  2%     -59.2%       2144        perf-stat.overall.instructions-per-iTLB-miss
      0.58            -3.2%       0.56            -4.7%       0.55        perf-stat.overall.ipc
     45.25            -2.2       43.10            +0.7       45.93        perf-stat.overall.node-load-miss-rate%
 7.199e+08            -4.4%  6.883e+08            -3.9%  6.917e+08        perf-stat.ps.branch-instructions
  19919808            +2.8%   20469001            -3.1%   19299968        perf-stat.ps.branch-misses
  40597326           +19.5%   48497201            -1.9%   39829580        perf-stat.ps.cache-references
      1477 ±  7%      -5.7%       1393            +9.6%       1618 ±  5%  perf-stat.ps.context-switches
     55.06            +5.4%      58.03 ±  2%      +0.5%      55.32        perf-stat.ps.cpu-migrations
  16469488 ±  8%      -4.8%   15673772 ±  4%     -13.1%   14319828 ±  4%  perf-stat.ps.dTLB-load-misses
 1.007e+09            -3.8%  9.686e+08            -4.4%  9.627e+08        perf-stat.ps.dTLB-loads
   2158768 ±  4%      -6.9%    2009174 ±  3%      -7.0%    2007326 ±  3%  perf-stat.ps.dTLB-store-misses
 8.475e+08            +5.5%  8.937e+08            -3.5%  8.178e+08        perf-stat.ps.dTLB-stores
    707081 ±  5%      -5.4%     668703 ±  2%    +133.6%    1651678        perf-stat.ps.iTLB-load-misses
    315394 ± 12%     -31.6%     215816 ±  3%      +3.5%     326463 ± 19%  perf-stat.ps.iTLB-loads
  3.71e+09            -3.1%  3.595e+09            -4.5%  3.541e+09        perf-stat.ps.instructions
     87895 ±  3%      +5.2%      92424 ±  4%     +16.4%     102341 ±  6%  perf-stat.ps.node-load-misses
    106351 ±  3%     +14.8%     122083 ±  5%     +13.2%     120439 ±  5%  perf-stat.ps.node-loads
    106728 ±  4%     +29.1%     137740 ±  7%      +7.6%     114824 ±  5%  perf-stat.ps.node-stores
 1.117e+12            -3.0%  1.084e+12            -4.5%  1.067e+12        perf-stat.total.instructions
     10.55 ± 95%    -100.0%       0.00          -100.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.avg
    506.30 ± 95%    -100.0%       0.00          -100.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.max
      0.00            +0.0%       0.00          -100.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.min
      1.08 ±  7%      -7.7%       1.00           -46.2%       0.58 ± 27%  sched_debug.cfs_rq:/.h_nr_running.max
    538959 ± 24%     -23.2%     414090           -58.3%     224671 ± 31%  sched_debug.cfs_rq:/.load.max
    130191 ± 14%     -13.3%     112846 ±  6%     -56.6%      56505 ± 39%  sched_debug.cfs_rq:/.load.stddev
     10.56 ± 95%    -100.0%       0.00          -100.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.avg
    506.64 ± 95%    -100.0%       0.00          -100.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.max
      0.00            +0.0%       0.00          -100.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.min
    116849 ± 27%     -51.2%      56995 ± 20%     -66.7%      38966 ± 39%  sched_debug.cfs_rq:/.min_vruntime.max
      1248 ± 14%      +9.8%       1370 ± 15%     -29.8%     876.86 ± 16%  sched_debug.cfs_rq:/.min_vruntime.min
     20484 ± 22%     -37.0%      12910 ± 15%     -60.7%       8059 ± 32%  sched_debug.cfs_rq:/.min_vruntime.stddev
      1.08 ±  7%      -7.7%       1.00           -46.2%       0.58 ± 27%  sched_debug.cfs_rq:/.nr_running.max
      1223 ±191%    -897.4%      -9754          -100.0%       0.00        sched_debug.cfs_rq:/.spread0.avg
    107969 ± 29%     -65.3%      37448 ± 39%    -100.0%       0.00        sched_debug.cfs_rq:/.spread0.max
     -7628          +138.2%     -18173          -100.0%       0.00        sched_debug.cfs_rq:/.spread0.min
     20484 ± 22%     -37.0%      12910 ± 15%    -100.0%       0.00        sched_debug.cfs_rq:/.spread0.stddev
     29.84 ± 19%      -1.1%      29.52 ± 14%    -100.0%       0.00        sched_debug.cfs_rq:/.util_est_enqueued.avg
    569.91 ± 11%      +4.5%     595.58          -100.0%       0.00        sched_debug.cfs_rq:/.util_est_enqueued.max
    109.06 ± 13%      +3.0%     112.32 ±  5%    -100.0%       0.00        sched_debug.cfs_rq:/.util_est_enqueued.stddev
    910320            +0.0%     910388           -44.2%     507736 ± 28%  sched_debug.cpu.avg_idle.avg
   1052715 ±  5%      -3.8%    1012910           -45.8%     570219 ± 28%  sched_debug.cpu.avg_idle.max
    175426 ±  8%      +2.8%     180422 ±  6%     -42.5%     100839 ± 20%  sched_debug.cpu.clock.avg
    175428 ±  8%      +2.8%     180424 ±  6%     -42.5%     100840 ± 20%  sched_debug.cpu.clock.max
    175424 ±  8%      +2.8%     180421 ±  6%     -42.5%     100838 ± 20%  sched_debug.cpu.clock.min
    170979 ±  8%      +2.8%     175682 ±  6%     -42.5%      98373 ± 20%  sched_debug.cpu.clock_task.avg
    173398 ±  8%      +2.6%     177937 ±  6%     -42.6%      99568 ± 20%  sched_debug.cpu.clock_task.max
    165789 ±  8%      +3.2%     171014 ±  6%     -42.4%      95513 ± 20%  sched_debug.cpu.clock_task.min
      2178 ±  8%     -13.1%       1893 ± 18%     -49.7%       1094 ± 33%  sched_debug.cpu.clock_task.stddev
      7443 ±  4%      +1.7%       7566 ±  3%     -43.0%       4246 ± 24%  sched_debug.cpu.curr->pid.max
      1409 ±  2%      +1.1%       1426 ±  2%     -42.0%     818.46 ± 25%  sched_debug.cpu.curr->pid.stddev
    502082            +0.0%     502206           -43.9%     281834 ± 29%  sched_debug.cpu.max_idle_balance_cost.avg
    567767 ±  5%      -3.3%     548996 ±  2%     -46.6%     303439 ± 27%  sched_debug.cpu.max_idle_balance_cost.max
      4294            +0.0%       4294           -43.7%       2415 ± 29%  sched_debug.cpu.next_balance.avg
      4294            +0.0%       4294           -43.7%       2415 ± 29%  sched_debug.cpu.next_balance.max
      4294            +0.0%       4294           -43.7%       2415 ± 29%  sched_debug.cpu.next_balance.min
      0.29 ±  3%      -1.2%       0.28           -43.0%       0.16 ± 29%  sched_debug.cpu.nr_running.stddev
      8212 ±  7%      -2.2%       8032 ±  4%     -40.7%       4867 ± 20%  sched_debug.cpu.nr_switches.avg
     55209 ± 14%     -21.8%      43154 ± 14%     -57.0%      23755 ± 20%  sched_debug.cpu.nr_switches.max
      1272 ± 23%     +10.2%       1402 ±  8%     -39.1%     775.51 ± 29%  sched_debug.cpu.nr_switches.min
      9805 ± 13%     -13.7%       8459 ±  8%     -50.8%       4825 ± 20%  sched_debug.cpu.nr_switches.stddev
    -15.73           -14.1%     -13.52           -64.8%      -5.53        sched_debug.cpu.nr_uninterruptible.min
      6.08 ± 27%      -1.0%       6.02 ± 13%     -53.7%       2.82 ± 24%  sched_debug.cpu.nr_uninterruptible.stddev
    175425 ±  8%      +2.8%     180421 ±  6%     -42.5%     100838 ± 20%  sched_debug.cpu_clk
 4.295e+09            +0.0%  4.295e+09           -43.7%  2.416e+09 ± 29%  sched_debug.jiffies
    174815 ±  8%      +2.9%     179811 ±  6%     -42.5%     100505 ± 20%  sched_debug.ktime
    175972 ±  8%      +2.8%     180955 ±  6%     -42.5%     101150 ± 20%  sched_debug.sched_clk
  58611259            +0.0%   58611259           -94.0%    3508734 ± 29%  sched_debug.sysctl_sched.sysctl_sched_features
      0.75            +0.0%       0.75          -100.0%       0.00        sched_debug.sysctl_sched.sysctl_sched_idle_min_granularity
     24.00            +0.0%      24.00          -100.0%       0.00        sched_debug.sysctl_sched.sysctl_sched_latency
      3.00            +0.0%       3.00          -100.0%       0.00        sched_debug.sysctl_sched.sysctl_sched_min_granularity
      4.00            +0.0%       4.00          -100.0%       0.00        sched_debug.sysctl_sched.sysctl_sched_wakeup_granularity
      0.26 ±100%      -0.3        0.00            +1.2        1.44 ±  9%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      2.08 ± 26%      -0.2        1.87 ± 12%      -1.4        0.63 ± 11%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.00            +0.0        0.00            +0.7        0.67 ± 11%  perf-profile.calltrace.cycles-pp.rcu_sched_clock_irq.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues
      0.00            +0.0        0.00            +0.7        0.71 ± 18%  perf-profile.calltrace.cycles-pp.rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.0        0.00            +0.8        0.80 ± 14%  perf-profile.calltrace.cycles-pp.getname_flags.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      0.00            +0.0        0.00            +0.8        0.84 ± 12%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.00            +0.0        0.00            +1.0        0.98 ± 13%  perf-profile.calltrace.cycles-pp.mas_alloc_cyclic.mtree_alloc_cyclic.simple_offset_add.shmem_mknod.lookup_open
      0.00            +0.0        0.00            +1.1        1.10 ± 14%  perf-profile.calltrace.cycles-pp.mtree_alloc_cyclic.simple_offset_add.shmem_mknod.lookup_open.open_last_lookups
      0.00            +0.0        0.00            +1.2        1.20 ± 13%  perf-profile.calltrace.cycles-pp.mas_erase.mtree_erase.simple_offset_remove.shmem_unlink.vfs_unlink
      0.00            +0.0        0.00            +1.3        1.34 ± 15%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat
      0.00            +0.0        0.00            +1.4        1.35 ± 12%  perf-profile.calltrace.cycles-pp.mtree_erase.simple_offset_remove.shmem_unlink.vfs_unlink.do_unlinkat
      0.00            +0.0        0.00            +1.6        1.56 ± 18%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +0.0        0.00            +1.7        1.73 ±  6%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues
      0.00            +0.0        0.00            +1.8        1.80 ± 16%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +0.0        0.00            +2.0        2.03 ± 15%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64
      0.00            +0.0        0.00            +2.2        2.16 ± 15%  perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +2.9        2.94 ± 14%  perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      0.00            +0.0        0.00            +3.2        3.19 ±  8%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +0.0        0.00            +3.4        3.35 ±  8%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +0.0        0.00            +3.9        3.88 ±  8%  perf-profile.calltrace.cycles-pp.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +0.8        0.75 ± 12%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__call_rcu_common.xas_store.__xa_erase.xa_erase.simple_offset_remove
      0.00            +0.8        0.78 ± 34%      +0.0        0.00        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_lru.xas_alloc.xas_create.xas_store
      0.00            +0.8        0.83 ± 29%      +0.0        0.00        perf-profile.calltrace.cycles-pp.allocate_slab.___slab_alloc.kmem_cache_alloc_lru.xas_alloc.xas_expand
      0.00            +0.9        0.92 ± 26%      +0.0        0.00        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_lru.xas_alloc.xas_expand.xas_create
      0.00            +1.0        0.99 ± 27%      +0.0        0.00        perf-profile.calltrace.cycles-pp.shuffle_freelist.allocate_slab.___slab_alloc.kmem_cache_alloc_lru.xas_alloc
      0.00            +1.0        1.04 ± 28%      +0.0        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_lru.xas_alloc.xas_create.xas_store.__xa_alloc
      0.00            +1.1        1.11 ± 26%      +0.0        0.00        perf-profile.calltrace.cycles-pp.xas_alloc.xas_create.xas_store.__xa_alloc.__xa_alloc_cyclic
      1.51 ± 24%      +1.2        2.73 ± 10%      +1.2        2.75 ± 10%  perf-profile.calltrace.cycles-pp.vfs_unlink.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.2        1.24 ± 20%      +0.0        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_lru.xas_alloc.xas_expand.xas_create.xas_store
      0.00            +1.3        1.27 ± 10%      +0.0        0.00        perf-profile.calltrace.cycles-pp.xas_store.__xa_erase.xa_erase.simple_offset_remove.shmem_unlink
      0.00            +1.3        1.30 ± 10%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__xa_erase.xa_erase.simple_offset_remove.shmem_unlink.vfs_unlink
      0.00            +1.3        1.33 ± 19%      +0.0        0.00        perf-profile.calltrace.cycles-pp.xas_alloc.xas_expand.xas_create.xas_store.__xa_alloc
      0.00            +1.4        1.36 ± 10%      +0.0        0.00        perf-profile.calltrace.cycles-pp.xa_erase.simple_offset_remove.shmem_unlink.vfs_unlink.do_unlinkat
      0.00            +1.4        1.37 ± 10%      +1.4        1.37 ± 12%  perf-profile.calltrace.cycles-pp.simple_offset_remove.shmem_unlink.vfs_unlink.do_unlinkat.__x64_sys_unlink
      0.00            +1.5        1.51 ± 17%      +0.0        0.00        perf-profile.calltrace.cycles-pp.xas_expand.xas_create.xas_store.__xa_alloc.__xa_alloc_cyclic
      0.00            +1.6        1.62 ± 12%      +1.6        1.65 ± 12%  perf-profile.calltrace.cycles-pp.shmem_unlink.vfs_unlink.do_unlinkat.__x64_sys_unlink.do_syscall_64
      0.00            +2.8        2.80 ± 13%      +0.0        0.00        perf-profile.calltrace.cycles-pp.xas_create.xas_store.__xa_alloc.__xa_alloc_cyclic.simple_offset_add
      0.00            +2.9        2.94 ± 13%      +0.0        0.00        perf-profile.calltrace.cycles-pp.xas_store.__xa_alloc.__xa_alloc_cyclic.simple_offset_add.shmem_mknod
      5.38 ± 24%      +3.1        8.51 ± 11%      +0.6        5.95 ± 11%  perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      6.08 ± 24%      +3.2        9.24 ± 12%      +0.5        6.59 ± 10%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat
      0.00            +3.2        3.20 ± 13%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__xa_alloc.__xa_alloc_cyclic.simple_offset_add.shmem_mknod.lookup_open
      0.00            +3.2        3.24 ± 13%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__xa_alloc_cyclic.simple_offset_add.shmem_mknod.lookup_open.open_last_lookups
      0.00            +3.4        3.36 ± 14%      +1.2        1.16 ± 13%  perf-profile.calltrace.cycles-pp.simple_offset_add.shmem_mknod.lookup_open.open_last_lookups.path_openat
      2.78 ± 25%      +3.4        6.17 ± 12%      +0.9        3.69 ± 12%  perf-profile.calltrace.cycles-pp.shmem_mknod.lookup_open.open_last_lookups.path_openat.do_filp_open
      0.16 ± 30%      -0.1        0.08 ± 20%      -0.0        0.13 ± 42%  perf-profile.children.cycles-pp.map_id_up
      0.22 ± 18%      -0.0        0.16 ± 17%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.47 ± 17%      -0.0        0.43 ± 16%      +1.0        1.49 ± 10%  perf-profile.children.cycles-pp.__x64_sys_close
      0.02 ±142%      -0.0        0.00            +0.1        0.08 ± 22%  perf-profile.children.cycles-pp._find_next_zero_bit
      0.01 ±223%      -0.0        0.00            +2.0        1.97 ± 15%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.00            +0.0        0.00            +0.1        0.08 ± 30%  perf-profile.children.cycles-pp.__wake_up
      0.00            +0.0        0.00            +0.1        0.08 ± 21%  perf-profile.children.cycles-pp.should_we_balance
      0.00            +0.0        0.00            +0.1        0.09 ± 34%  perf-profile.children.cycles-pp.amd_clear_divider
      0.00            +0.0        0.00            +0.1        0.10 ± 36%  perf-profile.children.cycles-pp.apparmor_current_getsecid_subj
      0.00            +0.0        0.00            +0.1        0.10 ± 32%  perf-profile.children.cycles-pp.filp_flush
      0.00            +0.0        0.00            +0.1        0.10 ± 27%  perf-profile.children.cycles-pp.mas_wr_end_piv
      0.00            +0.0        0.00            +0.1        0.12 ± 27%  perf-profile.children.cycles-pp.mnt_get_write_access
      0.00            +0.0        0.00            +0.1        0.12 ± 23%  perf-profile.children.cycles-pp.file_close_fd
      0.00            +0.0        0.00            +0.1        0.13 ± 30%  perf-profile.children.cycles-pp.security_current_getsecid_subj
      0.00            +0.0        0.00            +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.native_apic_mem_eoi
      0.00            +0.0        0.00            +0.2        0.17 ± 22%  perf-profile.children.cycles-pp.mas_leaf_max_gap
      0.00            +0.0        0.00            +0.2        0.18 ± 24%  perf-profile.children.cycles-pp.mtree_range_walk
      0.00            +0.0        0.00            +0.2        0.20 ± 19%  perf-profile.children.cycles-pp.inode_set_ctime_current
      0.00            +0.0        0.00            +0.2        0.24 ± 14%  perf-profile.children.cycles-pp.ima_file_check
      0.00            +0.0        0.00            +0.2        0.24 ± 22%  perf-profile.children.cycles-pp.mas_anode_descend
      0.00            +0.0        0.00            +0.3        0.26 ± 18%  perf-profile.children.cycles-pp.lockref_put_return
      0.00            +0.0        0.00            +0.3        0.29 ± 16%  perf-profile.children.cycles-pp.mas_wr_walk
      0.00            +0.0        0.00            +0.3        0.31 ± 23%  perf-profile.children.cycles-pp.mas_update_gap
      0.00            +0.0        0.00            +0.3        0.32 ± 17%  perf-profile.children.cycles-pp.mas_wr_append
      0.00            +0.0        0.00            +0.4        0.37 ± 15%  perf-profile.children.cycles-pp.mas_empty_area
      0.00            +0.0        0.00            +0.5        0.47 ± 18%  perf-profile.children.cycles-pp.mas_wr_node_store
      0.00            +0.0        0.00            +0.5        0.53 ± 18%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.00            +0.0        0.00            +0.7        0.65 ± 12%  perf-profile.children.cycles-pp.__memcg_slab_pre_alloc_hook
      0.00            +0.0        0.00            +0.7        0.65 ± 28%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.00            +0.0        0.00            +1.0        0.99 ± 13%  perf-profile.children.cycles-pp.mas_alloc_cyclic
      0.00            +0.0        0.00            +1.1        1.11 ± 14%  perf-profile.children.cycles-pp.mtree_alloc_cyclic
      0.00            +0.0        0.00            +1.2        1.21 ± 14%  perf-profile.children.cycles-pp.mas_erase
      0.00            +0.0        0.00            +1.4        1.35 ± 12%  perf-profile.children.cycles-pp.mtree_erase
      0.00            +0.0        0.00            +1.8        1.78 ±  9%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.00            +0.0        0.00            +4.1        4.06 ±  8%  perf-profile.children.cycles-pp.tick_nohz_highres_handler
      0.02 ±146%      +0.1        0.08 ± 13%      +0.0        0.06 ± 81%  perf-profile.children.cycles-pp.shmem_is_huge
      0.02 ±141%      +0.1        0.09 ± 16%      -0.0        0.00        perf-profile.children.cycles-pp.__list_del_entry_valid
      0.00            +0.1        0.08 ± 11%      +0.0        0.00        perf-profile.children.cycles-pp.free_unref_page
      0.00            +0.1        0.08 ± 13%      +0.1        0.08 ± 45%  perf-profile.children.cycles-pp.shmem_destroy_inode
      0.04 ±101%      +0.1        0.14 ± 25%      +0.0        0.05 ± 65%  perf-profile.children.cycles-pp.rcu_nocb_try_bypass
      0.00            +0.1        0.12 ± 27%      +0.0        0.00        perf-profile.children.cycles-pp.xas_find_marked
      0.02 ±144%      +0.1        0.16 ± 14%      -0.0        0.00        perf-profile.children.cycles-pp.__unfreeze_partials
      0.03 ±106%      +0.2        0.19 ± 26%      -0.0        0.03 ±136%  perf-profile.children.cycles-pp.xas_descend
      0.01 ±223%      +0.2        0.17 ± 15%      -0.0        0.00        perf-profile.children.cycles-pp.get_page_from_freelist
      0.11 ± 22%      +0.2        0.29 ± 16%      -0.0        0.08 ± 30%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.02 ±146%      +0.2        0.24 ± 13%      -0.0        0.01 ±174%  perf-profile.children.cycles-pp.__alloc_pages
      0.36 ± 79%      +0.6        0.98 ± 15%      -0.0        0.31 ± 43%  perf-profile.children.cycles-pp.__slab_free
      0.50 ± 26%      +0.7        1.23 ± 14%      -0.2        0.31 ± 19%  perf-profile.children.cycles-pp.__call_rcu_common
      0.00            +0.8        0.82 ± 13%      +0.0        0.00        perf-profile.children.cycles-pp.radix_tree_node_rcu_free
      0.00            +1.1        1.14 ± 17%      +0.0        0.00        perf-profile.children.cycles-pp.radix_tree_node_ctor
      0.16 ± 86%      +1.2        1.38 ± 16%      -0.1        0.02 ±174%  perf-profile.children.cycles-pp.setup_object
      1.52 ± 25%      +1.2        2.75 ± 10%      +1.2        2.76 ± 11%  perf-profile.children.cycles-pp.vfs_unlink
      0.36 ± 22%      +1.3        1.63 ± 12%      +1.3        1.65 ± 12%  perf-profile.children.cycles-pp.shmem_unlink
      0.00            +1.3        1.30 ± 10%      +0.0        0.00        perf-profile.children.cycles-pp.__xa_erase
      0.20 ± 79%      +1.3        1.53 ± 15%      -0.2        0.02 ±173%  perf-profile.children.cycles-pp.shuffle_freelist
      0.00            +1.4        1.36 ± 10%      +0.0        0.00        perf-profile.children.cycles-pp.xa_erase
      0.00            +1.4        1.38 ± 10%      +1.4        1.37 ± 12%  perf-profile.children.cycles-pp.simple_offset_remove
      0.00            +1.5        1.51 ± 17%      +0.0        0.00        perf-profile.children.cycles-pp.xas_expand
      0.26 ± 78%      +1.6        1.87 ± 13%      -0.2        0.05 ± 68%  perf-profile.children.cycles-pp.allocate_slab
      0.40 ± 49%      +1.7        2.10 ± 13%      -0.3        0.14 ± 28%  perf-profile.children.cycles-pp.___slab_alloc
      1.30 ± 85%      +2.1        3.42 ± 12%      -0.1        1.15 ± 41%  perf-profile.children.cycles-pp.rcu_do_batch
      1.56 ± 27%      +2.4        3.93 ± 11%      -0.2        1.41 ± 12%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.00            +2.4        2.44 ± 12%      +0.0        0.00        perf-profile.children.cycles-pp.xas_alloc
      2.66 ± 13%      +2.5        5.14 ±  5%      -2.7        0.00        perf-profile.children.cycles-pp.__irq_exit_rcu
     11.16 ± 10%      +2.7       13.88 ±  8%      +0.6       11.72 ±  8%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     11.77 ± 10%      +2.7       14.49 ±  8%      +0.6       12.40 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +2.8        2.82 ± 13%      +0.0        0.00        perf-profile.children.cycles-pp.xas_create
      5.40 ± 24%      +3.1        8.52 ± 11%      +0.6        5.97 ± 11%  perf-profile.children.cycles-pp.lookup_open
      6.12 ± 24%      +3.1        9.27 ± 12%      +0.5        6.62 ± 10%  perf-profile.children.cycles-pp.open_last_lookups
      0.00            +3.2        3.22 ± 13%      +0.0        0.00        perf-profile.children.cycles-pp.__xa_alloc
      0.00            +3.2        3.24 ± 13%      +0.0        0.00        perf-profile.children.cycles-pp.__xa_alloc_cyclic
      0.00            +3.4        3.36 ± 14%      +1.2        1.16 ± 13%  perf-profile.children.cycles-pp.simple_offset_add
      2.78 ± 25%      +3.4        6.18 ± 12%      +0.9        3.70 ± 12%  perf-profile.children.cycles-pp.shmem_mknod
      0.00            +4.2        4.24 ± 12%      +0.0        0.00        perf-profile.children.cycles-pp.xas_store
      0.14 ± 27%      -0.1        0.08 ± 21%      -0.0        0.12 ± 42%  perf-profile.self.cycles-pp.map_id_up
      0.09 ± 18%      -0.0        0.06 ± 52%      +0.1        0.14 ± 12%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.18 ± 22%      -0.0        0.15 ± 17%      -0.1        0.10 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.02 ±141%      -0.0        0.00            +0.1        0.08 ± 22%  perf-profile.self.cycles-pp._find_next_zero_bit
      0.16 ± 24%      -0.0        0.16 ± 24%      -0.1        0.07 ± 64%  perf-profile.self.cycles-pp.__sysvec_apic_timer_interrupt
      0.02 ±146%      +0.0        0.02 ±146%      +0.1        0.08 ± 18%  perf-profile.self.cycles-pp.shmem_mknod
      0.00            +0.0        0.00            +0.1        0.09 ± 36%  perf-profile.self.cycles-pp.irq_exit_rcu
      0.00            +0.0        0.00            +0.1        0.09 ± 28%  perf-profile.self.cycles-pp.tick_nohz_highres_handler
      0.00            +0.0        0.00            +0.1        0.09 ± 36%  perf-profile.self.cycles-pp.apparmor_current_getsecid_subj
      0.00            +0.0        0.00            +0.1        0.09 ± 30%  perf-profile.self.cycles-pp.mtree_erase
      0.00            +0.0        0.00            +0.1        0.10 ± 26%  perf-profile.self.cycles-pp.mtree_alloc_cyclic
      0.00            +0.0        0.00            +0.1        0.10 ± 27%  perf-profile.self.cycles-pp.mas_wr_end_piv
      0.00            +0.0        0.00            +0.1        0.12 ± 28%  perf-profile.self.cycles-pp.mnt_get_write_access
      0.00            +0.0        0.00            +0.1        0.12 ± 29%  perf-profile.self.cycles-pp.inode_set_ctime_current
      0.00            +0.0        0.00            +0.1        0.12 ± 38%  perf-profile.self.cycles-pp.mas_empty_area
      0.00            +0.0        0.00            +0.1        0.13 ± 18%  perf-profile.self.cycles-pp.native_apic_mem_eoi
      0.00            +0.0        0.00            +0.1        0.14 ± 38%  perf-profile.self.cycles-pp.mas_update_gap
      0.00            +0.0        0.00            +0.1        0.14 ± 20%  perf-profile.self.cycles-pp.mas_wr_append
      0.00            +0.0        0.00            +0.2        0.16 ± 23%  perf-profile.self.cycles-pp.mas_leaf_max_gap
      0.00            +0.0        0.00            +0.2        0.18 ± 24%  perf-profile.self.cycles-pp.mtree_range_walk
      0.00            +0.0        0.00            +0.2        0.18 ± 29%  perf-profile.self.cycles-pp.mas_alloc_cyclic
      0.00            +0.0        0.00            +0.2        0.20 ± 14%  perf-profile.self.cycles-pp.__memcg_slab_pre_alloc_hook
      0.00            +0.0        0.00            +0.2        0.22 ± 32%  perf-profile.self.cycles-pp.mas_erase
      0.00            +0.0        0.00            +0.2        0.24 ± 35%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.00            +0.0        0.00            +0.2        0.24 ± 22%  perf-profile.self.cycles-pp.mas_anode_descend
      0.00            +0.0        0.00            +0.3        0.26 ± 17%  perf-profile.self.cycles-pp.lockref_put_return
      0.00            +0.0        0.00            +0.3        0.27 ± 16%  perf-profile.self.cycles-pp.mas_wr_walk
      0.00            +0.0        0.00            +0.3        0.34 ± 20%  perf-profile.self.cycles-pp.mas_wr_node_store
      0.00            +0.0        0.00            +0.4        0.35 ± 20%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.00            +0.0        0.00            +1.6        1.59 ±  8%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.05 ± 85%      +0.0        0.06 ± 47%      +0.1        0.15 ± 54%  perf-profile.self.cycles-pp.check_heap_object
      0.05 ± 72%      +0.0        0.06 ± 81%      +0.0        0.10 ± 15%  perf-profile.self.cycles-pp.call_cpuidle
      0.04 ±105%      +0.0        0.04 ± 75%      +0.1        0.10 ± 33%  perf-profile.self.cycles-pp.putname
      0.00            +0.1        0.06 ± 24%      +0.0        0.05 ± 66%  perf-profile.self.cycles-pp.shmem_destroy_inode
      0.00            +0.1        0.07 ±  8%      +0.0        0.00        perf-profile.self.cycles-pp.__xa_alloc
      0.02 ±146%      +0.1        0.11 ± 28%      +0.0        0.02 ±133%  perf-profile.self.cycles-pp.rcu_nocb_try_bypass
      0.01 ±223%      +0.1        0.10 ± 28%      -0.0        0.00        perf-profile.self.cycles-pp.shuffle_freelist
      0.00            +0.1        0.11 ± 40%      +0.0        0.00        perf-profile.self.cycles-pp.xas_create
      0.00            +0.1        0.12 ± 27%      +0.0        0.00        perf-profile.self.cycles-pp.xas_find_marked
      0.00            +0.1        0.14 ± 18%      +0.0        0.00        perf-profile.self.cycles-pp.xas_alloc
      0.03 ±103%      +0.1        0.17 ± 29%      -0.0        0.03 ±136%  perf-profile.self.cycles-pp.xas_descend
      0.00            +0.2        0.16 ± 23%      +0.0        0.00        perf-profile.self.cycles-pp.xas_expand
      0.10 ± 22%      +0.2        0.27 ± 16%      -0.0        0.06 ± 65%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.92 ± 35%      +0.3        1.22 ± 11%      -0.3        0.59 ± 15%  perf-profile.self.cycles-pp.kmem_cache_free
      0.00            +0.4        0.36 ± 16%      +0.0        0.00        perf-profile.self.cycles-pp.xas_store
      0.32 ± 30%      +0.4        0.71 ± 12%      -0.1        0.18 ± 23%  perf-profile.self.cycles-pp.__call_rcu_common
      0.18 ± 27%      +0.5        0.65 ±  8%      +0.1        0.26 ± 21%  perf-profile.self.cycles-pp.kmem_cache_alloc_lru
      0.36 ± 79%      +0.6        0.96 ± 15%      -0.0        0.31 ± 42%  perf-profile.self.cycles-pp.__slab_free
      0.00            +0.8        0.80 ± 14%      +0.0        0.00        perf-profile.self.cycles-pp.radix_tree_node_rcu_free
      0.00            +1.0        1.01 ± 16%      +0.0        0.00        perf-profile.self.cycles-pp.radix_tree_node_ctor



[1] https://lore.kernel.org/all/202402191308.8e7ee8c7-oliver.sang@intel.com/

> 
> 
> > > > > @@ -330,9 +329,9 @@ int simple_offset_empty(struct dentry *dentry)
> > > > >  	if (!inode || !S_ISDIR(inode->i_mode))
> > > > >  		return ret;
> > > > >  
> > > > > -	index = 2;
> > > > > +	index = DIR_OFFSET_MIN;
> > > > 
> > > > This bit should go into the simple_offset_empty() patch...
> > > > 
> > > > > @@ -434,15 +433,15 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
> > > > >  
> > > > >  	/* In this case, ->private_data is protected by f_pos_lock */
> > > > >  	file->private_data = NULL;
> > > > > -	return vfs_setpos(file, offset, U32_MAX);
> > > > > +	return vfs_setpos(file, offset, MAX_LFS_FILESIZE);
> > > > 					^^^
> > > > Why this? It is ULONG_MAX << PAGE_SHIFT on 32-bit so that doesn't seem
> > > > quite right? Why not use ULONG_MAX here directly?
> > > 
> > > I initially changed U32_MAX to ULONG_MAX, but for some reason, the
> > > length checking in vfs_setpos() fails. There is probably a sign
> > > extension thing happening here that I don't understand.
> > > 
> > > 
> > > > Otherwise the patch looks good to me.
> > > 
> > > As always, thank you for your review.
> > > 
> > > 
> > > -- 
> > > Chuck Lever
> 
> -- 
> Chuck Lever

