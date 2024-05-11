Return-Path: <linux-fsdevel+bounces-19293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB958C2F04
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 04:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F091C2122E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 02:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4AB1865A;
	Sat, 11 May 2024 02:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UV0TleTb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA42E8462
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 02:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715394483; cv=none; b=GhRejXTkda7X5rhQYwk3VS0cPmu5a7WMMp7M2trHJZBvW2+XJ2hXsTKs+aZviN6LBIdTihgJ31jsrrhAFnC5UP2Q/XkKtFnY4WUWl1ldhGjCRUbC3snZTMMte3iQCJjp9/LQe1Djl+3K6zUFqNSQ97UVHAr4Yjxt6tDgnq+A/9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715394483; c=relaxed/simple;
	bh=JmL6yJOEAslDnFvE2R7aY7gTBLqbGYfzOjGWxdtaaYA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Il5qJLgtVI9E9/Adwj1AM+aPp/VITqE5D/rlGcOCltyUb3Yoh3cl3b8yT+hJaoiR5/br1/AjZEkFyy6vSEXCv5DAS+K1z6+TVzaHe9J/nM7B8XKhGOeWdJkDS7JILZSAIuJH7z1UpLHz1d5FCegtHcyHOnEyUhGuxlZPcqXtgdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UV0TleTb; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2b6208c88dcso2112680a91.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 19:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715394481; x=1715999281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kwHtm1sGUNJLnDAeiauxoLqXXDP64gMW/Aa+gftXnyM=;
        b=UV0TleTb9XazwLGeVU3N/51qZjyT5gX9TmNFnsy3+B1cP3hicp1y11/onNMKNXmqts
         t7KZl4gdO88dtBVIaaNrQ5qc6yMCV292kEvTYvw+4ioxOjy+mOm2cChaX+d7S/scjc/o
         mAQ729qLZYcXC2eJAXBfmoJMS/k6alI5OrkPewBYd9H1U8DcXeXkB07DtG9xIHJdjyIf
         qkQZ/+j0mYpd8vwY4+/LJaQ0AdjpOqjdNqF0YAdZv/2yFykB3NnBlCsbSYttQY4pW2/X
         cm61ZEnZaNvC1hjDay8Sc5iKJklLzID+CZbkv0PVWbA1Ex3Omuz+kirfLYdQSIasn4b3
         Xdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715394481; x=1715999281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwHtm1sGUNJLnDAeiauxoLqXXDP64gMW/Aa+gftXnyM=;
        b=OpJvSKKCzQnWwARry60CuJYfxYqFOzF2W3+jmYj/EZ/Lstn8ZvlX9uOlGHHIhMMpkA
         z0lvtngkEb0a/BwuHsQtJNKyu0R5eogcfnUr0I8WPKxCMkDOUXgOfdpQf7GYnpt/DPNy
         4lH3s007Vg1M7rYaDZ4+dQ76SEBlm1YMVi/8FbiEl4ErpXJOeA4JfDgDMlZRLRNloJQZ
         JuWe5DYfuwlFsjgF97i3FNLHF7tjZHtZh4YjlM5T+1AiAMEyUviWsyjekQ956QZJWfxz
         VoKj21BJaF9qWJvfnags3vIUrYnorFB8ICkozj1+GUToklABRg0TPdpEhGi0e+JIzzEG
         +EYg==
X-Gm-Message-State: AOJu0Yw0h0oqOfHMJwAv4pTnHwO/yyd/XRPklc3HIU8YQHFenepEw1ns
	/mk1GcQGepRNI+vx6A70OTbOlao7ogrAgnW0WJ3m3Of+sdxJgUrR
X-Google-Smtp-Source: AGHT+IFPgEfQZRiNW7ttL2gs3fGDKfNGOI4xlqr7/8R/5HSwRYikQrfydhDnAqPcf8I695GoZLYIZg==
X-Received: by 2002:a17:903:2288:b0:1eb:dae:714f with SMTP id d9443c01a7336-1ef43c0ced6mr51710205ad.9.1715394480984;
        Fri, 10 May 2024 19:28:00 -0700 (PDT)
Received: from localhost.localdomain ([39.144.45.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d171esm39332615ad.55.2024.05.10.19.27.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2024 19:28:00 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Wangkai <wangkai86@huawei.com>,
	Colin Walters <walters@verbum.org>,
	Waiman Long <longman@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC PATCH] fs: dcache: Delete the associated dentry when deleting a file
Date: Sat, 11 May 2024 10:27:29 +0800
Message-Id: <20240511022729.35144-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our applications, built on Elasticsearch[0], frequently create and delete
files. These applications operate within containers, some with a memory
limit exceeding 100GB. Over prolonged periods, the accumulation of negative
dentries within these containers can amount to tens of gigabytes.

Upon container exit, directories are deleted. However, due to the numerous
associated dentries, this process can be time-consuming. Our users have
expressed frustration with this prolonged exit duration, which constitutes
our first issue.

Simultaneously, other processes may attempt to access the parent directory
of the Elasticsearch directories. Since the task responsible for deleting
the dentries holds the inode lock, processes attempting directory lookup
experience significant delays. This issue, our second problem, is easily
demonstrated:

  - Task 1 generates negative dentries: 
  $ pwd
  ~/test
  $ mkdir es && cd es/ && ./create_and_delete_files.sh

  [ After generating tens of GB dentries ]  

  $ cd ~/test && rm -rf es

  [ It will take a long duration to finish ]

  - Task 2 attempts to lookup the 'test/' directory
  $ pwd
  ~/test
  $ ls

  The 'ls' command in Task 2 experiences prolonged execution as Task 1
  is deleting the dentries.

We've devised a solution to address both issues by deleting associated
dentry when removing a file. Interestingly, we've noted that a similar
patch was proposed years ago[1], although it was rejected citing the
absence of tangible issues caused by negative dentries. Given our current
challenges, we're resubmitting the proposal. All relevant stakeholders from
previous discussions have been included for reference.

[0]. https://github.com/elastic/elasticsearch
[1]. https://patchwork.kernel.org/project/linux-fsdevel/patch/1502099673-31620-1-git-send-email-wangkai86@huawei.com

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Wangkai <wangkai86@huawei.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Colin Walters <walters@verbum.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 fs/dcache.c            | 4 ++++
 include/linux/dcache.h | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 71a8e943a0fa..4b97f60f0e64 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -701,6 +701,9 @@ static inline bool retain_dentry(struct dentry *dentry, bool locked)
 	if (unlikely(d_flags & DCACHE_DONTCACHE))
 		return false;
 
+	if (unlikely(dentry->d_flags & DCACHE_FILE_DELETED))
+		return false;
+
 	// At this point it looks like we ought to keep it.  We also might
 	// need to do something - put it on LRU if it wasn't there already
 	// and mark it referenced if it was on LRU, but not marked yet.
@@ -2392,6 +2395,7 @@ void d_delete(struct dentry * dentry)
 		spin_unlock(&dentry->d_lock);
 		spin_unlock(&inode->i_lock);
 	}
+	dentry->d_flags |= DCACHE_FILE_DELETED;
 }
 EXPORT_SYMBOL(d_delete);
 
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index bf53e3894aae..55a69682918c 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -210,7 +210,7 @@ struct dentry_operations {
 
 #define DCACHE_NOKEY_NAME		BIT(25) /* Encrypted name encoded without key */
 #define DCACHE_OP_REAL			BIT(26)
-
+#define DCACHE_FILE_DELETED		BIT(27) /* File is deleted */
 #define DCACHE_PAR_LOOKUP		BIT(28) /* being looked up (with parent locked shared) */
 #define DCACHE_DENTRY_CURSOR		BIT(29)
 #define DCACHE_NORCU			BIT(30) /* No RCU delay for freeing */
-- 
2.39.1


