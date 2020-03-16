Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9EB18764B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 00:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732954AbgCPXiv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 19:38:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33498 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732932AbgCPXiv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 19:38:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so23423350wrd.0;
        Mon, 16 Mar 2020 16:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s7MT1W4c0iLCPP6WJDplp79IQPzcsZf4PRM5SEuNrW4=;
        b=VUq7JVDvVVdvjOIFNpX/FRhbAtLHjXOHzOAYtH7CclKhk0PX6gE4NDOyrwdczDR96g
         XBPqQ/qmho70NGmAt9wpd6HIIdYruSDqmfTcv+XYRf8TsIf11fRiVVTov167IXkwKSG/
         5fXFkJBcWLHCl3GlZo+kQBBocGEPbOHnPn9aYTwd3s5kWipZO/L87zu4QF4bfZYf9IWj
         75EsJ6F59P1m+IuIInW1wB6e3nmPioqZhPlofGL40Pd5O0D8r8CWdFqvsp3siggp+ERv
         o15mdaMOUxbchwp0XZUWf/9S/RJB0Vsujsa8nsFCi1jU9/mSuX0DlhwTb6S7WAnT/fuM
         +DlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s7MT1W4c0iLCPP6WJDplp79IQPzcsZf4PRM5SEuNrW4=;
        b=euaJM4hRGZAL13PAJLmEZa1AqP2Ej/RObBvgIiRFNJyUwdexXgPzv6Gc3b918TIXeT
         B7UH5ZJWkpOu0waDtycW0rbMDy7x7zzr5BPeevufUay60jmdyvZ4yTu/N8s7homURNxR
         mnYLdt9jmIfJweC8Bi4zAju+tZadDGMKHCjcqTRJ/dpx1h64sZsYh3anc69WKzTLcFfA
         /F4TfgsZwxtDkbZEhvzSbtpOvn2/Mzjd9+Z6GhIyfAlHA0pRWEBqdf8SvbpvrRw8LIN+
         muCuTNi655sHzfrEUwXROS8MviBKCZilE17ZCx1qC7Oja+lSTihhtZm5s2e2k+alV/lk
         KJpg==
X-Gm-Message-State: ANhLgQ3nitSqvEWxNj2Ix1VnGDSb4G5mLFpuhkKMEZ90QOaTs5O1dfgK
        87DY541/fCr+mkqXNZnaKH2Wnx98YA==
X-Google-Smtp-Source: ADFU+vs8yceWIx6H0vj2f2I+P9/G6KQwzFtNlEfkONE+N15XxTsAk5Y2edcwjSd0PYP0tBCmiGhJ7A==
X-Received: by 2002:a5d:4ad1:: with SMTP id y17mr1744026wrs.119.1584401930067;
        Mon, 16 Mar 2020 16:38:50 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-82-35.as13285.net. [92.23.82.35])
        by smtp.googlemail.com with ESMTPSA id i9sm1510495wmd.37.2020.03.16.16.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 16:38:49 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 3/6] fs: Add missing annotation for __wait_on_freeing_inode()
Date:   Mon, 16 Mar 2020 23:38:01 +0000
Message-Id: <20200316233804.96657-4-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316233804.96657-1-jbi.octave@gmail.com>
References: <0/6>
 <20200316233804.96657-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sparse reports a warning at __wait_on_freeing_inode()

warning: context imbalance in __wait_on_freeing_inode() - unexpected unlock

The root cause is the missing annotations at __wait_on_freeing_inode()

Add the missing __releases(&inode->i_lock)
	and __must_hold(&inode_hash_lock) annotations

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 fs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 7d57068b6b7a..3b06c5c59883 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1955,6 +1955,8 @@ EXPORT_SYMBOL(inode_needs_sync);
  * will DTRT.
  */
 static void __wait_on_freeing_inode(struct inode *inode)
+	__releases(&inode->i_lock)
+	__must_hold(&inode_hash_lock)
 {
 	wait_queue_head_t *wq;
 	DEFINE_WAIT_BIT(wait, &inode->i_state, __I_NEW);
-- 
2.24.1

