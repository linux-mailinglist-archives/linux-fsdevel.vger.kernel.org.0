Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80273437F2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 22:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbhJVURq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 16:17:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57130 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhJVURp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:17:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 51AC81FD61;
        Fri, 22 Oct 2021 20:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634933726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b5ZL8IsddVC5wtGTez6QqQY4LXm+jrHqut3eC/YGm54=;
        b=1VbQ5d4RHkVLYopROQIv5DlRaCivowZ1m4uf7LZVUaLX9c4UQYVF8isoj7rEvdnuo3+lWY
        e3v14ZTWCHa8rmVAW45mR+Ydt5iupoqYhRL2cJ3DHUmCJdc333dy+JwegakiNhMeHqc7/e
        fEvkJ0zkV0h0P/dD0hA8j/1ZRIuM/QE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634933726;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b5ZL8IsddVC5wtGTez6QqQY4LXm+jrHqut3eC/YGm54=;
        b=WRAdleFPEf/SVTjmtn5SiKeluyzzqciVHyIb99DKKjviD/TrtC/uQMD+uX60rFsW0DJH5p
        TVicBjjSoYyrkvCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DADFF1348D;
        Fri, 22 Oct 2021 20:15:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MvXaGN0bc2HjdgAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Fri, 22 Oct 2021 20:15:25 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 1/5] mm: Use file parameter to determine bdi
Date:   Fri, 22 Oct 2021 15:15:01 -0500
Message-Id: <11dbd8d715fab9c7fe8536552c18fcb44a36b849.1634933121.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634933121.git.rgoldwyn@suse.com>
References: <cover.1634933121.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

This is done so the bdi inode is derived correctly when file->f_mapping
is not the same as mapping passed. Set conditionally because some
callee pass NULL for file pointer.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 mm/readahead.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/readahead.c b/mm/readahead.c
index d589f147f4c2..9f303a31f650 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -443,6 +443,9 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	unsigned long index = readahead_index(ractl);
 	pgoff_t prev_index;
 
+	if (ractl->file)
+		bdi = inode_to_bdi(file_inode(ractl->file));
+
 	/*
 	 * If the request exceeds the readahead window, allow the read to
 	 * be up to the optimal hardware IO size
-- 
2.33.1

