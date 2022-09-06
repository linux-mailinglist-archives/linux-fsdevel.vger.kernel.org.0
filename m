Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4205AE0A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 09:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbiIFHLD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 03:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbiIFHLB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:11:01 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFFEF59A;
        Tue,  6 Sep 2022 00:10:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIVsCKVJf3wmtjER4ljTFXHMN8KSX6ZswTNccskJ2jLdWAFVp4nlQ0sDnDMmeEhdEndft2RslZwcJ5Q92Rj+OcdpyzEto+dQv5B77f4mgd3UAJ9K+A84c8Ht6qQiwI9IwbkCO4ozXU+ZFcchWBnXOBY0nxJHJQ5X4MgDsrYrsclmx/G3/K+o1n9S0B23h86FQ/cnTHWfxYX/hibaT9hEVXPmGQCTDNUhdBX88EQKtmrok7huZa5ISMTP3KgV0ZnJY/hS8P2uEcVHTXVRowezFJEaK3+0MEzxs/UPaP06OoSLjmt703IFCjMJAC6vUQzxHrEW3B4WUs4CW4VBntZaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNb+7Ukaw5YmVz8o4zeFvFfwLlsvokJvmwbInUTyNW4=;
 b=jltmcw6jzKrbOO/kkFhpbosG6kjX7TqF32CCtRYSBZ0F1DPTjZkanTNjlUlk8HUxYgK4Y1o9NU6NWrd9jeHdnZwRG3BO/H0BCmGdh4TYLMYhkrE5CJ9/S/1Wb+WTrCzBKwAPMhUiDWJzEMBhc+dvlyf5x4j9yNO1jKemynvZZObZwSFB2hOErw3hUAuMl8cRjJdp6pkO2z4bSaJI1G2UzLUeBVTaRhTJfjpBgzZr8jcfXXqgcwe7n5yYR4Z9V2qm9X4rVgOV0gjnUR6G3Jm/Sv3RlQSpfJJvZuFrRG4DfY5/mXeJhdUKZj36XzXvweR2pNZMeEk4mqHexIJZ1040mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNb+7Ukaw5YmVz8o4zeFvFfwLlsvokJvmwbInUTyNW4=;
 b=lHp86kIl/vdBRTAUY1ZoNlZQY7TskA89hSoVpLpLEq5uNdHC7YxaRDlOcT2j5vIxH+N6mhdyu20Au6uzbK3JMFph51s/OgxtDDm42hyn3WnIbA9w8T0/tsB9RNgR493eZNVzctkdgH37DguqDhjw8xPX+xmJdkEnWh9lHwxmgQ/lP3vL7xnw8PmvQN4zL2V9q6XJolj8aiF/SHQ40jQ2wsUoOszUqoYumBn7dJA1NJRPn26w4boiHC1DfjkL4BVX+XwXFDZxfwZh/kSAJ3feLKHF/7WlV/a608hK6GDgQiJnBlGolj1bNxK8nZlFwTSXCk9qcwW9PBiK65aQgT0XiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by SJ1PR12MB6124.namprd12.prod.outlook.com (2603:10b6:a03:459::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Tue, 6 Sep
 2022 07:10:58 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::e0c5:bb15:a743:7ddb]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::e0c5:bb15:a743:7ddb%3]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 07:10:58 +0000
Message-ID: <50d1d649-cb41-3031-c459-bbd38295c619@nvidia.com>
Date:   Tue, 6 Sep 2022 00:10:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 0/7] convert most filesystems to pin_user_pages_fast()
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
 <YxbqUvDJ/rJsLMPZ@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YxbqUvDJ/rJsLMPZ@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::15) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d22c25b8-575b-433b-eebd-08da8fd6f286
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6124:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jodpvIVTVK0ji/+hMCffESmTpY6g+kmM9ujGurTLnVCotEStRW6U5+05rKtdlj1+A8raNIyc/BiL01fm07yRD+kx2IbYN8ImbK/O/7qjwvZCGzG5eO6kY6AD+yRQsCY14XVLHVntrkMCruSFcSvonVySsqadegNZxPMcN9+2iv/NsYDRXe1Qi/XRR4JwWllw3Qy35kyLytv28WyEQLYVfdVqilsuOoCBEb1hCJlOQitCcW6zcGLSdtgX/YLIFJBKguARKI0hrEHlaO3ggyJ1FLm3ba/JJ1iJWjqQlL3Ef4QhxYQRcSJmv+nnRAHPalNRvzt7lkSK4vHBpna/J32GVQUa50gLgMCkM31c7Y2XPavLzs9eY3FxJSf/7weC9ij+Rq2+axXnHoszTl/fDEhsQFXwHe3xEV7Z8a1jiR58qu3pEzwvRFlKQKLn8s+vt/koqbWf7DoKK2/VaAiL3KNTvrFb72bPmoJah0GH5s5hPAcSXXhXgTBS/VJIJMGq0N7pVG6i2av5AA6vwYuDxTMJZug14XY4P1MZfCG36ANTIdXSuQKkFnN5cJkDhW1l8vUGBwXI54fbIUB+kPqK1T07FiWKIyQcM/Ig6P7qqxxvQBTZ3V9uvaj1aGfE3Be/Olyqgwt2N4XDy2IWTccivujRB1U2vkOaEaaWxPHULCYwsOTjJxLpZnxbWe+tpeUod6LNkLrCQGExDGSwqhag06iqIXbqnrgJtPnQpmnBY9IMRvbrMRe5EwHx793/vaoTXNRz6r+1mtdbJOHnaJsb2C/CLbzc2qqSOL9QwF2FTlfwFTE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(86362001)(83380400001)(66476007)(31696002)(4326008)(31686004)(8676002)(478600001)(66946007)(38100700002)(41300700001)(6486002)(5660300002)(6666004)(54906003)(8936002)(6916009)(2906002)(316002)(66556008)(26005)(53546011)(6512007)(36756003)(6506007)(186003)(7416002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R05yWkpDS3poUmJPdXl2MnhkbmdEa1ZBZnhqUk1URk0ybjUrRE5MZ1FWL1Uw?=
 =?utf-8?B?T0gxWCtYRmlPT2FrVGhhZHRFQXYrNk1KOThhdUNBN3ZSQ0JJazg2YkFJTDZu?=
 =?utf-8?B?ZFVXM3hjb2Z3eTlqai96UlpkdlNxSzk4aE5mK1R2OTBGWXZxVTEzSlNwektB?=
 =?utf-8?B?TG9ad3l0SDF2a001QTc2SVJtSHJvVE0venlXNC9oaUMxUEdTNDREemZhWDFx?=
 =?utf-8?B?WWVqdFBhYy9uYUhLd1B6dy9VbEcvZmJIQWkwMGVxcXROcXlZUzNOVEpqWEho?=
 =?utf-8?B?dWgxY1hkMXlBSHdQcUluKy9jNEtPLzYrYmlIRDhCcnI5eXA3NzFoWEpsTnRP?=
 =?utf-8?B?VVIyT3pJNEllMTJOelptcXE0SldTd3huMGw1cS9nU1JvRGtCd2FrSW9ic2NG?=
 =?utf-8?B?cjJLYlhoQkRnT2ljYThQME5WbVFvM0xoZTRmdmtYR3ZJdFRGbFVNMTQ4WEhQ?=
 =?utf-8?B?SXo1Qi9OTmp4Qkd4a040NXk1eTcrREtRVUZnZnJ2N1hRQVJFTndXRnh1ZjNu?=
 =?utf-8?B?RWtrTklKaUp1Vm1sakdRRERBMkROeGZPRmlsZUtwV2JtMk5nRHR1bWxPSnNi?=
 =?utf-8?B?R1BWNXVDSkx5MVVRRC90TjVHd3ZadTM1ZXBKT1V5OW8zTVJ2S0RRRDBqMTRO?=
 =?utf-8?B?c3lkOFovS01DZEJ6azkyYzNkNC9mVm1LR3I2UmI5QTBpMU5GekRtN0dRWFhB?=
 =?utf-8?B?ejFCeE1aT2tTcm5oME9DMWptQXBCN2lZOFYxenQ1OFNvTUVaNjcybFZ3d2E5?=
 =?utf-8?B?bWJNdC9PVVJKSFdqNEtmZlZZVjlRR3RtTHM4V280Y0Jaemt6K0o0M3BDRkNW?=
 =?utf-8?B?TXVnM2JPVGZGcTdXVThBbjloRFh1QUlXdlhvVUJRcWY4ak85VnFieExMN2lN?=
 =?utf-8?B?VGwveHRjV0dIM2g1TGZpRmEvTE5yVUlwbXBRN0t4RDhNc1FHMDFLWTdOcDlw?=
 =?utf-8?B?REd2RnhDSG1QbXBybXREcVJXd25rYTdaODZ1YytSUWFtWFkweW9FVE5QS1dm?=
 =?utf-8?B?bEVZZUhDdzdtSUxsYkMvTGx6VGVJY2lVejJoL2VYdnh0VmF5UkhDV2VMTGhJ?=
 =?utf-8?B?K1lkbTZ6TkN2M2ZhOE53YzhDNzlMZVYvT2ZzOXV5RzhGOFV1dFZ3ZHlicUpO?=
 =?utf-8?B?dFJrRG1TNllpUlgzc1JNZDhJQllsUE1URlc1Z2g2d05iWnBiOFo4bWQrWVFz?=
 =?utf-8?B?UEkzWGs2RnZVMU1WOWFPcXZpOEJtbVYwaERGUTR2SFNjSjM0YU5Qc285clZ6?=
 =?utf-8?B?OE1XcDN4RitlZm5yazJ4dlA2RzBPVmhsMGUycnVaL1BXQjZQLzF0VDVlNzlB?=
 =?utf-8?B?ZkJ0TTUydlVpNGhxT3BsUDBCaXhmVFRGSm9naHFxUDRMTFJvMUdpb0Y3eGRQ?=
 =?utf-8?B?enVINlVxMkY2Q0s0WUliNmV3VWVvMGZldHF0V0lvQ2p2Wjh3OStKY2d5TGFP?=
 =?utf-8?B?MG9SK2JOZ0dDbG93OWN6OEsvYnpBT0tob3NQdXVsNC9WOW5QZE9oSGpIajVu?=
 =?utf-8?B?U0J3MkRQanpjNG1YblBXUHZWbDl6K2ltS2tUclhtUlNuWXhkT1Q5Uit5V1dN?=
 =?utf-8?B?VUUzaTlWdDEwbWZ6WGhVUW5NRDVMRDJPOTdMLzM3U09oMytNQ0RXMkN2VUFI?=
 =?utf-8?B?STZ3UERnTG4xekV2RG9ERFQzUVNWLzYyZm04WmZ3ejNyMVZSVjhYS1pMQy9K?=
 =?utf-8?B?Mi82MHNWZk8xL3hFMFRKR1gwNFlsVXZGVHpoVG1MT0dhSDk0akw4anMzcFhU?=
 =?utf-8?B?TXZNRjVvT3hqb1BKVWlEK1pNWlRLQllRcnhQL2RIWmlTd0RQbURGc1NYNytY?=
 =?utf-8?B?bFFET1dxNlZGdHlINS9WcDQyNHZDQ0RNZ3ZQWTBidkk0Z081T2NlUG05TnJC?=
 =?utf-8?B?NVg5VlJLQy8wWDJud08xa21BSnU4TS9RcExyT3ZvRWttZzQ0cFZNZDZBbTVJ?=
 =?utf-8?B?NXUranRTeGVoQlh1dER6Y2h3bWVSZVZ5RXphcTJUcHJoa1plbzBpY0dvZVVw?=
 =?utf-8?B?M0FZSUFsKzVqM1RGNE9FZVp0d0RKcUc3c0lGR0ZXYUxkWmxMazBQbUIxOEh4?=
 =?utf-8?B?T0RJRXFJNDNpVGxlcnpVSEdWcnlHakhaSk1od2Jzakx2S0xkZWdtclU5OGRj?=
 =?utf-8?Q?nKi2lw3yDTwovv9F6W8rm09/R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22c25b8-575b-433b-eebd-08da8fd6f286
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 07:10:58.4173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s5AxGk4mI1fipVPKcM3PTSVBdM1I9C7tA/XND0ful3ibjq70XCh7f73Kds0fbSnKYnjr1GDC3qrseuSDdgrhBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6124
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/5/22 23:36, Christoph Hellwig wrote:
> On Tue, Aug 30, 2022 at 09:18:36PM -0700, John Hubbard wrote:
>> The conversion is temporarily guarded by
>> CONFIG_BLK_USE_PIN_USER_PAGES_FOR_DIO. In the future (not part of this
>> series), when we are certain that all filesystems have converted their
>> Direct IO paths to FOLL_PIN, then we can do the final step, which is to
>> get rid of CONFIG_BLK_USE_PIN_USER_PAGES_FOR_DIO and search-and-replace
>> the dio_w_*() functions with their final names (see bvec.h changes).
> 
> What is the the point of these wrappers?  We should be able to
> convert one caller at a time in an entirely safe way.

I would be delighted if that were somehow possible. Every time I think
it's possible, it has fallen apart. The fact that bio_release_pages()
will need to switch over from put_page() to unpin_user_page(), combined
with the fact that there are a lot of callers that submit bios, has
led me to the current approach.

What did you have in mind?

thanks,

-- 
John Hubbard
NVIDIA

