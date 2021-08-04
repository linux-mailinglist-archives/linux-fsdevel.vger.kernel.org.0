Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D113DF8B8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 02:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbhHDAEq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 20:04:46 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43159 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232641AbhHDAEq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 20:04:46 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17404I00014990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Aug 2021 20:04:19 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 629A515C3DEA; Tue,  3 Aug 2021 20:04:18 -0400 (EDT)
Date:   Tue, 3 Aug 2021 20:04:18 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        zajec5@gmail.com, "Darrick J. Wong" <djwong@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
Message-ID: <YQnZgq3gMKGI1Nig@mit.edu>
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com>
 <20210716114635.14797-1-papadakospan@gmail.com>
 <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com>
 <YQnHxIU+EAAxIjZA@mit.edu>
 <YQnU5m/ur+0D5MfJ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQnU5m/ur+0D5MfJ@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 04, 2021 at 12:44:38AM +0100, Matthew Wilcox wrote:
> 
> I don't understand how so many ntfs-classic xfstests pass:
> 
> config NTFS_RW
>         bool "NTFS write support"
>         depends on NTFS_FS
>         help
>           This enables the partial, but safe, write support in the NTFS driver.
> 
>           The only supported operation is overwriting existing files, without
>           changing the file length.  No file or directory creation, deletion or
>           renaming is possible.  Note only non-resident files can be written to
>           so you may find that some very small files (<500 bytes or so) cannot
>           be written to.
> 
> Are the tests really passing, or just claiming to pass?

This was the ntfs provided by the Debian package ntfs-3g (which is the
only source of a mkfs.ntfs that I could find, BTW).  This is a
fuse-based ntfs, not the in-kernel ntfs file system.  Apologies for
not making that clear.

<tytso.root@cwcc> {/usr/projects/linux/ext4}, level 2   (ntfs3)
1003# mkfs.ntfs /dev/cwcc-vg/scratch
Cluster size has been automatically set to 4096 bytes.
Initializing device with zeroes: 100% - Done.
Creating NTFS volume structures.
mkntfs completed successfully. Have a nice day.
<tytso.root@cwcc> {/usr/projects/linux/ext4}, level 2   (ntfs3)
1004# mount -t ntfs /dev/cwcc-vg/scratch /mnt
<tytso.root@cwcc> {/usr/projects/linux/ext4}, level 2   (ntfs3)
1005# grep /mnt /proc/mounts
/dev/mapper/cwcc--vg-scratch /mnt fuseblk rw,relatime,user_id=0,group_id=0,allow_other,blksize=4096 0 0

TBH, I had forgotten that we had an in-kernel ntfs implementation.
Whenver I've ever needed to access ntfs files, I've always used the
ntfs-3g FUSE package.

			     	  	  - Ted
