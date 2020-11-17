Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D142B5B77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 10:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgKQJBf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 04:01:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8103 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgKQJBf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:01:35 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cb0Kk5RJ8zLp4d;
        Tue, 17 Nov 2020 17:01:14 +0800 (CST)
Received: from [10.174.178.136] (10.174.178.136) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Tue, 17 Nov 2020 17:01:25 +0800
To:     <miklos@szeredi.hu>, <mszeredi@redhat.com>, <virtio-fs@redhat.com>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "liuzhiqiang (I)" <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>, <lixiaokeng@huawei.com>
From:   Haotian Li <lihaotian9@huawei.com>
Subject: [Question] How to deal D state on request_wait_answer?
Message-ID: <5ae3557a-0b87-e6c0-be41-8441026c400c@huawei.com>
Date:   Tue, 17 Nov 2020 17:01:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.136]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi
    We recently detected a bug in virtiofs.  Here, we created a
virtual machine as guest with Qemu and virtiofsd. We mounted
virtiofs on guest, for example /home/virtiofs. Then we killed
the virtiofsd in host and accessed /home/virtiofs in guest later.
This casued a process with D state which could not be killed.
The stack of the process as following:
      wait_event_interruptible
[<0>] request_wait_answer+0x9d/0x210 [fuse]
[<0>] __fuse_request_send+0x75/0x80 [fuse]
[<0>] fuse_simple_request+0x164/0x270 [fuse]
[<0>] fuse_do_getattr+0xd5/0x2a0 [fuse]
[<0>] vfs_statx+0x89/0xe0
[<0>] __do_sys_newstat+0x39/0x70
[<0>] do_syscall_64+0x55/0x1c0
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
    We have no idea to deal with the bug. Here, we have some
question about that:
    1. Why not use timeout mechanism?
    2. If timeout mechanism is used, the process will enter
 wait_event after wait_event_interruptible_timeout?
