Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CAB5A552D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 21:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiH2T7f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 15:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2T7d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:59:33 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEABB91D2E;
        Mon, 29 Aug 2022 12:59:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1AkLwsrp4Y6tI+lmj0pNDuEfiipWiZhDRMrdwJp82ehney9P269II6Bp9LaFk7CWZNr4hWTknuN+FoRUV8B7+KTEX0KveVOeDS0WqjoRvvCOTRAidFtkhfllTdfvIuVZ+a2g3yGeovVp4bvf8uMeAWjhq3kKlUljUqLHjsygDDcLvMzp7M6aXZHcajZTqkch3y5Qox0gCPsPI0TQp9/G91F0EfJjUblNnh8K76HwY7y3EYQciKNGxsuAsBsn4M3A+1jbNtX2SKjCT9DB/QYzo20wfwyPUjSJL7mzK0Bp5UN0+mIyhThrG3jMVDGKU3rEwW+POiN34AHzYqJr6G+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFPzLcOxvuTyn7mwkI/rmNcZWjcVSS/mW7TKV4BlpD0=;
 b=l+IuMzfBWprX58ltNyDSJ/lzzU/2mDHRVW/QNDg13EEl4oqEmv1o+sZ8j6DC3I/u8oE/rpXLE2q3NS4KYLkhtpEJe4LQ5NY+9dS/dR0A+MyRL4Ixw5olIq5ye/RUEV2nvnQp/13FIcYUhHi2HIEATh/8C1eP9hNEzo8ISVUMpWcbi0uVcAH/IfAjK+TuryUKl1k2X1D73xK3xUoSq+T19TKUsMQnv8wzeQVCGev379DCLbz/3GF6gANL7iHcA86L4KFGycuADa/o/C42cE9nL1s6b85NWrbq+9PBOYRoWTrSBE6/wi8yKNUlrQKJaa0vqx4UTaoEe9Ik+9CmIiUyxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFPzLcOxvuTyn7mwkI/rmNcZWjcVSS/mW7TKV4BlpD0=;
 b=BljByNRD2UTPn1FPEk2IbzuPCoh+3/OBXdmFc0hvXS0YkmGaTaOi1rSy11oj3Q2UuQciIC5cIzhGhnIxbqBquVXpDqvkF7PFzrHFQ4wl5eDoHPR1/9pVTtH41RJufKOe+5EmA8A2HTuuowjSvRxyaRfY+TEtoXdoh9VR2Hj1j6peK1xi0IIBnoN861+tM4QN5kPqLz1pArWXSxGrmSgoZd0pzMTA84YeNvn7oj+lPFKWL2YdejlXETceesARbJC3+RdccKjKU0GHISjG/yGO8DdkxnzeU4klJIcYroChhWx1EXhN+3I21NEGhv4Q49zdGx2G7iI2QX5kPuPlndankA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM5PR1201MB0060.namprd12.prod.outlook.com (2603:10b6:4:51::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 29 Aug
 2022 19:59:28 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%8]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 19:59:28 +0000
Message-ID: <a53b2d14-687a-16c9-2f63-4f94876f8b3c@nvidia.com>
Date:   Mon, 29 Aug 2022 12:59:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
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
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220829160808.rwkkiuelipr3huxk@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0081.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::22) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0eeb3af4-38ac-4931-949d-08da89f8fb38
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0060:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVCaPOxry/8pLoVgB4z7GzNLrZauWwmba9ioTWFX6BKwGL6Hk63LnB6WBTB7w1QAw2FIzbpHy1TkAWpVrw3E1WlnIelDOsNXes+z6o/k8psitT52v78Io+qBejAtrm27L6RnmAkfhtMWg16/QiuG5Ve4LnYnwG+Jj0Iy9Wi2W7WdNsL0dez6ncW1RM/e40qh4rkKRA7V1ur0rou3udZxoMuPy9c0oo694N7WNSxJqA9W940ugfurLzOZ28BZXATZLRD7fvLiJqLrOULuTu4IIdXRqPvOHD9L4DA4rF9n4PqCR4PcbEvY+HeMJ3Rgmo0878OVMdGQDcDFxq2KCNdxJRn0u2tNoCF8XxaXIP6MTSO4Bx49EfOihHdZupSHN2SOf/IcAjKDPwEiEuvB3hW3679eckg3f0qtkduUbeZ8M2iuLq20J43OmGdK9hJHhWzG0b34PB4xzoyP1Cz+6wMtqTZvCrcNCIWkFUtIbDsudKUmsvhzq+BP4uCdeCMR0tuf43NGYztGezS9Ojy6B5Qb0+TeS5c6IryMlDHg951yfqMVeWJzC5S/XgGrpR8TSLA0FTiGMJd+ArNL723+/3SrR/kCbADqiW2cUeuHqL3JwdTt4Y50NVkr1mDBFHzXv0PHDEcn5bcz6FateWzRvDk9jiyeJB7FwzTn6QPb3fgjbVEL9E0FGgA9wLtMRd/ro8Qc6BR7czZnBanKUrY2ceFZvLalg6SjtdyI/SFiumTBgUxXBjMQBJiZyAOzeOklDH29yT0dBtjPTtKn68f1/aw8l/qTOewYNZxdfRfeo8RtiOsrPzChmcFA0oeDUCaFGmaLgJOxL13T6RGKQZUQS0CKDigQsneOjCcW6rRY4NDeUC6OdJZKjNIfNaqGM+Fa4ey+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(41300700001)(2616005)(7416002)(478600001)(83380400001)(8936002)(966005)(36756003)(6486002)(5660300002)(31686004)(2906002)(38100700002)(186003)(66476007)(8676002)(6916009)(66556008)(54906003)(4326008)(31696002)(6512007)(86362001)(26005)(6506007)(66946007)(316002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlJnTDNYTzZtT3FTTXRsRkxqZFM3Q2xjd3lpTFVsNkIwNUxBeXk3c0NiVGVz?=
 =?utf-8?B?TXcwdU8zUnpLYlBOUUUxT1M0ejdCVXZiSVFUY1J6cno4dkl1b0R3Q0o2blBE?=
 =?utf-8?B?T1IxWnZFS2RwUjRlZVJnbVUwNGFycThyNHdYemlrWlJPdnltdjI4Ui90Kyt4?=
 =?utf-8?B?bVFhYnJXTytKMFZYRTZ5cVFyMU1oL2tFQ2VncVFNbmpTOUZsemp5Z1QvQW8x?=
 =?utf-8?B?WTgrNmRaOHl6SlJKbXJDWGlpNER0djNRUjc0ZE1kc05oVWQ1c0VPY3lWYkNE?=
 =?utf-8?B?TUNoNmM1MzZMMFA3RlMvVm1jWGdNMkhHZ3pPWUhtM0NmV2M2K0MySWljZTFD?=
 =?utf-8?B?TXZBM2xHeTVkbzdKU2VYS252ckJQbC9aYTFqZ3J1aTg1VWd0VzhSNEx5Uko4?=
 =?utf-8?B?eUcwTmxaRWtPVWRzZzk0U2lkRFJ3dnJpbW1ZclRSbERvVEVMM0xXbk1tU0x6?=
 =?utf-8?B?eldEQ1hEcG1JRFpCcFEvOU03VnJWQ1o2MVg5dWRmeEhmRUxRVGVhQURORVZU?=
 =?utf-8?B?UnZWS2hEUS9lQTV6SC9seGpHOTZHK0tUU1h4THJYS1kvbThxbHp6ams5UDVu?=
 =?utf-8?B?MkNJUGF5YkQwV0hvVlZsY05HUlo2R0lGYms2Y0ZKa1JmOEtsYlNGR0pSNytC?=
 =?utf-8?B?ZEJrakpJdUdGd21BeHp4RVVFa0ZIZFlpelFUMVpCTm41eWgrUnhrZnZINWZt?=
 =?utf-8?B?bFlaTVdLQnZNQ2JTUVdkUUdKVWJpUnQ3YlVZQ2ZCZHplRzhBS096b1h2NjFZ?=
 =?utf-8?B?Wjh3RWQ2L2UyUmxiWXgwenNaV0k3VENvTXlzZGJnTklaYk81S1hvZ01QV01D?=
 =?utf-8?B?dTF6c1JEL2duRVBGb0pMMHplSm5ZZUxmbDIxWjdwMVZSUFdSOHVXM29HMU1M?=
 =?utf-8?B?aW9uK3UvTGoreUxjTFBjMWM4NGQwNjVjSFFtNkgrMXhQeVFaaXJoUUNTMnBu?=
 =?utf-8?B?ditvMnVYaDQ3TG5rWHE4YVZKNXRYMGJ0d0wxNnk4Z3NmQ0Z1TU1CbW1ObjFk?=
 =?utf-8?B?Z3JxSnI4aHhWYWpFcXFpcERHeFh3UXVKZjRNc3BoN010SGtTc01ENFJBaWVk?=
 =?utf-8?B?S28rSGV4YTdGTjduWVpHejdJU011cEM1RlIzZmc1dlg1WFZxbHFDWlZlbnNF?=
 =?utf-8?B?TVdRazdHQXdLeFZPWjNvbjBRRU0zckpRTUUzcTNBZVJWdE9sWnBpOHNVWE1S?=
 =?utf-8?B?RTBLZ1pEdVVVNW8zeGxWcGNMcWE5VGZqSy9XQTBncVhYMGhVdVZqQUIvbm9D?=
 =?utf-8?B?c045clFQM2dGazVuVHRBSjdydlo2UEMvQUlJaEtxaDJQTzVLYzdtVVprOE8y?=
 =?utf-8?B?Ym80RzNPU0xkZWxlTVRBRlNOaVR2bWhsNlkrYWxxaU0rS2pqT1RQR2RObnJk?=
 =?utf-8?B?NXBxVVdGVW01cWpaT1VjRTdBdGl0djFaZGpTSDI2aWtpc3J0TGtEN1ZTb1gz?=
 =?utf-8?B?SEszdHd2ejEvSDczNXhFdEcvUFAwSmtTcWtpOFNHWFNZdGs0RlBCL3g5RDQr?=
 =?utf-8?B?TmZWcmQxOFpTV0NMTC9LZWhFdUw0VUxBdlIvaWJHRkwwYzJYWU1SNkpVV0g2?=
 =?utf-8?B?OEdjS1RDdE1qbkFlUTJYMkFoT0x2T3ZYWlhtbFBzWHJnTWFCMjFCR0UrZ3FB?=
 =?utf-8?B?b0hpT01LYkpIWnVFZ1A4WCtoTW9qYXFMbEZmSndWNm5IUThtSXB0a2hreXhX?=
 =?utf-8?B?T1RHN3VoTVY3S2hZLzNRQ3FqM3RDSERUaFlvcStINUVlTWJqc05lallKd3Zr?=
 =?utf-8?B?RzQxek9xc3BmVnNKRGxpNUFuVUFFZk9mM0ZnUXFoZFJVSjV4RXV1aEhTZXZB?=
 =?utf-8?B?WnVWMUgybUhQUjBVUitWYnFaMWxXbHBlcVpGenpSZDJ6aGR1TnZsSTlkaElD?=
 =?utf-8?B?WVFvY3BuWmFtRVZQWURqcC9xWk8yejdQNngwV0NUWW14ajZDWDNOYnJ2SjlM?=
 =?utf-8?B?VXMwZTlWeWNocWlFc3VoNnB5QmdveU1Dd1M2Q0JyTCsxZFVBMXZCWis5ckRw?=
 =?utf-8?B?TzJhS0lFU05iclZwMjVjOEdrdzVmazBGcjZQTm4wVm83czJpdjhQNTN2dDdq?=
 =?utf-8?B?Ni9TMVF6Zy9yWmdkZXF6RDN5THkrVThDTFNqNDVHODcxSTg0elZjSkVrY2pJ?=
 =?utf-8?Q?VdSh4c2rrwvKTgr++Km8yqKvU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eeb3af4-38ac-4931-949d-08da89f8fb38
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 19:59:28.7592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9EqWsMPy5LNCjbmk2oYkF7Rv+nr7lcxFfHc21y6sFXY15ipC303+gSZ7s/ggqwCW9uhlsG1pTZodO+/3uwdCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0060
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

On 8/29/22 09:08, Jan Kara wrote:
>> However, the core block/bio conversion in patch 4 still does depend upon
>> a key assumption, which I got from a 2019 email discussion with
>> Christoph Hellwig and others here [1], which says:
>>
>>     "All pages released by bio_release_pages should come from
>>      get_get_user_pages...".
>>
>> I really hope that still holds true. Otherwise this whole thing is in
>> trouble.
>>
>> [1] https://lore.kernel.org/kvm/20190724053053.GA18330@infradead.org/
> 
> Well as far as I've checked that discussion, Christoph was aware of pipe
> pages etc. (i.e., bvecs) entering direct IO code. But he had some patches
> [2] which enabled GUP to work for bvecs as well (using the kernel mapping
> under the hood AFAICT from a quick glance at the series). I suppose we
> could also handle this in __iov_iter_get_pages_alloc() by grabbing pin
> reference instead of plain get_page() for the case of bvec iter. That way
> we should have only pinned pages in bio_release_pages() even for the bvec
> case.

OK, thanks, that looks viable. So, that approach assumes that the
remaining two cases in __iov_iter_get_pages_alloc() will never end up
being released via bio_release_pages():

    iov_iter_is_pipe(i)
    iov_iter_is_xarray(i)

I'm actually a little worried about ITER_XARRAY, which is a recent addition.
It seems to be used in ways that are similar to ITER_BVEC, and cephfs is
using it. It's probably OK for now, for this series, which doesn't yet
convert cephfs.


> 
> [2] http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/gup-bvec

Yes, I had looked through that again before sending this. The problem
for me was that that it didn't have to deal with releasing pages
differently (and therefore, differentiating between FOLL_PIN and
FOLL_GET pages). But it did enable GUP to handle bvecs, so with that
applied, one could then make the original claim about bio_release_pages()
and GUP, yes.


thanks,

-- 
John Hubbard
NVIDIA
