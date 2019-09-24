Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 826BABD3D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 22:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633180AbfIXUvo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 16:51:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43866 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731288AbfIXUvn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 16:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+v9rUtMVLbceJYUrls0UAlCyrXq767IWhnxlCJpL7sY=; b=C9iEGEnKl6h5EiBPyWUTj+JpT
        uLY3285XCKnxDiiV+/TdezXJUYrO9Z1d+M85J5PS7/QEWylR1Kz74VJC86ovh8PtG6TJnDQwBooov
        M4CQSwewUvpMt4tp4Ilp0NZTttuXajXOGqQpZfcDqKQUBa8yl/7sWmifirAVWTNhx+BFmupzRJRMK
        IfiUoBQzq6eEdi1XU9TYkqWcr/t/DQ+CSiMGyty28VzbgVOSU4R1i5zl+QAtQJXJkTo/OxT1hFydF
        77PmcrS+yO2XyCYZZ+rhk9F9aIvS276E+PGmW60r4uMYUpFfCQZKiZZt7+hkwc8DGt7Ul4cInMm/q
        tcB4/BSyA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCrmX-0005ZA-S8; Tue, 24 Sep 2019 20:51:33 +0000
Date:   Tue, 24 Sep 2019 13:51:33 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     cl@linux.com
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>, dsterba@suse.cz,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-btrfs@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 2/2] mm, sl[aou]b: guarantee natural alignment for
 kmalloc(power-of-two)
Message-ID: <20190924205133.GK1855@bombadil.infradead.org>
References: <20190826111627.7505-1-vbabka@suse.cz>
 <20190826111627.7505-3-vbabka@suse.cz>
 <df8d1cf4-ff8f-1ee1-12fb-cfec39131b32@suse.cz>
 <20190923171710.GN2751@twin.jikos.cz>
 <20190923175146.GT2229799@magnolia>
 <alpine.DEB.2.21.1909242045250.17661@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1909242045250.17661@www.lameter.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 08:47:52PM +0000, cl@linux.com wrote:
> On Mon, 23 Sep 2019, Darrick J. Wong wrote:
> 
> > On Mon, Sep 23, 2019 at 07:17:10PM +0200, David Sterba wrote:
> > > On Mon, Sep 23, 2019 at 06:36:32PM +0200, Vlastimil Babka wrote:
> > > > So if anyone thinks this is a good idea, please express it (preferably
> > > > in a formal way such as Acked-by), otherwise it seems the patch will be
> > > > dropped (due to a private NACK, apparently).
> >
> > Oh, I didn't realize  ^^^^^^^^^^^^ that *some* of us are allowed the
> > privilege of gutting a patch via private NAK without any of that open
> > development discussion incovenience. <grumble>
> 
> There was a public discussion about this issue and from what I can tell
> the outcome was that the allocator already provides what you want. Which
> was a mechanism to misalign objects and detect these issues. This
> mechanism has been in use for over a decade.

You missed the important part, which was *ENABLED BY DEFAULT*.  People
who are enabling a debugging option to debug their issues, should not
have to first debug all the other issues that enabling that debugging
option uncovers!
