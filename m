Return-Path: <linux-fsdevel+bounces-11418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45310853A8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 20:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4A62842C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 19:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9661CA8F;
	Tue, 13 Feb 2024 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNWl3pGA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B0E1CA94;
	Tue, 13 Feb 2024 19:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707851269; cv=fail; b=HaJDdq4Wc77d/9lrGRoUdrCnUK3TyNYp2zyaWaHq8bDN4EiuyZz3bpfiQ4ZohsGvFIkn/g0PaH1M/fKqPliOQ2ASqkflMCFeIubMM0upX8UFYNkIQCJ7Colb4OUAY/AakFLCQQZaYGwBViT3PwzY2k1N4gUTWqo4dieMRgHdnSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707851269; c=relaxed/simple;
	bh=xjfBr4j4ouh+foOVW5nUXybbssU67fUGH1Tl12BJ4Vc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nyW1If2xqvpyfcjZA2t0NtjfekOrIwoOOeO6TA68OxlwNGXhDHOuPTRudYX42fvHgLPZsJv67vrAMs7CUS5qw3vhulqeTGlTJUyHjSxqzig/J20F92aKTzButbSkhe0skjKXFEuQjzM7VwZvje+sbct3gNWcM7mskkuKj9m7JVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNWl3pGA; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707851269; x=1739387269;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xjfBr4j4ouh+foOVW5nUXybbssU67fUGH1Tl12BJ4Vc=;
  b=NNWl3pGAAnA1QcqvQXQ1ouslnjm9eK3p2pW7+8CflGdc/5zmay24lw5g
   lgtCvPd3+xT0R23Pq3AAs2nXGQu+feDz+21T+osBnEfy0F2YqoHBvYBkU
   K9T/sFi5jT3jHmLV+dcZaLvvwmTHRwoy5ENWfUbC4CF4rkaXuSkY+15uN
   ObeEsJ9omSBMI5XaLB8ROKJDozm/pNJI2dhgDNPaHSt2v4OA7zJUWQjL0
   JCqLWuy5cSln9M6+FI7eCZRkuI0X2Fl5SyBg0FGaZ8TCmtWTHjK2dcx7s
   gymcQ9nCchfQWWRgtRtrSp2fuahzymtwcbVxDWBSiGcZblxcVBf2sz2rh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1756396"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="1756396"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 11:07:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="7584948"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 11:07:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 11:07:47 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 11:07:47 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 11:07:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6BmwhAs2EX5GhJTtA2Xhbk3/5M94C/1R13Eorfx/yGLc+ULE8jGmOMLzCAZ7JKWCf9z3zDHBo2evBliCbeEnCtVubp+2bZHS5REQxCdEIBkaayv/X3lt2MUmXMmQcMQzZWlpAQsMgkiNjnO/Ljo6ihecQqoZnAddZ3B94v6Sy25NWrCkXS7NzNqQhDijeNWPSlGEYJdbxmMBi8/2VsBIKJ9ESyvzjJfLBd8cRMC1It3YUsfJO3c+svMAQGKtRevbc7qISeuDqTCGW5nlQ9TsXah8QhAv8keSKY6sjuFoTEQ3PGhCAULiY2t8xk2Yv8vLVsaGTEv/tnN/PFdfmkiuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNhb5KOoC1Uj0BDnRgE87gVPUBfebv1GfG0Cj0ux0h8=;
 b=CtW1FMpBN79/y5pAg3DkyDtJKR+RUVkXs6WSudnErRAvbJxe3+58bAFphgkGAiXxLR0fTGMmj40j9DL39ivKXT0nC/7vIOYCGWctA7WSHKc6DtoEsDzspbvurXgXgJTttLz6vnORM0gq+GCeDkaJB74qdaVNn1nsI2ymsNCN4wR8y1NoAczmRD/rWOfyq2Pykb5h/5Odo34jp9SHTEzxli9IQl7N9Z6Usast0KbdreD+eWud1xbO7Ehezt6RIugwPcKqxHax+tm5RO/eKBSrqIQeuD4iJjBra7Gp0h3pz5bREhdQKMRDWow4L6cs2F5NpGzkPkm/uBTZcyrSm6tIOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5138.namprd11.prod.outlook.com (2603:10b6:303:94::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 19:07:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 19:07:45 +0000
Date: Tue, 13 Feb 2024 11:07:42 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Lukas Wunner <lukas@wunner.de>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>
CC: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Dave Chinner <david@fromorbit.com>, <linux-kernel@vger.kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>, <linux-arch@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-xfs@vger.kernel.org>,
	<dm-devel@lists.linux.dev>, <nvdimm@lists.linux.dev>,
	<linux-s390@vger.kernel.org>
Subject: Re: [PATCH v5 1/8] dax: alloc_dax() return ERR_PTR(-EOPNOTSUPP) for
 CONFIG_DAX=n
Message-ID: <65cbbdfe19172_29b129476@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240212163101.19614-1-mathieu.desnoyers@efficios.com>
 <20240212163101.19614-2-mathieu.desnoyers@efficios.com>
 <20240213063226.GA4740@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240213063226.GA4740@wunner.de>
X-ClientProxiedBy: MW4PR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:303:6a::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5138:EE_
X-MS-Office365-Filtering-Correlation-Id: 17881b32-effb-4449-9e1f-08dc2cc70f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HUojAbJ+CRaO2WRuXtmBtYMitJt3WJM8DG5jwVkhKM1hEHRLCi0Ri5UJD9UgBWr5IKcgyg9l4K/PzjWcrhMtmV8U92bK6EZ8eXuV+yj+IwQAivtGEq90h50BUHqdIFX53hxgB7HDgBc49qp7iu193OILfbsK3KVX5hwRKlAE2N4uP7ooXRWKcPOq85U3jIC/RjyE4Rn/7nf5tf9LtpUx9Z5gqXIHdWIRnimue/9GCSRm+iiEff4s48MCQ/pfTS2yF+c+awen0a8X/Bj07tZFQD34CsWiE9Pdkn8M3H0MANDd7I6iUy9kzUJJyB6h3rPh3j872bwUxABkyBAmh05Ht8dZzV6DD2Mb/gNcBkDwAPmto76P24M98SkloNg4P7owelgDyM4GhA70Ol8JugEgYOHnDfg4pEj/PxsoJLiPVEiI0/FGwH1DJDTcPC9ABSXYDcDQjLC0+yH0/Rraw5wXQ+V/ZfuNugxVhePJ9TYxWIak2JXXTKuGEyLHBNLmfrbKfajN9iZRy+gzp43m3HenTSbRR88QYNLfHQeO4Y9eOto5qh0K9B+aS57kd/ETXwOG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(9686003)(478600001)(6512007)(6486002)(41300700001)(8936002)(8676002)(5660300002)(7416002)(4326008)(2906002)(4744005)(110136005)(6506007)(6666004)(66476007)(316002)(66556008)(54906003)(66946007)(83380400001)(82960400001)(86362001)(38100700002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Q14BU0s3KiyA+YTU6bIabCvLspWMM2p3V04k6mUrUtYV3c+AJCHPJ2ezMeC?=
 =?us-ascii?Q?lwElHNOTXtxUBW/g4dpc13bgHcNNdvAUhrdnG/G52+U0I5DIySuaCXokzaWF?=
 =?us-ascii?Q?/qAt9SoQ2Q7wEXjJ4GgmM8kaic4gc58u9Cvpq1acdDrb1iJgO9KqP25E8HUs?=
 =?us-ascii?Q?WKGAwd4hOc2HLQf18YjSbMmQhmMfGtaaNO+PGESVHBqqziqA1C5pFTJcX7dK?=
 =?us-ascii?Q?CwK9wl7ir7qrUP5Q5tg3fAJJbkAkHMKvEHu72EUGHP6BN3oTX84rkRVqSlve?=
 =?us-ascii?Q?lAAPx+sLIXUJ+InczmeKLUgNmvAmqvgxomHccCF1wS1UlnoV45P6MKZMty7y?=
 =?us-ascii?Q?h0ZthV5v0yZbBZZ1GpXVeIQja3DPsrBrBEj2klX9ynzEGxlj+NaAJcag+RVd?=
 =?us-ascii?Q?NfdrswHRt4qY3vqOyKOH5S9+4pJiP6RFyeN0Cht3SxGhRi+ozTfT12L3aDrA?=
 =?us-ascii?Q?d8Gw8xotbLLIAfbqxW+PAwaP4ApnAGhCb/5HtC3i8h9acBU9ChadqHpPOKHj?=
 =?us-ascii?Q?Hwr2nY+TGxtEZZkY9F1XULc6ZkD+yFWhSwYzutmgayzKemLoTC0v2KzJ5NE+?=
 =?us-ascii?Q?0/HwG7KnchAv8jvFNXQmYMdNcGI/MRXkgS5DmpnC0MKlPxLBjtctQavAK1pR?=
 =?us-ascii?Q?8F/Mqm+jQyAWsAaMHhvRbWAHXzUHJW2nxqF5bYYGKsJxXacDmThaVZxygoqt?=
 =?us-ascii?Q?JeGZKx/+Vx+Ab8Abfg6mU+5lPKwUsgeFFPhSqGQI4ix40bOqXZmun0Wk7Fo8?=
 =?us-ascii?Q?BBPiUDb1tXWrbU451e6dkYIcUdh7pXugw37cFW5JOWzGqpjdDq4lm10J6UAa?=
 =?us-ascii?Q?W3jy/r9BDDYu6phW16opayb6IMeFew+0swrGHlF7NlGfGyfjg4cl9joffbEO?=
 =?us-ascii?Q?K5MEBV9rao/DutgW7iuXp2EvOdaYPsRB81cYSIDt1x4j14veFsIfyd8MY51l?=
 =?us-ascii?Q?YbnZuWYljNdAUIr8mhllSIvDfqtnfED0/iA7n/Hhdm+5dQke1+kkDzeDPkIC?=
 =?us-ascii?Q?6GyDOfEVpjENe5oIJ2N7YY27mhFhZNGrZpnM9/fqjiZWDNmcww16q3xZPAO5?=
 =?us-ascii?Q?c9A1wVKJP7X6GTPjOFAEXVODap29RpfOrxhLWzqtZeN9aAouOR+NBNR5Xx+/?=
 =?us-ascii?Q?pIj/t89gY6+xalVp8R1XyjnHfSiI2CNpfPYNmFlD+HLAjGwpN4A44xBqe8EM?=
 =?us-ascii?Q?fU2ZNBfIk7Hv8poBtKp1zhXhNjF5uLny/eYbNUOj7eEo1m/Y/Ycl5AgxpMy9?=
 =?us-ascii?Q?j9d5/KH2Q6MLrOJfXiUjRomzc2jes2oXEGk+aG08DBKcy7NKAJcY2RfLGl+L?=
 =?us-ascii?Q?QGrU1nV2r0yv1h6FeFvVcWKJkgltRl0c67NnY22bzIeolgznJBYl25patMy0?=
 =?us-ascii?Q?x49tyT0vlOnusXZDm62sg7LT/fibk/vJDV8k9gwOyylakXXpzy7JUD7UnoAl?=
 =?us-ascii?Q?uSePNQWlQmEclRG0NqycKG63oUyGcastPJRJLqnVdywmOZotMcs+SgL03tBg?=
 =?us-ascii?Q?/oHIrsGcXYMFk8shnP3ZCcwBaZMYhd64WpEVvVRS8k5BOjN+/kaJ08cgN62s?=
 =?us-ascii?Q?i8sawNNol6xDONgzOpKRuGUO5bCeZu3r9iJg5O1/9G6Ghm/2Dz6aSivqRSEk?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17881b32-effb-4449-9e1f-08dc2cc70f65
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 19:07:45.0567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TEeTi2558ZC4UAY/WplHee0ppzbS0EtLoqSurvVUEXrpPawrThA3tMmQbz09bPcvLMr4Ud2egruv8+kEXDSQ1MNDn50I6oHjU8UHpuqIVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5138
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> On Mon, Feb 12, 2024 at 11:30:54AM -0500, Mathieu Desnoyers wrote:
> > Change the return value from NULL to PTR_ERR(-EOPNOTSUPP) for
> > CONFIG_DAX=n to be consistent with the fact that CONFIG_DAX=y
> > never returns NULL.
> 
> All the callers of alloc_dax() only check for IS_ERR().
> 
> Doesn't this result in a change of behavior in all the callers?
> Previously they'd ignore the NULL return value and continue,
> now they'll error out.
> 
> Given that, seems dangerous to add a Fixes tag with a v4.0 commit
> and thus risk regressing all stable kernels.

Oh, good catch, yes that Fixes tag should be:

4e4ced93794a dax: Move mandatory ->zero_page_range() check in alloc_dax()

...as that was the one that updated the alloc_dax() calling convention
without fixing up the CONFIG_DAX=n case.

This is a pre-requisite for restoring DAX operation on ARM32.

