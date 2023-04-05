Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA0C6D7393
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 07:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbjDEFAN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 01:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbjDEFAL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 01:00:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A372D72;
        Tue,  4 Apr 2023 22:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680670810; x=1712206810;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=BE64LDpjc7W63Ye+zQhJ1yk9DDYxSGm/2fwHvUEpl6A=;
  b=eDKL68iM2A1b4mRe7fr2VgCFoO1OtL3aoW1aXxcxbFVDw0jo11+zL+/M
   DVDTCh7zvu2xxjvSaBb+GLdNS1aO3OePwNO9uZoUNSZnNbgbZYa2ZrPqf
   gIpC20LuFYd5hH4whkFdPzfnT/wFhP2Jmzb3ePGmsJLvarFCX08C6cNps
   BrIU7ll3Klyzxv0Dc8EbhsWnUCidq/uPjVWUFFdZjVgpU/u+m0VPWoVeC
   F1CAs67h/FGJfziXwTHdI6a0nD4wluCmciAmRwK3jRK+GB5y67ZyFH0Ci
   vgaJ83bNlbxi3M27UqWFUG4UJ3SC62ide5RKsrf8HwlxEcDK7snjKX2+I
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="342389326"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="342389326"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 22:00:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="932692132"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="932692132"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 04 Apr 2023 22:00:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 22:00:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 22:00:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 22:00:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 22:00:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOt6rwM4gDW7e39RK8BsNCvE8WIS7P+jmaKnU04wiSaahFFbm3S4RpL9Q5Y5VybH+QDUN9sdoaL8ejJrctqeVWEdN2BLzEzo1a1BYbbl4fAZ267t1X+WXZBSg8c8jbCvUxC/qcICPQYbLDBw1q1EopVb4u2bSr5BWB+j4tLWlAM2QoOBV8pXOSjT+yC5puCHVyXuUgqzQiTWQMIdmvKTkmwIkHRZ41RlRyZIzG8cg6XqnO7oYrgqKBhFMf7ntZIvMUeFlRnBJGtkgHx1BsgdGbU8+Z5zEOZ24AFjRQN3MY/1hIJwSjaAzAJGVQkchKQGJMLF6n8E2HIwHEVLF3JM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5JFtegeAq5wSlgp3Q+gFes3ura3rIKm7IRevrgZC6s=;
 b=nVtz1SdI2+ttXezXlTV4XI1G5W8A7i4L7cyWxeu/ocO5NWJbDKb2fvFd0u1rAPkxS9tcFiI92Cg5j0G2cNW0KPoHN7hv86Tkqd25e3/APHsPKEArT5XA6apRbL6LtPcCFXFXKitd1rCbc0rEmnDgxfFTWJCje1or11ZdYIuL71LqldfSkzxazX2xEooudel6aYX4LKSTC87Vd4iAY4giafyB8ZkWismFAZqmTWB51yqHfEH5G4RQB9f5ZLiJmSSF9jhCMIkeoOu0S4L1PvwwVE+bEDBsfFNHfZb88LImZLUD0r3RtbY7uEV3jCVcK5p0eN9lb5PXyoCvgy2oQBO41w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6517.namprd11.prod.outlook.com (2603:10b6:8:d3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.35; Wed, 5 Apr 2023 05:00:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6254.033; Wed, 5 Apr 2023
 05:00:06 +0000
Date:   Tue, 4 Apr 2023 22:00:03 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Kyungsan Kim <ks0204.kim@samsung.com>, <fvdl@google.com>
CC:     <lsf-pc@lists.linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <a.manzanares@samsung.com>, <viacheslav.dubeyko@bytedance.com>,
        <dan.j.williams@intel.com>, <seungjun.ha@samsung.com>,
        <wj28.lee@samsung.com>
Subject: RE: Re: RE: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Message-ID: <642d0053afc07_21a8294b7@dwillia2-xfh.jf.intel.com.notmuch>
References: <CAPTztWYGdkcdq+yO4aG2C8YYZ0SokxhHQxQK7JmRxXLAuwV00Q@mail.gmail.com>
 <CGME20230405020631epcas2p1c85058b28a70bbd46d587e78a9c9c7ad@epcas2p1.samsung.com>
 <20230405020631.413965-1-ks0204.kim@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230405020631.413965-1-ks0204.kim@samsung.com>
X-ClientProxiedBy: BY3PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6517:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b2f4174-3b46-4eb5-b388-08db35929f75
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u9jEClCun1McMDJrHDfO6v77AfYc2cTXaVc/qbN2uU8rkAebn0SVY1MViqBQidwSbBTcXdF38BqTR8PrZN5x/eTNqhHPgK8vDHLWf0yC/HajRwrCO5zXbEYAyWMIS/8/iA+kAn055/O5j+rkKOaM1QS0LqfGdfRvCT3G3GOgwdsD1m8tn3++oqBxQj6IrtinvVSniyYmGhRC5tAUEKkLNoIsowEccVwWrd1cHo4hr0/zEQHbG3H0/EXsAs4NQiFuULs46F8JcUHoYuNTuJ+oVMdx4Ee/qWrs8p7cA87ufBNMg/aTEO6/zv8zWn4Te5bS5fF06esVt89Of/op48x3TACD3eXeBzA5YezTbDoYrL2hBKnCaE9AVTD8fG0MfCW5ZAE74WS2ST5DQC45migoruCUPmcf0CH7RE0cj9A225G9YYixUYFo/GFW1dMcYOL9JBnrur5lUz9SmYSv6R7CDKpCrX6Kaa8memQCoT6yDah4tJjyqXYSOrJVmS2g1hwO5NELldhvHiDKJ8kDAMjRn1nJXsyRHFeFms+mP7MggVUeNUiIFbN3WVKSM/9Sa9HKws7+edG2QdIlkyTbFN6TuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199021)(83380400001)(6486002)(966005)(6666004)(8676002)(66476007)(66556008)(66946007)(9686003)(26005)(6512007)(6506007)(86362001)(4326008)(2906002)(186003)(316002)(478600001)(82960400001)(41300700001)(8936002)(38100700002)(7416002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVhFb05HTmtMaDNRSC9KR2Iybk5oS0srZmNJRnVCWG00TEhIMkFwWmhnUkpx?=
 =?utf-8?B?Y0dRaHlmbXJjUm8xYnNvZFdjMFh2ZHZuSHlTRjVDcnZySmtyNlhXVlQ4RzFr?=
 =?utf-8?B?elJaMnp2ZTdQdjZlNFFvdU1BOTQyUm5pYTlOYXdlUlp2ZkpvY0RzMjNkaFVl?=
 =?utf-8?B?T1UxRFF3Y1JiSlY1d2VNaFJ4dUVxZjY0M1hKckw0NlBLcnFvRGFGY3lkTEEv?=
 =?utf-8?B?ZE0wSmVXTkRiQk5yT0I0RSs0YlNpY1NOR3Jsa2ZTZmFQRzc4Y1lxS1Q2Ymoz?=
 =?utf-8?B?bXRsMU1wZC85QUhyMkJGVk1nWm4zcEY3ZUFDSy9RUmF6eUdnM1czeHB4bHhj?=
 =?utf-8?B?ZXd0dTdYU25JZDU2NEU0T1pwcXZKd2J5alEvbm9EZEMzUWxCMGUwU1MvVHEr?=
 =?utf-8?B?VFZjSHV2WDgxUWxlSmdKdXRnQmtPT1pvcE1qSGl1eWxPRGptaUthV3pUU29v?=
 =?utf-8?B?QzBaMzVscFJrcmMzV0ROR0Q2cGYyMVhLQUxqSW5hNitVWkVNQ3lXVVErNzR2?=
 =?utf-8?B?NkIzSUxhMFpxeTRnbmdzTmZlUFJtNnY2YjNYNVgrRWpqUGtiVHdVMEJDSWxC?=
 =?utf-8?B?dWw1WWJQZnRsRFNORk4wTEhITVB3VTVLV1orbFJBL1RId2FLODRSNE9WYklS?=
 =?utf-8?B?cUs0NHlkZVcwdU02aDhwNExwMlJucDlrRWthL3BnZnFYUXlMQjh6dWVHd0hx?=
 =?utf-8?B?alFBRVZ5SUo3RGYrQWkrOS9YYnNRTmIyK2dJdDRVaUVFdTh4TkNVWDFnYzdT?=
 =?utf-8?B?Qk5SdkRNR0Mxek5nK2RtRFA2Q2kwOHhqeEpKcWd3V1haMzh0c0FpRUY5MVUx?=
 =?utf-8?B?bnpSR0FKRGRaNk5scjRMU1RUelNsWHdKNTRwQlFkMXVIZzZRM2xTVzBHSEJp?=
 =?utf-8?B?Z1k3MW1iY2JYR0xiR3lXVlllN0tqQXdWcFBpSW9yL1JyNDhiSmx0SUw1aG8x?=
 =?utf-8?B?ZWJvS2dkRC9MeStLTVpLcFhJdGtWZkZCbXBNWU1iNmlIOVdnTHpqR2k5dDdq?=
 =?utf-8?B?aVU5R3h5YWVocFR3U1BMS0U1dS9pTjg5WkVsRkxrQkpXdWhTd0RBNWVvNC9h?=
 =?utf-8?B?VFF3Z0tlVEY5VjgrL1c1WXhEUnRob0luWmJvSlk4dEg2RXZtcDBGYlNrZkdX?=
 =?utf-8?B?cFNGOFZmeUY5SnhQZU5uNjRqNVg3MnRBZHVBb3JZYk85a2doR2Y4UnpjNCtO?=
 =?utf-8?B?ZXExSVNnUk9yTU5LOXpXN1hueWJDcXlJN3pXVWxVemFWTkFQNzMyaDJhcll6?=
 =?utf-8?B?d3UxbmFTdkNQOGZZYzhzOSs0Zmc2SmIwTFo4cjl3OEZmNzNqWi9hY2lqQ0pn?=
 =?utf-8?B?ekEvMStaSWdidWdBcUVuZFpHL2d6TGZzTFVUSkh5SUp1MkN0ajBCZ3BBblJU?=
 =?utf-8?B?d1NpS1oveHNFSGxJM1c3RXNCNXZsRGJ0TmZSTDR4VDhBakFsSW0yRDB1a2FJ?=
 =?utf-8?B?Smp6SHlEeDloL2k5YU5lcGdqbDVsUWlQQytORnowNWxNSzVtZzBMWVlPaThM?=
 =?utf-8?B?MXYyZWEzL2dxUE12eXRkNGxzZ2c2UEl5alBBeC93WWRCaWlBOVRLUVdwUUoy?=
 =?utf-8?B?SU9rNUxnbFFpdmtMWHJtNEdtQUt0RGpBQzV6dnFNTmJFMjB1ek0xOFhxaTVZ?=
 =?utf-8?B?amNWVnhDemwreDBlQlEwYTBReVBUZ1ZmY2RmVWlEZ2oyakFOLzJpOGVDQVZU?=
 =?utf-8?B?Q013UHg0bFYva1E5OEk3ektadlFpNU5QbEpNQy9tSDVDYTB6YXBSWWtpMG5a?=
 =?utf-8?B?YnFHZG42TXpJZE9LWTdSQnNXWjRIRzFLN2F3VkxqNDJETktzNnFLRG42L3ly?=
 =?utf-8?B?RVhIL3JMRWhVRTlMejFJbyt6NVdDTy90OEtkaXBYZEZKbnlCMTUrb2FzczlC?=
 =?utf-8?B?Z2Q4MklaY2lUL0ZTR0JrRWRmY1h5QVVIMzZRL214SWFncDlQZTZ6bTY5YlBB?=
 =?utf-8?B?WUZ3dU93b3pZbmV6amY1bnRQOVoyb2hmOWdqUElyT0lhV3NTdG1NY2lUa29v?=
 =?utf-8?B?b0hyamd4ZUZFVXpMakJTOEFrTlNkdC9VcmJMYTFvVHdJZHg4eDVEeDFCNDdo?=
 =?utf-8?B?dkxYT0dQUUZhZ2FxbVpGMWZRRGZsb25PQ3FPQ2R4K2VZY1RveDFmUDdPL0JD?=
 =?utf-8?B?YVk0Q2Q1MWswck1wRUdKbU1jbHVpZnBsUmdOYUZzQUVtVWNjb0ZLWXRhTllS?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2f4174-3b46-4eb5-b388-08db35929f75
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 05:00:06.1723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RqfhtipCyUCse4+RTNgx7e1OCctI/d0R+PqXknp4D7w1jcFP/K7eu4spBopWRMAL/73L64E2TtV1ygHj1EWfDOMicKjyTuN+QC6pC5gl+Xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6517
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kyungsan Kim wrote:
> Hi Frank, 
> Thank you for your interest on this topic and remaining your opinion.
> 
> >On Fri, Mar 31, 2023 at 6:42���AM Matthew Wilcox <willy@infradead.org> wrote:
> >>
> >> On Fri, Mar 31, 2023 at 08:42:20PM +0900, Kyungsan Kim wrote:
> >> > Given our experiences/design and industry's viewpoints/inquiries,
> >> > I will prepare a few slides in the session to explain
> >> >   1. Usecase - user/kernespace memory tiering for near/far placement, memory virtualization between hypervisor/baremetal OS
> >> >   2. Issue - movability(movable/unmovable), allocation(explicit/implicit), migration(intented/unintended)
> >> >   3. HW - topology(direct, switch, fabric), feature(pluggability,error-handling,etc)
> >>
> >> I think you'll find everybody else in the room understands these issues
> >> rather better than you do.  This is hardly the first time that we've
> >> talked about CXL, and CXL is not the first time that people have
> >> proposed disaggregated memory, nor heterogenous latency/bandwidth
> >> systems.  All the previous attempts have failed, and I expect this
> >> one to fail too.  Maybe there's something novel that means this time
> >> it really will work, so any slides you do should focus on that.
> >>
> >> A more profitable discussion might be:
> >>
> >> 1. Should we have the page allocator return pages from CXL or should
> >>    CXL memory be allocated another way?
> >> 2. Should there be a way for userspace to indicate that it prefers CXL
> >>    memory when it calls mmap(), or should it always be at the discretion
> >>    of the kernel?
> >> 3. Do we continue with the current ZONE_DEVICE model, or do we come up
> >>    with something new?
> >>
> >>
> >
> >Point 2 is what I proposed talking about here:
> >https://lore.kernel.org/linux-mm/a80a4d4b-25aa-a38a-884f-9f119c03a1da@google.com/T/
> >
> >With the current cxl-as-numa-node model, an application can express a
> >preference through mbind(). But that also means that mempolicy and
> >madvise (e.g. MADV_COLD) are starting to overlap if the intention is
> >to use cxl as a second tier for colder memory.  Are these the right
> >abstractions? Might it be more flexible to attach properties to memory
> >ranges, and have applications hint which properties they prefer?
> 
> We also think more userspace hints would be meaningful for diverse purposes of application.
> Specific intefaces are need to be discussed, though.
> 
> FYI in fact, we expanded mbind() and set_mempolicy() as well to explicitly bind DDR/CXL.
>   - mbind(,,MPOL_F_ZONE_EXMEM / MPOL_F_ZONE_NOEXMEM) 
>   - set_mempolicy(,,MPOL_F_ZONE_EXMEM / MPOL_F_ZONE_NOEXMEM)
> madvise() is also a candidate to express tiering intention.

Need to be careful to explain why node numbers are not sufficient,
because the need for new userspace ABI is a high bar.

Recall that ZONE id bits and NUMA id bits are both coming from
page->flags:

#define NODES_PGSHIFT           (NODES_PGOFF * (NODES_WIDTH != 0))
#define ZONES_PGSHIFT           (ZONES_PGOFF * (ZONES_WIDTH != 0))
#define ZONES_MASK              ((1UL << ZONES_WIDTH) - 1)
#define NODES_MASK              ((1UL << NODES_WIDTH) - 1)

So when people declare that they are on "team ZONE" or "team NUMA" for
this solution they are both on "team page->flags".

Also have a look at the HMEM_REPORTING [1] interface and how it
enumerates performance properties from initiator nodes to target nodes.
There's no similar existing ABI for enumerating the performance of a
ZONE. This is just to point out the momentum behind numbers in
NODES_MASK having more meaning for conveying policy and enumerating
performance than numbers in ZONES_MASK.

[1]: https://www.kernel.org/doc/html/latest/admin-guide/mm/numaperf.html
