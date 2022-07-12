Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD5D5710A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 05:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiGLDHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 23:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiGLDGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 23:06:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3146A509CB;
        Mon, 11 Jul 2022 20:06:32 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LhltJ6L45zVfhN;
        Tue, 12 Jul 2022 11:02:48 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Jul 2022 11:06:17 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Jul 2022 11:06:16 +0800
Subject: Re: [PATCH v4] proc: Fix a dentry lock race between release_task and
 lookup
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <ebiederm@xmission.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <yukuai3@huawei.com>, Matthew Wilcox <willy@infradead.org>,
        <bhe@redhat.com>, <bfoster@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <kaleshsingh@google.com>
References: <20220601062332.232439-1-chengzhihao1@huawei.com>
 <6e47d9b8-6b6e-e350-d688-1576f68211ed@huawei.com>
Message-ID: <b7df85db-8e02-8a0f-000f-b36eccf4505e@huawei.com>
Date:   Tue, 12 Jul 2022 11:06:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <6e47d9b8-6b6e-e350-d688-1576f68211ed@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

在 2022/6/10 16:09, Zhihao Cheng 写道:
> 在 2022/6/1 14:23, Zhihao Cheng 写道:
ping again.
> friendly ping
>> Commit 7bc3e6e55acf06 ("proc: Use a list of inodes to flush from proc")
>> moved proc_flush_task() behind __exit_signal(). Then, process systemd
>> can take long period high cpu usage during releasing task in following
>> concurrent processes:
>>
>>    systemd                                 ps
>> kernel_waitid                 stat(/proc/tgid)
>>    do_wait                       filename_lookup
>>      wait_consider_task            lookup_fast
>>        release_task
>>          __exit_signal
>>            __unhash_process
>>              detach_pid
>>                __change_pid // remove task->pid_links
>>                                       d_revalidate -> pid_revalidate  
>> // 0
>>                                       d_invalidate(/proc/tgid)
>>                                         shrink_dcache_parent(/proc/tgid)
>>                                           d_walk(/proc/tgid)
>>                                             
>> spin_lock_nested(/proc/tgid/fd)
>>                                             // iterating opened fd
>>          proc_flush_pid                                    |
>>             d_invalidate (/proc/tgid/fd)                   |
>>                shrink_dcache_parent(/proc/tgid/fd)         |
>>                  shrink_dentry_list(subdirs)               ↓
>>                    shrink_lock_dentry(/proc/tgid/fd) --> race on 
>> dentry lock
>>
>> Function d_invalidate() will remove dentry from hash firstly, but why 
>> does
>> proc_flush_pid() process dentry '/proc/tgid/fd' before dentry 
>> '/proc/tgid'?
>> That's because proc_pid_make_inode() adds proc inode in reverse order by
>> invoking hlist_add_head_rcu(). But proc should not add any inodes under
>> '/proc/tgid' except '/proc/tgid/task/pid', fix it by adding inode into
>> 'pid->inodes' only if the inode is /proc/tgid or /proc/tgid/task/pid.
>>
>> Performance regression:
>> Create 200 tasks, each task open one file for 50,000 times. Kill all
>> tasks when opened files exceed 10,000,000 (cat /proc/sys/fs/file-nr).
>>
> 
> .

