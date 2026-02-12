Return-Path: <linux-fsdevel+bounces-77044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFtLAk0XjmlF/QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 19:09:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC43D130299
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 19:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E47C30117C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 18:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB7A26ED45;
	Thu, 12 Feb 2026 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYV9ftaU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E416026E71E
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770919752; cv=none; b=ASyD15MtIIW/HfE0lq91RaUZGO6ZzmVjNcPtSrc7YqJT8jgjLE55RCd1mVeJbkUhgR4s3aItfj2nhE/Vwxo7pS9/tquGuv0hM8JiBiNenmbvhQbscrSqBYL4gRbijdkTRqouU5Mw0PRBaa9USE/y9gCW3sAi1hDfOJ2jQoHZH1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770919752; c=relaxed/simple;
	bh=ZVr+r/LBqXQgcI+sBykKKfmAoe4khgXbrhxb1OvV5SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4ScC//T8cDyZnETH2nnmjeOHzATsRjIA2O9Z8lZ4B825Xol3I6UUUvEdD9qwqpzBUkUyEX1veI4Ubnbzo8u3e94VcTmxoXL+iLvC4aw8L5la95yXDJhRePfkgoWdu5PrUkLMCjdcCGBjxYZBNmfl99bBBr9mdZXgcrRj0dce3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UYV9ftaU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770919750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yfg1XVDNrOrliMld15NJAv7vzlhGMGaxrtLKhQhHwig=;
	b=UYV9ftaUnN/p0S8OQ8E+dbw33TMAAeZIUVYUT2IurJETMUDOqgOQiDCCQiwjvzyQqPzxNZ
	sXUpwWHn27XCauas81maB+enm5J5tgxCCbfqJk4k6Uv9eg1LK/gPB9KhwxLkd5106s2Z8J
	Ka7nDrgBTrXFCFTd2lQY9GGMbR3VJjE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-3doP8PF5Peqi68zGV4iYbA-1; Thu,
 12 Feb 2026 13:09:08 -0500
X-MC-Unique: 3doP8PF5Peqi68zGV4iYbA-1
X-Mimecast-MFC-AGG-ID: 3doP8PF5Peqi68zGV4iYbA_1770919747
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AE1D18003F5;
	Thu, 12 Feb 2026 18:09:07 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.194])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7085519560BC;
	Thu, 12 Feb 2026 18:09:05 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RESEND PATCH v3 2/2] audit: Use the new {get,put}_fs_pwd_pool() APIs to get/put pwd references
Date: Thu, 12 Feb 2026 13:08:20 -0500
Message-ID: <20260212180820.2418869-3-longman@redhat.com>
In-Reply-To: <20260206201918.1988344-1-longman@redhat.com>
References: <20260206201918.1988344-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77044-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC43D130299
X-Rspamd-Action: no action

When the audit subsystem is enabled, it can do a lot of get_fs_pwd()
calls to get references to fs->pwd and then releasing those references
back with path_put() later. That may cause a lot of spinlock contention
on a single pwd's dentry lock because of the constant changes to the
reference count when there are many processes on the same working
directory actively doing open/close system calls. This can cause
noticeable performance regresssion when compared with the case where
the audit subsystem is turned off especially on systems with a lot of
CPUs which is becoming more common these days.

To avoid this kind of performance regression, use the new
get_fs_pwd_pool() and put_fs_pwd_pool() APIs to acquire and release a
fs->pwd reference. This should greatly reduce the number of path_get()
and path_put() calls that are needed.

After installing a test kernel with auditing enabled and counters
added to track the get_fs_pwd_pool() and put_fs_pwd_pool() calls on
a 2-socket 96-core test system and running a parallel kernel build,
the counter values for this particular test run were shown below.

  fs_get_path=307,903
  fs_get_pool=56,583,192
  fs_put_path=6,209
  fs_put_pool=56,885,147

Of the about 57M calls to get_fs_pwd_pool() and put_fs_pwd_pool(), the
majority of them are just updating the pwd_refs counters. Only less than
1% of those calls require an actual path_get() and path_put() calls. The
difference between fs_get_path and fs_put_path represents the extra pwd
references that were still stored in various active task->fs's when the
counter values were retrieved.

It can be seen that the number of path_get() and path_put() calls are
reduced by quite a lot.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/auditsc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index dd0563a8e0be..af22f8be4d70 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -931,6 +931,9 @@ static inline void audit_free_names(struct audit_context *context)
 {
 	struct audit_names *n, *next;
 
+	if (!context->name_count)
+		return;	/* audit_alloc_name() has not been called */
+
 	list_for_each_entry_safe(n, next, &context->names_list, list) {
 		list_del(&n->list);
 		if (n->name)
@@ -939,7 +942,7 @@ static inline void audit_free_names(struct audit_context *context)
 			kfree(n);
 	}
 	context->name_count = 0;
-	path_put(&context->pwd);
+	put_fs_pwd_pool(current->fs, &context->pwd);
 	context->pwd.dentry = NULL;
 	context->pwd.mnt = NULL;
 }
@@ -2165,7 +2168,7 @@ static struct audit_names *audit_alloc_name(struct audit_context *context,
 
 	context->name_count++;
 	if (!context->pwd.dentry)
-		get_fs_pwd(current->fs, &context->pwd);
+		get_fs_pwd_pool(current->fs, &context->pwd);
 	return aname;
 }
 
-- 
2.52.0


