Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E147C163B94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 04:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgBSDrn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 22:47:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgBSDrn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 22:47:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i/xcm0BfIZoUOgtJ9Kb7+ENMgRO8MVFTO+YgYUUmnnU=; b=sMeTw1fz0AtXWv4h5McRaI0hCC
        OIeMYm4j5TaxU6/S+PNsormwo6Bir4wd3qqGXl+GGGR9ekz3hzBXljkYHgg49p+g8cXAmtP2rs6k3
        69dcsD1yVpFMMZPVBgJM2M6dUtwSbV8XzDOOXM1+rQ8x8Tgn7iTWBfWCzxF5LPjzKG8tHjIZgCd5o
        o+iDKzs+iuYHb0nWK7CgfwUKvGVxa1DpfmuaYH6dzHmEMJGYSROvOuIy/F02GpS2f4BnOSoK7htCK
        dj9wRqSeArzQt/ea/tpsDBkyItAgPHmM8u//+U1zx2sHOilh75WFAwV2VrYfOZ/IlTmzStwZqicCC
        ZgaRjdug==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4GKs-0001V5-0u; Wed, 19 Feb 2020 03:47:42 +0000
Date:   Tue, 18 Feb 2020 19:47:41 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Junxiao Bi <junxiao.bi@oracle.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
        linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 10/19] fs: Convert mpage_readpages to mpage_readahead
Message-ID: <20200219034741.GK24185@bombadil.infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-18-willy@infradead.org>
 <20200219032826.GB1075@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219032826.GB1075@sol.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 07:28:26PM -0800, Eric Biggers wrote:
> On Mon, Feb 17, 2020 at 10:45:58AM -0800, Matthew Wilcox wrote:
> > diff --git a/include/linux/mpage.h b/include/linux/mpage.h
> > index 001f1fcf9836..f4f5e90a6844 100644
> > --- a/include/linux/mpage.h
> > +++ b/include/linux/mpage.h
> > @@ -13,9 +13,9 @@
> >  #ifdef CONFIG_BLOCK
> >  
> >  struct writeback_control;
> > +struct readahead_control;
> >  
> > -int mpage_readpages(struct address_space *mapping, struct list_head *pages,
> > -				unsigned nr_pages, get_block_t get_block);
> > +void mpage_readahead(struct readahead_control *, get_block_t get_block);
> >  int mpage_readpage(struct page *page, get_block_t get_block);
> >  int mpage_writepages(struct address_space *mapping,
> >  		struct writeback_control *wbc, get_block_t get_block);
> 
> Can you name the 'struct readahead_control *' parameter?

What good would that do?  I'm sick of seeing 'struct page *page'.
Well, no shit it's a page.  Unless there's some actual information to
convey, leave the argument unnamed.  It should be a crime to not name
an unsigned long, but not naming the struct address_space pointer is
entirely reasonable.
