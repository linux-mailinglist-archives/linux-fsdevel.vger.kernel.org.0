Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86AF776BBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 00:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjHIWF6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 18:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjHIWFz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:05:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EBAFE;
        Wed,  9 Aug 2023 15:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NG0deoyFL0ke8Z5Qg+U8RKnDclzET8PRtBjAbxGF/fk=; b=qYTrKNo7cgWFz/O2x38dyij4DD
        JTmngKvtHymeSD1p24fgXqVd2Pb8qdw6gB/vfLCBoFQ/DdNl4HtA+oGb47+ipAX618h5qfpDT1ED6
        AaHimsZreLHaposQlYLTw9Mg+tCISvyRlHAZ0/dYv8BCwOB8T8LKIokYAb9Fy+v2fDcQOnfbqqS+f
        ydKC0Oqm5akuBWAGidJx2kjINy5lvy1l9PwiBhWSAV4wSoSXveMOkPXxgv4N7c3PhtmYK2wPkDCDE
        ZQGFxkXTrXIxoGd8cxPNCMdYuNeJu1/JRjyF9YC89G9u2BZMQCGIacGlIzckGdf5/uJ/b2FYqLGqD
        VWAXjAbA==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTrJL-005xnz-0G;
        Wed, 09 Aug 2023 22:05:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: [PATCH 02/13] xfs: remove a superfluous s_fs_info NULL check in xfs_fs_put_super
Date:   Wed,  9 Aug 2023 15:05:34 -0700
Message-Id: <20230809220545.1308228-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230809220545.1308228-1-hch@lst.de>
References: <20230809220545.1308228-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

->put_super is only called when sb->s_root is set, and thus when
fill_super succeeds.  Thus drop the NULL check that can't happen in
xfs_fs_put_super.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_super.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 0a294659c18972..128f4a2924d49c 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1132,10 +1132,6 @@ xfs_fs_put_super(
 {
 	struct xfs_mount	*mp = XFS_M(sb);
 
-	/* if ->fill_super failed, we have no mount to tear down */
-	if (!sb->s_fs_info)
-		return;
-
 	xfs_notice(mp, "Unmounting Filesystem %pU", &mp->m_sb.sb_uuid);
 	xfs_filestream_unmount(mp);
 	xfs_unmountfs(mp);
-- 
2.39.2

