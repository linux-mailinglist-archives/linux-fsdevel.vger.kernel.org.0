Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF20B5A84EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 20:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiHaSCx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 14:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiHaSCw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:02:52 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0312AC6CCC;
        Wed, 31 Aug 2022 11:02:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsxWZ9ZoALZWGjbjn29W73ZZTdbSEtsPL77Pm4cWI/p2jBI8wckp/dsh3ZlWr0WvPRuxtwiZIPBxluB61TyrCFEFrFANOdrMo0X+FV2UWZks1FNQ2CslscpPuZwDKKoSeLvc5LNrJqHWGuUYAWJRw8Pbx1klCajftE/cSHjGgoRRRY7qv5H3IlGZyx7IKRvszk3MrK+oFcrBRX3pkY4CmNE/dGYg+tKbGmWgwvtdtTAzRAyaNzrDvm/PxiigwJnZ/T4sBJncvotBS326ptTFnb/FebdnOIM+6Lec3kD5J0dWAqRQUTfRkxPmFNsYDKl6iEgDhLcKOkfZO2tBMHxr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H74zguoUo/WcRNEIN40L3e35AvSumUDwpxlKWAaZuDE=;
 b=KRwdNiaRi9jOwubaNM4fVlA+z5ZiHwesKBjURiXQt5Bb4E2yr9O69goNDZD1cMntiO2AJKR0+w3NJ1lqI1g722AXhBBPYZYQRiyZsOKIsC3L+KHfWwqHygYgNWhip/+3iK3Tg5wygB5Uz9apu/1+BQC7EWUrOry3zAjxqhyXtw6AiI9hYoZc5zPcbjwECEL8uWi4kMb0LDCrzzMwmwlV/fekeqUJSoJOnmQUJ/dhbZ9wFx0Ng3UZoUKdB+DxSiGrVTNb3Zpkt7JKjJPI9FK2oAID8sUqY3eIiuiqsPVDI478NLnqQ6dkA/wYiPOcIBkItpvtOxJM3dDNXIYlhQyaYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H74zguoUo/WcRNEIN40L3e35AvSumUDwpxlKWAaZuDE=;
 b=eqrI7mnomzJz6dXE8NdMf7I3wJ7+nqkPq6ys4O4ccel6QrSLMjHhG+k8z8vB2+sfHIppSm90v2woQMt+OzaNVoHxEuD66YPxj8YqbE3rKKWc1M9rwBwQu5mwQcKEAcSBrwf1248wJvbrze5cUMYdzIBdqcEaY10nbH4ENhqNMRJAw+GorHG2R7tgHbCq+YD8q3vHvC/vez6Wg7AiFz5AIhskl0PS44jEWzvVMogYnbMWiFRbnmQ9kKDXwAJ3LEADKX2IhQPX/BrJJtKKOlakduZ/pJSNgee60Gf1f3T1ZoZidQL61JzTe1Srv6JcfLmSJvIqpsrTBkd9q6irLsW+1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 18:02:48 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 18:02:48 +0000
Message-ID: <c66b13a6-b9d7-381a-4fb8-cc5e8b833ac5@nvidia.com>
Date:   Wed, 31 Aug 2022 11:02:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 5/6] NFS: direct-io: convert to FOLL_PIN pages
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <20220827083607.2345453-1-jhubbard@nvidia.com>
 <20220827083607.2345453-6-jhubbard@nvidia.com> <YwqfWoAE2Awp4YvT@ZenIV>
 <353f18ac-0792-2cb7-6675-868d0bd41d3d@nvidia.com> <Ywq5ILRNxsbWvFQe@ZenIV>
 <Ywq5VrSrY341UVpL@ZenIV> <217b4a17-1355-06c5-291e-7980c0d3cea6@nvidia.com>
 <20220829160808.rwkkiuelipr3huxk@quack3>
 <a53b2d14-687a-16c9-2f63-4f94876f8b3c@nvidia.com>
 <20220831094349.boln4jjajkdtykx3@quack3>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220831094349.boln4jjajkdtykx3@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0003.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::16) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 952b5246-39bc-4c85-d96a-08da8b7b03a4
X-MS-TrafficTypeDiagnostic: PH7PR12MB5880:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QabiXuw8/FIHuhaifxZqAANb+ahL9duSSe1mFjoJrgmSRM/iD3gMmKtV6E+Mnrkxv+EEJ52wRR1ctk/RYvzcNRPGwtZ7J7YXL3o5L1nVVLdnZGOiWempJO3gUZvO6QEimHAYm+7pUyt6nc05stikNQgzbUYszMhETKaU/XXNifuJuabkkuXtKiQjYjnN/0qPn4DIrID77LI8LKBCYmOFC72zFmKV8UGhvO0GOwkWcvIBA0WfHsY3NGw2GvizP7YXhjBeYRDlim2szcscpq9NRsmmnbWL1i9pqvn9vmpUfZqUhN2MY+ndKzqCTGCemFa03wI81Qn4ot5TFiDsJQoa3tdMIM2BBfN0AMl6Ye4gv6v7+eqIirpXkUylD/y2EjibtYqvsMMvA9v153OnPqRFX7D8tdtzbh8bdk7u/m1ILM9d9gt7yi8YF/bqSksdlMSCEskRQlPn5zQdWlQz8PtIPXP/W2wBrp169ZTOhm8xt18OdHLdNPDye5dYpEUaoicodtbZsrDiTFFPNGVCktUeYbNhYoEW/lyeFLEbIe7aUFvmv0S+5DK8r8IVZN9FEiludRefRB7hnjuH8MBA5B5fKSWCVimux4K5CaRi1KZyjuSc++fSNSdyyZa+l/+y45/KignmQbUKVO0wkJF19J9oqCj1KhaD9nHR/u7X7zDY2Sjrrwqqg+f3MtojfOfZjtuNZsuwbUfnQIIg5lADEBBz7TYizRVob6Vk132JHZ2uTmpMGa8y5kf6KEBPvsWl15WsFtLitvUtgqkXLi8nCoV7xweAkBeilgT3qAdY6JndzSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(83380400001)(53546011)(86362001)(26005)(31696002)(6666004)(478600001)(6486002)(6506007)(41300700001)(186003)(6512007)(38100700002)(316002)(2616005)(6916009)(8936002)(4326008)(5660300002)(8676002)(66556008)(66946007)(66476007)(31686004)(2906002)(54906003)(36756003)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXVoMC9VU29IVTV1QmtWWkFZWTlOd0xLdDV0L2VHTFZ4REhLWkZpTGRYcmxp?=
 =?utf-8?B?Y1VEMWdSUVYzMGN1TnBHTmUrS1hIZ2lCcTEwcjdveHppL0J0bnQwWmVGU2NI?=
 =?utf-8?B?c3F3RTVWSldqOGk5bEFZeXQxVC8xbHFaS01SSVB4T3ltWjBJWGUwSllMYlhu?=
 =?utf-8?B?Zm9aOEtTRjd5SlZyYXAwZzV1d1JoWCs0VGpoRnpnOEVKZ3RUSlNzYk4zZjBx?=
 =?utf-8?B?dDhHcEorcnFqSThVYWQ2Q2I3QVhBekFORllkK3VPclhkTURjT2ltZElKQXRl?=
 =?utf-8?B?elBIbmpxVVk2aUlOdi8yK1lGS1hJbUlobzBEdm1aeTUydXM5Z1hBbFM2bWhQ?=
 =?utf-8?B?bEtGT1J2ZUJsMmdtRzJPOFhVTU8rRlMzanlEdmVHWllCem5aNHVhUndJejlr?=
 =?utf-8?B?ZmlKUHJLa2R2Vi91dEtGdTNocHN5RTg5OEtEL0N1OXhDNTA2QkNqcmlBNitH?=
 =?utf-8?B?MncrbFoxNStRQy84K1N3UTJEMkpnQjBjaXFvVlNSTFUvUGkzclUxcnRNM3cv?=
 =?utf-8?B?K3ZyZUNZVE1IaFVsRVBQVmoxYlNGQTdkcjJodzdkRk1aR1lnSUE5YVFLcFk3?=
 =?utf-8?B?U2grL1lCaWVvNmZMOFdqbmYyZCt3R09FZGVOeDN2WXZ5b3ZsRGp5eEJraWlk?=
 =?utf-8?B?NW8yZnNmdjdwazJuYi9INWxEU0MycmNrSVFuaVJ2ODZxS1orZ2JOazV6bDNu?=
 =?utf-8?B?dHU4Vnd2ZEdWRjY4VnJ1ekEvNkVDOG95VmR0V0lySjNKWDdpSU9uWEh1N2h2?=
 =?utf-8?B?TmEyQzdPNEwrSVFnbFE5ZGQ3eVFYRzhydys2MTlHdjRwNnhmVlRsN3ppQWdu?=
 =?utf-8?B?MVRQRFpnbjdNU3JXZm10L2NHTU5MKzk0bzV1TkZDS3owTHIzdTBJeWVMeEkv?=
 =?utf-8?B?K2ZZSWFGbVFrTmRPc0x6WksrZ1ptM1JUNWRZVGVOdk5sVlhoVnltVlljd0Na?=
 =?utf-8?B?THkyaW8vMWd5ejVCM0VpeGJGWldlY09seGFJc1VqY250R1RWUm5qTkdmT2o5?=
 =?utf-8?B?TERQUE56SlFsRGpWY3BEOGRIak5ybzBUWng5TDlmbGc0TUpoSXZLN2FSZjNE?=
 =?utf-8?B?azFxWXkydTIvVUFkMkRlVEptTW5Qam0yU0M1L0lyejBuck1SY29RK2xtUjU3?=
 =?utf-8?B?NlBsT3IrN0crWk43Sm5tRVQ1UHVFNmVKdFpWeXVXRHRWWmtGTXd0YW5HS2Nk?=
 =?utf-8?B?N2dqcGtROEdvSnFHQ0hnNWVrelRkRFBBWmZSMGh3eDgzT0VOVkIyeVJKK1kx?=
 =?utf-8?B?WGF0aUZ4aE8xa0J0YTFrNXpHZ0tlOUdJOXd4ZENpd3hVeDNYY2gwRzY3OSs3?=
 =?utf-8?B?bG13YVZDT0gzY1JMNFRXM1JlWkI3RTExUThPd1VVVmNwcjA4N1hZMUpzTy95?=
 =?utf-8?B?VkJLY2J5ay9sWHhtMjgvOStKcXF6NGcrd29EOXNWT1dpam91dHRzSzdzTFE5?=
 =?utf-8?B?TVB6c2E4dTBFZmNENWxkWWs0WEIzcUtaRDhZdDJTKy9PeFZJeDkvc1kzWFF5?=
 =?utf-8?B?c0xCVmUrZ2d4dkNoMUxLTjBwVDFSY3F6ODJZWXZ1UzlzYk44VVovOHBJNkRp?=
 =?utf-8?B?RTN0MFlpMXA2TFpsVG52YlgyVExpclkyQ2FhdGdGb2hmY2Y4akUzNkFVMEsw?=
 =?utf-8?B?ck5mL2ZadmppNE9SZzBITi94WjB1TXJDenI2Sm1UVnRZZFpjdVlXbW0zRnUy?=
 =?utf-8?B?VGxjRGFvTnlieldxS25lckJhVzRqOGxFOFpyQ29JWUw0VEFaVGdDU1lUcUJD?=
 =?utf-8?B?YlZ4WXhORHpOMjBVLzl0d1JoZ0t1RFBiSDQ1Qnl2SHdyY2JJQkNQZGhtSmVY?=
 =?utf-8?B?S0c3WTEzaXVXNnVVRDF2dW1DbjU3VUNpejFLeHBRcDVmTEIwS3VhN1dVTkNr?=
 =?utf-8?B?ZFQxRWEvVm1LTUc3THhPUVJlbHFxbHYrS0tnL1oyNHdPS0ZSODREcEZ4NlZh?=
 =?utf-8?B?QkFNSlc0Qmw1ZTN6Q2l1MVQ5aWlySnNaWVNiZk4rbHpaSU5tOE1KQnNZVTEy?=
 =?utf-8?B?QmlLNzFpejlQRm5ZdkN4N2huYThIZGNPNFdyL0VrZHl1djNmMU9hOVRtL1Ft?=
 =?utf-8?B?S1Z1STlJMDVmTTVvN2V0NVdqa0c3N3dmRElEUVFiQ1lac1VxaFh3SmpOa2tF?=
 =?utf-8?Q?GyHA7ufh5iGbw1P5eUfqzbe/H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952b5246-39bc-4c85-d96a-08da8b7b03a4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 18:02:48.6438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aC564EZzlLoGCRfQPGAqDr6OJJvIJ7Wj4jwnFOEHJQlCb4gfKSyfxlNPUz3ldVGwcu/gBZTDkV0uhuT735H/Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/31/22 02:43, Jan Kara wrote:
>> OK, thanks, that looks viable. So, that approach assumes that the
>> remaining two cases in __iov_iter_get_pages_alloc() will never end up
>> being released via bio_release_pages():
>>
>>     iov_iter_is_pipe(i)
>>     iov_iter_is_xarray(i)
>>
>> I'm actually a little worried about ITER_XARRAY, which is a recent addition.
>> It seems to be used in ways that are similar to ITER_BVEC, and cephfs is
>> using it. It's probably OK for now, for this series, which doesn't yet
>> convert cephfs.
> 
> So after looking into that a bit more, I think a clean approach would be to
> provide iov_iter_pin_pages2() and iov_iter_pages_alloc2(), under the hood
> in __iov_iter_get_pages_alloc() make sure we use pin_user_page() instead of
> get_page() in all the cases (using this in pipe_get_pages() and
> iter_xarray_get_pages() is easy) and then make all bio handling use the
> pinning variants for iters. I think at least iov_iter_is_pipe() case needs
> to be handled as well because as I wrote above, pipe pages can enter direct
> IO code e.g. for splice(2).
> 

OK, yes.

> Also I think that all iov_iter_get_pages2() (or the _alloc2 variant) users
> actually do want the "pin page" semantics in the end (they are accessing
> page contents) so eventually we should convert them all to
> iov_iter_pin_pages2() and remove iov_iter_get_pages2() altogether. But this
> will take some more conversion work with networking etc. so I'd start with
> converting bios only.
> 
> 								Honza


I'll give this approach a spin, thanks very much for the guidance!


thanks,

-- 
John Hubbard
NVIDIA
