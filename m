Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECD51172DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 18:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfLIRdj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 12:33:39 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43698 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIRdj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:33:39 -0500
Received: by mail-yw1-f65.google.com with SMTP id s187so6087804ywe.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2019 09:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Adh6h37Kp+la7eZqBDpe8mhDD/FDjIdew1Wd/iTqW4A=;
        b=O8w4esFlKgDkPpA2RHV76oUdxT8rPzV+XaG3WZ++GvhOPyfn2wnWx/KBlAuTdWh7yX
         CWZrGsLjsVN4z+RX+cAxNc86IGkseyUiEHNOoChQkNTwUTHY18X+MXypikiGfddaPv5S
         t5QEuQ8JaYyp/hKQeUc6moG4gDZqHo3caOcJNKLOU2wvX5T5PMHBpo44rRobPxRHFeG7
         dsfkC1Tgjv3Bskn+zZcqNu9wdSH4T5tpmzFYrUlf2c3C+KzCoip7M/dlIjPl20SwJOUj
         Vf+XaXtvD6OlE0EM7nHKVZx3l0FOTYUftrQfwn+9u1Xz0PygUxp9GaQa0y7y3LnO4/j/
         MMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Adh6h37Kp+la7eZqBDpe8mhDD/FDjIdew1Wd/iTqW4A=;
        b=Wl8ZxcpuQcz97G54BDvbV0BmERZpPmKTzBBJp7RQZWpHK7vGVOctJtsKNqNEpRsBk/
         rf2j/Auqx8U8vqEiXx52ieeKzD6NRcjuDQ2uOCRz9BgOptqyOvUR1UsfXZ/yLjvJ1Gys
         BbyNuTtHmEcbBQey++yUTgh2cvhmgtP5IY0c5QlYXeBKOht3NH3c22SGmY2l4fXEoVMy
         fsXbIsF6Jxff6rkwlf6zEm0wqLSyoLhRhylnyAMvww0ugHy6FUf8DA3m1F1RyTsL9RuJ
         TWkAVTA4lI5vSKk8GNjq5vtYf6MVsTyhrd6HJyIXNF2oMLmLSE6Gd4N0YFkyV2TNqfRe
         fjAw==
X-Gm-Message-State: APjAAAUIQsIIwUimreVDLyBvcYI3lV2BMhOxXE6mQiJFjHLGTaWqtgOY
        p/8EF1w0RxWm399U+mB8n+3lVOv1VfOspCsS7H4=
X-Google-Smtp-Source: APXvYqyoH4jU3H0Id0YxRkx6FkJ0RNYd0Sw9rENWwIPDj/aRW6CfSbjuANtyX/WfiANYms05kufB6xn4wJdKHFUCWPE=
X-Received: by 2002:a81:5488:: with SMTP id i130mr21605120ywb.181.1575912818036;
 Mon, 09 Dec 2019 09:33:38 -0800 (PST)
MIME-Version: 1.0
References: <14196.1575902815@warthog.procyon.org.uk>
In-Reply-To: <14196.1575902815@warthog.procyon.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 9 Dec 2019 19:33:26 +0200
Message-ID: <CAOQ4uxj7RhrBnWb3Lqi3hHLuXNkVXrKio398_PAEczxfyW7HsA@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] How to make disconnected operation work?
To:     David Howells <dhowells@redhat.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 9, 2019 at 4:47 PM David Howells <dhowells@redhat.com> wrote:
>
> I've been rewriting fscache and cachefiles to massively simplify it and make
> use of the kiocb interface to do direct-I/O to/from the netfs's pages which
> didn't exist when I first did this.
>
>         https://lore.kernel.org/lkml/24942.1573667720@warthog.procyon.org.uk/
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter
>
> I'm getting towards the point where it's working and able to do basic caching
> once again.  So now I've been thinking about what it'd take to support
> disconnected operation.  Here's a list of things that I think need to be
> considered or dealt with:
>
>  (1) Making sure the working set is present in the cache.
>
>      - Userspace (find/cat/tar)
>      - Splice netfs -> cache
>      - Metadata storage (e.g. directories)
>      - Permissions caching
>
>  (2) Making sure the working set doesn't get culled.
>
>      - Pinning API (cachectl() syscall?)
>      - Allow culling to be disabled entirely on a cache
>      - Per-fs/per-dir config
>
>  (3) Switching into/out of disconnected mode.
>
>      - Manual, automatic
>      - On what granularity?
>        - Entirety of fs (eg. all nfs)
>        - By logical unit (server, volume, cell, share)
>
>  (4) Local changes in disconnected mode.
>
>      - Journal
>      - File identifier allocation
>      - statx flag to indicate provisional nature of info
>      - New error codes
>         - EDISCONNECTED - Op not available in disconnected mode
>         - EDISCONDATA - Data not available in disconnected mode
>         - EDISCONPERM - Permission cannot be checked in disconnected mode
>         - EDISCONFULL - Disconnected mode cache full
>      - SIGIO support?
>
>  (5) Reconnection.
>
>      - Proactive or JIT synchronisation
>        - Authentication
>      - Conflict detection and resolution
>          - ECONFLICTED - Disconnected mode resolution failed
>      - Journal replay
>      - Directory 'diffing' to find remote deletions
>      - Symlink and other non-regular file comparison
>
>  (6) Conflict resolution.
>
>      - Automatic where possible
>        - Just create/remove new non-regular files if possible
>        - How to handle permission differences?
>      - How to let userspace access conflicts?
>        - Move local copy to 'lost+found'-like directory
>          - Might not have been completely downloaded
>        - New open() flags?
>          - O_SERVER_VARIANT, O_CLIENT_VARIANT, O_RESOLVED_VARIANT
>        - fcntl() to switch variants?
>
>  (7) GUI integration.
>
>      - Entering/exiting disconnected mode notification/switches.
>      - Resolution required notification.
>      - Cache getting full notification.
>
> Can anyone think of any more considerations?  What do you think of the
> proposed error codes and open flags?  Is that the best way to do this?
>

Hi David,

I am very interested in this topic.
I can share (some) information from experience with a "Caching Gateway"
implementation in userspace shipped in products of my employer, CTERA.

I have come across several attempts to implement a network fs cache
using overlayfs. I don't remember by whom, but they were asking
questions on overlayfs list about online modification to lower layer.

It is not so far fetched, as you get many of the requirements for metadata
caching out-of-the-box, especially with recent addition of metacopy feature.
Also, if you consider the plans to implement overlayfs page cache [1][2],
then at least the read side of fscache sounds like it has some things in
common with overlayfs.

Anyway, you should know plenty about overlayfs to say if you think
there is any room for collaboration between the two projects.

Thanks,
Amir.

[1] https://marc.info/?l=linux-unionfs&m=154995746503505&w=2
[2] https://github.com/amir73il/linux/commits/ovl-aops-wip
