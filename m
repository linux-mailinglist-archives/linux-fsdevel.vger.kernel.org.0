Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5362D4B1E80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Feb 2022 07:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbiBKGRq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 01:17:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiBKGRp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:17:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1762B2D0;
        Thu, 10 Feb 2022 22:17:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A67E961ABD;
        Fri, 11 Feb 2022 06:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3C8C340F1;
        Fri, 11 Feb 2022 06:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644560264;
        bh=gY+SW8mDXCVLJFUJPNH/tdEUYgt89QeK8AWxE3ZwQBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p6vbGACw3Ah792ljjZrRk/+olQ9AfeLUPMAl5V588ySx/IVsJQnK07PzkJvcRbFkn
         KNmefDP2m5WZNSwTJh98wR2mjNlEU9eSBNLor2qB82UY9PIfIwhYm+Tj4FSTdrw6ZJ
         LTCIGNC2z1iibcS243VKWrb9kmjxa+TDHQM7myQcTmaf6WkFEVKSoPT4I80NRycm8k
         gEwP6XCAY3/7/cCzQbefOwUVITsq2Bqi1l7DV/AjIWgHqZrwa1VXFDxp5+V4CGtaxy
         5us5ng6vuaQllDiBtyey+G4tpaPkrOelsr5xv9/B9XT9biWt6iGiax7OEZHgStolCj
         Rrxf8QPLV7aCA==
Date:   Thu, 10 Feb 2022 22:17:42 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v11 0/5] add support for direct I/O with fscrypt using
 blk-crypto
Message-ID: <YgX/hl4GK85M9mGs@sol.localdomain>
References: <20220128233940.79464-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128233940.79464-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 28, 2022 at 03:39:35PM -0800, Eric Biggers wrote:
> [Note: I'm planning to send a patchset adding STATX_DIRECTIO as was
> discussed on v10, but that will be a separate patchset.]
> 
> Encrypted files traditionally haven't supported DIO, due to the need to
> encrypt/decrypt the data.  However, when the encryption is implemented
> using inline encryption (blk-crypto) instead of the traditional
> filesystem-layer encryption, it is straightforward to support DIO.
> 
> This series adds support for this.  There are multiple use cases for DIO
> on encrypted files, but avoiding double caching on loopback devices
> located in an encrypted directory is the main one currently.
> 
> v1 through v9 of this series were sent out by Satya Tangirala.  I've
> cleaned up a few things since Satya's last version
> (https://lore.kernel.org/all/20210604210908.2105870-1-satyat@google.com/T/#u).
> But more notably, I've made a couple simplifications.
> 
> First, since f2fs has now been converted to use iomap for DIO, I've
> dropped the patch which added fscrypt support to fs/direct-io.c.
> 
> Second, I've returned to the original design where DIO requests must be
> fully aligned to the FS block size in terms of file position, length,
> and memory buffers.  Satya previously was pursuing a slightly different
> design, where the memory buffers (but not the file position and length)
> were allowed to be aligned to just the block device logical block size.
> This was at the request of Dave Chinner on v4 and v6 of the patchset
> (https://lore.kernel.org/linux-fscrypt/20200720233739.824943-1-satyat@google.com/T/#u
> and
> https://lore.kernel.org/linux-fscrypt/20200724184501.1651378-1-satyat@google.com/T/#u).
> 
> I believe that approach is a dead end, for two reasons.  First, it
> necessarily causes it to be possible that crypto data units span bvecs.
> Splits cannot occur at such locations; however the block layer currently
> assumes that bios can be split at any bvec boundary.  Changing that is
> quite difficult, as Satya's v9 patchset demonstrated.  This is not an
> issue if we require FS block aligned buffers instead.  Second, it
> doesn't change the fact that FS block alignment is still required for
> the file position and I/O length; this is unavoidable due to the
> granularity of encryption being the FS block size.  So, it seems that
> relaxing the memory buffer alignment requirement wouldn't make things
> meaningfully easier for applications, which raises the question of why
> we would bother with it in the first place.
> 
> Christoph Hellwig also said that he much prefers that fscrypt DIO be
> supported without sector-only alignment to start:
> https://lore.kernel.org/r/YPu+88KReGlt94o3@infradead.org
> 
> Given the above, as far as I know the only remaining objection to this
> patchset would be that DIO constraints aren't sufficiently discoverable
> by userspace.  Now, to put this in context, this is a longstanding issue
> with all Linux filesystems, except XFS which has XFS_IOC_DIOINFO.  It's
> not specific to this feature, and it doesn't actually seem to be too
> important in practice; many other filesystem features place constraints
> on DIO, and f2fs even *only* allows fully FS block size aligned DIO.
> (And for better or worse, many systems using fscrypt already have
> out-of-tree patches that enable DIO support, and people don't seem to
> have trouble with the FS block size alignment requirement.)
> 
> To address the issue of DIO constraints being insufficiently
> discoverable, I plan to make statx() expose this information.
> 
> This series applies to v5.17-rc1.
> 
> Changed v10 => v11:
>   * Changed fscrypt_dio_unsupported() back to fscrypt_dio_supported().
>   * Removed a mention of f2fs from fscrypt_dio_supported().
>   * Added Reviewed-by and Acked-by tags, including a couple from earlier
>     I had dropped due to the renaming of fscrypt_dio_supported().
>   * In fscrypt_limit_io_blocks(), don't load i_crypt_info until it's
>     known to be valid, to avoid confusion as is done elsewhere.
> 
> Eric Biggers (5):
>   fscrypt: add functions for direct I/O support
>   iomap: support direct I/O with fscrypt using blk-crypto
>   ext4: support direct I/O with fscrypt using blk-crypto
>   f2fs: support direct I/O with fscrypt using blk-crypto
>   fscrypt: update documentation for direct I/O support
> 
>  Documentation/filesystems/fscrypt.rst | 25 ++++++-
>  fs/crypto/crypto.c                    |  8 +++
>  fs/crypto/inline_crypt.c              | 93 +++++++++++++++++++++++++++
>  fs/ext4/file.c                        | 10 +--
>  fs/ext4/inode.c                       |  7 ++
>  fs/f2fs/data.c                        |  7 ++
>  fs/f2fs/f2fs.h                        |  6 +-
>  fs/iomap/direct-io.c                  |  6 ++
>  include/linux/fscrypt.h               | 18 ++++++
>  9 files changed, 173 insertions(+), 7 deletions(-)

I've applied this patchset to fscrypt.git#master for 5.18
(https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git/log/).

- Eric
