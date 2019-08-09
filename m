Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31A8088000
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2019 18:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437053AbfHIQaL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 12:30:11 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36954 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfHIQaK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:30:10 -0400
Received: by mail-yw1-f65.google.com with SMTP id u141so35780917ywe.4;
        Fri, 09 Aug 2019 09:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fpmb7aMu+8l69AdkKJAl1XMLapQrrZLpssynUgiongE=;
        b=g24dmDg1xYHwa/HEx7XJfAc+Oi9Ozx2qOzIklkpRqje3zxC9KRa29lss18EIQATH1C
         65NxHQkFieqXmguHo88uvxGo2DVO4fdEEQvDQ9gcUGU/JsvWGjzq+mTqYppELGtFIZbg
         9NraSZ74+1lnacaBLVmsSLAqf8RpRFnAHOH2dSIXCzrAfwLyjYD/sg2CBjEMvccKoomF
         StasBNvtFErsEZ/ST3PSDuZudQaYUoWUhPWP3tzXcxbdGr52N3vOeJSuU2t2prKvu5Az
         WdcPkB0b5szi5NZEMloHyMWNx83dohB16QS7LZD9e/Idcr8Iy2KmN/GUYOWC6L6P5tXy
         dTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpmb7aMu+8l69AdkKJAl1XMLapQrrZLpssynUgiongE=;
        b=oUkO6c8hTgrerPkUc+CIDxKHrIFTuDpU50BpRxV2mKMFy0R/s3ZJ8JGILsySOY9ZiG
         RyI0zWxvgc12QpsEXDtjaXQF+iHw7UndHbIgL3dvwqQaN2tgdaIBcdM+8Yp7HZx7JwXH
         0UM+YdWjKF6G3x183LI9rvwH77ePGf7QVbyOGywWClV282mctN2F3Mb5g4AO9vr8OZ8A
         NBJKxg2wqcOp/+UWSrdqWz5NyHNFdQ9QuufIDDHUQ0urwVEhqLe7x7agHtIzQ5TmsADB
         YVVWEk4JVRSbsAu5RT+DqpKsIZSfj/HKPYAVK2xr430trgHcdWuBD5NtYV3TqS+MirhE
         23DQ==
X-Gm-Message-State: APjAAAU9zpO5XXT4GC0EsKaHrzJbHveBKnwScPkrZmioG9OlKfdE7OiO
        qz2U61t2Vb8fkJ4ZiI3k8nE3UvSWmACSSSQFdIk=
X-Google-Smtp-Source: APXvYqxoQD16sTWl8XMyuigBUkpNd9gDcOuZI/i1h93mKpNSyCEiAmD+Kpg9VEHgXstLxyzAMmzIiN09C+8r/b1hCQY=
X-Received: by 2002:a81:13d4:: with SMTP id 203mr14520724ywt.181.1565368209677;
 Fri, 09 Aug 2019 09:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190731153443.4984-1-acgoide@tycho.nsa.gov> <CAHC9VhQUoDwBiLi+BiW=_Px18v3xMhhGYDD2mLdu9YZJDWw1yg@mail.gmail.com>
 <CAOQ4uxigYZunXgq0BubRFNM51Kh_g3wrtyNH77PozUX+3sM=aQ@mail.gmail.com>
 <CAHC9VhRpTuL2Lj1VFwHW4YLpx0hJVSxMnXefooHqsxpEUg6-0A@mail.gmail.com> <03ad3773-bea7-77de-0a1f-4bd6f41d3211@tycho.nsa.gov>
In-Reply-To: <03ad3773-bea7-77de-0a1f-4bd6f41d3211@tycho.nsa.gov>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 9 Aug 2019 19:29:57 +0300
Message-ID: <CAOQ4uxjfwhg4LaPhaDoSQqTviLbXT_-g+WNfQ5AahTK9d+h-Zw@mail.gmail.com>
Subject: Re: [Non-DoD Source] Re: [PATCH] fanotify, inotify, dnotify,
 security: add security hook for fs notifications
To:     Aaron Goidel <acgoide@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

...
> >> First a suggestion, take it or leave it.
> >> The name of the hook _notify() seems misleading to me.
> >> naming the hook security_path_watch() seems much more
> >> appropriate and matching the name of the constants FILE__WATCH
> >> used by selinux.
> >
> > I guess I'm not too bothered by either name, Aaron?  FWIW, if I was
> > writing this hook, I would probably name it
> > security_fsnotify_path(...).
> >

Or even just security_fsnotify()

>
> While I'm not necessarily attached to the name, I feel as though
> "misleading" is too strong a word here.

Agree. It is not misleading, but I should note that you yourself
named the security class "watch", so why the inconsistency?

> Notify seems to be an
> appropriate enough term to me as every call to the hook, and thus all
> the logic to which the hook adds security, lives in the notify/ subtree.
>

Well, if nobody cares about the name, it's fine by me.

I wanted to point your attention to this proposal by David Howells:
https://lore.kernel.org/linux-fsdevel/155991706847.15579.4702772917586301113.stgit@warthog.procyon.org.uk/

His proposal adds new types of watches, for keyring changes,
mount changes, etc and he proposed security hooks for setting
new watches named "watch_XXX" and for posting notifications
called "post_notification". The latter was later rejected by
Stephen Smalley:
https://lore.kernel.org/linux-fsdevel/cd657aab-e11c-c0b1-2e36-dd796ca75b75@tycho.nsa.gov/
https://lore.kernel.org/linux-fsdevel/541e5cb3-142b-fe87-dff6-260b46d34f2d@tycho.nsa.gov/

Just to have a perspective why the hook name "notify_path" may end up
being a bit ambiguous down the road.

Thanks,
Amir.
