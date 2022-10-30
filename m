Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B37612C9F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Oct 2022 21:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJ3U2s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Oct 2022 16:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ3U2r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Oct 2022 16:28:47 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB83A185;
        Sun, 30 Oct 2022 13:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GjHcp/wdMbwEfGBYGedZOimxPCDQynRkjHeEm6VDjxY=; b=i8A+0CXCpFmEwaRWYLuk3I/7qh
        4rSg5bGpqNEWlx1autk6G5pN6F7UE6N41M0041G4TRIZKOrZnXCtG5maJ2HluqRWqNCKQ8gdyUR4w
        Mybf85r8I9Y4rALKoycInK0hKJAeERO+fp/sAKuVFqBe1wzkPq6Bih9bhoIFbXVGo24l+asWjQANM
        AYWtLsKwLgFZI6d5jYGPx1lo0sFVWXXv5Zt9HuO8U4QJdESYKo8oBkJN9YJ5FEsxmjiOexOnxtgZG
        mf4iEeOzJhaqj94XRE/cfWW+ALgfWNYemIdKVebNNgDiJkpWpyHEPygr1oQjD9l3iomyxJsrYiADV
        mKUbYThg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1opEv9-00GPxE-34;
        Sun, 30 Oct 2022 20:28:40 +0000
Date:   Sun, 30 Oct 2022 20:28:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     brauner@kernel.org, neilb@suse.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: Make vfs_get_super() internal
Message-ID: <Y17edxOrW81EBh1v@ZenIV>
References: <TYCP286MB23233CC984811CFD38F69BC1CA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB23233CC984811CFD38F69BC1CA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 30, 2022 at 09:06:08PM +0800, Dawei Li wrote:
> For now there are no external callers of vfs_get_super(),
> so just make it an internal API.
> 
> v1: https://lore.kernel.org/all/TYCP286MB2323D37F4F6400FD07D7C7F7CA319@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/
> 
> v2: move vfs_get_super_keying to super.c, as the suggestion
> from Christian Brauner.
> 
> base-commit: 3aca47127a646165965ff52803e2b269eed91afc
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>  fs/super.c                 | 13 +++++++++++--
>  include/linux/fs_context.h | 14 --------------
>  2 files changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 6a82660e1adb..24e31e458552 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1111,6 +1111,16 @@ static int test_single_super(struct super_block *s, struct fs_context *fc)
>  	return 1;
>  }
>  
> +/*
> + * sget() wrappers to be called from the ->get_tree() op.
> + */
> +enum vfs_get_super_keying {
> +	vfs_get_single_super,	/* Only one such superblock may exist */
> +	vfs_get_single_reconf_super, /* As above, but reconfigure if it exists */
> +	vfs_get_keyed_super,	/* Superblocks with different s_fs_info keys may exist */
> +	vfs_get_independent_super, /* Multiple independent superblocks may exist */
> +};

I would rather kill the "keying" thing completely.

Seriously, what does it buy us?  Consider e.g.
        return vfs_get_super(fc, vfs_get_independent_super, fill_super);
in get_tree_nodev().  If you expand vfs_get_super() there, you'll get
this:
{
        struct super_block *sb = sget_fc(fc, NULL, set_anon_super_fc);
        if (IS_ERR(sb))
                return PTR_ERR(sb);

        if (!sb->s_root) {
                int err = fill_super(sb, fc);
                if (unlikely(err)) {
                        deactivate_locked_super(sb);
			return err;
		}
                sb->s_flags |= SB_ACTIVE;
        }
	fc->root = dget(sb->s_root);
	return 0;
}

Sure, it's several lines long, but it's much easier to follow than
vfs_get_super().  And duplication between these vfs_get_super()
callers is, IMO, not worth eliminating...
