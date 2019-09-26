Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02F70BE9B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 02:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391071AbfIZAhE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 20:37:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44151 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391043AbfIZAhB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:37:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id q21so595984pfn.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2019 17:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uOStsxQqfO06OYtHmn1zyVyHteg7NOzz5rqwNkTb9ow=;
        b=JiqmtcSBsaozI32UI7NC2RmIz4mXNttFMZqTO2p33b8Dk5Mrifi/nUziyw4zDzpSXj
         JHHJFWSwQUoRhjJMrkVdiaZUpWFLTqVwCka11YtGWdEOlVEQvPXU7/E1Xa9xow91cYpE
         KlWhW0X+kM6JXN3Z9MyYyk2t1MFAbH9PwIuSYGV9gDxS0fX52PcwH4E5ysH5/p5LgdlB
         SzAP0yFOxveNcN0RHdOhbjpB5wEjcKOyYngPNzvK9dC/+aN7wUMdxcDWLkr8UBLJispg
         gRPj/giSgVsvvMux8DlWDbC6WDUFTRY7XZjUTI2pG4WihGnjdhptil70Fh7DnUjEHWHI
         vhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uOStsxQqfO06OYtHmn1zyVyHteg7NOzz5rqwNkTb9ow=;
        b=MEZqLhJenHcdhKvsrFlhvNXQzBVlOp/cK4VVZMK4eCyB6sboXLboBIYbbeiR43hbRM
         TwJjleNJ4LIZMU4T01Kl6GoMAjAyvU1QWgLQ+qFeoQgpfAx+1NYTz2cnqYT9i66E5Qv/
         hZpD6bPDEHZ6iMB6HrEVwDfjcQHLlPs8AP8guTrbYclrcipNK1rT8SfYCSju5pDLQnxA
         jdcg3yeegLwz++vOpUR5FRbKfN+ZILmDv8JYMneNLTJj7VCnFwUxVxTPqyLsPMCz8opg
         xtUVvttwykOjAyWHdVWuJmjp0XRgs0OmtZIfPtpia+3Vq2QW8meRc6HQnNkhcuNqkghD
         US0A==
X-Gm-Message-State: APjAAAUyGYua0/jQtdA7thMDeYnENXLU6BGEkepQUhDfrXQK69EcdlOB
        FXwSYwJpdSgL62ar3Wz4Dcz+Dg==
X-Google-Smtp-Source: APXvYqxFO4le1GcOPrqGJrQOBTZwee7HUoRxS+iDZqfwUACSVSFP0Fg5NHCc+2VkbGcDU5NxqFCbfQ==
X-Received: by 2002:a17:90a:6c90:: with SMTP id y16mr570103pjj.58.1569458219611;
        Wed, 25 Sep 2019 17:36:59 -0700 (PDT)
Received: from vader ([2607:fb90:8361:57cc:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id x23sm166889pfq.140.2019.09.25.17.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 17:36:58 -0700 (PDT)
Date:   Wed, 25 Sep 2019 17:36:56 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jann Horn <jannh@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH 2/3] fs: add RWF_ENCODED for writing compressed data
Message-ID: <20190926003656.GA10413@vader>
References: <cover.1568875700.git.osandov@fb.com>
 <230a76e65372a8fb3ec62ce167d9322e5e342810.1568875700.git.osandov@fb.com>
 <CAG48ez2GKv15Uj6Wzv0sG5v2bXyrSaCtRTw5Ok_ovja_CiO_fQ@mail.gmail.com>
 <20190924171513.GA39872@vader>
 <20190924193513.GA45540@vader>
 <CAG48ez1NQBNR1XeVQYGoopEk=g_KedUr+7jxLQTaO+V8JCeweQ@mail.gmail.com>
 <20190925071129.GB804@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925071129.GB804@dread.disaster.area>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 25, 2019 at 05:11:29PM +1000, Dave Chinner wrote:
> On Tue, Sep 24, 2019 at 10:01:41PM +0200, Jann Horn wrote:
> > On Tue, Sep 24, 2019 at 9:35 PM Omar Sandoval <osandov@osandov.com> wrote:
> > > On Tue, Sep 24, 2019 at 10:15:13AM -0700, Omar Sandoval wrote:
> > > > On Thu, Sep 19, 2019 at 05:44:12PM +0200, Jann Horn wrote:
> > > > > On Thu, Sep 19, 2019 at 8:54 AM Omar Sandoval <osandov@osandov.com> wrote:
> > > > > > Btrfs can transparently compress data written by the user. However, we'd
> > > > > > like to add an interface to write pre-compressed data directly to the
> > > > > > filesystem. This adds support for so-called "encoded writes" via
> > > > > > pwritev2().
> > > > > >
> > > > > > A new RWF_ENCODED flags indicates that a write is "encoded". If this
> > > > > > flag is set, iov[0].iov_base points to a struct encoded_iov which
> > > > > > contains metadata about the write: namely, the compression algorithm and
> > > > > > the unencoded (i.e., decompressed) length of the extent. iov[0].iov_len
> > > > > > must be set to sizeof(struct encoded_iov), which can be used to extend
> > > > > > the interface in the future. The remaining iovecs contain the encoded
> > > > > > extent.
> > > > > >
> > > > > > A similar interface for reading encoded data can be added to preadv2()
> > > > > > in the future.
> > > > > >
> > > > > > Filesystems must indicate that they support encoded writes by setting
> > > > > > FMODE_ENCODED_IO in ->file_open().
> > > > > [...]
> > > > > > +int import_encoded_write(struct kiocb *iocb, struct encoded_iov *encoded,
> > > > > > +                        struct iov_iter *from)
> > > > > > +{
> > > > > > +       if (iov_iter_single_seg_count(from) != sizeof(*encoded))
> > > > > > +               return -EINVAL;
> > > > > > +       if (copy_from_iter(encoded, sizeof(*encoded), from) != sizeof(*encoded))
> > > > > > +               return -EFAULT;
> > > > > > +       if (encoded->compression == ENCODED_IOV_COMPRESSION_NONE &&
> > > > > > +           encoded->encryption == ENCODED_IOV_ENCRYPTION_NONE) {
> > > > > > +               iocb->ki_flags &= ~IOCB_ENCODED;
> > > > > > +               return 0;
> > > > > > +       }
> > > > > > +       if (encoded->compression > ENCODED_IOV_COMPRESSION_TYPES ||
> > > > > > +           encoded->encryption > ENCODED_IOV_ENCRYPTION_TYPES)
> > > > > > +               return -EINVAL;
> > > > > > +       if (!capable(CAP_SYS_ADMIN))
> > > > > > +               return -EPERM;
> > > > >
> > > > > How does this capable() check interact with io_uring? Without having
> > > > > looked at this in detail, I suspect that when an encoded write is
> > > > > requested through io_uring, the capable() check might be executed on
> > > > > something like a workqueue worker thread, which is probably running
> > > > > with a full capability set.
> > > >
> > > > I discussed this more with Jens. You're right, per-IO permission checks
> > > > aren't going to work. In fully-polled mode, we never get an opportunity
> > > > to check capabilities in right context. So, this will probably require a
> > > > new open flag.
> > >
> > > Actually, file_ns_capable() accomplishes the same thing without a new
> > > open flag. Changing the capable() check to file_ns_capable() in
> > > init_user_ns should be enough.
> > 
> > +Aleksa for openat2() and open() space
> > 
> > Mmh... but if the file descriptor has been passed through a privilege
> > boundary, it isn't really clear whether the original opener of the
> > file intended for this to be possible. For example, if (as a
> > hypothetical example) the init process opens a service's logfile with
> > root privileges, then passes the file descriptor to that logfile to
> > the service on execve(), that doesn't mean that the service should be
> > able to perform compressed writes into that file, I think.
> 
> Where's the privilege boundary that is being crossed?
> 
> We're talking about user data read/write access here, not some
> special security capability. Access to the data has already been
> permission checked, so why should the format that the data is
> supplied to the kernel in suddenly require new privilege checks?
> 
> i.e. writing encoded data to a file requires exactly the same
> access permissions as writing cleartext data to the file. The only
> extra information here is whether the _filesystem_ supports encoded
> data, and that doesn't change regardless of what the open file gets
> passed to. Hence the capability is either there or it isn't, it
> doesn't transform not matter what privilege boundary the file is
> passed across. Similarly, we have permission to access the data
> or we don't through the struct file, it doesn't transform either.
> 
> Hence I don't see why CAP_SYS_ADMIN or any special permissions are
> needed for an application with access permissions to file data to
> use these RWF_ENCODED IO interfaces. I am inclined to think the
> permission check here is wrong and should be dropped, and then all
> these issues go away.
> 
> Yes, the app that is going to use this needs root perms because it
> accesses all data in the fs (it's a backup app!), but that doesn't
> mean you can only use RWF_ENCODED if you have root perms.

For RWF_ENCODED writes, the risk here is that we'd be adding a way for
an unprivileged process to feed arbitrary data to zlib/lzo/zstd in the
kernel. From what I could find, this is a new attack surface for
unprivileged processes, and based on the search results for
"$compression_algorithm CVE", there are real bugs here.

For RWF_ENCODED reads, there's another potential issue that occurred to
me. There are a few operations for which we may need to chop up a
compressed extent: hole punch, truncate, reflink, and dedupe. Rather
than recompressing the data, Btrfs keeps the whole extent on disk and
updates the file metadata to refer to a piece of the extent. If we want
to support RWF_ENCODED reads for such extents (and I think we do), then
we need to return the entire original extent along with that metadata.
For an unprivileged reader, there's a security issue that we may be
returning data that the reader wasn't supposed to see. (A privileged
reader can go and read the block device anyways.)

So, in my opinion, both reads and writes should require privilege just
to be on the safe side.
