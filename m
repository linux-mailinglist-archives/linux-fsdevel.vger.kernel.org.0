Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88013663AE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 09:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjAJIWl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 03:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbjAJIWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:22:31 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8701A43A1A;
        Tue, 10 Jan 2023 00:22:30 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5B94068AFE; Tue, 10 Jan 2023 09:22:25 +0100 (CET)
Date:   Tue, 10 Jan 2023 09:22:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20230110082225.GB11947@lst.de>
References: <20230108165645.381077-1-hch@lst.de> <20230108165645.381077-4-hch@lst.de> <Y7sy5jzjT7tpPX6Z@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7sy5jzjT7tpPX6Z@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 08, 2023 at 09:17:26PM +0000, Matthew Wilcox wrote:
> > +	dir_commit_chunk(page, pos, sbi->s_dirsize);
> >  	dir->i_mtime = dir->i_ctime = current_time(dir);
> >  	mark_inode_dirty(dir);
> > +	minix_handle_dirsync(dir);
> 
> Doesn't this need to be:
> 
> 	err = minix_handle_dirsync(dir);

Yes, fixed.

> 
> > @@ -426,7 +436,7 @@ void minix_set_link(struct minix_dir_entry *de, struct page *page,
> >  			((minix3_dirent *) de)->inode = inode->i_ino;
> >  		else
> >  			de->inode = inode->i_ino;
> > -		err = dir_commit_chunk(page, pos, sbi->s_dirsize);
> > +		dir_commit_chunk(page, pos, sbi->s_dirsize);
> >  	} else {
> >  		unlock_page(page);
> >  	}
> > -- 
> 
> Aren't you missing a call to minix_handle_dirsync() in this function?

Yes, fixed.
