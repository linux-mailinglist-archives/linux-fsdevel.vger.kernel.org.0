Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FF329055D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 14:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394934AbgJPMiK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 08:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407661AbgJPMh6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 08:37:58 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8429EC0613D6
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 05:37:57 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id 1so1221784ple.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 05:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rjQ1D5B+qargOyy25A8yvKQ0xoEiGNZxg2F9KkU+Vqc=;
        b=Fclu/Hcd9RUYb5bhdLv7nP6MVmLHBec0xUHjiPj2P9iuLZ2oZ78cy16qzjTX1AnSF+
         JWidmtD/NwsrtFvD4tYxFSvZbydhfqut8Mf3U44L72etGGSU0TvzgWeDJ5OMJKrvJRg8
         BNykXmTdlVRYyBa5otSpqUSF2TAon2r3LN9GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rjQ1D5B+qargOyy25A8yvKQ0xoEiGNZxg2F9KkU+Vqc=;
        b=QgD8V8hs4gHwI53KlS7LmUIa3MLZBi1j3Y4L+JBa0vVPxXvs11Q98GvnIqZueWN9mw
         nG5X6lnK4mPIYM6Os9dOjfXOEzKz3Oqm+5mcSBNZ8Gc8AJXO8kJlRmh3JHtKgfeOEHl9
         mxGTl2HoL3mmDmVzO054P6HhgLn83RtlE5CUCHYPpFv0urjJ0FCop3j+/6A8pa4yCeAe
         uJ/HlwhXQ6O3zGKnjHkDNDtj03Gm185ia6SkhZYWwWhlcQRu8cMvalMRGkFLqxt6oVQ+
         Y0V9eXHt2DN1APZ686vvyNuP1VINmy8W2xD8RirZVoK8vueL+fUAalQXhxDQwutvpQuR
         GIzA==
X-Gm-Message-State: AOAM5331jQprdn8RGvyraUSpD64/Yh5QedhRe5w+GQ6NaiTDlhiQtazO
        i+XCgfKswyzc7wb/7jo4WPMJmA==
X-Google-Smtp-Source: ABdhPJxjDFChxVXxiEd7JKRNmQQO8e1xGCxiZnHvjAwWIP91ABczY49KhJpRTA3ABUSFrK6kuQvWzg==
X-Received: by 2002:a17:90a:6984:: with SMTP id s4mr4042149pjj.206.1602851876951;
        Fri, 16 Oct 2020 05:37:56 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id q8sm2857216pfg.118.2020.10.16.05.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 05:37:56 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kyle Anderson <kylea@netflix.com>
Subject: [PATCH v2 1/3] NFS: Use cred from fscontext during fsmount
Date:   Fri, 16 Oct 2020 05:37:43 -0700
Message-Id: <20201016123745.9510-2-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201016123745.9510-1-sargun@sargun.me>
References: <20201016123745.9510-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In several patches, support was introduced to NFS for user namespaces:

ccfe51a5161c: SUNRPC: Fix the server AUTH_UNIX userspace mappings
e6667c73a27d: SUNRPC: rsi_parse() should use the current user namespace
1a58e8a0e5c1: NFS: Store the credential of the mount process in the nfs_server
283ebe3ec415: SUNRPC: Use the client user namespace when encoding creds
ac83228a7101: SUNRPC: Use namespace of listening daemon in the client AUTH_GSS upcall
264d948ce7d0: NFS: Convert NFSv3 to use the container user namespace
58002399da65: NFSv4: Convert the NFS client idmapper to use the container user namespace
c207db2f5da5: NFS: Convert NFSv2 to use the container user namespace
3b7eb5e35d0f: NFS: When mounting, don't share filesystems between different user namespaces

All of these commits are predicated on the NFS server being created with
credentials that are in the user namespace of interest. The new VFS
mount APIs help in this[1], in that the creation of the FSFD (fsopen)
captures a set of credentials at creation time.

Normally, the new file system API users automatically get their
super block's user_ns set to the fc->user_ns in sget_fc, but since
NFS has to do special manipulation of UIDs / GIDs on the wire,
it keeps track of credentials itself.

Unfortunately, the credentials that the NFS uses are the current_creds
at the time FSCONFIG_CMD_CREATE is called. When FSCONFIG_CMD_CREATE is
called, simultaneously, mount_capable is checked -- which checks if
the user has CAP_SYS_ADMIN in the init_user_ns because NFS does not
have FS_USERNS_MOUNT.

This makes a subtle change so that the struct cred from fsopen
is used instead. Since the fs_context is available at server
creation time, and it has the credentials, we can just use
those.

This roughly allows a privileged user to mount on behalf of an unprivileged
usernamespace, by forking off and calling fsopen in the unprivileged user
namespace. It can then pass back that fsfd to the privileged process which
can configure the NFS mount, and then it can call FSCONFIG_CMD_CREATE
before switching back into the mount namespace of the container, and finish
up the mounting process and call fsmount and move_mount.

This change makes a small user space change if the user performs this
elaborate process of passing around file descriptors, and switching
namespaces. There may be a better way to go about this, or even enable
FS_USERNS_MOUNT on NFS, but this seems like the safest and most
straightforward approach.

[1]: https://lore.kernel.org/linux-fsdevel/155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk/

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Cc: J. Bruce Fields <bfields@fieldses.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna.schumaker@netapp.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kyle Anderson <kylea@netflix.com>
---
 fs/nfs/client.c     | 2 +-
 fs/nfs/nfs4client.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index f1ff3076e4a4..fdefcc649884 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -967,7 +967,7 @@ struct nfs_server *nfs_create_server(struct fs_context *fc)
 	if (!server)
 		return ERR_PTR(-ENOMEM);
 
-	server->cred = get_cred(current_cred());
+	server->cred = get_cred(fc->cred);
 
 	error = -ENOMEM;
 	fattr = nfs_alloc_fattr();
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 0bd77cc1f639..92ff6fb8e324 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1120,7 +1120,7 @@ struct nfs_server *nfs4_create_server(struct fs_context *fc)
 	if (!server)
 		return ERR_PTR(-ENOMEM);
 
-	server->cred = get_cred(current_cred());
+	server->cred = get_cred(fc->cred);
 
 	auth_probe = ctx->auth_info.flavor_len < 1;
 
-- 
2.25.1

