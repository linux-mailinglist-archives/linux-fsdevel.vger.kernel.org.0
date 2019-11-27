Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1C9810B141
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 15:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfK0OZX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 09:25:23 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43124 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727313AbfK0OZX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 09:25:23 -0500
Received: from callcc.thunk.org (97-71-153.205.biz.bhn.net [97.71.153.205] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xAREP9Sx018154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 09:25:10 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9092F4202FD; Wed, 27 Nov 2019 09:25:08 -0500 (EST)
Date:   Wed, 27 Nov 2019 09:25:08 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Daniel Phillips <daniel@phunq.net>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [RFC] Thing 1: Shardmap fox Ext4
Message-ID: <20191127142508.GB5143@mit.edu>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A couple of quick observations about Shardmap.

(1) It's licensed[1] under the GPLv3, so it's not compatible with the
kernel license.  That doesn't matter much for ext4, because...

[1] https://github.com/danielbot/Shardmap/blob/master/LICENSE


(2) It's implemented as userspace code (e.g., it uses open(2),
mmap(2), et. al) and using C++, so it would need to be reimplemented
from scratch for use in the kernel.


(3) It's not particularly well documented, making the above more
challenging, but it appears to be a variation of an extensible hashing
scheme, which was used by dbx and Berkley DB.


(4) Because of (2), we won't be able to do any actual benchmarks for a
while.  I just checked the latest version of Tux3[2], and it appears
to be be still using a linear search scheme for its directory ---
e.g., an O(n) lookup ala ext2.  So I'm guessing Shardmap may have been
*designed* for Tux3, but it has not yet been *implemented* for Tux3?

[2] https://github.com/OGAWAHirofumi/linux-tux3/blob/hirofumi/fs/tux3/dir.c#L283


(5) The claim is made that readdir() accesses files sequentially; but
there is also mention in Shardmap of compressing shards (e.g.,
rewriting them) to squeeze out deleted and tombstone entries.  This
pretty much guarantees that it will not be possible to satisfy POSIX
requirements of telldir(2)/seekdir(3) (using a 32-bit or 64-bitt
cookie), NFS (which also requires use of a 32-bit or 64-bit cookie
while doing readdir scan), or readdir() semantics in the face of
directory entries getting inserted or removed from the directory.

(To be specific, POSIX requires readdir returns each entry in a
directory once and only once, and in the case of a directory entry
which is removed or inserted, that directory entry must be returned
exactly zero or one times.  This is true even if telldir(2) ort
seekdir(2) is used to memoize a particular location in the directory,
which means you have a 32-bit or 64-bit cookie to define a particular
location in the readdir(2) stream.  If the file system wants to be
exportable via NFS, it must meet similar requirements ---- except the
32-bit or 64-bit cookie MUST survive a reboot.)

Regards,

						- Ted
