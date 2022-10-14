Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E764E5FF199
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 17:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiJNPoU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 11:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJNPoS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:44:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6A027B16;
        Fri, 14 Oct 2022 08:44:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B52C61BB3;
        Fri, 14 Oct 2022 15:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F66C433D6;
        Fri, 14 Oct 2022 15:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665762256;
        bh=a5ohXX2HljiK2lNNucw1xbywST/b4xYjzGhuCnryDTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BojrB6HSrEMn1FhOgfcP/WBFDRf35mrgRpMiajKBb27i/tgA0yefz/nT4qQzAhWud
         I2BIVssXLeiYN1j+rCLBf8YukEVGRs/Yo7TcK41ggGHF1t8gNqn7JmlWjM9nbQTpay
         Bo6K8LKowNqInWjustkMtzWpwqYUb3dK79HqY6jzscgi+4qSDsEd54sSQ98ZxN9SSg
         WbN6PEb8FHoe6zPwitBWhHa8UGo/t58coOzis1+FRAp3U8lEIgrB9QvPSd9PYSHaIC
         +IEzfryV+tWCKGx95u9xR0HrB9NwDP3GqRC4BFQFgbqBZlGnfqVyboxmulVghVWA3B
         Xo1doKeBNsfuQ==
Date:   Fri, 14 Oct 2022 08:44:16 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Hrutvik Kanabar <hrkanabar@gmail.com>
Cc:     Hrutvik Kanabar <hrutvik@google.com>,
        Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        kasan-dev@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH RFC 5/7] fs/xfs: support `DISABLE_FS_CSUM_VERIFICATION`
 config option
Message-ID: <Y0mD0LcNvu+QTlQ9@magnolia>
References: <20221014084837.1787196-1-hrkanabar@gmail.com>
 <20221014084837.1787196-6-hrkanabar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014084837.1787196-6-hrkanabar@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 14, 2022 at 08:48:35AM +0000, Hrutvik Kanabar wrote:
> From: Hrutvik Kanabar <hrutvik@google.com>
> 
> When `DISABLE_FS_CSUM_VERIFICATION` is enabled, return truthy value for
> `xfs_verify_cksum`, which is the key function implementing checksum
> verification for XFS.
> 
> Signed-off-by: Hrutvik Kanabar <hrutvik@google.com>

NAK, we're not going to break XFS for the sake of automated fuzz tools.

You'll have to adapt your fuzzing tools to rewrite the block header
checksums, like the existing xfs fuzz testing framework does.  See
the xfs_db 'fuzz -d' command and the relevant fstests.

--D

> ---
>  fs/xfs/libxfs/xfs_cksum.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_cksum.h b/fs/xfs/libxfs/xfs_cksum.h
> index 999a290cfd72..ba55b1afa382 100644
> --- a/fs/xfs/libxfs/xfs_cksum.h
> +++ b/fs/xfs/libxfs/xfs_cksum.h
> @@ -76,7 +76,10 @@ xfs_verify_cksum(char *buffer, size_t length, unsigned long cksum_offset)
>  {
>  	uint32_t crc = xfs_start_cksum_safe(buffer, length, cksum_offset);
>  
> -	return *(__le32 *)(buffer + cksum_offset) == xfs_end_cksum(crc);
> +	if (IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION))
> +		return 1;
> +	else
> +		return *(__le32 *)(buffer + cksum_offset) == xfs_end_cksum(crc);
>  }
>  
>  #endif /* _XFS_CKSUM_H */
> -- 
> 2.38.0.413.g74048e4d9e-goog
> 
