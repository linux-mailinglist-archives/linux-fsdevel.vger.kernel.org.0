Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D053BF44F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 15:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfIZNpl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 09:45:41 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37032 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfIZNpl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 09:45:41 -0400
Received: by mail-io1-f66.google.com with SMTP id b19so6688440iob.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2019 06:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xb+YmsSDioHzf9VLWMv2QgHLJSqijZMNN8Nz6d7NJ+4=;
        b=mBkQjggKvKCBJ1YXCxU4PMyb+gJt02FB5nC7k3BxO9WfavEwWe9AnpR49e00LUBj8k
         m0iExFjuJp9RrcOij0U7xq43th6gL8wkka4IJKx/JDdwblZjvUhePLvsI+687mJsP7PJ
         1zzZGa3W5MsbBNkdV3JBHTjRzTLF8EbEsNpE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xb+YmsSDioHzf9VLWMv2QgHLJSqijZMNN8Nz6d7NJ+4=;
        b=R45107VJ+63Rs+nLf8AeFVWt6fsPltBbzKCSme5jy2qd4cyEHVLeQd383nnEfaGFKO
         DWmoOcRK0ns2CXmIdMJO5AfgaHT1nSBjTrElV7t1wKIYZwseokb4Vkiwu44wmRCPjx7m
         zF+NtKXJbqPzDFgq6Vo4pdCp1/0upyJ/VH/MaMI4ACed1IFaE1KP/80UWK29zMQ0Erb4
         lzoeyQ+M/EEp+9gymUunb5ddzj41lxBE9jbfllwAu4+49c0uLzmTvA1Nl9PGtYpEqCUY
         GbCrJhTwyx+BnFF+InFVVwS1aLIkyS80M9Bb4XynfDglnqjzGr26wsaftCS/C1wDxYFj
         0i7g==
X-Gm-Message-State: APjAAAVMSfE9n+7wGwQtjit27jo0Kqf4JbxuuWfwlEEih0yOu3tkozjH
        O4pweEnYeFs7xMmDmOri8CJ5zGi65iSnuGhHvbG0XQ==
X-Google-Smtp-Source: APXvYqxnqVaidyew8mjjgz4geA4F0i9TP8Im9oq6mDKGuxloSk8E7wLHYki/EqlQQZnBYT5IX0DQ/b/1gXw1ieomaP4=
X-Received: by 2002:a92:60b:: with SMTP id x11mr2386240ilg.212.1569505540443;
 Thu, 26 Sep 2019 06:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190926020725.19601-1-boazh@netapp.com> <CAJfpeguWh5HYcYsgjZ0J2UWUnw88jCURWSpxEjCT2ayubB9Z3A@mail.gmail.com>
 <0bb90477-e0b5-650b-d8c0-fb44723691a4@gmail.com> <91c22d2d-15fd-393d-dee2-8e74bdd8833a@fastmail.fm>
 <8280e517-1077-14f7-ff84-4597e78a327c@gmail.com>
In-Reply-To: <8280e517-1077-14f7-ff84-4597e78a327c@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 26 Sep 2019 15:45:29 +0200
Message-ID: <CAJfpegtjEoE7H8tayLaQHG9fRSBiVuaspnmPr2oQiOZXVB1+7g@mail.gmail.com>
Subject: Re: [PATCHSET v02 00/16] zuf: ZUFS Zero-copy User-mode FileSystem
To:     Boaz Harrosh <openosd@gmail.com>
Cc:     Bernd Schubert <bernd.schubert@fastmail.fm>,
        Boaz Harrosh <boaz@plexistor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matt Benjamin <mbenjami@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Sagi Manole <sagim@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 26, 2019 at 2:24 PM Boaz Harrosh <openosd@gmail.com> wrote:
>
> On 26/09/2019 15:12, Bernd Schubert wrote:
> >>> Are you interested in comparing zufs with the scalable fuse prototype?
> >>>  If so, I'll push the code into a public repo with some instructions,
> >>>
> >>
> >> Yes please do send it. I will give it a good run.

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#fuse2

Enable:

CONFIG_FUSE2_FS=y
CONFIG_SAMPLE_FUSE2=y

> >> What fuseFS do you use in usermode?

It's the example loopback filesystem supplied in the git tree above.
I haven't converted libfuse yet to use the new features, so for now
this is the only way to try it.

Usage:

    linux/samples/fuse2/loraw -2 -p -t ~/mnt/fuse/

    options:

     -d: debug
     -s: single threaded
     -b: FUSE_DEV_IOC_CLONE (v1)
     -p: use ioctl for device I/O (v2)
     -m: use "map read" transferring offset into file instead of actual data
     -1: use regular fuse
     -2: use experimental fuse2
     -t: use shared memory instead of threads

I tested with shmfs, and IIRC got about 4-8us latency, depending on
the hardware, type of operation, etc...

Let me know if something's not working properly (this is experimental code).

Thanks,
Miklos
