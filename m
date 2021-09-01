Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3343FE0C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 19:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345700AbhIARCz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 13:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345689AbhIARCw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:02:52 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DDCC061760
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Sep 2021 10:01:55 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d3-20020a17090ae28300b0019629c96f25so178567pjz.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Sep 2021 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Czv/scH0OjTXKN+DARuFwgbXTad4j7QO8lQlEk0GsOU=;
        b=gfE8ivxfE1m9bRvzFn1tVmVGfCtKiB6NyEzVNoMeuzHgn3ZLLBJWYCO2pbYrk5FasS
         3mUhWdUCwPqykqb/IdRdI6//gD6tZZl2PXZqUs4jLN9HRV+LBmLeTyBOmZ6slkXbdao8
         S7bPiO6Sz+ywam54n6HzykfyAJ0tL+TN1w256/JVYLVK6n5kkm1E6D9x5myq+C7CM4MG
         vsT55FUVCyEOX9OXQb3cCvgkkokVCLrWHzfnOl3iJrKDp/vsAIjwepm631qDYnRBdWka
         WdCOV4hnFr0qrEu9JWkMHwm8JMJ8fym7bp34rHjTKv7Sl1ooeC4e2e86+2WeMcpsM4aX
         dt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Czv/scH0OjTXKN+DARuFwgbXTad4j7QO8lQlEk0GsOU=;
        b=aEJDtM6PCNTKhjo7CZjjYRwgdWwWt6XnqM8GQuqxt5cFRwzCCv0C7NZp49hnbdqyyZ
         h+bVr7iuRT/9MfALlDSSzMLo1qxMLp+IzsDON2v/sSNQM5ANcavhIBlEn5dUDCvuUMGS
         4rV4Hzi70eLtK4tmeWccRiKjnYD0xaPlkfX8NerkogkShga8K2/CCS2n193IhhTkspYa
         GJxRmH//FgOPNXdjkjP3bQK79ImtlDmSGzgyA0O8OAMlNCXqeUE6SFRSLRmAGH89j3/B
         WzSfpCIjMdoTv1uDxiNMBTp0XgZVbYAS3s4KcTV9E461SRIAxKYCgmXgxXBFjN3qPg4d
         W98A==
X-Gm-Message-State: AOAM5324V3c5CJ5TMmJ1MgSAy9hd0lKwcI4UgE/Q22Y1s0+q3yFfjhi4
        hca8CTHu0mOARoYsCSujWplieUSpZSe3Jg==
X-Google-Smtp-Source: ABdhPJySl07mGkFlgxODv46Z2AVCxFXgGb6V3LpvkoCF0VXEnvzZd0BkEyOYgtWs9Qt22QEqaMHlmQ==
X-Received: by 2002:a17:90b:601:: with SMTP id gb1mr394295pjb.96.1630515715272;
        Wed, 01 Sep 2021 10:01:55 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:a2b2])
        by smtp.gmail.com with ESMTPSA id y7sm58642pff.206.2021.09.01.10.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 10:01:54 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v11 04/10] btrfs-progs: receive: add send stream v2 cmds and attrs to send.h
Date:   Wed,  1 Sep 2021 10:01:13 -0700
Message-Id: <5b7301ccf0ac841e02ae736138f661630093603e.1630515568.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630514529.git.osandov@fb.com>
References: <cover.1630514529.git.osandov@fb.com>
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
2.33.0

