Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6D56651AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 03:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbjAKCVG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 21:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbjAKCVB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 21:21:01 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBB683;
        Tue, 10 Jan 2023 18:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nC2zRIJsPDH7lfPM013A6ZhKrdzcIixd+v8ICTA/zXw=; b=EJXDRWw922tsBHv8pVihMTfEzX
        cAnh+DIDfy5WK8WpuLeldrQsLeM+U+IDEhfDKkpqfRPo5ltzJrRQJN2h0983eKxZEn/ViZvQT1zw5
        dXZE6B7ajOJP+d079+ZOkU3XjRGF0CBIhvdLilgI3TMdfwzsYv8Hj+L9vHTLYg6953pTPbQgKeBnG
        jKblwmPGe5q2Ukar3+4BVgnbtwgOGcxJvaBJ2QDDdnukNQLNFYs45tV0O+meIHYIoke++yw3YLSEc
        ckkPIEkrGzWzDZEg2WPLfglK5OOx6Ai2BfcMgqkfqHHatTmLIju0/qQmXMpjNhfM21hXR1omDsOhr
        Xvu53ukg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pFQjJ-0016dP-29;
        Wed, 11 Jan 2023 02:20:42 +0000
Date:   Wed, 11 Jan 2023 02:20:41 +0000
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
Message-ID: <Y74c+WSEajAic3Kh@ZenIV>
References: <20230108165645.381077-1-hch@lst.de>
 <20230108165645.381077-4-hch@lst.de>
 <Y7sy5jzjT7tpPX6Z@casper.infradead.org>
 <20230110082225.GB11947@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110082225.GB11947@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 10, 2023 at 09:22:25AM +0100, Christoph Hellwig wrote:
> On Sun, Jan 08, 2023 at 09:17:26PM +0000, Matthew Wilcox wrote:
> > > +	dir_commit_chunk(page, pos, sbi->s_dirsize);
> > >  	dir->i_mtime = dir->i_ctime = current_time(dir);
> > >  	mark_inode_dirty(dir);
> > > +	minix_handle_dirsync(dir);
> > 
> > Doesn't this need to be:
> > 
> > 	err = minix_handle_dirsync(dir);
> 
> Yes, fixed.
> 
> > 
> > > @@ -426,7 +436,7 @@ void minix_set_link(struct minix_dir_entry *de, struct page *page,
> > >  			((minix3_dirent *) de)->inode = inode->i_ino;
> > >  		else
> > >  			de->inode = inode->i_ino;
> > > -		err = dir_commit_chunk(page, pos, sbi->s_dirsize);
> > > +		dir_commit_chunk(page, pos, sbi->s_dirsize);
> > >  	} else {
> > >  		unlock_page(page);
> > >  	}
> > > -- 
> > 
> > Aren't you missing a call to minix_handle_dirsync() in this function?
> 
> Yes, fixed.

More seriously, all those ..._set_link() need to return an error and their
callers (..._rename()) need to deal with failures.  That goes for ext2
as well, and that part is worth splitting off into a prereq - it's a -stable
fodder.
