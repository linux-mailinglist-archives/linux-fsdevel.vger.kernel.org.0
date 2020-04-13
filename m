Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F2D1A6470
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 11:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgDMJEr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 05:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728091AbgDMJEl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 05:04:41 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0008AC008749;
        Mon, 13 Apr 2020 01:57:51 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id f82so4509930ilh.8;
        Mon, 13 Apr 2020 01:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GHA9/acdYNKg6TtXigttoWf+ctJ+xZIYedEqvuMFErI=;
        b=gtIWF+DRFw3NFjElbOmdUq+StalADZweXYUfWCkqiK8JLnF7+ewHUQMxY+05DelQSh
         qXSsO4sJPiZJO5nQCa3P36ztKcww04jTPFhV7HkEKzuN22nplRCgZ1Zf7qRo3fGIKHQ6
         7X+qnxY6W3J8t4tN73OF6zZKx1wsnuu+3MN8PLFa77bWZvxOID6Hap2HgyVEMWm3235m
         wPXQZS9Mq+UFvND3v/rf6kfHfS9Dtlj7GHzLNFHzDfKI7YP88UIGKKQWyrGgKy/TRMLg
         f8Hw9XVxkuDpz/JGArMAMJnoBgNoxJHtqr1WTtcp0Hph4bDYkRgn0hNTjOVSZevNria0
         0x/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GHA9/acdYNKg6TtXigttoWf+ctJ+xZIYedEqvuMFErI=;
        b=NwsDSGSaKdFTZkTmiVqAnpW62xZArNmU6d5w+o9F3+bbxfOmvyEXM1NA/Tx9OASAs5
         9sbCeOYFDS4bKI7QSV71QBVjO8wgap36rBwLifstQCNg9eEuR69n/+eLuSxaFt1pjfGW
         ngPQ13g8ZqqbeAFU5lrAwPuA/O6SVjn89RKS3ogq/3kMc4sgXcfaHeKiOAgYZkg3Xkbs
         wX2Thtd2M9nmPcCjwXVyEjHeEUY0kExO9sU8AlrGC7v7FCu5D3CrD2blMwUNlSW6C8iU
         P93Ne5NimiENFEA368sKClnHegA3N+jmRyv8LI5wpckkC+fJWJcOGR8KPEf5Wdanzgmq
         65ZQ==
X-Gm-Message-State: AGi0PuZ9vZcE3FWUmgWohdx6HQ09ge0lVV//bZNOsX3jJqaJwNvlOKXN
        As5tGuTTwMH4mLlSh8PJ70ThsoCQc5F6VOHZWFMU/qWI
X-Google-Smtp-Source: APiQypJCBRNY8WDeGRUOflqvmNLp4SLE40Vw+oZCgbf0ZQM7kLQ076HrzVTr4mL4n8pgv7NuZjDw6OSN5H1RzKfZw1A=
X-Received: by 2002:a92:cc02:: with SMTP id s2mr12907286ilp.9.1586768271374;
 Mon, 13 Apr 2020 01:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <CABV8kRw_jGxPqWc68Bj-uP_hSrKO0MmShOmtuzGQA2W3WHyCrg@mail.gmail.com>
 <CAOQ4uxhPKR34cXvWfF49z8mTGJm+oP2ibfohsXNdY7tXaOi4RA@mail.gmail.com> <CABV8kRxVA0j2qLkyWx+vULh2DxK2Ef4nPk-zXCikN8XmdBOFgQ@mail.gmail.com>
In-Reply-To: <CABV8kRxVA0j2qLkyWx+vULh2DxK2Ef4nPk-zXCikN8XmdBOFgQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 13 Apr 2020 11:57:40 +0300
Message-ID: <CAOQ4uxh2KKwORLC+gWEF=mWzBa3Kh4A4HgRoiad5N5qu06xjcg@mail.gmail.com>
Subject: Re: Same mountpoint restriction in FICLONE ioctls
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 13, 2020 at 1:28 AM Keno Fischer <keno@juliacomputing.com> wrote:
>
> > You did not specify your use case.
>
> My use case is recording (https://rr-project.org/) executions

Cool! I should try that ;-)

> of containers (which often make heavy use of bind mounts on
> the same file system, thus me running into this restriction).
> In essence, at relevant read or mmap operations,
> rr needs to checkpoint the file that was opened,
> in case it later gets deleted or modified.
> It always tries to FICLONE the file first,
> before deciding heuristically whether to
> instead create a copy (if it decides there is a low
> likelihood the file will get changed - e.g. because
> it's a system file - it may decide to take the chance and
> not copy it at the risk of creating a broken recording).
> That's often a decent trade-off, but of course it's not
> 100% perfect.
>
> > The question is: do you *really* need cross mount clone?
> > Can you use copy_file_range() instead?
>
> Good question. copy_file_range doesn't quite work
> for that initial clone, because we do want it to fail if
> cloning doesn't work (so that we can apply the
> heuristics). However, you make a good point that
> the copy fallback should probably use copy_file_range.
> At least that way, if it does decide to copy, the
> performance will be better.
>
> It would still be nice for FICLONE to ease this restriction,
> since it reduces the chance of the heuristics getting
> it wrong and preventing the copy, even if such
> a copy would have been cheap.
>

You make it sound like the heuristic decision must be made
*after* trying to clone, but it can be made before and pass
flags to the kernel whether or to fallback to copy.

copy_file_range(2) has an unused flags argument.
Adding support for flags like:
COPY_FILE_RANGE_BY_FS
COPY_FILE_RANGE_BY_KERNEL

or any other names elected after bike shedding can be used
to control whether user intended to use filesystem internal
clone/copy methods and/or to fallback to kernel copy.

I think this functionality will be useful to many.

> > Across which filesystems mounts are you trying to clone?
>
> This functionality was written with btrfs in mind, so that's
> what I was testing with. The mounts themselves are just
> different bindmounts into the same filesystem.
>

I can also suggest a workaround for you.
If your only problem is bind mounts and if recorder is a privileged
process (CAP_DAC_READ_SEARCH) then you can use a "master"
bind mount to perform all clone operations on.
Use name_to_handle_at(2) to get sb file handle of source file.
Use open_by_handle_at(2) to get an open file descriptor of the source
file under the "master" bind mount.

Thanks,
Amir.
