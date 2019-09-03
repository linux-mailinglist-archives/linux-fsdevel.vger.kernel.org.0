Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCEBA7405
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 21:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfICTuS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 15:50:18 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39398 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfICTuS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:50:18 -0400
Received: by mail-qt1-f193.google.com with SMTP id n7so21510024qtb.6;
        Tue, 03 Sep 2019 12:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VPptNHDgIrbyunwZQp87iOUTMUhTiMYxTTIn/hXA+LU=;
        b=kM+ot8AL2uMvl03OY7A0/LZA6tHBB19rbVZbrZfhatMbp3bhBNiMvJIs7sXfmVmxdE
         E8tnnnnLafy65mjSH+WhzTiW63zmq59DnbE7u7HWXY0kM1XjD+oq90ldUl5ka4z45+Gq
         Pb/YAXazqxUr6LUyWbGHXLRk9YBLc+OpPW44ohX7kHNgM5jmlqkUsbdaBkC4Jhnk/gXX
         qPTUyDBpHIf63D3wG4V/rqg9SspItxezN8zF+dyT8VbqvNis3J4wj9ENDkiXEd3D0Owa
         Wr2ehIeexrTYdfPsuFHnWJzH1b3gzEDNDNpw4tGi+iJmaOixSqKU78JJk+pZ4iXsUksS
         62Nw==
X-Gm-Message-State: APjAAAVJDzUu1PWaVvWmunOiu8uHl4ifa5+w93wyr9FCFwHZe8Ez9x+t
        6O06fO+12Ck7eRIJS010F9DKjIof+axEjxyQX8c=
X-Google-Smtp-Source: APXvYqwmWvykYLIsIXv/rExQqRH4453QTzFrznyO0uRb5z3SOOF3l6nvFg1g5Nl4d6IaoTvNw7tWKpHG/sajdmkrkk0=
X-Received: by 2002:ac8:6b1a:: with SMTP id w26mr11811379qts.304.1567540217416;
 Tue, 03 Sep 2019 12:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <1567523922.5576.57.camel@lca.pw> <CABeXuvoPdAbDr-ELxNqUPg5n84fubZJZKiryERrXdHeuLhBQjQ@mail.gmail.com>
 <CABeXuvq7n+ZW7-HOiur+cyQXBjYKKWw1nRgFTJXTBZ9JNusPeg@mail.gmail.com>
 <1567534549.5576.62.camel@lca.pw> <82F89AEA-994B-44B5-93E7-CD339E4F78F6@dilger.ca>
In-Reply-To: <82F89AEA-994B-44B5-93E7-CD339E4F78F6@dilger.ca>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 Sep 2019 21:50:00 +0200
Message-ID: <CAK8P3a19PNVv0tEd8h93F9iszcCC-AmeqZ=pFkuSAyxAfhaQ-Q@mail.gmail.com>
Subject: Re: "beyond 2038" warnings from loopback mount is noisy
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Qian Cai <cai@lca.pw>, Deepa Dinamani <deepa.kernel@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 3, 2019 at 9:39 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Sep 3, 2019, at 12:15 PM, Qian Cai <cai@lca.pw> wrote:
> >
> > On Tue, 2019-09-03 at 09:36 -0700, Deepa Dinamani wrote:
> >> We might also want to consider updating the file system the LTP is
> >> being run on here.
> >
> > It simply format (mkfs.ext4) a loop back device on ext4 with the kernel.
> >
> > CONFIG_EXT4_FS=m
> > # CONFIG_EXT4_USE_FOR_EXT2 is not set
> > # CONFIG_EXT4_FS_POSIX_ACL is not set
> > # CONFIG_EXT4_FS_SECURITY is not set
> > # CONFIG_EXT4_DEBUG is not set
> >
> > using e2fsprogs-1.44.6. Do you mean people now need to update the kernel to
> > enable additional config to avoid the spam of warnings now?
>
> Strange.  The defaults for mkfs.ext4 _should_ default to use options that
> allow enough space for the extra timestamps.
>
> Can you please provide "dumpe2fs -h" output for your filesystem, and the
> formatting options that you used when creating this filesystem.

According to the man page,

        "The default inode size is controlled by the mke2fs.conf(5)
file.  In the
         mke2fs.conf file shipped with  e2fsprogs, the default inode size is 256
         bytes for most file systems, except for small file systems
where the inode
         size will be 128 bytes."

If this (small file systems) is the problem, then I think we need to
do two things:

1. Change the per-inode warning to not warn if the inode size for the
    file system is less than 256. We already get a mount-time warning
    in that case.

2. Change the mkfs.ext4 defaults to never pick a 128 byte inode unless
    the user really wants this (maybe not even then).

          Arnd
