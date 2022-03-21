Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C479E4E264B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 13:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347295AbiCUM3h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 08:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347307AbiCUM3c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:29:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F8E2B3;
        Mon, 21 Mar 2022 05:28:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BB0FB81367;
        Mon, 21 Mar 2022 12:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B3CC340E8;
        Mon, 21 Mar 2022 12:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647865683;
        bh=0GgEVLZEduZDLqniMFRxYsbQL46moysVsgQVneO8NkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wie7nCEssTqxXqI5wBnZnWyrWYWuyca9GZ/7td8VFJSIxLxNXthlS7tf7MSD8bnAU
         obpH2JvimckATJoMTmLIzVYcSbVFz6EhaJRlIba5pQ3wJ7ssoHOUvpBQZ7DWgE5LPV
         IZ2j6TIML1mikP2MA+rNOSBBs5PJWX6WR1zx4Vlo=
Date:   Mon, 21 Mar 2022 13:28:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Carlos Llamas <cmllamas@google.com>,
        Alessio Balsini <balsini@android.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fuse: fix integer type usage in uapi header
Message-ID: <YjhvULpvl6LUZI0Z@kroah.com>
References: <20220318171405.2728855-1-cmllamas@google.com>
 <CAJfpegsT6BO5P122wrKbni3qFkyHuq_0Qq4ibr05_SOa7gfvcw@mail.gmail.com>
 <Yjfd1+k83U+meSbi@google.com>
 <CAJfpeguoFHgG9Jm3hVqWnta3DB6toPRp_vD3EK74y90Aj3w+8Q@mail.gmail.com>
 <Yjg8TVQZ6TeTSQxj@kroah.com>
 <CAJfpegsj94__xdBe8aH+VFdY5fJg515vG0XY-Qu0RXwEAUhM3A@mail.gmail.com>
 <YjhM9UMKs+1H8eIe@kroah.com>
 <CAJfpegtpHLjL3fEu+CciBdkOptk23jV2qKCMc4AwEjgmASgbBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtpHLjL3fEu+CciBdkOptk23jV2qKCMc4AwEjgmASgbBA@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 21, 2022 at 12:25:27PM +0100, Miklos Szeredi wrote:
> On Mon, 21 Mar 2022 at 11:01, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Mar 21, 2022 at 10:36:20AM +0100, Miklos Szeredi wrote:
> > > On Mon, 21 Mar 2022 at 09:50, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Mon, Mar 21, 2022 at 09:40:56AM +0100, Miklos Szeredi wrote:
> > > > > On Mon, 21 Mar 2022 at 03:07, Carlos Llamas <cmllamas@google.com> wrote:
> > > > > >
> > > > > > On Fri, Mar 18, 2022 at 08:24:55PM +0100, Miklos Szeredi wrote:
> > > > > > > On Fri, 18 Mar 2022 at 18:14, Carlos Llamas <cmllamas@google.com> wrote:
> > > > > > > >
> > > > > > > > Kernel uapi headers are supposed to use __[us]{8,16,32,64} defined by
> > > > > > > > <linux/types.h> instead of 'uint32_t' and similar. This patch changes
> > > > > > > > all the definitions in this header to use the correct type. Previous
> > > > > > > > discussion of this topic can be found here:
> > > > > > > >
> > > > > > > >   https://lkml.org/lkml/2019/6/5/18
> > > > > > >
> > > > > > > This is effectively a revert of these two commits:
> > > > > > >
> > > > > > > 4c82456eeb4d ("fuse: fix type definitions in uapi header")
> > > > > > > 7e98d53086d1 ("Synchronize fuse header with one used in library")
> > > > > > >
> > > > > > > And so we've gone full circle and back to having to modify the header
> > > > > > > to be usable in the cross platform library...
> > > > > > >
> > > > > > > And also made lots of churn for what reason exactly?
> > > > > >
> > > > > > There are currently only two uapi headers making use of C99 types and
> > > > > > one is <linux/fuse.h>. This approach results in different typedefs being
> > > > > > selected when compiling for userspace vs the kernel.
> > > > >
> > > > > Why is this a problem if the size of the resulting types is the same?
> > > >
> > > > uint* are not "valid" variable types to cross the user/kernel boundary.
> > > > They are part of the userspace variable type namespace, not the kernel
> > > > variable type namespace.  Linus wrong a long post about this somewhere
> > > > in the past, I'm sure someone can dig it up...
> > >
> > > Looking forward to the details.  I cannot imagine why this would matter...
> >
> > Here's the huge thread on the issue:
> >         https://lore.kernel.org/all/19865.1101395592@redhat.com/
> > and specifically here's Linus's answer:
> >         https://lore.kernel.org/all/Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org/
> >
> > The whole thread is actually relevant for this .h file as well.  Some
> > things never change :)
> 
> "- the kernel should not depend on, or pollute user-space naming.
>   YOU MUST NOT USE "uint32_t" when that may not be defined, and
>   user-space rules for when it is defined are arcane and totally
>   arbitrary."
> 
> The "pollutes user space naming" argument is bogus for fuse, since
> application are using the library interface, which doesn't pull in the
> kernel headers but redefines everything that needs to be shared.   BTW
> this seems to be the pattern for libc interfaces as well, though I
> haven't looked closely.
> 
> On the other hand, if we change the types back to __u32 etc, then that
> will mess with the history.  I think the disadvantages outweigh the
> advantages, so unless some stronger argument comes up  it's NACK from
> me.

As this .h file is only 1 of 3 .h files using these variable types, I
think you are wrong and should go along with the rest of the kernel api
style.

greg k-h
