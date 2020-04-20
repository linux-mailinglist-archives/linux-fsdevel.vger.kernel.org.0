Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E278D1B018E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 08:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgDTGXW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 02:23:22 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:57438 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgDTGXW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 02:23:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Tw2u4zK_1587363799;
Received: from 30.225.32.108(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0Tw2u4zK_1587363799)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 Apr 2020 14:23:19 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: Does have race between __mark_inode_dirty() and evict()
To:     tj@kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        joseph qi <joseph.qi@linux.alibaba.com>
Message-ID: <fdf7f9da-4516-f5c3-c5c9-06a1a3f8e55a@linux.alibaba.com>
Date:   Mon, 20 Apr 2020 14:23:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hi,

Recently we run into a NULL pointer dereference panic in our internal 4.9 kernel
it panics because inode->i_wb has become zero in wbc_attach_and_unlock_inode(),
and by crash tools analysis, inode's dirtied_when is zero, but dirtied_time_when
is not zero, seems that this inode has been used after free. Looking into both
4.9 and upstream codes, seems that there maybe a race:

__mark_inode_dirty(...)
{
     spin_lock(&inode->i_lock);
     ...
     if (inode->i_state & I_FREEING)
         goto out_unlock_inode;
     ...
     if (!was_dirty) {
         struct bdi_writeback *wb;
         struct list_head *dirty_list;
         bool wakeup_bdi = false;

         wb = locked_inode_to_wb_and_lock_list(inode);
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        this function will unlock inode->i_ilock firstly and then relock, but once the
inode->i_ilock is unlocked, evict() may run in, set I_FREEING flag, and free the inode,
and later locked_inode_to_wb_and_lock_list relocks inode->i_ilock again, but will not
check the I_FREEING flag again, so the use after free for this inode would happen.

I'm not familiar with vfs or cgroup writeback codes much, could you please confirm whether
this is an issue? Thanks.

Regards,
Xiaoguang Wang
