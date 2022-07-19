Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA9F57AA5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 01:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbiGSXSs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 19:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiGSXSs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 19:18:48 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72755643E9;
        Tue, 19 Jul 2022 16:18:46 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 43FF662C936;
        Wed, 20 Jul 2022 09:18:44 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oDwUE-002wMR-38; Wed, 20 Jul 2022 09:18:42 +1000
Date:   Wed, 20 Jul 2022 09:18:42 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Message-ID: <20220719231842.GM3600936@dread.disaster.area>
References: <20220715184433.838521-1-anna@kernel.org>
 <20220715184433.838521-7-anna@kernel.org>
 <EC97C20D-A317-49F9-8280-062D1AAEE49A@oracle.com>
 <20220718011552.GK3600936@dread.disaster.area>
 <5A400446-A6FD-436B-BDE2-DAD61239F98F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A400446-A6FD-436B-BDE2-DAD61239F98F@oracle.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62d73bd4
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=7-415B0cAAAA:8 a=VwQbUJbxAAAA:8
        a=W8QhFI2ueDrvgjlhSKsA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
        a=AjGcO6oz07-iQ99wixmX:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 19, 2022 at 05:21:21PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jul 17, 2022, at 9:15 PM, Dave Chinner <david@fromorbit.com> wrote:
> > 
> > On Fri, Jul 15, 2022 at 07:08:13PM +0000, Chuck Lever III wrote:
> >>> On Jul 15, 2022, at 2:44 PM, Anna Schumaker <anna@kernel.org> wrote:
> >>> 
> >>> +nfsd4_encode_read_plus_segments(struct nfsd4_compoundres *resp,
> >>> +				struct nfsd4_read *read,
> >>> +				unsigned int *segments, u32 *eof)
> >>> {
> >>> -	struct file *file = read->rd_nf->nf_file;
> >>> -	loff_t data_pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
> >>> -	loff_t f_size = i_size_read(file_inode(file));
> >>> -	unsigned long count;
> >>> -	__be32 *p;
> >>> +	struct xdr_stream *xdr = resp->xdr;
> >>> +	unsigned int bufpos = xdr->buf->len;
> >>> +	u64 offset = read->rd_offset;
> >>> +	struct read_plus_segment segment;
> >>> +	enum data_content4 pagetype;
> >>> +	unsigned long maxcount;
> >>> +	unsigned int pagenum = 0;
> >>> +	unsigned int pagelen;
> >>> +	char *vpage, *p;
> >>> +	__be32 nfserr;
> >>> 
> >>> -	if (data_pos == -ENXIO)
> >>> -		data_pos = f_size;
> >>> -	else if (data_pos <= read->rd_offset || (data_pos < f_size && data_pos % PAGE_SIZE))
> >>> -		return nfsd4_encode_read_plus_data(resp, read, maxcount, eof, &f_size);
> >>> -	count = data_pos - read->rd_offset;
> >>> -
> >>> -	/* Content type, offset, byte count */
> >>> -	p = xdr_reserve_space(resp->xdr, 4 + 8 + 8);
> >>> -	if (!p)
> >>> +	/* enough space for a HOLE segment before we switch to the pages */
> >>> +	if (!xdr_reserve_space(xdr, 5 * XDR_UNIT))
> >>> 		return nfserr_resource;
> >>> +	xdr_commit_encode(xdr);
> >>> 
> >>> -	*p++ = htonl(NFS4_CONTENT_HOLE);
> >>> -	p = xdr_encode_hyper(p, read->rd_offset);
> >>> -	p = xdr_encode_hyper(p, count);
> >>> +	maxcount = min_t(unsigned long, read->rd_length,
> >>> +			 (xdr->buf->buflen - xdr->buf->len));
> >>> 
> >>> -	*eof = (read->rd_offset + count) >= f_size;
> >>> -	*maxcount = min_t(unsigned long, count, *maxcount);
> >>> +	nfserr = nfsd4_read_plus_readv(resp, read, &maxcount, eof);
> >>> +	if (nfserr)
> >>> +		return nfserr;
> >>> +
> >>> +	while (maxcount > 0) {
> >>> +		vpage = xdr_buf_nth_page_address(xdr->buf, pagenum, &pagelen);
> >>> +		pagelen = min_t(unsigned int, pagelen, maxcount);
> >>> +		if (!vpage || pagelen == 0)
> >>> +			break;
> >>> +		p = memchr_inv(vpage, 0, pagelen);
> >> 
> >> I'm still not happy about touching every byte in each READ_PLUS
> >> payload. I think even though the rest of this work is merge-ready,
> >> this is a brute-force mechanism that's OK for a proof of concept
> >> but not appropriate for production-ready code.
> > 
> > Seems like a step backwards as it defeats the benefit zero-copy read
> > IO paths on the server side....
> 
> Tom Haynes' vision for READ_PLUS was to eventually replace the
> legacy READ operation. That means READ_PLUS(CONTENT_DATA) needs
> to be as fast and efficient as plain READ. (It would be great
> to use splice reads for CONTENT_DATA if we can!)
> 
> But I also thought the purpose of READ_PLUS was to help clients
> preserve unallocated extents in files during copy operations.

That's not a good idea. Userspace can't rely on the file layout
remaining unchanged while the copy is in progress. It's the
fundamental flaw in cp using FIEMAP - it will miss data that is in
memory over unwritten extents because it thinks that unwritten
extents are holes. Fundamentally, extent data is stale the moment the
filesystem inode is unlocked by the IO path, so you cannot rely on
it being accurate and correct anywhere but deep in the filesystem
implementation itself while the data is being read from or written
to the extent.

SEEK_HOLE/DATA is the best compromise for that which we have as it
considers the data ranges in the file, not the on-disk state.
However, if the extents are remote (i.e. in the case of NFS) then
there can still be massive TOCTOU race conditions in using
SEEK_HOLE/DATA at the client for determining the sparse regions of
the data - the client needs to hold an exclusive delegation on the
source file it is copying to ensure no other client changes the
layout while it is trying to perform the sparse copy....

Essentially, there is no safe way to do sparse copies short of
a filesystem having native offload support for either FI_CLONERANGE
(reflink) or copy_file_range() that allows the filesystem to make an
atomic duplicate of the source file....

> An unallocated extent is not the same as an allocated extent
> that has zeroes written into it.

Yes, but it is also also not the same as an unwritten extent, which
is an allocated extent that has a special "unwritten" flag in it.
SEEK_HOLE/DATA will present these as holes (i.e. zero
filled data), unless there is dirty data in memory over it in which case
they are DATA.

This is the key distinction between FIEMAP and SEEK_HOLE/DATA -
FIEMAP reports purely the on-disk filesystem extent state, while
SEEK_HOLE/DATA returns information about the *contents* of the file.

IOWs, if you are thinking about READ_PLUS in terms of the underlying
file layout, then you are thinking about it incorrectly. READ_PLUS
encodes information about the data it returns, not the layout of the
file the data came from.

> IIUC this new logic does not
> distinguish between those two cases at all. (And please correct
> me if this is really not the goal of READ_PLUS).

From 15 years ago when I was last deeply involved in NFS, the whole
discussion around eventual NFSv4 support for sparse reads was about
how to acheive server and network bandwidth reduction for really
large sparse files. e.g. sparse matrix files used in HPC might be
TBs in size, but are almost entirely zeros. Shipping TBs of zeros to
each of the thousands of clients in the HPC cluster is not in any
way efficient...

And, quite frankly, when you have large sparse read-only source
files like this that might be accessed by thousands of clients, the
last thing you want the server to be doing is populating the page
cache with of TBs of zeros just so it can read the zeroes to punch
them out of the encoded response to every read operation.

> I would like to retain precise detection of unallocated extents
> in files. Maybe SEEK_HOLE/SEEK_DATA is not how to do that, but
> my feeling is that checking for zero bytes is definitely not
> the way to do it.

SEEK_HOLE/DATA is the only way to do this "safely" in a generic
manner. But as I mentioned in my response to Anna, it seems like
entirely the wrong way to go about implementing efficient sparse
reads that reflect the state of the data as accurately as using
memchr_inv() after the fact to punch out zeroed holes in the data...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
