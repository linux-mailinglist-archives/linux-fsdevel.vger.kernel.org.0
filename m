Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C55B013BEB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 12:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgAOLla (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 06:41:30 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:42821 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730140AbgAOLla (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 06:41:30 -0500
Received: by mail-il1-f194.google.com with SMTP id t2so14552643ilq.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2020 03:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jerE6nCByPyp8nMkftpi9G1L1UkFSdwJwwfGyKZUqsE=;
        b=JIHvEujlN5p1XuTt0rPkXvdYsnyG/7UFqzoe+IiLnkhDGRitv8VCHPHm9/diZ7/dMC
         ZbKRhoCiAY5eXXXTPh4h4lCGGb8YuPwF/rlzYM107YYsmQDikVsHJMpkIUl0MKIWKn6r
         7zuFVMMM87H3B0Knrag8uRwPF08GCtzjkKlow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jerE6nCByPyp8nMkftpi9G1L1UkFSdwJwwfGyKZUqsE=;
        b=GuH8HIR9Mb41TbeRoHEFCNkvw6soaRwLR+BCNe/fk1LMhz3D/ViQSYc7b6kPqnMCV3
         Xy0yf9veq5xVZNaXKSO2fgHom6pc50mY4l7lNxo/+pY0I5ejsftyBIqv/W/iY0JLOWW6
         heXrif/m1Tx3P1fnl5sWBOGKSRnb/ORGlcj2XoUFRIlO+aLSa0BREvybSRQZK9/vJu0/
         VilhNg6L9SZ3NH9akNIl7b9BPj+J3t4V5iQZlJOqNUt+eY6qWW5e2AVINV7AtMlu8KMM
         n2AOdx0VIQLHu8ne49OlmVqaWUzQMZVG7W5Y/cr/w93mRJlaR/tqViRxuWAe0aV4a7JP
         DMQA==
X-Gm-Message-State: APjAAAUlESgJyQ6PS8Cz78YA6gLkAg5MllLl6T4q5D88vQQDtERt7vC9
        WHv7JZtfEVQTOKSz38GrYXOOBu0aJfQzWfTeLZIu4g==
X-Google-Smtp-Source: APXvYqylsgznQ5bI1+nHvYQwmEivmZhBzlDLdL1TTLmcspNdd5vXcuw3jyD3K/TlUCMRyPEvtyXSqwLalJCLofp9WKE=
X-Received: by 2002:a92:89c2:: with SMTP id w63mr2976176ilk.252.1579088489003;
 Wed, 15 Jan 2020 03:41:29 -0800 (PST)
MIME-Version: 1.0
References: <CA+wuGHCr2zJKFkHyRECOLAXsijLAcQgHVoACcNbvLbXnqarOtg@mail.gmail.com>
In-Reply-To: <CA+wuGHCr2zJKFkHyRECOLAXsijLAcQgHVoACcNbvLbXnqarOtg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 15 Jan 2020 12:41:17 +0100
Message-ID: <CAJfpegsECDNeL0FmaB=BsYdYrmZSLpG5etvwhW5uQWGJJjODeg@mail.gmail.com>
Subject: Re: Weird fuse_operations.read calls with Linux 5.4
To:     Ondrej Holy <oholy@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 9:28 AM Ondrej Holy <oholy@redhat.com> wrote:
>
> Hi,
>
> I have been directed here from https://github.com/libfuse/libfuse/issues/488.
>
> My issue is that with Linux Kernel 5.4, one read kernel call (e.g.
> made by cat tool) triggers two fuse_operations.read executions and in
> both cases with 0 offset even though that first read successfully
> returned some bytes.
>
> For gvfs, it leads to redundant I/O operations, or to "Operation not
> supported" errors if seeking is not supported. This doesn't happen
> with Linux 5.3. Any idea what is wrong here?
>
> $ strace cat /run/user/1000/gvfs/ftp\:host\=server\,user\=user/foo
> ...
> openat(AT_FDCWD, "/run/user/1000/gvfs/ftp:host=server,user=user/foo",

Hi, I'm trying to reproduce this on fedora30, but even failing to get
that "cat" to work.  I've  replaced "server" with a public ftp server,
but it's not even getting to the ftp backend.  Is there a trick to
enable the ftp backend?  Haven't found the answer by googling...

Thanks,
Miklos


> O_RDONLY) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=20, ...}) = 0
> fadvise64(3, 0, 0, POSIX_FADV_SEQUENTIAL) = 0
> mmap(NULL, 139264, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
> -1, 0) = 0x7fbc42b92000
> read(3, 0x7fbc42b93000, 131072)         = -1 EOPNOTSUPP (Operation not
> supported)
> ...
>
> $ /usr/libexec/gvfsd-fuse /run/user/1000/gvfs -d
> ...
> open flags: 0x8000 /ftp:host=server,user=user/foo
>    open[139679517117488] flags: 0x8000 /ftp:host=server,user=user/foo
>    unique: 8, success, outsize: 32
> unique: 10, opcode: READ (15), nodeid: 3, insize: 80, pid: 5053
> read[139679517117488] 4096 bytes from 0 flags: 0x8000
>    read[139679517117488] 20 bytes from 0
>    unique: 10, success, outsize: 36
> unique: 12, opcode: READ (15), nodeid: 3, insize: 80, pid: 5053
> read[139679517117488] 4096 bytes from 0 flags: 0x8000
>    unique: 12, error: -95 (Operation not supported), outsize: 16
> ...
>
> See for other information: https://gitlab.gnome.org/GNOME/gvfs/issues/441
>
> Regards
>
> Ondrej
> --
> Ondrej Holy
> Software Engineer, Core Desktop Development
> Red Hat Czech s.r.o
>
