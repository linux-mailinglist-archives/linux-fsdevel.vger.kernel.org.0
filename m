Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E70710DC0B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 02:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfK3BlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Nov 2019 20:41:18 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39558 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727142AbfK3BlR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Nov 2019 20:41:17 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 569BD39B753B849EAA34;
        Sat, 30 Nov 2019 09:41:15 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Sat, 30 Nov 2019
 09:41:06 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <viro@zeniv.linux.org.uk>, <rostedt@goodmis.org>,
        <oleg@redhat.com>, <mchehab+samsung@kernel.org>, <corbet@lwn.net>,
        <tytso@mit.edu>, <jmorris@namei.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <yukuai3@huawei.com>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>, <chenxiang66@hisilicon.com>,
        <xiexiuqi@huawei.com>
Subject: [PATCH V2 0/3] fix potential infinite loop in debugfs_remove_recursive
Date:   Sat, 30 Nov 2019 10:02:22 +0800
Message-ID: <20191130020225.20239-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The main purpose of this patchset is to fix potential infinite loop in
debugfs_remove_recursive. Al Viro want to refactor it
(https://lore.kernel.org/lkml/20191115184209.GT26530@ZenIV.linux.org.uk/).
I can't really tell if it's better. Since debugfs_remove_recursive is
still using 'simple_empty', whitch is wrong, I'm sending this patchset
just in case.

The first patch add a new enum type for 'dentry_d_lock_class'.The second
patch use the new enum type in 'simple_empty' to avoid confusion for
lockdep. The last patch fix potential infinite loop in
debugfs_remove_recursive by using 'simple_empty' instead of 'list_empty'.

changes in V2:
rename the new enum type in the first patch, add some comments.


yu kuai (3):
  dcache: add a new enum type for 'dentry_d_lock_class'
  fs/libfs.c: use 'spin_lock_nested' when taking 'd_lock' for dentry in
    simple_empty
  debugfs: fix potential infinite loop in debugfs_remove_recursive

 fs/debugfs/inode.c     |  7 +++++--
 fs/libfs.c             |  4 ++--
 include/linux/dcache.h | 11 ++++++++++-
 3 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.17.2

