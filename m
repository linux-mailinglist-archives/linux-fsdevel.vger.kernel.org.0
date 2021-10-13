Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1500842B620
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 07:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbhJMFxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 01:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhJMFxG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 01:53:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B58BC061570;
        Tue, 12 Oct 2021 22:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=o4h3siWCWbYazYK0Oyye0WCxhW+TPsSdCJyezg31K/s=; b=h/xz+HqR3T+2gdg8k2nNGkeFrh
        oBfn/pdJam7uwquPpri+uWckonTBJR+SPPwva6ojdH4VCTh9BjV8vKQKCGyPXU0dgqxxOBWFjziev
        PP0t0q4OWGrW7NaoepwV7XF78rE2jSee6S6dOoUwoWpD+2U/BptLWNNM8TnnqDuu3gnovgVWrwCPY
        NzqOyLaeLFL/gtHgcLPYk7oy122A48dL/MvYklpbYzsq1afBOR/LuKx8OP6d8BfPxgCzYKGpApyGA
        vkkxTaOCFuOQcwepWerxC/fBJk1clMLnCBsEwAZyLqtkz98WYOdIwjlim4YFIKx6YjNBxeikzaCtY
        u+K2EeIg==;
Received: from 089144212063.atnat0021.highway.a1.net ([89.144.212.63] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maX4E-0078XK-Np; Wed, 13 Oct 2021 05:45:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Song Liu <song@kernel.org>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Kees Cook <keescook@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        reiserfs-devel@vger.kernel.org
Subject: [PATCH 28/29] reiserfs: use sb_bdev_nr_blocks
Date:   Wed, 13 Oct 2021 07:10:41 +0200
Message-Id: <20211013051042.1065752-29-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013051042.1065752-1-hch@lst.de>
References: <20211013051042.1065752-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the sb_bdev_nr_blocks helper instead of open coding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/reiserfs/super.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 6c9681e2809f0..b12baadb7e9bb 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -1199,9 +1199,7 @@ static int reiserfs_parse_options(struct super_block *s,
 
 			if (!strcmp(arg, "auto")) {
 				/* From JFS code, to auto-get the size. */
-				*blocks =
-				    i_size_read(s->s_bdev->bd_inode) >> s->
-				    s_blocksize_bits;
+				*blocks = sb_bdev_nr_blocks(s);
 			} else {
 				*blocks = simple_strtoul(arg, &p, 0);
 				if (*p != '\0') {
-- 
2.30.2

