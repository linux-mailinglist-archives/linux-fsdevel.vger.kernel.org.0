Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A36C2D8872
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Dec 2020 18:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407681AbgLLQwR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Dec 2020 11:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405827AbgLLQv4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Dec 2020 11:51:56 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5559FC0613D6
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Dec 2020 08:51:16 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w16so9460064pga.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Dec 2020 08:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bs8HhYRrXZk0BV9zDW0PP2lEDiHkjRKLbU8rK5axhYs=;
        b=DCAvRPh01mhUixtYpjdb3M4oF+UQwH1+U1L3H8V1di+UmKZfcBIf7s59fhRCiIqYXP
         ci/T6N1fzeMocK02pTvSQDSbbwKlUpDy+/QWWSy8V92zsAmBuspiP0zDzlC7g1uPweBu
         /UaOHpwzyV4DpUy6MRSlz5QRQhz3n0NacJWj3n02lgMwhqvL83yxcyOKywZTm6s2199p
         Re+PqjC1mIrOSW4wEfxMR9TYMWy/i+gmdGBb8SEb+V389IqP6nAPYgURV6jKjCTT2TuG
         mikgnPvzXEUhwyxVH8ZNOB9wBwpMDgGJLPBXDJmKS5BGllpd+bV5SBaPbsgscxywd/hB
         mN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bs8HhYRrXZk0BV9zDW0PP2lEDiHkjRKLbU8rK5axhYs=;
        b=RvnWc5zsivSyIHaJsWzLhKvNi2LXKILFXnkNkVdV39Yx+sZJKKU20hjnUtDdkJlzIl
         kTPoABRs9bpxZcdNrYoc+ivLsJMpXV4mzBtcfqULVWjOE7wszvKgetZYVfst+J4Vdy2g
         ZQOKYUj/SEkNs19mgs9aXnFTYrw4rv8lrFX2kSqnV42dwQuz6PXUrRyoE+Abcw+GvDfz
         77OzbxJvdRXBC/8QiB9bZoJ7MZwO7Zple2YDiLtarapnkNCSZykrvKTZmXVfjshCLu9Y
         6+6gbE+V1C6AfUiFY6MgGwZezOiMYq6GsQGCa/acgLmlh7/YF/1TLdNowB+wx52srjKz
         fo2Q==
X-Gm-Message-State: AOAM530Y1CVRZIZfIUeiVmazcBUfHpFqitqyIvFiJg3B20WhIyg6Bn15
        TlDkasFvrHqczSGyXz9gs67giGBN0wTHRg==
X-Google-Smtp-Source: ABdhPJw3+16ATTQ3MDjPe8kI6WZqsUxvc4F+vRsV2sRVnR9mEgeXdD2JrRpWmD03ZXgSsJ7I0lVbPw==
X-Received: by 2002:aa7:9e52:0:b029:19e:6c32:30d4 with SMTP id z18-20020aa79e520000b029019e6c3230d4mr16709260pfq.21.1607791875532;
        Sat, 12 Dec 2020 08:51:15 -0800 (PST)
Received: from p1.localdomain ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s17sm14855352pge.37.2020.12.12.08.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 08:51:15 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/5] fs: add support for LOOKUP_NONBLOCK
Date:   Sat, 12 Dec 2020 09:51:02 -0700
Message-Id: <20201212165105.902688-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201212165105.902688-1-axboe@kernel.dk>
References: <20201212165105.902688-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

io_uring always punts opens to async context, since there's no control
over whether the lookup blocks or not. Add LOOKUP_NONBLOCK to support
just doing the fast RCU based lookups, which we know will not block. If
we can do a cached path resolution of the filename, then we don't have
to always punt lookups for a worker.

During path resolution, we always do LOOKUP_RCU first. If that fails and
we terminate LOOKUP_RCU, then fail a LOOKUP_NONBLOCK attempt as well.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/namei.c            | 9 +++++++++
 include/linux/namei.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 7eb7830da298..07a1aa874f65 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -686,6 +686,8 @@ static bool try_to_unlazy(struct nameidata *nd)
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
 	nd->flags &= ~LOOKUP_RCU;
+	if (nd->flags & LOOKUP_NONBLOCK)
+		goto out1;
 	if (unlikely(!legitimize_links(nd)))
 		goto out1;
 	if (unlikely(!legitimize_path(nd, &nd->path, nd->seq)))
@@ -722,6 +724,8 @@ static int unlazy_child(struct nameidata *nd, struct dentry *dentry, unsigned se
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
 	nd->flags &= ~LOOKUP_RCU;
+	if (nd->flags & LOOKUP_NONBLOCK)
+		goto out2;
 	if (unlikely(!legitimize_links(nd)))
 		goto out2;
 	if (unlikely(!legitimize_mnt(nd->path.mnt, nd->m_seq)))
@@ -792,6 +796,7 @@ static int complete_walk(struct nameidata *nd)
 		 */
 		if (!(nd->flags & (LOOKUP_ROOT | LOOKUP_IS_SCOPED)))
 			nd->root.mnt = NULL;
+		nd->flags &= ~LOOKUP_NONBLOCK;
 		if (!try_to_unlazy(nd))
 			return -ECHILD;
 	}
@@ -2202,6 +2207,10 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	int error;
 	const char *s = nd->name->name;
 
+	/* LOOKUP_NONBLOCK requires RCU, ask caller to retry */
+	if ((flags & (LOOKUP_RCU | LOOKUP_NONBLOCK)) == LOOKUP_NONBLOCK)
+		return ERR_PTR(-EAGAIN);
+
 	if (!*s)
 		flags &= ~LOOKUP_RCU;
 	if (flags & LOOKUP_RCU)
diff --git a/include/linux/namei.h b/include/linux/namei.h
index a4bb992623c4..c36c4e0805fc 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -46,6 +46,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 #define LOOKUP_NO_XDEV		0x040000 /* No mountpoint crossing. */
 #define LOOKUP_BENEATH		0x080000 /* No escaping from starting point. */
 #define LOOKUP_IN_ROOT		0x100000 /* Treat dirfd as fs root. */
+#define LOOKUP_NONBLOCK		0x200000 /* don't block for lookup */
 /* LOOKUP_* flags which do scope-related checks based on the dirfd. */
 #define LOOKUP_IS_SCOPED (LOOKUP_BENEATH | LOOKUP_IN_ROOT)
 
-- 
2.29.2

