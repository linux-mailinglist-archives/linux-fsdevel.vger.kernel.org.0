Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F0C3A3A4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 05:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhFKDee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 23:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhFKDec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 23:34:32 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77D9C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jun 2021 20:32:18 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id l184so1351964pgd.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jun 2021 20:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3Ul25URgYkS02BnTiPzEeWiHrAlONbcKyEZy6N2eO6Y=;
        b=QuekuG5+wmCnUWp7D3BoU6BqUiWF6bcAbULutQY4epDIA1WOZLLSj+EJ5Nv1EODhlu
         eH33F0vW8k7ecADhezTkiRWTNJ5j1sBhbSKsjJrz4NwU0Td6ci0f+lSlUy6Brimjdgt8
         qBVSmGHcd3Yu/CBkFZ7LDiSfXmj1zEQ6nd6KBwlff7cz1yEe14BAFWvd5asFX1ogMcH0
         huVPhAKWjph8Grp4K5mKPkMu+m+lTDknBgMg24kDgzAuGjm6qxNAcYD7q4QYq6fdFGgO
         lUGgpbClwno5T++fl1NV9S6u4bG9x9T3LZup2JsTrczOubWujkvzwQHsEM0yRO2Q/O2c
         ozNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3Ul25URgYkS02BnTiPzEeWiHrAlONbcKyEZy6N2eO6Y=;
        b=ERKImYuvxARIh2XzWheYmYDv2EXN/8u6/LMaVBhmX4saEVlMnTfCZQutrxZFmkqiC8
         THL2xkYAzABE/UJYlA41H7TWwOwcHVlnvNYnjBd2bYkt/GqAzU3EDf8Wb9O37n7I8JKY
         ZIX8hV3afrt1XO6jbN3lgSadsxwqyQX4ZmvTAfVDVN4RxmJk5xgfZHZi4dDO5QEF1eFM
         q640maV6A0JBZRNMaHGr0GA+52Rj/OoAhpfll8HdXcwuXWOWf2ep9cAtJxay7VH6byoZ
         pAlGWx8ikrpVKI3z7IxK17DwWgktjQs7X5m7lwjOomdqae1yo+3FZS+taJeBaxn8kh0E
         6RHQ==
X-Gm-Message-State: AOAM531jbKfmWifjszyDM2CBbZLlbS3Y4XEay8k05E0X2W9pnvqT55SD
        rzRAo6AuC4cDps6XzW039wmTTA==
X-Google-Smtp-Source: ABdhPJxdP6BhIZCKVL8k47gPjyzF7QHNAwSLsiBScQ+ES6R39D59/7Ve0AL2lNaw7KfSr9pnG4yWaA==
X-Received: by 2002:a05:6a00:a1e:b029:2e2:89d8:5c87 with SMTP id p30-20020a056a000a1eb02902e289d85c87mr6187364pfh.73.1623382338224;
        Thu, 10 Jun 2021 20:32:18 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:f66a:ff0e:a646:785c])
        by smtp.gmail.com with ESMTPSA id c25sm3524230pfo.130.2021.06.10.20.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 20:32:17 -0700 (PDT)
Date:   Fri, 11 Jun 2021 13:32:06 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     amir73il@gmail.com, jack@suse.cz
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fanotify: fix copy_event_to_user() fid error clean up
Message-ID: <1ef8ae9100101eb1a91763c516c2e9a3a3b112bd.1623376346.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ensure that clean up is performed on the allocated file descriptor and
struct file object in the event that an error is encountered while copying
fid info objects. Currently, we return directly to the caller when an error
is experienced in the fid info copying helper, which isn't ideal given that
the listener process could be left with a dangling file descriptor in their
fdtable.

Fixes: 44d705b0370b1 ("fanotify: report name info for FAN_DIR_MODIFY event")
Fixes: 5e469c830fdb5 ("fanotify: copy event fid info to user")
Link: https://lore.kernel.org/linux-fsdevel/YMKv1U7tNPK955ho@google.com/T/#m15361cd6399dad4396aad650de25dbf6b312288e

Signed-off-by: Matthew Bobrowski <repnop@google.com>
---

Hey Amir/Jan,

I wasn't 100% sure what specific commit hash I should be referencing in the
fix tags, so please let me know if that needs to be changed.

Should we also be CC'ing <stable@vger.kernel.org> so this gets backported?

 fs/notify/fanotify/fanotify_user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index be5b6d2c01e7..64864fb40b40 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -471,7 +471,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 					info_type, fanotify_info_name(info),
 					info->name_len, buf, count);
 		if (ret < 0)
-			return ret;
+			goto out_close_fd;
 
 		buf += ret;
 		count -= ret;
@@ -519,7 +519,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 					fanotify_event_object_fh(event),
 					info_type, dot, dot_len, buf, count);
 		if (ret < 0)
-			return ret;
+			goto out_close_fd;
 
 		buf += ret;
 		count -= ret;
-- 
2.32.0.272.g935e593368-goog

/M
