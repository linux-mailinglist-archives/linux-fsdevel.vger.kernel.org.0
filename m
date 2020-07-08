Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4852185B6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbgGHLMX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbgGHLMV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:12:21 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796EEC08C5DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 04:12:21 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b6so48464299wrs.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 04:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0RznM6V9EpewBz0nSAqAQ+u8DNu6bH6DPGPWPaSW9EE=;
        b=Q6RnHhZH/BgMuj9Mt7O37QN8HuJhjl0WkZTd5ecgdH6TY80tljDkJg2b9LhMj4m2+A
         Jql7D9ZTlPaOgUiEAo48S8rTw7EFQ6zeYJkaFCrrd/aWrT6PpqECpQR9/d+qR3/lpA58
         Hl52v2oHcJNl+lajAa/88YYAwlJyMg/dbgyvbNAKivM5z82rkaDEKQp4i6GGTMutoo7f
         oXIpyPltbpDoP5B9+cW6+v6OPyKX2rVZ4xzgc5svo2cRaAz44eAfltBYcF2yXXKjHMqd
         oDzwF+7/t61Okqx9PzpjTbTaJ2b9RSZjOckFnHkgIxs7EokteQlK4fDkz3sy4hEX3Or7
         ni+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0RznM6V9EpewBz0nSAqAQ+u8DNu6bH6DPGPWPaSW9EE=;
        b=Sq42GQIIBpjxbVC7Fyt/O+VCwovOec9XBc8ZkEcBBHic/N9o2A+Xz2BB1U1wFznK+8
         yt5f3kLhoQ0jCTbI7UW+qIY62zvwPRjV3UUv3EgWu/2INLGr7YjnXrXL8qmhn9B7PrGH
         Crfvm3te3NMnd44IriRqMO4OrEjIPyG0FRwJDMNlUq92AW3wxGFNUG0mzfaeh6FmtzTv
         esxOm0SWGbHakLX2UfrGzQNehOmMyxY8ARatHsxBsEXEBkMzxuyE15WLkUwtf8QTaw7c
         kEAGWsV7GmZUWjdorIKrtKuRD8GQ1lnTixUQQRHVuNB7aw7BftxRFaK1b9shdbRX8om3
         1PXQ==
X-Gm-Message-State: AOAM530oQFi/6LgquDY+xmVQBYVnAI6UMD8AIkenbARWHS/Hds85acw5
        E0+8atX5ddo/bfdwNeNGIMoZwc3w
X-Google-Smtp-Source: ABdhPJwqBAeOADjUwqlE24OR6DWbopXVrWGgRPZaOAj0qiQPfoLMNBBWEPHr5YOLUDK00uBZ4cA5hw==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr28063145wrm.113.1594206740260;
        Wed, 08 Jul 2020 04:12:20 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id k126sm5980834wme.17.2020.07.08.04.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:12:19 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 10/20] fanotify: generalize the handling of extra event flags
Date:   Wed,  8 Jul 2020 14:11:45 +0300
Message-Id: <20200708111156.24659-10-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708111156.24659-1-amir73il@gmail.com>
References: <20200708111156.24659-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In fanotify_group_event_mask() there is logic in place to make sure we
are not going to handle an event with no type and just FAN_ONDIR flag.
Generalize this logic to any FANOTIFY_EVENT_FLAGS.

There is only one more flag in this group at the moment -
FAN_EVENT_ON_CHILD. We never report it to user, but we do pass it in to
fanotify_alloc_event() when group is reporting fid as indication that
event happened on child. We will have use for this indication later on.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index e68a9fad98bd..d853acc62b83 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -211,7 +211,8 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 				     int data_type)
 {
 	__u32 marks_mask = 0, marks_ignored_mask = 0;
-	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS;
+	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS |
+				     FANOTIFY_EVENT_FLAGS;
 	const struct path *path = fsnotify_data_path(data, data_type);
 	struct fsnotify_mark *mark;
 	int type;
@@ -264,14 +265,18 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	 *
 	 * For backward compatibility and consistency, do not report FAN_ONDIR
 	 * to user in legacy fanotify mode (reporting fd) and report FAN_ONDIR
-	 * to user in FAN_REPORT_FID mode for all event types.
+	 * to user in fid mode for all event types.
+	 *
+	 * We never report FAN_EVENT_ON_CHILD to user, but we do pass it in to
+	 * fanotify_alloc_event() when group is reporting fid as indication
+	 * that event happened on child.
 	 */
 	if (FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
-		/* Do not report FAN_ONDIR without any event */
-		if (!(test_mask & ~FAN_ONDIR))
+		/* Do not report event flags without any event */
+		if (!(test_mask & ~FANOTIFY_EVENT_FLAGS))
 			return 0;
 	} else {
-		user_mask &= ~FAN_ONDIR;
+		user_mask &= ~FANOTIFY_EVENT_FLAGS;
 	}
 
 	return test_mask & user_mask;
-- 
2.17.1

