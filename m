Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637B275101B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 19:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjGLR4X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 13:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGLR4W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:56:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BFF12F;
        Wed, 12 Jul 2023 10:56:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 152FC618A2;
        Wed, 12 Jul 2023 17:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC266C433C7;
        Wed, 12 Jul 2023 17:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689184580;
        bh=bWk+oZ6OvAgtqrgCnXCIUq3C2AK6O81HD5L4eLgEjKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=spnu5oTadwOaAzuH81ZsuV041schpQNuk1BUH8+KXptqhYMjcZGn3kCTg6Hc8/qmt
         ySRNj4UPFUl3YyE0Hh0dCqzxk57D/34kE2GizMPAN9ZD+68xSgsedXK1YxRYDZ/3h8
         xYUbuD6tJcy2FGdPgJpFZU1wu2MnxNDs/QClnKEEPO7nndglsPE5h/HxKK45h38Z0t
         Gl+yXD1F0NSUKh9TlSUZcLNJLrdsvjwngaQQAxOin4xaXVdowZm+k9h7geYYR3lo9o
         8M61rZm61UgHbJjF1xFv1jLLjMSXTjYNevLcrAV5zPIbKLKW7pa7HBb4SUc4HoJ5Qh
         Z6lWfBbVBTK5A==
Date:   Wed, 12 Jul 2023 19:56:15 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Florian Weimer <fweimer@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org
Subject: Re: [PATCH] attr: block mode changes of symlinks
Message-ID: <20230712-kresse-getragen-736c8d675979@brauner>
References: <20230712-vfs-chmod-symlinks-v1-1-27921df6011f@kernel.org>
 <CAHk-=whypK=-91QfDpd3PWwazx35iWT=ooKLxhbeTAwJL_WXVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whypK=-91QfDpd3PWwazx35iWT=ooKLxhbeTAwJL_WXVg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 12, 2023 at 09:24:43AM -0700, Linus Torvalds wrote:
> On Wed, 12 Jul 2023 at 02:56, Christian Brauner <brauner@kernel.org> wrote:
> >
> > Changing the mode of symlinks is meaningless as the vfs doesn't take the
> > mode of a symlink into account during path lookup permission checking.
> 
> Hmm. I have this dim memory that we actually used to do that as an
> extension at one point for the symlinks in /proc. Long long ago.

If we block it properly now. We could - crazy talk on my side now:
through a sysctl like the weird sysctl sysctl_protected_* stuff we have
already - later implement taking the mode of symlinks into account
properly. I'm not saying we should nor that it's wise but it would be
doable.

> 
> Or maybe it was just a potential plan.
> 
> Because at least in /proc, the symlinks *do* have protection semantics
> (ie you can't do readlink() on them or follow them without the right
> permissions.
> 
> That said, blocking the mode setting sounds fine, because the proc
> permissions are basically done separately.
> 
> However:
> 
> >         if ((ia_valid & ATTR_MODE)) {
> > +               if (S_ISLNK(inode->i_mode))
> > +                       return -EOPNOTSUPP;
> > +
> >                 umode_t amode = attr->ia_mode;
> 
> The above is not ok. It might compile these days because we have to
> allow statements before declarations for other reasons, but that
> doesn't make it ok.

Sorry, I completely missed that. I miss the days when that would've
thrown a compile error right away. Let me send a v2 right now.
