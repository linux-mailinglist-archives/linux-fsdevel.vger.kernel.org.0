Return-Path: <linux-fsdevel+bounces-24003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50EE9378EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 16:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE582818A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 14:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D1514535E;
	Fri, 19 Jul 2024 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzZ55XEy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FEC282FB
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721398166; cv=none; b=Uw2t9O4Plrl1r1hZPFa22eT3rQ1fn4lf6QojjPbCtxbjr4UEW00iyC/LFoCohH5RZZJx/G5uRXT+/py30JyI13Xv/PNFtcS30u4YTfy1pZlkUhrRm/HwuYNRkw287RrSR/lUZBMbBGurK52Wzn78nqTHMWUj+SZlG5av2c4TpxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721398166; c=relaxed/simple;
	bh=fre4/NqB1QX3kYFrVwwxZtWqZ8RN0m4oK0mMVAsB7Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUXasK6QTyi1LER6VqwciWTHn/RnMti+5dBxmPLJYBvcg/UnNLJCTbNfmDD0WLq7H2GErq9gypb5w1/XD3sVMPiCQPINpTvVuAT4n4inK3qbAwOIXpcs33GL7Z/4OixIP1iZ+gCGfJVYY8FjSDGr6Wj3eMNyf6fXWj783xJr26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DzZ55XEy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721398163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OHBrQxJhHKq/0+I6r91RjUd+G1W1o7qj5MHAExhQKcI=;
	b=DzZ55XEyEo3a+LXD0oarpykBu88xPHvmkSBpSj81N8hFUSphpujnOwEG8F9TsYPbnmV/ht
	4HQvunNra7OhIqdKjATjLNfPs+vaGpgIXAPtFUlA9FgkhRAedidgrXLoSR/ztChFvVCr2s
	4DyXtF1nv/4PbLVOqv107V/k18fcU8I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-XHKxl2mIPn-W94e6oZHLDQ-1; Fri,
 19 Jul 2024 10:09:19 -0400
X-MC-Unique: XHKxl2mIPn-W94e6oZHLDQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A92B91944B30;
	Fri, 19 Jul 2024 14:09:17 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.216])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B99981955F40;
	Fri, 19 Jul 2024 14:09:14 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Aurelien Aptel <aaptel@suse.com>,
	netfs@lists.linux.dev
Subject: [PATCH 1/4] cifs: Fix server re-repick on subrequest retry
Date: Fri, 19 Jul 2024 15:09:01 +0100
Message-ID: <20240719140907.1598372-2-dhowells@redhat.com>
In-Reply-To: <20240719140907.1598372-1-dhowells@redhat.com>
References: <20240719140907.1598372-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When a subrequest is marked for needing retry, netfs will call
cifs_prepare_write() which will make cifs repick the server for the op
before renegotiating credits; it then calls cifs_issue_write() which
invokes smb2_async_writev() - which re-repicks the server.

If a different server is then selected, this causes the increment of
server->in_flight to happen against one record and the decrement to happen
against another, leading to misaccounting.

Fix this by just removing the repick code in smb2_async_writev().  As this
is only called from netfslib-driven code, cifs_prepare_write() should
always have been called first, and so server should never be NULL and the
preparatory step is repeated in the event that we do a retry.

The problem manifests as a warning looking something like:

 WARNING: CPU: 4 PID: 72896 at fs/smb/client/smb2ops.c:97 smb2_add_credits+0x3f0/0x9e0 [cifs]
 ...
 RIP: 0010:smb2_add_credits+0x3f0/0x9e0 [cifs]
 ...
  smb2_writev_callback+0x334/0x560 [cifs]
  cifs_demultiplex_thread+0x77a/0x11b0 [cifs]
  kthread+0x187/0x1d0
  ret_from_fork+0x34/0x60
  ret_from_fork_asm+0x1a/0x30

Which may be triggered by a number of different xfstests running against an
Azure server in multichannel mode.  generic/249 seems the most repeatable,
but generic/215, generic/249 and generic/308 may also show it.

Fixes: 3ee1a1fc3981 ("cifs: Cut over to using netfslib")
Reported-by: Steve French <sfrench@samba.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Aurelien Aptel <aaptel@suse.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smb2pdu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 2ae2dbb6202b..bb84a89e5905 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4859,9 +4859,6 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 	struct cifs_io_parms *io_parms = NULL;
 	int credit_request;
 
-	if (!wdata->server || test_bit(NETFS_SREQ_RETRYING, &wdata->subreq.flags))
-		server = wdata->server = cifs_pick_channel(tcon->ses);
-
 	/*
 	 * in future we may get cifs_io_parms passed in from the caller,
 	 * but for now we construct it here...


