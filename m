Return-Path: <linux-fsdevel+bounces-23956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EB093525B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 22:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F0F1C212BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 20:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E1D145B16;
	Thu, 18 Jul 2024 20:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qkeue+D2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499021448C9
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 20:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721333417; cv=none; b=Dgh1Wab80OGrxq+Cll7EJMowsZlW6Celd9Ovuzniax0bjHt0Jpn0+R5RGoP/gy3BS5n/DiCE7onErt7yvUnb/2So8zd7un4f6oSLs2ph3OXwOYzCX+O0iZT36qT1FYgNe9Hi1PwwrUJRV3uiHNVcvL0bhcmiAMIUxyUH+9BW15s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721333417; c=relaxed/simple;
	bh=ugaWR8JGHdj3yGFXvMOXzTdia9uN1CQ7x8IvBCYoT6A=;
	h=From:In-Reply-To:References:To:cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=XxLxQiRMaJ5tTys0c/QAZO/YB6EM7J+loI0dcenBSAbCs0z164uSX8fk6J74VlhTMchd+uLm+Thsvz7xzcQvrmHDSu47KxpdMh4i5C6J5y6/eXCLAwVCvC1sbkadLh2BvpFA3yrnEIvg/sghrlHeldIDFUTOR8tsDEFPLT9thJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qkeue+D2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721333415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhNrypD9tKCB76J+bi+54vbqRuUJuHcgPMKesV6Oa6c=;
	b=Qkeue+D27tShVskSw0L0sk7aEhZP+lelKQsPfRa5n7eXafX40NteRyhs6Wf/97fWG96Yrq
	2NSdqwfbvL26j5d2VAyBua3+Nea4RYKsAAHAjFydC8AKc99WSCpnljTd8cG6A788esH6DJ
	0WPfy6VxJzM5fnrKtP993B4iEBnOhfE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-l6JER5hFOUaXuakXyqR36A-1; Thu,
 18 Jul 2024 16:10:10 -0400
X-MC-Unique: l6JER5hFOUaXuakXyqR36A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97A42195420D;
	Thu, 18 Jul 2024 20:10:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E4971955F40;
	Thu, 18 Jul 2024 20:10:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1410685.1721333252@warthog.procyon.org.uk>
References: <1410685.1721333252@warthog.procyon.org.uk>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com,
    Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
    Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] netfs: Rename CONFIG_FSCACHE_DEBUG to CONFIG_NETFS_DEBUG
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jul 2024 21:10:06 +0100
Message-ID: <1410796.1721333406@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


CONFIG_FSCACHE_DEBUG should have been renamed to CONFIG_NETFS_DEBUG, so do
that now.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
cc: Christian Brauner <brauner@kernel.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/Kconfig |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/netfs/Kconfig b/fs/netfs/Kconfig
index bec805e0c44c..1b78e8b65ebc 100644
--- a/fs/netfs/Kconfig
+++ b/fs/netfs/Kconfig
@@ -22,6 +22,14 @@ config NETFS_STATS
 	  between CPUs.  On the other hand, the stats are very useful for
 	  debugging purposes.  Saying 'Y' here is recommended.
=20
+config NETFS_DEBUG
+	bool "Enable dynamic debugging netfslib and FS-Cache"
+	depends on NETFS
+	help
+	  This permits debugging to be dynamically enabled in the local caching
+	  management module.  If this is set, the debugging output may be
+	  enabled by setting bits in /sys/module/netfs/parameters/debug.
+
 config FSCACHE
 	bool "General filesystem local caching manager"
 	depends on NETFS_SUPPORT
@@ -50,13 +58,3 @@ config FSCACHE_STATS
 	  debugging purposes.  Saying 'Y' here is recommended.
=20
 	  See Documentation/filesystems/caching/fscache.rst for more information.
-
-config FSCACHE_DEBUG
-	bool "Debug FS-Cache"
-	depends on FSCACHE
-	help
-	  This permits debugging to be dynamically enabled in the local caching
-	  management module.  If this is set, the debugging output may be
-	  enabled by setting bits in /sys/modules/fscache/parameter/debug.
-
-	  See Documentation/filesystems/caching/fscache.rst for more information.


