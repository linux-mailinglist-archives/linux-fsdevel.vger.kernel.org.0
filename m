Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766B8766B20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 12:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbjG1K4o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 06:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbjG1K4n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:56:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4989A2682;
        Fri, 28 Jul 2023 03:56:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94EB262089;
        Fri, 28 Jul 2023 10:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671D3C433C8;
        Fri, 28 Jul 2023 10:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690541801;
        bh=/nWjw3Rqh2Q1Nlskkcd3rRe8h6y+YfC7niET4DyAxls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XS6RB/nBpd5uAUwSBDW6J5mGOPm75YnDf7w9iAynklPCUEscE7YkCyEJi7iwG0Jvk
         0TJDjq6xVATLpe2VqhjwD+V3GhBDOEGdE7LvyDeu8r5KFiIriCDRdmsXyX9tKOJ5vG
         nTEvVC2gG9Y75IgGLryyBI/5OLFXLmXe3iHtvJ1q2tFBTd57PxYAvMe4XM4Cf99mxX
         PkmtS2Y4FIuGAkZqZCP84XBf2Y7R5Iv+/UL+kN4LVQbgXGn/Byykm5mftPONAOI0G9
         DDfQJ4diVPibEKBIXaDz8IRCu867boKiS3wIflbOS82D6Z+FTgRCC+TJxFKr+/NqKI
         tz7zpi6x5vGSA==
Date:   Fri, 28 Jul 2023 12:56:36 +0200
From:   Simon Horman <horms@kernel.org>
To:     Joel Granados <j.granados@samsung.com>
Cc:     mcgrof@kernel.org, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, willy@infradead.org,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/14] sysctl: Add size arg to __register_sysctl_init
Message-ID: <ZMOe5FE3VETYsmdX@kernel.org>
References: <20230726140635.2059334-1-j.granados@samsung.com>
 <CGME20230726140700eucas1p1e6b16e884362ebec50f6712b3f11a533@eucas1p1.samsung.com>
 <20230726140635.2059334-8-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726140635.2059334-8-j.granados@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 26, 2023 at 04:06:27PM +0200, Joel Granados wrote:
> This is part of the effort to remove the sentinel element from the
> ctl_table array at register time. We add a size argument to
> __register_sysctl_init and modify the register_sysctl_init macro to
> calculate the array size with ARRAY_SIZE. The original callers do not
> need to be updated as they will go through the new macro.
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  fs/proc/proc_sysctl.c  | 11 ++---------
>  include/linux/sysctl.h |  5 +++--
>  2 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index c04293911e7e..6c0721cd35f3 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -1444,16 +1444,9 @@ EXPORT_SYMBOL(register_sysctl_sz);
>   * Context: if your base directory does not exist it will be created for you.
>   */
>  void __init __register_sysctl_init(const char *path, struct ctl_table *table,
> -				 const char *table_name)
> +				 const char *table_name, size_t table_size)

Hi Joel,

in the same vein as my comment on another patch.
Please add table_size to the kernel doc for this function.
