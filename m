Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E965A3A4D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 00:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiH0Ws2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 18:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiH0Ws0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 18:48:26 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C18C56B9E;
        Sat, 27 Aug 2022 15:48:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnkHgAc48NtxlK6V/swPDht5y0BXv+8x+1sYYCFKFX0CFr+rP4bWmu9SlxqF4U6aeRrxnTvSWSd/2ZAWbz93hAGXBr/4k24y6Ijhn94LX/maZghEDtVD6jdRhEi18OJOcGT46JpUUseIXZXw+6nw2KtV3uPwYyn0PHD404SzaD9pfuB6/LnC8x8uyPlQx5phdfjBfVNygTywHhApojLDRkn5NmOB1qJE5gKYZwNhZS4cEje3FENpHR5pKGJvBunXuTQQGmINVYVshhYr7qw0P3xpFL/E8uq9I7DNe4kmT1NtVNOBE+GBK/2i2OEtG7YRAuwUQKKRz87VU3fm3FNoqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/q1QnpgstUmS5pHPE2qtJshlTKyTTtGpewrV3zcCyc=;
 b=TKa+FCUaQxldtrz2Eq5qbdJPJ1wpy+CFZ9hVOENwjZXwzbHc5MedD6uBYeoq7YkDDx4xPPUbDOfZOO2o8m9bFhUJmG5GlosRl4UAXslrqDp176TwKq8Iq/23mv435k8niykBI8kSrZsALThD82MkOFYiVPEtCSJS6j9EZoGnww28RpRmqdMbg57njGdRQd8soR5ucdE12rpifPXZx013ZxdiPyx4cLfT1TN03T5WsknXiSfg8lCoWoT4ljSXQHvbU/F0K4kh8x44/igyuvZmGkqM7THKOwRaUVrR6AxEay5NJBm9EaWVv0KXOqYVFWsdm5g9mOOpVS6j+wlcRHEENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/q1QnpgstUmS5pHPE2qtJshlTKyTTtGpewrV3zcCyc=;
 b=qXdoxCnx06sJXBAkKibvcM6bDpIbOIh+xNB89K7ugb1VgWTEqgW4OU5omrHCNNu0YC6oip7H25erphrmwfyFvgP0H9+SzO3tl9luIZtURajvga00EMjlLQhoYEtwsFHJv0e1BJ+t7KHwVjjCWU/hjdx5KsPb5UTcBVd23SXXFc6qF+MFrFXzm4Xrr+7IsFJqaFh8DW5Kdx36b+ZbdQ++jZvBPrcZ2IrnVo3B6zbEgc7jNSSIONT6lbwcQX7ioqXC4m8hZPUw2Pou9lrK3vkj+lAv23R2ov4PsGaWQF9gm26o6BJuJhdifIgQZuS6dioVe+Mue3ptVYqnOvMiesB1eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by SN7PR12MB7227.namprd12.prod.outlook.com (2603:10b6:806:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Sat, 27 Aug
 2022 22:48:23 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::5d0b:8227:33e6:b490]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::5d0b:8227:33e6:b490%5]) with mapi id 15.20.5566.019; Sat, 27 Aug 2022
 22:48:23 +0000
Message-ID: <0fde3d40-d20f-6650-c3e4-79f1a2424ffc@nvidia.com>
Date:   Sat, 27 Aug 2022 15:48:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/6] iov_iter: new iov_iter_pin_pages*() routines
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <20220827083607.2345453-1-jhubbard@nvidia.com>
 <20220827083607.2345453-4-jhubbard@nvidia.com> <YwqexJOL9GcOKRg1@ZenIV>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YwqexJOL9GcOKRg1@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0003.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::16) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edb93626-e8b7-4f6d-0afe-08da887e3f28
X-MS-TrafficTypeDiagnostic: SN7PR12MB7227:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PBJ5++Pnn66oyMXfSNEy32EbqgoaMa+WnPXzOAPz9FDhMIh8onF/Ddkh6rdIs+JX/IZLH5hWxL5vXTe8edvnh8XT2THItObF5wyAV31qBmiqO0GTexMPh6VHzw6BjGYVBDCAaQOaC1p8YsYgycZqUYb+XKmnZerrECDTH+gyecJXpR8TfyAaSCvX6n3J/2b8kW1URhTLn9Q/O1gxq8rvS5azSh9IygBTArZYWshLbh4LOs3hLNVozWmRuTB/AiW56+B6g0nXEhv+PS+reEbmYk0rrnbDvDIGOr8Nb4LcHQzUSALo4rxPha5KJxHBXD6cceQhlsukbZ+GSGhz85xmhXUJLlh15z94aBPnhiUD3OXz6+MYIb9OU9KAvbFN3Qt2MZg8hiJIPH/fDQ8qKUpDixi92SysqCSzwhWubyuuqjVMDU8aTvlqzk257LTZ4V0EGPMfuJq6kNh5LBNqWz/j3MEUWNol6Ttn4iubTYn+ngBrZLlGCujjiZVGDE0xqoUUPjZI5wFg2qXbq/9CGzKvqk92Z3JWpPK6+9eqNGEJ0XD/TIYhuqcB9Egt/P6AabVF520AwDqaUmb+JY68+FEb+eSfiYAV7lnDmcMOXOBG/9CO8mXHeSjWShuhkomtxu0FgWZ1nNHxc3J9lADqnRYjDMPclkSwZcjBg2svsAv9IqaV2DHBj/XbnbPF0qdov7AnhAttdBS1dcmDEUpeEpmT7TOPSjGQuZ8Aizbnhj8iGI3/65MCEEkJgp01Fw/4ODyEY6QBjGTSTk62XEIEGnyUi6P5jI6LePQ8z5ARWSUqU0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(66556008)(66476007)(66946007)(8676002)(316002)(6916009)(54906003)(4326008)(8936002)(5660300002)(7416002)(4744005)(2906002)(38100700002)(2616005)(36756003)(31696002)(6512007)(26005)(53546011)(6666004)(6506007)(6486002)(478600001)(41300700001)(83380400001)(186003)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTkwM1NqeUNwSUNKSlN3TTV1UUsxQVNvbHZyL0s0bGtBRy9CbVRMZjJ0dHNF?=
 =?utf-8?B?MWRvWWk3MC8vL3BENFM2R3h0M0xGcHc0ZC9teWRFRzFBUlVXR0theVJ1MVFh?=
 =?utf-8?B?Y3lNdXg5LzlCdEYzNkNlTGxYWFN5Z0ZjeHFxZ0twS3dmMUhqZGdzSU4zdkgr?=
 =?utf-8?B?K2pxSzRZQUJTRDFSNFJmYWdpK2c5NFcvajRaT041UUE3aXhpUE9uak5zcGgr?=
 =?utf-8?B?NG5oZ1FiZzg3WE5EVlVyRTE2Vlc5WEtlcStxLzl3RmlkeXU4SUxvazdZVFZT?=
 =?utf-8?B?b2x3ZWpOYXJpVlFnWU1UYW9RdUsvQXhYU09PNHRkNC9TeEEwa1lRQnU5OHk4?=
 =?utf-8?B?dThPTDZhNGtKWUJTb2FSU2VielFVU3JRTFA4YVNZN1hhUXJRalQ2TUN2RXZn?=
 =?utf-8?B?TERVS3NrNy81aVA0eExRTWdicVZkLzZ1dnhCTW0rZmJnRjByc21lSHRVcTlp?=
 =?utf-8?B?MEVza3pwSzVrdnRmV3ZMR0hJb1RHYjV6NVN2TlVRN1NVSXdwcy9qL0FZdHhX?=
 =?utf-8?B?KzVaMWd2eit3Tmdna3B6Z0NGeVZzYm9oYkJsL3ROZVoyNkZrK0d4Y0x6Yzh5?=
 =?utf-8?B?dW84aWdkZGVVYnNQSHBMc09IVnd3TnFtcnIxR2ZMQk81WUc2dndOVGxKSVhG?=
 =?utf-8?B?V3h5Qlp6R2R2MkhLcVh2TzRxU1NwcjhUUWh6N2xZWmNpOFQ4U0RFQXFuY2pS?=
 =?utf-8?B?a0FZNXNTa29INlNIejNQbGZrRis5Sm1CVHlXR2xpUS9pUnU5b2RaQkRGUHZG?=
 =?utf-8?B?UzNaWUI5QzN1eGZOZlhnYkkxT3JoMTByVUJqWFVwaDBQSkZSZFZVOXAwSkdP?=
 =?utf-8?B?cFpTTXlvdnBuZnZvRFZWM29FQVYwV1h0RGFQU3BQSXZJZVN0dm9sK3dpdzZs?=
 =?utf-8?B?M0FLa201WFUwOUNDdkZlb1FjbkZScVpLSTJrNDQvOVByc3BESzFDQUoyU2lh?=
 =?utf-8?B?MytRdGZaWkJsSnpVcjVTN082cEZLcGVOakY3dmg4Z2dOVWtYTUFoQ2ZaaHZM?=
 =?utf-8?B?eDRJRnZ1MkgyUlJKQnZCczBWbmlrWlhOUitQRlFXZ2lXRk5MOGNJSTE2WUx5?=
 =?utf-8?B?RlpPUFJUTExaUlY5dkFmeUZGcE52ekJ0b2haU0w1cHF6K0NibkFXUjFwUWl4?=
 =?utf-8?B?QjF6SzUzL0ovQkNzaGlFL0NuV1E0aWNUU0Mxci9FTWlaMEFKNFZlbDBaK25r?=
 =?utf-8?B?eDUvOUNPTDlobExJTk1lc3pNNkpuekQrYkFubkI5aC9sY0M1cGFPeG9wZHJi?=
 =?utf-8?B?em1UU2tIdTlvTnJRV3NzUTFhOHZQOWg4VHAvUXF4MkxRSGNLSGpZSmRSZ0Zo?=
 =?utf-8?B?T0ltMTY5QnQ3N2RhajZyTkkycDFxem82QWYxd2h0NGowdzZyU0psNTByL2lG?=
 =?utf-8?B?NFBuZmc4UlpiczJaTXIrbEdacGI1dlhkWmM0QmlyaEVIempsaHRneXFyZ3dy?=
 =?utf-8?B?b0NvSXNEaW5neVBlS2NQemRhVjMrU3dObVlxbkllRGpiOG1JOVFsUjJ2UWgv?=
 =?utf-8?B?NS9DcloyYWZ1VU42RXcxYzUvUXVMRGlKUHhpenRaZytqQmx5Y1Vxa1JBaEd5?=
 =?utf-8?B?TVcwaUJhRWt1QXd4ai9aM1RYRmRNOWdQL25YclZZYTYzSitGOGZod2VmMWxD?=
 =?utf-8?B?OWcySEVRanNCQURQU1NBZkFRVTkySFhvMDk5N0dVckU1ejJ4M0E1NFVFd1E1?=
 =?utf-8?B?SVlTR1BNTGR4OFFZRnR1M2hIR1Q5azRCSXcyd2JWTUVRRVRJMmYyZmJLdzhm?=
 =?utf-8?B?SnJXZ1c4ZGg5RlhuQkFqdnJDN29qMDlOSW94OW1xWThjRFljNnNkcWx6YTJR?=
 =?utf-8?B?bHRIS2VhSzR2RGIvNy9FNVN4b1J3S0k1Vkc2MjB6UzRiWU90U2Z2aEZCb1BZ?=
 =?utf-8?B?QUFiNy9OblMwbUJSeThxK1EwbDZNTHdsQjFhWmg0Vm1iTE1pbGI2di8yYU9M?=
 =?utf-8?B?OFBBWjdQdnpDUGVzRm8vK1VKbFp0clJ4VElBVDlsU1pzNDBMdUZNUUFDMVVx?=
 =?utf-8?B?clh3MEs0L0dQVVlNOVpMZVZLUW5GRGhNRk4rckVOL0UxeFYyTmFIaEVkbFUx?=
 =?utf-8?B?UUVFeUxsQWwvWnhsKzMyYUJqVFdGc090ZS9HQjdxK0dkWWxGa256S3B6SVlH?=
 =?utf-8?Q?fPVRXHxfXGZXEZpXd5h+z84/j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb93626-e8b7-4f6d-0afe-08da887e3f28
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 22:48:23.5847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8TtZCZeqCyEc7d1+979yMq2LuA49tozzcE4cUYRn6agFnlxv3+XGpkbNT6xPJRAQLi+CGBhME3Qu9+Ug9lSiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7227
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

On 8/27/22 15:46, Al Viro wrote:
> On Sat, Aug 27, 2022 at 01:36:04AM -0700, John Hubbard wrote:
>> Provide two new wrapper routines that are intended for user space pages
>> only:
>>
>>     iov_iter_pin_pages()
>>     iov_iter_pin_pages_alloc()
>>
>> Internally, these routines call pin_user_pages_fast(), instead of
>> get_user_pages_fast().
>>
>> As always, callers must use unpin_user_pages() or a suitable FOLL_PIN
>> variant, to release the pages, if they actually were acquired via
>> pin_user_pages_fast().
>>
>> This is a prerequisite to converting bio/block layers over to use
>> pin_user_pages_fast().
> 
> You do realize that O_DIRECT on ITER_BVEC is possible, right?

I do now. But I didn't until you wrote this!

Any advice or ideas would be welcome here.


thanks,

-- 
John Hubbard
NVIDIA
