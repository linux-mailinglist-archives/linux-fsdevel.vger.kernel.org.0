Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9DE21448EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 01:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgAVAaR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 19:30:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:41452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgAVAaR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 19:30:17 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D435217F4;
        Wed, 22 Jan 2020 00:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579653016;
        bh=H/qN5wQT4EZ5hYKWGp7yIkcoOLzjrk0gNanXBpiBRnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qUmyGZfkQoEjSKG30mFMzVYmysM/ifNtNxjkA1RSMGQ7a09pMTLRQ51CbJ/WSqYbJ
         3X6LIerTmDJS8K4r629U6pRTw5tK+OB60JON9E76MkrGSspGCJVKneBB0fF2UOY/z7
         5i6O013odo5e0N2RxkVk+0bwfG0RbjP7IfDQNb50=
Date:   Tue, 21 Jan 2020 16:30:15 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v5 4/6] ubifs: don't trigger assertion on invalid no-key
 filename
Message-ID: <20200122003014.GA180824@gmail.com>
References: <20200120223201.241390-1-ebiggers@kernel.org>
 <20200120223201.241390-5-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120223201.241390-5-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 20, 2020 at 02:31:59PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> If userspace provides an invalid fscrypt no-key filename which encodes a
> hash value with any of the UBIFS node type bits set (i.e. the high 3
> bits), gracefully report ENOENT rather than triggering ubifs_assert().
> 
> Test case with kvm-xfstests shell:
> 
>     . fs/ubifs/config
>     . ~/xfstests/common/encrypt
>     dev=$(__blkdev_to_ubi_volume /dev/vdc)
>     ubiupdatevol $dev -t
>     mount $dev /mnt -t ubifs
>     mkdir /mnt/edir
>     xfs_io -c set_encpolicy /mnt/edir
>     rm /mnt/edir/_,,,,,DAAAAAAAAAAAAAAAAAAAAAAAAAA
> 
> With the bug, the following assertion fails on the 'rm' command:
> 
>     [   19.066048] UBIFS error (ubi0:0 pid 379): ubifs_assert_failed: UBIFS assert failed: !(hash & ~UBIFS_S_KEY_HASH_MASK), in fs/ubifs/key.h:170
> 
> Fixes: f4f61d2cc6d8 ("ubifs: Implement encrypted filenames")
> Cc: <stable@vger.kernel.org> # v4.10+
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Richard, can you review the two UBIFS patches in this series, and if you're okay
with them, provide Acked-by's so that we can take them through the fscrypt tree?
They don't conflict with anything currently in the UBIFS tree.

Thanks!

- Eric
