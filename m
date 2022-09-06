Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AF15AE1BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 09:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbiIFH7P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 03:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiIFH7N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:59:13 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20625.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::625])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086B271704;
        Tue,  6 Sep 2022 00:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaLmTY2o6ftnbJ/27vPewOhblwlOVwJOX1P0gzpp0IOPYfiZCZ4fLAhmKtYQb2vHP1HANaqgkjPGvZSCMEYJiTJEvGlfVdJqKBuGva3zlAPJlaMIkJ0WlvI2w1/mVP7WHdzTz696aWqcTkudqq0kNjzJIxjft9JnDrwN3zg7/iuAfGjq+VO9BNAv1AFydqESyfUhZpVgHt1Tu0+KX9QmYAWma0SF1/5TgTZfj9sGDR3jZGeQkJxhE7wajDYFVGrGbIGPNbZEDj1n+AF0D3v0w+rsy+ZW+7amPbaLI71gnXG0MFU8vhV5ColymkMImVMTE0jqdb76/ar7UpAA+FSJHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNvOLQzdymwbkQafamtSqqFEIWTZYQwKnN+RaXcYcJI=;
 b=nHFmRGzcv5emiG2YvFAhU6+1mjke7lGDW9VLvoofbi+1n5xYujxqsxv0Niyd6nf1oz5O+yXtYDc2+30HYCQ8YXEaPRSWECX3bAwDIL8X+VVuoL46qFqnSbwzDLRNydrao80yqwDzBka9xlJ4RrYUej7NzLizUprOV6JXVTLssOWhIxGUOtbgvAPnZS9mfzcFubHHIV8nsBqvoqm2hpg5jq+XQGRFBHWttwRcnwJMwQa+ooyusivCJLW4FMU7NfEJvNOUC609O4X8M4X/1BCfh2iEfm6BfeeO6l/mFr+lFnawvHnKmcDWentKB6CxliP9APnaCAF49oWDJXAACKuO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNvOLQzdymwbkQafamtSqqFEIWTZYQwKnN+RaXcYcJI=;
 b=K4PKvLVJ2VrF65GFHZvFHk5Rxg94xZ8tjBqQvI/G6YZlp80D40h0tBLtLrQbHoEEM9SsevIzSRB2Ttmz8umeGdxIILL0qdtxNOYJ4MLUWqwdo5OPDBDWTbploFcZhYupsPW6Ezv6XsKTzUG3yZVyqeGchDM0hGGkohe5OirFjWwXoLCl0t369eQH7lzQdl26LE9GvKP1WeR5h2Di+7REStm3Hwm6odd7YZJKrZ7LNwuMWvy1ZW4FrJ91O/PhcZzLriTAUMwnamP3oJT7v9FMlVRHMIQiN6GcbdFlaswC6nU4pczuisb+ZL8tH2p+ie+DzWmKw67s3tAHWU78WclzCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by SJ0PR12MB5609.namprd12.prod.outlook.com (2603:10b6:a03:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Tue, 6 Sep
 2022 07:59:09 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::e0c5:bb15:a743:7ddb]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::e0c5:bb15:a743:7ddb%3]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 07:59:09 +0000
Message-ID: <d1535f25-b252-ee38-8eb8-94af9367d5f1@nvidia.com>
Date:   Tue, 6 Sep 2022 00:58:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 4/7] iov_iter: new iov_iter_pin_pages*() routines
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
 <20220831041843.973026-5-jhubbard@nvidia.com>
 <YxbtF1O8+kXhTNaj@infradead.org>
 <103fe662-3dc8-35cb-1a68-dda8af95c518@nvidia.com>
 <Yxb7YQWgjHkZet4u@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Yxb7YQWgjHkZet4u@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0007.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::20) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 854f191e-6af1-4505-9918-08da8fddad86
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5609:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7Pqvo2CuFIX9TiyH/FdgxlrodWFD6UDMeedtFgFLpJ3Q6lcDB7odHxJzuLTsWZJPLT4EmKxl0C1NCRGLnIEv91KVnd9EWYA0PDWt7b+5lakx9o7llPvh6ClcGUeUUMc+E5J4oT74/LQ92nsLOglGRnPoY0jKl1j1MmVeM00fL+CLauDapaUwOx9rS56mjgoQKJs7/Y4upicS5w3q9XoTLf9hHMix9fhw3EZEzz2B0mLjkjGqaegsskLVRRwIiBSbtYqpCwj+by+aHf3fmGt9Ro/XJGas7z8VYtfjsO185ALtltz36NzoFfagN1m1K9rmPcKjE1BpU8W1DJHDHDCyt6iDtcjS9VjCNoZrIwSwNur4jJ/+R9GKGPPuFfPwRWT4Qopk81OcvmM/1Y82yPy93Kkg1ulPk9+Hfdl6Wy+LB6EcVbMplNBAqcAsdFXDrb543rEV1lqfcCpevC+ZxP8LyBFIjbMHgh/5pyC3+3VowTnLrW7/JzTKQ8NXOInZ1bFV6Q9yPWnRpbiccusbNlmhKfbheThAYXp708cAVYg3SKsjHPH/NKNgKipIdJqN/o7AbEw49ou1XicWmHaCBJoQmsml1axC2wKIPjkhGFaDs/kZohAjlO0XAL5W+zRdFsKlvphC9tovW/aLeJrSz6xVQuSXO5yuvCZCihBTHVlBln7cuFNZHnTec4F7ofd9DwRUmDWEI5iOe5niYYXxnDqGTX6NmUEg1fz86BoLeUxbx5xX7Rwje0gTZ0277xAuk/dVhJPPYLCTeBNDIaos6uHWv+Ry3UE7ORz+Xu6YcSOtp4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(7416002)(8936002)(4326008)(8676002)(5660300002)(66556008)(66946007)(6486002)(6506007)(26005)(6512007)(38100700002)(478600001)(6666004)(66476007)(41300700001)(316002)(186003)(6916009)(2616005)(53546011)(54906003)(83380400001)(31686004)(86362001)(31696002)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXFCM1FZSnpYWUNkbk5ybi82ZTlRUkNBOFBqeHY4VWZpcEpXVGNrVEFlaDFZ?=
 =?utf-8?B?R1pISzBqM3hRdEZFWU9uclpZNCtCYWVkZzQzY0RRRzc2bmJhWGVRdkFZVjVN?=
 =?utf-8?B?UmpCZmNtT3NEN2R0bTRtbUtUSmUxU0RMa0xFcFY5bFRaTVhvczFtL0JjeWxN?=
 =?utf-8?B?VWk2QTQ4Mi8vNkl1azRRekVicjVsUysxMTB5aVFtRXlLL084bUQyZ0dvVzA2?=
 =?utf-8?B?MlBTT0NreU8zOWZJS21DeGhnY2QwZjYveW1XalMvenludmsxTG1aODRyTFJq?=
 =?utf-8?B?a2liMG9vSzlnVUNob3J1c1prK0FZaWh2aXhyOVh2NFpDYUdUajlvaW1NSm11?=
 =?utf-8?B?VmtpUkt3NExKblovOVFVU09XTmdRRHdKNVJvQ2h5TSswc3ZDMGhsOEFSLzMw?=
 =?utf-8?B?cE1hSUNWRXRtd0VvSzZwU3NlVVVpTUYyVjU0WGtORnVZVERxTkZ6dXMrLzJa?=
 =?utf-8?B?dDl3d283bUtUazVsM1NYTG9GdnNXbHdUaER5U3A0S29TOFg5Nm82enkyZGha?=
 =?utf-8?B?SkFPZXVnSTZ2SVhNdEROVXBIK2czQjg3UnJCb2hXYWRRTXljSjhlKytEKzFV?=
 =?utf-8?B?c2pGVkhpL0VycHRtRFcwWE4vM1dTcDlEbkpRSStlTGNjeHBFdlBqeUNQUmNH?=
 =?utf-8?B?dXo1ckkvV3RxVlV0TDBQVzMyNFFIazJpTmZ4alNmMk5zNmxFQ0FFOW1mVGpN?=
 =?utf-8?B?UjZQRzhmMHQ3UnU1Uldka044NEpBWlFNYWIzT2phQy8yeHNreGYvcjZ2eWVX?=
 =?utf-8?B?UVpucG1WeWU1a09OeGNsbFQ2QnAwdXZId1o3V3pVa000STkrZGtkV3JvYVZR?=
 =?utf-8?B?RFYveWY0K0pqNVVGZzdtUzVtL1ZwNWxaWTBvVWtSMzVOb0NlQzRoRzFvVXFp?=
 =?utf-8?B?ZjBmVXhTTWJ2YUNGNnRQMWE0NHZvUXJmNnZRb2w4cGdPK3VOa0JieWxGQmNC?=
 =?utf-8?B?QVJzaDFGNkFreWdRdTQrZTE4Y0dRdXpPdEpzdDJTNnBDaytGejZ4bk5CWFBO?=
 =?utf-8?B?dmhIaFRpaG5DU2dPZUFwYVoveWJOOTRwd0RMZGRQVlRKRk5Zdk5ZeHpVU1Bv?=
 =?utf-8?B?c3NWOXJhb0tERkpUV1BwSXZ3YkM1bkV2Y0ZEZUliMkE3NlEzMWY0OEE3TnQ4?=
 =?utf-8?B?UUhPMVdHWnZvWUdjNHlwK01WRFhFWjlqVFhVbUNyR2hVeUVOQkczS0VVdUdq?=
 =?utf-8?B?ZnhOQ2tGQnJqa2NORThCdElUT2NzNSt4NlptWWE4Um1ZSzA5cldRZlFMVW9I?=
 =?utf-8?B?TXpuK29GbklTVWYzTmV3NXovTUl2Q0dkMjE4dXJkVU9XbHNkWTFjSjZmK0xC?=
 =?utf-8?B?dXR4bzF1a3Y3NnBtbUlUb0pVRFZlOUJMc01vbnBVV0VVMTBSaVJVbHo1K2dq?=
 =?utf-8?B?cXZINHJFcGtjY3lLUE1vaG9WUldkOVFiQzJWOU0yYUJGc3hqTlNWc2lsYmFK?=
 =?utf-8?B?eXd3dkNRdlJwc2M3QXRaQ3ZJaGR1NlJGN1BMM29CWHA3RzRWM0N4U2dQcHVo?=
 =?utf-8?B?SloxTTFmYmtFa2ZrZVM1WHljaFV5d2NKZm1VTTB4MWxHWGlXc095YStzZVl0?=
 =?utf-8?B?ancrV0x6a1kzOU05Qkd1M21tSjZOMXBxK0h1NTJtN094SmxKWG5KcjRaREph?=
 =?utf-8?B?SmJkLzJmYlNYQktMRXc2WXlFZUY0bW9COEg4MFltdkZrVG5GN2ZaZmVmRlcr?=
 =?utf-8?B?a01vS21jelk3dXZYa09TSnB0aFg5bjJHTDZpZmhzc3l6UG05aEYxd0J6bkw4?=
 =?utf-8?B?cVdndzZOeEF6ekx1YzduTW93Vm1JbDlnbldyaG10RG1OUmx5UVRwS21od1Yw?=
 =?utf-8?B?R3Y1aGFSbTNQLzZaN25laDYzZ2FXNkpyeU5HZHhCdStGTE8yaVp5TWNuME9N?=
 =?utf-8?B?WEZBMCtOZ0VIL2lsazlqc2s0WUduVDdBbml3MEJJSTErRm4yTWg2VkdNalVI?=
 =?utf-8?B?MmllYUkwZUdsN2FhbHlNU2U0TDlQZjhaaG01aEZYTUxUc3BOUGtPSnZYV0xE?=
 =?utf-8?B?RHFNeVA5RXVPdVpoWDArNVVhY2JzZzRCSGQ0SExITXREdEI2MUlNTEpaaGhK?=
 =?utf-8?B?VE8yMFRhZC92bFJweFUwSDlQOVJkYTgrVURveEVINTFLUFpXY1MwUjNqdmhv?=
 =?utf-8?Q?LkvOAWaVg/d6BhQJAuKv1k1BJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854f191e-6af1-4505-9918-08da8fddad86
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 07:59:09.0201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2T6Isx3z1j2v+FzSuBMhCL66JGYL55tiirQ7tm1RRQLq8fPEKt8e5FroKRm9UMmEwJPkZRuM7NA2j+efPviR9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5609
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/6/22 00:48, Christoph Hellwig wrote:
> On Tue, Sep 06, 2022 at 12:44:28AM -0700, John Hubbard wrote:
>> OK, that part is clear.
>>
>>>  - for the pin case don't use the existing bvec helper at all, but
>>>    copy the logic for the block layer for not pinning.
>>
>> I'm almost, but not quite sure I get the idea above. Overall, what
>> happens to bvec pages? Leave the get_page() pin in place for FOLL_GET
>> (or USE_FOLL_GET), I suppose, but do...what, for FOLL_PIN callers?
> 
> Do not change anyhing for FOLL_GET callers, as they are on the way out
> anyway.
> 

OK, got it.

> For FOLL_PIN callers, never pin bvec and kvec pages:  For file systems
> not acquiring a reference is obviously safe, and the other callers will
> need an audit, but I can't think of why it woul  ever be unsafe.

In order to do that, one would need to be confident that such bvec and kvec
pages do not get passed down to bio_release_pages() (or the new
bio_unpin_pages()). Also, I'm missing a key point, because today bvec pages get
a get_page() reference from __iov_iter_get_pages_alloc(). If I just skip
that, then the get/put calls are unbalanced...

I can just hear Al Viro repeating his points about splice() and vmsplice(),
heh. :)


thanks,

-- 
John Hubbard
NVIDIA

