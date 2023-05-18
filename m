Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3356A708034
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 13:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjERLs0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 07:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjERLsQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 07:48:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500E419A;
        Thu, 18 May 2023 04:47:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8C9664ED4;
        Thu, 18 May 2023 11:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DD8C433A0;
        Thu, 18 May 2023 11:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684410477;
        bh=en20+kwYIb+rQx+Bs8McKeHFRgrQ8XEHcOk9MVmU7iY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E4LAb0nIr9avuLF6bnhNgC2cRv8n+Y1r1x0zPOZeGu+bmo0SCl5MMh4ksQB9eom5S
         CEPIxNX0JYB+XiFpj7TAYcNwACJZ0aG2sE7DrRd8kZiFZMB+MkW7P2Gk7W1du57+Tx
         BMsp9pM/wLI2kWZmup7SdZvctIT91uMob/wvifDVVh88XCAtTac7bHJkRuxHrr8ZN2
         jrlGYU74z7oZ6tQP5ksyrgyn3awO7cIF7AtozH7MMlARxYEikZaguKB2DTP6z6xi6M
         Wm8fgVO2JxxmGPrUz5pDiYBZcTOycshUgvJF3oY9yDGZ5hzJhsgwGrWv6Kl3g/82aL
         D7C397+DhZIWQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore T'so <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH v4 4/9] nfsd: ensure we use ctime_peek to grab the inode->i_ctime
Date:   Thu, 18 May 2023 07:47:37 -0400
Message-Id: <20230518114742.128950-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518114742.128950-1-jlayton@kernel.org>
References: <20230518114742.128950-1-jlayton@kernel.org>
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

If getattr fails, then nfsd can end up scraping the time values directly
out of the inode for pre and post-op attrs. This may or may not be the
right thing to do, but for now make it at least use ctime_peek in this
situation to ensure that the QUERIED flag is masked.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsfh.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index ccd8485fee04..f053cf20dd8a 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -624,9 +624,14 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
 	inode = d_inode(fhp->fh_dentry);
 	err = fh_getattr(fhp, &stat);
 	if (err) {
-		/* Grab the times from inode anyway */
+		/*
+		 * Grab the times from inode anyway.
+		 *
+		 * FIXME: is this the right thing to do? Or should we just
+		 * 	  not send pre and post-op attrs in this case?
+		 */
 		stat.mtime = inode->i_mtime;
-		stat.ctime = inode->i_ctime;
+		stat.ctime = ctime_peek(inode);
 		stat.size  = inode->i_size;
 		if (v4 && IS_I_VERSION(inode)) {
 			stat.change_cookie = inode_query_iversion(inode);
@@ -662,7 +667,7 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
 	err = fh_getattr(fhp, &fhp->fh_post_attr);
 	if (err) {
 		fhp->fh_post_saved = false;
-		fhp->fh_post_attr.ctime = inode->i_ctime;
+		fhp->fh_post_attr.ctime = ctime_peek(inode);
 		if (v4 && IS_I_VERSION(inode)) {
 			fhp->fh_post_attr.change_cookie = inode_query_iversion(inode);
 			fhp->fh_post_attr.result_mask |= STATX_CHANGE_COOKIE;
-- 
2.40.1

