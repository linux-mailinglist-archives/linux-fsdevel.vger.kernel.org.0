Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A667AE383
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 03:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjIZB4a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 21:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjIZB43 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 21:56:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E72116
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 18:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695693382; x=1727229382;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bDxo79vISUGmqilgGArHT37rFEIyYaJ5H8wiQ9yrBIs=;
  b=hR4JzKxCeG1fZyp74rWDWxMYOmXzUvczzEeJfeEgGb96/1/IVITiDPHJ
   tA3fQTaJ+wECHaER/inbOSMXbZRYM4QPupV+CpTIOFWfyRkd5hXa8uZj6
   3wnNhw8RI/nbN3wLKch7o35EZSeKOEiyAB3u5DAjCajDQ1o6UHtJjkAet
   StGaN6a5YjsdqnIXEQmPWPktvDRhyBPmUbWk/6ngvw/zJFpQ1kozy5exx
   yUXwtm48P3PgItz/a09DqCSSDgH31uH/Hky4YIB/S+ZbGohRY9cpDtAwi
   ZvF0tvzop1AabOzF9LsMpONFqxnETNpntKHv4WwAIobJl6X8yOrdx4WY1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="384236164"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="384236164"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 18:56:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818860785"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="818860785"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 18:56:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 18:56:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 18:56:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 18:56:15 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 18:56:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEeelnw7wNBrMyWJjnZTGzecDMtEOmCGqSzKHqmW+3ceG7HPiZnA5GQCfHebH+1KPd0il9ucbphbtGNnaXD6jizqozclN6CSo445R+RAhqNCbcJ1b4oB2ZgmRmgl8F6cO9uCnJUDsFd0SRR+k/Lc+7cmNx/fZZLj/qTs5zEPeBWvfvQkiZ0S/vD8GD0xYxBp/+EDTw5SuVxBONhklZsjBagne8CPpLmFEYGVyYXkYM+1VUf6+w/ID7g70YNsXMf5p2eT3mqFiIEDaKLRzJxwOncewlJbJplYIq+hOTZmXDZh9LeH+cqFO+A3dGJot2HW7XE/KQ3LVlQ9t1Rhe6uuoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCnYwu7tE65Tl4cWOCZi49pD5Wp52dVT3fn9hffWcYM=;
 b=bvBb+wEUEey3hRTWC/IZwiR31IxYRTQ78c07MNvNOm1SRQX44y/qK21LdS9w2eQzGtkcQAO4VQ/JGrADa//s1optIP0g/qmyaJEKVZKCNfcT0Lfpks01LIO6cYt+fRZNdHFTe87nUZ2JV/a7giUELmMMzdBkIf9Z2BXWmeNeHKo7ALOlKEZXbcvh+w61bAd7COGES59HwFaBWy6raZRV51+Zcfme3bLjYVykQhNyDamTpJY28tQlOCplDkTKr9CyVjfENzB26YbXT/CYAtzagMXr+asfwB7qd0ohjy5XPzFLXC2DOKh+w+u2SB2S5hHjfl0h0KOd8N1kMCFCsPUOtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SA3PR11MB7553.namprd11.prod.outlook.com (2603:10b6:806:316::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 01:56:13 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 01:56:13 +0000
Date:   Tue, 26 Sep 2023 09:56:02 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Amir Goldstein <amir73il@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Reuben Hawkins <reubenhwk@gmail.com>, <brauner@kernel.org>,
        Cyril Hrubis <chrubis@suse.cz>, <mszeredi@redhat.com>,
        <lkp@intel.com>, <linux-fsdevel@vger.kernel.org>,
        <viro@zeniv.linux.org.uk>, <oe-lkp@lists.linux.dev>,
        <ltp@lists.linux.it>, Jan Kara <jack@suse.cz>,
        <oliver.sang@intel.com>
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
Message-ID: <ZRI6MsKeEgDnsyTo@xsang-OptiPlex-9020>
References: <ZQ1Z_JHMPE3hrzv5@yuki>
 <CAD_8n+ShV=HJuk5v-JeYU1f+MAq1nDz9GqVmbfK9NpNThRjzSg@mail.gmail.com>
 <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
 <ZQ75JynY8Y2DqaHD@casper.infradead.org>
 <CAOQ4uxjOGqWFdS4rU8u9TuLMLJafqMUsQUD3ToY3L9bOsfGibg@mail.gmail.com>
 <CAD_8n+SNKww4VwLRsBdOg+aBc7pNzZhmW9TPcj9472_MjGhWyg@mail.gmail.com>
 <CAOQ4uxjM8YTA9DjT5nYW1RBZReLjtLV6ZS3LNOOrgCRQcR2F9A@mail.gmail.com>
 <CAOQ4uxjmyfKmOxP0MZQPfu8PL3KjLeC=HwgEACo21MJg-6rD7g@mail.gmail.com>
 <ZRBHSACF5NdZoQwx@casper.infradead.org>
 <CAOQ4uxjmoY_Pu_JiY9U1TAa=Tz1Mta3aH=wwn192GOfRuvLJQw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjmoY_Pu_JiY9U1TAa=Tz1Mta3aH=wwn192GOfRuvLJQw@mail.gmail.com>
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SA3PR11MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 6126c56d-3f04-41ed-937f-08dbbe33c379
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AbpKzNbHT2lCKWcTL9fVhZWcYQx5ocytSnI+MawxK/IXD9ww6s2feAqs+2hKUPrwYXs3ZdG9vsyrw//1w1jY0GMlQVlr+kDRkSI91DJi6Ow503PXYSqdUvVojImuOUOx0FrYqf1tmQU3rdW1kXpxi35SHLIP/t7999SNkFzSr+yKoYT+emuyDA4YUf/jF52GhVEAp/wYrtpP4dzg5YIitQ/OM7YrM/s06DeQ5/1DDS3W/oSxf6qAlj0qldN/XLG88DZVY6pf0ww9h9NkImKpB4Ij4U2LkqXVSsX2d+XlGksebrc7oERwo/EAhxEHmAQmhTvg/3O/WY9v2noDkRYivztMJK6+iPUYqhxPaFRs6xBaKZVDsolIVWFE4aqowuzoSfuQ1Pc2mdTAnN0g286xOvu3exJ3qpMmaspbkDjPQr6FRQOcJXk8N1bGsalZsztHfB5JnjnoQVIBy5fr8U576I0wLFgTChiM4p9nk2KnTZsRoAFrh2l2/5CimoynaYwi0LUSjpqdNC7IBtKqbzxuJcIWRuqG+vmSmLhBBuZwPT8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(366004)(396003)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799009)(41300700001)(316002)(8676002)(54906003)(66556008)(66946007)(66476007)(6916009)(7416002)(6512007)(9686003)(8936002)(2906002)(4326008)(44832011)(478600001)(6666004)(26005)(6486002)(38100700002)(6506007)(53546011)(83380400001)(5660300002)(966005)(107886003)(86362001)(82960400001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmlMQ3o4QmtPNVhwUVk0Rk1yZ2lqU1pIZjBqbnVnOUJJUVhPL01UUU1SNmw2?=
 =?utf-8?B?dU9ZRjNobC80d2VTV3hRQkFxS2JBdk40UXk5SjB6MThWcWFqdDBuRlYvb1l6?=
 =?utf-8?B?K1lOMEhwTXVuYlArZHlLNzgrcVcweHBSZGJ3R3UwVXBJUEZDWXY5eTlvQmVW?=
 =?utf-8?B?YnRabDNtQWxBOFFqS0dkdHpXOEppSlZqclNQMC83TkVDSC92SitlU3k2SHpm?=
 =?utf-8?B?b2pUUHVJSjdXb0tyV1hWUHFGbnZiK21WN2dBUTJIZFdBMGJWSnFvcUk0YVB2?=
 =?utf-8?B?aS9FaWdSUkw0SGYzU3ZFM2RnU2taZ0pyRWw1WklvVFhIUnhObnZyWGJtZ1RI?=
 =?utf-8?B?TXhXcHl3QTVwRnNvNU1QMEhya0lqaHFuSDRITHg3bVJNMFc5cFNWTXhaV29M?=
 =?utf-8?B?aXJ5b0ZlQktnVjZTMWZ1VERrTE85UWJzTXNRcDczMkN2Z21pSmxac2UrNmtF?=
 =?utf-8?B?NFpLSk03cUdHRmJjUEFPd0wxc09zcnlGZW5GL0pmd1gzaXlJN0hZUUhua0gy?=
 =?utf-8?B?RHAvV2tyZmRWK2FRamdSYVpBd212WTFNdllhczdIMUVxVUltTlBpUjNmQk1r?=
 =?utf-8?B?N3dzMnBwenhLWkJOeWhnZ05IcndtL21aZ2lUUzFtQUVoOXA1QWRSSHdOaldv?=
 =?utf-8?B?OGVWS29maTR2eDh4T1FEU2JnR05ES2dzdVQ3TDcrdjcxUktNeURFYUZNR1R0?=
 =?utf-8?B?WlZnNUxhajFUeGJsVHpvbU82cG41Z1hmeXBqTm45d0N1M2d1N08wTkk1SWpv?=
 =?utf-8?B?TmdJbFF4bmgwd1R1OHNKRjR6L2p2Y00zc3kzK2lJVDNpMWFUZHd4VWQrWjFF?=
 =?utf-8?B?WUpWbVhnRFNLT1NMR1lLNXVFWCsvQ1l5YnhoWGZrQmZvMldMYUhKdkF4NU5K?=
 =?utf-8?B?UWZZeU05azVpMTBnVGR3c1dXOTFTUmFvbFprS0dzc2hkclE5ay9pUE92TnJD?=
 =?utf-8?B?aWRGeXVpR2hKSkdERzhTNno0M1RweWUrdzFXRUdTYWd5R2NkT2hhaXE5ZFlo?=
 =?utf-8?B?S241a3dzWndsYlBJbWV3cmlQeUpFOWdXRjZXeU1LSkI2K3MwUXQyZmpOMkYr?=
 =?utf-8?B?SWhoY081TjhRcGJnQkhGNXF5TnBDcERSYlJkT2VoaE9XM3IxUXFNWHdpQVVT?=
 =?utf-8?B?U0lGMENNc3dQWk1oRC9tWVFsZ3lnK3JzUmx2ckZVaWo1T1Evam1vdm1ZYWQ5?=
 =?utf-8?B?bFNmc1FCbzdpOEhvTHdJM0t0a1VHK1FYU01QalFCZXZBd1NNZG1Ed204cjJq?=
 =?utf-8?B?d3NQY2hVOC9MV2Juek9jSDFmOUJiTE5oZzlNYVdvS2pnS2dEdWFJbVM5VEJP?=
 =?utf-8?B?Z0tXYk5MbHhsWmowa3Zhd2hqQVpHbVF2empjT1lvRTBFR3VWdkR2dTNTOTdO?=
 =?utf-8?B?ZW1mVmV3b0lyMCtaVWJHMk1rMHF6Z0s2VFZySHJFa0x2eXRvSEY3akpBT3NM?=
 =?utf-8?B?UnlMYmdmR0RDbFN2aWViemhqMDc3TkFRVmNUSHlNWTJjcEU2TkFDWk0zdWpX?=
 =?utf-8?B?NkpFY1RuMXgrcGpiekEyUHBJM01Qclc5ZzVjSTF6ZEFySDBGcms5VlZzUDBu?=
 =?utf-8?B?dkF3SUZzc3BCdTFvQjdadUUxdXlIbWN1eXNjU1U5eDFtemV3ak1wbWN3NVFN?=
 =?utf-8?B?cnRETWZlMTJDeGk3Z2c2Vmh4ZTFob0J4V2UyOTZRL1RGek1oQ3hNUmFVTVQ2?=
 =?utf-8?B?TlNmbG5JM3dISXNZdjZkZzFldHBIR3RJaGhyZ1NmeWdCbEVlN2pSc0k2aGJK?=
 =?utf-8?B?bmJBc2lJV2xOVzQyQU9GUGVNZmZOdk1LaHRRVllQT2kvTnMvOWxEbGl2VFJS?=
 =?utf-8?B?ZnJ6ZWp1Z1J3MkVPOStBUWVYeXRWcnVveTZxS3MzMlRFV0FpSmo4NHNIcDFF?=
 =?utf-8?B?SXFlUWd2QmVBWkJ3RmtHcFcrVnlSNGdJc05nejhaU21NZERsVkMyOXRDb2g5?=
 =?utf-8?B?emJtVU4wM2RIYitSNW4vcDFaRVkrbkwyaTFoWlRoQVVSVmpLRExvb3ZyVXFG?=
 =?utf-8?B?d3ZCdFpWUHJPak1SbkQ0cXpybmxoZjZaQTZTRHZ6aHREM09ab3p5YUxycVIv?=
 =?utf-8?B?Z2xObVhMaVhpOWttMVRNNVE2YjIxdDN6T0U5aHJkcm0wVU1uRWJkLzJYOEQ4?=
 =?utf-8?B?ZG0yWm9QOHZqOUNmR0JWcmY2eEFXNk1OYkdRek1SeXlKVEl1akw0ckU0WXA3?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6126c56d-3f04-41ed-937f-08dbbe33c379
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 01:56:13.6235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFWIBm6vkirgqwsKUPjaO9K5iYd86aoaUqvecKG2B8TVsGIvUCCqQUmnWxaQ+jQyXdNLYo+uHh4I9I609Py2qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7553
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hi Amir,

On Sun, Sep 24, 2023 at 06:32:30PM +0300, Amir Goldstein wrote:
> On Sun, Sep 24, 2023 at 5:27 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sun, Sep 24, 2023 at 02:47:42PM +0300, Amir Goldstein wrote:
> > > Since you joined the discussion, you have the opportunity to agree or
> > > disagree with our decision to change readahead() to ESPIPE.
> > > Judging  by your citing of lseek and posix_fadvise standard,
> > > I assume that you will be on board?
> >
> > I'm fine with returning ESPIPE (it's like ENOTTY in a sense).  but
> > that's not what kbuild reported:
> 
> kbuild report is from v1 patch that was posted to the list
> this is not the patch (v2) that is applied to vfs.misc
> and has been in linux-next for a few days.
> 
> Oliver,
> 
> Can you say the failure (on socket) is reproduced on
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.misc?
> 
> I would expect the pipe test to fail for getting ESPIPE
> but according to Reuben the socket test does not fail.

I tested on this commit:
15d4000b93539 (brauner-vfs/vfs.misc) vfs: fix readahead(2) on block devices

below is the test output:

<<<test_output>>>
tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
readahead01.c:36: TINFO: test_bad_fd -1
readahead01.c:37: TPASS: readahead(-1, 0, getpagesize()) : EBADF (9)
readahead01.c:39: TINFO: test_bad_fd O_WRONLY
readahead01.c:45: TPASS: readahead(fd, 0, getpagesize()) : EBADF (9)
readahead01.c:54: TINFO: test_invalid_fd pipe
readahead01.c:56: TFAIL: readahead(fd[0], 0, getpagesize()) expected EINVAL: ESPIPE (29)
readahead01.c:60: TINFO: test_invalid_fd socket
readahead01.c:62: TFAIL: readahead(fd[0], 0, getpagesize()) succeeded

Summary:
passed   2
failed   2
broken   0
skipped  0
warnings 0


BTW, I noticed the branch updated, now:
e9168b6800ecd (brauner-vfs/vfs.misc) vfs: fix readahead(2) on block devices

though the patch-id are same. do you want us to test it again?

> 
> >
> > readahead01.c:62: TFAIL: readahead(fd[0], 0, getpagesize()) succeeded
> >
> > 61:     fd[0] = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
> > 62:     TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);
> >
> > I think LTP would report 'wrong error code' rather than 'succeeded'
> > if it were returning ESPIPE.
> >
> > I'm not OK with readahead() succeeding on a socket.
> 
> Agree. Reuben reported that this does not happen on v2
> although I cannot explain why it was reported on v1...
> 
> > I think that should
> > also return ESPIPE.  I think posix_fadvise() should return ESPIPE on a
> > socket too, but reporting bugs to the Austin Group seems quite painful.
> > Perhaps somebody has been through this process and can do that for us?
> >
> 
> This is Reuben's first kernel patch.
> Let's agree that changing the standard of posix_fadvise() for socket is
> beyond the scope of his contribution :)
> 
> Thanks,
> Amir.
> 
