Return-Path: <linux-fsdevel+bounces-79337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cG+QK4AKqGn2nQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 11:33:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E441FE65F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 11:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B82730CC185
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 10:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799043A255F;
	Wed,  4 Mar 2026 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GI7h/3MW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB413A255E
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772620065; cv=none; b=ja+Hk1jaoBw0UVsKKFnKY2juCmgeOIH9GzlWLQQDJ4zmFewImNEvl54R5WhGVtVkoH7ZTovvQeY+2YlnMuQI2Jb/RD8h2Rqgh06GtIgUKJ1JGwPXmhxqbwZ4BOYVyNQXmuHq4enDpCEWCucY+gj3BVt3bUX/ZePH/dyi177/FgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772620065; c=relaxed/simple;
	bh=E100ka1dL4bibW3CFmfapEd76zJ5jr+xC7IyF30CAHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WJlQDWKG2pzNLpyD5yeryeOqy7hPnGhfeo8nE70cSQw2vt8WRP10qHHLvDfJGMzhPZPf+BF3DuYamsTaLvH/MKWWhVyZbhck2Qd+Mzu9YoY87rqN8SKSJMa9FlWUciRa4jDSJB3LsJSRAmZPxL0EzJEY0HJ1IkNimysI6VAl1sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GI7h/3MW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ab39b111b9so31771035ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Mar 2026 02:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772620063; x=1773224863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BlvRFcaaKrlIcfTaPcJpKe4F/scRPAHs6ZtzwYHkQv0=;
        b=GI7h/3MW7j8dUW6bl+bBc8qjMACjPLUkmIFa8bhQCR6xBBZ5SzBcByP0RNk06NGiqz
         UTh2dv9Bs9MtPcXTBcQY92F+CBv5gSHDYx/DupmUlvAXMJIUY2hoAMd/6NYs3kt7Akic
         7/uGNrbRAJ1EBqeUQVR2xQcx9M0m9CO75Xi48ueDahY60/jvlx9U22xeQaJQoVuQKfrW
         1KbEJIC3MvLv+f2PbCk+CsA8Q/Vyn1b8dqElOU2srv/sXdsK1fMiYENqJwXqhmmHmkGY
         Ybem8PpAgOA5DGfzr2rkFObsZt9iWVM6MnHqd8K5wweKmqF9DVGar2hNiR5BDcMOwdz9
         BhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772620063; x=1773224863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlvRFcaaKrlIcfTaPcJpKe4F/scRPAHs6ZtzwYHkQv0=;
        b=ZksdbYXalgbw9bK8POwIonPlkG5UOzithdBJ9bAnMWAJL4e0GOfuVwiDvfkvVYQMxb
         oMimwuLD/UYiI/iS0gZcUDOABH/I6Pg0Fo5BKzOWJLfU+6nY0HOFozNWC9VYV42f2JMY
         3lHqUuOGwEc82xK2zZ0V3yADFbsp1W42XE3DdJYcF0cpFKqS3QFyTWpShAtYSRijlJtB
         I05n/xlbvjzBtArqp50GGrKcEH9pKu9XKltH2E5ad5Ux4JHRIs7RXC4EagmZLpB3ialh
         pfIXJQ1w7ZHrAU0N0UcmJZEOSijNgP0qyEEqW6eULN37kdVWe21uzqRUCP+oS+pZfsmx
         UvkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYr4cUs8QbRvykZUX4DhcNT89u91JV8lsXQZ783LtHNZpUcmtWXu0BmumP/CKWh13B8Cs7St4qD974brTJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzaA0vpSOIOMNKPIzZtgtrYTv6De9wbh3xpCsyJqVUgY+gxi5ab
	+APZ1txW6fNn5K3D2BE8Fr7LZ2OCbbVhrKkM6suwu9hF+GD71qBoNXapW8xVRGKxfTc=
X-Gm-Gg: ATEYQzwliVbXrixO3lzw/m5v4OIdXRt8FdObkmYp0dy8hLADpy5pfB01xAT7oCaFwA9
	JJ5rDYpHLg4QV37SHWzVus5FEQwnmp2MPm0IHcvZzZLl1hQqTRXg1xQPm8bValOF2u0qdukmEjs
	ED+ofN0Qs72Wc6V8Dd0yH37DTNyuLmR1kDJojV1xtMapZCgD8faeHO83AF2iz6GGUOLSx59aLhE
	2xqutXvGU4a3THxhGxr+uxaTi5RhBX+a3scUsCgKc6v3B9O2wuwsikOklm5K6fX/5NY24YsCzEr
	EjH5sF+GyU9gzg9oohykDxuyZL5O86qCl4fxZtcaaVbsQBiS5ETUSBpLzOUlpvV6NtyTIDC7lm3
	dQ428sHCdl/aCe7iEIteb2s75RaDS8Wkz3iQhSQrU47FtTlcLUVgGUNtWGt8408yIxOvfdZIWWS
	zZg2FzScoa60m9nzs1V0qK84727st3C4PBhQ==
X-Received: by 2002:a17:902:db0f:b0:2ad:6e26:abbb with SMTP id d9443c01a7336-2ae6ab9ecd3mr14619845ad.54.1772620063275;
        Wed, 04 Mar 2026 02:27:43 -0800 (PST)
Received: from yangwen.localdomain ([121.225.53.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c3b01sm202391855ad.31.2026.03.04.02.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 02:27:42 -0800 (PST)
From: Yang Wen <anmuxixixi@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Wen <anmuxixixi@gmail.com>
Subject: [PATCH v3] exfat: initialize caching fields during inode allocation
Date: Wed,  4 Mar 2026 18:27:32 +0800
Message-ID: <20260304102732.3928-1-anmuxixixi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 25E441FE65F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[sony.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-79337-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anmuxixixi@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

exfat_alloc_inode() does not initialize the cache_lru list head of
struct exfat_inode_info.

If an inode is evicted before its cache structures are properly
initialized (e.g., during a forced unmount), the cleanup
path in __exfat_cache_inval_inode() may observe an uninitialized
list head.

The check:

    while (!list_empty(&ei->cache_lru))

may incorrectly succeed when stale pointers remain from a reused
slab object. Subsequent list traversal can then operate on invalid
entries, potentially leading to a NULL pointer dereference or
memory corruption.

Initialize cache_lru, cache_lru_lock, nr_caches, and cache_valid_id
in exfat_alloc_inode() to ensure a well-defined state at allocation
time.

Signed-off-by: Yang Wen <anmuxixixi@gmail.com>
---
 fs/exfat/super.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 83396fd265cd..4f99986f390a 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -195,6 +195,12 @@ static struct inode *exfat_alloc_inode(struct super_block *sb)
 	if (!ei)
 		return NULL;
 
+	spin_lock_init(&ei->cache_lru_lock);
+	ei->nr_caches = 0;
+	ei->cache_valid_id = EXFAT_CACHE_VALID + 1;
+	INIT_LIST_HEAD(&ei->cache_lru);
+	INIT_HLIST_NODE(&ei->i_hash_fat);
+
 	init_rwsem(&ei->truncate_lock);
 	return &ei->vfs_inode;
 }
@@ -879,11 +885,6 @@ static void exfat_inode_init_once(void *foo)
 {
 	struct exfat_inode_info *ei = (struct exfat_inode_info *)foo;
 
-	spin_lock_init(&ei->cache_lru_lock);
-	ei->nr_caches = 0;
-	ei->cache_valid_id = EXFAT_CACHE_VALID + 1;
-	INIT_LIST_HEAD(&ei->cache_lru);
-	INIT_HLIST_NODE(&ei->i_hash_fat);
 	inode_init_once(&ei->vfs_inode);
 }
 
-- 
2.43.0


