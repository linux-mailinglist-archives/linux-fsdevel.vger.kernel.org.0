Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1A474560F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 09:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjGCH2B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 03:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjGCH17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:27:59 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A58E58;
        Mon,  3 Jul 2023 00:27:55 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 3066D1D21;
        Mon,  3 Jul 2023 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1688368962;
        bh=q5eMVDMl8OohS/5+a1OTXjwPDE7CVMtEf2hDSqPpYdc=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=RjkVAo7NwjKBmWEMvIlJsB79izFMwGHGw2m5t2MLac2t2fLRc9GuLr0ri2b88NDIf
         hH8hwrRf88DIOVYe57oacRxXKLbO4OITZPNsbEmre3dkirQEhKAP3ewdj6gXk1mvGs
         1W4Yk/9Wnnl1BzrR4wVnCieGQvtG1qTiiZLXRwIg=
Received: from [192.168.211.138] (192.168.211.138) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 3 Jul 2023 10:27:53 +0300
Message-ID: <23596b4e-1a38-d944-3bba-de7d528c7bf6@paragon-software.com>
Date:   Mon, 3 Jul 2023 11:27:52 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: [PATCH 7/8] fs/ntfs3: fix deadlock in mark_as_free_ex
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <e41f6717-7c70-edf2-2d3a-8034840d14c5@paragon-software.com>
In-Reply-To: <e41f6717-7c70-edf2-2d3a-8034840d14c5@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.138]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Reported-by: syzbot+e94d98936a0ed08bde43@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/fsntfs.c | 6 +++++-
  1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index edb51dc12f65..fbfe21dbb425 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -2454,10 +2454,12 @@ void mark_as_free_ex(struct ntfs_sb_info *sbi, 
CLST lcn, CLST len, bool trim)
  {
      CLST end, i, zone_len, zlen;
      struct wnd_bitmap *wnd = &sbi->used.bitmap;
+    bool dirty = false;

      down_write_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
      if (!wnd_is_used(wnd, lcn, len)) {
-        ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+        /* mark volume as dirty out of wnd->rw_lock */
+        dirty = true;

          end = lcn + len;
          len = 0;
@@ -2511,6 +2513,8 @@ void mark_as_free_ex(struct ntfs_sb_info *sbi, 
CLST lcn, CLST len, bool trim)

  out:
      up_write(&wnd->rw_lock);
+    if (dirty)
+        ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
  }

  /*
-- 
2.34.1


