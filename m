Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F8B24CFA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 09:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgHUHlN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 03:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgHUHkn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:40:43 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D36C061385
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:43 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id z23so513833plo.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HPllMP1dggYArlaBG8NbdTKVXA2/TOK/hKcMMPnu8LA=;
        b=IP6qcyz3YWCExIoUyhje7azbZk90z3J/+FZDf98t6ckQrKngJGknpqKrixQJHnL6n/
         nJo6BM45hA6TVWMpLVxhEBKr7SLPZsVQvGGtl8pwv/9tZUaozMggjPKKrSOhf39LmKEe
         kREF5Uijlym1NEz/PLMdJvy5Y/QnT9z1YczOrRmuEwhQKtxdKseemhOOhuotGdKouSNB
         7xDy2d2dLB2NLD3hUjaWuR898WiAss4ammDiyezszjDsLinXOoWPZHjw7KRR0EwD+84g
         zQwLNiYR2WMPjlG+cr212Sk1vTbNdDGyScUDD7S54qCiYBRttx5MatrFui/tNtqplOtl
         TDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HPllMP1dggYArlaBG8NbdTKVXA2/TOK/hKcMMPnu8LA=;
        b=TO7yaXJYNsEgSf0oajj2xw2CuTfUCNaoJ+gALFcmC6noSLgeNaCLWqAoZHzlMND24m
         1uz/n3d/id3VY+rHPIjEzwDOIyN4AHg7d6NNZKJG0uOD7JH3Ma2D5Fz94Kfpa1PVT7Zv
         jHsX7bu5WRRTqDBOjB0fqtsb5DyCgaPhQb25zP7/hoXO/lnIOzBgH8qSHzC9Us3UO27x
         4nRj2RJXHuVSHgzkRreWFFwISA8guTdmxWaebhwPJouCxEQrktYAD4fdFmZUh2wIUU8O
         kSps6Y3UyTdn0ybKude/Lf2EeBZ05EwDyDwDmtI5BZjDlKNmPZW1CjuRgG6r8KSo1WTw
         uJgQ==
X-Gm-Message-State: AOAM531PLI3AKStkpPVSwWkyPCIhKP+uH4AuX9Uqm6WfY6RHIem6979u
        o0A4/DMAoWuskU7wNaXkC+Dw3/pT1vaVtw==
X-Google-Smtp-Source: ABdhPJzjSz6B/wIUhrw81Khq6id6K/AFXO+kMSQ2LmrsdpT9MO9QNi0H3um10Hmj7H+rctPHlxvQAQ==
X-Received: by 2002:a17:90a:c787:: with SMTP id gn7mr1497597pjb.90.1597995642917;
        Fri, 21 Aug 2020 00:40:42 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id jb1sm1080875pjb.9.2020.08.21.00.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:40:42 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/11] btrfs-progs: receive: add send stream v2 cmds and attrs to send.h
Date:   Fri, 21 Aug 2020 00:40:03 -0700
Message-Id: <3477da4106d103099b41705e2a84fb58c18cbd29.1597994354.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597994106.git.osandov@osandov.com>
References: <cover.1597994106.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
2.28.0

