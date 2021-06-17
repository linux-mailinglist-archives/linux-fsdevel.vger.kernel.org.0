Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7143AAF0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 10:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhFQIsd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 04:48:33 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:55392 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229712AbhFQIsd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 04:48:33 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15H8kKc4012520;
        Thu, 17 Jun 2021 01:46:20 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0a-0064b401.pphosted.com with ESMTP id 397xms05pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 01:46:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRiuQ7gbL32Iw1IPGofaSG/N3haPrN8Pm/C3AroTqvRywO8m+za2275Q2Xs68pul0NTKeOrqsQNxq++q64iX17MHTXPCk40/R6R36n7u9vyiPtDNR2OtLzTU24PzCFaqGdEV1rjbwjgVT1634Rph+YSsMfsXZXF2Udwme9oQ40pbpkWso8jK8/MNeH6CuigPgWAMGLtUoQHmSrn9Dfil63eXeGVA05i7mfyrsiEAtXv6b6qCwVyRXaw4qKI5oou7+7jlB/8RTAKo6bwgepRWry566o8D1ZfGF2KZcpxV5W7d7EKGeoJHIF0+YDlV29pAQ5G9znXb67dDOHn1fbBM7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oz4Q8PXWGOSUPfwZZwS003KXCo0OB0iPsDC88Rn1YKk=;
 b=gpTjz+a3bNbtDm5bSAgsiFt6BBkGqbMQKOzOejVDfiNJOffOxqORtukbl9M2EDU5F3PeunZf6rs45rmp9p9Bvk0idZ9zfAjRf83CRbJHdEs7SDfP6G6KjhGJycBFKt+DN3cFy3lG3qrUrtCM2mG+zksCC7HBrMRkqEvOXJMVlNF32qlmnsPvfPBH7zHFYgBjsTpUMryX5FhW5L08227hPbPbOMdublnY49BUNDAqUfkRz3AWc65EZziTpRkQjKBk1rTQm0HgiC2Ax50zTZUcFYS/h7jI9iMh3qgR6+ey609XGFJeGcZijLhuPjhHhalBqHM5FjNuL3Cv+RNrnTPFtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oz4Q8PXWGOSUPfwZZwS003KXCo0OB0iPsDC88Rn1YKk=;
 b=b6uJlXzuo2CW/KrZH65alzqYpljNuurVANjbx45Np71FghsEY2z09CwxM5qPKby1PId6Jr7rOnzho5KepCDxojrmlkEzZYII/+0XbFhY1SAhmrWp0JvVf+a/7uyXwRNhI/oFsNnpUSZ5lLPv0EzGtJN1ZG+liETy8VDP3E7ZmrA=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=windriver.com;
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18) by MWHPR11MB1854.namprd11.prod.outlook.com
 (2603:10b6:300:10c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Thu, 17 Jun
 2021 08:46:16 +0000
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c5c:9f78:ea96:40e2]) by MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c5c:9f78:ea96:40e2%10]) with mapi id 15.20.4219.026; Thu, 17 Jun 2021
 08:46:16 +0000
Subject: Re: Re: [PATCH v3] eventfd: convert global percpu eventfd_wake_count
 to ctx percpu eventfd_wake_count
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@ftp.linux.org.uk" <viro@ftp.linux.org.uk>
Cc:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210609081526.27104-1-qiang.zhang@windriver.com>
 <DM6PR11MB4202EF122EB1EE2384731FD2FF309@DM6PR11MB4202.namprd11.prod.outlook.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <4c802825-eed0-a5c8-c6d9-5704c44c3190@windriver.com>
Date:   Thu, 17 Jun 2021 16:46:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <DM6PR11MB4202EF122EB1EE2384731FD2FF309@DM6PR11MB4202.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: PH0PR07CA0120.namprd07.prod.outlook.com
 (2603:10b6:510:4::35) To MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by PH0PR07CA0120.namprd07.prod.outlook.com (2603:10b6:510:4::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 08:46:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94438e6d-ff58-4138-b9bb-08d9316c5ea9
X-MS-TrafficTypeDiagnostic: MWHPR11MB1854:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR11MB1854548AF62FC3800A130F828F0E9@MWHPR11MB1854.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +vqFiGA+0qO+ZndJkdHGLI0IaTshb9BhLFWAP8XaQvk5EsbIn6ExVN3P5KTCVt+qjm4MZWcswV11lS2HHEhYQWpOeGHDzvanK4hKRfM+RG7TyyIxvsHv84qBWv/J1Z2kkE/PTwbwT+uQmX88DP7Bs7vBCbtnxC6QZKkNwQuBRMRYLhH6jBNxpY983AwY31w4DKkMgCBDHfpET7KG487b0Z2IqA3uHj4Qsg41lZ1q9PHVxfHD17rE+Zx4Q0v5GNKGR+ORe79HYMqDAA3JWkfDG1nty7KGGr+PFYUIuMDDmf6U15CsW5TzC+sSXbWQleuxooyvWmobdpD29luYLk1IooHTue+DM24hW7iJi3jKOCWlfkKGyB64N5O/WzlxJa1pcuqKchp3RReyjyjW8EclFdlyk1R9pU5fjZJs0bdzHKvkvGBq1F5t1s7gvOffE2LnqQQVKrS/JHLMv1EGBU98mKAcES/h5vKNtqlVMbPMl+TuKXHZjJuXChq7mysvrxY21RhNfZ+Xav1+pXGM2soziFbugfUMTVVdYjR6Tioqw0mKx1967WGbjY9uqv1Ou2aWlYA1F6opWJexkz/v+G9Y4IlhVyvhYcPdVp8QuArRTA5LUj+JkLs5rLcnkcUgHe6pCRDPI3b20Y3bNGaYHeghnvdG+vppnVaacoVZqrGXsnGGugFkiTs9uZ9X7loXqpQtGu6MLZWHfN7tVlKo0aDVRpid7lLN8iGktwJO90ihk7jHN9Vtu9lKx/UDcO3pAyEpE2vowN8TVW+YOx94tLm7kgIMhHd2vExuIR5L57RltxjqVFEdjp+kyxAYHg8quJmtxWeHCCmsxIorX8/rn7n0WrSZz0qGPZQu4almDDY4P0k6aQS/jbZUW5dmsHd1LZzcIJ9qm5JLgfoVVKrLKZELhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2351.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(396003)(136003)(366004)(346002)(966005)(31686004)(16576012)(83380400001)(26005)(38350700002)(956004)(6666004)(52116002)(2616005)(31696002)(53546011)(5660300002)(8676002)(38100700002)(84040400003)(86362001)(8936002)(54906003)(316002)(110136005)(6486002)(66946007)(36756003)(4326008)(16526019)(186003)(66556008)(478600001)(6706004)(2906002)(66476007)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckxLaDM5Vk5zdXJmOElNK2dud0xUT2gvUjRhTXJPQnBWU1VyWXFkM3hQN3hs?=
 =?utf-8?B?eExXWm5DSzhYUmhZbHVRRVJkOXdmanNBZ21rRXl4emJ4dWlHN09KSFpWdFVT?=
 =?utf-8?B?a3BwTmw1UGhKazIvVjdQV0JlQ1pSWGVHM0Y4ODRlZW0rU1RsRnd1NjE1cWhI?=
 =?utf-8?B?YTJYZWZBdmdmNnJEME03N3JyQ1F6VnJEcEJlbWh0RXdmOUw5UGhsRDZTQ3oy?=
 =?utf-8?B?QWxQRWpPWEhtUVRtQlQ0L2NDdWIrMTNoOVU2aDhOSk0rODlGTTRpL1c2NEFT?=
 =?utf-8?B?K2grSmVnTDhqT0tBbzBEQTUxbmVMZGZaTHFpM3lMQ1JQYXhIeld5VG9WWHNr?=
 =?utf-8?B?ZnF0TVBUSTM4TGV3ZVJTRWZieU5DZnk4RzVKMHBjOHo5QjBsekdyUnB2MnAr?=
 =?utf-8?B?TXEyZ2FCY3dkczg0M3JMT0dVWDZlQm9TWUhZa3BzSzJkUEpMVW51WmhMQTVm?=
 =?utf-8?B?NHJzUkFkSGYxcTdsTjFMTFYyNlViZVhDejAxS1hna2VMOC8xTW1jNU5HYkdw?=
 =?utf-8?B?cmpmT2RWMjY3Zy9EMlBpWEowamVPcVZyM2JvVm5OeHZBZUVTaDhsNVJCcWpv?=
 =?utf-8?B?cUNUSUhtVVRBTzFtTjFhVlYycDQzNnQ5NkJhTXZTdVVKUGxNZCtDU0wyMXR4?=
 =?utf-8?B?anAwZ1gxSUo1Q3NLZzhsWEFGR3Q2dVBMU1lxRHJuckllQnl5Tkk4UkhobUNY?=
 =?utf-8?B?amJ2SnBBSnMyRTQ2VVRYK1Ewb3RZbVNYbllRWS9XNG83Z1FUWE9XTlQ2cW41?=
 =?utf-8?B?dFN5TWVpaUNmMGRHSVpyZ0s5aGhPb093amV5RGo1emRJV3JwZ0tYM0F1aWJR?=
 =?utf-8?B?RlpqOHRxOGFBUzhGaFRZZTNrTEtFYjZTRGU2UlF0Rk9lcWd0OGNxZVkzVHBB?=
 =?utf-8?B?Z0RCZXdFMEN1ZGQzMVlqUElVLzFBYUhQK2ZrbFRwU2RnanZzZ0RiZUxDN1Yy?=
 =?utf-8?B?Z0VQQVNvTWx2b2dWemt6aWh4cFVQN1VCajdNRmt6Wkp5V09GSW5hUHQ3RE93?=
 =?utf-8?B?TUtPa0IzT0ptOFlVenBLYXhabnZ2cWtUdGdxMU9ZenhDdmtjdzBEc1djM0Ey?=
 =?utf-8?B?UnZybmxpWHUxTnhoVXhLVEcwNFMzWkNycWZya3BleWpJalpQNFNTM3VSWC9q?=
 =?utf-8?B?bmMyMlRkNEg0K0Z1aHRMak50aWovNDQ2QXo4bGVrbURycHlZczdMSmhRMHk0?=
 =?utf-8?B?SzMvR0MvcG9USWwrOGFQbGZiN1pjZmgyR0lZbkJhOG80TEtvRytiOWdrcFcx?=
 =?utf-8?B?QVRXL3poYmF3SzllZWQzUFRTZm1taWthYy9qbFdpVnEzeWE0bG5aUDhhSnFZ?=
 =?utf-8?B?VDd2MTNYN0MrNnJBbVlTUnNYRlY3YmlwcFo4bkRWTlY2RVQ4WEc5aUNxQ205?=
 =?utf-8?B?M1U0ZHU4UHdzSmNaR3NTbC94MDJMWHQ4cjM5VUF3T0VyRzV2cVZvSWVwUk9r?=
 =?utf-8?B?N01CT3VFUURsSUdDbDJOaWxhcXYwR3l5amk2TEdVaU9TaHVaanhKbUJLV3BT?=
 =?utf-8?B?YVlIRGk0bGpMamwvZWpDcmg4ekI2RzZLWXRaOURTb1N3UU95UjNNRzA4OGY2?=
 =?utf-8?B?NTk4OG9VbStrb2N0WDIyOVl2cDRMSm9CZzNBdUdNR3lOVkUvOXU2M2F6MEZj?=
 =?utf-8?B?NnhEVnBwVmlob3QyTnFaWm43eTM5a2NKUCttbldEWXFUVU9mNmd4d2dYVXow?=
 =?utf-8?B?QkpTaEdqMVlXdDYzRGViWWNLUnh2ZUEvbjZKOGJNbG9FaU84aThpdGY3OHRi?=
 =?utf-8?Q?DetL/UFCBuYqbrU6mW1/FUCp3be6uxj4Sg7HIZe?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94438e6d-ff58-4138-b9bb-08d9316c5ea9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2351.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 08:46:16.5905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3c87vbjuT369JYaOPBifv319PS374lAXoNhGjUdUAjNUcGGz6qyDgq3Jj67HXIT/5fpFkm3KnZfRwh1IGgnGNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1854
X-Proofpoint-ORIG-GUID: Vul59zDOC2UxQvBgrokY02yoQYZYZqpB
X-Proofpoint-GUID: Vul59zDOC2UxQvBgrokY02yoQYZYZqpB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_05:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 phishscore=0 impostorscore=0 clxscore=1011 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170061
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/15/21 10:58 PM, Zhang, Qiang wrote:
> Hello AI Viro,  Jens
>
> There was no response to this patch for a long time,
> can you help with the review?   I will thank you very much and look forward to your reply .

This way had been talked about before. The concern is different eventfds. See
https://lore.kernel.org/lkml/3b4aa4cb-0e76-89c2-c48a-cf24e1a36bc2@kernel.dk/

The thread waiting to be reviewed is here:
https://lore.kernel.org/lkml/20200410114720.24838-1-zhe.he@windriver.com/


Zhe

>
> Thanks
> Qiang
>
> ________________________________________
> From: Zhang, Qiang <qiang.zhang@windriver.com>
> Sent: Wednesday, 9 June 2021 16:15
> To: axboe@kernel.dk
> Cc: viro@zeniv.linux.org.uk; linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org
> Subject: [PATCH v3] eventfd: convert global percpu eventfd_wake_count to ctx percpu eventfd_wake_count
>
> From: Zqiang <qiang.zhang@windriver.com>
>
> In RT system, the spinlock_irq be replaced by rt_mutex, when
> call eventfd_signal(), if the current task is preempted after
> increasing the current CPU eventfd_wake_count, when other task
> run on this CPU and  call eventfd_signal(), find this CPU
> eventfd_wake_count is not zero, will trigger warning and direct
> return, miss wakeup.
>
> RIP: 0010:eventfd_signal+0x85/0xa0
> vhost_add_used_and_signal_n+0x41/0x50 [vhost]
> handle_rx+0xb9/0x9e0 [vhost_net]
> handle_rx_net+0x15/0x20 [vhost_net]
> vhost_worker+0x95/0xe0 [vhost]
> kthread+0x19c/0x1c0
> ret_from_fork+0x22/0x30
>
> In no-RT system, even if the eventfd_signal() call is nested, if
> if it's different eventfd_ctx object, it is not happen deadlock.
>
> Fixes: b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>  v1->v2:
>  Modify submission information.
>  v2->v3:
>  Fix compilation error in riscv32.
>
>  fs/aio.c                |  2 +-
>  fs/eventfd.c            | 30 ++++++++++--------------------
>  include/linux/eventfd.h | 26 +++++++++++++++++++++-----
>  3 files changed, 32 insertions(+), 26 deletions(-)
>
> diff --git a/fs/aio.c b/fs/aio.c
> index 76ce0cc3ee4e..b45983d5d35a 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1695,7 +1695,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
>                 list_del(&iocb->ki_list);
>                 iocb->ki_res.res = mangle_poll(mask);
>                 req->done = true;
> -               if (iocb->ki_eventfd && eventfd_signal_count()) {
> +               if (iocb->ki_eventfd && eventfd_signal_count(iocb->ki_eventfd)) {
>                         iocb = NULL;
>                         INIT_WORK(&req->work, aio_poll_put_work);
>                         schedule_work(&req->work);
> diff --git a/fs/eventfd.c b/fs/eventfd.c
> index e265b6dd4f34..b1df2c5720a7 100644
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -25,26 +25,9 @@
>  #include <linux/idr.h>
>  #include <linux/uio.h>
>
> -DEFINE_PER_CPU(int, eventfd_wake_count);
>
>  static DEFINE_IDA(eventfd_ida);
>
> -struct eventfd_ctx {
> -       struct kref kref;
> -       wait_queue_head_t wqh;
> -       /*
> -        * Every time that a write(2) is performed on an eventfd, the
> -        * value of the __u64 being written is added to "count" and a
> -        * wakeup is performed on "wqh". A read(2) will return the "count"
> -        * value to userspace, and will reset "count" to zero. The kernel
> -        * side eventfd_signal() also, adds to the "count" counter and
> -        * issue a wakeup.
> -        */
> -       __u64 count;
> -       unsigned int flags;
> -       int id;
> -};
> -
>  /**
>   * eventfd_signal - Adds @n to the eventfd counter.
>   * @ctx: [in] Pointer to the eventfd context.
> @@ -71,17 +54,17 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
>          * it returns true, the eventfd_signal() call should be deferred to a
>          * safe context.
>          */
> -       if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
> +       if (WARN_ON_ONCE(this_cpu_read(*ctx->eventfd_wake_count)))
>                 return 0;
>
>         spin_lock_irqsave(&ctx->wqh.lock, flags);
> -       this_cpu_inc(eventfd_wake_count);
> +       this_cpu_inc(*ctx->eventfd_wake_count);
>         if (ULLONG_MAX - ctx->count < n)
>                 n = ULLONG_MAX - ctx->count;
>         ctx->count += n;
>         if (waitqueue_active(&ctx->wqh))
>                 wake_up_locked_poll(&ctx->wqh, EPOLLIN);
> -       this_cpu_dec(eventfd_wake_count);
> +       this_cpu_dec(*ctx->eventfd_wake_count);
>         spin_unlock_irqrestore(&ctx->wqh.lock, flags);
>
>         return n;
> @@ -92,6 +75,9 @@ static void eventfd_free_ctx(struct eventfd_ctx *ctx)
>  {
>         if (ctx->id >= 0)
>                 ida_simple_remove(&eventfd_ida, ctx->id);
> +
> +       if (ctx->eventfd_wake_count)
> +               free_percpu(ctx->eventfd_wake_count);
>         kfree(ctx);
>  }
>
> @@ -421,6 +407,10 @@ static int do_eventfd(unsigned int count, int flags)
>         if (!ctx)
>                 return -ENOMEM;
>
> +       ctx->eventfd_wake_count = alloc_percpu(int);
> +       if (!ctx->eventfd_wake_count)
> +               goto err;
> +
>         kref_init(&ctx->kref);
>         init_waitqueue_head(&ctx->wqh);
>         ctx->count = count;
> diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
> index fa0a524baed0..6311b931ac6f 100644
> --- a/include/linux/eventfd.h
> +++ b/include/linux/eventfd.h
> @@ -14,6 +14,7 @@
>  #include <linux/err.h>
>  #include <linux/percpu-defs.h>
>  #include <linux/percpu.h>
> +#include <linux/kref.h>
>
>  /*
>   * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
> @@ -29,11 +30,27 @@
>  #define EFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
>  #define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE)
>
> -struct eventfd_ctx;
>  struct file;
>
>  #ifdef CONFIG_EVENTFD
>
> +struct eventfd_ctx {
> +       struct kref kref;
> +       wait_queue_head_t wqh;
> +       /*
> +       * Every time that a write(2) is performed on an eventfd, the
> +       * value of the __u64 being written is added to "count" and a
> +       * wakeup is performed on "wqh". A read(2) will return the "count"
> +       * value to userspace, and will reset "count" to zero. The kernel
> +       * side eventfd_signal() also, adds to the "count" counter and
> +       * issue a wakeup.
> +       */
> +       __u64 count;
> +       unsigned int flags;
> +       int id;
> +       int __percpu *eventfd_wake_count;
> +};
> +
>  void eventfd_ctx_put(struct eventfd_ctx *ctx);
>  struct file *eventfd_fget(int fd);
>  struct eventfd_ctx *eventfd_ctx_fdget(int fd);
> @@ -43,11 +60,10 @@ int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *w
>                                   __u64 *cnt);
>  void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);
>
> -DECLARE_PER_CPU(int, eventfd_wake_count);
>
> -static inline bool eventfd_signal_count(void)
> +static inline bool eventfd_signal_count(struct eventfd_ctx *ctx)
>  {
> -       return this_cpu_read(eventfd_wake_count);
> +       return this_cpu_read(*ctx->eventfd_wake_count);
>  }
>
>  #else /* CONFIG_EVENTFD */
> @@ -78,7 +94,7 @@ static inline int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx,
>         return -ENOSYS;
>  }
>
> -static inline bool eventfd_signal_count(void)
> +static inline bool eventfd_signal_count(struct eventfd_ctx *ctx)
>  {
>         return false;
>  }
> --
> 2.17.1
>
>
>

