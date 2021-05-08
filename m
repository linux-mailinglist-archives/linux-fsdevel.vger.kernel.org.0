Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DA1377466
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 May 2021 00:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhEHWnh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 May 2021 18:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhEHWnb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 May 2021 18:43:31 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE21FC061761
        for <linux-fsdevel@vger.kernel.org>; Sat,  8 May 2021 15:42:28 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t11so17869382lfl.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 May 2021 15:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8qvrf78C1VckxwN+Rd5iRKXM/TVBAx3SQ0yt8T9W1XI=;
        b=DHL714aYp4X3y/ZDPD/BxJq1zv4WKtKia+ktMgIzEElXklJlzicJbZPsvSVxT/1xq/
         ll2tgIA7+11guksgQhLfWHypKFmuq96HS2x73V3P8fR1NgWiz+KeFKOCZmlgoTLzSEA6
         tLX8U9qAEO26/nlzd5qfUVlzthZNMMtHZNWBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8qvrf78C1VckxwN+Rd5iRKXM/TVBAx3SQ0yt8T9W1XI=;
        b=gWoq+KqBbzk2FDp1w9iJPoTaqa18fYB9YjLep3qU/fn6WN7+oLCwl5YRxyvr0Hej9V
         uUDoJozmjf+FUToTYMYwMQhCaUuS0BO8TklKRp+JnjQxDKYv5mxUlIXVjZQMUMq4U9aW
         m7DoqsZhQAMJQoRnOBwyeWH2LIUaLowEqUV6z3RhXdmUa619JRa2yi+WdHI0TBD8HfcY
         r9eG+M8FYlLLT8orVgjSedrJVltI/ctAfVWBI5FfNhD2iLnPUHvYfsbwaiAkUA2QlCMX
         K5OjA2OHkBAboYINaxWZGbB7NS/Dyg6MdO1CiugN1+gvzMRNguHbWuX7D5E6mt0vdsP/
         fQGg==
X-Gm-Message-State: AOAM531SoX/iSuhOtvqqTb9s+CVnfrTnx9kbKIoufkw+bDdGPzl52JZy
        TLOKGv0c4Z8kpHhZFkOVYuMVKSTKFHfunLhAfWw=
X-Google-Smtp-Source: ABdhPJyH7zgAvMUotdHOZ2oUlVkMSRqdAVj42MQ7B/sdGHWLVCh2CfsEJ/nJS7X8igjzt/lRMZB7ag==
X-Received: by 2002:a05:6512:452:: with SMTP id y18mr11795276lfk.429.1620513747311;
        Sat, 08 May 2021 15:42:27 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 124sm1735874lfm.275.2021.05.08.15.42.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 15:42:27 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id v6so16157291ljj.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 May 2021 15:42:27 -0700 (PDT)
X-Received: by 2002:a19:c30b:: with SMTP id t11mr11039558lff.421.1620513735912;
 Sat, 08 May 2021 15:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210508122530.1971-1-justin.he@arm.com> <20210508122530.1971-2-justin.he@arm.com>
 <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
 <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk> <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
 <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk>
In-Reply-To: <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 May 2021 15:42:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhrhkWbV_EY0gupi2ea7QHpGW=68x7g09j_Tns5ZnsLA@mail.gmail.com>
Message-ID: <CAHk-=wjhrhkWbV_EY0gupi2ea7QHpGW=68x7g09j_Tns5ZnsLA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] fs: introduce helper d_path_fast()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jia He <justin.he@arm.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@ftp.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 8, 2021 at 2:06 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, if we go that way, I would make that
>
>         while (dentry != root->dentry || &mnt->mnt != root->mnt) {
>                 int error;
>                 struct dentry *parent = READ_ONCE(dentry->d_parent);

Side note: you've added that READ_ONCE() to the parent reading, and I
think that's a bug-fix regardless. The old code does that plain

                parent = dentry->d_parent;

(after doing the mountpoint stuff). And d_parent isn't actually
guaranteed stable here.

It probably does not matter - we are in a RCU read-locked section, so
it's not like parent will go away, but in theory we might end up with
(for example) pre-fetching a different parent than the one we then
walk down.

But your READ_ONCE() is definitely the right thing to do (whether we
do your re-org or not, and whether we do this "prepend_buffer" thing
or not).

Do you want to do a final version with your fixes?

               Linus
