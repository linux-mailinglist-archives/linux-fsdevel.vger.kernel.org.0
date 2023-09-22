Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0535D7AA6F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 04:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjIVCSi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 22:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjIVCSg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 22:18:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7F0CE;
        Thu, 21 Sep 2023 19:18:28 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RsG7x3PY9zVl1r;
        Fri, 22 Sep 2023 10:15:25 +0800 (CST)
Received: from [10.67.109.31] (10.67.109.31) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 22 Sep
 2023 10:18:25 +0800
Message-ID: <84e5fb5f-67c5-6d34-b93b-b307c6c9805c@huawei.com>
Date:   Fri, 22 Sep 2023 10:18:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From:   Cai Xinchen <caixinchen1@huawei.com>
Subject: [BUG?] fsconfig restart_syscall failed
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <dhowells@redhat.com>,
        <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.31]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello:
   I am doing some test for kernel 6.4, util-linux version:2.39.1.
Have you encountered similar problems? If there is a fix, please
let me know.
Thank you very much

--------------------------------------------------

util-linux version 2.39.1 call mount use fsopen->fsconfig->fsmount->close
instead of mount syscall.

And use this shell test:

#!/bin/bash
mkdir -p /tmp/cgroup/cgrouptest
while true
do
         mount -t cgroup -o none,name=foo cgroup /tmp/cgroup/cgrouptest
         ret=$?
         if [ $ret -ne 0 ];then
                 echo "mount failed , $ret"
         fi
         umount /tmp/cgroup/cgrouptest
         ret=$?
         if [ $ret -ne 0 ];then
                 echo "umount failed, $ret"
         fi
done

And as a result, we mount cgroup immediately after umount, it will return
failed.

in fsconfig syscall, we find this stack:

SYSCALL_DEFINE5(fsconfig, ...)
         vfs_fsconfig_locked
                 if (fc->phase != FS_CONTEXT_CREATE_PARAMS)
                         return -EBUSY;

                 vfs_get_tree
                         fc->ops->get_tree // cgroup1_get_tree
                                 if (!ret && !percpu_ref_tryget_live
(&ctx->root->cgrp.self.refcnt))
                                         ret = 1;
                                 ...
                                 if (unlikely(ret > 0)) {
                                         msleep(10);
                                         restart_syscall();
                                 }
                 ...
                 fc->phase = FS_CONTEXT_FAILED;

in mount syscall, no function will check fs->phase, and fc is recreate
in monnt syscall. However, in fdconfig syscall, fc->phase is not initial as
FS_CONTEXT_CREATE_PARAMS, restart_syscall will return -EBUSY. fc is created
in fsopen syscall.

