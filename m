Return-Path: <linux-fsdevel+bounces-18355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE2C8B790A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 16:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B014BB25DF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 14:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C73181B95;
	Tue, 30 Apr 2024 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dovAHFa1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034F1181B9D
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486199; cv=none; b=aShuQZBa+umgLkfsEVMC5vo6J5a1nWHxviOM99lm0xtzMVge3EBEudkbiq3kCunnYB/ZF917WMIoDC34zV+Upoyd9TZr9mCei1nHlMz8RmSYWSpkD4YcQSb5j0z/8wSX26UJtPAstdZt8LrY8Cc3IWBL+gR/6o5L52+xmxu3ayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486199; c=relaxed/simple;
	bh=ep1Os42cgG5usiuJkZHV92W2FWs/pG0ogFpWSLhqpWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNuSqtp86rrq7OWs7/QCBXXDeB7yAjjOX+wBScaBVSmZYlL5Zdihj6DS9mgkL98rTXLrNiIjGM+Qxa+zFSGeqNwnubNm4HUD/FS02z8lrWTg95feDxo34KFhZqK15DKxjtCj3P6kt4PxGGtN1LH1byJ7S8LqRcijq0JoSwscUHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dovAHFa1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714486197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iTq0bS5g9R6jgzGNalFqSv7Xb/w6Rjat80pgdhJo5Kk=;
	b=dovAHFa1wrWSculckUX9JH+7iyxlFfqKIN+hBPo8vdQf6vdtoJFxxUIGMxoFQh7PgeG2OX
	OBfJTrFt5JNzdNvVTIqVRA9Hk0cMYRiTrbELinlLEfXLjzbeXIcLEx583sQsru/r5ds0Nm
	j/fUDv7t/Ysv9KfTSVY/F1ggKomUp9M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64--oKur80jNpuvK1_W52Jseg-1; Tue,
 30 Apr 2024 10:09:50 -0400
X-MC-Unique: -oKur80jNpuvK1_W52Jseg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8A763C00088;
	Tue, 30 Apr 2024 14:09:49 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E51B52166B31;
	Tue, 30 Apr 2024 14:09:47 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Christian Brauner <christian@brauner.io>,
	netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>
Subject: [PATCH v7 06/16] cifs: Replace the writedata replay bool with a netfs sreq flag
Date: Tue, 30 Apr 2024 15:09:18 +0100
Message-ID: <20240430140930.262762-7-dhowells@redhat.com>
In-Reply-To: <20240430140930.262762-1-dhowells@redhat.com>
References: <20240430140930.262762-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Replace the 'replay' bool in cifs_writedata (now cifs_io_subrequest) with a
flag in the netfs_io_subrequest flags.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/smb/client/file.c    | 2 +-
 fs/smb/client/smb2pdu.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 4d8cd0d82104..7f2ce68d2a2a 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -3325,7 +3325,7 @@ cifs_resend_wdata(struct cifs_io_subrequest *wdata, struct list_head *wdata_list
 			if (wdata->cfile->invalidHandle)
 				rc = -EAGAIN;
 			else {
-				wdata->replay = true;
+				set_bit(NETFS_SREQ_RETRYING, &wdata->subreq.flags);
 #ifdef CONFIG_CIFS_SMB_DIRECT
 				if (wdata->mr) {
 					wdata->mr->need_invalidate = true;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index ca8ba6878f9f..b063f5e95f5d 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4832,7 +4832,7 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 	struct cifs_io_parms *io_parms = NULL;
 	int credit_request;
 
-	if (!wdata->server || wdata->replay)
+	if (!wdata->server || test_bit(NETFS_SREQ_RETRYING, &wdata->subreq.flags))
 		server = wdata->server = cifs_pick_channel(tcon->ses);
 
 	/*
@@ -4917,7 +4917,7 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 	rqst.rq_nvec = 1;
 	rqst.rq_iter = wdata->subreq.io_iter;
 	rqst.rq_iter_size = iov_iter_count(&rqst.rq_iter);
-	if (wdata->replay)
+	if (test_bit(NETFS_SREQ_RETRYING, &wdata->subreq.flags))
 		smb2_set_replay(server, &rqst);
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	if (wdata->mr)


