Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561B25241F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 03:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349867AbiELBUG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 21:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245448AbiELBUE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 21:20:04 -0400
X-Greylist: delayed 437 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 May 2022 18:20:03 PDT
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B576987A01;
        Wed, 11 May 2022 18:20:03 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 8AB44101BDD;
        Thu, 12 May 2022 11:12:43 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UZ4HLCtp03P9; Thu, 12 May 2022 11:12:43 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 8218F101C45; Thu, 12 May 2022 11:12:43 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from web.messagingengine.com (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 41335101C3C;
        Thu, 12 May 2022 11:12:41 +1000 (AEST)
Subject: [PATCH] nfs: fix port value parsing
From:   Ian Kent <raven@themaw.net>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs-list <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Date:   Thu, 12 May 2022 09:12:40 +0800
Message-ID: <165231795988.422447.17355615290677403439.stgit@web.messagingengine.com>
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

Parsing these values as s32 rather than u32 prevents the parser from
returning a parse fail allowing the later USHRT_MAX option check to
correctly return a fail in this case. The result check could be changed
to use the int_32 union variant as well but leaving it as a uint_32
check avoids using two logical compares instead of one.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/nfs/fs_context.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index e2d59bb5e6bb..67a592fbb2cc 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -156,14 +156,14 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
 	fsparam_u32   ("minorversion",	Opt_minorversion),
 	fsparam_string("mountaddr",	Opt_mountaddr),
 	fsparam_string("mounthost",	Opt_mounthost),
-	fsparam_u32   ("mountport",	Opt_mountport),
+	fsparam_s32   ("mountport",	Opt_mountport),
 	fsparam_string("mountproto",	Opt_mountproto),
 	fsparam_u32   ("mountvers",	Opt_mountvers),
 	fsparam_u32   ("namlen",	Opt_namelen),
 	fsparam_u32   ("nconnect",	Opt_nconnect),
 	fsparam_u32   ("max_connect",	Opt_max_connect),
 	fsparam_string("nfsvers",	Opt_vers),
-	fsparam_u32   ("port",		Opt_port),
+	fsparam_s32   ("port",		Opt_port),
 	fsparam_flag_no("posix",	Opt_posix),
 	fsparam_string("proto",		Opt_proto),
 	fsparam_flag_no("rdirplus",	Opt_rdirplus),


