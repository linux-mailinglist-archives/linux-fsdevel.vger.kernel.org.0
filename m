Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE6F2D91E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 03:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438074AbgLNCx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 21:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407069AbgLNCx5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 21:53:57 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA994C061793
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 18:53:13 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id lb18so5438531pjb.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 18:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HwBTug+23umF28NOUuY72jHdkiXAQf5/pampIt7rm+0=;
        b=J49jneFUInkPlDDaEjkpF2WlwAij2n1jRxF8kD76kf6FyHhR5rEnCviD/9QyA0QkPh
         6a0vUbZrcYig3fZSVy537vIKoFHCEg/DmzJHCOgcs1UK7SiOMYnmV9tDiledQWNCKNMp
         A16eeBAu6Yr7lj8JWFuRTCIAOD7daVjmAJxG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HwBTug+23umF28NOUuY72jHdkiXAQf5/pampIt7rm+0=;
        b=oaTu2bOxUEiXaVYpBaktcaxgP13+dm9tYPFtDDW6Bm+/hnMuIUELYMrP9pWQToI5sv
         +cMKug1mcJRhDx4O92fT57cTqFVaFL09inbzI6p0PzJMXGUPBrcbXPgayus1PGFYJEtH
         Qk41mFm90ODT4uxs8A/VZlUrS7R+345bxoZlzO7W/U5GvMANYC9yVyw8OoWhCdg8zmt9
         Pf3DLT22flrUx2rpQ1QCarpNmnosJntUxR7Ga1nlb6Foy8iV7J7Edmltj2d5bgR4xszl
         k+JXYWkQSReXlRSJgnZJsLPsgBc7NV2T9xbj48OSKBCC9u5jpbtAq/1AoS4VIUZNCS0K
         S0cQ==
X-Gm-Message-State: AOAM5303z56P5VslnVEZr/QCdIajMVwJZ9HexoraVCrK+GjEASAmFaeK
        J8Fh6ECyQRgSdCGwEE2FPT3t8w==
X-Google-Smtp-Source: ABdhPJyVNM2WkOT3tRgZy5ak+z9aUkV2LF0bO3oZUHSlkqBWXdsooQOk77Z4ZYi3AP0e8cLMwq9syQ==
X-Received: by 2002:a17:902:c244:b029:da:e63c:cede with SMTP id 4-20020a170902c244b02900dae63ccedemr14170210plg.0.1607914393289;
        Sun, 13 Dec 2020 18:53:13 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id h20sm17102713pgv.23.2020.12.13.18.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 18:53:12 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <schumaker.anna@gmail.com>,
        "J . Bruce Fields" <bfields@fieldses.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mauricio@kinvolk.io, Alban Crequy <alban.crequy@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH RESEND v5 1/2] NFS: NFSv2/NFSv3: Use cred from fs_context during mount
Date:   Sun, 13 Dec 2020 18:53:04 -0800
Message-Id: <20201214025305.25984-2-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201214025305.25984-1-sargun@sargun.me>
References: <20201214025305.25984-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There was refactoring done to use the fs_context for mounting done in:
62a55d088cd87: NFS: Additional refactoring for fs_context conversion

This made it so that the net_ns is fetched from the fs_context (the netns
that fsopen is called in). This change also makes it so that the credential
fetched during fsopen is used as well as the net_ns.

NFS has already had a number of changes to prepare it for user namespaces:
1a58e8a0e5c1: NFS: Store the credential of the mount process in the nfs_server
264d948ce7d0: NFS: Convert NFSv3 to use the container user namespace
c207db2f5da5: NFS: Convert NFSv2 to use the container user namespace

Previously, different credentials could be used for creation of the
fs_context versus creation of the nfs_server, as FSCONFIG_CMD_CREATE did
the actual credential check, and that's where current_creds() were fetched.
This meant that the user namespace which fsopen was called in could be a
non-init user namespace. This still requires that the user that calls
FSCONFIG_CMD_CREATE has CAP_SYS_ADMIN in the init user ns.

This roughly allows a privileged user to mount on behalf of an unprivileged
usernamespace, by forking off and calling fsopen in the unprivileged user
namespace. It can then pass back that fsfd to the privileged process which
can configure the NFS mount, and then it can call FSCONFIG_CMD_CREATE
before switching back into the mount namespace of the container, and finish
up the mounting process and call fsmount and move_mount.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Tested-by: Alban Crequy <alban.crequy@gmail.com>
---
 fs/nfs/client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 4b8cc93913f7..1e6f3b3ed445 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -571,7 +571,7 @@ static int nfs_start_lockd(struct nfs_server *server)
 					1 : 0,
 		.net		= clp->cl_net,
 		.nlmclnt_ops 	= clp->cl_nfs_mod->rpc_ops->nlmclnt_ops,
-		.cred		= current_cred(),
+		.cred		= server->cred,
 	};
 
 	if (nlm_init.nfs_version > 3)
@@ -985,7 +985,7 @@ struct nfs_server *nfs_create_server(struct fs_context *fc)
 	if (!server)
 		return ERR_PTR(-ENOMEM);
 
-	server->cred = get_cred(current_cred());
+	server->cred = get_cred(fc->cred);
 
 	error = -ENOMEM;
 	fattr = nfs_alloc_fattr();
-- 
2.25.1

