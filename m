Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59F72AB44D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 11:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgKIKEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 05:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgKIKED (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:04:03 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540CEC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 02:04:03 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w14so5031674pfd.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2020 02:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7AVIsTLSuERUo3ZlSNUVHIDaou3IkmMKt865T7sgWys=;
        b=BzGMwtP1GoOp/qtAlRQLHnK9sZIsvQe4zUy382LGQc2EqchBXzFOZ/RYkp9rKH8I3C
         v4Dmk9jNkO1ZEaGzMa6dSVo7chIZs5XI7FLbRxyrUzIo+wQVK57pZ7sZYHGiegEfHFfJ
         lp7OXKmas9Mn0wyRtqQY7s+KnONbrpzao+M9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7AVIsTLSuERUo3ZlSNUVHIDaou3IkmMKt865T7sgWys=;
        b=VJ6GxeOPEmbUkmBGciuup8sg4RA3u5nKBHUP2etHyA16KBL/3HGtJwxcQdZaKDFj/S
         KK8AuN24JMrgIA3coESgieIXG/RA131VFCZaCgArjviZIsmLOlNzzRY319Xnj2fsoEIh
         zLwgmk12UcPmy+VZuy8CU0ZsedqyV1NoLLEbewp6+pQb3o9Wqg1IgBjAJX5b6qU21dNc
         CpRDJmlzFSGbI/DocQecApiolkK7zuE65E1gIk+lPNWtmtBICwGj1rKdiT/SJsiJZpWY
         2CJCKkm5RSr+tflmHiPXewz1i+d0prJELkx+fygWnViPbmxdlurt0BdJNwi8JOLLH18s
         NqqQ==
X-Gm-Message-State: AOAM532SvqyHsTzNKDtYiVMY3RJhxpmslgle5+l14NDJcDXukIeYX1H5
        2LhKcy2l4SnWDjZmC7XBlwTRFA==
X-Google-Smtp-Source: ABdhPJwzBFGWwocOm8YHCn7X7cDSvFFuewHqmvu5+QDfn9ZVMvFvCQM23fcr6yfzpdAk5zyZT0kaqw==
X-Received: by 2002:a17:90a:2904:: with SMTP id g4mr6647864pjd.102.1604916242995;
        Mon, 09 Nov 2020 02:04:02 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f693:9fff:fef4:2537])
        by smtp.gmail.com with ESMTPSA id z5sm11651662pjr.22.2020.11.09.02.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 02:04:02 -0800 (PST)
From:   Chirantan Ekbote <chirantan@chromium.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel@lists.sourceforge.net,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH 1/2] uapi/fuse.h: Add message definitions for O_TMPFILE
Date:   Mon,  9 Nov 2020 19:03:42 +0900
Message-Id: <20201109100343.3958378-2-chirantan@chromium.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
In-Reply-To: <20201109100343.3958378-1-chirantan@chromium.org>
References: <20201109100343.3958378-1-chirantan@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the fuse_tmpfile_in struct and the FUSE_TMPFILE opcode. Like other
operations that create new entries, the server should reply to a
FUSE_TMPFILE message with a fuse_entry_out for the newly created entry.

Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
---
 include/uapi/linux/fuse.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 7233502ea991f..db7bcf87c3977 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -175,6 +175,7 @@
  *
  *  7.32
  *  - add flags to fuse_attr, add FUSE_ATTR_SUBMOUNT, add FUSE_SUBMOUNTS
+ *  - add FUSE_TMPFILE and fuse_tmpfile_in
  */
 
 #ifndef _LINUX_FUSE_H
@@ -479,6 +480,7 @@ enum fuse_opcode {
 	FUSE_COPY_FILE_RANGE	= 47,
 	FUSE_SETUPMAPPING	= 48,
 	FUSE_REMOVEMAPPING	= 49,
+	FUSE_TMPFILE		= 50,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
@@ -602,6 +604,11 @@ struct fuse_create_in {
 	uint32_t	padding;
 };
 
+struct fuse_tmpfile_in {
+	uint32_t mode;
+	uint32_t umask;
+};
+
 struct fuse_open_out {
 	uint64_t	fh;
 	uint32_t	open_flags;
-- 
2.29.2.222.g5d2a92d10f8-goog

