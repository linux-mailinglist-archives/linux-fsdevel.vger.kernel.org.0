Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3607375318B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 07:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbjGNFz0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 01:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjGNFzV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:55:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C1A2123;
        Thu, 13 Jul 2023 22:55:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13E1D61C2A;
        Fri, 14 Jul 2023 05:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC76C433C7;
        Fri, 14 Jul 2023 05:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689314119;
        bh=IXG6OKn01yJj0TE1xVyNQVVP2cgIJ84xsyC/CW0XIaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lNSPH9QfHOdM9FO2SngD10EMxHIkKS12TAD6XmT2erE4WSzUHeNZqG1g7ORyq9Ptc
         Wc7RRfwHvx/wbR5WolW+1AXcbpMN09Y3E/WXLvIdB34yAaMhs9YktbrqvSGTCKTKKl
         6XZuOTEeIQsVog29Cz2aPr0e50H4Qxk7DlNn/9O6OZdN2w9+USiaxuK1FjyuX7Mowp
         VOJpP2p+PuN9wgFUJhrU4aTJbs5cFsg0224yfp8ayO73ubM67xA4jKtUDGoFT824fK
         Dq6P8F3ZmDt6Rwle9l0TAQQZE7eH5nZHHj29VmmGWjvMa7nTKF8WD/A8tvxWoW927/
         zeswo3tOfNpuQ==
Date:   Thu, 13 Jul 2023 22:55:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 2/7] fs: Add DCACHE_CASEFOLD_LOOKUP flag
Message-ID: <20230714055517.GG913@sol.localdomain>
References: <20230422000310.1802-1-krisman@suse.de>
 <20230422000310.1802-3-krisman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230422000310.1802-3-krisman@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 08:03:05PM -0400, Gabriel Krisman Bertazi wrote:
> @@ -209,6 +209,7 @@ struct dentry_operations {
>  #define DCACHE_FALLTHRU			0x01000000 /* Fall through to lower layer */
>  #define DCACHE_NOKEY_NAME		0x02000000 /* Encrypted name encoded without key */
>  #define DCACHE_OP_REAL			0x04000000
> +#define DCACHE_CASEFOLD_LOOKUP		0x08000000 /* Dentry comes from a casefold directory */
>  
>  #define DCACHE_PAR_LOOKUP		0x10000000 /* being looked up (with parent locked shared) */
>  #define DCACHE_DENTRY_CURSOR		0x20000000

The first time I read DCACHE_CASEFOLD_LOOKUP, I got the wrong impression, since
it uses _LOOKUP in a different way from DCACHE_PAR_LOOKUP.  DCACHE_PAR_LOOKUP
uses it to mean "dentry is currently being looked up", while
DCACHE_CASEFOLD_LOOKUP uses it to mean "dentry *was* looked up".

Maybe DCACHE_CASEFOLDED_NAME would be more logical?  That would follow
DCACHE_NOKEY_NAME.  (Also CASEFOLD => CASEFOLDED would be logical, I think.)

- Eric
