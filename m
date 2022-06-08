Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D4E543137
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 15:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbiFHNTd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 09:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240033AbiFHNTd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:19:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF566387AB
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 06:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654694371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=SwNazhl3yXSKLkMfxmQhMsW0Mn4hYb8ENtRNGo7fZsI=;
        b=JEtyEL6zlTLOe4pfSB7/ZxWf7xGcKLHmcCR3P6ZrsZxfogD1PLYum7tcfOmFYjKlaQxqOa
        w86ktbx9WKMj8kcnA7h07Bqo8MaGb6OB5ufh5LpFbftNKBGJpavwg2LNLjtIbhCjds7OeE
        DBsneEOxt/fkkHtO+tLBLAvNTjxvaSI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-RuXIvppwNLmlFL63uYHP5A-1; Wed, 08 Jun 2022 09:19:27 -0400
X-MC-Unique: RuXIvppwNLmlFL63uYHP5A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BB013810D2A;
        Wed,  8 Jun 2022 13:19:27 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-0-4.rdu2.redhat.com [10.22.0.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ABCB7492C3B;
        Wed,  8 Jun 2022 13:19:26 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     viro@zeniv.linux.org.uk, jlayton@kernel.org, bfields@fieldses.org
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Roberto Bergantinos Corpas" <rbergant@redhat.com>
Subject: vfs_test_lock - should it WARN if F_UNLCK and modified file_lock?
Date:   Wed, 08 Jun 2022 09:19:25 -0400
Message-ID: <9559FAE9-4E4A-4161-995F-32D800EC0D5B@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NLM sometimes gets burnt by implementations of f_op->lock for F_GETLK
modifying the lock structure (swapping out fl_owner) when the return is
F_UNLCK.

Yes, NLM should be more defensive, but perhaps we should be checking for
everyone, as per POSIX "If no lock is found that would prevent this lock
from being created, then the structure shall be left unchanged except 
for
the lock type which shall be set to F_UNLCK."

That would save others from the pain, as the offenders would hopefully 
take
notice.

Something like:

diff --git a/fs/locks.c b/fs/locks.c
index 32c948fe2944..4cc425008036 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2274,8 +2274,16 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned 
int, cmd)
   */
  int vfs_test_lock(struct file *filp, struct file_lock *fl)
  {
-       if (filp->f_op->lock)
-               return filp->f_op->lock(filp, F_GETLK, fl);
+       int ret;
+       fl_owner_t test_owner = fl->fl_owner;
+
+       if (filp->f_op->lock) {
+               ret = filp->f_op->lock(filp, F_GETLK, fl);
+               if (fl->fl_type == F_UNLCK)
+                       WARN_ON(fl->fl_owner != test_owner);
+               return ret;
+       }
+
         posix_test_lock(filp, fl);
         return 0;
  }

.. I'm worried that might be too big of a hammer though.  Any thoughts?

Ben

