Return-Path: <linux-fsdevel+bounces-18648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B08FB8BAEF2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 16:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C5A1C2123D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 14:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BEE1553AB;
	Fri,  3 May 2024 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezGhBUYp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E0D155338
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714746162; cv=none; b=kSFSd4uKt8j+Z9elbWykfyVFSL1JUcNHzrSuT0oYdLufKJR6N8cNlN4HKtsTExxlVEf+cnP5vsUI/f2/DLxJrWJABaQnPsjV5qHZZAxXXysB1vKGZQm7aFKmEoqdlYSqj1lNkkVCTouK2lsRU5b6FwveX4Gped4iuUqssDvbtVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714746162; c=relaxed/simple;
	bh=CQuCKx1f52rBmguZ6r3kKXQ8Q8tgOq7dYH9ndvPdeg8=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=RcO1X2icOPHRinDzfM2oHBuSlyM7IgLSEl2RX6w1xReLqw/HRfOjCFdBKy1vjMBnpClv9whjM14Hfa8tbC9J7lMwfkEvqGEA1J4QJ5KYu6FCZfm1ax9XMVWZrEb4mSM5FAz9rZf9fFgLiVEwGwP/j0+SN70xdYDq+U4z9nF6kA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ezGhBUYp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714746158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fdzGfOXdyJ77aM6wV3QFOsIhYI1kALNNR677cthOE1w=;
	b=ezGhBUYpaDBGHutTpPMw6OrDeZaoPsrrusA/f57vjwpmtVsRmfwrhdXwqCHN/9WCHKcmh2
	EXszFoAv3imytjIEIzILgwQMBfzKvIUWhwDB2Tv4keuKWR1v6C4Jmu8wU7LsmQUH7iouaI
	dq40NFAej1eByy4cQ6YbIETI7Oe/GsE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251--q8-pTE7PZah1LJSYg3Xsg-1; Fri,
 03 May 2024 10:22:34 -0400
X-MC-Unique: -q8-pTE7PZah1LJSYg3Xsg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 204AF28EC11E;
	Fri,  3 May 2024 14:22:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5558840F5F8;
	Fri,  3 May 2024 14:22:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH v2] afs: Fix fileserver rotation getting stuck
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <998835.1714746152.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 May 2024 15:22:32 +0100
Message-ID: <998836.1714746152@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Hi Christian,

Could you pick this up, please?

David
---
afs: Fix fileserver rotation getting stuck

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
Link: https://lore.kernel.org/r/4005300.1712309731@warthog.procyon.org.uk/=
 # v1
---
 Changes
 =3D=3D=3D=3D=3D=3D=3D
 ver #2)
  - Use the untried address set precomputed in the 'set' variable.

 fs/afs/rotate.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index ed04bd1eeae8..ed09d4d4c211 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -541,11 +541,13 @@ bool afs_select_fileserver(struct afs_operation *op)
 		    test_bit(AFS_SE_EXCLUDED, &se->flags) ||
 		    !test_bit(AFS_SERVER_FL_RESPONDING, &s->flags))
 			continue;
-		es =3D op->server_states->endpoint_state;
+		es =3D op->server_states[i].endpoint_state;
 		sal =3D es->addresses;
 =

 		afs_get_address_preferences_rcu(op->net, sal);
 		for (j =3D 0; j < sal->nr_addrs; j++) {
+			if (es->failed_set & (1 << j))
+				continue;
 			if (!sal->addrs[j].peer)
 				continue;
 			if (sal->addrs[j].prio > best_prio) {
@@ -605,6 +607,8 @@ bool afs_select_fileserver(struct afs_operation *op)
 	best_prio =3D -1;
 	addr_index =3D 0;
 	for (i =3D 0; i < alist->nr_addrs; i++) {
+		if (!(set & (1 << i)))
+			continue;
 		if (alist->addrs[i].prio > best_prio) {
 			addr_index =3D i;
 			best_prio =3D alist->addrs[i].prio;
@@ -674,7 +678,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 	for (i =3D 0; i < op->server_list->nr_servers; i++) {
 		struct afs_endpoint_state *estate;
 =

-		estate =3D op->server_states->endpoint_state;
+		estate =3D op->server_states[i].endpoint_state;
 		error =3D READ_ONCE(estate->error);
 		if (error < 0)
 			afs_op_accumulate_error(op, error, estate->abort_code);


