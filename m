Return-Path: <linux-fsdevel+bounces-2731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8B87E7E01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 18:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD8E1C209E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 17:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDB920323;
	Fri, 10 Nov 2023 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQ4Bg4Dl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D433F1DFD8
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 17:06:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AAF37ACC
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 09:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699635993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2KBpc9BasJQHEEaBScXMjepCNomXvpnM2lUSUMsHc4=;
	b=WQ4Bg4DlX25EpUfNnpOiVtPKBfVwI6cGT8qcImZ8BgFrn/ZA3hwnWFnis38Ksef6IVpA7r
	YmMf1WbBlfkZkgGrs7hGJMu90gX4vJn0m/lNYCQDtPC8OqzfuIlellXuSZrnwkNHPZJ0ca
	95tKjuW9PXxMnETg34g7pfno1HoChco=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-l1dL7eoMPreuAzOZKJ4E3A-1; Fri, 10 Nov 2023 12:06:30 -0500
X-MC-Unique: l1dL7eoMPreuAzOZKJ4E3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 168E6101A597;
	Fri, 10 Nov 2023 17:06:30 +0000 (UTC)
Received: from cmirabil.redhat.com (unknown [10.22.16.238])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D668E502C;
	Fri, 10 Nov 2023 17:06:29 +0000 (UTC)
From: Charles Mirabile <cmirabil@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	Charles Mirabile <cmirabil@redhat.com>
Subject: [PATCH v1 1/1] fs: Consider capabilities relative to namespace for linkat permission check
Date: Fri, 10 Nov 2023 12:06:15 -0500
Message-Id: <20231110170615.2168372-2-cmirabil@redhat.com>
In-Reply-To: <20231110170615.2168372-1-cmirabil@redhat.com>
References: <20231110170615.2168372-1-cmirabil@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Previously, the check for CAP_DAC_READ_SEARCH when trying to use
AT_EMPTY_PATH happened relative to the init process's namespace
rather than the namespace of the current process. This seems like
an oversight because it meant that processes in new namespaces
could not ever use AT_EMPTY_PATH with linkat even if they have
CAP_DAC_READ_SEARCH within their namespace.

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 71c13b2990b4..0848aa563988 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4628,7 +4628,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 	 * This ensures that not everyone will be able to create
 	 * handlink using the passed filedescriptor.
 	 */
-	if (flags & AT_EMPTY_PATH && !capable(CAP_DAC_READ_SEARCH)) {
+	if (flags & AT_EMPTY_PATH && !ns_capable(current_user_ns(), CAP_DAC_READ_SEARCH)) {
 		error = -ENOENT;
 		goto out_putnames;
 	}
-- 
2.38.1


