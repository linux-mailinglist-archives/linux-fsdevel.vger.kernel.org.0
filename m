Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36AA0163BAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 04:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgBSDzx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 22:55:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:46268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgBSDzx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 22:55:53 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCCEB206DB;
        Wed, 19 Feb 2020 03:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582084552;
        bh=ra63ctCM03qQ/yjMX6m08SRFO6UdUhDwmhqww51jeug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cHpc7qeSZ/gAs6+Ko/Z9/c8wDmwW8WTd6Y9ysIVgBbEI5SGfvT8WdEDSgJvrnpRtd
         JfJgLR87X7pDZj1ZfCs4p5yM6PqBSZH+kh5NSfb+dGb2Fgl12LstCggu8oVIaphCC5
         XsxYNaY/zixWmZHQTqiVBZLArwLDm8F1awAYyw38=
Date:   Tue, 18 Feb 2020 19:55:50 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Junxiao Bi <junxiao.bi@oracle.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
        linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 10/19] fs: Convert mpage_readpages to mpage_readahead
Message-ID: <20200219035550.GE1075@sol.localdomain>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-18-willy@infradead.org>
 <20200219032826.GB1075@sol.localdomain>
 <20200219034741.GK24185@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219034741.GK24185@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 07:47:41PM -0800, Matthew Wilcox wrote:
> On Tue, Feb 18, 2020 at 07:28:26PM -0800, Eric Biggers wrote:
> > On Mon, Feb 17, 2020 at 10:45:58AM -0800, Matthew Wilcox wrote:
> > > diff --git a/include/linux/mpage.h b/include/linux/mpage.h
> > > index 001f1fcf9836..f4f5e90a6844 100644
> > > --- a/include/linux/mpage.h
> > > +++ b/include/linux/mpage.h
> > > @@ -13,9 +13,9 @@
> > >  #ifdef CONFIG_BLOCK
> > >  
> > >  struct writeback_control;
> > > +struct readahead_control;
> > >  
> > > -int mpage_readpages(struct address_space *mapping, struct list_head *pages,
> > > -				unsigned nr_pages, get_block_t get_block);
> > > +void mpage_readahead(struct readahead_control *, get_block_t get_block);
> > >  int mpage_readpage(struct page *page, get_block_t get_block);
> > >  int mpage_writepages(struct address_space *mapping,
> > >  		struct writeback_control *wbc, get_block_t get_block);
> > 
> > Can you name the 'struct readahead_control *' parameter?
> 
> What good would that do?  I'm sick of seeing 'struct page *page'.
> Well, no shit it's a page.  Unless there's some actual information to
> convey, leave the argument unnamed.  It should be a crime to not name
> an unsigned long, but not naming the struct address_space pointer is
> entirely reasonable.

It's the coding style the community has agreed on, so the tools check for.

I don't care that much myself; it just appeared like this was a mistake rather
than intentional so I thought I'd point it out.

- Eric
