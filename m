Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEF37DE7F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 11:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfJUJUp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 05:20:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33399 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfJUJUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:20:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so6336883pls.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 02:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=14Kemxr7lge9hljjqfibah/1nIDd0rrIrEFWCQLuEzY=;
        b=1cviomBFXuaJ3UL4IfzswfJQCNXYohWbh+Bra0LiHQ8+rtey2VTsoBXr3aMYl0voUz
         3YeJ1p1+f7m3Mvc5v29JKHhV+5h/otmPs5Q97H1+gtiz4lDQ0yU7JhoaWFeZxnrxoqyW
         2g+sJ7cI4iklRw8oW2j/qgjAM+duC7UL0TVPCJxvIrQOaw6P2gLzbln4+/7UUlqppM+c
         MaDk1XGOl3EbfQCUUmCtAt/SEi91kAHPLqcj5EcdSja5yxTqj9bYC1EhmqKYSb4Nru5e
         OD7bu8xgRBERCMYOqbqEZmdtZWNfXGwRhW0YVAkiNTiGukuHFMe4gdyqs9tVa5eZogh+
         M14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=14Kemxr7lge9hljjqfibah/1nIDd0rrIrEFWCQLuEzY=;
        b=evqS1R+bqaO2MJs4tHNmc/y+yDsWqQAhBToRpiISNFD2hA4MZvydpFRfBcKBuQD1G7
         qcKrXhcPolG8dR2ASlhORYamDgp2NlgTADufcKnKJyhzUul6G+lYQVio+Wtd5+U1U8w1
         cNUFEvp+m3P+DkmsESzQ2L9UVg28m/9Z1m/kz5zs1CiRVrl5nuI8muokAGfUxfSai3LX
         m0Cr+82VPEbOQoHAOZ035bBJ05/MHHx6KrKsH8MZuUiPNTG3MuORCAFUZV2HiFmSOvsv
         ZNRCWPlntEcRna6BH0eDDn50pUvP/2rlz3R/fEXSxzG5R1KRDtv2rq2Mxy6J30QKmBAK
         a0TQ==
X-Gm-Message-State: APjAAAUwAu7pHi7jMiKTRB4OY67q+grEDmNN3OxVDLEKEui9rD1SkdtY
        CBKMrJSSYN56JrxJfSeTsecE
X-Google-Smtp-Source: APXvYqyiZGODRLojxmjKwg9R0oc8UImPGSw1nQRe0oVh/ab4fFsCAiYaDEUiI908KbYRPN5FWTzz6Q==
X-Received: by 2002:a17:902:9881:: with SMTP id s1mr24240292plp.18.1571649644096;
        Mon, 21 Oct 2019 02:20:44 -0700 (PDT)
Received: from athena.bobrowski.net (n1-41-199-60.bla2.nsw.optusnet.com.au. [1.41.199.60])
        by smtp.gmail.com with ESMTPSA id q3sm15422277pgj.54.2019.10.21.02.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 02:20:43 -0700 (PDT)
Date:   Mon, 21 Oct 2019 20:20:37 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v5 10/12] ext4: move inode extension check out from
 ext4_iomap_alloc()
Message-ID: <a2bf8283b42f49e3549f92b9170d56d3a740c521.1571647180.git.mbobrowski@mbobrowski.org>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571647178.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Lift the inode extension/orphan list handling code out from
ext4_iomap_alloc() and apply it within the ext4_dax_write_iter()
function.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/file.c  | 21 ++++++++++++++++++++-
 fs/ext4/inode.c | 22 ----------------------
 2 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 6ddf00265988..65e758ae02d0 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -304,6 +304,8 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t ret;
 	size_t count;
 	loff_t offset;
+	handle_t *handle;
+	bool extend = false;
 	struct inode *inode = file_inode(iocb->ki_filp);
 
 	if (!inode_trylock(inode)) {
@@ -323,8 +325,25 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	offset = iocb->ki_pos;
 	count = iov_iter_count(from);
+	if (offset + count > EXT4_I(inode)->i_disksize) {
+		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
+		if (IS_ERR(handle)) {
+			ret = PTR_ERR(handle);
+			goto out;
+		}
+
+		ret = ext4_orphan_add(handle, inode);
+		if (ret) {
+			ext4_journal_stop(handle);
+			goto out;
+		}
+		extend = true;
+		ext4_journal_stop(handle);
+	}
+
 	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
-	ret = ext4_handle_inode_extension(inode, ret, offset, count);
+	if (extend)
+		ret = ext4_handle_inode_extension(inode, ret, offset, count);
 out:
 	inode_unlock(inode);
 	if (ret > 0)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f79d15e8d3c6..a37112efe3fb 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3443,7 +3443,6 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 			    unsigned int flags)
 {
 	handle_t *handle;
-	u8 blkbits = inode->i_blkbits;
 	int ret, dio_credits, retries = 0;
 
 	/*
@@ -3466,28 +3465,7 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 		return PTR_ERR(handle);
 
 	ret = ext4_map_blocks(handle, inode, map, EXT4_GET_BLOCKS_CREATE_ZERO);
-	if (ret < 0)
-		goto journal_stop;
-
-	/*
-	 * If we have allocated blocks beyond EOF, we need to ensure that
-	 * they're truncated if we crash before updating the inode size
-	 * metadata within ext4_iomap_end(). For faults, we don't need to do
-	 * that (and cannot due to the orphan list operations needing an
-	 * inode_lock()). If we happen to instantiate blocks beyond EOF, it is
-	 * because we race with a truncate operation, which already has added
-	 * the inode onto the orphan list.
-	 */
-	if (!(flags & IOMAP_FAULT) && map->m_lblk + map->m_len >
-	    (i_size_read(inode) + (1 << blkbits) - 1) >> blkbits) {
-		int err;
-
-		err = ext4_orphan_add(handle, inode);
-		if (err < 0)
-			ret = err;
-	}
 
-journal_stop:
 	ext4_journal_stop(handle);
 	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
 		goto retry;
-- 
2.20.1

--<M>--
