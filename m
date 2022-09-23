Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5879A5E72F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 06:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiIWEeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 00:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIWEef (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 00:34:35 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAF92679;
        Thu, 22 Sep 2022 21:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJ/E9YLSUwYPPnNfq+tfBDLgpAO/SRu6MVKe14N2Chy54epRAD6yusBNMq4D2vf3Je79hhgZZSH8ZLTGwQyZviiIICZgGr+EVYWrswiwviBkQx3YrpbtKZpMYYLsViLq3p/WBUzSlRtGJl4jDOjjjmh81KDd5KH2EsjH+59ne3pl7njJWxRqFzwUMVcQgmM3XH/Y1785Uty2+SBUzRSxenxm0dEVH7BoXyXMdKn1QGXER6SU2BpXHadq8R6V7f+cOVUxqxfg1HC1XL/8hsxMrNzKHfllOctwNaa6C8lCRsB+eXgz3SO6NIlMMoW7vQMIR4uCH5Bas1rB4H6fNfQ/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s71ycgE3YSB9J0FOZcfERbK3D2ZGqm7PEvlIVQPQSvM=;
 b=nBWey38hwWX9BLWlgKIPxaCNlP4uMgdiFG/s6hIDnPYC/8JIyFJbHqy7ToWrpOD8K5kqBJDRFjptyD07n+PQOocfeR8l4h6ti8NocZwIAv/QDbEJU/z3uF/PYYqCvwmYUrBVhuqT96dbw8Yr0JBF0akmzO5eMK0Uj0TMOSN+SEvHskLQUGo9EHMk6s0CxH+1jPfJ3N9itB0HukwKFfztBXiKIvK/vuScpl9d4umtDLPNuHnhfYTv6u8nv8nH2KeWgv3C7iMyjHyAi72n2+ubIVadtzexqsh+m09LsUJWDqshYIrhDyUUiTYWCD0k5BaG/lhhFeMSQofmrQQVOf36CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s71ycgE3YSB9J0FOZcfERbK3D2ZGqm7PEvlIVQPQSvM=;
 b=KDLYDHNEVHVDSad1NUBQh4K3QxuJyiXNeuuKg1aiLoMxKMWg5SE8JrgDTG8qIXJsgX0CWwT4wDk9k/UqrPjirpVoy958eQvme6L8ARnttVKgg3nA0n4FGvW2uJjhNgNI9Z4augPb3ns73v/qt55RXYX60kf8QQFbHJarobUe+mcKmXHdgF+yiAO2McCgypxX535edK8Vp4ZR1479At9JINEtB5g/am0epGvCyClOJoRuHrtS+a+6WkSJUAHHoet6SZ3fWeqLvXN/LHo2uW1z4RonjirZ4ZblRgFZIQk9hji/5h03wZi1B4WAf2rcYW8lj3uitMhN2fFXL8FxrB9dRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DS0PR12MB6605.namprd12.prod.outlook.com (2603:10b6:8:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Fri, 23 Sep
 2022 04:34:30 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6405:bafc:2fd6:2d55]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6405:bafc:2fd6:2d55%7]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 04:34:30 +0000
Message-ID: <c46b63f6-d222-36cb-ffb4-558df20edf24@nvidia.com>
Date:   Thu, 22 Sep 2022 21:34:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 4/7] iov_iter: new iov_iter_pin_pages*() routines
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <103fe662-3dc8-35cb-1a68-dda8af95c518@nvidia.com>
 <Yxb7YQWgjHkZet4u@infradead.org> <20220906102106.q23ovgyjyrsnbhkp@quack3>
 <YxhaJktqtHw3QTSG@infradead.org> <YyFPtTtxYozCuXvu@ZenIV>
 <20220914145233.cyeljaku4egeu4x2@quack3> <YyIEgD8ksSZTsUdJ@ZenIV>
 <20220915081625.6a72nza6yq4l5etp@quack3> <YyvG+Oih2A37Grcf@ZenIV>
 <a6f95605-c2d5-6ec5-b85c-d1f3f8664646@nvidia.com>
 <20220922112935.pep45vfqfw5766gq@quack3>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220922112935.pep45vfqfw5766gq@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0062.namprd08.prod.outlook.com
 (2603:10b6:a03:117::39) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|DS0PR12MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca31e1c-2fc0-4674-6195-08da9d1ce7b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQftdA0+M+FBmjMhq2m/hGHU3I8VG6TXPBcOTH0d8Vz4qPE6nXsSaIz6mEuXfCHUSG2deKOOY+i+fdY3wifKSvsmyuK5UXg7/xnkuNieE09fssz14ADhH/lKxsNouIJ57dj3icNoOH68O2UiOhPniTCs8MRk+5+vVHpLF7PO7wmijE7Ja/bhtEgklg3cvFhMsyVvUhmLeJvuR/tR2G6vS+9s2SMAmYrwnrXWbiuSeE+VCiLkaN2k04DDSxIgX8UWdSmUKNZ87wPiU3JaWcTSKKDTog/jpkkW/aVJtSwSN4rkVGepAWZyajIaxuUPkQs5izy7hwlbxBinalCs9uFOjBEQh5putg+dYQuWzdsn+6KKdN4ZP6TO3RBlK/FEAn8rtwQsh3xLRdotivbM7KhyW5vajXKLjEB2iAq1QzWbIwHR/wKTVGA86Jkc6hLQBCECZOXw1Lvv6nRPUikjFWgZw0JBiwiLHMqZp5WxPt1jmXzvy2EA2UnzM00LfCIl671qDzUZyWcKK8hVUBWpEWYmMmDP83XuzHwGOg2gTavKdGf6BNt9xK0CyfRs1pK1a1v4GMVd9NzqiDyl26AeKtbhaNBcWI3YNDPL6MbTtuDPdtb9oCQ7f/Ue4TOk6AZ8mgPT8BistX+N6MhS0u9BgW81+yRtpV0oHENY05byYkxTN7J53/CT0qbmUb9BDar6ugHrlsXgFwCtPzmUpgTANy9YhoclsH18IrZW8lH0+J8h/kQ+FWGHZG3fsbthC7oFm8njd6V0FNWfhtob5O+y1oib1H3/9kkkcsOapiOQQWZwJII=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199015)(31686004)(36756003)(2906002)(66556008)(8676002)(31696002)(4326008)(83380400001)(38100700002)(86362001)(8936002)(7416002)(4744005)(6916009)(5660300002)(66946007)(316002)(66476007)(186003)(6486002)(2616005)(478600001)(54906003)(26005)(41300700001)(6512007)(6666004)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzNtcGlFQlFzK0tCbkQxZUYrb3FHTWhFWE9QbkNSSFhrMzllQkdwa0ROQ01J?=
 =?utf-8?B?K25WMWp0RnVrTnVLTGdKTjUvb3hLaWlSTDlic2NlYzdmSjF3Rm5TckliTFNw?=
 =?utf-8?B?UllsQWxMNVFMY2Y0MlBOQk9OcnV1eExrRmNjYk9xYm5lTFhMNzhicXVLTkps?=
 =?utf-8?B?S2pudXFKdjdKNy9yem5YWHJ5b0JIejBXN053UE5mc0w2czdJRmFQbWVNaWRG?=
 =?utf-8?B?RGt6WnU3ZHNuSDVabStFbWl5RThLWEJvZFU2Z1dsN0Q1eG5EQVQ1UGVxZE9h?=
 =?utf-8?B?NzBaTDkweGZjaFpVL2dlak1HREFPWG5GT3VnUG5CNERodkRnMlNYeW1mMGFI?=
 =?utf-8?B?VnhuYWtsMlhDd0FFSjJEUU1RcGFOdEFhR0xVc202SXZ2OHRrK0trVXVjMkpH?=
 =?utf-8?B?b2ljb3ZRNGVVL2xvVlJEYjREOGQ2TFMrSG8vbjcwdU5sZHFzc1JOQzV2enFj?=
 =?utf-8?B?RFRrTlFhd20xR2dKWjhGY0M1a21rMGZ6Tld5VlRhZlFPVW9WUWRxMmJtNHZQ?=
 =?utf-8?B?M1IwQkQ4OERDN3VobTdDblhCMWhuUDVsY081dWsxcWtSckRTZDhic1ZhMTJ3?=
 =?utf-8?B?NEhUbWwrYnFBTEtVandhSTVQbXlZTDh4bVpJSE5lNnEwYkt1Q0g5RFJBT2Fm?=
 =?utf-8?B?S1hQYmlWanBLN2N3djNvR2F2aW5NSlo2WE84emVlQmpVZmhlalpxd25yNEtE?=
 =?utf-8?B?aXJkZmxpeCtXaFc2dGpVNFFpdDFVM0VzK2xXUUJISmY3UHZJNHJaWVJqZDRv?=
 =?utf-8?B?WCtZaXdENHYvWGh6dVZHS1dwZFlhSzJGR2xsd2ZnUTZFdmdyWFFzR3FxSEVm?=
 =?utf-8?B?bkhpUG9iMm1uT2RmdXpYeUQzS1pZUXZid21kdmkrTHU3bWFEU3RXN1A2b0Nm?=
 =?utf-8?B?V1duWkhuOFF1c0liZk4vSWZTS2Myd0w1MmFQVENucGczSHFLeWN6SWJEdE54?=
 =?utf-8?B?SGxpNnFzOGVEdk5qOW5zSlNaZGE3M1F0VFM1SFZEOUxMNG1PMVIvaFI0cWc1?=
 =?utf-8?B?S20vVDVDY0IzZCtib3FOaEpySjFuMkMveVRpZkZHTzQxbXJudkp4QytxK0tW?=
 =?utf-8?B?SkZYRmlMOUhySWhoSXpWZHhDbW04UWpYcjJ3bHJ0YmtQL3JYcGFBYjBEdjhM?=
 =?utf-8?B?NVF3OVFhSjlObVhBeHF0RmF5SHNRK2ZiSXh0S1NjUXFYZnBaRjhCK2FtQ0dw?=
 =?utf-8?B?WDBHMjFZcjQ3QkxOMUo0akg3MUlVVGpEdGUwQzZscFJuUnVJUU9ldUZob2N2?=
 =?utf-8?B?RmdpSTlRclJNcFUvd0JUMWtoNTQrWFNTSTlhMWYrYXJCZHY5OEFzL1diYVhX?=
 =?utf-8?B?ZmE0L21ud1hpTGVrYi9JN0cycmZXWXBxbmFtSlFnNUY4RVh0dXZQTXhuZHUw?=
 =?utf-8?B?U0pHNHlOcmVBekFKYTBGWDZTZlA3VytRUDVaQXhKT1JzaVpocW4vWDJvOU9u?=
 =?utf-8?B?VXR5ZzR5WGpmSGxYeUtEbGo2SVJLVlVsaHlRZnY2bkNGQ0NMTUd6QjdVbktY?=
 =?utf-8?B?SFVSQVFXc2l1amJKTEtYTjlyOWxsaVMray9HRjJOVFlVekF1V29JZHNzYkFZ?=
 =?utf-8?B?UEEwWnNyU3dsQmdmTXJvMFMyQWdUeURqL21HaXJyZVhEMUhjQ2RwdFFQM2xO?=
 =?utf-8?B?SUNlbzZkQ1FKR2ZEMHQ5UjlmVTlvbTJqcnhJeUhNdVpqUDNUV01lNkpDVVVO?=
 =?utf-8?B?endQcmdNdzRXVlhtbTU5ZU5vdkdHenpsT0pvYWtUazZpajFyU3h3MzQxZXRj?=
 =?utf-8?B?MWR5cXBDWHpvb29MTzJmYnIzRGdRSFNCeXRxNTBaNmJNUGtRbk8rbURXVUF6?=
 =?utf-8?B?UjFaZ0NJaitGZ21vSWRxcDFJRHdkTy9ZbFFZWEZaMEFjL01oOG1aMTkzZy90?=
 =?utf-8?B?Mmkwcnp6Y2I5cGg1N1NBNTk4NjRuTGE2eGV3V3hoMWMwRTJKeHVvNklMMHpO?=
 =?utf-8?B?by9oWERZMVo2Ykx0aXJNWGtnQ1p4REh3WjZMN2JnZEFRNG56U1VxaVJ6aDN4?=
 =?utf-8?B?OE43S2FYQXlPVTQrS2s2RnVoczM3SjNGdHkzWXFxZUM3NEY0dkFTZVNVcllq?=
 =?utf-8?B?Mk45WmdreHFYQUlYU0FENXB5WCt2NVJKSjJJZk1oekFkTFhVNDR0ejZQT3hl?=
 =?utf-8?B?Rm5CN1g4K1FQc0lYd0JIbzg2Zk9nTTJLdkJGTDBqZjl1SnpKeTN1dWNMOXYw?=
 =?utf-8?B?OVE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca31e1c-2fc0-4674-6195-08da9d1ce7b3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 04:34:29.9690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KW2N3yXvFat5zJQzIXBT/rCemUAbZQunKdHDKX/HD2W5zKd9IF5a4l3VxrA2fFjPFzVY2pjiImv/RDkhhQPecA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6605
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/22/22 04:29, Jan Kara wrote:
> I don't think this will work. The pin nfs_direct_read_schedule_iovec()
> obtains needs to be released once the IO is completed. Not once the IO is
> submitted. Notice how nfs_create_request()->__nfs_create_request() gets
> another page reference which is released on completion
> (nfs_direct_read_completion->nfs_release_request->nfs_page_group_destroy->
> nfs_free_request->nfs_clear_request). And we need to stop releasing the
> obtained pin in nfs_direct_read_schedule_iovec() (and acquiring another
> reference in __nfs_create_request()) and instead propagate it to
> nfs_clear_request() where it can get released.
> 
> 								Honza

OK, now I see how that is supposed to work, thanks for explaining!


thanks,

-- 
John Hubbard
NVIDIA

