Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D5A767C11
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jul 2023 06:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjG2EUx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jul 2023 00:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjG2EUw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jul 2023 00:20:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88497420C;
        Fri, 28 Jul 2023 21:20:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22FF1608C4;
        Sat, 29 Jul 2023 04:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3534EC433C8;
        Sat, 29 Jul 2023 04:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690604450;
        bh=YIBg8ak2NqRa88/sTJp0e/BBEXgBNmBM+mfnhMOzXG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EJ4rvZXkVfWvq6nmBVNai9EM9SQ8yhZZOS9uwKZYDy0igRd3ecA0PZMCP9acOGCE6
         mjhic6G4xsE1W0OxsNoARN3gq3hsmfvJ8B9wXnLNAJywgXNqht3wvO6LrHUbQLWSQg
         rdNY5KK7UFnAFlBrUFxmc20eaStE0+4Ge6+IR3TncVKSB1ebw8S5uz+Pjb2UyzUMja
         nbYR0uFc+1p6LGca0DcAJX5IaCdpD8RK5abIy1OlFHoky9to4BgwaSNSMsef4QvjZP
         WrBFveCdSbNfsi2jQklcEk4cYxjNZ5ClQPi+r/kYaDYVp+BbTTXZ+HMc0eMbAcEsfd
         61jY+FK/3U0yg==
Date:   Fri, 28 Jul 2023 21:20:48 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v4 3/7] libfs: Validate negative dentries in
 case-insensitive directories
Message-ID: <20230729042048.GB4171@sol.localdomain>
References: <20230727172843.20542-1-krisman@suse.de>
 <20230727172843.20542-4-krisman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727172843.20542-4-krisman@suse.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 01:28:39PM -0400, Gabriel Krisman Bertazi wrote:
>   - In __lookup_slow, either the parent inode is read locked by the
>     caller (lookup_slow), or it is called with no flags (lookup_one*).
>     The read lock suffices to prevent ->d_name modifications, with the
>     exception of one case: __d_unalias, will call __d_move to fix a
>     directory accessible from multiple dentries, which effectively swaps
>     ->d_name while holding only the shared read lock.  This happens
>     through this flow:
> 
>     lookup_slow()  //LOOKUP_CREATE
>       d_lookup()
>         ->d_lookup()
>           d_splice_alias()
>             __d_unalias()
>               __d_move()
> 
>     Nevertheless, this case is not a problem because negative dentries
>     are not allowed to be moved with __d_move.

Isn't it possible for a negative dentry to become a positive one concurrently?

- Eric
