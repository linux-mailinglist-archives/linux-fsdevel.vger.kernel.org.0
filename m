Return-Path: <linux-fsdevel+bounces-71876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A57CD75B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A4E83004F59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 22:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D239E34B438;
	Mon, 22 Dec 2025 22:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKUoukB1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A39D34DCCC
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442712; cv=none; b=J/nMDKUHm+aPh3qltI0G/UMxMQseU2TvbpHI4f8EvzHByZCaoSW6vSGhh0P642/vIhmexVsKqOFsbpLTZdcQRVj4O5wKgSsAmkwQOItQQ8XQDxMj6tAsD4enu9KbCGxS5QisOiLaQ+U69IA5CSHCDJTaO261pxEwhgki1uDUg74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442712; c=relaxed/simple;
	bh=oYIjE52XOFn8YAxiIn5yhD90njY1vb/PyI/8Pb+4Uuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fE4cmwYtMQEVz9uKZjz/DN4oYOwaAUxBdhdOcaNoTuwdYwwDF4prJFoHdELTdBKLGHaFqeNkfyQr60Ljp6rCu8KbchX2wQ/rEtD37BQVH+1PGuiD9mPzRp5WqEKycQuqQgLGS/4gOF7qy7JbHoTo/MaH5B2hCCE4rdCB0jkJbBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JKUoukB1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f250vIX/4x3KPDhxaBbib281DG6BOnbvl0mbyxq2DIA=;
	b=JKUoukB1tSBdTwk0yvctDS1jTo42g9HE45mUs6RG4Ggau7Db1gKJNIewO5FHtPtjNptcmB
	Ypob3ZKzZXlnyfgodjicVzq5tHfU8xqQN1AP7skC/CEJL2ErArE4khe+Jj2VYp9QJipHtq
	8mkPlQgyGvoGuoLepc1B+NQMCti7v2M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-9dXHinb5NKqv61vU95WrrQ-1; Mon,
 22 Dec 2025 17:31:44 -0500
X-MC-Unique: 9dXHinb5NKqv61vU95WrrQ-1
X-Mimecast-MFC-AGG-ID: 9dXHinb5NKqv61vU95WrrQ_1766442702
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B57C319560A5;
	Mon, 22 Dec 2025 22:31:42 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EF3EB1800669;
	Mon, 22 Dec 2025 22:31:40 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 29/37] cifs: Fix cifs_dump_mids() to call ->dump_detail
Date: Mon, 22 Dec 2025 22:29:54 +0000
Message-ID: <20251222223006.1075635-30-dhowells@redhat.com>
In-Reply-To: <20251222223006.1075635-1-dhowells@redhat.com>
References: <20251222223006.1075635-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/cifs_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index 98136547ea5f..b21444777872 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -78,7 +78,7 @@ void cifs_dump_mids(struct TCP_Server_Info *server)
 		cifs_dbg(VFS, "IsMult: %d IsEnd: %d\n",
 			 mid_entry->multiRsp, mid_entry->multiEnd);
 		if (mid_entry->resp_buf) {
-			cifs_dump_detail(mid_entry->resp_buf,
+			server->ops->dump_detail(mid_entry->resp_buf,
 					 mid_entry->response_pdu_len, server);
 			cifs_dump_mem("existing buf: ", mid_entry->resp_buf, 62);
 		}


