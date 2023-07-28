Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B19C766AFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 12:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbjG1Ksm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 06:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbjG1Ksi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:48:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FED919B6;
        Fri, 28 Jul 2023 03:48:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C16C6620DE;
        Fri, 28 Jul 2023 10:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3E6C433C8;
        Fri, 28 Jul 2023 10:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690541316;
        bh=Ua3Nq6ErGR02ZKzEq2FJx72D5cYGNbW8Cmy7BoDjPAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XOd/EpcNBPP/niX953VLgFzat1P9RgReSHB0gx9zv7anYC1NXoaSfcQdlzVeqdCR8
         JVOa4fRN9P5JtI6eCeoc+FRe+kv+Z26K8nGA3pgbvK3Z2Rmvzn858CSR7LadVUbGKS
         s2XDXRzQr+9itqFp0Uw5UWtVM7OLEufWypIVwuf+EiE4NfdkTFKUKPHzbWnTTnFgso
         8mgYiWqpqqk5UokkEopcp2VhXRtHg3SvOE0kmZWeuiUtI0ifIYUST8dlreFfQVOaIE
         UoxSlDmHW/zI5FyYfSUDrpQSLgRo5mgRo6e6GNDhL/mAvT1gQpYH9XCnn5D7LxzyyF
         Nmi3B0FJA5v3w==
Date:   Fri, 28 Jul 2023 12:48:31 +0200
From:   Simon Horman <horms@kernel.org>
To:     Joel Granados <j.granados@samsung.com>
Cc:     mcgrof@kernel.org, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, willy@infradead.org,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/14] sysctl: Add ctl_table_size to ctl_table_header
Message-ID: <ZMOc/+Q0PT48ed0G@kernel.org>
References: <20230726140635.2059334-1-j.granados@samsung.com>
 <CGME20230726140653eucas1p2e234b7cd0af5dc506bd27399b84292a6@eucas1p2.samsung.com>
 <20230726140635.2059334-4-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726140635.2059334-4-j.granados@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 26, 2023 at 04:06:23PM +0200, Joel Granados wrote:
> The new ctl_table_size element will hold the size of the ctl_table
> contained in the header. This value is passed by the callers to the
> sysctl register infrastructure.
> 
> This is a preparation commit that allows us to systematically add
> ctl_table_size and start using it only when it is in all the places
> where there is a sysctl registration.
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  include/linux/sysctl.h | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 59d451f455bf..33252ad58ebe 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -159,12 +159,22 @@ struct ctl_node {
>  	struct ctl_table_header *header;
>  };
>  
> -/* struct ctl_table_header is used to maintain dynamic lists of
> -   struct ctl_table trees. */
> +/**
> + * struct ctl_table_header - maintains dynamic lists of struct ctl_table trees
> + * @ctl_table: pointer to the first element in ctl_table array
> + * @ctl_table_size: number of elements pointed by @ctl_table
> + * @used: The entry will never be touched when equal to 0.
> + * @count: Upped every time something is added to @inodes and downed every time
> + *         something is removed from inodes
> + * @nreg: When nreg drops to 0 the ctl_table_header will be unregistered.
> + * @rcu: Delays the freeing of the inode. Introduced with "unfuck proc_sysctl ->d_compare()"
> + *
> + */

Please consider documenting all fields of struct ctl_table_header.
./scripts/kernel-doc complains that the following are missing:

  unregistering
  ctl_table_arg
  root
  set
  parent
  node
  inodes
