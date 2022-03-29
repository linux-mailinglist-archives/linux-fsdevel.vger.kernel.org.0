Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D94A4EA829
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 08:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbiC2G5y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 02:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbiC2G5w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 02:57:52 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB552DD69;
        Mon, 28 Mar 2022 23:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648536969; x=1680072969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QKH/8wm+bXeq4ciczY4GMtSIhBOzRDlob2ZdPvhqb18=;
  b=QJ1aJ+kyCGnPOnPGj2R3RAkZTrpR6NIYz4QXXrBLL/j7JdV6LwZBNT1Z
   DEOFHupVUi7D0SaJne+TkdXO7yhvZRa1CuHkcGZCo1EYAENhNKspNMiuv
   eoYCUoKzSgcmtxNxsXkR6/Nssd85eqYAxpjP+GRi00CvdK3aT7xXJDCNx
   CXSke7SqrIVmNr+nO7p0iLKICqUjfFMUFUpHB9h8MV6ufwb7D2KVs+/L8
   KE82GBk+B6RhfhFt4OuMQS9y+eP9dXV/UHd+sDEVhoke0TnFW/HfBB7V5
   ARpgBkPjv+BtkmrHnjzXXMdWG84RqXCQGHRqD4bKtyQ95+Go9ZyENrVYd
   w==;
X-IronPort-AV: E=Sophos;i="5.90,219,1643644800"; 
   d="scan'208";a="197429214"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2022 14:56:07 +0800
IronPort-SDR: O6Xvw4Hqq/D3Kjog71QK5yQXsFSNC53i+wu5rt6YmUZA01nLICp0F+jK9Rtn/Vj4HpqsOpGSo7
 2uBWET7uk6Tgz3q/ezLIW0gnOCLGnDlk6nhogcxGR8ZlNmNJ7YO77TDHDJ4SL9FnKXCQn4Wrpl
 cXvQUkeAJuYhjtS/VgTTb+vazs3XfVkqenbof9CojQ5qfspHxyJEl4T3sjf3JOgbEl3qG3rfUP
 muspi+p6I0WxnarkboAazjZZfqyF2lJxh85Gv0FHnxZL2g4tT42EZCq3IjsqIvSh5sMRmeS8hn
 BEHDMcrNqa/yhfVu03mP2I+X
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Mar 2022 23:27:51 -0700
IronPort-SDR: 3BK7FG6rkbvLcD9T+0gxIeqTXfbUunRklBsG7fmu3Mw8K8+8sJwN086jlF7ZQkYtvDyRMXoeVE
 9cneGMkRRUfrtGROrRWLBsz1jtR4dqNdFZpFwO2LAUyzrz5/bSqP3jlNGcHfuWqdn499awAls9
 3wOk0P2ujkarI4mhx3eJM36g4F/dMWS3JhZalIg3oFQK5cV/Ry+BE3YkOVNhzVPZ/HhSnS2Tok
 W59PjmqQIFX8tVE91Ik6FY4v3ChxTirANyUL9wsZNrHRpJcZ0/UY44rqTk7xITLSvaFrSNnHHa
 66s=
WDCIronportException: Internal
Received: from 2zx6353.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.64])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Mar 2022 23:56:06 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v4 1/3] btrfs: mark resumed async balance as writing
Date:   Tue, 29 Mar 2022 15:55:58 +0900
Message-Id: <b3f742cf33d091f2c5a224c501515debb49e90b0.1648535838.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648535838.git.naohiro.aota@wdc.com>
References: <cover.1648535838.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When btrfs balance is interrupted with umount, the background balance
resumes on the next mount. There is a potential deadlock with FS freezing
here like as described in commit 26559780b953 ("btrfs: zoned: mark
relocation as writing"). Mark the process as sb_writing to avoid it.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Cc: stable@vger.kernel.org # 4.9+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3fd17e87815a..3471698fd831 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4430,10 +4430,12 @@ static int balance_kthread(void *data)
 	struct btrfs_fs_info *fs_info = data;
 	int ret = 0;
 
+	sb_start_write(fs_info->sb);
 	mutex_lock(&fs_info->balance_mutex);
 	if (fs_info->balance_ctl)
 		ret = btrfs_balance(fs_info, fs_info->balance_ctl, NULL);
 	mutex_unlock(&fs_info->balance_mutex);
+	sb_end_write(fs_info->sb);
 
 	return ret;
 }
-- 
2.35.1

