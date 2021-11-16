Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615B4452B3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 07:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhKPHAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 02:00:45 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14749 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhKPHAa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 02:00:30 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HtcJG0sBczZd4c;
        Tue, 16 Nov 2021 14:55:10 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 16 Nov 2021 14:57:31 +0800
Received: from use12-sp2.huawei.com (10.67.189.20) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 16 Nov 2021 14:57:31 +0800
From:   Jubin Zhong <zhongjubin@huawei.com>
To:     <hch@infradead.org>
CC:     <kechengsong@huawei.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
        <wangfangpeng1@huawei.com>, <zhongjubin@huawei.com>
Subject: Re: [PATCH] fs: Fix truncate never updates m/ctime
Date:   Tue, 16 Nov 2021 14:57:28 +0800
Message-ID: <1637045848-56278-1-git-send-email-zhongjubin@huawei.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <YZNADLcSbgKp5Znh@infradead.org>
References: <YZNADLcSbgKp5Znh@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.20]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> It seems like you need to fix jffs2 to implement the proper semantics in its ->setattr.

Yes I have thought of this solution. However, when I tried to
track this problem down, I found that ftruncate() had similar
problem and it was fixed by commit 6e656be89999 ("ftruncate 
does not always update m/ctime"):

	diff --git a/fs/open.c b/fs/open.c
	index 5fb16e5267dc..303f06d2a7b9 100644
	--- a/fs/open.c
	+++ b/fs/open.c
	@@ -322,7 +322,7 @@ static long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
 
        error = locks_verify_truncate(inode, file, length);
        if (!error)
	-   	error = do_truncate(dentry, length, 0, file);
	+   	error = do_truncate(dentry, length, ATTR_MTIME|ATTR_CTIME, file);
 	out_putf:
        fput(file);
	 out:

In my opinion, there are two advantages if we fix it in
vfs_truncate():

1. All filesystems can reuse the scheme without adapting
Separately, just like what we did for ftruncate().

2. In the case when old_size = new_size, we can avoid
calling do_truncate() and return without doing anything.

Hope that you can consider my suggestion, thanks.
