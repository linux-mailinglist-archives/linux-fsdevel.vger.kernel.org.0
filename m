Return-Path: <linux-fsdevel+bounces-65588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A51AC088FD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 04:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9E264E22AF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 02:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF8F248868;
	Sat, 25 Oct 2025 02:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iJlbNIV2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3C6610D;
	Sat, 25 Oct 2025 02:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761360214; cv=none; b=d1oVM2b0m9Q+8TnHeq3fCHwvx25lZagki2SB6ilW6naDDUIAexcuxVoNR2qT3p0m6IrIvU9UimMAksEWMQ8+sR88kOJPCB4HIY4r1lkEf6CLMzULM3KYSemKmIrLUXOhOL04wENGXdSVyp+V5zjFpW0Pii5oAw3zJLLjQhhRvIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761360214; c=relaxed/simple;
	bh=QdAPGK5hXpf0G5m6pcdF7m7LqY3YmGZb7eU89/9gqGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IqJSlm5zHvTcC03A7ZYO7WIzyzDWB2AQRDAxEJDp/rE0w9UOjh5IwzvbLaLaTAA1LlKrmw9ZLWAClRp2RpMNyb+WM0mYPuy4p/lpwHxM44ikLahhIaWT9uipSKBAJqLBB/wwnyO+R9trZ8GrQZxqzYHfaCRUYqKlq2Zrh/jiSLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iJlbNIV2; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=yN
	l65k/kAeexTgDSNR6tWuwOKvH4IBPMLIdSVvUAofc=; b=iJlbNIV2UkMRMwbQlg
	z7lgnIyGtxcw+j57t63C3i3RDDmCiXfIgH7SqqJcO14vJmk8/5aWKxoVIi9paE6P
	pYMyTRJJzW4v3JOYootQlWvmSybvAehETtkg54axezXH+Hr5hFNGLZDjuvNaW1/A
	aQ6yjXOkZJ8P0M36qVOqXihwk=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBHn9cwOfxoc1hRBQ--.47S2;
	Sat, 25 Oct 2025 10:42:57 +0800 (CST)
From: albin_yang@163.com
To: akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	wangzijie1@honor.com,
	brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: albinwyang@tencent.com
Subject: [PATCH] fs/proc: fix uaf in proc_readdir_de()
Date: Sat, 25 Oct 2025 10:42:33 +0800
Message-ID: <20251025024233.158363-1-albin_yang@163.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBHn9cwOfxoc1hRBQ--.47S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF18XFWDtFy3KF4xKFyUWrg_yoW5AF45pF
	W3WrW3Gr48WFn8Gr1Sqr1DCF48uF15Aa1akr4xua1IyrsFvryxJr4rtFy8try7AFWrGa4Y
	qF4jg3srArykA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7txhUUUUU=
X-CM-SenderInfo: pdoex0xb1d0wi6rwjhhfrp/1tbiShbxomj8NBwwJgABsk

From: Wei Yang <albinwyang@tencent.com>

Pde is erased from subdir rbtree through rb_erase(), but not set the node to EMPTY,
which may result in uaf access. We should use RB_CLEAR_NODE() set the erased node
to EMPTY, then pde_subdir_next() will return NULL to avoid uaf access.

We found an uaf issue while using stree-ng testing, need to run testcase getdent and
tun in the same time. The steps of the issue is as follows:
1) use getdent to traverse dir /proc/pid/net/dev_snmp6/, and current pde is tun3;
2) in the [time windows] unregister netdevice tun3 and tun2, and erase them from
   rbtree. erase tun3 first, and then erase tun2. the pde(tun2) will be released
   to slab;
3) continue to getdent process, then pde_subdir_next() will return pde(tun2) which
   is released, it will case uaf access.

CPU 0                                      |    CPU 1
----------------------------------------------------------------------------------------------
traverse dir /proc/pid/net/dev_snmp6/      |   unregister_netdevice(tun->dev)   //tun3 tun2
sys_getdents64()                           |
  iterate_dir()                            |
    proc_readdir()                         |
      proc_readdir_de()                    |     snmp6_unregister_dev()
        pde_get(de);                       |       proc_remove()
        read_unlock(&proc_subdir_lock);    |         remove_proc_subtree()
                                           |           write_lock(&proc_subdir_lock);
        [time window]                      |           rb_erase(&root->subdir_node, &parent->subdir);
                                           |           write_unlock(&proc_subdir_lock);
        read_lock(&proc_subdir_lock);      |
        next = pde_subdir_next(de);        |
        pde_put(de);                       |
        de = next;    //UAF                |

rbtree of dev_snmp6
                        |
                    pde(tun3)
                     /    \
                  NULL  pde(tun2)

Signed-off-by: Wei Yang <albinwyang@tencent.com>
---
 fs/proc/generic.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 176281112273..501889856461 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -698,6 +698,12 @@ void pde_put(struct proc_dir_entry *pde)
 	}
 }
 
+static void pde_erase(struct proc_dir_entry *pde, struct proc_dir_entry *parent)
+{
+	rb_erase(&pde->subdir_node, &parent->subdir);
+	RB_CLEAR_NODE(&pde->subdir_node);
+}
+
 /*
  * Remove a /proc entry and free it if it's not currently in use.
  */
@@ -720,7 +726,7 @@ void remove_proc_entry(const char *name, struct proc_dir_entry *parent)
 			WARN(1, "removing permanent /proc entry '%s'", de->name);
 			de = NULL;
 		} else {
-			rb_erase(&de->subdir_node, &parent->subdir);
+			pde_erase(de, parent);
 			if (S_ISDIR(de->mode))
 				parent->nlink--;
 		}
@@ -764,7 +770,7 @@ int remove_proc_subtree(const char *name, struct proc_dir_entry *parent)
 			root->parent->name, root->name);
 		return -EINVAL;
 	}
-	rb_erase(&root->subdir_node, &parent->subdir);
+	pde_erase(root, parent);
 
 	de = root;
 	while (1) {
@@ -776,7 +782,7 @@ int remove_proc_subtree(const char *name, struct proc_dir_entry *parent)
 					next->parent->name, next->name);
 				return -EINVAL;
 			}
-			rb_erase(&next->subdir_node, &de->subdir);
+			pde_erase(next, de);
 			de = next;
 			continue;
 		}
-- 
2.43.7


