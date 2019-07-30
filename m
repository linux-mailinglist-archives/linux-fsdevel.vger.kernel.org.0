Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D72D79E3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbfG3Buv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:50:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42249 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730911AbfG3Buk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:50:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so28254432plb.9;
        Mon, 29 Jul 2019 18:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2ZSThE50NNeqhGeatQJKVePoQLkvHh5lNhLyxKc+P10=;
        b=G/sRwmaWmQYl7mNyCUU4QUj5B6N3VaV1fxKTTDTNh1nNyTteIy7banRQTi7zWMIiq6
         aasftDWeoTUZF9zqIVJSbqB8TfCk50NmbinX/dIRBEQ9pLaNYRqynThGYnGsMpjPhNqD
         82pYQVfZcgVHrAg2l20u7bYK92+prDKCuFC4BsoVC0o/mqfy6iVphKr6eTuhT7tbkQyv
         8Q3ZBH7oPtXLJKuMiaaqnWuJN70WcH+epSsSBPpqwQRTczQWwsJbRobUJTI9QQ9JwMKY
         Cvjvh9inU3A4WoiwHMTNOtpie6kfHxH6GXMcnn4g03zohvAjTH3Cem3zkS11Ombsifci
         2low==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2ZSThE50NNeqhGeatQJKVePoQLkvHh5lNhLyxKc+P10=;
        b=Am6C+RMkQ85RXlN1vW4aatjQoG59vPnf3BBwDXQkNoxwV7pQ/znGRL5L1MphipDQZ8
         hcu/kAvvqrunUgocSZD5H3hgRNTa5bK2+uVL9pA3E3pFIsyXAfHH9MM0v99LhU4JahqH
         G7pdiRQixJ66ihfGwvZ9cSUDIJk3Caw05fZPDVEBNehqGBl3lY5o/olGx359DoU7Gx1u
         CI7ophk0N/tvyIKnlXKqvCOu3dKmEZms9oOujwPR7vF+wL4P0BSzk3qDykbhbB9E0Y0H
         GCiD6myKa/4wEYb5egscO34tsB8/9lP2dUjyOPQy9mRYY489CFinEbOq4WtggPoI9LAt
         OoNQ==
X-Gm-Message-State: APjAAAW+kmDz+7chPZCNes7LaYQbSxssVc1uRuyatAVNmykUxzLzWx2r
        l4kgYQe5QsEBiQmDptlgX+M=
X-Google-Smtp-Source: APXvYqzPSFQCjcYcdyjouStI1bcFGux0Ndao/REHUqNGuDSyZqW0Iz/8Z4xiR8hnOnkPDpeu+z6v4g==
X-Received: by 2002:a17:902:ba96:: with SMTP id k22mr115650959pls.44.1564451440013;
        Mon, 29 Jul 2019 18:50:40 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id r6sm138807156pjb.22.2019.07.29.18.50.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 18:50:39 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, anton@enomsg.org, ccross@android.com,
        keescook@chromium.org, tony.luck@intel.com
Subject: [PATCH 19/20] pstore: fs superblock limits
Date:   Mon, 29 Jul 2019 18:49:23 -0700
Message-Id: <20190730014924.2193-20-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730014924.2193-1-deepa.kernel@gmail.com>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Also update the gran since pstore has microsecond granularity.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: anton@enomsg.org
Cc: ccross@android.com
Cc: keescook@chromium.org
Cc: tony.luck@intel.com
---
 fs/pstore/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 89a80b568a17..ee752f9fda57 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -388,7 +388,9 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_blocksize_bits	= PAGE_SHIFT;
 	sb->s_magic		= PSTOREFS_MAGIC;
 	sb->s_op		= &pstore_ops;
-	sb->s_time_gran		= 1;
+	sb->s_time_gran         = NSEC_PER_USEC;
+	sb->s_time_min		= S64_MIN;
+	sb->s_time_max		= S64_MAX;
 
 	parse_options(data);
 
-- 
2.17.1

