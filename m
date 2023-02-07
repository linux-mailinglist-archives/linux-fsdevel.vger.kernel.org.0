Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC9068DF8C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 19:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjBGSEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 13:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBGSEu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:04:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47103C37;
        Tue,  7 Feb 2023 10:04:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E89E6CE1DF8;
        Tue,  7 Feb 2023 18:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E2FC433EF;
        Tue,  7 Feb 2023 18:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675793086;
        bh=0VKQjQe3KQPYT8I06awoNqRWHvEBpTHUM2gBgH+dJSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZYwaqJlBHig9pGugf90EYJfVdpnBpKabm3D56UMPURs6dquPFL57mxG4z7Jaeu9eC
         ohWjrDbOy85u3OT7rxQumcLwiSwBtyna0IPICP34vj2deCfwdGftyekEc+Uo7TqUXO
         PrlBrw0yLrkOsoPBD083QTn8hLrCpFHIZHgArzd4KpboKZlKgqvam/uwgGAV+EqLoW
         siBw2bO3yd2PB2DgdLb60Cd3pieRzPTwwdbZA0O9els/8DfKqFryg3pDa4ZSaJ00ie
         6wZyweikC+523F09krogC9Xy2BX7YHAeZRoQRPwMRFf6cYXN6q9esVUHltGsNQDIlv
         pAPSn4Eso2MwQ==
Date:   Tue, 7 Feb 2023 18:04:44 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: remove obsolete comments on member ordering of
 random layout struct
Message-ID: <Y+KSvGl1rPYbMFar@gmail.com>
References: <TYCP286MB2323C8F54CB121755B83F5D9CADB9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB2323C8F54CB121755B83F5D9CADB9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 07, 2023 at 09:14:08PM +0800, Dawei Li wrote:
> Structures marked with __randomize_layout are supposed to reorder layout
> of members randomly. Although layout is not guranteed to be reordered
> since dependency on hardening config, but let's not make assumption such
> as "member foo is first".
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>  include/linux/fs.h | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c1769a2c5d70..9114c4e44154 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -585,11 +585,6 @@ is_uncached_acl(struct posix_acl *acl)
>  
>  struct fsnotify_mark_connector;
>  
> -/*
> - * Keep mostly read-only and often accessed (especially for
> - * the RCU path lookup and 'stat' data) fields at the beginning
> - * of the 'struct inode'
> - */
>  struct inode {
>  	umode_t			i_mode;
>  	unsigned short		i_opflags;
> @@ -1471,7 +1466,7 @@ struct sb_writers {
>  };
>  
>  struct super_block {
> -	struct list_head	s_list;		/* Keep this first */
> +	struct list_head	s_list;

If these comments are just talking about how the fields are arranged for best
performance (the inode comment definitely is; the super_block one is a bit
ambiguous), rather than for correctness, they are perfectly fine to keep.  It
still makes sense to do those sort of manual structure layout optimizations on
commonly used structures like these, because they still benefit everyone who
doesn't have CONFIG_RANDSTRUCT enabled (i.e., almost everyone).

- Eric
