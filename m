Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B6C7A49BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 14:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241129AbjIRMdV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 08:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241329AbjIRMc4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:32:56 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047FD10A
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 05:32:36 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so74584971fa.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 05:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695040354; x=1695645154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVQUJ/L8+afXKT69wRIL26IHsJ0vcphHTUN9uWpD+6k=;
        b=ZVJDUei0T8xfdtWX15tKcApO5DRgqvWossHyS/Yo7okNpQcav0LIfkrrJ/dRxgUtoS
         dMbR5D4WEUPreV7wBLTlKjgC7dtk35RGPlh2PVFlIfMDntYOfK/E81js+s0ZonC3rg1I
         1HD3KVIWrjTxMGDjGor7LqciO2j6GqTk03MS44Ojh+pz/omTEf/GWwnZlsQsQR/ljbtA
         NF/fyLltWyB4hnvTKdEqgWtjiXyU/8lnwAxzcuDESpZ89rXQ0saDf2oE+/lVAIw1Hwi/
         V6AgiaGj6W+9mljljF+gJWWeHZYBb6MvNOFyntHkdDF1zqjJRpIJIMmD0yJdP1E77rZX
         UA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695040354; x=1695645154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVQUJ/L8+afXKT69wRIL26IHsJ0vcphHTUN9uWpD+6k=;
        b=rzJpFKDNPp9nmsLRCVed8X2ImbvMT5oM24n7UKEvX5r/GfrxhucVz0lcvcyjSbt++V
         E6sSgpdhR0f07I2rYIN3P+GTYnlCgJGdxAX9yJ2BzBum+UJiDg8z+vOa/cdzrGb3cm07
         mN52gnbiFN85UNpJT2mbKfPXxm/YyW8CI9+t6t0f94ACxqi6GRs3OEw0KdSty6WPGiqQ
         Uzn9Cq4ESOqpYb7Wc2PsYuKFqMksv8CKRLjCBuDvrwpGNWtggDJPHp2lZx9ka7AZW2jb
         0+R6xHCpXNGmUszaRnHYtQq0rrJE2m2O5rDPW8ByFqE+HDz98iBA5gSDMEBL0BbC6roM
         LD8Q==
X-Gm-Message-State: AOJu0YxAJbw9nrgJ3J2cuJPMSJ0G6on4OrYMKkvVsx5fxdSsS3FUWKNp
        kVpObiJ0O22UzQ64tMGu+obfkPpg00ujIKC8FNI=
X-Google-Smtp-Source: AGHT+IHb3L5MoZ8WzsxS2Mcfsaw3C3Napx9+SHpFnQgKIyys75W2jZc3ZlqdjEn8jHRUcw8A38gNeQ==
X-Received: by 2002:a2e:80d7:0:b0:2bc:ff80:f639 with SMTP id r23-20020a2e80d7000000b002bcff80f639mr7962895ljg.7.1695040354219;
        Mon, 18 Sep 2023 05:32:34 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f209c00529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f20:9c00:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id sd5-20020a170906ce2500b00992a8a54f32sm6328834ejb.139.2023.09.18.05.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 05:32:33 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     amir73il@gmail.com, max.kellermann@ionos.com
Subject: [PATCH 3/4] inotify_user: add system call inotify_add_watch_at()
Date:   Mon, 18 Sep 2023 14:32:16 +0200
Message-Id: <20230918123217.932179-3-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230918123217.932179-1-max.kellermann@ionos.com>
References: <20230918123217.932179-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This implements a missing piece in the inotify API: referring to a
file by a directory file descriptor and a path name.  This can be
solved in userspace currently only by doing something similar to:

  int old = open(".");
  fchdir(dfd);
  inotify_add_watch(....);
  fchdir(old);

Support for LOOKUP_EMPTY is still missing.  We could add another IN_*
flag for that (which would clutter the IN_* flags list further) or
add a "flags" parameter to the new system call (which would however
duplicate features already present via special IN_* flags).

To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>
To: linux-fsdevel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/notify/inotify/inotify_user.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index b6e6f6ab21f8..8a9096c5ebb1 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -797,6 +797,12 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
 	return do_inotify_add_watch(fd, AT_FDCWD, pathname, mask);
 }
 
+SYSCALL_DEFINE4(inotify_add_watch_at, int, fd, int, dfd, const char __user *, pathname,
+		u32, mask)
+{
+	return do_inotify_add_watch(fd, dfd, pathname, mask);
+}
+
 SYSCALL_DEFINE2(inotify_rm_watch, int, fd, __s32, wd)
 {
 	struct fsnotify_group *group;
-- 
2.39.2

