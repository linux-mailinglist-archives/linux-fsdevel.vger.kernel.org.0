Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955211E8AB9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 00:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgE2WCK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 18:02:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25519 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728648AbgE2WCJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 18:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590789728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cJO7tftuTzicPpFhRijSDm1G6EQS7i0R6RgRJY1TUdc=;
        b=Pbyj8oCyKpKjgQqT2CpbFPc6lJR1QPBStUzZWT9lxlF+HQRh/nji9/dNML596+a/hqPbSD
        YD9lasLTzic6aR2HCBehrq9ou7hw1QWWUPeF97r2iYXw8nO2Ba/SXZctnSnut0vRbrkbW+
        oqCAzw3a6AJKInNLkOg4KqHcFupPtuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-7_Ex-LhYONmqAXWDnZ5y9A-1; Fri, 29 May 2020 18:02:06 -0400
X-MC-Unique: 7_Ex-LhYONmqAXWDnZ5y9A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E647C1005512;
        Fri, 29 May 2020 22:02:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1717C5C1B5;
        Fri, 29 May 2020 22:02:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 16/27] afs: Retain more of the VLDB record for alias detection
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 May 2020 23:02:01 +0100
Message-ID: <159078972121.679399.17300781032376177951.stgit@warthog.procyon.org.uk>
In-Reply-To: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
References: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Save more bits from the volume location database record obtained for a
server so that we can use this information in cell alias detection.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/internal.h    |    3 ++-
 fs/afs/server_list.c |    3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 9f024c1bd650..dce03e068cab 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -546,7 +546,7 @@ struct afs_cb_interest {
 };
 
 /*
- * Replaceable server list.
+ * Replaceable volume server list.
  */
 struct afs_server_entry {
 	struct afs_server	*server;
@@ -554,6 +554,7 @@ struct afs_server_entry {
 };
 
 struct afs_server_list {
+	afs_volid_t		vids[AFS_MAXTYPES]; /* Volume IDs */
 	refcount_t		usage;
 	unsigned char		nr_servers;
 	unsigned char		preferred;	/* Preferred server */
diff --git a/fs/afs/server_list.c b/fs/afs/server_list.c
index b77e50f62459..a35f6951a74a 100644
--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -46,6 +46,9 @@ struct afs_server_list *afs_alloc_server_list(struct afs_cell *cell,
 	refcount_set(&slist->usage, 1);
 	rwlock_init(&slist->lock);
 
+	for (i = 0; i < AFS_MAXTYPES; i++)
+		slist->vids[i] = vldb->vid[i];
+
 	/* Make sure a records exists for each server in the list. */
 	for (i = 0; i < vldb->nr_servers; i++) {
 		if (!(vldb->fs_mask[i] & type_mask))


