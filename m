Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00176193D07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 11:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgCZKjB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 06:39:01 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:36498 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgCZKjB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:39:01 -0400
Received: by mail-io1-f49.google.com with SMTP id d15so5512533iog.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2020 03:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=LhRRlEVlaxyCVEA3UCXYEnM6QtOeDdBMgms9CyFJPww=;
        b=ks6FOqxQcbdyrAE0Od0ZH7QI9y7l840SBcW1u8Aa6vP8tCT7ZMd8tiXKQmSXjXVJEw
         SWJA0uw4/GKVdWWVPjfitQh1hDcUl9o4oFEEivPunWaeNrJF1BKPHC+61RVO9O092eJV
         G32cyFzVEJ4ScEm7IeqzSa9KoulA/DV54ao60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=LhRRlEVlaxyCVEA3UCXYEnM6QtOeDdBMgms9CyFJPww=;
        b=jWT9h7GwKjU+YxqhRH9ovKOEkLonTQotlxWPMGPsgx4+XUDk0FBcWIjo8TbdISzbED
         if1jR3rx65URO3O5/PJEuE4pFeI7+sbk7dWcRg6CEu+ZpzUmHRrvQ3AiCyPIWN8nD8zr
         pI3U4izOuaP8hwpUmO8lqRKcUnCwcTDYxyl/3jeD4qAM6wdVwKwQ/MPmH6WX49Jd/lfZ
         0c6M6lrYTcBlgamcTzWxoPkir6qCXuv+zYYP5v/xjVmkn3ydJfSnP0jTZ60O6iwCpFDe
         u6VywlqqYW8T4OIk1N+2GBone//8wrvPyKtrku4tMGwia3pR+B/Vtc/IUWNhy6NKFZ78
         39Iw==
X-Gm-Message-State: ANhLgQ1G6uxmmOdZdLRWFBOp0ip+9LJHk52zHRiPuKZyL1cOhdI0URNz
        2ZEkmCkZrkx0PZ+wJmstZVKehtMELfqjfw0FIe0JpJdg
X-Google-Smtp-Source: ADFU+vsUaDfuP3UFpmhDvyMU7Bh4t9sU1/VAbxkdLkaXRyQWRqZQgFN9bWRWHL0DLApFSnOUBxCZrviXTvkokdBuQ/c=
X-Received: by 2002:a02:2714:: with SMTP id g20mr7053651jaa.95.1585219140756;
 Thu, 26 Mar 2020 03:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <87r1xlesiu.fsf@vostro.rath.org>
In-Reply-To: <87r1xlesiu.fsf@vostro.rath.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 26 Mar 2020 11:38:49 +0100
Message-ID: <CAJfpegvSQAh5rtGWgAex8h3XEPKKUF6NTjNvtqpYMrQvXta8DQ@mail.gmail.com>
Subject: Re: [fuse] Why is readahead=0 limiting read size?
To:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 21, 2020 at 2:40 PM Nikolaus Rath <Nikolaus@rath.org> wrote:
>
> Hello,
>
> When issuing a 16 kB read request from userspace and the default FUSE
> readahead settings, data is read in batches of 32k:
>
> $ example/passthrough_ll -d mnt
> FUSE library version: 3.9.1
> unique: 1, opcode: INIT (26), nodeid: 0, insize: 56, pid: 0
> INIT: 7.27
> flags=0x003ffffb
> max_readahead=0x00020000
>    INIT: 7.31
>    flags=0x0000f439
>    max_readahead=0x00020000
>    max_write=0x00020000
>    max_background=0
>    congestion_threshold=0
>    time_gran=1
>    unique: 1, success, outsize: 80
> unique: 2, opcode: LOOKUP (1), nodeid: 1, insize: 44, pid: 20822
> lo_lookup(parent=1, name=bin)
>   1/bin -> 140290677541808
>    unique: 2, success, outsize: 144
> unique: 3, opcode: LOOKUP (1), nodeid: 140290677541808, insize: 45, pid: 20822
> lo_lookup(parent=140290677541808, name=bash)
>   140290677541808/bash -> 140290677542048
>    unique: 3, success, outsize: 144
> unique: 4, opcode: OPEN (14), nodeid: 140290677542048, insize: 48, pid: 20822
> lo_open(ino=140290677542048, flags=32768)
>    unique: 4, success, outsize: 32
> unique: 5, opcode: FLUSH (25), nodeid: 140290677542048, insize: 64, pid: 20822
>    unique: 5, success, outsize: 16
> unique: 6, opcode: READ (15), nodeid: 140290677542048, insize: 80, pid: 20822
> lo_read(ino=140290677542048, size=32768, off=0)
>    unique: 6, success, outsize: 32784
> unique: 7, opcode: FLUSH (25), nodeid: 140290677542048, insize: 64, pid: 20822
>    unique: 7, success, outsize: 16
> unique: 8, opcode: RELEASE (18), nodeid: 140290677542048, insize: 64, pid: 0
>    unique: 8, success, outsize: 16
>
>
> However, when disabling readahead, the read size decreases to 4k:
>
>
> $ example/passthrough_ll -d mnt
> FUSE library version: 3.9.1
> unique: 1, opcode: INIT (26), nodeid: 0, insize: 56, pid: 0
> INIT: 7.27
> flags=0x003ffffb
> max_readahead=0x00020000
>    INIT: 7.31
>    flags=0x0000f439
>    max_readahead=0x00000000
>    max_write=0x00020000
>    max_background=0
>    congestion_threshold=0
>    time_gran=1
>    unique: 1, success, outsize: 80
> unique: 2, opcode: LOOKUP (1), nodeid: 1, insize: 44, pid: 20911
> lo_lookup(parent=1, name=bin)
>   1/bin -> 140509922200528
>    unique: 2, success, outsize: 144
> unique: 3, opcode: LOOKUP (1), nodeid: 140509922200528, insize: 45, pid: 20911
> lo_lookup(parent=140509922200528, name=bash)
>   140509922200528/bash -> 140510056418784
>    unique: 3, success, outsize: 144
> unique: 4, opcode: OPEN (14), nodeid: 140510056418784, insize: 48, pid: 20911
> lo_open(ino=140510056418784, flags=32768)
>    unique: 4, success, outsize: 32
> unique: 5, opcode: FLUSH (25), nodeid: 140510056418784, insize: 64, pid: 20911
>    unique: 5, success, outsize: 16
> unique: 6, opcode: READ (15), nodeid: 140510056418784, insize: 80, pid: 20911
> lo_read(ino=140510056418784, size=4096, off=0)
>    unique: 6, success, outsize: 4112
> unique: 7, opcode: READ (15), nodeid: 140510056418784, insize: 80, pid: 20911
> lo_read(ino=140510056418784, size=4096, off=4096)
>    unique: 7, success, outsize: 4112
> unique: 8, opcode: READ (15), nodeid: 140510056418784, insize: 80, pid: 20911
> lo_read(ino=140510056418784, size=4096, off=8192)
>    unique: 8, success, outsize: 4112
> unique: 9, opcode: READ (15), nodeid: 140510056418784, insize: 80, pid: 20911
> lo_read(ino=140510056418784, size=4096, off=12288)
>    unique: 9, success, outsize: 4112
> unique: 10, opcode: FLUSH (25), nodeid: 140510056418784, insize: 64, pid: 20911
>    unique: 10, success, outsize: 16
> unique: 11, opcode: RELEASE (18), nodeid: 140510056418784, insize: 64, pid: 0
>    unique: 11, success, outsize: 16
>
>
>
> Is that intentional? If so, why?

There are two cached read methods that linux filesystems can
implement: readpage (mandatory) and readpages (optional).   The second
one is called by the readahead code, and that's the one which can
generate multi page read requests.  The first one is called in all
other cases, so that's the one that will be called with readahead
disabled.

>
> Is there any way to get larger read requests without also enabling
> readahead?

Only using direct I/O.

Thanks,
Miklos
