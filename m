Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A14FD339
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 04:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfKODUw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 22:20:52 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6672 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727187AbfKODUl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 22:20:41 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 251A92404E01104A0712;
        Fri, 15 Nov 2019 11:20:38 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 15 Nov 2019
 11:20:28 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <viro@zeniv.linux.org.uk>, <rostedt@goodmis.org>,
        <oleg@redhat.com>, <mchehab+samsung@kernel.org>, <corbet@lwn.net>,
        <tytso@mit.edu>, <jmorris@namei.org>
CC:     <yukuai3@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>, <chenxiang66@hisilicon.com>,
        <xiexiuqi@huawei.com>
Subject: [PATCH 0/3] fix potential infinite loop in debugfs_remove_recursive
Date:   Fri, 15 Nov 2019 11:27:49 +0800
Message-ID: <1573788472-87426-1-git-send-email-yukuai3@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The first patch add a new enum type for 'dentry_d_lock_class'.The second
patch use the new enum type in 'simple_empty' to avoid confusion for
lockdep. The last patch fix potential infinite loop in
debugfs_remove_recursive by using 'simple_empty' instead of 'list_empty'.

yu kuai (3):
  dcache: add a new enum type for 'dentry_d_lock_class'
  fs/libfs.c: use 'spin_lock_nested' when taking 'd_lock' for dentry in
    simple_empty
  debugfs: fix potential infinite loop in debugfs_remove_recursive

 fs/debugfs/inode.c     | 7 +++++--
 fs/libfs.c             | 4 ++--
 include/linux/dcache.h | 3 ++-
 3 files changed, 9 insertions(+), 5 deletions(-)

-- 
2.7.4

