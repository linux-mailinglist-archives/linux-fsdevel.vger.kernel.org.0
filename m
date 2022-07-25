Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B6E57F7E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jul 2022 03:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiGYBR2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Jul 2022 21:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiGYBR0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Jul 2022 21:17:26 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14D9BCA7;
        Sun, 24 Jul 2022 18:17:25 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id EC4C9100398;
        Mon, 25 Jul 2022 11:17:23 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SIsG4HvR3OCq; Mon, 25 Jul 2022 11:17:23 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id E31851003B0; Mon, 25 Jul 2022 11:17:23 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 37C9510038B;
        Mon, 25 Jul 2022 11:17:23 +1000 (AEST)
Subject: [PATCH v3 1/2] ext4: fix possible null pointer dereference
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 25 Jul 2022 09:17:23 +0800
Message-ID: <165871184279.22404.4501431417766210690.stgit@donald.themaw.net>
In-Reply-To: <165871154975.22404.9637671230578653457.stgit@donald.themaw.net>
References: <165871154975.22404.9637671230578653457.stgit@donald.themaw.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It could be the case that the file system parameter ->string value is
NULL rather than a zero length string.

Guard against this possibility in ext4_parse_param().

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/ext4/super.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 845f2f8aee5f..97160e982ced 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2110,12 +2110,12 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	switch (token) {
 #ifdef CONFIG_QUOTA
 	case Opt_usrjquota:
-		if (!*param->string)
+		if (!param->string || !*param->string)
 			return unnote_qf_name(fc, USRQUOTA);
 		else
 			return note_qf_name(fc, USRQUOTA, param);
 	case Opt_grpjquota:
-		if (!*param->string)
+		if (!param->string || !*param->string)
 			return unnote_qf_name(fc, GRPQUOTA);
 		else
 			return note_qf_name(fc, GRPQUOTA, param);


