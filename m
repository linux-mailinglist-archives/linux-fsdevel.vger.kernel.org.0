Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067DD4BAEFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 02:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiBRBHI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 20:07:08 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiBRBHH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 20:07:07 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994CB21E03;
        Thu, 17 Feb 2022 17:06:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beFY7Zyl6dsy7duQxquIOE9m3TmPMe9rft+9NmGu2/4Z0uznpL2qOghtnWkitLyb6Q+OdApHbfOFXuui2RxvfI6uyRBtEwZnmtInwot+xPsKWZSTVRfUd27Qdqz1EUOxBotuVsR2+JPmJThgYa+JCIQTdHmZbjCo5MQsbdzl3y78fCLjd3J8lBJ3O1e4F/lhMcMkuO2WfG8LUfSYJgV5+ih4C68mXRYwKDv5gGstnlgpOmOupThmrprS3AuKqfJT+PWTsDsfhrioL14iNSSOFuX+OZ/NkPAAxnBTI1tWfg7WOu5o16y3wVE8qIIo/qWX61u57V2pNQDX7VJYRcTnuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ca2KzEPGfyJbXxOFkAthxKTAt4QC91jqPFkRwx4NL3M=;
 b=J2sZyfi1LvNjenrOUjV2m2qnAtelvz5LGnekus3l1R7CqWEyzMvs9WqXnejFcz86H23YL6eSZUfLyKOdfrbT9djThuuwWHxQvj2SEhkTbwfn85zWLmmPBHq12yljTn9WOD+jMI/Mdqhzp+daccAXdbFJ5KS5UkZ5cDks5j2t+8UubtcVX/4u9gXLiIadlDC095Ek2r7iirYs+bL0Dq5gjxApMpB1FHokyhSU6yGxDaxAdczArIuqihL5dDl6oTLI5u0LkM3j3nvqJyzJrEVVcMqJLy43zRe5CfFEq6PRe4RfEd/5ztrhVSTcmPQ2a8n7s2GtQY8Xxdw1oNudKYt3Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ca2KzEPGfyJbXxOFkAthxKTAt4QC91jqPFkRwx4NL3M=;
 b=LoA7vdznlwrxD4hU4yeZlnU7ETHsWHFbxIIUUAAHsCTxFFkoSIMW8nEOif1atfhg/0SbGYWXkaXFkD33XXoDS6B83TjpmxeMBJLGgpT7v+13GXf2tdsuryOdfK5NAm0j7hyxerF8tChrHGBDM81UzvuORnzgHwOKwTTUnq/qVg7OR9B+XcNeT2phSLlhLD5B8MFSMX5ARnBqtCnqyDajwmF47PO99BfGh27VyCub0keS91T1225HoD0S9MVpd2OabI+EZvLi6pSb2UaMSFm6ls27K3NdYdfTrjZw3BD1ekyCFxvjANd0PVcTVs1Xv1yAQkuBRFJEX8LBP9hNDk/lng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.19; Fri, 18 Feb
 2022 01:06:47 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%6]) with mapi id 15.20.4995.015; Fri, 18 Feb 2022
 01:06:47 +0000
Message-ID: <82d0f4e4-c911-a245-4701-4712453592d9@nvidia.com>
Date:   Thu, 17 Feb 2022 17:06:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [REPORT] kernel BUG at fs/ext4/inode.c:2620 - page_buffers()
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>, linux-ext4@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Dave Chinner <dchinner@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <jth@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
References: <Yg0m6IjcNmfaSokM@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Yg0m6IjcNmfaSokM@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::32) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a64eb021-257c-4be2-32a8-08d9f27af007
X-MS-TrafficTypeDiagnostic: MN0PR12MB5764:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5764C04484DE4015BE448CF3A8379@MN0PR12MB5764.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lrfx2+FJNorMF2tMz8nBTpJqqclq9Mrk+jk6bztYfFH1E4PU8SqGaa2qKAhLUhfFD2aWTar7/eedxF5j9WpNzxRUOuN1/eYqntha127wYDlbcCKM+QUvpY/pPWNQiRxIJb+7TvEmbI86XneocqKOzP3haJDePn4pBFOvPKxI3IGJpKzmMv5YwebufgMyFUbNwH6FbEhpOkwSYxmFxDfj/y0Scn3sOIGk/C0WYy4lZVu4xj8F7IwH1CiB7lcMveJ7N5aHdZKFyej+LShFrVVSCOkr3nanzmF2StVNSCx+2regIUcAvFmhFfatBIBKNzFpQm7qK2Xxt089hAZWY4f+tvFZQmpj+DQlW7VVs55kcqWf5o+1ITNkU3WzNbLW39sQwZ1wXcTR5VePEcOILk7DvzBEdKLv+eCMO+Ym5Ml8WxMtyAoNPINLPGPMae4KEjQjEi6ivr/tqP+CCYPwVSAP/RxBBLp1hE1pHjQo/0wZh31nqAdGILthRQABf2GFxMcgbocBPmJIK3psljvQMwUiXZlXdgt7Ox9n7InuxEkQ0eb7RbtUcyNpv0rkPA8SWUXQPssw0pgw6PVJi4Iu/7IpCqRySypTd248u7dMWOei2rE1vILpSq/WMm1UCQ2lJvIIebPLloVwPeFqqfs+x+ET9/SWVp4RX4w9Mfrn7k4Xpozaky3+1+ODjBJsaqm1JNiLiSvbB6o3JW9BrUUEsz9J5iBrCLn2LblKvef5+8EiA7hvEHxq+FggUL3Y+t4Ig4vLQ/beJ2qHKprORSwwwnnNlwkpMbFasPCuHV+G7o036oKPT1+T4tDEfaySqfdoOpYuNoQex3ySCcrG8LbYpAAuaNWmqiP31YgQgbq5vQoDmoNsSJy6JojsZQgkUxNuh11S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(316002)(38100700002)(6486002)(54906003)(966005)(508600001)(86362001)(2906002)(4326008)(8676002)(19627235002)(66476007)(66556008)(66946007)(5660300002)(53546011)(83380400001)(30864003)(8936002)(7416002)(26005)(186003)(31686004)(2616005)(36756003)(45080400002)(6512007)(6506007)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1hsQTJQczZFcDJwMGgrQ0JaYUQ1Qk9tdzdRSisxd2VtZ1ljN2VuUWJWZFZG?=
 =?utf-8?B?d01JNWpLNEd2TG9XQ1RMdEVuQ2YyQWttRTVaQ1R5Ky9mYkpNbHpFeTI3V0hr?=
 =?utf-8?B?YmRkOEVuM0wxS0dVWlJ0bTlHVWRucG9kUTgxaXUzUUF2QkJRTjJrcW9QOVFj?=
 =?utf-8?B?NHg0MzhqRFZyZGV0MW9uRW10SGMwYUxhd0VWRVcyNXhnQVBjdmUydnVkOXpJ?=
 =?utf-8?B?cW52U21mUkJNQTlYbXMrLzNlNWYzakpTZkFOWVJSYmNJNDZuTHl5M2dCdG5n?=
 =?utf-8?B?ditZRm1KQ2lmSENhUDBMcjFNZ2MxWk5iSlM0UFM1TmJTRlV4V0o0N3RUcEpO?=
 =?utf-8?B?TXpXdHAzWllyK3huVys1MW5xZXRRTU9ncjd0VGMvT010R2s3UnFDV3MyRVBG?=
 =?utf-8?B?ekhVU0dJbklXcVZudENEZ3ExZUlITHd3Ylo1aHZUTE1Ka3RXNHZCK1dWOXdT?=
 =?utf-8?B?aDY5OGNWcUFqRy9acmVWLzZuelZXbkpyeEpJb2d4R2VyMENXM3RVVm9VK2Z2?=
 =?utf-8?B?QnB6UVVjZVhXUVVvYVZvcWMxUjAzaWtKVDBSU3JaaW5oN25XVnBUSFl0dy9r?=
 =?utf-8?B?NTAxRGw5SnZDMzRQUy8ySTk0NFQ2alFyYThCaWRDczJkWm50TmVqejh2ODBu?=
 =?utf-8?B?UlpSTmgzaFVCUDFsOU5VMC8vNVMxVE9KeGFYVTRRSFRMY0txcXJvTnpJUkVI?=
 =?utf-8?B?dG01azVHUCtpcXVoNVdRMXd2QUYxSmlYNWwzRHAvLzhBc0JiVTRLSDRhQ3dx?=
 =?utf-8?B?TG0rT0gyaHZOUjhwYmhGL0xLVVhlOTdnODZnY080L1V4ZUdDSWJTMU9XMG4v?=
 =?utf-8?B?dmwwQlNEcFFVVEMvVy9UMkRNOWwyRE5tZDRsSVhId0VOb3dYaWQ5WDdzSndw?=
 =?utf-8?B?WXBNTW5YTkQ5QnNLQmZGVnN3OUdzQitmUWJNbmhIQ3BoMTBZVDlicUhNYzRQ?=
 =?utf-8?B?alJPSnBjYm1BQmZLVURLK20wK0dLVVgxalpUbW5yUDFZQzREbkRZb0JWRE9E?=
 =?utf-8?B?TVNlTGhXZlNjZDlyOVB4a1BLdklEbEZkWUVLUVk5cE5LSE5IdlNudEhZSEFP?=
 =?utf-8?B?QWVIVlNVY3hiMWJsT2N5QW5ZeTVXOHNjNDh0WC9qbUJlUTgreWRaeWRMSFkw?=
 =?utf-8?B?MDVvaEVxL29GQnAzcnpqYjBzWkl2SzRJT0pUS1BWUDB5cm5xQy96d0tVYnd0?=
 =?utf-8?B?OVg4MmNMQU1BQXc5OXEwSzhMOXNrVnNWdWlvYjVMSkFRQWpmckl4aGNpRFY4?=
 =?utf-8?B?OHk3azZMS2tEd2tFYVZDK1Ezdzk1ZFVHZUJkT3BkSWdPdDNHbFpvZVVhTXZz?=
 =?utf-8?B?ZFRrUEV0eFVuUTMzanlEVENadE55elFLbi96N2xWYVNPOHkyYUhSL091RzN2?=
 =?utf-8?B?YjRVTTRNOXNldEE2ampnaEtvNXpubmRVbGN0TmFQOHJpbXVaTWZJT240czA5?=
 =?utf-8?B?Zk8vWXVNLzVNdjVqQ3ZmSkpNSE5MNkFoWVhLR2hmK2FTbzRWNzErcTUraDhE?=
 =?utf-8?B?dlQxVGt3cjN4bXBJWEdmOHdCeXg4U3A0aUhDYnh0WWV4MzM1RG4rQWN0aWFP?=
 =?utf-8?B?alVYWU1CemVYcFdYWk1oeVhTRHlMSkJxN0RuZDJXWHdBbjF1VnlwakhjMnhy?=
 =?utf-8?B?bkRvaEtrR0hmd3ZNUTc5VWRTRm5XNUZEVjNQWEg4a0tZcFFxd0I2bE0rOU4r?=
 =?utf-8?B?MytmSklsWllxVHhWSnF6eCtVcGFpM3QrLy80anFTN3NkSHFzc3BNaFA0Q2tF?=
 =?utf-8?B?cHpTdmJUeWV5dVhwSFI3VlpGRFQ5NEw3YWgvRHNITmdVZGdXNVJsSmovZERz?=
 =?utf-8?B?enlYZnI3WDVIeHdBNlFBT202QTliODV3TWdEVnVVeURDSGdEdk0vZnNHaGZj?=
 =?utf-8?B?N0t0WWR2Z3kwTXk4aWdwZWlCZGxYT2RlOEQvOUtwOGowR09vTFYxS3RrQzA4?=
 =?utf-8?B?c2JqMkFMRXlIMU90Nmh4ZmxHTG9OQk8wb0d2cmg0Nk1ZOFN2QzdwWWQrMXdV?=
 =?utf-8?B?OU9zcGxPUGQ4Q2xiWHBQS1FSeGZuSFgrUmJiVStOR2dSMnhPaUVtNUVyRUZ3?=
 =?utf-8?B?YzhSRTQyMkJRNGs1OWlPUS8rMGFjdEo1MjRQaFo1UExCdlhEWWVxejRLVlp1?=
 =?utf-8?B?aXBySHRZVzl1cEFWa0ZYQWNnTUxaaldPczRHbjc5ZTdIS01tQ0ZrWms5Q2Y4?=
 =?utf-8?Q?Q0CGWO0rvYhzQaDcasT8hP0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64eb021-257c-4be2-32a8-08d9f27af007
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 01:06:47.8133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qo5q9AkVpQ9CcQLCb/tFUVb7AL3GtfmWjWqQe0RqFesFgTFO1viSJpQfc6N7iEpdoqEJYygvjA9qUa86wwNdnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/16/22 08:31, Lee Jones wrote:
> Good afternoon,
...
> I managed to seemingly bisect the issue down to commit:
> 
>    60263d5889e6d ("iomap: fall back to buffered writes for invalidation failures")
> 
> Although it appears to be the belief of the Filesystem community that
> this is likely not the cause of the issue and should therefore not be
> reverted.

They are correct in this matter, imho. :)

...
> Darrick seems to suggest that:
> 
>    "The BUG report came from page_buffers failing to find any buffer heads
>     attached to the page."

Yes. And looking at the pair of backtraces below, this looks very much
like another aspect of the "get_user_pages problem" [1], originally
described in Jan Kara's 2018 email [2].

I'm getting close to posting an RFC for the direct IO conversion to
FOLL_PIN, but even after that, various parts of the kernel (reclaim,
filesystems/block layer) still need to be changed so as to use
page_maybe_dma_pinned() to help avoid this problem. There's a bit
more than that, actually.


[1] https://lwn.net/Articles/753027/

[2] https://www.spinics.net/lists/linux-mm/msg142700.html


thanks,
-- 
John Hubbard
NVIDIA

> 
> If the reproducer, also massively stripped down from the original
> report, would be of any use to you, it can be found further down at
> [2].
> 
> I don't how true this is, but it is my current belief that user-space
> should not be able to force the kernel to BUG.  This seems to be a
> temporary DoS issue.  So although not a critically serious security
> problem involved memory leakage or data corruption, it could
> potentially cause a nuisance if not rectified.
> 
> Any well meaning help with this would be gratefully received.
> 
> Kind regards,
> Lee
> 
> [0] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsyzkaller.appspot.com%2Fbug%3Fextid%3D41c966bf0729a530bd8d&amp;data=04%7C01%7Cjhubbard%40nvidia.com%7C107e857de4b940fbe7e708d9f169d4a8%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637806259852035011%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=5oD2%2BB9iOOSqSh3xwLLzR1vFxqyMtYNivJVQmepj2ww%3D&amp;reserved=0
> 
> [1]
> [   15.200920] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!
> [   15.215877] File: /syzkaller.IsS3Yc/0/bus PID: 1497 Comm: repro
> [   16.718970] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!
> [   16.734250] File: /syzkaller.IsS3Yc/5/bus PID: 1512 Comm: repro
> [   17.013871] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!
> [   17.028193] File: /syzkaller.IsS3Yc/6/bus PID: 1515 Comm: repro
> [   17.320498] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!
> [   17.336115] File: /syzkaller.IsS3Yc/7/bus PID: 1518 Comm: repro
> [   17.617921] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!
> [   17.633063] File: /syzkaller.IsS3Yc/8/bus PID: 1521 Comm: repro
> [   18.527260] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!
> [   18.544236] File: /syzkaller.IsS3Yc/11/bus PID: 1530 Comm: repro
> [   18.810347] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!
> [   18.824721] File: /syzkaller.IsS3Yc/12/bus PID: 1533 Comm: repro
> [   19.099315] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!
> [   19.114151] File: /syzkaller.IsS3Yc/13/bus PID: 1536 Comm: repro
> [   19.403882] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!
> [   19.418467] File: /syzkaller.IsS3Yc/14/bus PID: 1539 Comm: repro
> [   19.703934] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!
> [   19.718400] File: /syzkaller.IsS3Yc/15/bus PID: 1542 Comm: repro
> [   26.533129] ------------[ cut here ]------------
> [   26.540473] WARNING: CPU: 1 PID: 1612 at fs/ext4/inode.c:3576 ext4_set_page_dirty+0xaf/0xc0
> [   26.553171] Modules linked in:
> [   26.557354] CPU: 1 PID: 1612 Comm: repro Not tainted 5.16.0+ #169
> [   26.565238] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [   26.576182] RIP: 0010:ext4_set_page_dirty+0xaf/0xc0
> [   26.583077] Code: 4c 89 ff e8 e3 86 e7 ff 49 f7 07 00 20 00 00 74 19 4c 89 ff 5b 41 5e 41 5f e9 8d 05 f0 ff 48 83 c0 ff 48 89 c3 e9 76 ff ff ff <0f> 0b eb e3 48 83 c0 ff 48 89 c3 eb 9e 0f 0b eb b8 55 48 89 e5 41
> [   26.607402] RSP: 0018:ffff88810f4ffa10 EFLAGS: 00010246
> [   26.614646] RAX: ffffea00043bc687 RBX: ffffea00043bc680 RCX: ffffffff9913f86d
> [   26.625115] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: ffffea00043bc680
> [   26.635137] RBP: 0000000000000400 R08: dffffc0000000000 R09: fffff940008778d1
> [   26.644923] R10: fffff940008778d1 R11: 0000000000000000 R12: ffff88810e14c000
> [   26.654807] R13: ffffea00043bc680 R14: ffffea00043bc688 R15: ffffea00043bc680
> [   26.664812] FS:  00007f27c16d6640(0000) GS:ffff8883ef440000(0000) knlGS:0000000000000000
> [   26.676238] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   26.684212] CR2: 000000000049b3a8 CR3: 000000010f7a6005 CR4: 0000000000370ee0
> [   26.693896] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   26.703778] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   26.714238] Call Trace:
> [   26.717987]  <TASK>
> [   26.721105]  folio_mark_dirty+0x72/0xa0
> [   26.726455]  set_page_dirty_lock+0x4a/0x70
> [   26.732426]  unpin_user_pages_dirty_lock+0x101/0x1d0
> [   26.739369]  process_vm_rw_single_vec+0x2f4/0x3c0
> [   26.745707]  ? process_vm_rw+0x4d0/0x4d0
> [   26.751454]  ? mm_access+0xe1/0x120
> [   26.756495]  process_vm_rw+0x2fd/0x4d0
> [   26.762431]  ? __ia32_sys_process_vm_writev+0x80/0x80
> [   26.769780]  ? preempt_count_sub+0xf/0xc0
> [   26.775021]  ? folio_add_lru+0xea/0x110
> [   26.780260]  ? preempt_count_sub+0xf/0xc0
> [   26.786062]  ? _raw_spin_unlock+0x2e/0x50
> [   26.791676]  ? __handle_mm_fault+0x14a7/0x1970
> [   26.797550]  ? handle_mm_fault+0x1d0/0x1d0
> [   26.802981]  ? up_read+0x6f/0x180
> [   26.807430]  ? down_read_trylock+0x13f/0x190
> [   26.813252]  ? down_write_trylock+0x130/0x130
> [   26.818935]  ? handle_mm_fault+0x160/0x1d0
> [   26.824454]  ? do_kern_addr_fault+0x130/0x130
> [   26.830695]  __x64_sys_process_vm_writev+0x71/0x80
> [   26.837270]  do_syscall_64+0x43/0x90
> [   26.842134]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   26.848994] RIP: 0033:0x44c849
> [   26.853311] Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> [   26.877911] RSP: 002b:00007f27c16d6168 EFLAGS: 00000216 ORIG_RAX: 0000000000000137
> [   26.887953] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000044c849
> [   26.897571] RDX: 0000000000000001 RSI: 0000000020c22000 RDI: 0000000000000076
> [   26.907068] RBP: 00007f27c16d61a0 R08: 0000000000000001 R09: 0000000000000000
> [   26.916433] R10: 0000000020c22fa0 R11: 0000000000000216 R12: 00007ffd3062431e
> [   26.927113] R13: 00007ffd3062431f R14: 0000000000000000 R15: 00007f27c16d6640
> [   26.936755]  </TASK>
> [   26.939785] ---[ end trace 42b5bb79157828eb ]---
> [   27.160243] ------------[ cut here ]------------
> [   27.166572] kernel BUG at fs/ext4/inode.c:2620!
> [   27.173362] invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> [   27.180459] CPU: 1 PID: 1616 Comm: repro Tainted: G        W         5.16.0+ #169
> [   27.190304] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [   27.201112] RIP: 0010:mpage_prepare_extent_to_map+0x573/0x580
> [   27.208692] Code: 08 14 00 00 00 00 65 48 8b 04 25 28 00 00 00 48 3b 84 24 40 01 00 00 75 15 89 d8 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 <0f> 0b 0f 0b e8 04 39 15 01 0f 1f 40 00 55 48 89 e5 41 57 41 56 41
> [   27.232612] RSP: 0018:ffff88810f7e6b60 EFLAGS: 00010246
> [   27.239348] RAX: ffffea00043b4fc7 RBX: 0000000000000067 RCX: ffffffff9913ea61
> [   27.248720] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: ffffea00043b4fc0
> [   27.257899] RBP: ffff88810f7e6cf0 R08: dffffc0000000000 R09: fffff940008769f9
> [   27.266846] R10: fffff940008769f9 R11: 0000000000000000 R12: 0000000000000000
> [   27.276050] R13: ffff88810f7e6be0 R14: ffffea00043b4fc0 R15: ffff88810f7e6f58
> [   27.285119] FS:  00007f27c16d6640(0000) GS:ffff8883ef440000(0000) knlGS:0000000000000000
> [   27.295466] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   27.302935] CR2: 0000000020002002 CR3: 000000010cb70006 CR4: 0000000000370ee0
> [   27.312837] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   27.322697] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   27.332451] Call Trace:
> [   27.336060]  <TASK>
> [   27.339164]  ? ext4_iomap_swap_activate+0x10/0x10
> [   27.346171]  ? preempt_count_sub+0xf/0xc0
> [   27.352456]  ? page_writeback_cpu_online+0x1f0/0x1f0
> [   27.359598]  ? ext4_init_io_end+0x18/0x90
> [   27.365427]  ? kmem_cache_alloc+0xf2/0x200
> [   27.371638]  ext4_writepages+0x823/0x1c50
> [   27.377047]  ? kernel_text_address+0xa8/0xc0
> [   27.382587]  ? unwind_get_return_address+0x25/0x40
> [   27.388649]  ? __rcu_read_unlock+0x8d/0x320
> [   27.394134]  ? __rcu_read_lock+0x20/0x20
> [   27.399094]  ? preempt_count_sub+0xf/0xc0
> [   27.404220]  ? ext4_readpage+0x110/0x110
> [   27.409494]  ? stack_trace_save+0x120/0x120
> [   27.414838]  ? __is_insn_slot_addr+0x58/0x60
> [   27.420186]  ? kernel_text_address+0xa8/0xc0
> [   27.425531]  ? __kernel_text_address+0x9/0x40
> [   27.431355]  ? unwind_get_return_address+0x25/0x40
> [   27.437415]  ? stack_trace_save+0xdb/0x120
> [   27.442722]  ? stack_trace_snprint+0xc0/0xc0
> [   27.448310]  do_writepages+0x20b/0x3a0
> [   27.453245]  ? __kasan_slab_alloc+0x43/0xb0
> [   27.458532]  ? filter_irq_stacks+0x3d/0x80
> [   27.463792]  ? __writepage+0xb0/0xb0
> [   27.468366]  ? __iomap_dio_rw+0x1c2/0xec0
> [   27.473579]  ? iomap_dio_rw+0x5/0x30
> [   27.478152]  ? ext4_file_write_iter+0x8a8/0xde0
> [   27.484091]  ? do_iter_readv_writev+0x2ce/0x360
> [   27.490002]  ? do_iter_write+0x109/0x370
> [   27.495400]  ? iter_file_splice_write+0x4b6/0x770
> [   27.501658]  ? direct_splice_actor+0x7b/0x90
> [   27.507225]  ? splice_direct_to_actor+0x309/0x570
> [   27.513487]  ? do_splice_direct+0x172/0x230
> [   27.519352]  ? do_sendfile+0x567/0x960
> [   27.524605]  ? __x64_sys_sendfile64+0x104/0x150
> [   27.531035]  ? do_syscall_64+0x43/0x90
> [   27.536259]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   27.543606]  ? do_syscall_64+0x43/0x90
> [   27.548942]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   27.556281]  ? _raw_spin_lock+0x120/0x120
> [   27.561984]  ? __ext4_handle_dirty_metadata+0x22d/0x510
> [   27.569186]  filemap_write_and_wait_range+0x200/0x230
> [   27.576185]  ? filemap_range_needs_writeback+0x400/0x400
> [   27.583632]  ? ext4_mark_iloc_dirty+0x66c/0x6b0
> [   27.589986]  ? kmem_cache_alloc_trace+0xe7/0x230
> [   27.596373]  ? __iomap_dio_rw+0x1c2/0xec0
> [   27.601967]  __iomap_dio_rw+0x525/0xec0
> [   27.609616]  ? jbd2_journal_stop+0x481/0x5b0
> [   27.615606]  ? iomap_dio_complete+0x2a0/0x2a0
> [   27.622054]  ? generic_update_time+0xde/0x130
> [   27.628225]  ? __mnt_drop_write_file+0xd/0x60
> [   27.634306]  ? file_update_time+0x1cd/0x210
> [   27.640161]  ? kernel_text_address+0xa8/0xc0
> [   27.646114]  ? file_remove_privs+0x2b0/0x2b0
> [   27.652278]  iomap_dio_rw+0x5/0x30
> [   27.657149]  ext4_file_write_iter+0x8a8/0xde0
> [   27.663323]  ? ext4_file_read_iter+0x1e0/0x1e0
> [   27.669800]  ? ____kasan_kmalloc+0xd1/0xf0
> [   27.675676]  ? direct_splice_actor+0x7b/0x90
> [   27.681778]  ? splice_direct_to_actor+0x309/0x570
> [   27.688357]  ? do_splice_direct+0x172/0x230
> [   27.694256]  ? do_sendfile+0x567/0x960
> [   27.699605]  ? __x64_sys_sendfile64+0x104/0x150
> [   27.706129]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   27.713462]  do_iter_readv_writev+0x2ce/0x360
> [   27.719894]  ? generic_file_rw_checks+0xd0/0xd0
> [   27.726446]  ? memcpy+0x3c/0x60
> [   27.731234]  ? security_file_permission+0x47/0x270
> [   27.738026]  do_iter_write+0x109/0x370
> [   27.743417]  iter_file_splice_write+0x4b6/0x770
> [   27.749824]  ? splice_from_pipe+0x170/0x170
> [   27.755630]  ? generic_file_splice_read+0x2d0/0x380
> [   27.765041]  ? splice_shrink_spd+0x40/0x40
> [   27.770668]  ? is_mmconf_reserved+0x240/0x240
> [   27.776487]  ? kcalloc+0x1b/0x20
> [   27.780737]  ? splice_from_pipe+0x170/0x170
> [   27.786278]  direct_splice_actor+0x7b/0x90
> [   27.791885]  splice_direct_to_actor+0x309/0x570
> [   27.797680]  ? do_splice_direct+0x230/0x230
> [   27.803067]  ? pipe_to_sendpage+0x1b0/0x1b0
> [   27.808395]  ? security_file_permission+0x47/0x270
> [   27.814761]  do_splice_direct+0x172/0x230
> [   27.819842]  ? splice_direct_to_actor+0x570/0x570
> [   27.825936]  ? security_file_permission+0x47/0x270
> [   27.832354]  do_sendfile+0x567/0x960
> [   27.837426]  ? do_pwritev+0x3d0/0x3d0
> [   27.842258]  ? __se_sys_futex+0x1b1/0x2c0
> [   27.847619]  ? restore_fpregs_from_fpstate+0xc4/0x190
> [   27.854277]  __x64_sys_sendfile64+0x104/0x150
> [   27.859919]  ? __ia32_sys_sendfile+0x170/0x170
> [   27.865622]  ? switch_fpu_return+0x97/0x120
> [   27.871204]  do_syscall_64+0x43/0x90
> [   27.875661]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   27.882673] RIP: 0033:0x44c849
> [   27.887077] Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> [   27.911882] RSP: 002b:00007f27c16d6178 EFLAGS: 00000203 ORIG_RAX: 0000000000000028
> [   27.921306] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000044c849
> [   27.930587] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
> [   27.939877] RBP: 00007f27c16d61a0 R08: 0000000000000000 R09: 0000000000000000
> [   27.949975] R10: 0000000080000005 R11: 0000000000000203 R12: 00007ffd3062431e
> [   27.959298] R13: 00007ffd3062431f R14: 0000000000000000 R15: 00007f27c16d6640
> [   27.968616]  </TASK>
> [   27.971668] Modules linked in:
> [   27.975922] ---[ end trace 42b5bb79157828ec ]---
> [   27.982710] RIP: 0010:mpage_prepare_extent_to_map+0x573/0x580
> [   27.990558] Code: 08 14 00 00 00 00 65 48 8b 04 25 28 00 00 00 48 3b 84 24 40 01 00 00 75 15 89 d8 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 <0f> 0b 0f 0b e8 04 39 15 01 0f 1f 40 00 55 48 89 e5 41 57 41 56 41
> [   28.015009] RSP: 0018:ffff88810f7e6b60 EFLAGS: 00010246
> [   28.021763] RAX: ffffea00043b4fc7 RBX: 0000000000000067 RCX: ffffffff9913ea61
> [   28.031325] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: ffffea00043b4fc0
> [   28.040622] RBP: ffff88810f7e6cf0 R08: dffffc0000000000 R09: fffff940008769f9
> [   28.050140] R10: fffff940008769f9 R11: 0000000000000000 R12: 0000000000000000
> [   28.059313] R13: ffff88810f7e6be0 R14: ffffea00043b4fc0 R15: ffff88810f7e6f58
> [   28.068502] FS:  00007f27c16d6640(0000) GS:ffff8883ef440000(0000) knlGS:0000000000000000
> [   28.079454] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   28.087279] CR2: 0000000020002002 CR3: 000000010cb70006 CR4: 0000000000370ee0
> [   28.096763] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   28.105974] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> [2]
> // https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsyzkaller.appspot.com%2Fbug%3Fid%3D906354c4596539d9561ee6cb6d8c54cda38fc3c2&amp;data=04%7C01%7Cjhubbard%40nvidia.com%7C107e857de4b940fbe7e708d9f169d4a8%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637806259852035011%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=WhaMEtC2yWJva1OO%2Fp0BIYRwADAlClWQPee7Trf9DpQ%3D&amp;reserved=0
> // autogenerated by syzkaller (https://github.com/google/syzkaller)
> 
> #define _GNU_SOURCE
> 
> #include <arpa/inet.h>
> #include <dirent.h>
> #include <endian.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <net/if.h>
> #include <net/if_arp.h>
> #include <netinet/in.h>
> #include <pthread.h>
> #include <sched.h>
> #include <signal.h>
> #include <stdarg.h>
> #include <stdbool.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/ioctl.h>
> #include <sys/mount.h>
> #include <sys/prctl.h>
> #include <sys/resource.h>
> #include <sys/socket.h>
> #include <sys/stat.h>
> #include <sys/syscall.h>
> #include <sys/time.h>
> #include <sys/types.h>
> #include <sys/uio.h>
> #include <sys/wait.h>
> #include <time.h>
> #include <unistd.h>
> 
> #include <linux/capability.h>
> #include <linux/futex.h>
> #include <linux/genetlink.h>
> #include <linux/if_addr.h>
> #include <linux/if_ether.h>
> #include <linux/if_link.h>
> #include <linux/if_tun.h>
> #include <linux/in6.h>
> #include <linux/ip.h>
> #include <linux/neighbour.h>
> #include <linux/net.h>
> #include <linux/netlink.h>
> #include <linux/rtnetlink.h>
> #include <linux/tcp.h>
> #include <linux/veth.h>
> 
> static void sleep_ms(uint64_t ms)
> {
>    usleep(ms * 1000);
> }
> 
> static uint64_t current_time_ms(void)
> {
>    struct timespec ts;
>    if (clock_gettime(CLOCK_MONOTONIC, &ts))
>      exit(1);
>    return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
> }
> 
> static void use_temporary_dir(void)
> {
>    char tmpdir_template[] = "./syzkaller.XXXXXX";
>    char* tmpdir = mkdtemp(tmpdir_template);
>    if (!tmpdir)
>      exit(1);
>    if (chmod(tmpdir, 0777))
>      exit(1);
>    if (chdir(tmpdir))
>      exit(1);
> }
> 
> static void thread_start(void* (*fn)(void*), void* arg)
> {
>    pthread_t th;
>    pthread_attr_t attr;
>    pthread_attr_init(&attr);
>    pthread_attr_setstacksize(&attr, 128 << 10);
>    int i = 0;
>    for (; i < 100; i++) {
>      if (pthread_create(&th, &attr, fn, arg) == 0) {
>        pthread_attr_destroy(&attr);
>        return;
>      }
>      if (errno == EAGAIN) {
>        usleep(50);
>        continue;
>      }
>      break;
>    }
>    exit(1);
> }
> 
> typedef struct {
>    int state;
> } event_t;
> 
> static void event_init(event_t* ev)
> {
>    ev->state = 0;
> }
> 
> static void event_reset(event_t* ev)
> {
>    ev->state = 0;
> }
> 
> static void event_set(event_t* ev)
> {
>    if (ev->state)
>      exit(1);
>    __atomic_store_n(&ev->state, 1, __ATOMIC_RELEASE);
>    syscall(SYS_futex, &ev->state, FUTEX_WAKE | FUTEX_PRIVATE_FLAG, 1000000);
> }
> 
> static void event_wait(event_t* ev)
> {
>    while (!__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
>      syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, 0);
> }
> 
> static int event_isset(event_t* ev)
> {
>    return __atomic_load_n(&ev->state, __ATOMIC_ACQUIRE);
> }
> 
> static int event_timedwait(event_t* ev, uint64_t timeout)
> {
>    uint64_t start = current_time_ms();
>    uint64_t now = start;
>    for (;;) {
>      uint64_t remain = timeout - (now - start);
>      struct timespec ts;
>      ts.tv_sec = remain / 1000;
>      ts.tv_nsec = (remain % 1000) * 1000 * 1000;
>      syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, &ts);
>      if (__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
>        return 1;
>      now = current_time_ms();
>      if (now - start > timeout)
>        return 0;
>    }
> }
> 
> #define IFLA_IPVLAN_FLAGS 2
> #define IPVLAN_MODE_L3S 2
> #undef IPVLAN_F_VEPA
> #define IPVLAN_F_VEPA 2
> 
> #define TUN_IFACE "syz_tun"
> #define LOCAL_MAC 0xaaaaaaaaaaaa
> #define REMOTE_MAC 0xaaaaaaaaaabb
> #define LOCAL_IPV4 "172.20.20.170"
> #define REMOTE_IPV4 "172.20.20.187"
> #define LOCAL_IPV6 "fe80::aa"
> #define REMOTE_IPV6 "fe80::bb"
> 
> #define IFF_NAPI 0x0010
> 
> #define DEVLINK_FAMILY_NAME "devlink"
> 
> #define DEVLINK_CMD_PORT_GET 5
> #define DEVLINK_ATTR_BUS_NAME 1
> #define DEVLINK_ATTR_DEV_NAME 2
> #define DEVLINK_ATTR_NETDEV_NAME 7
> 
> #define DEV_IPV4 "172.20.20.%d"
> #define DEV_IPV6 "fe80::%02x"
> #define DEV_MAC 0x00aaaaaaaaaa
> 
> #define WG_GENL_NAME "wireguard"
> enum wg_cmd {
>    WG_CMD_GET_DEVICE,
>    WG_CMD_SET_DEVICE,
> };
> enum wgdevice_attribute {
>    WGDEVICE_A_UNSPEC,
>    WGDEVICE_A_IFINDEX,
>    WGDEVICE_A_IFNAME,
>    WGDEVICE_A_PRIVATE_KEY,
>    WGDEVICE_A_PUBLIC_KEY,
>    WGDEVICE_A_FLAGS,
>    WGDEVICE_A_LISTEN_PORT,
>    WGDEVICE_A_FWMARK,
>    WGDEVICE_A_PEERS,
> };
> enum wgpeer_attribute {
>    WGPEER_A_UNSPEC,
>    WGPEER_A_PUBLIC_KEY,
>    WGPEER_A_PRESHARED_KEY,
>    WGPEER_A_FLAGS,
>    WGPEER_A_ENDPOINT,
>    WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
>    WGPEER_A_LAST_HANDSHAKE_TIME,
>    WGPEER_A_RX_BYTES,
>    WGPEER_A_TX_BYTES,
>    WGPEER_A_ALLOWEDIPS,
>    WGPEER_A_PROTOCOL_VERSION,
> };
> enum wgallowedip_attribute {
>    WGALLOWEDIP_A_UNSPEC,
>    WGALLOWEDIP_A_FAMILY,
>    WGALLOWEDIP_A_IPADDR,
>    WGALLOWEDIP_A_CIDR_MASK,
> };
> 
> #define MAX_FDS 30
> 
> #define XT_TABLE_SIZE 1536
> #define XT_MAX_ENTRIES 10
> 
> struct xt_counters {
>    uint64_t pcnt, bcnt;
> };
> 
> struct ipt_getinfo {
>    char name[32];
>    unsigned int valid_hooks;
>    unsigned int hook_entry[5];
>    unsigned int underflow[5];
>    unsigned int num_entries;
>    unsigned int size;
> };
> 
> struct ipt_get_entries {
>    char name[32];
>    unsigned int size;
>    uint64_t entrytable[XT_TABLE_SIZE / sizeof(uint64_t)];
> };
> 
> struct ipt_replace {
>    char name[32];
>    unsigned int valid_hooks;
>    unsigned int num_entries;
>    unsigned int size;
>    unsigned int hook_entry[5];
>    unsigned int underflow[5];
>    unsigned int num_counters;
>    struct xt_counters* counters;
>    uint64_t entrytable[XT_TABLE_SIZE / sizeof(uint64_t)];
> };
> 
> struct ipt_table_desc {
>    const char* name;
>    struct ipt_getinfo info;
>    struct ipt_replace replace;
> };
> 
> #define IPT_BASE_CTL 64
> #define IPT_SO_SET_REPLACE (IPT_BASE_CTL)
> #define IPT_SO_GET_INFO (IPT_BASE_CTL)
> #define IPT_SO_GET_ENTRIES (IPT_BASE_CTL + 1)
> 
> struct arpt_getinfo {
>    char name[32];
>    unsigned int valid_hooks;
>    unsigned int hook_entry[3];
>    unsigned int underflow[3];
>    unsigned int num_entries;
>    unsigned int size;
> };
> 
> struct arpt_get_entries {
>    char name[32];
>    unsigned int size;
>    uint64_t entrytable[XT_TABLE_SIZE / sizeof(uint64_t)];
> };
> 
> struct arpt_replace {
>    char name[32];
>    unsigned int valid_hooks;
>    unsigned int num_entries;
>    unsigned int size;
>    unsigned int hook_entry[3];
>    unsigned int underflow[3];
>    unsigned int num_counters;
>    struct xt_counters* counters;
>    uint64_t entrytable[XT_TABLE_SIZE / sizeof(uint64_t)];
> };
> 
> #define ARPT_BASE_CTL 96
> #define ARPT_SO_SET_REPLACE (ARPT_BASE_CTL)
> #define ARPT_SO_GET_INFO (ARPT_BASE_CTL)
> #define ARPT_SO_GET_ENTRIES (ARPT_BASE_CTL + 1)
> 
> static void loop();
> 
> static int wait_for_loop(int pid)
> {
>    if (pid < 0)
>      exit(1);
>    int status = 0;
>    while (waitpid(-1, &status, __WALL) != pid) {
>    }
>    return WEXITSTATUS(status);
> }
> 
> static int do_sandbox_none(void)
> {
>    if (unshare(CLONE_NEWPID)) {
>    }
>    int pid = fork();
>    if (pid != 0)
>      return wait_for_loop(pid);
> 
>    if (unshare(CLONE_NEWNET)) {
>    }
>    loop();
>    exit(1);
> }
> 
> #define FS_IOC_SETFLAGS _IOW('f', 2, long)
> static void remove_dir(const char* dir)
> {
>    int iter = 0;
>    DIR* dp = 0;
> retry:
>    while (umount2(dir, MNT_DETACH | UMOUNT_NOFOLLOW) == 0) {
>    }
>    dp = opendir(dir);
>    if (dp == NULL) {
>      if (errno == EMFILE) {
>        exit(1);
>      }
>      exit(1);
>    }
>    struct dirent* ep = 0;
>    while ((ep = readdir(dp))) {
>      if (strcmp(ep->d_name, ".") == 0 || strcmp(ep->d_name, "..") == 0)
>        continue;
>      char filename[FILENAME_MAX];
>      snprintf(filename, sizeof(filename), "%s/%s", dir, ep->d_name);
>      while (umount2(filename, MNT_DETACH | UMOUNT_NOFOLLOW) == 0) {
>      }
>      struct stat st;
>      if (lstat(filename, &st))
>        exit(1);
>      if (S_ISDIR(st.st_mode)) {
>        remove_dir(filename);
>        continue;
>      }
>      int i;
>      for (i = 0;; i++) {
>        if (unlink(filename) == 0)
>          break;
>        if (errno == EPERM) {
>          int fd = open(filename, O_RDONLY);
>          if (fd != -1) {
>            long flags = 0;
>            if (ioctl(fd, FS_IOC_SETFLAGS, &flags) == 0) {
>            }
>            close(fd);
>            continue;
>          }
>        }
>        if (errno == EROFS) {
>          break;
>        }
>        if (errno != EBUSY || i > 100)
>          exit(1);
>        if (umount2(filename, MNT_DETACH | UMOUNT_NOFOLLOW))
>          exit(1);
>      }
>    }
>    closedir(dp);
>    for (int i = 0;; i++) {
>      if (rmdir(dir) == 0)
>        break;
>      if (i < 100) {
>        if (errno == EPERM) {
>          int fd = open(dir, O_RDONLY);
>          if (fd != -1) {
>            long flags = 0;
>            if (ioctl(fd, FS_IOC_SETFLAGS, &flags) == 0) {
>            }
>            close(fd);
>            continue;
>          }
>        }
>        if (errno == EROFS) {
>          break;
>        }
>        if (errno == EBUSY) {
>          if (umount2(dir, MNT_DETACH | UMOUNT_NOFOLLOW))
>            exit(1);
>          continue;
>        }
>        if (errno == ENOTEMPTY) {
>          if (iter < 100) {
>            iter++;
>            goto retry;
>          }
>        }
>      }
>      exit(1);
>    }
> }
> 
> static void kill_and_wait(int pid, int* status)
> {
>    kill(-pid, SIGKILL);
>    kill(pid, SIGKILL);
>    for (int i = 0; i < 100; i++) {
>      if (waitpid(-1, status, WNOHANG | __WALL) == pid)
>        return;
>      usleep(1000);
>    }
>    DIR* dir = opendir("/sys/fs/fuse/connections");
>    if (dir) {
>      for (;;) {
>        struct dirent* ent = readdir(dir);
>        if (!ent)
>          break;
>        if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
>          continue;
>        char abort[300];
>        snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
>                 ent->d_name);
>        int fd = open(abort, O_WRONLY);
>        if (fd == -1) {
>          continue;
>        }
>        if (write(fd, abort, 1) < 0) {
>        }
>        close(fd);
>      }
>      closedir(dir);
>    } else {
>    }
>    while (waitpid(-1, status, __WALL) != pid) {
>    }
> }
> 
> static void close_fds()
> {
>    for (int fd = 3; fd < MAX_FDS; fd++)
>      close(fd);
> }
> 
> struct thread_t {
>    int created, call;
>    event_t ready, done;
> };
> 
> static struct thread_t threads[16];
> static void execute_call(int call);
> static int running;
> 
> static void* thr(void* arg)
> {
>    struct thread_t* th = (struct thread_t*)arg;
>    for (;;) {
>      event_wait(&th->ready);
>      event_reset(&th->ready);
>      execute_call(th->call);
>      __atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
>      event_set(&th->done);
>    }
>    return 0;
> }
> 
> static void execute_one(void)
> {
>    int i, call, thread;
>    for (call = 0; call < 10; call++) {
>      for (thread = 0; thread < (int)(sizeof(threads) / sizeof(threads[0]));
>           thread++) {
>        struct thread_t* th = &threads[thread];
>        if (!th->created) {
>          th->created = 1;
>          event_init(&th->ready);
>          event_init(&th->done);
>          event_set(&th->done);
>          thread_start(thr, th);
>        }
>        if (!event_isset(&th->done))
>          continue;
>        event_reset(&th->done);
>        th->call = call;
>        __atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
>        event_set(&th->ready);
>        event_timedwait(&th->done, 50);
>        break;
>      }
>    }
>    for (i = 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i++)
>      sleep_ms(1);
>    close_fds();
> }
> 
> static void execute_one(void);
> 
> #define WAIT_FLAGS __WALL
> 
> static void loop(void)
> {
>    int iter = 0;
>    for (;; iter++) {
>      char cwdbuf[32];
>      sprintf(cwdbuf, "./%d", iter);
>      if (mkdir(cwdbuf, 0777))
>        exit(1);
>      int pid = fork();
>      if (pid < 0)
> 	    exit(1);
>      if (pid == 0) {
>        if (chdir(cwdbuf))
>          exit(1);
>        execute_one();
>        exit(0);
>      }
>      int status = 0;
>      uint64_t start = current_time_ms();
>      for (;;) {
>         if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid) {
> 	 break;
>         }
>        sleep_ms(1);
>        if (current_time_ms() - start < 5000)
>          continue;
>        kill_and_wait(pid, &status);
>        break;
>      }
>      remove_dir(cwdbuf);
>    }
> }
> 
> uint64_t r[5] = {0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff,
>                   0xffffffffffffffff, 0x0};
> 
> void execute_call(int call)
> {
>    intptr_t res = 0;
>    switch (call) {
>    case 0:
>      memcpy((void*)0x20000080, "./bus\000", 6);
>      res = syscall(__NR_open, 0x20000080ul, 0x14d842ul, 0ul);
>      if (res != -1)
>        r[0] = res;
>      break;
>    case 1:
>      memcpy((void*)0x20000000, "/proc/self/exe\000", 15);
>      res = syscall(__NR_openat, 0xffffff9c, 0x20000000ul, 0ul, 0ul);
>      if (res != -1)
>        r[1] = res;
>      break;
>    case 2:
>      memcpy((void*)0x20002000, "./bus\000", 6);
>      res = syscall(__NR_open, 0x20002000ul, 0x143042ul, 0ul);
>      if (res != -1)
>        r[2] = res;
>      break;
>    case 3:
>      syscall(__NR_ftruncate, r[2], 0x2008002ul);
>      break;
>    case 4:
>      memcpy((void*)0x20000400, "./bus\000", 6);
>      res = syscall(__NR_open, 0x20000400ul, 0x14103eul, 0ul);
>      if (res != -1)
>        r[3] = res;
>      break;
>    case 5:
>      syscall(__NR_mmap, 0x20000000ul, 0x600000ul, 0x7ffffeul, 0x11ul, r[3], 0ul);
>      break;
>    case 6:
>      syscall(__NR_sendfile, r[0], r[1], 0ul, 0x80000005ul);
>      break;
>    case 7:
>      res = syscall(__NR_gettid);
>      if (res != -1)
>        r[4] = res;
>      break;
>    case 8:
>      *(uint64_t*)0x20c22000 = 0x2034afa4;
>      *(uint64_t*)0x20c22008 = 0x1f80;
>      *(uint64_t*)0x20c22fa0 = 0x20000080;
>      *(uint64_t*)0x20c22fa8 = 0x2034afa5;
>      syscall(__NR_process_vm_writev, r[4], 0x20c22000ul, 1ul, 0x20c22fa0ul, 1ul,
>              0ul);
>      break;
>    case 9:
>      syscall(__NR_sendfile, r[0], r[1], 0ul, 0x80000005ul);
>      break;
>    }
> }
> int main(void)
> {
>    syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
>    syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
>    syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
> 
>    use_temporary_dir();
>    do_sandbox_none();
> 
>    return 0;
> }
> 

