Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765962B0288
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 11:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgKLKKX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 05:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgKLKKT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:10:19 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727CBC0613D1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2020 02:10:19 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id q10so4108373pfn.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2020 02:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HwBTug+23umF28NOUuY72jHdkiXAQf5/pampIt7rm+0=;
        b=f/FCgDAPg3mfdDCjfy71ryP/hWtUQJNJ7T+gmydKdG95040KitzidkH2AYuLXZuA9P
         tHip4qbqzxoqWvSHCUV0qMyydFKRNS1nMaVj3uH4yF9iilbUU85jczoPNOr8/t2xxqZs
         HQ8KW0cuWxYYLlQgRTGmbaqT1KE7Z9qtCwalI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HwBTug+23umF28NOUuY72jHdkiXAQf5/pampIt7rm+0=;
        b=WzcBVAtEIfh5oC6mbGQR9b+SB8eG5wYKzed/nswAlRRVTd2CzCDrGgorP0BfG1CxSF
         zgu6ktj1QFoOQ6XULqjT/2kkRzO/qtINKOZinT4eOnljmBtybwU9RD1iU3pXgH0GtQqa
         PCMsFVv5IDh0pn2t+I/j4WR+n/NcRIRoV7z9858MRvBAqeeW0udEQHIck0bcYBGYaV+w
         0H84JkVZwEi4hzL1rneQA49mDEfAwFdNNcSIGxCBz1bPg8M1Jt0dZvwytBvxuE35QPKR
         9Af1NHq2c2E7fNNEp1P6puAtcYRfTt+QwmCoSlapR3Sq2jWtXwSZ9XrfuQNahgU0WpW8
         rWSA==
X-Gm-Message-State: AOAM531ts50XWBGoeQI3gGTFScXsJ7cuJfCM+AwoUHGvvK6R6WxJxN2U
        NtDA1h4mGZALyAjMPDDtoGf+Zw==
X-Google-Smtp-Source: ABdhPJxKsI86xum8d5jkMs9uEYgnOC5aQTE4UvTzZiFlEp6gDjWmAC2oYsoDrPCFjQpENuC1k+Kjfw==
X-Received: by 2002:a17:90a:648b:: with SMTP id h11mr8573948pjj.221.1605175818836;
        Thu, 12 Nov 2020 02:10:18 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id n1sm5577060pfu.211.2020.11.12.02.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 02:10:18 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>
Cc:     mauricio@kinvolk.io, Alban Crequy <alban.crequy@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Anderson <kylea@netflix.com>
Subject: [PATCH v5 1/2] NFS: NFSv2/NFSv3: Use cred from fs_context during mount
Date:   Thu, 12 Nov 2020 02:09:51 -0800
Message-Id: <20201112100952.3514-2-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112100952.3514-1-sargun@sargun.me>
References: <20201112100952.3514-1-sargun@sargun.me>
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

