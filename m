Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59B34E2288
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 09:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345463AbiCUIvv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 04:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344531AbiCUIvu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:51:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403353669A;
        Mon, 21 Mar 2022 01:50:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C340861158;
        Mon, 21 Mar 2022 08:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87298C340E8;
        Mon, 21 Mar 2022 08:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647852625;
        bh=BILM29Vz9Uzyjt1P4yCjGxvGQNz4xIpQPbvuVj+CJNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gwjQS8/v7pxCCz6xYSKlbvTQ3ICRioXfWlF/cJwei6zLWr9YqnBT3aAgF3VI/SwF2
         kJG/ZDezwlHYjr0BXKKuMb6mRaRw+E96xndf4QZfxpydbnxA7wTw48y7nr9MY/nOrs
         jFvPksMrvWZdqPuKu7IYs49e7qiL4epo2X23nJcA=
Date:   Mon, 21 Mar 2022 09:50:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Carlos Llamas <cmllamas@google.com>,
        Alessio Balsini <balsini@android.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fuse: fix integer type usage in uapi header
Message-ID: <Yjg8TVQZ6TeTSQxj@kroah.com>
References: <20220318171405.2728855-1-cmllamas@google.com>
 <CAJfpegsT6BO5P122wrKbni3qFkyHuq_0Qq4ibr05_SOa7gfvcw@mail.gmail.com>
 <Yjfd1+k83U+meSbi@google.com>
 <CAJfpeguoFHgG9Jm3hVqWnta3DB6toPRp_vD3EK74y90Aj3w+8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguoFHgG9Jm3hVqWnta3DB6toPRp_vD3EK74y90Aj3w+8Q@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 21, 2022 at 09:40:56AM +0100, Miklos Szeredi wrote:
> On Mon, 21 Mar 2022 at 03:07, Carlos Llamas <cmllamas@google.com> wrote:
> >
> > On Fri, Mar 18, 2022 at 08:24:55PM +0100, Miklos Szeredi wrote:
> > > On Fri, 18 Mar 2022 at 18:14, Carlos Llamas <cmllamas@google.com> wrote:
> > > >
> > > > Kernel uapi headers are supposed to use __[us]{8,16,32,64} defined by
> > > > <linux/types.h> instead of 'uint32_t' and similar. This patch changes
> > > > all the definitions in this header to use the correct type. Previous
> > > > discussion of this topic can be found here:
> > > >
> > > >   https://lkml.org/lkml/2019/6/5/18
> > >
> > > This is effectively a revert of these two commits:
> > >
> > > 4c82456eeb4d ("fuse: fix type definitions in uapi header")
> > > 7e98d53086d1 ("Synchronize fuse header with one used in library")
> > >
> > > And so we've gone full circle and back to having to modify the header
> > > to be usable in the cross platform library...
> > >
> > > And also made lots of churn for what reason exactly?
> >
> > There are currently only two uapi headers making use of C99 types and
> > one is <linux/fuse.h>. This approach results in different typedefs being
> > selected when compiling for userspace vs the kernel.
> 
> Why is this a problem if the size of the resulting types is the same?

uint* are not "valid" variable types to cross the user/kernel boundary.
They are part of the userspace variable type namespace, not the kernel
variable type namespace.  Linus wrong a long post about this somewhere
in the past, I'm sure someone can dig it up...

thanks,

greg k-h
