Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2C37186FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 10:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfEIIr1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 04:47:27 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34066 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfEIIr1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 04:47:27 -0400
Received: by mail-yw1-f67.google.com with SMTP id n76so1285460ywd.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2019 01:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mTrdMZY0rl+Z/LsYF0zBWmZC7412KvJsbPvQM8xFjZY=;
        b=AYAJ9dnhx42kLOyw0KfNySjYMiws/eLENKDoR18kLjhu++LK0hmO3MLC6JnNN1Jq4p
         eXQIxqw3eRa+gDCieeRTurFUPW+tBpH/uwmVB9I3TP4dlTyERB+xiYUKhqQy0B4WD7Sz
         mGEkLSndJfqgr3dzUCbXGwYa048MmjtAc4ASIDDIP42Q9iE1ebI9SVoKx5yVuA88waft
         P2H6F9CJybaTy1BhMvhb1a1cRuzapvPTv9GPBpD3Iwx8V2dJ90DJOyVsn/wTOWVbhAs3
         GIy6iItTkiAeVnEHT2tsbiku5cGy0AKtzFHdue6/GZ1gNrHXvNbTjEoENWdttc/94Us6
         RG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mTrdMZY0rl+Z/LsYF0zBWmZC7412KvJsbPvQM8xFjZY=;
        b=gi14YizJc1LoEYkUAFTKav3xhyGTdFBQ1Lvr0wSHuAATFPx6e6g1PwDEdFvg42QVe0
         KjcyxjVV5w75LqLd2FLIoDz1M8TkkrGcQ2/iYPU7ri8eHdkTIjTBa3xoWRygI36b8R+v
         8ZQyr7GkmwuTfiHuHz0UpctBCZnQ9eSV4WvASjJXBGO0tYq0cT5vL665SVPXLRsai/SS
         7EqqTkBfookdQzkqn4A0OxQUZv1+IVAEttMExBmoWfTqJeM56KGllcsqcPqPa7KHQ/7M
         2+hyRTgYugyVQfN4LTdVG1fq4hUm6lwIdNJYmTccFxR4ws9O3A04CFW4Fkh4GGFGFyyE
         YjmQ==
X-Gm-Message-State: APjAAAXfVd8cfJsoxn3OrOUvTfy3W7hH5Vh492Ex9zBxY5/K3W/hzi38
        tCXb/vmsAmcH2N2UddgGltEu5LPRxWIB1urCy00=
X-Google-Smtp-Source: APXvYqzU/VDgJhBaI8RbpPyBzDEMR8k3xJUeQDwrj6GUXnBav4apN7prcDyaP0IovX90JulCuhBB2WaxLpaczXJgsSo=
X-Received: by 2002:a81:7dc5:: with SMTP id y188mr1177914ywc.34.1557391646773;
 Thu, 09 May 2019 01:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com>
 <CAOQ4uxgEicLTA4LtV2fpvx7okEEa=FtbYE7Qa_=JeVEGXz40kw@mail.gmail.com>
 <CAHWVdUXS+e71QNFAyhFUY4W7o3mzVCb=8UrRZAN=v9bv7j6ssA@mail.gmail.com>
 <CAOQ4uxjNWLvh7EmizA7PjmViG5nPMsvB2UbHW6-hhbZiLadQTA@mail.gmail.com>
 <20190503023043.GB23724@mit.edu> <20190509014327.GT1454@dread.disaster.area>
In-Reply-To: <20190509014327.GT1454@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 9 May 2019 11:47:15 +0300
Message-ID: <CAOQ4uxgJZJaMNNSGeS9uw1JUVtRA9vWfUWDrYnFY4uZh6BeX2A@mail.gmail.com>
Subject: Re: [TOPIC] Extending the filesystem crash recovery guaranties contract
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>,
        lsf-pc@lists.linux-foundation.org,
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

On Thu, May 9, 2019 at 4:43 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Thu, May 02, 2019 at 10:30:43PM -0400, Theodore Ts'o wrote:
> > On Thu, May 02, 2019 at 01:39:47PM -0400, Amir Goldstein wrote:
> > > I am not saying there is no room for a document that elaborates on those
> > > guaranties. I personally think that could be useful and certainly think that
> > > your group's work for adding xfstest coverage for API guaranties is useful.
> >
> > Again, here is my concern.  If we promise that ext4 will always obey
> > Dave Chinner's SOMC model, it would forever rule out Daejun Park and
> > Dongkun Shin's "iJournaling: Fine-grained journaling for improving the
> > latency of fsync system call"[1] published in Usenix ATC 2017.
>
> No, it doesn't rule that out at all.
>

Dave and all the good people,

Please go back to read the first email in this thread before it diverged yet
again into interpretations of SOMC.

The novelty in my proposal (which I attribute to Jan's idea) is to reduce the
concerns around documenting "expected behavior of the world" to documenting
"expected behavior of linking an O_TMPFILE".

It boils down to documenting AT_LINK_ATOMIC (or whatever flag name):

""The filesystem provided the guaranty that after a crash, if the linked
 O_TMPFILE is observed in the target directory, than all the data and
 metadata modifications made to the file before being linked are also
 observed."

No more, no less.

I intentionally reduced the scope to the point that I could get ext4,btrfs to
sign the treaty. I think this is a good starting point, from which we can make
forward progress.

I'd appreciate if xfs camp, Dave in particular, would address the proposal
regardless of the broader SOMC documentation discussion.

Thanks,
Amir.
