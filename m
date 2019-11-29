Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6EE10D5C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2019 13:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfK2Mna (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Nov 2019 07:43:30 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:42577 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfK2Mn3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Nov 2019 07:43:29 -0500
Received: by mail-vk1-f193.google.com with SMTP id u123so1185030vkb.9;
        Fri, 29 Nov 2019 04:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=GPdrQzCsKSWEOfPSRfTPg/zh6Na3hHHeRHsi7uEzLyw=;
        b=tAnHC+PzdW+JSxsiM9eFc71BES2lxMZd5sN4SXXLSevLbuGOl3HAm3OPVx3AsLTyZD
         zTEhgyzOfsdgvwqgq0Al/c/GFrdM2nCZp7Cm691J0T1v1VJfjqVIuZmzTnxz472PHlrL
         p9alKLGG4gFGby06zAsh3PUOtt2utmmGwAZWQtoGWU3dOub9jmTKMAjYrV59qZZUhizx
         dqZ0Dx/KSphvet7h8n7gWnjjtO8DU+211sHLtanV084cCKiwcW4LHB7V4Qt9wec7IHRW
         ReIFtP4wKLsvVAT81p664w64LFOH0/Q89TmumX3I+i6sQFYS08lxD/x1NwI53orPNgv/
         JJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=GPdrQzCsKSWEOfPSRfTPg/zh6Na3hHHeRHsi7uEzLyw=;
        b=iyJhX0/L2QzTumjeDHpRnybnOk2aoQAScORLMlUqp48mhyrWa7odRwHVexsZVMXqoj
         ni/cRjcR2DIoThCcE9INegG70+fuNSLnBx3+0jKWs6hU+jJ9T4GKiOi6FSd5VPqo7YBk
         CH3urvZGv2XCoFlMY/P8kbJjH6d/9Ubgpd5yU82Xzwvm4k/KtaKSl3gT5ORhmj8G3+IZ
         tT6zPrdbHbNT3mAAozIWHF/WfpLxzzTx7wJTzuVx/4Yr4v2pD0NctnTBKkp3lnFLz/g8
         ofO9qWs/mk0uAZtY3mtK2P5iy6TKc/98Gey+6hcvjX2WqL3o4VhZCbSTomK/stZIOhDR
         pVYQ==
X-Gm-Message-State: APjAAAWPrjdt3ZguN6Ml51sbkqH7ep6GNOMJLS6EFzfZIydBDAWSznai
        9l5xILm6lXx9S87MCYk3CBMcN4y/5T/eNOd5RNI=
X-Google-Smtp-Source: APXvYqw/q5um8xzmDIqrEPtZiuXCJ21x5Pepgp1qfKhR3td3M2hP1r55MBnZJatdo9G7gEhEKyzuDJ33EkZDNuuFvpM=
X-Received: by 2002:a1f:8dc5:: with SMTP id p188mr9894849vkd.13.1575031408661;
 Fri, 29 Nov 2019 04:43:28 -0800 (PST)
MIME-Version: 1.0
References: <f063089fb62c219ea6453c7b9b0aaafd50946dae.camel@hammerspace.com> <20191127202136.GV6211@magnolia>
In-Reply-To: <20191127202136.GV6211@magnolia>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 29 Nov 2019 12:43:17 +0000
Message-ID: <CAL3q7H76DDdvwoMGcxBTbrHNCKN-qAAnKFN5GtmAyAZvjZkHtw@mail.gmail.com>
Subject: Re: Question about clone_range() metadata stability
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 27, 2019 at 8:24 PM Darrick J. Wong <darrick.wong@oracle.com> w=
rote:
>
> On Wed, Nov 27, 2019 at 06:38:46PM +0000, Trond Myklebust wrote:
> > Hi all
> >
> > A quick question about clone_range() and guarantees around metadata
> > stability.
> >
> > Are users required to call fsync/fsync_range() after calling
> > clone_range() in order to guarantee that the cloned range metadata is
> > persisted?
>
> Yes.
>
> > I'm assuming that it is required in order to guarantee that
> > data is persisted.
>
> Data and metadata.  XFS and ocfs2's reflink implementations will flush
> the page cache before starting the remap, but they both require fsync to
> force the log/journal to disk.
>
> (AFAICT the same reasoning applies to btrfs, but don't trust my word for
> it.)

Yep, exactly the same for btrfs.


>
> > I'm asking because knfsd currently just does a call to
> > vfs_clone_file_range() when parsing a NFSv4.2 CLONE operation. It does
> > not call fsync()/fsync_range() on the destination file, and since the
> > NFSv4.2 protocol does not require you to perform any other operation in
> > order to persist data/metadata, I'm worried that we may be corrupting
> > the cloned file if the NFS server crashes at the wrong moment after the
> > client has been told the clone completed.
>
> That analysis seems correct.
>
> --D
>
> > Cheers
> >   Trond
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> >
> >



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
