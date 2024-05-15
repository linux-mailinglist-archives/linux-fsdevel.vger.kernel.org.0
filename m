Return-Path: <linux-fsdevel+bounces-19513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A7D8C6383
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 11:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000F01C20FAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 09:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111D557CB5;
	Wed, 15 May 2024 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ6ceIxw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5804157C8D;
	Wed, 15 May 2024 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715764667; cv=none; b=X4hy3rf7+5z/ZTlAqUQsXsKwYcJ7T2nqavmN6Z1FoiOOXMqrQBE2ttVgo8NhTre7/3dimq09FeByWfA7vQ69ZimQ4jdIy2AfZQ4XRqJZx7VJ5wZbOKOexWc9YM6YawzJ0Zv8dlJy6KZHqrp8GLLFH+JIsd70J7yLJMlWQhxZ/wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715764667; c=relaxed/simple;
	bh=97fJlRl8dJOpcgfN1cVebIQsfS1pVOcf9fB3mVSPx5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=swnr3r+xtWMvlOmLUlXPgyNrx+jYATMDbULCKgqmUR/6eHkssxhkLF3oDQhFWGUFLEzr4KmW9sgctOw05hIo0gj/asWh2pRg6ifaRKHydrcWr4B6IBcarLm7LvLOhFm1urP6D9XkT5Zh8tfcMoV3HOTnB5RZx+Cl8sTPyyxB2Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJ6ceIxw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ed835f3c3cso57207185ad.3;
        Wed, 15 May 2024 02:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715764665; x=1716369465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Wv8rV2tKPThsseCMW82u6ARIGWeqVn1KtBaNU4oLcc=;
        b=KJ6ceIxw6eDuVGLik8cMQCftF/XcDBDwtVe/ffdaxPmRVfMq+tLDtoCaALSnxw0Z6m
         ZWTAwzfwS753qSETjfTwZCQp2gqju4Vqor5nlRMabAp1+cHJ237EzQWDARmOLPQG/ui8
         6Uw6J/WZslyiDhv1Z0oKUaJGO2K6GgstHhWkZIYT+oYHp3KrrKAr7kelVmuWKtAmPncR
         +SPC1Fk6VBbhcBsVUdWX9aWDBSMwd49TeEf7LjUA9jFsTaOc1S7s+N4idQbm/ByzyygZ
         +AmL8rHGL072ljSzcAn6RbUj/Q9fp+09RXucO2M3l/w4/LbD/R6pnJxX2K7L/7oqNg4e
         D5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715764665; x=1716369465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Wv8rV2tKPThsseCMW82u6ARIGWeqVn1KtBaNU4oLcc=;
        b=Qpe9g3jUDDNq9Z6e++IRhU4yI364ZmRpAx3qa7PZURLs3/9Jj/OSXtAZu/2vV9QNEj
         8u1gBskuuXyldmnvijuMHCeBju9xMtA8il7zhid2sab/tkhn5TwiYEoxTppzyxDnZCHF
         xM0XlYzNv1UKI/xaW/wOoNcygmk+xZUO/mxjoRCYUJfTubPd/QfWibThqd7wTwIpHdkX
         Z8DKZjovLhkgmYxelwivVzjvSo7D/frSu+GMdisf0TQnZMAaGXsL1i9EqsUOhV7fNl1w
         RGeBWYUzMaWTSkadq0J9cwP/PXkCsT6YpbvCSWyZq+rPtLuJdqJpN1lpYIcaP/7dx28r
         Tvaw==
X-Forwarded-Encrypted: i=1; AJvYcCVu5feVg8knOSRGsxQrt45s2UBjpWl0B9B8UAL83FMI+79X5DrsEZyTrFsMDCtBqyYHr4ClzCqBFtT+p1yO/igPBpxY3jTT64WDvM5CwE1aim+H+D8nI0dNwoHcuKZRucxppcWHyzTuSteT3Q==
X-Gm-Message-State: AOJu0YxDBV1Xm506XiCYCSFkikwwi9stbDNK1XFcPZTWl07bOch2Q3Ib
	N4v9zhjnLSMKB5WCQ1zjAdbBcIseZLERWmv3ahAbqnALv9HUUMj0
X-Google-Smtp-Source: AGHT+IFtmVf7oEws1uF1l3m/5X3gzrEYi5mE17gV2Q6owMBXhDKxbWShPbXhK8zPO76YBGJxCnbDkQ==
X-Received: by 2002:a17:902:ec8b:b0:1eb:1129:7f15 with SMTP id d9443c01a7336-1ef4404a272mr202174455ad.46.1715764664621;
        Wed, 15 May 2024 02:17:44 -0700 (PDT)
Received: from localhost.localdomain ([39.144.45.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30fb1sm113304135ad.177.2024.05.15.02.17.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2024 02:17:44 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	laoar.shao@gmail.com,
	linux-fsdevel@vger.kernel.org,
	longman@redhat.com,
	viro@zeniv.linux.org.uk,
	walters@verbum.org,
	wangkai86@huawei.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] vfs: Delete the associated dentry when deleting a file
Date: Wed, 15 May 2024 17:17:27 +0800
Message-Id: <20240515091727.22034-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <CAHk-=whHsCLoBsCdv2TiaQB+2TUR+wm2EPkaPHxF=g9Ofki7AQ@mail.gmail.com>
References: <CAHk-=whHsCLoBsCdv2TiaQB+2TUR+wm2EPkaPHxF=g9Ofki7AQ@mail.gmail.com>
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

Some alternative solutions are also under discussion[2][3], such as
shrinking child dentries outside of the parent inode lock or even
asynchronously shrinking child dentries. However, given the straightforward
nature of the current solution, I believe this approach is still necessary.

[0]. https://github.com/elastic/elasticsearch
[1]. https://patchwork.kernel.org/project/linux-fsdevel/patch/1502099673-31620-1-git-send-email-wangkai86@huawei.com
[2]. https://lore.kernel.org/linux-fsdevel/20240511200240.6354-2-torvalds@linux-foundation.org/
[3]. https://lore.kernel.org/linux-fsdevel/CAHk-=wjEMf8Du4UFzxuToGDnF3yLaMcrYeyNAaH1NJWa6fwcNQ@mail.gmail.com/

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Waiman Long <longman@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Wangkai <wangkai86@huawei.com>
Cc: Colin Walters <walters@verbum.org>
---
 fs/dcache.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 71a8e943a0fa..2ffdb98e9166 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2360,19 +2360,17 @@ EXPORT_SYMBOL(d_hash_and_lookup);
  * - unhash this dentry and free it.
  *
  * Usually, we want to just turn this into
- * a negative dentry, but if anybody else is
- * currently using the dentry or the inode
- * we can't do that and we fall back on removing
- * it from the hash queues and waiting for
- * it to be deleted later when it has no users
+ * a negative dentry, but certain workloads can
+ * generate a large number of negative dentries.
+ * Therefore, it would be better to simply
+ * unhash it.
  */
  
 /**
  * d_delete - delete a dentry
  * @dentry: The dentry to delete
  *
- * Turn the dentry into a negative dentry if possible, otherwise
- * remove it from the hash queues so it can be deleted later
+ * Remove the dentry from the hash queues so it can be deleted later.
  */
  
 void d_delete(struct dentry * dentry)
@@ -2381,14 +2379,14 @@ void d_delete(struct dentry * dentry)
 
 	spin_lock(&inode->i_lock);
 	spin_lock(&dentry->d_lock);
+	__d_drop(dentry);
+
 	/*
 	 * Are we the only user?
 	 */
 	if (dentry->d_lockref.count == 1) {
-		dentry->d_flags &= ~DCACHE_CANT_MOUNT;
 		dentry_unlink_inode(dentry);
 	} else {
-		__d_drop(dentry);
 		spin_unlock(&dentry->d_lock);
 		spin_unlock(&inode->i_lock);
 	}
-- 
2.30.1 (Apple Git-130)


