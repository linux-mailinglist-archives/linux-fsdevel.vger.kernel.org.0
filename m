Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AB63764A4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 May 2021 13:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbhEGLnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 May 2021 07:43:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33224 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235085AbhEGLnA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 May 2021 07:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620387720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0zmbYpIxO+tqIx9tDKPAbmZ+lvrUpQZvE1lV/asn3qo=;
        b=fwTJmyRYn1rHv1fIlUXUfaZG88TysBdfAtwDirZA8Yjj55GLwxJVc1HhHTNhadEyqMLLHT
        fitYo6F6qTRKT4NtKzSchSfQSvCONBpJOS3SBDBy4iIIMkmIBdbvfV0Q2fyxKyHjhX9KKf
        D536NtCHerfzw32HR2jgPFt2YQZu1yM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-K6H55XBXPMS0V_U0n7XenQ-1; Fri, 07 May 2021 07:41:56 -0400
X-MC-Unique: K6H55XBXPMS0V_U0n7XenQ-1
Received: by mail-ed1-f69.google.com with SMTP id g17-20020aa7dd910000b029038843570b67so4304493edv.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 May 2021 04:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0zmbYpIxO+tqIx9tDKPAbmZ+lvrUpQZvE1lV/asn3qo=;
        b=eQMM6fFnRB0hTO8DnphLstHW3RQ7+DQNt+vLcme3OSrtxNFya+L4yMpYnHd2NbxWmk
         2ciRHRau3zSq6AanPx3vEbnMk0rrkTaaNbxyf2BwUj4EsyRBZRrK6I8ppCkckv6GpRu8
         1yiMcbQwUbNnEFrPVrMvtqVBJA+C/wucA2elAWPrcEtP4MaM5M39Y0UpuXZz+Z/r6el/
         Mz7lLXjom+s7UlpxO60YOYqeWmIH83e98pp2GGJKU5DakqqUr95lYuPmwwxFtcNakeYZ
         Rg+UjnYWV0FPXA5n7yYk179ZLuEcrEDIgYiX0puyPfyROp8Apv46PmvKBBjt4zkro2ol
         Lr6A==
X-Gm-Message-State: AOAM532pvHZ3brlFaWa0xTVE4MOitVnBOYxgn8ezy6JWlrkPSofijF/o
        etzdTBYhLWCumbOvSdUPnz01eFE8OXIb26ysn5mMca6lang4m64DtnLI+tOuGPx6hGTulzhU6O3
        zxaEDbCaw5uRWj0XuP5qoh1LhlQ==
X-Received: by 2002:a17:906:a2d1:: with SMTP id by17mr10007698ejb.426.1620387715167;
        Fri, 07 May 2021 04:41:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxe+4tEBSZQpT+iheN+fbqzfk3Ilvhkxits1eJbgq0XcZH2UeBxRoLPxQpaOHsaIcs/iRz58w==
X-Received: by 2002:a17:906:a2d1:: with SMTP id by17mr10007682ejb.426.1620387715042;
        Fri, 07 May 2021 04:41:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id v19sm3356083ejy.78.2021.05.07.04.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 04:41:54 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] debugfs: fix security_locked_down() call for SELinux
Date:   Fri,  7 May 2021 13:41:50 +0200
Message-Id: <20210507114150.139102-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make sure that security_locked_down() is checked last so that a bogus
denial is not reported by SELinux when (ia->ia_valid & (ATTR_MODE |
ATTR_UID | ATTR_GID)) is zero.

Note: this was introduced by commit 5496197f9b08 ("debugfs: Restrict
debugfs when the kernel is locked down"), but it didn't matter at that
time, as the SELinux support came in later.

Fixes: 59438b46471a ("security,lockdown,selinux: implement SELinux lockdown")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/debugfs/inode.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 22e86ae4dd5a..bbfc7898c1aa 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -45,10 +45,13 @@ static unsigned int debugfs_allow = DEFAULT_DEBUGFS_ALLOW_BITS;
 static int debugfs_setattr(struct user_namespace *mnt_userns,
 			   struct dentry *dentry, struct iattr *ia)
 {
-	int ret = security_locked_down(LOCKDOWN_DEBUGFS);
+	int ret;
 
-	if (ret && (ia->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)))
-		return ret;
+	if (ia->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)) {
+		ret = security_locked_down(LOCKDOWN_DEBUGFS);
+		if (ret)
+			return ret;
+	}
 	return simple_setattr(&init_user_ns, dentry, ia);
 }
 
-- 
2.31.1

