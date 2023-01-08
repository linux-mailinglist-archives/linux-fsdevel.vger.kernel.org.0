Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA786619DE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 22:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjAHVR2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 16:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjAHVR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:17:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B808BD43;
        Sun,  8 Jan 2023 13:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+fTNevAqKk/KH5jQmB577WyYwIjJaGXSYo1Kkw8//U8=; b=byUKNGetm3skpB0osIZdzjmVcj
        gX2dVF3m2fMEnkOaV+kh6gvARpBZ7AFyfxgY+L1iGfpdfGfjVTHL9xxoF4NlkjqYeIaQLwOSl+Mtl
        4Sa3NFJyeX0+o+I3BQS8ART4Ltabft8TVIJwxwfwQ9nMYccsrJmcldxE+CTmKur3Bs+uvJ+oF9CgA
        aPIoqFVfFK2QUuQ7BDYMSYt74tm/fN5lm2i7/Za+hVv4N+RLcV8ktrebKs/bSETE8RZTA4ZxkhNE0
        u6tAe/HAvZcOUtIpTcGGV/A/eQ1GwLN3mPr8I1VwHlpv4keaJQ0vmIEQNNgsdYSo1bq9yynXC37jl
        Eu6oRbmw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEd2k-001kcp-D4; Sun, 08 Jan 2023 21:17:26 +0000
Date:   Sun, 8 Jan 2023 21:17:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <Y7sy5jzjT7tpPX6Z@casper.infradead.org>
References: <20230108165645.381077-1-hch@lst.de>
 <20230108165645.381077-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108165645.381077-4-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 08, 2023 at 05:56:41PM +0100, Christoph Hellwig wrote:
> @@ -274,9 +280,10 @@ int minix_add_link(struct dentry *dentry, struct inode *inode)
>  		memset (namx + namelen, 0, sbi->s_dirsize - namelen - 2);
>  		de->inode = inode->i_ino;
>  	}
> -	err = dir_commit_chunk(page, pos, sbi->s_dirsize);
> +	dir_commit_chunk(page, pos, sbi->s_dirsize);
>  	dir->i_mtime = dir->i_ctime = current_time(dir);
>  	mark_inode_dirty(dir);
> +	minix_handle_dirsync(dir);

Doesn't this need to be:

	err = minix_handle_dirsync(dir);

> @@ -426,7 +436,7 @@ void minix_set_link(struct minix_dir_entry *de, struct page *page,
>  			((minix3_dirent *) de)->inode = inode->i_ino;
>  		else
>  			de->inode = inode->i_ino;
> -		err = dir_commit_chunk(page, pos, sbi->s_dirsize);
> +		dir_commit_chunk(page, pos, sbi->s_dirsize);
>  	} else {
>  		unlock_page(page);
>  	}
> -- 

Aren't you missing a call to minix_handle_dirsync() in this function?
