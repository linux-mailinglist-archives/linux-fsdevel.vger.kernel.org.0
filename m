Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AE23B9DFC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 11:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhGBJVu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 05:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhGBJVt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 05:21:49 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432F5C061762;
        Fri,  2 Jul 2021 02:19:16 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso5698395pjp.5;
        Fri, 02 Jul 2021 02:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nm45adTul5XCFOT6dnN8MdpgDMBSy0CJdfrYkdLx/To=;
        b=fMt7/cmVBVuUMtYM2MNPljWLWWzqq8BjDcrJoYGSlLgyR8/DwFd3AZkMhWgc9pKPVz
         agBdKdUyFMiUx5J7g+uGRuUQJq7E7ar0qzpSrxUoaegezIR1Ah+3glG5Zdb3GqYGnDSs
         obudtjXnF2Q5qrdwHvVrNcExX3lXMBT+d+SjfP7azf5DqdC7ixS/QBP7Y+1Cif0I7tA9
         poeRctpZ+WxF7t6qXBU0bB7MKtkCsybNwb7a6UvmSnx2HHh/ST3a76Kk3xqaZ0LT2gw8
         UaazK4DhL+y8upmnQLuzR+pn68Wav1Pg8HB4UIBvCr9DyyZyNNUpvCQWdesJsCUNBnbw
         UCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nm45adTul5XCFOT6dnN8MdpgDMBSy0CJdfrYkdLx/To=;
        b=oUZYk3cphmJoPgmU1zWceVl06RBDHxaha2Tf576bEW2DqqM4rbtFO483qKoAvcUP44
         dxIn+SXCGKgoeG3eNniTwMTVvZ2DudB5my84hduOv4mBLw0DfSpV0vmmiiWlFhWFeumV
         IIm/oPsKqT26UMsksaR5tWi3lLsFjzKsJuM8evNHND289YH5fQVAiW/0cxDWREPtGqN4
         EucJr4O8ef0AMMZbeTvkoqGfwAL5DCHF/fZ6fzaAfAOwOqVHy8XpjQquEj9xL7z65EWl
         32rUMaJO/YUm8WWFmqLHDUO5Fsthe8/ZsxJNOaTMtjwTbbB/Gtvc8aKyq4zzbPZKyefb
         WQmg==
X-Gm-Message-State: AOAM533VckP36ZmKYqW/rZe3ID14/1OH6nyjIfrCag4IcCInNMSatOBH
        B0v2nSQBXFIkc2yAWVK2I4Q=
X-Google-Smtp-Source: ABdhPJy1SBWtkMHNFwz/PuByfck8ZnDs7HnX59nmGJqo0xDw/1YGwYyHkb3mPprE/D5XFUNc7Xu48A==
X-Received: by 2002:a17:90b:3506:: with SMTP id ls6mr3911151pjb.25.1625217553690;
        Fri, 02 Jul 2021 02:19:13 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id y3sm3023918pga.72.2021.07.02.02.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 02:19:13 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     jlayton@kernel.org, bfields@fieldses.org, viro@zeniv.linux.org.uk
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 2/2] fcntl: fix potential deadlock for &fasync_struct.fa_lock
Date:   Fri,  2 Jul 2021 17:18:31 +0800
Message-Id: <20210702091831.615042-3-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210702091831.615042-1-desmondcheongzx@gmail.com>
References: <20210702091831.615042-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is an existing lock hierarchy of
&dev->event_lock --> &fasync_struct.fa_lock --> &f->f_owner.lock
from the following call chain:

  input_inject_event():
    spin_lock_irqsave(&dev->event_lock,...);
    input_handle_event():
      input_pass_values():
        input_to_handler():
          evdev_events():
            evdev_pass_values():
              spin_lock(&client->buffer_lock);
              __pass_event():
                kill_fasync():
                  kill_fasync_rcu():
                    read_lock(&fa->fa_lock);
                    send_sigio():
                      read_lock_irqsave(&fown->lock,...);

&dev->event_lock is HARDIRQ-safe, so interrupts have to be disabled
while grabbing &fasync_struct.fa_lock, otherwise we invert the lock
hierarchy. However, since kill_fasync which calls kill_fasync_rcu is
an exported symbol, it may not necessarily be called with interrupts
disabled.

As kill_fasync_rcu may be called with interrupts disabled (for
example, in the call chain above), we replace calls to
read_lock/read_unlock on &fasync_struct.fa_lock in kill_fasync_rcu
with read_lock_irqsave/read_unlock_irqrestore.

Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 fs/fcntl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index cf9e81dfa615..887db4918a89 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1004,13 +1004,14 @@ static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
 {
 	while (fa) {
 		struct fown_struct *fown;
+		unsigned long flags;
 
 		if (fa->magic != FASYNC_MAGIC) {
 			printk(KERN_ERR "kill_fasync: bad magic number in "
 			       "fasync_struct!\n");
 			return;
 		}
-		read_lock(&fa->fa_lock);
+		read_lock_irqsave(&fa->fa_lock, flags);
 		if (fa->fa_file) {
 			fown = &fa->fa_file->f_owner;
 			/* Don't send SIGURG to processes which have not set a
@@ -1019,7 +1020,7 @@ static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
 			if (!(sig == SIGURG && fown->signum == 0))
 				send_sigio(fown, fa->fa_fd, band);
 		}
-		read_unlock(&fa->fa_lock);
+		read_unlock_irqrestore(&fa->fa_lock, flags);
 		fa = rcu_dereference(fa->fa_next);
 	}
 }
-- 
2.25.1

