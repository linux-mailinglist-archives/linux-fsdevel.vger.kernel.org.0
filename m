Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EAE21E7F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 08:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgGNGSO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 02:18:14 -0400
Received: from mail-eopbgr80128.outbound.protection.outlook.com ([40.107.8.128]:29784
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725778AbgGNGSN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:18:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcDuQWfC7yS+XTK3F6cvAlX6jaftJzQ4w2BcgPrkVtxQItGETXwZMrjiQVHipfMrM2jWldVu751AA/cOTzietcP1VSFJ6Ml4yvegF5Z6gAmjsFr+DVL8pFCQIPYD9uXj8V5ZAs579uUy1WY1rkdbtEpYE61BHMxTcTVLQZ9qUxcJiC41HSPKqtmxvgLeedoKfv5+ZtRyLPpbZhV2bVoIoZf0kNEV2QK6/NXhivZgn9WRe5KVCgifTxMyRzL//Z6S8nFSH4ZkC1ZGsTjLDq/+GYK2Q4XWF8fv9GHHELkHOgTnU5hQho+hdrykY1wxeGOrZvR0IpitHwb0vmWu31knLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjItNMY/npMpjySQUkiumKG4Va9KwR96GEsCTZzU2mU=;
 b=aKJiC/3c/1TSznwODkvY/c1UTCdFy2XIUXgHaiBBFSwwyBMBnnAXa5/ahpag+aAGjiY7FVFlJx6Kvd5891ZNR3sYz5n49wZKthujTAnwsf7kf3IMTb8E3hxp6YJZ0ySFUOgPLup0IxcbQZtvPuVU2kF8NtFNiv3sAErPxAO2fAXkMMWvNQoSIW9pJryj4n/8Rzls3K+Jj6wsS9swiyPJaDBFFmhJPRvsaoJF+zDsAKDc6L6xJR6D3OM7zUi4ZYOlVWrZjL+a0e09LHtLgwW95fpCPUkSiSMEpj7wk/0UeMHU9tUZ1bqtAEUTe28HXHm8LzfH3YOiPhjesso5uSQ9xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjItNMY/npMpjySQUkiumKG4Va9KwR96GEsCTZzU2mU=;
 b=eUzGhDDMMRZAGFRhbRvJo+mi8wMVN+DSK2giNIK6ISnpTZCE6Csb/fNZqMMBIz6oyr9GTr27vAKvEF1IrH4qa1PauENhKO2aPAkktvaD9uOXMl2kePv0kTHBfJ3s9+ffXqnDD5C2TqD+l5z/O0VobP3NZGZid/FUUZAGaR654k4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com (2603:10a6:208:162::17)
 by AM0PR08MB3012.eurprd08.prod.outlook.com (2603:10a6:208:5b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 06:18:10 +0000
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::189d:9569:dbb8:2783]) by AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::189d:9569:dbb8:2783%6]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 06:18:10 +0000
Subject: Re: [PATCH] fuse_writepages_fill() optimization to avoid WARN_ON in
 tree_insert
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Maxim Patlasov <maximvp@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <2733b41a-b4c6-be94-0118-a1a8d6f26eec@virtuozzo.com>
 <d6e8ef46-c311-b993-909c-4ae2823e2237@virtuozzo.com>
 <CAJfpegupeWA_dFi5Q4RBSdHFAkutEeRk3Z1KZ5mtfkFn-ROo=A@mail.gmail.com>
 <8da94b27-484c-98e4-2152-69d282bcfc50@virtuozzo.com>
 <CAJfpegvU2JQcNM+0mcMPk-_e==RcT0xjqYUHCTzx3g0oCw6RiA@mail.gmail.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <27623253-5814-5bc7-7c89-f8c6faa06249@virtuozzo.com>
Date:   Tue, 14 Jul 2020 09:18:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <CAJfpegvU2JQcNM+0mcMPk-_e==RcT0xjqYUHCTzx3g0oCw6RiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0087.eurprd03.prod.outlook.com
 (2603:10a6:208:69::28) To AM0PR08MB5140.eurprd08.prod.outlook.com
 (2603:10a6:208:162::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0PR03CA0087.eurprd03.prod.outlook.com (2603:10a6:208:69::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Tue, 14 Jul 2020 06:18:09 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac371bc8-ab66-4826-e358-08d827bdae39
X-MS-TrafficTypeDiagnostic: AM0PR08MB3012:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3012774A4D51BB413A1CD3A2AA610@AM0PR08MB3012.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lGcym3Pvcnna6df45hbT5FQa9oI5ZTcf4ENL/H+LBIds6nMXu8yJcpyVP+9rbxvbDVok4CjvtaktCy2lM+xXpp+AgF3oKCGBFJ9MlBD27XQhtZ3YkaVvxCf/zHweMGBTE1tV1jU/LX+vdqB+IiAFw8Te2PL572QrntvwIQDeTUdUGbawzYvsDuC0Up/ZWKn20Dkd0M8U9l9RNPqJ9Lrscz+6u88oHIRW8jxBrUhnYMaWET6RicYKHMkQrIBwTzl1YxarOrDlt70MQlG/szSc5k89HKMGHOLGUTojLzyWsZfBTcarqlwyu0OR0B8iXXmLMrlATnVJ13BqfdIOIRlPFlk65+GnQnXapWM/c19I1rfFxxi0os30ExejOFMx36mh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB5140.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(346002)(39840400004)(396003)(136003)(4326008)(54906003)(83380400001)(31696002)(6916009)(316002)(16576012)(6486002)(36756003)(5660300002)(2906002)(66476007)(8936002)(66556008)(66946007)(8676002)(956004)(31686004)(186003)(2616005)(52116002)(26005)(16526019)(86362001)(478600001)(53546011)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: vS9OnN8PP46vtcHYq/31TzadyDKJIadE4ZlQm+p21QJDvVHF0L3jhrBaaUpfYAlfNuH70B6BI6ygnK1JUVbG66DfUHT2XxefVA68Qb0BZegHr19QOXHdru3DCvV91gRVe86g3cBGkM2KKKTdXNYSAY06hfExV3WRCpd4yY2GP/wuQtY+/+zD80GtJsUCw6Ue0JitRCgZ5ZK63DzchnqOp0H0qvlTBHLuSIYVfPXcqZyLBCixPMTVRnkH0ARv59N9xumZsit9kL7n9Fi6G69k43ZXAwyMG7nAGiXltQaY6eOfU+ilRMIk0D05K/f9HQh+2a/Zg8LwcWlxy3DWMbh8Q6mpIp7Oro7fBMnuZlFpR7XeM9QYz8zoZcmnkCUKTBsDygasy0YfeBWeb3woT7S6sD1xZirhHbdCW8w0DtJioN60iXeeQ7eR4a8t/UWC1IM6Ah3t3pn7troYDAxaO9YxGTKbUK12YtoFsgQyts74m9Y=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac371bc8-ab66-4826-e358-08d827bdae39
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB5140.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 06:18:10.0005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SkKGoqF0/vyBRL9rPuvRZt3jNDqhL8aRyYf9sDP30lWaJ6mJPbdXtZ1mUe0yVxEOyTm+9buTnEP0Ef6GDtgD+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3012
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/13/20 7:14 PM, Miklos Szeredi wrote:
> On Mon, Jul 13, 2020 at 10:02 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>>
>> On 7/11/20 7:01 AM, Miklos Szeredi wrote:
>>> On Thu, Jun 25, 2020 at 11:02 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>>>>
>>>> In current implementation fuse_writepages_fill() tries to share the code:
>>>> for new wpa it calls tree_insert() with num_pages = 0
>>>> then switches to common code used non-modified num_pages
>>>> and increments it at the very end.
>>>>
>>>> Though it triggers WARN_ON(!wpa->ia.ap.num_pages) in tree_insert()
>>>>  WARNING: CPU: 1 PID: 17211 at fs/fuse/file.c:1728 tree_insert+0xab/0xc0 [fuse]
>>>>  RIP: 0010:tree_insert+0xab/0xc0 [fuse]
>>>>  Call Trace:
>>>>   fuse_writepages_fill+0x5da/0x6a0 [fuse]
>>>>   write_cache_pages+0x171/0x470
>>>>   fuse_writepages+0x8a/0x100 [fuse]
>>>>   do_writepages+0x43/0xe0
>>>>
>>>> This patch re-works fuse_writepages_fill() to call tree_insert()
>>>> with num_pages = 1 and avoids its subsequent increment and
>>>> an extra spin_lock(&fi->lock) for newly added wpa.
>>>
>>> Looks good.  However, I don't like the way fuse_writepage_in_flight()
>>> is silently changed to insert page into the rb_tree.  Also the
>>> insertion can be merged with the search for in-flight and be done
>>> unconditionally to simplify the logic.  See attached patch.
>>
>> Your patch looks correct for me except 2 things:
> 
> Thanks for reviewing.
> 
>> 1) you have lost "data->wpa = NULL;" when fuse_writepage_add() returns false.
> 
> This is intentional, because this is in the !data->wpa branch.

Agree, I was wrong here.

>> 2) in the same case old code did not set data->orig_pages[ap->num_pages] = page;
> 
> That is also intentional, in this case the origi_pages[0] is either
> overwritten with the next page or discarded due to data->wpa being
> NULL.

Got it, agree, it should not be a problem.

> I'll write these up in the patch header.

Thank you,
	Vasily Averin
