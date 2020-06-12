Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232A11F7611
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 11:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgFLJeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 05:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgFLJeS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:34:18 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92904C03E96F
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:18 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id m21so5928591eds.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GQWhwLvFbjYdU+X3+8BOvGL0FjQrjs9VQW+nzjowkyQ=;
        b=e37S2qTy+EGuvxawpVOSRf8GRze8RPTK8+6Y6QhDL+jnYGZlVr1beVOGheXVHfih1s
         16u76vo1CoSDXjaSTOFDrMqCmJejNaiTHm/psd44N7vj2VDDEJWPHXXgvc9roJzhS6Qk
         ARbSlWWHB4wxyyHxF1V1j5CCUkKQ1/BOK2LFYTIoCYUMqPeejLL1d72oU9vzoWPoMf4t
         1O6uIU+55E+EsiBOYmR90DRGonlc9sJMXrenxzEA9WoVrsqxxoZCs1QJqoOjj8rxrmm8
         hKEFrBRVyay8i84adPndtjcwlzXlg84RlMzUMOHM4Tdvltfj2V096gDbUjfg8M/aDbKp
         bAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GQWhwLvFbjYdU+X3+8BOvGL0FjQrjs9VQW+nzjowkyQ=;
        b=ftmpU7MWDedyU3PN/JikV00tgCZZnkvG2EnB77lRxas6hBYAs2JO8oPNZ5IwmmZn3j
         yiycpve7uNGq3AwBw0lNrGbugBStlJ72B+hEsDwPKLEqJkzYk+E8nNmlLNK3nib3QDOI
         DfCTgbyMGp9rXhXuOKg/PJQ8HYKBnNTt1Qh1JDQqNDqY9q8phwCj2/ctnh46Q6jl4z4W
         o1GCqkURyg5R/j4pvINbn3wP3hMIwnwwXmHHmDC+LoCH+FFQTAOD8ugVDMuvx6idlO6S
         oNeyptcRm/OUxb++3YFbRFQsi57UMDpRURoZ2ERly2BKdqDlDeZqLJo+QVky3MvHnzgo
         4V8w==
X-Gm-Message-State: AOAM531D73Zd8zhge55kx3Frq1EfLkNWJAWow9tBdzpVACMLHBnTeFUt
        /jYqNAVO/maa/gtZJmTxn2G+m/X7
X-Google-Smtp-Source: ABdhPJwHAOpa7f5Dbdu6FC6IGreJAGxmIKa4F8QO0m2CqepENfc+MZOWkOOXxRjjMLQGLN1VzgABPw==
X-Received: by 2002:a50:e881:: with SMTP id f1mr10393530edn.98.1591954457350;
        Fri, 12 Jun 2020 02:34:17 -0700 (PDT)
Received: from localhost.localdomain ([5.102.204.95])
        by smtp.gmail.com with ESMTPSA id l2sm2876578edq.9.2020.06.12.02.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 02:34:16 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/20] fanotify: distinguish between fid encode error and null fid
Date:   Fri, 12 Jun 2020 12:33:35 +0300
Message-Id: <20200612093343.5669-13-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612093343.5669-1-amir73il@gmail.com>
References: <20200612093343.5669-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In fanotify_encode_fh(), both cases of NULL inode and failure to encode
ended up with fh type FILEID_INVALID.

Distiguish the case of NULL inode, by setting fh type to FILEID_ROOT.
This is just a semantic difference at this point.

Remove stale comment and unneeded check from fid event compare helpers.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 63865c5373e5..a982594ebca7 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -34,10 +34,6 @@ static bool fanotify_fh_equal(struct fanotify_fh *fh1,
 	if (fh1->type != fh2->type || fh1->len != fh2->len)
 		return false;
 
-	/* Do not merge events if we failed to encode fh */
-	if (fh1->type == FILEID_INVALID)
-		return false;
-
 	return !fh1->len ||
 		!memcmp(fanotify_fh_buf(fh1), fanotify_fh_buf(fh2), fh1->len);
 }
@@ -56,10 +52,7 @@ static bool fanotify_fid_event_equal(struct fanotify_fid_event *ffe1,
 static bool fanotify_name_event_equal(struct fanotify_name_event *fne1,
 				      struct fanotify_name_event *fne2)
 {
-	/*
-	 * Do not merge name events without dir fh.
-	 * FAN_DIR_MODIFY does not encode object fh, so it may be empty.
-	 */
+	/* Do not merge name events without dir fh */
 	if (!fne1->dir_fh.len)
 		return false;
 
@@ -290,8 +283,10 @@ static void fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	void *buf = fh->buf;
 	int err;
 
+	fh->type = FILEID_ROOT;
+	fh->len = 0;
 	if (!inode)
-		goto out;
+		return;
 
 	dwords = 0;
 	err = -ENOENT;
@@ -326,7 +321,6 @@ static void fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 			    type, bytes, err);
 	kfree(ext_buf);
 	*fanotify_fh_ext_buf_ptr(fh) = NULL;
-out:
 	/* Report the event without a file identifier on encode error */
 	fh->type = FILEID_INVALID;
 	fh->len = 0;
-- 
2.17.1

