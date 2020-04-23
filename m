Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56CD1B5C84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 15:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgDWNYP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 09:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727116AbgDWNYO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 09:24:14 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C44C08ED7D
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 06:24:14 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k6so6349408iob.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 06:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IYI4MOFxE2DmsW+dfX71saQe4Hx32Kp/Cx5yZ42ghYw=;
        b=VxMtuIl+IDdp4e7GrKdYtdIpD+iv9MOAAj9Ns5O0PNySh3blxlWaHzi1AeebltDvdd
         AUdUT4sQCysCRq6y/SnXsmyHBKmGjvgBmWaX3Zjqd6NrkEydBITCmFJwQLbOElNs0MZ6
         3SHV/GocG13e4oFEQN0Pbvf33MXOkhOUSQxeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IYI4MOFxE2DmsW+dfX71saQe4Hx32Kp/Cx5yZ42ghYw=;
        b=kOKzVpDcjxhRpRogXy/a2xR6bBJi7deSB2yoOp5SAqV7j8+zTS2TyuN4PB8CY675kJ
         cvxxrpq25JpHjKeP5qWeU9jCYz55I//2J3hePM8dpbEaYRZ4AgGXAK0U58/RiOcmNu9O
         R29NdxUxLqNq7etQrC3MSQtfUno1B8DTrO/APe+0QhTcwNDEf37ERcFqfZ0wSlui80Vo
         jiDrVTnKDVNkO6Whie7BLn5fcYmumnW1Q0SAq/wf9kbEPbTGASlOp43phhgv0ltnF8Rc
         2VURBb0/vsfw+35UYcxEa9C8n60ysH23UDhbd3mvxC7MfjE4LPWL6wpFgIQ6YvEot6V+
         KLyQ==
X-Gm-Message-State: AGi0Pua/sfsqAZFKmK1kiha6wicBS/7WVVv94jC89Hjh3S/lBu2+/xOQ
        /C/u1CosETGMfJX0bUsiz//TD8MTlMXcPi91RqUZQg==
X-Google-Smtp-Source: APiQypJxiFUmCFrucYd6jfVEYnSaLjmunqORafPxfOfbdjWlBbumjtBRb6y1VgIXjxdlSY4fV+/NyS2Z0lAVtalFbUo=
X-Received: by 2002:a6b:6618:: with SMTP id a24mr3527703ioc.85.1587648253810;
 Thu, 23 Apr 2020 06:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200423044050.162093-1-joel@joelfernandes.org>
 <20200423044518.GA162422@google.com> <CAOQ4uxgifK_XTkJO69-hQvR4xQGPgHNGKJPv6-MNgHcQat5UBQ@mail.gmail.com>
 <20200423104827.GD3737@quack2.suse.cz>
In-Reply-To: <20200423104827.GD3737@quack2.suse.cz>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 23 Apr 2020 09:24:02 -0400
Message-ID: <CAEXW_YT4behgV05BqU1PG1o0-FUNnRowdntem5n7bvraGVXz3Q@mail.gmail.com>
Subject: Re: [RFC] fs: Use slab constructor to initialize conn objects in fsnotify
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 23, 2020 at 6:48 AM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 23-04-20 08:24:23, Amir Goldstein wrote:
> > On Thu, Apr 23, 2020 at 7:45 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Thu, Apr 23, 2020 at 12:40:50AM -0400, Joel Fernandes (Google) wrote:
> > > > While reading the famous slab paper [1], I noticed that the conn->lock
> > > > spinlock and conn->list hlist in fsnotify code is being initialized
> > > > during every object allocation. This seems a good fit for the
> > > > constructor within the slab to take advantage of the slab design. Move
> > > > the initializtion to that.
> > > >
> > > >        spin_lock_init(&conn->lock);
> > > >        INIT_HLIST_HEAD(&conn->list);
> > > >
> > > > [1] https://pdfs.semanticscholar.org/1acc/3a14da69dd240f2fbc11d00e09610263bdbd.pdf
> > > >
> > >
> > > The commit message could be better. Just to clarify, doing it this way is
> > > more efficient because the object will only have its spinlock init and hlist
> > > init happen during object construction, not object allocation.
> > >
> >
> > This change may be correct, but completely unjustified IMO.
> > conn objects are very rarely allocated, from user syscall path only.
> > I see no reason to micro optimize this.
> >
> > Perhaps there is another justification to do this, but not efficiency.
>
> Thanks for the suggestion Joel but I agree with Amir here. In principle
> using constructor is correct however it puts initialization of object in
> two places which makes the code harder to follow and the allocation of
> connector does not happen frequently enough for optimizing out these two
> stores to matter in any tangible way.

Thanks a lot Jan and Amir for your comments on the RFC patch. I am
glad I got learn about this concept and appreciate the discussion very
much.

I agree with your analysis about the lack of constructor benefit with
infrequent allocations, the other ones being: splitting object
initialization into 2 code paths and also dirtying the entire page and
the L1 cache that Matthew mentioned.

 - Joel
