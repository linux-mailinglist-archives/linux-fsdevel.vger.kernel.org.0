Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641BA7BB392
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 10:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjJFIyF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 04:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjJFIyE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:54:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D8793
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 01:54:00 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53808d5b774so3401160a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 01:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1696582439; x=1697187239; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3xGSg1ywEPdzy+7pm5ys+NDpYYhLyChWJlGKSbRiijw=;
        b=e9JOMdBddiy+e2X+XurG3ruDYEHCQk3UVKyXYxDFYF6XrhfOyP7Ato/eVIEGR8Logq
         81e6/dyfh73Lsst2k4dsDNpGBJCi7izTL7CPKkAFe4U2y+awEF+a7D+evT3y7n39fFWx
         lJs5HQgMTUkhEIyVnUfxn+0aQVgdBiP30I5CQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696582439; x=1697187239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xGSg1ywEPdzy+7pm5ys+NDpYYhLyChWJlGKSbRiijw=;
        b=UtPr91Jd9WazRMX9aDrnvdur/CGunAr7q+6syHYoclyNlc0sohoLpwGgSxaJVM9dR3
         1+Z/Lsid0p6jXbpLAfnP5y54X7Ovapdadu7zaZffAGtLTcUldRtZZsv/ENYETFyyxN6c
         8l5TnPpoySfuddM067ZAK9qUQFI1FLWj0IH4kOWZxG2deaIMiYHQugT6HuVhgMA2yRlY
         vuXBGk6ugJcINveDCu6fVmWJWbzUS01gIyYo7qwNb5ZfBatCHdRRFUzl3RUGefmpUPou
         ySYgg5lsmlXGswOyYKO+Opris8bQ+RDXjNO8z/Hp80T+Ve9J7p+B/t8LvhakDVZyouEG
         25+A==
X-Gm-Message-State: AOJu0Yy5Kes1B3z9m7SoTkKdVUSUhajHY2nI46bKvo9tFLrsO7VKFBQP
        X1jTm8z0J1x95x3TzxdayOYyFX2WLXhOr0tlaHPHhA==
X-Google-Smtp-Source: AGHT+IE83piQJm/UCJj7lGXWIXCxJWyzvaAX8JQ2evdgbQBnXPLUaWBfp6YDG5512fSgiL66epwHp3T7nz1LEyZLGHk=
X-Received: by 2002:a17:906:109e:b0:9b2:a7f2:f819 with SMTP id
 u30-20020a170906109e00b009b2a7f2f819mr6282014eju.31.1696582438701; Fri, 06
 Oct 2023 01:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230928130147.564503-1-mszeredi@redhat.com> <20230928130147.564503-5-mszeredi@redhat.com>
 <CAHC9VhQD9r+Qf5Vz1XmxUdJJJO7HNTKdo8Ux=n+xkxr=JGFMrw@mail.gmail.com>
 <CAJfpegsPbDgaz46x4Rr9ZgCpF9rohVHsvuWtQ5LNAdiYU_D4Ww@mail.gmail.com>
 <a25f2736-1837-f4ca-b401-85db24f46452@themaw.net> <CAJfpegv78njkWdaShTskKXoGOpKAndvYYJwq7CLibiu+xmLCvg@mail.gmail.com>
 <CAHC9VhTwnjhfmkT5Rzt+SBf-8hyw4PYkbuPYnm6XLoyY7VAUiw@mail.gmail.com>
In-Reply-To: <CAHC9VhTwnjhfmkT5Rzt+SBf-8hyw4PYkbuPYnm6XLoyY7VAUiw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Oct 2023 10:53:47 +0200
Message-ID: <CAJfpegsZqF4TnnFBsV-tzi=w_7M=To5DeAjyW=cei9YuG+qMfg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] add listmount(2) syscall
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ian Kent <raven@themaw.net>, Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 6 Oct 2023 at 04:56, Paul Moore <paul@paul-moore.com> wrote:

> > Also I cannot see the point in hiding some mount ID's from the list.
> > It seems to me that the list is just an array of numbers that in
> > itself doesn't carry any information.
>
> I think it really comes down to the significance of the mount ID, and
> I can't say I know enough of the details here to be entirely
> comfortable taking a hard stance on this.  Can you help me understand
> the mount ID concept a bit better?

Mount ID is a descriptor that allows referring to a specific struct
mount from userspace.

The old 32 bit mount id is allocated with IDA from a global pool.
Because it's non-referencing it doesn't allow uniquely identifying a
mount.  That was a design mistake that I made back in 2008, thinking
that the same sort of dense descriptor space as used for file
descriptors would work.  Originally it was used to identify the mount
and the parent mount in /proc/PID/mountinfo.  Later it was also added
to the following interfaces:

 - name_to_handle_at(2) returns 32 bit value
 - /proc/PID/FD/fdinfo
 - statx(2) returns 64 bit value

It was never used on the kernel interfaces as an input argument.

statmount(2) and listmount(2) require the mount to be identified by
userspace, so having a unique ID is important.  So the "[1/4] add
unique mount ID" adds a new 64 bit ID (still global) that is allocated
sequentially and only reused after reboot.   It is used as an input to
these syscalls.  It is returned by statx(2) if requested by
STATX_MNT_ID_UNIQUE and as an array of ID's by listmount(2).

I can see mild security problems with the global allocation, since a
task can observe mounts being done in other namespaces.  This doesn't
sound too serious, and the old ID has similar issues.  But I think
making the new ID be local to the mount namespace is also feasible.

> While I'm reasonably confident that we want a security_sb_statfs()
> control point in statmount(), it may turn out that we don't want/need
> a call in the listmount() case.  Perhaps your original patch was
> correct in the sense that we only want a single security_sb_statfs()
> call for the root (implying that the child mount IDs are attributes of
> the root/parent mount)?  Maybe it's something else entirely?

Mounts are arranged in a tree (I think it obvious how) and
listmount(2) just lists the IDs of the immediate children of a mount.

I don't see ID being an attribute of a mount, it's a descriptor.

Thanks,
Miklos
