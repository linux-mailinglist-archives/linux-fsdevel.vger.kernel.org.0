Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D76DA1367F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2019 02:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfEDASI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 20:18:08 -0400
Received: from newman.cs.utexas.edu ([128.83.139.110]:46276 "EHLO
        newman.cs.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfEDASI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 20:18:08 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (authenticated bits=0)
        by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id x440I6h5015864
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 3 May 2019 19:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.utexas.edu;
        s=default; t=1556929086;
        bh=do6FZFsLfUaYoh6r1GPjrzM/556ikEAls0W/lvuNMUk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G9YRK92bzfs8Fs6midBc1o4HoyYCfivhIAYB9iMd4cDpoJtIGC8+smEe7FZlGuK38
         mCOTXnPHM7ipVKocuUMyAEk2tNoI4PUgE6gmvaL+79iyjzFUM1yvNH0e7PTzvWSUsV
         g+6iRWy2EJ3fypJK+HLURXoWgx2oHLDRy4om09aY=
Received: by mail-ot1-f42.google.com with SMTP id g24so6870513otq.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2019 17:18:06 -0700 (PDT)
X-Gm-Message-State: APjAAAWXHcIgpiGl0fguH2Q5EUyNBdRNH4KaZ8Us8j4TvVrfRj++NBl+
        hms+84Sl6q/1c3LWZlAsqolmQIRwa8e8H8mSq10mgA==
X-Google-Smtp-Source: APXvYqxK7frUfo0lci16jAHaiZRByf9iF2EdUeV+9q678lczfj7FoJzU9lVPCqsTq4lsVZpxwQ9Y//w0rWeQdQvMoBY=
X-Received: by 2002:a05:6830:158f:: with SMTP id i15mr1626333otr.14.1556929085917;
 Fri, 03 May 2019 17:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com>
 <CAOQ4uxgEicLTA4LtV2fpvx7okEEa=FtbYE7Qa_=JeVEGXz40kw@mail.gmail.com>
 <CAHWVdUXS+e71QNFAyhFUY4W7o3mzVCb=8UrRZAN=v9bv7j6ssA@mail.gmail.com>
 <CAOQ4uxjNWLvh7EmizA7PjmViG5nPMsvB2UbHW6-hhbZiLadQTA@mail.gmail.com>
 <20190503023043.GB23724@mit.edu> <CAHWVdUV115x8spvAd3p-6iDRE--yZULbF6DDc+Hapt2s+pJgbA@mail.gmail.com>
 <20190503094543.GD23724@mit.edu>
In-Reply-To: <20190503094543.GD23724@mit.edu>
From:   Vijay Chidambaram <vijay@cs.utexas.edu>
Date:   Fri, 3 May 2019 19:17:54 -0500
X-Gmail-Original-Message-ID: <CAHWVdUWrKigH8g-Jhi404y+XvuhXAx4b+PBW8_hLF4110etSLg@mail.gmail.com>
Message-ID: <CAHWVdUWrKigH8g-Jhi404y+XvuhXAx4b+PBW8_hLF4110etSLg@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.3.9 (newman.cs.utexas.edu [128.83.139.110]); Fri, 03 May 2019 19:18:06 -0500 (CDT)
X-Virus-Scanned: clamav-milter 0.98.7 at newman
X-Virus-Status: Clean
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> As documented, the draft of the rules *I* saw specifically said that a
> fsync() to inode B would guarantee that metadata changes for inode A,
> which were made before the changes to inode B, would be persisted to
> disk since the metadata changes for B happened after the changes to
> inode A.  It used the fsync(2) *explicitly* as an example for how
> ordering of unrelated files could be guaranteed.  And this would
> invalidate Park and Shin's incremental journal for fsync.
>
> If the guarantees are when fsync(2) is *not* being used, sure, then
> the SOMC model is naturally what would happen with most common file
> system.  But then fsync(2) needs to appear nowhere in the crash
> consistency model description, and that is not the case today.
>

I think there might be a mis-understanding about the example
(reproduced below) and about SOMC. The relationship that matters is
not whether X happens before Y. The relationship between X and Y is
that they are in the same directory, so fsync(new file X) implies
fsync(X's parent directory) which contains Y.  In the example, X is
A/foo and Y is A/bar. For truly un-related files such as A/foo and
B/bar, SOMC does indeed allow fsync(A/foo) to not persist B/bar.

touch A/foo
echo =E2=80=9Chello=E2=80=9D >  A/foo
sync
mv A/foo A/bar
echo =E2=80=9Cworld=E2=80=9D > A/foo
fsync A/foo
CRASH

We could rewrite the example to not include fsync, but this example
comes directly from xfstest generic/342, so we would like to preserve
it.

But in any case, I think this is beside the point. If ext4 does not
want to provide SOMC-like behavior, I think that is totally
reasonable. The documentation does *not* say all file systems should
provide SOMC. As long as the documentation does not say ext4 provides
SOMC-like behavior, are you okay with the rest of the documentation
effort? If so, we can send out v3 with these changes.

Please forgive my continued pushing on this:  I would like to see more
documentation about these file-system aspects in the kernel. XFS and
btrfs developers approved of the effort, so there is some support for
this. We have already put in some work on the documentation, so I'd
like to see it finished up and merged. (Sorry for hijacking/forking
the thread Amir!)
