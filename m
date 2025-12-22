Return-Path: <linux-fsdevel+bounces-71861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F1BCD7558
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E02F83001801
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 22:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED363314AB;
	Mon, 22 Dec 2025 22:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ho7TRiLx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B14341AB1
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442666; cv=none; b=Rf156WbQv019zSXwPcjIo5q+A7Hc4W3EEliHzFhEytFd13+Q5sj0td2lIKow1ljmFdXv88jJt5O/evvNSoo9ZAMWCOu6i1qUexykrfElaQhfFUKzaQ4xj7eohiWEvriNw5GsXnZKDSjEZKszgLWBT/d7fQrDt0idmJvW0T0ekBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442666; c=relaxed/simple;
	bh=kHsDSsBbEJjgzmCquEl2lb6YJgpKoKwc0ROqUXOGtwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=netHI5CEPSFOPHo1aWRrnRmvU0Dav9qHHfXp7hAgStskgR/E7VHrpjoPxZOyjrfiOkTQKJGZEyAzFXcp+MqysysDo63D47hq+Nf0FEuKl1Leo0Kdw7AOf/F/W5J+Yp5EtYn6BGsv5uiQwyejKciKJ0zgA2FVODHm/pPVmQfVhBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ho7TRiLx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzr6N7b5JybtHCAVwGJNHrVs+Vz79HR5PooQE+V9Huo=;
	b=ho7TRiLxCb1uCAEUPql1KzhzYE+TCrV6GeN6u+sAddBCcWFW1RP3BffUloEbuePKK25t/k
	sWL+Xtv/oy2FznRe+5+5mlBv9t2ci+Gh9ba3XUA/sQC/zoyVBmZb1jHO8dx0Ie1MAyRwtJ
	ZhLIjs/k/oWOgdADoBtsYLIOP6+AS58=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-wl-SGEttMneyMcbd2YxUZA-1; Mon,
 22 Dec 2025 17:30:59 -0500
X-MC-Unique: wl-SGEttMneyMcbd2YxUZA-1
X-Mimecast-MFC-AGG-ID: wl-SGEttMneyMcbd2YxUZA_1766442658
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C4C519560B2;
	Mon, 22 Dec 2025 22:30:58 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 95C1819560B4;
	Mon, 22 Dec 2025 22:30:56 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/37] cifs: Scripted clean up fs/smb/client/cifs_debug.h
Date: Mon, 22 Dec 2025 22:29:40 +0000
Message-ID: <20251222223006.1075635-16-dhowells@redhat.com>
In-Reply-To: <20251222223006.1075635-1-dhowells@redhat.com>
References: <20251222223006.1075635-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Remove externs, correct argument names and reformat declarations.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/cifs_debug.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/cifs_debug.h b/fs/smb/client/cifs_debug.h
index e0035ff42dba..35bd5c8e1d71 100644
--- a/fs/smb/client/cifs_debug.h
+++ b/fs/smb/client/cifs_debug.h
@@ -15,7 +15,8 @@
 #define pr_fmt(fmt) "CIFS: " fmt
 
 void cifs_dump_mem(char *label, void *data, int length);
-void cifs_dump_detail(void *buf, size_t buf_len, struct TCP_Server_Info *server);
+void cifs_dump_detail(void *buf, size_t buf_len,
+		      struct TCP_Server_Info *server);
 void cifs_dump_mids(struct TCP_Server_Info *server);
 extern bool traceSMB;		/* flag which enables the function below */
 void dump_smb(void *buf, int smb_buf_length);


