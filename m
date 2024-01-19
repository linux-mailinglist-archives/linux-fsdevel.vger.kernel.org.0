Return-Path: <linux-fsdevel+bounces-8283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F13F832334
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 03:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A865285661
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 02:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E381F137E;
	Fri, 19 Jan 2024 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WpW5Xw//"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E451362
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705629593; cv=fail; b=fVvuavahRIOSX+jTC6Q8yjxbhiPoWL219isYN7oaiqH+r0RHV5kJvPXJSMt3G4xYMTAdkT6PPIs0WuYVZ/dV4i7SNyHmdH+5cH8a4upduX3CWt26Y9NrwuHt0Mt/PQicbOYF0oNYHgQcYigX0z4O5SnWeXOOS7bTWZP+VqeVxj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705629593; c=relaxed/simple;
	bh=it1inFJqpHUYOB64vttJg/3xKoIvXoFSXx6samivFoM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BsSjcydFkx07C5KGMwuL1ag3psnVDp2rXT4aRFsgezJ6dMwe1e1sTuTy7CcHNUFTBX5CidQX9GIIGIj40Eh7e7b+ZrhIuPJz3s4s555MNlSC+FGqSMs/F8jpOv/vB7iRPUyOiEk9GSjD4yGCC8IB6fhCliw7gw/Ud4IP0zQKRPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WpW5Xw//; arc=fail smtp.client-ip=192.55.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705629591; x=1737165591;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=it1inFJqpHUYOB64vttJg/3xKoIvXoFSXx6samivFoM=;
  b=WpW5Xw//A/pJYIgK4o7UzboOj6ECkjGIxH4JjWuBA9ciwSLe6rKVauuP
   s45X8pZ8MAWRB/ympeLxxDKPgVKAokdNnBa9fWjXjmRsn/L5EmEk+PVRf
   FutjmN45MTptRs5flb5sv7wsz2bZPtCLuMBvIJlKGSs7Jlg+6I/Huuezr
   DB40m/wDAJhtmC7D6WIf/+eSiL5FcYLvFAeaQ6yTgiXBP3cgSSTycoBKs
   ur7jqj9GgscyCPoBAmzylVhFUoWpKDpttf8NNgbbleIywdhWafnzHt90X
   vKEuVKVh1sXu7FtsY2DMxstUzEOTzD4AmELSyhnHY93ON6Yk+EYsOY3ab
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="486785125"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="486785125"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 17:59:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="818942676"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="818942676"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jan 2024 17:59:50 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 17:59:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 17:59:48 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 17:59:48 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 17:59:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZI4SyotIVNlmBTcJxiRKZqoZeqtX+Vj8RdwOBc+8cj3w0r35HGldMugfskXipZnbJI3AdJmaeOpvxTmLCEfA8c99d82oSc4n3Q9zqnwP3dbgBeLhehtwYhw6TD6K7XQsSMpbSjMDikryHEkxBeIEt7Gap4BgStPhqIIW7X31po+Q2K0ZPcHC1/MAw66AibOJHK0QA/H3j2eY7k8cfk/j+/fso0p1xF0o7Uf8JMXLkW/91+OFztvymro/nuUMIsKxEOcdvuMjS3P0h5w5RNpe8iuZie++5sanNlgA0MwevAeTa720vGMyGV9pHqoHn4hiNpFwt7WcPSuKwQnDaTaaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyZ4zCt7SSY5XghEZS3jnO8gD5sJj3QsvpiBPbCNnWI=;
 b=NUCOoloReAgxLoyBszAXxedDVJBp6uXCpbowfQveIsROwJJ6p/AfMlHW5ahzaaognfSB4GpKYra7Dn8RVqe7eU1UVERtuoWmWXRuk+llpgYTpwGHcws37fXbn82rkse94E0FfA/bmKfjxt4X67c+XRAfL2m3jltCitcmr2vpqAR5eYpxBgncb3Epg+oJHCKRwZPSjECgRns1WkEO5wimkHJ9z97Q2ByjDpuOYrAua3NDOPyGFZsaFOF2XIj7DIRmbQruaznAYb3oG9YhDQ16H3Xwg9B921U3VfB90mhLHDTgJ4/UrzthC8c8VJhRUgHk1OiVkbNvziYO87nySj1wmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV3PR11MB8483.namprd11.prod.outlook.com (2603:10b6:408:1b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 01:59:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Fri, 19 Jan 2024
 01:59:46 +0000
Date: Thu, 18 Jan 2024 17:59:43 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <linux-fsdevel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>
CC: <dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>
Subject: RE: [PATCH] fsdax: cleanup tracepoints
Message-ID: <65a9d78fc1ff2_3b8e29413@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240104104925.3496797-1-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240104104925.3496797-1-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: MW4PR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:303:8d::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV3PR11MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbdcde2-8de8-4818-5ff1-08dc18924f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cjHDMqFRH6fhxlr9rqenYqiP1f3TizYgec/0kspOOWrlRf3HNKUjIgc7iIlNTMtUpieWHrKYsN4bWDokoyTc1PgrsWLNCo9R7ib32OP6m1I8iasqlre61cjWxdKcVgFn190j+2kqwq8nRmkAkotWjvSVA3WT1vcwKym4LUWZqGSLBENtFC/OgZE/1SWapjg8rawd5XQutA/xgMS0kKfiPAnV2H2VABHpmwB+9QjlVrmRX8h+WyL1tVbzE4n/0c5FJrcRCM0o921x2ZcqWunIvYyuJcfoiW9MrPZT0jQ9qhXPYChcgI98C36nLvLhJJ9yiAlMiolTjCTFaV1fLcoB25cS4qgaHrEDBzYwf8CfD+tBG0dxoG8u2EIwzfC3T1Uc4Yjj+fwUDwAC2lEZD5j6+Pagi/6LzkZMUkaCvSNTyMhiF5BSk9s2WJjbx1Cr+MbAlSVZtj9WdLIsiqeQsRzYJCaJSd19tRv8STBdpgeDXi3qeE82ZLAujNvFn39jiHbHkM7I08iCuMTyQr/pYzXz6RXHoNPz2ihyDPK13fq6nYb/oDdmN+tINWqQ7I92AmER
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(366004)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(5660300002)(6486002)(2906002)(4744005)(478600001)(8676002)(8936002)(4326008)(86362001)(316002)(66946007)(66476007)(66556008)(26005)(83380400001)(38100700002)(82960400001)(9686003)(6512007)(6506007)(41300700001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RJuBB6yp7nhjza35N0rQNA2o0y3Kd410LPQunEzW8zBNz0uiw3lSspSHhF/E?=
 =?us-ascii?Q?WCL8mTuUz/eBzGlxSofKyLtt9k8FYOMCry7214FpssYMVBTG/reRNFeCbVAC?=
 =?us-ascii?Q?Xcbpoh2dUYmMpCmMrL7nsYQFVFmgxtFm6xxuVhbmhPAa8FehaDaYpZTHEfwW?=
 =?us-ascii?Q?eWeQQenkSbfVI9hAPeDA9O0K8pJm1sjvfIF2eCij+h4Ka8rYvsSLnJ2jRM/W?=
 =?us-ascii?Q?/iI5KH4mw6fQ6x5ZbJ/qTahE2vos432TSQ79Eu/r/ZBd45cJJivqooIezQi/?=
 =?us-ascii?Q?TbZ+qgYVq+58AOZ1w4miZ1CHP5SzqdDEGgQRXksysq4tP1PdLyak/XPMJjTU?=
 =?us-ascii?Q?LryDXx9mp6ySDpsghxLkhmM1e5GobMQI/pYUEKAkcXmoKwIiolHmgEUHJ0L/?=
 =?us-ascii?Q?D6/zRDi1oYJwbErKY8JIvYjqEGQTbDxSVNnVUzOCZklO4P3tIkSXIAaCgCj1?=
 =?us-ascii?Q?qVljMoiRe7+CYho1iOkJMv4EWEgsadRYZH/RVnzFSJgwS2CjcyEFJedPVfrC?=
 =?us-ascii?Q?faF92LJTvTgVMGoPp/CKtQKbjdqnzFuI6xdWdG0sC7TTzysUJao52kalOOnf?=
 =?us-ascii?Q?GVZQKMTr37mbuCyK1/xq/vKkPrhpRIySyYJxIzcENMyjeGM35UkLab07SaKl?=
 =?us-ascii?Q?dfDagwn0iPG8ajV5K2dd6Ns6cbU5FwwhhLlx63n2c84pGTyP9nDqs6bMRqFN?=
 =?us-ascii?Q?9v8YxDBEqFxDIaF0IDjRl3HCkYWcQwzhHju/ZIBYqN+XlELNpdzYkcX4QLIx?=
 =?us-ascii?Q?v8Ft5d4jqyieUFHlfAbr2pEm/YeJfvO6zdxZkS5U3ntRHsN/RmGFNexJ5aAB?=
 =?us-ascii?Q?sTyOqbA/Mz5fk+9KuDy13u6JOHU4Vme/Uc7+YrvQ2skuVHbb8PZsGYs/CmHc?=
 =?us-ascii?Q?v2r7D/LIr46oDtEy5vy9aG0THcyCbsD8b+fsQbvx6JJBDkDuDQwrGbThg4d2?=
 =?us-ascii?Q?4voZWB0Swq5M1mLRadwzC9X7h9/5q7rFOkfKMzSesGxtZRCXjZ7WHTlq/5C5?=
 =?us-ascii?Q?UuXCdREIbiYDgJVBg6w6G8ksr9NjxNtnbq3hJZXtlhGBE8PCvMWooaG6QrfQ?=
 =?us-ascii?Q?NoPVo7HR0YTLIXpDo9G5W+6TQ2wtjBOyhNW3UVj2TnCQxEndtSbFK4ZwxgGM?=
 =?us-ascii?Q?0KWPfY5upqFhERxJByvo77BqDWxzIwC6Cz3t8CSHwYnkR8aih4P40UWLGTwM?=
 =?us-ascii?Q?YZwWLg0cKd+bg10r+2JPZWMPOB0Txkc3FBq27bX5p92ePn2DvhhUBtBErP7s?=
 =?us-ascii?Q?y5AJl4v7uAsTKN96pQ4+4cRi44V6tveLVqK+HpiiUdu81CTfhbt99Wy3OnJ2?=
 =?us-ascii?Q?fRWtfIe0j51UProUJJiOFpqy6Ny1LHrjSEpC7UbB2S7o16t0yhACjh6VYU0w?=
 =?us-ascii?Q?wgjoOrUyIaYqVVC1p2zfkUI8zMZaeqt6P/Z3WD2M7rukqbpVEJ45UVttzYAB?=
 =?us-ascii?Q?ghShG8daB7Q4405DO866+HwCIMma/RYiGx4Nrurvwb4IFDABjkvrtJV/yedv?=
 =?us-ascii?Q?/aTZUogWA5OETAfTSqfu1/KwHuGax5jRT8CTZcArcrJFc3xHsbk9ABFrKEdr?=
 =?us-ascii?Q?hasPJ30iA00S7AR5ItlgvFYxYorxMLw6jEb3l7Cb1Mn38ebVne7SoiGBKHt8?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbdcde2-8de8-4818-5ff1-08dc18924f7f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 01:59:45.8827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umAIDQD2Y6mCizT4Mpx0pMKHnj5U5SoxDtN5GaB8O0AsIH2mPk/D3H1YYLRKS+PyBXZleWTskV61UWBqqFPPHnlT3h/XQHrbRHzs/MAEMAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8483
X-OriginatorOrg: intel.com

Shiyang Ruan wrote:
> Restore the tracepoint that was accidentally deleted before, and rename
> to dax_insert_entry().  Also, since we are using XArray, rename
> 'radix_entry' to 'xa_entry'.

The restore tracepoint patch should be an independent patch.

As for the rename I believe that can potentially break peoples existing
scripts.

So we can try to change it and see if someone screams, but if that needs
to be reverted then having it as a separate patch from the fix makes it
easier to manage.

Effectively, any time you write "Also," in a patch that is usually a
good sign to break up the patch.

