Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE88A241E4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 18:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbgHKQbY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 12:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729302AbgHKQbJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:31:09 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71378C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 09:31:06 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id t6so14222891ljk.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 09:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N7traUqX1fM13wKjAbxkcSlNBWmdCV6QJf9i7XpWydE=;
        b=WPJKoAqHiSl/tMI6ux9ZyiwFZyLZeSf9IYnGPT6aXv5JxD0edUrsFyfwibupSRZPli
         sRgA0IHx4UhfQY9IUr+rb1b91G/QJ4IOfgHOH9XwY0IGnWNZoZAF+orZ9O7vZ9YyH60H
         QN4mw78jv4VsrakmBralo6Vc4sNZK78skPMUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N7traUqX1fM13wKjAbxkcSlNBWmdCV6QJf9i7XpWydE=;
        b=O64cIo3yputGDpR3Muq4gYZPPX1Sfta4pOoP8gMLNiEfGnZeIxqR6sP+PcRYJPFA8g
         5iaa3bdcs/3kjvqJ0KLE9pBuf4oB1Vo5UetNVmabTnrtEQUJqAOU9X0ugBwhyQ7a7LnV
         DTiQIcM3X4V9V4d7KNbBeKb5RSK9kgklyLK8KrfUH8Tunv8sAQ7XqB1Ih+QonJ5hHGrK
         AZ5DF/pTeQYFY9u+9gnS4CTaSnKLUR4ejveCEH+eUvz0KxlMAfBBo+OADl/D2x90ny/g
         i3169F1u8nMAjGEsesYJbgznBZsILhj1c4J6DcqgWZzCBlZf3bVEI6LHqOluq51oiFx3
         ZgiQ==
X-Gm-Message-State: AOAM531hBkZJnxe4Td1eXyPj3HXOF3jqjHtfD96DeBunhniv8yfkC8V/
        ZrLXYDXrv9XyPs4LIngBqZzplDBm/9w=
X-Google-Smtp-Source: ABdhPJx7D+ZtVU7dNyvSBLXEcLb+r3Wi3m0aEtwSODWwRhufg4a38pB9EaTmXaS3X5RlHE7HQxM3eA==
X-Received: by 2002:a2e:b81a:: with SMTP id u26mr3608120ljo.241.1597163464799;
        Tue, 11 Aug 2020 09:31:04 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id b1sm10144674ljp.78.2020.08.11.09.31.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 09:31:04 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id w25so14203109ljo.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 09:31:04 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr3282002lji.314.1597163463666;
 Tue, 11 Aug 2020 09:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net> <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
In-Reply-To: <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Aug 2020 09:30:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNwsV6PYrB=MB6y8AJ00GO70CGVUcgKxZHZybhcNp_6w@mail.gmail.com>
Message-ID: <CAHk-=whNwsV6PYrB=MB6y8AJ00GO70CGVUcgKxZHZybhcNp_6w@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 9:17 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> This doesn't work so well for setxattr(), which we want to be atomic.

Well, it's not like the old interfaces could go away. But yes, doing

        metadatafd = openat(fd, "metadataname", O_ALT | O_CREAT | O_EXCL)

to create a new xattr (and then write to it) would not act like
setxattr(). Even if you do it as one atomic write, a reader would see
that zero-sized xattr between the O_CREAT and the write.

Of course, we could just hide zero-sized xattrs from the legacy
interfaces and avoid things like that, but another option is to say
that only the legacy interfaces give that particular atomicity
guarantee.

> Since a////////b has known meaning, and lots of applications
> play loose with '/', its really dangerous to treat the string as
> special. We only get away with '.' and '..' because their behavior
> was defined before many of y'all were born.

Yeah, I really don't think it's a good idea to play with "//".

POSIX does allow special semantics for a pathname with "//" at the
*beginning*, but even that has been very questionable (and Linux has
never supported it).

                   Linus
