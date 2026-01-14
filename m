Return-Path: <linux-fsdevel+bounces-73756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC87D1F904
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60BEB308E603
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD72A30C631;
	Wed, 14 Jan 2026 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CgJP9dG/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IhFhZqbn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B5330E0F0
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402439; cv=none; b=DgJ7ow1sDNVjfJ5ucsk34ptQpVqDTrc2Ag8PCeJx58zNUYTSYlcgBX7uuy2cchfDpsCEDCvz+BtpFw0yN0fKN3lY2gACetIbaTiC5OoJURY3mz719e0CRUaMdl7FJOotig9zQ4tN3emq9MG74pxPQAx6QeivRsuiiVPN01o5jrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402439; c=relaxed/simple;
	bh=TeFpHi3OadLODwTeU3cLvwWccEE5trzQ3l72/BRpWCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyPvKSDt9XBWJWnOlFaAe9aUdw0RqCQKAUBgGvU7Zskl/yN3wdIVaAas0Wh/N9l5MVslsI/7ED0ib+a5ByP4cPIluODu0yxEumJrOaI9+GUMcF4hG5P9MbYFiFlYyllqdDcbBmeXqbDjG/lOmfYTPN7vP9HsKa5Vd83ugIufvE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CgJP9dG/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IhFhZqbn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768402436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l/MdpdF6O35DO5R69+eDuTZv5XXA0pHiEm5pcvnzXwY=;
	b=CgJP9dG/JsRhs9GTxylJEIViZ21eALGhtxJVnJpyinSycALNNqKLNTJ5RbibQRMmXI7pje
	3TQx5Vk/21Kl5i8aN2nFrb66C+X4q/QlNpvsEUzAfMMN4HjTRBze7QQnSTDsMlKHvvsi+L
	HBSxZYBfiE9hCImsaxWgCEMbGfOlWZU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-0aQrE59mPo2uFEcHL0tpxQ-1; Wed, 14 Jan 2026 09:53:54 -0500
X-MC-Unique: 0aQrE59mPo2uFEcHL0tpxQ-1
X-Mimecast-MFC-AGG-ID: 0aQrE59mPo2uFEcHL0tpxQ_1768402433
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b7fe37056e1so915471466b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 06:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768402433; x=1769007233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/MdpdF6O35DO5R69+eDuTZv5XXA0pHiEm5pcvnzXwY=;
        b=IhFhZqbnMfvS9n2UQk+A1fKsiROOftudHucHBchmy9M3UUh2JbIQQ1rRc29mYsn1Ri
         Febj5NdPS2kjW2JdIugYylYP4GAokJQRQ6yudnfl6R6DZ8h9CV7QweZ2ieIW8+kh52lP
         Itun3QZAQj7aOH/B8BmSlsAOskomLArMBy5asyWR7yz7iXKhqyS6tiE+DFdZDreP2Kjv
         xIbQ70DG1oxSuZiuvwTt2cVCXydbcEMqr2IOOkAf8XotRt4ijAUn/tdy9eij8zic1HnS
         /ajGOUjo3B1Suf7PTxbpY7jsW/z66Q7NIqiC3r8AE+lSrjmuvUKyn+LZvqzBJ30SBv2H
         T9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768402433; x=1769007233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l/MdpdF6O35DO5R69+eDuTZv5XXA0pHiEm5pcvnzXwY=;
        b=Vb+T4kJz0obJG/hp809hJPRMELzbMgUCRNY8QtQOoaHv/B1HE1WTC5wsx9iLVs2AFL
         l+upOkgyP5EWc2Mb9otdWOKrzW9TXg5arubaZVdwSnITMSMfZZz8iJUrHhqB9SqLcz/y
         qS0V1Q3XuIPqTtdwBUGCm2HybcRXQesLdaswJ8zpXvkfhxgZ8OQ2O8OWRV+BQRS+rdSw
         0xuu6d+8EVcxGN35sT5nB5reRAwEmowdV0vix4XiYGp2VSDqINctzqtv2zygTtp94phO
         gNQ5FOBCb++d8aCt0KqrOXvHt0R5FiTAJiu8/0cgJbXQL+vve5a+w6AEYsXB+Z1pGa/B
         STVQ==
X-Gm-Message-State: AOJu0YwI/7VRvBCYfnl/6NMqMgdNftTQ46qIJaQ1E0BnbsmXbD7Xd5B4
	nLvXkpt8eN61jvYokOFaUL9uYh3ic2VqJdAIJdnZWVvM4IK/CldGDewcLUWtS0vuenCcwJjjWuK
	XNSY4FAH9vxCMxm/XWixIKR/UjdR9Bcq4mrdrLteyhZeAHoiq/pbft1OF1kuVZCgOFrz6O/+1hi
	6CDredVngeqgi2XPZU9jPvCXZj46c3MuvsLLOnSTt61bUtLhEr2Ow=
X-Gm-Gg: AY/fxX60tm9BR62+ZAuCLxJyeJqHhx2F6pijUqn108KKZvOiK1xJIM0C7FnR0vMGXPe
	AXLUIB7VIM5nmWWbcicMQUs0JY6LqJo0LpyNe5zvSRWxfKBOXv6FSBDuoUqbTBUvSXJmLhbakzL
	OTEYc1KcAD/XmRnJfi2n1spima5F8xqgtAUMRA1AvP1VjOYNK3Ot665lNpPO9Ex3baq/gOgTQTt
	U/IDiAbpsSEAJV7hUE+KpbR2Eq9v8wFwqSOL1ehTC3ky2lKBrrQsBYNUbUzOFziBJIq3EE10uX2
	yCDVdUrfjgsOJ8m+nFVxZTY4QYirSPsmwA3AEFFrf+aTNmyNB5xrXKZL2IapqGCz7HliNuwjYdu
	I9nutFVsrRW7mfqrr1uO8IVw/s6D7/hfCZTDPoxnHJnAiHWFXQYjTroOb81YKhuzO
X-Received: by 2002:a17:906:4fcb:b0:b86:fd46:724 with SMTP id a640c23a62f3a-b8760f94c82mr257264766b.13.1768402433232;
        Wed, 14 Jan 2026 06:53:53 -0800 (PST)
X-Received: by 2002:a17:906:4fcb:b0:b86:fd46:724 with SMTP id a640c23a62f3a-b8760f94c82mr257262066b.13.1768402432716;
        Wed, 14 Jan 2026 06:53:52 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (193-226-246-7.pool.digikabel.hu. [193.226.246.7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6d5absm23059608a12.33.2026.01.14.06.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 06:53:52 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Luis Henriques <luis@igalia.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 5/6] fuse: shrink once after all buckets have been scanned
Date: Wed, 14 Jan 2026 15:53:42 +0100
Message-ID: <20260114145344.468856-6-mszeredi@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114145344.468856-1-mszeredi@redhat.com>
References: <20260114145344.468856-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In fuse_dentry_tree_work() move the shrink_dentry_list() out from the loop.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d8dd515d4bd6..fc1734758c8a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -187,8 +187,8 @@ static void fuse_dentry_tree_work(struct work_struct *work)
 			node = rb_first(&dentry_hash[i].tree);
 		}
 		spin_unlock(&dentry_hash[i].lock);
-		shrink_dentry_list(&dispose);
 	}
+	shrink_dentry_list(&dispose);
 
 	if (inval_wq)
 		schedule_delayed_work(&dentry_tree_work,
-- 
2.52.0


