Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15208126A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 06:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbfECEQo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 00:16:44 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43289 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfECEQo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 00:16:44 -0400
Received: by mail-yw1-f65.google.com with SMTP id p19so496825ywe.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2019 21:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vf5mInp7UYaZ/4qW3eNsXHV3KbFkT3uAMhg8Vqa2kqg=;
        b=RsXLe3N7WsAbganPDS3PMUIl3zjsFSvnTvmEK5rk/ocxpdRuZMNrtILSvfaS9ZybZj
         4Qz/+9MyO35nwJK9neZve91EeP3Hs7fssPQLqlfeXuF3bCGo+daizOgLYRK+HTsKGt6v
         MNCq+n8jZlnBCsNwGpohzHRzAiKdllDSzn5U0Maa/jHTvu0+X+2XKGOZ87uOrjz/1eqh
         4SSDjzu7zF63UogTqen6NWS+s3h+O5a5D7JrbS+6b73SAIIzqtmJ8dbRQm5f5p89skHQ
         mauw8tDj/QyiO/UD1FMlOlLdo/bp9a24ukUckNwvwnsQN0hzLFumUcweVtrhaRqOTZEU
         FiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vf5mInp7UYaZ/4qW3eNsXHV3KbFkT3uAMhg8Vqa2kqg=;
        b=WlHYJ4wCPl4KP76jz5FKonVoQy1H5ZUBRDeEwa6BkhyhFjZKxmMgHzUeWjAaPFuz2A
         Aakze/Ioz71BkjKvQAWiSJmDuzazlQ91CHTDdsGCXK7JmpsFdVi+NfuJUH8FCWz5c+5m
         2oVciXTebQV/9v2DjQZz1lWY8kODDJspDmWx8tqo8f9TEECE8DzdQa/uYYVPWOU9RqoN
         BblrEmhHBk9yf+/5fUxzkg/ZXmzynJtkOcprHBNCqN26beh+2IjQnfOPU7EiS+ld2foz
         R4utOn9ZXzUyngE8CJKeU6G1VjOhVHFvwR6UCyze46p/9oIbEDgbStSYAfgW6nfuhUPB
         1yYA==
X-Gm-Message-State: APjAAAWlX8593aOgD+t+rv2CikmFr4qLAdxH2BUGFNE+XrXNO2t0ErHW
        Y37uer6uJP5oUorsuMaQU+etlBRVkqwUFWlfzwg=
X-Google-Smtp-Source: APXvYqwS6X2lRF2QpB2h8zTjfRBwCWEUfabNLRjpoH/MVSyHBF8ZAkM/EMDUmxOo+UVkfspGvliJUFjBoEfcEnsxWVQ=
X-Received: by 2002:a25:74c9:: with SMTP id p192mr6434544ybc.507.1556857003945;
 Thu, 02 May 2019 21:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com>
 <CAOQ4uxgEicLTA4LtV2fpvx7okEEa=FtbYE7Qa_=JeVEGXz40kw@mail.gmail.com>
 <CAHWVdUXS+e71QNFAyhFUY4W7o3mzVCb=8UrRZAN=v9bv7j6ssA@mail.gmail.com>
 <CAOQ4uxjNWLvh7EmizA7PjmViG5nPMsvB2UbHW6-hhbZiLadQTA@mail.gmail.com> <20190503023043.GB23724@mit.edu>
In-Reply-To: <20190503023043.GB23724@mit.edu>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 3 May 2019 00:16:32 -0400
Message-ID: <CAOQ4uxjM+ivnn-oU482GmRqOF6bYY5j89NdyHnfH++f49qB4yw@mail.gmail.com>
Subject: Re: [TOPIC] Extending the filesystem crash recovery guaranties contract
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Vijay Chidambaram <vijay@cs.utexas.edu>,
        lsf-pc@lists.linux-foundation.org,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Filipe Manana <fdmanana@suse.com>, Chris Mason <clm@fb.com>,
        lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 2, 2019 at 10:30 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Thu, May 02, 2019 at 01:39:47PM -0400, Amir Goldstein wrote:
> > > The expectation is that applications will use this, and then rename
> > > the O_TMPFILE file over the original file. Is this correct? If so, is
> > > there also an implied barrier between O_TMPFILE metadata and the
> > > rename?
>
> In the case of O_TMPFILE, the file can be brought into the namespace
> using something like:
>
> linkat(AT_FDCWD, "/proc/self/fd/42", AT_FDCWD, pathname, AT_SYMLINK_FOLLOW);
>
> it's not using rename.
>
> To be clear, this discussion happened in the hallway, and it's not
> clear it had full support by everyone.  After our discussion, some of
> us came up with an example where forcing a call to
> filemap_write_and_wait() before the linkat(2) might *not* be the right
> thing.  Suppose some browser wanted to wait until a file was fully(
> downloaded before letting it appear in the directory --- but what was
> being downloaded was a 4 GiB DVD image (say, a distribution's install
> media).  If the download was done using O_TMPFILE followed by
> linkat(2), that might be a case where forcing the data blocks to disk
> before allowing the linkat(2) to proceed might not be what the
> application or the user would want.
>
> So it might be that we will need to add a linkat flag to indicate that
> we want the kernel to call filemap_write_and_wait() before making the
> metadata changes in linkat(2).
>

Agreed.

> > For replacing an existing file with another the same could be
> > achieved with renameat2(AT_FDCWD, tempname, AT_FDCWD, newname,
> > RENAME_ATOMIC). There is no need to create the tempname
> > file using O_TMPFILE in that case, but if you do, the RENAME_ATOMIC
> > flag would be redundant.
> >
> > RENAME_ATOMIC flag is needed because directories and non regular
> > files cannot be created using O_TMPFILE.
>
> I think there's much less consensus about this.  Again, most of this
> happened in a hallway conversation.
>

OK. we can leave that one for later.
Although I am not sure what the concern is.
If we are able to agree  and document a LINK_ATOMIC flag,
what would be the down side of documenting a RENAME_ATOMIC
flag with same semantics? After all, as I said, this is what many users
already expect when renaming a temp file (as ext4 heuristics prove).

I would love to get Dave's take on the proposal of LINK_ATOMIC/
RENAME_ATOMIC, preferably before the discussion wanders off
to an argument about what SOMC means...

Thanks,
Amir.
