Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF6A4F984A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 16:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbiDHOkx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 10:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiDHOkw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:40:52 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBDB28986;
        Fri,  8 Apr 2022 07:38:48 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id k9so4664962uad.2;
        Fri, 08 Apr 2022 07:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h0U7OO6jgr7syg2oYma/02GJ8nZoVmEsQLGYr6HMkKE=;
        b=LnKns7Qf2LQ/yngkFRT3vXI5OO0RJdDJ6DnXODInspR7oHTQMpQNmfS41T6fmEVBNI
         vF0BWVZYp6vujcanPXBqNwDycaeW8OraKRFqAAnA27QWe9xAaknmN8/4G8TC+QMxk8d7
         GMAN5eq2qcfMlXZIQBzoMPNVylcGwfuW+MMUQjrNNNBV9LD04WY5UnnkDKslJRkwu6Ok
         AeUP11u4KIzJmkcRVmpS3YMq4Wkb0GrCf2cLpsTiORAyJRSzCkGC1uFfnMSQ1UCXxGKz
         dZe0WB21sWAAax/Q7u3iQt/y6o0Sb9Qz0jj5ompCmH2a+DNmZMp6eQxrUeksJoafeMJl
         12yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h0U7OO6jgr7syg2oYma/02GJ8nZoVmEsQLGYr6HMkKE=;
        b=IOSnhn+ZF63tdY/ePA1ZcdXRrzgctvdny/cs3DC+zvxZ//qm2Bxq7y76JHOtJj4Swn
         6lzd03bApxc4AnaLa6iRz5GfJDPdBN1VW42Q3/nu+lk6XYdcThTW2Ep3E+FGq6wFxKXf
         ivMRLIvuCj9R8QPI2Nw/7Gs8AWtz6ANG6f9SKXInIUZ5CoRFgqVIizqDUTQ6i1FA2fPl
         msrxi0iYQMWm7pf2FsYmsYmHcEf/RhKL5X5QHqxZngr8EgkelmtDHpj3fceSpjzHgKgx
         VLU12r9Gst3YHxn7km/PNSHdIVpMeo23nUzkZGY1mbRqmfFyva9SMlax16B5QY1NdY0D
         2rxw==
X-Gm-Message-State: AOAM532BJQGXIZ9mzFyzqzKxPdLRgsPNZmeIt5kgq3b7y79SUxmH2iX8
        /WyvOSKUq+S08R/bzIodybJIjRZA0nec8KzrLKo=
X-Google-Smtp-Source: ABdhPJxSr0pXicaPlQ5nejvPQyWHBziVbTs/XcHYInIgliTpo8o+qOCSqIup2yiFGJ95uYkXaKfIRZs2PLPBITeiONE=
X-Received: by 2002:ab0:54c9:0:b0:35d:5e7:f830 with SMTP id
 q9-20020ab054c9000000b0035d05e7f830mr2936867uaa.87.1649428727818; Fri, 08 Apr
 2022 07:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <673D708E-2DFA-4812-BB63-6A437E0C72EE@oracle.com>
 <11f319-c9a-4648-bfbb-dc5a83c774@google.com> <2B7AF707-67B1-4ED8-A29F-957C26B7F87A@oracle.com>
 <c5ea49a-1a76-8cf9-5c76-4bb31aa3d458@google.com> <0017C60F-0BD8-4F5A-BD68-189EEDB2195C@oracle.com>
In-Reply-To: <0017C60F-0BD8-4F5A-BD68-189EEDB2195C@oracle.com>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Fri, 8 Apr 2022 15:38:36 +0100
Message-ID: <CANe_+UjUGxZVzCC8yaqgqynpsMtM0d_iH0eL-ZB7k2=ZWe9rZw@mail.gmail.com>
Subject: Re: Regression in xfstests on tmpfs-backed NFS exports
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Patrice CHOTARD <patrice.chotard@foss.st.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 8 Apr 2022 at 00:45, Chuck Lever III <chuck.lever@oracle.com> wrote:
> > On Apr 7, 2022, at 6:26 PM, Hugh Dickins <hughd@google.com> wrote:
> >
> > On Thu, 7 Apr 2022, Chuck Lever III wrote:
> >>> On Apr 6, 2022, at 8:18 PM, Hugh Dickins <hughd@google.com> wrote:
> >>>
> >>> But I can sit here and try to guess.  I notice fs/nfsd checks
> >>> file->f_op->splice_read, and employs fallback if not available:
> >>> if you have time, please try rerunning those xfstests on an -rc1
> >>> kernel, but with mm/shmem.c's .splice_read line commented out.
> >>> My guess is that will then pass the tests, and we shall know more.
> >>
> >> This seemed like the most probative next step, so I commented
> >> out the .splice_read call-out in mm/shmem.c and ran the tests
> >> again. Yes, that change enables the fsx-related tests to pass
> >> as expected.
> >
> > Great, thank you for trying that.
> >
> >>
> >>> What could be going wrong there?  I've thought of two possibilities.
> >>> A minor, hopefully easily fixed, issue would be if fs/nfsd has
> >>> trouble with seeing the same page twice in a row: since tmpfs is
> >>> now using the ZERO_PAGE(0) for all pages of a hole, and I think I
> >>> caught sight of code which looks to see if the latest page is the
> >>> same as the one before.  It's easy to imagine that might go wrong.
> >>
> >> Are you referring to this function in fs/nfsd/vfs.c ?
> >
> > I think that was it, didn't pay much attention.
>
> This code seems to have been the issue. I added a little test
> to see if @page pointed to ZERO_PAGE(0) and now the tests
> pass as expected.
>
>
> >> 847 static int
> >> 848 nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
> >> 849                   struct splice_desc *sd)
> >> 850 {
> >> 851         struct svc_rqst *rqstp = sd->u.data;
> >> 852         struct page **pp = rqstp->rq_next_page;
> >> 853         struct page *page = buf->page;
> >> 854
> >> 855         if (rqstp->rq_res.page_len == 0) {
> >> 856                 svc_rqst_replace_page(rqstp, page);
> >> 857                 rqstp->rq_res.page_base = buf->offset;
> >> 858         } else if (page != pp[-1]) {
> >> 859                 svc_rqst_replace_page(rqstp, page);
> >> 860         }
> >> 861         rqstp->rq_res.page_len += sd->len;
> >> 862
> >> 863         return sd->len;
> >> 864 }
> >>
> >> rq_next_page should point to the first unused element of
> >> rqstp->rq_pages, so IIUC that check is looking for the
> >> final page that is part of the READ payload.
> >>
> >> But that does suggest that if page -> ZERO_PAGE and so does
> >> pp[-1], then svc_rqst_replace_page() would not be invoked.
> >
> > I still haven't studied the logic there: Mark's input made it clear
> > that it's just too risky for tmpfs to pass back ZERO_PAGE repeatedly,
> > there could be expectations of uniqueness in other places too.
>
> I can't really attest to Mark's comment, but...
>
> After studying nfsd_splice_actor() I can't see any reason
> except cleverness and technical debt for this particular
> check. I have a patch that removes the check and simplifies
> this function that I'm testing now -- it seems to be a
> reasonable clean-up whether you keep 56a8c8eb1eaf or
> choose to revert it.

Agreed nfsd_splice_actor() is broken for the same-page case.
That function hasn't changed in logic since introduction.  So when
VxFS triggered this issue, back in 2007/2008, it must have had the
same problem with this actor (same with its predecessor; ->sendfile).
I don't remember.  But skb_can_coalesce() sticks in my mind for some
reason.  Would jumbo frames be a good stress for can_coalesce with
same-page?  Or, as Hugh is proposing to avoid sending ZERO_PAGE,
ignore this for now?


> >>> A more difficult issue would be, if fsx is racing writes and reads,
> >>> in a way that it can guarantee the correct result, but that correct
> >>> result is no longer delivered: because the writes go into freshly
> >>> allocated tmpfs cache pages, while reads are still delivering
> >>> stale ZERO_PAGEs from the pipe.  I'm hazy on the guarantees there.
> >>>
> >>> But unless someone has time to help out, we're heading for a revert.
> >
> > We might be able to avoid that revert, and go the whole way to using
> > iov_iter_zero() instead.  But the significant slowness of clear_user()
> > relative to copy to user, on x86 at least, does ask for a hybrid.
> >
> > Suggested patch below, on top of 5.18-rc1, passes my own testing:
> > but will it pass yours?  It seems to me safe, and as fast as before,
> > but we don't know yet if this iov_iter_zero() works right for you.
> > Chuck, please give it a go and let us know.
> >
> > (Don't forget to restore mm/shmem.c's .splice_read first!  And if
> > this works, I can revert mm/filemap.c's SetPageUptodate(ZERO_PAGE(0))
> > in the same patch, fixing the other regression, without recourse to
> > #ifdefs or arch mods.)
>
> Sure, I will try this out first thing tomorrow.
>
> One thing that occurs to me is that for NFS/RDMA, having a
> page full of zeroes that is already DMA-mapped would be a
> nice optimization on the sender side (on the client for an
> NFS WRITE and on the server for an NFS READ). The transport
> would have to set up a scatter-gather list containing a
> bunch of entries that reference the same page...
>
> </musing>
>
>
> > Thanks!
> > Hugh
> >
> > --- 5.18-rc1/mm/shmem.c
> > +++ linux/mm/shmem.c
> > @@ -2513,7 +2513,6 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> >               pgoff_t end_index;
> >               unsigned long nr, ret;
> >               loff_t i_size = i_size_read(inode);
> > -             bool got_page;
> >
> >               end_index = i_size >> PAGE_SHIFT;
> >               if (index > end_index)
> > @@ -2570,24 +2569,34 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> >                        */
> >                       if (!offset)
> >                               mark_page_accessed(page);
> > -                     got_page = true;
> > +                     /*
> > +                      * Ok, we have the page, and it's up-to-date, so
> > +                      * now we can copy it to user space...
> > +                      */
> > +                     ret = copy_page_to_iter(page, offset, nr, to);
> > +                     put_page(page);
> > +
> > +             } else if (iter_is_iovec(to)) {
> > +                     /*
> > +                      * Copy to user tends to be so well optimized, but
> > +                      * clear_user() not so much, that it is noticeably
> > +                      * faster to copy the zero page instead of clearing.
> > +                      */
> > +                     ret = copy_page_to_iter(ZERO_PAGE(0), offset, nr, to);
> >               } else {
> > -                     page = ZERO_PAGE(0);
> > -                     got_page = false;
> > +                     /*
> > +                      * But submitting the same page twice in a row to
> > +                      * splice() - or others? - can result in confusion:
> > +                      * so don't attempt that optimization on pipes etc.
> > +                      */
> > +                     ret = iov_iter_zero(nr, to);
> >               }
> >
> > -             /*
> > -              * Ok, we have the page, and it's up-to-date, so
> > -              * now we can copy it to user space...
> > -              */
> > -             ret = copy_page_to_iter(page, offset, nr, to);
> >               retval += ret;
> >               offset += ret;
> >               index += offset >> PAGE_SHIFT;
> >               offset &= ~PAGE_MASK;
> >
> > -             if (got_page)
> > -                     put_page(page);
> >               if (!iov_iter_count(to))
> >                       break;
> >               if (ret < nr) {
>
> --
> Chuck Lever

Cheers,
Mark
