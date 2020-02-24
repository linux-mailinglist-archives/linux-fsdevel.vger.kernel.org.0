Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1F516B347
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 22:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgBXVyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 16:54:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39910 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgBXVyO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=APtxhiGX2oo2NuFWECGVLQtSqhQUVX091Swo9E3jyGQ=; b=k4YHtYQMII9XuUXNa7K98f5Lr8
        8kxvJ/tzbiUBK0u8QPQlhc0S7pbYmtD+Kp/ADfY06g04+syMs0jiIxgreUVqaL2jTdxfVFgmvRJIq
        oTmznOvFRzH5WSEJ9IWPTFDJ+erRAgDrH/RmPUBzK601Fwa6IdIoQ6C3fegnBHogmdc5w+2qvj5gY
        azQCmdMraUIHucXS6vJTgsz3Fe5JuP/OkXHWU/LXgR0E4YJ9UfZD+tC1vsf+PL62iedbWaYajeqcO
        g6/F6Ohsx0R3d7CnbruJ/vQynXFS4X6INJIgfA7SRCec91PJ4VA+gJ2wESYF19FEGFB+fvp/elqYF
        ZWBJCgSg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6Lg6-0004ll-A1; Mon, 24 Feb 2020 21:54:14 +0000
Date:   Mon, 24 Feb 2020 13:54:14 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
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
Message-ID: <20200224215414.GR24185@bombadil.infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-15-willy@infradead.org>
 <SN4PR0401MB35987D7B76007B93B1C5CE5E9B130@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200220134849.GV24185@bombadil.infradead.org>
 <20200220154658.GA19577@infradead.org>
 <20200220155452.GX24185@bombadil.infradead.org>
 <20200220155727.GA32232@infradead.org>
 <20200224214347.GH13895@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200224214347.GH13895@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 24, 2020 at 01:43:47PM -0800, Christoph Hellwig wrote:
> On Thu, Feb 20, 2020 at 07:57:27AM -0800, Christoph Hellwig wrote:
> > On Thu, Feb 20, 2020 at 07:54:52AM -0800, Matthew Wilcox wrote:
> > > On Thu, Feb 20, 2020 at 07:46:58AM -0800, Christoph Hellwig wrote:
> > > > On Thu, Feb 20, 2020 at 05:48:49AM -0800, Matthew Wilcox wrote:
> > > > > btrfs: Convert from readpages to readahead
> > > > >   
> > > > > Implement the new readahead method in btrfs.  Add a readahead_page_batch()
> > > > > to optimise fetching a batch of pages at once.
> > > > 
> > > > Shouldn't this readahead_page_batch heper go into a separate patch so
> > > > that it clearly stands out?
> > > 
> > > I'll move it into 'Put readahead pages in cache earlier' for v8 (the
> > > same patch where we add readahead_page())
> > 
> > One argument for keeping it in a patch of its own is that btrfs appears
> > to be the only user, and Goldwyn has a WIP conversion of btrfs to iomap,
> > so it might go away pretty soon and we could just revert the commit.
> > 
> > But this starts to get into really minor details, so I'll shut up now :)
> 
> So looking at this again I have another comment and a question.
> 
> First I think the implicit ARRAY_SIZE in readahead_page_batch is highly
> dangerous, as it will do the wrong thing when passing a pointer or
> function argument.

somebody already thought of that ;-)

#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))

> Second I wonder іf it would be worth to also switch to a batched
> operation in iomap if the xarray overhead is high enough.  That should
> be pretty trivial, but we don't really need to do it in this series.

I've also considered keeping a small array of pointers inside the
readahead_control so nobody needs to have a readahead_page_batch()
operation.  Even keeping 10 pointers in there will reduce the XArray
overhead by 90%.  But this fit the current btrfs model well, and it
lets us play with different approaches by abstracting everything away.
I'm sure this won't be the last patch that touches the readahead code ;-)
