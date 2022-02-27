Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D174C5F5B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 23:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiB0WOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 17:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiB0WOX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 17:14:23 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3989B1A82A;
        Sun, 27 Feb 2022 14:13:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P529Kw4b4tp5dNVRkKB8YqyPYFWksjKSvd+8zH8oPvkNqNWPYGdIBOctTQjH927rs/Yuc027j2vMAXpKwHWyVmHD3lP8t2ooAIvaRk8+FlMKq5+I0bAN78vDhYw/+IidTCEtYUv+w1hB0IcMBc3z23TFMub2Q/eZsH8DWZUJONqR5q3E8RDYpuG8+rIkcLZ2hvsihHPVopHvU4YQ9bQpwqpdru2xesqTMyYIYGciCTT+a1hv7HM5b+NPzS4B8tUd8wBbAZjwn03g4cGrsmh1ReLHcJqXQCPLUSXIlZEne+ye8nK9m73MrvcrWdt6zJEBeBClTjbTiwQSbF4Wh05yIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7V1vygH0zc9lftPhQEoOFB3OOYy+U9ZZP1P85eNgzg=;
 b=VJlz3n/BuEqip4yMsjJMjL+ObcH6jjTi/+m83vya5tHAIo68A7tyjwVoxju9hc/zgw8SiuxuqbGRB5MnKIiyVNlnQqKqjPdwJEBbSte9NYO7IjPDm8Gue7zHN7VnZjCsExVdPC4Eekim+lVevxkAppc99mMAcj9inXAOET1xivhhvb/dHC/qiUIMT+44kkKohR4SCVuwABycTzm+EB65clqIqeJ7E8dhx9oy9C3RtFH3nj38JJxB4tGWaFuh/G1YBcF2EXp2Z4fNwXWpcAKP9P/HlmdjM6Hn0Xpyet6eEOy+El10+lBTEvcgPdFOuwx91uFMB9hkmG81iZkl659NbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7V1vygH0zc9lftPhQEoOFB3OOYy+U9ZZP1P85eNgzg=;
 b=aBzYpLfhpbyRSP5crhrJOdO1M+GVvCloD0qVizD84QSwmTkmeTORJZmYwLRDSaSU88aHXhglMIPkEov4ZTepnCCK+j/SvBvvyHn3YqVKOmISB9aNmiLuiW6GM/Z6TUPv9Nk6XZxSeC2Th3Neone5oKXLiErk7QuqBQ6bg0LeEollR73TI0MpAzh1wnd6N2aghJ4cfBIAfgx1aRS3OLXqH/TLpfESDniExWHz/7eyGy1PO1/VGWOSJOX94njEvtPagjeu+oRaCnA7u6DkUxJOH1NukMkyViF84NqNjlngatvwJorOhvogaHJbQAfa2f3n5j43JUHXkSpm2gJpA7pjjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MN2PR12MB3679.namprd12.prod.outlook.com (2603:10b6:208:159::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Sun, 27 Feb
 2022 22:13:44 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%7]) with mapi id 15.20.5017.026; Sun, 27 Feb 2022
 22:13:44 +0000
Message-ID: <83d98cfc-79db-bfd5-1404-1b7133e5694e@nvidia.com>
Date:   Sun, 27 Feb 2022 14:13:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 4/6] block, bio, fs: convert most filesystems to
 pin_user_pages_fast()
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, jhubbard.send.patches@gmail.com,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20220227093434.2889464-1-jhubbard@nvidia.com>
 <20220227093434.2889464-5-jhubbard@nvidia.com>
 <8b5b35fa-3c70-adc8-ca3a-4829388c4d12@kernel.dk>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <8b5b35fa-3c70-adc8-ca3a-4829388c4d12@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::33) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdaa4251-be4c-4a72-aa9c-08d9fa3e6b2d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3679:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3679DA0C0FDEEBBDCD0EB453A8009@MN2PR12MB3679.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KqNp+dB2ab00RGhxQR8GTLcmIvGfhV/rOFOirc0+jvpLf+423etyUTTea8C6NyDvRHTjGeTN8+8j8ijbCW+Ruyzau7nq47KTu4R3c7jbQe11ba9mIp/WivFg9bXcoPwD4rpRumwIC1VFkYBMIXa6Q9S5dhmK0LH2aFBa5aW5r37QBjGp5OixmWyMSbQpB8Lr2YKIQ4RCyxse0YNivi3y/VFJ3dyP+h3mAEi3dAA+HALp/A+RH2MJ25OL0v9ODG+Vw1Axukusa2Xri7wmpNjbCT2ABOICQj2VfRM0auOumBOdhIs9a89htn0AvhT42WCJQXQeD6U34mQfMuD8QxxF7jtPOCph0oJRy3M/rqnWperx5KSfd06hp9M4NqDTXI8glVXybcAlFYDQeF4x9JyfVT0jMoDmnURth3IXUjxuZkGIn/LtuFXKDN3LTg/MHC5kOyWXOyfMFfZsowMpHsIg93xjTxhSflQQ67aJe/H9RzwfzcUzseOPnvIO3nGYEQuEcnBsMaEsqdDvRxExmRw5/pz8+TEA6BRDWmqGjoTJuMY46XLnV6PPUYVVULjjeXuo0PoIfUmSEqOzqWnnVT5t7Do+65AzIngiLWIn10hvZiskJIJ/hZbjpGarJYW8vysOUT6ZMZwzDuLkZ67Qu5AhyE4TlQc3Gpe9KmLFBjOKUgT7oB2I76dADnxd1ACfWI7hN1qAdeS4H8a9ykL+PtDKHw3GKEVk1k+hfHe28EC8+r5/knJz3Z9AVRQn9uVXXi78zr0XZ7eQhnoteV61q7nUww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(31686004)(316002)(4326008)(83380400001)(6506007)(2616005)(36756003)(6486002)(6512007)(508600001)(26005)(186003)(6636002)(5660300002)(2906002)(4744005)(8936002)(7416002)(110136005)(66556008)(66476007)(66946007)(86362001)(8676002)(38100700002)(921005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmFzQ3FyL3VTWXYxWWxpQnZrRG1MMVNWWHhGUWhFZUxENjV0SnRmQmxZZElJ?=
 =?utf-8?B?YjRMT3VMdEZteXVQRVIzeDB0U3gxODFwTnNoT3lYdEFnNjhMSmRzUHhVWFo5?=
 =?utf-8?B?U3RCdUZUeXh4ZUJSckZBNzU3M1J0eFlvWmxHSzNsektzN2VWY0NFT1BGTWY4?=
 =?utf-8?B?WWs1REl3WDllZThrYUQ4blBlbEQzRnhrM083cVQxR2VWWkVWcTFtakhqWUVP?=
 =?utf-8?B?MnZyWS9zN3JrNEF5eFJudXNzbHpSM0RuR3VsYURwSDh4Ym5xZ3JGdmZpUUxv?=
 =?utf-8?B?SCttdXFXVnhKek5uOG05Rk9MeDdXc0hxVThNSG9Rdm5peDd6NEExSVFSRmdt?=
 =?utf-8?B?S2grZy9tVjQ4VzJ1WkhFekVqeDF1QmlJWWhVVFQ1aWplYUJRbHcwa3BzaVhy?=
 =?utf-8?B?bjNmZ1lPYWtlY2tmUzk1ZDBqRUVmTUpLelFsWXR5T1NGakVDYU9QN0VmUm0r?=
 =?utf-8?B?V1VEdFVzNHkyWlEzckVibS9JeXJEcmJQUllTcCtiMGlMcjUvbGM0ajlDNWV2?=
 =?utf-8?B?U3hGNk1HVWFjM0V3bk5LZ21Ea2hNdm01anpQcjlSYWFGRGFDaGM5UEpnWkpV?=
 =?utf-8?B?K0czUXdSWXFmSytTQ1Z6NnQ2Ri94b2tUcTlsWVVlMU5PMjBJRTFKUzFuemxQ?=
 =?utf-8?B?MmlNRXVtY1NKTjlWY0JPdGhCVnVUeHRZOTl2UTk3anIyZnVaM0U1TXRaYkhO?=
 =?utf-8?B?WUFuM0lBbCtaeUNJZ29XbGpKRkI2ZlVIREpvclRzK1NySzZsSVpaYXprMklM?=
 =?utf-8?B?VTVwdlowcm81cXlRY29yOFFvL2xDMks1aTlnbnBrZTQ1VDRhbjVyMzhSZTZK?=
 =?utf-8?B?L09jLzhWUEgwNEJzVmJsU0J5a0Q4TExNN1lHdllpalFQdDhvbDJGd2RKdVIz?=
 =?utf-8?B?d0xPM0tPT2o4cEtZWjEyT3VUcDltZkkzdVNSU0s0ZnZFWjVBaHM0VHFPM1pQ?=
 =?utf-8?B?SDFCd2RleEUrWTIrM3Z4KzE5VVVCTFV4Zm9US3hXdjYrTDc3aitTdkJHemk2?=
 =?utf-8?B?UW9TMXQyUHIrRlIwRFErUkVyRDFEeTlGYkp1ZjkzOEYvZ0ZEaG5YRFpraVVK?=
 =?utf-8?B?YnpWd2g0d2Z4WHA1dUxMSm5ZRkJEMXlFWjVWeTUweVRiL3BDOEdxeHNuSFJO?=
 =?utf-8?B?Wi9BMkJ0VENoZUJIOU90MW1mWHR6SkovRFRtS2xRVk9ZSU9hS3kydE1vZ3R5?=
 =?utf-8?B?VDlZaFFmRjZDRyt6TlkwVlRLcC9Rem92QXhmdXoyd1hVZlUwcG1OdCtzMDdI?=
 =?utf-8?B?QUxlSytJSjYwQWVPdnpZMHBDZVRkZkg2cjVRa1o1YzhadUVBMkkyazZxbUFl?=
 =?utf-8?B?aFpiSWc3UTRQWmN6anhmYm4vL0hUNExJeVFMU2g3T29nM0tkS0JZRDRVKzZr?=
 =?utf-8?B?aWVDblF5bWYwVGJEWGxpUHpjK0UyR3FqV0kybzF2bVZTMzJudDJNYjE1T3c4?=
 =?utf-8?B?VkN0RFV6RngwR1dwZTZuK3ZvY2Ixc2ZzSVpVWmd6ZGlHbnE5UWp3UEhUNm1K?=
 =?utf-8?B?OGdNdkNtU21lTnlZOVA4ei9KenFVa1piSUJzeEdlemppekcwMVpyNi8rK1l4?=
 =?utf-8?B?V0F0cmRPQzFSTHJyZFlTazNYalpySC8rL3pWME1kelZwQVJxQU56VkVteldI?=
 =?utf-8?B?S3g2QkRXeDU4SmhGVWs0SkxUbVFCcWdPTS8rd1RhY2gySzB5NVdkMk4yNDVy?=
 =?utf-8?B?YVkrOHYyTXpST3RvQ1pkSnQvTjRqSzlRSEpXenpIL0J5Wm5IdTJPZXBHd213?=
 =?utf-8?B?eU0zVW9qVGdkbWJRMHNYbzRjRndJRnZLUmY1QUFLMWN0U3MvRUkrQzJIT3Na?=
 =?utf-8?B?VGRBcy9meXhZeThsMWJJaU5UUzJpdks5dXVKcFZ6OGVLM2dRUlE0emlJRmYz?=
 =?utf-8?B?d1Jtc3UzMHFxalJHQ1JmQ0JGcnVBQUxEdGtpM2h2WU14c3ppc0ZOWkFHMTJW?=
 =?utf-8?B?VnBCMUJPM2tKMzVzeHBGbWtNd0lHSlA0Wk1jeFJvdFVrZlZGdmlpWFJHSnRW?=
 =?utf-8?B?WlFTbXV0RERJNmQ0Z3RrMXdmMy96ZmxRdTM3Yzl1b2NUYTEwVmI5WTBubzNH?=
 =?utf-8?B?dC9hMEZ6aXdvcEgzTDZFUE4yS05LTTJIbmUzdVJWOXNFa210SXlFRFhtV0c4?=
 =?utf-8?B?a1lKMmlndGVxR2syNGh4Yjc5RzFjT0lSSFN5YW5DYkZWQnZkT3RwL254NDFn?=
 =?utf-8?Q?a13wgA7EYNozQbq2AjfckSA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdaa4251-be4c-4a72-aa9c-08d9fa3e6b2d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2022 22:13:44.3807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqLdUyCOvRd0TXtoVioKcA8YMjklsCUNRfAxgD06qN41k58+/Nte/HqDHdp/Y7gdAO/zyjaRQ0uAh0KH64Qtjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3679
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/27/22 13:59, Jens Axboe wrote:
> On 2/27/22 2:34 AM, jhubbard.send.patches@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
>>
>> Use pin_user_pages_fast(), pin_user_page(), and unpin_user_page() calls,
>> in place of get_user_pages_fast(), get_page() and put_page().
>>
>> This converts the Direct IO parts of most filesystems over to using
>> FOLL_PIN (pin_user_page*()) page pinning.
> 
> The commit message needs to explain why a change is being made, not what
> is being done. The latter I can just look at the code for.
> 
> Didn't even find it in in your cover letter, had to go to the original
> posting for that.
> 

Sorry about that, I'll sit down and write up something thorough for this
patch. It is after the central thing, and it got neglected here.

thanks,
-- 
John Hubbard
NVIDIA
