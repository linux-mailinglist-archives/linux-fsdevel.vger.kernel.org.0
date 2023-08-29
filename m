Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E1778C702
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 16:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbjH2OMI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 10:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236901AbjH2OLy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:11:54 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F128129
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 07:11:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4018af103bcso27943265e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 07:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693318305; x=1693923105;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJ8yJVk1WanTGK6noPSAuAu8J5j6k7b3gO5IRwPDORc=;
        b=pDfSqxW/VMwLUzzQxKkJcrvOyXGTdi+m78jrAmELfOR+jSL0bgTFPe2YgNMeaGm350
         WqLnoRfNyy2lFNrVO4duvKoqPamj5nY9lGvzw2VhoxrwDxyj7nkjxn43BmXimhKvw9NY
         DwPWGVP7ItRZm6gATl1VZn6FI1X6ELDpEOqWG0TnhPeNPfxnOUX6sHhVBaDdH8trBDJi
         hF0O3b8w5t0r9ezlMaWcqBM+qQ9jSMzQrJV5eASglFcEEVeR3SVc+HS9Jh89cAsCIHTw
         tFvOYpPFIMwX50nbMcxQjp9qgV2+tdAd25nqTTPy2pS9KENK9Or7oO2a0fSmt6KedIbd
         fBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693318305; x=1693923105;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJ8yJVk1WanTGK6noPSAuAu8J5j6k7b3gO5IRwPDORc=;
        b=YOsaIYzrH8blaF1yJx4WhVVfwnrLgBGYE6c6CixAUMPKHvEMH21898N1w48Oi6k6fb
         54SZYs+5PWM9oDRTdXoZB3XoRhImsHVmzlm+iZL/rpPhO9L/EeYrjNWdVQZNxFUlTitb
         PsFRH+w9+dj9mWbYD12evxa+DtH3QnJmvC3SWdmM28dnZ3AVDZzKF67arVspUnfdHlv/
         9JUkwKhdDXMweo1fRaNxlFWLkr052TOT3pvXwQmHHQ5zY8z+xN33C3C/aW9Lv5qMfIxd
         UXt1d+uDBeWFJ2sCmdWt787mJrVwn1dXT6yi/3zMqLIqPc/R0Fze/qpY/OitpZPH61st
         tyuA==
X-Gm-Message-State: AOJu0YzqhquY/fKpLeW1yjBoLk6hTZXwbKyYbixXCCZ+XAS6KnEMMNiG
        YhlPVjcwHhYOamQBef0dY1ltfw==
X-Google-Smtp-Source: AGHT+IFFCPGxLiaYC5WNJ7fqI+TG+TcdZx3IaR6+EMXKEo+SeqxY92aYFuyGltp0GJAZesLUqlFAyA==
X-Received: by 2002:a05:600c:3b07:b0:401:b53e:6c55 with SMTP id m7-20020a05600c3b0700b00401b53e6c55mr2216906wms.0.1693318304674;
        Tue, 29 Aug 2023 07:11:44 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:3380:af04:1905:46a])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003fbe791a0e8sm14138042wmg.0.2023.08.29.07.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 07:11:43 -0700 (PDT)
Date:   Tue, 29 Aug 2023 16:11:38 +0200
From:   Marco Elver <elver@google.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     syzbot <syzbot+e441aeeb422763cc5511@syzkaller.appspotmail.com>,
        davem@davemloft.net, edumazet@google.com, ericvh@kernel.org,
        kuba@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux_oss@crudebyte.com,
        lucho@ionkov.net, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Subject: Re: [syzbot] [net?] [v9fs?] KCSAN: data-race in p9_fd_create /
 p9_fd_create (2)
Message-ID: <ZO38mqkS0TYUlpFp@elver.google.com>
References: <000000000000d26ff606040c9719@google.com>
 <ZO3PFO_OpNfBW7bd@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO3PFO_OpNfBW7bd@codewreck.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 29, 2023 at 07:57PM +0900, Dominique Martinet wrote:
[...]
> Yes well that doesn't seem too hard to hit, both threads are just
> setting O_NONBLOCK to the same fd in parallel (0x800 is 04000,
> O_NONBLOCK)
> 
> I'm not quite sure why that'd be a problem; and I'm also pretty sure
> that wouldn't work anyway (9p has no muxing or anything that'd allow
> sharing the same fd between multiple mounts)
> 
> Can this be flagged "don't care" ?

If it's an intentional data race, it could be marked data_race() [1].

However, staring at this code for a bit, I wonder why the f_flags are
set on open, and not on initialization somewhere...

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt

Anyway, a patch like the below would document that the data race is
intended and we assume that there is no way (famous last words) the
compiler or the CPU can mess it up (and KCSAN won't report it again).

------ >8 ------

From: Marco Elver <elver@google.com>
Date: Tue, 29 Aug 2023 15:48:58 +0200
Subject: [PATCH] 9p: Annotate data-racy writes to file::f_flags

syzbot reported:

 | BUG: KCSAN: data-race in p9_fd_create / p9_fd_create
 |
 | read-write to 0xffff888130fb3d48 of 4 bytes by task 15599 on cpu 0:
 |  p9_fd_open net/9p/trans_fd.c:842 [inline]
 |  p9_fd_create+0x210/0x250 net/9p/trans_fd.c:1092
 |  p9_client_create+0x595/0xa70 net/9p/client.c:1010
 |  v9fs_session_init+0xf9/0xd90 fs/9p/v9fs.c:410
 |  v9fs_mount+0x69/0x630 fs/9p/vfs_super.c:123
 |  legacy_get_tree+0x74/0xd0 fs/fs_context.c:611
 |  vfs_get_tree+0x51/0x190 fs/super.c:1519
 |  do_new_mount+0x203/0x660 fs/namespace.c:3335
 |  path_mount+0x496/0xb30 fs/namespace.c:3662
 |  do_mount fs/namespace.c:3675 [inline]
 |  __do_sys_mount fs/namespace.c:3884 [inline]
 |  [...]
 |
 | read-write to 0xffff888130fb3d48 of 4 bytes by task 15563 on cpu 1:
 |  p9_fd_open net/9p/trans_fd.c:842 [inline]
 |  p9_fd_create+0x210/0x250 net/9p/trans_fd.c:1092
 |  p9_client_create+0x595/0xa70 net/9p/client.c:1010
 |  v9fs_session_init+0xf9/0xd90 fs/9p/v9fs.c:410
 |  v9fs_mount+0x69/0x630 fs/9p/vfs_super.c:123
 |  legacy_get_tree+0x74/0xd0 fs/fs_context.c:611
 |  vfs_get_tree+0x51/0x190 fs/super.c:1519
 |  do_new_mount+0x203/0x660 fs/namespace.c:3335
 |  path_mount+0x496/0xb30 fs/namespace.c:3662
 |  do_mount fs/namespace.c:3675 [inline]
 |  __do_sys_mount fs/namespace.c:3884 [inline]
 |  [...]
 |
 | value changed: 0x00008002 -> 0x00008802

Within p9_fd_open(), O_NONBLOCK is added to f_flags of the read and
write files. This may happen concurrently if e.g. 2 tasks mount the same
filesystem.

Mark the plain read-modify-writes as intentional data-races, with the
assumption that the result of executing the accesses concurrently will
always result in the same result despite the accesses themselves not
being atomic.

Reported-by: syzbot+e441aeeb422763cc5511@syzkaller.appspotmail.com
Signed-off-by: Marco Elver <elver@google.com>
---
 net/9p/trans_fd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 00b684616e8d..9b01e15a758b 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -833,13 +833,13 @@ static int p9_fd_open(struct p9_client *client, int rfd, int wfd)
 	if (!(ts->rd->f_mode & FMODE_READ))
 		goto out_put_rd;
 	/* prevent workers from hanging on IO when fd is a pipe */
-	ts->rd->f_flags |= O_NONBLOCK;
+	data_race(ts->rd->f_flags |= O_NONBLOCK);
 	ts->wr = fget(wfd);
 	if (!ts->wr)
 		goto out_put_rd;
 	if (!(ts->wr->f_mode & FMODE_WRITE))
 		goto out_put_wr;
-	ts->wr->f_flags |= O_NONBLOCK;
+	data_race(ts->wr->f_flags |= O_NONBLOCK);
 
 	client->trans = ts;
 	client->status = Connected;
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

