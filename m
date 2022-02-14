Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4554B4254
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 08:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbiBNHCU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 02:02:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240580AbiBNHCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:02:18 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342C34F9DA
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Feb 2022 23:02:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhXYrt9edHuvQamA4718KwrtrTbCJi+uSqqsokKhMxh+9eek7ypjV3AMnaIPwDpPAfCLWVpfV4+wGPApCwLsf+VF3I5v1fwdOGKLgk1VoSCi6WI/pnRsYa9f4toCphC2aMJKDULQh3CNxOaanxAioe4cl6RFo/dZZ/j+BEWiuFQuHQ3OtH9JO2OMeP5segFMG6wdtO2HZpy4M/8k2Bpwov8rzk/+Rinv1HfXnFDA9SkceZK87X71FINTbNuprKl0LjNNDqDdNOiiDXf1udruPbXO2nl9irAANZL9+UqtEHrtH2Osz8hAIWZYjDkjNc7wGJTYcmlUGj4NnP0keuVrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgpG7jK5mbznFe+/sV5GF5xw1gi75a2VuoXONkzZhLY=;
 b=anez8QktYFYg+kGOFr7bl4aJ/CdLJo/Bxxs4OEA7lgkc2qFnMfv98OL0JSy3FoFDthoZC04VZm16jQK7wrD/pZhOa9nc4A/gq8WV07hVc6ZxFGDCeF0BQiMp7XrLDqKeamCIMsnUMleUOczjEr5Y9PHKX9FUMcX8TSgnjCuTIz5qbqQxj7zbdnLb1m4TZQD901uR9kPCbloUAgIDIYrJFbwBn42uC6IBe6Bd8p448qwuhEn4I6dM1MvPcugZYGPjYCYxNk/OSNqVtAjr9zOydLhZ8VXuKdPwWenfNum8dIwL4XwKzfbzQ64ZWq5KlXmsMsMGmCja5mAjR24WglypQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgpG7jK5mbznFe+/sV5GF5xw1gi75a2VuoXONkzZhLY=;
 b=O+Gn/vpZPu0gITkMJHp937CF9C54Ta1IHKQe6j56+J78Kt4y7Lz3wVnkSQjWCiMUcEeyE7AQxs9oS+SmfBbj0O+HCbTf5syJK8Ytr34saJkCMCvdKUuGbrauVljmJlfZf9OMiqMGaKidU1pGIo0BM46cHgm5gCy4JcbVLgA+46ngAgrDWSs6wC3IJG9p1mBViAp2xjmHBF9nuh6b6iHi/ENQVup7SpLJxz14Wg+N9joDfZjOod2jxz1uRhDVBwRPnF8tE0yc7jf2Iyd2kv37t5aZ59OOjyLVO3gi46dgg5Iv/MzuNLMkvtsN5HRIFPcXS1O8r4aNrqfccij4sFUVzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BN6PR12MB1298.namprd12.prod.outlook.com (2603:10b6:404:17::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Mon, 14 Feb
 2022 07:02:09 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%5]) with mapi id 15.20.4975.014; Mon, 14 Feb 2022
 07:02:09 +0000
Message-ID: <916059c1-548e-fd29-92b6-f4384d07b29f@nvidia.com>
Date:   Sun, 13 Feb 2022 23:02:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 42/56] fscache: Convert fscache_set_page_dirty() to
 fscache_dirty_folio()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <20220209202215.2055748-1-willy@infradead.org>
 <20220209202215.2055748-43-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220209202215.2055748-43-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:a03:100::36) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b52c968-6b92-454b-8c9d-08d9ef87eb11
X-MS-TrafficTypeDiagnostic: BN6PR12MB1298:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1298C76FC5833A5C8C892148A8339@BN6PR12MB1298.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0rlai+ytLigpxQFOrrbxmio19cUxDO3iZ0ujUAHo6JaqhV5ccuVlhKafACFA3tl7+Dcfi+/MBiHs6xDTPoOiiNUbPvG4koPtrdFuoSW81lsE96mNMGloZsNiFEOySQqYf7uQDGFW28cfcNZlDZyS6xfquHw22KNEChDtKjYa0MAhe0O2epenYhiWUkNeSAzQdzhrznTlla4BkAfSjZRHyvcUKtNqa4YHJg1YI4AbeDqk6+wBHG4nDPjosAkg8UDxoeOQjznB17d0dIVzlmZHN5ppI0b1CodkK4JvS/DcCz16gEnDP1VMwT2JxM7Qe79x3WedNNpbJ+Nf62eGR90JYT7Mf70mqc9QOUNBfqlYgeYFUyBGkX9Kn0nGgxyckx6jLFKrElavPzrmDuXmv7Y5IukNJD8Pb7Jla2vPcEWTb7S1VFZoZQkWon2nPMMBSt0Us7WuZJaoUuXrWM49PeVb3ZiOwKr+jm6ft56AL3Z1i7D8x0/fFBfUp/XGMH5KWH1uWeAo9FCQhnismDRzYFeEfCPaWWmYAvU3Uf2t2HYXHvhvWAsvhClsxIE46BkcQysKNzcnZluG6dilsbTAqqmIiHktB9HGcW2THA2Gd3WVXA9jl6pXdtpSV6xrf9nfPZNS6SvoWjugEuVvsn7sKzEQTd8UWKozm4lWktTn7fRMV9Yh1ll9fgOgZWJIBVD0T8cshkdUA7z/G3PiHrM+BPNs2zTQ198FBB6hIVt7MXJx18xkCQ4WP5XfO15VNHYPX/wKuw40VroGasGQMBbXPCZjYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(31686004)(26005)(2616005)(6512007)(53546011)(6666004)(6506007)(508600001)(6486002)(316002)(66476007)(66556008)(66946007)(186003)(5660300002)(8936002)(2906002)(8676002)(38100700002)(86362001)(31696002)(36756003)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVhXOFRMSG5XYVBQeDV3VzBEQ2krU21rMThUOG9zbEt5MW4zMTdWSXZFQjJv?=
 =?utf-8?B?Qm92L2h1RUdWNmtFU3hoZk1JWmY5bG42SXFhWjhxaWFvSjF0VDNYVkJ0N21U?=
 =?utf-8?B?WElSMHVmSHBMNUVvN2dWc2ZZUWgwL3ZHZkZvUHpZT09ueXNrUG1LL3VBME1w?=
 =?utf-8?B?anZKTGU2UXl4WnRUeGJRTTFMVHkza2lDcW1FUml2aC9tcE1kVEFxL2djUFlm?=
 =?utf-8?B?Z2V5dnNNYnZFQzJVSVBLb3Jla3pBNUZ0MEhFZjFGaG1qM09SbjkzZjYzeUNO?=
 =?utf-8?B?QWFwN0VvbEVlcjF5S0k2T0gvY3FEV0N5c2Y4VEg0SVB6UnpOZ0oweDdKdmw3?=
 =?utf-8?B?dHdFanRLcGlTL0F0Mnp0MVRXQlpLQ3ZOTzZCUkd1L0RHQUI1Y2xjUTNsVXFy?=
 =?utf-8?B?VEc4RTdJWGJ0UGMzZm1KeVRYL05TUW9ZdXJDK0RqMjBuSkdHa2VRdEdYOGdv?=
 =?utf-8?B?WTRpVlFPc0w3elQyclpXTUErd2pUQm1pQ09NNzV4eGxWMERBWEVGK2RhUUJH?=
 =?utf-8?B?cWRMTWRKaEFwYStQR3I3bllNbGsxMGh2OWVOdWNCb3VteDRmZHNLNmpIVEFi?=
 =?utf-8?B?T1Z5NHNtZW5RYWp6TDdvdFpPaFVSNDB5U3c5MDBuZDNyY0E2clVyc0VhbUEz?=
 =?utf-8?B?c094RE9URGRmU1N0V2JnM280Q2o3OCtacDY1UTNDVGcvbmxIbnlDeGZVZTJG?=
 =?utf-8?B?Vy9wU3puTWkyM2taOHhLMG8yVHovbUNKQUc0STRYRWZRSkpWMDZzZzZrZDJ4?=
 =?utf-8?B?VksrclVuOSs0Rm95eENWc1IrNUorL1l2KzZSaHBhbFNwcFZhTkpGdzNxaWhJ?=
 =?utf-8?B?RWVtWWtUTjljUDZuKzBIcmtiWE9uL1Q3TDF3SWNpaEUrWjFuaEpmenFtZVQ5?=
 =?utf-8?B?YWYwbWRqeVAwZmdoaHdEVWludXg3aGsxakRZOFl2M0ozazFqL2lKMWNJelJN?=
 =?utf-8?B?M3Rud2g0b3B5RWJwTU1vS2s1dHI1ZUlHQloxS09hY1ZvbkpCb2RtTnNpbnJs?=
 =?utf-8?B?V0xWd0sxRzF2RWZIWVJOTVRPeVBBcHVvQlg1enIwcFVVcmxHTnRGWEdnUVpW?=
 =?utf-8?B?Z2VTUGJsZ2UrczJvU3NKWGQyaXBLOWt6cFlzclJoL0gxaWZsRnZYdFlOZnBD?=
 =?utf-8?B?ZGdub3BHRVdZU2Jlc3RyZENjdnBxbys5TW8rOTh4eFcwaDZyMHFQem5UUnEw?=
 =?utf-8?B?ZEJpclhXWXVwaytXMGhuZjZUSWRlWk9lZjVUS0FtY29mN1R4MGVac2RxY2c5?=
 =?utf-8?B?RDBEZHJxYWV6Y1BnRjh5S1h2QklvaW1JZGhUbDNJYVR6OVc0Y2IrZzF5eENp?=
 =?utf-8?B?UUUrUVRXaFdwU0IvQlFzQ0FSTWVrTldDRjkrWjRDSnBWYmlsQkRzdXFNK0Jt?=
 =?utf-8?B?NTVjNFgzbi9CMDlmNVR1ckdocFJ6bHBWOFJiaXM3N2IwYjZQNzdJL1haVWx6?=
 =?utf-8?B?UmFxc3hnK20rNGZKeldMaXVGdFo5T3Jld3A5S2RVMGFpNElwRUZHaS81TGJq?=
 =?utf-8?B?UTFiaUtHUysrTnZhUW0wNFh6a2hvZ1lWTExxY0dqanRLNHNOMG51dG51S0VP?=
 =?utf-8?B?VUN0L2pvc2h2SGZvYTB6QS9oUGhCdStTYXZRckh3eGkwazRRc0gzbkUyN0xO?=
 =?utf-8?B?SHBSNGJrRWF0aGxxa3pMTDY3ODhSanh4dHJydm54bTRPS2FMOHpCMlZwT0JM?=
 =?utf-8?B?NFpZRnkwOXlDNFlPdzlhd2xxN1dvZnBDUlMvLzRKSWMvV0N0bEJFNHVZLzZW?=
 =?utf-8?B?bVR3cXRWSndOZWlmL0dxRHFsY01OWENQNnJGV2p6VmM4TjVDOU5uYXRwcEI5?=
 =?utf-8?B?eUJMbkNDaFAxNFJiRXNZQlo3SzdaOXJURWhnUnloSGRySVJRZldNMWRLYmgz?=
 =?utf-8?B?alNZQjRtZHVpblhsL01DWFV5OXhXYTVmZ1hCZHhmemp4WUZHQjVVOS9VVElW?=
 =?utf-8?B?UFpacWE4R0lRby9WZzhOeDh3bVhNZVNLclUwYXpGRVJ1TTNrWVhCSUJQRGRw?=
 =?utf-8?B?bzh6NytsUURpOGFuSURhYmh1K0F1c2pYeWY5NGxvbmRqdy9IQ3VnQ09yK2h2?=
 =?utf-8?B?NklvL21YWHNVdERSVkY1TUw4dE54U1JOZXZ4djJ5UnRCMGRXeW81WVBQd3BR?=
 =?utf-8?B?UFQvZWFzUXJuRFZSRUJDUnZoMEh4WkpUM0FEeXdFWEZkbkc2eDMzeTF5R1Iz?=
 =?utf-8?Q?gfIw7n2sbw6QVYSJuJ8iVEs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b52c968-6b92-454b-8c9d-08d9ef87eb11
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 07:02:09.4929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7cAxFJqgvuuLkllX1IU6WL7jq5144aVxs+Q1irAvmHOJE76zWgX9MAWzdDoX9iFTYAAWEwi+S2LVzn6HWYgyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1298
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/9/22 12:22, Matthew Wilcox (Oracle) wrote:
> Convert all users of fscache_set_page_dirty to use fscache_dirty_folio.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   .../filesystems/caching/netfs-api.rst         |  7 +++--
>   fs/9p/vfs_addr.c                              | 10 +++----
>   fs/afs/file.c                                 |  2 +-
>   fs/afs/internal.h                             |  4 +--
>   fs/afs/write.c                                |  5 ++--
>   fs/ceph/addr.c                                | 27 +++++++++---------
>   fs/ceph/cache.h                               | 13 +++++----
>   fs/cifs/file.c                                | 11 ++++----
>   fs/fscache/io.c                               | 28 ++++++++++---------
>   include/linux/fscache.h                       |  8 ++++--
>   10 files changed, 61 insertions(+), 54 deletions(-)
> 

Hi Matthew,

I was just reading through this in case my pin_user_pages() changes
had any overlap (I think not), and noticed a build issue, below.

...
>   static inline int ceph_begin_cache_operation(struct netfs_read_request *rreq)
> @@ -133,9 +133,10 @@ static inline void ceph_fscache_unpin_writeback(struct inode *inode,
>   {
>   }
>   
> -static inline int ceph_fscache_set_page_dirty(struct page *page)
> +static inline int ceph_fscache_dirty_folio(struct address_space *mapping,
> +		struct folio *folio)
>   {
> -	return __set_page_dirty_nobuffers(page);
> +	return filemap_dirty_folio(folio);

I believe that should be:

	return filemap_dirty_folio(mapping, folio);


thanks,
-- 
John Hubbard
NVIDIA
