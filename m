Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A5B69BB64
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 19:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBRS1e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 13:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRS1d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 13:27:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C916D11EB8;
        Sat, 18 Feb 2023 10:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=PEzzaCof8/M/nB7RAAhochQCVXNg2Fidw1t3l1IrvkE=; b=bch8HVD6Cf3lAEcpRcQui0jXUV
        a/qYXcV38zVSP1xY5iG51XYaRn2hrsYVAwZUw8YRtd2w2MTnPYj5uDAt62AzxRxmHh708CfIjyiho
        sriViccTlKxbjhsF7Melgy3m/UjxXhnHiKJRMucRquXa3XUQLlCoewkWWcFg3J/qEvY8arQHwSd0g
        6ZglW3K117GxQ7RiahfEBlpXpD/tt9g+vIlDgxVoMe3s887heYFbJ0hwYMFkIJc6oVo1F5Karl75f
        lV0Y7poKhvBSWHUbQtHp3FcfThpA2SrnqYRwCaMLBorV1zXjgFQnQJaw849ikFrZT0GDqG6nJ8Pgj
        oQhw5WEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pTRvd-00ALG4-Aq; Sat, 18 Feb 2023 18:27:21 +0000
Date:   Sat, 18 Feb 2023 18:27:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        djwong@kernel.org, david@fromorbit.com, dan.j.williams@intel.com,
        hch@infradead.org, jane.chu@oracle.com, akpm@linux-foundation.org
Subject: Re: [PATCH v10 2/3] fs: introduce super_drop_pagecache()
Message-ID: <Y/EYiSTpjhvjxpUw@casper.infradead.org>
References: <1676645312-13-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1676645312-13-3-git-send-email-ruansy.fnst@fujitsu.com>
 <Y++n53dzkCsH1qeK@casper.infradead.org>
 <d5e5c50f-6d16-5a52-e79d-3578acdc1d92@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5e5c50f-6d16-5a52-e79d-3578acdc1d92@fujitsu.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 18, 2023 at 09:16:43AM +0800, Shiyang Ruan wrote:
> 在 2023/2/18 0:14, Matthew Wilcox 写道:
> > On Fri, Feb 17, 2023 at 02:48:31PM +0000, Shiyang Ruan wrote:
> > > -		invalidate_mapping_pages(inode->i_mapping, 0, -1);
> > > -		iput(toput_inode);
> > > -		toput_inode = inode;
> > > -
> > > -		cond_resched();
> > > -		spin_lock(&sb->s_inode_list_lock);
> > > -	}
> > > -	spin_unlock(&sb->s_inode_list_lock);
> > > -	iput(toput_inode);
> > > +	super_drop_pagecache(sb, invalidate_inode_pages);
> > 
> > I thought I explained last time that you can do this with
> > invalidate_mapping_pages() / invalidate_inode_pages2_range() ?
> > Then you don't need to introduce invalidate_inode_pages().
> > 
> > > +void super_drop_pagecache(struct super_block *sb,
> > > +	int (*invalidator)(struct address_space *))
> > 
> > void super_drop_pagecache(struct super_block *sb,
> > 		int (*invalidate)(struct address_space *, pgoff_t, pgoff_t))
> > 
> > > +		invalidator(inode->i_mapping);
> > 
> > 		invalidate(inode->i_mapping, 0, -1)
> > 
> > ... then all the changes to mm/truncate.c and filemap.h go away.
> 
> Yes, I tried as you suggested, but I found that they don't have same type of
> return value.
> 
> int invalidate_inode_pages2_range(struct address_space *mapping,
> 				  pgoff_t start, pgoff_t end);
> 
> unsigned long invalidate_mapping_pages(struct address_space *mapping,
> 		pgoff_t start, pgoff_t end);

Oh, that's annoying.  Particularly annoying is that the return value
for invalidate_mapping_pages() is used by fs/inode.c to account for
the number of pages invalidate, and the return value for
invalidate_inode_pages2_range() is used by several filesystems
to know whether an error occurred.

Hm.  Shouldn't you be checking for an error from
invalidate_inode_pages2_range()?  Seems like it can return -EBUSY for
DAX entries.

With that in mind, the wrapper you actually want to exist is

static int invalidate_inode_pages_range(struct address_space *mapping,
				pgoff_t start, pgoff_t end)
{
	invalidate_mapping_pages(mapping, start, end);
	return 0;
}

Right?
