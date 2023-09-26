Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D772E7AE9B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 11:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbjIZJ4s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 05:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjIZJ4q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:56:46 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31CBBE;
        Tue, 26 Sep 2023 02:56:39 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id BC5B521BC;
        Tue, 26 Sep 2023 09:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1695721847;
        bh=M2FK5gsLtmNBcSaysRw/Y++y3lLBnCCRyRI6dXE7TkE=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=XHUt8KfYdRnPQjP75T3mvqKkT0lKFp8HuLuslcCVkw0uxFL6JlAkifzksCkkJ+n6b
         fGCHjdm03L0Nyu6du7YjamOBFvCO3Xq2r9hGvMnVe3dtDl+oQDaQN6PD6h+sPHeEtO
         +153iHrxH+T8LNfgdd1PmaaaOziZj5/1Qrq1wvtA=
Received: from [172.16.192.129] (192.168.211.137) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 26 Sep 2023 12:56:37 +0300
Message-ID: <0b667ec4-8223-407b-9303-94b70dfa5101@paragon-software.com>
Date:   Tue, 26 Sep 2023 12:56:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 5/8] fs/ntfs3: Add more info into /proc/fs/ntfs3/<dev>/volinfo
Content-Language: en-US
From:   Konstantin Komarovc <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <7c217d7d-6ee4-4603-b5f1-ebe7b68cf430@paragon-software.com>
In-Reply-To: <7c217d7d-6ee4-4603-b5f1-ebe7b68cf430@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.137]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/super.c | 14 +++++++++++---
  1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index f9a214367113..5811da7e9d45 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -453,15 +453,23 @@ static struct proc_dir_entry *proc_info_root;
   * ntfs3.1
   * cluster size
   * number of clusters
+ * total number of mft records
+ * number of used mft records ~= number of files + folders
+ * real state of ntfs "dirty"/"clean"
+ * current state of ntfs "dirty"/"clean"
  */
  static int ntfs3_volinfo(struct seq_file *m, void *o)
  {
      struct super_block *sb = m->private;
      struct ntfs_sb_info *sbi = sb->s_fs_info;

-    seq_printf(m, "ntfs%d.%d\n%u\n%zu\n", sbi->volume.major_ver,
-           sbi->volume.minor_ver, sbi->cluster_size,
-           sbi->used.bitmap.nbits);
+    seq_printf(m, "ntfs%d.%d\n%u\n%zu\n\%zu\n%zu\n%s\n%s\n",
+           sbi->volume.major_ver, sbi->volume.minor_ver,
+           sbi->cluster_size, sbi->used.bitmap.nbits,
+           sbi->mft.bitmap.nbits,
+           sbi->mft.bitmap.nbits - wnd_zeroes(&sbi->mft.bitmap),
+           sbi->volume.real_dirty ? "dirty" : "clean",
+           (sbi->volume.flags & VOLUME_FLAG_DIRTY) ? "dirty" : "clean");

      return 0;
  }
-- 
2.34.1

