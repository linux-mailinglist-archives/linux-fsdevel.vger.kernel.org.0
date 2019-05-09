Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E975D184AD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 07:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfEIFCe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 01:02:34 -0400
Received: from newman.cs.utexas.edu ([128.83.139.110]:48955 "EHLO
        newman.cs.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfEIFCe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 01:02:34 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (authenticated bits=0)
        by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id x4952Uh3042165
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 9 May 2019 00:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.utexas.edu;
        s=default; t=1557378150;
        bh=M9kSPIUHJWPmVO2qzlacbT1dp1+eyxwKUZdc7X0fUp4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JxNIckgs3sVa5A9ZYh4kDEw00zV1smckKhfriEj6D2m9U/kciJJN3ie8UOmIQfVmO
         JICRVIwK9dkD8Y4isNTjVclPtG0TnwXDips4D70e+XCfgd5IkSqnTka1EXCPTJ7YLa
         pRGUXK5QUVhuSacNZNWayP0v8IQ3v3qfotPaN7gw=
Received: by mail-oi1-f174.google.com with SMTP id j9so911327oie.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 May 2019 22:02:30 -0700 (PDT)
X-Gm-Message-State: APjAAAUDR0iGr0hYrJeJLEyrnPoa4KHNRylfaGzOUHUZdy5putTt8YnY
        HWp6GtqTJIMGt9irF90juDFd1CZ5TRC0yOnEVrNoZA==
X-Google-Smtp-Source: APXvYqzoYOrl0bNTx7Vg3gJGLvhDqIKGL5VA0mpz1rzOkW0c2cQ1eSSjnEXm2DoopH+EzkxSNGvniR/o5FeZI3UpT7c=
X-Received: by 2002:a05:6808:8d:: with SMTP id s13mr278633oic.6.1557378149812;
 Wed, 08 May 2019 22:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com>
 <CAOQ4uxgEicLTA4LtV2fpvx7okEEa=FtbYE7Qa_=JeVEGXz40kw@mail.gmail.com>
 <CAHWVdUXS+e71QNFAyhFUY4W7o3mzVCb=8UrRZAN=v9bv7j6ssA@mail.gmail.com>
 <CAOQ4uxjNWLvh7EmizA7PjmViG5nPMsvB2UbHW6-hhbZiLadQTA@mail.gmail.com>
 <20190503023043.GB23724@mit.edu> <20190509014327.GT1454@dread.disaster.area> <20190509022013.GC7031@mit.edu>
In-Reply-To: <20190509022013.GC7031@mit.edu>
From:   Vijay Chidambaram <vijay@cs.utexas.edu>
Date:   Thu, 9 May 2019 00:02:17 -0500
X-Gmail-Original-Message-ID: <CAHWVdUVViC_EJm3K7MfvfSQ+G1u=SX=RXAZWPYjZuS16JWxNEw@mail.gmail.com>
Message-ID: <CAHWVdUVViC_EJm3K7MfvfSQ+G1u=SX=RXAZWPYjZuS16JWxNEw@mail.gmail.com>
Subject: Re: [TOPIC] Extending the filesystem crash recovery guaranties contract
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Filipe Manana <fdmanana@suse.com>, Chris Mason <clm@fb.com>,
        lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.3.9 (newman.cs.utexas.edu [128.83.139.110]); Thu, 09 May 2019 00:02:30 -0500 (CDT)
X-Virus-Scanned: clamav-milter 0.98.7 at newman
X-Virus-Status: Clean
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 8, 2019 at 9:30 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Thu, May 09, 2019 at 11:43:27AM +1000, Dave Chinner wrote:
> >
> > .... the whole point of SOMC is that allows filesystems to avoid
> > dragging external metadata into fsync() operations /unless/ there's
> > a user visible ordering dependency that must be maintained between
> > objects.  If all you are doing is stabilising file data in a stable
> > file/directory, then independent, incremental journaling of the
> > fsync operations on that file fit the SOMC model just fine.
>
> Well, that's not what Vijay's crash consistency guarantees state.  It
> guarantees quite a bit more than what you've written above.  Which is
> my concern.

The intention is to capture Dave's SOMC semantics. We can re-iterate
and re-phrase until we capture what Dave meant precisely. I am fairly
confident we can do this, given that Dave himself is participating and
helping us refine the text. So this doesn't seem like a reason not to
have documentation at all to me.

As we have stated on multiple times on this and other threads, the
intention is *not* to come up with one set of crash-recovery
guarantees that every Linux file system must abide by forever. Ted,
you keep repeating this, though we have never said this was our
intention.

The intention behind this effort is to simply document the
crash-recovery guarantees provided today by different Linux file
systems. Ted, you question why this is required at all, and why we
simply can't use POSIX and man pages. The answer:

1. POSIX is vague. Not persisting data to stable media on fsync is
also allowed in POSIX (but no Linux file system actually does this),
so its not very useful in terms of understanding what crash-recovery
guarantees file systems actually provide. Given that all Linux file
systems provide something more than POSIX, the natural question to ask
is what do they provide? We understood this from working on
CrashMonkey, and we wanted to document it.
2. Other parts of the Linux kernel have much better documentation,
even though they similarly want to provide freedom for developers to
optimize and change internal implementation. I don't think
documentation and freedom to change internals are mutually exclusive.
3. XFS provides SOMC semantics, and btrfs developers have stated they
want to provide SOMC as well. F2FS developers have a mode in which
they seek to provide SOMC semantics. Given all this, it seemed prudent
to document SOMC.
4. Apart from developers, a document like this would also help
academic researchers understand the current state-of-the-art in
crash-recovery guarantees and the different choices made by different
file systems. It is non-trivial to understand this without
documentation.

FWIW, I think the position of "if we don't write it down, application
developers can't depend on it" is wrong. Even with nothing written
down, developers noticed they could skip fsync() in ext3 when
atomically updating files with rename(). This lead to the whole ext4
rename-and-delayed-allocation problem. The much better path, IMO, is
to document the current set of guarantees given by different file
systems, and talk about what is intended and what is not. This would
give application developers much better guidance in writing
applications.

If ext4 wants to develop incremental fsync and introduce a new set of
semantics that is different from SOMC and much closer to minimal
POSIX, I don't think the documentation affects that at all. As Dave
notes, diversity is good! Documentation is also good :)

That being said, I think I'll stop our push to get this documented
inside the Linux kernel at this point. We got useful comments from
Dave, Amir, and others, so we will incorporate those comments and put
up the documentation on a University of Texas web page. If someone
else wants to carry on and get this merged, you are welcome to do so
:)
