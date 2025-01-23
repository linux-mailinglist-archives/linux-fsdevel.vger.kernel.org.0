Return-Path: <linux-fsdevel+bounces-39902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E288FA19C5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2930016C318
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0B461FDF;
	Thu, 23 Jan 2025 01:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZxGZ/VHQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3718B8F5A;
	Thu, 23 Jan 2025 01:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596807; cv=none; b=FsN+3V/u7YQfRHbSjE4pySEBgLfgaOH9d64hRVmkQRYA8J4aGv1DpByyvIEtU/eAZL6/FVuodwfMDMNQDuD9xorJSBW7CVaVkC5J4G3qNaAn0t4M0ZvhYx+eFSI55E8q9y5uupLJT1T1RJB4A1lci58vG2PfL6wRhOeOxhoglW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596807; c=relaxed/simple;
	bh=O99DaNH/9UoS2mloDzfckbmT7zcw9IH3XkcraOUqx1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QToIU4+gP2yQ8zr0Wf3zu7cWcvm0K6NYy5Jzsx7KEmqhJRsIMU8Wf4WwFW/5CW7BRaJwQO2XBmh4xu81SRfmSiyGApfSTk2m5tOMF80XgAorzro3FLkHwdB1vPaOB4lAANHOPjaTvGJ53/WN8uZ6fVBfCh4fzqATwnY9AZdXjPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZxGZ/VHQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=uluj5dvO+EeL5bFRJd14lCVgGa2Cb6Ufz0cEimr7VOM=; b=ZxGZ/VHQ8IuNWS89oPebaki1pq
	3omejEdKZFepLKolw9pmsC+sKfRIGmcscFN2D7gI2D92hDGmZIgGSmU5NM1Y6yXpf7LrYzG8F7oQW
	78cfOaYmbVwjsqAu8rfFY4/65aPglcBIieOfoGuku+Kl5TA2gNuaJTQXlh2wdYbRoMMbEnVM/R/gY
	5o4+YD+KkNK8/jxfO+NpfRq+3JtbahWHc9/s8zCgp5x+CgU8GXF8v5ZQiXuAg6OHPSgVV6VQqO7vg
	YT6/TS8auAtB4h+bUaOAQWUkIYaKthF+wLoZhr4g+8dulUdmtRlUTjxjWgGjeL8bQtAUK829QA0o9
	7S1Li2KQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tamIt-00000008F1e-2jls;
	Thu, 23 Jan 2025 01:46:43 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: agruenba@redhat.com,
	amir73il@gmail.com,
	brauner@kernel.org,
	ceph-devel@vger.kernel.org,
	dhowells@redhat.com,
	hubcap@omnibond.com,
	jack@suse.cz,
	krisman@kernel.org,
	linux-nfs@vger.kernel.org,
	miklos@szeredi.hu,
	torvalds@linux-foundation.org
Subject: [PATCH v3 03/20] make take_dentry_name_snapshot() lockless
Date: Thu, 23 Jan 2025 01:46:26 +0000
Message-ID: <20250123014643.1964371-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123014643.1964371-1-viro@zeniv.linux.org.uk>
References: <20250123014511.GA1962481@ZenIV>
 <20250123014643.1964371-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Use ->d_seq instead of grabbing ->d_lock; in case of shortname dentries
that avoids any stores to shared data objects and in case of long names
we are down to (unavoidable) atomic_inc on the external_name refcount.

Makes the thing safer as well - the areas where ->d_seq is held odd are
all nested inside the areas where ->d_lock is held, and the latter are
much more numerous.

NOTE: now that there is a lockless path where we might try to grab
a reference to an already doomed external_name instance, it is no
longer possible for external_name.u.count and external_name.u.head
to share space (kudos to Linus for spotting that).

To reduce the noise this commit just make external_name.u a struct
(instead of union); the next commit will dissolve it.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 52662a5d08e4..f387dc97df86 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -296,9 +296,9 @@ static inline int dentry_cmp(const struct dentry *dentry, const unsigned char *c
 }
 
 struct external_name {
-	union {
-		atomic_t count;
-		struct rcu_head head;
+	struct {
+		atomic_t count;		// ->count and ->head can't be combined
+		struct rcu_head head;	// see take_dentry_name_snapshot()
 	} u;
 	unsigned char name[];
 };
@@ -329,15 +329,30 @@ static inline int dname_external(const struct dentry *dentry)
 
 void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry)
 {
-	spin_lock(&dentry->d_lock);
-	name->name = dentry->d_name;
-	if (unlikely(dname_external(dentry))) {
-		atomic_inc(&external_name(dentry)->u.count);
-	} else {
+	unsigned seq;
+	const unsigned char *s;
+
+	rcu_read_lock();
+retry:
+	seq = read_seqcount_begin(&dentry->d_seq);
+	s = READ_ONCE(dentry->d_name.name);
+	name->name.hash_len = dentry->d_name.hash_len;
+	name->name.name = name->inline_name.string;
+	if (likely(s == dentry->d_shortname.string)) {
 		name->inline_name = dentry->d_shortname;
-		name->name.name = name->inline_name.string;
+	} else {
+		struct external_name *p;
+		p = container_of(s, struct external_name, name[0]);
+		// get a valid reference
+		if (unlikely(!atomic_inc_not_zero(&p->u.count)))
+			goto retry;
+		name->name.name = s;
 	}
-	spin_unlock(&dentry->d_lock);
+	if (read_seqcount_retry(&dentry->d_seq, seq)) {
+		release_dentry_name_snapshot(name);
+		goto retry;
+	}
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(take_dentry_name_snapshot);
 
-- 
2.39.5


