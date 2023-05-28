Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3B3713821
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 May 2023 08:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjE1G63 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 May 2023 02:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjE1G62 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 May 2023 02:58:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BADEAD;
        Sat, 27 May 2023 23:58:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8ACE60BA0;
        Sun, 28 May 2023 06:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CEBC433D2;
        Sun, 28 May 2023 06:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685257106;
        bh=ULT0MUHPV6zX7gWbuYwDfef9KCFMMv1QSrnhRpZmcj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fa1SCm7T3Q5lK/lJrmqPV2lMY+4v5Rj5yfAZoiuD+1SfOC1ai00qLK9d1UQ6/P8rE
         km85mTgahwwEbBF4o8crePN4XyFIScPMKHU2QPtnAVsrQM51irFwYGgz6viuIzVJ9J
         AhJmqGFb7wmByVvKVNPlm2GBZAb06r81fz0xTYKI=
Date:   Sun, 28 May 2023 07:58:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prince Kumar Maurya <princekumarmaurya06@gmail.com>
Cc:     skhan@linuxfoundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chenzhongjin@huawei.com,
        syzkaller-bugs@googlegroups.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Null check to prevent null-ptr-deref bug
Message-ID: <2023052803-pucker-depress-5452@gregkh>
References: <000000000000cafb9305fc4fe588@google.com>
 <20230528012516.427126-1-princekumarmaurya06@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230528012516.427126-1-princekumarmaurya06@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 27, 2023 at 06:25:16PM -0700, Prince Kumar Maurya wrote:
> sb_getblk(inode->i_sb, parent) return a null ptr and taking lock on that leads to the null-ptr-deref bug.

Please wrap your changelog comments at 72 columns.

> Signed-off-by: Prince Kumar Maurya <princekumarmaurya06@gmail.com>
> ---
>  fs/sysv/itree.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
> index b22764fe669c..3a6b66e719fd 100644
> --- a/fs/sysv/itree.c
> +++ b/fs/sysv/itree.c
> @@ -145,6 +145,8 @@ static int alloc_branch(struct inode *inode,
>  		 */
>  		parent = block_to_cpu(SYSV_SB(inode->i_sb), branch[n-1].key);
>  		bh = sb_getblk(inode->i_sb, parent);
> +		if (!bh)
> +			break;

How have you tested this?  Have you reproduced this failure and has this
patch resolved the issue?  This function should never really fail in
normal operation, so it's odd that you were able to hit this somehow.

thanks,

greg k-h
