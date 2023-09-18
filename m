Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762477A55E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 00:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjIRWsu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 18:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIRWst (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 18:48:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873E78F
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 15:48:43 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a645e54806so627958866b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 15:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695077322; x=1695682122; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i6hkJxO6NTkRAR4iA2oDJjG8smKCtYLtHbMWyNh04yg=;
        b=T+1f6dYqv0nzjEpx3+TC12OSCj4+hLoyud9bJb1zmJ1GxEbSorDSEJ3EhfSwRF76y7
         MWfUm4gZEL6Y59drabjdweuxaLlh6MWoX+tRV0WXGE+bzT6BNN8eJ4w3wblQwQQscKVz
         Fsexi2j//mOymCRzhMJbpbIP7Y8mEACoS1Vcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695077322; x=1695682122;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6hkJxO6NTkRAR4iA2oDJjG8smKCtYLtHbMWyNh04yg=;
        b=QKN6HAlYYbybeCDVVSkswKSXwInwpF5pEyfrD8UmT/0b+ChkbgXzDHq4k1moOPjQI/
         k4y8Y0Asit9CqLqAIDNbRvNbm6zy+nanRjRTRsj2CgyDZ+voJ+TU1NnXX9jsrR/Sg/k6
         Lye+Y+nQneeRU2lMEX0bcKkpCDwMmqO6PdvbtZk/l16AUZUNi5C67PP08Nr+aGMa/pDe
         uMiMNrlaeRdYvyHWwjSTux0o/3ZmCmHgRtEbC/1YvD8c0Ih8Yrd/Cwf46F1E3sNKsCAd
         SwRmaAF0UInJNqmHNE4SXIbX4+22fpKHq3BjpQbxCtBDVmCD4GfgMZxZdcLO6WzkobDR
         MqFQ==
X-Gm-Message-State: AOJu0Yx7yy37oJwO8ZLGII6+uVqmpw/kbMT53bldCez4LcKAozSU4x0/
        hf6ujOUbkSpFvpJEhbwLmppx5135vJLEUBWorylGcetZ
X-Google-Smtp-Source: AGHT+IEYli7ciNEaEAte7ocIKBL0t5lNr3ZQNkdL4rr9cIHtNliPRz+t5ZR+zhTHhKNgc6bPdno+9Q==
X-Received: by 2002:a17:906:18aa:b0:9a5:a543:274f with SMTP id c10-20020a17090618aa00b009a5a543274fmr8383604ejf.69.1695077321767;
        Mon, 18 Sep 2023 15:48:41 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id br13-20020a170906d14d00b0099cf9bf4c98sm7079435ejb.8.2023.09.18.15.48.41
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 15:48:41 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-53087f0e18bso4535644a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 15:48:41 -0700 (PDT)
X-Received: by 2002:a05:6402:4c4:b0:525:76fc:f559 with SMTP id
 n4-20020a05640204c400b0052576fcf559mr8082482edw.41.1695077320907; Mon, 18 Sep
 2023 15:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <ZQTfIu9OWwGnIT4b@dread.disaster.area> <db57da32517e5f33d1d44564097a7cc8468a96c3.camel@HansenPartnership.com>
 <169491481677.8274.17867378561711132366@noble.neil.brown.name>
 <CAHk-=wg_p7g=nonWOqgHGVXd+ZwZs8im-G=pNHP6hW60c8=UHw@mail.gmail.com>
 <20230917185742.GA19642@mit.edu> <CAHk-=wjHarh2VHgM57D1Z+yPFxGwGm7ubfLN7aQCRH5Ke3_=Tg@mail.gmail.com>
 <20230918111402.7mx3wiecqt5axvs5@quack3> <CAHk-=whB5mjPnsvBZ4vMn7A4pkXT9a5pk4vjasPOsSvU-UNdQg@mail.gmail.com>
 <nycvar.YFH.7.76.2309182127480.14216@cbobk.fhfr.pm> <CAHk-=whoKiqEThggu_HA5VA9wXPTBxdUBdkt+n_rNu8XaFy1oA@mail.gmail.com>
 <ZQi4E_3b6MrJQSXs@mit.edu>
In-Reply-To: <ZQi4E_3b6MrJQSXs@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Sep 2023 15:48:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wizOtVCZCcUvC3F+GFxcTfj1D3qL2yzCfd7YRnntY0=pQ@mail.gmail.com>
Message-ID: <CAHk-=wizOtVCZCcUvC3F+GFxcTfj1D3qL2yzCfd7YRnntY0=pQ@mail.gmail.com>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Jiri Kosina <jikos@kernel.org>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.de>,
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

On Mon, 18 Sept 2023 at 13:51, Theodore Ts'o <tytso@mit.edu> wrote:
>
> Fortunately, I most of the "simple" file systems appear to support
> mmap, via generic_file_mmap:

Yes, but that is in fact exactly the path that causes the most
complexity for the buffer cache: it needs that "readpage" function
that in turn then uses mpage_readpage() and friends to create the
buffers all in the same page.

And then - in order for normal read/write to not have any buffer
aliases, and be coherent - they too need to deal with that "group of
buffers in the same page" situation too.

It's not a *big* amount of complexity, but it's absolutely the most
complicated part of the buffer cache by far, in how it makes buffer
heads not independent of each other, and how it makes some of the
buffer cache depend on the page lock etc.

So the mmap side is what ties buffers heads together with the pages
(now folios), and it's not pretty. we have a number of loops like

        struct buffer_head *bh = head;
        do {
                .. work on bh ..
                bh = bh->b_this_page;
        } while (bh != head);

together with rules for marking buffers and pages dirty / uptodate /
whatever hand-in-hand.

Anyway, all of this is very old, and all of it is quite stable. We had
mmap support thanks to these games even before the page cache existed.

So it's not _pretty_, but it works, and if we can't just say "we don't
need to support mmap", we're almost certainly stuck with it (at least
if we want mappings that stay coherent with IO).

               Linus
