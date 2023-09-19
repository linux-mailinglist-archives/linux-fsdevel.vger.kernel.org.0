Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35497A5C52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 10:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjISISy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 04:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjISISs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:18:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2E9129
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 01:18:42 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32001d16a14so2591273f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 01:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695111520; x=1695716320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S4D5C4k+i1eZNnOt391w1UuQt6K8OH0zFNJfwEYdVWU=;
        b=WobcBBhesTQqSlnbhexk2H1g4bS1LGtSdk3OQrg9ZNUcizwt5Cov1yiEqYDtrULg5A
         r6gy7DzGAjdDOslkSEQ3/aKkIrj4fBMRsffOPF3cLSQrQoUrTJlAcbIJYZvpIZmvnOj8
         KtKV7Sd745CgU9RvivoKxsVGC3/iA7K0NfLNPTW3ZNRxr9101Q3+DZetFpF3XwKJNRga
         A1dGZhEXVcGfORsjN7d5y5+2VhFA4WshraOUNugNFP6moZLYniy46n7EnWuF0MSCXeRl
         rv3YQY7HmeVGYAvs5IWqWWpFD/52ZPoYBIgW3mSnUgTZXjj8bxuVKyWbICem1/QrbXDn
         l7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695111520; x=1695716320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S4D5C4k+i1eZNnOt391w1UuQt6K8OH0zFNJfwEYdVWU=;
        b=LvMxxKLJHJWyQhNK5SWuhXk2Qsmd88SMhuQgB/52kiOcPMgJmyYmamAliM8Il/4MOP
         iAZtttSPvhOb5L1UXgOJ5XczzbkBCnuN9QV4cCcUG/ZKTTpYng2Mn0eWAZOw7PdFqzbs
         EhID5n78zNzoXPItcMAKFc9JT+JX2w78B4ghy7eTZ+yAheqIZCwrFMQS7duA+lEfBndp
         UFZJcZpzi07DQ3SwyPbg1J6srs26ngaWjy1SjYYgN2AQFILbTmo+ZKlT0hhD1TXOrBXt
         9zb2OjF1fzyXCLSg6xFrZTefY+SFo+vGfsqlm82kMMQCHsPdHZDaC/AjWvsoomPetKQp
         QX2w==
X-Gm-Message-State: AOJu0YwPsWimAGB879xo0y+5cStrVMqLXkWV7cMSU0lK10AoFhXO2zR7
        MgzOwdeYG67JHAPUO4VFLKHv3bQf9eOgdMGcTmWKlw==
X-Google-Smtp-Source: AGHT+IFgGC81/nJ2d++KHzxJtc6SLDcCl27ekDZ3S/J8hiT6jN1P+ZI78aDTSEFf1H1SXmXg9JaVCQ==
X-Received: by 2002:a5d:66c3:0:b0:317:c2a9:9b0c with SMTP id k3-20020a5d66c3000000b00317c2a99b0cmr9403458wrw.50.1695111520707;
        Tue, 19 Sep 2023 01:18:40 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f209c00529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f20:9c00:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id f7-20020adff987000000b0031c8a43712asm14783219wrr.69.2023.09.19.01.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 01:18:39 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        "J . Bruce Fields" <bfields@redhat.com>, Jan Kara <jack@suse.cz>,
        stable@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] linux/fs.h: fix umask on NFS with CONFIG_FS_POSIX_ACL=n
Date:   Tue, 19 Sep 2023 10:18:36 +0200
Message-Id: <20230919081837.1096695-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make IS_POSIXACL() return false if POSIX ACL support is disabled and
ignore SB_POSIXACL/MS_POSIXACL.

Never skip applying the umask in namei.c and never bother to do any
ACL specific checks if the filesystem falsely indicates it has ACLs
enabled when the feature is completely disabled in the kernel.

This fixes a problem where the umask is always ignored in the NFS
client when compiled without CONFIG_FS_POSIX_ACL.  This is a 4 year
old regression caused by commit 013cdf1088d723 which itself was not
completely wrong, but failed to consider all the side effects by
misdesigned VFS code.

Prior to that commit, there were two places where the umask could be
applied, for example when creating a directory:

 1. in the VFS layer in SYSCALL_DEFINE3(mkdirat), but only if
    !IS_POSIXACL()

 2. again (unconditionally) in nfs3_proc_mkdir()

The first one does not apply, because even without
CONFIG_FS_POSIX_ACL, the NFS client sets MS_POSIXACL in
nfs_fill_super().

After that commit, (2.) was replaced by:

 2b. in posix_acl_create(), called by nfs3_proc_mkdir()

There's one branch in posix_acl_create() which applies the umask;
however, without CONFIG_FS_POSIX_ACL, posix_acl_create() is an empty
dummy function which does not apply the umask.

The approach chosen by this patch is to make IS_POSIXACL() always
return false when POSIX ACL support is disabled, so the umask always
gets applied by the VFS layer.  This is consistent with the (regular)
behavior of posix_acl_create(): that function returns early if
IS_POSIXACL() is false, before applying the umask.

Therefore, posix_acl_create() is responsible for applying the umask if
there is ACL support enabled in the file system (SB_POSIXACL), and the
VFS layer is responsible for all other cases (no SB_POSIXACL or no
CONFIG_FS_POSIX_ACL).

Reviewed-by: J. Bruce Fields <bfields@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/fs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4aeb3fa11927..c1a4bc5c2e95 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2110,7 +2110,12 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
 #define IS_NOQUOTA(inode)	((inode)->i_flags & S_NOQUOTA)
 #define IS_APPEND(inode)	((inode)->i_flags & S_APPEND)
 #define IS_IMMUTABLE(inode)	((inode)->i_flags & S_IMMUTABLE)
+
+#ifdef CONFIG_FS_POSIX_ACL
 #define IS_POSIXACL(inode)	__IS_FLG(inode, SB_POSIXACL)
+#else
+#define IS_POSIXACL(inode)	0
+#endif
 
 #define IS_DEADDIR(inode)	((inode)->i_flags & S_DEAD)
 #define IS_NOCMTIME(inode)	((inode)->i_flags & S_NOCMTIME)
-- 
2.39.2

