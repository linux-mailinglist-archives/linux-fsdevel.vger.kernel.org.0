Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EDF221EA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 10:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgGPImp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 04:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgGPImm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:42:42 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2393FC061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 22so9424723wmg.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ISCio/c6BwtLabpK0j/QeY3rqxRy+P4irG+jRMX0SCE=;
        b=R70H80X76YCUI8O8zBj2KLnycxreVVpCGSJ8OfHzPohDBJrEbORQeDQOCzTykjxldc
         Juzz8KOiKjrp3T+8YRV8q/IlbvJv1n8D5bITlmzf3h2M65fzUJH2x69ZE7oVKvMrK+Ao
         7uJcOBeXCL1Wo4x4N5auYTyKo2gpSYDKAiOQRsJ5XwtAFmhmV+ssMAL0t8j1eNQNfrTl
         pbPQ28lfxTifeD8QV1kdXOFNz7kwBqfKB4EwAi7u5sKEJQBKsBQpLdmSIPeUQSEzc0dz
         o+rb0rzmrLTUB5wkT/RisOsziOODauOF8QPivyvs2K4k0/geI/tbAZv95OYiWq7yvCQV
         Qvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ISCio/c6BwtLabpK0j/QeY3rqxRy+P4irG+jRMX0SCE=;
        b=unYIde5KMlhHQj/E5GyHlevNiRBcGUBes3ZxJuvcntB/8J4o3acvCCPtLtWqYDnTno
         zfCiVYTyNAM3C3/rS2xlYC3oJi2hUJjWS4IeCKrrao6WxkLRYHp+KwP2y700CdM4LHNp
         U3f/stieaVKEuKiqSzhu04Y8abxBGYP5+/2vyJ02vzkyCN+kHv4yITeQVpn2qWSOxaO/
         tYTyMUru7vZaolBO4/JOZXXtytXsqOz0jgz9WTs4qZ4exLYeZk/+6zABXQSU0HmHsjTr
         rpoaU1a2QGDAB1uHm+Xs5l+uGUUGYqGKjjPlL1cc48EtQsRIiseaPSeuN15/EaKwZugV
         A4Sg==
X-Gm-Message-State: AOAM531aCfOlJFnmL33Ore4pScv/MU6s1wWA1JdievC1V5QNG/cYI12k
        /JHHbqLvfpQhklaJA2IEXOPGy9tv
X-Google-Smtp-Source: ABdhPJyIbN0hCxYL//Ahzu+LEsYIIcmIf4Iy2fKmh7A/3LAK3FK2ns5zksDT0Zm7OmdKYnW3egBZNA==
X-Received: by 2002:a1c:9d0c:: with SMTP id g12mr3426774wme.107.1594888960848;
        Thu, 16 Jul 2020 01:42:40 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id j75sm8509977wrj.22.2020.07.16.01.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:42:40 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 03/22] fanotify: distinguish between fid encode error and null fid
Date:   Thu, 16 Jul 2020 11:42:11 +0300
Message-Id: <20200716084230.30611-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716084230.30611-1-amir73il@gmail.com>
References: <20200716084230.30611-1-amir73il@gmail.com>
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
index 84c86a45874c..3dc71a8e795a 100644
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

