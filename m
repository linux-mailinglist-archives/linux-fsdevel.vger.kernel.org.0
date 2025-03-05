Return-Path: <linux-fsdevel+bounces-43307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020D5A50DB4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 22:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71330175F7F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 21:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495892566DB;
	Wed,  5 Mar 2025 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Etu1NK/B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEC2254848
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210556; cv=none; b=UqgFQUXWpYMysVU14vKajxns+WVFDksD+D12Ibh0QT/AT8p5VN6lOd0wWPG1d1XnCS0kp/nONMIv+WnmzvAaRG7Fafi7/oSYfz9BkxRwK3Exgz9SZidInQjsS6naBrPuCkWV6kUzBRczdLS9aqxUmYUoYXgyQyBCcFf8EQxl1vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210556; c=relaxed/simple;
	bh=kJB/BuKpNJuMmYfW3eeM1K+X6HuiYJFeiFZWiMKXpQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=GsF/0Wc4UmJp9W1jiIXFneHmhla7LCmlTjGIf9XGa+wIS5Hexyqs/j0W4iDOaedzxdODt0/5VAl+0tIh0mKTD5VhEQuG/sb7ZfILCJPv2SruQTDFOcGpLsjMrw166PYfN8gcgc1nz8UA4vxHl/3t+zxTUyObTvwNKclG8bUYoxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Etu1NK/B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741210554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/065lj+K5RVB5JDzFKvemDu1XmMmEIECpSK6YxUCzE=;
	b=Etu1NK/BeIPIyt7azzmt+y73gOBPUFsDN5YgV1b8pictyk0Zaw+UdAVvZSrgz2yT4a0yHF
	jbap491JDeI8+5aQLH7hQSpp1C+sSUmtdnuRNEiZrMI5yUs47iSdb4b9yC2XBX+ppmqe8L
	SPbjyuBFxBWGNu6ICIciaxxMY5cmDXg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-1-a3N_2zPBmhY8ApvHz-ig-1; Wed,
 05 Mar 2025 16:35:45 -0500
X-MC-Unique: 1-a3N_2zPBmhY8ApvHz-ig-1
X-Mimecast-MFC-AGG-ID: 1-a3N_2zPBmhY8ApvHz-ig_1741210543
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 311BF1954B20;
	Wed,  5 Mar 2025 21:35:43 +0000 (UTC)
Received: from madcap2.tricolour.com (unknown [10.22.76.19])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 306121955DCE;
	Wed,  5 Mar 2025 21:35:39 +0000 (UTC)
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@parisplace.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Richard Guy Briggs <rgb@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v1 1/2] audit: record fanotify event regardless of presence of rules
Date: Wed,  5 Mar 2025 16:33:19 -0500
Message-ID: <3c2679cb9df8a110e1e21b7f387b77ddfaacc289.1741210251.git.rgb@redhat.com>
In-Reply-To: <cover.1741210251.git.rgb@redhat.com>
References: <cover.1741210251.git.rgb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

When no audit rules are in place, fanotify event results are
unconditionally dropped due to an explicit check for the existence of
any audit rules.  Given this is a report from another security
sub-system, allow it to be recorded regardless of the existence of any
audit rules.

To test, install and run the fapolicyd daemon with default config.  Then
as an unprivileged user, create and run a very simple binary that should
be denied.  Then check for an event with
	ausearch -m FANOTIFY -ts recent

Link: https://issues.redhat.com/browse/RHEL-1367
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 include/linux/audit.h | 8 +-------
 kernel/auditsc.c      | 2 +-
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 0050ef288ab3..d0c6f23503a1 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -418,7 +418,7 @@ extern void __audit_log_capset(const struct cred *new, const struct cred *old);
 extern void __audit_mmap_fd(int fd, int flags);
 extern void __audit_openat2_how(struct open_how *how);
 extern void __audit_log_kern_module(char *name);
-extern void __audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar);
+extern void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar);
 extern void __audit_tk_injoffset(struct timespec64 offset);
 extern void __audit_ntp_log(const struct audit_ntp_data *ad);
 extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
@@ -525,12 +525,6 @@ static inline void audit_log_kern_module(char *name)
 		__audit_log_kern_module(name);
 }
 
-static inline void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
-{
-	if (!audit_dummy_context())
-		__audit_fanotify(response, friar);
-}
-
 static inline void audit_tk_injoffset(struct timespec64 offset)
 {
 	/* ignore no-op events */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 0627e74585ce..936825114bae 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2880,7 +2880,7 @@ void __audit_log_kern_module(char *name)
 	context->type = AUDIT_KERN_MODULE;
 }
 
-void __audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
+void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
 {
 	/* {subj,obj}_trust values are {0,1,2}: no,yes,unknown */
 	switch (friar->hdr.type) {
-- 
2.43.5


