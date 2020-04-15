Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D274D1A9C10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 13:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896908AbgDOLWp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 07:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896897AbgDOLWS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:22:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4600C061A0C;
        Wed, 15 Apr 2020 04:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p5k96MLyrJ0Kc/9UM6Xw8FfLDEnTX/dVH39aK5qAXAA=; b=ClQLKHw92puBJhU2nimC3BH8wA
        355osRMfVxhDQVssm7Zm9jE6v3E3dRGs+Oc5jFRy3/jQbyNAsfVORzBRmGEfW7/HIf4gbDH2d4DT2
        gL3rNu+X2XBNBJ3NpW/Bx0FlYJMdgdadGJM/y2cHwCtDUUl9b+KcgcTHyz2DkqV52KYqOQaeHmfVH
        s2D+J2WiHScmuPaZ+HVg8gSTWAFyV0P0cKjdmyQFi/TapX8CRjBU8aFB/npLmiZAvjPQMvj6Rpgij
        Vy0bfVHN0vosqBiQDXjyzG7mDrHdrpJGmw7wYW8mNvb2TBTAiSuOkc9Tu/G2eouAmkldMad/NLN38
        jgC7ixKA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOg7U-0004jU-L2; Wed, 15 Apr 2020 11:22:16 +0000
Date:   Wed, 15 Apr 2020 04:22:16 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v11 05/25] mm: Add new readahead_control API
Message-ID: <20200415112216.GC5820@bombadil.infradead.org>
References: <20200414150233.24495-1-willy@infradead.org>
 <20200414150233.24495-6-willy@infradead.org>
 <20200414181705.bfc4c0087092051a9475141e@linux-foundation.org>
 <20200415021808.GA5820@bombadil.infradead.org>
 <20200414215616.f665d12f8549f52606784d1e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414215616.f665d12f8549f52606784d1e@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 09:56:16PM -0700, Andrew Morton wrote:
> On Tue, 14 Apr 2020 19:18:08 -0700 Matthew Wilcox <willy@infradead.org> wrote:
> > Hmm.  They don't seem that big to me.
> 
> They're really big!

v5.7-rc1:	11636	    636	    224	  12496	   30d0	fs/iomap/buffered-io.o
readahead_v11:	11528	    636	    224	  12388	   3064	fs/iomap/buffered-io.o

> > __readahead_batch is much bigger, but it's only used by btrfs and fuse,
> > and it seemed unfair to make everybody pay the cost for a function only
> > used by two filesystems.
> 
> Do we expect more filesystems to use these in the future?

I'm honestly not sure.  I think it'd be nice to be able to fill a bvec
from the page cache directly, but I haven't tried to write that function
yet.  If so, then it'd be appropriate to move that functionality into
the core.

> > > The code adds quite a few (inlined!) VM_BUG_ONs.  Can we plan to remove
> > > them at some stage?  Such as, before Linus shouts at us :)
> > 
> > I'd be happy to remove them.  Various reviewers said things like "are you
> > sure this can't happen?"
> 
> Yeah, these things tend to live for ever.  Please add a todo to remove
> them after the code has matured?

Sure!  I'm touching this code some more in the large pages patch set, so
I can get rid of it there.
