Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEB36E5DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 14:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfGSMn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jul 2019 08:43:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35923 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbfGSMn5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:43:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so15602861plt.3;
        Fri, 19 Jul 2019 05:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=/FrjOlHsU/rFl8swGWw38s2HqBJIeif3GsejqegBQfE=;
        b=HHBrAYBsAlGxR2OIsZGbdNPvlEtFEwW5mIo9kKXWBwu9d4V+76wWe/JhlvzH4cRzOl
         c/s+PKUjJ768Dms1tPcHbfJ6sR5hRwsWPCSn8eY//T6P67/wyUyJaHOjg8oWvu6deR80
         iW23s6joLdSePWwcOSjbrhX1eeq5YlkoYEL1u0MnizWv1QX8dyQ5a6CyDaZEgcw8W0+U
         jgChwcXrQzqkbJ1aqtVcnbz5FjkgVGMUeVC5uv7X+KyxzAUgwiPOaljKG3L/1HPYtvsO
         3Tt5t9tvTQBjVupL7CxLf8z4FpRe2usC6RXP0cnB3bESqEweUF6MwX50Ouw7y5Q2oi/W
         vGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=/FrjOlHsU/rFl8swGWw38s2HqBJIeif3GsejqegBQfE=;
        b=E6xfx0dbhMiZ4VD86urN/fjQT8a10D+JviPPhaRKIYJB1i7mekielgjMHQpkp6BEoH
         /SoHo4KbbNefYiX1biH5aqw23h+94kCoK2QJXzX9RytH10ftK7AfxDFTWBgNoM01UVY3
         LI6sa/vJ+UlcHx+dFvA2DG8D3oLOc3wd2NXrj6REyaljn0yq+FR+39nFeqYkIl9tdvDd
         OwVnKiPj+eXqzmXalU/+q6JZt2+xw7m9GWvQVe2drxf0q7jgD2k5yOkBONLN8kP8ftFu
         wsyrTSiKf3TMh9LOl/DNreuBzMpfQe/Lb4bPyATICbyk0Kxb9afJOSH2+dmXPPnJYlmE
         /HnQ==
X-Gm-Message-State: APjAAAXYgD81q2RvWr5A8X8pyg8pHRuf/wQpxBR/ECSwUR6404uuOcVQ
        DLQyBUyK2GumBZs0A7zX7Ck=
X-Google-Smtp-Source: APXvYqx+9N9T2/+1wzwWwh/y89oJ9P0IE/G4zN8NafEAO+fPvr12z2A57s7nZTYhogOgeMC5M9ukpg==
X-Received: by 2002:a17:902:724c:: with SMTP id c12mr55789189pll.219.1563540237303;
        Fri, 19 Jul 2019 05:43:57 -0700 (PDT)
Received: from localhost.localdomain ([103.121.208.202])
        by smtp.gmail.com with ESMTPSA id l189sm37612530pfl.7.2019.07.19.05.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 05:43:56 -0700 (PDT)
From:   Yin Fengwei <nh26223.lmm@gmail.com>
To:     dhowells@redhat.com, gregkh@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, miklos@szeredi.hu,
        viro@zeniv.linux.org.uk, tglx@linutronix.de,
        kstewart@linuxfoundation.org
Subject: [PATCH] fs: fs_parser: avoid NULL param->string to kstrtouint
Date:   Fri, 19 Jul 2019 20:43:29 +0800
Message-Id: <20190719124329.23207-1-nh26223.lmm@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot reported general protection fault in kstrtouint:
https://lkml.org/lkml/2019/7/18/328

From the log, if the mount option is something like:
   fd,XXXXXXXXXXXXXXXXXXXX

The default parameter (which has NULL param->string) will be
passed to vfs_parse_fs_param. Finally, this NULL param->string
is passed to kstrtouint and trigger NULL pointer access.

Reported-by: syzbot+398343b7c1b1b989228d@syzkaller.appspotmail.com
Fixes: 71cbb7570a9a ("vfs: Move the subtype parameter into fuse")

Signed-off-by: Yin Fengwei <nh26223.lmm@gmail.com>
---
 fs/fs_parser.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index d13fe7d797c2..578e6880ac67 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -210,6 +210,10 @@ int fs_parse(struct fs_context *fc,
 	case fs_param_is_fd: {
 		switch (param->type) {
 		case fs_value_is_string:
+			if (result->has_value) {
+				goto bad_value;
+			}
+
 			ret = kstrtouint(param->string, 0, &result->uint_32);
 			break;
 		case fs_value_is_file:
-- 
2.17.1

