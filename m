Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8662640CB1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 18:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhIOQvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 12:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhIOQvL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:51:11 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1A6C061764
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 09:49:51 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id a12so2276473qvz.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 09:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=osh6NDovzw+ZlXVVDOUZQCSNWZPxEeXF/7ss3wLmtKA=;
        b=Kv3Vj3lzxRAZJd4JPCmdm40i8ty++ilePqyolEIaYhWs/o1fsLgK9efzsYW3QiD44f
         dms6SjJGKaaKHs5OrsE76GSk9SUZrOJOg2mfde7/vQWKTyEz//5FOYazl86x/k86H2C6
         pzSGsuPJS5TY7ow0hCZY8At/mH1zfcz9x2lMbZZv0wNu4qOMGmSvlpuS9syvXWZ5LXaQ
         B45Xuz4AEHia38q0cLJVHdWqua3pPkdy/WV5G73xpcRw10OAj3hTWZsZruIDq3lw2LcJ
         bcsQhdDmLYW2sDUkqGKpMu6lvkXH8yTosOklEuX7aKMxuwyUPplAbFpqOH6/IyvPuTOJ
         b2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=osh6NDovzw+ZlXVVDOUZQCSNWZPxEeXF/7ss3wLmtKA=;
        b=Z7bSNt9PKerl5wU2jfbP5E45UMeUnOUDml6zs4Efp3pKEUehuJyx56onH1bNGjQBbK
         xDwQ8Ca3aAB7kPBQ5UAmwwoviqfE9Opt6UdLTYHShIf8t3b63sk/g0jXEIDQ7cPkVrG6
         feSLMJhUv7+mVc6dhdZrhy0e15CgBlE8E5PROZiFeu3ClcmY3izNcCt4TU9pcthlfEV4
         KpuS5jkBQR7XAV/C8YVU3wFYcktasLytMx18wsfldrEjrgYT/k1yNsgcrtfpOtspNY2N
         k51gbpZJ3brsz1JhBl4NET2kiWZp4DZUpVVck31f0r0qnf6ujGeFTG2mrH/oEOMFCp4R
         NbHQ==
X-Gm-Message-State: AOAM533uEZShEEKmvf0NvoIFZYn5/+PWgCYgUN7IF4HtFVzLPZH5jNyP
        bCzNFDqNkiZBm7Bt9XGx/j3v
X-Google-Smtp-Source: ABdhPJyL+cxrJfyT+g4h6UtkmldJivzlVA9vPqio5LiheuUJzccqirZH/QPK9x2hW9PO0FHnZb0Duw==
X-Received: by 2002:a05:6214:11f0:: with SMTP id e16mr650335qvu.30.1631724591078;
        Wed, 15 Sep 2021 09:49:51 -0700 (PDT)
Received: from localhost (pool-96-237-52-188.bstnma.fios.verizon.net. [96.237.52.188])
        by smtp.gmail.com with ESMTPSA id h9sm390273qkl.4.2021.09.15.09.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 09:49:50 -0700 (PDT)
Subject: [PATCH v4 5/8] io_uring: convert io_uring to the secure anon inode
 interface
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Wed, 15 Sep 2021 12:49:50 -0400
Message-ID: <163172459001.88001.17463922586800990358.stgit@olly>
In-Reply-To: <163172413301.88001.16054830862146685573.stgit@olly>
References: <163172413301.88001.16054830862146685573.stgit@olly>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Converting io_uring's anonymous inode to the secure anon inode API
enables LSMs to enforce policy on the io_uring anonymous inodes if
they chose to do so.  This is an important first step towards
providing the necessary mechanisms so that LSMs can apply security
policy to io_uring operations.

Signed-off-by: Paul Moore <paul@paul-moore.com>

---
v4:
- no change
v3:
- no change
v2:
- no change
v1:
- initial draft
---
 fs/io_uring.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 388754b24785..56cc9aba0d01 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -10155,8 +10155,8 @@ static struct file *io_uring_get_file(struct io_ring_ctx *ctx)
 		return ERR_PTR(ret);
 #endif
 
-	file = anon_inode_getfile("[io_uring]", &io_uring_fops, ctx,
-					O_RDWR | O_CLOEXEC);
+	file = anon_inode_getfile_secure("[io_uring]", &io_uring_fops, ctx,
+					 O_RDWR | O_CLOEXEC, NULL);
 #if defined(CONFIG_UNIX)
 	if (IS_ERR(file)) {
 		sock_release(ctx->ring_sock);

