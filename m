Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E2D1F4071
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 18:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbgFIQN7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 12:13:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39045 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731225AbgFIQNx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591719232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+NfdDHd048erz6t6tm56S9vVVu/IFfv0ONqlf8UAtGg=;
        b=PfQZFkGiW2tZC5sP4z0/tICrRx3zmvtOZ5EZ3/WX/CM7PCBYNvxzL/Sxk4exeGax5TlCq7
        5WKNwc6hVyP2BktD3t8mPRK56dAoCx69gWEKFqITb/NOr3/p8UDOl71DdkQTcVG4GAubIh
        xJUSdv//qVtzyAZBJknro6gUda2B1vU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-5lTf6LqqNgSq2fj980Vfrw-1; Tue, 09 Jun 2020 12:13:49 -0400
X-MC-Unique: 5lTf6LqqNgSq2fj980Vfrw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E159C107ACF2;
        Tue,  9 Jun 2020 16:13:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13DA01001281;
        Tue,  9 Jun 2020 16:13:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 6/6] afs: Make afs_zap_data() static
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 09 Jun 2020 17:13:47 +0100
Message-ID: <159171922724.3038039.13172044294369425099.stgit@warthog.procyon.org.uk>
In-Reply-To: <159171918506.3038039.10915051218779105094.stgit@warthog.procyon.org.uk>
References: <159171918506.3038039.10915051218779105094.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make afs_zap_data() static as it's only used in the file in which it is
defined.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/inode.c    |    2 +-
 fs/afs/internal.h |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 7dde703df40c..cd0a0060950b 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -538,7 +538,7 @@ struct inode *afs_root_iget(struct super_block *sb, struct key *key)
  * mark the data attached to an inode as obsolete due to a write on the server
  * - might also want to ditch all the outstanding writes and dirty pages
  */
-void afs_zap_data(struct afs_vnode *vnode)
+static void afs_zap_data(struct afs_vnode *vnode)
 {
 	_enter("{%llx:%llu}", vnode->fid.vid, vnode->fid.vnode);
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 519ffb104616..0c9806ef2a19 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1069,7 +1069,6 @@ extern int afs_ilookup5_test_by_fid(struct inode *, void *);
 extern struct inode *afs_iget_pseudo_dir(struct super_block *, bool);
 extern struct inode *afs_iget(struct afs_operation *, struct afs_vnode_param *);
 extern struct inode *afs_root_iget(struct super_block *, struct key *);
-extern void afs_zap_data(struct afs_vnode *);
 extern bool afs_check_validity(struct afs_vnode *);
 extern int afs_validate(struct afs_vnode *, struct key *);
 extern int afs_getattr(const struct path *, struct kstat *, u32, unsigned int);


