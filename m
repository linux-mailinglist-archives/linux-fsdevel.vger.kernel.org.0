Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3ED790BCF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Sep 2023 14:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236959AbjICMEo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Sep 2023 08:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjICMEn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Sep 2023 08:04:43 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E53F124;
        Sun,  3 Sep 2023 05:04:40 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4ff8cf11b90so922418e87.1;
        Sun, 03 Sep 2023 05:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693742679; x=1694347479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OPut1jT3/XtVUggqzhuV25GqNPj8dEhO8Hj67sZc4zQ=;
        b=Vmh7C4GyPvF4QV6TgBQHK+fvCS14E3XuhogyOnDbETgz0B1MUm/REbbWDA61cD/BTx
         T7cKMBsbLODR497OYvvuv3S5IHdKKKzsxVqjAfXSjDFEr1EbuLaye1UqYFU4R3orWTnk
         GjupUPM0GEZ4LgiTx62yOgx6UAF7rAz7F034I1obWg7BwyX9gDkuphydhLiCfhR/Ge95
         H60T/O3lwO8GZUuiYGKeDeR/J2glvlUx2EG4BP/v+fwaK30C9OgffDqnbA8UYg90ZeD/
         V34XCq/JMaS8/PxPOTqhQ6XPPySoCTL8YAQn8VFHsa2L2f3VM1Tiv8uw9I0WwlBoY4yv
         tSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693742679; x=1694347479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPut1jT3/XtVUggqzhuV25GqNPj8dEhO8Hj67sZc4zQ=;
        b=IiTqgyT9AcxdJhuB8D6gSf+MJr03uBwsWUKGBZlYYEg3vHQgjT+EefF79ORxVqsntr
         xWr+8vLo6qjXmonLeMEuDJ+hQqAhdyqV9iSZlMX/5JrN2Sf1Pb94WVfNlH2hNwPd6jWo
         Cizn/PRFza4HoMMFO89vHYyK2ql169837YxaO7bDd/TKaCm97ghgc8jQEj+Ptu0DiSUn
         mWVquFISlT2UdhkfzioNhQv+PavkXqZ729CJLIwaFGugBTJ+AJqnc67tRhZfXuZzhefG
         yoM5Wobm+AtGbi1O4zvUeFa0PQAJJqbF7w/phigpn/06G5VW3teNxQwc1O1hjfHZKPLQ
         xhiw==
X-Gm-Message-State: AOJu0Yxz7tBrDsyLzsygQfb30PCWIt3y+HtCrMv7yOgSEVNvyzOzObvl
        AlPQg2mei2IUAnD0D/NZ27YmhcMaUnI=
X-Google-Smtp-Source: AGHT+IHBNMESQDFFiVZiNouQjRBoK8STcxgxCncKF5hzsJ0mlN6HU9Aksi/LHv6FPJbBxj0Hl0zTWA==
X-Received: by 2002:a05:6512:104b:b0:500:bb99:69a7 with SMTP id c11-20020a056512104b00b00500bb9969a7mr6031196lfb.14.1693742678498;
        Sun, 03 Sep 2023 05:04:38 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id i11-20020a056512224b00b0050085eaa79esm1255310lfu.61.2023.09.03.05.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 05:04:37 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@poochiereds.net>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org
Subject: [PATCH] name_to_handle_at.2,fanotify_mark.2: Document the AT_HANDLE_FID flag
Date:   Sun,  3 Sep 2023 15:04:33 +0300
Message-Id: <20230903120433.2605027-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A flag to indicate that the requested file_handle is not intended
to be used for open_by_handle_at(2) and may be needed to identify
filesystem objects reported in fanotify events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Alejandro,

This is a followup on AT_HANDLE_FID feature from v6.5.

Thanks,
Amir.

 man2/fanotify_mark.2     | 11 +++++++++--
 man2/open_by_handle_at.2 | 42 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/man2/fanotify_mark.2 b/man2/fanotify_mark.2
index 3f85deb23..8e885af69 100644
--- a/man2/fanotify_mark.2
+++ b/man2/fanotify_mark.2
@@ -743,10 +743,17 @@ do not specify a directory.
 .B EOPNOTSUPP
 The object indicated by
 .I pathname
-is associated with a filesystem that does not support the encoding of file
-handles.
+is associated with a filesystem
+that does not support the encoding of file handles.
 This error can be returned only with an fanotify group that identifies
 filesystem objects by file handles.
+Calling
+.BR name_to_handle_at (2)
+with the flag
+.BR AT_HANDLE_FID " (since Linux 6.5)"
+.\" commit 96b2b072ee62be8ae68c8ecf14854c4d0505a8f8
+can be used as a test
+to check if a filesystem supports reporting events with file handles.
 .TP
 .B EPERM
 The operation is not permitted because the caller lacks a required capability.
diff --git a/man2/open_by_handle_at.2 b/man2/open_by_handle_at.2
index 4061faea9..4cfa21d9c 100644
--- a/man2/open_by_handle_at.2
+++ b/man2/open_by_handle_at.2
@@ -109,17 +109,44 @@ structure as an opaque data type: the
 .I handle_type
 and
 .I f_handle
-fields are needed only by a subsequent call to
+fields can be used in a subsequent call to
 .BR open_by_handle_at ().
+The caller can also use the opaque
+.I file_handle
+to compare the identity of filesystem objects
+that were queried at different times and possibly
+at different paths.
+The
+.BR fanotify (7)
+subsystem can report events
+with an information record containing a
+.I file_handle
+to identify the filesystem object.
 .PP
 The
 .I flags
 argument is a bit mask constructed by ORing together zero or more of
-.B AT_EMPTY_PATH
+.BR AT_HANDLE_FID ,
+.BR AT_EMPTY_PATH ,
 and
 .BR AT_SYMLINK_FOLLOW ,
 described below.
 .PP
+When
+.I flags
+contain the
+.BR AT_HANDLE_FID " (since Linux 6.5)"
+.\" commit 96b2b072ee62be8ae68c8ecf14854c4d0505a8f8
+flag, the caller indicates that the returned
+.I file_handle
+is needed to identify the filesystem object,
+and not for opening the file later,
+so it should be expected that a subsequent call to
+.BR open_by_handle_at ()
+with the returned
+.I file_handle
+may fail.
+.PP
 Together, the
 .I pathname
 and
@@ -363,8 +390,14 @@ capability.
 .B ESTALE
 The specified
 .I handle
-is not valid.
+is not valid for opening a file.
 This error will occur if, for example, the file has been deleted.
+This error can also occur if the
+.I handle
+was aquired using the
+.B AT_HANDLE_FID
+flag and the filesystem does not support
+.BR open_by_handle_at ().
 .SH VERSIONS
 FreeBSD has a broadly similar pair of system calls in the form of
 .BR getfh ()
@@ -386,6 +419,9 @@ file handles, for example,
 .IR /proc ,
 .IR /sys ,
 and various network filesystems.
+Some filesystem support the translation of pathnames to
+file handles, but do not support using those file handles in
+.BR open_by_handle_at ().
 .PP
 A file handle may become invalid ("stale") if a file is deleted,
 or for other filesystem-specific reasons.
-- 
2.34.1

