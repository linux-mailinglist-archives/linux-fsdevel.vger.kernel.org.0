Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7602B84C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 20:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgKRTTa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 14:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgKRTT2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:19:28 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E911AC0613D6
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:26 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id j5so1531183plk.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ng3S9jzsXHM6uNgh/DWKZS8UtOoWwHqg6ejAsiMq32A=;
        b=ghXL55lmpcFLzMg1nP3mlUyrBZxvH+ykIs6DIk6t7TYvxlGVJWgrlxAZcwD3H0QORm
         tPEtf2etlYrGH0QngZgiL6IcJTagyjpXq/i+i4xTm9u5fEiUHSo35CKhcSX+zwej+5tu
         Iqm8UuETnJbAuyvlBmbDHkLlnKqFOEoqZWNaykZRbFvG4RmU8NZIqXw8MpI6KbL7ztn6
         EHChq/+phTmop66ocDCq8gR9uEq6oW8OXF08gl25T8fy88ZqjjHToav8gUi1dy3KoyvC
         UzPyjS6bHmSl4mC+rayGkLJulTr/tUNB/LITuvW506Gg/2NAUl6tRx+bztPwTM2XwUDa
         NWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ng3S9jzsXHM6uNgh/DWKZS8UtOoWwHqg6ejAsiMq32A=;
        b=tTSVIHpiF8LU/d1eoYC6yyOM+rlnLiHTUstFPP7OFIGrLGKbex2DyygOu0mmfn0UFv
         jfd51fKN6wKiIBmKe8fgk6J17EQzCoTgfeq0kGuDSdBtDVo5lrJabNpZMDmhePVTbOko
         HOKfijbt3dXdhFzsiDHIF8p+pZucThqcZQGgTNMSjc3wfhHuVzOnSVnfs/URajMXafal
         7WgmdqfTlsHFTczC5U1LHZ7PtargOahBxyho1uqraEObUTOw/G2fi5spfnVoUlcwVPUt
         XNlaO3/D80PGl8U4+cI9yEpsR5/nC2LhCwJ8xlWYVtbV6BICBx0z3HzvPA1OMZgvYwdx
         0AYg==
X-Gm-Message-State: AOAM531itjHVQa4OLp0rM8HJnhBPJm2WvNg47196jelZLwyGGP8wnzdI
        sXYXYGriUji2Njl9CH3tmARzxppqoNTFQw==
X-Google-Smtp-Source: ABdhPJyJSSBXpWt2egYFPP8WmVBzm0RRl48D0NpL29atIM2xMxu2lspygQV3KZ7xzLqMfUV1Uuh4hA==
X-Received: by 2002:a17:902:c393:b029:d9:6e7:6787 with SMTP id g19-20020a170902c393b02900d906e76787mr5682353plg.78.1605727166485;
        Wed, 18 Nov 2020 11:19:26 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:8b43])
        by smtp.gmail.com with ESMTPSA id l9sm3197221pjy.10.2020.11.18.11.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:19:25 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 05/13] btrfs-progs: receive: add send stream v2 cmds and attrs to send.h
Date:   Wed, 18 Nov 2020 11:18:51 -0800
Message-Id: <8495f1c759ae6fc3002cb5d9309d206a6e6f0906.1605723745.git.osandov@osandov.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605723600.git.osandov@fb.com>
References: <cover.1605723600.git.osandov@fb.com>
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
2.29.2

