Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11A62198B92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 07:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCaFLY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 01:11:24 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39596 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCaFLY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 01:11:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id a43so23598309edf.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2020 22:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=181xT05kF3H0VD4f8J7xShi9xZwvoRHrcpvFBQLeEIA=;
        b=m3IgsGGZrBgakxVw5if3yzczNN+msQw/g4O9F81ImNkKRl6IR0dPN9pgwGDudyXoFD
         wIWE3Xb4wifN6VLA2/4V2jQdkh5DWnfWy9gEgEbaIM2wokowxXNZoF3v4dB085lzm0sT
         cxBvjCc7bpBAb5dgoCxTIjslzsJDa+Q/lTfFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=181xT05kF3H0VD4f8J7xShi9xZwvoRHrcpvFBQLeEIA=;
        b=mitbaFWl77IazRPwoK2adQNNO5S6pzklyXf5OJ9jb4tKB/x0uYl5AaThv53Swd9k1w
         szeIXN1LiE66/vCzG+DeHzcO92+NewsYfazbAbCnQGlUnQzChv4t/A6IjkpT/UPPEjmd
         hqHrhtWNqPyc75BKPFTU1yfoWJI9EfKB1ooMUUCZ+PadGd/M/ZUs40DW4hTDYn1+cl+L
         4ksGQu3/r4Xr3v/ZiYR8qdZ6qiQGhuzmvxPKVo8TCy+oZxnsR1rzuBTuvJVDbx7aAYKa
         iyoVTKvuZIJIfQiuvIgCbCf6/A9vXZKs2k3OPNleznVkW6ksYRqZoV5Too3odWLcMHqa
         5X7g==
X-Gm-Message-State: ANhLgQ0p87TSn32FtJAiC1YomGl69qDu9QIMdhNdF7cVAUoS7s9wA9q9
        pPIhIqbvDNSXKVSrW4mdZu5nleqD6xN0LVt8jLcK5w==
X-Google-Smtp-Source: ADFU+vujD3XRyzE2A6P8XAJLarFPpIUeWPjGW5jTzW/mvrFUEb88BGcaM3HywgE+474EUtqBVDyCkVg3I0Aj9RVfp1g=
X-Received: by 2002:a17:906:9ca:: with SMTP id r10mr13543753eje.151.1585631482578;
 Mon, 30 Mar 2020 22:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <1445647.1585576702@warthog.procyon.org.uk> <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
In-Reply-To: <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 31 Mar 2020 07:11:11 +0200
Message-ID: <CAJfpegtjmkJUSqORFv6jw-sYbqEMh9vJz64+dmzWhATYiBmzVQ@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 30, 2020 at 11:17 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:

> Fwiw, putting down my kernel hat and speaking as someone who maintains
> two container runtimes and various other low-level bits and pieces in
> userspace who'd make heavy use of this stuff I would prefer the fd-based
> fsinfo() approach especially in the light of across namespace
> operations, querying all properties of a mount atomically all-at-once,

fsinfo(2) doesn't meet the atomically all-at-once requirement.  Sure,
it's possible to check the various change counters before and after a
batch of calls to check that the result is consistent.  Still, that's
not an atomic all-at-once query, if you'd really require that, than
fsinfo(2) as it currently stands would be inadequate.

> and safe delegation through fds. Another heavy user of this would be
> systemd (Cced Lennart who I've discussed this with) which would prefer
> the fd-based approach as well. I think pulling this into a filesystem
> and making userspace parse around in a filesystem tree to query mount
> information is the wrong approach and will get messy pretty quickly
> especially in the face of mount and user namespace interactions and
> various other pitfalls.

Have you actually looked at my proposed patch?   Do you have concrete
issues or just vague bad feelings?

Thanks,
Miklos
