Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6897A0110
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 12:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbjINKBa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 06:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237585AbjINKBO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:01:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCA71981;
        Thu, 14 Sep 2023 03:01:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8079C433C7;
        Thu, 14 Sep 2023 10:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694685669;
        bh=fZNCOSuOnW8qgFYbmpGKc3ZPkINzwR/JRzJy6TB6DLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BcGVVnF+zgH7WPhoYtq83iUNmXp9AEyFnCb09pOFYhrpvWu0JtS/gUl3E1msCkPiL
         KyZSpbTFxBFPrT6NIlMWkxrK11OvL8M2p9BttSN8RWWBeBfhs1HPqtnrUVRG7pPis3
         KOHzeQXHlNEFAbYjCze7yOlkql6Vk9XxZAdGEnIcB4LwI89G97oIimVoPzzfSe3tE2
         2XIol3Dam9OtYTbS56sGbq2G2GOQ1QPlvPDsX2S9YzNV8KZVezt1k5MjgtLu/RDEla
         0zkxpA86JWOOSzm8DbirZS3lTtrkg9nxxrq1DU1jY6Z3L67FDCYjXtSH1RYJvz7bmT
         IfihVbFi71Vfw==
Date:   Thu, 14 Sep 2023 12:01:04 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [RFC PATCH 3/3] add listmnt(2) syscall
Message-ID: <20230914-umtriebe-fahrwasser-7c789fc442f7@brauner>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <20230913152238.905247-4-mszeredi@redhat.com>
 <CAOQ4uxh4ETADj7cD56d=8+0t7L_DHaSQpoPGHmwHFqCreOQjdQ@mail.gmail.com>
 <CAJfpeguE97q=esmS6zE4OaZBwkBBWykwH1MTnUvLeHcfb7NeTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpeguE97q=esmS6zE4OaZBwkBBWykwH1MTnUvLeHcfb7NeTw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 14, 2023 at 10:50:04AM +0200, Miklos Szeredi wrote:
> On Thu, 14 Sept 2023 at 08:00, Amir Goldstein <amir73il@gmail.com> wrote:
> 
> > > +               if (ctr >= bufsize)
> > > +                       return -EOVERFLOW;
> > > +               if (put_user(r->mnt_id_unique, buf + ctr))
> > > +                       return -EFAULT;
> > > +               ctr++;
> > > +               if (ctr < 0)
> > > +                       return -ERANGE;
> >
> > I think it'd be good for userspace to be able to query required
> > bufsize with NULL buf, listattr style, rather than having to
> > guess and re-guess on EOVERFLOW.
> 
> The getxattr/listxattr style encourages the following code:
> 
>   size = get(NULL, 0);
>   buf = alloc(size);
>   err = get(buf, size);
>   if (err)
>       /* failure */
> 
> Which is wrong, since the needed buffer size could change between the two calls.

Not a fan of this either tbh.

> 
> Doing it iteratively is the only correct way, and then adding
> complexity to both userspace and the kernel for *optimizing* the
> iteration is not really worth it, IMO.

So realistically, userspace nows that an upper bound on the number of
mounts in a mount namespace (expressed in /proc/sys/fs/mount-max usually
100000 - which is often too much ofc).

This is probably insane but I'll power through it: ideally we'd have an
iterator interface that keeps state between calls so we can continue
iterating similar to how readdir/getdents does.
