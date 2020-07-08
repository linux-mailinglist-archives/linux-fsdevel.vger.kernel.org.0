Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7BE2185B8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgGHLMZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbgGHLMZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:12:25 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD60C08C5DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 04:12:24 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z2so26212412wrp.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 04:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yRQPB0bO5fRf+w+U7ylZ8gHdgwszFT8wyVGA9GecFLg=;
        b=O0aC90sm1cKdJOU8EXtxyXI5BDfnZEMaCQ9rQJBWIer15UEpOmlfDhYT9bk8QYSRIe
         o0H/3ZZXK8nfff+utOr8D3rl5Bs+osVUi57YgToPzIhCgVk19Io7szR9R+JkXWh1MOzR
         Ht6k9Vij0v67wrbSvDMXsaJgcf02kbSIr6kCzzMn6P/owPo1ZdgK5Dqn5TK7Ws3+eBh7
         tUOkJeCFzM+JJYTrIzzvWCQ97j0GaQLepHJJGaVqa2AS18YRe5LQ75s3CbtqkmFtwzbc
         lcte2KdveL0Z0OR0k9eXWV1c9qr2FJbIMMksQcC7A6gjNmdze4Hvz3zPqsTY21UG9il3
         L51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yRQPB0bO5fRf+w+U7ylZ8gHdgwszFT8wyVGA9GecFLg=;
        b=RzPp0PTfv0ImVbODOWkXRgw7qgqB+h4hrE0KZoV+4juAta8pjD1edoxAPWt5f+N/7d
         Gv0VUZIFIPenF+i6kmonAh//zf6cZeCHRu/xRXpNK+RDTcb818hKDByOtlon24TwD996
         baO+WQM9cEQDFO7AtNmDXEMb/jCenGTbg9kiK4VY2J9Ib+OU3Oo0PPu/9Jtbe3pq/1eu
         VB4rK7sJM/oZNuUtausGoXO36cGSGYND7Bht9SLCBudgbhSfcA8ZykErs6n5cUA6lVUD
         cdrFhd8U3QA3rhcJ63lbGIksCyewof4NvM2avNx1WMKW7ngeLYbXem4qjr3I1okXYrtg
         qtTg==
X-Gm-Message-State: AOAM530HEN1nEvIYzkIQOo+543zR7l0RT/Kvzp4WMQgPPJIiRN8BhkgD
        HciYEQn5uvFMcIlD2+bYkgo=
X-Google-Smtp-Source: ABdhPJzzRBui7nw5H2Br2s9DvbwUPP0/xSyo7aQJpsrS+v15eNQ0jDNgiTR83RY/Uhdnj80n33Iu7g==
X-Received: by 2002:adf:e74e:: with SMTP id c14mr61412355wrn.143.1594206743435;
        Wed, 08 Jul 2020 04:12:23 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id k126sm5980834wme.17.2020.07.08.04.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:12:22 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 12/20] fanotify: distinguish between fid encode error and null fid
Date:   Wed,  8 Jul 2020 14:11:47 +0300
Message-Id: <20200708111156.24659-12-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708111156.24659-1-amir73il@gmail.com>
References: <20200708111156.24659-1-amir73il@gmail.com>
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
index 94316639cafb..ef8a1b698691 100644
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

