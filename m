Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF352780BE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 14:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359452AbjHRMg3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 08:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352515AbjHRMf6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:35:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9D5114;
        Fri, 18 Aug 2023 05:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692362156; x=1723898156;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=tvkmuMSVZHLiYWb47gQseqr8+QNBr0JinaLtH/VjfEM=;
  b=XdZBIEwAbC7Ug5QEj6zGnwylL1qPaArHfwBBXylh6+DUQhboq146uU07
   xBb6ecayB4ARUZ3RK58SohYONDLMXym1L8uLBzo2sJTQKersYA4c6tKgj
   l+aiMp2qBLjFcDVq4Kp3M3QZ6zlgper7NByMLrLpBmKtJ6nqc8/on1cFz
   RSkB/fh0NMNJVokSRgitc00CDTuAEOBeJYlkA7TqLscBXrVp3KfpC2XCy
   DdeHq1MWcaKeDlfzaDRw8/+FlIVXnKrvaxfQdPXel7QEkS84IxfYByjwO
   2TKu/a8upcZqRqZrCZxXHwkOHusBtFaJdALt+6Y7+F9XGj6ygwrHgIqpa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="352680714"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="352680714"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 05:35:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="764550261"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="764550261"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2023 05:35:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 05:35:55 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 05:35:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 05:35:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 18 Aug 2023 05:35:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpvIi0xgCRjBYbHh1uw+6cE9IHKt6yqkkohy9yuLLY7C0qJWiPb8iuTRK+vUKrGhgibmiUuXBRl2oJ9J4ZD32mXdvG2twxnIu+c/lCumF8UkPzu73VxzltOxcXD5EvnzNWsaxU+q2TR58IDOxWo1u1wzGjANtV3hQgD6K/IA85SEXx0q4loeIykLo62Zluabxx/BLWTwQADNGJOtqGSjEetiRHvj/lxJzL+wUrUYZn5Bs0QV3IRxA8jzQZeigpU6ztDTZ/OHvcfaiZhbSJkCo5p5WSXKnJDCGB5X6agv42OTjuqc7V0hLmk2uCRrIYXE1+GxIT0qeQzbrGshfrWLLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYTc6A+l3FRX9mNzY4ga6c59RjBNCCrBq4yWnFLLnAE=;
 b=Hrr/Z/tMn5wKLI4UkCGUpFK2amOc6KMer14dq/Nj7gkM8MpTsyBiuqQqiT/RDhfKkyjstgyHLphh9SIr8YBnFc0zq1oZs2Wb0LfoTA5CgFeCKcOaXnx6qCmVS0ociZeDLUjaA+X1zEuh9s1xpDVO3HoM6pGJEKhrDP3u+W3f7YIPNJ4ewucWtMAare3Qt31ZXSz2rBLngLje52CW/cKdjWwGmG4UjsUxcaN80HIaTg9pC84RYn8T1V3mpLv6w1ZCi2Y8O+ZhAtx+RkWR4Nie+i52i6IUO+OVq617ROCGxWLAjwBCzHxvTmXzlUo7pNDhzQFc9YIJQDVbniMOf6frIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by BL1PR11MB5980.namprd11.prod.outlook.com (2603:10b6:208:387::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 12:35:51 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::589b:22b8:e509:c001]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::589b:22b8:e509:c001%4]) with mapi id 15.20.6678.022; Fri, 18 Aug 2023
 12:35:51 +0000
Date:   Fri, 18 Aug 2023 20:35:34 +0800
From:   Philip Li <philip.li@intel.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
CC:     kernel test robot <lkp@intel.com>, Peter Xu <peterx@redhat.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        <oe-kbuild-all@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        "Suren Baghdasaryan" <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, Greg KH <greg@kroah.com>,
        <kernel@collabora.com>, Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v32 2/6] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <ZN9llmDir1wow36T@rli9-mobl>
References: <20230816113049.1697849-3-usama.anjum@collabora.com>
 <202308181520.yCq9Z26w-lkp@intel.com>
 <ea2af063-67da-137b-1dc4-bace40568187@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea2af063-67da-137b-1dc4-bace40568187@collabora.com>
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|BL1PR11MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: 52900f0e-eab1-4f0d-9501-08db9fe7a804
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ncnM8FQRnAHshajrQBuSsqoPboJXQHPUZ349/chPilKFgB9G4A2X2pXGwBlLhnqOxw4fXJ2Td1Xg/eGcnLEr7dFKeqpA+gguFaYAwrUHjHhCZJFojlqkvi78AQM3AX0/p1W3hL32ZS/7l18RVzZLHQpklUtv281LfFB5rAmVBQ7DFU7E45DiWGezbZk3uuYed0xDNG2UQpjaGQq+WBV28WgZPLLKaM0J2KhnrkXLZZMqfL/HiuhrfOXEO75+UOThaaHFXu5oBreMtzcBAiWRuwkE9fpnJ2kWzjd43kcdVRmVulUjIUo/+YK0bl20h1Cb8xtTgkq4kIZcEh9oy0/zkSLPlkF4mbmFuppVj0gVFMrdmbCgIw5tdw2cljC3keZKjCBNrMird4JzpQLjnmNZ86ErP14Ol7e9/JNRJeuZ/vy913dJc9z2Rd9Szxhugh7Y1nh80iPGjPe4mbp1FAgodfewezPdO9slNRCj9RNHN1QC5ukhDkuTP+U/QMhKimPZt8QSIUkSslPIPWxDvfbdQfEIcigquuBOpYla/cUNt0Yysm4CeXtFjlXmiU7TyoY4Pq42yHGFbbVHCnhBqPrSRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199024)(186009)(1800799009)(33716001)(86362001)(83380400001)(8936002)(8676002)(4326008)(5660300002)(2906002)(41300700001)(26005)(6666004)(6506007)(53546011)(44832011)(6512007)(6486002)(9686003)(966005)(478600001)(7416002)(7406005)(82960400001)(66476007)(316002)(6916009)(38100700002)(66946007)(66556008)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEJ6dU1hN2lsdGtCN3lVTlhtMzhkWDA2RzZFZlcyM2VjQk00TjFJU3RIZEo4?=
 =?utf-8?B?TURoTzg3ZW44SjhkTU9NUTQwNkYxbjJiOGpBd1Ruek0xdTFMVzcvMlBLTEsy?=
 =?utf-8?B?ZHBzalZnS0JuQm10N3FEc09DS1puV21OS1N0ZStMd2liY3R5Wk9BNjBySHlH?=
 =?utf-8?B?cTZaWXl2TXB2SmRmYUJYV2RuekNiME1Ua0oxTEtVaURQUmZaMGZEdGRuKzg3?=
 =?utf-8?B?UmwyQ3U4SFVOM0RzLzlBSVZ0aHVGVEtGdXUzK250QXFXclJDK082T1MwejJo?=
 =?utf-8?B?bzgvNkkwejFpakxRL0o1RXFReWhYYlZwRFZsVDRKZzZ3dEJSYnNhdi85bldO?=
 =?utf-8?B?b1dzZVVZTFU2OHNQRllqK1g3VkxPWEgwN0t3Qmplb3VGOFEzcmRLS28yWmRY?=
 =?utf-8?B?bWd6QU1JUFVBSjRhajVER0JzVTN6cU9BQkNQUkhyYTkrNTVhckxDM2NxQXpW?=
 =?utf-8?B?OFk0TUN6UFRRQ3RObTdxUWQ1bVZDeitnbU41MVgzQ3Vlbk1lVzI4cHhUODN1?=
 =?utf-8?B?YUw4NUtnWlpwWVlGNzU2YnhTNmY0eHRRYnpvdXIrYlcwOHVkc3dva2VYdDhS?=
 =?utf-8?B?MEg4cHJOTjZkZzFBVkxkN1MwTmh2dnBuMTh4ZXV0dFhyemxpQXJvRzZlak9V?=
 =?utf-8?B?RUZUU1pYa1EyM2lCQXpINXBvTFRzQ2JUaktaRFdwZWpFT2VzZ3BVc1BxNGti?=
 =?utf-8?B?WjNDbithb0ZFOVkvRXZTTWpXSlE1UUdrQ2hlOHJmVFRvNlo5RFdnVU00amc5?=
 =?utf-8?B?REVwZGx6dkxQTzRWeXQ5SUdaVzI1dlF5VlF2bVRpZGpsalJQdk5USUVzQk42?=
 =?utf-8?B?K21qNnR2S25abjMwOG5RakcyRDNGSUhWcnVHUXR5OEdBbU5CcndRTkhMbHJx?=
 =?utf-8?B?elJLblFidWtQSzZyd2NheklqaHFtcE9OMjFLTTJaRmxvQjlBOCtzTXhLMVNj?=
 =?utf-8?B?VnZxekdDVW1aRml5R3VsSWxlWkxpWGc3bWcrVjVXWXVydTQwVGRRa1U3NTU4?=
 =?utf-8?B?OHZsT3ZsMUhQcUhoR3NMR0J5RzNHSGdZcnBEL3ZnQVpKcVJNVWRVRWFnb3hC?=
 =?utf-8?B?dWN4d2cwd0QyZlJjbWI3N0pDdXV1WWlWbU1ZOHRXQkdvREtwMGUzc292VXVr?=
 =?utf-8?B?YkVzLzMrbkUxeFJsQ3RSbU1LU1RPSXhOS3h2NTVrdWlBYmtpUnloMFlaV2RX?=
 =?utf-8?B?eXJTb3ErblRhS05KSUM1S0hpVEpxSVcvc1h5M1RrMkFYMSswamwvWHJzUGVo?=
 =?utf-8?B?eStKeG9uQk9mN0VsQ1lNNjd3dGtMSURoV21qaWh1bDduOGFwc0paL3Z4dGxI?=
 =?utf-8?B?SWh4TFJEdWZ2U1RxZnpqKzJ0ck9EL2crb0FsY21IUlJBRlc1TjhQRmRjdm5u?=
 =?utf-8?B?K2FDdUdEQWdMUXU0T2VpL1RYMnhYM2o2aCswdU50K0p6ajhLcVdaWjIwM1NW?=
 =?utf-8?B?T3NraytMcndNZ3FsNmU0SU5ZTitmbWdkZG5yQVVPNmJObHpqS29XaUVrOWw1?=
 =?utf-8?B?THIvZXZxL2w1TEUwVW01dEpoTDV0ZGNTaEpMeHUzZVptc3hWNDdRVzdFVldZ?=
 =?utf-8?B?eGw1UTM0eUF0NUtWOTIxUWNKQ3JrMTVsMXBpVGZBMDBySEdmcWhTR0VhUith?=
 =?utf-8?B?aURtUlJZSUx5VjlTcCtPYkFyOUdvelNHdVgzditjZlB0VktIbGZzZFhTMGt0?=
 =?utf-8?B?MU14UXJPN25XS1E3NUtLRnpkRU42TUZNVElLNEJJc0d5ckxQWEpXTmVtQi91?=
 =?utf-8?B?SGNsUkxTMFNHZ0NoMUFwYnhHbHBZQTloeVZpQmhXZENVM21vM213aHBTOVI0?=
 =?utf-8?B?eWsrYUtOUXB6dS83cXorK2p5NTJNMW5SOCsxYjI2cWZlb3JKTm9VOXJzNEln?=
 =?utf-8?B?VXh4eEkvbmdDSERpbGxoVytGL0ZYN0tCYU5FR2xYWjFIem1SZTZiWTJYaTBh?=
 =?utf-8?B?WW5JVXRvVW4rb3BLbmVURVBHaFcreFlOM2IzbjIxRWViRy9lOXRNYzkvMEta?=
 =?utf-8?B?ZkZUNGxaS3F5TzVVUXBYZm9qQ1RLcXNqaGVEaFJZWjV3bm9PZkFEMTVxME1l?=
 =?utf-8?B?UWZvSk9vWEV6REY5QnU2NnYybzV4cFNUMzRnVldtdXpsUlJZSVltQmp2OGY2?=
 =?utf-8?Q?TVXSEOJvdbzlL/Tq0ax0V4JEa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52900f0e-eab1-4f0d-9501-08db9fe7a804
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 12:35:51.2131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NIm7wpnICP0Ksv6u8yoCwDwvcPcuvzY57EDlYfeBybApAwZvBfmikYqdWv3IASCuOj5bwXMnJ3YxEdO8sQrhdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5980
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 18, 2023 at 02:55:36PM +0500, Muhammad Usama Anjum wrote:
> On 8/18/23 12:16 PM, kernel test robot wrote:
> > Hi Muhammad,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on akpm-mm/mm-everything]
> > [also build test ERROR on next-20230817]
> > [cannot apply to linus/master v6.5-rc6]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/userfaultfd-UFFD_FEATURE_WP_ASYNC/20230816-193454
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> > patch link:    https://lore.kernel.org/r/20230816113049.1697849-3-usama.anjum%40collabora.com
> > patch subject: [PATCH v32 2/6] fs/proc/task_mmu: Implement IOCTL to get and optionally clear info about PTEs
> > config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20230818/202308181520.yCq9Z26w-lkp@intel.com/config)
> > compiler: arceb-elf-gcc (GCC) 12.3.0
> > reproduce: (https://download.01.org/0day-ci/archive/20230818/202308181520.yCq9Z26w-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202308181520.yCq9Z26w-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    fs/proc/task_mmu.c: In function 'pagemap_scan_thp_entry':
> >>> fs/proc/task_mmu.c:2077:28: error: 'HPAGE_SIZE' undeclared (first use in this function); did you mean 'PAGE_SIZE'?
> >     2077 |         if (end != start + HPAGE_SIZE) {
> >          |                            ^~~~~~~~~~
> >          |                            PAGE_SIZE
> I've been emailing arc maintainers for resolution of this error from April,
> but nobody replies there:
> https://lore.kernel.org/all/0e6b318a-bbf8-3701-00af-1802c6347897@collabora.com

Thanks for the info, we will update the bot to ignore this error
to avoid duplicated reports.

> 
> >    fs/proc/task_mmu.c:2077:28: note: each undeclared identifier is reported only once for each function it appears in
> > 
> > 
> > vim +2077 fs/proc/task_mmu.c
> > 
> >   2044	
> >   2045	static int pagemap_scan_thp_entry(pmd_t *pmd, unsigned long start,
> >   2046					  unsigned long end, struct mm_walk *walk)
> >   2047	{
> >   2048	#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >   2049		struct pagemap_scan_private *p = walk->private;
> >   2050		struct vm_area_struct *vma = walk->vma;
> >   2051		unsigned long categories;
> >   2052		spinlock_t *ptl;
> >   2053		int ret = 0;
> >   2054	
> >   2055		ptl = pmd_trans_huge_lock(pmd, vma);
> >   2056		if (!ptl)
> >   2057			return -ENOENT;
> >   2058	
> >   2059		categories = p->cur_vma_category | pagemap_thp_category(*pmd);
> >   2060	
> >   2061		if (!pagemap_scan_is_interesting_page(categories, p))
> >   2062			goto out_unlock;
> >   2063	
> >   2064		ret = pagemap_scan_output(categories, p, start, &end);
> >   2065		if (start == end)
> >   2066			goto out_unlock;
> >   2067	
> >   2068		if (~p->arg.flags & PM_SCAN_WP_MATCHING)
> >   2069			goto out_unlock;
> >   2070		if (~categories & PAGE_IS_WRITTEN)
> >   2071			goto out_unlock;
> >   2072	
> >   2073		/*
> >   2074		 * Break huge page into small pages if the WP operation
> >   2075		 * needs to be performed on a portion of the huge page.
> >   2076		 */
> >> 2077		if (end != start + HPAGE_SIZE) {
> >   2078			spin_unlock(ptl);
> >   2079			split_huge_pmd(vma, pmd, start);
> >   2080			pagemap_scan_backout_range(p, start, end);
> >   2081			/* Report as if there was no THP */
> >   2082			return -ENOENT;
> >   2083		}
> >   2084	
> >   2085		make_uffd_wp_pmd(vma, start, pmd);
> >   2086		flush_tlb_range(vma, start, end);
> >   2087	out_unlock:
> >   2088		spin_unlock(ptl);
> >   2089		return ret;
> >   2090	#else /* !CONFIG_TRANSPARENT_HUGEPAGE */
> >   2091		return -ENOENT;
> >   2092	#endif
> >   2093	}
> >   2094	
> > 
> 
> -- 
> BR,
> Muhammad Usama Anjum
> 
