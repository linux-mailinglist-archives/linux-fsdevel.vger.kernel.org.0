Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0215E437F36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 22:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhJVUSC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 16:18:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57138 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbhJVURz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:17:55 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E386C1FD61;
        Fri, 22 Oct 2021 20:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634933736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6s0KWIoYU1fvFLOFfccODUHj8eFbZXTXmCH1ca4A95w=;
        b=04IYGaz6ruYhvJErFgLXiTwFkKLfHhY2C4Dq9da0ZEq3I/rCs8rEDoJnwLze0nLkys3c9u
        pJXaWUH87sVLUuYVZyTLV6oOnzdTGx/Z3ejdQ1PIJtsc6gCxdEWU89zMTR2CednaF2MyIV
        rhdNPupUrSIjH80D2e0aPZj6ap9iNJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634933736;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6s0KWIoYU1fvFLOFfccODUHj8eFbZXTXmCH1ca4A95w=;
        b=jPzncAv+ma4xZKL7zVZLAalKsEoY/DCRxft8tlQL+RJRW8YLMr35Nsi3imn9rntMrYnapJ
        CzKvdAtMMLX1dVDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 790FB1348D;
        Fri, 22 Oct 2021 20:15:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id r4E2EOgbc2H6dgAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Fri, 22 Oct 2021 20:15:36 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 4/5] btrfs: Set s_bdev for btrfs super block
Date:   Fri, 22 Oct 2021 15:15:04 -0500
Message-Id: <0dfdf1aea018b4a06774f0117ef0af51944ecb46.1634933122.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634933121.git.rgoldwyn@suse.com>
References: <cover.1634933121.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

s_bdev is not set. Use the latest bdev to setup s_bdev.
reads are performed on block device directly and derived from super
block ->s_bdev field.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 432f40f72466..9588a42d7a49 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1749,6 +1749,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 		deactivate_locked_super(s);
 		return ERR_PTR(error);
 	}
+	s->s_bdev = bdev;
 
 	return dget(s->s_root);
 
-- 
2.33.1

