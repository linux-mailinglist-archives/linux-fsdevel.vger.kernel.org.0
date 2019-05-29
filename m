Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1B862D71C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 09:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfE2Hzu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 03:55:50 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37632 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfE2Hzu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 03:55:50 -0400
Received: by mail-it1-f193.google.com with SMTP id s16so2071191ita.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2019 00:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=op4791qBHMjDCQdV9txK9mbzIX+WhgzeovFSwUXqaFQ=;
        b=YbZYex+MkYR9h819JTNbMfn9OoTfQc0WfMl0pIniSUlyhGceEB4vQ8StrtFyuiAy4w
         V/rdXa8qsaNoWL4xwbh2GBDzhIEKxgBZMsNRyZjGgmPoBJPWEYu2f0YjJis9SSPtC26W
         UD998MyvHLyBc5OYtLE92jxNIzzt5APPCEtC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=op4791qBHMjDCQdV9txK9mbzIX+WhgzeovFSwUXqaFQ=;
        b=aliNOTpk1vZg2foLKwy7Y39t5JD0Oy1IvXVEvV7ADoNbKS3zJQ7S8ClaH5YSmPV/KA
         6GoB2wyiBm+29FD/1HSlwE+3VT+dgyO4Q1uZxhPwCzbTvaMF7ikj7vVmukSDo1s9dia0
         fSF1QZgN50U8YcS+omWIsAjObNsgyKq4u/j5Zep3L7XLXTrod8Var+ZMAH1cQ7RAtDvy
         H/jyndN6D8g+De8PFxDR/6+3Hee1L6+ZjUyGfbDkx8mkWCzBxhb8eP4lifjgQCvtEcQe
         MBajcKpcrzcWfqVXbsoEHWPujEb58au69olajwuLBOkD0uyOy6xbO1sf/mhXABfDosE1
         Yb3Q==
X-Gm-Message-State: APjAAAUqqSSWUDnDG/qgUosTK9llEcYFDiRAd7BcaBiKz2Y4i1lQCIkE
        8QTI/uUTNBl176myWBrZriiecdbG5P3bbWPk7mjFOKrs
X-Google-Smtp-Source: APXvYqy/whcusTY4hHDoC4X+OnP9aaNKf6KjmFpD6uW6iIEpnRrUQmEJ77wekoH11aNFI99khObtXhKqxO04kVXVSD0=
X-Received: by 2002:a24:4dd4:: with SMTP id l203mr6105131itb.118.1559116549227;
 Wed, 29 May 2019 00:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <155905621951.1304.5956310120238620025.stgit@warthog.procyon.org.uk>
 <155905622921.1304.8775688192987027250.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905622921.1304.8775688192987027250.stgit@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 29 May 2019 09:55:38 +0200
Message-ID: <CAJfpeguPTQ00zVjpwVQ4R8mEqE3aijCzNMAz6Wvr56xE-jfJag@mail.gmail.com>
Subject: Re: [PATCH 1/7] General notification queue with user mmap()'able ring
 buffer [ver #13]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 28, 2019 at 5:10 PM David Howells <dhowells@redhat.com> wrote:
>
> Implement a misc device that implements a general notification queue as a
> ring buffer that can be mmap()'d from userspace.
>
> The way this is done is:
>
>  (1) An application opens the device and indicates the size of the ring
>      buffer that it wants to reserve in pages (this can only be set once):
>
>         fd = open("/dev/watch_queue", O_RDWR);
>         ioctl(fd, IOC_WATCH_QUEUE_NR_PAGES, nr_of_pages);
>
>  (2) The application should then map the pages that the device has
>      reserved.  Each instance of the device created by open() allocates
>      separate pages so that maps of different fds don't interfere with one
>      another.  Multiple mmap() calls on the same fd, however, will all work
>      together.
>
>         page_size = sysconf(_SC_PAGESIZE);
>         mapping_size = nr_of_pages * page_size;
>         char *buf = mmap(NULL, mapping_size, PROT_READ|PROT_WRITE,
>                          MAP_SHARED, fd, 0);

Would it make sense to use relayfs for the implementation of the
mapped ring buffer?

Thanks,
Miklos
