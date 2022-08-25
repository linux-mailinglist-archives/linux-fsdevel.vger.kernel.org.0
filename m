Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF6D5A1987
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 21:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbiHYT25 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 15:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiHYT24 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:28:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E37BD770;
        Thu, 25 Aug 2022 12:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661455734; x=1692991734;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=1KICcVJCBqyEk3It+OxuLPa7j5f7j8x0cDuvsHPNHf8=;
  b=ZOyg0QQOkPmpLmCSn1KCP4A8m/OaxWyOCdsgktmN444Kv8t+bdsgwol/
   IA9dH52I7OofVdAPsHmVpEDifT7rsvhiYQnJvsksHjbeKnOVNjP3xrnld
   DnrLmTccQej987iEO+EdhL2+q3KpH1ASUTHS28xHfaM5OKqprYvaMKD4P
   VKW0+83M6UIPGD4/abhPgKtquBg87FZAyUCZwBy8gySeBy4v1f3m1/EPx
   drTsNlp5yGmkutdlKUVZ8q6ek8ItNZmF2e371KXA1S2bb/XV/AJffCzBe
   Br4mbIi0f0UGr1TaSXohvC2mUkC6ot5trw7e8geDpHtonjJ+NyFkXTolA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="277356814"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="277356814"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 12:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="561163665"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 25 Aug 2022 12:28:53 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 25 Aug 2022 12:28:52 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 25 Aug 2022 12:28:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 25 Aug 2022 12:28:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 25 Aug 2022 12:28:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJ7tWKmyk7qpP0OtpvpHAohTphrQcZPCk4HXKSLtPTizQS8c6E4QrNXKiqG3lQ66rf70rcDIzR2tqELEwDewZ2Zlk/tx26I+ck3nJiBAeQhyMFYZLovWduMEJwvSrMhNgCMi6Gb2CkqYsJhCPQl1ZSBng5T6EpSVKduHq+9k797gIVRmk8G6mv795LUpZ4GqW3cN/m/fsf7/oo9PYNjq6p+nRlusM78Fzh2G9R5yDxkPWINzPZQPgaaKEDFP/JsJ13ky0+/hy7G+e299aJwVtFsEAPa5vWqiqO84IcdSS81BDs4Jdj9ll5QiYtTx52a5lo31nlB+4zzeHwQ3DfeNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/As9I/+tGP4V2qhg3J5Fl5KKE3HFjvpVHmfFsE/hSW4=;
 b=UcvzlVBEe1sPWTvZ1cpVqDOL0r0dHahUd2qjOC3T7bKpp21DlHZCAB/bGKnsr9fswUEzFP4ojpgrgk2aHg9uUVQpYZuMBAI/BXaoTF1y/n41NaLigd+84i+wC/BH3DmYUlfAviZnmy5fJm11HfF7WevjGRC0YXsZIDGzFH1i5W/Ay3U4Su/wIiI1RXFhYxTRGbCJyUf893l0hvjRg1Aoi47/NHDcdcgtZ+gcFtUcSuxGD2AuxjqVgo4ZUBRGZBKMxznT64E0P3zonhsjqZso9X0krS07qY7kAxDnD3H16Z7wowi6scKKMDmTeMZBbM2aro1FR35LzX3JZwD/T8hIJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB4738.namprd11.prod.outlook.com
 (2603:10b6:5:2a3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 19:28:50 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5546.024; Thu, 25 Aug 2022
 19:28:49 +0000
Date:   Thu, 25 Aug 2022 12:28:45 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
CC:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "willy@infradead.org" <willy@infradead.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 05/14] mm: Introduce mf_dax_kill_procs() for fsdax case
Message-ID: <6307cd6d8bec5_1b322946@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
 <20220603053738.1218681-6-ruansy.fnst@fujitsu.com>
 <63069db388d43_1b3229426@dwillia2-xfh.jf.intel.com.notmuch>
 <20220824234142.GA850225@hori.linux.bs1.fc.nec.co.jp>
 <6306fbabab4cd_18ed7294e2@dwillia2-xfh.jf.intel.com.notmuch>
 <6307031b763be_18ed729455@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6307031b763be_18ed729455@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR05CA0159.namprd05.prod.outlook.com
 (2603:10b6:a03:339::14) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56c99c02-23dd-4cad-f7c5-08da86d00969
X-MS-TrafficTypeDiagnostic: DM6PR11MB4738:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: em4ImuqZilbrWCFTuNmRY1AbeNDL0N1aEs+8NuIovpHRIlf8J8SSApbFrzMsQ5uMtSRjTYjQ/tg3Mv9AWGf3EbLYUDHqUDhNKQtnnYTSAc0zMxXzlnWm94wVa1Scq9qFIir/OYeLGI0eGlucoQeSEyOckAMFwP1wdUhw1KL/iX9pMbq1WSS1+A/RHFEnFZp2KrXJc8ZfcDDqLbdo4QL9USlWns42mv37laZlpx/0tCcjB3IG54V7dUKScAvCXqq1U/7ZjrYY+uyURhzxTqILTK1bfVmxzxUf6+4y2mdU7Ve95ogJs0qKzU9WMa2DfvQq14mZUvB2TCwrZlxqpOswo318unECi4t/xJ4IzyNtpamxhkJu1eNPht5XHCPCKvx0TUO1GvjwnHVRjivtEMUL0o8/ghsfdYdppr9utyK4YQvM6UHPJJebyMcFyKIk7aTCCYd8HNZ9ZM0G/Pqb1fkHwaIIIIzvjacbUuo7uZztseYL/fbrumVdP4YXs+GRZUzxzSNBJY1U0HrN3fUMkN2gw3rczOSfYzZTUml2Xx5+IqA4NDvNXSIoUyXayEFZEIMjmc+/J9M6aVBux/AIBmEtMA8dcVSw3ULkG9zFqCc2+IIROhY6VXnia/cLTAK7mqNbe2jpnVpPqwVREqbEVDgoeIv63R9TPQsnXx1W7VJZH9ogZwrw5JxoxtnQhK/KBMKkkZYrtu0Ha0smK8RU0VEqDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(376002)(136003)(39860400002)(366004)(6512007)(26005)(6506007)(6666004)(86362001)(82960400001)(186003)(41300700001)(83380400001)(6486002)(9686003)(478600001)(66556008)(316002)(4326008)(110136005)(54906003)(66476007)(8676002)(66946007)(7416002)(8936002)(38100700002)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3ErQ1BFRTJoOWNndmxUQndjTEQ3cUpkakpJMnpiVUh0RlY2Z2lRQkhycUpM?=
 =?utf-8?B?OHB0eTE2eitYdkppTitNemVseG9sbmU0T0xoOXNQVDZjeEFzR0NjbEV3Wnkw?=
 =?utf-8?B?eHIwWk5tQWMreERXcmpRRjJCN2tKUE1sQ094MmJxSDZSaG1WRENudXI0b0xZ?=
 =?utf-8?B?SFQ2ekdOMlQyT2tFbmxHckZEaDNXTnhObmJiTHorVDB4a0FSWGhXVUZ6ajVZ?=
 =?utf-8?B?MTJOdzE4Zkx6ZC82Rk92MWNVSkRocE4zOTlqS0dlSzRLL2pacmFkbWJJTTRE?=
 =?utf-8?B?UHJsdWhITC9ISktqanNJOEQ3VEdXZVBrNjQxTkN3ZjBHN2p6YkY5cFVCbnE0?=
 =?utf-8?B?bkw0VHAvVHlmbzZsR0oyL2N5WGJXam5tWm92Z3JKUzM2QS9vMzVrY2xZNHds?=
 =?utf-8?B?N0RWUGd2N2RkMHJRUGhDeFJWM3pjcFVuK2w4MzR0ZUdOQU5FbUVZcUlPSk54?=
 =?utf-8?B?RzhiYk5IY21EZGRYVThMdkl2Ukk5b0ZHQ0JCbDJ6VlVkRmcyeXNJRXFNYWxm?=
 =?utf-8?B?RW9Sbi9qSUhqN1lyRzN0U2U1RGlXbmwxSXgyQXI5dGhFY2gyaFdPekxUM3Rv?=
 =?utf-8?B?VWIxMkJVeXp2aldza3hLU2o0K202cCszdzNrYk5IRlM1K2lxN2F3Z3JnSkhE?=
 =?utf-8?B?TzAwL2lBcklYZlU5WnJGT1VmWDNVUlp0eElIVXdJNW1YaVVqWWFGN0NjdTho?=
 =?utf-8?B?eU1BUFE3cXlvZDVOamxGejQ0c2hwcWliaFV5TlQ4eVpadjVBWFg5WVhPN3h3?=
 =?utf-8?B?TTBxdEFRWncvQWE5T0FpRVFhakRjS0JDTVhSaHgyVzIra2pJRjl4aTZ0YW5W?=
 =?utf-8?B?d2I1RG4wTmRpTTZnanNRNEI5QmVkMWxZWkNuYVZnRUYrdHVkU09TUnBqalhG?=
 =?utf-8?B?VzVlWDJrQVE1MWlEeW5jcTRUVW4wTGVDM0RBTDJsdnc4SXhTajNtT1B1aDJk?=
 =?utf-8?B?UW9MSEVsTFdaeDNJVE0xTExrMjNQNGhValRIMHlBRXN4RTEwSjhTcUl4N3BP?=
 =?utf-8?B?emVpUi80RFpCZjBmcGdCc0Z5RUtoaEtETWpGSlB4V09tR0g2a1FpT0JSa2I3?=
 =?utf-8?B?aDhQL2pxNGhVVGZCcFRpNFJoVERCaURqL1ptNUQ4TWNTcmdkMkEwVG9GeVN0?=
 =?utf-8?B?aEszQVFGZXFGcGI1N2dzeHJobEFjM1VXV2Jsc3NyMThGR240N2sxMi9jdmJ5?=
 =?utf-8?B?c3ZTYVMwKzYwQStNNlN5Y1lxN0xEVmQrQmg5YlRJNVk4N2VVanVTUE9EQzl0?=
 =?utf-8?B?UFlYR2treGpaSTc4amRXbkxCWSszU3NybndhL05tUitTb2lPeHUydG5JWmx2?=
 =?utf-8?B?OEtXT0s3WTZUeXAvYWFWS012eDk3cmFpaXNqZGJRUXE3QjRUNnlkSlBYWUMw?=
 =?utf-8?B?M1hHd0lKMTFGdHZVcWxVTHE0UnFRYmdHU3BlSWd0ei9JZlVZRmh1NFkzRkpO?=
 =?utf-8?B?bTd0a1hPaFhxSGI2UzROS3JVaFRuWHBqbnlScmVtaWxHZ0JrV2lRc3JmVUdX?=
 =?utf-8?B?a2FvWXFPdERqT3JSZkFDdDhvUm9xSzRReXo1U3ZFVDl0cXJnTzVCT2ZpYVhH?=
 =?utf-8?B?aXBSZGxJWUFReTFrWWU4QkN5UGQ4RzZISGlZRXk1bzBJK2w0QjJ0UXRvU0hH?=
 =?utf-8?B?OVluQmxQTDhna05Wc0o5NnQ5THFIYjQzaUJiOTJEZ1ZzZi9PWVo4a2M0NlA3?=
 =?utf-8?B?YXBQdmJkM3ZJSzdlRWJuK3UzMlBBcFJCZmZuZGJQVFdLZHBxRW1PUTZQZUx4?=
 =?utf-8?B?Ni9oNlplWmhzdUxheEUxazVsMEFNWHMxeEVKZGVmWmZzVWc0Vm5uOVVlYmM0?=
 =?utf-8?B?cVRxd0V6YVVJMjVOZjA1VTZYNUJ5UGpOYVFIK1o0MWQ4bGd4eWVIaCs4V1Zx?=
 =?utf-8?B?NDRONk5PeDk3Uno5YjlZYzJxVVcvV2FXblprVitIODhTQTJXWVlKcDB5R2xw?=
 =?utf-8?B?TFFDSGZ4ZDkzbVN3OUlsMUZaVURzSmpsb01zRGRFbFA1NnQ2a2JOWUR0MGVR?=
 =?utf-8?B?c2x2SkFNcVVuanJENUs0Nkhxd1JNSXJpNTc1L2dBOUY3RE12RUVaUFlQc2wr?=
 =?utf-8?B?NWxLZ1ZNY0t4SDlOckZvdEJLUTVpSHNYU3FGREhUTERxaC9UVUVpNi80ZEpX?=
 =?utf-8?B?czNiNXF6ZDdjZzNlWnhoUkdjbmpJdmR3TXovU1h4UTR2OC9LTi9aQmtHSjRs?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c99c02-23dd-4cad-f7c5-08da86d00969
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 19:28:49.8105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBL0BXl8z57CGrONJqPKjHa3wGywjTOp6dEOI4BQQeSWHCSZnvTUk6B3EpWBN2FJ1E7Le47HiQWRfet2TDW8mgaydJTkflCMWQVJf8DqLZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4738
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dan Williams wrote:
> Dan Williams wrote:
> > HORIGUCHI NAOYA(堀口　直也) wrote:
> > > On Wed, Aug 24, 2022 at 02:52:51PM -0700, Dan Williams wrote:
> > > > Shiyang Ruan wrote:
> > > > > This new function is a variant of mf_generic_kill_procs that accepts a
> > > > > file, offset pair instead of a struct to support multiple files sharing
> > > > > a DAX mapping.  It is intended to be called by the file systems as part
> > > > > of the memory_failure handler after the file system performed a reverse
> > > > > mapping from the storage address to the file and file offset.
> > > > > 
> > > > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > > > Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> > > > > ---
> > > > >  include/linux/mm.h  |  2 +
> > > > >  mm/memory-failure.c | 96 ++++++++++++++++++++++++++++++++++++++++-----
> > > > >  2 files changed, 88 insertions(+), 10 deletions(-)
> > > > 
> > > > Unfortunately my test suite was only running the "non-destructive" set
> > > > of 'ndctl' tests which skipped some of the complex memory-failure cases.
> > > > Upon fixing that, bisect flags this commit as the source of the following
> > > > crash regression:
> > > 
> > > Thank you for testing/reporting.
> > > 
> > > > 
> > > >  kernel BUG at mm/memory-failure.c:310!
> > > >  invalid opcode: 0000 [#1] PREEMPT SMP PTI
> > > >  CPU: 26 PID: 1252 Comm: dax-pmd Tainted: G           OE     5.19.0-rc4+ #58
> > > >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> > > >  RIP: 0010:add_to_kill+0x304/0x400
> > > > [..]
> > > >  Call Trace:
> > > >   <TASK>
> > > >   collect_procs.part.0+0x2c8/0x470
> > > >   memory_failure+0x979/0xf30
> > > >   do_madvise.part.0.cold+0x9c/0xd3
> > > >   ? lock_is_held_type+0xe3/0x140
> > > >   ? find_held_lock+0x2b/0x80
> > > >   ? lock_release+0x145/0x2f0
> > > >   ? lock_is_held_type+0xe3/0x140
> > > >   ? syscall_enter_from_user_mode+0x20/0x70
> > > >   __x64_sys_madvise+0x56/0x70
> > > >   do_syscall_64+0x3a/0x80
> > > >   entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > > 
> > > This stacktrace shows that VM_BUG_ON_VMA() in dev_pagemap_mapping_shift()
> > > was triggered.  I think that BUG_ON is too harsh here because address ==
> > > -EFAULT means that there's no mapping for the address.  The subsequent
> > > code considers "tk->size_shift == 0" as "no mapping" cases, so
> > > dev_pagemap_mapping_shift() can return 0 in such a case?
> > > 
> > > Could the following diff work for the issue?
> > 
> > This passes the "dax-ext4.sh" and "dax-xfs.sh" tests from the ndctl
> > suite.

So that diff works to avoid the BUG_ON, but it does not work to handle
the error case. I think the problem comes from:

    vma->vm_file->f_mapping != folio->mapping

...where page_folio(page)->mapping is likely not setup correctly for DAX
pages. This goes back to the broken nature of DAX page reference
counting which I am fixing now, but this folio association also needs to
be fixed up.
