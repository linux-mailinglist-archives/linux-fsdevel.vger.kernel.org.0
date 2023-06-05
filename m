Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77553722F5C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 21:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbjFETKO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 15:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbjFETKI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:10:08 -0400
Received: from forward204c.mail.yandex.net (forward204c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3172FED;
        Mon,  5 Jun 2023 12:10:07 -0700 (PDT)
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
        by forward204c.mail.yandex.net (Yandex) with ESMTP id 9081567F5C;
        Mon,  5 Jun 2023 22:03:37 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:7c8d:0:640:daf4:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id 7088560037;
        Mon,  5 Jun 2023 22:03:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id P3Y5PY6DbSw0-D03FsbaO;
        Mon, 05 Jun 2023 22:03:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1685991810;
        bh=MEigQzDY74Nvn1JaDAKnEZHd5i4CDwKJ3Ad6AHXfzeY=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From;
        b=nku73zf1DQChaO49JXDE6MZ6i2mQGvLbi+bBUqJu+M4OnrmerRoH+8GLIIlD2BtYk
         Lf0Cl3rp5rYLS6m/8g/rhZOY/fpBJI5utQRJhIvdaUPH+qQyix5BtbHC8GP3T/LS+r
         K4Gj7k0LH642cC+bqZ6rQWO6ULwPjnkJd/QHfnAw=
Authentication-Results: mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From:   Kirill Tkhai <tkhai@ya.ru>
To:     akpm@linux-foundation.org, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhengqi.arch@bytedance.com,
        david@fromorbit.com
Subject: [PATCH v2 3/3] fs: Use delayed shrinker unregistration
Date:   Mon,  5 Jun 2023 22:03:25 +0300
Message-Id: <168599180526.70911.14606767590861123431.stgit@pro.pro>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <168599103578.70911.9402374667983518835.stgit@pro.pro>
References: <168599103578.70911.9402374667983518835.stgit@pro.pro>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kernel test robot reports -88.8% regression in stress-ng.ramfs.ops_per_sec
test case caused by commit: f95bdb700bc6 ("mm: vmscan: make global slab
shrink lockless"). Qi Zheng investigated that the reason is in long SRCU's
synchronize_srcu() occuring in unregister_shrinker().

This patch fixes the problem by using new unregistration interfaces,
which split unregister_shrinker() in two parts. First part actually only
notifies shrinker subsystem about the fact of unregistration and it prevents
future shrinker methods calls. The second part completes the unregistration
and it insures, that struct shrinker is not used during shrinker chain
iteration anymore, so shrinker memory may be freed. Since the long second
part is called from delayed work asynchronously, it hides synchronize_srcu()
delay from a user.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 fs/super.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 8d8d68799b34..f3e4f205ec79 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -159,6 +159,7 @@ static void destroy_super_work(struct work_struct *work)
 							destroy_work);
 	int i;
 
+	unregister_shrinker_delayed_finalize(&s->s_shrink);
 	for (i = 0; i < SB_FREEZE_LEVELS; i++)
 		percpu_free_rwsem(&s->s_writers.rw_sem[i]);
 	kfree(s);
@@ -327,7 +328,7 @@ void deactivate_locked_super(struct super_block *s)
 {
 	struct file_system_type *fs = s->s_type;
 	if (atomic_dec_and_test(&s->s_active)) {
-		unregister_shrinker(&s->s_shrink);
+		unregister_shrinker_delayed_initiate(&s->s_shrink);
 		fs->kill_sb(s);
 
 		/*

