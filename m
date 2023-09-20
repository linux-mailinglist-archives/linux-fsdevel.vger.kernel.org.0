Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6869C7A7125
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 05:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjITDyy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 23:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjITDyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:54:53 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFB8AC;
        Tue, 19 Sep 2023 20:54:47 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76ef6d98d7eso391515985a.0;
        Tue, 19 Sep 2023 20:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695182086; x=1695786886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hi9pJ3V/h0zrn32iGZuY7DuSQJTpPQ9iO1On2B06DpU=;
        b=Hcw2/cOUmYP4d6Ey9D8VGBECs6RqtBuyJOouopdNNVDz+XgnGNnWCHvvnyNLFl3oJh
         tY7oQfnN/ZTagDmIGQZ73Ew+FqU0aAm3j56XxnQZMXgX4IhfmU2bBSxyV4m1ZMJhjxV7
         /ZlxLoJfX68ns+hv/MXQZRIhyMIXD3yXpoC2f3OsryQrywAhbWaQiBV3QXetZ3q5o2Ht
         9XhoTDWfWUuwY+znWFJY9OABSYuEaxR4Kn559qHjOdnUbW+fNmofbLiIFFLksH7H6NdG
         u4TUcO4Q9amBOqoy6boPUrUykPhr2D/J0Z8yApaE9WuMww4t1cie7ny1ZiuZAnRcq02Y
         t97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695182086; x=1695786886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hi9pJ3V/h0zrn32iGZuY7DuSQJTpPQ9iO1On2B06DpU=;
        b=Y+U1cp0D/MeVLDjPzMW3GGeHkA83L/Z1lTdYExYf+0hYXmlOKCiTrYHOudsK2VZH2P
         3Va+dvkhtHxWHBopldWx4IBBNj9/aONCCQzl04Pb18xq60UiDVLIgtQh/TTPXQZMtMWx
         ocW22dkH9C/tXkT+9bwHDo+pkFfDK74C7XoyNWskEUHcjtxLz1bOiwhjx10Dbi//0VyW
         0ZUDZZm/Vo4/sOkFWCMhV+/vo3dt6O4AJZP6rVqppvpMXelNt4jOiExHXA04bGMwCTPP
         d0TKxy3i8GmkIN2OiP3Y63iGahaYAo3Re+OJV+Rr0eqOZzbV3YxBpWA2hgZjAIh6ywBz
         5MYA==
X-Gm-Message-State: AOJu0YzRPOPOD2YPQFVkEeGiWK+Cy+l/TSRaMfwfnLMbCUM/fvJXCRvG
        Nf77bYgU55kPYMTUR0oe25AO/hM63yosiNSW5xg=
X-Google-Smtp-Source: AGHT+IFPcK/N+vZQH1m12xbMhw/1wrYNbeENvyBAcXKEJQy405KClZGVs4AkJolK4NWT36Cw7KKMRqaUmzs2DVd/fkI=
X-Received: by 2002:a05:620a:424e:b0:76e:f0b5:d004 with SMTP id
 w14-20020a05620a424e00b0076ef0b5d004mr1552799qko.66.1695182086118; Tue, 19
 Sep 2023 20:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230919202304.1197654-1-max.kellermann@ionos.com>
In-Reply-To: <20230919202304.1197654-1-max.kellermann@ionos.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 20 Sep 2023 06:54:34 +0300
Message-ID: <CAOQ4uxhh5=ux=C0wBOndG5tVUuQ+F4OL1ihoaGcb8z67BY-Tbw@mail.gmail.com>
Subject: Re: [PATCH] inotify: support returning file_handles
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 11:23=E2=80=AFPM Max Kellermann
<max.kellermann@ionos.com> wrote:
>
> This patch adds the watch mask bit "IN_FID".  It implements semantics
> similar to fanotify's "FAN_REPORT_FID": if the bit is set in a "struct
> inotify_event", the event (and the name) are followed by a "struct
> inotify_extra_fid" which contains the filesystem id (not yet
> implemented) and the file_handle.
>
> It is debatable whether this is a useful feature; not useful for me,
> but Jan Kara cited this feature as an advantage of fanotify over
> inotify:
> https://lore.kernel.org/linux-fsdevel/20230919100112.nlb2t4nm46wmugc2@qua=
ck3/
>
> In a follow-up, Amir Goldstein did not want to accept that this
> feature could be added easily to inotify, telling me that I "do not
> understand the complexity involved":
> https://lore.kernel.org/linux-fsdevel/CAOQ4uxgG6ync6dSBJiGW98docJGnajALiV=
+9tuwGiRt8NE8F+w@mail.gmail.com/
>
> .. which Jan Kara agreed with: "I'll really find out it isn't so easy"
> https://lore.kernel.org/linux-fsdevel/20230919132818.4s3n5bsqmokof6n2@qua=
ck3/
>
> So here it is, an easy implementation in less than 90 lines of code
> (which is slightly incomplete; grep TODO).  This is a per-watch flag
> and there is no backwards compatibility breakage because the extra
> struct is only added if explicitly requested by user space.
>
> This is just a proof-of-concept, to demonstrate that adding such a
> feature to inotify is not only possible, but also easy.  Even though
> this part of the kernel is new to me, apparently I do "understand the
> complexity involved", after all.
>

A bit more humility couldn't hurt. From both you and I.
Obviously, reporting the fhandle in not the complexity we were
talking about. Looks like you are a fast learner, so maybe one day
you wili dive into fanotify code and see the improvements over inotify.

But your basic point that inotify could have been extended is true.
We wanted to extend functionality in the kernel for filesystem watches [1].
We could have done inotify 2.0 (extend inotify).
We could have done fsnotify 1.0 (i.e. new syscalls).
We decided to go with fanotify 2.0, because the fanotify
syscalls and event format already had all the fields needed to
provide the extended API.

It was an arbitrary design choice. It is futile to argue about it.

The main difference between inotify and fanotify APIs which concerns
your complaint is the watch descriptor - a kernel map of unique inode
objects.

Filesystem watches drove the need for reporting fhandles.
I don't have the time to explain why reporting wd/fd in this case
is not a good idea.

It was a design decision to keep the API consistent and uniform
and report the same information for inode watches as well.

Ignoring the functionality gap that needs to be closed between
fanotify -> inotify for the discussion, the remaining part that you like
about inotify is the integer wd descriptor, which makes your life easier.

I am not saying that wd is not useful.
I am not saying that it will not be considered useful enough to keep it
around when the time comes to consider deprecating inotify.

What I am saying is that the inode already has a unique identifier -
more than one even.
For the context of pinned inodes (as in inotify watches), st_dev/st_ino
is unique and fixed size.
fsid/fhandle is variable size (practically fixes size per fs type), but has
the advantage that the identity is persistent so applications can use it to
store change tracking information in databases and to resolve uptodate
path of objects.

Again, it was a design decision to use the stronger fid always.
I have probably offered more than once to implement
FAN_REPORT_DEV_INO, which simplifies things a bit
(maybe not enough for you ;)) and closes the gap of supporting
all filesystems.
For now, we decided to try and stick with FAN_REPORT_FID
for uniformity and add support for fs that do not currently report
fsid/fhandle.

> I don't expect this to be merged.  As much as I'd like to see inotify
> improved because fanotify is too complex and cumbersome for my taste,
> I'm not deluded enough to believe this PoC will convince anybody.  But
> hacking it was fun and helped me learn about the inotify code which I
> may continue to improve in our private kernel fork.
>

Learning is always good.

Thanks,
Amir.

[1] https://github.com/amir73il/fsnotify-utils/wiki/filesystem-mark
