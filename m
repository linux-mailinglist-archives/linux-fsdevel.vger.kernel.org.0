Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7D47A50EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 19:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjIRR0x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 13:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIRR0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:26:52 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9017DB
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 10:26:45 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b962535808so76336231fa.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 10:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695058004; x=1695662804; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1k/7HPsRc+s4sU3sVF0r8fu4Hc5FoXfKZQpu2fNyRCw=;
        b=O/2Ugd+OP8LjThJF8TUAFqhA5ghleGztH/BFUs3XwsQ0lRPA3gfcTPT+X6wlWVKwH0
         n7+Vk4u4fbFgcklw4lPkHAMRCys8eXOQe6eT35wXzxMD5BMTRtcg682g+LydW/8izBbX
         U4qPlkGVFkW3ECwhWdnY1GxrjFHUT0vZA7T1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695058004; x=1695662804;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1k/7HPsRc+s4sU3sVF0r8fu4Hc5FoXfKZQpu2fNyRCw=;
        b=q+3j68CjL0/Rj4EXExlZoR6408Sz+flQr36HpbXmiQK2cGb4FryfCDf3/fku0Utj6R
         2eJwG4flrBlaWqSlH/mApzVfZqoCgbffd0LQU5zfpJcGLSzbZxINvUnprWq1AfNw3fI6
         NOiF32l0Fbo5ReKtIEkGjs/qWgn/nNPysJQxovF7KB18hAlkRsWFo7CzQ+fOteAOX8eX
         RkEVk9NDmJv5I+qFN0jGacpS+HkZMkaddLUNB2rl2Z3R/A/DCHF0HIXQSvfSGV7VZ41p
         7BYye3zCpE4wDpmjQG34cXiBcUbFqb9/wEzCRvTfbfA4Q3ZNhuvix3tPFnBRwTHhED9+
         h09A==
X-Gm-Message-State: AOJu0Yxjipib16CQJ5Y0dYbi8AQcB3ITTA24K53pVhEnYlVKrkDsEa3A
        clsu93GL3P7JCoEoYzycpczwOyLZbPixfCsLSmqKqn4Z
X-Google-Smtp-Source: AGHT+IGhsM6jjHfjg73MCjYyODAdEFfVXuISfs8Sl4ovjviLKYu5jxEE+TaW57rIAdQKqnUFgqwXfg==
X-Received: by 2002:a2e:330b:0:b0:2bc:d09c:853a with SMTP id d11-20020a2e330b000000b002bcd09c853amr7637832ljc.6.1695058003889;
        Mon, 18 Sep 2023 10:26:43 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id dv7-20020a170906b80700b0099b8234a9fesm6767726ejb.1.2023.09.18.10.26.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 10:26:43 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-52c88a03f99so5531683a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 10:26:42 -0700 (PDT)
X-Received: by 2002:a50:ee84:0:b0:523:38ea:48bb with SMTP id
 f4-20020a50ee84000000b0052338ea48bbmr8827319edr.24.1695058002123; Mon, 18 Sep
 2023 10:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <ZPlFwHQhJS+Td6Cz@dread.disaster.area> <20230907071801.1d37a3c5@gandalf.local.home>
 <b7ca4a4e-a815-a1e8-3579-57ac783a66bf@sandeen.net> <CAHk-=wg=xY6id92yS3=B59UfKmTmOgq+NNv+cqCMZ1Yr=FwR9A@mail.gmail.com>
 <ZQTfIu9OWwGnIT4b@dread.disaster.area> <db57da32517e5f33d1d44564097a7cc8468a96c3.camel@HansenPartnership.com>
 <169491481677.8274.17867378561711132366@noble.neil.brown.name>
 <CAHk-=wg_p7g=nonWOqgHGVXd+ZwZs8im-G=pNHP6hW60c8=UHw@mail.gmail.com>
 <20230917185742.GA19642@mit.edu> <CAHk-=wjHarh2VHgM57D1Z+yPFxGwGm7ubfLN7aQCRH5Ke3_=Tg@mail.gmail.com>
 <20230918111402.7mx3wiecqt5axvs5@quack3>
In-Reply-To: <20230918111402.7mx3wiecqt5axvs5@quack3>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Sep 2023 10:26:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whB5mjPnsvBZ4vMn7A4pkXT9a5pk4vjasPOsSvU-UNdQg@mail.gmail.com>
Message-ID: <CAHk-=whB5mjPnsvBZ4vMn7A4pkXT9a5pk4vjasPOsSvU-UNdQg@mail.gmail.com>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, NeilBrown <neilb@suse.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
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

On Mon, 18 Sept 2023 at 04:14, Jan Kara <jack@suse.cz> wrote:
>
> I agree. On the other hand each filesystem we carry imposes some
> maintenance burden (due to tree wide changes that are happening) and the
> question I have for some of them is: Do these filesystems actually bring
> any value?

I wouldn't be shocked if we could probably remove half of the
filesystems I listed, and nobody would even notice.

But at the same time, the actual upside to removing them is pretty
much zero. I do agree with you that reiserfs had issues - other than
the authorship - that made people much more inclined to remove it.

I'm looking at something like sysv, for example - the ancient old
14-byte filename thing. Does it have a single user? I really couldn't
tell. But at the same time, looking at the actual changes to it, they
fall into three categories:

 - trivial tree-wide changes - things like spelling fixes, or the SPDX
updates, or some "use common helpers"

 - VFS API updates, which are very straightforward (because sysvfs is
in no way doing anything odd)

 - some actual updates by Al Viro, who I doubt uses it, but I think
actually likes it and has some odd connection to it

anyway, I went back five years, and didn't see a single thing that
looked like "that was wasted time and effort".  There's a total of 44
patches over five years, so I'm looking at that filesystem and getting
a very strong feeling of "I think the minimal effort to maintain it
has been worth it".

Even without a single user, there's a history there, and it would be
sad to leave it behind. Exactly because it's _so_ little effort to
just keep.

Now, some of the other filesystems have gotten much more work done to
them - but it's because people have actively worked on them. rmk
actually did several adfs patch-series of cleanups etc back in 2019,
for example. Other than that, adfs seems to actually have gotten less
attention than sysvfs did, but I think that is probably because it
lacked the "Al Viro likes it" factor.

And something like befs - which has no knight in shining armor that
cares at all - has just a very small handful of one-liner patches for
VFS API changes.

So even the completely unloved ones just aren't a *burden*.

Reiserfs does stand out, as you say. There's a fair amount of actual
bug fixes and stuff there, because it's much more complicated, and
there were presumably a lot more complicated uses of it too due to the
history of it being an actual default distro filesystem for a while.

And that's kind of the other side of the picture: usage matters.
Something like affs or minixfs might still have a couple of users, but
those uses would basically be people who likely use Linux to interact
with some legacy machine they maintain..  So the usage they see would
mainly be very simple operations.

And that matters for two reasons:

 (a) we probably don't have to worry about bugs - security or
otherwise - as much. These are not generally "general-purpose"
filesystems. They are used for data transfer etc.

 (b) if they ever turn painful, we might be able to limit the pain further.

For example, mmap() is a very important operation in the general case,
and it actually causes a lot of potential problems from a filesystem
standpoint. It's one of the main sources of what little complexity
there is in the buffer head handling, for example.

But mmap() is *not* important for a filesystem that is used just for
data transport. I bet that FAT is still widely used, for example, and
while exFAT is probably making inroads, I suspect most of us have used
a USB stick with a FAT filesystem on it in the not too distant past.
Yet I doubt we'd have ever even noticed if 'mmap' didn't work on FAT.
Because all you really want for data transport is basic read/write
support.

And the reason I mention mmap is that it actually has some complexity
associated with it. If you support mmap, you have to have a read_folio
function, which in turn is why we have mpage_readpage(), which in turn
ends up being a noticeable part of the buffer cache code - any minor
complexity of the buffer cache does not tend to be about the
individual bh's themselves, but about the 'b_this_page' traversal, and
how buffers can be reached not just with sb_bread() and friends, but
are reachable from the VM through the page they are in.

IOW, *if* the buffer cache ever ends up being a big pain point, I
suspect that we'd still not want to remove ir, but it might be that we
could go "Hmm. Let's remove all the mmap support for the filesystems
that still use the buffer cache for data pages, because that causes
problems".

I think, for example, that ext4 - which obviously needs to continue to
support mmap, and which does use buffer heads in other parts - does
*not* use the buffer cache for actual data pages, only for metadata. I
might be wrong.

Anyway, based on the *current* situation, I don't actually see the
buffer cache even _remotely_ painful enough that we'd do even that
thing. It's not a small undertaking to get rid of the whole
b_this_page stuff and the complexity that comes from the page being
reachable through the VM layer (ie writepages etc). So it would be a
*lot* more work to rip that code out than it is to just support it.

         Linus
