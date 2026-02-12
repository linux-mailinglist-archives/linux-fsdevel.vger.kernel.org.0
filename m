Return-Path: <linux-fsdevel+bounces-77042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLojGnEXjmlF/QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 19:09:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B43491302AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 19:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B01230D612C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 18:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7313B271464;
	Thu, 12 Feb 2026 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAM9bdlF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC8F26E71E
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 18:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770919750; cv=none; b=te5Rzp2E0YfJ7/WdRTe7F3FYma4D6ecASgici+xjUn7IfnrBbJuo1T5pq7tERuKLS2jMt/oBz4eDikpUyY3yeY5umy/2ZOtlLWZ09Wv2i5fCzKi6c15FfRF66zEKCKOmG/cetTMb4OH+LdkTm331DF7lxWRzYA/XAUjgydX+Ib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770919750; c=relaxed/simple;
	bh=mzuI1FMO7QtuIRQ5U3mqDpk3IW3+dfzY829HS5JEBec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fidr7bTgYX6SGAdP1Jj89LJRVGXfp/LI8cBMKvMrs98RZALxNl+Fu+wq1XUK3d4mAoWmOiTnSKa33vNSkdtypPhT3UF65njGVd5a4sMfriNC6BUdp2Kvv14E/BdJL0JDN2h9QWKo8Mhtn0X8vDcTohPC1FFSQgf0YH5EerhsP/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IAM9bdlF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770919747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ly2nA8ZJ0dJIvsrFKrjSkM+A6/05aZpz+ZyV0YXxmwQ=;
	b=IAM9bdlFyut1Y/kqekZudNt2Fx7Jj2fG5KpHJIojt6FStqtFjknf3oLIUouAxbQx+w0f7C
	5OwDSDUOWNA1QOC+WeYPwrkeawhMC6QehS24+cvIvgDZYx7K0P9NaF7W0QHybZ+iVg2ylT
	FiVbbDoqsO/YFCncKI29+8NhMTIHFt4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-sXX38uMZMKqCrfOjNrJs-w-1; Thu,
 12 Feb 2026 13:09:04 -0500
X-MC-Unique: sXX38uMZMKqCrfOjNrJs-w-1
X-Mimecast-MFC-AGG-ID: sXX38uMZMKqCrfOjNrJs-w_1770919743
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F35B71800352;
	Thu, 12 Feb 2026 18:09:02 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.194])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9433F19560B9;
	Thu, 12 Feb 2026 18:09:00 +0000 (UTC)
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
Subject: [RESEND PATCH v3 0/2] fs, audit: Avoid excessive dput/dget in audit_context setup and reset paths
Date: Thu, 12 Feb 2026 13:08:18 -0500
Message-ID: <20260212180820.2418869-1-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77042-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B43491302AF
X-Rspamd-Action: no action

 v3:
  - Add a new counter in fs_struct to track # of additional references
    to pwd and add a new get_fs_pwd_pool() and put_fs_pwd_pool helpers
    to use the new counter.
  - Make audit use the new helpers instead of storing pwd reference
    internally.

 v2: https://lore.kernel.org/lkml/20260203194433.1738162-1-longman@redhat.com/

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
 include/linux/fs_struct.h | 30 +++++++++++++++++++++++++++++-
 kernel/auditsc.c          |  7 +++++--
 4 files changed, 63 insertions(+), 8 deletions(-)

-- 
2.52.0


