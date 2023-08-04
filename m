Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2160376F9A0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 07:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjHDFkP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 01:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjHDFkK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 01:40:10 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97688E46;
        Thu,  3 Aug 2023 22:40:05 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 6CB371015A9;
        Fri,  4 Aug 2023 15:33:19 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3WRgSlxFvley; Fri,  4 Aug 2023 15:33:19 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 61AD71015A4; Fri,  4 Aug 2023 15:33:19 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
Received: from donald.themaw.net (2403-580e-4b40-0-7968-2232-4db8-a45e.ip6.aussiebb.net [IPv6:2403:580e:4b40:0:7968:2232:4db8:a45e])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 746C2101592;
        Fri,  4 Aug 2023 15:33:18 +1000 (AEST)
Subject: [PATCH 2/2] autofs: use wake_up() instead of wake_up_interruptible(()
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fedor Pchelkin <pchelkin@ispras.ru>,
        Takeshi Misawa <jeliantsurux@gmail.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Matthew Wilcox <willy@infradead.org>,
        Andrey Vagin <avagin@openvz.org>
Date:   Fri, 04 Aug 2023 13:33:18 +0800
Message-ID: <169112719813.7590.4971499386839952992.stgit@donald.themaw.net>
In-Reply-To: <169112719161.7590.6700123246297365841.stgit@donald.themaw.net>
References: <169112719161.7590.6700123246297365841.stgit@donald.themaw.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In autofs_wait_release() wake_up() is used to wake up processes waiting
on a mount callback to complete which matches the wait_event_killable()
in autofs_wait().

But in autofs_catatonic_mode() the wake_up_interruptible() was not also
changed at the time autofs_wait_release() was changed.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/waitq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
index efdc76732fae..33dd4660d82f 100644
--- a/fs/autofs/waitq.c
+++ b/fs/autofs/waitq.c
@@ -32,7 +32,7 @@ void autofs_catatonic_mode(struct autofs_sb_info *sbi)
 		wq->status = -ENOENT; /* Magic is gone - report failure */
 		kfree(wq->name.name - wq->offset);
 		wq->name.name = NULL;
-		wake_up_interruptible(&wq->queue);
+		wake_up(&wq->queue);
 		if (!--wq->wait_ctr)
 			kfree(wq);
 		wq = nwq;


