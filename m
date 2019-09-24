Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 608C4BD3AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 22:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441981AbfIXUib (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 16:38:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46261 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441977AbfIXUia (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 16:38:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so2009553pfg.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2019 13:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XXpB+n/Qq9mbpz8JXknmFvdDRIH2ZnerYAdSnNglnD8=;
        b=Gd5fC4ze5JKmHWdFj3mKAMzd1akYwuSIF1UCnUdjRSganaQLFo1YVQf71WGQojfnTS
         FCtix9g9Xcit4JYPaddfFeeTSBEeZqAx4ZMNthWgfDjM6bi9TclET/34PwAV95PtuSV6
         0OAHi/xAMztLd/HSi5RhwrwwbmBfbpLrMD4XLhRIHrA6lZypfdw2wrp7Q8eOmoXDC+ME
         il9DsTt5y3gu8lqarWuxrtEv4fAcPkqCP5IkAcbhio/mzUAkcnhLSAdwYooW4IMvpwuE
         unu16lT0Mgm/hqEVNXhtvLT2H4SEMK/JZBpZRu5fzwlyXffojnts7md67sPN7UgdIe5v
         wrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XXpB+n/Qq9mbpz8JXknmFvdDRIH2ZnerYAdSnNglnD8=;
        b=i6gWP4ZrWm+aN294ytkcHTgqqL0q3/KIawc36I3TCxd/n6A90isTcC3N9CR9kP8+UL
         /nB8coVSG6DadpV2rwLuyqjooCC1t8a8VYlSyqk0U1FNkiQRbmrW8mCnuE2da485nDe4
         a/Jw4hOe2yNqwFerj0sYpCpEda7GCqYe1vtSpR7OLnvskwW5aPuoyLAJzCh5YpyH2Ik9
         xpOdyVbln0fjbL4RTY/maeSKLPrOHrUglXi+/gBOg1eecMqHn8Wag4tBWk2in7OgGWKi
         KrhPSEnYomvLJTFPMBOUaQAkGitb+dwcNHyi7bNUxBsbF5Ows2eE/7hY/jJ8X+9FCeTm
         X03g==
X-Gm-Message-State: APjAAAX4lBBtI06sPAjtwgS21oKeKLckrYj0oHxaFZwfcRHugENPmRT/
        Xe39nivFDGGDApCCd5BUHo2TAA==
X-Google-Smtp-Source: APXvYqzCH5xnEzpQvW+6HYgcR0Hnm409iWIA7nsnBfvYyPFk3aNTXpcTCq9Nh30S0XuXtOFujIrV1w==
X-Received: by 2002:a65:530c:: with SMTP id m12mr4977050pgq.309.1569357509244;
        Tue, 24 Sep 2019 13:38:29 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::3:f972])
        by smtp.gmail.com with ESMTPSA id 22sm3106844pfj.139.2019.09.24.13.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 13:38:28 -0700 (PDT)
Date:   Tue, 24 Sep 2019 13:38:27 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Jann Horn <jannh@google.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH 2/3] fs: add RWF_ENCODED for writing compressed data
Message-ID: <20190924203827.GA46556@vader>
References: <cover.1568875700.git.osandov@fb.com>
 <230a76e65372a8fb3ec62ce167d9322e5e342810.1568875700.git.osandov@fb.com>
 <CAG48ez2GKv15Uj6Wzv0sG5v2bXyrSaCtRTw5Ok_ovja_CiO_fQ@mail.gmail.com>
 <20190924171513.GA39872@vader>
 <20190924193513.GA45540@vader>
 <CAG48ez1NQBNR1XeVQYGoopEk=g_KedUr+7jxLQTaO+V8JCeweQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1NQBNR1XeVQYGoopEk=g_KedUr+7jxLQTaO+V8JCeweQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 10:01:41PM +0200, Jann Horn wrote:
> On Tue, Sep 24, 2019 at 9:35 PM Omar Sandoval <osandov@osandov.com> wrote:
> > On Tue, Sep 24, 2019 at 10:15:13AM -0700, Omar Sandoval wrote:
> > > On Thu, Sep 19, 2019 at 05:44:12PM +0200, Jann Horn wrote:
> > > > On Thu, Sep 19, 2019 at 8:54 AM Omar Sandoval <osandov@osandov.com> wrote:
> > > > > Btrfs can transparently compress data written by the user. However, we'd
> > > > > like to add an interface to write pre-compressed data directly to the
> > > > > filesystem. This adds support for so-called "encoded writes" via
> > > > > pwritev2().
> > > > >
> > > > > A new RWF_ENCODED flags indicates that a write is "encoded". If this
> > > > > flag is set, iov[0].iov_base points to a struct encoded_iov which
> > > > > contains metadata about the write: namely, the compression algorithm and
> > > > > the unencoded (i.e., decompressed) length of the extent. iov[0].iov_len
> > > > > must be set to sizeof(struct encoded_iov), which can be used to extend
> > > > > the interface in the future. The remaining iovecs contain the encoded
> > > > > extent.
> > > > >
> > > > > A similar interface for reading encoded data can be added to preadv2()
> > > > > in the future.
> > > > >
> > > > > Filesystems must indicate that they support encoded writes by setting
> > > > > FMODE_ENCODED_IO in ->file_open().
> > > > [...]
> > > > > +int import_encoded_write(struct kiocb *iocb, struct encoded_iov *encoded,
> > > > > +                        struct iov_iter *from)
> > > > > +{
> > > > > +       if (iov_iter_single_seg_count(from) != sizeof(*encoded))
> > > > > +               return -EINVAL;
> > > > > +       if (copy_from_iter(encoded, sizeof(*encoded), from) != sizeof(*encoded))
> > > > > +               return -EFAULT;
> > > > > +       if (encoded->compression == ENCODED_IOV_COMPRESSION_NONE &&
> > > > > +           encoded->encryption == ENCODED_IOV_ENCRYPTION_NONE) {
> > > > > +               iocb->ki_flags &= ~IOCB_ENCODED;
> > > > > +               return 0;
> > > > > +       }
> > > > > +       if (encoded->compression > ENCODED_IOV_COMPRESSION_TYPES ||
> > > > > +           encoded->encryption > ENCODED_IOV_ENCRYPTION_TYPES)
> > > > > +               return -EINVAL;
> > > > > +       if (!capable(CAP_SYS_ADMIN))
> > > > > +               return -EPERM;
> > > >
> > > > How does this capable() check interact with io_uring? Without having
> > > > looked at this in detail, I suspect that when an encoded write is
> > > > requested through io_uring, the capable() check might be executed on
> > > > something like a workqueue worker thread, which is probably running
> > > > with a full capability set.
> > >
> > > I discussed this more with Jens. You're right, per-IO permission checks
> > > aren't going to work. In fully-polled mode, we never get an opportunity
> > > to check capabilities in right context. So, this will probably require a
> > > new open flag.
> >
> > Actually, file_ns_capable() accomplishes the same thing without a new
> > open flag. Changing the capable() check to file_ns_capable() in
> > init_user_ns should be enough.
> 
> +Aleksa for openat2() and open() space
> 
> Mmh... but if the file descriptor has been passed through a privilege
> boundary, it isn't really clear whether the original opener of the
> file intended for this to be possible. For example, if (as a
> hypothetical example) the init process opens a service's logfile with
> root privileges, then passes the file descriptor to that logfile to
> the service on execve(), that doesn't mean that the service should be
> able to perform compressed writes into that file, I think.

Ahh, you're right.

> I think that an open flag (as you already suggested) or an fcntl()
> operation would do the job; but AFAIK the open() flag space has run
> out, so if you hook it up that way, I think you might have to wait for
> Aleksa Sarai to get something like his sys_openat2() suggestion
> (https://lore.kernel.org/lkml/20190904201933.10736-12-cyphar@cyphar.com/)
> merged?

If I counted correctly, there's still space for a new O_ flag. One of
the problems that Aleksa is solving is that unknown O_ flags are
silently ignored, which isn't an issue for an O_ENCODED flag. If the
kernel doesn't support it, it won't support RWF_ENCODED, either, so
you'll get EOPNOTSUPP from pwritev2(). So, open flag it is...
