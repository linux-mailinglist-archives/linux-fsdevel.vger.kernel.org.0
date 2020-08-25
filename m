Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB7D250EA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 04:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgHYCHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 22:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgHYCHG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:07:06 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6CAC061574;
        Mon, 24 Aug 2020 19:07:06 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAOMW-004EtK-7m; Tue, 25 Aug 2020 02:07:00 +0000
Date:   Tue, 25 Aug 2020 03:07:00 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] bio: Direct IO: convert to pin_user_pages_fast()
Message-ID: <20200825020700.GV1236603@ZenIV.linux.org.uk>
References: <20200822042059.1805541-1-jhubbard@nvidia.com>
 <20200825015428.GU1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825015428.GU1236603@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 25, 2020 at 02:54:28AM +0100, Al Viro wrote:
> On Fri, Aug 21, 2020 at 09:20:54PM -0700, John Hubbard wrote:
> 
> > Direct IO behavior:
> > 
> >     ITER_IOVEC:
> >         pin_user_pages_fast();
> >         break;
> > 
> >     ITER_KVEC:    // already elevated page refcount, leave alone
> >     ITER_BVEC:    // already elevated page refcount, leave alone
> >     ITER_PIPE:    // just, no :)
> 
> Why?  What's wrong with splice to O_DIRECT file?

Sorry - s/to/from/, obviously.

To spell it out: consider generic_file_splice_read() behaviour when
the source had been opened with O_DIRECT; you will get a call of
->read_iter() into ITER_PIPE destination.  And it bloody well
will hit iov_iter_get_pages() on common filesystems, to pick the
pages we want to read into.

So... what's wrong with having that "pin" primitive making sure
the pages are there and referenced by the pipe?
