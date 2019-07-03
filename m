Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEA425E471
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 14:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfGCMsh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jul 2019 08:48:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38585 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbfGCMrb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jul 2019 08:47:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so2254366wmj.3;
        Wed, 03 Jul 2019 05:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=34BvfGgISONnsOeh6LA1EfvEoJF1pB0OtD1tUFoABIY=;
        b=Zj7UGvBLfC6yTB5Gy9eKUFK4/FokpCeq4rsKDYgRDe54B8HOHzYIyxJ64uFiDQbtGe
         dcymEX/OZ6UxckhsV0b+crR0nUn36wTE+Nv796dA6bjUx2vZ6sYWv8tDd1jR20vjkc/E
         axfrDwffhX5EBlB97SlhsrG4ZiFWR5FA+HDb393ZrxDa6RifAc/eJepqKP/wXmu2vzgs
         OYgSsKz6+0lKebUAHeQcH2lQ9xxZeLqJyHXk8w83aKszArAwC3b5GMCLtI4/PhKVlzi0
         f7Z/iIPiIQgFkOYfQBg30MfEHsl2FgLmGofNPispLjwALIn7vwiuMtfBGPfrc7lxhjN7
         TtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=34BvfGgISONnsOeh6LA1EfvEoJF1pB0OtD1tUFoABIY=;
        b=aV3Ju7Ci0hz7Dkds9DMSpbYU8QlriyHGTIJ5dB1NLbK/HfVkA2LW5SGrtbIe8nhly1
         ITTYuDK1O2Rq6AfCAADVg3e29ehOMxkZQj9ctM4zwEHPtD8prVbAeItxz3aNdy+IRm1Y
         Sx6So0yAt6iofofJRPD6sSghXy7839nsXhqLviik74MMMAeoaaFSQ2UYdsXzseTaCOYf
         0JgJSFCIgwSg8QaVE5WlgTZosxo8bQx2QVGM70wjs8aZdf/3gikehLGfOvTQJbUv6Cwl
         JG3gBV2T5OtUSZCvcH+DCVn5wmhJHql/ysBocZJHXrg3nunBmR6841+nsS7QbEuORfkg
         esrw==
X-Gm-Message-State: APjAAAWqgyjhMIeH0NDCTK+crisDSBht2bF4RGSbY1P6Bh8ZX3HkF7zm
        /ZmjU+7bvwSuxubmBEnkEQfq+VUJWpM=
X-Google-Smtp-Source: APXvYqwY7iiZHXXifbUaGvDuBuT5SumvNPFuqW5mfuxQMgeVm6A6avgkZV86OlBxMZJEk3yqS5+mew==
X-Received: by 2002:a7b:cd9a:: with SMTP id y26mr8435877wmj.44.1562158049430;
        Wed, 03 Jul 2019 05:47:29 -0700 (PDT)
Received: from heron.blarg.de (p200300DC6F443A000000000000000FD2.dip0.t-ipconnect.de. [2003:dc:6f44:3a00::fd2])
        by smtp.gmail.com with ESMTPSA id o24sm5480588wmh.2.2019.07.03.05.47.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 05:47:28 -0700 (PDT)
From:   Max Kellermann <max.kellermann@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        trond.myklebust@hammerspace.com, bfields@redhat.com,
        gregkh@linuxfoundation.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, hughd@google.com,
        anna.schumaker@netapp.com
Cc:     linux-kernel@vger.kernel.org,
        Max Kellermann <max.kellermann@gmail.com>
Subject: [PATCH 3/4] linux/fs.h: fix umask on NFS with CONFIG_FS_POSIX_ACL=n
Date:   Wed,  3 Jul 2019 14:47:14 +0200
Message-Id: <20190703124715.4319-3-max.kellermann@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703124715.4319-1-max.kellermann@gmail.com>
References: <20190703124715.4319-1-max.kellermann@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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

Signed-off-by: Max Kellermann <max.kellermann@gmail.com>
---
 include/linux/fs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index dd28e7679089..299acdaaab56 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1985,7 +1985,12 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
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
2.20.1

