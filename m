Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E490546AB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 18:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349756AbiFJQjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 12:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349828AbiFJQjM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:39:12 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30114.outbound.protection.outlook.com [40.107.3.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF765DE74;
        Fri, 10 Jun 2022 09:39:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMwyc6Z4+jbo+mYVAcUJP6lJjvJBfykrzx8IYom0hzHs5cTXyW2lIXtz84u4X73rpN0xlW6til77PO3KA+aQD40/f+3TnHSq89N+CZpbFNWnRQc3ffKV/KNIyQuAA5/y1/D6unw0LWKF2g3v4eDo4yu9AFe5xtiA7RHu8hB8uTU7wBdET3yOczWoXvham18XhFihq4B8Awr5mSmz1APrvHnG1tclp2TzQ/g0A7aJNlM+d6Ysl9tEX9CiMi7xUGLSvnKZ/C+ne5fH2bck89W2QmnJMH3svQtQfFPTTmwhu32eYcSX4jIZFfGSxyl8+ShUoI6FcT/v6Kpyv294WLckYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ko2cLk9XQ+yhgKdLfPZVHmKLgKmyXFoVYF2xXgjF9js=;
 b=PKbta/uXKmLaZ5fVjSO229qCycypGcAsqEt7RwEgnEu5G+b7+kBzNdmqj8i0w+MB5arOMTFHPhE2+/54AvdoFj1eQAAdW9VVigCrv553fEvyGlBXpm93dVK7YEQ/fJ2ewPGxfGw3Unq+7JpEy5GUVQaXDynItzlfUlyMT7I69ZJ++j9vjXf62XlyJ4dyjk6nVgCSktSZdD1Ai+tpW9QuWZEkNccSqUOT/kdtcf0NbPb2kt853froDRpNrwzWvQGS81Unhf3Zs+4yf8LbG0YRIm2PyONlRysbdnItgiwTmrYhIyQ/Dv3lAeN/+rYMPKR0idjM35nwkuBxtVJ7qm+v7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ko2cLk9XQ+yhgKdLfPZVHmKLgKmyXFoVYF2xXgjF9js=;
 b=IKKqD0mYvxdNoZuKiFHQz2/S3/5OpRXtwXgNbRWw/PUuPCuEhTtteVjq4oxzp3IklLHeK5B8w2sVd7S3n/Bht8okVlNAa4sSYV72rncYpw2GmrxfsKgllAcQ4Fnzt5yPZAM10Ju2KQO63hMbss/5VXnG3CLi0ZEOeC9hOpyDcBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by AM9PR08MB6180.eurprd08.prod.outlook.com (2603:10a6:20b:2d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Fri, 10 Jun
 2022 16:39:04 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::5f7:6dd:4715:5169]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::5f7:6dd:4715:5169%6]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 16:39:03 +0000
Message-ID: <cb7f3533-a904-ef0f-e3a9-39eed6775aad@virtuozzo.com>
Date:   Fri, 10 Jun 2022 19:38:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 0/2] Introduce CABA helper process tree
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ia64@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, kernel@openvz.org
References: <20220610163214.49974-1-ptikhomirov@virtuozzo.com>
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <20220610163214.49974-1-ptikhomirov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0071.eurprd04.prod.outlook.com
 (2603:10a6:20b:313::16) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a733b14-233b-48b6-6aee-08da4affbacc
X-MS-TrafficTypeDiagnostic: AM9PR08MB6180:EE_
X-Microsoft-Antispam-PRVS: <AM9PR08MB6180F506ADE77DF180021339B7A69@AM9PR08MB6180.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rf99ihfiGoTOeYLPV/tN5EDNHL30NEPzr0aPCVvmQbRsGQkCuG3iFGy7PjBYTuq4Vi8oLGhIGd3pFN2NVsmSuqaeRY6nS9QICqa1ubG3syXPts/vfZQZLw9qWdQqUIF7H1vsEJC7inQXGS7UYux0PUbPdux0lGaUKm5PZmorObxD/FTsFg3/YjQ09/dbFiEEaDG92fZqW2ERoRwyMmvfZLQffip3FueX0S3+RAz2dj0HgYgdFcJmoll45IJJu/Q9J62Li5TUHyX8CLQIbFU4xpR45Ol5m2jE5Ix0KE561rktzZnwZ+YrzTVxhyXzXYuDEtSNK151k1M2arv5gq+merZdrj1ZMge6e66fK9iMt7vKa/zMNcVwvcK1tevS10cxITWaOUB0rknoY1XtmZklWsAzgEj+/ccRP4Rx5TFSOC7dCF297AwarTq/MkFw2lGam4Pnsx3hg0eRTHnZD/rOwGUawFsfJryAwOJE9IEgqHpC2vTbkou9RqTIl6NEMfKfi6NPBalYbW2C0FZEoDI+K8TmDl2L5lywAoMBKbUaEqBeG1/Cwencrv5klgk5ppMpW9djlSBEr6s2PkJ8b+lDYUItSzyqVXqNNUkb2ZE2pRoK/Q4JDF2+F3zJFnSVhFgSFdYl7CUOwmlZ957x2ZpU+KnojLH04Ihf6Wbp+2W9L5crTn5qPj/iiQz/GYhST2Gs0U8jlHvWkzvigXBvRvh1cLmfPhKUKHRkDbLl9qj+TBU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(26005)(6506007)(186003)(6512007)(36756003)(31696002)(2616005)(31686004)(107886003)(86362001)(508600001)(8936002)(38100700002)(316002)(6916009)(54906003)(83380400001)(53546011)(6666004)(8676002)(4326008)(2906002)(5660300002)(7416002)(66946007)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWoyaGhIUU1FUXZjL3V4eVhYdWVwMEdkdFlrL0I5NThUSlNibjkzWXQxcVN0?=
 =?utf-8?B?WTJkNC9QUFprQmdXZEppL2l1WWk1WHYxU3NTZ3NQdlg1VjIrOUFwTGhnakd1?=
 =?utf-8?B?QVBSYWVWZTM4M2xuR1J2SGVkZlF3RkpkZEJBV09ZZHVqeE5Uc20zb2paL3Fx?=
 =?utf-8?B?MmNrRlZwODNFOERLbWdQazEzTHY1UTN5Nys4OGEwbThCd1lBeVVvUWNDTlhF?=
 =?utf-8?B?UjJtVCttYmt4MDhMUGJtbFpQWkp3cWVYVGVqMmk0b3dPQkpDOTY5UGlxYzBo?=
 =?utf-8?B?anBCNjNQNmFWcmxoV2ZZRVU1ZlFpZFMzc3JkUGY3dFNrRlo4RjVMQzhVOUkr?=
 =?utf-8?B?eGZwdWxhUW1lZ2hRdERlR3pQc0NVbDJGejI3d01LTTRraXBiTmlqQW1KRTdD?=
 =?utf-8?B?QjNqNTlXUGljS1JKbEFrSGVPR2RvWHlPQjlRNnBtSFVDUWdXY0tuZ2NWcnE1?=
 =?utf-8?B?NDlrM0FNYUFDMFFYYVkzLzRmeng2ZjREYzNXZkFNKzNua3FvRjVuNWNoaks5?=
 =?utf-8?B?NFUzNFBmaUx0ZWhNVFplNE5TN054SlNsTXRWUlhDY01YVDFlajlnWDhMbG9m?=
 =?utf-8?B?dTBISjU4WXRwdVZCUS93d1c0VjR1eFo1QnZXKzdqUkpVdDBoWDQzU2ZFNHdI?=
 =?utf-8?B?VGVSLzkrSGZ5cFVWMmJXYy9rRHNGenpudlR5VHlpRTV5VFpDYlVjRVNsOHoy?=
 =?utf-8?B?STUwUGtzalFYWUpFRjI3alFhUWM0bkkzTTZCY25FL2ZEdkcrRUd1czJqb28w?=
 =?utf-8?B?M1lOYTZOTkxaR2hqaE9WTWtHbTBGZzhEeTQzSVpjSWtUTGR4c1R3aGd2YzFy?=
 =?utf-8?B?bXI5RzBSajdLOEdaVmRsbk1GMGtEOXlwNmlJR0sxcHBTM0VjcmtzNWNWUE5P?=
 =?utf-8?B?cUoxeDdwUTgxUEczNG96K1FRaTBZWGRBWDVZMkk0ZmdsaUJON05kbC9PajVW?=
 =?utf-8?B?ZG1zTnVORSt2NERRc3MvVE5OY2M2RlJZKzhtb1FIQXV5THdoaGVWTk9TRlZZ?=
 =?utf-8?B?aitFeHRIK0F6WXBTaGV0L2FXN2E4L2lOTTJHaHRpZTRpUkhCSWs2TmIyZm96?=
 =?utf-8?B?c1U4THdGL3grZlpaSlkvNTRoRzJYdEozRTJPSUs3MmhZeVF4MUYvR0VVSFVr?=
 =?utf-8?B?QWtrUDVLZG1XQjZmZTBwZEdNNmpQNWd3dmJYOSttTTJUT0NsVmJ2b09jSWhQ?=
 =?utf-8?B?RDBwbWMvZFlMUEN2aldqZzBYOVk5a2lLSmZRU1h6OUFuci8xOU9DV3AzZXBQ?=
 =?utf-8?B?dEtGWEJZUjZpWTZ2clljK2l4cGxnVWtjNkQ2c2dITWxIakZKSnFYNE1CYUQy?=
 =?utf-8?B?QTJvQlRvWjdkQVVtQ05nRTRJVjdFOCsyU1lJQklodEhJa3dRK3N4bVE5VTJJ?=
 =?utf-8?B?NzdZd0VLcFhvRkxiVnRFeFFqeVd1bi9xeHU0Tzd4ajZsaEZGMVEvRUhiMktl?=
 =?utf-8?B?QzFWaU1Tc0J3N1NQdDlXMDVrQktFLysyMDV1NFNVdTBuTWdxSmJUQ0pwdElM?=
 =?utf-8?B?by9Pa09IV1Zad3hDcGh5TVpzVXQ4cGJtVHdFWkdtWWZ3RmIzV1hyZWd1Q0ht?=
 =?utf-8?B?YVczUjJCUFdiTkFsSlBwcmtqcE1HTEV5RTJZdHBTZEtGVEFYQlZsdGxYQ2t2?=
 =?utf-8?B?dXYvMXlQSnlDWTdZazEzdkJjSnhTODA1dVJQVm5pUjJuUWZHUndNOUNWenZB?=
 =?utf-8?B?NVBUY0gwekg2ODI2dlk0NEhtam9TN0QxZ2NiQXlOVEpFQ2ZKakNHNklyVWlM?=
 =?utf-8?B?bjdmVDhSMGZIbjhQRWlidC9PeW5kaGlRbEtzem03NDJJblR0Nkg0REljR05Q?=
 =?utf-8?B?QjI2cHRyUlFZcjVnTTFOK1pLbjBPQ1oxRmk5ODhZT2tKNzN3bkJDb1VOL29q?=
 =?utf-8?B?SzREaEVaUU5RRGZhUkJDeElOWTlqRkhGalRuemhsRUhsM0xwM2FxTlZvR1dF?=
 =?utf-8?B?T1FwUjlVYjY0VmJrMkd1Z1Q1dnVyd3EvN1NnZzRjMlo3bk9NYTRsc2x0Tmxx?=
 =?utf-8?B?b09RRFUzaGtucExvclE1TytnTFAxYkpHQmhkaThENjhiN21reWdhSXZQcGoz?=
 =?utf-8?B?a2hseHZmUnVEc1V2eU5Bb1c5WFUxNFI2OVdrZFlCaWRoV3RQRDJuWm1PZlpU?=
 =?utf-8?B?ZjFQcUJ2Ni91RVEzWTc5c2FweHZiU0c4VWtsY0tNdVArMnVsdGNXVjVpbHFS?=
 =?utf-8?B?YXdIU1BUdGlyd0NEYU5pZWl3WnJ4YzhoWmlUUWZwYXFmVE1RcUFIZXFTM25r?=
 =?utf-8?B?TCtxL3J0M1NLNEJsMmRBcGNYNGxRV25pdkJIbE14ZzRvTWN6SmU2TXNsQks0?=
 =?utf-8?B?M1Mvc0k3ck15NTgvcUt1bGc2NkVsTGUxS1dHY3Z0Rk9zeVBxbVJoYmJKUGhy?=
 =?utf-8?Q?9nFLVbV6yh8O3Xks=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a733b14-233b-48b6-6aee-08da4affbacc
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 16:39:03.8671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXhebvYXzrTW7ZLwwjmrDj82H48iCyf4Nv+vWc6jfng7yE7qJAZNvM9lw7EV+2gWSpiRD7UZbFdbRsT3rkPhIG5fcxTfpdzl8z21df+n4uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6180
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CC: kernel@openvz.org

On 10.06.2022 19:32, Pavel Tikhomirov wrote:
> Please see "Add CABA tree to task_struct" for deeper explanation, and
> "tests: Add CABA selftest" for a small test and an actual case for which
> we might need CABA.
> 
> Probably the original problem of restoring process tree with complex
> sessions can be resolved by allowing sessions copying, like we do for
> process group, but I'm not sure if that would be too secure to do it,
> and if there would not be another similar resource in future.
> 
> We can use CABA not only for CRIU for restoring processes, in normal
> life when processes detach CABA will help to understand from which place
> in process tree they were originally started from sshd/crond or
> something else.
> 
> Hope my idea is not completely insane =)
> 
> CC: Eric Biederman <ebiederm@xmission.com>
> CC: Kees Cook <keescook@chromium.org>
> CC: Alexander Viro <viro@zeniv.linux.org.uk>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Juri Lelli <juri.lelli@redhat.com>
> CC: Vincent Guittot <vincent.guittot@linaro.org>
> CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Ben Segall <bsegall@google.com>
> CC: Mel Gorman <mgorman@suse.de>
> CC: Daniel Bristot de Oliveira <bristot@redhat.com>
> CC: Valentin Schneider <vschneid@redhat.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: linux-ia64@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: linux-mm@kvack.org
> CC: linux-fsdevel@vger.kernel.org
> 
> Pavel Tikhomirov (2):
>    Add CABA tree to task_struct
>    tests: Add CABA selftest
> 
>   arch/ia64/kernel/mca.c                   |   3 +
>   fs/exec.c                                |   1 +
>   fs/proc/array.c                          |  18 +
>   include/linux/sched.h                    |   7 +
>   init/init_task.c                         |   3 +
>   kernel/exit.c                            |  50 ++-
>   kernel/fork.c                            |   4 +
>   tools/testing/selftests/Makefile         |   1 +
>   tools/testing/selftests/caba/.gitignore  |   1 +
>   tools/testing/selftests/caba/Makefile    |   7 +
>   tools/testing/selftests/caba/caba_test.c | 501 +++++++++++++++++++++++
>   tools/testing/selftests/caba/config      |   1 +
>   12 files changed, 591 insertions(+), 6 deletions(-)
>   create mode 100644 tools/testing/selftests/caba/.gitignore
>   create mode 100644 tools/testing/selftests/caba/Makefile
>   create mode 100644 tools/testing/selftests/caba/caba_test.c
>   create mode 100644 tools/testing/selftests/caba/config
> 

-- 
Best regards, Tikhomirov Pavel
Software Developer, Virtuozzo.
