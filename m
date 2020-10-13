Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F91228CC34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 13:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbgJMLHx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 07:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgJMLHw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:07:52 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AFAC0613D0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2020 04:07:51 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j7so6556632pgk.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2020 04:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DsdLLXEDu5r/rHvGHkVF/s17QLEI/N8JfwaZzVE4yB4=;
        b=muAXyrqMq62Izrg81/t4ptqj8Swn6SKvqTxUpJ+Zymn2DlKWCBAP1GI8ZXFU8m/vF+
         8ENY23F4hgI+I0T+JSo9L0FAsL8oIyp1oDKU/keoZNuykXCwiuzJlH6Y/2PaGbtimepH
         63f+EH740kSXvrWZR9Nd/2m+UT1zZiNl33bPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DsdLLXEDu5r/rHvGHkVF/s17QLEI/N8JfwaZzVE4yB4=;
        b=EZQVLp4Lc9DbHikwENV7xccRt3J/lHo9bU7PTHFRycgVPqlZ18ErEC0i//ih2s7v2o
         fywUO0t2zUgUZPl4s4HWTGCXZNLs2bcIZqL+9JfaD/wVEdTpJ9UKkrDDKuapDBWLojCe
         zO6e+HgpeL47QRazSdWfBvjbsisT9p0Qlgtk0R2ySH19oiQHeiS27boXwKEEkXxUrE5K
         /oPl62Akv+oaK7PLX0ec0rc9JOURJrHtb2GoQxvO3m7h93QAg/WD/5C/JwfH70FWFG0/
         SqLLvNNCZP8jz2QMmvT/zHfmaWK7wwmFDxE6eXK4Jwo2T2mRdHAkgf/8MQ+xpvv9SZAy
         1JNA==
X-Gm-Message-State: AOAM531AfVT/pyop4srNqNf+764/lBkWC7gQ26zFMsPZVWTsA7u/IwzA
        p53RiMLz3NT9KNH0T1eimLHZDQ==
X-Google-Smtp-Source: ABdhPJzqgEV+lAzcTt/anrFL0qbSxvROzpd/Bgfp7nsuzar5JhMOWGYQzIRZJvmrVNrusgjQNu/0lg==
X-Received: by 2002:a65:4987:: with SMTP id r7mr16649379pgs.228.1602587270915;
        Tue, 13 Oct 2020 04:07:50 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id f5sm20809195pgi.86.2020.10.13.04.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 04:07:50 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] nfs: Use cred from fscontext during fsmount
Date:   Tue, 13 Oct 2020 04:07:39 -0700
Message-Id: <20201013110739.21922-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a subtle change that is important for usage of NFS within
user namespaces. With the new mount APIs, the fscontext has an associated
struct cred. This struct cred is created at the time "fsopen" is called.
This cred object contains user namespaces, network namespaces, etc...

Right now, rather than using the cred / network namespace / user namespaces
that are all acquired at the time fsopen is called, we use some bits at the
time FSCONFIG_CMD_CREATE is called, and other bits at the time fsopen is
called. Specifically, the RPC client itself lives in the network namespace
that fsopen was called within. On the other hand, the credentials the RPC
client uses are the ones retrieved at the time of FSCONFIG_CMD_CREATE.

When FSCONFIG_CMD_CREATE is called, the vfs layer checks is the user has
CAP_SYS_ADMIN in the init user ns, as NFS does not have the FS_USERNS_MOUNT
flag enabled. Due to this, there is no way of configuring an NFS mount to
use id mappings from a user namespace.

It may make sense to switch from using clp->cl_rpcclient->cl_cred->user_ns
as the user namespace for the idmapper to clp->cl_net->user_ns, to make
sure that everything is aligned based on the net ns, and matches what has
been previously discussed [1].

Although this is a change that would effect userspace, it is very unlikely
that anyone is initializing the NFS FS FD in an unprivileged namespace,
and then calling FSCONFIG_CMD_CREATE to only get the network namespace's
effects, and not all of the effects. The fscontext API has provisions
for being able to configure specific namespaces.

[1]: https://lore.kernel.org/linux-nfs/CAMp4zn-mw1U3PoS9k_JePieU2+owg6hdXdrQ2Lt3p173J_sRbg@mail.gmail.com/

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 fs/nfs/client.c     | 2 +-
 fs/nfs/nfs4client.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 4b8cc93913f7..bd26ec6a2984 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -985,7 +985,7 @@ struct nfs_server *nfs_create_server(struct fs_context *fc)
 	if (!server)
 		return ERR_PTR(-ENOMEM);
 
-	server->cred = get_cred(current_cred());
+	server->cred = get_cred(fc->cred);
 
 	error = -ENOMEM;
 	fattr = nfs_alloc_fattr();
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index daacc78a3d48..818638cb10c4 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1151,7 +1151,7 @@ struct nfs_server *nfs4_create_server(struct fs_context *fc)
 	if (!server)
 		return ERR_PTR(-ENOMEM);
 
-	server->cred = get_cred(current_cred());
+	server->cred = get_cred(fc->cred);
 
 	auth_probe = ctx->auth_info.flavor_len < 1;
 
-- 
2.25.1

