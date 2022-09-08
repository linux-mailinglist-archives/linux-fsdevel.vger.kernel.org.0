Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF735B2490
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 19:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiIHRZo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 13:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiIHRZP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:25:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E856157E3F;
        Thu,  8 Sep 2022 10:25:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7958DB821DB;
        Thu,  8 Sep 2022 17:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F98C4347C;
        Thu,  8 Sep 2022 17:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662657910;
        bh=GCiVQrHAmwsie7AsMWJgZavE3oU3xm6fSWOc49mDFmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bm5rIPlx/0BsT6WANYrIo5eksfQ3ZHl7HQ//5M3nJmwTWrG8OKt2XGG20tlIbzZsv
         gREn8JhQfvr60YHNNOhaDShwmBnOnCpu9nvPfKSomTVstq54aZKaRazlw5QjMvdLJY
         fN9IUntS/1fFUOX3M6qjLr2D7S/e1oYFmX1dbp9NIdyO+rgN+jFfARiQA+x9DlNe7w
         zIMxv5TafDusRr4vyY4FAcXQma0OZbV7ctE9pm5rT7zrHip9UDSQcfBSmNlupA92uK
         pIM+e3NqISUkh7EjcsG35bFm87umbXxEFvnHoLaew2eB4Eg+4aevC7gdof9dBfu7KN
         j+hOgRKkjSkpA==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [RFC PATCH v5 8/8] nfsd: take inode_lock when querying for NFSv4 GETATTR
Date:   Thu,  8 Sep 2022 13:24:48 -0400
Message-Id: <20220908172448.208585-9-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220908172448.208585-1-jlayton@kernel.org>
References: <20220908172448.208585-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The i_version counter for regular files is updated in update_time, and
that's usually done before copying the data to the pagecache. It's
possible that a reader and writer could race like this:

	reader		writer
	------		------
			i_version++
	read
	getattr
			update page cache

If that happens then the reader may associate the i_version value with
the wrong inode state.

All of the existing filesystems that implement i_version take the
i_rwsem in their write_iter operations before incrementing it. Take the
inode_lock when issuing a getattr for NFSv4 attributes to prevent the
above race.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 4eec2ce05e7e..f7951d8d55ca 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2872,9 +2872,22 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 
+	/*
+	 * The inode lock is needed here to ensure that there is not a
+	 * write to the inode in progress that might change the size,
+	 * or an in-progress directory morphing operation for directory
+	 * inodes.
+	 *
+	 * READ and GETATTR are not guaranteed to be atomic, even when in
+	 * the same compound, but we do try to present attributes in the
+	 * GETATTR reply as representing a single point in time.
+	 */
+	inode_lock(d_inode(dentry));
 	err = vfs_getattr(&path, &stat,
 			  STATX_BASIC_STATS | STATX_BTIME | STATX_INO_VERSION,
 			  AT_STATX_SYNC_AS_STAT);
+	inode_unlock(d_inode(dentry));
+
 	if (err)
 		goto out_nfserr;
 	if (!(stat.result_mask & STATX_BTIME))
-- 
2.37.3

