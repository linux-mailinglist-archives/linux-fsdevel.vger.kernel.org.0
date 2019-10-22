Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAD3DFD71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 08:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbfJVGAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 02:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:32856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbfJVGAI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 02:00:08 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 578F92089E;
        Tue, 22 Oct 2019 06:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571724006;
        bh=IV+O29anGZ56O62huhHa4OXym9e0Xnv7gAZOs76+eK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q3YwoQVs7bPCIFItl4itSXlw7LYeUrnwtcXhnDi1R1G97a4bw3wQtQO50DPxp8JPZ
         Qe97F9ZDTVfkx0fPuafbZUD/ny2xzKwsOz5gLgjYbpAkOC15pCe8e5FI4Juuxj/XNf
         QZiILELJNEMdNqBqi3bjjKdN+Bzgif+iVsCmzOwg=
Date:   Mon, 21 Oct 2019 23:00:04 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/3] fscrypt: add support for inline-encryption-optimized
 policies
Message-ID: <20191022060004.GA333751@sol.localdomain>
Mail-Followup-To: Dave Chinner <david@fromorbit.com>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20191021230355.23136-1-ebiggers@kernel.org>
 <20191021230355.23136-2-ebiggers@kernel.org>
 <20191022052712.GA2083@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022052712.GA2083@dread.disaster.area>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 22, 2019 at 04:27:12PM +1100, Dave Chinner wrote:
> On Mon, Oct 21, 2019 at 04:03:53PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Some inline encryption hardware has only a small number of keyslots,
> > which would make it inefficient to use the traditional fscrypt per-file
> > keys.  The existing DIRECT_KEY encryption policy flag doesn't solve this
> > because it assumes that file contents and names are encrypted by the
> > same algorithm and that IVs are at least 24 bytes.
> > 
> > Therefore, add a new encryption policy flag INLINE_CRYPT_OPTIMIZED which
> > causes the encryption to modified as follows:
> > 
> > - The key for file contents encryption is derived from the values
> >   (master_key, mode_num, filesystem_uuid).  The per-file nonce is not
> >   included, so many files may share the same contents encryption key.
> > 
> > - The IV for encrypting each block of file contents is built as
> >   (inode_number << 32) | file_logical_block_num.
> > 
> > Including the inode number in the IVs ensures that data in different
> > files is encrypted differently, despite per-file keys not being used.
> > Limiting the inode and block numbers to 32 bits and putting the block
> > number in the low bits is needed to be compatible with inline encryption
> > hardware which only supports specifying a 64-bit data unit number which
> > is auto-incremented; this is what the UFS and EMMC standards support.
> 
> These 32 bit size limits seem arbitrary and rules out implementing
> this on larger filesystems. Why not just hash the 64 bit inode, file
> offset and block numbers into a single 64 bit value? It is still
> unique enough for the stated use (i.e. unique IV for each file
> block) but it doesn't limit what filesystem configurations can
> actually make use of this functionality....
> 

That won't work because we need consecutive file blocks to have consecutive IVs
as often as possible.  The crypto support in the UFS and EMMC standards takes
only a single 64-bit "data unit number" (DUN) per request, which the hardware
uses as the first 64 bits of the IV and automatically increments for each data
unit (i.e. for each filesystem block, in this case).

If every block had some random DUN, we'd have to submit a separate bio for every
single block.  And they wouldn't be mergable, so each one would cause a separate
disk request.  That would be really terrible for performance.

Also, a 64 bit hash value isn't sufficiently safe against hash collisions.

An alternative which would work nicely on ext4 and xfs (if xfs supported
fscrypt) would be to pass the physical block number as the DUN.  However, that
wouldn't work at all on f2fs because f2fs moves data blocks around.  And since
most people who want to use this are using f2fs, f2fs support is essential.

Also keep in mind that the proposed format can still be used on a specific
filesystem instance with fewer than 2^32 inodes and blocks, even if that type of
filesystem can support more inodes and blocks in general.

- Eric
