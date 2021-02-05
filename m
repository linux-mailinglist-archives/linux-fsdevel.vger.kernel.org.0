Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AF5310621
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 08:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhBEH5l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 02:57:41 -0500
Received: from mail-bn7nam10on2070.outbound.protection.outlook.com ([40.107.92.70]:58571
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229609AbhBEH5j (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 02:57:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/Y+Xb+2TZ5OIde6SsrrpnR7WwD1nDksZMEmvFDAbDkj8gZzLALRerpvZ6SvEt6Rs1Wr/RWteeThoS7LmDuhB7DUq3KfVnvq93+2pFQahc7om5r0r0vQxoL4wVM1Y7s95hdbRkvblbe2Ypb4MFFxLLhBF6tlxFUB8QhKaZKZZR+5Z0exZ3j8uzeuBlMxO96SUGQPjP9If59lJhW7dkdE/YPygu9Bf9MsdzW0rc6wz59yxNElJjBt5p94ima3L/TOMSgeyf2QFmTJ9Igi+ufqEvvmZD7JFSd7qHU5Uslv8WWut2j1B3inaukbQPj8tA0AtSokMomNqVAUv6sXBWPD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jw91bYumPL75+1tmVHDR2vjRtrBsS1t0L53YzTPu8uc=;
 b=ck0+nWLE7pTSpY1sj09d6302B3E5xVbrJjw6/sYShR27kn3FsyZu5nvnNLMbxXSgnZbfi0OmKgalPN0Cd8331iY/70OIt20CPU3Axw6TjQ8cuVE/AZLfgepGTmjN/KYu6wl3AD0cs84keH9DDpiE3qmJB/PjOQSYOI6X1v6SLn0JIuuVKl29jhVJFBdR9Il6MHfZS+AKtXp0VhlzlWm20fOzd4FLaP9rL3ij4ivy9KCB7I7HMwLwSdGevsISJFwyzqM7voDHwRJgj12W/Q2uIO5gdQ8eRaw280eR4+u+/0k63Zl7uc/OQUAa4dhxtfqte+42jjEUSd0wwD7kgSJTXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jw91bYumPL75+1tmVHDR2vjRtrBsS1t0L53YzTPu8uc=;
 b=CZUgU4GYhy2VCkEB9r5eV1JrpqEWHQ55oUvriPzAqIx7UcTArqVsfQQbilLnMwqnQcK63P+Wi3M3rtuN0t13CxkS/YhYcwIup2KjjU9uy03muTkXDXAavLIvQhz5Rb8ANlfcpOLDMKzeLdP0oVXUakG4bOMAMOJyAzBeZEoh8Yk=
Authentication-Results: lists.linaro.org; dkim=none (message not signed)
 header.d=none;lists.linaro.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (10.255.86.19) by
 MN2PR12MB4390.namprd12.prod.outlook.com (20.180.247.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.23; Fri, 5 Feb 2021 07:56:44 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3825.023; Fri, 5 Feb 2021
 07:56:44 +0000
Subject: Re: [PATCH v3 2/2] dmabuf: Add dmabuf inode number to /proc/*/fdinfo
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     jannh@google.com, jeffv@google.com, keescook@chromium.org,
        surenb@google.com, minchan@kernel.org, hridya@google.com,
        kernel-team@android.com, Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Anand K Mistry <amistry@google.com>,
        NeilBrown <neilb@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20210205022328.481524-1-kaleshsingh@google.com>
 <20210205022328.481524-2-kaleshsingh@google.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <df97ba85-2291-487a-8af0-84398f9e8188@amd.com>
Date:   Fri, 5 Feb 2021 08:56:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210205022328.481524-2-kaleshsingh@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR03CA0070.eurprd03.prod.outlook.com (2603:10a6:208::47)
 To MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR03CA0070.eurprd03.prod.outlook.com (2603:10a6:208::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Fri, 5 Feb 2021 07:56:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b12cd88-e660-4f7f-2815-08d8c9ab9471
X-MS-TrafficTypeDiagnostic: MN2PR12MB4390:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4390FF5699D9D10BE5E8AB5083B29@MN2PR12MB4390.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IADDlkhCBEsnGsw6DtXK6sgBwdzdWttPEtFw0hEv2d0Y39DMi9PdDINl/lBo3hDymr6LPeWgLpBOo07aVzS1Keyh0/2xM0sLXuL0Ic6ZVtEmPIhgkvroCpKT8DWyPi8K+jm10CB+OAz3XnnzW/ViH5k9+xIBmKQn9FyFKR7agxGGNQLGaRpU7JMbH4rnzGfvZybuab/uhDAG2Wf2L20NCxBrhDpWLHAz3JdBaGT4KpIxeI3gwPQLLdLfL11sc/K70WPzLfYNaFA1yRx7yL0ReCqezL8Tb2hCsGl6j5GIw/u2gNqn+78MeagRP+z/Oh+7AAxEb66u/tlNnn/AmjTQZPegRAk/g9i1Samp3hPcen+P6p+y3LOncZ1S0o25ZlK6tbEtq5UOBpXGk0iXDWVCA31sufPlb/gp5uYdPn9TtpxNQKVFze0NLgT4bt+7eM5hNLHOzi8WYjCnmfDcrvBe7vLgEcu+4LCqagzVgT0mNBH014gzS9QfuccjlrcSLPHE6cAg5As9DyrKg8HxB4rYbJjXthgTCtm8Bgv21t063EGhS6XMmra1XVqCXLA/h40yHhJq7s4mMXa/BtggtXlbEUfEyw1LF8Q9Nmr8P+58uNMYoEoKoQKWsfgH/Puqcxu4qyh8584VXVIGzRKqhS/IBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(52116002)(316002)(6666004)(7416002)(66946007)(5660300002)(54906003)(478600001)(66476007)(66556008)(31686004)(6486002)(6916009)(86362001)(8936002)(2906002)(31696002)(8676002)(36756003)(4326008)(83380400001)(2616005)(16526019)(186003)(34580700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eXA0UTN1QUxyNVpBUU9RQU92d21Yd3F2bU92b0lUNVRMQ3V0NEJiTU1GWVNl?=
 =?utf-8?B?NE9Cc2QyS1dhV3lwNkY1M2ZiWitqaTdMZU5wZVpQeG10TkRHTytRaTlsWkhs?=
 =?utf-8?B?emg2VEw2N1hWZFYyQWRiOWtCd05XMVFFanRqRDliM2w4elFndlZ5ZkpFa0Rr?=
 =?utf-8?B?ajFWVkdsQ3ZVbGtSb3hVR2pvaXdaMlhxRmVQUVlzdFpJUkYwQTdDN01RUDdR?=
 =?utf-8?B?eEtQWXJNNUMrY1pTb1JDNHhFMExNTk9SNTMvcEtGRjFTVXoyTXBTYSs5NjJ3?=
 =?utf-8?B?dnBOTHZDUm14QUlHbUxtbGo3WTJuTWpQc1pCTnZLNnluQ3VRSkJNT2hKMERQ?=
 =?utf-8?B?WWV0YklyM2s0bTMzNFFrSGlTUXVRRTluQjIyZk9IVk9IUDN6Vk01VU42VGFq?=
 =?utf-8?B?dnl1QlBMdjRNNWl6T2J5a1p3OTc5c2ZmcjJyeEtyNnV4ckdrdkxUdGwrWjB2?=
 =?utf-8?B?T0VxamcwdDBlaGJURXFqUit1Z1FyM0JKT2NlUmlOY3U1Q3ZidS9NckdHZmg1?=
 =?utf-8?B?SDhVMWZLeTYwb05USGROYk92Vk5tQkdOWEhYMkNEZ2Z1empLMVlmYXRweGF1?=
 =?utf-8?B?K281Qmx2bDRyeWdiRC9vM2dCWGRmWjFCUlZzZUcrYmR1RStocWxUSENyNEVh?=
 =?utf-8?B?MTJ6cncyZE1wSkU3Y1BleitXc1I0a2xpR3FvOHVCMXZoVnZVV3ZyaE0rS1VV?=
 =?utf-8?B?NWhqVVh6d0IveHhseDV2dEtlVjVxLzJHb09RTSt2clhIbkh2engyZGRKN05s?=
 =?utf-8?B?a0VCMDV6RmxVcXQzM0wrbGMwbU9KWDA1WngvN2tPQVBTczRpeEJGQy9GMGJ1?=
 =?utf-8?B?RUg0c1FwemREelBlTTBoSkFjUHI4Y1ptbko1MTErNmVUNG1SOUczNDZhZ1ht?=
 =?utf-8?B?SnVMdy9yVWlsZ3pLd3NubWZDUkc3bUxqVlRaM1UxME5zM1FSSzJLREF3a3BL?=
 =?utf-8?B?OGZlRy91cE02Q1ovZEpSLzUyM0VKRkFsRHE4THJQUWQ4YmpIL0JwSjRoaFlN?=
 =?utf-8?B?aHBsVzF4cGdpMmYwa1VmU3dtSG1kSnNKRHVJNTRFUS9BNk41OTMyam9nRVN0?=
 =?utf-8?B?bk5WWFdQVEt1NFgvKzNQaEgwVkZQN1V0Z280TW93b1NQNFYyZmZ4N0dIaXYr?=
 =?utf-8?B?UnVZekJmRzdOWUc0bWtXdDlwNTdIWDZFRlJMTDVtZU1udEZGaU90SVBjOVov?=
 =?utf-8?B?c3d6ZWkrM3QrV1lISUlVOHlReWs2UVVTODFZY0FPRlBDbnBlYWlkbVpRSDN5?=
 =?utf-8?B?TE13ek1Kbmh4ZGxMTzN6RkxNN0NOSDJ3eUJoUlhnVVFxb2xOMWtrU2JIbEpR?=
 =?utf-8?B?VTlRenA2Q0FXYWliQUdKOExxNnhjZ1p0Q3g3blQrSmNLZUtSdW5lNFpiMk1X?=
 =?utf-8?B?Vm1TS2UxdHFyRTRkb2dzNHp4U3lvRDNDL1lKNm5tMW8zRmZ6NXhtNWlLdVpW?=
 =?utf-8?B?alZYV1gra0VURHNaRlRyZ3pCaXozT2FCNmxveXhuZzRTSmhsZ2xETGwycW1u?=
 =?utf-8?B?TjlieEd4N05FK2tHS3pqK2x6YWIwMUNlaVhIMzdIbjdZN2hJWGkwTmZScHIz?=
 =?utf-8?B?KytGSU5id2d6V1c1dEg2ZSthRjd2clphNFljaG5Cc09KdmtaVE5CVGdGeUJy?=
 =?utf-8?B?ZUZOSUhnMStkR3poSDFGb2p4WHFvYU1zZ0VmbkVVODZJMUVLT3NTYzNndGda?=
 =?utf-8?B?MnB1LzlNYUo4V1ZodTk4RURMbXdTdUNJckN2VjRGdVVsdi9ENVpuaGZPdlVT?=
 =?utf-8?B?cVdhWmhpcit5ZlhmaURPR1ZCSVRMTmQrcURoVkFERFUzOGZjeUk0SmQ5eEtS?=
 =?utf-8?B?dmlZdzQ4OFo1NHFiQndKMTBvcUZHWGZOcnRTQnJMRTVEVGtnSVp2QzBFUlVq?=
 =?utf-8?Q?fxNgOWA8rri3X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b12cd88-e660-4f7f-2815-08d8c9ab9471
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 07:56:44.4706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufHK6GEms2ZrRMJnxuBbOf4i3QN9gzhEspdXft3TT5mh1R9hY2Adm7qKCXDaqxga
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 05.02.21 um 03:23 schrieb Kalesh Singh:
> If a FD refers to a DMA buffer add the DMA buffer inode number to
> /proc/<pid>/fdinfo/<FD> and /proc/<pid>/task/<tid>/fdindo/<FD>.
>
> The dmabuf inode number allows userspace to uniquely identify the buffer
> and avoids a dependency on /proc/<pid>/fd/* when accounting per-process
> DMA buffer sizes.

BTW: Why do we make this DMA-buf specific? Couldn't we always print the 
inode number for all fds?

Regards,
Christian.

>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
> Changes in v3:
>    - Add documentation in proc.rst
> Changes in v2:
>    - Update patch description
>
>   Documentation/filesystems/proc.rst | 17 +++++++++++++++++
>   drivers/dma-buf/dma-buf.c          |  1 +
>   2 files changed, 18 insertions(+)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 2fa69f710e2a..fdd38676f57f 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -2031,6 +2031,23 @@ details]. 'it_value' is remaining time until the timer expiration.
>   with TIMER_ABSTIME option which will be shown in 'settime flags', but 'it_value'
>   still exhibits timer's remaining time.
>   
> +DMA Buffer files
> +~~~~~~~~~~~~~~~~
> +
> +::
> +
> +	pos:	0
> +	flags:	04002
> +	mnt_id:	9
> +	dmabuf_inode_no: 63107
> +	size:   32768
> +	count:  2
> +	exp_name:  system-heap
> +
> +where 'dmabuf_inode_no' is the unique inode number of the DMA buffer file.
> +'size' is the size of the DMA buffer in bytes. 'count' is the file count of
> +the DMA buffer file. 'exp_name' is the name of the DMA buffer exporter.
> +
>   3.9	/proc/<pid>/map_files - Information about memory mapped files
>   ---------------------------------------------------------------------
>   This directory contains symbolic links which represent memory mapped files
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 9ad6397aaa97..d869099ede83 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -414,6 +414,7 @@ static void dma_buf_show_fdinfo(struct seq_file *m, struct file *file)
>   {
>   	struct dma_buf *dmabuf = file->private_data;
>   
> +	seq_printf(m, "dmabuf_inode_no:\t%lu\n", file_inode(file)->i_ino);
>   	seq_printf(m, "size:\t%zu\n", dmabuf->size);
>   	/* Don't count the temporary reference taken inside procfs seq_show */
>   	seq_printf(m, "count:\t%ld\n", file_count(dmabuf->file) - 1);

