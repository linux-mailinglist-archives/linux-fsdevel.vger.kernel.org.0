Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12F036B7D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 19:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbhDZRPY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 13:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbhDZRPW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:15:22 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3677C061574;
        Mon, 26 Apr 2021 10:14:39 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lb4ob-008SGJ-Lx; Mon, 26 Apr 2021 17:14:33 +0000
Date:   Mon, 26 Apr 2021 17:14:33 +0000
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
Subject: Re: [PATCH] iov_iter: Four fixes for ITER_XARRAY
Message-ID: <YIb0+b7VJJrrofCB@zeniv-ca.linux.org.uk>
References: <161918448151.3145707.11541538916600921083.stgit@warthog.procyon.org.uk>
 <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
 <3545034.1619392490@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3545034.1619392490@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 26, 2021 at 12:14:50AM +0100, David Howells wrote:
> Hi Al,
> 
> I think this patch should include all the fixes necessary.  I could merge
> it in, but I think it might be better to tag it on the end as an additional
> patch.

Looks sane, but I wonder if it would've been better to deal with this

> @@ -791,6 +791,8 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
>  			curr_addr = (unsigned long) from;
>  			bytes = curr_addr - s_addr - rem;
>  			rcu_read_unlock();
> +			i->iov_offset += bytes;
> +			i->count -= bytes;
>  			return bytes;
>  		}
>  		})

by having your iterator check the return value of X callback and, having
decremented .bv_len by return value, broke out of the loop.

       __label__ __bugger_off;

       xas_for_each(&xas, head, ULONG_MAX) {                           \
               if (xas_retry(&xas, head))                              \
                       continue;                                       \
               if (WARN_ON(xa_is_value(head)))                         \
                       break;                                          \
               if (WARN_ON(PageHuge(head)))                            \
                       break;                                          \
               for (j = (head->index < index) ? index - head->index : 0; \
                    j < thp_nr_pages(head); j++) {                     \
                       __v.bv_page = head + j;                         \

			size_t left;

                       offset = (i->xarray_start + skip) & ~PAGE_MASK; \
                       seg = PAGE_SIZE - offset;                       \
                       __v.bv_offset = offset;                         \
                       __v.bv_len = min(n, seg);                       \

                       left = (STEP);
		       __v.bv_len -= left;

                       n -= __v.bv_len;                                \
                       skip += __v.bv_len;                             \

		       if (!n || left)
				goto __bugger_off;

               }                                                       \
               if (n == 0)                                             \
                       break;                                          \
       }                                                       \

__bugger_off:


Then rename iterate_and_advance() to __iterate_and_advance() and have
#define iterate_and_advance(....., X) __iterate_and_advance(....., ((void)(X),0))
with iterate_all_kinds() using iterate_xarray(....,((void)(X),0)

Then _copy_mc_to_iter() could use __iterate_and_advance(), getting rid of
the need of doing anything special in case of short copy.  OTOH, I can do
that myself in a followup - not a problem.
