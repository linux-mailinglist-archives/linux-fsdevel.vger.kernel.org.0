Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B521457A82C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 22:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbiGSUYj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 16:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiGSUYj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:24:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB2846D91;
        Tue, 19 Jul 2022 13:24:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D50DF6195B;
        Tue, 19 Jul 2022 20:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B8CC341CA;
        Tue, 19 Jul 2022 20:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658262277;
        bh=i8vSLAZwjV2kBCoUEIK9ZuVfSPMFGWPqOVNLYVDv3Ks=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SDHQmBR2EPLW3IdrqsccEyZmqbtLp5hqefOKGlX7dGFTeeugRbuPYfLd5l3X6I0Mz
         zLOrAtowD9TID32kx3cFnQ23S9w/QON8PVD6rnDzAtYuLOjfHn5IDqE9+sVxGFbCCx
         v3X4yKpq+zDBZ8QLOnW32ItQGDPsp99d9maossEAQLKpMLfUURy1M+y6E8pN6wZEq+
         zLrkC/vl77Ol803llaH9TaS9AKY73hUhUVfY2FyjoInIBSFLjfk9I+CnSUAkF4DT5F
         cCcScHAlJYQt8i/F/If55vKJ9i1wlD44E+c7PFQTMTajTvErX4kcXBG1MBkcPOo8RC
         P9VCfE4qTw3Tg==
Received: by mail-wm1-f52.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso1018329wmq.1;
        Tue, 19 Jul 2022 13:24:36 -0700 (PDT)
X-Gm-Message-State: AJIora9dKTZDrXxll+Xz3I8kba0gAuLkMIj6dJtKkAiewcg6zh4YTkTD
        30Vbh/tR+elahneg9EKl9ic61p+5Eewy0KOrRDQ=
X-Google-Smtp-Source: AGRyM1tGBtz4nRYMQ3utEybCkeCvgZ6vj77TM3u1myfDQIJvtjLGV1Qf9qvYaz6PndL2LOt7OZxUxOdLQEOBcCwTcK0=
X-Received: by 2002:a05:600c:154c:b0:3a1:884e:72ac with SMTP id
 f12-20020a05600c154c00b003a1884e72acmr892174wmg.23.1658262275417; Tue, 19 Jul
 2022 13:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220715184433.838521-1-anna@kernel.org> <20220715184433.838521-7-anna@kernel.org>
 <EC97C20D-A317-49F9-8280-062D1AAEE49A@oracle.com> <20220718011552.GK3600936@dread.disaster.area>
 <5A400446-A6FD-436B-BDE2-DAD61239F98F@oracle.com>
In-Reply-To: <5A400446-A6FD-436B-BDE2-DAD61239F98F@oracle.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Tue, 19 Jul 2022 16:24:18 -0400
X-Gmail-Original-Message-ID: <CAFX2Jfmm6t8V1P3Lt9j2gE_GFpKo51Z8jKPvxdbFoJfVi=dn9A@mail.gmail.com>
Message-ID: <CAFX2Jfmm6t8V1P3Lt9j2gE_GFpKo51Z8jKPvxdbFoJfVi=dn9A@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS implementation
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 19, 2022 at 1:21 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jul 17, 2022, at 9:15 PM, Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Fri, Jul 15, 2022 at 07:08:13PM +0000, Chuck Lever III wrote:
> >>> On Jul 15, 2022, at 2:44 PM, Anna Schumaker <anna@kernel.org> wrote:
> >>>
> >>> +nfsd4_encode_read_plus_segments(struct nfsd4_compoundres *resp,
> >>> +                           struct nfsd4_read *read,
> >>> +                           unsigned int *segments, u32 *eof)
> >>> {
> >>> -   struct file *file = read->rd_nf->nf_file;
> >>> -   loff_t data_pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
> >>> -   loff_t f_size = i_size_read(file_inode(file));
> >>> -   unsigned long count;
> >>> -   __be32 *p;
> >>> +   struct xdr_stream *xdr = resp->xdr;
> >>> +   unsigned int bufpos = xdr->buf->len;
> >>> +   u64 offset = read->rd_offset;
> >>> +   struct read_plus_segment segment;
> >>> +   enum data_content4 pagetype;
> >>> +   unsigned long maxcount;
> >>> +   unsigned int pagenum = 0;
> >>> +   unsigned int pagelen;
> >>> +   char *vpage, *p;
> >>> +   __be32 nfserr;
> >>>
> >>> -   if (data_pos == -ENXIO)
> >>> -           data_pos = f_size;
> >>> -   else if (data_pos <= read->rd_offset || (data_pos < f_size && data_pos % PAGE_SIZE))
> >>> -           return nfsd4_encode_read_plus_data(resp, read, maxcount, eof, &f_size);
> >>> -   count = data_pos - read->rd_offset;
> >>> -
> >>> -   /* Content type, offset, byte count */
> >>> -   p = xdr_reserve_space(resp->xdr, 4 + 8 + 8);
> >>> -   if (!p)
> >>> +   /* enough space for a HOLE segment before we switch to the pages */
> >>> +   if (!xdr_reserve_space(xdr, 5 * XDR_UNIT))
> >>>             return nfserr_resource;
> >>> +   xdr_commit_encode(xdr);
> >>>
> >>> -   *p++ = htonl(NFS4_CONTENT_HOLE);
> >>> -   p = xdr_encode_hyper(p, read->rd_offset);
> >>> -   p = xdr_encode_hyper(p, count);
> >>> +   maxcount = min_t(unsigned long, read->rd_length,
> >>> +                    (xdr->buf->buflen - xdr->buf->len));
> >>>
> >>> -   *eof = (read->rd_offset + count) >= f_size;
> >>> -   *maxcount = min_t(unsigned long, count, *maxcount);
> >>> +   nfserr = nfsd4_read_plus_readv(resp, read, &maxcount, eof);
> >>> +   if (nfserr)
> >>> +           return nfserr;
> >>> +
> >>> +   while (maxcount > 0) {
> >>> +           vpage = xdr_buf_nth_page_address(xdr->buf, pagenum, &pagelen);
> >>> +           pagelen = min_t(unsigned int, pagelen, maxcount);
> >>> +           if (!vpage || pagelen == 0)
> >>> +                   break;
> >>> +           p = memchr_inv(vpage, 0, pagelen);
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

I remember Bruce thinking we could only use splice reads for the very
first segment if it's data, but that was a few years ago so I don't
know if anything has changed that would allow spliced reads for all
data.

>
> But I also thought the purpose of READ_PLUS was to help clients
> preserve unallocated extents in files during copy operations.
> An unallocated extent is not the same as an allocated extent
> that has zeroes written into it. IIUC this new logic does not
> distinguish between those two cases at all. (And please correct
> me if this is really not the goal of READ_PLUS).

I wasn't aware of this as a goal of READ_PLUS. As of right now, Linux
doesn't really have a way to punch holes into pagecache data, so we
and up needing to zero-fill on the client side during decoding.

>
> I would like to retain precise detection of unallocated extents
> in files. Maybe SEEK_HOLE/SEEK_DATA is not how to do that, but
> my feeling is that checking for zero bytes is definitely not
> the way to do it.

Ok.
>
>
> >> I've cc'd linux-fsdevel to see if we can get some more ideas going
> >> and move this forward.
> >>
> >> Another thought I had was to support returning only one or two
> >> segments per reply. One CONTENT segment, one HOLE segment, or one
> >> of each. Would that be enough to prevent the issues around file
> >> updates racing with the construction of the reply?
> >
> > Before I can make any sort of useful suggestion, I need to have it
> > explained to me why we care if the underlying file mapping has
> > changed between the read of the data and the SEEK_HOLE trim check,
> > because it's not at all clear to me what problem this change is
> > actually solving.
>
> The cover letter for this series calls out generic/091 and
> generic/263 -- it mentioned both are failing with NFSv4.2. I've
> tried to reproduce failures here, but both passed.

Did you check that CONFIG_NFS_V4_2_READ_PLUS=y on the client? We had
it disabled due to these tests and the very, very long time servers
exporting btrfs take to read already-cached data (see btrfs sections
in the wiki page linked in the cover letter).

There is also this bugzilla documenting the problem:
https://bugzilla.kernel.org/show_bug.cgi?id=215673

>
> Anna, can you provide a root-cause analysis of what is failing
> in your testing? Maybe a reproducer for us to kick around?

The only reproducers I have are the xfstests mentioned. They fail
pretty reliably on my setup (linux nfsd exporting xfs).

Anna

> I'm guessing you might be encountering races because your
> usual test environment is virtual, so we need to understand
> how timing effects the results.
>
>
> --
> Chuck Lever
>
>
>
