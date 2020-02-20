Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00298166197
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 16:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgBTP52 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 10:57:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57658 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbgBTP52 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+/UHJ6F1pbYDweJDUZAgvqKfayrQBowwGTnz0WdYGiI=; b=otE+N0vtlyX9xN010Sejc78VWm
        +Z6Nhr8BvmGUNrIO9afuJHhxoLPaunjuFqSB3Vbfkg92cFJ3CGndTAJiSloW8688jbu+LsyPnwsfM
        7+EZh4a1KpVzbLiwzv7LZrgnYjvExYmxe48vBmhmvCOPmZ7sVJnLeHwyQwYksv3nnnaQLNldoXsYQ
        u1gQv6uFtIOengP5ajM30qweiLUQ49UDY3r+ygUvyonu17lsTwaYIiH/5oz7IhvQ4fhsYNWJY/9Ww
        eOATcZg8cPjWf2FcknrxS05+tCQGLf31jvSwLk8Ndl9n4CBxBjuYStE6NyuIbPzCKDkbX2IXV3hgI
        bWJ8ZdIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4oCd-0000Ht-HF; Thu, 20 Feb 2020 15:57:27 +0000
Date:   Thu, 20 Feb 2020 07:57:27 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v7 14/24] btrfs: Convert from readpages to readahead
Message-ID: <20200220155727.GA32232@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-15-willy@infradead.org>
 <SN4PR0401MB35987D7B76007B93B1C5CE5E9B130@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200220134849.GV24185@bombadil.infradead.org>
 <20200220154658.GA19577@infradead.org>
 <20200220155452.GX24185@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220155452.GX24185@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 07:54:52AM -0800, Matthew Wilcox wrote:
> On Thu, Feb 20, 2020 at 07:46:58AM -0800, Christoph Hellwig wrote:
> > On Thu, Feb 20, 2020 at 05:48:49AM -0800, Matthew Wilcox wrote:
> > > btrfs: Convert from readpages to readahead
> > >   
> > > Implement the new readahead method in btrfs.  Add a readahead_page_batch()
> > > to optimise fetching a batch of pages at once.
> > 
> > Shouldn't this readahead_page_batch heper go into a separate patch so
> > that it clearly stands out?
> 
> I'll move it into 'Put readahead pages in cache earlier' for v8 (the
> same patch where we add readahead_page())

One argument for keeping it in a patch of its own is that btrfs appears
to be the only user, and Goldwyn has a WIP conversion of btrfs to iomap,
so it might go away pretty soon and we could just revert the commit.

But this starts to get into really minor details, so I'll shut up now :)
