Return-Path: <linux-fsdevel+bounces-19585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69F68C77E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 15:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA61BB20A59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 13:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1043147C6D;
	Thu, 16 May 2024 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mVCREOuX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74162143749;
	Thu, 16 May 2024 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715867100; cv=fail; b=Xol2KiqKMKaT1QjHM9wL4OeiUrstLpuIyn4HxEsKGwKHhzO9ibPDbTbO4qxlCQ+BITCN4meeISVly+C+uVHQpAR+OStK8mGO2lTEcRiUWdk4yV0Z3OcYHIMgEdcVRO5GF43c7kzwa57oqqLNMl9BDXcZIu60WPd+nghzEPEk4+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715867100; c=relaxed/simple;
	bh=OWBtXbymqFy188DZSb5SMgGsmVUdLXkFS5swa93/daE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aggPmtH4lrS+25CMOFJVb4qLkDPQUalKx2q81Y1tI64/bjgJKEf3iqSTCj5YWM3TBtefjWdL6AOTqx0VrS8q3HgSua4c+ptF4XZ9jTtbu8SYnZPUEhFl63e1MnZzTiYcG1Avm0HcgA0TXbyNsUjOg+sJ3e8gR7BkHmWck5kPUaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mVCREOuX; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715867098; x=1747403098;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OWBtXbymqFy188DZSb5SMgGsmVUdLXkFS5swa93/daE=;
  b=mVCREOuXtPe3DL1fOgghT26nzRp0S6xOogZCFmLeX4x4xvqYdXFHZpe9
   RePO4pYt6FQyi6lEhIuOVFLuecYMNuNkFIIYwFtptemcwzNnZsmgXrW/w
   Rze4ayq0pps2bPibdKAum3cjgUmEMZtN4PSX8FD3+lh2KcbYIAIrn3kJi
   +jmNiidL8L5bthon3MkvsmNoVfKyi4WIcCZLJjtO50KJAQ3fG3ybAM1Y1
   Ha4GT8Ny1K+mxoXIpkShoKT7DZ/8spBRNH5ha+1xvtVJcePy0UME49J32
   oCAxHzeUUZhFfeO+IEGml1LKcZl2zNumSB1pdpE820DeF9IFwQhnyWNKD
   A==;
X-CSE-ConnectionGUID: qe3mPtvMQaSN6V2y3vBWiQ==
X-CSE-MsgGUID: hfrimIg2Q+m66GjQLxLVUQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11829835"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="11829835"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 06:44:58 -0700
X-CSE-ConnectionGUID: RTETJVVMQKKJucObXW+ZOw==
X-CSE-MsgGUID: 7aPxabPgQPWmcVMeVfeuRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="36212184"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 06:44:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 06:44:57 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 06:44:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 16 May 2024 06:44:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 06:44:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZB5qdW6+zT3DxkzYXfSEu3s+NR/nNdwJTbnTk+CYxLY6mSDQwH7UVIiwDe0m0IHdkRCIRy/vn/+h4ASV2e2Dh0qlFl1C006eAy54G6LQhZnF88pZQwghQbe0OgAlEKZ/iQGa8XiUL2bf8DMNht3wZouwoCFZ8hVOGbidYgBWNq3BWVR6ln/grELvjlRWiUh8G20iex4QGqOgAs5muCd8xvYN5AkDB6G72v/lg/kpY1x0hcQYCTR9QJeiEnzM05LpV7p/WSv9fnndYQ8gRJ2VmaaEMn/Dwwq42Y6dg/J0MVSAdvvOlAWzIrk4rAYXQxERA+Yx/kZtBwz7A0CSu6JLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llIyIjR4zc7+Ybfw40xPgyU/r9o/86Z4qMS3TgcfOr8=;
 b=oeAzNi0KpXFCt+HzuJi9FWz5nsPn2uj1FXp9RQ0mDl1GN85vauL3xWXmTr70oPyigjd/zw0if1T8vI3bURZ+CSBXg0C770yS1HRS6rHfX51xW/hltJ9oqkoVy+Sk/xvdJx8eI6OM0xjk6zv7J/GAbBYgNU6naSLa1oxQMU1VQKTk4IlHw6wOGNs3SEcrNCFPgTBznQCnGB+yyqqGCRHU67rXJSb5+gIoz2oHiw2MklM12/7k9jRv1K0myy2O/DCBVHS+PZb8Jng+Chdk02IPZwBgPQit2T5Y/hG1V0tfAgFDsw0nWlKBowbHEeYdeq6glvagQbmySMaqhS5gl1xoIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB4912.namprd11.prod.outlook.com (2603:10b6:a03:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Thu, 16 May
 2024 13:44:53 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 13:44:53 +0000
Date: Thu, 16 May 2024 21:44:43 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Yafang Shao <laoar.shao@gmail.com>, <brauner@kernel.org>, <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, <longman@redhat.com>,
	<viro@zeniv.linux.org.uk>, <walters@verbum.org>, <wangkai86@huawei.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Matthew Wilcox
	<willy@infradead.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH] vfs: Delete the associated dentry when deleting a file
Message-ID: <ZkYNy8UEcpvAdamT@xsang-OptiPlex-9020>
References: <CAHk-=whHsCLoBsCdv2TiaQB+2TUR+wm2EPkaPHxF=g9Ofki7AQ@mail.gmail.com>
 <20240515091727.22034-1-laoar.shao@gmail.com>
 <CAHk-=wgcnsjRvJ3d_Pm6HZ+0Pf_er4Zt2T04E1TSCDywECSJJQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHk-=wgcnsjRvJ3d_Pm6HZ+0Pf_er4Zt2T04E1TSCDywECSJJQ@mail.gmail.com>
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB4912:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe890fa-e902-458e-8891-08dc75ae5d7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UNAdrxII5ofQIWYty1qpH16Unf7l9WXeUtc1PEj1xnz5mOauWXYoCPMfMFRq?=
 =?us-ascii?Q?9BdaXc2wmNIneAJ3gcC1o8+Ol1FI33HIqh3zotC8V9045ii6Zx/93ePuKC+o?=
 =?us-ascii?Q?NjONUPKH5xOxXoNPenjxMurPFg6PTXjIpeE5WTdv5+N4gb+W9zv8nrcu51nO?=
 =?us-ascii?Q?vYFG46Zgc5wJut0kppVZfEvfORUexGNJMw9/deGEV9INiywwOS+73hiYEQ+g?=
 =?us-ascii?Q?Vtl1VTHyXGSqMMgZQQjYBhGLVBFDkVx6FezR1d7cKc2ilTtppbvIpDCFdCJh?=
 =?us-ascii?Q?FEoOE4qmwMKYOGo2n7qyqvesCSeNrOdudniiEEotbOJa5NcLMOKitezqUWVP?=
 =?us-ascii?Q?GgRPzHtdBTa4UrjUp5OUKZfv2adHvojTenVgEtvWYoBJ6/o0gx/TGhSL2Smd?=
 =?us-ascii?Q?sczJBUWbLJ9VXa5FVfh+oLAzCo51DI3Yai2VCySReQOZDASTCvRTroL20+n6?=
 =?us-ascii?Q?7KlK5w5A94aga608kxMbjCAMbLDk2iYTIuRmGVc1kbI1fcy25iR95FUEbN45?=
 =?us-ascii?Q?MfZEo5ovm301hklxDvQebfQ/60PEbs72wDhdwA8OFgJgEn7lhxpznoVwgMKN?=
 =?us-ascii?Q?lMBhPtdK7SGBZKWyBVsi6A/uObAfXtxeWyhZFRltvY2pKgj+ssnv8eh777W4?=
 =?us-ascii?Q?u94whRLQVANZx7lUFef4rEBzqZwRyag10IZdT7JSIwv9O98gVmp5sA/ibOtm?=
 =?us-ascii?Q?iPXaw0e6VTdEwZBZq8oTTnKgqvZp49sfeKEt8jD8GpjLZS9avFFjlxLenxMT?=
 =?us-ascii?Q?39GNNEx7Cnvk9SEruXX52BIYrC7IAwGf7ny8OLdZvLgrfwmlhV1fZegGJwwJ?=
 =?us-ascii?Q?FdtWicbdXxQr6vKEj6KR2wDXxq25wII/hSfQNEBByTLXwUitKji9/vkorb1b?=
 =?us-ascii?Q?7afTPisbYVHmYjUYFlIagw7/N0SuEq3EyJMAypbTZeRta21nvPbbk261dk4R?=
 =?us-ascii?Q?UrXOOcrNNz+O+NpXr9s2fhcXW+c94bnapuocwbKp7XLbT8wvidmovKzHXcFg?=
 =?us-ascii?Q?T5fGvw7LpgS3ayrdS4kvzXHJZOUPrgEmOzaQT0eRnsOjj8Lqow1lPNoNdo91?=
 =?us-ascii?Q?N0j5U+w+l/8PQLE7YXoP94mtozhyhSSAUF5DZbLEQiD9FjM8F3J1EuUseouX?=
 =?us-ascii?Q?K3y7mIT83ELwTBFcwQkqv92x+fzwG14W061QRIgeJcJdLEVW6wY31TLO6LVy?=
 =?us-ascii?Q?sBCh+46d7CSjOrBD70GwWOf6j+R6QHzqW9/BUWIkeYQWbuDT6o/4YSNcK8I?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YjICljJ2bckC92hdM1eLsqNOsgPN+iiMrGwE0cthX9y1HGzOHLfb/GkZc1vO?=
 =?us-ascii?Q?4cDDFn6RtTjK9M49tHT3KwG1q7fvDtpynAMZHREvG6kSdhatKGXfHF+znF66?=
 =?us-ascii?Q?/3sP5VMJ6PS0sGxILalCL5huLjckyZOShmb/9suwD7QCk6uonTboBzsixxDL?=
 =?us-ascii?Q?iBoUVe56At4HyzlE8TocBBKS1raAqR3REnUrzWgP+eQbG2vRk2EsAqtxLAu5?=
 =?us-ascii?Q?RIHUa6MEfk8X6NXtZ6AHhloqAvtV8BN38AXaLah4mQAHHMUKccJlWOl4OrJS?=
 =?us-ascii?Q?z5jtWvOAtTgOifJ4LzX5lEOZwz894aEitZEOn7fShxJjSWIQlFm+ZiYrY10L?=
 =?us-ascii?Q?ZNyjyKyaFb1NcKGawZqv0rriD1PnFa4ZCMz2qtponr/j3vBd+nYybuog7HKb?=
 =?us-ascii?Q?YuvMh4LYv13PI+EMOKBDLQq+Yg7QP+oUuNOmiZ+oWUcuy8VOdC5UAZTJS6i+?=
 =?us-ascii?Q?HLOGH985Nvnyoi8FgVi4l5PEZwI4nAe8ymiRHC1EV7f4p1kxX79azwbQO9lB?=
 =?us-ascii?Q?PokR55tKL4wiXZTVAIrRv0iLgiv4jmPHD5vDdacxRg2ws4PvttZ183M03mI2?=
 =?us-ascii?Q?VIe/zhFrtQdTUNwnXlB1yOy1EY59xqVAngt3vu04pNB0DfSKvcFy6uTEpQr+?=
 =?us-ascii?Q?nT720qU7X7H8RbGdf+UmEgNgX8ZPyhTUkPQ//6xaPziMkewleU1MfN4/pioe?=
 =?us-ascii?Q?peygIISYMESMA5uK8LnKDfLYe8auhmkw4cKyxf8GxDsTaB4Q9ov6gZ94FTmm?=
 =?us-ascii?Q?KnBa1eqtB9XH8eSwOyg8RfBuvQoFXRYVzUKWyVIBelOJAH+N+XcLrrtt8si2?=
 =?us-ascii?Q?yaX9cJZ6F1mHznsoNRhfSEW2TSzXKWyniEbTjX3ft5rQKvAWPwnmdBze/Uk0?=
 =?us-ascii?Q?S7HjcVHtFDnQTMAobDphIOC6u1SmkLEbFZqqCedlFN3sX74FlmHgZyJUVnwu?=
 =?us-ascii?Q?7aIFbZVyVkLV8h6ZW+9vMywHiONkEaCg7R3BKRqANKR7PLHo607lPA9LEdEu?=
 =?us-ascii?Q?fCmH0iwBTNuRgBUyVXw0bgDCetwDF+lYvtAh4tBU+Jk0WlNk/RIxMdn7RRWh?=
 =?us-ascii?Q?j5qnZoRx5/Le9uf+u/xpz/VOavbS+YpAcDZ+cO121w7Y5iGd7mNFRq1EKlYW?=
 =?us-ascii?Q?+p8ug6jlKbHQ+hXmGwR9USJ8N4p4hGB07hZ5qwkJwGK8XGKCIWSuKs/GOgik?=
 =?us-ascii?Q?N81bKRe2S4a4Ih9DQRPQk8vHTWE/uCuHq28ZInF6iYAS8ofgKvEDWXxna/L3?=
 =?us-ascii?Q?pvNJjOi6tLpn+ahZCjnNXZuBmuzlU7qN/Di31rB8AdbIdcHs0RPMODBzjSAb?=
 =?us-ascii?Q?vawXPGBsQSBb3D+2K/XMZrBxRmbSZF+kaLjkg1dwymDDa28PJW2Sqjq13i8/?=
 =?us-ascii?Q?8I3X5FwvBRQEiimG/CYFUpIL3dIrgu/XDvnhkkpNgi5or7oJ2hP4ZE2ao81P?=
 =?us-ascii?Q?iu1UKW/0kEedcAEs0VvDBo4KgQospOB9GIpBq9Z8zCCW3NaaPyJwhplUElX/?=
 =?us-ascii?Q?rdDXzx62VlPXtZX+JtlJlQsOP18Xh0KSHtMZOlL+Q6cga0Sgn4+us+vZGkoj?=
 =?us-ascii?Q?v90fsT4vhJwP1x+cUCb/yU36pj9p2Fc2C0aDBA8Z8lohc/MkfnXC+bBm5+8H?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe890fa-e902-458e-8891-08dc75ae5d7f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 13:44:53.6573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w69Yohv5ORcMALez8+zs/uX+L8ctIB1EFrDZXbIk3egwL/+8jGtiLBwVdmuIbs+Yf7Bn4yo7KLpakeFwz+lALg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4912
X-OriginatorOrg: intel.com

hi, Linus,

On Wed, May 15, 2024 at 09:05:24AM -0700, Linus Torvalds wrote:
> Oliver,
>  is there any chance you could run this through the test robot
> performance suite? The original full patch at
> 
>     https://lore.kernel.org/all/20240515091727.22034-1-laoar.shao@gmail.com/
> 
> and it would be interesting if the test robot could see if the patch
> makes any difference on any other loads?

sure. it's our great pleasure. thanks a lot to involve us.

the tests are started, but due to resource contraint, it may cost 2-3 days
to run enough tests.

will keep you guys updated, Thanks!

> 
> Thanks,
>                      Linus
> 
> On Wed, 15 May 2024 at 02:17, Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > Our applications, built on Elasticsearch[0], frequently create and delete
> > files. These applications operate within containers, some with a memory
> > limit exceeding 100GB. Over prolonged periods, the accumulation of negative
> > dentries within these containers can amount to tens of gigabytes.
> >
> > Upon container exit, directories are deleted. However, due to the numerous
> > associated dentries, this process can be time-consuming. Our users have
> > expressed frustration with this prolonged exit duration, which constitutes
> > our first issue.

