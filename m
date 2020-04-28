Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE981BBC2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 13:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgD1LQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 07:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgD1LQh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:16:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B78C03C1A9;
        Tue, 28 Apr 2020 04:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=u2H9SL+UMErMdRB2YXU6A5uO+y4zqg8b68UfJIqKHUU=; b=BbEv0tv/tpdRIsWJ5h4Vm4N5uQ
        N6PimFztig63e/oRDUJ0P7VhoKLjfva0KIy4rlZjQ2OheYN1i8n/GKpj2swy49MNk/3u3jcNMaGvn
        ye/iybuk4S7mglrs/hNIx6WJySktdeNKwPTGx/RPP0xLx6DFnyk4a0jqJCX6BncQiuHkzfusZOPPh
        bMgyUGN91SR7w+nOOebqqyYc7/cJ5mH98QgOYiw1Yk0d8xv1IGMzJwM0OBwI00wIucyImvp4Lg9um
        NaXoPXFKBqIYa/RLoTWaGGtZWGiiOvDLiQiQZFwaJAE7rHjxktGJjWcGK1wg+u+micKtkLYptCD2i
        cVFpmLJw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTOE8-0002zk-5p; Tue, 28 Apr 2020 11:16:36 +0000
Date:   Tue, 28 Apr 2020 04:16:36 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        "Qi, Fuli" <qi.fuli@fujitsu.com>,
        "Gotou, Yasunori" <y-goto@fujitsu.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBSZQ==?= =?utf-8?Q?=3A?= [RFC PATCH 0/8]
 dax: Add a dax-rmap tree to support reflink
Message-ID: <20200428111636.GK29705@bombadil.infradead.org>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
 <20200427122836.GD29705@bombadil.infradead.org>
 <em33c55fa5-15ca-4c46-8c27-6b0300fa4e51@g08fnstd180058>
 <20200428064318.GG2040@dread.disaster.area>
 <259fe633-e1ff-b279-cd8c-1a81eaa40941@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <259fe633-e1ff-b279-cd8c-1a81eaa40941@cn.fujitsu.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 05:32:41PM +0800, Ruan Shiyang wrote:
> On 2020/4/28 下午2:43, Dave Chinner wrote:
> > On Tue, Apr 28, 2020 at 06:09:47AM +0000, Ruan, Shiyang wrote:
> > > 在 2020/4/27 20:28:36, "Matthew Wilcox" <willy@infradead.org> 写道:
> > > > On Mon, Apr 27, 2020 at 04:47:42PM +0800, Shiyang Ruan wrote:
> > > > >   This patchset is a try to resolve the shared 'page cache' problem for
> > > > >   fsdax.
> > > > > 
> > > > >   In order to track multiple mappings and indexes on one page, I
> > > > >   introduced a dax-rmap rb-tree to manage the relationship.  A dax entry
> > > > >   will be associated more than once if is shared.  At the second time we
> > > > >   associate this entry, we create this rb-tree and store its root in
> > > > >   page->private(not used in fsdax).  Insert (->mapping, ->index) when
> > > > >   dax_associate_entry() and delete it when dax_disassociate_entry().
> > > > 
> > > > Do we really want to track all of this on a per-page basis?  I would
> > > > have thought a per-extent basis was more useful.  Essentially, create
> > > > a new address_space for each shared extent.  Per page just seems like
> > > > a huge overhead.
> > > > 
> > > Per-extent tracking is a nice idea for me.  I haven't thought of it
> > > yet...
> > > 
> > > But the extent info is maintained by filesystem.  I think we need a way
> > > to obtain this info from FS when associating a page.  May be a bit
> > > complicated.  Let me think about it...
> > 
> > That's why I want the -user of this association- to do a filesystem
> > callout instead of keeping it's own naive tracking infrastructure.
> > The filesystem can do an efficient, on-demand reverse mapping lookup
> > from it's own extent tracking infrastructure, and there's zero
> > runtime overhead when there are no errors present.
> > 
> > At the moment, this "dax association" is used to "report" a storage
> > media error directly to userspace. I say "report" because what it
> > does is kill userspace processes dead. The storage media error
> > actually needs to be reported to the owner of the storage media,
> > which in the case of FS-DAX is the filesytem.
> 
> Understood.
> 
> BTW, this is the usage in memory-failure, so what about rmap?  I have not
> found how to use this tracking in rmap.  Do you have any ideas?
> 
> > 
> > That way the filesystem can then look up all the owners of that bad
> > media range (i.e. the filesystem block it corresponds to) and take
> > appropriate action. e.g.
> 
> I tried writing a function to look up all the owners' info of one block in
> xfs for memory-failure use.  It was dropped in this patchset because I found
> out that this lookup function needs 'rmapbt' to be enabled when mkfs.  But
> by default, rmapbt is disabled.  I am not sure if it matters...

I'm pretty sure you can't have shared extents on an XFS filesystem if you
_don't_ have the rmapbt feature enabled.  I mean, that's why it exists.
