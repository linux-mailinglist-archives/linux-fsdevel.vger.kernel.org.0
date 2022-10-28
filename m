Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4AD6118D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 19:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiJ1RGa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 13:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiJ1RFZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:05:25 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B675F65;
        Fri, 28 Oct 2022 10:04:29 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 5525A218D;
        Fri, 28 Oct 2022 17:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666976508;
        bh=BmUVG6ms7j9t1XfpPFgVhAO9DJJUmMgqjadwiLxmTcw=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=BygQuWcHrtPlllKZ5K86ExroWKnBzp7tyPVA1fSldWehIIebhqr1t4xpqbY6LA5t4
         d+gQ+9ApkUIifzZ61+sWm4gaBdzDtg5325q/kkF1ynKcUHOxY4dKSX66/y7z9H0nvn
         Q6yspqKR4aM8atx8zL2McYxz3BvVOBKO9qkLyUz0=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 5336DDD;
        Fri, 28 Oct 2022 17:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666976667;
        bh=BmUVG6ms7j9t1XfpPFgVhAO9DJJUmMgqjadwiLxmTcw=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=be8RnZNLcEwCgSEyGxTN3VMSaPn1aEaicmyBZxAVejZb5/hOiuE8FHUcaTd2PVPoW
         YsGUoMcoqbi+rgmjWN5yRf7QczlRiEsNKepU9WTtackXhpl39HE79RwMkgPVpyqCAu
         dW+OnKeiRAK6IuMlpxhGQWBuGHfYeMemfa8pwrYo=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 28 Oct 2022 20:04:26 +0300
Message-ID: <721e9a74-607c-fb85-8cbf-5bfed49b266e@paragon-software.com>
Date:   Fri, 28 Oct 2022 20:04:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 06/14] fs/ntfs3: Changing locking in ntfs_rename
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <fc5957cc-a71b-cfa3-f291-cb63b23800d1@paragon-software.com>
In-Reply-To: <fc5957cc-a71b-cfa3-f291-cb63b23800d1@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In some cases we can be in deadlock
because we tried to lock the same dir.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/namei.c   | 4 ++++
  fs/ntfs3/ntfs_fs.h | 6 ++++++
  2 files changed, 10 insertions(+)

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 1af02d4f6b4d..13d6acc0747f 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -305,6 +305,8 @@ static int ntfs_rename(struct user_namespace *mnt_userns, struct inode *dir,
  
  	ni_lock_dir(dir_ni);
  	ni_lock(ni);
+	if (dir_ni != new_dir_ni)
+		ni_lock_dir2(new_dir_ni);
  
  	is_bad = false;
  	err = ni_rename(dir_ni, new_dir_ni, ni, de, new_de, &is_bad);
@@ -328,6 +330,8 @@ static int ntfs_rename(struct user_namespace *mnt_userns, struct inode *dir,
  			ntfs_sync_inode(inode);
  	}
  
+	if (dir_ni != new_dir_ni)
+		ni_unlock(new_dir_ni);
  	ni_unlock(ni);
  	ni_unlock(dir_ni);
  out:
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index c45a411f82f6..5fad93a2c3fd 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -333,6 +333,7 @@ enum ntfs_inode_mutex_lock_class {
  	NTFS_INODE_MUTEX_REPARSE,
  	NTFS_INODE_MUTEX_NORMAL,
  	NTFS_INODE_MUTEX_PARENT,
+	NTFS_INODE_MUTEX_PARENT2,
  };
  
  /*
@@ -1119,6 +1120,11 @@ static inline void ni_lock_dir(struct ntfs_inode *ni)
  	mutex_lock_nested(&ni->ni_lock, NTFS_INODE_MUTEX_PARENT);
  }
  
+static inline void ni_lock_dir2(struct ntfs_inode *ni)
+{
+	mutex_lock_nested(&ni->ni_lock, NTFS_INODE_MUTEX_PARENT2);
+}
+
  static inline void ni_unlock(struct ntfs_inode *ni)
  {
  	mutex_unlock(&ni->ni_lock);
-- 
2.37.0


