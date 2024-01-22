Return-Path: <linux-fsdevel+bounces-8495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EF183765E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 23:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F991F215AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 22:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0674D122;
	Mon, 22 Jan 2024 22:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7hyQnCV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E324CB49
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 22:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705962789; cv=none; b=GjYYv02JcHXFXnphNIa1fAjOOfhLi1lpTt98G8XSNwhHzrILMHe3jdYIYkLWrvxLDo7z3mEX1eohd+OFI/5Nsz/qyTzfVkQbwtgI4xSqsbDjkn+pA2mTqEQFHopubQQKIzRZ/o/k24NY5OQpvjzRtbqHeVtZdDlb1q01g/SKC00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705962789; c=relaxed/simple;
	bh=BGYCQmdxuK36T0p5PfoL1bkyJdAK5JMIMZ5+TCMUjLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URlANSckTNYzEipp2piwu9MiQdV/tjX/srCupKHdTngK/jVkWupA024WxBhKHm5jYaQBrAsbYr2LNGhT1SBAfkgDIbyW6LENY6zkKIi9AHb8qvbE2l1i1GjNtSemI/PyJcMrn+Dh37VEmotC9ZySvBOmfo9mCxiyH/e0+DTZka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q7hyQnCV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705962787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2EbxtrFCFvcK5IiuVsAPW/KUPjjRaC8uqKzNdD5mRDM=;
	b=Q7hyQnCV4h6RGdy/5oB7d8KenQtE61HiCRbCdiua7LHAJsnLzwPaUuB100A+0Nel3ikHuM
	oODTrnU6CZJlixkVslN9hH/jG7HS4yc/AdCVjcO97tACsfBJpFJxg2ixs108NkAnxN/9I2
	Tyfcco+zYG0NgKjRsKkD7wdLkeJJTX8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-7Wyv8Y6KNviaO9h4wF-rXg-1; Mon, 22 Jan 2024 17:33:03 -0500
X-MC-Unique: 7Wyv8Y6KNviaO9h4wF-rXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FF28863062;
	Mon, 22 Jan 2024 22:33:03 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DC8335012;
	Mon, 22 Jan 2024 22:33:00 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2 10/10] afs: Fix missing/incorrect unlocking of RCU read lock
Date: Mon, 22 Jan 2024 22:32:23 +0000
Message-ID: <20240122223230.4000595-11-dhowells@redhat.com>
In-Reply-To: <20240122223230.4000595-1-dhowells@redhat.com>
References: <20240122223230.4000595-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

In afs_proc_addr_prefs_show(), we need to unlock the RCU read lock in both
places before returning (and not lock it again).

Fixes: f94f70d39cc2 ("afs: Provide a way to configure address priorities")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202401172243.cd53d5f6-oliver.sang@intel.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/proc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 3bd02571f30d..15eab053af6d 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -166,7 +166,7 @@ static int afs_proc_addr_prefs_show(struct seq_file *m, void *v)
 
 	if (!preflist) {
 		seq_puts(m, "NO PREFS\n");
-		return 0;
+		goto out;
 	}
 
 	seq_printf(m, "PROT SUBNET                                      PRIOR (v=%u n=%u/%u/%u)\n",
@@ -191,7 +191,8 @@ static int afs_proc_addr_prefs_show(struct seq_file *m, void *v)
 		}
 	}
 
-	rcu_read_lock();
+out:
+	rcu_read_unlock();
 	return 0;
 }
 


