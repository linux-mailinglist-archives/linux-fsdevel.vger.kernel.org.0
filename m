Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69F65D1057
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 15:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfJINkN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 09:40:13 -0400
Received: from mout02.posteo.de ([185.67.36.66]:37167 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731259AbfJINkN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:40:13 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id AB6322400FC
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2019 15:32:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1570627927; bh=v156KLmsetNeSmsA507OqKATkLkxlImkcFjRxUoOgT8=;
        h=From:To:Cc:Subject:Date:From;
        b=JhHaI9WhkFwDSD5yV8abEdqNutaTWTgiFnob60Tog3CGdMI+Q557R/PCI1ou3ykuq
         AKF7yuEH1OO/TlnuUg9G8E6nVmXPgAMcFH5eSCqFESLi0mDhB8RVYYZzxCBY7rl5im
         Yq1NblTH74VqJ068ezsCLiPNqNpdsk/CcdMKRWo/tQUV2upbELDRWpb2W88tDQihyl
         +4rGTCNAD1MUc4x6zlGsACM5Lk42pdGw46AFaq2iEl8/bSrN9XGK6ub02D6gP1K9T1
         ip135V8YbX+hTbAgYTUjDeAkrD5OcmpQtpqxVUpipf9vMuXHu8YnKi0V8H1sKquA2G
         UEcZmxxRCZqnA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 46pFWC2gcTz9rxN;
        Wed,  9 Oct 2019 15:32:07 +0200 (CEST)
From:   philipp.ammann@posteo.de
To:     linux-fsdevel@vger.kernel.org
Cc:     Andreas Schneider <asn@cryptomilk.org>
Subject: [PATCH 5/6] Sync blocks on remount
Date:   Wed,  9 Oct 2019 15:31:56 +0200
Message-Id: <20191009133157.14028-6-philipp.ammann@posteo.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009133157.14028-1-philipp.ammann@posteo.de>
References: <20191009133157.14028-1-philipp.ammann@posteo.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Andreas Schneider <asn@cryptomilk.org>

Signed-off-by: Andreas Schneider <asn@cryptomilk.org>
---
 drivers/staging/exfat/exfat_super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 29fb5e88fe5f..e8e481a5ddc9 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -3532,6 +3532,8 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 static int exfat_remount(struct super_block *sb, int *flags, char *data)
 {
 	*flags |= SB_NODIRATIME;
+	sync_filesystem(sb);
+
 	return 0;
 }
 
-- 
2.21.0

