Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637E674786B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 20:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjGDSoU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 14:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGDSoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 14:44:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199FBE64;
        Tue,  4 Jul 2023 11:44:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1AAC6135E;
        Tue,  4 Jul 2023 18:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97002C433C8;
        Tue,  4 Jul 2023 18:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688496258;
        bh=hDKl5t70qzP61QO0xHoDVX4sSDqQj16F4n8PIeWs4E8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LxErgMXJnp0cfmV+O5rxWWMIkmrE0JJHLuo8fzSAK5UfRQ5M5H/hf7nAoicKWAwmj
         Ti35s8MkIfk9rLT8O0CU66OjHfqZepcY5JkHJuGxmVMmbn0QedXi0Oli4T7n0tx2dn
         2apxqvgxtyxA7hLYyrhJjZXSQZANCCPRvs+vXyi6Ko1/f6/QrZipQYSFHFkxTPuyfB
         vFxy0AcQfGCj7455j2ShPiqvuXcZNqmDvZ+uJOnifaWMUvOM3qMikocUj12or/Wu6S
         oxogFZNsQ/C9Hrp/vEJs28m/nDT0FDF/M5HkFmFpBksziAWkaW5irizEvxEY4dEDkC
         okLjDgZZxTsFQ==
Date:   Tue, 4 Jul 2023 11:44:16 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 1/6] block: Add config option to not allow writing to
 mounted devices
Message-ID: <20230704184416.GE1851@sol.localdomain>
References: <20230704122727.17096-1-jack@suse.cz>
 <20230704125702.23180-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704125702.23180-1-jack@suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 04, 2023 at 02:56:49PM +0200, Jan Kara wrote:
> Writing to mounted devices is dangerous and can lead to filesystem
> corruption as well as crashes. Furthermore syzbot comes with more and
> more involved examples how to corrupt block device under a mounted
> filesystem leading to kernel crashes and reports we can do nothing
> about. Add tracking of writers to each block device and a kernel cmdline
> argument which controls whether writes to block devices open with
> BLK_OPEN_BLOCK_WRITES flag are allowed. We will make filesystems use
> this flag for used devices.
> 
> Syzbot can use this cmdline argument option to avoid uninteresting
> crashes. Also users whose userspace setup does not need writing to
> mounted block devices can set this option for hardening.
> 
> Link: https://lore.kernel.org/all/60788e5d-5c7c-1142-e554-c21d709acfd9@linaro.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  block/Kconfig             | 16 ++++++++++
>  block/bdev.c              | 63 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/blk_types.h |  1 +
>  include/linux/blkdev.h    |  3 ++
>  4 files changed, 82 insertions(+), 1 deletion(-)
> 
> diff --git a/block/Kconfig b/block/Kconfig
> index 86122e459fe0..8b4fa105b854 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -77,6 +77,22 @@ config BLK_DEV_INTEGRITY_T10
>  	select CRC_T10DIF
>  	select CRC64_ROCKSOFT
>  
> +config BLK_DEV_WRITE_MOUNTED
> +	bool "Allow writing to mounted block devices"
> +	default y
> +	help
> +	When a block device is mounted, writing to its buffer cache very likely
> +	going to cause filesystem corruption. It is also rather easy to crash
> +	the kernel in this way since the filesystem has no practical way of
> +	detecting these writes to buffer cache and verifying its metadata
> +	integrity. However there are some setups that need this capability
> +	like running fsck on read-only mounted root device, modifying some
> +	features on mounted ext4 filesystem, and similar. If you say N, the
> +	kernel will prevent processes from writing to block devices that are
> +	mounted by filesystems which provides some more protection from runaway
> +	priviledged processes. If in doubt, say Y. The configuration can be
> +	overridden with bdev_allow_write_mounted boot option.

Does this prevent the underlying storage from being written to?  Say if the
mounted block device is /dev/sda1 and someone tries to write to /dev/sda in the
region that contains sda1.

I *think* the answer is no, writes to /dev/sda are still allowed since the goal
is just to prevent writes to the buffer cache of mounted block devices, not
writes to the underlying storage.  That is really something that should be
stated explicitly, though.

- Eric
