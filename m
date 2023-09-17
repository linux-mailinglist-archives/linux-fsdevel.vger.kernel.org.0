Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C237A36DD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Sep 2023 19:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbjIQRby (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Sep 2023 13:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237433AbjIQRbY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Sep 2023 13:31:24 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2A0130
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Sep 2023 10:31:17 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50300e9e75bso1935270e87.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Sep 2023 10:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694971875; x=1695576675; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3LaHPsqUpXWOJt89sEmNMFWS6fftJzEZe6i+AFxGXb0=;
        b=WSNMC8RJGv2KazEFZ38qZO1fPpNntyvmfIGWzbLKUlc5SVDYgvPhsJnT5dN3G1nvbM
         6oHPRxIM7J93hflrlZY1J8lr4zI0QPnBcBevRTcy20w8/xHPJKaTAr3y4+syziecN7uG
         s4ojGfcS1x0wvxUEto+pikfLX4ZQfhlnu/diE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694971875; x=1695576675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3LaHPsqUpXWOJt89sEmNMFWS6fftJzEZe6i+AFxGXb0=;
        b=P6KMnLtMnegGEozj5JhljqTRU2gdU1oWV84TlfQ1p6MXQnnZkl/IE9OjXx/C1k8l2F
         GaPsne/1FdQ8NuglfQtwirU0c1U/OqSHNh0dNQVWn4tnR3q9dd7O4EqJEQHYfvoTlXKx
         tnyitB8YXXjykYvXCVOTUzrAbbocdHy2NdBQ8dX16XZ4AgJ5W+Bqvt9jnAM3xtGEOUgn
         95mp5O9hZSGTsKtKIL8oW6zDFX7hkHvQxgGvPxg+GTSsdv36ddcyselKc064eBpCRJCE
         rJKfnVgpzjfxn5DApI7jqGQLv5cfU9tG2Vpm/nWZZxPB0MH1/y5K7+f9XsqJqJJiOXwc
         wsvw==
X-Gm-Message-State: AOJu0YwjavNuYhm1IAYrr2w6yJs0G1/DHzPXTo0RhdLEAG1N+l9kCSNi
        eczvssszFklmCgMOhFFcXfkoO9FCubani/nEpiuZzR8O
X-Google-Smtp-Source: AGHT+IFNUiqVyl2SIvG9y+h3uxCf27vxGGZCxzEglFJFrU05jys5pqdhLJqpv80UUwiV+Cgcgz1/AQ==
X-Received: by 2002:a05:6512:2025:b0:4fd:d9dd:7a1a with SMTP id s5-20020a056512202500b004fdd9dd7a1amr5211223lfs.31.1694971875310;
        Sun, 17 Sep 2023 10:31:15 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id r6-20020a19ac46000000b004fe250e24a3sm1476745lfc.104.2023.09.17.10.31.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 10:31:14 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50308217223so1400146e87.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Sep 2023 10:31:13 -0700 (PDT)
X-Received: by 2002:a05:6512:20c4:b0:500:ac76:4a61 with SMTP id
 u4-20020a05651220c400b00500ac764a61mr5425444lfr.65.1694971873289; Sun, 17 Sep
 2023 10:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <ZO9NK0FchtYjOuIH@infradead.org> <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
 <ZPkDLp0jyteubQhh@dread.disaster.area> <20230906215327.18a45c89@gandalf.local.home>
 <ZPkz86RRLaYOkmx+@dread.disaster.area> <20230906225139.6ffe953c@gandalf.local.home>
 <ZPlFwHQhJS+Td6Cz@dread.disaster.area> <20230907071801.1d37a3c5@gandalf.local.home>
 <b7ca4a4e-a815-a1e8-3579-57ac783a66bf@sandeen.net> <CAHk-=wg=xY6id92yS3=B59UfKmTmOgq+NNv+cqCMZ1Yr=FwR9A@mail.gmail.com>
 <ZQTfIu9OWwGnIT4b@dread.disaster.area> <db57da32517e5f33d1d44564097a7cc8468a96c3.camel@HansenPartnership.com>
 <169491481677.8274.17867378561711132366@noble.neil.brown.name>
In-Reply-To: <169491481677.8274.17867378561711132366@noble.neil.brown.name>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Sep 2023 10:30:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_p7g=nonWOqgHGVXd+ZwZs8im-G=pNHP6hW60c8=UHw@mail.gmail.com>
Message-ID: <CAHk-=wg_p7g=nonWOqgHGVXd+ZwZs8im-G=pNHP6hW60c8=UHw@mail.gmail.com>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
To:     NeilBrown <neilb@suse.de>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 16 Sept 2023 at 18:40, NeilBrown <neilb@suse.de> wrote:
>
> I'm not sure the technical argument was particularly coherent.  I think
> there is a broad desire to deprecate and remove the buffer cache.

There really isn't.

There may be _whining_ about the buffer cache, but it's completely
misplaced, and has zero technical background.

The buffer cache is perfectly fine, and as mentioned, it is very
simple. It has absolutely no downsides for what it is.

Sure, it's old.

The whole getblk/bread/bwrite/brelse thing goes all the way back to
original unix, and in fact if you go and read the Lions' book, you'll
see that even in Unix v6, you have comments about some of it being a
relic:

    "B_RELOC is a relic" (p 68)
     http://www.lemis.com/grog/Documentation/Lions/book.pdf

and while obviously the Linux version of it is a different
re-implementation (based on reading _another_ classic book about Unix
-  Maurice Bach's "The Design of the UNIX Operating System"), the
basic notions aren't all that different. The detaisl are different,
the names have been changed later ("sb_bread()" instead of "bread()"),
and it has some extra code to try to do the "pack into a page so that
we can also mmap the result", but in the end it's the exact same
thing.

And because it's old, it's kind of limited. I wouldn't expect a modern
filesystem to use the buffer cache.

IOW, the buffer cache is simple and stupid. But it's literally
designed for simple and stupid old filesystems.

And simple and stupid old filesystems are often designed for it.

Simple and stupid is not *wrong*. In fact, it's often exactly what you want.

Being simple and stupid, it's a physically indexed cache. That's all
kinds of slow and inefficient, since you have to first look up the
physical location of a data file to even find the cached copy of the
data.

It's not fancy.

It's not clever.

But the whole "broad desire to deprecate and remove" is complete and utter BS.

The thing is, the buffer cache is completely pain free, and nobody
sane would ever remove it. That's a FACT. Do these two operations

      wc fs/buffer.c fs/mpage.c
      git grep -l 'struct.buffer_head'

and ponder.

And here's a clue-bat for anybody who can't do the "ponder" part
above: the buffer cache is _small_, it's _simple_, and it has
basically absolutely no effect on anything except for the filesystems
that use it.

And the filesystems that use it are old, and simple, but they are many
(this one is from "grep -w sb_bread", in case people care - I didn't
do any kind of fancier analysis):

      adfs, affs, befs, bfs, efs, exfat, ext2, ext4, f2fs, fat,
      freevxfs, hfs, hpfs, isofs, jfs, minix, nilfs2, ntfs, ntfs3, omfs,
      qnx4, qnx6, reiserfs, romfs, sysv, udf, ufs

And the other part of that "pondering" above, is to look at what the
impact of the buffer cache is *outside* those filesystems that use it.

And here's another clue-bat: it's effectively zero.  There's a couple
of lines in the VM. There's a couple of small helpers functions in
fs/direct-io.c. That's pretty much it.

In other words, the buffer cache is

 - simple

 - self-contained

 - supports 20+ legacy filesystems

so the whole "let's deprecate and remove it" is literally crazy
ranting and whining and completely mis-placed.

And yes, *within* the context of a filesystem or two, the whole "try
to avoid the buffer cache" can be a real thing.

Looking at the list of filesystems above, I would not be surprised if
one or two of them were to have a long-term plan to not use the buffer
cache.

But that in no way changes the actual picture.

Was this enough technical information for people?

And can we now all just admit that anybody who says "remove the buffer
cache" is so uninformed about what they are speaking of that we can
just ignore said whining?

                    Linus
