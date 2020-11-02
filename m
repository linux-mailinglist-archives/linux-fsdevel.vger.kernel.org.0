Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941D62A31F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 18:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgKBRrs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 12:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgKBRrr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:47:47 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9FAC061A49
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 09:47:47 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id u2so1245116pls.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 09:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Or3OrGmTCVsC6irW7Os1G3558l38zqrysNf3h0cfK5c=;
        b=dg1q155mU4N5HJ5VxaD/IhrXeEbL95QkuqJG/mMnQ9E9Pqj28zeAGjVO3Fcass6f6Y
         /sMvitvIVUaIpuwHSbAFnfyM1ISHwOZ3FN8TLQNpeB12VDQYqsbnNmQQq2jkk3weG/+O
         Q2vLr4P5PTi3SCPWQGZh5DsRg0OR5wvHHpw7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Or3OrGmTCVsC6irW7Os1G3558l38zqrysNf3h0cfK5c=;
        b=dsJFEV4N+t7PNcE+JlVX/JDOA6lsFQrDGIsVaE8lzSVBq4JndbhfRlfKbXJacT+df8
         GaziYX9TF/lQwKp3mn2JP2aVA5docKfTIHe+QewOZGSl7xw81ako9+th7VyyfP3BP4cN
         ZuvVc/U3+sO764luC+z31i5N4h+V/Q5s4/K99DDe83JdI8u1v7Ut3jjBcR6+2yGzpxFu
         J1/dLc2pBeB7YkUi/JXY49X2dUZZhqeNSyM2Thsfd6ivdAUtmWsfMi+OUjDXOk7OD9Lu
         uqXsEPSejzrO9j43+wPbtJcLaDBOap6IauqbvRCHmf32Kpzbpq7UevELAZeyksqB7tpc
         PBMA==
X-Gm-Message-State: AOAM5326z8TY7ropsV3EHTYYehVa3F9MD2m9O4CALK+sQijU2TPuAwNJ
        vXs0m+zkREjgiC4m/2nf5l1X2w==
X-Google-Smtp-Source: ABdhPJxlD6/ZAw8JNnTv3Awopgp4CRymm+nq4blgRU7ucki8OiClOD7a5hIT2vmxXr0RdtkyFpCNyA==
X-Received: by 2002:a17:902:788a:b029:d6:b9f:820a with SMTP id q10-20020a170902788ab02900d60b9f820amr21461584pll.76.1604339266776;
        Mon, 02 Nov 2020 09:47:46 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id f4sm115989pjs.8.2020.11.02.09.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:47:46 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Anna Schumaker <schumaker.anna@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] NFS: NFSv2/NFSv3: Use cred from fs_context during mount
Date:   Mon,  2 Nov 2020 09:47:36 -0800
Message-Id: <20201102174737.2740-2-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102174737.2740-1-sargun@sargun.me>
References: <20201102174737.2740-1-sargun@sargun.me>
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
---
 fs/nfs/client.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 4b8cc93913f7..c3afe448a512 100644
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
@@ -985,7 +985,13 @@ struct nfs_server *nfs_create_server(struct fs_context *fc)
 	if (!server)
 		return ERR_PTR(-ENOMEM);
 
-	server->cred = get_cred(current_cred());
+	if (fc->cred->user_ns != &init_user_ns)
+		dprintk("%s: Using creds from non-init userns\n", __func__);
+	else if (fc->cred != current_cred())
+		dprintk("%s: Using creds from fs_context which are different than current_creds\n",
+			__func__);
+
+	server->cred = get_cred(fc->cred);
 
 	error = -ENOMEM;
 	fattr = nfs_alloc_fattr();
-- 
2.25.1

