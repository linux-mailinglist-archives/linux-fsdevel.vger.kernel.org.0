Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E24643D0B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 07:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbiLFGP6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 01:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiLFGP5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 01:15:57 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C900327169;
        Mon,  5 Dec 2022 22:15:56 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id v3so12519278pgh.4;
        Mon, 05 Dec 2022 22:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cao+GfaGrq2ECO1hr0MTI44zHM0MFwGfvfdh/iV+l9o=;
        b=ANIjq6WCcDktRPe1ueay3wixt+JhU/DP767DDqVBVffq1j1J01LAu8298A1+Kc84X6
         IWiMQiYbzpg1y2rlsYmUXyUaqtIlkhUKRB9mAfjZuzwBEjJxLyvQahoErlTOG5o2ee98
         o0pa7npb3BbvNcYzOrN20P45Bw29uSOO1SVw3YPjz0Tmntd5h3xlFvyFIDx/4fxsME6E
         Vi2Hhku8FkpJGdqzLV6pP2ddZiwHaI4zqdQTnCwVHuvhZ4IHu9xA5xtFx/m3YBevFzEK
         bwUZYPulvssSh+9RLgEB6BFJBCsNOneXmaDRMrCwX7w6wa3IbDYpDcd4H/3hNGa2Qd7g
         yHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cao+GfaGrq2ECO1hr0MTI44zHM0MFwGfvfdh/iV+l9o=;
        b=tQwZc3LV6Y3I9Y0WzApLfA4s5aZokRrX2h6zU9ed4WSF9VtRKH7E+ODD2fs38aVsS/
         EDkUP+sW+Ky2cH6sjks8ioXpxZfuB9/iRdjxQim1ToCWedK+ytrz6ZPcLjX3qyvU2nI1
         Y7guKdNHyDY/CQMep6BuH8OnrD4OLo3m2D3gZK06e0mbdAPv5Oq1yY3dJjOa0UQyLZYu
         6uI8ZL6VyCCI88BKzoCpr0m6DTziwBnq3WCua0AJAtuY5xU9AReXixVK8Q0IZx+5R0fr
         BEPWWt0Ri3eTNlGR1lEmSHYQSXjzq6j2wgRw/DmNwohLKLIiqeJ9ZTX9HzAe3aSR3x5V
         TS4g==
X-Gm-Message-State: ANoB5pmq0+W5Y+tsVBUirShg7YLqXfGJtz4bXfCoMzwifEMU9HWyL1Ol
        B25lH1el5o+oprOZLe4SxZw=
X-Google-Smtp-Source: AA0mqf51fDDfA8tYm68EG4YmthSBGmIpHHULymVB6KvmwTqLu5LaTA/sjuYrnkEPYohep97WifxOtg==
X-Received: by 2002:a63:495e:0:b0:43c:a5cb:5d1b with SMTP id y30-20020a63495e000000b0043ca5cb5d1bmr60848658pgk.134.1670307356320;
        Mon, 05 Dec 2022 22:15:56 -0800 (PST)
Received: from PS-CAN-014uA51.localdomain ([58.63.247.51])
        by smtp.googlemail.com with ESMTPSA id r13-20020aa7962d000000b00576d4d69909sm3720153pfg.8.2022.12.05.22.15.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2022 22:15:55 -0800 (PST)
From:   Chen Xiao <abigwc@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Xiao <abigwc@gmail.com>
Subject: [PATCH] fs: use helper function file_inode() to get inode
Date:   Tue,  6 Dec 2022 14:15:34 +0800
Message-Id: <1670307334-3638-1-git-send-email-abigwc@gmail.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 496ad9aa8ef44 ("new helper: file_inode(file)") introduced
the helper file_inode(file) but dir_emit_dot forgot to use it.

Signed-off-by: Chen Xiao <abigwc@gmail.com>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 59ae95d..014aef9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3567,7 +3567,7 @@ static inline bool dir_emit(struct dir_context *ctx,
 static inline bool dir_emit_dot(struct file *file, struct dir_context *ctx)
 {
 	return ctx->actor(ctx, ".", 1, ctx->pos,
-			  file->f_path.dentry->d_inode->i_ino, DT_DIR);
+			  file_inode(file)->i_ino, DT_DIR);
 }
 static inline bool dir_emit_dotdot(struct file *file, struct dir_context *ctx)
 {
-- 
1.8.3.1

