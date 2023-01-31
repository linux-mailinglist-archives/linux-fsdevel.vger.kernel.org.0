Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C406831EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 16:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjAaP4Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 10:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjAaP4O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:56:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FDA17154;
        Tue, 31 Jan 2023 07:56:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0B1061551;
        Tue, 31 Jan 2023 15:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59B6C4339C;
        Tue, 31 Jan 2023 15:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675180572;
        bh=IcXc4uCVYnYjMccYdVFqtLssqj6bmugsjF7l8KDMQvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tPWYl3nIji/sBLzHAe/gJE26dnOHxgLscyV0BilJgs9cjTo863AuYpMem6rSCS7ix
         MIWlk5KncNGbAxhaLtKNU7lA6W0wbYGqxTbzbDWfo5KGZVr3rnW/B3+npjWMouJcg5
         3iYQYWqq4OjLX6zDGD/SA8GUxJKZBogibcHETvaCY1uOaMDc5mKX01OXlqQB5EhUg7
         eDWDHUAj9SODyG5r/urpi3JAHtpoMXET4l8XfCheuBsgw2ZJajZpi+jgVCjYTiZEZo
         BriA6Vz7cEDZiLpJmwo/daU7Tej5o9+fZwsQL/heSI2/jygk7QePD9Jp5+hmz2Yuls
         2e/0O6pktWO/A==
From:   Chao Yu <chao@kernel.org>
To:     akpm@linux-foundation.org, adobriyan@gmail.com
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] proc: fix .s_blocksize and .s_blocksize_bits
Date:   Tue, 31 Jan 2023 23:55:59 +0800
Message-Id: <20230131155559.35800-2-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230131155559.35800-1-chao@kernel.org>
References: <20230131155559.35800-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

procfs uses seq_file's operations to process IO, and seq_file
uses PAGE_SIZE as basic operating unit, so, fix to update
.s_blocksize and .s_blocksize_bits from 1024 and 10 to PAGE_SIZE
and PAGE_SHIFT.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix to update blocksize to PAGE_SIZE pointed out by Alexey Dobriyan.
 fs/proc/root.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index 3c2ee3eb1138..8bf5a9080adc 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -173,8 +173,8 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 	/* User space would break if executables or devices appear on proc */
 	s->s_iflags |= SB_I_USERNS_VISIBLE | SB_I_NOEXEC | SB_I_NODEV;
 	s->s_flags |= SB_NODIRATIME | SB_NOSUID | SB_NOEXEC;
-	s->s_blocksize = 1024;
-	s->s_blocksize_bits = 10;
+	s->s_blocksize = PAGE_SIZE;
+	s->s_blocksize_bits = PAGE_SHIFT;
 	s->s_magic = PROC_SUPER_MAGIC;
 	s->s_op = &proc_sops;
 	s->s_time_gran = 1;
-- 
2.36.1

