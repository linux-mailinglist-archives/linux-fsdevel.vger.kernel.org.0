Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4594C7BA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 22:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiB1VRV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 16:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiB1VRU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:17:20 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB8CDFD2;
        Mon, 28 Feb 2022 13:16:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8K4icPct8eYSLAzPZUAiaBn+vTJfTusg54/WFtU8TfFCqiBLJNp0bzaQ+DWvA6gutIESkSv5s44yVRgtPHcEruUFTRixZtT6enO1iBOnblB00tdK3SzKwEua79AcZNcCqW4h/FqTwHKjoPWMOXGIIYCXCvU7eiQZq3+d8qiKZZIAGYsIGkBvyXZQeFkY/vFnLZxecip5iUjZVnpWf6RfuHQTvkfzGnf3ZBVqDrN+PdT8+CmlkWZZZY+j3qpRaQMfYyH6aoqgXzfptSw9Ed+vwcDqKQOncn4gL1Cs18ZrKOAr4K0lPUTpqrmGBxFpWOUl75ySoav5mRMSx36OPtk+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/n0bRGxCZtWPcItEnN/BGF6a96Yp4Hfzwhz0Z01e8Y=;
 b=BnouvNTS5I4De2QBWFZu4JDe8W2GFbSAshVo0CMf3LAybclIUWspFCLydXdC4O1s9mPCvEDxR1AtWc50a7nW8UQ+ra64Zn4uYB1xoGkn1jTdo/h/gdrd1tuYvQpIxEbYc4JksSKErS6DFZsbn+bDyHXlrXjiX0XDVblJhYxO8WqVcBDxNeU2I+RkhlF6e01fmiun0q3b0JhwsLAkVeorqoZr9HMR+FWX/MAMNBhP2v9YduM5J1DdQx/kpgvVTCsIBpvsvbNtqqWyqdbWyUiyTlbQ7rAg5UMSVPcYgYc5QG1l/vxQRpjuAPeO3XazxS9Q9alE/JM5X/8IAVkvVNpfqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/n0bRGxCZtWPcItEnN/BGF6a96Yp4Hfzwhz0Z01e8Y=;
 b=aFF0Z4n+b7ZKq9x5ykpy4RuN1L66qX3gYge7+kHM9skmKuQ/G9WbxCS0K5ssZ7eVuC4p/K7zMyySDzE60UHs6QlVabgjv32zo3cqOxCXv/Z4K8eMhwPJQAL/p5hXTut3e+9/hrvwauVxiOofH9Bo3gGs1DUsV0sF0uAd3baSqJPzs8JLnoiYyGWC5ydizkNt0iKSVB3XFHlGBRfwn3Yi+pf3aX/MAZQ/i0JS9B0teCfo+4SLYUcQ1ji2V9LtScnTUdOrBZ1YHRZUmTyMAPDyUoyiTcQGdEPC39prUBySjO18y5I2iUGbZi83bL5u6L8BxTvpZx53Jf3dm+HwOcWatA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM5PR1201MB0268.namprd12.prod.outlook.com (2603:10b6:4:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 21:16:35 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%7]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 21:16:35 +0000
Message-ID: <f0b158dc-5b01-67aa-1f49-331bf1ff2bfd@nvidia.com>
Date:   Mon, 28 Feb 2022 13:16:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 6/6] fuse: convert direct IO paths to use FOLL_PIN
Content-Language: en-US
To:     Miklos Szeredi <miklos@szeredi.hu>, jhubbard.send.patches@gmail.com
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220227093434.2889464-1-jhubbard@nvidia.com>
 <20220227093434.2889464-7-jhubbard@nvidia.com>
 <CAJfpegsDkpdCQiPmfKfX_b4-bkkj5N5vRhseifEH6woJ7r0S6A@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAJfpegsDkpdCQiPmfKfX_b4-bkkj5N5vRhseifEH6woJ7r0S6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0380.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::25) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26364b12-1290-4acc-3921-08d9faff99da
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0268:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0268F9CF0FC7B0CDC3A44FDBA8019@DM5PR1201MB0268.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PYukDUMzZs7ro806clh9g6KM6+nM2EGN8HCNvmqgP65kKEPD23i3Ru+mRypaVKWwz8uf9ofnCvpp3bN/bW1Xntsa+A4R85pH3GIB6SjsMMFxcGZrsX2Sg/DmV7gzrsAEZ4Ri24sPKFtzHCg+ogpNakI8BRMuvHjbY3aMpUY5x6dyHAGPd6Pcs8gUkxEtn9xtBSnrhORlq/kvCXmTvLO+fyxFaKzyW6dgAkZil73HDAd9lLbFmDcEvz76llUXrPGm/jVO0NPzhrbLPbPOGM+lSlN+NT64J+eN/HUAUdS2qvH66wbsKCHTm84ixApDPZq02zBSrflEBkd9EzAxLFizwDafLmV7YN/Fqo6HWK04tpcj9o1UnknVrPP981jHKmNhs4g2NBHcqD4UUjnCrKz25/6Wjm2KmNrFI4lGLWj9/XWlZ3DIvisxbViSJIgvR7lGAR9i9gvPOhroYf4F5lgpB/JF2K4mFwaY855OFlt5wY/IP4OhTAQrGtM1qoDMdhLbkm+HVFWGLxbXo4D+YynVP01P2x0HHiNH4QQP2fcGtso6E7AJvi/yQQ8b/cjOQo6Dzxc8kGIn3L2n0e6sGGgOxWl01xW9F/mLHB5h+hFu6K1zOsbdhQs8Wj8enl5sdJaDG+T6YfKdMQ9kEkigMW1wydpb1d4ypSzlwH8EYb9YPORGDlFAX57ak+cHJ87A9OzFHuyT0qtnWCTAI+IEGMK8f74SBT2EfhR00t+WqZgrZD+uNvsXrdGXSyvbDGAjEr0Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(66946007)(6506007)(66556008)(66476007)(8676002)(4326008)(53546011)(2906002)(6486002)(508600001)(54906003)(38100700002)(31696002)(86362001)(316002)(8936002)(7416002)(2616005)(186003)(26005)(5660300002)(31686004)(83380400001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVpmNHg5ZUpEM0VCRWFHZjRQSjRSSGRIRG1WZkw0eUxpZGNQOVZna1FxalBv?=
 =?utf-8?B?NnQ0eWcwNStEZG5rQnlJZjBKTVp1UmlvQWF5SUNTS3FpMVk0YVB4SnM1WE5n?=
 =?utf-8?B?dmdzd2RmdzZlcFlIOEg2Y0UwUjQ2M3Fxdit5dXVHcUNzcEpWR3B6NzBINjU1?=
 =?utf-8?B?TDIvbzVoVVd1R2o5eWRMTk41K3lNeks3U1Fab1FXcGRySzZNSmUvQnlTMzI5?=
 =?utf-8?B?TVVxS2w4MmFaRzRRVU92RlViUmVvVXBUNDNWNUt4U0tVNGt6MmxQZ21sbCta?=
 =?utf-8?B?Sm9mVmlJeTRXVklMMWcvaUtYUDVzeWptaHhmZ0hKbktlYjF1Q292elYySWVj?=
 =?utf-8?B?Y1AzSFVINlpGWE5LUFRjZjMreThMcVhiN2IxemlHUkZNejM5WUJzQmhsSVcv?=
 =?utf-8?B?L2doWWJ0bCt2dE1tem9VWGVWSDdXMGVVNWxFTUE4ZjlsSGFyeGJFWXVIWWhr?=
 =?utf-8?B?OXJQbXR6MUE1RTZNV2Y0MlNacjdFMkpVdHRRczNpSUpNdUsxV1lLeFYxVGpw?=
 =?utf-8?B?bXM1d0kvT1M1RGNRclBTWitMVXpVTW1hY29Mdm1ZL2VNT005MWRSYkt0SkNG?=
 =?utf-8?B?RDZ1VkM5M25PTWdNdjhXOE5obEZySTIxZUcwbWgyTFBuR01sWnRTOWtZcHd3?=
 =?utf-8?B?dllxSjFZaUZwQ0FVTUtSQ0ppK3hPcUtkNklmYTlEWDlCc2JLbFhvOExkODN2?=
 =?utf-8?B?alJONUtUYWc3OTJzUEV0amdMMWJQd2svZndwWWl6UjdjbFQ5dDgyZlpYcmF6?=
 =?utf-8?B?QzNZd21UenE4cUx2NFNzQ1YzRHVYWXhjS1BpTWQ4STlUM0x4b0NIWVltVFVE?=
 =?utf-8?B?ZUdpUFA3T2NNSWRrbkpRbzFUV2d2YWhFYzNRdTF5Vk0vTjI2bDduczREd2wx?=
 =?utf-8?B?d3B1RVhHVHliYXFYWkRpQ2dmdHRLZEFsRE9jVVNsTWxiaURDV0ZseE9vbWN2?=
 =?utf-8?B?cWo2VFBDVkR6QVV0V3VQZTRVVWltZVF2NVJKbFZ5TWZsRkk0ZlFTK2p1RzFX?=
 =?utf-8?B?VUNiZlhKaCs0M2J4Y0c0S2pUNFZVM2MrNGR0d2pyK3R0Vkt2dmhYay9TWFFM?=
 =?utf-8?B?M3BZQmZ6U053YUFla29scHZyUnU1bW1kWXFYSFB1VFU1cHRKNXJZajNGWjh0?=
 =?utf-8?B?NDI4SVdsQnpzR2RTZFRvREZnN2JWYU5NVHU0SUZqcUY2ZDFDUkN2WXBHSmVD?=
 =?utf-8?B?dUlKc2RVRFF0UGlNcTlGZmFSb25zYmg3MmJSQnp0RitWeVJyRTI3Mmkra2Zn?=
 =?utf-8?B?SkUrYmJuRXFpLzBxbHZpaEtiZ3VVOFduLysyWEtiT04rN0VQUzBMOWdKYm5i?=
 =?utf-8?B?QUJVeUxPTWFrZTJrM1gzZmFIM1MxVkxhYThTSzUyOWFCMWJqd2hjUEdBZkRz?=
 =?utf-8?B?aFhqSHNZUVBRZjdWc3p4M0NQWlpoOEhTYXdwaHpScGlRN2J4Yms0RDFxeUhF?=
 =?utf-8?B?MWFtdGhqRERhcGtocVBjWHBMSFlBY2svY3JtUHNtMEFxbTg1NVpyYWw5T3Av?=
 =?utf-8?B?WHNHbFVOTE5xejJ0SDZDTlh1N2pSbExQR1FOT0dML1ZsSmtoWlgwRUpiVzlR?=
 =?utf-8?B?a3VvQXoveGR4dk15Y2xzY3FVaXpnaUVDSTJ1Y1h3dUpFbkVKa045bzZyYUZM?=
 =?utf-8?B?TnBOaUI1VXpjeG82aU9SMHlna29tYzRkTlU3YXhSL3dEeWR4dXNrbitoWGRx?=
 =?utf-8?B?T3N0d3FuSlhwc3FvYmtLSzIxTkxSeUh2UzhDakQxbC83WUErQUgzWXVNQ1JW?=
 =?utf-8?B?bXE2V2d1OHpoVXd6UVdkYWNUbmNXOW1sSU8xaUM4Y09UQS9MMEQxZ0xTNmtj?=
 =?utf-8?B?SUFGWmdPbUpVSy9CSUJoaGhqM3d2UmdnZDNISklBQm01Mm4xd1FHTTFleTdV?=
 =?utf-8?B?eFdtNFNEa1VNbG1DVFJ5T29vQ1ZNQ1cyeHBudE1kV1RkN25BRUFJcWVtUmNZ?=
 =?utf-8?B?a04vckdjRlc1S095am9vZWN2TERkWEljcUFtd2xhUTE2cFcyNk80ZlY5MkxT?=
 =?utf-8?B?RVBjNTMvNnlzdzZFU3pYbk5oQkJjd0x5ZEJZbmxCWVBsbjFrVmxGSkhOdmtt?=
 =?utf-8?B?WVAwRkZzcWN5Syttc0ZIRHZuckRMRXBmaVV0VUM2NHd0SDNwV3pXRmhaRTly?=
 =?utf-8?B?bElnWmFxTjlRelBvOEdocXJBbnVtMVRKejZaRmhiWm8rWFBoZWhNK3ZyUGNz?=
 =?utf-8?Q?ukFnJYk3jrgQ6Ow+jZ7kxVQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26364b12-1290-4acc-3921-08d9faff99da
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 21:16:35.6018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLLMMkvfDDnGhp2TecUlWh+Fuh5ZpOf38qWAObt35QBYlQn/OGvpwt1bZyyNNcHLdzFparf/ZwivI45A380sWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0268
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/28/22 07:59, Miklos Szeredi wrote:
> On Sun, 27 Feb 2022 at 10:34, <jhubbard.send.patches@gmail.com> wrote:
>>
>> From: John Hubbard <jhubbard@nvidia.com>
>>
>> Convert the fuse filesystem to support the new iov_iter_get_pages()
>> behavior. That routine now invokes pin_user_pages_fast(), which means
>> that such pages must be released via unpin_user_page(), rather than via
>> put_page().
>>
>> This commit also removes any possibility of kernel pages being handled,
>> in the fuse_get_user_pages() call. Although this may seem like a steep
>> price to pay, Christoph Hellwig actually recommended it a few years ago
>> for nearly the same situation [1].
> 
> This might work for O_DIRECT, but fuse has this mode of operation
> which turns normal "buffered" I/O into direct I/O.  And that in turn
> will break execve of such files.
> 
> So AFAICS we need to keep kvec handing in some way.
> 

Thanks for bringing that up! Do you have any hints for me, to jump start
a deeper look? And especially, sample programs that exercise this?


thanks,
-- 
John Hubbard
NVIDIA
