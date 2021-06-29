Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286D43B6EA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 09:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhF2HXV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 03:23:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57736 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbhF2HXV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 03:23:21 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 91DD92038F;
        Tue, 29 Jun 2021 07:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624951253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=z9i+1oOsM9Oo3GDg7DNAJTVWQZ0floPmxgvFrbDHP24=;
        b=pgsWp3ioGIKi629tH6D3XZ+lVx1u4K++61o7CfQ0LhGTZRfnHBdL14m+ZczKIBzRWKOvpe
        36E9ZDhubTGMXlAGQ2gS+8AcnNEWHhqv1ei3+2PpRFkWQkCDwiEKOmM1Z/+M1vMI3AnRcw
        EYzPKi0NeRHNTsoCqHo0DZ0qXGQ9hRs=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 3B39D11906;
        Tue, 29 Jun 2021 07:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624951253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=z9i+1oOsM9Oo3GDg7DNAJTVWQZ0floPmxgvFrbDHP24=;
        b=pgsWp3ioGIKi629tH6D3XZ+lVx1u4K++61o7CfQ0LhGTZRfnHBdL14m+ZczKIBzRWKOvpe
        36E9ZDhubTGMXlAGQ2gS+8AcnNEWHhqv1ei3+2PpRFkWQkCDwiEKOmM1Z/+M1vMI3AnRcw
        EYzPKi0NeRHNTsoCqHo0DZ0qXGQ9hRs=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id rHSRC9XJ2mAkFgAALh3uQQ
        (envelope-from <nborisov@suse.com>); Tue, 29 Jun 2021 07:20:53 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     hch@infradead.org
Cc:     djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2] iomap: Break build if io_inline_bio is not last in iomap_ioend
Date:   Tue, 29 Jun 2021 10:20:51 +0300
Message-Id: <20210629072051.2875413-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Comments are good but unfortunately they can't effectively enforce
certain invariants, to that effect let's break the build in case
io_inline_bio is, for whatever reason, not the last member of
iomap_ioend.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

V2:
 - Fix indentation and long lines

 fs/iomap/buffered-io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9023717c5188..62e27faacc6e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1225,6 +1225,9 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
 	bio->bi_write_hint = inode->i_write_hint;
 	wbc_init_bio(wbc, bio);

+	BUILD_BUG_ON(offsetof(struct iomap_ioend, io_inline_bio) +
+		     sizeof(struct bio) != sizeof(struct iomap_ioend));
+
 	ioend = container_of(bio, struct iomap_ioend, io_inline_bio);
 	INIT_LIST_HEAD(&ioend->io_list);
 	ioend->io_type = wpc->iomap.type;
--
2.25.1

