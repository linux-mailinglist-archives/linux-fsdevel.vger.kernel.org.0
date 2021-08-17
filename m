Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4EB3EF490
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 23:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhHQVIX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 17:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbhHQVIS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 17:08:18 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10752C0612A3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 14:07:40 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so864667pjl.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 14:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a7PCxGc6lMrjJLJIFdFJeeuYjNC0VZLRn/3fPuPf6xI=;
        b=zL7n46VT+lMteVZ6qfT5lmUStnH5sIE6ilui9EHQwEIPGtyF7JGXcfCUz70eDjmefB
         jG6T/uBc3w9DHzfDvZ46oLyVWHUKzVaWQzG98Emf+WzLigrwJJPNUlCN2yvKCBNBCJsD
         HiUQdxvdB3OSz8JlnBLhzMGplubb0+36nqfI0JQw3OxD5TRm4da5n5gjI4vFNd63Uve9
         AcKqLWr5xCasC+Ozl6J6uQzT52j0qbkBhB06cPaV6QxIiLPk1JJUm+Y0WwFmY4uuA576
         Hg7EBPdn+B6NuUf/lYiksz1+ZaiIW8YpsYc7zjwoC4L7JU006tWG/HJXDyaJfaysWVg8
         ndwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a7PCxGc6lMrjJLJIFdFJeeuYjNC0VZLRn/3fPuPf6xI=;
        b=A4twbZpYvT9JEnmdSpONvcm0SuZCmJKC9FSTEBQxhTAUY/oyGr/AUnLUDHEn6DQnqk
         Z4x4foHVVJ3S4cb0JN35Tft48p1+fs4tLTlDMcp3Mq/J7o6/YUgyOXfmDCCFktqyD8q6
         puFHxTD7W68XnhWUDyoiao3OHEQ9LzV2Fi+dJGJArdL52aroYQRSzBXIMXOgZip/U1M9
         khOD0t3iWmTnY0LZr0V+yZ7G2FtN5EtAaHDbMPuCJ85jGoYSkscpAa8Na8gkoQbADf3x
         KQQGdOfr4JBvPS5kpmzVmhbfhGMzPS5GHveTeTLpYvb82Dj30IQlVG3Ys9cVp+Etfd1r
         3Fiw==
X-Gm-Message-State: AOAM532tnLJt3QvMmZUV9k3VjxSZS9t7ByVNePBYqeUM2wY1jIcGhysS
        qShXzJyQA8mExKJXDKl38/GNUQ==
X-Google-Smtp-Source: ABdhPJynze4TOX/Iit2NW0rJmK1lx9mO4rTokxcuEw6Pb//RFlXAqbaWCEaXRw+ou0O5CZhBVaWpdg==
X-Received: by 2002:a63:480a:: with SMTP id v10mr5241690pga.113.1629234460425;
        Tue, 17 Aug 2021 14:07:40 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:df70])
        by smtp.gmail.com with ESMTPSA id c9sm4205194pgq.58.2021.08.17.14.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:07:40 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: [PATCH v10 04/10] btrfs-progs: receive: add send stream v2 cmds and attrs to send.h
Date:   Tue, 17 Aug 2021 14:06:50 -0700
Message-Id: <6c5db293c3628934407761057dc9b508cb191778.1629234282.git.osandov@fb.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629234193.git.osandov@fb.com>
References: <cover.1629234193.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Boris Burkov <boris@bur.io>

Send stream v2 adds three commands and several attributes associated to
those commands. Before we implement processing them, add all the
commands and attributes. This avoids leaving the enums in an
intermediate state that doesn't correspond to any version of send
stream.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 send.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/send.h b/send.h
index 228928a0..3c47e0c7 100644
--- a/send.h
+++ b/send.h
@@ -98,6 +98,11 @@ enum btrfs_send_cmd {
 
 	BTRFS_SEND_C_END,
 	BTRFS_SEND_C_UPDATE_EXTENT,
+
+	BTRFS_SEND_C_FALLOCATE,
+	BTRFS_SEND_C_SETFLAGS,
+	BTRFS_SEND_C_ENCODED_WRITE,
+
 	__BTRFS_SEND_C_MAX,
 };
 #define BTRFS_SEND_C_MAX (__BTRFS_SEND_C_MAX - 1)
@@ -136,6 +141,16 @@ enum {
 	BTRFS_SEND_A_CLONE_OFFSET,
 	BTRFS_SEND_A_CLONE_LEN,
 
+	BTRFS_SEND_A_FALLOCATE_MODE,
+
+	BTRFS_SEND_A_SETFLAGS_FLAGS,
+
+	BTRFS_SEND_A_UNENCODED_FILE_LEN,
+	BTRFS_SEND_A_UNENCODED_LEN,
+	BTRFS_SEND_A_UNENCODED_OFFSET,
+	BTRFS_SEND_A_COMPRESSION,
+	BTRFS_SEND_A_ENCRYPTION,
+
 	__BTRFS_SEND_A_MAX,
 };
 #define BTRFS_SEND_A_MAX (__BTRFS_SEND_A_MAX - 1)
-- 
2.32.0

