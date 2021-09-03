Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A757740077C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 23:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348249AbhICViJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 17:38:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235264AbhICViG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 17:38:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 567F160F21;
        Fri,  3 Sep 2021 21:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630705025;
        bh=ysWHeMqbDEvsn5l8zRqxKz3HmCgf/gvL2ecLQgzUgGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aSiHeZKjhDq+ztl6o0f8wJxJmLw4zLul3iGSDB0Jqs0IMlXRUHoxhXWYzjIO0MzPC
         1Hj//2eBpuNjxzEzmLcG+hxJy2hDEPNA2RO3akE+OcW7sL+9CcI14cpqflptRh/04n
         GToXqM4S5SSc8/iwtbhsTk8rCGcVV2gDHv+jtOOlKiLU6C7dCK7qV5MsON8njssnSU
         iu8dYTz8MbyrD+zryeE9eP5/TKU9JMIJc2y2wIXJ31zSquZW0laOYBVIgrPBo1R7m9
         /OkMY4URXIIQWKvX8k//xjd3ldXNcS4KXMJuUHemCKv8+xZWXUx5hZMNvUeZSD6NER
         34BYeYwAEYt+A==
Received: by pali.im (Postfix)
        id 39FF877C; Fri,  3 Sep 2021 23:37:03 +0200 (CEST)
Date:   Fri, 3 Sep 2021 23:37:03 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 00/20] fs: Remove usage of broken nls_utf8 and drop it
Message-ID: <20210903213703.s5y5iobmdrlmzfek@pali>
References: <20210808162453.1653-1-pali@kernel.org>
 <20210903212616.xbi5tz5ier5xcpas@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210903212616.xbi5tz5ier5xcpas@kari-VirtualBox>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Saturday 04 September 2021 00:26:16 Kari Argillander wrote:
> On Sun, Aug 08, 2021 at 06:24:33PM +0200, Pali Rohár wrote:
> > Module nls_utf8 is broken in several ways. It does not support (full)
> > UTF-8, despite its name. It cannot handle 4-byte UTF-8 sequences and
> > tolower/toupper table is not implemented at all. Which means that it is
> > not suitable for usage in case-insensitive filesystems or UTF-16
> > filesystems (because of e.g. missing UTF-16 surrogate pairs processing).
> > 
> > This is RFC patch series which unify and fix iocharset=utf8 mount
> > option in all fs drivers and converts all remaining fs drivers to use
> > utf8s_to_utf16s(), utf16s_to_utf8s(), utf8_to_utf32(), utf32_to_utf8
> > functions for implementing UTF-8 support instead of nls_utf8.
> > 
> > So at the end it allows to completely drop this broken nls_utf8 module.
> 
> Now that every filesystem will support nls=NULL. Is it possible to just
> drop default_table completly? Then default has to be utf8, but is it a
> problem?

Currently (default) fallback nls table is iso8859-1. I was planning to
merge fallback nls table and external iso8859-1 table into one, to
decrease code duplication.

There is also config option for default table. I do not think it is a
good idea to drop config option for default table as more people are
using some iso8859-X as default encoding.

> Then I was also thinking that every nls "codepage module" can have in
> Kconfig
> 	select HAVE_NLS
> 
> HAVE_NLS will tell if we can get anything other than nls=NULL. This way
> fs can drop some functions if they wanted to.  It would be nice to also
> make nls module as small as possible because also acpi, pci and usb
> selects it. Also many other driver seems to depend on it and they do not
> even seem to select it. All other than filesystems seems to just need
> utf conversions. At least for quick eye.  Other option is to seperate
> nls and utf, but I'm not fan this idea just yet at least.

nls tables can be already compiled as modules. There are also
inefficient implementations of some nls tables (e.g. ascii or
iso8859-1). So there are already places for decreasing size of nls
code without loosing any functionality.

> Whole point is to help little bit small Linux and embedded devices. I'm
> happy to do this, but all really depens on if utf8 can be default and
> that we sure can think before hand. 

I agree that on modern embedded systems there is no reason to use
non-utf8 encoding if you are not targeting some legacy userspace.

So allowing to compile filesystems also without nls code (in which case
they would use only utf-8) makes sense.

>   Argillander
> 
> > For more details look at email thread where was discussed fs unification:
> > https://lore.kernel.org/linux-fsdevel/20200102211855.gg62r7jshp742d6i@pali/t/#u
> > 
> > This patch series is mostly untested and presented as RFC. Please let me
> > know what do you think about it and if is the correct way how to fix
> > broken UTF-8 support in fs drivers. As explained in above email thread I
> > think it does not make sense to try fixing whole NLS framework and it is
> > easier to just drop this nls_utf8 module.
> > 
> > Note: this patch series does not address UTF-8 fat case-sensitivity issue:
> > https://lore.kernel.org/linux-fsdevel/20200119221455.bac7dc55g56q2l4r@pali/
> > 
> > Pali Rohár (20):
> >   fat: Fix iocharset=utf8 mount option
> >   hfsplus: Add iocharset= mount option as alias for nls=
> >   udf: Fix iocharset=utf8 mount option
> >   isofs: joliet: Fix iocharset=utf8 mount option
> >   ntfs: Undeprecate iocharset= mount option
> >   ntfs: Fix error processing when load_nls() fails
> >   befs: Fix printing iocharset= mount option
> >   befs: Rename enum value Opt_charset to Opt_iocharset to match mount
> >     option
> >   befs: Fix error processing when load_nls() fails
> >   befs: Allow to use native UTF-8 mode
> >   hfs: Explicitly set hsb->nls_disk when hsb->nls_io is set
> >   hfs: Do not use broken utf8 NLS table for iocharset=utf8 mount option
> >   hfsplus: Do not use broken utf8 NLS table for iocharset=utf8 mount
> >     option
> >   jfs: Remove custom iso8859-1 implementation
> >   jfs: Fix buffer overflow in jfs_strfromUCS_le() function
> >   jfs: Do not use broken utf8 NLS table for iocharset=utf8 mount option
> >   ntfs: Do not use broken utf8 NLS table for iocharset=utf8 mount option
> >   cifs: Do not use broken utf8 NLS table for iocharset=utf8 mount option
> >   cifs: Remove usage of load_nls_default() calls
> >   nls: Drop broken nls_utf8 module
> > 
> >  fs/befs/linuxvfs.c          |  22 ++++---
> >  fs/cifs/cifs_unicode.c      | 128 +++++++++++++++++++++++-------------
> >  fs/cifs/cifs_unicode.h      |   2 +-
> >  fs/cifs/cifsfs.c            |   2 +
> >  fs/cifs/cifssmb.c           |   8 +--
> >  fs/cifs/connect.c           |   8 ++-
> >  fs/cifs/dfs_cache.c         |  24 +++----
> >  fs/cifs/dir.c               |  28 ++++++--
> >  fs/cifs/smb2pdu.c           |  17 ++---
> >  fs/cifs/winucase.c          |  14 ++--
> >  fs/fat/Kconfig              |  15 -----
> >  fs/fat/dir.c                |  17 ++---
> >  fs/fat/fat.h                |  22 +++++++
> >  fs/fat/inode.c              |  28 ++++----
> >  fs/fat/namei_vfat.c         |  26 ++++++--
> >  fs/hfs/super.c              |  62 ++++++++++++++---
> >  fs/hfs/trans.c              |  62 +++++++++--------
> >  fs/hfsplus/dir.c            |   6 +-
> >  fs/hfsplus/options.c        |  39 ++++++-----
> >  fs/hfsplus/super.c          |   7 +-
> >  fs/hfsplus/unicode.c        |  31 ++++++++-
> >  fs/hfsplus/xattr.c          |  14 ++--
> >  fs/hfsplus/xattr_security.c |   3 +-
> >  fs/isofs/inode.c            |  27 ++++----
> >  fs/isofs/isofs.h            |   1 -
> >  fs/isofs/joliet.c           |   4 +-
> >  fs/jfs/jfs_dtree.c          |  13 +++-
> >  fs/jfs/jfs_unicode.c        |  35 +++++-----
> >  fs/jfs/jfs_unicode.h        |   2 +-
> >  fs/jfs/super.c              |  29 ++++++--
> >  fs/nls/Kconfig              |   9 ---
> >  fs/nls/Makefile             |   1 -
> >  fs/nls/nls_utf8.c           |  67 -------------------
> >  fs/ntfs/dir.c               |   6 +-
> >  fs/ntfs/inode.c             |   5 +-
> >  fs/ntfs/super.c             |  60 ++++++++---------
> >  fs/ntfs/unistr.c            |  28 +++++++-
> >  fs/udf/super.c              |  50 ++++++--------
> >  fs/udf/udf_sb.h             |   2 -
> >  fs/udf/unicode.c            |   4 +-
> >  40 files changed, 510 insertions(+), 418 deletions(-)
> >  delete mode 100644 fs/nls/nls_utf8.c
> > 
> > -- 
> > 2.20.1
> > 
