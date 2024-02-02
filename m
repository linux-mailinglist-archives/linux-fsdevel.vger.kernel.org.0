Return-Path: <linux-fsdevel+bounces-10086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D8C847A4F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 21:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47877B251E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 20:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E048172E;
	Fri,  2 Feb 2024 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPw9uIQX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53AC80628;
	Fri,  2 Feb 2024 20:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706904866; cv=fail; b=TGhyZ9oNYeEQthamDZEKDBYGp6b1k+EjNQ2lvI2kpCcGgSGAFDlMSYes5fxwoPkoMQiEKEBUuOKZaijt9MPJST3eTw7ooSK2xLcJ3v1A1Xhit42x7g0gwv8gzuFGL3jwBpxRBIJW4a0Znl8I99dcxjI2257xPj2ZGJOMfA0uSV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706904866; c=relaxed/simple;
	bh=a4VnuHqgE9CJb5JjJQr7kvDXE4waKiNZHlOeufKhZZ0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vij4RAzZUV0AG7wVaOxoX/F4iaBne5ERwZI5uqicK6gbbgdd+wCXPVBk5hPNfsiPgoJsvnlTju0V+dfrCHv6Ff5W/TRteOK/QIEd1Jww5ndNEkJrnEn8xQSRq8WEWI3vBCthP0wuoDOx1r/W2KZw3Ez13SD2QyibU7mSJDnbRh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPw9uIQX; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706904865; x=1738440865;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a4VnuHqgE9CJb5JjJQr7kvDXE4waKiNZHlOeufKhZZ0=;
  b=TPw9uIQXWPF2vmoYBP5zBE1d8koRQ13SNxk0+cTPg7gwbLUrMvsq9a+t
   CqWt96mBc4nwmuXGgPz+Eu0/w3XKXodDYabiWDqfnCRIFWSO4U13uixN7
   O79te1/pJtdGUIgTsZWAFTkmYQzZ57+uB2xJzvuupbE+zP9BrKGsHLPbo
   8tOZnUkQso/6yJGPKocV9C8HGbSuQzm03ooB1L4CB5vAiy7+y7x3D89k4
   7obPc36u9Jvu4msAuydSfF3AiqZPDyq+8U4HGI2cJMjNaE0pcrHtkWaNg
   Rh3c+0TuGuaTuZuxvsjlFsJ6EnjO2MY/T2sCUKn4pQV+LN8cIBaMhwL/B
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="147747"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="147747"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 12:14:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4769692"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 12:14:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 12:14:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 12:14:22 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 12:14:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwE7xuIsOWYDZEihnrAaB9aHHlFVt62yCr0A1brhvr+CjKClHLz+dK6+NZIjqvro4wjH38bBRdlpHgjk3KVR4K6VcQqL7Ws5binW3N9WbtzMvpCejCc+hXXVZqxcVDoXfyWosaoz+0WON8mvaruRcDIE4I0BVqiSFJZjqbgLcPij4Fiqm5KhmvYr/R/BtWNRmzGcE48BsOsJ6dNlBAlxY8TsdYCAZbOG9Lyw9yXL1nvfva5ZOskxgVoIsv+lN5CJdx93ph2G+wV7nl3u9ag7ySIdYLVqDo8064OOun0zwtWoPmes9HsJ0HXVZKKSR9TZjmk0jK2aXmdEuzT164405w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpb6CMXUfwxwEegI6jnJDbXSVHw8Qcp+uVT7Kg25m7U=;
 b=M+c7W1E2pI5xgJHbULhC/SVairJ5BtfHJSNN+yN2S0bdKljoq1GbcKZYqU4J8Xy8pPjqF3GNboblJaKTAWN5pw00aHUT9V4qbSh73x+3Rf6kZwwRGIc6WsNJFgRy9O7g0ogFVvxKETCZQyBaOJSY54a/08t9UA0w6tLEedZMrAwkgaOSMY/XI8VzYcZft9rmC4uiKtnMfGG//1rFemrizwNgaO1N6ub9tmeYQOEGR0mKpUAjLa1C5AaH5JSnlJoolIDVXkSj/XSanv9KfywZ9ULs44k5L+E5dHOnAvYvdwOg2lXxLiqR1dqvYYNGyH7wG5LZ4B5hrpUjrLfW4Vjvtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7583.namprd11.prod.outlook.com (2603:10b6:806:306::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 20:14:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 20:14:20 +0000
Date: Fri, 2 Feb 2024 12:14:16 -0800
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
Message-ID: <65bd4d18cab98_7193229421@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240131162533.247710-1-mathieu.desnoyers@efficios.com>
 <20240131162533.247710-3-mathieu.desnoyers@efficios.com>
 <65bab567665f3_37ad2943c@dwillia2-xfh.jf.intel.com.notmuch>
 <0a38176b-c453-4be0-be83-f3e1bb897973@efficios.com>
 <65bac71a9659b_37ad29428@dwillia2-xfh.jf.intel.com.notmuch>
 <f1d14941-2d22-452a-99e6-42db806b6d7f@efficios.com>
 <65bd284165177_2d43c29443@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <6bdf6085-101d-47ef-86f4-87936622345a@efficios.com>
 <65bd457460fb1_719322942@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <5e838147-524c-40e5-b106-e388bf4e549b@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5e838147-524c-40e5-b106-e388bf4e549b@efficios.com>
X-ClientProxiedBy: MW4PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:303:83::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: bdab67eb-234c-460b-a795-08dc242b8a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ub7YIUU6ob9pLWm+2OmqQ99j4Adw40b5rUPhFmSsmIxkNXoFIvuUxZYgHES8hyk4tnpEkR0jtiZHl0kMOd3+nNH7wTfKZniorciocG8RpYLg4DG6g9Ke/6/XhFrI42KwcIHX8VseR25QDn9QugN9AS9VVGjbeVTmrDIMGLeZDhMW7RRPFrmF/6eYU5bcH0dg2StjcsWIfzAI2qjNx+fXXQWuJ3KwCkjIZwg6yms6qJqlFU9GoAYvDarRaX27eEYAKep1Q0zesMl0xONuhGSuGHdlEKroYwod2j66ZuXBvq6e9bjdbX8Ps5UAF1Rz6FSpBSA4R8392s7WbSqWkIo1Evg2QqvFtKkUnDRortQWxNaytDIBevrHyWxtG9A4XrUnuhwP4gr8DXwH8wLELcGZp6RD4kV0ZraUpte31j4OQgs7MbC3jLMzmHB8dapxPm3UG4fchuavz+FyhEL1Ee/xXC2KqBf++87NJAGBg7OdHPqpGV5aRlBA1hOiRtAEvcaqVaT4e98sdG0181pfRwMJ06EeUmGdsNnB2EFu/GqB5oo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(83380400001)(26005)(478600001)(82960400001)(8936002)(8676002)(66946007)(110136005)(5660300002)(66476007)(7416002)(4744005)(54906003)(66556008)(2906002)(4326008)(38100700002)(6666004)(316002)(6506007)(6512007)(9686003)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gzKzF6ApSErPESjn2czsZRdmVAQsdgxswhTXAdmWE2TbYQIqI55GUO/IaOec?=
 =?us-ascii?Q?rNl3QIO/mN2hw/aEm50XcV/odi0pH7d9vksu8wt+fWw5rRHiPOa2A9sVKr8J?=
 =?us-ascii?Q?QY5wueIR3OlnKwtKfdjcBChjopBor2q6t9X8OIDX132BzmCAei9MdJtC1afF?=
 =?us-ascii?Q?lgZ3V/ziEYg0y8/coI/BbEAp668uTbZWodPvXSSze6DGLTFAo+cyhcjJ2+bu?=
 =?us-ascii?Q?HSIGbLUbNO/kWKOWHarI1dG4OioVQdjWVuCQmLryKxU45LoMA0uBLEU4Ub+E?=
 =?us-ascii?Q?RT3dDAdDeTpiwpDIvqlq6vvSHWVMCCWrbNFJlIrWEq2kVpP+Kx2s6wPLrKnC?=
 =?us-ascii?Q?spmpZTNCIOsbIfeb5boKQ13QKXB2A6zV6IG2DMWf6ccphf6eTr0EWMQ2rQXt?=
 =?us-ascii?Q?VD17QkGMQbzX8HhgiKH+vJ5XxrDj1rVN4bwtR+ZA4PAf+VMwJ6DkgvSDRba0?=
 =?us-ascii?Q?I/C7kTzwSZQhgc1MvWvqgePtJkUJC7aQQREjk+4zk2yPfN9K3w3LGqo0rHo+?=
 =?us-ascii?Q?qqEfI8kPUs6Q9YoLskQCFkSYiOiWi21Kuxf9a80eMuhCZYP9g2f7VGLsW+Gl?=
 =?us-ascii?Q?4zk2xYeytw0W/rfK2Gafq/4LMvQLiNWIpyUXBjeyyzqDdS6BRiiDq0daLgu6?=
 =?us-ascii?Q?UtfM0rwUT8GhsvIxoe5cpXO1p2fYGmTvZZ2+Fw4op7KXeifXhEt50tft4uPG?=
 =?us-ascii?Q?iSyeYTu+65ISqtGW62zQIH2TQOrY6mimq0bxNtRqqooAgPqNZ18Tt9l9QdGu?=
 =?us-ascii?Q?93y83n6gjqO85/vLPJ7rB8CIpxw42w77cgMc/ZOHxS6MDrdWQ9i7W/jU8VFf?=
 =?us-ascii?Q?q+0xV+AKDdRARakbW7wfeMO8NbuPHn/PTHr2e11eTe8IKM762PdpkutOh4SC?=
 =?us-ascii?Q?eSezgGn6XtqpgMClM5V7Acd+TzwzXSnFSbOqKdsfU7hSj290n4dkb+NOtV2M?=
 =?us-ascii?Q?IRdvw/WspHuEgb/U0YOqoLm4gkoydWN3e3F0ykcRWfgAEgzLh8ckvs55tyxK?=
 =?us-ascii?Q?VGaHf9+hcxunXvZ9FyL+18CmvpmWVBZxIUNf1eIlQim+DJQFxsxssd+Ae0eK?=
 =?us-ascii?Q?BLuA3RXnUidOhDp8OCiMTPoJEm0StKZ7A5j6Xw0LUeJuiaRiWypFLBqyB0of?=
 =?us-ascii?Q?XhShCE7KdXl2BC5FDq7B6bRV8NKJ1LxpubyBXS22hZ8vc0Ue4IlO/FNIe2HS?=
 =?us-ascii?Q?ZRqyEkaC5RhaBTAsmNd+kTQj+VbWrvBGz42PP14meM6ENjEECcKpa+6QMXaM?=
 =?us-ascii?Q?B+GmB4Ij0+TRXNYGQggQiYVBGEEYDwM8PDNH9SxfQU8ya2xzUorttFRmifc6?=
 =?us-ascii?Q?HakqgEgt56ccrS3uolc0ke3N+s0GBZyCXhdgnk62BGBcMVKQ+wFDbp3PgT/U?=
 =?us-ascii?Q?tFeXBnGjQ8L73jqwfJDikvdljTjCYYa4h91vFzMIxFsLv1HeR6NuA8Gej+2c?=
 =?us-ascii?Q?0UBMmCqSoqwZMKvBfKIqVG/itHulGMTJrB0xnpWjqhc2HeNoVuWjnqDOoLWU?=
 =?us-ascii?Q?mF3CHu10PLh+fMShdLS3lHEvrebvGdvSByZ5iNQI+D7HIUPqcj1OM55pkGBO?=
 =?us-ascii?Q?GG79ZnoCpjXgPydb+4mbs9cQFXJwrPG68SvN2A3IdSpt4MYNp6DkvNqtRv7a?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bdab67eb-234c-460b-a795-08dc242b8a74
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 20:14:20.6075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSAIMMAXN6Ghc2YbALKdnBKtcyIFLdO+3FnJMpiK4V/vujCdTq/Zu02aQtW3b90ETDN02JAWENhLZmFT6Fg0xxwB+tkcyZ2VvE4JR6hbWZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7583
X-OriginatorOrg: intel.com

Mathieu Desnoyers wrote:
[..]
> > Thanks for that. All of those need to be done before the fs goes live
> > later in virtio_device_ready(), but before that point nothing should be
> > calling into virtio_fs_dax_ops, so as far as I can see it is safe to
> > change the order.
> 
> Sounds good, I'll do that.
> 
> I will soon be ready to send out a RFC v4, which is still only
> compiled-tested. Do you happen to have some kind of test suite
> you can use to automate some of the runtime testing ?

There is a test suite for the pmem, dm, and dax changes
(https://github.com/pmem/ndctl?tab=readme-ov-file#unit-tests), but not
automated unfortunately. The NVDIMM maintainer team will run that before
pushing patches out to the fixes branch if you just want to lean on
that. For the rest I think we will need to depend on tested-by's from
s390 + virtio_fs folks, and / or sufficient soak time in linux-next.

