Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1B1777F26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 19:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbjHJRcM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 13:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjHJRcL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:32:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1142702;
        Thu, 10 Aug 2023 10:32:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C066C60C6E;
        Thu, 10 Aug 2023 17:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F11C433C8;
        Thu, 10 Aug 2023 17:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691688730;
        bh=jqKPlFDYzdL8CJp3TA+4twzklky0wW7cWmS7m81wH+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wIK/zj2SRsqJMsUjc8U5fOPZna2hBCpa6VhGWa1RTzraVJdrpH06+zrTRa8s9FwWd
         lDp9xMCp9LptZ1R++ywSKldAbIZCYW+mW82qZvhO+ukEgP0faf99pAx7cmbT8YCpRR
         K4ikjzLtlOJTE3grhFYBb/zdgTM1vH/Xtbj0AKt8=
Date:   Thu, 10 Aug 2023 19:32:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manas Ghandat <ghandatmanas@gmail.com>
Cc:     Linux-kernel-mentees@lists.linuxfoundation.org, anton@tuxera.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] ntfs : fix shift-out-of-bounds in ntfs_iget
Message-ID: <2023081050-extent-footsie-66c9@gregkh>
References: <2023080811-populace-raven-96d2@gregkh>
 <20230810161308.8577-1-ghandatmanas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810161308.8577-1-ghandatmanas@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 10, 2023 at 09:43:08PM +0530, Manas Ghandat wrote:
> Added a check to the compression_unit so that out of bound doesn't occur.

This probably needs more text to describe what is happening.


> 
> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
> Reported-by: syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=4768a8f039aa677897d0

What commit id does this fix?  Should it go to stable kernels?


> ---
> V2 -> V3: Fix patching issue.
> V1 -> V2: Cleaned up coding style.
> 
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

Should be indented a bit left, right?

> +						ntfs_error(vi->i_sb,
> +							"Found non-standard compression unit (%u).   Cannot handle this.",

Why all the extra ' ' characters?

thanks,

greg k-h
