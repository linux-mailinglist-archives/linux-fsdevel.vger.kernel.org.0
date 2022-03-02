Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4018A4C9EE3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 09:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239987AbiCBIIM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 03:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiCBIIL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:08:11 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1141BBCAF;
        Wed,  2 Mar 2022 00:07:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuNoVaQhy1Uw9j8AUBG/5tbqW9bmKVzJNjMGVgjduuF/YmYq7gAOozlq1r97SdqcnSliuIYXlEiQErKRWrP+eKiaTNNEy1aJIBa/ZAkEEAidKqmvT2SLAU88RsAOWVahcYCwGOZj3Pg17Ljna7EiqUDiClaZbalnENYZ/H1LRXCAYj5KQK+qha9L6ezL7PdPViXpX0WucdmdCBHnKoZKbauQpDFLSVjt2w3Bzh3eX09ovBXdxx2tbYPGtAHkLHlIJA+GvEIscacTUYsSwqiAEUH4kpwC6m+6HmXdzdvRHQfT3jSssg4rqUclutRg0W/g7/GRHYFXk1qTDLkl+lD1QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spk/Dj/dDEFQoHWmIfPriB0uldXeMcMU8YZSC7gNQiA=;
 b=kz7tURwLT38PVvTujc0BjTQYVIIn6/D0epUk0ASx0Rhz1F2BXs+VbSQ8uKh+ywsuRs4bNAJJ83U3/001DbZ37T9QHRT3UXRGVM5Ml8ZBgP5p6jn6Nt0hvR9gTyNqnZxYUK9WIvGZO4FmD9X36i1nIo15wTwajmOIkPAzF1tfzScozRytWGdVs2IFMEjfZczJltvzPeuPzBYGUlQ1e9KA/UiYkJoEJFdepVvYzsZ9H7M68kKy+T2jz5MorjrqjON6JZhBpUEowF43ZId4540JjStS1l0HNwOZ4ntK/fLvdedTH0bwRzwevf2D5rJKngLsTDFPA0XKkKqpdf3EsTdEjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spk/Dj/dDEFQoHWmIfPriB0uldXeMcMU8YZSC7gNQiA=;
 b=DClJg2t+vd1+TQ7MsAgVCgjuWzCjLN20f5BDp+HUQUx5NXl2FRI31DUxBi3JXTuhlgXy0j4m77kjyJf/8hdVEpI+Hvbq24qwHd6L2yArTrNcZB/qhlsUVlhBKf2iybFYATXZ5SA6/rnznnWuYj2COtDJ6Dk+45YpulrFAXpUUNXPiDUUsT1T+tGXyC/LobsJ0Mv8uJq/T1khUM/p4wX4v/LbGKXDiEK3MfbrXDNBuFc+cDtKwuzMnFFuEnVWL/u0LTl7DCm909VASlUmCqGFDdbEW+ZGE2AwEtxOS05K6uZGIt6bt/60tgk1FZI5Q1mF7RvWC4j91zs1I7zwGERtNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BN8PR12MB3634.namprd12.prod.outlook.com (2603:10b6:408:47::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 08:07:25 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::d998:f58:66df:a70e]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::d998:f58:66df:a70e%4]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 08:07:24 +0000
Message-ID: <acbb7dd0-3727-093f-3bae-87bda8c50266@nvidia.com>
Date:   Wed, 2 Mar 2022 00:07:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 6/6] fuse: convert direct IO paths to use FOLL_PIN
Content-Language: en-US
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     jhubbard.send.patches@gmail.com, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
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
 <f0b158dc-5b01-67aa-1f49-331bf1ff2bfd@nvidia.com>
 <CAJfpegvcX4n3Ac5ekNNKGRh-cDGjSjX3CuS7+SOWvfksii-UEw@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAJfpegvcX4n3Ac5ekNNKGRh-cDGjSjX3CuS7+SOWvfksii-UEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::16) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13191337-5b1e-4c8d-c8bd-08d9fc23af3c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3634:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB36343B160E809221D69B1E3BA8039@BN8PR12MB3634.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2K+39bliQra3vs+950FAS8m9VImtVaCviROJT2nVdrvbK05Yl3fuUPq7Jht5CaedvdxoFsLVfJ10w07EwrxC+sxDCDtRuLg0CHsRIqDNzajwAHUPXGTqhQUn7ARMlS3k/Ug8jvjF/NTEnGSNwhOrXTSUUdxLL6TWyGeec/2UM7OhDzxdwe58Vs/9rvRjBazZJKTb9ytaFmpgV8ZHq90zi9Te64P5lrKYgCFeWy8eCINjt1G4ZDUeTFZUxJKbiRg32Zc3u6JTqVvymDD9rvxBbDM5LEjWevbYos6WG/6yX+T3ExdLkQ02m6MBhtU0rUdTYtKOmkCllXbjQTviVBoRZenyJQqsYY6T9FuQ2g+4ukANUO0JtmzYOIH5X2KRPbneFzUFz2I1cQJroDhHfdRxpxHpGRDhWC2w4BbTE+b9ZVHEOOh3Ko/ilgmk9twhu2PpI3Ku5ifxPkfmW7mC5OJvY3b1KZrReVGgy0S0e0CYSZUayvslko5GP1TYTY9GBys5J8axi+U0IA/MHtDnVX9jSQFcmCyJw9RUhzl+GwyaWnqhxQWcXi8L6ER60HHwNjK8ND4f+Yq+hFuP7uaR35TyVSjUJxWE8uonhi4qOnc6gK8Nlzj3h2eHkUiBzKFUYvOmsaBytPBgM1FjXsJ8iWHy+p1sPJAr9qEGYG1jMilUheaw+CFhYmwO4lcrRbVY8MKC+ysYv6jdZwVUDmVhXxXtUJ5k++e9IITa1THv9M2vJmsWchF0W5kIWCUdIknhrAt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(66476007)(6506007)(6512007)(66946007)(66556008)(38100700002)(8676002)(5660300002)(4326008)(31696002)(26005)(186003)(2616005)(83380400001)(53546011)(6916009)(316002)(6486002)(54906003)(508600001)(2906002)(8936002)(7416002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am4xK3FyeG9DUUhHMTZWc2lDVEZZWWhNeEJNSE95TGdqZjhlaTlBUDFhbURG?=
 =?utf-8?B?UFNUcDNmbjRBVDdMbjZvWkk3ZmlKSEZOL3FiZUQ2ak9vbklUa0g3a0dDOHNr?=
 =?utf-8?B?MDlFZ1gxeS9IU2V6SXVFQ2VLbDdZNGRGc2sxZENUbStlbks0T2s4WXpwZFda?=
 =?utf-8?B?M2hoeWZEYnBmT0t1eHJpNWtIakFMZXV2TU9ORFJtTDV5bHlpMWkxcDVBaWhz?=
 =?utf-8?B?Z0ZHbStnOG43UGhxbWxlT3N4aEU5UnhVUURFdVlXSXQ2OURXdkh1NFcxVWFX?=
 =?utf-8?B?WG1GUzJwVHFLYVd2QU5FQ09QM2FYc3Jnd0Vjbjd2MjF5LzN0M1RXUkErMlh4?=
 =?utf-8?B?NlFsSDRkRy81SWtvVk1JT21YcGZDY3pQT25WVm5wWUQrVFM0S056YU9BU2FK?=
 =?utf-8?B?emZsdlpUeTN5enJBelNwN2IwTkNwaTVzQmhwZU5DZ1Jnb0RjN0IzRGFCRlVh?=
 =?utf-8?B?ZmZkenpKMWl6VXUwRUJsZkl4bm9OeUlYYTZQME93a2FGN28yeDRJN0gydTNY?=
 =?utf-8?B?L3VmOHpNTkJnUnI3dHA2SzJuMzNycmtEQVdYdHVTVDIzRmhVL2tSeCt1L0lr?=
 =?utf-8?B?OTluZVY5bGFNVTRIWmp0eWY4YU9Wa2dBZFNoU2ZBSkJ5YmpPalJWQWtPTFJr?=
 =?utf-8?B?aDR6bnBXU1dNTFZBK1dZRlpQMGk3KzVNMFl4ZHgvYnlnaklWTXZzWVFid001?=
 =?utf-8?B?a3F3TzhqemtGenpWd2pnOEM4SDVYQ1VBODVKWXI5dTEvc08rOWg5ZXJvS0Np?=
 =?utf-8?B?SFRiaUVlaW5JNkdKckhQQUdUTFVFSHBnMkkwV0FjcW5rZ3hLTFdWL3VHaHYz?=
 =?utf-8?B?NU4xQVFWVHYxTkJnZ1N1MUNrMnNPcDlrc2ZKNkVXS2pBWXA1UFZwQThHL2JC?=
 =?utf-8?B?aXdqSkRzYlFvMlNGdDlkVUw3WWJ1YjFBdFJPYisrQ0x0ZmMrVGhOMGVxemJO?=
 =?utf-8?B?cEZGbWRSVkNnTTR5NXIxakc5a1c3U1M5OHhrbE10dTkxQU91NmZKdEs0eFdV?=
 =?utf-8?B?cVNreHllN1BGN2gxd3Z6eTZoWitYSmNwK1RSU201UUlBb1ZLNFhxQmI4K3g3?=
 =?utf-8?B?ZGZWaFl6dG9xMStMNnZNN1B5VjBIQVQyZm1CejBLTEt3QmJ5alpYTGh0Wkdh?=
 =?utf-8?B?Z1c5bmN2dnNCZjMyQ1ZOeUgxTkVLUStlYmw4N1VYNmlBSlZsa2o5RkVpdGt1?=
 =?utf-8?B?bW9NWVY0ckJrdzlyYzVZUmlnQ0JXMDVwTHdoQnhBdW15ejhkbTR2aGFvV1E2?=
 =?utf-8?B?Z3gweWx2b3BUMkxmY2Z4QmlsZzFNaitMMk1LRVNPZ3hQWllHUmFsS0c5L21G?=
 =?utf-8?B?cUlPeFMzcnpieW16SytWR1ZrcnVUcXo0UmdDR2JqSW0wVGpMcEYxT1UrbC96?=
 =?utf-8?B?aUNVUXdXdkxxcy9JZHZ3N2dsbWhUd21NWDlnS2Y1V2FvUjgxWVZtclIwRXI0?=
 =?utf-8?B?d1JpeU1xOElPNStaS1VnaUlpUTBnaTZMNEVRQmRpeUNDMmtXMVVQblJlbUZJ?=
 =?utf-8?B?VDRwVGt5MTFXdlRjQ0ZVR0JGQlFSMEdnU2U0YSt5RUgrYXJaR1lid3Z5ZW9M?=
 =?utf-8?B?VUJFZmJtMzc1Q0RHRU8vcGdQTmtHR2dNakJ5Q2ZoTHFOa254QUc5cVR4REhD?=
 =?utf-8?B?RktkVzZPczNWVnNIL0hXMjNrVDBtclVjdUF2UitVYVpTS2hvNEJ0dFJ6Rm1q?=
 =?utf-8?B?R3l1RnNrZDAwVlpmSDlHRS9udng5VVM2QW83NVBhMGFGY3lVcEljZTNPc3F0?=
 =?utf-8?B?Tmp6V2FtanBjYzl3ZjNpdjBjQmd4TzlhOVZyK1JWSEltVVRhdEVzUVljUWd2?=
 =?utf-8?B?WkpKNlp1OUNyQ0dLQ3dRNll3MjZHTUJUSjhpQzlhM09YckJleXNnT3RueEl6?=
 =?utf-8?B?UmRiTGFka042TWRJNUFhS1M2bVlSeGRMdU5XSGdZNkU5NDEwbkdLMVRnUzk1?=
 =?utf-8?B?N1VXbHYvZ2VVOGQzTGJVN2J3V0p4THcrNjZybXRvQnZJLytUN2hVdTNPS1Ew?=
 =?utf-8?B?VW5WQ3R3TGdiQVdNa01YQlBGQzVOQmVOOGpPemxoaW9ITFA2cXZpWVJQUnZO?=
 =?utf-8?B?WkRqcm91SUFOT1NDMHBKZllWZHhPNHpQajRycXpCZThxcXRLU2doRVBGOTFD?=
 =?utf-8?B?MlJYdVBkM1haMFdFNWlGek5LaEZ2ci9YaDdKcC9JQXZrVGxnaFlpNVc3TGho?=
 =?utf-8?Q?aqtmDb1R/zjpaNaA8HurO2M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13191337-5b1e-4c8d-c8bd-08d9fc23af3c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 08:07:24.6331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lX5Q3mAjkcnolqwe0liW9Qdwb/43Hkj1h0Vs6hh/6KoywGlBJ4YdsBS7+Z5XDqwbFWwEJGrOe2ISH8FylWsvqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3634
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

On 3/1/22 01:41, Miklos Szeredi wrote:
...
>>> This might work for O_DIRECT, but fuse has this mode of operation
>>> which turns normal "buffered" I/O into direct I/O.  And that in turn
>>> will break execve of such files.
>>>
>>> So AFAICS we need to keep kvec handing in some way.
>>>
>>
>> Thanks for bringing that up! Do you have any hints for me, to jump start
> 
> How about just leaving that special code in place?   It bypasses page
> refs and directly copies to the kernel buffer, so it should not have
> any affect on the user page code.
> 

Good idea, I'll go that direction.

>> a deeper look? And especially, sample programs that exercise this?
> 
> Here's one:

This is really helpful, exactly what I was looking for.


thanks!
-- 
John Hubbard
NVIDIA

> # uncomment as appropriate:
> #sudo dnf install fuse3-devel
> #sudo apt install libfuse3-dev
> 
> cat <<EOF > fuse-dio-exec.c
> #define FUSE_USE_VERSION 31
> #include <fuse.h>
> #include <errno.h>
> #include <unistd.h>
> 
> static const char *filename = "/bin/true";
> 
> static int test_getattr(const char *path, struct stat *stbuf,
>               struct fuse_file_info *fi)
> {
>      return lstat(filename, stbuf) == -1 ? -errno : 0;
> }
> 
> static int test_open(const char *path, struct fuse_file_info *fi)
> {
>      int res;
> 
>      res = open(filename, fi->flags);
>      if (res == -1)
>          return -errno;
> 
>      fi->fh = res;
>      fi->direct_io = 1;
>      return 0;
> }
> 
> static int test_read(const char *path, char *buf, size_t size, off_t offset,
>                struct fuse_file_info *fi)
> {
>      int res = pread(fi->fh, buf, size, offset);
>      return res == -1 ? -errno : res;
> }
> 
> static int test_release(const char *path, struct fuse_file_info *fi)
> {
>      close(fi->fh);
>      return 0;
> }
> 
> static const struct fuse_operations test_oper = {
>      .getattr    = test_getattr,
>      .open        = test_open,
>      .release    = test_release,
>      .read        = test_read,
> };
> 
> int main(int argc, char *argv[])
> {
>      return fuse_main(argc, argv, &test_oper, NULL);
> }
> EOF
> 
> gcc -W fuse-dio-exec.c `pkg-config fuse3 --cflags --libs` -o fuse-dio-exec
> touch /tmp/true
> 
> #run test:
> ./fuse-dio-exec /tmp/true
> /tmp/true
> umount /tmp/true
