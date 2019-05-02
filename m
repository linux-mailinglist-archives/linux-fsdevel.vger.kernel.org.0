Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE9A12129
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 19:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfEBRj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 13:39:59 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42456 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEBRj7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 13:39:59 -0400
Received: by mail-yw1-f68.google.com with SMTP id y131so2186042ywa.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2019 10:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zIttL0t4AS0Zz3UxbcFh+mxaazoURxQz+i9NrA3xWxM=;
        b=LwAMiG9EhZEOIIDyE+kUe3zmX2QhPV6KfTcAw5aEW67gJl4iW4QyNyOlR9gFHs7kji
         kjbHTJa9Id/7r8oCrPhrCkCgOpFVsJ5c6lj1ATf6C1reJC2j0ycptutdwohn3wxfwneB
         BnOtQpi1AmHdIAHqC58RRjbvs4NyPxTLRS1rl3rniFrWuj2YcuwLEUsGXpWwjgd4Ffni
         226QYZohb3wMHkhycKry4dl1DOuf1aWEvb/SVrMOCqUVsdJ4SnKQbbuYwalzMXJElPAJ
         XnrZGeTiAEtqDAdcS9sCJ7E2+qxnCKWi7gW/PNgXREyTktGqEvsLfNgIu0N4r7Zka8qG
         sdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zIttL0t4AS0Zz3UxbcFh+mxaazoURxQz+i9NrA3xWxM=;
        b=MPsJq5STYWFSbMiDsANyi/cCah9YTo5sKN55DHk7wjRfCO2eBg5484YScF/XwrE0Q2
         sFUyrBHa6M2GGTJMWT+Y0n4dy+iUNTNXCkT5y/jgBd1GqiAZYPDF5Bedf1jrrdfpA/6P
         TQrLsZW6tBIfPdOtuf5QC5HlkP9t/e9AF0Py39oO98N2Ns9fEIKQd/QwK+9jKnfRNWjk
         ROlM+QAFZVSCzdO7sjVL3o+T/Iko0aDrpc4ifcFwvnR4mRhOyI+q97M4aAmCo9/77LTH
         5KSWS9vdNyrnj8qbQjNZty4n9sVzNhQbTSzubqRuciRxkgZn5h7VfFIVUR54aPtLGaZh
         wE8w==
X-Gm-Message-State: APjAAAU29d1F69WRKEAG1lsZBnKu6ouSu356yhM6v1dwwBDcBU9Rvr7T
        GJLowWFbnn0JXOurpUbkwywUn7KlCoX4OxYw2hw=
X-Google-Smtp-Source: APXvYqzlVT47hpGRbi/Yl8yijWS9KZ3qEdPS0NBuSIGQDDcxa1VHMD2n6nEQlEVgh5m6VlnbirHc/mUKd5qM8lMeiGU=
X-Received: by 2002:a5b:48a:: with SMTP id n10mr4277104ybp.320.1556818798080;
 Thu, 02 May 2019 10:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com>
 <CAOQ4uxgEicLTA4LtV2fpvx7okEEa=FtbYE7Qa_=JeVEGXz40kw@mail.gmail.com> <CAHWVdUXS+e71QNFAyhFUY4W7o3mzVCb=8UrRZAN=v9bv7j6ssA@mail.gmail.com>
In-Reply-To: <CAHWVdUXS+e71QNFAyhFUY4W7o3mzVCb=8UrRZAN=v9bv7j6ssA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 2 May 2019 13:39:47 -0400
Message-ID: <CAOQ4uxjNWLvh7EmizA7PjmViG5nPMsvB2UbHW6-hhbZiLadQTA@mail.gmail.com>
Subject: Re: [TOPIC] Extending the filesystem crash recovery guaranties contract
To:     Vijay Chidambaram <vijay@cs.utexas.edu>
Cc:     lsf-pc@lists.linux-foundation.org,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Filipe Manana <fdmanana@suse.com>, Chris Mason <clm@fb.com>,
        lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 2, 2019 at 1:11 PM Vijay Chidambaram <vijay@cs.utexas.edu> wrote:
>
> Thank you for driving this discussion Amir. I'm glad ext4 and btrfs
> developers want to provide these semantics.
>
> If I'm understanding this correctly, the new semantics will be: any
> data changes to files written with O_TMPFILE will be visible if the
> associated metadata is also visible. Basically, there will be a
> barrier between O_TMPFILE data and O_TMPFILE metadata.

Mmm, this phrasing deviates from what I wrote.
The agreement is that we should document something *minimal*
that users can understand. I was hoping that this phrasing meets
those requirements:

""The filesystem provided the guaranty that after a crash, if the linked
 O_TMPFILE is observed in the target directory, than all the data and
 metadata modifications made to the file before being linked are also
 observed."

No more, no less.

>
> The expectation is that applications will use this, and then rename
> the O_TMPFILE file over the original file. Is this correct? If so, is
> there also an implied barrier between O_TMPFILE metadata and the
> rename?

Not really, the use case is when users want to create a file to apear
"atomically" in the namespace with certain data and metadata.

For replacing an existing file with another the same could be
achieved with renameat2(AT_FDCWD, tempname, AT_FDCWD, newname,
RENAME_ATOMIC). There is no need to create the tempname
file using O_TMPFILE in that case, but if you do, the RENAME_ATOMIC
flag would be redundant.

RENAME_ATOMIC flag is needed because directories and non regular
files cannot be created using O_TMPFILE.

>
> Where does this land us on the discussion about documenting
> file-system crash-recovery guarantees? Has that been deemed not
> necessary?
>

Can't say for sure.
Some filesystem maintainers hold on to the opinion that they do
NOT wish to have a document describing existing behavior of specific
filesystems, which is large parts of the document that your group posted.

They would rather that only the guaranties of the APIs are documented
and those should already be documented in man pages anyway - if they
are not, man pages could be improved.

I am not saying there is no room for a document that elaborates on those
guaranties. I personally think that could be useful and certainly think that
your group's work for adding xfstest coverage for API guaranties is useful.

Thanks,
Amir.
