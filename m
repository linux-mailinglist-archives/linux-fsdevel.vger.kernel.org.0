Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E59A12666
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 05:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfECDPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 23:15:15 -0400
Received: from newman.cs.utexas.edu ([128.83.139.110]:38176 "EHLO
        newman.cs.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfECDPP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 23:15:15 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (authenticated bits=0)
        by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id x433FCcG015316
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 2 May 2019 22:15:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.utexas.edu;
        s=default; t=1556853313;
        bh=TCdPdnIujETZrPtlwd+LUywxsYBkZCmyPwSXIqolwos=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S+wMzgE045n+7ihu+Xt10ZnjLJ6Lg1CBpxSoaMDoEHdPCqj5AuluJO6A6INF3rrRr
         Es4GBXh2QrIsRnij1GoHTs1m4XMliChxiYBorzHa+/ApBdEzvHBHgSOSsBVNmGxAqR
         s5CnxKnCNGq4mYhj671pZULsY+pA6LblO6l97jxM=
Received: by mail-ot1-f51.google.com with SMTP id g24so4111982otq.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2019 20:15:13 -0700 (PDT)
X-Gm-Message-State: APjAAAVy5Jc9O30fygSgeWWcWCezNG3GRinUo8eK6OS31jjblyTUw2xu
        v3vGyYJgBfthEmratOUJm2chmvfbHmfaFOYfX1rzMA==
X-Google-Smtp-Source: APXvYqzZ3sTZfr4+K2a1MDtzYD8crxFkGTIGNndBri3mL0Mo6Wt23KUr/0q85+9WuDlgoMun7wIZXJIOUvHtLwKJJk0=
X-Received: by 2002:a9d:7d04:: with SMTP id v4mr4735190otn.185.1556853312748;
 Thu, 02 May 2019 20:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com>
 <CAOQ4uxgEicLTA4LtV2fpvx7okEEa=FtbYE7Qa_=JeVEGXz40kw@mail.gmail.com>
 <CAHWVdUXS+e71QNFAyhFUY4W7o3mzVCb=8UrRZAN=v9bv7j6ssA@mail.gmail.com>
 <CAOQ4uxjNWLvh7EmizA7PjmViG5nPMsvB2UbHW6-hhbZiLadQTA@mail.gmail.com> <20190503023043.GB23724@mit.edu>
In-Reply-To: <20190503023043.GB23724@mit.edu>
From:   Vijay Chidambaram <vijay@cs.utexas.edu>
Date:   Thu, 2 May 2019 22:15:01 -0500
X-Gmail-Original-Message-ID: <CAHWVdUV115x8spvAd3p-6iDRE--yZULbF6DDc+Hapt2s+pJgbA@mail.gmail.com>
Message-ID: <CAHWVdUV115x8spvAd3p-6iDRE--yZULbF6DDc+Hapt2s+pJgbA@mail.gmail.com>
Subject: Re: [TOPIC] Extending the filesystem crash recovery guaranties contract
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Filipe Manana <fdmanana@suse.com>, Chris Mason <clm@fb.com>,
        lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.3.9 (newman.cs.utexas.edu [128.83.139.110]); Thu, 02 May 2019 22:15:13 -0500 (CDT)
X-Virus-Scanned: clamav-milter 0.98.7 at newman
X-Virus-Status: Clean
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Again, here is my concern.  If we promise that ext4 will always obey
> Dave Chinner's SOMC model, it would forever rule out Daejun Park and
> Dongkun Shin's "iJournaling: Fine-grained journaling for improving the
> latency of fsync system call"[1] published in Usenix ATC 2017.
>
> [1] https://www.usenix.org/system/files/conference/atc17/atc17-park.pdf
>
> That's because this provides a fast fsync() using an incremental
> journal.  This fast fsync would cause the metadata associated with the
> inode being fsync'ed to be persisted after the crash --- ahead of
> metadata changes to other, potentially completely unrelated files,
> which would *not* be persisted after the crash.  Fine grained
> journalling would provide all of the guarantee all of the POSIX, and
> for applications that only care about the single file being fsync'ed
> -- they would be happy.  BUT, it violates the proposed crash
> consistency guarantees.
>
> So if the crash consistency guarantees forbids future innovations
> where applications might *want* a fast fsync() that doesn't drag
> unrelated inodes into the persistence guarantees, is that really what
> we want?  Do we want to forever rule out various academic
> investigations such as Park and Shin's because "it violates the crash
> consistency recovery model"?  Especially if some applications don't
> *need* the crash consistency model?
>
>                                                 - Ted
>
> P.S.  I feel especially strong about this because I'm working with an
> engineer currently trying to implement a simplified version of Park
> and Shin's proposal...  So this is not a hypothetical concern of mine.
> I'd much rather not invalidate all of this engineer's work to date,
> especially since there is a published paper demonstrating that for
> some workloads (such as sqlite), this approach can be a big win.

Ted, I sympathize with your position. To be clear, this is not what my
group or Amir is suggesting we do.

A few things to clarify:
1) We are not suggesting that all file systems follow SOMC semantics.
If ext4 does not want to do so, we are quite happy to document ext4
provides a different set of reasonable semantics. We can make the
ext4-related documentation as minimal as you want (or drop ext4 from
documentation entirely). I'm hoping this will satisfy you.
2) As I understand it, I do not think SOMC rules out the scenario in
your example, because it does not require fsync to push un-related
files to storage.
3) We are not documenting how fsync works internally, merely what the
user-visible behavior is. I think this will actually free up file
systems to optimize fsync aggressively while making sure they provide
the required user-visible behavior.

Quoting from Dave Chinner's response when you brought up this concern
previously (https://patchwork.kernel.org/patch/10849903/#22538743):

"Sure, but again this is orthognal to what we are discussing here:
the user visible ordering of metadata operations after a crash.

If anyone implements a multi-segment or per-inode journal (say, like
NOVA), then it is up to that implementation to maintain the ordering
guarantees that a SOMC model requires. You can implement whatever
fsync() go-fast bits you want, as long as it provides the ordering
behaviour guarantees that the model defines.

IOWs, Ted, I think you have the wrong end of the stick here. This
isn't about optimising fsync() to provide better performance, it's
about guaranteeing order so that fsync() is not necessary and we
improve performance by allowing applications to omit order-only
synchornisation points in their workloads.

i.e. an order-based integrity model /reduces/ the need for a
hyper-optimised fsync operation because applications won't need to
use it as often."

> P.P.S.  One of the other discussions that did happen during the main
> LSF/MM File system session, and for which there was general agreement
> across a number of major file system maintainers, was a fsync2()
> system call which would take a list of file descriptors (and flags)
> that should be fsync'ed.  The semantics would be that when the
> fsync2() successfully returns, all of the guarantees of fsync() or
> fdatasync() requested by the list of file descriptors and flags would
> be satisfied.  This would allow file systems to more optimally fsync a
> batch of files, for example by implementing data integrity writebacks
> for all of the files, followed by a single journal commit to guarantee
> persistence for all of the metadata changes.

I like this "group fsync" idea. I think this is a great way to extend
the basic fsync interface.
