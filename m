Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D487D7A7A42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 13:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjITLUe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 07:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbjITLUd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:20:33 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8FEA1;
        Wed, 20 Sep 2023 04:20:23 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c465d59719so28818355ad.1;
        Wed, 20 Sep 2023 04:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695208823; x=1695813623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrYaQMi129MfXVncu6BToQxK7QswkFgAkNIRkcmNulM=;
        b=dTQeUX8YlbBW6F+wjIxvhuWEx2q8giHxzQQzXKRDC2mEoi3eBJKBpqaKGZUQjikR3c
         ohDX7oCD9IDzV2s2rFNoYkAdHwRbMlzXIJs/JBhC6+sMNvnUNMouEUzxZGoWEijT9I0w
         5E5+X5v4Z9yO6jIYtE/NTfAbXEPjRev8bQwtaVh/eSJy8PTkWLwLI7TUJiwuicHoH+Ko
         BW7C0yxdKAn3nr07Pe/y3U1TyWvcQuoUnMFq9UrGkzQ00+oiCYxYfyIfYnG5zimcPs2I
         ZdcF8ZierNyM634PDmqeyeOPZBy0fY1D7rME1fm7/MjF4lvPJkryFPzfH1EBSJWLnNeH
         xV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695208823; x=1695813623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrYaQMi129MfXVncu6BToQxK7QswkFgAkNIRkcmNulM=;
        b=RfdahbLUbIaEx+TB2CioB5VoVNupDwx4KQA8nlF1PEDS3RywJ0qSapkUTlpZwWkBeT
         umttIZNFObKTjOQtmOe1lcn0Q+N/KE6bZ9iQrBHjNrA+TwGVWY/yPYl7snFkuO/9JMxm
         xSoTyt58NoYJloJAPdPybOSMbRB4Nx3zFnPa/P5cZwuc/OVrauIkDq1xtlpKFkwcAHV4
         Qexe5DNFZIh0UuqJsTtJwpTi9AsxynH8EJykfCGNKCn/1gVu6OvxCEbJiavHn5BaOpUt
         bc4FWxNB9GEMEdp5Jo1ebXMZcqdjJhyrwRRov8bIccYb9wZKSJ5sjikVhPjoL3xTRQy8
         lq/w==
X-Gm-Message-State: AOJu0YxKnFb73pnU4DY59UMcIjLwafsjAMM7lztbG0BFDUUS+2mjYfGf
        kL/P4cjBk8zBNs+FtBpyhB0=
X-Google-Smtp-Source: AGHT+IGZYXpsW5iovKSBardgpPHBYkbHJu0ltbIi7R1cQiB17QV6sJ6uYvB6H+XTzefXxXiZEdGUsA==
X-Received: by 2002:a17:902:d503:b0:1c0:b8fd:9c7 with SMTP id b3-20020a170902d50300b001c0b8fd09c7mr2418167plg.43.1695208823377;
        Wed, 20 Sep 2023 04:20:23 -0700 (PDT)
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
        by smtp.gmail.com with ESMTPSA id iy13-20020a170903130d00b001bdd512df9csm7968397plb.74.2023.09.20.04.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 04:20:22 -0700 (PDT)
From:   Edward AD <twuufnxlz@gmail.com>
To:     syzbot+9cf75dc581fb4307d6dd@syzkaller.appspotmail.com
Cc:     adilger.kernel@dilger.ca, ebiggers@google.com,
        krisman@collabora.com, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: [PATCH] unicode: add s_encoding null ptr check in utf8ncursor
Date:   Wed, 20 Sep 2023 19:20:16 +0800
Message-ID: <20230920112015.829124-2-twuufnxlz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <0000000000001f0b970605c39a7e@google.com>
References: <0000000000001f0b970605c39a7e@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When init struct utf8cursor *u8c in utf8ncursor(), we need check um is
valid.

Reported-and-tested-by: syzbot+9cf75dc581fb4307d6dd@syzkaller.appspotmail.com
Fixes: b81427939590 ("ext4: remove redundant checks of s_encoding")
Signed-off-by: Edward AD <twuufnxlz@gmail.com>
---
 fs/unicode/utf8-norm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/unicode/utf8-norm.c b/fs/unicode/utf8-norm.c
index 768f8ab448b8..906b639b2f38 100644
--- a/fs/unicode/utf8-norm.c
+++ b/fs/unicode/utf8-norm.c
@@ -422,6 +422,10 @@ int utf8ncursor(struct utf8cursor *u8c, const struct unicode_map *um,
 {
 	if (!s)
 		return -1;
+
+	if (IS_ERR_OR_NULL(um))
+		return -1;
+
 	u8c->um = um;
 	u8c->n = n;
 	u8c->s = s;
-- 
2.25.1

