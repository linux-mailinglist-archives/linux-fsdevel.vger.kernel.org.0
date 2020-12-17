Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1DC2DD50C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 17:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgLQQT7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 11:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbgLQQT6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 11:19:58 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41758C0617B0
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 08:19:18 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id z136so28051189iof.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 08:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dH4yhvV2A033Po00xq4v2MOxDj8pbUF6BP+iJCY6sVo=;
        b=B1i0qKow9CCnMstMkdzHcbLY0nUpqWzsjWghECXQft23Vqmnfk4Vb7k3/5uwdQSe5+
         90F+gkf6sy75aLvAo18uwAG4Y9jMRM8uJxQbpi50TEgeHuvf6ljIX/imTYf9RxRVplgn
         P0Bw3wabPywI9WNbRVkssZ2daVJznt8xzsAeqj5GYflT3sgyPHa6rvcjJqv5E8MOAMll
         ynMNxPGI61yvyxujXu2YyI/L3T0INWPi1u/3OxFXSG6gua4vvl+CJUpw299oESe1YpRm
         sBHwLogeEhCu8XHaYMYfk3p9psXZ7S34/RO/rlFz/oDJNxFpRBqBX/tGKFpCs7m0rWsm
         yNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dH4yhvV2A033Po00xq4v2MOxDj8pbUF6BP+iJCY6sVo=;
        b=JQEbvINzTLZNlSdnirQab7ZxPl9ec6V7hrXabOd4lkOA4Zp/edjjllPM853QiCnV4x
         MjGs41cH0dEKaAMNMERN7llgs70kETYm7tp4J4omMsQExLysfN142ciCqk2/Hj1q54Os
         LrBGT5Pg1KXkpJPS1+imQKnt22ykZHRX01EAlsjxpY6DZdj5yDNdo15uU/oLSDRUwg6H
         WECljlnCLSuNfkss+vhRlem2hAzC2r0uvG8QK9gI7CRenPoda0bINDhW5chJOaP7cdct
         cP1kswMXdTz72E5Lte8Py59fe7T2fh147txc9UbuKmb5KbtR2LsgxuBhnEf9eRZR775P
         rjRg==
X-Gm-Message-State: AOAM532iMYLv8E2Q/iuXR4oeYVVtijU29pZrv2ecizWx/lpZxeNEAbvn
        C1+aB7Se23tEmf4PZecRIIiys/w+EWGFkA==
X-Google-Smtp-Source: ABdhPJyU6tVzgofAgt3iF6QljRrueGPzUIdXQuukp6TRegKsSv62+qTnCMTjGhv+gAFeArktXOyFvw==
X-Received: by 2002:a02:b02:: with SMTP id 2mr48456145jad.15.1608221957464;
        Thu, 17 Dec 2020 08:19:17 -0800 (PST)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k76sm3849957ilk.36.2020.12.17.08.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 08:19:16 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/4] fs: add support for LOOKUP_CACHED
Date:   Thu, 17 Dec 2020 09:19:09 -0700
Message-Id: <20201217161911.743222-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201217161911.743222-1-axboe@kernel.dk>
References: <20201217161911.743222-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

io_uring always punts opens to async context, since there's no control
over whether the lookup blocks or not. Add LOOKUP_CACHED to support
just doing the fast RCU based lookups, which we know will not block. If
we can do a cached path resolution of the filename, then we don't have
to always punt lookups for a worker.

During path resolution, we always do LOOKUP_RCU first. If that fails and
we terminate LOOKUP_RCU, then fail a LOOKUP_CACHED attempt as well.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/namei.c            | 9 +++++++++
 include/linux/namei.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index c31ddddcef3c..e051eb0fa7f9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -686,6 +686,8 @@ static bool try_to_unlazy(struct nameidata *nd)
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
 	nd->flags &= ~LOOKUP_RCU;
+	if (nd->flags & LOOKUP_CACHED)
+		goto out1;
 	if (unlikely(!legitimize_links(nd)))
 		goto out1;
 	if (unlikely(!legitimize_path(nd, &nd->path, nd->seq)))
@@ -722,6 +724,8 @@ static int unlazy_child(struct nameidata *nd, struct dentry *dentry, unsigned se
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
 	nd->flags &= ~LOOKUP_RCU;
+	if (nd->flags & LOOKUP_CACHED)
+		goto out2;
 	if (unlikely(!legitimize_links(nd)))
 		goto out2;
 	if (unlikely(!legitimize_mnt(nd->path.mnt, nd->m_seq)))
@@ -792,6 +796,7 @@ static int complete_walk(struct nameidata *nd)
 		 */
 		if (!(nd->flags & (LOOKUP_ROOT | LOOKUP_IS_SCOPED)))
 			nd->root.mnt = NULL;
+		nd->flags &= ~LOOKUP_CACHED;
 		if (!try_to_unlazy(nd))
 			return -ECHILD;
 	}
@@ -2202,6 +2207,10 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	int error;
 	const char *s = nd->name->name;
 
+	/* LOOKUP_CACHED requires RCU, ask caller to retry */
+	if ((flags & (LOOKUP_RCU | LOOKUP_CACHED)) == LOOKUP_CACHED)
+		return ERR_PTR(-EAGAIN);
+
 	if (!*s)
 		flags &= ~LOOKUP_RCU;
 	if (flags & LOOKUP_RCU)
diff --git a/include/linux/namei.h b/include/linux/namei.h
index a4bb992623c4..b9605b2b46e7 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -46,6 +46,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 #define LOOKUP_NO_XDEV		0x040000 /* No mountpoint crossing. */
 #define LOOKUP_BENEATH		0x080000 /* No escaping from starting point. */
 #define LOOKUP_IN_ROOT		0x100000 /* Treat dirfd as fs root. */
+#define LOOKUP_CACHED		0x200000 /* Only do cached lookup */
 /* LOOKUP_* flags which do scope-related checks based on the dirfd. */
 #define LOOKUP_IS_SCOPED (LOOKUP_BENEATH | LOOKUP_IN_ROOT)
 
-- 
2.29.2

