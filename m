Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A519115A0FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 06:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgBLF7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 00:59:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgBLF7M (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 00:59:12 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEDE12073C;
        Wed, 12 Feb 2020 05:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581487151;
        bh=xQFnOudKqb/kbsLlYNKBDsIDCJCWea6054v8vCNp2FQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EsE7XRDFHHOJfmDnCHM815qhGLMokCKAMN0ADFh7v0kZYkXrKVyCmg3ov9QmVtxw8
         yU3nMgZ5d6TS7d8e5dmazqBXjtQqTTJgUxJkjAKkGUCuNYVAgrkKkuG4uNoWXxC9u9
         l1eeoPbZjmyRuFtYZGF48Bp8fihJgKHWSZUymX7w=
Date:   Tue, 11 Feb 2020 21:59:09 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v7 7/8] ext4: Hande casefolding with encryption
Message-ID: <20200212055909.GI870@sol.localdomain>
References: <20200208013552.241832-1-drosen@google.com>
 <20200208013552.241832-8-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200208013552.241832-8-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 05:35:51PM -0800, Daniel Rosenberg wrote:
> This adds support for encryption with casefolding.
> 
> Since the name on disk is case preserving, and also encrypted, we can no
> longer just recompute the hash on the fly. Additionally, to avoid
> leaking extra information from the hash of the unencrypted name, we use
> siphash via an fscrypt v2 policy.
> 
> The hash is stored at the end of the directory entry for all entries
> inside of an encrypted and casefolded directory apart from those that
> deal with '.' and '..'. This way, the change is backwards compatible
> with existing ext4 filesystems.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>  Documentation/filesystems/ext4/directory.rst |  27 ++
>  fs/ext4/dir.c                                |  27 +-
>  fs/ext4/ext4.h                               |  64 +++-
>  fs/ext4/hash.c                               |  24 +-
>  fs/ext4/ialloc.c                             |   5 +-
>  fs/ext4/inline.c                             |  41 +--
>  fs/ext4/namei.c                              | 291 +++++++++++++------
>  fs/ext4/super.c                              |   6 -
>  8 files changed, 343 insertions(+), 142 deletions(-)

How was this tested?  I tried it (using a patched version of 'mke2fs' that
allows the encrypt and encoding options to be combined), and I immediately got
an ext4 error about a bad directory entry:

~/e2fsprogs/misc/mke2fs -F -t ext4 -O encrypt -E encoding=utf8 /dev/vdb
mount /dev/vdb /mnt
fscrypt setup /mnt
mkdir /mnt/dir
# (assumes /etc/fscrypt.conf contains policy_version 2)
echo hunter2 | fscrypt encrypt /mnt/dir --quiet --source=custom_passphrase --name=dir
chattr +F /mnt/dir
echo contents > /mnt/dir/file
umount /mnt
mount /dev/vdb /mnt
ls /mnt/dir/
[  391.292067] EXT4-fs error (device vdb): htree_dirblock_to_tree:1038: inode #8193: block 4251: comm ls: bad entry in directory: directory entry too close to block end - offset=80, inode=18, rec_len=4004, lblk=0, size=4096
