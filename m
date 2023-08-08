Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2CC7747E7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 21:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjHHTWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 15:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbjHHTVp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:21:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F94810C397;
        Tue,  8 Aug 2023 09:45:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6854B6249D;
        Tue,  8 Aug 2023 10:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41632C433C9;
        Tue,  8 Aug 2023 10:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691491551;
        bh=gyjPKuYD6JNhlxb0kNhxGzdUJ6csqcLkvyjwlVH2pDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mhcqifm9dNwNrQ9v5LsHk6rgbfaLMA/lUO+//NapmjQVpB7E5fXcUxGY0paOtkRQn
         Eg8Cz0j5IiFfK4hCe748TVN9n9Z6uqzYyQWQh0h0UBpDOKw+P567t9inQPCLE2BCgl
         UY47DFeKRSmTAbS9qB8eGuh3/buqG4TOB3zBNqGM=
Date:   Tue, 8 Aug 2023 12:45:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manas Ghandat <ghandatmanas@gmail.com>
Cc:     Linux-kernel-mentees@lists.linuxfoundation.org, anton@tuxera.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] ntfs : fix shift-out-of-bounds in ntfs_iget
Message-ID: <2023080833-pedicure-flavorful-921c@gregkh>
References: <2023080821-blandness-survival-44af@gregkh>
 <20230808102958.8161-1-ghandatmanas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808102958.8161-1-ghandatmanas@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 03:59:58PM +0530, Manas Ghandat wrote:
> Added a check to the compression_unit so that out of bound doesn't occur.
> 
> Fix patching issues in version 2.
> 
> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
> Reported-by: syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=4768a8f039aa677897d0
> ---
>  fs/ntfs/inode.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index 6c3f38d66579..a657322874ed 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -1077,6 +1077,15 @@ static int ntfs_read_locked_inode(struct inode *vi)
>  					goto unm_err_out;
>  				}
>  				if (a->data.non_resident.compression_unit) {
> +					if (a->data.non_resident.compression_unit +
> +						vol->cluster_size_bits > 32) {
> +						ntfs_error(vi->i_sb,
> +							"Found non-standard compression unit (%u).   Cannot handle this.",
> +							a->data.non_resident.compression_unit
> +						);
> +						err = -EOPNOTSUPP;
> +						goto unm_err_out;
> +					}
>  					ni->itype.compressed.block_size = 1U <<
>  							(a->data.non_resident.
>  							compression_unit +
> -- 
> 2.37.2
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
