Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AACC3C93D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2019 23:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfJBVwz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Oct 2019 17:52:55 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37654 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfJBVwz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Oct 2019 17:52:55 -0400
Received: by mail-io1-f66.google.com with SMTP id b19so880256iob.4;
        Wed, 02 Oct 2019 14:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0FH/Ql1YZ9Zx9Hb5RkkVkUiTPlW6ZQ9p6QOTNzXQQDY=;
        b=CO8EOQJRXhdRs0jPpcPQytkdOJC3fm/d3QrojFtX8YXONsarhEHAEdhuFTmktztaiQ
         2ha9qeSqDiucfqJ5fQ7L+35KzoxZp0uqGeYKCVApTr62uzUUe1oceXQwqNKSQCKyiOwn
         277tbtvXwGnJVRdAmHZDC4cbf4D8gRuDO+u1M2jh+aAMbsg405zAQ5C2cKLArwIZjBMR
         3puCssidxOzc827J8yTudVDFzE63bVi3l1dq3JBDnSYwvCLgtxqb42kF7NOYI6MnjO6/
         uL/v50PqcHxpWW/RQUXuoYHLaaB+b1A5cbT8Y8+DPfb7ZpX/LxbDxLJ94K8QJH5aIBr/
         KMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0FH/Ql1YZ9Zx9Hb5RkkVkUiTPlW6ZQ9p6QOTNzXQQDY=;
        b=PabK/18us4EnzvRZynQEmdpZbxbUyrl5SaNLrfs3bP48UfZSQX0LfQJM12ywscRX4/
         j+B8A6UGP+zW9bXu676SMyAnRxD6dLvI0zxkvCGempD+WaQ4RSVw8tzbCwwkXBsspxXw
         9R+D35tLzRuQLJnONT6syLie3z1U556sVbT4gwa/oqatK3tvxv0dt3CN2nb9QYUm9TWS
         zmuQTFNpQuM0jhMRk5bnT6LsAslKVZ2YbeKiiHNk5kZS09JSvCBLMU4bzQmEh//hEE1q
         vlWJm8Y99PevJGN72tIDtq9ycZngrw+LZEOL21mEqrDkE+y2L06WZ43pA1wtMyzcwXUY
         gIbQ==
X-Gm-Message-State: APjAAAV712pckrvKxeHR00bSzKrlPgCm5TjoceMwL7er9UKA6Xe0kVct
        Y4eh8z9A2Xrs+vW+WgX7wrM=
X-Google-Smtp-Source: APXvYqyhyHMRd4OeekOxCoS3Urza6Pc4ZzekQO9DQN2uPvUqIeh31x7k9cTvE7eXYshmJ+MSy5S8PA==
X-Received: by 2002:a92:5bc4:: with SMTP id c65mr6396088ilg.90.1570053173101;
        Wed, 02 Oct 2019 14:52:53 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id v3sm192370ioh.51.2019.10.02.14.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 14:52:52 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     dsterba@suse.cz
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Jeff Layton <jlayton@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] fs: affs: fix a memory leak in affs_remount
Date:   Wed,  2 Oct 2019 16:52:37 -0500
Message-Id: <20191002215242.14317-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002092221.GJ2751@suse.cz>
References: <20191002092221.GJ2751@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In affs_remount if data is provided it is duplicated into new_opts.
The allocated memory for new_opts is only released if pare_options fail.
But the variable is not used anywhere. So the new_opts should be
removed.

Fixes: c8f33d0bec99 ("affs: kstrdup() memory handling")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
Changes in v2:
	-- fix typo
Changes in v3:
	-- remove the call to kstrdup, as new_opts is not used anymore.
---
 fs/affs/super.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/affs/super.c b/fs/affs/super.c
index cc463ae47c12..b6c6080d186c 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -565,10 +565,6 @@ affs_remount(struct super_block *sb, int *flags, char *data)
 	char			 volume[32];
 	char			*prefix = NULL;
 
-	new_opts = kstrdup(data, GFP_KERNEL);
-	if (data && !new_opts)
-		return -ENOMEM;
-
 	pr_debug("%s(flags=0x%x,opts=\"%s\")\n", __func__, *flags, data);
 
 	sync_filesystem(sb);
@@ -579,7 +575,6 @@ affs_remount(struct super_block *sb, int *flags, char *data)
 			   &blocksize, &prefix, volume,
 			   &mount_flags)) {
 		kfree(prefix);
-		kfree(new_opts);
 		return -EINVAL;
 	}
 
-- 
2.17.1

