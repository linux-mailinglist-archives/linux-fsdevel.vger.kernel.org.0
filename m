Return-Path: <linux-fsdevel+bounces-64658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B821BBF01EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 11:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E5C188B7F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 09:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D132F4A1B;
	Mon, 20 Oct 2025 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKgUR0VZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED042F5462
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 09:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951782; cv=none; b=ZJ9EjrcJqnqdquP8/vP4MxfnF7uueZ50n3zh2sI71pOk05NEVvndLWeOYLG+RMggcjXoQIIJTsX4ACd8BGR9urdhzbMrhQwPLPRWT8ptqjwi22VvjmCDgBBMDQiEU7iAi4SIKFk5ffj9PY0bIzTqPvxHAr/2kqgUZMpnkiEHrcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951782; c=relaxed/simple;
	bh=BQJ2hrSINdz3fdvMten9Qqkdiern9n7uP6s5u9Gax4w=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=gWksD/CPDJlDInAPumvPumPYMxksL0Of596mTWGsrsFcO1L+AFDMNIOs/x+qGLu9uGpZi0XDuAo6dHexskVHPljN54oyhP+mchIXGlZ5f0tfBvCpaHf6mg8/6QyzgqLAh6OBxeyrJPP1rwsPTXxjanemj743P/uBZILVt4aTP10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKgUR0VZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760951777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=BrVn10/sBsW2pLhUNKB812kfwkyunp935qKLIORAuP8=;
	b=ZKgUR0VZTfQEpUgI4uupctLHZGrncDWM6v4Cj/goi5+g34f93YX6rOKWD+1mbNiT8VHfqK
	cXXH7tqkc+JXbb9f8U+maRBN79xqY/RE/ruVR06WVMH8aWFaBWj9jww89HHn6gSGof4iEF
	jFIqsLkJi81+POqpetH3IdpyA94fTA8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-vGMTRp2xMyudDEGQx-rJkQ-1; Mon,
 20 Oct 2025 05:16:11 -0400
X-MC-Unique: vGMTRp2xMyudDEGQx-rJkQ-1
X-Mimecast-MFC-AGG-ID: vGMTRp2xMyudDEGQx-rJkQ_1760951770
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D42BB1956088;
	Mon, 20 Oct 2025 09:16:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.57])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 658B41800451;
	Mon, 20 Oct 2025 09:16:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: #include cifsglob.h before trace.h to allow structs in tracepoints
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1039409.1760951767.1@warthog.procyon.org.uk>
Date: Mon, 20 Oct 2025 10:16:07 +0100
Message-ID: <1039410.1760951767@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

    
Make cifs #include cifsglob.h in advance of #including trace.h so that the
structures defined in cifsglob.h can be accessed directly by the cifs
tracepoints rather than the callers having to manually pass in the bits and
pieces.

This should allow the tracepoints to be made more efficient to use as well
as easier to read in the code.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsproto.h |    1 +
 fs/smb/client/trace.c     |    1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 07dc4d766192..4ef6459de564 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -9,6 +9,7 @@
 #define _CIFSPROTO_H
 #include <linux/nls.h>
 #include <linux/ctype.h>
+#include "cifsglob.h"
 #include "trace.h"
 #ifdef CONFIG_CIFS_DFS_UPCALL
 #include "dfs_cache.h"
diff --git a/fs/smb/client/trace.c b/fs/smb/client/trace.c
index 465483787193..16b0e719731f 100644
--- a/fs/smb/client/trace.c
+++ b/fs/smb/client/trace.c
@@ -4,5 +4,6 @@
  *
  *   Author(s): Steve French <stfrench@microsoft.com>
  */
+#include "cifsglob.h"
 #define CREATE_TRACE_POINTS
 #include "trace.h"


