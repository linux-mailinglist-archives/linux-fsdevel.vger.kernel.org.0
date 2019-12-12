Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4C6311D03A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 15:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfLLOuw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 09:50:52 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56579 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728869AbfLLOuv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:50:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576162249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7XQ0BIDQs1rSkgFn546VmoxkIOFu9sf2QvSDRqt2+UU=;
        b=B/33Gkx3n2PBSDIjZPCJsE19bDgw9ucxec46c4+sFrmS7PthnFgnwOU5Hbw2wXd1yz04J9
        uP5zZINtnje/cm1TpuWeJEET5Hk+QxPNWpOYAZhO5uD19fNLMuXNAehuLj9Dvq8IB1UeK+
        pHEmF0gUd24arpyoXjnv2Wnhw8ir0D4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-jnbYDJ_JOBu_QjAMMKd8Pg-1; Thu, 12 Dec 2019 09:50:46 -0500
X-MC-Unique: jnbYDJ_JOBu_QjAMMKd8Pg-1
Received: by mail-qk1-f199.google.com with SMTP id 143so1519107qkg.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 06:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7XQ0BIDQs1rSkgFn546VmoxkIOFu9sf2QvSDRqt2+UU=;
        b=eIwJX/1k89Zx5OSbwJoUaDsnq7V9bDf/h7J2NOzTYfngfWeIfzCXjvtrP2+thOFWwZ
         LmOIAJXflRoeR77qoJ3c2dx64AoWoRy6+g7m1YjIhVAwL113Rbe+PmjPfUNzkvrfgVr/
         HOo8OkXLRSWJpAG2nzCifYirl4Kt/v6KzAydq55aAQal98ABmeobmljderVwjuj3uQ8k
         3X8YVg58ZO1H+n3aS/4XqMEDGplMbTpDiW4kDN8YeX2j7h34A4TfKEFnCs786e5eXqaU
         4pkeA+jlJH2BE8Zt3cegIepAWJ/9MwWzQcBJKYXIE8PLWK1qB4hTsiSQU4jfMuyAGgKP
         a5iQ==
X-Gm-Message-State: APjAAAUze+JvJd6XqXw7mwBAxryUfo6KIirBtur/W/+y+jcsRF9MWyND
        KgipvTMx6z0i5G9LaTV9MWsMSQi+xiirnSIuwOQ0Bo0+uPPJjRO3EcOSY914XGcogLe5XlVC3JP
        07BKM8z7VUjNP0PTcFEDXvb4Tmg==
X-Received: by 2002:ac8:7417:: with SMTP id p23mr7598792qtq.313.1576162246356;
        Thu, 12 Dec 2019 06:50:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqxOQuw5KzIzEEpY1tkirep65v+/e3rmTOxoGFv8KpZEJqgnBlMHg1taBK8FFNx2bZg0I/q0jg==
X-Received: by 2002:ac8:7417:: with SMTP id p23mr7598772qtq.313.1576162246140;
        Thu, 12 Dec 2019 06:50:46 -0800 (PST)
Received: from labbott-redhat.redhat.com (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id 201sm1823298qkf.10.2019.12.12.06.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 06:50:45 -0800 (PST)
From:   Laura Abbott <labbott@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vfs: Don't reject unknown parameters
Date:   Thu, 12 Dec 2019 09:50:42 -0500
Message-Id: <20191212145042.12694-1-labbott@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The new mount API currently rejects unknown parameters if the
filesystem doesn't have doesn't take any arguments. This is
unfortunately a regression from the old API which silently
ignores extra arguments. This is easly seen with the squashfs
conversion (5a2be1288b51 ("vfs: Convert squashfs to use the new
mount API")) which now fails to mount with extra options. Just
get rid of the error.

Fixes: 3e1aeb00e6d1 ("vfs: Implement a filesystem superblock
creation/configuration context")
Link: https://lore.kernel.org/lkml/20191130181548.GA28459@gentoo-tp.home/
Reported-by: Jeremi Piotrowski <jeremi.piotrowski@gmail.com>
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1781863
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 fs/fs_context.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 138b5b4d621d..7ec20b1f8a53 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -160,8 +160,7 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
 		return 0;
 	}
 
-	return invalf(fc, "%s: Unknown parameter '%s'",
-		      fc->fs_type->name, param->key);
+	return 0;
 }
 EXPORT_SYMBOL(vfs_parse_fs_param);
 
-- 
2.21.0

