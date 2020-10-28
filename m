Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F98E29D5DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 23:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbgJ1WJY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:09:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6660 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730255AbgJ1WJA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:09:00 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CLYLp2Sfqz15M2S;
        Wed, 28 Oct 2020 11:04:02 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.238) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Wed, 28 Oct 2020
 11:03:53 +0800
To:     <viro@zeniv.linux.org.uk>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
CC:     <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <cai@redhat.com>
Subject: [PATCH] pipe: fix potential inode leak in create_pipe_files()
Message-ID: <779f767d-c08b-0c03-198e-06270100d529@huawei.com>
Date:   Wed, 28 Oct 2020 11:03:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.238]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


In create_pipe_files(), if alloc_file_clone() fails, we will call
put_pipe_info to release pipe, and call fput() to release f.
However, we donot call iput() to free inode.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Signed-off-by: Feilong Lin <linfeilong@huawei.com>
---
 fs/pipe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/pipe.c b/fs/pipe.c
index 0ac197658a2d..8856607fde65 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -924,6 +924,7 @@ int create_pipe_files(struct file **res, int flags)
 	if (IS_ERR(res[0])) {
 		put_pipe_info(inode, inode->i_pipe);
 		fput(f);
+		iput(inode);
 		return PTR_ERR(res[0]);
 	}
 	res[0]->private_data = inode->i_pipe;
-- 
2.19.1


