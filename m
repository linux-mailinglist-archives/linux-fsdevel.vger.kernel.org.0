Return-Path: <linux-fsdevel+bounces-78835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNmnFulJo2kF/QQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 21:02:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC951C7D02
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 21:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B167C34D2F06
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 19:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659A93B3C07;
	Sat, 28 Feb 2026 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpFHuRcS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B923B3BE2
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Feb 2026 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772303301; cv=none; b=EciMwagJYjJfbU30IPBuOwou9QMeEpxIfIgGBKmElm4C4Ic7pLkLRPDw+p0letnvtQ7wxfvpSNDBS93VVEMXUYmZGV3WI6XS1NRFQyjZG38/lHDO8DknMx47yxE5g/VHTLLKNeA+2qwNsZ9WkweEqOnW7zR0p8GJZ8gq2lrWSEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772303301; c=relaxed/simple;
	bh=6gz20nsM24m2S/dck8ZmFQ35FSYPIPpH8Q92e6D/gI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NK1bmVEa1IQh7DmincpoGVm1uLmG5iezKG6eYF5n719ATwlexVetNytxVGEMErcxZ59CwIbtfWOt8Kb/mB2A0aTRbNUlmY2626IUBtrwd+cfcOqa2bKfuEBSDQHD31dzMSeWB0svBebi0dBJa+2dA72ZzjL162FBEROQBfkpRmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YpFHuRcS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772303298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IoIBsfhbhKEi7ETTfW3xNVUCfo/hcm8J/JCFyb6okZw=;
	b=YpFHuRcSXLW7gLDQ5bPqaIQUbFEvv6Vc65SwDwQXDtpXOoGR47JyF1ZxZh9VZNZZINrWWD
	Y1i0nSmPbStFCUrcPbLh1hAsYmPJxbWotz4+z6IVz/dMTS2lKRRbjazuhRhx1tKd/EgUMR
	7ks7FBNQlFgCvpNqZMeSA3zM5zQMlR8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-GF4WwlKAM_uhwhWHQGt9Dg-1; Sat,
 28 Feb 2026 13:28:15 -0500
X-MC-Unique: GF4WwlKAM_uhwhWHQGt9Dg-1
X-Mimecast-MFC-AGG-ID: GF4WwlKAM_uhwhWHQGt9Dg_1772303294
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5F3C195608A;
	Sat, 28 Feb 2026 18:28:13 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.6])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B32781800286;
	Sat, 28 Feb 2026 18:28:10 +0000 (UTC)
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
Subject: [PATCH v4 2/2] audit: Use the new {get,put}_fs_pwd_pool() APIs to get/put pwd references
Date: Sat, 28 Feb 2026 13:27:57 -0500
Message-ID: <20260228182757.90528-3-longman@redhat.com>
In-Reply-To: <20260228182757.90528-1-longman@redhat.com>
References: <20260228182757.90528-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78835-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,paul-moore.com:email]
X-Rspamd-Queue-Id: ADC951C7D02
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
Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditsc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index f6af6a8f68c4..26ba61eabfb0 100644
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
2.53.0


