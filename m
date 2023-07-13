Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502847524AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 16:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbjGMOKm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 10:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjGMOKk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:10:40 -0400
X-Greylist: delayed 4442 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Jul 2023 07:10:39 PDT
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8B6212D;
        Thu, 13 Jul 2023 07:10:39 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4R1xMw0SSlz9sRm;
        Thu, 13 Jul 2023 16:10:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1689257436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DsJX/tFpbTwtQ2LSeMQrzi9/53b88Qdy1opjeZwYFME=;
        b=LgbtBXv50U/WMflAcuUJfocHrynxphke7hl5cwiqpeOPrJIN49aI0t3xCmzdx6NFv6CFIv
        b/P0NDXnaWETV00yq6QxV4DkZR+Yh1kZuLx4L8og/bxJ4S+mxJYAfpIB4SuvCAjKBWmNKf
        87urlpwu7g3GpG8hDcrCtOD0BoAFBJ+ksUfUbINpqvtLX14kRqWnjkygwxup85wVgWpIS8
        ft8FwM6lCVVF6gZfpjZeC6V4Mc19VCxvwSm1MvZ50K+XjAYx/El9FiT4M2Yc/SJDOp/SLe
        WUZZMu2YXRjZKZIXXG/NvEpcp55H23dT6b1xfW28rjq8poauQhKlXhoasgVhvg==
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        xu xin <cgel.zte@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Stefan Roesch <shr@devkernel.io>,
        Janis Danisevskis <jdanis@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Aleksa Sarai <cyphar@cyphar.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] procfs: block chmod on /proc/thread-self/comm
Date:   Fri, 14 Jul 2023 00:09:58 +1000
Message-ID: <20230713141001.27046-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4R1xMw0SSlz9sRm
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Due to an oversight in commit 1b3044e39a89 ("procfs: fix pthread
cross-thread naming if !PR_DUMPABLE") in switching from REG to NOD,
chmod operations on /proc/thread-self/comm were no longer blocked as
they are on almost all other procfs files.

A very similar situation with /proc/self/environ was used to as a root
exploit a long time ago, but procfs has SB_I_NOEXEC so this is simply a
correctness issue.

Ref: https://lwn.net/Articles/191954/
Ref: 6d76fa58b050 ("Don't allow chmod() on the /proc/<pid>/ files")
Fixes: 1b3044e39a89 ("procfs: fix pthread cross-thread naming if !PR_DUMPABLE")
Cc: stable@vger.kernel.org # v4.7+
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
v2: removed nolibc selftests as per review
v1: <https://lore.kernel.org/linux-fsdevel/20230713121907.9693-1-cyphar@cyphar.com/>
---
 fs/proc/base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 05452c3b9872..7394229816f3 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3583,7 +3583,8 @@ static int proc_tid_comm_permission(struct mnt_idmap *idmap,
 }
 
 static const struct inode_operations proc_tid_comm_inode_operations = {
-		.permission = proc_tid_comm_permission,
+		.setattr	= proc_setattr,
+		.permission	= proc_tid_comm_permission,
 };
 
 /*
-- 
2.41.0

