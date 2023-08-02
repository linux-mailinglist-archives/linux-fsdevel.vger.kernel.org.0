Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7876076C697
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 09:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjHBHVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 03:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbjHBHUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:20:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368AC19A0
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 00:20:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 151A061840
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 07:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8409C433C7;
        Wed,  2 Aug 2023 07:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690960837;
        bh=NnEYqfjE58O3XZiPDkp9YFQv07X+rTaM6Y4z+XJarwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TKF2bXhwBBp/9w2sm78JVynRRtSjsHMd6KbOuRghZ1lyzAYw4CFFDpQs+8So0WOcT
         zbvE3jneoyfl8KyEI67L6mzT4Oik5CtIRhCo0K19PrsU52MEwh4mEcBtRs9/wf0sDB
         15yrJAYQZR9Ii48YWRirO+0Z7jpkhmZ61sHQs5qzsjWpvYgONUu2FC62Rmb9mHU5tl
         ldR/7zSgncbnHkgDPuYiIbR3NhMb9WGVFFwnu1uhPNrv28nNn6jlhCP6wL1kEPT7fE
         Mozr0Vh7XMccDnaYDRqQbFzNue7IADKCoJXH15yckZFiHnr2kkUHPSIwEtXiG8IDIz
         dbTQQ2dM9sQOg==
Date:   Wed, 2 Aug 2023 09:20:28 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] super: remove get_tree_single_reconf()
Message-ID: <20230802-zettel-krempel-7094d4718ab1@brauner>
References: <20230801-vfs-super-exclusive-v1-0-1a587e56c9f3@kernel.org>
 <20230801-vfs-super-exclusive-v1-1-1a587e56c9f3@kernel.org>
 <20230801153100.GB12035@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230801153100.GB12035@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 05:31:00PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 01, 2023 at 03:09:00PM +0200, Christian Brauner wrote:
> > The get_tree_single_reconf() helper isn't used anywhere. Remote it.
> 
> Yeah, I've got pretty much the same patch hiding somewhere in one of
> me trees..
> 
> > -static int vfs_get_super(struct fs_context *fc, bool reconf,
> > -		int (*test)(struct super_block *, struct fs_context *),
> > -		int (*fill_super)(struct super_block *sb,
> > -				  struct fs_context *fc))
> > +static int vfs_get_super(struct fs_context *fc,
> > +			 int (*test)(struct super_block *, struct fs_context *),
> > +			 int (*fill_super)(struct super_block *sb,
> > +					   struct fs_context *fc))
> 
> .a althought keeping the existing formatting here seems much more readable
> to me.  No idea why the odd align to brace formatting has picked up so
> many fans recently given that it is horrible to read and causes tons
> of churn when touching the protoptype or function name.

I'm not doing that manually. I'm using clang-format for this so I don't
have to care about stuff like this.

Tbh, the fact that we don't simply have an authoritative code formatting
tool in-kernel over 30 years later that we settle on - at least on a per
subsystem basis - is funny and sad.

I'm fine not touching the header.
