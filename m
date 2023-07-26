Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5FB7636E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 14:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjGZM50 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 08:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjGZM5X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:57:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBB81BF2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 05:57:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECE9861789
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 12:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55118C433C8;
        Wed, 26 Jul 2023 12:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690376239;
        bh=vbjgSKtf90eTsPm3Ahs2u639/D2tSVA9b8bVL9FUXIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A+jbMuwozmIBmoknXptKYOCIL1HxcIfZCXwKXZsRs8EzTF4X7X7us5plsWnpQ+fVO
         ISfxyuRyZmuUdJxhmA5bnf8EEjq4LSxisSxAjvwMgWYqt1QE7qMyT1PFhADzuSQlcm
         z6eOex/k9rGBryCaL0pOiJxhDUEcFcv9jY+AxcISJqBaQEym5dlwHXAmAtkb4vGSd1
         BSk4ngpMQBgdakC4p4tju5LQ5OMQu1WVSha211J8Jy+l8HHYvfuwXtYTkXa8mFaDxI
         58Ip7bsN7+tTjYLCm/eistShmATor+doRQvD8G9GOFpWzhl6uQ27/9gx2aeDq9QGkS
         g06TO1oUCHjog==
Date:   Wed, 26 Jul 2023 14:57:15 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     viro@zeniv.linux.org.uk, jack@suse.cz,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: open the block device after allocation the
 super_block
Message-ID: <20230726-gurken-weltall-ddaa4e42fbdb@brauner>
References: <20230724175145.201318-1-hch@lst.de>
 <20230725-tagebuch-gerede-a28f8fd8084a@brauner>
 <20230725-einnahmen-warnschilder-17779aec0a97@brauner>
 <20230726125106.GA14306@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230726125106.GA14306@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 26, 2023 at 02:51:06PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 25, 2023 at 06:32:05PM +0200, Christian Brauner wrote:
> > I've removed the references to bind mounts from the commit message.
> > I mentioned in [1] and [2] that this problem is really related to
> > superblocks at it's core. It's just that technically a bind-mount would
> > be created in the following scenario where two processes race to create
> > a superblock:
> 
> I wanted to keep some of Jan's original logic.  In the end a bind mount
> is just one of many reuses of a super block so I think your updated
> log is fine.
> 
> Btw, it might make sense to place this on a separate branch, and Jan's
> block work will have to pull it in, and it might be good to not
> require the entire vfs misc tree to be pult in.

Ok, now on the vfs.super branch.
