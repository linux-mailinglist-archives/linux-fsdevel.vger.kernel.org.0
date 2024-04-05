Return-Path: <linux-fsdevel+bounces-16161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4193A899993
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 11:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B80283BB5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 09:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8290415FD0C;
	Fri,  5 Apr 2024 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anoj9uPB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDB715FA9C
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309742; cv=none; b=gjF7rjr2Jg4Hr0SkiHqSvCki8I18JnMwypr06eI0gvNxoQWzqlW4kFQeshjYitcNN9YZCHaA9d4jPL++C2vqONPJ5AsqKgbNnt+bXIeRJLa5VBh90yNo7aTby+Lf34SsPAjM/guKMxjDF8xu4W4p4mgL1DxBsvTKWB5Qezp3tKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309742; c=relaxed/simple;
	bh=+a5JQHY01VQS8HMcimLn5yqtKMTw31b0O9KfVX+tlqg=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=JnBnAVdr3lpxSN3zTUNSAIzsPB5t/CEGqvCmmPJRKRxphW2UiXZ5EhhIRrGs+hpKusqm6kyUUhlVsJgWZ+/r6ZJU6TFu2kyynqhx1eAgRG++twL9Ykrz9qqGVhNPFdfJLeRViwvQM6DHBdzM0V1RsGzQ/wRG5ga4shPwfypYdN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=anoj9uPB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712309739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=0GLXeH4FRyM8L8RvcOr9SSWdCRRfNA3antrSczCv1Vg=;
	b=anoj9uPBSST1qsAQMnVkrQrtvMPIyBcTN481XahXjC/kI3ZQVZotUgIF+sjP2YpSrpun46
	wQSSumnU2r+xmXCSxbFEeOM604JkZ+g31wHwc8ATuorDfFtKfCp6SVWWTzGjHnuYjCwm/7
	ujh9J9+6biI7hprj8B7zzZfx9y83iik=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-jAkRxwT_ObCguw5uP-mYwg-1; Fri, 05 Apr 2024 05:35:36 -0400
X-MC-Unique: jAkRxwT_ObCguw5uP-mYwg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83068805A61;
	Fri,  5 Apr 2024 09:35:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BA797C1576F;
	Fri,  5 Apr 2024 09:35:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix fileserver rotation getting stuck
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4005299.1712309731.1@warthog.procyon.org.uk>
Date: Fri, 05 Apr 2024 10:35:31 +0100
Message-ID: <4005300.1712309731@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Fix the fileserver rotation code in a couple of ways:

 (1) op->server_states is an array, not a pointer to a single record, so
     fix the places that access it to index it.

 (2) In the places that go through an address list to work out which one
     has the best priority, fix the loops to skip known failed addresses.

Without this, the rotation algorithm may get stuck on addresses that are
inaccessible or don't respond.

This can be triggered manually by finding a server that advertises a
non-routable address and giving it a higher priority, eg.:

        echo "add udp 192.168.0.0/16 3000" >/proc/fs/afs/addr_prefs

if the server, say, includes the address 192.168.7.7 in its address list,
and then attempting to access a volume on that server.

Fixes: 495f2ae9e355 ("afs: Fix fileserver rotation")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/rotate.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index ed04bd1eeae8..c126d51ff400 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -541,11 +541,13 @@ bool afs_select_fileserver(struct afs_operation *op)
 		    test_bit(AFS_SE_EXCLUDED, &se->flags) ||
 		    !test_bit(AFS_SERVER_FL_RESPONDING, &s->flags))
 			continue;
-		es = op->server_states->endpoint_state;
+		es = op->server_states[i].endpoint_state;
 		sal = es->addresses;
 
 		afs_get_address_preferences_rcu(op->net, sal);
 		for (j = 0; j < sal->nr_addrs; j++) {
+			if (es->failed_set & (1 << j))
+				continue;
 			if (!sal->addrs[j].peer)
 				continue;
 			if (sal->addrs[j].prio > best_prio) {
@@ -605,6 +607,8 @@ bool afs_select_fileserver(struct afs_operation *op)
 	best_prio = -1;
 	addr_index = 0;
 	for (i = 0; i < alist->nr_addrs; i++) {
+		if (op->estate->failed_set & (1 << i))
+			continue;
 		if (alist->addrs[i].prio > best_prio) {
 			addr_index = i;
 			best_prio = alist->addrs[i].prio;
@@ -674,7 +678,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 	for (i = 0; i < op->server_list->nr_servers; i++) {
 		struct afs_endpoint_state *estate;
 
-		estate = op->server_states->endpoint_state;
+		estate = op->server_states[i].endpoint_state;
 		error = READ_ONCE(estate->error);
 		if (error < 0)
 			afs_op_accumulate_error(op, error, estate->abort_code);


