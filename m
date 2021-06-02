Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27F4397FEF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 06:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhFBEDW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 00:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhFBEDF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 00:03:05 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5905C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jun 2021 21:01:05 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d14-20020a056a00198eb029028eb1d4a555so785799pfl.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jun 2021 21:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Z8TWrZ1N+kpmDT3P7kRs0ATN9eESgaJlrgr88tTLyBk=;
        b=nqoqK4bXyYWNKPHsGGPnWTOhxk08WuJn4CiwSPoMWatITZOP+2QBsfuwPVae8UEdsF
         oVThx3Km2KlLAhvs+ilooIMZb8ZPKQTZquUUEhr5cOzWXJXpcFzJkgMMP0VMTZOoY57k
         u5xZyibHXAVVzf2SAoAkbXn3xMHtVsZlGghpeWQCbIFQeuLu27tll2ooJhNk41F78Df0
         pMBVzNkBzYXYPc4sMAbzF7IG1syqYcD/AKavpYukgUqOdBPykT4pWg+eQ8LMaQOkat5L
         6arIrAQnE2zGUo3ekmtnNvF3ACkvkbRrf/ZW1vMrNHRJm00Ubi7gvQRFWPrHzC93Uzuh
         ty8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Z8TWrZ1N+kpmDT3P7kRs0ATN9eESgaJlrgr88tTLyBk=;
        b=HHlutGGC64Tl1337MC09FAaqcK/Oczq9iv3U/bLJ30qgFB7SEBMdR14Mbz9GM1TnDg
         r92QXu27baOQLbRWWhoGWlEfdvviMXQ+GV4ED3WzUkHuvd5gfGy/iUsbmREqkQ/Nd0sN
         wrYzcN4NaP9fKG8aMNvX+hFRRFgmCIE8z39+2v7klbRktmJdJfhQ8N7v7OfJDxxTRoTo
         84f4rGbn1LDLMqs5nWgkMSMebqEm80BS0+fI7J7nIw0ml8hZOoGC5YYM5A9XxghTAXRR
         BHIElEwFtaSJjB/kT71mrUj78Or+gSnD0eWv5V0/VIMJQpsIuA18ITcKLbonM1yjF79Q
         qtIA==
X-Gm-Message-State: AOAM530S01Fa/60TG0n0+cd9oFxYt0nOJlVbALjMfGW8cg7j8p+xg+Jh
        7q7rMqdxyjVsAFyfkGo6fmD/e28OaoA=
X-Google-Smtp-Source: ABdhPJx/LBxE4zrDN/L8cOC9B8hUfYcxBJA2Un0jyImpFvETNt39frGfayI7c0PlMb2fqxe4Y+C/v3V0ZuQ=
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a17:902:9886:b029:f9:c8d6:4cee with SMTP id
 s6-20020a1709029886b02900f9c8d64ceemr28909072plp.82.1622606465244; Tue, 01
 Jun 2021 21:01:05 -0700 (PDT)
Date:   Wed,  2 Jun 2021 04:01:00 +0000
Message-Id: <20210602040100.121327-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH] ext4: Correct encrypted_casefold sysfs entry
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Encrypted casefolding is only supported when both encryption and
casefolding are both enabled in the config.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/ext4/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 6f825dedc3d4..55fcab60a59a 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -315,7 +315,9 @@ EXT4_ATTR_FEATURE(verity);
 #endif
 EXT4_ATTR_FEATURE(metadata_csum_seed);
 EXT4_ATTR_FEATURE(fast_commit);
+#if defined(CONFIG_UNICODE) && defined(CONFIG_FS_ENCRYPTION)
 EXT4_ATTR_FEATURE(encrypted_casefold);
+#endif
 
 static struct attribute *ext4_feat_attrs[] = {
 	ATTR_LIST(lazy_itable_init),
@@ -333,7 +335,9 @@ static struct attribute *ext4_feat_attrs[] = {
 #endif
 	ATTR_LIST(metadata_csum_seed),
 	ATTR_LIST(fast_commit),
+#if defined(CONFIG_UNICODE) && defined(CONFIG_FS_ENCRYPTION)
 	ATTR_LIST(encrypted_casefold),
+#endif
 	NULL,
 };
 ATTRIBUTE_GROUPS(ext4_feat);
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

