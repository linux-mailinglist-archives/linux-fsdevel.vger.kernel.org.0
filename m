Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9312B7BA90C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 20:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjJES1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 14:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjJES1X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:27:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DC49F;
        Thu,  5 Oct 2023 11:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QdLbOjyN2QvHQH3f6UEWNamidGFa6JBOfjnj2AoIPrk=; b=CnyrTTCXY2J+AnabSkhCSmsUOe
        kGLy6schHDRrfZpjdkyQiwmtw7m2IaYLsaxGyFYyxllXuPuW9nDQOBwE2irfM53srFIG0im+kwhHo
        Jf7R2m+tsgciNHCC/Ug2UbI9wBFL5uwMwUBskYXA+3gixPIBll9dILPIi9KzW7Qh+2TQ8HddzTnbs
        gT8ml5ew2+d9P5h2wdLFdGio7e9LOae9C4Z+tOkkdwo9QsLr027r5HpSmTMnVpytqFc6cwvJin4mI
        tVc5FBH6qf+y+L/N5TASfNhr18W8mg3A2HSkg5o+AKXxroliI8QcpX5ekBLqt+pnnkSa9oxLWgoSQ
        iKEDDXvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qoT47-00Aqt4-T5; Thu, 05 Oct 2023 18:27:15 +0000
Date:   Thu, 5 Oct 2023 19:27:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH 02/10] ext2: Convert ext2_check_page to ext2_check_folio
Message-ID: <ZR8AAy6scCAjXhiS@casper.infradead.org>
References: <20230921200746.3303942-1-willy@infradead.org>
 <20230921200746.3303942-2-willy@infradead.org>
 <20231003104017.ohuyl3fv2mobif5u@quack3>
 <20231003105224.3j47fjxpiudwvupn@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003105224.3j47fjxpiudwvupn@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 03, 2023 at 12:52:24PM +0200, Jan Kara wrote:
> On Tue 03-10-23 12:40:17, Jan Kara wrote:
> > On Thu 21-09-23 21:07:39, Matthew Wilcox (Oracle) wrote:
> > > Support in this function for large folios is limited to supporting
> > > filesystems with block size > PAGE_SIZE.  This new functionality will only
> > > be supported on machines without HIGHMEM, so the problem of kmap_local
> > > only being able to map a single page in the folio can be ignored.
> > > We will not use large folios for ext2 directories on HIGHMEM machines.
> > 
> > OK, but can we perhaps enforce this with some checks & error messages
> > instead of a silent failure? Like:
> > 
> > #ifdef CONFIG_HIGHMEM
> > 	if (sb->s_blocksize > PAGE_SIZE)
> > 		bail with error
> > #endif
> > 
> > somewhere in ext2_fill_super()? Or maybe force allocation of lowmem pages
> > when blocksize > PAGE_SIZE?
> > 
> > > @@ -195,9 +195,9 @@ static void *ext2_get_page(struct inode *dir, unsigned long n,
> > >  
> > >  	if (IS_ERR(folio))
> > >  		return ERR_CAST(folio);
> > > -	page_addr = kmap_local_folio(folio, n & (folio_nr_pages(folio) - 1));
> > > +	page_addr = kmap_local_folio(folio, 0);
> 
> Oh, and I think this change breaks the code whenever we get back higher
> order folio because the page_addr we get back is not for the page index
> 'n'.

> A look like a fool replying to the same patch multiple times ;) but how is
> this supposed to work even without HIGHMEM? Suppose we have a page size 4k
> and block size 16k. Directory entries in a block can then straddle 4k
> boundary so if kmap_local() is mapping only a single page, then we are
> going to have hard time parsing this all?
> 
> Oh, I guess you are pointing to the fact kmap_local_folio() gives you back
> address usable for the whole folio access if !HIGHMEM. But then all the
> iterations (e.g. in ext2_readdir()) has to be folio-size based and not
> page-size based as they currently are? You didn't change these iterations
> in your patches which has confused me...

I'm going to reply to all three emails as one ;-)

The goal for this patchset is simply to do the folio conversion.
Earlier work was focused on "make sure everything behaves as it did
before", but now I've started to give some thought to "How will this
work" without actually doing the higher level work.

Today, ext2 does not permit large folios to be used for directory
inodes.  Whoever adds the call to mapping_set_large_folios() gets the
joy of finding all the places that contain assumptions and fixing them.
I don't particularly want to do that myself; I'm just trying to sort
out the underpinnings so that whoever does it has a somewhat sane
API to work against.

So I'm really just trying to do two things here:

 - Convert uses of struct page -> struct folio
 - Not leave any landmines for whoever comes after me

I had a quick look at converting ext2_readdir() to work for
large folios.  It's a bit intrusive, and I haven't done any
serious testing (let alone with the bs>PS patches).  But it could
look something like this:


diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 6807df637112..5eeb57ce6a18 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -257,45 +257,45 @@ static inline void ext2_set_de_type(ext2_dirent *de, struct inode *inode)
 static int
 ext2_readdir(struct file *file, struct dir_context *ctx)
 {
-	loff_t pos = ctx->pos;
 	struct inode *inode = file_inode(file);
+	loff_t pos = ctx->pos;
+	loff_t isize = i_size_read(inode);
 	struct super_block *sb = inode->i_sb;
-	unsigned int offset = pos & ~PAGE_MASK;
-	unsigned long n = pos >> PAGE_SHIFT;
-	unsigned long npages = dir_pages(inode);
 	unsigned chunk_mask = ~(ext2_chunk_size(inode)-1);
 	bool need_revalidate = !inode_eq_iversion(inode, file->f_version);
 	bool has_filetype;
 
-	if (pos > inode->i_size - EXT2_DIR_REC_LEN(1))
+	if (pos > isize - EXT2_DIR_REC_LEN(1))
 		return 0;
 
 	has_filetype =
 		EXT2_HAS_INCOMPAT_FEATURE(sb, EXT2_FEATURE_INCOMPAT_FILETYPE);
 
-	for ( ; n < npages; n++, offset = 0) {
+	while (pos < isize) {
 		ext2_dirent *de;
 		struct folio *folio;
-		char *kaddr = ext2_get_folio(inode, n, 0, &folio);
+		char *kaddr = ext2_get_folio(inode, pos / PAGE_SIZE, 0, &folio);
+		size_t offset = offset_in_folio(folio, pos);
 		char *limit;
 
 		if (IS_ERR(kaddr)) {
 			ext2_error(sb, __func__,
 				   "bad page in #%lu",
 				   inode->i_ino);
-			ctx->pos += PAGE_SIZE - offset;
+			ctx->pos += folio_size(folio) - offset;
 			return PTR_ERR(kaddr);
 		}
 		if (unlikely(need_revalidate)) {
 			if (offset) {
 				offset = ext2_validate_entry(kaddr, offset, chunk_mask);
-				ctx->pos = (n<<PAGE_SHIFT) + offset;
+				ctx->pos = folio_pos(folio) + offset;
 			}
 			file->f_version = inode_query_iversion(inode);
 			need_revalidate = false;
 		}
 		de = (ext2_dirent *)(kaddr+offset);
-		limit = kaddr + ext2_last_byte(inode, n) - EXT2_DIR_REC_LEN(1);
+		limit = kaddr + ext2_last_byte(inode, folio->index) -
+				EXT2_DIR_REC_LEN(1);
 		for ( ;(char*)de <= limit; de = ext2_next_entry(de)) {
 			if (de->rec_len == 0) {
 				ext2_error(sb, __func__,
@@ -319,6 +319,7 @@ ext2_readdir(struct file *file, struct dir_context *ctx)
 			ctx->pos += ext2_rec_len_from_disk(de->rec_len);
 		}
 		folio_release_kmap(folio, kaddr);
+		pos = (loff_t)folio_next_index(folio) * PAGE_SIZE;
 	}
 	return 0;
 }

ext2_last_byte() is clearly now incorrect.  It should probably take
isize and folio as inputs and return either the last byte in the folio
or the last byte in the file.  But then we need to convert all the
callers, and I didn't want to do that for this demonstration patch.
