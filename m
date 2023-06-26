Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4D073E5B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 18:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjFZQr7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 12:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFZQr6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:47:58 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119B583
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 09:47:56 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51d9128494cso1697541a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 09:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1687798074; x=1690390074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A/nUDlqt951lKsKkZgydvbd14iydf4nHrE0dUZUBvRw=;
        b=YWsvvtIBa6fa44eN1VmuC/broBdRFbDtLYl8CO7rqAcvHYrR7tUmJUQUrS4j/39x2d
         CUoZCznWtf3qjSbO9plXJDIzeomk2BI0jmGA99MF8TMs9KPCrc5uSXK0vrczxoNhOPHd
         d0hMhkGlXMZkArgsPLPIMjo+90/Ugiv/uz4mqaf6TpkBxpq2reFn/mYIBfmrxMwq4v3M
         cUlbEPG5gCe7GxewogMCSRh/b11LmDFmC/6FZyd47PIl8PvKE8LhDIOYG4v8npbFuDS4
         GUtN15Iu5szeLpekMDPx/ELJlrtcXDlIxcNMgfhqhL7GPs939gXzW2beKymd/Mh3t7lv
         /8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687798074; x=1690390074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/nUDlqt951lKsKkZgydvbd14iydf4nHrE0dUZUBvRw=;
        b=TOQ6S5gUhMtXRQsrD6zJQ93LbEfJsm0dg2VWQjDWLFem9ZZhnq9VU9ypsobxJrxSqk
         8ciRVI7D/1XkEo6Pb9LTpDGJ+AAhBTM1jhZpns7Y9JbNKKQD9SRlFbb8tt4IYZPMRi9c
         GSV76ed2Sba4xRYol6WPcmVtIS9lx/h4N4j1l+vW5IEA5+kBV68X5OgB/1c4RUt+gbtv
         1i0VGe4TWXbHcw94quPD7/pc09uaa0+6gUJ8B+ECxnSWwP9ll9983KGJX2LKKM5FQvCN
         w9ws25yTCeShC9irLbthmAj2XVz9EXg/CDdqFwXtCmTK5RI4YLqcOZElCUuUj+pr/HXi
         AqHA==
X-Gm-Message-State: AC+VfDx6HNyC+1qbbpP9zxfn4PYYBEMKlAWq8cPLfiBHPR1qDw+s29Wn
        W68SDthPk6luxWhVz3gxOHlg1w==
X-Google-Smtp-Source: ACHHUZ6gSGBGgxjP0GUuHbZ7aLJqeF9tjkoj3TTxlmNbkpOWV1Si67AXKtgCDkOQTKru2nEkemxiYg==
X-Received: by 2002:a05:6402:358:b0:51d:9db4:8201 with SMTP id r24-20020a056402035800b0051d9db48201mr1902333edw.7.1687798074413;
        Mon, 26 Jun 2023 09:47:54 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id s25-20020aa7c559000000b0051d914a9f49sm2305579edr.65.2023.06.26.09.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:47:53 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org (open list:ZONEFS FILESYSTEM),
        gost.dev@samsung.com, Andreas Hindborg <a.hindborg@samsung.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
Subject: [PATCH] zonefs: do not use append if device does not support it
Date:   Mon, 26 Jun 2023 18:47:52 +0200
Message-ID: <20230626164752.1098394-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>

Zonefs will try to use `zonefs_file_dio_append()` for direct sync writes even if
device `max_zone_append_sectors` is zero. This will cause the IO to fail as the
io vector is truncated to zero. It also causes a call to
`invalidate_inode_pages2_range()` with end set to UINT_MAX, which is probably
not intentional. Thus, do not use append when device does not support it.

Signed-off-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>
---
 fs/zonefs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 132f01d3461f..c97fe2aa20b0 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -536,9 +536,11 @@ static ssize_t zonefs_write_checks(struct kiocb *iocb, struct iov_iter *from)
 static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
+	struct block_device *bdev = inode->i_sb->s_bdev;
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	struct zonefs_zone *z = zonefs_inode_zone(inode);
 	struct super_block *sb = inode->i_sb;
+	unsigned int max_append = bdev_max_zone_append_sectors(bdev);
 	bool sync = is_sync_kiocb(iocb);
 	bool append = false;
 	ssize_t ret, count;
@@ -581,7 +583,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 		append = sync;
 	}
 
-	if (append) {
+	if (append && max_append) {
 		ret = zonefs_file_dio_append(iocb, from);
 	} else {
 		/*

base-commit: 45a3e24f65e90a047bef86f927ebdc4c710edaa1
-- 
2.41.0

