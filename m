Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589845A0847
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 07:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbiHYFFp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 01:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiHYFFm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 01:05:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4238D7FE66;
        Wed, 24 Aug 2022 22:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661403939; x=1692939939;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=kqKWWY0r0Z7br161a9g9cHW/kSUV68BnQrWMSog6nW0=;
  b=QScq+9QRxhMyP1I5x2cpGBHfaqempG6Z9U3OlpcuofSqs2SHkpl6hjK/
   z9UgDorZX7XFwkb8prgbe/aezeBXeY95QczEwyN7a2+WCzAKOhs64XMJG
   oPsEykKg2G3fgqdr4EBBlI85Aagj1ZUo/R5fbWj71BXAKpEBRgAI4M5E+
   PcJ8Dh/oBMVlarl7NslZbEASYeOGzD74iJoBqCOzv2xGmVlufNubklMen
   FM85YhDl+4BbSufWPCrNnHnmDOJt8Cs+dz44z7Jlwmn11p1Fj2vyZuQN4
   TcsD8ejy8KtLxHiOSt3pxIARY9teDWkd78FDZ+15G3tznQ4RzoZCjITn1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="294147822"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="294147822"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 22:05:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="752345749"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 24 Aug 2022 22:05:38 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 22:05:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 22:05:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 24 Aug 2022 22:05:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 24 Aug 2022 22:05:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrI3AE8UYIUbyzbhyQY9zx/a2D+tEZy95WmvOBuR7wt67H8/NgTqv459ZrWGiPNtfHRUUxb6bO83xhCt3jQ/waDZXTx20wQGYy1SLP60XMxTPqWNFfGbSoCuVOxDnKZVFfDpJmsx1s+4ncrwKbBUXTKUznhRpIN7IkxZN7HjGYIlRrcmMY/eBRO+JPJgqoR3jsOJYHb4g9YuWvkc9OiFHKiqoGH4BoGglDuzs3tpd/rZpjfAAPApwB0Z1PLIbYoJbOasVCLW8f3UqvaN75wolZILc983cKwPVxcSeQJn2zW7YJcZAYk9C7d0cAYfCcb9ANsjiHe2d401UWtJ/9Sy3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mT47JA/vqHW2PiINR1x4vbmgzreuyZ9nCo9ZEjlP3c8=;
 b=UfSs9HbMvKJmZj9XwQr5mYVFZchia03HAi5IHrxoOjp5SkaurTQ+f0nJLQ+3v/zjLH+AqALSKlx09znacH9yQTivSv13I7nd1Yw93+bRJ8XleT2T8KHTglCbi0jBmY18WPK7GFoAevCofJdK5ZkySSafLenQLuG5Bo/IvT0GIomfOMA6YhRLLRLJULlpDTIHlW6DqmJC3blZQZ6JWKDRIl9vOlQzEja9beGG3LEjNlhPum9auHoChABSxznzLkVecIvibW9rbUnd6qWHI/+D19xbW0fWEnueC9GghGMwlZw+TCB1TEtRCgpD6chh5M59vYHiiAC+kZjJklpcWNZ3rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CH2PR11MB4325.namprd11.prod.outlook.com
 (2603:10b6:610:3e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.20; Thu, 25 Aug
 2022 05:05:35 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5546.024; Thu, 25 Aug 2022
 05:05:35 +0000
Date:   Wed, 24 Aug 2022 22:05:31 -0700
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
Message-ID: <6307031b763be_18ed729455@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
 <20220603053738.1218681-6-ruansy.fnst@fujitsu.com>
 <63069db388d43_1b3229426@dwillia2-xfh.jf.intel.com.notmuch>
 <20220824234142.GA850225@hori.linux.bs1.fc.nec.co.jp>
 <6306fbabab4cd_18ed7294e2@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6306fbabab4cd_18ed7294e2@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR06CA0043.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::20) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 099141f1-7ba8-458b-ba8e-08da8657715d
X-MS-TrafficTypeDiagnostic: CH2PR11MB4325:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XhZBk4X9QQTm1BEp3pqYNqGyR9R8UKoXI/8vLTAT5Ti580Bq7Fh2YZmSnTTyMeoVATVhSwH4PX979nYezCRzYQ0993RDGrUY78lAuTuS8NpWCKUhDghF6oZopV1Bwr+vXf8k12OT+Vy/Q7G7Tvk92G+hYjdusmVXAE5N5pIU355nLZRlYUHNhQ78mRvJvWM/bfv6MwdzFS56koHVW5dFqXFuFPjACZNBDGJ68N9fuWn4MZ2ovvSJ1xVNOJj6acvWCYajaS00vmYl6owLrh1MRDMFBol0j0IFZEvc77wz/K7LnNA46wOalyA2ZTWXIB3sfQayI5JNn22ZVXBDIftJMCTnkLq0j9uMzPseISGTpqA4SzTsWMzSKcGSPGiK3ZiIPlRHNkr8AF/+gX7aKNMVs5q+vSv8U9oRR5fZA3Lw0RU3E8QeFBFBzk101RjXrRQ1xpJVDzfvB8lk9SZj+AxxLPIN6xVubcZCCHRI/mRPU03t98M6uyhl5Qgy0JHlgTkBYM5pfkBBpzfV55ogSgCzQp9LufG+2um0QYuEFKmBv+L9jBG6o3RQxXjlDGEj1LyYtAc9v2jepnbhgZCRCR28mTeXrMhD/P97hm0PvRVnJ4Kvn8LLZyrsZK8Q7oWFe78LiXNfvr5J9iEhyipN0YBaOVVAKeiQrvWprbBmFjbLaZ+W8MGQe99nO5qR5NTKrfGfOFlN7UowY1uGg7/Oghqzow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(39860400002)(136003)(366004)(2906002)(66556008)(5660300002)(7416002)(4326008)(66476007)(66946007)(8676002)(54906003)(8936002)(110136005)(86362001)(38100700002)(316002)(186003)(6486002)(478600001)(6666004)(26005)(83380400001)(6512007)(41300700001)(9686003)(6506007)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHQwdUJoUEtYRTg3S3pFMTF4RVhWSTBIMmFoNGVVTisxczhOZXpDcUxQcjcv?=
 =?utf-8?B?ZkMvd3Q0M0Z0Ulhsdy92aUNtcVdzT2xDMjVHVHVLZlJBRElWcFFjTGtIYWFu?=
 =?utf-8?B?NnlhSU5LTEhKN1RLcXdQOW1rQTJiS250WkZtRHRhWFpxRVIzRmpCbW1wMjlj?=
 =?utf-8?B?dk8wbFQ3bkRsV0U0Zk1HdEtzeDJnR2JQMTI2aXQxa1RuU05OcHdCUjhFU25C?=
 =?utf-8?B?QlBZMVdZTDRpVnlTakN1YlAxWllRQnVnd3JaNnBseTJlcVlZSlpIUVVtSWk0?=
 =?utf-8?B?OTY2bTdKSUk0QUR5bklyY3h5L0UwUTlTR1JmVEd6QlBuWE0vSi9LT0dxWXg2?=
 =?utf-8?B?eXBNZXFqSzRqL1ByY2FBVGw5cTduVDhwd0pqVUk1cndhSnlFcDJsVTlJU1Ev?=
 =?utf-8?B?K2F1Mloyb0M1b3J4WEgxbGtFWXR2V1g5ZEdQdFNxTm9pSXFscldGYWFVVlA2?=
 =?utf-8?B?L1J6WVhvUTZWOUtzVk1wb21CNnpLRmpVeHBia3BUaEtVcG4zWEY5UlAzajBX?=
 =?utf-8?B?QVRaaEtJSkFnUVMvZjZtMWVZckhSN3JhNlNXam5ReUUvaVoyLzZoYmc1S1ZB?=
 =?utf-8?B?RlUxRm94WDIyVEFEUzM0dmV0UlZDQytNMW9FZnFrTWFhWHRvMmcvSnJtUUl0?=
 =?utf-8?B?Ny82ZncrWXQrL0U4UTE0ZmNtOHU5U2U1UWRWc2RQMW5vZDJYK1hyUjRKNUsx?=
 =?utf-8?B?T05vMDBpbXdQeXFPSEhKcHlML0hJSDVidXhmcTdxRjM3bGhlcTFsT2U2a0U2?=
 =?utf-8?B?VjdoL3hLeXpJWTR1K0JNWnRsZjJjQWJLUVVjRHFSU3YwR1U0bWFOVlJGYVI2?=
 =?utf-8?B?ZWs2QVBtTzR0bitrOWRuMnNKUzFTV245ZW54a2RJU0hOMXJhMWNabWRYVm9N?=
 =?utf-8?B?NlYwbXEwc3RSa20rbFhtL0tEUkE3ekZTMEJSQkVNbGpuNnUzdSt6NkxiODRP?=
 =?utf-8?B?Y21uNVFKMmtJVDdvTC9tblBJNlR4Q1oxNGpJck05N0VZZzlzTkRnY1NPT2lM?=
 =?utf-8?B?WlZDU3pBSVJ1TWZIUUtCRDZLelZIQm1DTzZHd3NIKzk5elVIZmxrbGhTRTR5?=
 =?utf-8?B?VVp1MS9oR1djMWJjZEVzSkZ5bE1yS1NMN3NzRUI3OVJCaGtIZER6T3puS3c0?=
 =?utf-8?B?YThNKzI5VUhCRUFFNXVMd1FSRmFyMGxDZTdacDc0b2F6WWRwNHlNOHZ5SFpi?=
 =?utf-8?B?TWRIenZvUjFsT0Z6TzFzZnd1a0V4OVlHbml0KzJWQXNZR3ptYnBJeEQ1UUhy?=
 =?utf-8?B?cTJ0c3dKNElUNGpQWjFHOVJMSGQ1TVdwTTZWWWZ2SzZHd3VXL2t6TVNGLzBn?=
 =?utf-8?B?NUxnUXgzbkoxWmF1MUNPcFpTcFJvemJ1UXRYR1Z6TTF5Ukg5Y3pPWVhMbzk3?=
 =?utf-8?B?emNyYmhBU3RSRUE4Nk1tVytTSGxuallkMUU0L0FxTUV3cEhpK1ZEM2FWS2ox?=
 =?utf-8?B?N21HTlBmeE9SMC9GUllZUGh3WCtVVEJscnJLYlU0anhOc2hVYlMvTERpd25T?=
 =?utf-8?B?dU5KZHdvVTN0OFR5U29xcGZ5VkVlcUZtRE9PSHo1UjY0czB5Qk1NdVc4b2VZ?=
 =?utf-8?B?UytGV1h2T2c5bGgvYXlEREt4ZXpRUGd2T2NpNUhaMXYwQXpvV05sdVEwcm0z?=
 =?utf-8?B?a0lJdkcraGZORXVJU2ZwTElHSk9XaHFVbW5KQ1c4WUhKVk9BNXpVZnNyY0s4?=
 =?utf-8?B?ZlFUMG9XdUd6OWxwejN1S2pDVlQyMCtuOFY3NkY2cVFBdFc0SnpKZDlaajdG?=
 =?utf-8?B?eTMrMjBGMEhJTE1nbW0yY29BU094ZUNoZXRGbnBQQzR6RG1zazNMVzBWV2ZT?=
 =?utf-8?B?ci9xV29zQnZVUDl6bW92alZneHJGUVZLVEFpaWhqMENHWUc3d1d6bTc1eUJ3?=
 =?utf-8?B?bnAyWlZYUFNxWGJJbFh3NmF3Z3A5Uk1zdVJtTkRWamptUFMreng4aVJjaUs0?=
 =?utf-8?B?MnV3V2sxT2JLY0RoMVJFTUNJaEIwaHJ0cGs5SlQ5Z1ZlSGI2dkF3aDFmczVz?=
 =?utf-8?B?OUs1a0RpaHdHc01tMitWaGNYRCtyajF4VzNFZVd6NXF2UU1BZW9Ua0JHN0U4?=
 =?utf-8?B?T3JmNm13empIOUdPU21iVjB4NW5nRmhPWVRVVklzeWNIZEVEcVg5NkZZdTRv?=
 =?utf-8?B?Z3Yranl5TXcycnhSNU54NHh0SlY5N1I3TnY1MTYrODk3UkIrdU5HNTNOV3VE?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 099141f1-7ba8-458b-ba8e-08da8657715d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 05:05:35.0778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrFjZWIKQczwoR/w986n7XQYYIcMlVlQiOg13VLVvAl+QohYkz0gp/3SA8rLzJfDUc2hz7sk2JnzbyVGwh8pVL++pA+aglnJPTaUVyDZNDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4325
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dan Williams wrote:
> HORIGUCHI NAOYA(堀口　直也) wrote:
> > On Wed, Aug 24, 2022 at 02:52:51PM -0700, Dan Williams wrote:
> > > Shiyang Ruan wrote:
> > > > This new function is a variant of mf_generic_kill_procs that accepts a
> > > > file, offset pair instead of a struct to support multiple files sharing
> > > > a DAX mapping.  It is intended to be called by the file systems as part
> > > > of the memory_failure handler after the file system performed a reverse
> > > > mapping from the storage address to the file and file offset.
> > > > 
> > > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > > Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> > > > ---
> > > >  include/linux/mm.h  |  2 +
> > > >  mm/memory-failure.c | 96 ++++++++++++++++++++++++++++++++++++++++-----
> > > >  2 files changed, 88 insertions(+), 10 deletions(-)
> > > 
> > > Unfortunately my test suite was only running the "non-destructive" set
> > > of 'ndctl' tests which skipped some of the complex memory-failure cases.
> > > Upon fixing that, bisect flags this commit as the source of the following
> > > crash regression:
> > 
> > Thank you for testing/reporting.
> > 
> > > 
> > >  kernel BUG at mm/memory-failure.c:310!
> > >  invalid opcode: 0000 [#1] PREEMPT SMP PTI
> > >  CPU: 26 PID: 1252 Comm: dax-pmd Tainted: G           OE     5.19.0-rc4+ #58
> > >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> > >  RIP: 0010:add_to_kill+0x304/0x400
> > > [..]
> > >  Call Trace:
> > >   <TASK>
> > >   collect_procs.part.0+0x2c8/0x470
> > >   memory_failure+0x979/0xf30
> > >   do_madvise.part.0.cold+0x9c/0xd3
> > >   ? lock_is_held_type+0xe3/0x140
> > >   ? find_held_lock+0x2b/0x80
> > >   ? lock_release+0x145/0x2f0
> > >   ? lock_is_held_type+0xe3/0x140
> > >   ? syscall_enter_from_user_mode+0x20/0x70
> > >   __x64_sys_madvise+0x56/0x70
> > >   do_syscall_64+0x3a/0x80
> > >   entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > 
> > This stacktrace shows that VM_BUG_ON_VMA() in dev_pagemap_mapping_shift()
> > was triggered.  I think that BUG_ON is too harsh here because address ==
> > -EFAULT means that there's no mapping for the address.  The subsequent
> > code considers "tk->size_shift == 0" as "no mapping" cases, so
> > dev_pagemap_mapping_shift() can return 0 in such a case?
> > 
> > Could the following diff work for the issue?
> 
> This passes the "dax-ext4.sh" and "dax-xfs.sh" tests from the ndctl
> suite.
> 
> It then fails on the "device-dax" test with this signature:
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000010
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 8000000205073067 P4D 8000000205073067 PUD 2062b3067 PMD 0 
>  Oops: 0000 [#1] PREEMPT SMP PTI
>  CPU: 22 PID: 4535 Comm: device-dax Tainted: G           OE    N 6.0.0-rc2+ #59
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>  RIP: 0010:memory_failure+0x667/0xba0
> [..]
>  Call Trace:
>   <TASK>
>   ? _printk+0x58/0x73
>   do_madvise.part.0.cold+0xaf/0xc5
> 
> Which is:
> 
> (gdb) li *(memory_failure+0x667)
> 0xffffffff813b7f17 is in memory_failure (mm/memory-failure.c:1933).
> 1928
> 1929            /*
> 1930             * Call driver's implementation to handle the memory failure, otherwise
> 1931             * fall back to generic handler.
> 1932             */
> 1933            if (pgmap->ops->memory_failure) {
> 1934                    rc = pgmap->ops->memory_failure(pgmap, pfn, 1, flags);
> 
> 
> ...I think this is just a simple matter of:
> 
> @@ -1928,7 +1930,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>          * Call driver's implementation to handle the memory failure, otherwise
>          * fall back to generic handler.
>          */
> -       if (pgmap->ops->memory_failure) {
> +       if (pgmap->ops && pgmap->ops->memory_failure) {
>                 rc = pgmap->ops->memory_failure(pgmap, pfn, 1, flags);
>                 /*
>                  * Fall back to generic handler too if operation is not
> 
> 
> ...since device-dax does not implement pagemap ops.
> 
> I will see what else pops up and make sure that this regression always
> runs going forward.

Ok, that was last of the regression fallout that I could find.
