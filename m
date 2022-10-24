Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B6260BD43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 00:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiJXWTv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 18:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiJXWTZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:19:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AE8196EE5;
        Mon, 24 Oct 2022 13:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666643810; x=1698179810;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=skOZWB6id/22e1zurCE3AQG6nbV5pyvT6nRDINsuXTI=;
  b=SkVSyP8Rp4MKEuxyOZAKI9LvR6OBpQVcFOmtyelyxggd8JgtXFg37xl7
   smMwy9Jo0SV3ZDkm6Ix8ViT20MtThqsw8ALo7wah4hinxgK/ckkkHMIRi
   wXIEHkNuqDAgDV6o6sBqZ1t1XX/19igc86v6do1rIiytfHCXegJdk2T7r
   Uv7lyrmbigFe76/Zs+bvF9T8mSk7PPOpxy4E51zfnnzficw22fMDhEwNf
   4izUNcO94ubi8VubayMWrnkHxJX28Yy15WwL2rhhj5BQM5HUGkyZUJFLc
   4/81Cz7mxhseXZRsX+wQnPVUFWgnBxdkPrcD29wXON6rw60CxUUX4M23I
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="309204343"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="309204343"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 13:36:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="633837811"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="633837811"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 24 Oct 2022 13:36:01 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 13:36:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 13:36:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 13:36:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 13:36:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtcBAbMCwY7iNpBpcgisOP6R6MXZImbd5yERV6SiLmNSRDz5dfKDk46bCkgzg0XU6uA+GUJ0LMNMZndut1viCcc6o+hR3xmlLpxQETfJa3f7O89jJQH06QihPb8SA4HKbZPNS6t7WOvTRDUdOxL1JnwIZbaunqMC3YCi9ynGBCBC96D3AMt9bAqWaFc82nRiys35DvO7jC59d16c9APcisKsywckKAKzycfMfOgghD7FcaPm25LwejAPx1/ziwFvQtE91H11pG0CX6JZW+8lQ5JZ7FzgoyO2Mn1VFO3a5XoI6GMDReh0oQUhYv2EV0LBC6bH5EXrQ9YHQZNHT30Lfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOuVhPKGD6u67jMApf4nfC3oWOWDfK7XnkGTak8qOIw=;
 b=Xgl/xMrmKJBmOXh3vZTK+WSDEgMqre4hTFmgBwv9O1FQdtawiPCajtraswXR3QJzW5GFLIJGEtS44g30lcYJsiMP+B3r1HKdhmtTyoszF5XGR4zsCzXkyuzhRaAs40yCUNNk/7E9v7byggNigiVwtQTWkahLqkanA4V+KDJRqNM/wl8e98mQtN64PEPDu4rrHU7JSzwNVtzxthoxjgD7avXNG1KsGOYdqHbGnS1b8Z6b9nFGgT9JQXO/jfddHooAzui1/JG39zMo7Lhwf803ZlLk0DjBVCxuRFKoKfaEpeOuHy8ZSIDq7WDcT1sZgB523yqutZh4CMO0dn1GajzjaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH7PR11MB6748.namprd11.prod.outlook.com
 (2603:10b6:510:1b6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 20:35:59 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.023; Mon, 24 Oct
 2022 20:35:59 +0000
Date:   Mon, 24 Oct 2022 13:35:56 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        <jesus.a.arechiga.lopez@intel.com>, <tim.c.chen@linux.intel.com>
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
Message-ID: <6356f72ca12e0_4da32941c@dwillia2-xfh.jf.intel.com.notmuch>
References: <YjDj3lvlNJK/IPiU@bfoster>
 <YjJPu/3tYnuKK888@casper.infradead.org>
 <YjM88OwoccZOKp86@bfoster>
 <YjSTq4roN/LJ7Xsy@bfoster>
 <YjSbHp6B9a1G3tuQ@casper.infradead.org>
 <CAHk-=wh6V6TZjjnqBvktbaho_wqfjZYQ9zcKJTV8EP2Kygn0uQ@mail.gmail.com>
 <6350a5f07bae2_6be12944c@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHk-=wizsHtGa=7dESxXd6VNU2mdHqhvCv88FB3xcWb3o3iJMw@mail.gmail.com>
 <6356f1f74678c_141929415@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <CAHk-=wj7mRYuictrQjT+sacgj9_GrmRetE1KLTiz-nOk-H4DPQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHk-=wj7mRYuictrQjT+sacgj9_GrmRetE1KLTiz-nOk-H4DPQ@mail.gmail.com>
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|PH7PR11MB6748:EE_
X-MS-Office365-Filtering-Correlation-Id: 4795ceee-c8e0-426f-3345-08dab5ff5bd6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H9ai+QtAHhXOkIZnFiwWd5fko49GrQMb7H4s1//rbhy9BZHoQBcY2zoWSdhgf8g/RID2BmMQbhK0YnA1tdVklF7GV8v4q96AAuy6E4oBIk4oqtt2wRZbIFnkc3usH28uBMz++KvajFv5VoJyTgsftrSU28nM4JymxOLjKBjIYBgAR9VhhVqhK/ebEKAbY1LvxrFLQvRKJzhbe/qBf3oEpUfATF39VXuZnzo5yQZrPYg0JYsZRqt21VTuyg/eASrhfw+atFsq9I/Fx1WQd51YESlMv2KI3PVC462PtmcsfFUC2L/Yb2+GlcTG9Xd+EYnmPr4k4WZnJjKmdoDYkQS1UCMvuIOxRGhuORvHix0PrZeKlfdtmC9wZq2S9gQVT5MgHk2tEOkGqtZMfTbR0Ys8uy9iyDoga5kv0Qvou48vlljlympETbcnQGBfT6vbHHogirBygNe7HK4PNfNdNO5uwpXT4bXOr9mv/JNjlILelHs/0+pFJKZGgpQYvNwPjur7A8ENnNu/Ujb3MK90/Tgtw5CcBBD49je9G5xzDP+YX8qDHJqHkKqG/jSdD9lJuyWCFQ7LWGeVnTJ/VLHeedHcn9s8ZpLPVB1Y/txegrqzgjV9D89iQqGbkz1c2lRlyUKS8bto96okf22tN/XcD+vE7tYyOHA9yk3Cqcsnq0WCGP7h2zJ6c+5gGB0wGabn/XO/NJ4A0OwV0zdF+96fOkjN+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199015)(186003)(5660300002)(83380400001)(6486002)(86362001)(38100700002)(41300700001)(82960400001)(2906002)(54906003)(8936002)(26005)(9686003)(6512007)(6506007)(6666004)(8676002)(66556008)(66946007)(110136005)(478600001)(4326008)(316002)(53546011)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6BwjGZIj0WgeEtB7ZWGe/PUFolaE3ZRVsOIILZjl3HSNJkkUcyM09O48jE0e?=
 =?us-ascii?Q?tTZJyQHuhurdP/0L4CiqU5nR3Kwu8rebFXNedCeTSGOxnzwopOsheWDyuXeg?=
 =?us-ascii?Q?Ety1/fQdimLLOD79y0FgSckgrgRQKjrOw82q9lgMZe65CYo1x+HTC+1utYGL?=
 =?us-ascii?Q?5DhzAXGHlGU1GM4Ka1KZKF0IJRhHrw2xUQuLjwOYnrE7C3yA9WRKPtdFEP8H?=
 =?us-ascii?Q?x1um3CpweHwBKivqIJWaD9PbjDMINpcijKPQLR9rMJ2K7egIHmFmIXGf6TGQ?=
 =?us-ascii?Q?M2qe4OGq827AU3xFTQdhUcHW3wLkW+hV2SVHadmzjeJzShMrY7Jmc/ntxGJS?=
 =?us-ascii?Q?7nZ2Djc/FTjem5TFVuLrBwSMsz81TBj245g5B5qOf3DqcTWrWRReo+b4KLS1?=
 =?us-ascii?Q?0Ftzs4p4zeuNGwhRML5R8WE/Fx4J+BKGgE5pHgTuNAb4SAwKSjz20w7z2L86?=
 =?us-ascii?Q?HzXGJjb4OEkcvQSsW8KCV3/9RrI+0yB2jlsWQ994roafKB+VdndTTU1ZByMG?=
 =?us-ascii?Q?q5gsRi6wsS+k4YsgQ65K1iXFcrSQDANpUH9Ymm8qYdRLGSSFnaGS251oc2V8?=
 =?us-ascii?Q?kC032CyFO9pNI5Q0ruDGxCOpU/Vyf1RrmAeHBQB3rjFndR/KtNrauJTGfF9C?=
 =?us-ascii?Q?K/swwPYmUw7EkaUclGhj+2LuzON9aY8T0GBo+iBzNStIZ+a4OGnLq4VnAAnb?=
 =?us-ascii?Q?mHhyEODHsaVU9iUnEzNBN5iks9/8wkCr30+w8jxMio3Vzkls3Ja6vvUQxy5Y?=
 =?us-ascii?Q?CntSVsvGEYy7QOJ482Uamx4JGAONKcu0XF/fcmrg3zB93fIA/ZtPsRwFxm6F?=
 =?us-ascii?Q?N8KIBtHNZtbk0TIVfXq6zvAR63Y26K7ak/PA77LMW6ycCxjLF4cOKN2aQAlh?=
 =?us-ascii?Q?GkDISueGHujJT9DP2OZB05WvqWyUJILWOVvvfm0ml1nXzT8B2xRWv7XwOb0I?=
 =?us-ascii?Q?uPLG1wnmDlLm7ywau+yzaFcqxO9R42KT4+V8dcj2HUmf0HlHqv7pgG/Exmdo?=
 =?us-ascii?Q?BfkD1yeXGOMU6FRmnLtT7texB5cjOChQQuyJ4HUSSbLZ5BP8vkMqtz3PpQJq?=
 =?us-ascii?Q?T2wplu71rnFqUOAVUfbIgeFVC4r4S3EEuNJwd24QhOS32ca5kF6P1q4s2n+y?=
 =?us-ascii?Q?2/Z7BTAKXS+tufjoJ+vm4Z8QpPD7Pjdee7Owhu4wwbLriffVNZPac+q6kIvx?=
 =?us-ascii?Q?2I91BFrSN9Aw5TpsK1vEck7i+/ZEHH9EUGLUhAC8PAad2msCy8K5aB48VCrV?=
 =?us-ascii?Q?NZysPwcqMKBWjy0RS4lskhhk4L4RiEux2s5dEzatB/BCh8dm+PRSa6fzDKKQ?=
 =?us-ascii?Q?h5Kb5NOd5kxmAftGCyKemrMiRR8MKnzrErnYFCNkheBPXfYo0EZqme9nzOp/?=
 =?us-ascii?Q?H31FHnjX+RKK/QeSVbO7FySzOXJEln5atLxaAACk07gXjWLnK9JOlp9l1rv8?=
 =?us-ascii?Q?XuoEQHd21qX6yFSQaXmz1SsAeC/08Q6utERndYpw2SxkLtEoOcTqDYpLeGNx?=
 =?us-ascii?Q?sh2hFQBOMOnfiZmdai66mSmqda+B7lUSvtI+DWfEK+OfZIj4jXF8arr079L3?=
 =?us-ascii?Q?iznWi7n2gTB6AXwrjj79StFJ2WlOZ7Hd5wtpGywtHnqT4HLZliEB7qINHfDW?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4795ceee-c8e0-426f-3345-08dab5ff5bd6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 20:35:58.9805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyK8VwYuqRGH3Pt2TmXY8fV4XTxMv+PoB8zJcxmRhmOb11iyeI8b2cJfPkrZa0OYBBC8st43CEvaGfxxGM9ORLlnYVlbgwdKEWLLrA9LZ7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6748
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds wrote:
> On Mon, Oct 24, 2022 at 1:13 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Arechiga reports that his test case that failed "fast" before now ran
> > for 28 hours without a soft lockup report with the proposed patches
> > applied. So, I would consider those:
> >
> > Tested-by: Jesus Arechiga Lopez <jesus.a.arechiga.lopez@intel.com>
> 
> Ok, great.
> 
> I really like that patch myself (and obviously liked it back when it
> was originally proposed), but I think it was always held back by the
> fact that we didn't really have any hard data for it.
> 
> It does sound like we now very much have hard data for "the page
> waitlist complexity is now a bigger problem than the historical
> problem it tried to solve".
> 
> So I'll happily apply it. The only question is whether it's a "let's
> do this for 6.2", or if it's something that we'd want to back-port
> anyway, and might as well apply sooner rather than later as a fix.
> 
> I think that in turn then depends on just how artificial the test case
> was. If the test case was triggered by somebody seeing problems in
> real life loads, that would make the urgency a lot higher. But if it
> was purely a synthetic test case with no accompanying "this is what
> made us look at this" problem, it might be a 6.2 thing.
> 
> Arechiga?

I will let Arechiga reply as well, but my sense is that this is more in
the latter camp of not urgent because the test case is trying to
generate platform stress (success!), not necessarily trying to get real
work done.
