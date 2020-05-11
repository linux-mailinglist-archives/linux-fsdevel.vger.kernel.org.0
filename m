Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8A21CD96D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 14:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgEKMMq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 08:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725913AbgEKMMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 08:12:46 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBD2C061A0C
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2020 05:12:44 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b91so3516923edf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2020 05:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=mGEeAidnaM2iRIyWxI6jgp1Wobv7K4kFp+s5P5H4YoA=;
        b=owJ03ZLe6XOnl1JyEldc61eRkgc7YLJIQJIzIhH0Nh+NOdGN78NY6/IY9z6/Sm3VYt
         03cpvMlqpx35vrqjUtos/XQNeRCJu8eJrcZPmufFRCXiAkyzkBotvjSoOpadPq4d15L5
         6dLgZojOK//t9s+FN2fJVN1JI3hK1KZxZUA84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=mGEeAidnaM2iRIyWxI6jgp1Wobv7K4kFp+s5P5H4YoA=;
        b=kh0l+xO25zIQq7Wtyodo8tsx/s0/c6wr6z3HJoCwkiYvdM4aQkBEf0iNVHDdXrp9cS
         Sz8sCCuN0gukmhFcClqBwggWHm/dTgSXJ18xGiZrD9eQ3Urh2A7u8bhOnswYdg/Dmo6B
         QewJd9/vkiiWOgkf9fzD4EVgwmjaJasnCCaGuI9meZ47BfgGNF7P5K8D59esUuz/K51h
         QpzJRHcBCGGmihyaa4fl2O4ZuCUTnUy04Eh5pEPK+5QhEYsiAPgwoKvWyo24DGssmW8a
         ZvOXvbBxZs/xPJq1ymwySi4YeLPsnJkc7w32u5wn9qpiAD81w8jFd+4UT1eCp5MlUT25
         D86A==
X-Gm-Message-State: AGi0PubhEfiqSyYaxnjUHG744KbtXF1i2zG4p83MMYPnFL2vT1h3Nxf1
        /eh05WnmOTLOfJQmLtMTH087Sf7u4qFGwKeOmt1rqg==
X-Google-Smtp-Source: APiQypLx39OTYFA+g9OcLemqwK2mJuf5Rfhn6Y6TMz6Bi7uvVAIE32tvtajBkxSF8JW4n0CKQeJvwfWnbSszCMWAzrY=
X-Received: by 2002:a05:6402:2058:: with SMTP id bc24mr8316071edb.134.1589199163373;
 Mon, 11 May 2020 05:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <87k123h4vr.fsf@vostro.rath.org> <CAJfpeguqV=++b-PF6o6Y-pLvPioHrM-4mWE2rUqoFbmB7685FA@mail.gmail.com>
 <874ksq4fa9.fsf@vostro.rath.org>
In-Reply-To: <874ksq4fa9.fsf@vostro.rath.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 11 May 2020 14:12:32 +0200
Message-ID: <CAJfpegv63Tv7_YKno6BR+SdPPGD_4=c4YnGPmbPrY7jZCyuf_g@mail.gmail.com>
Subject: Re: [fuse-devel] [fuse] Getting visibility into reads from page cache
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 8, 2020 at 5:29 PM Nikolaus Rath <Nikolaus@rath.org> wrote:
>
> On Apr 27 2020, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > On Sat, Apr 25, 2020 at 7:07 PM Nikolaus Rath <Nikolaus@rath.org> wrote:
> >>
> >> Hello,
> >>
> >> For debugging purposes, I would like to get information about read
> >> requests for FUSE filesystems that are answered from the page cache
> >> (i.e., that never make it to the FUSE userspace daemon).
> >>
> >> What would be the easiest way to accomplish that?
> >>
> >> For now I'd be happy with seeing regular reads and knowing when an
> >> application uses mmap (so that I know that I might be missing reads).
> >>
> >>
> >> Not having done any real kernel-level work, I would start by looking
> >> into using some tracing framework to hook into the relevant kernel
> >> function. However, I thought I'd ask here first to make sure that I'm
> >> not heading into the completely wrong direction.
> >
> > Bpftrace is a nice high level tracing tool.
> >
> > E.g.
> >
> >   sudo bpftrace -e 'kretprobe:fuse_file_read_iter { printf ("fuse
> > read: %d\n", retval); }'
>
> Thanks, this looks great! I had to do some reading about bpftrace first,
> but I think this is exacly what I'm looking for. A few more questions:
>
>
> - If I attach a probe to fuse_file_mmap, will this tell me whenever an
>   application attempts to mmap() a FUSE file?

Yes.

> - I believe that (struct kiocb*)arg0)->ki_pos will give me the offset
>   within the file, but where can I see how much data is being read?
>
> Looking at the code in fuse_file_read_iter, it seems the length is in
> ((struct iov_iter*)arg1)->count, but I do not really understand why.

That's correct.

> The definiton of this parameter is:
>
> struct iov_iter {
>         int type;
>         const struct iovec *iov;
>         unsigned long nr_segs;
>         size_t iov_offset;
>         size_t count;
> };
>
> ..so I would think that *count* is the number of `iovec` elements hiding
> behind the `iov` pointer, not some total number of bytes.

That's nr_segs.

> Furthermore, there is a function iov_length() that is documented to
> return the "total number of bytes covered by an iovec" and doesn't look
> at `count` at all.

iov_iter_count() is the accessor function that does this.

> - What is the best way to connect read requests to a specific FUSE
>   filesystems (if more than one is mounted)? I found the superblock in
>   (struct kiocb*)arg0)->ki_filp->f_mapping->host->i_sb->s_fs_info, but I
>   do not see anything in this structure that I could map to a similar
>   value that FUSE userspace has access to...

You can match up ki_filp->f_inode->i_sb->s_dev with st_dev on any
file.  I think the kernel encodes the device value differently, but
the bits should be there.

> - I assume fuse_file_read_iter is called for every read request for FUSE
>   filesystems unless it's an mmap'ed access. Is that right?

Correct.

> - Is there any similar way to catch access to an mmap'ed file? I think
>   there is probably a way to make sure that every memory read triggers a
>   page fault and then hook into the fault handler, but I am not sure how
>   difficult this is to do and how much performance this would cost....

Not sure if that's implementable, but it would surely be grossly
inefficient.  Flushing page tables e.g. every second would probably
work, but then you'd only get the read pattern on a one second
granularity.

> - If my BPF program contains e.g. a printf statement, will execution of
>   the kernel function block until the printf has completed, or is there
>   some queuing mechanism?

AFAIK there's some queuing.

Thanks,
Miklos
