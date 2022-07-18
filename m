Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C1E577934
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 03:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiGRBQB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Jul 2022 21:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiGRBQA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Jul 2022 21:16:00 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A70C411806;
        Sun, 17 Jul 2022 18:15:58 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 781BD62C89D;
        Mon, 18 Jul 2022 11:15:54 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oDFMW-002BKH-MW; Mon, 18 Jul 2022 11:15:52 +1000
Date:   Mon, 18 Jul 2022 11:15:52 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Message-ID: <20220718011552.GK3600936@dread.disaster.area>
References: <20220715184433.838521-1-anna@kernel.org>
 <20220715184433.838521-7-anna@kernel.org>
 <EC97C20D-A317-49F9-8280-062D1AAEE49A@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EC97C20D-A317-49F9-8280-062D1AAEE49A@oracle.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62d4b44b
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=VwQbUJbxAAAA:8 a=JDjsHSkAAAAA:8
        a=7-415B0cAAAA:8 a=fWi2OyK2X19uTAQ67-EA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=dseMxAR1CDlncBZeV_se:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 15, 2022 at 07:08:13PM +0000, Chuck Lever III wrote:
> > On Jul 15, 2022, at 2:44 PM, Anna Schumaker <anna@kernel.org> wrote:
> > 
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > 
> > Rather than relying on the underlying filesystem to tell us where hole
> > and data segments are through vfs_llseek(), let's instead do the hole
> > compression ourselves. This has a few advantages over the old
> > implementation:
> > 
> > 1) A single call to the underlying filesystem through nfsd_readv() means
> >   the file can't change from underneath us in the middle of encoding.

Hi Anna,

I'm assuming you mean the vfs_llseek(SEEK_HOLE) call at the start
of nfsd4_encode_read_plus_data() that is used to trim the data that
has already been read out of the file?

What's the problem with racing with a hole punch here? All it does
is shorten the read data returned to match the new hole, so all it's
doing is making the returned data "more correct".

OTOH, if something allocates over a hole that the read filled with
zeros, what's the problem with occasionally returning zeros as data?
Regardless, if this has raced with a write to the file that filled
that hole, we're already returning stale data/hole information to
the client regardless of whether we trim it or not....

i.e. I can't see a correctness or data integrity problem here that
doesn't already exist, and I have my doubts that hole
punching/filling racing with reads happens often enough to create a
performance or bandwidth problem OTW. Hence I've really got no idea
what the problem that needs to be solved here is.

Can you explain what the symptoms of the problem a user would see
that this change solves?

> > 2) A single call to the underlying filestem also means that the
> >   underlying filesystem only needs to synchronize cached and on-disk
> >   data one time instead of potentially many speeding up the reply.

SEEK_HOLE/DATA doesn't require cached data to be sync'd to disk to
be coherent - that's only a problem FIEMAP has (and syncing cached
data doesn't fix the TOCTOU coherency issue!).  i.e. SEEK_HOLE/DATA
will check the page cache for data if appropriate (e.g. unwritten
disk extents may have data in memory over the top of them) instead
of syncing data to disk.

> > 3) Hole support for filesystems that don't support SEEK_HOLE and SEEK_DATA
> 
> Thanks for addressing my cosmetic comments! Looks good.
> 
> I'm still not clear why NFSD needs to support filesystems that
> do not support SEEK_HOLE/DATA. I'm guessing this is just a side
> benefit of the memchr_inv approach below, not really a goal of
> this overhaul?

Don't other mechanisms in NFSv4 require SEEK_HOLE/SEEK_DATA support?
ie. supporting a useful implementation of NFS4_CONTENT_DATA/
NFS4_CONTENT_HOLE across the wire?  Why doesn't that server side
implementations use memchr_inv() rather than allowing filesystems to
optimise away the data read requirement for the operation?

Or don't we care because what is returned to the client is *always*
going to have races with whatever the client decides what to do with
the information? If that's true, then why do we care if
nfsd4_encode_read_plus_data() may return some zeros instead of a
shorter read and a longer hole?

> One more comment below.
> 
> 
> > I also included an optimization where we can cut down on the amount of
> > memory being shifed around by doing the compression as (hole, data)
> > pairs.
> > 
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
> > fs/nfsd/nfs4xdr.c | 219 +++++++++++++++++++++++++---------------------
> > 1 file changed, 119 insertions(+), 100 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 61b2aae81abb..df8289fce4ef 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -4731,81 +4731,138 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
> > 	return nfserr;
> > }
> > 
> > +struct read_plus_segment {
> > +	enum data_content4	rp_type;
> > +	u64			rp_offset;
> > +	u64			rp_length;
> > +	unsigned int		rp_page_pos;
> > +};
> > +
> > static __be32
> > -nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> > -			    struct nfsd4_read *read,
> > -			    unsigned long *maxcount, u32 *eof,
> > -			    loff_t *pos)
> > +nfsd4_read_plus_readv(struct nfsd4_compoundres *resp, struct nfsd4_read *read,
> > +		      unsigned long *maxcount, u32 *eof)
> > {
> > 	struct xdr_stream *xdr = resp->xdr;
> > -	struct file *file = read->rd_nf->nf_file;
> > -	int starting_len = xdr->buf->len;
> > -	loff_t hole_pos;
> > -	__be32 nfserr;
> > -	__be32 *p, tmp;
> > -	__be64 tmp64;
> > -
> > -	hole_pos = pos ? *pos : vfs_llseek(file, read->rd_offset, SEEK_HOLE);
> > -	if (hole_pos > read->rd_offset)
> > -		*maxcount = min_t(unsigned long, *maxcount, hole_pos - read->rd_offset);
> > -	*maxcount = min_t(unsigned long, *maxcount, (xdr->buf->buflen - xdr->buf->len));
> > -
> > -	/* Content type, offset, byte count */
> > -	p = xdr_reserve_space(xdr, 4 + 8 + 4);
> > -	if (!p)
> > -		return nfserr_resource;
> > +	unsigned int starting_len = xdr->buf->len;
> > +	__be32 nfserr, zero = xdr_zero;
> > +	unsigned int pad;
> > 
> > +	/*
> > +	 * Reserve the maximum abount of space needed to craft a READ_PLUS
> > +	 * reply. The call to xdr_reserve_space_vec() switches us to the
> > +	 * xdr->pages, which we then read file data into before analyzing
> > +	 * the individual segments.
> > +	 */
> > 	read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, *maxcount);
> > 	if (read->rd_vlen < 0)
> > 		return nfserr_resource;
> > 
> > -	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
> > -			    resp->rqstp->rq_vec, read->rd_vlen, maxcount, eof);
> > +	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, read->rd_nf->nf_file,
> > +			    read->rd_offset, resp->rqstp->rq_vec, read->rd_vlen,
> > +			    maxcount, eof);
> > 	if (nfserr)
> > 		return nfserr;
> > -	xdr_truncate_encode(xdr, starting_len + 16 + xdr_align_size(*maxcount));
> > +	xdr_truncate_encode(xdr, starting_len + xdr_align_size(*maxcount));
> > 
> > -	tmp = htonl(NFS4_CONTENT_DATA);
> > -	write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
> > -	tmp64 = cpu_to_be64(read->rd_offset);
> > -	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
> > -	tmp = htonl(*maxcount);
> > -	write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
> > -
> > -	tmp = xdr_zero;
> > -	write_bytes_to_xdr_buf(xdr->buf, starting_len + 16 + *maxcount, &tmp,
> > -			       xdr_pad_size(*maxcount));
> > +	pad = xdr_pad_size(*maxcount);
> > +	write_bytes_to_xdr_buf(xdr->buf, starting_len + *maxcount, &zero, pad);
> > 	return nfs_ok;
> > }
> > 
> > +/**
> > + * nfsd4_encode_read_plus_segment - Encode a single READ_PLUS segment
> > + * @xdr: pointer to an xdr_stream
> > + * @segment: pointer to a single segment
> > + * @bufpos: xdr_stream offset to place the segment
> > + * @segments: pointer to the total number of segments seen
> > + *
> > + * Performs surgery on the xdr_stream to compress out HOLE segments and
> > + * to place DATA segments in the proper place.
> > + */
> > +static void
> > +nfsd4_encode_read_plus_segment(struct xdr_stream *xdr,
> > +			       struct read_plus_segment *segment,
> > +			       unsigned int *bufpos, unsigned int *segments)
> > +{
> > +	struct xdr_buf *buf = xdr->buf;
> > +
> > +	xdr_encode_word(buf, *bufpos, segment->rp_type);
> > +	xdr_encode_double(buf, *bufpos + XDR_UNIT, segment->rp_offset);
> > +	*bufpos += 3 * XDR_UNIT;
> > +
> > +	if (segment->rp_type == NFS4_CONTENT_HOLE) {
> > +		xdr_encode_double(buf, *bufpos, segment->rp_length);
> > +		*bufpos += 2 * XDR_UNIT;
> > +	} else {
> > +		size_t align = xdr_align_size(segment->rp_length);
> > +		xdr_encode_word(buf, *bufpos, segment->rp_length);
> > +		if (*segments == 0)
> > +			xdr_buf_trim_head(buf, XDR_UNIT);
> > +
> > +		xdr_stream_move_subsegment(xdr,
> > +				buf->head[0].iov_len + segment->rp_page_pos,
> > +				*bufpos + XDR_UNIT, align);
> > +		*bufpos += XDR_UNIT + align;
> > +	}
> > +
> > +	*segments += 1;
> > +}
> > +
> > static __be32
> > -nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
> > -			    struct nfsd4_read *read,
> > -			    unsigned long *maxcount, u32 *eof)
> > +nfsd4_encode_read_plus_segments(struct nfsd4_compoundres *resp,
> > +				struct nfsd4_read *read,
> > +				unsigned int *segments, u32 *eof)
> > {
> > -	struct file *file = read->rd_nf->nf_file;
> > -	loff_t data_pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
> > -	loff_t f_size = i_size_read(file_inode(file));
> > -	unsigned long count;
> > -	__be32 *p;
> > +	struct xdr_stream *xdr = resp->xdr;
> > +	unsigned int bufpos = xdr->buf->len;
> > +	u64 offset = read->rd_offset;
> > +	struct read_plus_segment segment;
> > +	enum data_content4 pagetype;
> > +	unsigned long maxcount;
> > +	unsigned int pagenum = 0;
> > +	unsigned int pagelen;
> > +	char *vpage, *p;
> > +	__be32 nfserr;
> > 
> > -	if (data_pos == -ENXIO)
> > -		data_pos = f_size;
> > -	else if (data_pos <= read->rd_offset || (data_pos < f_size && data_pos % PAGE_SIZE))
> > -		return nfsd4_encode_read_plus_data(resp, read, maxcount, eof, &f_size);
> > -	count = data_pos - read->rd_offset;
> > -
> > -	/* Content type, offset, byte count */
> > -	p = xdr_reserve_space(resp->xdr, 4 + 8 + 8);
> > -	if (!p)
> > +	/* enough space for a HOLE segment before we switch to the pages */
> > +	if (!xdr_reserve_space(xdr, 5 * XDR_UNIT))
> > 		return nfserr_resource;
> > +	xdr_commit_encode(xdr);
> > 
> > -	*p++ = htonl(NFS4_CONTENT_HOLE);
> > -	p = xdr_encode_hyper(p, read->rd_offset);
> > -	p = xdr_encode_hyper(p, count);
> > +	maxcount = min_t(unsigned long, read->rd_length,
> > +			 (xdr->buf->buflen - xdr->buf->len));
> > 
> > -	*eof = (read->rd_offset + count) >= f_size;
> > -	*maxcount = min_t(unsigned long, count, *maxcount);
> > +	nfserr = nfsd4_read_plus_readv(resp, read, &maxcount, eof);
> > +	if (nfserr)
> > +		return nfserr;
> > +
> > +	while (maxcount > 0) {
> > +		vpage = xdr_buf_nth_page_address(xdr->buf, pagenum, &pagelen);
> > +		pagelen = min_t(unsigned int, pagelen, maxcount);
> > +		if (!vpage || pagelen == 0)
> > +			break;
> > +		p = memchr_inv(vpage, 0, pagelen);
> 
> I'm still not happy about touching every byte in each READ_PLUS
> payload. I think even though the rest of this work is merge-ready,
> this is a brute-force mechanism that's OK for a proof of concept
> but not appropriate for production-ready code.

Seems like a step backwards as it defeats the benefit zero-copy read
IO paths on the server side....

> I've cc'd linux-fsdevel to see if we can get some more ideas going
> and move this forward.
> 
> Another thought I had was to support returning only one or two
> segments per reply. One CONTENT segment, one HOLE segment, or one
> of each. Would that be enough to prevent the issues around file
> updates racing with the construction of the reply?

Before I can make any sort of useful suggestion, I need to have it
explained to me why we care if the underlying file mapping has
changed between the read of the data and the SEEK_HOLE trim check,
because it's not at all clear to me what problem this change is
actually solving.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
