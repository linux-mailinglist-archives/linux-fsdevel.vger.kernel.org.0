Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 925C24B84F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 14:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbfFSMae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 08:30:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51631 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731804AbfFSMad (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:30:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so1588985wma.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2019 05:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mkwu/3OEXZGqXJyUnO5ri3H818oiUy7gpX5xDSptxL0=;
        b=TSyXhLLf4CmFTkGNCOoBtHFmO22rt36UCLr/PsfHCH7ImaZ54RBRFe6VncExwFywEA
         Oy5WWy1A6s+naf4fFJaxYZoA520H58ttaMPGi42XXOd2EjAg7vMJihDH5wc9ba9Qbg9f
         2KCVXR4lg7P2Qa2CnXuyaCCXP9tia3qpPbOzKKRaPU/r2x6I133l63iJVIBiI79DbZlB
         A+BlSiPv+qzIQJAahuIuAIXKaAdKPEDTfQXQGcCGVyx8qLkBDQgkU0Xab2qYEVbdJXvh
         tAm1LKEOFFVYJ12kd6ZUnGerW4QmrpuAl1p1SaAHb1p6BuXN1YbYOMejqZlhPIIpAoL8
         J5FQ==
X-Gm-Message-State: APjAAAXHRsbx0DXFwFm3CkumTLVo+B+EjOwpReRPvuMfm7XQXVVxbNie
        oqUHhEO6iQJkMXDOHzS6n15Ebg==
X-Google-Smtp-Source: APXvYqzhG/Ojq+ugu+NGlKLRr7Xa/HPx8OL4GK+QnjWlXZC3Xx84s21vw7gBF3qzuyD/LyRnzB0ihw==
X-Received: by 2002:a1c:7d56:: with SMTP id y83mr8459959wmc.77.1560947431788;
        Wed, 19 Jun 2019 05:30:31 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:31 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] vfs: don't parse "silent" option
Date:   Wed, 19 Jun 2019 14:30:11 +0200
Message-Id: <20190619123019.30032-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619123019.30032-1-mszeredi@redhat.com>
References: <20190619123019.30032-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While this is a standard option as documented in mount(8), it is ignored by
most filesystems.  So reject, unless filesystem explicitly wants to handle
it.

The exception is unconverted filesystems, where it is unknown if the
filesystem handles this or not.

Any implementation, such as mount(8) that needs to parse this option
without failing should simply ignore the return value from fsconfig().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fs_context.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 49636e541293..c26b353aa858 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -51,7 +51,6 @@ static const struct constant_table common_clear_sb_flag[] = {
 	{ "nolazytime",	SB_LAZYTIME },
 	{ "nomand",	SB_MANDLOCK },
 	{ "rw",		SB_RDONLY },
-	{ "silent",	SB_SILENT },
 };
 
 /*
@@ -535,6 +534,9 @@ static int legacy_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	if (ret != -ENOPARAM)
 		return ret;
 
+	if (strcmp(param->key, "silent") == 0)
+		fc->sb_flags |= SB_SILENT;
+
 	if (strcmp(param->key, "source") == 0) {
 		if (param->type != fs_value_is_string)
 			return invalf(fc, "VFS: Legacy: Non-string source");
-- 
2.21.0

