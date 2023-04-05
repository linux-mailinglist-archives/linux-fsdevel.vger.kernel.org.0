Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475366D871D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 21:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjDETnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 15:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjDETnk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:43:40 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4757776BE;
        Wed,  5 Apr 2023 12:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680723793; x=1712259793;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JQDK/FAkxtiqZ/hepNLVP9tvi8je9quDwcL17OCVs9s=;
  b=MFnu4Tlq+0Z7aawHaYKzMTCb50FBF32ygA2mpT2pKhehQYu2wPjUXnDa
   FCYrik17R6YsjPSuGum3bFIeImGtKC0Caf+IF1J6qePVfREYXX1UExgri
   Hyp/DcbQaD9jRNewIHGvJU3Lpg7h9YpiuQpl/RuNRfx735NBoQWqeqwlL
   ZRHWqxRgPOS3R8h+c2tzX0QsHZgZ5ewWQtxY+JeiYWK9OaGa7G1XScFG8
   v/QMOJFlhuBqgR+n7ct0cz1XBhlpZGibESQCHzjoriJYp1In95JtyzHf0
   nj+rfvhka55pAuV7oT9A31yKi2bQD8VNHraMnZKfCbtnpVpuq0xEZHy6z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="344281770"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="344281770"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 12:43:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="751381831"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="751381831"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 05 Apr 2023 12:43:06 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 12:43:05 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 12:43:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 5 Apr 2023 12:43:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 5 Apr 2023 12:43:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBWvi2kDpw8dZLwVBAWXimmt05WADGJKMnK9zGnbgakYVjki+5xlgofZN5zf0d7+1XpZJBzykmrm/JMW+vZW0CXW9TKEWXvgS29T6AD55AlGPKzjuLxcm+UlKZhsSj/mHu80ABr9eonaLk3gCMMk/csJMd5FGbiLg8LgWeh/eKyHmEsKY9+6LvQgYyTnvxLyh2c7n2yy5LFrRugVlSPxvLZjZbndlLBEzBZyphiZFn5nhIy/OjBZcOVl7ScJZqpvOs+97P4V/lIK4f743DQCJlwOyf2MkNyVY9G0T9dM/1ggYnFiL94NAGFlwcEUbQg1mzVrLDl4ECIbLLFWV7XmPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+M/EF5941BzIgLFdlij4tTUJKqlE4u5phY37m2giu0=;
 b=lmbWIf/00whNlbmrhPOe4BWs3gK80+ItZfJHLAFmkDI1OYkzNPuUNvyt8EattwArJ1AxAhTjZuXkDMjdrwsrAGsrzJ6c75MdeXvW5mXoOU+qJCzBT5GbZ8R1fch/AFk1tGmtGkjJtoRxLj0e1rVG8oQDyT9QkUjYMfZ/5S1RjppOm79ynzoTM6Xk9qVoYZz7MlBvYktkWjbsklBZf9m9qBLn0fL8PZHIrhHD9sUpfjsIsH9YWGIERoHoXe4/q0jOmRpt7abfbKbYtBLziESi9NaaUvq628OoWvay4HXLLUSvsA34t4xjtpw/ZPIN3Fd0jQPmCVgUB44QKlRC/RqbLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6243.namprd11.prod.outlook.com (2603:10b6:208:3e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 19:43:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6254.033; Wed, 5 Apr 2023
 19:43:00 +0000
Date:   Wed, 5 Apr 2023 12:42:57 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Kyungsan Kim <ks0204.kim@samsung.com>,
        <lsf-pc@lists.linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <a.manzanares@samsung.com>, <viacheslav.dubeyko@bytedance.com>,
        <seungjun.ha@samsung.com>, <wj28.lee@samsung.com>
Subject: Re: Re: Re: RE(2): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes
 for CXL
Message-ID: <642dcf4169ae5_21a8294f@dwillia2-xfh.jf.intel.com.notmuch>
References: <ZCbX6+x1xJ0tnwLw@casper.infradead.org>
 <CGME20230405020027epcas2p4682d43446a493385b60c39a1dbbf07d6@epcas2p4.samsung.com>
 <20230405020027.413578-1-ks0204.kim@samsung.com>
 <642cfda9ccd64_21a8294fd@dwillia2-xfh.jf.intel.com.notmuch>
 <ZC26HpJiBexoIApc@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZC26HpJiBexoIApc@casper.infradead.org>
X-ClientProxiedBy: SJ0PR05CA0171.namprd05.prod.outlook.com
 (2603:10b6:a03:339::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c8ecd1-ec7e-409f-376e-08db360df664
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VD9BNtx4kT7UrPLpf16l6gJaBJfZWyfpWBNudb6TR0cwV2Nlo/LQCr23IlaJC9zzImLM/7Q+DSWhaRnhuh+xbdkrqhSG1Vo+8GYGB0MNbsqB20hjIRoLybxqwkC1SJIBvP7RG12uclPiyHo23Fw5d1GyHqUaOTjc6SNsqXuZ3tqdn2QfDEO6cGjWGLmsJhGT1NznyFTQLNolYVh2l1/xmPRkAQClZIqS+9juSUH692QEo/EPmw/nK5P1PqDX+YyC5JtZ+uKNmEu6uWbMJoNFu3mshn9PS05g+Xp2aY8D7W5sr/Ti6MTEq4FwELKPBNeiYt7hHdtuElKonF9P6vy8h4HcirFyyOBrtjlHznxY+jb80NFpdhMdKp6rjMxfgWrUX/i05oPaYUJ6m57F/yeriffb0SzJg5rXQOyzHDIDsHYx2Mkz2fYZUMqv8aEH2fYiCMxVITekPl0uIhPaC9ILbjGtIXbGmukxCqL8s+EjCChwdjgTaBGbmCzX0+t5Ro8Fd04oohXGgf8sPjGrPt9k4ZnZfJdwaT7jQP6WNLr4ZywkPTrX6/nGeevAG/iWP15h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199021)(478600001)(316002)(110136005)(66556008)(66476007)(66946007)(8676002)(9686003)(186003)(26005)(6506007)(6512007)(83380400001)(6486002)(4326008)(38100700002)(6666004)(86362001)(2906002)(8936002)(5660300002)(82960400001)(41300700001)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V9o52E1fanoaQRkHiRQH6WPRDG6drCtJIEWgEoaMxT2o5XN+HZSnkoPiRJFv?=
 =?us-ascii?Q?8c0TmNEdTqdJULbtHSchMW2rfoa60kwOzsMELfz1+tg5yeu6UQuR9vGHqwb7?=
 =?us-ascii?Q?EQ2zYGHk/x8WIm+SCqXmcHnm8Dmcsd8MvUP4+aDLtLt7aSephexuVo6wSF3K?=
 =?us-ascii?Q?6Fg8+aPxlx8GUv2OgvKJecfYzi9fIDbhLTskCN7/5f5nLWUzpDhrlWDl5egy?=
 =?us-ascii?Q?IPGTJ40mNZzWtxIPhg4amRq9cATHGWakD58E6Pwzn4Aq5w+e8HUdQYW4TTQm?=
 =?us-ascii?Q?hat8phHswi1E/Oincg8dMZhGA8nwEnHt43XgmXKaF18Ztg8vNj6ftr2yehFx?=
 =?us-ascii?Q?cdApMNY5bPulxB/dJ8M8Ny99PcLbxCFyZ69GpTuRRKec38zzgkdW+qLGF0eB?=
 =?us-ascii?Q?CPGNbAb0jDLQALxrh/5Bi5BBSryH5Au1JTdxlB9IW+dQ5vL9Izq7TDkANlnf?=
 =?us-ascii?Q?2hGN99224qZj9HYA1pfMK9PI1KrkCwuV4bxsWD0Lyl21/4rGgjuitV0u3M/q?=
 =?us-ascii?Q?cm3WinvpY66qpQzLKA3WjyBYe6WQy0+6ZpasbtChdSu2TG5GchteAEViUV5S?=
 =?us-ascii?Q?21gWsb5sxQOTmRlutKfUlYQKp4ksV78roT5FyxaXASrw6I9/cuys9DpP/taQ?=
 =?us-ascii?Q?XciHRsU7M0N+ZXMAPaiqCA8yE0HsGrUHX7Py/C2Fpsy1HvhgfUbTi494M1j1?=
 =?us-ascii?Q?lBGlHONWoB5Xdi++xEYcoUfOzfM5qydshdaX1ZPQLru3ciQoPBGOF6u+TSNj?=
 =?us-ascii?Q?fh5fef2VqV5lvQMNCYfrI+weLCpIcNYDTJesDAhkBVtmkl317jPBOqE4OCeG?=
 =?us-ascii?Q?yIgr8zU3wMvUYkr46oKwyai68FrNMc6NZFlmoliV0FpbH+R559Bttu6P7iPr?=
 =?us-ascii?Q?F1QUZgHlUCa7n2rPQm9ouZyOFOf6g/4v18YzQDu7o6xDou/K+WD6/bGNDZ0k?=
 =?us-ascii?Q?cN7Zw9D5eN+gZJwedyOzUnCmx6naKDDnZzzg6YaYrbkXY8rnR5+On78wQkgO?=
 =?us-ascii?Q?QaVl7hLhXM6Rmx9yRI8kw3fa+c+RDfJWSvgh7otcsKaj/k5BHOAwMJVZwAnl?=
 =?us-ascii?Q?Uflp1EfPY463DOu42pECzlY9gwKgnkJ1375iCkFymRSsS38e2a8nFsLr0tZ9?=
 =?us-ascii?Q?I6kZbesPS6PjVU+PiDgdG/Dxn8Isi5V9uMqcuvOL93CmuYpnN4+9jN0maj8O?=
 =?us-ascii?Q?aqQeXv9jU19T0VmtS8dvyMrLDV0ebfkp1ZQgownB0/CKtfxmxqisbPHI1Lv4?=
 =?us-ascii?Q?q4kwBCguIlwzqOqinqdxQ/ikZgZHtHyFdaia6C6uCUg9L1p6ptYm7mCCCb52?=
 =?us-ascii?Q?jVCLIZ4+H0/AkqOM0MODgOPy0S9y5NGfk9IaGpMi/J881xe9GbCb2bHOlrez?=
 =?us-ascii?Q?b4KLkyAnIgLYGiGl5x+qM7zBwTCEwkqVnBBkmoc9UoRgZYraDSfmQUD+9pky?=
 =?us-ascii?Q?nKc0Ha6rXiU5KqSqillrkfSue/m4kRF7F5Lq/3H8y0s3rAwGbBrOauTFFOnY?=
 =?us-ascii?Q?16fLyqpVAF9yy2BHKlj4d1neULAWC7sHo/D4dUHtE18egJDDVKWtLgp6CoO0?=
 =?us-ascii?Q?KVERe8VqDTMfOdlb73UuUgQKryB7TRWsv9N2hFgFcFZiN9qUDfSUGAWcMDBI?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c8ecd1-ec7e-409f-376e-08db360df664
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 19:43:00.1174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TO+xqSlch1nmI5j21JHBup/v3t6Bxu7zlxqL3tvJMmQdA/3o2Q54tjolSpOLglNbGB+VtyNBYiQbudS6uQxt4icjRb3ndHat+kOoat1riMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6243
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox wrote:
> On Tue, Apr 04, 2023 at 09:48:41PM -0700, Dan Williams wrote:
> > Kyungsan Kim wrote:
> > > We know the situation. When a CXL DRAM channel is located under ZONE_NORMAL,
> > > a random allocation of a kernel object by calling kmalloc() siblings makes the entire CXL DRAM unremovable.
> > > Also, not all kernel objects can be allocated from ZONE_MOVABLE.
> > > 
> > > ZONE_EXMEM does not confine a movability attribute(movable or unmovable), rather it allows a calling context can decide it.
> > > In that aspect, it is the same with ZONE_NORMAL but ZONE_EXMEM works for extended memory device.
> > > It does not mean ZONE_EXMEM support both movability and kernel object allocation at the same time.
> > > In case multiple CXL DRAM channels are connected, we think a memory consumer possibly dedicate a channel for movable or unmovable purpose.
> > > 
> > 
> > I want to clarify that I expect the number of people doing physical CXL
> > hotplug of whole devices to be small compared to dynamic capacity
> > devices (DCD). DCD is a new feature of the CXL 3.0 specification where a
> > device maps 1 or more thinly provisioned memory regions that have
> > individual extents get populated and depopulated by a fabric manager.
> > 
> > In that scenario there is a semantic where the fabric manager hands out
> > 100G to a host and asks for it back, it is within the protocol that the
> > host can say "I can give 97GB back now, come back and ask again if you
> > need that last 3GB".
> 
> Presumably it can't give back arbitrary chunks of that 100GB?  There's
> some granularity that's preferred; maybe on 1GB boundaries or something?

The device picks a granularity that can be tiny per spec, but it makes
the hardware more expensive to track in small extents, so I expect
something reasonable like 1GB, but time will tell once actual devices
start showing up.

> > In other words even pinned pages in ZONE_MOVABLE are not fatal to the
> > flow. Alternatively, if a deployment needs 100% guarantees that the host
> > will return all the memory it was assigned when asked there is always
> > the option to keep that memory out of the page allocator and just access
> > it via a device. That's the role device-dax plays for "dedicated" memory
> > that needs to be set aside from kernel allocations.
> > 
> > This is to say something like ZONE_PREFER_MOVABLE semantics can be
> > handled within the DCD protocol, where 100% unpluggability is not
> > necessary and 97% is good enough.
> 
> This certainly makes life better (and rather more like hypervisor
> shrinking than like DIMM hotplug), but I think fragmentation may well
> result in "only 3GB of 100GB allocated" will result in being able to
> return less than 50% of the memory, depending on granule size and
> exactly how the allocations got chunked.

Agree.
