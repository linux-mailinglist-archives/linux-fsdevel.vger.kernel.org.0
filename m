Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5578D67B922
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 19:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbjAYSSj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 13:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbjAYSSj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:18:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D026186;
        Wed, 25 Jan 2023 10:18:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F0B9615AE;
        Wed, 25 Jan 2023 18:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E286C433EF;
        Wed, 25 Jan 2023 18:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674670716;
        bh=4OvC/a+md6kdAfKZwdL+M9oXYAGXwUs2kFoJ+/mfzUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vj7RtkeUWUupACyrp74577xD2hsSzBplxyfZWcAXiwwq3cYUXsaefuslLNjVQx6z7
         RHx0psIAjqfKwM0fYPFpyb8SOV2v9Zt97gMrtum93LyX7t9dk1uA/i40MOFtibHvMo
         zilq8RGiscF8duhmeSiGBzapN4w2WWB7r2Ks3tMewsM1l0ZCeIPRvmHHegHNeNtZs/
         JRrV5dR/SNYsI9YAdBvmoV/rtea1QywofhwuPclFo69AfoHgGd2MCfvXPkLk9aAE8G
         jt3df9MT+8lbSanYvBe5zxybqHZwt1+eDebiFdapzZTENlaV4ACRxdOJ+rrj7N4GKx
         N3JYOlOb6yTpg==
Date:   Wed, 25 Jan 2023 10:18:34 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: build the legacy direct I/O code conditionally
Message-ID: <Y9FyevJAyyGUPgJb@sol.localdomain>
References: <20230125065839.191256-1-hch@lst.de>
 <20230125065839.191256-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125065839.191256-3-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023 at 07:58:39AM +0100, Christoph Hellwig wrote:
> Add a new LEGACY_DIRECT_IO config symbol that is only selected by the
> file systems that still use the legacy blockdev_direct_IO code, so that
> kernels without support for those file systems don't need to build the
> code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/Kconfig          | 4 ++++
>  fs/Makefile         | 3 ++-
>  fs/affs/Kconfig     | 1 +
>  fs/exfat/Kconfig    | 1 +
>  fs/ext2/Kconfig     | 1 +
>  fs/fat/Kconfig      | 1 +
>  fs/hfs/Kconfig      | 1 +
>  fs/hfsplus/Kconfig  | 1 +
>  fs/jfs/Kconfig      | 1 +
>  fs/nilfs2/Kconfig   | 1 +
>  fs/ntfs3/Kconfig    | 1 +
>  fs/ocfs2/Kconfig    | 1 +
>  fs/reiserfs/Kconfig | 1 +
>  fs/udf/Kconfig      | 1 +
>  14 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 2685a4d0d35318..e99830c650336a 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -18,6 +18,10 @@ config VALIDATE_FS_PARSER
>  config FS_IOMAP
>  	bool
>  
> +# old blockdev_direct_IO implementation.  Use iomap for new code instead
> +config LEGACY_DIRECT_IO
> +	bool
> +
>  if BLOCK
>  

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
