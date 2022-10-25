Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A940F60CF32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 16:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiJYOhJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 10:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbiJYOgQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:36:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0B3170B5F;
        Tue, 25 Oct 2022 07:36:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFB40B81D53;
        Tue, 25 Oct 2022 14:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44033C433D6;
        Tue, 25 Oct 2022 14:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666708571;
        bh=L0xnnC6VqXOdL3SosPrum6FZh21guGBKfx7TXhf1718=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rd/jg1hOaGlFnyDN+QFJTJbNzPKD7jbtGwpWnXf2DwgjP6zXe5itYXEW+rR5/wQvp
         skoXlF+E8WgB69+du3MRe45/kVR3WyAiR1JST1tzQN2mVaMvSNPq4nX2jUD4Kp9n/Z
         mOIwemacY2Bg4dQnoOrA7I3x/K+utPzT6d48K096JBUOVEeMuy2166AEX/ebkdEaWu
         cMdz/t6FjYDkhz8Nc5vT0kCTM4N7v4BgHojOfvsEQwm7s9Ppi/PtZsKSfs3uHLLK6y
         nbrTKawgu7Azcd9lKoaJxiKrh7W0srRzpHMhO/sXWANUF4QZbZOvznGUf03/pVMpnT
         vnQBFMO1gb3Cg==
Date:   Tue, 25 Oct 2022 16:36:07 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     viro@zeniv.linux.org.uk, neilb@suse.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: Make vfs_get_super() internal
Message-ID: <20221025143607.frmf3qg7j4kwezll@wittgenstein>
References: <TYCP286MB2323D37F4F6400FD07D7C7F7CA319@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TYCP286MB2323D37F4F6400FD07D7C7F7CA319@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 25, 2022 at 10:24:01PM +0800, Dawei Li wrote:
> For now there are no external callers of vfs_get_super(),
> so just make it an internal API.
> 
> base-commit: 3aca47127a646165965ff52803e2b269eed91afc
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>  fs/super.c                 | 3 +--
>  include/linux/fs_context.h | 4 ----
>  2 files changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 6a82660e1adb..cde412f900c7 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1136,7 +1136,7 @@ static int test_single_super(struct super_block *s, struct fs_context *fc)
>   * A permissions check is made by sget_fc() unless we're getting a superblock
>   * for a kernel-internal mount or a submount.
>   */
> -int vfs_get_super(struct fs_context *fc,
> +static int vfs_get_super(struct fs_context *fc,
>  		  enum vfs_get_super_keying keying,
>  		  int (*fill_super)(struct super_block *sb,
>  				    struct fs_context *fc))

If you want to make it static that you should probably also make enum
vfs_get_super_keying static by moving it into super.c. It's not used
anywhere but for vfs_get_super() afaict.
