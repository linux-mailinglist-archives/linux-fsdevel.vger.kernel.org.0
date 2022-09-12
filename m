Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA525B5E6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 18:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiILQks (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 12:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiILQkq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 12:40:46 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A33C25C6B;
        Mon, 12 Sep 2022 09:40:45 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 122C32265;
        Mon, 12 Sep 2022 16:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1663000724;
        bh=/ZtGhq6EJuhIvLQh59RiN21gsyK9NnlVonHDvDAOoGY=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=r9NH0yXlHfBsMAc42IRDXyiaFVIBeKMdDBRfbpM7mPPPQ5btS1rMDflXCQLXM7IGj
         oya1oXts+jf1QJYEvwW3XHiXl86Fmm9J7NFReA6WERFhqKaZT/btyhpeqbOEdrXgTD
         8kQgMpaOYUxTKPBSxpEcYJjKwcgeaMxz2jzsW95I=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id A78F522FE;
        Mon, 12 Sep 2022 16:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1663000843;
        bh=/ZtGhq6EJuhIvLQh59RiN21gsyK9NnlVonHDvDAOoGY=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=DIM0XMkCn5bWwJMSEOYlV5cj26bWWtJduJYTNvgNFXBpFfEW5Urz2J8mSQkmIgjox
         BuVUHDTuOiQ8lSjNNbOBvIQofPILnXTckKaYLC9rSByjRSlekX94VQgeSYPy6yi+9S
         BUKq28S05qTcBHc07rhcnI+Cw5YHuM555oJ7aXpY=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 12 Sep 2022 19:40:43 +0300
Message-ID: <b1dbef1a-d52e-5096-c179-fde8c5f0f2b2@paragon-software.com>
Date:   Mon, 12 Sep 2022 19:40:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 3/3] fs/ntfs3: Change destroy_inode to free_inode
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <59960918-0adb-6d53-2d77-8172e666bf40@paragon-software.com>
In-Reply-To: <59960918-0adb-6d53-2d77-8172e666bf40@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Many filesystems already use free_inode callback,
so we will use it too from now on.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/super.c | 20 ++++----------------
  1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 067a0e9cf590..744c1f15ba2a 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -438,27 +438,18 @@ static struct inode *ntfs_alloc_inode(struct super_block *sb)
  		return NULL;
  
  	memset(ni, 0, offsetof(struct ntfs_inode, vfs_inode));
-
  	mutex_init(&ni->ni_lock);
-
  	return &ni->vfs_inode;
  }
  
-static void ntfs_i_callback(struct rcu_head *head)
+static void ntfs_free_inode(struct inode *inode)
  {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
  	struct ntfs_inode *ni = ntfs_i(inode);
  
  	mutex_destroy(&ni->ni_lock);
-
  	kmem_cache_free(ntfs_inode_cachep, ni);
  }
  
-static void ntfs_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, ntfs_i_callback);
-}
-
  static void init_once(void *foo)
  {
  	struct ntfs_inode *ni = foo;
@@ -624,7 +615,7 @@ static int ntfs_sync_fs(struct super_block *sb, int wait)
  
  static const struct super_operations ntfs_sops = {
  	.alloc_inode = ntfs_alloc_inode,
-	.destroy_inode = ntfs_destroy_inode,
+	.free_inode = ntfs_free_inode,
  	.evict_inode = ntfs_evict_inode,
  	.put_super = ntfs_put_super,
  	.statfs = ntfs_statfs,
@@ -1520,11 +1511,8 @@ static int __init init_ntfs_fs(void)
  
  static void __exit exit_ntfs_fs(void)
  {
-	if (ntfs_inode_cachep) {
-		rcu_barrier();
-		kmem_cache_destroy(ntfs_inode_cachep);
-	}
-
+	rcu_barrier();
+	kmem_cache_destroy(ntfs_inode_cachep);
  	unregister_filesystem(&ntfs_fs_type);
  	ntfs3_exit_bitmap();
  }
-- 
2.37.0


