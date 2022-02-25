Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38B64C5171
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 23:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbiBYWVH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 17:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiBYWVF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 17:21:05 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AE41A58C9;
        Fri, 25 Feb 2022 14:20:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbgL8uecXCytHcWAde/kneVzg98q0GF6063QZBcTzCgO5Mmi6Jc+Jt6FsmbHunNW2Ihh1Dvjc9pD8APDKNK+DS0tE4VM/4Fpqa2akrEJpad0N3Aw0+WUXJdunOk/AOB9n0zeMueLQ4C9YT4cRTO2I3Pxt9hzSviK90vbNQgfrzC8TxzLfPlRvjYEIY8A/REHGQ22fXlZNJEfYij0QOLg5NJ/g7ElzdGfbatqlSDt/YthLM1tjptkMafZmcNp5jkbPbcaUbAmXJn3QNtdNeBj9G0Hk2r5ryeg4xlxGEpNjBGzg1kKMA6eV4bLvgnb8FHtYedYquwHDehvqlQi/MBJ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9c8TcnhAR7GENlu0oKJ0qHTw1exP4AbiHErVgkTWaOU=;
 b=U/SaQRbQsHuw6r60y34AuRuObrh/1uWsCO9TqZ3ni7Ek8aAVwZ/U1Mjhyt0GEAQZbObB/m93AkY/u/VIt5A2uM1WJBqg/FNE7OSPfJVFAKPqrzrTZ0bVGG4xSgMkPD+9KgrDJrB3jqdObPMn0uTJ8vJtjddGtbjt0qO0kljzNMJrY9mCl305+QhllkCpjBgnnD22iIsP38RSsi7WaDp8YsWd/8rB0F997N1ek2PNOaINcm132o7uO/n145wU7z2AQbBm99u3ohQO76/Tb8PWgVfu5UQlwiv0TWyRDl4lX0kU4bWMjveNVQtEqndVk5bj6yjl3rw1yfjSRLHGjAq6DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9c8TcnhAR7GENlu0oKJ0qHTw1exP4AbiHErVgkTWaOU=;
 b=AKBDdyi3xAsg5OMoZpdy1yaGwXC4zbqufB3bm/4WBm62wxDKQikvGLKt0nPT/SJjep0hpkLY42OFbBhzE6n368Jnb/wSoQqDSorZE0TiZlpnf1OuOPEIm+4Nlnr7OQicLIkQOUkv2utplsi023xwtYF8/fnbzMBWOsfftWAfZEMceKA/w5JIOxsF1saJRUpTP/lWZpg/BuhqVEpCSBRsEBUT2mZq0hjhY5EZPiBRTWjk3STVXeFjMaBU9WMo8jhwrw9OnMinNWSjCYwnQaa4GZtlXtbwnoXHwawuWoqdumZuBvg+WBkRf70dl+wghmsGiQig74Ve3rIFBug8BoJ5Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BN8PR12MB3217.namprd12.prod.outlook.com (2603:10b6:408:6e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 22:20:28 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%7]) with mapi id 15.20.5017.026; Fri, 25 Feb 2022
 22:20:28 +0000
Message-ID: <a23c8d6f-6311-f74f-b0fe-26682e16ee98@nvidia.com>
Date:   Fri, 25 Feb 2022 14:20:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH 0/7] block, fs: convert Direct IO to FOLL_PIN
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20220225085025.3052894-1-jhubbard@nvidia.com>
 <20220225120522.6qctxigvowpnehxl@quack3.lan>
 <d2b87357-baf9-ef1f-6e6a-18aab8e6d2fd@nvidia.com>
In-Reply-To: <d2b87357-baf9-ef1f-6e6a-18aab8e6d2fd@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0064.namprd02.prod.outlook.com
 (2603:10b6:a03:54::41) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dac4101a-8dd3-4947-bb1b-08d9f8ad0741
X-MS-TrafficTypeDiagnostic: BN8PR12MB3217:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB32179A76D954B23E0DC7DD71A83E9@BN8PR12MB3217.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +j9sqMzzaWXVSlE1MvqWGQtgOaPSjI9t8DD4Uy/8EJqQf/NOWvhAD1SlRt71HXdRR3ARwKRCoB4y+2ED4M4DONbgdgD2h9sBVUqxEBENAGLZkRtl1p+C9gD2Nwhl2dzxmaeOn2HxjpsxBXNFm25nUBBTHYmCzJ0OmgNrjl4nvMjSvFNh74kys22mpKaVsVtJv0PTMAJO2OhRYaQhxQVzenYTnUoF6pP897OgK/4vOceojMtpimrh+j+2+6RcAWgE4SvPKJrFLsV9w9IRXkn55vVJc0PiBYZeNG8kHux2DkGwdbRfXZd8PBAZJ60A8c+NnLnkuhxM62W9S60/pg3jWAPh1TfwWoBWxUKxcMweE6mEmZukpc0nVJKtNWTppgNj6peuMQZ1AO+7GPvFNDvxV3dgwGCJW4xAaiMdtIvUN+gF/hO7vRMKyxodU0BDHEVDFLcjhWTrkd7VdW24fLos7Lz9uTbtAxYp+LrIy7Go/VNbBEjuOSfaMFhxoJizlVmsrzf8nrVu0HnNkbBI2wMQ3mkF3/MeU+yEyx7jNLYho3Hc+if7H4d2UGk3/3vvpOMTYnTC3fdIAUc2tufTC/EzGtIl1Mpl0wWV0j80x5RKbjFHjvp5QrIs0dmSpIPL+8XwSQLNWEeiYjzV1KjK3eDmZYx/jEd0//GJo6Xc9T/DQivyYAjhwHyvBXfCEQ6OkrGDe1YbEnm0JQGX/LOE0Z6HZC9iw4cFpiNwKSn0hG636YsAD3T21jgZdw6Jk1e+Q021
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(8936002)(31686004)(86362001)(26005)(53546011)(6506007)(36756003)(31696002)(6486002)(508600001)(7416002)(6916009)(54906003)(66556008)(66476007)(38100700002)(5660300002)(2906002)(8676002)(2616005)(6666004)(186003)(66946007)(316002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFE2eU5EZTgxV25ndVJjRFdmNkxzQmYwMWYvTmJiNzZvcDNiRC9GNmlEWXFO?=
 =?utf-8?B?Q3hQQXh5QTMwRTRXL3RFd3lmdDkwVG9jeEcvMGwzSkU4aklsVmlXQ2RPWmJm?=
 =?utf-8?B?SnFpelcvRGc1ZnF0Z0NuRlJkaFdUMkNUOHBocllSLzV2ZHZMNnEyd2hnUVlj?=
 =?utf-8?B?Q0dVazdqMXVGR1VGN1Y4bkR4RWZvOEJVRndqSkttU0ROYjBJU2I3Mm5tSW5u?=
 =?utf-8?B?QkY2ZTRKajhYQzI1V09lUGV2SmkzT0VRVkZsa01jOFNBR0toenNTNDllMmtF?=
 =?utf-8?B?MEEwWnRhd1V6TVQ0SGpBbE5nTENXMDZhZDEwRURmRjdka3hTUWw5bE5leXR0?=
 =?utf-8?B?UlAzRlFKRTZVbmpudXB1MjRoUHpnWHVPeGpydFU2TUxQbWxsc0d5Z2d6RHhv?=
 =?utf-8?B?dElOdUxaWnJ6OWZhYjFRV2NpeVc1cGRoU0lIZ2xtQnlYWE5GNzlNM0sxN0JN?=
 =?utf-8?B?eUxVWTU5eExoOVJhQUFwd3dTMktoVlNqb2p0NU4zTUFaaXFucnl5L0FUYTFV?=
 =?utf-8?B?MnllSHJ4SWllQm9RSzFpVkZHbG5HTzIrYlBEZ0xOdS82WlBVNTN1Sm5hUTVz?=
 =?utf-8?B?TUZSTHNZN21kWC80NVNvOC9xc0NNWU1RaStwa3BHaGwrOHA2c2preTJGa1Jp?=
 =?utf-8?B?OHhZRWFLSkhnMG02MmRBWFhYTmJmTW9SNEs3S3h1Q1ptM3RGbVJOcXoxeURW?=
 =?utf-8?B?NlAreFJLQXN0NkRQcTgvcXZ4T3RpMUpyd1R6U0dWWE43N1NEMCtpbkM3REpq?=
 =?utf-8?B?R09TNGdFQm9URVJPazlxbXZVNUcrNjNoYXRaVDh3ODFmQnp2Q2RSc2lOS0dv?=
 =?utf-8?B?S1lySkl6Y1cva2Z5Q05kV3Y1SW1IZnhVWDlvTk5tVldtNFVocHozMzJ3Q0t3?=
 =?utf-8?B?c29OeU8wL0duZXNjblJHVldGWTVxVjJCNEUxZ3FxbW15Ritwd3VId3pjdGJZ?=
 =?utf-8?B?eEx3dWNBcG5DTElWa04wQmg1TE1jcldBL0lWdUJYdDVEdHM4VXFpRzNkZ2Jl?=
 =?utf-8?B?TldXd0k5LzJtNXkyUXF3MWJ6RE0vM2FXUkhlQ2I4WGtDa3g1aEVMWjI4S3or?=
 =?utf-8?B?S0tZaExlbzk5LytOQ1I0eHB2clcwYVRzZlJyNmtaVkd3SkJld2xJNExjSDI4?=
 =?utf-8?B?RjhVaWxEejYvZ3lvMWV6SjF4UHVXTmZ4MzBYWTUxbGhURTBacTdnMHZsY0JM?=
 =?utf-8?B?bWpIN09qTXlXSDV4NXVRRDVFcXU4azhiNGE1ZWF1bVZLYk14TmhEZWFadExh?=
 =?utf-8?B?eHJHNGRPc3RqOVhPcm5HS3hDVnhjWXZZMHFKUlNYT09GMVRTRWhCdGpZZWZr?=
 =?utf-8?B?NGJPdXV0YnFCWXpudWxMcHhwZlhCa0FNMmdLdXpEVDN1d1NhSEdqbkJUMFFM?=
 =?utf-8?B?blR4dmtMTFNJUGVZWm9iT1pJZkljTDVHUTFoblQzSVRnZ1RMV1FZVUU1V2NK?=
 =?utf-8?B?TFlvM2plUjRkNGxJWDNrTGNlbSsyQ2R2bnh5MlI1bjk2T2xxS3k0VFZVSi9y?=
 =?utf-8?B?bElYbTNUa1dsSW1lRjNyUHVsbjJiczdtTnRtb1RSSHdWcEwxaFUxbXc0TTFO?=
 =?utf-8?B?YXQ5VG5lVUhvaU91UnZocldzd2tXNlFBcUIvQzY4YzJKc2RkNFJpSE8yOFRJ?=
 =?utf-8?B?K0xteVFUY3BRMU9Ud0lkYUVXYW9RVFc5MEY2RGdDd0ZTbDUyQ3VpTFNsZmd0?=
 =?utf-8?B?RnpHUEU3Y3Fyb3QwOG9nakRIWjZYYk4ycGl2VFdhUWZ6dnd1aW91M2Znd3Jx?=
 =?utf-8?B?dFIzVDdmRVR0eHorVVBvTzBaWThTUTdUWGhIUC81bDU3T0tLNk54WWpqaVJL?=
 =?utf-8?B?Z1plZUtqZmVjTU13Yk5vTEppNjB4eEllc29kdFhBSlQ2YUN2cmZGOC9BN1RX?=
 =?utf-8?B?Z2N3VHpzYWpuMlRndEp3UnFDVXVGeDZmZkIwTUNoVHhiYUpOMWlFVVJjY2Vz?=
 =?utf-8?B?UEdwajVOdjlNOVA3UVM1Umx6aWRtYzNuU3JxUlhzMG9sQTFEaXFXQ0FmVFdp?=
 =?utf-8?B?eC9UVmp1WjkzK1NhQ2JTMnVCTm9DZFlXeGFnczc1M0txSXlvbnNwRldqSDBW?=
 =?utf-8?B?WGZoT2g0Yy9OMzg2QUFlOWFaWExKMU9aSVh1djlPWmh4dWJDTXNiRjVpVVVC?=
 =?utf-8?B?Y243cEF6UHV4STI2TmZUalUwVFlHSU5UelhPSXRXK0s4U1hhV0pNM2MrdEZ6?=
 =?utf-8?Q?oLhYCLqBpePyupp14hw81Ko=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac4101a-8dd3-4947-bb1b-08d9f8ad0741
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 22:20:28.6758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tsroRTmQfhzZezlm8B9tndp3PWK8Z304VlD3vqC8UIL5yKnQxDuu8ddMzW2Pat3Apd4LgJ0jwD1avUFGV9rFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3217
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

On 2/25/22 11:36, John Hubbard wrote:
> On 2/25/22 04:05, Jan Kara wrote:
> ...
>> With having modified fs/direct-io.c and fs/iomap/direct-io.c which
>> filesystems do you know are missing conversion? Or is it that you just want
>> to make sure with audit everything is fine? The only fs I could find
>> unconverted by your changes is ceph. Am I missing something?
>>
>>                                 Honza
> 
> There are a few more filesystems that call iov_iter_get_pages() or
> iov_iter_get_pages_alloc(), plus networking things as well, plus some
> others that are hard to categorize, such as vhost. So we have:
> 
> * ceph
> * rds
> * cifs
> * p9
> * net: __zerocopy_sg_from_iter(), tls_setup_from_iter(),
> * crypto: af_alg_make_sg() (maybe N/A)
> * vmsplice() (as David Hildenbrand mentioned)
> * vhost: vhost_scsi_map_to_sgl()

...although...if each filesystem does *not* require custom attention,
then there is another, maybe better approach, which is: factor out an
iovec-only pair of allocators, and transition each subsystem when it's
ready. So:

     dio_iov_iter_get_pages()
     dio_iov_iter_get_pages_alloc()

That would allow doing this a bit at a time, and without the horrible
CONFIG parameter that is switched over all at once.

The bio_release_pages() still calls unpin_user_page(), though, so that
means that all Direct IO callers would still have to change over at
once.


thanks,
-- 
John Hubbard
NVIDIA
