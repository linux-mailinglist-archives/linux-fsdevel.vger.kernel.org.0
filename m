Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FD557A878
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 22:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbiGSUrQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 16:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiGSUrP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56ED4F1BF;
        Tue, 19 Jul 2022 13:47:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 99C06CE1DC3;
        Tue, 19 Jul 2022 20:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F466C341C6;
        Tue, 19 Jul 2022 20:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658263629;
        bh=n8Z8IBZTosqICaePvl4vDsfaEGgsmlmYodZ5BjIFjIc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G5PYjf+LTE4F/46iWG00Xf47QCr1e4RmaXurl07jiwyLkN8IoxYO4ESI48vAlqgRp
         MjAD1BZXLm1Hl5FJjehH9MNnyL6zUqWmqS9ngG6/B7XkOiEerkvf3R1eZIMZiGdWe9
         wEJb2JuZzLIS6eISbdwmll4jeFQDFMEbdGRYUn+KIufRd5stKryr16NmlwJOhsfO3T
         eSWofuACsxLlWTFOniCILuQWGPpObSk1B7xVopAr8pcCg4cG5RRMom3aRZlb+ZL51I
         uNlrNtoEpgxQO/g7f3O1i/i6m2mJXhcksRyYqUXwWMBuipen5bzyZWs9E/lIRs5MM0
         S/Y3HpmPLaBUA==
Received: by mail-wm1-f50.google.com with SMTP id x23-20020a05600c179700b003a30e3e7989so89494wmo.0;
        Tue, 19 Jul 2022 13:47:09 -0700 (PDT)
X-Gm-Message-State: AJIora+0dWQZvHtR80zdGf/Q16YfUO6pvUyaPKqar9r5Lb8BDoeBNhPJ
        /FK9xsDnOFG33OZd81lAVuJ2j0vrAHJG+VM6lBs=
X-Google-Smtp-Source: AGRyM1vj8Xw3K2n0Zy/8gUp4wdGRQqKMNHL7qyVMBBWYWL1XTQzfFFqT0ANQyV6+DMCLXhv95FaI4XNE4f72seyxxro=
X-Received: by 2002:a1c:7401:0:b0:3a3:182f:7be9 with SMTP id
 p1-20020a1c7401000000b003a3182f7be9mr852585wmc.189.1658263627925; Tue, 19 Jul
 2022 13:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220715184433.838521-1-anna@kernel.org> <20220715184433.838521-7-anna@kernel.org>
 <EC97C20D-A317-49F9-8280-062D1AAEE49A@oracle.com> <20220718011552.GK3600936@dread.disaster.area>
In-Reply-To: <20220718011552.GK3600936@dread.disaster.area>
From:   Anna Schumaker <anna@kernel.org>
Date:   Tue, 19 Jul 2022 16:46:50 -0400
X-Gmail-Original-Message-ID: <CAFX2Jf=FrXHMxioWLHFkRHxBNDRe-9SBUmCcco9gkaY8EQOSZg@mail.gmail.com>
Message-ID: <CAFX2Jf=FrXHMxioWLHFkRHxBNDRe-9SBUmCcco9gkaY8EQOSZg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS implementation
To:     Dave Chinner <david@fromorbit.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 17, 2022 at 9:16 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Fri, Jul 15, 2022 at 07:08:13PM +0000, Chuck Lever III wrote:
> > > On Jul 15, 2022, at 2:44 PM, Anna Schumaker <anna@kernel.org> wrote:
> > >
> > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > >
> > > Rather than relying on the underlying filesystem to tell us where hole
> > > and data segments are through vfs_llseek(), let's instead do the hole
> > > compression ourselves. This has a few advantages over the old
> > > implementation:
> > >
> > > 1) A single call to the underlying filesystem through nfsd_readv() means
> > >   the file can't change from underneath us in the middle of encoding.
>
> Hi Anna,
>
> I'm assuming you mean the vfs_llseek(SEEK_HOLE) call at the start
> of nfsd4_encode_read_plus_data() that is used to trim the data that
> has already been read out of the file?

There is also the vfs_llseek(SEEK_DATA) call at the start of
nfsd4_encode_read_plus_hole(). They are used to determine the length
of the current hole or data segment.

>
> What's the problem with racing with a hole punch here? All it does
> is shorten the read data returned to match the new hole, so all it's
> doing is making the returned data "more correct".

The problem is we call vfs_llseek() potentially many times when
encoding a single reply to READ_PLUS. nfsd4_encode_read_plus() has a
loop where we alternate between hole and data segments until we've
encoded the requested number of bytes. My attempts at locking the file
have resulted in a deadlock since vfs_llseek() also locks the file, so
the file could change from underneath us during each iteration of the
loop.

>
> OTOH, if something allocates over a hole that the read filled with
> zeros, what's the problem with occasionally returning zeros as data?
> Regardless, if this has raced with a write to the file that filled
> that hole, we're already returning stale data/hole information to
> the client regardless of whether we trim it or not....
>
> i.e. I can't see a correctness or data integrity problem here that
> doesn't already exist, and I have my doubts that hole
> punching/filling racing with reads happens often enough to create a
> performance or bandwidth problem OTW. Hence I've really got no idea
> what the problem that needs to be solved here is.
>
> Can you explain what the symptoms of the problem a user would see
> that this change solves?

This fixes xfstests generic/091 and generic/263, along with this
reported bug: https://bugzilla.kernel.org/show_bug.cgi?id=215673
>
> > > 2) A single call to the underlying filestem also means that the
> > >   underlying filesystem only needs to synchronize cached and on-disk
> > >   data one time instead of potentially many speeding up the reply.
>
> SEEK_HOLE/DATA doesn't require cached data to be sync'd to disk to
> be coherent - that's only a problem FIEMAP has (and syncing cached
> data doesn't fix the TOCTOU coherency issue!).  i.e. SEEK_HOLE/DATA
> will check the page cache for data if appropriate (e.g. unwritten
> disk extents may have data in memory over the top of them) instead
> of syncing data to disk.

For some reason, btrfs on virtual hardware has terrible performance
numbers when using vfs_llseek() with files that are already in the
server's cache. I think it had something to do with how they lock
extents, and some extra work that needs to be done if the file already
exists in the server's memory but it's been  a few years since I've
gone into their code to figure out where the slowdown is coming from.
See this section of my performance results wiki page:
https://wiki.linux-nfs.org/wiki/index.php/Read_Plus_May_2022#BTRFS_3

Anna

>
> > > 3) Hole support for filesystems that don't support SEEK_HOLE and SEEK_DATA
> >
> > Thanks for addressing my cosmetic comments! Looks good.
> >
> > I'm still not clear why NFSD needs to support filesystems that
> > do not support SEEK_HOLE/DATA. I'm guessing this is just a side
> > benefit of the memchr_inv approach below, not really a goal of
> > this overhaul?
>
> Don't other mechanisms in NFSv4 require SEEK_HOLE/SEEK_DATA support?
> ie. supporting a useful implementation of NFS4_CONTENT_DATA/
> NFS4_CONTENT_HOLE across the wire?  Why doesn't that server side
> implementations use memchr_inv() rather than allowing filesystems to
> optimise away the data read requirement for the operation?
>
> Or don't we care because what is returned to the client is *always*
> going to have races with whatever the client decides what to do with
> the information? If that's true, then why do we care if
> nfsd4_encode_read_plus_data() may return some zeros instead of a
> shorter read and a longer hole?
>
> > One more comment below.
> >
> >
> > > I also included an optimization where we can cut down on the amount of
> > > memory being shifed around by doing the compression as (hole, data)
> > > pairs.
> > >
> > > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > ---
> > > fs/nfsd/nfs4xdr.c | 219 +++++++++++++++++++++++++---------------------
> > > 1 file changed, 119 insertions(+), 100 deletions(-)
> > >
> > > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > > index 61b2aae81abb..df8289fce4ef 100644
> > > --- a/fs/nfsd/nfs4xdr.c
> > > +++ b/fs/nfsd/nfs4xdr.c
> > > @@ -4731,81 +4731,138 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
> > >     return nfserr;
> > > }
> > >
> > > +struct read_plus_segment {
> > > +   enum data_content4      rp_type;
> > > +   u64                     rp_offset;
> > > +   u64                     rp_length;
> > > +   unsigned int            rp_page_pos;
> > > +};
> > > +
> > > static __be32
> > > -nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> > > -                       struct nfsd4_read *read,
> > > -                       unsigned long *maxcount, u32 *eof,
> > > -                       loff_t *pos)
> > > +nfsd4_read_plus_readv(struct nfsd4_compoundres *resp, struct nfsd4_read *read,
> > > +                 unsigned long *maxcount, u32 *eof)
> > > {
> > >     struct xdr_stream *xdr = resp->xdr;
> > > -   struct file *file = read->rd_nf->nf_file;
> > > -   int starting_len = xdr->buf->len;
> > > -   loff_t hole_pos;
> > > -   __be32 nfserr;
> > > -   __be32 *p, tmp;
> > > -   __be64 tmp64;
> > > -
> > > -   hole_pos = pos ? *pos : vfs_llseek(file, read->rd_offset, SEEK_HOLE);
> > > -   if (hole_pos > read->rd_offset)
> > > -           *maxcount = min_t(unsigned long, *maxcount, hole_pos - read->rd_offset);
> > > -   *maxcount = min_t(unsigned long, *maxcount, (xdr->buf->buflen - xdr->buf->len));
> > > -
> > > -   /* Content type, offset, byte count */
> > > -   p = xdr_reserve_space(xdr, 4 + 8 + 4);
> > > -   if (!p)
> > > -           return nfserr_resource;
> > > +   unsigned int starting_len = xdr->buf->len;
> > > +   __be32 nfserr, zero = xdr_zero;
> > > +   unsigned int pad;
> > >
> > > +   /*
> > > +    * Reserve the maximum abount of space needed to craft a READ_PLUS
> > > +    * reply. The call to xdr_reserve_space_vec() switches us to the
> > > +    * xdr->pages, which we then read file data into before analyzing
> > > +    * the individual segments.
> > > +    */
> > >     read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, *maxcount);
> > >     if (read->rd_vlen < 0)
> > >             return nfserr_resource;
> > >
> > > -   nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
> > > -                       resp->rqstp->rq_vec, read->rd_vlen, maxcount, eof);
> > > +   nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, read->rd_nf->nf_file,
> > > +                       read->rd_offset, resp->rqstp->rq_vec, read->rd_vlen,
> > > +                       maxcount, eof);
> > >     if (nfserr)
> > >             return nfserr;
> > > -   xdr_truncate_encode(xdr, starting_len + 16 + xdr_align_size(*maxcount));
> > > +   xdr_truncate_encode(xdr, starting_len + xdr_align_size(*maxcount));
> > >
> > > -   tmp = htonl(NFS4_CONTENT_DATA);
> > > -   write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
> > > -   tmp64 = cpu_to_be64(read->rd_offset);
> > > -   write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
> > > -   tmp = htonl(*maxcount);
> > > -   write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
> > > -
> > > -   tmp = xdr_zero;
> > > -   write_bytes_to_xdr_buf(xdr->buf, starting_len + 16 + *maxcount, &tmp,
> > > -                          xdr_pad_size(*maxcount));
> > > +   pad = xdr_pad_size(*maxcount);
> > > +   write_bytes_to_xdr_buf(xdr->buf, starting_len + *maxcount, &zero, pad);
> > >     return nfs_ok;
> > > }
> > >
> > > +/**
> > > + * nfsd4_encode_read_plus_segment - Encode a single READ_PLUS segment
> > > + * @xdr: pointer to an xdr_stream
> > > + * @segment: pointer to a single segment
> > > + * @bufpos: xdr_stream offset to place the segment
> > > + * @segments: pointer to the total number of segments seen
> > > + *
> > > + * Performs surgery on the xdr_stream to compress out HOLE segments and
> > > + * to place DATA segments in the proper place.
> > > + */
> > > +static void
> > > +nfsd4_encode_read_plus_segment(struct xdr_stream *xdr,
> > > +                          struct read_plus_segment *segment,
> > > +                          unsigned int *bufpos, unsigned int *segments)
> > > +{
> > > +   struct xdr_buf *buf = xdr->buf;
> > > +
> > > +   xdr_encode_word(buf, *bufpos, segment->rp_type);
> > > +   xdr_encode_double(buf, *bufpos + XDR_UNIT, segment->rp_offset);
> > > +   *bufpos += 3 * XDR_UNIT;
> > > +
> > > +   if (segment->rp_type == NFS4_CONTENT_HOLE) {
> > > +           xdr_encode_double(buf, *bufpos, segment->rp_length);
> > > +           *bufpos += 2 * XDR_UNIT;
> > > +   } else {
> > > +           size_t align = xdr_align_size(segment->rp_length);
> > > +           xdr_encode_word(buf, *bufpos, segment->rp_length);
> > > +           if (*segments == 0)
> > > +                   xdr_buf_trim_head(buf, XDR_UNIT);
> > > +
> > > +           xdr_stream_move_subsegment(xdr,
> > > +                           buf->head[0].iov_len + segment->rp_page_pos,
> > > +                           *bufpos + XDR_UNIT, align);
> > > +           *bufpos += XDR_UNIT + align;
> > > +   }
> > > +
> > > +   *segments += 1;
> > > +}
> > > +
> > > static __be32
> > > -nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
> > > -                       struct nfsd4_read *read,
> > > -                       unsigned long *maxcount, u32 *eof)
> > > +nfsd4_encode_read_plus_segments(struct nfsd4_compoundres *resp,
> > > +                           struct nfsd4_read *read,
> > > +                           unsigned int *segments, u32 *eof)
> > > {
> > > -   struct file *file = read->rd_nf->nf_file;
> > > -   loff_t data_pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
> > > -   loff_t f_size = i_size_read(file_inode(file));
> > > -   unsigned long count;
> > > -   __be32 *p;
> > > +   struct xdr_stream *xdr = resp->xdr;
> > > +   unsigned int bufpos = xdr->buf->len;
> > > +   u64 offset = read->rd_offset;
> > > +   struct read_plus_segment segment;
> > > +   enum data_content4 pagetype;
> > > +   unsigned long maxcount;
> > > +   unsigned int pagenum = 0;
> > > +   unsigned int pagelen;
> > > +   char *vpage, *p;
> > > +   __be32 nfserr;
> > >
> > > -   if (data_pos == -ENXIO)
> > > -           data_pos = f_size;
> > > -   else if (data_pos <= read->rd_offset || (data_pos < f_size && data_pos % PAGE_SIZE))
> > > -           return nfsd4_encode_read_plus_data(resp, read, maxcount, eof, &f_size);
> > > -   count = data_pos - read->rd_offset;
> > > -
> > > -   /* Content type, offset, byte count */
> > > -   p = xdr_reserve_space(resp->xdr, 4 + 8 + 8);
> > > -   if (!p)
> > > +   /* enough space for a HOLE segment before we switch to the pages */
> > > +   if (!xdr_reserve_space(xdr, 5 * XDR_UNIT))
> > >             return nfserr_resource;
> > > +   xdr_commit_encode(xdr);
> > >
> > > -   *p++ = htonl(NFS4_CONTENT_HOLE);
> > > -   p = xdr_encode_hyper(p, read->rd_offset);
> > > -   p = xdr_encode_hyper(p, count);
> > > +   maxcount = min_t(unsigned long, read->rd_length,
> > > +                    (xdr->buf->buflen - xdr->buf->len));
> > >
> > > -   *eof = (read->rd_offset + count) >= f_size;
> > > -   *maxcount = min_t(unsigned long, count, *maxcount);
> > > +   nfserr = nfsd4_read_plus_readv(resp, read, &maxcount, eof);
> > > +   if (nfserr)
> > > +           return nfserr;
> > > +
> > > +   while (maxcount > 0) {
> > > +           vpage = xdr_buf_nth_page_address(xdr->buf, pagenum, &pagelen);
> > > +           pagelen = min_t(unsigned int, pagelen, maxcount);
> > > +           if (!vpage || pagelen == 0)
> > > +                   break;
> > > +           p = memchr_inv(vpage, 0, pagelen);
> >
> > I'm still not happy about touching every byte in each READ_PLUS
> > payload. I think even though the rest of this work is merge-ready,
> > this is a brute-force mechanism that's OK for a proof of concept
> > but not appropriate for production-ready code.
>
> Seems like a step backwards as it defeats the benefit zero-copy read
> IO paths on the server side....
>
> > I've cc'd linux-fsdevel to see if we can get some more ideas going
> > and move this forward.
> >
> > Another thought I had was to support returning only one or two
> > segments per reply. One CONTENT segment, one HOLE segment, or one
> > of each. Would that be enough to prevent the issues around file
> > updates racing with the construction of the reply?
>
> Before I can make any sort of useful suggestion, I need to have it
> explained to me why we care if the underlying file mapping has
> changed between the read of the data and the SEEK_HOLE trim check,
> because it's not at all clear to me what problem this change is
> actually solving.
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
