Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C816652FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 05:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjAKE7D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 23:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjAKE7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 23:59:01 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29C4E0BC;
        Tue, 10 Jan 2023 20:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hwxTpnik4GFRaEfSysSXhVpKMkvUhYmc7DfBcKe47Q8=; b=gwuZnr26GfvdSwtTngWR0qosOP
        HUs1Cd/2fuK8Qmn4R+lCu65v90x3QDWE/O14fdzypvhBXSoYF4rbsU1ykCOH27b8Xj7rp2JRAnf60
        hcESkI65xxGkW5d1dmkrRhX253+s2bBeRS8x9As4FZk1sJg0/i9tdrxE2gBIqXrCUpjSjFVQmD59P
        yWkZ1kvppP2R3edwG0o19wXOgbKokc9xs+7pjD3M1PsiLmk0yVgIe/2Wh3vCPRj++UHnAGs2zyx+w
        F7rqLOZOjVvXeWfpNOgnCiEvEkTI822rlxKyO8e/cKnXhKVhmdqatpDQdhRiuxoCcE4feBhtRD5Bd
        BQG8ySuw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pFTCF-0017ZY-1R;
        Wed, 11 Jan 2023 04:58:43 +0000
Date:   Wed, 11 Jan 2023 04:58:43 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        linux-btrfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/7] minix: don't flush page immediately for DIRSYNC
 directories
Message-ID: <Y75CAwtM1gE1sevy@ZenIV>
References: <20230108165645.381077-1-hch@lst.de>
 <20230108165645.381077-4-hch@lst.de>
 <Y7sy5jzjT7tpPX6Z@casper.infradead.org>
 <20230110082225.GB11947@lst.de>
 <Y74c+WSEajAic3Kh@ZenIV>
 <20230111042641.GA15181@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111042641.GA15181@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 11, 2023 at 05:26:41AM +0100, Christoph Hellwig wrote:
> On Wed, Jan 11, 2023 at 02:20:41AM +0000, Al Viro wrote:
> > More seriously, all those ..._set_link() need to return an error and their
> > callers (..._rename()) need to deal with failures.
> 
> That's actually what I did yesterday:
> 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/remove-write_one_page

ext2 also has that bug.  As well as "need to check for delete_entry errors"
one (also in ext2_rename()).

Completely untested patch follows:

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index e5cbc27ba459..b38fab33cd0d 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -461,7 +461,7 @@ static int ext2_handle_dirsync(struct inode *dir)
 	return err;
 }
 
-void ext2_set_link(struct inode *dir, struct ext2_dir_entry_2 *de,
+int ext2_set_link(struct inode *dir, struct ext2_dir_entry_2 *de,
 		   struct page *page, void *page_addr, struct inode *inode,
 		   int update_times)
 {
@@ -480,7 +480,7 @@ void ext2_set_link(struct inode *dir, struct ext2_dir_entry_2 *de,
 		dir->i_mtime = dir->i_ctime = current_time(dir);
 	EXT2_I(dir)->i_flags &= ~EXT2_BTREE_FL;
 	mark_inode_dirty(dir);
-	ext2_handle_dirsync(dir);
+	return ext2_handle_dirsync(dir);
 }
 
 /*
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 28de11a22e5f..95c083bb1b7c 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -734,7 +734,7 @@ extern int ext2_delete_entry(struct ext2_dir_entry_2 *dir, struct page *page,
 			     char *kaddr);
 extern int ext2_empty_dir (struct inode *);
 extern struct ext2_dir_entry_2 *ext2_dotdot(struct inode *dir, struct page **p, void **pa);
-extern void ext2_set_link(struct inode *, struct ext2_dir_entry_2 *, struct page *, void *,
+extern int ext2_set_link(struct inode *, struct ext2_dir_entry_2 *, struct page *, void *,
 			  struct inode *, int);
 static inline void ext2_put_page(struct page *page, void *page_addr)
 {
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index c056957221a2..5e3397680faa 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -370,8 +370,10 @@ static int ext2_rename (struct user_namespace * mnt_userns,
 			err = PTR_ERR(new_de);
 			goto out_dir;
 		}
-		ext2_set_link(new_dir, new_de, new_page, page_addr, old_inode, 1);
+		err = ext2_set_link(new_dir, new_de, new_page, page_addr, old_inode, 1);
 		ext2_put_page(new_page, page_addr);
+		if (err)
+			goto out_dir;
 		new_inode->i_ctime = current_time(new_inode);
 		if (dir_de)
 			drop_nlink(new_inode);
@@ -391,7 +393,9 @@ static int ext2_rename (struct user_namespace * mnt_userns,
 	old_inode->i_ctime = current_time(old_inode);
 	mark_inode_dirty(old_inode);
 
-	ext2_delete_entry(old_de, old_page, old_page_addr);
+	err = ext2_delete_entry(old_de, old_page, old_page_addr);
+	if (err)
+		goto out_dir;
 
 	if (dir_de) {
 		if (old_dir != new_dir)
