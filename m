Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DF9774110
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 19:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjHHROY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 13:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbjHHRNs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:13:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535C61C10E;
        Tue,  8 Aug 2023 09:05:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A47A623F9;
        Tue,  8 Aug 2023 05:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47730C433C7;
        Tue,  8 Aug 2023 05:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691472425;
        bh=S9P0wt9/UV+bZwCnIUc+wtbpz2FzSntM/auL0J/PicU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B9ZxvXh1Apn7cPVBgbYzQsJo5pXkygSx/IaWe63PMlz0D+HZ7IERKsmOoxOWPpL/D
         cgcCPx9EVmvp/8k9D8u/ZDWMLDhGjzcbJuqfZrjzCPBVxwR3q/o2D0dc/nHY1Vpwdj
         jg4WCJ6iFvYW2RfRUc0OLYPwu54K+JwG15UlimWs=
Date:   Tue, 8 Aug 2023 07:27:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manas Ghandat <ghandatmanas@gmail.com>
Cc:     anton@tuxera.com, linkinjeon@kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com,
        linux-fsdevel@vger.kernel.org,
        Linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] ntfs : fix shift-out-of-bounds in ntfs_iget
Message-ID: <2023080821-blandness-survival-44af@gregkh>
References: <20230808043404.9028-1-ghandatmanas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808043404.9028-1-ghandatmanas@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 10:04:05AM +0530, Manas Ghandat wrote:
> Added a check to the compression_unit so that out of bound doesn't
> occur.
> 
> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
> Reported-by: syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
> ---
>  fs/ntfs/inode.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index 6c3f38d66579..2ee100a7df32 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -1077,6 +1077,17 @@ static int ntfs_read_locked_inode(struct inode *vi)
>  					goto unm_err_out;
>  				}
>  				if (a->data.non_resident.compression_unit) {
> +					if(a->data.non_resident.compression_unit + 
> +						vol->cluster_size_bits > 32) {
> +							ntfs_error(vi->i_sb, "Found "
> +								"non-standard "
> +								"compression unit (%u).   "
> +								"Cannot handle this.",

Please do not split strings across lines.

And checkpatch will find other problems with this change as well, did
you run it before submitting it.

thanks,

greg k-h
