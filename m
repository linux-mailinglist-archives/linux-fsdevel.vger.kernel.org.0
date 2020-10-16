Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AC7290573
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 14:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407813AbgJPMp7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 08:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407809AbgJPMp6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 08:45:58 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC0BC0613D5
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 05:45:58 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n14so1441375pff.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 05:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rjQ1D5B+qargOyy25A8yvKQ0xoEiGNZxg2F9KkU+Vqc=;
        b=rvvX9vjwBy6pgW5A1sZMeli8uVvshsQbi7OfAvSfKv+cfunjCEdoM9PDcEMZt6u8am
         ti4utoFydxTM6dfWPQgNDQtqFZ5gJ1w7XEBLyAB08qriub02wS0nKi8WBk2Wl/GMt0+F
         UMH6mHhxsp21/JqgdH6CdMU+2XaH7RpSHSDOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rjQ1D5B+qargOyy25A8yvKQ0xoEiGNZxg2F9KkU+Vqc=;
        b=uN6CxbNqtAuim7HCKMpcBxQg+8njjkDFwmD7rffFUpY5NA3+ERr6AgXyy8Z85T2uZ7
         HVULuzzNFG0PtBd01pAcI221Nz5oWRBMLf/gkc0ut8D531axfa1sHof3KshZZsgVLDKu
         25oVh2NZAW9HrtXPLXzfpjlKVh+PpTc1fU4XDwU7hf5AbbkOYYMGyTi16l/P/hgK+Niy
         jYV+x/4mJ5wX831H/gfn+5Qyj55U1kvLJpdYWwBAfmborIqBuwKyDJZ8P1xq7NhMPfbl
         Y18aJtDqxM6GUIrPtCMGXIXyHwzLV1cDjmvxT3zX8MOYTUeWkvUfvkgANmO6P3heR1mD
         tMyw==
X-Gm-Message-State: AOAM533iM3qxGLJnO7omYv9puz0gSxEVzEo1SACj0WNdMoaJ1v3Rev00
        9hK8IAzBxLOs8axTJc0z+RlM+w==
X-Google-Smtp-Source: ABdhPJyGw5sBLcgSohIBCu2iy7zrVUgKUib9rZilW+TIEcZbkw0CflLpTDkjcXvAI0orCvPYxdnVmA==
X-Received: by 2002:a62:e81a:0:b029:152:97f9:9775 with SMTP id c26-20020a62e81a0000b029015297f99775mr3374158pfi.29.1602852357318;
        Fri, 16 Oct 2020 05:45:57 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id q123sm2906732pfq.56.2020.10.16.05.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 05:45:56 -0700 (PDT)
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
Subject: [RESEND PATCH v2 1/3] NFS: Use cred from fscontext during fsmount
Date:   Fri, 16 Oct 2020 05:45:48 -0700
Message-Id: <20201016124550.10739-2-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201016124550.10739-1-sargun@sargun.me>
References: <20201016124550.10739-1-sargun@sargun.me>
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

