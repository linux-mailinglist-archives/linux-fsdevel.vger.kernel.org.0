Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80756917A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 05:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjBJErb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 23:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjBJEr3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:47:29 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897C45B74E
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Feb 2023 20:47:27 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v13so3781412eda.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Feb 2023 20:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cvwfcddns9wEYGMGsoiElla/fMiugMdLW+ZU2vKhB7Q=;
        b=M9jqvy9vqZ7GIvN6X0r0tJPRyNR5XsTBKWs09APkXPouATgMG65O1fuTD3jATxsfcO
         Gysz8LgLqGc+GXmEgZ5girBmCfhrAfMolnWCqDSAvI42pkfVsZE28km43Yn3Tgr1ltQY
         uAos7n6XK3oEQ5ve/fwxQ53u1Uz9Wz2cNjh+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cvwfcddns9wEYGMGsoiElla/fMiugMdLW+ZU2vKhB7Q=;
        b=C7igiTLYnxwGhtboosqiKqHrPDP35H9rPCmFz08O5xTXOuIqrTzaVUIij1RVcXZX4q
         s4JYUiaaT6zAtv3K354f9R0HtLKqHZLJ1zqXcQLxkD9xI6zH+9PICCWOJRSEojd4xKqK
         JsmkNKcq7J5EZtCLwVmlwpAMWG3ko4ZmaiFHsFr9nJnDxKE2jfX/Cr+nmcNIBzlc6uOj
         igeRs+TX+wavjC9ID3O1lQdkiP4+qTw+tGjzktpGX7Mlitb/eiP1Xarn5PzeL0iIGDbv
         YJU+MDecv1USO81TpIVxiJvz9FtxpTTe84q+xVw3NM1u289m3evkfohtyXYzrTO45V/y
         gohw==
X-Gm-Message-State: AO0yUKWUSywNNnF6TVAOANu4QiakmuQF9E1m7Oq5qgFRBgsH+quV1QnP
        XBcSDaYrgirxZor3FSChx/PWIzMbHI9nDTUQB4E=
X-Google-Smtp-Source: AK7set8CI8AMC6sqLFcI/+egMz8juC9Ivhb85I5yfUNFLe6QNszRWPCHKvrLKFA9aG5B6bmR6blaBg==
X-Received: by 2002:a50:9517:0:b0:4ab:25a4:9a3d with SMTP id u23-20020a509517000000b004ab25a49a3dmr2743727eda.32.1676004445494;
        Thu, 09 Feb 2023 20:47:25 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id u19-20020a1709067d1300b0088b93bfa765sm1823645ejo.138.2023.02.09.20.47.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 20:47:24 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id q19so3847052edd.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Feb 2023 20:47:24 -0800 (PST)
X-Received: by 2002:a50:cc99:0:b0:4ab:66f:6de0 with SMTP id
 q25-20020a50cc99000000b004ab066f6de0mr2073831edi.5.1676004444332; Thu, 09 Feb
 2023 20:47:24 -0800 (PST)
MIME-Version: 1.0
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wj8rthcQ9gQbvkMzeFt0iymq+CuOzmidx3Pm29Lg+W0gg@mail.gmail.com>
 <20230210021603.GA2825702@dread.disaster.area> <20230210040626.GB2825702@dread.disaster.area>
In-Reply-To: <20230210040626.GB2825702@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Feb 2023 20:47:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wip9xx367bfCV8xaF9Oaw4DZ6edF9Ojv10XoxJ-iUBwhA@mail.gmail.com>
Message-ID: <CAHk-=wip9xx367bfCV8xaF9Oaw4DZ6edF9Ojv10XoxJ-iUBwhA@mail.gmail.com>
Subject: Re: copy on write for splice() from file to pipe?
To:     Dave Chinner <david@fromorbit.com>
Cc:     Stefan Metzmacher <metze@samba.org>, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API Mailing List <linux-api@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Samba Technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 9, 2023 at 8:06 PM Dave Chinner <david@fromorbit.com> wrote:
>>
> So while I was pondering the complexity of this and watching a great
> big shiny rocket create lots of heat, light and noise, it occurred
> to me that we already have a mechanism for preventing page cache
> data from being changed while the folios are under IO:
> SB_I_STABLE_WRITES and folio_wait_stable().

No, Dave. Not at all.

Stop and think.

splice() is not some "while under IO" thing. It's *UNBOUNDED*.

Let me just give an example: random user A does

   fd = open("/dev/passwd", O_RDONLY);
   splice(fd, NULL, pipefd, NULL, ..);
   sleep(10000);

and you now want to block all writes to the page in that file as long
as it's being held on to, do you?

So no.

The above is also why something like IOMAP_F_SHARED is not relevant.
The whole point of splice is to act as a way to communicate pages
between *DIFFERENT* subsystems. The only thing they have in common is
the buffer (typically a page reference, but it can be other things)
that is getting transferred.

A spliced page - by definition - is not in some controlled state where
one filesystem (or one subsystem like networking) owns it, because the
whole and only point of splice is to act as that "take data from one
random source and feed it in to another random destination", and avoid
the N*M complexity matrix of N sources and M destinations.

So no. We cannot block writes, because there is no bounded time for
them. And no, we cannot use some kind of "mark this IO as shared",
because there is no "this IO".

It is also worth noting that the shared behavior (ie "splice acts as a
temporary shared buffer") might even be something that people actually
expect and depend on for semantics. I hope not, but it's not entirely
impossible that people change the source (could be file data for the
above "splice from file" case, but could be your own virtual memory
image for "vmsplice()") _after_ splicing the source, and before
splicing it to the destination.

(It sounds very unlikely that people would do that for file contents,
but vmsplice() might intentionally use buffers that may be "live").

Now, to be honest, I hope nobody plays games like that. In fact, I'm a
bit sorry that I was pushing splice() in the first place. Playing
games with zero-copy tends to cause problems, and we've had some nasty
security issues in this area too.

Now, splice() is a *lot* cleaner conceptually than "sendfile()" ever
was, exactly because it allows that whole "many different sources,
many different destinations" model. But this is also very much an
example of how "generic" may be something that is revered in computer
science, but is often a *horrible* thing in reality.

Because if this was just "sendfile()", and would be one operation that
moves file contents from the page cache to the network buffers, then
your idea of "prevent data from being changed while in transit" would
actually be valid.

Special cases are often much simpler and easier, and sometimes the
special cases are all you actually want.

Splice() is not a special case. It's sadly a very interesting and very
generic model for sharing buffers, and that does cause very real
problems.

            Linus
