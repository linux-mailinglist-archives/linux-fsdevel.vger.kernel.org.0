Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2F4754709
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jul 2023 08:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjGOGba (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jul 2023 02:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOGbZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jul 2023 02:31:25 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6657A2726;
        Fri, 14 Jul 2023 23:31:24 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso26154945e9.0;
        Fri, 14 Jul 2023 23:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689402682; x=1691994682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5499ObPoo5ZYZm4cR26jD7+9ROdxWSkLTLfdSFPaw5E=;
        b=GDokpqBhwTxdi/FxZ+GgecZdhADW5Xn7QbWLhDoA/w5OwA2OO7waF1Vc2gujTiRL42
         1cv9ygVHFlmhL68HBxqZkZCbrwyIz/7FFvD+ZmFMNGnK4YQ7Q3yxorhxXZBta/RymOBi
         1odO6zGMX3IOAVX0JqWPjAcjI/g2SqDMQZyQuoF4iowgxHOzQMRbIJq8191bPF1GRuCj
         OXFMMyWZ9MlGF4YDfyI1jOmVZ3t15XXHaNA3sGdqWDFj+gATUGO6zZz58seBfC7oYf7M
         E6X14+6gNAwUHsuF7lI45/7lZG1pBmVgq/rXe91WeESr4qEDWIyrcAI6dKj2C9dPPNkG
         TL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689402682; x=1691994682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5499ObPoo5ZYZm4cR26jD7+9ROdxWSkLTLfdSFPaw5E=;
        b=EOu93urLqEIL8g26QvTeOkd+6rXtE0Z66OJUKNe8l/onWIhali9/FtVB08lTfqk6zB
         9u+RiS3PVba+okTyBg52bqmC4Dmi1xdVPUhH0WkxSNr7heUjrjyq2BzRw/KNpWqP+cOU
         MAy3em1fTAs0Ocm4Kby6w7Kq0DXXLcR6jP4zcy5bdQTZzHisg9deGJ3MpaYe2EvRBJb1
         Yzh7BOjxSoadNorDFuPNjHr7maFvcVHh1FfI2OXzY1KrF9T+K19GYCX8jThP0SUEnEPt
         8NvJ0fPUIOPh6DIAiTsF7GSRqNmajboP0ipIVyhe0y7lbvCP6953wFCsDV8HF9ykxgZZ
         GxeA==
X-Gm-Message-State: ABy/qLYstbp6TjIGf57xXU00Cvf4s7PNO15GipffDOi0CRgACYGdyaas
        CgtWmmVxNQKfNoBdunxom1M=
X-Google-Smtp-Source: APBJJlHbx2VhDR5H4x0sHLPQObn3zeqvVS4Sa+6B7t4I3n3TLSwgmiW5fj7lxvBLpeZbpAaLW10qvw==
X-Received: by 2002:a05:600c:c8:b0:3fc:182:7eac with SMTP id u8-20020a05600c00c800b003fc01827eacmr6637922wmm.33.1689402682296;
        Fri, 14 Jul 2023 23:31:22 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bcb86000000b003fbe36a4ce6sm2957360wmi.10.2023.07.14.23.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 23:31:21 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCH 6.1 1/4] xfs: explicitly specify cpu when forcing inodegc delayed work to run immediately
Date:   Sat, 15 Jul 2023 09:31:11 +0300
Message-Id: <20230715063114.1485841-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715063114.1485841-1-amir73il@gmail.com>
References: <20230715063114.1485841-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Darrick J. Wong" <djwong@kernel.org>

commit 03e0add80f4cf3f7393edb574eeb3a89a1db7758 upstream.

I've been noticing odd racing behavior in the inodegc code that could
only be explained by one cpu adding an inode to its inactivation llist
at the same time that another cpu is processing that cpu's llist.
Preemption is disabled between get/put_cpu_ptr, so the only explanation
is scheduler mayhem.  I inserted the following debug code into
xfs_inodegc_worker (see the next patch):

	ASSERT(gc->cpu == smp_processor_id());

This assertion tripped during overnight tests on the arm64 machines, but
curiously not on x86_64.  I think we haven't observed any resource leaks
here because the lockfree list code can handle simultaneous llist_add
and llist_del_all functions operating on the same list.  However, the
whole point of having percpu inodegc lists is to take advantage of warm
memory caches by inactivating inodes on the last processor to touch the
inode.

The incorrect scheduling seems to occur after an inodegc worker is
subjected to mod_delayed_work().  This wraps mod_delayed_work_on with
WORK_CPU_UNBOUND specified as the cpu number.  Unbound allows for
scheduling on any cpu, not necessarily the same one that scheduled the
work.

Because preemption is disabled for as long as we have the gc pointer, I
think it's safe to use current_cpu() (aka smp_processor_id) to queue the
delayed work item on the correct cpu.

Fixes: 7cf2b0f9611b ("xfs: bound maximum wait time for inodegc work")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_icache.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index eae7427062cf..536885f8b8a8 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -2052,7 +2052,8 @@ xfs_inodegc_queue(
 		queue_delay = 0;
 
 	trace_xfs_inodegc_queue(mp, __return_address);
-	mod_delayed_work(mp->m_inodegc_wq, &gc->work, queue_delay);
+	mod_delayed_work_on(current_cpu(), mp->m_inodegc_wq, &gc->work,
+			queue_delay);
 	put_cpu_ptr(gc);
 
 	if (xfs_inodegc_want_flush_work(ip, items, shrinker_hits)) {
@@ -2096,7 +2097,8 @@ xfs_inodegc_cpu_dead(
 
 	if (xfs_is_inodegc_enabled(mp)) {
 		trace_xfs_inodegc_queue(mp, __return_address);
-		mod_delayed_work(mp->m_inodegc_wq, &gc->work, 0);
+		mod_delayed_work_on(current_cpu(), mp->m_inodegc_wq, &gc->work,
+				0);
 	}
 	put_cpu_ptr(gc);
 }
-- 
2.34.1

