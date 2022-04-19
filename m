Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074AA506FBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 16:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346997AbiDSOGV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 10:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346543AbiDSOGV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:06:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1151F396B1;
        Tue, 19 Apr 2022 07:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3556B819BA;
        Tue, 19 Apr 2022 14:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2536C385A7;
        Tue, 19 Apr 2022 14:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650377016;
        bh=tFAAs+fiYJ2BsZiyGNrhRo5R1A/suHSPfni/ubpjD7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kM2YxlsGmbliGkoVk+kdii1qyYQFWzN64NCescUWCKlxX0e/jHsQMFwYp6aGUFJti
         OuPUiHix3LVgMjiQ/q82Imej9B4osuruKNncgG92B/1GzzrudZrQm69ePkdPH0F9s3
         Zez6ZYfvKjW0fVkysaFyRefwdQJGBfzxyNGfP8xZCn9MO7ddM9y/WBRhMltrheIq4S
         tcLjr3nletIDq9AvMsq+kYN+B4zJ0pUwJcW2m7ADs2FMe4so+fbNFGSJz+SREFfHMN
         gtjkChCnr/jGYGWmTMlOzDmw1qqwuzJDxh62EzPCUvuyz0L1QfVDhMm1APeqASPm5W
         W107a1iSDBEHA==
Date:   Tue, 19 Apr 2022 16:03:30 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com, djwong@kernel.org,
        jlayton@kernel.org, ntfs3@lists.linux.dev, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v4 6/8] ntfs3: Use the same order for acl pointer check
 in ntfs_init_acl
Message-ID: <20220419140330.jogjwtdzy735j567@wittgenstein>
References: <1650368834-2420-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650368834-2420-6-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650368834-2420-6-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 19, 2022 at 07:47:12PM +0800, Yang Xu wrote:
> Like ext4 and other use ${fs}_init_acl filesystem, they all used the following
> style
> 
>        error = posix_acl_create(dir, &inode->i_mode, &default_acl, &acl);
>        if (error)
>                 return error;
> 
>         if (default_acl) {
>                 error = __ext4_set_acl(handle, inode, ACL_TYPE_DEFAULT,
>                                        default_acl, XATTR_CREATE);
>                 posix_acl_release(default_acl);
>         } else {
>                 inode->i_default_acl = NULL;
>         }
>         if (acl) {
>                 if (!error)
>                         error = __ext4_set_acl(handle, inode, ACL_TYPE_ACCESS,
>                                                acl, XATTR_CREATE);
>                 posix_acl_release(acl);
>         } else {
>                 inode->i_acl = NULL;
>         }
> 	...
> 
> So for the readability and unity of the code, adjust this order.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

Again, this patch is irrelevant to the main drive of this patch series
and it's sensitive enough as it is. Just drop it from this series and
upstream it separately to the relevant filesystem imho.
