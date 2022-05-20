Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C252152EB34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 13:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348772AbiETLwr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 07:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348762AbiETLwp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 07:52:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31F615E48E;
        Fri, 20 May 2022 04:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FFC461DEB;
        Fri, 20 May 2022 11:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDA2C385A9;
        Fri, 20 May 2022 11:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653047563;
        bh=KjobZP6O6Jgwt6QhmllP83ZeT6Jg+VwnOafaxcAZ+8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bptv6Mg3TVFF3Sk1DQV4g4ILT2blHfHJLQtoU4tvyhqF7sBMSi7SFHPt3GYix9zDj
         fmabFBKLLAt+mzYpio3Dnr/a7b1Bzz/E1lwcSx8VAf8RLyOdKVCKRepQRXrq4mW3NI
         xqhUOLKtCR6bJJICVsEgK6en7zdhRbI3TuWM4uIQLCEtyDzROd1z4XU0U6Eg3HnHGC
         6Vu5Fs1CZPey2sZjUfEvTvZXyBNZShJ6tvoIR9/5uN7AJh/Mv7cAPeyxtXUC8GLCOr
         f3oZpQCpTLgA7aCs25q+jmOHsq0cBJOc1BrqKgBXL2hPTHR0+nkHa+zQP+BSejsGZ5
         JQb/K98Kky8rA==
Date:   Fri, 20 May 2022 13:52:37 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC PATCH v2 1/7] statx: add I/O alignment information
Message-ID: <20220520115237.w2oa5bdzyzhkgwin@wittgenstein>
References: <20220518235011.153058-1-ebiggers@kernel.org>
 <20220518235011.153058-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220518235011.153058-2-ebiggers@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 18, 2022 at 04:50:05PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Traditionally, the conditions for when DIO (direct I/O) is supported
> were fairly simple: filesystems either supported DIO aligned to the
> block device's logical block size, or didn't support DIO at all.
> 
> However, due to filesystem features that have been added over time (e.g,
> data journalling, inline data, encryption, verity, compression,
> checkpoint disabling, log-structured mode), the conditions for when DIO
> is allowed on a file have gotten increasingly complex.  Whether a
> particular file supports DIO, and with what alignment, can depend on
> various file attributes and filesystem mount options, as well as which
> block device(s) the file's data is located on.
> 
> XFS has an ioctl XFS_IOC_DIOINFO which exposes this information to
> applications.  However, as discussed
> (https://lore.kernel.org/linux-fsdevel/20220120071215.123274-1-ebiggers@kernel.org/T/#u),
> this ioctl is rarely used and not known to be used outside of
> XFS-specific code.  It also was never intended to indicate when a file
> doesn't support DIO at all, and it only exposes the minimum I/O
> alignment, not the optimal I/O alignment which has been requested too.
> 
> Therefore, let's expose this information via statx().  Add the
> STATX_IOALIGN flag and three fields associated with it:
> 
> * stx_mem_align_dio: the alignment (in bytes) required for user memory
>   buffers for DIO, or 0 if DIO is not supported on the file.
> 
> * stx_offset_align_dio: the alignment (in bytes) required for file
>   offsets and I/O segment lengths for DIO, or 0 if DIO is not supported
>   on the file.  This will only be nonzero if stx_mem_align_dio is
>   nonzero, and vice versa.
> 
> * stx_offset_align_optimal: the alignment (in bytes) suggested for file
>   offsets and I/O segment lengths to get optimal performance.  This
>   applies to both DIO and buffered I/O.  It differs from stx_blocksize
>   in that stx_offset_align_optimal will contain the real optimum I/O
>   size, which may be a large value.  In contrast, for compatibility
>   reasons stx_blocksize is the minimum size needed to avoid page cache
>   read/write/modify cycles, which may be much smaller than the optimum
>   I/O size.  For more details about the motivation for this field, see
>   https://lore.kernel.org/r/20220210040304.GM59729@dread.disaster.area
> 
> Note that as with other statx() extensions, if STATX_IOALIGN isn't set
> in the returned statx struct, then these new fields won't be filled in.
> This will happen if the filesystem doesn't support STATX_IOALIGN, or if
> the file isn't a regular file.  (It might be supported on block device
> files in the future.)  It might also happen if the caller didn't include
> STATX_IOALIGN in the request mask, since statx() isn't required to
> return information that wasn't requested.
> 
> This commit adds the VFS-level plumbing for STATX_IOALIGN.  Individual
> filesystems will still need to add code to support it.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
