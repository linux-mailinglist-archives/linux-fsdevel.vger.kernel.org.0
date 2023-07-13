Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632FF7520D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 14:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbjGMMKc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 08:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjGMMKa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:10:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33486269F;
        Thu, 13 Jul 2023 05:10:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B86C561045;
        Thu, 13 Jul 2023 12:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DDEC433C7;
        Thu, 13 Jul 2023 12:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689250229;
        bh=D9pkBgTJsVy9wzntreGQ5cEydaCWdRG9KOblpsQ7xB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YcmrqQv3iQdWLMkTHd9dOPjOAsbBikoQ+YES48c69vtY1FnAvWHaf4WlhuKspY+LJ
         fJWdjOAC+jY4ka5L92La5JYLModBtoMcEEcULA+EucC9+kHMMgZQTjlvfbidO4CCUO
         DYweMkfShgmSB92/ornA5omva5HXPvJZjnuOi+OSSVf3LnBFDLLlIkOXnucizMiERd
         N1eH/LHhwC5yzshcyfPbi/TP/9KkYT8yXmaEB4bL8nDquhjMGO+ITDqlgtBz6gFEEB
         bORNE8N4sjIrbbkayMFUhHsVI3Jpn4IC5OduJ982v0WAUm95KLeotKBlvHkx7psyJC
         og7OOVduvDJBg==
Date:   Thu, 13 Jul 2023 14:10:24 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] attr: block mode changes of symlinks
Message-ID: <20230713-kennen-randvoll-a55bd59550ea@brauner>
References: <20230712-vfs-chmod-symlinks-v2-1-08cfb92b61dd@kernel.org>
 <20230713114029.GA23375@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230713114029.GA23375@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 13, 2023 at 01:40:29PM +0200, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> one minor nitpick below:
> 
> >  	if ((ia_valid & ATTR_MODE)) {
> > +		if (S_ISLNK(inode->i_mode))
> > +			return -EOPNOTSUPP;
> 
> Maybe some of the rationale on why we have this check from the commit
> log should go here?

I'll add a comment to the patch.
