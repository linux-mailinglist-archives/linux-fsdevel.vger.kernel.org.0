Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E657A5371
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 21:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjIRT7u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 15:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjIRT7q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:59:46 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652D510A
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 12:59:37 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bff7d81b5eso34141671fa.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 12:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695067175; x=1695671975; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IfqbVkGHBoZGHryAINIdEudRrkAyBzkbimgGl4E0yt8=;
        b=QrXZZ2ImZvub/eV7U5iJ1ZOh4K3oFix42bsiG6eP7SFF3f2fdZIHYkdYMMgtTLYF21
         sskr9rrWkRqB/796Qm4fZwm0UJb4EadDQXTnRMN5AB6WbI5wzBRAg87AnyNUnyazLuOG
         FdfdJYgI9ZbT1ZQFdPijnggoAg5mZQjV/+g1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695067175; x=1695671975;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfqbVkGHBoZGHryAINIdEudRrkAyBzkbimgGl4E0yt8=;
        b=IGPT2LvdubE5K+VbTuQDB/QKelcTrsaWpM9dEvu57aAVjA1E1C7VO5yLec8F7xKn99
         b/+89tUp/Nq4wlmJEsfbuzG7Tb3/JxyXZDbtSQxeuwbKuHQ8FQaR6FVP6fOaoKVNpojF
         0KpJ0TN0Af4Sa88FM65Xom4gZHz06k+EbmADPeGF641Hx4N6sKMJG/bNQu417URjBhaZ
         SDWXFCR4XnBa8KjKY1TMjhB+v+zYAb45A2AeNIRfs+k+xoiB1R7ZEKIRufH/dXjvPvsN
         wudGMmtD5fwb9sBl3JSYT988I9aKD600o+9Kfd9GWwxC27u+HvIKLXVrgQMpPy+4kyoU
         fYBg==
X-Gm-Message-State: AOJu0Yy3qt1po8N48DtCzOXMpJQ5f1NJvp2Xy1udgr2XDTVpB+N7kkes
        /lWNiBitHCy5bKyOlegPJU/0lmTfwx7j/So/fDCtWvgv
X-Google-Smtp-Source: AGHT+IEm2+3xfvovM5nEp4EoWMwJJkhOZ9htyiRhwAApVyedzhE4BXhDCJ4nKoj/+nXSTt/olrgQHA==
X-Received: by 2002:a2e:3614:0:b0:2bc:ffcd:8556 with SMTP id d20-20020a2e3614000000b002bcffcd8556mr9088834lja.12.1695067175516;
        Mon, 18 Sep 2023 12:59:35 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id d16-20020a2e3310000000b002b9e6d7f72fsm2233931ljc.5.2023.09.18.12.59.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 12:59:34 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-502153ae36cso7904653e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 12:59:33 -0700 (PDT)
X-Received: by 2002:a19:8c0b:0:b0:503:99d:5a97 with SMTP id
 o11-20020a198c0b000000b00503099d5a97mr4098028lfd.20.1695067173515; Mon, 18
 Sep 2023 12:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <ZPlFwHQhJS+Td6Cz@dread.disaster.area> <20230907071801.1d37a3c5@gandalf.local.home>
 <b7ca4a4e-a815-a1e8-3579-57ac783a66bf@sandeen.net> <CAHk-=wg=xY6id92yS3=B59UfKmTmOgq+NNv+cqCMZ1Yr=FwR9A@mail.gmail.com>
 <ZQTfIu9OWwGnIT4b@dread.disaster.area> <db57da32517e5f33d1d44564097a7cc8468a96c3.camel@HansenPartnership.com>
 <169491481677.8274.17867378561711132366@noble.neil.brown.name>
 <CAHk-=wg_p7g=nonWOqgHGVXd+ZwZs8im-G=pNHP6hW60c8=UHw@mail.gmail.com>
 <20230917185742.GA19642@mit.edu> <CAHk-=wjHarh2VHgM57D1Z+yPFxGwGm7ubfLN7aQCRH5Ke3_=Tg@mail.gmail.com>
 <20230918111402.7mx3wiecqt5axvs5@quack3> <CAHk-=whB5mjPnsvBZ4vMn7A4pkXT9a5pk4vjasPOsSvU-UNdQg@mail.gmail.com>
 <nycvar.YFH.7.76.2309182127480.14216@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2309182127480.14216@cbobk.fhfr.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Sep 2023 12:59:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whoKiqEThggu_HA5VA9wXPTBxdUBdkt+n_rNu8XaFy1oA@mail.gmail.com>
Message-ID: <CAHk-=whoKiqEThggu_HA5VA9wXPTBxdUBdkt+n_rNu8XaFy1oA@mail.gmail.com>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 18 Sept 2023 at 12:32, Jiri Kosina <jikos@kernel.org> wrote:
>
> I am afraid this is not reflecting reality.
>
> I am pretty sure that "give me that document on a USB stick, and I'll take
> a look" leads to using things like libreoffice (or any other editor liked
> by general public) to open the file directly on the FAT USB stick. And
> that's pretty much guaranteed to use mmap().

Ugh. I would have hoped that anybody will fall back to read/write -
because we definitely have filesystems that don't support mmap.

But I guess they are so specialized as to not ever trigger that kind
of problem (eg /proc - nobody is putting office documents there ;)

A cache-incoherent MAP_PRIVATE only mmap (ie one that doesn't react to
'write()' changing the data) is easy to do, but yeah, it would still
be a lot more work than just "keep things as-is".

           Linus
