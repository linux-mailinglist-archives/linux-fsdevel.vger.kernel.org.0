Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08531250EF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 04:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgHYCWa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 22:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgHYCW1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:22:27 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B02C061574;
        Mon, 24 Aug 2020 19:22:27 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAObM-004FIh-0R; Tue, 25 Aug 2020 02:22:20 +0000
Date:   Tue, 25 Aug 2020 03:22:19 +0100
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
Message-ID: <20200825022219.GW1236603@ZenIV.linux.org.uk>
References: <20200822042059.1805541-1-jhubbard@nvidia.com>
 <20200825015428.GU1236603@ZenIV.linux.org.uk>
 <3072d5a0-43c7-3396-c57f-6af83621b71c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3072d5a0-43c7-3396-c57f-6af83621b71c@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 24, 2020 at 07:07:02PM -0700, John Hubbard wrote:
> On 8/24/20 6:54 PM, Al Viro wrote:
> > On Fri, Aug 21, 2020 at 09:20:54PM -0700, John Hubbard wrote:
> > 
> > > Direct IO behavior:
> > > 
> > >      ITER_IOVEC:
> > >          pin_user_pages_fast();
> > >          break;
> > > 
> > >      ITER_KVEC:    // already elevated page refcount, leave alone
> > >      ITER_BVEC:    // already elevated page refcount, leave alone
> > >      ITER_PIPE:    // just, no :)
> > 
> > Why?  What's wrong with splice to O_DIRECT file?
> > 
> 
> Oh! I'll take a look. Is this the fs/splice.c stuff?  I ruled this out early
> mainly based on Christoph's comment in [1] ("ITER_PIPE is rejected іn the
> direct I/O path"), but if it's supportable then I'll hook it up.

; cat >a.c <<'EOF'
#define _GNU_SOURCE
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>

int main()
{
        int fd = open("./a.out", O_DIRECT);
        splice(fd, NULL, 1, NULL, 4096, 0);
	return 0;
}
EOF
; cc a.c
; ./a.out | wc -c
4096

and you just had ->read_iter() called with ITER_PIPE destination.
