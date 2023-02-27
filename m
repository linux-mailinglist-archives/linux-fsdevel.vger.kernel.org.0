Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4546A3910
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 03:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjB0Cx1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 21:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjB0CxY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 21:53:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7562F8A4C;
        Sun, 26 Feb 2023 18:53:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43854B80C9C;
        Mon, 27 Feb 2023 02:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA18C4339B;
        Mon, 27 Feb 2023 02:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677466397;
        bh=N6ubcD/dFtgXOAPcau3LnF8+6AA0rIbK/jLGuc5X2sU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LaG5G6F2fXMMMgRcI9J0GHjh//KMsw0ThjpS17oq/9sRrfwKxfjVptX18TM6uL9tQ
         Bkgl+xKxyw1fD0kzFNE6TkZI3sl6bJFf5hDj8lyXy9eLe38v8LrppRGEjWVNlh5D4e
         M82zS6mLoZMyMb8T+w38Sqv1d80rQljJl4zLqCbUWw/R+tIpJHz3xkNtgwQPMaxaN0
         Q3jed/4RyQfbkYvihDkplxb6+d9tiKuJFM4LmWWW9UNauA7zZ9WK2GSmK/5PkEgpPI
         SWmfe58Rt0BojGDziNDIocE+CbIItryhUO1/40q08wfp90XCU1lU3l5NNrnB735nSq
         2HlVlqEf61/dg==
From:   Eric Van Hensbergen <ericvh@kernel.org>
To:     asmadeus@codewreck.org
Cc:     ericvh@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux_oss@crudebyte.com,
        lucho@ionkov.net, rminnich@gmail.com,
        v9fs-developer@lists.sourceforge.net
Subject: [PATCH v5 7/11] 9p: Add additional debug flags and open modes
Date:   Mon, 27 Feb 2023 02:53:10 +0000
Message-Id: <20230227025310.24793-1-ericvh@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <Y/CGvTCyhjFITkFs@codewreck.org>
References: <Y/CGvTCyhjFITkFs@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add some additional debug flags to assist with debugging
cache changes.  Also add some additional open modes so we
can track cache state in fids more directly.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 include/net/9p/9p.h | 6 ++++++
 net/9p/client.c     | 8 ++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/net/9p/9p.h b/include/net/9p/9p.h
index 429adf6be29c..60cad0d200a4 100644
--- a/include/net/9p/9p.h
+++ b/include/net/9p/9p.h
@@ -42,6 +42,8 @@ enum p9_debug_flags {
 	P9_DEBUG_PKT =		(1<<10),
 	P9_DEBUG_FSC =		(1<<11),
 	P9_DEBUG_VPKT =		(1<<12),
+	P9_DEBUG_CACHE =	(1<<13),
+	P9_DEBUG_MMAP =		(1<<14),
 };
 
 #ifdef CONFIG_NET_9P_DEBUG
@@ -213,6 +215,10 @@ enum p9_open_mode_t {
 	P9_ORCLOSE = 0x40,
 	P9_OAPPEND = 0x80,
 	P9_OEXCL = 0x1000,
+	P9L_MODE_MASK = 0x1FFF, /* don't send anything under this to server */
+	P9L_DIRECT = 0x2000, /* cache disabled */
+	P9L_NOWRITECACHE = 0x4000, /* no write caching  */
+	P9L_LOOSE = 0x8000, /* loose cache */
 };
 
 /**
diff --git a/net/9p/client.c b/net/9p/client.c
index 2adcb5e7b0e2..a3340268ec8d 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1230,9 +1230,9 @@ int p9_client_open(struct p9_fid *fid, int mode)
 		return -EINVAL;
 
 	if (p9_is_proto_dotl(clnt))
-		req = p9_client_rpc(clnt, P9_TLOPEN, "dd", fid->fid, mode);
+		req = p9_client_rpc(clnt, P9_TLOPEN, "dd", fid->fid, mode & P9L_MODE_MASK);
 	else
-		req = p9_client_rpc(clnt, P9_TOPEN, "db", fid->fid, mode);
+		req = p9_client_rpc(clnt, P9_TOPEN, "db", fid->fid, mode & P9L_MODE_MASK);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
 		goto error;
@@ -1277,7 +1277,7 @@ int p9_client_create_dotl(struct p9_fid *ofid, const char *name, u32 flags,
 		return -EINVAL;
 
 	req = p9_client_rpc(clnt, P9_TLCREATE, "dsddg", ofid->fid, name, flags,
-			    mode, gid);
+			    mode & P9L_MODE_MASK, gid);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
 		goto error;
@@ -1321,7 +1321,7 @@ int p9_client_fcreate(struct p9_fid *fid, const char *name, u32 perm, int mode,
 		return -EINVAL;
 
 	req = p9_client_rpc(clnt, P9_TCREATE, "dsdb?s", fid->fid, name, perm,
-			    mode, extension);
+			    mode & P9L_MODE_MASK, extension);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
 		goto error;
-- 
2.37.2

