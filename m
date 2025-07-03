Return-Path: <linux-fsdevel+bounces-53759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A87BAF6867
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 04:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50EE85225B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 02:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B804521B9C5;
	Thu,  3 Jul 2025 02:58:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1205218584;
	Thu,  3 Jul 2025 02:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751511529; cv=none; b=kI6vtx7qofdzEdduY3ZlhNqfuMSj0nMyxjcmsEFFb8rIn12t2z8tmq9oK6wkLvz+daf2UU27GhhglrqsUwLPlfnzY8qOIxi8eCmnIXqQI2+S2cvJRc/sWgdhWhvAWIGsnwtfhR0YLIvT8xQRYxHJqLdNI4fkO7axr9VlueAzQnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751511529; c=relaxed/simple;
	bh=jwUjFEWxHBZ9rdXV6wi51a49hj7ascJE8+tOw68DL+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gPnbAg0RY2FBoR/OEmjcd2mSodA+31kDcE6nmlHDnWb+W7Xn8Rlu2iXI+95N0r9rfB3ZyEpAmIn0dCLOtfULIaE7YEaRmecJ28XcyJ6OvxNQlq17ozvwF8uENVQxNXE9+sGTkkomVseJom4B1IRo1e5YxBROMbTZYDfpdTGgFOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bXhKw0QW2zYQvBZ;
	Thu,  3 Jul 2025 10:58:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E46161A13AD;
	Thu,  3 Jul 2025 10:58:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgDnSCbb8WVoZkTvAQ--.1132S4;
	Thu, 03 Jul 2025 10:58:42 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org,
	brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wozizhi@huawei.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH] cachefiles: Fix the incorrect return value in __cachefiles_write()
Date: Thu,  3 Jul 2025 10:44:18 +0800
Message-ID: <20250703024418.2809353-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDnSCbb8WVoZkTvAQ--.1132S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWxtF17tw4rXF4rXF1UWrg_yoW8ury5pF
	WayFyUKryxuF48Cr1kAFn5W34fJ3ykJFnFg34UWwn8Zwn8Xr4YgFWjqr1YqF1UArW7Jr43
	tw4jka43Jw1q9rJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IUbmii3UUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

In __cachefiles_write(), if the return value of the write operation > 0, it
is set to 0. This makes it impossible to distinguish scenarios where a
partial write has occurred, and will affect the outer calling functions:

 1) cachefiles_write_complete() will call "term_func" such as
netfs_write_subrequest_terminated(). When "ret" in __cachefiles_write()
is used as the "transferred_or_error" of this function, it can not
distinguish the amount of data written, makes the WARN meaningless.

 2) cachefiles_ondemand_fd_write_iter() can only assume all writes were
successful by default when "ret" is 0, and unconditionally return the full
length specified by user space.

Fix it by modifying "ret" to reflect the actual number of bytes written.
Furthermore, returning a value greater than 0 from __cachefiles_write()
does not affect other call paths, such as cachefiles_issue_write() and
fscache_write().

Fixes: 047487c947e8 ("cachefiles: Implement the I/O routines")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 fs/cachefiles/io.c       | 2 --
 fs/cachefiles/ondemand.c | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index c08e4a66ac07..3e0576d9db1d 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -347,8 +347,6 @@ int __cachefiles_write(struct cachefiles_object *object,
 	default:
 		ki->was_async = false;
 		cachefiles_write_complete(&ki->iocb, ret);
-		if (ret > 0)
-			ret = 0;
 		break;
 	}
 
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index d9bc67176128..a7ed86fa98bb 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -83,10 +83,8 @@ static ssize_t cachefiles_ondemand_fd_write_iter(struct kiocb *kiocb,
 
 	trace_cachefiles_ondemand_fd_write(object, file_inode(file), pos, len);
 	ret = __cachefiles_write(object, file, pos, iter, NULL, NULL);
-	if (!ret) {
-		ret = len;
+	if (ret > 0)
 		kiocb->ki_pos += ret;
-	}
 
 out:
 	fput(file);
-- 
2.46.1


