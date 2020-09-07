Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D9B25FD06
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 17:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbgIGP01 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 11:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbgIGPVT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 11:21:19 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96953C061573
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2020 08:21:06 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bd2so235727plb.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2020 08:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=dDm50BpVZuQLGYSLkY4kWAnKOu+NYX3j/JL82/yvZsw=;
        b=RJ5s9MaqhEHO5V2IfABHfKScBVvIYJl1uOESsM7TA208JtB/i5pnrUk2euFVdZxGtL
         SCLkhk/eIrtAkx1cLJKi22+NOfrmPt8QkuNR46/J1HRaTDtu9vJfUADlOkWbjk++iTYE
         bSkFWGf+ueXnY2ceeXi2ZlMTUPg4CCwa+AoxfIqrtJv7WGlvtpdjBdUxsiVe4N94hREX
         Jf+nv+PpTodpJOgDl6Y593FKFbDcoNzI15eNc2927OzNd0UzoaHGxt1n44c6sbh4zpg9
         6BSJ5eKGkCwCFAbSPTM4gECqlw7yqcIm53BmXklX/vWRaWdjxmxLGv1jRvE213dVfdOn
         BVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=dDm50BpVZuQLGYSLkY4kWAnKOu+NYX3j/JL82/yvZsw=;
        b=OLYwYEAV4kEdOpvcpq3gJbMc54twBkMeONz9cHW6PulNK+WSBwskU3AQq2DBcO5Bw+
         jxZCfjt+31+EvGfGnA4pYnUEsOYMrwfl50oQtN63NsKY9hJHoYMv26Nk6vAN4GGTlpQ5
         wx/+8Cn5pxq1AlzB7Htas/HEBnj7vdHuznZd877Xvspm+UNtZ6p13Wv2UhjGeXooZtpS
         boHUvJ8idzjtq2DcbtMeAflL4K7OKBEgvpxA3RxkBJfSTVn0QmMk8BkwadB+8S3KTUQo
         UtbCo8HjKDGFCqFRN6/SbvQC1lYhj8Zr5W4PgdL6voY5EWmJM5LYkb3hqILWVbSzybUI
         YoRA==
X-Gm-Message-State: AOAM530e2OOLhAPuOU35NTN/dEBUbLHGFPTsOKC84IBB3yuZv4lMKDXJ
        tPdqxS2fZEqzv8tbxlsTHroobw==
X-Google-Smtp-Source: ABdhPJzGXrFSoWODyKXpSqClx55jfJGJNH5FkVEzm0uYE4X+iByW1zd19ffrfKEOs/9XX5s+bReuUQ==
X-Received: by 2002:a17:90a:de17:: with SMTP id m23mr21430575pjv.51.1599492065082;
        Mon, 07 Sep 2020 08:21:05 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id f9sm2399964pjq.26.2020.09.07.08.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 08:21:04 -0700 (PDT)
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] pipe: honor IOCB_NOWAIT
Message-ID: <cedfa436-47a3-7cbc-1948-75d0e28cfdc5@kernel.dk>
Date:   Mon, 7 Sep 2020 09:21:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pipe only looks at O_NONBLOCK for non-blocking operation, which means that
io_uring can't easily poll for it or attempt non-blocking issues. Check for
IOCB_NOWAIT in locking the pipe for reads and writes, and ditto when we
decide on whether or not to block or return -EAGAIN.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

If this is acceptable, then I can add S_ISFIFO to the whitelist on file
descriptors we can IOCB_NOWAIT try for, then poll if we get -EAGAIN
instead of using thread offload.

diff --git a/fs/pipe.c b/fs/pipe.c
index 60dbee457143..3cee28e35985 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -82,6 +82,13 @@ void pipe_unlock(struct pipe_inode_info *pipe)
 }
 EXPORT_SYMBOL(pipe_unlock);
 
+static inline bool __pipe_lock_nonblock(struct pipe_inode_info *pipe)
+{
+	if (mutex_trylock(&pipe->mutex))
+		return true;
+	return false;
+}
+
 static inline void __pipe_lock(struct pipe_inode_info *pipe)
 {
 	mutex_lock_nested(&pipe->mutex, I_MUTEX_PARENT);
@@ -244,7 +251,12 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		return 0;
 
 	ret = 0;
-	__pipe_lock(pipe);
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!__pipe_lock_nonblock(pipe))
+			return -EAGAIN;
+	} else {
+		__pipe_lock(pipe);
+	}
 
 	/*
 	 * We only wake up writers if the pipe was full when we started
@@ -344,7 +356,8 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 			break;
 		if (ret)
 			break;
-		if (filp->f_flags & O_NONBLOCK) {
+		if ((filp->f_flags & O_NONBLOCK) ||
+		    (iocb->ki_flags & IOCB_NOWAIT)) {
 			ret = -EAGAIN;
 			break;
 		}
@@ -432,7 +445,12 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	if (unlikely(total_len == 0))
 		return 0;
 
-	__pipe_lock(pipe);
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!__pipe_lock_nonblock(pipe))
+			return -EAGAIN;
+	} else {
+		__pipe_lock(pipe);
+	}
 
 	if (!pipe->readers) {
 		send_sig(SIGPIPE, current, 0);
@@ -554,7 +572,8 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			continue;
 
 		/* Wait for buffer space to become available. */
-		if (filp->f_flags & O_NONBLOCK) {
+		if ((filp->f_flags & O_NONBLOCK) ||
+		    (iocb->ki_flags & IOCB_NOWAIT)) {
 			if (!ret)
 				ret = -EAGAIN;
 			break;

-- 
Jens Axboe

