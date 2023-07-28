Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B748766B0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 12:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbjG1Kva (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 06:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbjG1Kv3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:51:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE45019B6;
        Fri, 28 Jul 2023 03:51:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B33E620DA;
        Fri, 28 Jul 2023 10:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A64EC433C8;
        Fri, 28 Jul 2023 10:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690541487;
        bh=E4KGSR6GkAndxuU2Aa+9XEtnvO90z/FTuRBymxeho50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cGFJDR9w0JqyMrOp6qnBtT6KTjeMFRZddjBvEfLiLldS6j7ki7uYRkV/IOkCGGFVR
         xAIP/3Qqt0ISv6gzNv6A5uWIoYIXQ8569T630PVHlsNKCTOorhnq8GWo/XYEaq6MmR
         7/Ov8F4m/P/0eMqDGJWGKEIv/3V658aAtUgSQjEiQUliqxcWiG1UBGMGXhgpuctEtF
         HxwybgjvNM2H16FCY/4/iDfibyIs9vISEdRNyqchK2gYFCyiJN7SXGstDKM8mQrBg6
         pTOVjehsNIoyCJTtWAHHIl4SBksfYSmWXSZxWdnttw1o7tYAX/ajuc/BsS2mfuH0A7
         4jlcTIGZXyCIA==
Date:   Fri, 28 Jul 2023 12:51:22 +0200
From:   Simon Horman <horms@kernel.org>
To:     Joel Granados <j.granados@samsung.com>
Cc:     mcgrof@kernel.org, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, willy@infradead.org,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 05/14] sysctl: Add a size arg to __register_sysctl_table
Message-ID: <ZMOdqvMfyPkNYBoq@kernel.org>
References: <20230726140635.2059334-1-j.granados@samsung.com>
 <CGME20230726140656eucas1p26cd9da21663d25b51dda75258aaa3b55@eucas1p2.samsung.com>
 <20230726140635.2059334-6-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726140635.2059334-6-j.granados@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 26, 2023 at 04:06:25PM +0200, Joel Granados wrote:
> This is part of the effort to remove the sentinel element in the
> ctl_table arrays. We add a table_size argument to
> __register_sysctl_table and adjust callers, all of which pass ctl_table
> pointers and need an explicit call to ARRAY_SIZE.
> 
> The new table_size argument does not yet have any effect in the
> init_header call which is still dependent on the sentinel's presence.
> table_size *does* however drive the `kzalloc` allocation in
> __register_sysctl_table with no adverse effects as the allocated memory
> is either one element greater than the calculated ctl_table array (for
> the calls in ipc_sysctl.c, mq_sysctl.c and ucount.c) or the exact size
> of the calculated ctl_table array (for the call from sysctl_net.c and
> register_sysctl). This approach will allows us to "just" remove the
> sentinel without further changes to __register_sysctl_table as
> table_size will represent the exact size for all the callers at that
> point.
> 
> Temporarily implement a size calculation in register_net_sysctl, which
> is an indirection call for all the network register calls.
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  fs/proc/proc_sysctl.c  | 22 +++++++++++-----------
>  include/linux/sysctl.h |  2 +-
>  ipc/ipc_sysctl.c       |  4 +++-
>  ipc/mq_sysctl.c        |  4 +++-
>  kernel/ucount.c        |  3 ++-
>  net/sysctl_net.c       |  8 +++++++-
>  6 files changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index fa1438f1a355..8d04f01a89c1 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -1354,27 +1354,20 @@ static struct ctl_dir *sysctl_mkdir_p(struct ctl_dir *dir, const char *path)
>   */
>  struct ctl_table_header *__register_sysctl_table(
>  	struct ctl_table_set *set,
> -	const char *path, struct ctl_table *table)
> +	const char *path, struct ctl_table *table, size_t table_size)

Hi Joel,

Please consider adding table_size to the kernel doc for this function.

...
