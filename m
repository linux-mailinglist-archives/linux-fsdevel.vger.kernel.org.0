Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4114B85C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 14:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbfFSMar (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 08:30:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36839 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731897AbfFSMaq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:30:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id u8so1658916wmm.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2019 05:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z4INWegdUTe8Q6ns0c8f39S93Wy18nSWojE+tUkgp2w=;
        b=HljfZpVwWxhCDBpZjDGkJ6tUj8ficPRpAv2P6HSKZX9ihBKfij1qlWOqVUEN8j+pw1
         T+vYVWIBL/HwLRqzamnDmJRdk8VM9jSJHMBKPnwZodE7g5HEuNUqctwvIAOT2PR0WY3J
         H8Ee3Zcspyb5GJ8G1YNMHuWFmH804MWH8MRyNB1fbRvly5K9FpHoK9pbfmF0zY2e9p2Y
         K8/1YX/tnZNeDA7HvDs0DD9pwQi4FfxntHSNfPwpFYt/Tv43uYr5SKXAngRrwtPy2EAc
         m1w3VrNjbyFkmNz9+kzmLeXAjomU/oDoaL/f1FCIJ1ndCVMYcyTqNnYVu+mWR7DdiNk6
         4JGw==
X-Gm-Message-State: APjAAAVqTAJ+eEyxAgXQjaiFbWt/7vWAVFrwjSt8DxUbxPS46bFoVmIt
        rq1IdOq0qzkb1/dYCYWvY7KcfBj3mpw=
X-Google-Smtp-Source: APXvYqwjHs6lmB/m746hPFbtEy06SjhOEIMC6yffNLPHqQEgXE5XeQUFxlR0BzlXmc26vAqECvSlhg==
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr7804571wmk.99.1560947444548;
        Wed, 19 Jun 2019 05:30:44 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:43 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] fusectl: don't ignore options
Date:   Wed, 19 Jun 2019 14:30:18 +0200
Message-Id: <20190619123019.30032-12-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619123019.30032-1-mszeredi@redhat.com>
References: <20190619123019.30032-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The options "sync", "async", "dirsync", "lazytime", "nolazytime", "mand"
and "nomand" make no sense for the fusectl filesystem.  If these options
are supplied to fsconfig(FSCONFIG_SET_FLAG), then return -EINVAL instead of
silently ignoring the option.

Any implementation, such as mount(8) that needs to parse this option
without failing should simply ignore the return value from fsconfig().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index c35013ed7f65..f3aab288929f 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -351,7 +351,7 @@ static int fuse_ctl_get_tree(struct fs_context *fc)
 
 static const struct fs_context_operations fuse_ctl_context_ops = {
 	.get_tree	= fuse_ctl_get_tree,
-	.parse_param	= vfs_parse_fs_param,
+	.parse_param	= vfs_parse_ro_rw,
 };
 
 static int fuse_ctl_init_fs_context(struct fs_context *fc)
-- 
2.21.0

