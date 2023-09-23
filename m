Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA307AC536
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Sep 2023 23:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjIWV34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Sep 2023 17:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIWV34 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Sep 2023 17:29:56 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A172124;
        Sat, 23 Sep 2023 14:29:50 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7740cedd4baso246394685a.2;
        Sat, 23 Sep 2023 14:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695504589; x=1696109389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3Je4TNRe1YIR75V+qdWRX7Igoi+hFtPHeeYUIcHIZM=;
        b=UwzTCGcWTw0vFwp+U6gnv7Sn+Lg+uMSQ642cOFmEEONVUgek3dm/RfNafQOrvN5/rz
         t/4vaMf9iLp7PvifBV7qp6v+yMPMAuH7qLj0fJ3dI9QXfHSpwloD7ECXAMrNFG7hMqd0
         ErsEzZ9qWXDbyiRoWFIFJiTy0He5ER7eYSkfkhefwKBRW28rZDQ+nFy1XweW+zEeflv6
         FfAWD9nW9Ja9i2auZMx6LERUvkoR9G6MF8xD5D0yoYp7Sr9dpbX4UFlQ70RjzqXhWrs0
         51+SuOHizKr3I3tKDp/W1dHwr5DGCz3kbYYwi9sjFSji3Q0CiBMsSv4XUCUu2AEDWIn6
         F9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695504589; x=1696109389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3Je4TNRe1YIR75V+qdWRX7Igoi+hFtPHeeYUIcHIZM=;
        b=KPT5WjGkqJU0t3Kdz6d3O78KDnYfhgnPgj55gaamk5nhHeBJc4he9X9WEvNEvlNxUD
         EEXDDKhLr+N4Guwq+xjiK6X7syJ+IjrPUCFizumNR9hEl5pElyu9vrzBRN0Q83ch+lmp
         7itqgBuQixdYiNuFUFygTGo0yY9DCMAcgicp6Aj+FoBubwB2uCc+eq3QGPM799ysujC4
         Tsy8+vSptgSW6yPAeZPKEh9PJvtitRaon1DJTsrDtXl4y9jZdXY3aj8L/XWKuJxfGRh7
         kfpcSeLQ0SoCpAaeMDrMD+zafI1uZoh5sFgSmU+7LnpW2UNRzERt1KpjA0fqz5TwoqI5
         ZDYg==
X-Gm-Message-State: AOJu0YzkV2ka1QOTFF1ElINp5PpHczx60nZzXWldj1C2aUBM7i1Q/ZSk
        Ha07ZcrvwP5TMUBfH8MamMj2zrS3PXkuthYrg6FHeBnR59Q=
X-Google-Smtp-Source: AGHT+IFSq/g4z041jXnwLJZcO1nkYQbUpzv8j2HBv047RiM61pkxOkJp3eSFa1qXWndcnwu/eGNWOFPuAofiMa6MXjo=
X-Received: by 2002:a05:620a:40c5:b0:76e:fea0:3f3e with SMTP id
 g5-20020a05620a40c500b0076efea03f3emr3400849qko.48.1695504589098; Sat, 23 Sep
 2023 14:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
 <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
 <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org>
 <CAHk-=whAwTJduUZTrsLFnj1creZMfO7eCNERHXZQmzX+qLqZMA@mail.gmail.com>
 <CAOQ4uxjcyfhfRhgR97wqsJHwzyOYqOYaaZWMWWCGXu5MWtKXfQ@mail.gmail.com> <CAHk-=wjGJEgizkXwSWVCnsGnciCKHHsWg+dkw2XAhM+0Tnd0Jw@mail.gmail.com>
In-Reply-To: <CAHk-=wjGJEgizkXwSWVCnsGnciCKHHsWg+dkw2XAhM+0Tnd0Jw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 24 Sep 2023 00:29:37 +0300
Message-ID: <CAOQ4uxgFb250Na9cJz0Jo-ioPynWCk0vxTDU-6hAKoEVQhgvRg@mail.gmail.com>
Subject: Re: [GIT PULL v2] timestamp fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 23, 2023 at 8:49=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 22 Sept 2023 at 23:36, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Apparently, they are willing to handle the "year 2486" issue ;)
>
> Well, we could certainly do the same at the VFS layer.
>
> But I suspect 10ns resolution is entirely overkill, since on a lot of
> platforms you don't even have timers with that resolution.
>
> I feel like 100ns is a much more reasonable resolution, and is quite
> close to a single system call (think "one thousand cycles at 10GHz").
>

You are right. 100ns is enough resolution for fs timestamps, but:

   1. We cannot truncate existing timestamps on existing files
that are stored in 1ns format even if the 100ns remainder is garbage,
applications depend on tv_nsec not changing, so if vfs truncates to
100ns, filesystems will need to carry the remainder anyway.

   2. The whole idea behind multigrain time is that the 100ns remainder
space is available in on-disk timestamps formats and is not going away,
so better not let it go to waste on garbage and use is for "change cookie".

> > But the resolution change is counter to the purpose of multigrain
> > timestamps - if two syscalls updated the same or two different inodes
> > within a 100ns tick, apparently, there are some workloads that
> > care to know about it and fs needs to store this information persistent=
ly.
>
> Those workloads are broken garbage, and we should *not* use that kind
> of sh*t to decide on VFS internals.
>

Sorry, I phrased it completely wrong.
The workloads don't expect 1ns resolution.
The workloads just compare timestamps of objects and expect some sane
not-before ordering rules.
If user visible timestamps are truncated to 100ns all is good.

> End result: we should ABSOLUTELY NOT have as a target to support some
> insane resolution.

This is not the target.

I think the target is explained well in this new v8 revision [1]
of the patch set which does exactly what you promote -
it hides the insane resolution in fs timestamps from users.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxjGofKT2LcM_YmoMYsH42ETpB5k=
xQkh+21nCbYc=3Dw1nEg@mail.gmail.com/T/#mbc87e67faf71cc58c6424335333935bf774=
0d49e
