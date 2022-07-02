Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908C9563D0B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Jul 2022 02:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiGBAX4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 20:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiGBAXz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 20:23:55 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2C73983A;
        Fri,  1 Jul 2022 17:23:54 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 91A28100801;
        Sat,  2 Jul 2022 10:23:49 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KqzllykxvaJN; Sat,  2 Jul 2022 10:23:49 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 88FFF100617; Sat,  2 Jul 2022 10:23:49 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 99932100534;
        Sat,  2 Jul 2022 10:23:47 +1000 (AEST)
Subject: [PATCH v2] nfs: fix port value parsing
From:   Ian Kent <raven@themaw.net>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Cc:     linux-nfs-list <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Steve Dickson <SteveD@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>
Date:   Sat, 02 Jul 2022 08:23:47 +0800
Message-ID: <165672142729.19075.11075272196311507440.stgit@donald.themaw.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The valid values of nfs options port and mountport are 0 to USHRT_MAX.

The fs parser will return a fail for port values that are negative
and the sloppy option handling then returns success.

But the sloppy option handling is meant to return success for invalid
options not valid options with invalid values.

Restricting the sloppy option override to handle failure returns for
invalid options only is sufficient to resolve this problem.

Changes:

v2: utilize the return value from fs_parse() to resolve this problem
    instead of changing the parameter definitions.

Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/nfs/fs_context.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 9a16897e8dc6..8f1f9b4af89d 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -484,7 +484,7 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 
 	opt = fs_parse(fc, nfs_fs_parameters, param, &result);
 	if (opt < 0)
-		return ctx->sloppy ? 1 : opt;
+		return (opt == -ENOPARAM && ctx->sloppy) ? 1 : opt;
 
 	if (fc->security)
 		ctx->has_sec_mnt_opts = 1;


