Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F39BF17E1F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 15:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgCIOBv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 10:01:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44687 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726997AbgCIOBv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583762510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3rsz1Kz8tEu9jAZB8nrhbT1TT5lUeQZQriahLu5bRHs=;
        b=KQV7DIBTp1f3NCaC0lPRCbNPIPY4KzPBjm19aXRpoKhJnmsR+NxD6/qQbUl4f2/bqTOD2d
        /pGxskTLtU7wk2B+Z1pw2WgpKhiy5VnErHDrGYPwUMpXkw90FkCNG7SRHPND5DLazW97At
        HxxD9AvM6r+sspkq1+toK6ky9MwPonA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-jiLgxWG_NuSMcn3RJSndBQ-1; Mon, 09 Mar 2020 10:01:49 -0400
X-MC-Unique: jiLgxWG_NuSMcn3RJSndBQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E2411005509;
        Mon,  9 Mar 2020 14:01:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1FAC360C87;
        Mon,  9 Mar 2020 14:01:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/14] fsinfo: Add a uniquifier ID to struct mount [ver #18]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        kzak@redhat.com, jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 09 Mar 2020 14:01:44 +0000
Message-ID: <158376250433.344135.6506083002982077028.stgit@warthog.procyon.org.uk>
In-Reply-To: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a uniquifier ID to struct mount that is effectively unique over the
kernel lifetime to deal around mnt_id values being reused.  This can then
be exported through fsinfo() to allow detection of replacement mounts that
happen to end up with the same mount ID.

The normal mount handle is still used for referring to a particular mount.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/mount.h     |    3 +++
 fs/namespace.c |    3 +++
 2 files changed, 6 insertions(+)

diff --git a/fs/mount.h b/fs/mount.h
index 381f842f3a27..9afbd2a7f692 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -73,6 +73,9 @@ struct mount {
 	int mnt_expiry_mark;		/* true if marked for expiry */
 	struct hlist_head mnt_pins;
 	struct hlist_head mnt_stuck_children;
+#ifdef CONFIG_FSINFO
+	u64	mnt_unique_id;		/* ID unique over lifetime of kernel */
+#endif
 #ifdef CONFIG_MOUNT_NOTIFICATIONS
 	atomic_t mnt_topology_changes;	/* Number of topology changes applied */
 	atomic_t mnt_attr_changes;	/* Number of attribute changes applied */
diff --git a/fs/namespace.c b/fs/namespace.c
index f33cec5fe885..54e8eb93fdd6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -115,6 +115,9 @@ static int mnt_alloc_id(struct mount *mnt)
 	if (res < 0)
 		return res;
 	mnt->mnt_id = res;
+#ifdef CONFIG_FSINFO
+	vfs_generate_unique_id(&mnt->mnt_unique_id);
+#endif
 	return 0;
 }
 


