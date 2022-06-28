Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5D955EFC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 22:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiF1UqY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 16:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiF1UqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:46:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88F232A407
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 13:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656449179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BcsVY1OPkKZ0bSTMBzDtRfeW2FEqJiWVDTUaBARc3oQ=;
        b=XjwXrDb+5+TaH7dtp/N5sHHGlLKzw8A61h2Pxgi3yXB+TEQHu6HX2H8E5d/pQBzr9w1iXS
        FMEGB/vJQubJ/kYO6OUZ0DX+udE26ayXvy+ItI3PfQtPQ7hwd8iYv3887lTFvxXwTs8h0s
        rViMdzfxlEBatB44eQfoK4gqBs6A02w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-if9X01vlPC-sowPfu-fSog-1; Tue, 28 Jun 2022 16:46:18 -0400
X-MC-Unique: if9X01vlPC-sowPfu-fSog-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17AAD1C0896B;
        Tue, 28 Jun 2022 20:46:18 +0000 (UTC)
Received: from max.localdomain (unknown [10.40.193.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2721D4050C4A;
        Tue, 28 Jun 2022 20:46:17 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     cluster-devel@redhat.com
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4/5] gfs2: Mark flock glock holders as GL_NOPID
Date:   Tue, 28 Jun 2022 22:46:10 +0200
Message-Id: <20220628204611.651126-5-agruenba@redhat.com>
In-Reply-To: <20220628204611.651126-1-agruenba@redhat.com>
References: <20220628204611.651126-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the GL_NOPID flag for flock glock holders.  Clean up the flag
setting code in do_flock.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/file.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 25f4080bc973..1383f9598011 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1472,7 +1472,9 @@ static int do_flock(struct file *file, int cmd, struct file_lock *fl)
 	int sleeptime;
 
 	state = (fl->fl_type == F_WRLCK) ? LM_ST_EXCLUSIVE : LM_ST_SHARED;
-	flags = (IS_SETLKW(cmd) ? 0 : LM_FLAG_TRY_1CB) | GL_EXACT;
+	flags = GL_EXACT | GL_NOPID;
+	if (!IS_SETLKW(cmd))
+		flags |= LM_FLAG_TRY_1CB;
 
 	mutex_lock(&fp->f_fl_mutex);
 
@@ -1500,7 +1502,8 @@ static int do_flock(struct file *file, int cmd, struct file_lock *fl)
 		error = gfs2_glock_nq(fl_gh);
 		if (error != GLR_TRYFAILED)
 			break;
-		fl_gh->gh_flags = LM_FLAG_TRY | GL_EXACT;
+		fl_gh->gh_flags &= ~LM_FLAG_TRY_1CB;
+		fl_gh->gh_flags |= LM_FLAG_TRY;
 		msleep(sleeptime);
 	}
 	if (error) {
-- 
2.35.1

