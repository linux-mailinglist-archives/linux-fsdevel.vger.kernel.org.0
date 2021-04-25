Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6791C36A7BD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Apr 2021 16:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhDYORW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Apr 2021 10:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbhDYORR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Apr 2021 10:17:17 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A935DC06138B;
        Sun, 25 Apr 2021 07:16:37 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lafYp-008Arj-GM; Sun, 25 Apr 2021 14:16:35 +0000
Date:   Sun, 25 Apr 2021 14:16:35 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Dave Wysochanski <dwysocha@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/31] iov_iter: Add ITER_XARRAY
Message-ID: <YIV5wyBWC18/DAoU@zeniv-ca.linux.org.uk>
References: <YIVrJT8GwLI0Wlgx@zeniv-ca.linux.org.uk>
 <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
 <161918448151.3145707.11541538916600921083.stgit@warthog.procyon.org.uk>
 <3388475.1619359082@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3388475.1619359082@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 25, 2021 at 02:58:02PM +0100, David Howells wrote:

> But for the moment, I guess I should just add:
> 
> 	i->iov_offset += bytes;
> 
> to all three (kvec, bvec and xarray)?

No.  First of all, you'd need ->count updated as well; for kvec and bvec you
*REALLY* don't have to end up with ->iov_offset exceeding the size of current
kvec or bvec resp.; Bad Shit(tm) happens that way.

> 
> > > @@ -1246,7 +1349,8 @@ unsigned long iov_iter_alignment(const struct iov_iter *i)
> > >  	iterate_all_kinds(i, size, v,
> > >  		(res |= (unsigned long)v.iov_base | v.iov_len, 0),
> > >  		res |= v.bv_offset | v.bv_len,
> > > -		res |= (unsigned long)v.iov_base | v.iov_len
> > > +		res |= (unsigned long)v.iov_base | v.iov_len,
> > > +		res |= v.bv_offset | v.bv_len
> > >  	)
> > >  	return res;
> > >  }
> > 
> > Hmm...  That looks like a really bad overkill - do you need anything beyond
> > count and iov_offset in that case + perhaps "do we have the very last page"?
> > IOW, do you need to iterate anything at all here?  What am I missing here?
> 
> Good point.  I wonder, even, if the alignment could just be set to 1.  There's
> no kdoc description on the function that says what the result is meant to
> represent.

Huh?  It's the worst alignment of all segment boundaries, what else?  As in
if (iov_iter_alignment(i) & 1023)
	// we have something in there that isn't 1K-aligned.

