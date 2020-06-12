Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17DD1F7613
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 11:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgFLJeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 05:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgFLJeV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:34:21 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D6CC08C5C2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:20 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id k11so9419250ejr.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hZyrx3M5ZDXIIPFXTz1CL5MNCJNiQMk8YdSpmLrpHQI=;
        b=J8fjLSzRnsvlOWiTgkss6KHdo8m6QpAQb/zR3o2302ps2T+5/W8IUft1ByGgfH0UX1
         po0LvXUKU4cmx6CGwamc7ijRIq89NLgJsIfcVoBg9jP1stVdoPUcrVCUCDdAFApvw6l6
         hLroUxOlK362Mxh3Vo2XhJrsGGOzqsLikQtgl4ozJ2G+du8GyBmDdIlm4TkBPub9fUpc
         +NXSEJM7PYYVpZgvzN6Y9zvWAKlVp/yJyCN+9/UPTl+3ZAdEgk5Z5oDDMm8OYT/Y7Biz
         AyBa7sxABKd006VoyvGEJWzvV7W8iwYx1EAJnhVdiZH7LVGD1e1tLBWOL0QTPfs9IjPR
         Eadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hZyrx3M5ZDXIIPFXTz1CL5MNCJNiQMk8YdSpmLrpHQI=;
        b=OOYEuBWfkVWhCeJtSAhjTCT2ZcEhqeEKJyJRhyU7AboTsukuu2vK1hZMFmtkGUJVL0
         mUrF4aCG4DLNTk4PTwDprIHdm7LMETRdKIYb10n1RdxAZe5PVShjxeu1QrKMKB1SNgf1
         S3gXMKk0vPy/Rx8N+P+Kqg4/FCG3vqz+Ugm1KKx8ECm6V/c1WcdY6wPD3REXrhaqzj3u
         vKV0Wk674NORvvKXOmNxvcsQYEFR+kWDYAQKjPAHTCehhx5f36uh2oP1yHVD4X5l9rw+
         CQptIwYL5iclVOAtepmInPXAQU1UWFJUEhaE958G8zAXqFhfAqGmuL/ylqztONEzus0o
         KLGA==
X-Gm-Message-State: AOAM5305otupFaYosWhIBuCMEC85KtaK6ylf0bv/OdEXN4+ngUVJCl+6
        9jk0XFhVxAoDKThprZLU+vFnPsQW
X-Google-Smtp-Source: ABdhPJxGY0zM6vrnmNkXg0VIxd8kME+ZUgXAoKMBOpv8QWcKI5Ctc8axNTbrdlprwtJQbVcqln48nQ==
X-Received: by 2002:a17:906:851:: with SMTP id f17mr11798930ejd.396.1591954459530;
        Fri, 12 Jun 2020 02:34:19 -0700 (PDT)
Received: from localhost.localdomain ([5.102.204.95])
        by smtp.gmail.com with ESMTPSA id l2sm2876578edq.9.2020.06.12.02.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 02:34:19 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/20] fanotify: mask out special event flags from ignored mask
Date:   Fri, 12 Jun 2020 12:33:37 +0300
Message-Id: <20200612093343.5669-15-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612093343.5669-1-amir73il@gmail.com>
References: <20200612093343.5669-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The special event flags (FAN_ONDIR, FAN_EVENT_ON_CHILD) never had
any meaning in ignored mask. Mask them out explicitly.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 92bb885b98b6..27bbd67270d8 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1035,6 +1035,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	__kernel_fsid_t __fsid, *fsid = NULL;
 	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
+	bool ignored = flags & FAN_MARK_IGNORED_MASK;
 	unsigned int obj_type, fid_mode;
 	int ret;
 
@@ -1082,6 +1083,10 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	if (mask & ~valid_mask)
 		return -EINVAL;
 
+	/* Event flags (ONDIR, ON_CHILD) are meaningless in ignored mask */
+	if (ignored)
+		mask &= ~FANOTIFY_EVENT_FLAGS;
+
 	f = fdget(fanotify_fd);
 	if (unlikely(!f.file))
 		return -EBADF;
-- 
2.17.1

