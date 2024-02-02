Return-Path: <linux-fsdevel+bounces-10082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3618479CE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 20:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB31B28C7AE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 19:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C794380600;
	Fri,  2 Feb 2024 19:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yq/RBi8+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D158880603;
	Fri,  2 Feb 2024 19:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706902915; cv=fail; b=eK0YbAteCRZU4srsCsYv6P/vIHlACgocxIhW4vqE1Y4a1IhxSRi8Ol96QEqUhmsxmrBGGADWlbQK4CPeUUDsUSmN21IqPqJg4OVHUoUsXYaCOMKaytQle7/BieSPowrtYmiE8+VRxdMPqT1JHPJauX4ULa6BTa3wXn4L7WSZK30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706902915; c=relaxed/simple;
	bh=FP915C6PLAPulAVDODcd4acy4hsnalrhgFYYKm0/i6I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ysx0cvICAFdxnhwW2OHNl4RW3NaXVnoRbtbsmCaladWVKOFa8+BoEbqFnym6HL4ggdepIkpmv+8TV9lO2OYDCWWEXkn8a6qCEhNa7dVPXezk1AXdBKnBNvvyrUFAHqdsXU9G8wAKb082dGUzqnBcarleUMB9wkh8nZo8b7XwK8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yq/RBi8+; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706902910; x=1738438910;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FP915C6PLAPulAVDODcd4acy4hsnalrhgFYYKm0/i6I=;
  b=Yq/RBi8+oz69RpLgBfnD/1/cOqovONiKehl+WUmrCheYS7HCj3GTaKD+
   81MOeLhua9GgTKEiX9wa8Lns4iCDxqiDo1oQTsqjWOXAFw/h27rRmBtHS
   vsckXg0TzYNXvAFHmCY0Q9y0LLJ0sGH7QP1wvlwEBO5/7GKyFVc3uAcMd
   KPKN62OAZMJ4xh+RTocV2k0/dnkQXWsYaP1bgMyrZZ7B07nDTD+2/GE88
   6ltjmC5tKW46kbifk3ohisEAMTmQQFTAonFflIj52lnFchYoz/P0fU9Az
   ElFBqPJ90MALKf7pamLFUua3SxEMIyheGxlp1HPkpCQzT8a/xvo98tr2b
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="123894"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="123894"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 11:41:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="30972818"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 11:41:49 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 11:41:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 11:41:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 11:41:47 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 11:41:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbB8auSuGcaHdqJnHCO9hEM7O2gcWqoM+7zGQewSEHQc7PKi5HF8qATdhCN7atOIg5gy6o6jkEkzBvifM7x5PxqChw9d0OLO0p409qYZjketeAIzpqjvn6sIxLn+a7ETKfmUxR9aUakAH4BvGiU7H1QoM/lf9vkoEawPip7o2s4PmDHOuvpVg4ZXKnkuzRCDXdJkWQWZJ6sL+5KfAqF+nKkjrBX3Lgysf7H99PNUbRlyobpIp6W0KlSFF2BG2Zu02OWlErKlEiluJvWiWSBNlUqYHrJpsPw83osdPDDAol6vFhM/Rl4a9nFlAmUUFEbTT67imGqMtlz7pJFv/gjpMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7u+Jv87iN0YTORW/BKoMNxO+13V80HwLnj8F+Nqn/lI=;
 b=GlxOVMAfms0tr8zHLJmYfu70EDGvjGee04fpe9vQ4M6dgGr64npBB72+B2QV5S+lZ9WdblZ7tybVc8vzk0A7KXYMoHS0ddVmq5Fa3DKru/X+SDDz0383w39SdcS36GAFToJEUAU7nyNpdmsrJt71vVJ7OoSjsEDM1CTJ9DzrHbcOeEoxa1+tQ6R9OBq/sqRt0TX717LOn4CelNJNIe/GdH04zb6+Trjzr7BKU19qHs/Un+GhRkHMjJeLH16dZSMST8gG/u5LBi9haYsJ7zvivCgCjyZTO+hYULb620Zpj3VS28vzgnSksNNFybOPvFFeNGYQ/nirT6maNST2iz3MKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7377.namprd11.prod.outlook.com (2603:10b6:208:433::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Fri, 2 Feb
 2024 19:41:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 19:41:44 +0000
Date: Fri, 2 Feb 2024 11:41:40 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dan Williams
	<dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>, Dave Chinner
	<david@fromorbit.com>
CC: <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-arch@vger.kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, "Russell
 King" <linux@armlinux.org.uk>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<dm-devel@lists.linux.dev>
Subject: Re: [RFC PATCH v3 2/4] dax: Check for data cache aliasing at runtime
Message-ID: <65bd457460fb1_719322942@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240131162533.247710-1-mathieu.desnoyers@efficios.com>
 <20240131162533.247710-3-mathieu.desnoyers@efficios.com>
 <65bab567665f3_37ad2943c@dwillia2-xfh.jf.intel.com.notmuch>
 <0a38176b-c453-4be0-be83-f3e1bb897973@efficios.com>
 <65bac71a9659b_37ad29428@dwillia2-xfh.jf.intel.com.notmuch>
 <f1d14941-2d22-452a-99e6-42db806b6d7f@efficios.com>
 <65bd284165177_2d43c29443@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <6bdf6085-101d-47ef-86f4-87936622345a@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6bdf6085-101d-47ef-86f4-87936622345a@efficios.com>
X-ClientProxiedBy: MW4PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:303:b6::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e61088-d60a-40b1-a762-08dc2426fc63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQrKq9zoxk8B5num0x7w//FYjNq8tNDkAq+CDw5EWc3p9kmgcXZchYqFFH+qc7344WkAnrNaWyUSFV8t0smg6WClIjxUJBw8f63nNvjifyFS0FlHoYjhOyEOZF1HI0Y5eFfrOvtwpTRNeHtqS/9UXcfIcz9AswseZlZh11/xT7hlPW2MKHVYyc0kAv9cmBfVAPzjlbeSFDVJNk3zxFsuZnP1O9Ylc3vF76acOV0ITx1zYvcG1MftLe2QxPm8FkpTBVwKwPR73zneYv7rqZkp2VliCCiA2WwSKU7+x3US8Ul99I+juFoDEq+w/YKVvJUiGIi7KOtensTQ6uwnztes4DbLzEZaAw2fuJn4cDo9fNXvsi02jbGZ5r4CFmTVfflm6UsuLvpWY1roVznC0CTUESiv35gBVnJsCF1is6/edMq8x90FR54xRWZzaJJhyOsmB2mDa9GVRXq7/psuuoypig08IbRLxdcRQrbc+DkihXlFqxdG4XXtYcwWb9rMp/ynn15Kfa7q4W4w3jhEw2PLwDKul5PuyagXK3+4SqwBs4/EWbCq73A7IbG0MC9XWZSR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(83380400001)(86362001)(41300700001)(82960400001)(9686003)(66476007)(478600001)(6512007)(26005)(54906003)(38100700002)(6506007)(2906002)(6486002)(6666004)(5660300002)(316002)(110136005)(4326008)(53546011)(7416002)(66556008)(8936002)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VlfO2LhDJMr88m1bR6HKiaMkt731pIoB+BdqHgew3b5Au+ZVWotDGcf1PTC3?=
 =?us-ascii?Q?l8WPxWRf9YclHZ4LRjvx+NWeQndY+014EoDbaLf8jR5S7Rq8yGrBKg/f0RqQ?=
 =?us-ascii?Q?xvEcplPTEtAv+2DEUIORqOQbwnC7aASTxePXze89S8V/fAcMORRDjm/s2+mj?=
 =?us-ascii?Q?XEaxicfrp+wePaxSrSiQLDihKEkIeBZ/1ZKCmrOk52J5j1on7Kvuv7Sti1k7?=
 =?us-ascii?Q?hyeIw1VAqlalXtsP7cjeHkTfz1GbZ15rO8L+Xz9h7Njhihgg3fa33O0bXhcF?=
 =?us-ascii?Q?VFrPrL+5MCQ5lFMRkJ5c+zQhe3me+1cpJJ4GGHdYrLuWR+ThJ9PGYETXlnSD?=
 =?us-ascii?Q?//C2exzI0GTQaW6uwGBRlR98tN5Tj9KUy6YiQRZk7Y7OqBmnPO6JLA8/3xaG?=
 =?us-ascii?Q?LRz8cXJ9gAbuzMvEFPceoX4vDkuduMyQ31Avh2gqyH3ihvSoTgyw/Jit0kSN?=
 =?us-ascii?Q?DCaYXLPYBPK6nJXICypcbF6Ffy9Oz18qRL6voPXFpn0CfqXe3wQGXuHCERPZ?=
 =?us-ascii?Q?KRvOO9Zb7Nplht+g7m6sJtvhVTYXs1ijz76ls0uICUvF1Ne//02uUviWFrTU?=
 =?us-ascii?Q?YnTI06k+rv++LaO5HEj5f+nV2zHnysE6Kp5TSms+XT3t2EVJ4Fv+im6oO96Q?=
 =?us-ascii?Q?m3o3VVuR5zCoyd8B1ORtbfw8NMCF1N6v3DQBzFI+yhcBQUlWxxvLzGCANmbW?=
 =?us-ascii?Q?69qTBsEf7fkZ0j/4OFOQ+OKCC9APjFk0+O9OivjSvuaasibY4ht+JItQeYQN?=
 =?us-ascii?Q?4GoaCOsLwCBjwqXSAydlgyVe37gU8HZFvzIlr5Hf3sNchwvrsLw8hlP/d9xm?=
 =?us-ascii?Q?fvSmnLnYQwpbzkHjkVqB/0/QP7C+QyP2DNf0iMtCqTN1u/joBpvz5HjPb2dw?=
 =?us-ascii?Q?z5SfQfxHdYyAj5PfHwaMWFdadmyTsm/U2huN7Xzkpk81ugMDaJm+HaLBWp4R?=
 =?us-ascii?Q?4lrq6BGF0pi+OqwyfOC9hYcoeK39N/3DbA53o9ZbAlAwKLrVZTby7Co61jAO?=
 =?us-ascii?Q?0TqHWM0sr5xHEJqYTnDgJcTV9XU3YdTTSu19v06BQxXKqEu0V3DBVgMD7Q+D?=
 =?us-ascii?Q?i8a0MMiKATmh7BqdtU/syVthDUIgXtQGDrkxytrnkjobzeCnZn8LktRFp+Nw?=
 =?us-ascii?Q?pUI7LW4+w0CpXMWxdHh44ulkm/4zgC3GxSUG6oMqw9bD4dcaYuY8ftg7Pusd?=
 =?us-ascii?Q?BZRAYJ2CQ2XoHGKRFMDKtTaMmHAAhPfZv+o1vTXmMKXnL7khVJwmyvqQb49c?=
 =?us-ascii?Q?hMZfrMdeXzQj6YjftIK5fKZENGAUuQej45RDPGmngjcNDNXXOxEHJ5dPfX/G?=
 =?us-ascii?Q?VvBz3fBfe4XCILO0nx6Yh5MlXj8uZnxhlNOvyN9AduX0a0wk9c4IWb3zJb9U?=
 =?us-ascii?Q?s1YsCX8jDZKkhrpalYFl1l2ca564YLNBAkF7ST8kzIDs3G9sp85ySebQqccU?=
 =?us-ascii?Q?FjkwRJH7p+sPztxhQ5J1aUOAkRt+s3HV/Y5j04PSq+KDkW/Fs9Y/HoLn7aH1?=
 =?us-ascii?Q?93G0DoZNUB1aTHlK4Ar1nqqSdP+S6xHBfh4twbn6DJ/OBuH8C+5Aga/AySCi?=
 =?us-ascii?Q?u5+Ds/eMgLs/uPWTLdL+I/RvV9imGcl4QrWouQhs2/9W5kCMT5xUhnxKp78M?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e61088-d60a-40b1-a762-08dc2426fc63
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 19:41:44.4512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPdjlzEaWjnKRIwh3WZTz5zfoqcANtfPvaMUT2L6O1GIqqb0VTKSG+bUALpG/uHIp3VCit/IQxprWjS1cmdYWI2YdC9Yq69tT1GUOqoKtss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7377
X-OriginatorOrg: intel.com

Mathieu Desnoyers wrote:
> On 2024-02-02 12:37, Dan Williams wrote:
> > Mathieu Desnoyers wrote:
> [...]
> >>
> > 
> >> The alternative route I intend to take is to audit all callers
> >> of alloc_dax() and make sure they all save the alloc_dax() return
> >> value in a struct dax_device * local variable first for the sake
> >> of checking for IS_ERR(). This will leave the xyz->dax_dev pointer
> >> initialized to NULL in the error case and simplify the rest of
> >> error checking.
> > 
> > I could maybe get on board with that, but it needs a comment somewhere
> > about the asymmetric subtlety.
> 
> Is this "somewhere" at every alloc_dax() call site, or do you have
> something else in mind ?

At least kill_dax() should mention the asymmetry I think.

> 
> > 
> >>
> >>
> >>>    		return;
> >>>    
> >>>    	if (dax_dev->holder_data != NULL)
> >>> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> >>> index 4e8fdcb3f1c8..b69c9e442cf4 100644
> >>> --- a/drivers/nvdimm/pmem.c
> >>> +++ b/drivers/nvdimm/pmem.c
> >>> @@ -560,17 +560,19 @@ static int pmem_attach_disk(struct device *dev,
> >>>    	dax_dev = alloc_dax(pmem, &pmem_dax_ops);
> >>>    	if (IS_ERR(dax_dev)) {
> >>>    		rc = PTR_ERR(dax_dev);
> >>> -		goto out;
> >>> +		if (rc != -EOPNOTSUPP)
> >>> +			goto out;
> >>
> >> If I compare the before / after this change, if previously
> >> pmem_attach_disk() was called in a configuration with FS_DAX=n, it would
> >> result in a NULL pointer dereference.
> > 
> > No, alloc_dax() only returns NULL CONFIG_DAX=n case, not the
> > CONFIG_FS_DAX=n case.
> 
> Indeed, I was wrong there.
> 
> > So that means that pmem devices on ARM have been
> > possible without FS_DAX. So, in order for alloc_dax() returning
> > ERR_PTR(-EOPNOTSUPP) to not regress pmem device availability this error
> > path needs to be changed.
> Good point. We're moving the depends on !(ARM || MIPS |PARC) from FS_DAX
> Kconfig to a runtime check in alloc_dax(), which is used whenever DAX=y,
> which includes configurations that had FS_DAX=n previously.
> 
> I'll change the error path in pmem_attack_disk to treat -EOPNOTSUPP
> alloc_dax() return value as non-fatal.
> 
> > 
> >> This would be an error handling fix all by itself. Do we really want
> >> to return successfully if dax is unsupported, or should we return
> >> an error here ?
> > 
> > Per above, there is no error handling fix, and pmem block device
> > available should not depend on alloc_dax() succeeding.
> 
> I agree on treating alloc_dax() failure as non-fatal. There is
> however one error handling fix to nvdimm/pmem which I plan to
> introduce as an initial patch before this change:
> 
>      nvdimm/pmem: Fix leak on dax_add_host() failure
>      
>      Fix a leak on dax_add_host() error, where "goto out_cleanup_dax" is done
>      before setting pmem->dax_dev, which therefore issues the two following
>      calls on NULL pointers:
>      
>      out_cleanup_dax:
>              kill_dax(pmem->dax_dev);
>              put_dax(pmem->dax_dev);
>      
>      Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 4e8fdcb3f1c8..9fe358090720 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -566,12 +566,11 @@ static int pmem_attach_disk(struct device *dev,
>   	set_dax_nomc(dax_dev);
>   	if (is_nvdimm_sync(nd_region))
>   		set_dax_synchronous(dax_dev);
> +	pmem->dax_dev = dax_dev;
>   	rc = dax_add_host(dax_dev, disk);
>   	if (rc)
>   		goto out_cleanup_dax;
>   	dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
> -	pmem->dax_dev = dax_dev;
> -
>   	rc = device_add_disk(dev, disk, pmem_attribute_groups);
>   	if (rc)
>   		goto out_remove_host;

Yup, looks good.

> > The real question is what to do about device-dax. I *think* it is not
> > affected by cpu_dcache aliasing because it never accesses user mappings
> > through a kernel alias. I doubt device-dax is in use on these platforms,
> > but we might need another fixup for that if someone screams about the
> > alloc_dax() behavior change making them lose device-dax access.
> 
> By "device-dax", I understand you mean drivers/dax/Kconfig:DEV_DAX.
> 
> Based on your analysis, is alloc_dax() still the right spot where
> to place this runtime check ? Which call sites are responsible
> for invoking alloc_dax() for device-dax ?

That is in devm_create_dev_dax().

> If we know which call sites do not intend to use the kernel linear
> mapping, we could introduce a flag (or a new variant of the alloc_dax()
> API) that would either enforce or skip the check.

Hmmm, it looks like there is already a natural flag for that. If
alloc_dax() is passed a NULL operations pointer it means there are no
kernel usages of the aliased mapping. That actually fits rather nicely.

[..]
> >>> @@ -804,6 +808,15 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
> >>>    	if (!IS_ENABLED(CONFIG_FUSE_DAX))
> >>>    		return 0;
> >>>    
> >>> +	dax_dev = alloc_dax(fs, &virtio_fs_dax_ops);
> >>> +	if (IS_ERR(dax_dev)) {
> >>> +		int rc = PTR_ERR(dax_dev);
> >>> +
> >>> +		if (rc == -EOPNOTSUPP)
> >>> +			return 0;
> >>> +		return rc;
> >>> +	}
> >>
> >> What is gained by moving this allocation here ?
> > 
> > The gain is to fail early in virtio_fs_setup_dax() since the fundamental
> > dependency of alloc_dax() success is not met. For example why let the
> > setup progress to devm_memremap_pages() when alloc_dax() is going to
> > return ERR_PTR(-EOPNOTSUPP).
> 
> What I don't know is whether there is a dependency requiring to do
> devm_request_mem_region(), devm_kzalloc(), devm_memremap_pages()
> before calling alloc_dax() ?
> 
> Those 3 calls are used to populate:
> 
>          fs->window_phys_addr = (phys_addr_t) cache_reg.addr;
>          fs->window_len = (phys_addr_t) cache_reg.len;
> 
> and then alloc_dax() takes "fs" as private data parameter. So it's
> unclear to me whether we can swap the invocation order. I suspect
> that it is not an issue because it is only used to populate
> dax_dev->private, but I prefer to confirm this with you just to be
> on the safe side.

Thanks for that. All of those need to be done before the fs goes live
later in virtio_device_ready(), but before that point nothing should be
calling into virtio_fs_dax_ops, so as far as I can see it is safe to
change the order.

