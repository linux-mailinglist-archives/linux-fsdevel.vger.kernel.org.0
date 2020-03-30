Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE3419855E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 22:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgC3U3L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 16:29:11 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43912 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgC3U3K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:29:10 -0400
Received: by mail-il1-f195.google.com with SMTP id g15so17212333ilj.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2020 13:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8wRE9skQiDOyL/NwP++MZjMIXWKMRhzu11GnAjRZxZ0=;
        b=j3F+pt8VEBaTXag4YyMtj/czjH6vJ+cXky5caKr/vsTZB0Zw/llYEDrLRNA3nSiU5W
         Pt2FBpDa4AsPrZwVQ0bsqww17OBPP5xlTKmy07P60DjZ/KAntiULP9lGqudbD0AOfbl9
         mvCBImTFxmA59jftjIzHyhHIdemR04U2NYVEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wRE9skQiDOyL/NwP++MZjMIXWKMRhzu11GnAjRZxZ0=;
        b=qdnMCBjGdGpnNRbkJ+T6VCwnIqkbZsN9ScqHjCuB/f/xlfSAd6/Jhvz10uc2Nv2Cby
         s/FGZQCQ+0N5j1SFHraXw+oAMfR8KTz9ndi/JI5OYqdOQPyBy+pHfH1lSthfVOFo2VWv
         a7R9ROORavVsmxDxZvxONoT4JZvUHxbmptcb4KKa/pFnb2vN033Rl0njdIhQwz/Huqbj
         z6kG20XsUsduCK3nAt/fi/iusatrayXi0PNRr05WEJLVa2rB9tHfuRu6vyoQwufGATjg
         jCOY5prsUrGvoIX3V0ry0fWZ68A9hn9EWwLwIU40NnbiNAkz8mhNDg+cSZr8ui6Gbcv+
         +VFw==
X-Gm-Message-State: ANhLgQ1FMDm83leS8zz8R3EurW3q8ANMyNBSlCWIv2NaPTiJEr1l0770
        KjX4QLS7QRruUOd/eAOX1gDKdhl8NY3iryUU4Mac8g==
X-Google-Smtp-Source: ADFU+vtRoI7ov8IVr1QxRy1CFyLzeT5qFbKHO3DNdyHr9xLr2wfTu8lvo64ee+deUv4Av2czf29wsrHaPEuUcKx48F8=
X-Received: by 2002:a92:b6c8:: with SMTP id m69mr12262028ill.21.1585600148216;
 Mon, 30 Mar 2020 13:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <1445647.1585576702@warthog.procyon.org.uk>
In-Reply-To: <1445647.1585576702@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 30 Mar 2020 22:28:56 +0200
Message-ID: <CAJfpegvZ_qtdGcP4bNQyYt1BbgF9HdaDRsmD43a-Muxgki+wTw@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de,
        Christian Brauner <christian.brauner@ubuntu.com>,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 30, 2020 at 3:58 PM David Howells <dhowells@redhat.com> wrote:
>
>
> Hi Linus,
>
> I have three sets of patches I'd like to push your way, if you (and Al) are
> willing to consider them.

The basic problem in my view, is that the performance requirement of a
"get filesystem information" type of API just does not warrant a
binary coded interface. I've said this a number of times, but it fell
on deaf ears.

Such binary ABIs (especially if not very carefully designed and
reviewed) usually go through several revisions as the structure fails
to account for future changes in the representation of those structure
fields.   There are too many examples of this to count.   Then there's
the problem of needing to update libc, utilities and language bindings
on each revision or extension of the interface.

All this could be solved with a string key/value representation of the
same data, with minimal performance loss on encoding/parsing.  The
proposed fs interface[1] is one example of that, but I could also
imagine a syscall based one too.

Thanks,
Miklos

[1] https://lore.kernel.org/linux-fsdevel/20200309200238.GB28467@miu.piliscsaba.redhat.com/
