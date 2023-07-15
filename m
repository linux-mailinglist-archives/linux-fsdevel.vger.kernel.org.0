Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFB4754710
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jul 2023 08:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjGOGbb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jul 2023 02:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjGOGb2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jul 2023 02:31:28 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F10B2D7B;
        Fri, 14 Jul 2023 23:31:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso23065115e9.2;
        Fri, 14 Jul 2023 23:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689402685; x=1691994685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AXY8sGXuOMpTkb31aXJGFVK03qdQQBJUaLjhUzmYCs=;
        b=nBa1tA9QEislcV5CGrscgZ6jyVcHcXgNNizrSh2qBMYJM8wssB8ILuKUX5bV4+N8xj
         dUCYWk6OJUCxmNtq7p1BD1x3B0JAyitZBuap4y90aav+CWMW6avz9HRJ3SGtVmYKHGZw
         ySo5MrzUvRetD1mPbepRvuyd9JGJSQ5bZ79DuqwUAJdPl3qkHAKjkYU+4+yZw4qcsD2H
         YIESdaYQYRjU4bF/gnpRebmeIeKtU99tIxUAoQPKPFCZTtQrtRnnfjpFur5vm/yvqV4n
         zWvTJmETAAhjFlKePxKXWkuyhhE7Ipt7zfSIAknamcSwlgcn23Qb1w+imQcbrGjaokZn
         HTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689402685; x=1691994685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AXY8sGXuOMpTkb31aXJGFVK03qdQQBJUaLjhUzmYCs=;
        b=BYRRWWDtseUaSEoHYOVLjYmDpDKce9KGPsW7jEha7xD3mTPMSSv46kIKTC5caThlbZ
         napX38X3+8qT2vDqnGaoVgOyG4ynD3p/ldaUGatpELWH5E0iSBOsmSeSFi/lyUzVozym
         DWj8/OElzdQJDMQiZKhWOiS/pbIKf4wdsFZpslDxPEEf6ObO3pmnw7zXzyaH1Qb+gg2U
         s5tDbkUCaXDSDI++mT76uNTRJTHafwuQKKPRrgPZ315S7t/FSsm4XDtBeaP/pliBFQyZ
         eZLoJS9U26tnDKqlY5mHv6V0oI9fFng2idnTr3aFByU8QmBwZ9KCBGh9DcON73hFb/Zt
         rvJA==
X-Gm-Message-State: ABy/qLavApKG6iHs8lExlYwuHnm96VVXSfEcdPyRRzO1SEvjAQb/vZWp
        WYBRuft4+jc/1iuh+7HGQX8=
X-Google-Smtp-Source: APBJJlE7Xuakk0qM4YH9U+I/TifU81VcfMgJpfAsVa64dMnDBq1olyK69fciRlLeBN0SkgXEX2ewpg==
X-Received: by 2002:a7b:c319:0:b0:3fb:a2b6:8dfd with SMTP id k25-20020a7bc319000000b003fba2b68dfdmr4853172wmj.32.1689402685459;
        Fri, 14 Jul 2023 23:31:25 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bcb86000000b003fbe36a4ce6sm2957360wmi.10.2023.07.14.23.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 23:31:25 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCH 6.1 3/4] xfs: disable reaping in fscounters scrub
Date:   Sat, 15 Jul 2023 09:31:13 +0300
Message-Id: <20230715063114.1485841-4-amir73il@gmail.com>
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

commit 2d5f38a31980d7090f5bf91021488dc61a0ba8ee upstream.

The fscounters scrub code doesn't work properly because it cannot
quiesce updates to the percpu counters in the filesystem, hence it
returns false corruption reports.  This has been fixed properly in
one of the online repair patchsets that are under review by replacing
the xchk_disable_reaping calls with an exclusive filesystem freeze.
Disabling background gc isn't sufficient to fix the problem.

In other words, scrub doesn't need to call xfs_inodegc_stop, which is
just as well since it wasn't correct to allow scrub to call
xfs_inodegc_start when something else could be calling xfs_inodegc_stop
(e.g. trying to freeze the filesystem).

Neuter the scrubber for now, and remove the xchk_*_reaping functions.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/scrub/common.c     | 26 --------------------------
 fs/xfs/scrub/common.h     |  2 --
 fs/xfs/scrub/fscounters.c | 13 ++++++-------
 fs/xfs/scrub/scrub.c      |  2 --
 fs/xfs/scrub/scrub.h      |  1 -
 5 files changed, 6 insertions(+), 38 deletions(-)

diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index 9bbbf20f401b..e71449658ecc 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -865,29 +865,3 @@ xchk_ilock_inverted(
 	}
 	return -EDEADLOCK;
 }
-
-/* Pause background reaping of resources. */
-void
-xchk_stop_reaping(
-	struct xfs_scrub	*sc)
-{
-	sc->flags |= XCHK_REAPING_DISABLED;
-	xfs_blockgc_stop(sc->mp);
-	xfs_inodegc_stop(sc->mp);
-}
-
-/* Restart background reaping of resources. */
-void
-xchk_start_reaping(
-	struct xfs_scrub	*sc)
-{
-	/*
-	 * Readonly filesystems do not perform inactivation or speculative
-	 * preallocation, so there's no need to restart the workers.
-	 */
-	if (!xfs_is_readonly(sc->mp)) {
-		xfs_inodegc_start(sc->mp);
-		xfs_blockgc_start(sc->mp);
-	}
-	sc->flags &= ~XCHK_REAPING_DISABLED;
-}
diff --git a/fs/xfs/scrub/common.h b/fs/xfs/scrub/common.h
index 454145db10e7..2ca80102e704 100644
--- a/fs/xfs/scrub/common.h
+++ b/fs/xfs/scrub/common.h
@@ -148,7 +148,5 @@ static inline bool xchk_skip_xref(struct xfs_scrub_metadata *sm)
 
 int xchk_metadata_inode_forks(struct xfs_scrub *sc);
 int xchk_ilock_inverted(struct xfs_inode *ip, uint lock_mode);
-void xchk_stop_reaping(struct xfs_scrub *sc);
-void xchk_start_reaping(struct xfs_scrub *sc);
 
 #endif	/* __XFS_SCRUB_COMMON_H__ */
diff --git a/fs/xfs/scrub/fscounters.c b/fs/xfs/scrub/fscounters.c
index 6a6f8fe7f87c..88d6961e3886 100644
--- a/fs/xfs/scrub/fscounters.c
+++ b/fs/xfs/scrub/fscounters.c
@@ -128,13 +128,6 @@ xchk_setup_fscounters(
 	if (error)
 		return error;
 
-	/*
-	 * Pause background reclaim while we're scrubbing to reduce the
-	 * likelihood of background perturbations to the counters throwing off
-	 * our calculations.
-	 */
-	xchk_stop_reaping(sc);
-
 	return xchk_trans_alloc(sc, 0);
 }
 
@@ -353,6 +346,12 @@ xchk_fscounters(
 	if (fdblocks > mp->m_sb.sb_dblocks)
 		xchk_set_corrupt(sc);
 
+	/*
+	 * XXX: We can't quiesce percpu counter updates, so exit early.
+	 * This can be re-enabled when we gain exclusive freeze functionality.
+	 */
+	return 0;
+
 	/*
 	 * If ifree exceeds icount by more than the minimum variance then
 	 * something's probably wrong with the counters.
diff --git a/fs/xfs/scrub/scrub.c b/fs/xfs/scrub/scrub.c
index 2e8e400f10a9..95132490fda5 100644
--- a/fs/xfs/scrub/scrub.c
+++ b/fs/xfs/scrub/scrub.c
@@ -171,8 +171,6 @@ xchk_teardown(
 	}
 	if (sc->sm->sm_flags & XFS_SCRUB_IFLAG_REPAIR)
 		mnt_drop_write_file(sc->file);
-	if (sc->flags & XCHK_REAPING_DISABLED)
-		xchk_start_reaping(sc);
 	if (sc->buf) {
 		kmem_free(sc->buf);
 		sc->buf = NULL;
diff --git a/fs/xfs/scrub/scrub.h b/fs/xfs/scrub/scrub.h
index 3de5287e98d8..4cb32c27df10 100644
--- a/fs/xfs/scrub/scrub.h
+++ b/fs/xfs/scrub/scrub.h
@@ -88,7 +88,6 @@ struct xfs_scrub {
 
 /* XCHK state flags grow up from zero, XREP state flags grown down from 2^31 */
 #define XCHK_TRY_HARDER		(1 << 0)  /* can't get resources, try again */
-#define XCHK_REAPING_DISABLED	(1 << 2)  /* background block reaping paused */
 #define XREP_ALREADY_FIXED	(1 << 31) /* checking our repair work */
 
 /* Metadata scrubbers */
-- 
2.34.1

