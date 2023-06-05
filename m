Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FECB722F57
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 21:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbjFETKG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 15:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbjFETJh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:09:37 -0400
Received: from forward205c.mail.yandex.net (forward205c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919941B5;
        Mon,  5 Jun 2023 12:09:29 -0700 (PDT)
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
        by forward205c.mail.yandex.net (Yandex) with ESMTP id 1D3C34B206;
        Mon,  5 Jun 2023 22:03:15 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:2e14:0:640:2cd1:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id 71C1B60042;
        Mon,  5 Jun 2023 22:03:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 23YUOG7DgKo0-B7EanhI6;
        Mon, 05 Jun 2023 22:03:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1685991787;
        bh=W1Bi1QeA3RV6fDYh5nFGYXyCEkJP+gzRRvK3oGgjt0Y=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From;
        b=fv3xvnujLxOzwiwx7oy8Fmj7DhRGkL1HQjX6HTZuI0ksIExohWUw/ppxsFP26wrQG
         ABBRGtJf4o4VNLVlTLGPG1t6h7tqg5icrp4ezWXm+YNnpCz010eUgXfzsA+M8cGqAe
         PTxMdU9REozFF2iPapv6z6sRp0YkcM1+kv/mCFMA=
Authentication-Results: mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From:   Kirill Tkhai <tkhai@ya.ru>
To:     akpm@linux-foundation.org, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhengqi.arch@bytedance.com,
        david@fromorbit.com
Subject: [PATCH v2 1/3] mm: vmscan: move shrinker_debugfs_remove() before synchronize_srcu()
Date:   Mon,  5 Jun 2023 22:03:02 +0300
Message-Id: <168599178203.70911.18350742045278218790.stgit@pro.pro>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <168599103578.70911.9402374667983518835.stgit@pro.pro>
References: <168599103578.70911.9402374667983518835.stgit@pro.pro>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Qi Zheng <zhengqi.arch@bytedance.com>

The debugfs_remove_recursive() will wait for debugfs_file_put()
to return, so there is no need to put it after synchronize_srcu()
to wait for the rcu read-side critical section to exit.

Just move it before synchronize_srcu(), which is also convenient
to put the heavy synchronize_srcu() in the delayed work later.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/vmscan.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index eeca83e28c9b..a773e97e152e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -818,11 +818,11 @@ void unregister_shrinker(struct shrinker *shrinker)
 	debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
 	mutex_unlock(&shrinker_mutex);
 
+	shrinker_debugfs_remove(debugfs_entry, debugfs_id);
+
 	atomic_inc(&shrinker_srcu_generation);
 	synchronize_srcu(&shrinker_srcu);
 
-	shrinker_debugfs_remove(debugfs_entry, debugfs_id);
-
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
 }

