Return-Path: <linux-fsdevel+bounces-78833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNm8Hvldo2myBQUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 22:28:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A29521C9196
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 22:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE90530AB0B3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 19:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A643B233D;
	Sat, 28 Feb 2026 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QoH/JI34"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF2F3B232A
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Feb 2026 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772303295; cv=none; b=U/0+5XRqxrhRWJYuVKiZ3tseIdCcRnhbcGmFhfi0bIBWayCJG9W6uxY7YlEN1Ah5AyZoKE7N/j7S9JyhRXsQZC39csEZLXxlpfHI1LM7rAOPZLZ+0OkjbMwpjYnXLcVGkDD4r20pO1YtOJuaCG4oFYCO6i6CAfjb5QD5sL3kuJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772303295; c=relaxed/simple;
	bh=xSHZE2a4FmsJnbM6miwzdJ5cI4Xsdj1vy/YMTH+O/nY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dTcJQbTiTNaovqKrVSw/eS+okPnULmkiKajigFp+lMaerXW1Mu6vRsqoBMe2c9pDEmOhkJYgERygu/ImxysN07QrwDSo/mzB6cJoY6sbeelgV6wt9ox8lxhPHvwrO26lQTxjUbcv7ZqdqJ0lRhTw3MTZWxObZa1AUmc8clweDzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QoH/JI34; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772303292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a/hFCs81cNsxu+qlQAKknDKpc+SOHunIa7+2foWYf/4=;
	b=QoH/JI34rXsypSpUM+D8kusV7687ZdoyN5WCtltXC74RbN11n8XKbsWbAn4w8rxVeJU+6A
	xPdI/4cQuiFsahvc8m0YPfYt1W7y68Ud1poYwQHiohZFqxrbFkzN9Mv4Ws1tjGOfzmjgK7
	omd24AuUmNHmnr3TIYhr+X57z7AWN0E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-Q46BqXX7MMa8chVasbN7_w-1; Sat,
 28 Feb 2026 13:28:08 -0500
X-MC-Unique: Q46BqXX7MMa8chVasbN7_w-1
X-Mimecast-MFC-AGG-ID: Q46BqXX7MMa8chVasbN7_w_1772303287
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E1E6195609E;
	Sat, 28 Feb 2026 18:28:07 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.6])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C0F071800351;
	Sat, 28 Feb 2026 18:28:03 +0000 (UTC)
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
Subject: [PATCH v4 0/2] fs, audit: Avoid excessive dput/dget in audit_context setup and reset paths
Date: Sat, 28 Feb 2026 13:27:55 -0500
Message-ID: <20260228182757.90528-1-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78833-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A29521C9196
X-Rspamd-Action: no action

 v4:
  - Add ack and review tags
  - Simplify put_fs_pwd_pool() in patch 1 as suggested by Paul Moore

 v3:
  - https://lore.kernel.org/lkml/20260206201918.1988344-1-longman@redhat.com/

When the audit subsystem is enabled, it can do a lot of get_fs_pwd()
calls to get references to fs->pwd and then releasing those references
back with path_put() later. That may cause a lot of spinlock contention
on a single pwd's dentry lock because of the constant changes to the
reference count when there are many processes on the same working
directory actively doing open/close system calls. This can cause
noticeable performance regresssion when compared with the case where
the audit subsystem is turned off especially on systems with a lot of
CPUs which is becoming more common these days.

This patch series aim to avoid this type of performance regression caused
by audit by adding a new set of fs_struct helpers to reduce unncessary
path_get() and path_put() calls and the audit code is modified to use
these new helpers.

Waiman Long (2):
  fs: Add a pool of extra fs->pwd references to fs_struct
  audit: Use the new {get,put}_fs_pwd_pool() APIs to get/put pwd
    references

 fs/fs_struct.c            | 26 +++++++++++++++++++++-----
 fs/namespace.c            |  8 ++++++++
 include/linux/fs_struct.h | 28 +++++++++++++++++++++++++++-
 kernel/auditsc.c          |  7 +++++--
 4 files changed, 61 insertions(+), 8 deletions(-)

-- 
2.53.0


