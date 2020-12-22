Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C27F2E03D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 02:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgLVBW7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 20:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLVBW6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 20:22:58 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71645C061282;
        Mon, 21 Dec 2020 17:22:18 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id x13so10556567oto.8;
        Mon, 21 Dec 2020 17:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A7LGrv9arxrfdu1GFoCf8wflov+CFF7/hYY5Y4CreBA=;
        b=ZsOihlsXrtaRcPzizcEnEy3F5PmTWYsEcy1f5kKeLj8jJSOcNF0xwlbgW3ejiR1AWv
         Z1UMMX4HR0/vSYxVlOmRl59NYU+LQT2BISdKDnMNIaVZC8ENmywrpFa4l+CX3Brb3yvu
         3JU56JnXRF4Wcf5wKqVRgYlJFOrvJ3TkQT6xMhDjm8XQ52zSRqvZSxobNECUuefHS+o5
         ZnpANifQGAwhxWXHja0wkEeS0EUoKwjTLsb7IF/3fEQyfoti7vyUn1aZ0mpGCR0lPmMQ
         A6jMVYzgRptUqhBbk7GPDeYh8weR/Tu3rTfsyP8g/5lBuHkq6DoETuRdjE8Lvht6VZ/V
         ZVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A7LGrv9arxrfdu1GFoCf8wflov+CFF7/hYY5Y4CreBA=;
        b=KKToF6u089LrJA2Hb9g2Q27EVvmiRy2a37CzhO8FBMpax2AV6gLnjA8vGO880DceN4
         nCgm5/QyAaE4+U0/5yRS0js7MdDZtl5oJoOj7WRRj73SnK8sw1T9cOh1nThqyCTcTxIH
         +bhWROdQ/4XDAgfRiWXA1azgsp7eqijSWogdf2OFWzJyu+hE0oW4UeBGUfs7AxZZ1eQ+
         7GzuTBN+gboHsVCMVD26klZubpsjpbUOspycimemrCj/qWqhv/I/nZ1twwjvOcQL7qsF
         SHW+F4+8S49xBOAEy1W03DIvb+HCPhJhG/K0nJYHS7hdx/OgJzhfG+roXtM3kt1KLmR3
         uU6w==
X-Gm-Message-State: AOAM5308g9uZ9GFvCCt3ehjppzbo/d1aHa+u0ER1+mPbhYaEgOc1rqxp
        XY9TholOhfpjVi+LHb2FR/k=
X-Google-Smtp-Source: ABdhPJzWauZ4OUHVQCKycQCUNjLregUj88VEqRI/lgKXVo6Q989mL8effGg+mlhu6BTPp9ocg7Ka+g==
X-Received: by 2002:a9d:a4e:: with SMTP id 72mr14436297otg.267.1608600137947;
        Mon, 21 Dec 2020 17:22:17 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id x20sm4070098oov.33.2020.12.21.17.22.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 17:22:16 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, david@fromorbit.com,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 3/4] xfs: introduce xfs_trans_context_swap() for rolling transaction
Date:   Tue, 22 Dec 2020 09:21:30 +0800
Message-Id: <20201222012131.47020-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201222012131.47020-1-laoar.shao@gmail.com>
References: <20201222012131.47020-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the rolling transaction, thread's NOFS state is transferred from the
old transaction to the new transaction, and then the NOFS state stored
in the old one should be cleared.

Suggested-by: Dave Chinner <david@fromorbit.com>
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/xfs/xfs_trans.c |  4 +++-
 fs/xfs/xfs_trans.h | 10 +++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 11d390f0d3f2..733e0113aebe 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -119,7 +119,9 @@ xfs_trans_dup(
 
 	ntp->t_rtx_res = tp->t_rtx_res - tp->t_rtx_res_used;
 	tp->t_rtx_res = tp->t_rtx_res_used;
-	ntp->t_pflags = tp->t_pflags;
+
+	/* Associate the new transaction with this thread. */
+	xfs_trans_context_swap(tp, ntp);
 
 	/* move deferred ops over to the new tp */
 	xfs_defer_move(ntp, tp);
diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
index 44b11c64a15e..b428704eeb20 100644
--- a/fs/xfs/xfs_trans.h
+++ b/fs/xfs/xfs_trans.h
@@ -277,7 +277,15 @@ xfs_trans_context_set(struct xfs_trans *tp)
 static inline void
 xfs_trans_context_clear(struct xfs_trans *tp)
 {
-	memalloc_nofs_restore(tp->t_pflags);
+	if (!tp->t_flags)
+		memalloc_nofs_restore(tp->t_pflags);
+}
+
+static inline void
+xfs_trans_context_swap(struct xfs_trans *tp, struct xfs_trans *ntp)
+{
+	ntp->t_pflags = tp->t_pflags;
+	tp->t_flags = -1;
 }
 
 #endif	/* __XFS_TRANS_H__ */
-- 
2.18.4

