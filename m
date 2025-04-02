Return-Path: <linux-fsdevel+bounces-45513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCF1A78E10
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 14:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD10171917
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 12:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F09239096;
	Wed,  2 Apr 2025 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLsHekaW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86EC235360
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596287; cv=none; b=NZh2U+4hul1DR7qW9qwnt83dabTSlgXASG42VbJ/8L6O5agINIIzigj6VgNuDpZdDbLDthNzOb7u++MWVZsxonvv2Q5yKBPuvA6fnthQ9p3FaIATyAV8NkwwxlxZtrCc9rKgcd1AlWwegAtvZ2zmjE796aoRbaiL87lq9eHzIcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596287; c=relaxed/simple;
	bh=cXmfE8Zo73fyB/QHPWw+99Wun31tm3+a46xHnHmRHs0=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=oNLxZ8kdfkzJMChrx+MGitrOZpAA+aPNpR9/cFm0NIY0oHHQy0C2OqZs8K2chRYs9caxFQT4DFq+oiBPUhsy5Ia+139H8DORr4RCAYBoE7fa5qdYtWWOtkC2hP+XGmR75DQc4ydRTY0soXE3L8cSmCAW5DMArD+9n0HVkQ64k6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cLsHekaW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743596284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=68lHblWFUM177oZ82WUmwq6fKcjyGzBb+/ilfrtKAuU=;
	b=cLsHekaWgSXX8qAnQe1mjgBbBA2oPRhH5ooR2sntazdnWAQnZ/gg/D4xliWkSZbwDEMAaS
	5TNE7DgqBUHlfU4HWQ8kZg2eskSkqnlyeQzPgZJuXC6w4QV6hqzqOc3jjHe4bRyUjDYqL9
	EvJ56quJGyTYaPrQtFQ8dm52shwknSI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-aCqRoR2WMt2CF3Di-QaNGQ-1; Wed,
 02 Apr 2025 08:18:01 -0400
X-MC-Unique: aCqRoR2WMt2CF3Di-QaNGQ-1
X-Mimecast-MFC-AGG-ID: aCqRoR2WMt2CF3Di-QaNGQ_1743596278
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69F24180AF52;
	Wed,  2 Apr 2025 12:17:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.40])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D46033001D14;
	Wed,  2 Apr 2025 12:17:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Giuseppe Scrivano <gscrivan@redhat.com>,
    Debarshi Ray <dray@redhat.com>, Eric Sandeen <sandeen@redhat.com>,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] devpts: Fix type for uid and gid params
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <759133.1743596274.1@warthog.procyon.org.uk>
Date: Wed, 02 Apr 2025 13:17:54 +0100
Message-ID: <759134.1743596274@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

    
Fix devpts to parse uid and gid params using the correct type so that they
get interpreted in the context of the user namespace.

Fixes: cc0876f817d6 ("vfs: Convert devpts to use the new mount API")
Reported-by: Debarshi Ray <dray@redhat.com>
Closes: https://github.com/containers/podman/issues/25751
Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Sandeen <sandeen@redhat.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/devpts/inode.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 42e4d6eeb29f..9c20d78e41f6 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -89,12 +89,12 @@ enum {
 };
 
 static const struct fs_parameter_spec devpts_param_specs[] = {
-	fsparam_u32	("gid",		Opt_gid),
+	fsparam_gid	("gid",		Opt_gid),
 	fsparam_s32	("max",		Opt_max),
 	fsparam_u32oct	("mode",	Opt_mode),
 	fsparam_flag	("newinstance",	Opt_newinstance),
 	fsparam_u32oct	("ptmxmode",	Opt_ptmxmode),
-	fsparam_u32	("uid",		Opt_uid),
+	fsparam_uid	("uid",		Opt_uid),
 	{}
 };
 


