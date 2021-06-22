Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1113B0CAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 20:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhFVSS1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 14:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFVSSX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:18:23 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C687FC061574;
        Tue, 22 Jun 2021 11:16:07 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t9so17772572pgn.4;
        Tue, 22 Jun 2021 11:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LvlqUd76IAy9L7kdhodL+NG05Os6O0cVnFr95gFkQvM=;
        b=NFhodhGHGGFBpXeVNZ3VtVimQGMgS4j13UL3omISPfnTJdZmAAcssg5FkMCjZJ6GtY
         2emg4vs+l1ZiKR6HrdAPmh6nIInlpAwJcOk4dWMvavgDZVfpF03nRY9QGNnXnz7XklF8
         wLYXVBBk8Cyqp/xoszIZxZ4xPs66gNVNIE0nVoTHZoouQE214nqTxGrkCDceq/XhfXo8
         3W91ZZsHxpiT5BdwB/v+veZaU5UYn1HnkhbStmXbLibp62yBmPLQWQDvn45V6suoPnTQ
         3wn2r9gaaqc33TMzVVqCMAiyqpyGjByUVsT9wtgTQHQrk0hsnuc/YsUIiwDLi1vcF3k3
         Nvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LvlqUd76IAy9L7kdhodL+NG05Os6O0cVnFr95gFkQvM=;
        b=msCfgefXFyZkaPYSGrnbR9580xbzw6UVJ2aK9LTpfPsii3SLN5lGBm1fGKC1WjHocf
         rn3eqvNE1YkGiJ8LLw7U4EMDI6rLWNnbJBV6LFfWlMvNAaee1w2wvpQ6kJWCb6UxQprJ
         GBPtAM0y/Cg+TXEAtnAo/qcsl89NpQtHRFu/WdqzGuhyW+YcOlUIAzUCIu7wIxhDqlXy
         dgPB2mWwBso/5zwWReVoQ141B4sJSQlwJ3L2eiBZ8nhliFV+xkinHbu4CyQ9qSZPkgJx
         gnnBKAcw8rRkYsaapD0eEugK0sdqEHPF9MzrdzvqfsqV/ZzlrigltgZmKuowapMpLENx
         MKrA==
X-Gm-Message-State: AOAM531aA4tfcuzjyOzMyUyHn6vKQL5+HDAYfYYE8cLXou7Hwzc4RkvC
        +Z9HIqIPwJ7w9zJWelN/zw43N3tbTMSW1Q==
X-Google-Smtp-Source: ABdhPJycAUB8Y1J8RSIc/cFA/fer7B+da2ICW/wH5DbTzVV8vS8ArfYM8UTJ8N9qR49CebfnJIr6XQ==
X-Received: by 2002:a65:5ac9:: with SMTP id d9mr5042005pgt.293.1624385767083;
        Tue, 22 Jun 2021 11:16:07 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id c3sm42759pfl.42.2021.06.22.11.16.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jun 2021 11:16:06 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CAHk-=wicC9ZTNNH1E-oHebcT3+r4Q4Wf1tXBindXrCdotj20Gg@mail.gmail.com>
Date:   Tue, 22 Jun 2021 11:16:03 -0700
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ted Ts'o <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <437C30AA-2256-4F4F-9CC0-363A21DB1044@gmail.com>
References: <CAHk-=wh=YxjEtTpYyhgypKmPJQ8eVLJ4qowmwbnG1bOU06_4Bg@mail.gmail.com>
 <3221175.1624375240@warthog.procyon.org.uk>
 <YNIBb5WPrk8nnKKn@zeniv-ca.linux.org.uk>
 <YNIDdgn0m8d2a0P3@zeniv-ca.linux.org.uk>
 <YNIdJaKrNj5GoT7w@casper.infradead.org>
 <3231150.1624384533@warthog.procyon.org.uk>
 <YNImEkqizzuStW72@casper.infradead.org>
 <CAHk-=wicC9ZTNNH1E-oHebcT3+r4Q4Wf1tXBindXrCdotj20Gg@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 22, 2021, at 11:07 AM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>=20
> On Tue, Jun 22, 2021 at 11:05 AM Matthew Wilcox <willy@infradead.org> =
wrote:
>>=20
>> Huh?  Last I checked, the fault_in_readable actually read a byte from
>> the page.  It has to wait for the read to complete before that can
>> happen.
>=20
> Yeah, we don't have any kind of async fault-in model.
>=20
> I'm not sure how that would even look. I don't think it would
> necessarily be *impossible* (special marker in the exception table to
> let the fault code know that this is a "prepare" fault), but it would
> be pretty challenging.

I did send an RFC some time ago for =E2=80=9Cprepare=E2=80=9D fault, but =
it the RFC
requires some more work.

https://lore.kernel.org/lkml/20210225072910.2811795-1-namit@vmware.com/

