Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245AA545E31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 10:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347150AbiFJIJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 04:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbiFJIJj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:09:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBEA21D4BB;
        Fri, 10 Jun 2022 01:09:36 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LKD8t4MWCzgY7w;
        Fri, 10 Jun 2022 16:07:42 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 16:09:34 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 16:09:33 +0800
Subject: Re: [PATCH v4] proc: Fix a dentry lock race between release_task and
 lookup
To:     <ebiederm@xmission.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
References: <20220601062332.232439-1-chengzhihao1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <6e47d9b8-6b6e-e350-d688-1576f68211ed@huawei.com>
Date:   Fri, 10 Jun 2022 16:09:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20220601062332.232439-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

在 2022/6/1 14:23, Zhihao Cheng 写道:
friendly ping
> Commit 7bc3e6e55acf06 ("proc: Use a list of inodes to flush from proc")
> moved proc_flush_task() behind __exit_signal(). Then, process systemd
> can take long period high cpu usage during releasing task in following
> concurrent processes:
>
>    systemd                                 ps
> kernel_waitid                 stat(/proc/tgid)
>    do_wait                       filename_lookup
>      wait_consider_task            lookup_fast
>        release_task
>          __exit_signal
>            __unhash_process
>              detach_pid
>                __change_pid // remove task->pid_links
>                                       d_revalidate -> pid_revalidate  // 0
>                                       d_invalidate(/proc/tgid)
>                                         shrink_dcache_parent(/proc/tgid)
>                                           d_walk(/proc/tgid)
>                                             spin_lock_nested(/proc/tgid/fd)
>                                             // iterating opened fd
>          proc_flush_pid                                    |
>             d_invalidate (/proc/tgid/fd)                   |
>                shrink_dcache_parent(/proc/tgid/fd)         |
>                  shrink_dentry_list(subdirs)               ↓
>                    shrink_lock_dentry(/proc/tgid/fd) --> race on dentry lock
>
> Function d_invalidate() will remove dentry from hash firstly, but why does
> proc_flush_pid() process dentry '/proc/tgid/fd' before dentry '/proc/tgid'?
> That's because proc_pid_make_inode() adds proc inode in reverse order by
> invoking hlist_add_head_rcu(). But proc should not add any inodes under
> '/proc/tgid' except '/proc/tgid/task/pid', fix it by adding inode into
> 'pid->inodes' only if the inode is /proc/tgid or /proc/tgid/task/pid.
>
> Performance regression:
> Create 200 tasks, each task open one file for 50,000 times. Kill all
> tasks when opened files exceed 10,000,000 (cat /proc/sys/fs/file-nr).
>

