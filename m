Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE3D303485
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 06:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbhAZFYm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:24:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58531 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728793AbhAYN2A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611581151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mKBAIHjLBv1uPqHgRWoGEuszBqIj+l3P9UDHtFckEn4=;
        b=gRh4vqK8VT4cNi+Vo2ia2O3cSsC3fKG77m1gwUl+NsjBfen6wT+i4pTxHlOKtzbAeijuJI
        1AHkIN/3JcpZrL5SXIz8w7JgQM8JhA3WaTbTY3xPuakD/XTanQnp5pm1hH9cqoQQzjWgaR
        16kWVk3B72H8TeV7HVQUMWHXD1isg1U=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-D4Ctru2xNOGl0B6soUvPqw-1; Mon, 25 Jan 2021 08:25:49 -0500
X-MC-Unique: D4Ctru2xNOGl0B6soUvPqw-1
Received: by mail-qk1-f197.google.com with SMTP id a75so4407262qkg.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 05:25:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mKBAIHjLBv1uPqHgRWoGEuszBqIj+l3P9UDHtFckEn4=;
        b=qbTcZtESiChOujZhxPEhHlxZV4gg8/502PlyCwUxOKtyNxpqhBthDaC0rQJTYbWsYy
         NZUkfhTM0o5hiErJ7uTaijQZ46kEKuyRq/b6ZhpsCg5LMbSmN9Hyga2eGkf08taBb2Hh
         n/s0JIkoiNREoq262y4GRpQSdGx6T7fkIU/5DnvZgPmHFVr9QWJ8Q4QF05xlQmpM9w54
         lu7sDOYPqc3u1SC+BYGOsGUXdM3V3VGuOpEuYxsNNTO4S0ZXfvo4unbYy6h5mx/2Hhzr
         JetHHL7BB8Y+Xk8eSE6pr1LseT9vmCOpc5qONVjR4NyXwzHlkWhxRb0bMfcq2vhdzGaD
         JJVw==
X-Gm-Message-State: AOAM5324P/updNWaBxxqbFfQlg5ytE1txz/EXm7rMadi1tgl+ypZYSq/
        9FdWMCptjT6pQBGdt0PmYXxhY9lQkP/FzNHf48LH4xD2HiErs4i/7f2HPfAQfAtWrAAEo+3BnKg
        wSLNeYr9YD9heFjtGIR5x/8YSUUwE+yzJnSYCIzikEQ==
X-Received: by 2002:a37:788:: with SMTP id 130mr656846qkh.390.1611581149426;
        Mon, 25 Jan 2021 05:25:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9uwqNss2gL2K4WjIoL7LYE/brUIbRAkeSgNTSwbgH4tU/Oz6Gn7u/P9cD2BigrYSceF14qFL5icT3pOjziLA=
X-Received: by 2002:a37:788:: with SMTP id 130mr656827qkh.390.1611581149237;
 Mon, 25 Jan 2021 05:25:49 -0800 (PST)
MIME-Version: 1.0
References: <20210119162204.2081137-1-mszeredi@redhat.com> <20210119162204.2081137-2-mszeredi@redhat.com>
 <20210122183141.GB81247@sequoia>
In-Reply-To: <20210122183141.GB81247@sequoia>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 25 Jan 2021 14:25:38 +0100
Message-ID: <CAOssrKd-P=4n-nzhjnvnChbCkcrAaLC=NjmCTDRHtzRtzJaU-g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ecryptfs: fix uid translation for setxattr on security.capability
To:     Tyler Hicks <code@tyhicks.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 22, 2021 at 7:31 PM Tyler Hicks <code@tyhicks.com> wrote:
>
> On 2021-01-19 17:22:03, Miklos Szeredi wrote:
> > Prior to commit 7c03e2cda4a5 ("vfs: move cap_convert_nscap() call into
> > vfs_setxattr()") the translation of nscap->rootid did not take stacked
> > filesystems (overlayfs and ecryptfs) into account.
> >
> > That patch fixed the overlay case, but made the ecryptfs case worse.
>
> Thanks for sending a fix!
>
> I know that you don't have an eCryptfs setup to test with but I'm at a
> loss about how to test this from the userns/fscaps side of things. Do
> you have a sequence of unshare/setcap/getcap commands that I can run on
> a file inside of an eCryptfs mount to verify that the bug exists after
> 7c03e2cda4a5 and then again to verify that this patch fixes the bug?

You need two terminals:
$ = <USER>
# = root

$ unshare -Um
$ echo $$
<PID>
# echo "0 1000 1" > uid_map
# cp uid_map gid_map
# echo 1000 2000 1 >> uid_map
# echo 2000 3000 1 >> uid_map
# cat uid_map > /proc/<PID>/uid_map
# cat gid_map > /proc/<PID>/gid_map
$ mkdir ~/tmp ~/mnt
$ mount -t tmpfs tmpfs ~/tmp
$ pwd
/home/<USER>
# nsenter -t <PID> -m
# [setup ecryptfs on /home/<USER>/mnt using /home/<USER>/tmp]
$ cd ~/mnt
$ touch test
$ /sbin/setcap -n 1000 cap_dac_override+eip test
$ /sbin/getcap -n test
test = cap_dac_override+eip [rootid=1000]

Without the patch, I'm thinking that it will do a double translate and
end up with rootid=2000 in the user namespace, but I might well have
messed it up...

Let me know how this goes.

Thanks,
Miklos

