Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15242D91E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 03:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438054AbgLNCyt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 21:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438014AbgLNCyi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 21:54:38 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA95C0617A6
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 18:53:15 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id f17so11508064pge.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 18:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NXvCHpzC4yHknkYUeuKH4ChAz6pAIcFQihq+5IBCqGs=;
        b=Fddofxw8GEI7/ddW41jojqQlbr3awy3c+LUjmqsgXOgCU2mPSYisSbooN9UQ5+XovY
         ltcvS+KRyuLoQImh7pI1I2alBShPFBH8Nn6NEqRAeZ8ZKd0SZBD7cDvs3ECeNhHf2Fnk
         vI45LPU46Kzcz4bMBPws1Os8P04vvjvgIz9UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NXvCHpzC4yHknkYUeuKH4ChAz6pAIcFQihq+5IBCqGs=;
        b=QuE+JBas77wIt/MMuWCYgz7moB3HJ2qb7Vs0/O1f52vp9WSSJRRiJvtplnKB5y27MD
         g/Hf70i64CQtvrrDHLj1w9hsd5oirvn7eOW6zX6EZ3HiF2Sojm8xqtsWZtkPpYkplMi2
         kqErY34T1NSyD6ZfEQ31pxDGCqJDaEGV4ImvWCZ3T+97ALK0W3M794uVU5uH5ZwXop1Y
         DVHvwPPScvNi3Eq08kIATvxHCn4XFcn3VTYOOUXoRS4CQ9oc+N5yqPj8jgqiVmLV6JrX
         9y0v9FHmMdhtXiv6I7b9HwVwCVstocggkPioHqykX3fA7eiJQXoeGTx8xkBvf8hJ3Uqc
         RbiA==
X-Gm-Message-State: AOAM533HO/cq+S2REam7FAFFLr0n71HZLCRXuW1J2UIcy0rPB3tAfrvt
        kOgFG+4W4NwZPG/+xfIyCw33kA==
X-Google-Smtp-Source: ABdhPJximX80fxcq78BYwz5TJQ7tu7BbHSoBKBAOFQVEsxp9XuCENYTJEgjWvZOnf0LPVObh619vHQ==
X-Received: by 2002:a63:4d12:: with SMTP id a18mr22071092pgb.17.1607914394956;
        Sun, 13 Dec 2020 18:53:14 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id h20sm17102713pgv.23.2020.12.13.18.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 18:53:14 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <schumaker.anna@gmail.com>,
        "J . Bruce Fields" <bfields@fieldses.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mauricio@kinvolk.io, Alban Crequy <alban.crequy@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH RESEND v5 2/2] NFSv4: Refactor to use user namespaces for nfs4idmap
Date:   Sun, 13 Dec 2020 18:53:05 -0800
Message-Id: <20201214025305.25984-3-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201214025305.25984-1-sargun@sargun.me>
References: <20201214025305.25984-1-sargun@sargun.me>
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

