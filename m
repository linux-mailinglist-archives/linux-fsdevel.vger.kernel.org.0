Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1A02B028C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 11:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgKLKKb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 05:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbgKLKKW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:10:22 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018F9C0617A7
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2020 02:10:22 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id b63so462346pfg.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2020 02:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NXvCHpzC4yHknkYUeuKH4ChAz6pAIcFQihq+5IBCqGs=;
        b=DsVxq8DzpPg4HEWezGB4gg/3D+K7pKGkupttoZLwON2YQQ9cUUGk/y0TqeHNiTaAP3
         UuJfU8bXy6ps54ZMEfVGNG5KyDTlmYNHrdrT0XsAaJLRIDzz0E1jfltR8Rzc6A3kDHuj
         tlgV4dNLIW8ssTszCeZjDc+3CPzyAFSbRg/gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NXvCHpzC4yHknkYUeuKH4ChAz6pAIcFQihq+5IBCqGs=;
        b=okjtlpFC1C/Tsi4v5lKMhTVZU86NunaZQ9pOe2/hEchQMyZ5A6kOFlxp7ZOGHmDfru
         B3PwKAcBc/QEOlzvye3IPEc781opupbjNd3fbLLssUrna9fC+/dpZEEniaW8tB34IbAF
         Z+OitF4GoWdSgjBy2mfl2YQmM4GcArDcpOLzxjhrYIxusBkrzy6ryOVZdbyJOeoKvro5
         mdRNczrUJjmzA6Zg1PEi0P3xy7tM8XW8QLe2anaRDfrdAEYbhZ5I5VzAzNfkmVcgTfeY
         jY3aSfRjSMnKFFbA0hv8q5x3+eTVDZK61OfytSK9lbrLW++tNUuYbLZgUEYhGs8G2RdA
         RZfg==
X-Gm-Message-State: AOAM530dTV7+GVxduG6S2KnPEOkMhs9yQ5ofmX/lGITCqN1E2o/WL1p3
        PG1JlRnhy0R+sVKV9bdQIHE6ZA==
X-Google-Smtp-Source: ABdhPJzYBRZtZh0C0vNFm/jGvhQmXdAS0zegRiM9o3nULcuWKE/qkhN8m/8ALvB00h81E1O9Zc7sfQ==
X-Received: by 2002:a65:6a54:: with SMTP id o20mr24145240pgu.38.1605175821486;
        Thu, 12 Nov 2020 02:10:21 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id n1sm5577060pfu.211.2020.11.12.02.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 02:10:20 -0800 (PST)
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
Subject: [PATCH v5 2/2] NFSv4: Refactor to use user namespaces for nfs4idmap
Date:   Thu, 12 Nov 2020 02:09:52 -0800
Message-Id: <20201112100952.3514-3-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112100952.3514-1-sargun@sargun.me>
References: <20201112100952.3514-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In several patches work has been done to enable NFSv4 to use user
namespaces:
58002399da65: NFSv4: Convert the NFS client idmapper to use the container user namespace
3b7eb5e35d0f: NFS: When mounting, don't share filesystems between different user namespaces

Unfortunately, the userspace APIs were only such that the userspace facing
side of the filesystem (superblock s_user_ns) could be set to a non init
user namespace. This furthers the fs_context related refactoring, and
piggybacks on top of that logic, so the superblock user namespace, and the
NFS user namespace are the same.

Users can still use rpc.idmapd if they choose to, but there are complexities
with user namespaces and request-key that have yet to be addresssed.

Eventually, we will need to at least:
  * Separate out the keyring cache by namespace
  * Come up with an upcall mechanism that can be triggered inside of the container,
    or safely triggered outside, with the requisite context to do the right
    mapping. * Handle whatever refactoring needs to be done in net/sunrpc.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Tested-by: Alban Crequy <alban.crequy@gmail.com>
---
 fs/nfs/nfs4client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index be7915c861ce..86acffe7335c 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1153,7 +1153,7 @@ struct nfs_server *nfs4_create_server(struct fs_context *fc)
 	if (!server)
 		return ERR_PTR(-ENOMEM);
 
-	server->cred = get_cred(current_cred());
+	server->cred = get_cred(fc->cred);
 
 	auth_probe = ctx->auth_info.flavor_len < 1;
 
-- 
2.25.1

