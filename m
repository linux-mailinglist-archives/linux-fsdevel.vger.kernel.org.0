Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02766632083
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 12:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiKUL0n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 06:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiKUL0O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:26:14 -0500
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E02BFF74
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 03:21:47 -0800 (PST)
Received: by mail-ej1-x649.google.com with SMTP id ga41-20020a1709070c2900b007aef14e8fd7so6500638ejc.21
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 03:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iseMGXVhmQtR+5DQv6vAmctq3FLXZ3Zx0bYYW0I3bps=;
        b=fvoRIPmpwjc9kwZJjlC8SWhtwYdajteuU8MNnEWUMvn5GkD+yGWYPUsDcdndaw8YjK
         fa13YD7A3DdjmU3EhEj99KaM6rOjUxJKB/d/QJYdnY6fqKOJgZkPoO8RrrWJe1U4umr+
         hiUfjkhq3hMpxwynNBwHUtYJWY9QJy0HLcUfde1YnzFDialtNBgsAL/Lpaq6bDXTMM62
         N5V2k9a1D0kusoUoO9/V+NmAYKbT5IpfYNf/E/G22Vwu5YTvASjATJcEIMrdADAeDQc2
         MVVCkuX8C8EJypjMeMPM03N72UYeZDw46ri4QQG9SKF+2INt3aYRQ+JZ/H1xOpAorNwU
         0etA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iseMGXVhmQtR+5DQv6vAmctq3FLXZ3Zx0bYYW0I3bps=;
        b=EuR6jNOfrQK3DAkeSvRtw2pIFuWyU9tvWVVavG6Ifds9h/uKxbRXDXA/NiaDZuIS8d
         avUdxw8HaojvpAig3xYhX38NKBe6ZX8QMQbnOijZRoayvtMaN5gQnYG55aexS8gB9gWv
         BJ1klXmCQCBUaazmd7/VcEwgVNUpmzJjQnDwG1VSmmu0Mwjo/hpvVU50WSnZJoAjJZXL
         QXmmgZZsLNTtMWWYC0okXwnMWCjDF1mxFgkHlzMgIImTSgKLAnSlINToH94+bhMxqwnj
         9mnzgaqVHF7ZgzGbt8gpLVKHNcK7aolXdWa61hGHcmRkIDOQvyA/8x2eSyhGQ135X6wY
         Nm0Q==
X-Gm-Message-State: ANoB5pk8uqvlfiSMdCKWdDpKAuC5jEQjyrj7vE0Sywao8H4SDJZVQrO2
        vmWEDklWOpgWE5/XKX1ZUBPQy9sMyfU=
X-Google-Smtp-Source: AA0mqf5//ubCLbRHw5k5ojH75x8ASFqsHvPLZaawkowyC5ynCgNspfsSIAS8NxDclO+KSFJJIsbTDrSav0k=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:db68:962:2bf6:6c7])
 (user=glider job=sendgmr) by 2002:a17:907:8b13:b0:781:541:6599 with SMTP id
 sz19-20020a1709078b1300b0078105416599mr3206798ejc.45.1669029706445; Mon, 21
 Nov 2022 03:21:46 -0800 (PST)
Date:   Mon, 21 Nov 2022 12:21:33 +0100
In-Reply-To: <20221121112134.407362-1-glider@google.com>
Mime-Version: 1.0
References: <20221121112134.407362-1-glider@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221121112134.407362-4-glider@google.com>
Subject: [PATCH 4/5] fs: hfs: initialize fsdata in hfs_file_truncate()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When aops->write_begin() does not initialize fsdata, KMSAN may report
an error passing the latter to aops->write_end().

Fix this by unconditionally initializing fsdata.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 fs/hfs/extent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index 3f7e9bef98743..6d1878b99b305 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -486,7 +486,7 @@ void hfs_file_truncate(struct inode *inode)
 		inode->i_size);
 	if (inode->i_size > HFS_I(inode)->phys_size) {
 		struct address_space *mapping = inode->i_mapping;
-		void *fsdata;
+		void *fsdata = NULL;
 		struct page *page;
 
 		/* XXX: Can use generic_cont_expand? */
-- 
2.38.1.584.g0f3c55d4c2-goog

