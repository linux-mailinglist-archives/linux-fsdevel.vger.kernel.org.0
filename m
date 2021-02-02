Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD91B30B4BF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 02:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhBBBfC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 20:35:02 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38505 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230527AbhBBBfB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 20:35:01 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1121V5Ce026106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 Feb 2021 20:31:06 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 52EE015C39E2; Mon,  1 Feb 2021 20:31:05 -0500 (EST)
Date:   Mon, 1 Feb 2021 20:31:05 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Amy Parker <enbyamy@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: Using bit shifts for VXFS file modes
Message-ID: <YBirWYRuq2ONxt/y@mit.edu>
References: <CAE1WUT63RUz0r2LaJZ7hvayzfLadEdsZjymg8UYU481de+6wLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE1WUT63RUz0r2LaJZ7hvayzfLadEdsZjymg8UYU481de+6wLA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 01, 2021 at 03:49:20PM -0800, Amy Parker wrote:
> Hello filesystem developers!
> 
> I was scouting through the FreeVXFS code, when I came across this in
> fs/freevxfs/vxfs.h:
> 
> enum vxfs_mode {
>         VXFS_ISUID = 0x00000800, /* setuid */
>         VXFS_ISGID = 0x00000400, /* setgid */
>         VXFS_ISVTX = 0x00000200, /* sticky bit */
>         VXFS_IREAD = 0x00000100, /* read */
>         VXFS_IWRITE = 0x00000080, /* write */
>         VXFS_IEXEC = 0x00000040, /* exec */

The main reason why some developers prefer to using enum is because it
allows the compiler to do type checking.  Also some people prefer
using hex digits because it becomes easier for people who are looking
at hex dumps.  So for example:

typedef enum {
        EXT4_IGET_NORMAL =      0,
        EXT4_IGET_SPECIAL =     0x0001, /* OK to iget a system inode */
        EXT4_IGET_HANDLE =      0x0002  /* Inode # is from a handle */
} ext4_iget_flags;

> Anyways, I believe using bit shifts to represent different file modes
> would be a much better idea - no runtime penalty as they get
> calculated into constants at compile time, and significantly easier
> for the average user to read.

That's a matter of personal preference; and I'll note that it's not a
matter of what is better for average users, but rather the average
file system developer.  Some people find octal easier, because that
was what Digital Equipment Corporation (DEC) systems tended to use,
and early Unix was developed on PDP-11.  So that's why octal gets used
in the man page for chmod, e.g.:

#define S_IRUSR 00400
#define S_IWUSR 00200
#define S_IXUSR 00100

#define S_IRGRP 00040
#define S_IWGRP 00020
#define S_IXGRP 00010

Personally, *I* find this easier to read than

#define S_IRGRP (1U << 5)
#define S_IWGRP (1U << 4)
#define S_IXGRP (1U << 3)

But perhaps that's because I can convert between octal and binary in
my sleep (having learned how to toggle in disk bootstraps into the
front console of a PDP-8i[1] when I was in grade school).

[1] https://www.vintagecomputer.net/digital/pdp8i/Digital_PDP8i_a.JPG

> Any thoughts on this?

I don't think there's a right answer here.  In some cases, hex will be
better; in some cases, octal (especially as far as Unix permissions is
concerned); and in other cases, perhaps using bit shifts is more important.

A lot depends on how you plan can use it, and your past experiewnce.
Maybe you can take left shift numbers and be able to translate that to
hex when looking at kernel oops messages; I can't, but I can take hex
definiions and can take something like 0xA453 and map that to what
flags are set that are defined using hex constants.

Cheers,

						- Ted
