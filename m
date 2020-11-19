Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0482B8923
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 01:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgKSAmn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 19:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgKSAmn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 19:42:43 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6AAC0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 16:42:42 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id s2so1973980plr.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 16:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vwvOdNltri8QeG/8NJREwvHkCBGEECJcvZZE736hY4g=;
        b=lhpPTrHGYU5nVBFNX5ArJFc05EAOTtLgysWxOa4ciurgWUviyxGN4iZV78F5KktPe6
         J4MCAKsgOFCcyJ2VT/JZ6qLQzJG2+we59Dz3bsFjpDv9ABcKElxQLjX7Vt9Bn3ob86gh
         ok5v0yLYNsdq+N0xo7w+un75v7trNkUBSw0TY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vwvOdNltri8QeG/8NJREwvHkCBGEECJcvZZE736hY4g=;
        b=Ds60BnkBK6b9hU2udJdXCieGLgAIvn26w4HqcACxhLDFBG4o+VqFdG6xHFxsAYLZxX
         ZlPFcjhhQYBGmzW+tf8iVAz2F+V7ewR5vBls0x1balT51LWadDSemq1v8q5pK8NcEzi6
         ZwhmJqsSyoT879QAGG0JUJXy69Z8QVTeoz/ItS4Kg8wzjyQop6jOBFEtw7SKnky9vOLo
         SlVgwDd83PkC5phtWi442AwVznEgVoQWYRo4jBbDbaSzBDGTohVUw2pQPHDIGDL6FGTj
         W6JD0SZvj1i1Xu0VfBYxHmfE57ck/TI2U6i2+W9aSFzFhtG4inwyuR+oq46jF+63HiN8
         sGBQ==
X-Gm-Message-State: AOAM530ZZX+97zaDBMeNHP++oo6Mz/lYz/0+W3WmSA34R8tsSFIDnBF8
        BIlkxFgmQelbxESUcqPmxjCJCQ==
X-Google-Smtp-Source: ABdhPJyTII3cKUvBoUVCBDit8YdMBKcwl776/hYEqYpBNBBnaf7gugKq37j+rUmyQ9DOz0Nk5sJ4bg==
X-Received: by 2002:a17:902:9689:b029:d8:e310:2fa2 with SMTP id n9-20020a1709029689b02900d8e3102fa2mr7104334plp.42.1605746562426;
        Wed, 18 Nov 2020 16:42:42 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-a5b9-f4da-efe6-5d34.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:a5b9:f4da:efe6:5d34])
        by smtp.gmail.com with ESMTPSA id y5sm3754343pja.52.2020.11.18.16.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 16:42:41 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     David.Laight@ACULAB.COM, hch@infradead.org,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH RESEND v2] fs/select.c: batch user writes in do_sys_poll
Date:   Thu, 19 Nov 2020 11:42:35 +1100
Message-Id: <20201119004235.173373-1-dja@axtens.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When returning results to userspace, do_sys_poll repeatedly calls
put_user() - once per fd that it's watching.

This means that on architectures that support some form of
kernel-to-userspace access protection, we end up enabling and disabling
access once for each file descripter we're watching. This is inefficent
and we can improve things. We could do careful batching of the opening
and closing of the access window, or we could just copy the entire walk
entries structure. While that copies more data, it potentially does so
more efficiently, and the overhead is much less than the lock/unlock
overhead.

Unscientific benchmarking with the poll2_threads microbenchmark from
will-it-scale, run as `./poll2_threads -t 1 -s 15`:

  - Bare-metal Power9 with KUAP: ~49% speed-up
  - VM on amd64 laptop with SMAP: ~25% speed-up

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 fs/select.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index ebfebdfe5c69..4a74d1353ccb 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -1012,12 +1012,10 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
 	poll_freewait(&table);
 
 	for (walk = head; walk; walk = walk->next) {
-		struct pollfd *fds = walk->entries;
-		int j;
-
-		for (j = 0; j < walk->len; j++, ufds++)
-			if (__put_user(fds[j].revents, &ufds->revents))
-				goto out_fds;
+		if (copy_to_user(ufds, walk->entries,
+				 sizeof(struct pollfd) * walk->len))
+			goto out_fds;
+		ufds += walk->len;
   	}
 
 	err = fdcount;
-- 
2.25.1

