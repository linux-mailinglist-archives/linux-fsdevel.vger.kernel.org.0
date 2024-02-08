Return-Path: <linux-fsdevel+bounces-10840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F79284EA8B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C464D1C22B5D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 21:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AF54F21F;
	Thu,  8 Feb 2024 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AzNcu3iP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E2D4F1E9;
	Thu,  8 Feb 2024 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707427964; cv=fail; b=B0zZ+ippXahBGtqxUGlkT8hYOITuwiO3dFNPckqpAKyZbI1Fw4+kvDGLUWwVoz6dvGW8AeFgtq7Ar0a0i71zlC1fUyZjGlnqRbi2FpnM1+KWNQTaZlEotcaMDH48eUtQ6aMyYS3mnqqvUuQurrCOSVwdtGUMDqgj0D2tywYgKG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707427964; c=relaxed/simple;
	bh=t05tgDIF3F+3N9v3ziAVnBQ1b3DTknlVGbRgn8ieBFo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P4AX/7YoTt0YlJz2K5ZhUEvukAb3+G7wcEM12FPWD7GSlLDMuiMF40tcSaUdn4fJkUYmMxXzkXRhpMs+ezlR0iVljDwBwqiTeM6/tOAtjvgRGJyBu+tqj7rF9Lsyh2AXzoj88YCXYw5mWIHEVLfivgpCTddv8WN2f0uykUD5rZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AzNcu3iP; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707427963; x=1738963963;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=t05tgDIF3F+3N9v3ziAVnBQ1b3DTknlVGbRgn8ieBFo=;
  b=AzNcu3iPSkNITkV9wUz29vZKDFQ8q6ap5Yfzz5um57l8Fzjh37peJXHz
   fv+tz2IwVZseqYOEeypzkxIr2ckPYMsqAMWpMyTKD2b2hBUlsYjyK66o7
   nHyiktP3o14BucpagCw20VXc5P4+T+VlWm+NKLJlGge7sMrxSkMeeMMwC
   byOAyNoZN4+Z9JG51Qc7OTA/zf4dLgwXFW9f3sXzFZsC5rsZysRK3mUce
   TaynZkC7GjuqL6ut6dbLxVBXsVAC1KjgprOODTNnXQEpAysSwg8S/2yv/
   AZaDWx5hbzBKHtEf898WiXch4T24Z2GSy2PbPd/4UP/dkuc+A9gYrEg02
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="11970554"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="11970554"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 13:32:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="32842887"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 13:32:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 13:32:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 13:32:39 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 13:32:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLTH3H+0gp9bwKtOpyzMoJxEwxohfPW4JiLPmGoTUeI2qsKB2M10L/wwZ9fQ2otMJJbdxAtMZkN16QQg3TrWUJ1dzdr1GvFswG7vZjfM8C0iHB0KNJvN+/E3aJEPeSnlJiKn8agr0+FB6A7RfFvkl2vyPowON1GIRvQsmeV6wYy5b7DuKobbrPkNx6kOYRGefNbUwKQbXW63CmcBxQP817sZP/Y6qW6DOd3MNI0I/E3hXIPQe3cRqN9MWr/RoRTYA2IZ6fxYWcdzMT57hmuQy5ndyNEW+eNI139Szca0e6vkw+spsJGq0GWiIKO9H08gi/Dk9sbghF8ZRoJy6jTSww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1uPblKe4ZVHMP+Yri96qK5p3zVUdnu8WEoFwjYqa/8=;
 b=EDb5dquZH06tWZ529bltIm8gOYV1PCIVLXSbl9jjXI5Fn06o/kT1lX0qQ+jLrNcKvDwNOA+i12HnogWX/VzibqsZPNJBM1ko6HSN+9OKqHW1TMKBmZiFAX2JYrMGz7yPLekz1Kno3r86CYMkFI55ABODHETlDJ82TLgBo9Me/BbSoP1+hHgD9+dOZ7EiWAw3Itbe98/fsEjQN/bugLir/nzS9mlaEUwBhUbgHv0qUVp9w+k5TiYWI1DrBn7XGPjYlsfQP3KTUo+1pF9bMEb1oT82mDIzwNidgUqseDaZoeHntcT17RZ//OnoNPPtqn/t10qa3cnvgmku3Ds4sxk6WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7271.namprd11.prod.outlook.com (2603:10b6:208:429::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 21:32:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 21:32:37 +0000
Date: Thu, 8 Feb 2024 13:32:33 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dan Williams
	<dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>, Dave Chinner
	<david@fromorbit.com>
CC: <linux-kernel@vger.kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox
	<willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
	<linux-arch@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-xfs@vger.kernel.org>, <dm-devel@lists.linux.dev>,
	<nvdimm@lists.linux.dev>, <linux-s390@vger.kernel.org>, Alasdair Kergon
	<agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>
Subject: RE: [PATCH v4 02/12] nvdimm/pmem: Treat alloc_dax() -EOPNOTSUPP
 failure as non-fatal
Message-ID: <65c5487174fbd_afa4294e7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240208184913.484340-1-mathieu.desnoyers@efficios.com>
 <20240208184913.484340-3-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240208184913.484340-3-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: MW4PR04CA0054.namprd04.prod.outlook.com
 (2603:10b6:303:6a::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8ef2f4-9f32-4449-b1ad-08dc28ed780e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XG8DM5nSkisBILcJ+Q8vspZGhoKNv98Tn++orpVMfnIi5AEDwCxRkeVMuAk7zHkjRKh6MIDkC/Bc+1s60dThwOT4r5tzPEZKlJXENRuqCuL9lBe4q7GOtNtqN/NIrURqDcBYHp26I24P4CymRTZ70p3pfmIxZrYdPgCMvN6PWJr4oM77+SL0TL5I1TeT/Yhq4x6IHuSv7vXv0KbJW9a/CybE/2GWgyVXdQh7GBtwTBcyjQBZ61I2k37BmEGUxrG4GGGI65+Ey38KdviitlBFRoKM95sPmFYFAK/fU9Y9Jxf4KYuYA11hOfAfX5vIJN0wpsCuswcP5oH2sJuV9ZVr+diu42+bNngmW07tnOYM6r+aq/pFKPp2ItoZmHFN/eFSxsnwoaj1yOy8PPR51mHutYhf++oD38Wk/wavtYPzNkplflf0ZkBfrdjYbgsKrvCbY72O/a4Un0X2yTOuWvEX741MhuUMqpyy/FcEUALsAGmQ1Z+W580O1XlVrikaGMwzyt0fQziE0N19oNx3Ud/VqLjWX9tHAtRlRreMl0ONQGkOraLzpD17WIjL4sLKNPdg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(83380400001)(38100700002)(82960400001)(41300700001)(316002)(26005)(66946007)(54906003)(110136005)(66556008)(66476007)(7416002)(4326008)(8936002)(8676002)(86362001)(6512007)(9686003)(6506007)(6666004)(5660300002)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ES1ho+1IvecBJGh91RYFO6LDE7k5wucevZlYUhEc1QQ+uskPPNrjZ6mgmt5z?=
 =?us-ascii?Q?A7evKljokx709+UnDAT3OdXzWFdwovZPkJ9Iou3MABpS3lp7f2Gb42cMDICy?=
 =?us-ascii?Q?ZowUBN/lYO32HYKEwHEsoo6+6OEgmUpExUpBsztIySrapOqOUBt7Dk+XR72L?=
 =?us-ascii?Q?G6tlWfiSRl+jVNXZQnPN1wHUBk/xUK/SCcfvIOf1t5DAI52oeHcASAxWxNQz?=
 =?us-ascii?Q?vUJpuF8RA8q7yr6vb4Hom7sa/99IJ05SEIuhgBg3UmUEwV0r7jfnr5uhK2cP?=
 =?us-ascii?Q?XyWGh7MXDgX4qPjp9MzI1i7v4L4gk0mU2smYRK+UqHXZsN8ax0PpMmyR7MVj?=
 =?us-ascii?Q?a9DYmzb+mz5nqI7ZL85ymXIiZStjLdI6ycoJ18EwfSIx85+LexIIRQv0BuHr?=
 =?us-ascii?Q?nH/BBVo47RslZCnyVZBl9/iXJAMMkNjopT+nwmQon+jYg4fhs0cpDIMjqBFs?=
 =?us-ascii?Q?RX0Wq3sXDIAwrjHcA3i+701B6qRggS1Tl7zvxffnPjHeEqYSqbmXtZ/hOmkO?=
 =?us-ascii?Q?83nl9424xVXhEye2rRcVRWcqr+TDCnORYzgTbZidTXaGzV2sufm2gUsVD2Fd?=
 =?us-ascii?Q?taP9Cvfygc1MbLN2cDx+M1tpiqGLe9T1w/QYMFu9eI+/GrWmm8C6Xq0OD5Ox?=
 =?us-ascii?Q?y+JeoFQqEWcH+xRF76le9wwY/vwWg4cj2iZqtJLBUJRxWEq28IdCSCGJs8wc?=
 =?us-ascii?Q?w1OWqDN/7ebrd3lNE1Z9OniQ0cRUqqpHqwKqbgI3a9/LC+sbjQVFPNSMh1UE?=
 =?us-ascii?Q?PJNgomoWOB85/g5H2MHtrdEzjUbrx6q2BkKT1r5x/uivNYtBEyanBt0PG6X7?=
 =?us-ascii?Q?K1wI66t6vVuMyv1QSp7BNqecICD6MaACUfqe0cmP5PXcAoLnstY2T2jKdKIC?=
 =?us-ascii?Q?dJCLBIR0m62/3/VysjZAKGjpdch0duL5Ws6AKJ2MAg53O1Aux7N7MlBKFXmW?=
 =?us-ascii?Q?6qyX97J7aOptKlKQ2qzS/79jrqxtIj4HsH+ImMvZIcSS0j1Oa51L5uQJj8Pb?=
 =?us-ascii?Q?3CEl5WhESdGxXcpVWRkISctDy6sQiUhszVJ7ZeXYiEsnDGz4GcCW0kmSRsDd?=
 =?us-ascii?Q?0No7q7vrPWFi0zL5cgZT75SkW4ZcZRlBXccbWAU+r0VfSJPea79DeyB7oHBa?=
 =?us-ascii?Q?2yGZT5tFyIZyT7yUsikATRPsoKjr3sCf1LcvD16p5eozUDwSDrJPT3TRx1qs?=
 =?us-ascii?Q?nIzTIckJ9lNc5fQgJvSf0H6en7wfQ4Io0O5fHI74jcmCUblljRzdR0HYRqCS?=
 =?us-ascii?Q?Ux2KNxAFkgxOT6VLBPlG7FV1Z8d7gf92rIoGRwE+WZhqRIbE/FhJKtMda4dQ?=
 =?us-ascii?Q?+PLaRX35ooGBexdtvROYnR9lleRp23CMRJ49ZdTy7Wyj/KhINKn4KCqd8MuZ?=
 =?us-ascii?Q?5a/LOajnKOa3qzCCIuq5ivSv220MQ+BPSGG5g7aSt8x1kF+y+ottp5gitGAD?=
 =?us-ascii?Q?dkY+hgDpygkKIA778qLD788qM+TG1YElej/3t1nBR4bIuG4nXvSyh2+xLgOu?=
 =?us-ascii?Q?lffTlJ9ANxhAIMkH/ViUnmI27TyewFF+lDkIfg7DHjQ4aL3pr+Gxpn7AxIt5?=
 =?us-ascii?Q?bli9eMxZzbCA//4gokoU1EGkK1HnQR0HmNHrN7haSXT/SeC79K1zJvfD82Qc?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8ef2f4-9f32-4449-b1ad-08dc28ed780e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 21:32:36.7730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rHqjtNUW8yd+IJILhq1gH57dx3nLCa9UahVSWMbUI6aoo+mZhOuqjqXMWt9USrXpxKVFL7bEoNlORNaZAdUqd4NCHeHhFfSyemX4CfYQ/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7271
X-OriginatorOrg: intel.com

Mathieu Desnoyers wrote:
> In preparation for checking whether the architecture has data cache
> aliasing within alloc_dax(), modify the error handling of nvdimm/pmem
> pmem_attach_disk() to treat alloc_dax() -EOPNOTSUPP failure as non-fatal.
> 
> For the transition, consider that alloc_dax() returning NULL is the
> same as returning -EOPNOTSUPP.
> 
> Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-cxl@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-xfs@vger.kernel.org
> Cc: dm-devel@lists.linux.dev
> Cc: nvdimm@lists.linux.dev
> ---
>  drivers/nvdimm/pmem.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 9fe358090720..f1d9f5c6dbac 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -558,19 +558,21 @@ static int pmem_attach_disk(struct device *dev,
>  	disk->bb = &pmem->bb;
>  
>  	dax_dev = alloc_dax(pmem, &pmem_dax_ops);
> -	if (IS_ERR(dax_dev)) {
> -		rc = PTR_ERR(dax_dev);
> -		goto out;
> +	if (IS_ERR_OR_NULL(dax_dev)) {

alloc_dax() should never return NULL. I.e. the lead in before this patch
should fix this misunderstanding:

diff --git a/include/linux/dax.h b/include/linux/dax.h
index b463502b16e1..df2d52b8a245 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -86,11 +86,7 @@ static inline void *dax_holder(struct dax_device *dax_dev)
 static inline struct dax_device *alloc_dax(void *private,
                const struct dax_operations *ops)
 {
-       /*
-        * Callers should check IS_ENABLED(CONFIG_DAX) to know if this
-        * NULL is an error or expected.
-        */
-       return NULL;
+       return ERR_PTR(-EOPNOTSUPP);
 }
 static inline void put_dax(struct dax_device *dax_dev)
 {

> +		rc = IS_ERR(dax_dev) ? PTR_ERR(dax_dev) : -EOPNOTSUPP;

Then this ternary can be replaced with just a check of which PTR_ERR()
value is being returned.

