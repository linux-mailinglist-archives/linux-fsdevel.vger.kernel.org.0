Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774C81C5D4D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 18:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbgEEQU2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 12:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730038AbgEEQU1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 12:20:27 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C02DC061A0F
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2020 09:20:27 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so3462698wra.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 09:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TCmf8C5nawtAUHiRXaKtNRxo3DSeSTT/sSmZUFizx28=;
        b=apV54xOCmRKRBZzNeClNPt1TdFfT4HlH618FqsXYaWDVYCnVbOswuP51vq1OSLf7nu
         F/p2wa2IeD9FajjLMyjdRYxVdJvFnE/fEavwLE83jAl05zSSxU7IZt1BjEF2rswAy4R/
         dK2ZwGYL4MqTUiUVjNHmUvYxeSc72ku7evXA5MIe1xXQg574FGMw+O4MkxemcZG3P+Wq
         kQODPtEIgPH3aIASdcuE2XkgduwrmqnORNbtDMYNfmKumo+EiTiS7iZJwD6lCLNnDAeK
         EgeLQ3V3H2jk/ql3/Z1WFcsRE/j+cz3E0IYWMLa/aBJNrFvdJU3gcX9uapjQZzJDA/IE
         2q8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TCmf8C5nawtAUHiRXaKtNRxo3DSeSTT/sSmZUFizx28=;
        b=td7YNBEyVx2UQY6VatOzwVT0yewO3LX8ofC3OmRBbkIhtPMLzzJEC2O1EzEGichKDZ
         h112P+n/wFjvJ+EdGoG6EWC3d6i2iCpD4x99vicXVidJBxa8BWD56SnfFx/r7DPWYZ1Q
         pk8ywVHJRZeXZo7J08cl4s6sTXbuiNEbXqmXEj+rmcPeR2+u87of8Il4gHX0Rm5xCMyb
         pvGwfbwd/SXYsRTOFlVzeD0vlMJMVovuC8K3MGELVFj1J9CC1u75S6saiao2hkZg3293
         hJIGLClGaLnBcgwBCZRjrCp0cnHBUuqPdatPgoEh6B+9tsp3wHFnHUdy03LCu7pSmJsq
         Nskg==
X-Gm-Message-State: AGi0PuZCDd2BuUBL2RH7e/FptK2vuch6WX8H722b9r5wlT5sOvs/IRWk
        gxFe6YeZe/WaTv0P6gLCfDFiv46r
X-Google-Smtp-Source: APiQypKrCIAZEepr+QICFvMifhmzjtn4vCZOcu6jBenJIBfYe1yey0GJg6a3msgPJP61DCM+XJFIFw==
X-Received: by 2002:adf:97de:: with SMTP id t30mr4721626wrb.135.1588695625827;
        Tue, 05 May 2020 09:20:25 -0700 (PDT)
Received: from localhost.localdomain ([141.226.12.123])
        by smtp.gmail.com with ESMTPSA id c128sm1612871wma.42.2020.05.05.09.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 09:20:25 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 3/7] fanotify: generalize the handling of extra event flags
Date:   Tue,  5 May 2020 19:20:10 +0300
Message-Id: <20200505162014.10352-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505162014.10352-1-amir73il@gmail.com>
References: <20200505162014.10352-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In fanotify_group_event_mask() there is logic in place to make sure we
are not going to handle an event with no type and just FAN_ONDIR flag.
Generalize this logic to any FANOTIFY_EVENT_FLAGS.

There is only one more flag in this group at the moment,
FAN_EVENT_ON_CHILD, and we will soon need to mask it out.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index f5c21949fdaa..1e4a345155dd 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -264,11 +264,11 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	 * to user in FAN_REPORT_FID mode for all event types.
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

