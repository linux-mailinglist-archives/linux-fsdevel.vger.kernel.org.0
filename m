Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CDA2CF43A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 19:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbgLDSjV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Dec 2020 13:39:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:48690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730232AbgLDSjV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Dec 2020 13:39:21 -0500
Date:   Fri, 4 Dec 2020 10:38:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607107120;
        bh=D0VwnsQjiZd2p/qMGY9WV/AY29U7e8/pE7AugozrGvQ=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=FmeSO1dCGWCpOlO8wpniiJ1ANCDVVBGa97IucG4eL4WhlMp8CmgYdlvh/B0h3RbWN
         zY/Q0e8MER7rAwEqxjQ84cuX/3eSB9iGpHVL1LP7Uj9U0uFpsWSfk0nFa4M6Ku1o7g
         g7ExD/x89MWdXT7bfWxkVkM3Hp4O2oosMuTHNIDGwbRiwgRg9tOGUu4BFK8hyoOybZ
         NVkuV3iWU2z6BfbmyrtOxS/4MlNe3VKZXwlv52ELqNPHOI0T5tXpoUeW/00IkZwIMi
         NjnYti7V++dHVfyRC5HMP2Z8B+2BciuONki7MZeY9Xk22l9Khj/OyJx92ZR5i0ETuN
         /Nqc1aMyvuw2A==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de
Subject: Re: [PATCH v14 06/10] fs/ntfs3: Add compression
Message-ID: <X8qCLXJOit0M+4X7@sol.localdomain>
References: <20201204154600.1546096-1-almaz.alexandrovich@paragon-software.com>
 <20201204154600.1546096-7-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204154600.1546096-7-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 04, 2020 at 06:45:56PM +0300, Konstantin Komarov wrote:
> This adds compression
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/lib/common_defs.h       | 196 +++++++++++
>  fs/ntfs3/lib/decompress_common.c | 314 +++++++++++++++++
>  fs/ntfs3/lib/decompress_common.h | 558 +++++++++++++++++++++++++++++++
>  fs/ntfs3/lib/lzx_common.c        | 204 +++++++++++
>  fs/ntfs3/lib/lzx_common.h        |  31 ++
>  fs/ntfs3/lib/lzx_constants.h     | 113 +++++++
>  fs/ntfs3/lib/lzx_decompress.c    | 553 ++++++++++++++++++++++++++++++
>  fs/ntfs3/lib/xpress_constants.h  |  23 ++
>  fs/ntfs3/lib/xpress_decompress.c | 165 +++++++++
>  fs/ntfs3/lznt.c                  | 452 +++++++++++++++++++++++++
>  10 files changed, 2609 insertions(+)
>  create mode 100644 fs/ntfs3/lib/common_defs.h
>  create mode 100644 fs/ntfs3/lib/decompress_common.c
>  create mode 100644 fs/ntfs3/lib/decompress_common.h
>  create mode 100644 fs/ntfs3/lib/lzx_common.c
>  create mode 100644 fs/ntfs3/lib/lzx_common.h
>  create mode 100644 fs/ntfs3/lib/lzx_constants.h
>  create mode 100644 fs/ntfs3/lib/lzx_decompress.c
>  create mode 100644 fs/ntfs3/lib/xpress_constants.h
>  create mode 100644 fs/ntfs3/lib/xpress_decompress.c
>  create mode 100644 fs/ntfs3/lznt.c

This really could use a much better commit message.  Including mentioning where
the LZX and XPRESS decompression code came from
(https://github.com/ebiggers/ntfs-3g-system-compression).

Also note you've marked the files as "SPDX-License-Identifier: GPL-2.0",
but they really are "SPDX-License-Identifier: GPL-2.0-or-later".

Also I still think you should consider using the simpler version from
ntfs-3g-system-compression commit 3ddd227ee8e3, which I had originally intended
to be included in NTFS-3G itself.  That version was fewer lines of code and
fewer files, as it was simplified for decompression-only.  The latest version
(the one you're using) is shared with a project that also implements compression
(so that I can more easily maintain both projects), so it's more complex than
needed for decompression-only support.  But in the kernel context it may make
sense to go with a simpler version.  There are a few performance optimizations
you'd miss by going with the older version, but they weren't too significant,
and probably you don't need to squeeze out every bit of performance possible
when reading XPRESS and LZX-compressed files in this context?

- Eric
