Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF655343C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 21:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344059AbiEYTG6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 15:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344058AbiEYTGz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 15:06:55 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2058.outbound.protection.outlook.com [40.107.102.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFD71182E;
        Wed, 25 May 2022 12:06:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qy2YARVnQzDpzmfpwYVaJmdqMYzk0pYrMQrBpo/fN88dppvF4wBzObB+VMRWOG3Fc6YQt0zj1FBInfCK0am/93+zGjYnkzFDXhnlMK4ITQBx/jsxdz+aiMUBOy05NJZzJonhyCGGdBoxNUXwP7pKZh/Q62S1dY7tUvzFzJTaQ8ljNQV5AYSLAgTjNTAqiucVvMbSmOlLh9I8JM25tk0V7G3Xagljy8XDgFDweMzpzUYPW20jHiBlE209QGbo3ETn2i5LK+T5KkS7ob/uI5rydqzH/zdpNu3YPBoyt4quI7PbeSXpRUtJsfwG7mMJPrigVwpFdg1MMaMq1SqBe3tncg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmK0l4vrSLZqAbg+H+696K0BMp0QRrMpCNlUxOvFPZI=;
 b=TNiIl+seE22PWNS+T2actUAXv7PrgqkOPo1IE+KBbBt6/grXwug3Nbj5mbqGaXTrD3rjF4OuXrGVqeT3B3WT2U8XXSl4jTjhetOlCj0zsfS0WB8lIBZ4R5nBflebAU3NpnXSCVtIdqPowcu2Cgv7+IjMUFXP4WVa4kxUM1KOhTFnG83LXJJ4lpdCSJv8cIisMZURl2jX2H5WO8yapsVEx5cEjCI2sZs6UN7aOCDleOidQHa3pT8AbioO/Jn/BWWwS1XwB0TOI+FL0rhHhdLjZtNqUL6oS/ahHHeq7WHXLqQJpwg0NIQqUlmq4tKWzjSQddE6HImvj2GSOYOZ5mX3uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmK0l4vrSLZqAbg+H+696K0BMp0QRrMpCNlUxOvFPZI=;
 b=dE5a4wNAIJt7IKdJF83d6S/Md4+f0SCJXcW9orjXcz/LfG+4EjTWIWh/qpJZrRvetwEV+1wfDYgpDrX4frUL4sY9NiZtRDXo3nMjz30wQnDsmAIhyK8JzGbKlbWp/1/T7sdt0TZ2tln+TtItUO0orWPoRqXi7EVcbz/2MeGgJzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by DM6PR19MB3979.namprd19.prod.outlook.com (2603:10b6:5:242::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 19:06:43 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::3994:ad08:1a41:d93a]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::3994:ad08:1a41:d93a%7]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 19:06:43 +0000
Message-ID: <77b28772-b210-6597-eedd-fe7e0b5b1db9@ddn.com>
Date:   Wed, 25 May 2022 21:06:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/1] FUSE: Allow non-extending parallel direct writes
 on the same file.
Content-Language: en-US
To:     Vivek Goyal <vgoyal@redhat.com>,
        Dharmendra Singh <dharamhans87@gmail.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Dharmendra Singh <dsingh@ddn.com>
References: <20220520043443.17439-1-dharamhans87@gmail.com>
 <20220520043443.17439-2-dharamhans87@gmail.com> <Yo54Z4EQjzsQbMTp@redhat.com>
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <Yo54Z4EQjzsQbMTp@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::14) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 843e64ff-c5b0-45a4-56a4-08da3e81b473
X-MS-TrafficTypeDiagnostic: DM6PR19MB3979:EE_
X-Microsoft-Antispam-PRVS: <DM6PR19MB39792743D66D0952BF5B1201B5D69@DM6PR19MB3979.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7WR/2ZXlHS19/VmDwmI/9OFu1dqhZ405tXJqwExD4Pz7SX/8MueQwhUmccnrDtN4BFJ9uf8Amhf6x6ZfXbZsgWmsW+6yzLyuSQMyKG6CCPeahhpO/D15CstExUE3Daqc4tHQkenh0UhyPcShTGOle43mT2vsnamWu7qj6PLZd02OOvNlfF+dJ6VNAf300N89CGLvZzYl/frh+53OvGYHS+QTO/h+8J8c7g+8hlA5D1R+eLCXXcowUXCaLR9mFf0U3xhg48prMb8xYkOxbBvvc+cgm6Ni+b73pONadPhchhfY76lNFL2yh2U+Ab00fYcfn5Mv2LNx3pPMcDXrCbQBdmhcl5OTQdarVhqwgR9Ei2WOFVQKAOXKdPbFwchpAROLUcrIaKz42uWwYzYjA84HF7aiY9INyXYIwQ23RmZHQN0ja1y9n0T/gqWKj1o+zA+LZSgV2bxYnhoqmwOTe8oWumW3PU96uXxqq0t2+PudvR124Q0C8/Ks+/WRmDshNI/9m0L+43vaI6rf/pAIVxkLr8dXqSK+PZ85DHOR4Chhe+/N+691MsHDBwPw3xDa+cwktdE/2lqvulby6hmNpL3xu5xid4lxSWRhdZ95AVsOP+kghenCFOsAOAB++kO7Fy8vrnx329+FgGNp9YkdqHBUIO2udjuuNC2b3WuE63ZWJ4sGx4b5ut3y+JUI1XZdwZfbI76/NErqbdzfdyOUK63gsHoeaSXRvlbn/my/T1jGJ8M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(83380400001)(31686004)(6486002)(5660300002)(31696002)(36756003)(2616005)(8936002)(186003)(6512007)(6666004)(38100700002)(6506007)(53546011)(8676002)(4326008)(66556008)(66476007)(66946007)(110136005)(86362001)(508600001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXBJcVZvYlJGSW5iS2NyWWxwb3FZVXZtRVZ5ZUVYVFhLNFh4WU5FWVRrOWoy?=
 =?utf-8?B?ZHhkYXk1MUhGUVFteFl6NkhpMEI0cGdRbVFCSUdJT3JzcG1NMG1CcG1mTlpn?=
 =?utf-8?B?RVhkaWdGV2w3WURWZlliaEsyNGQwcnJvbUVseFlrcGsvc1pOeFVnZzNKUFhL?=
 =?utf-8?B?ZnVwalByV2NGOWN2V3pkT2dhWWpjSGVVTUFOajN5RWFFK3ZSYjJNUGZab1Jr?=
 =?utf-8?B?bmwzaDg1NzhzcUt4V3g4OW4zTmdvSk5mV1g3MTRET1oyczBjWUhObDBYRmJm?=
 =?utf-8?B?cFJkNHdFcjZYYkJacFBJb2NLOW5SS3JWTDcyalRBenpNZVROOTdKRmxaL3VP?=
 =?utf-8?B?bkNwWGpnUDFlODJ3WmJ4NklqcmF3azBZY3ZBTVU2RHoyaGM5OFBHNzYxR1hm?=
 =?utf-8?B?WU5GQnNRTVFUQmFpTGVyOFBEOW5KRkVjaWpBcSsvYXhGUlZ3dXUzc25lbGxV?=
 =?utf-8?B?WUJCK2tQdzVRYmRrVlhCQWloN013ZTZ2Q3RaR0R3VzVnRm1HK25ETEFZRVds?=
 =?utf-8?B?c3FvYWMzcG5HY2RDNzdtR3JUaXBxU0I5WnhsYlhGRlRoQ1lwWm1FRGFvcjNv?=
 =?utf-8?B?Y3ZUZkkzM1dRMGJ1TmhZNkY3NEdNYVR3VndPQTJIL0dHb2xycjk5dzJIR1Jw?=
 =?utf-8?B?bGVmeWRvREx3bUE5Z0tUNnpFTEFUUU4zMDFJWDQ4ZFRVNUVJYmk2TEVBcVg5?=
 =?utf-8?B?QWU2WXAzL1pCd2s5Tmx1VVdwYTcxMy9KSHdRT1JZWGJpZEVuRmlWbXpPUDQr?=
 =?utf-8?B?ZUdJeEhOcExxdXhaWHBsdFE0elRPWk9wUzFkMFdNcUJZczZMSWNHQ1J0UXd4?=
 =?utf-8?B?N2kvMjR0QlJ0ZlBNUC9mUDc3V3FGNlF1SWhPSnRVdi9Hc0NwMUg2elBJYjEr?=
 =?utf-8?B?cVAya3JZdW45MWhyTzNBTmF0NmpFQ0FOK0RXODVmR0RxZHlxQ2JvMzRZaDNV?=
 =?utf-8?B?Y2lzTUxPSGpMQ3d5SDFaQWpYYy9RVERzay9aOFVtNXQwdmxocUhkYlpBZElG?=
 =?utf-8?B?VE5JWExvQjZHSTUzZTEzckxhdVhyc1AydU1GTVlTaGcwK0R1b0c4SUlrSEZq?=
 =?utf-8?B?djFNNnYzZG5Ga2NTckFnazRRRnNwanVBT2UxNlRYOGpHcjRxZ1V6MWpyQkow?=
 =?utf-8?B?ZzRkd3lRMFQ5TUZiNjRWbHR6T0ZjYUZpdG1jN1JKN0sva2FCY1U0ZU9ld2pz?=
 =?utf-8?B?cnVRYUdESXlCNDgyamw4YUkrZ1V2TE5mZmFQNTNkSWtENkVFam1JdnNNZmN4?=
 =?utf-8?B?b3BiWGkwY1h5Z1RwSXRFbkd2c1NVWTZFWEE0VVFwNkoxN1lYUCtPb0dyUDFm?=
 =?utf-8?B?ZVdGWUFrNnFMNHRHcWlMbkRyQzFJdXYrK0JIc2lBLzFlL0VGZVMvd2taQWdG?=
 =?utf-8?B?V2ZGeUlKK0thaGp4TjhTZktiTEhNQU4zcno2RS9XenVBRmYvNG1CSG1OM2Fh?=
 =?utf-8?B?YjVXRXo4TGl6TDNMVlhiWkUzMjFTdzhPWCtPWkl6Sk14UnJNUXFsVjhDbnhT?=
 =?utf-8?B?LzFXMldOSzMwQ0NGb01rTlZ3RVFDU0xqMlZ2ZUxveTZaNUgwdUFUMWs3V0xr?=
 =?utf-8?B?bFVNWlNtZTIwWmZ6bURRdkxlNFM2djBEbkVyK3BtNTNHSlRsdkVYc0lhanpw?=
 =?utf-8?B?OElPdjE0V2JGczk2MGFuZXdlVUZMWFlJM3pjWGY5SzdRaG1vVUtsU0VmZ2Yx?=
 =?utf-8?B?bWx6Y3haY0VuLy90eGYzcXhlbVZMTHNuQnhQVUVVcmhCVDdINDBvamN4TlFP?=
 =?utf-8?B?TXZZR3UzcnJZTWhoc3NSQlhtOCtnNEd6TlhGL09NTDI0TzAxU1FZL0laQ2JZ?=
 =?utf-8?B?d2pVRmxFY25MRUJ6OUdFRlRQT0JpanBmb2hMQ0h1TXRkQWZFTjROZTduNC9U?=
 =?utf-8?B?ajhzc2lQekI5c1ZYRHhuUzYydGhRdW5FcWk1SzVwWnd6QzBFMWxrb0NGSG9j?=
 =?utf-8?B?cG5pMnFrcUtPZkh1VVZaOHpKdGVMZ1JBNHFhTnJkSzlDWHFPRncybVl4cTgz?=
 =?utf-8?B?NC9rOHFjNzV6U1Qxc0hLWCtuK3hLdUxzMFFLVWxvMjNHWDRDQ3JyWDJaVGtX?=
 =?utf-8?B?Ky9scm90YkdkVjFUMzlocnVYQUJIRXh0QjJEVlhMYjVPZWpLSjJ3a2FXWFRV?=
 =?utf-8?B?YVhlbmR2TmpIeU1UL3huNVk0VFdjY21LdHpGN1FUbkJydmtFZE9jcU5uTlpp?=
 =?utf-8?B?ZzFRemlLQjlRSGRxQW1wOC83WE1aQmV6RG9DdkZnZXRHamVCYTNXK1VtUlVo?=
 =?utf-8?B?Sjl4RDZsVjI0alRlZDk0b2RMZTQ0UzBIbnMzOXBtam5UTVBad2h5ZDRoVmRi?=
 =?utf-8?B?alk5dzVONGlrTXdIYm9meFYzVE51T3Nod3JvSVRNUWRRVXY0a3RucDJqZVFY?=
 =?utf-8?Q?7dcV0YibTFXmZ2O62YSxnZRlVGj30XmUkhuUj3B2ESrSe?=
X-MS-Exchange-AntiSpam-MessageData-1: WVGy+FsxmBZleQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843e64ff-c5b0-45a4-56a4-08da3e81b473
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 19:06:42.9257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDegmWAX5I/ZyJUUvoqeYlMNis4zgfma+cSPR8ce3dmP4nVIBtKv9TY8uBndV+th4JfrPvzXXmzwvxvI5UNmog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3979
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/25/22 20:41, Vivek Goyal wrote:
> On Fri, May 20, 2022 at 10:04:43AM +0530, Dharmendra Singh wrote:
>> From: Dharmendra Singh <dsingh@ddn.com>
>>
>> In general, as of now, in FUSE, direct writes on the same file are
>> serialized over inode lock i.e we hold inode lock for the full duration
>> of the write request. I could not found in fuse code a comment which
>> clearly explains why this exclusive lock is taken for direct writes.
>> Our guess is some USER space fuse implementations might be relying
>> on this lock for seralization and also it protects for the issues
>> arising due to file size assumption or write failures.  This patch
>> relaxes this exclusive lock in some cases of direct writes.
>>
>> With these changes, we allows non-extending parallel direct writes
>> on the same file with the help of a flag called FOPEN_PARALLEL_WRITES.
>> If this flag is set on the file (flag is passed from libfuse to fuse
>> kernel as part of file open/create), we do not take exclusive lock instead
>> use shared lock so that all non-extending writes can run in parallel.
>>
>> Best practise would be to enable parallel direct writes of all kinds
>> including extending writes as well but we see some issues such as
>> when one write completes and other fails, how we should truncate(if
>> needed) the file if underlying file system does not support holes
>> (For file systems which supports holes, there might be a possibility
>> of enabling parallel writes for all cases).
>>
>> FUSE implementations which rely on this inode lock for serialisation
>> can continue to do so and this is default behaviour i.e no parallel
>> direct writes.
>>
>> Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>   fs/fuse/file.c            | 33 ++++++++++++++++++++++++++++++---
>>   include/uapi/linux/fuse.h |  2 ++
>>   2 files changed, 32 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index 829094451774..1a93fd80a6ce 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -1541,14 +1541,37 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
>>   	return res;
>>   }
>>   
>> +static bool fuse_direct_write_extending_i_size(struct kiocb *iocb,
>> +					       struct iov_iter *iter)
>> +{
>> +	struct inode *inode = file_inode(iocb->ki_filp);
>> +
>> +	return (iocb->ki_flags & IOCB_APPEND ||
>> +		iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode));
>> +}
> 
> Hi Dharmendra,
> 
> I have a question. What makes i_size stable. This is being read outside
> the inode_lock(). Can it race with truncate. I mean we checked
> i_size and decided to take shared lock. In the mean time another thread
> truncated the file and now our decision to take shared lock is wrong
> as file will be extended due to direct write?

Oh right, good catch! I guess we need to take a shared lock first, read 
the size and if it is an extending lock need to unlock/switch to an 
excluding lock. Theoretically could be a loop, but I guess that would be 
overkill.


Thanks for your review!

Cheers,
Bernd
