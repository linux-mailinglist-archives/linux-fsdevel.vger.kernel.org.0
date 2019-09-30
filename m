Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4B5C27A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 23:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbfI3VB0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Sep 2019 17:01:26 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43216 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfI3VB0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:01:26 -0400
Received: by mail-io1-f66.google.com with SMTP id v2so41985394iob.10;
        Mon, 30 Sep 2019 14:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CEUArm6gWibtMVWUMfUQg1zTk+VJsqkWb8i0x1lr37I=;
        b=iwsVE4VD78l6Fnw0gClX+7nvq5/Bzwjph4155ZqyLgN4jqzX1ORSCaLTJ0NGyKZAna
         /BGgTc8VwMNIaM9Aw72biO9dCIFORmK5E6cWM5FumLUpa/Pjlw70c+UC3iO7MSc5yFAn
         d6ipZaZqB5W0JnAvBsj097K+oNLKIynYKApiiHksaEOKsB7A0Lgu0xkz5zObgNQal8Iv
         0h0YUm6Ad6EX0+72mkNw9VmmyuOgFEsX1gJ42KSEHUNh7LabGLgaSno2Ryo3RR/DOMLr
         7pGtqS/yj1Hcw2V/DaNtmf6PRFxsiUE1J+qdm6Ql0svB1GLiG9AcAQHa0tp05O70P9kD
         vO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CEUArm6gWibtMVWUMfUQg1zTk+VJsqkWb8i0x1lr37I=;
        b=bIxXsd0+lizNCgM2LRw+GlStzSsMygArmwNkUokvRn1koMveRYjQPmyWsCevVK49Y0
         Ekv70oeELMsFCrMjBqZLzMccgH1tQEd3TVyWSA3PwBmHNYb7/hxZQc0e7tpIuagtEQe2
         gLKd/+Y3jwj+NM0h35hQj1DlKiPV7JTnuYco3sqBxVGFqdX4Y4EGG3ychHUEzJKj4v9l
         6vnN9xAxPa3wZCo0bcTQpNQxQA/mie3SFUQeSygvMOek5qnNvlAlVbFfhF6o8k/h5qFl
         r25SvDKnLLer/BW4zLZXtxKKLYP2o1tblhaC6KNEguSUEv923x8Awgh6AS9anX/6yMfK
         MD6Q==
X-Gm-Message-State: APjAAAWRelaZ+oH0RkeHyGOxqI37L/17Oid7QLexJ4mqk8s6nyuub3ds
        VLU8BkBPKDgE7l21qpwEwN4=
X-Google-Smtp-Source: APXvYqwGKvKPipBsipTjqYnbO0ZYDc+fU6ZsBhKsdyPYo5t6z2MnUinh4EbcZUdRgFrOXQ9W2hBq/Q==
X-Received: by 2002:a92:d5c5:: with SMTP id d5mr20928394ilq.63.1569877285716;
        Mon, 30 Sep 2019 14:01:25 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id c8sm6063991ile.9.2019.09.30.14.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 14:01:24 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Markus.Elfring@web.de
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] fs: affs: fix a memory leak in affs_remount
Date:   Mon, 30 Sep 2019 16:01:10 -0500
Message-Id: <20190930210114.6557-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ec7d3fdb-445b-7f4e-d6e6-77c6ae9a5732@web.de>
References: <ec7d3fdb-445b-7f4e-d6e6-77c6ae9a5732@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In affs_remount if data is provided it is duplicated into new_opts.
The allocated memory for new_opts is only released if pare_options fail.
The release for new_opts is added.

Fixes: c8f33d0bec99 ("affs: kstrdup() memory handling")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
Changes in v2:
	-- fix a type in title, and add fixes tag
---
 fs/affs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/affs/super.c b/fs/affs/super.c
index cc463ae47c12..1d38fdbc5148 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -598,6 +598,8 @@ affs_remount(struct super_block *sb, int *flags, char *data)
 	memcpy(sbi->s_volume, volume, 32);
 	spin_unlock(&sbi->symlink_lock);
 
+	kfree(new_opts);
+
 	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
 		return 0;
 
-- 
2.17.1

