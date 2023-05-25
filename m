Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF2B711998
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 23:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241996AbjEYVzK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 17:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241923AbjEYVzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 17:55:09 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA7312C;
        Thu, 25 May 2023 14:55:07 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d3bc0dce9so55285b3a.0;
        Thu, 25 May 2023 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685051707; x=1687643707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LbQCRta1Y9jbQW7prv57mERnTrGdSIJmBXQojqB73vg=;
        b=pbWH4QGdh0eZ5BhoWFAbimtwVSr5dFKasEjOv9jjhNBdAU6EGes6ukcV9zKfQWTXuL
         q4qvWBY5WF9mX7kYrOFW9n2dgKTCShheYn1vLGSQoXBBeLbTQBTiaBVAMC+puZJFgq/h
         CUq1r2Loqb0u716ScZuQM7w/kJ4hur5T7D+jirn1+eaIGIrYe9W3uqKJr141gcmpQbbV
         gXwKgNgwxHyCNwR604AEM+q/W2nIdZKdd09vlO7ZSX65O13xOSfyMQJYmzpF71BddTwQ
         EA1Mg1qKGJefuGGP9lsHRr7/Uemx6PmrpGSM0YVjG+kJJumFQniY8NUWYYQ1J1+tG2jL
         hP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685051707; x=1687643707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbQCRta1Y9jbQW7prv57mERnTrGdSIJmBXQojqB73vg=;
        b=W4o80LiiB5rSiid+1sZ6bVYtvu1swQk7PpyJn0L/NUASxvcclugAzJveGRr3XV9BJo
         yV8UqqANH+zKCPCuxo1FlhEKkRbHSh5ODtN239v8dD+irywoXeK765Bkx51u83OyD0cN
         oTBY3zUMBRXiyaZ3u3MXFtzH8E+ZEAaPRHoUjXowo7R2S+Q/KLse3gn8peAb6GBW0epV
         xicT0MQ99iC5r4kOLnZHfSp4P4k8XQ5M6TV9N6/Rk3kKC0SkePq+rKqzAt80SAO6EGJv
         cvYsUh6LtLKugXVpM5Q45fDo+a1QsOu73ozof36tcx2s6+rcHq0xWMrTzV0kv9ytbmG3
         5gfw==
X-Gm-Message-State: AC+VfDxOOyfdekSu40lIIDddBtFNgO0b2sDosp1J7cuhd7ebyX2LwwWs
        KbTXhITuzKaqa2kzpCSH7kM=
X-Google-Smtp-Source: ACHHUZ5URYK9lc36UtJVOivvqnqiAeYzt89uGFIDG12Ovoo/KrGPXZ/a5fF54ob6IoRVoFI/xvSRQA==
X-Received: by 2002:a17:902:ce86:b0:1af:adc2:ab5b with SMTP id f6-20020a170902ce8600b001afadc2ab5bmr262553plg.0.1685051707020;
        Thu, 25 May 2023 14:55:07 -0700 (PDT)
Received: from ip-172-31-38-16.us-west-2.compute.internal (ec2-52-37-71-140.us-west-2.compute.amazonaws.com. [52.37.71.140])
        by smtp.gmail.com with ESMTPSA id i12-20020a1709026acc00b001afd275e186sm1829141plt.286.2023.05.25.14.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 14:55:06 -0700 (PDT)
Date:   Thu, 25 May 2023 21:55:04 +0000
From:   Alok Tiagi <aloktiagi@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org,
        David.Laight@aculab.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        hch@infradead.org, tycho@tycho.pizza
Subject: Re: [RFC v7 1/2] epoll: Implement eventpoll_replace_file()
Message-ID: <ZG/ZOP0qtG4lVrNY@ip-172-31-38-16.us-west-2.compute.internal>
References: <20230524063933.2339105-1-aloktiagi@gmail.com>
 <20230524-quirlig-leckt-5e89366ede47@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524-quirlig-leckt-5e89366ede47@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 07:26:24PM +0200, Christian Brauner wrote:
> On Wed, May 24, 2023 at 06:39:32AM +0000, aloktiagi wrote:
> > Introduce a mechanism to replace a file linked in the epoll interface with a new
> > file.
> > 
> > eventpoll_replace() finds all instances of the file to be replaced and replaces
> > them with the new file and the interested events.h
> 
> I've spent a bit more time on this and I have a few more
> questions/thoughts.
> 
> * What if the seccomp notifier replaces a pollable file with a
>   non-pollable file? Right now you check that the file is pollable and
>   if it isn't you're not updating the file references in the epoll
>   instance for the file descriptor you updated. Why these semantics and
>   not e.g., removing all instances of that file referring to the updated
>   fd?
>

good question. the current implementation relies on __fput() calling
eventpoll_release() to ultimately release the file. eventpoll_replace_file()
only removes the file if it can successfully install the new file in epoll.
 
> * What if the seccomp notifier replaces the file of a file descriptor
>   with an epoll file descriptor? If the fd and original file are present
>   in an epoll instance does that mean you add the epoll file into all
>   epoll instances? That also means you create nested epoll instances
>   which are supported but are subject to various limitations. What's the
>   plan?
>

My plan was to allow these cases since there is support for nested epoll
instances. But thinking more on this, since seccomp subsystem is the only
caller of eventpoll_replace_file(), I am not sure whether there is a valid
use case where seccomp is used to intercept a system call that uses an
epoll fd as a parameter. Maybe its ok to not do the replacement for such
cases. Thoughts?
 
> * What if you have two threads in the same threadgroup that each have a
>   seccomp listener profile attached to them. Both have the same fd open.
> 
>   Now both replace the same fd concurrently. Both threads concurrently
>   update references in the epoll instances now since the spinlock and
>   mutex are acquired and reacquired again. Afaict, you can end up with
>   some instances of the fd temporarily generating events for file1 and
>   other instances generating events for file2 while the replace is in
>   progress. Thus generating spurious events and userspace might be
>   acting on a file descriptor that doesn't yet refer to the new file?
>   That's possibly dangerous.
> 
>   Maybe I'm mistaken but if so I'd like to hear the details why that
>   can't happen.
>

Considering file1 is the original file and file2 is the new file. First
the eventpoll_replace_file() is called before receive_fd_replace(), so
the file1 is still active and file2 would not receive any events. Within
receive_fd_replace() the install phase first installs file2 alongside file1
without removing file1. So during this phase the userspace can continue to
receive events on file1. In the remove phase within eventpoll_replace_file()
the epi for file1 is set to dying and replaced with file2. At this point the
fd should see no new events, since receive_fd_replace() is yet to be called.
 
>   Thinking about it what if the same file is registered via multiple fds
>   at the same time? Can't you end up in a scenario where you have the
>   same fd referring to different files in one or multiple epoll
>   instance?
> 
>   I mean, you can get into that situation via dup2() where you change
>   the file descriptor to refer to a different file but the fd might
>   still be registered in the epoll instance referring to the old file
>   provided there's another fd open holding the old file alive.
> 

The current implementation scopes the replacement to the fd being replaced
in the call to receive_fd_replace() since thats what the userspace intends
to do. In case there are multiple fds pointing to the same file, and 
receive_fd_replace() replaces only one of them, we would end up updating
the file for only one of the fds. The other fd will see the same result as
seen today without this patch, where the replaced file doesn't exist in 
epoll since it got cleared due to __fput().

>   The difference though is that userspace must've been dumb enough to
>   actually do that whereas now this can just happen behind their back
>   misleading them.
>

Since this is mainly serving the seccomp add fd usecase today, do you think
its something that can be documented as a limitation? I am not aware of the
interesting ways users are using seccomp add fd to think of all the possible
scenarios, so I am open to suggestions.

>   Honestly, the kernel can't give you any atomicity in replacing these
>   references and if so it would require new possibly invasive locking
>   that would very likely not be acceptable upstream just for the sake of
>   this feature. I still have a very hard time seeing any of this
>   happening.
> 
> * I haven't looked at the codepath that tries to restore the old file on
>   failure. That might introduce even more weirdness.
