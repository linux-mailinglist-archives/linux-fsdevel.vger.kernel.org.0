Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0365A6F13BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 11:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345353AbjD1JAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 05:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345600AbjD1I74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 04:59:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CD110C6;
        Fri, 28 Apr 2023 01:59:54 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q75zQ3mPvzSv36;
        Fri, 28 Apr 2023 16:55:30 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 28 Apr 2023 16:59:49 +0800
Message-ID: <5bab3a6d-62e7-21d1-df18-6d0f6b031216@huawei.com>
Date:   Fri, 28 Apr 2023 16:59:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] mm: hwpoison: coredump: support recovery from
 dump_user_range()
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "chu, jane" <jane.chu@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Jens Axboe <axboe@kernel.dk>
References: <9a9876a2-a2fd-40d9-b215-3e6c8207e711@huawei.com>
 <20230421031356.GA3048466@hori.linux.bs1.fc.nec.co.jp>
 <1bd6a635-5a3d-c294-38ce-5c6fcff6494f@huawei.com>
 <20230424064427.GA3267052@hori.linux.bs1.fc.nec.co.jp>
 <SJ1PR11MB60833E08F3C3028F7463FE19FC679@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <316b5a9e-5d5f-3bcf-57c1-86fafe6681c3@huawei.com>
 <SJ1PR11MB6083452F5EB3F1812C0D2DFEFC649@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <6b350187-a9a5-fb37-79b1-bf69068f0182@huawei.com>
 <SJ1PR11MB60833517FCAA19AC5F20FC3CFC659@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <f345b2b4-73e5-a88d-6cff-767827ab57d0@huawei.com>
 <20230427023045.GA3499768@hori.linux.bs1.fc.nec.co.jp>
 <SJ1PR11MB6083E48452A7FE8D874F5CF0FC6A9@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <SJ1PR11MB6083E48452A7FE8D874F5CF0FC6A9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/4/28 0:45, Luck, Tony wrote:
>>> But in the core dump case there is no return to user. The process is being
>>> terminated by the signal that leads to this core dump. So even though you
>>> may consider the page being accessed to be a "user" page, you can't fix
>>> it by queueing work to run on return to user.
>>
>> For coredump，the task work will be called too, see following code,
>>
>> get_signal
>> 	sig_kernel_coredump
>> 		elf_core_dump
>> 			dump_user_range
>> 				_copy_from_iter // with MC-safe copy, return without panic
>> 	do_group_exit(ksig->info.si_signo);
>> 		do_exit
>> 			exit_task_work
>> 				task_work_run
>> 					kill_me_never
>> 						memory_failure
>>
> 
> Nice. I didn't realize that the exit code path would clear any pending task_work() requests.
> But it makes sense that this happens. Thanks for filling a gap in my knowledge.
> 
Yep, we could be benefit from it to unify memory failure handling :)

> -Tony
