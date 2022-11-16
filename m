Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3912F62B11E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 03:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiKPCLx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 21:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiKPCLd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 21:11:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD54831ED6;
        Tue, 15 Nov 2022 18:11:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9218AB81A63;
        Wed, 16 Nov 2022 02:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2816EC433D6;
        Wed, 16 Nov 2022 02:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668564661;
        bh=ld0qkrtDSwM3SdstWq1JaEvveGrG0LuAO4gxXXjnm20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gLklhprduo7lgmoE3m8NzyKWECnC29pcc5D17mIqzJREHgMdBm6f1sIggqImRK19y
         rKjAGz5E8e5i8WIPVIZjkQ28cdoPpyGVITi5oKQH+31IasTAaGfeGC8z7/RyNb+NJh
         zvdZXaSRihPIgL3+ea96NP3jRisKf4DOIq3P8DVA4eZJhIont1Fb3nZchz5ZqOCCdJ
         FfDSU43uFWIdBmsqEObBjg8dF0H3ErBVVujGvNNXCWtnt92sZNanUaUszUJ68LbDOM
         9aqhC4g9LLQPvF7Onvv/hEDIguxhKFGd0/WZiiwPSwW+1kbyitR/t9xn8J2C5bzHXe
         S377OtWYfKoIA==
Date:   Tue, 15 Nov 2022 18:10:59 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Niels de Vos <ndevos@redhat.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
        Marcel Lauhoff <marcel.lauhoff@suse.com>
Subject: Re: [RFC 0/4] fs: provide per-filesystem options to disable fscrypt
Message-ID: <Y3RGs5dONBt+GAxN@sol.localdomain>
References: <20221110141225.2308856-1-ndevos@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110141225.2308856-1-ndevos@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 10, 2022 at 03:12:21PM +0100, Niels de Vos wrote:
> While more filesystems are getting support for fscrypt, it is useful to
> be able to disable fscrypt for a selection of filesystems, while
> enabling it for others.
> 
> The new USE_FS_ENCRYPTION define gets picked up in
> include/linux/fscrypt.h. This allows filesystems to choose to use the
> empty function definitions, or the functional ones when fscrypt is to be
> used with the filesystem.
> 
> Using USE_FS_ENCRYPTION is a relatively clean approach, and requires
> minimal changes to the filesystems supporting fscrypt. This RFC is
> mostly for checking the acceptance of this solution, or if an other
> direction is preferred.
> 
> ---
> 
> Niels de Vos (4):
>   fscrypt: introduce USE_FS_ENCRYPTION
>   fs: make fscrypt support an ext4 config option
>   fs: make fscrypt support a f2fs config option
>   fs: make fscrypt support a UBIFS config option

So as others have pointed out, it doesn't seem worth the complexity to do this.

For a bit of historical context, before Linux v5.1, we did have per-filesystem
options for this: CONFIG_EXT4_ENCRYPTION, CONFIG_F2FS_FS_ENCRYPTION, and
CONFIG_UBIFS_FS_ENCRYPTION.  If you enabled one of these, it selected
CONFIG_FS_ENCRYPTION to get the code in fs/crypto/.  CONFIG_FS_ENCRYPTION was a
tristate, so the code in fs/crypto/ could be built as a loadable module if it
was only needed by filesystems that were loadable modules themselves.

Having fs/crypto/ possibly be a loadable module was problematic, though, because
it made it impossible to call into fs/crypto/ from built-in code such as
fs/buffer.c, fs/ioctl.c, fs/libfs.c, fs/super.c, fs/iomap/direct-io.c, etc.  So
that's why we made CONFIG_FS_ENCRYPTION into a bool.  At the same time, we
decided to simplify the kconfig options by removing the per-filesystem options
so that it worked like CONFIG_QUOTA, CONFIG_FS_DAX, CONFIG_FS_POSIX_ACL, etc.

I suppose we *could* have *just* changed CONFIG_FS_ENCRYPTION to a bool to solve
the first problem, and kept the per-filesystem options.  I think that wouldn't
have made a lot of sense, though, for the reasons that Ted has already covered.

A further point, beyond what Ted has already covered, is that
non-filesystem-specific code can't honor filesystem-specific options.  So e.g.
if you had a filesystem with encryption disabled by kconfig, that then called
into fs/iomap/direct-io.c to process an I/O request, it could potentially still
call into fs/crypto/ to enable encryption on that I/O request, since
fs/iomap/direct-io.c would think that encryption support is enabled.

Granted, that *should* never actually happen, because this would only make a
difference on encrypted files, and the filesystem shouldn't have allowed an
encrypted file to be opened if it doesn't have encryption support enabled.  But
it does seem a bit odd, given that it would go against the goal of compiling out
all encryption code for a filesystem.

- Eric
