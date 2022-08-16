Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8055965B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 00:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbiHPW7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 18:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237785AbiHPW7E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 18:59:04 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0D74D831
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 15:59:04 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s11so15333826edd.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 15:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc;
        bh=vLqNaaV5P7/ZzXCJ0NGWGxyCfN/i3J6139fMlUMUnqU=;
        b=FXt5rHx1olwTgVv2m1sylcOHop8gTGYurpxX01eKmMCqQ7wM7UtxmEmmlECgLJYsh1
         /JwSiLFSa5Ci+koqyUE26HSqEfMK7e5l/6AdhKcg8yXgaJUcvSN9qW+G/v/3x18B5aZl
         +yRWhwmcRnVHXAwqkPe47m3/fuwK9XZeDYXWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc;
        bh=vLqNaaV5P7/ZzXCJ0NGWGxyCfN/i3J6139fMlUMUnqU=;
        b=MM3o96wWOKOSSo4U5exip7SF5IprmJgIgFenU6QzGVsZA6S23U71Bp1Gh3eO8Nh4w3
         t9/2g4apOxC/+PMch4kmjmSG4VSMFbYPjtrA1tuU6Yz/bJA3Eatz382nJ9OSpLWKugeB
         EdnLoW5BXyoOYTDkX5cEOJAHGeSqiDN08XYCn8AMUXJbk9+frHz6tLzAGeVOft2mK11R
         scwIvg7JVqEhkszopZdJT/liwSuHfCy79gz+U7+7yGgUcDq+YIANHaD6JEFdMpGkLwLn
         JvpXmwy/BOBt5BiWbuXEkNo1GwEVeMBdaXpWOEA3K6Zz3VgtX+43Ok5EHZmsye6HzgYh
         YE5Q==
X-Gm-Message-State: ACgBeo0lzWyX8v9FvvSjAAQVvXZVg+x8yqqFb9q5w6t1BzapPQvaq0mc
        xkQ5dHTRAP3TABHbgxJrgyS+FtqSflNGBwQAkqA=
X-Google-Smtp-Source: AA6agR4txEiafGBF9pMVUc/uekvEgcNXJtgvVVpdb4YQeu7COeHZHCynm/RvdE5Yt9MLtXjGvjH04Q==
X-Received: by 2002:a50:fd83:0:b0:43c:bca0:bdd1 with SMTP id o3-20020a50fd83000000b0043cbca0bdd1mr20365327edt.360.1660690742349;
        Tue, 16 Aug 2022 15:59:02 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id q23-20020aa7cc17000000b00445cf528bcdsm562116edt.86.2022.08.16.15.59.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 15:59:01 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id h24so208104wrb.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 15:59:01 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:222:ca41:dc26 with SMTP id
 a8-20020a056000188800b00222ca41dc26mr12090641wri.442.1660690741187; Tue, 16
 Aug 2022 15:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <YvvBs+7YUcrzwV1a@ZenIV> <CAHk-=wgkNwDikLfEkqLxCWR=pLi1rbPZ5eyE8FbfmXP2=r3qcw@mail.gmail.com>
 <Yvvr447B+mqbZAoe@casper.infradead.org> <20220816201438.66v4ilot5gvnhdwj@cs.cmu.edu>
In-Reply-To: <20220816201438.66v4ilot5gvnhdwj@cs.cmu.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 Aug 2022 15:58:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wghBfgOkH2jjr4OrQ7d+CLdspq1xaQK3L8x6BuDPv0eiw@mail.gmail.com>
Message-ID: <CAHk-=wghBfgOkH2jjr4OrQ7d+CLdspq1xaQK3L8x6BuDPv0eiw@mail.gmail.com>
Subject: Re: Switching to iterate_shared
To:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 1:14 PM Jan Harkes <jaharkes@cs.cmu.edu> wrote:
>
> So good to know in advance a change like this is coming. I'll have to
> educate myself on this shared vs non-shared filldir.

Well, that change isn't necessarily "coming" - we've had this horrid
duality for years. "iterate_shared" goes back to 2016, and has been
marked "recommended" since then.

But the plain old "iterate" does continue to work, and having both is
only an ugly wart - I can't honestly claim that it's a big and
pressing problem.

But it would be *really* nice if filesystems did switch to it. For
most filesystems, it is probably trivial. The only real difference is
that the "iterate_shared" directory walker is called with the
directory inode->i_rwsem held for reading, rather than for writing.

End result: there can be multiple concurrent "readdir" iterators
running on the same directory at the same time. But there's still
exclusion wrt things like file creation, so a filesystem doesn't have
to worry about that.

Also, the concurrency is only between different 'struct file'
entities. The file position lock still serializes all getdents() calls
on any individual open directory 'struct file'.

End result: most filesystems probably can move to the 'iterate_shared'
version with no real issues.

Looking at coda in particular, I don't see any reason to not just
switch over to 'iterate_shared' with no code modifications at all.
Nothing in there seems to have any "I rely on the directory inode
being exclusively locked".

In fact, for coda in particular, it would be really nice if we could
just get rid of the old "iterate" function for the host filesystem
entirely. Which honestly I'd expect you could _also_ do, because
almost all serious local filesystems have long since been converted.

So coda looks like it could trivially move over. But I might be
missing something.

I suspect the same is true of most other filesystems, but it requires
people go check and go think about it.

               Linus
