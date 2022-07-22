Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18D357E469
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 18:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbiGVQb4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 12:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiGVQbz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:31:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E805C89A9B;
        Fri, 22 Jul 2022 09:31:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2190B82970;
        Fri, 22 Jul 2022 16:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682F5C341C6;
        Fri, 22 Jul 2022 16:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658507510;
        bh=2zJKttnRhj1+bfpQ1neKDFu0IlRxRblBoec0bp8Sdok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R6uxrMTGkXqjhGQr3zA8qNa8GSPQYWhhd4mQ3yYrU74pGY1LX1IaIR5hc0nNP92LQ
         q9wz+Ac3IrLVRoZlFBxpRSiQx2lr3niXhLmKlEKd0WaePq36/63ztLdxUHKVP91cna
         iTiD0U+7tuK8NQRrlnfsoyqCoOVisiWxoj95uBcTC6TpEN1dPCJvAwk4AG+OLFbipY
         Ev1zg3asT7LDP81fPvnsbpQUSyN9RHHDGbrlF5ehxKVjBYDOL18hUhi2yOduvU0hdK
         zkACGw2vJii36YKdGWHobF9F/E/t5jlN1+H172Y6t7CaMxCzV8c30PiPug7zXwMxcb
         86mtOuQB7uKRA==
Date:   Fri, 22 Jul 2022 09:31:49 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [man-pages RFC PATCH v2] statx.2, open.2: document STATX_DIOALIGN
Message-ID: <YtrQ9cWwUkmOUe9r@magnolia>
References: <20220722074229.148925-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722074229.148925-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 22, 2022 at 12:42:28AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Document the proposed STATX_DIOALIGN support for statx()
> (https://lore.kernel.org/linux-fsdevel/20220722071228.146690-1-ebiggers@kernel.org/T/#u).
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> v2: rebased onto man-pages master branch, mentioned xfs, and updated
>     link to patchset
> 
>  man2/open.2  | 43 ++++++++++++++++++++++++++++++++-----------
>  man2/statx.2 | 29 +++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 11 deletions(-)
> 
> diff --git a/man2/open.2 b/man2/open.2
> index d1485999f..ef29847c3 100644
> --- a/man2/open.2
> +++ b/man2/open.2
> @@ -1732,21 +1732,42 @@ of user-space buffers and the file offset of I/Os.
>  In Linux alignment
>  restrictions vary by filesystem and kernel version and might be
>  absent entirely.
> -However there is currently no filesystem\-independent
> -interface for an application to discover these restrictions for a given
> -file or filesystem.
> -Some filesystems provide their own interfaces
> -for doing so, for example the
> +The handling of misaligned
> +.B O_DIRECT
> +I/Os also varies; they can either fail with
> +.B EINVAL
> +or fall back to buffered I/O.
> +.PP
> +Since Linux 5.20,
> +.B O_DIRECT
> +support and alignment restrictions for a file can be queried using
> +.BR statx (2),
> +using the
> +.B STATX_DIOALIGN
> +flag.
> +Support for
> +.B STATX_DIOALIGN
> +varies by filesystem; see
> +.BR statx (2).
> +.PP
> +Some filesystems provide their own interfaces for querying
> +.B O_DIRECT
> +alignment restrictions, for example the
>  .B XFS_IOC_DIOINFO
>  operation in
>  .BR xfsctl (3).
> +.B STATX_DIOALIGN
> +should be used instead when it is available.
>  .PP
> -Under Linux 2.4, transfer sizes, the alignment of the user buffer,
> -and the file offset must all be multiples of the logical block size
> -of the filesystem.
> -Since Linux 2.6.0, alignment to the logical block size of the
> -underlying storage (typically 512 bytes) suffices.
> -The logical block size can be determined using the
> +If none of the above is available, then direct I/O support and alignment
> +restrictions can only be assumed from known characteristics of the filesystem,
> +the individual file, the underlying storage device(s), and the kernel version.
> +In Linux 2.4, most block device based filesystems require that the file offset
> +and the length and memory address of all I/O segments be multiples of the
> +filesystem block size (typically 4096 bytes).
> +In Linux 2.6.0, this was relaxed to the logical block size of the block device
> +(typically 512 bytes).
> +A block device's logical block size can be determined using the
>  .BR ioctl (2)
>  .B BLKSSZGET
>  operation or from the shell using the command:
> diff --git a/man2/statx.2 b/man2/statx.2
> index 0326e9af0..ea38ec829 100644
> --- a/man2/statx.2
> +++ b/man2/statx.2
> @@ -61,7 +61,12 @@ struct statx {
>         containing the filesystem where the file resides */
>      __u32 stx_dev_major;   /* Major ID */
>      __u32 stx_dev_minor;   /* Minor ID */
> +
>      __u64 stx_mnt_id;      /* Mount ID */
> +
> +    /* Direct I/O alignment restrictions */
> +    __u32 stx_dio_mem_align;
> +    __u32 stx_dio_offset_align;
>  };
>  .EE
>  .in
> @@ -247,6 +252,8 @@ STATX_BTIME	Want stx_btime
>  STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
>  	It is deprecated and should not be used.
>  STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
> +STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
> +	(since Linux 5.20; support varies by filesystem)
>  .TE
>  .in
>  .PP
> @@ -407,6 +414,28 @@ This is the same number reported by
>  .BR name_to_handle_at (2)
>  and corresponds to the number in the first field in one of the records in
>  .IR /proc/self/mountinfo .
> +.TP
> +.I stx_dio_mem_align
> +The alignment (in bytes) required for user memory buffers for direct I/O
> +.BR "" ( O_DIRECT )
> +on this file. or 0 if direct I/O is not supported on this file.

Nit: "..on this file, or 0 if direct..."

> +.IP
> +.B STATX_DIOALIGN
> +.IR "" ( stx_dio_mem_align
> +and
> +.IR stx_dio_offset_align )
> +is supported on block devices since Linux 5.20.
> +The support on regular files varies by filesystem; it is supported by ext4,
> +f2fs, and xfs since Linux 5.20.
> +.TP
> +.I stx_dio_offset_align
> +The alignment (in bytes) required for file offsets and I/O segment lengths for
> +direct I/O
> +.BR "" ( O_DIRECT )
> +on this file, or 0 if direct I/O is not supported on this file.

On this last part -- userspace can only conclude that directio is not
supported on the file if ((STATX_DIOALIGN & stx_mask) &&
stx_dio_offset_align == 0), right?

IOWs, if (STATX_DIOALIGN & stx_mask)==0 then userspace can't draw any
conclusions from stx_dio_offset_align, correct?

If the answers are yes and yes, then I think I've understood all this
and can say
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> +This will only be nonzero if
> +.I stx_dio_mem_align
> +is nonzero, and vice versa.
>  .PP
>  For further information on the above fields, see
>  .BR inode (7).
> 
> base-commit: f9f25914e4ed393ac284ab921876e8a78722c504
> -- 
> 2.37.0
> 
