Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BED264EA56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 12:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiLPL0m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 06:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiLPL0k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:26:40 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBB4286D9
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 03:26:40 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id s9so2401993qtx.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 03:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a7C4DlTIJe/XAzDTApvBRiD8XTjnKR9AH5A3VoUGLOg=;
        b=NwQY0lOyux8zQdS9zMAo0gTIVBQw4Tpq5Bt9XfwxOWeeZoExJwK4JnJSNs6XbHTM+i
         Lv5bhR0Bu8KLvRSNai/hEYLSdT1W9Ro3qa4We7yN3/PP2J3AnHLZ4Lfu7LFF67Lx8MY2
         w+h/UW7V9V8UrlOYYhT/brFKFpP4g/HD7/LKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7C4DlTIJe/XAzDTApvBRiD8XTjnKR9AH5A3VoUGLOg=;
        b=vZRrJcSTjgMNgD0jvMPTlR3In+xMKiYL5NG8mHQbFMDbyHyDD8L7Q0ctAyK+i9lbVR
         UmSHsBhCiqqSosxygAJFSbkakwo3AuSzj7U5UzsZ9Kh9Sy8iKMXaZV3lm1tJOxcwLZ69
         5ywOu0J8jXQ9EqiJgrPlA2K5yPejU41OF3UlBTkLSc7hMdy9AVuZTAYimLnvttT9YP/4
         UwJHUfufpE4DCaGYBoDm1CGUu43pb44BuKpf9I0tWcKLH5aecBDF/LfbH+/+XIOXk/Px
         qgqzasZTG9bi0RsMq+mr8Yb1nuMJT8daiN4+Jo3gknExUcHiverKu3U9JFblsltb4Cl/
         en1A==
X-Gm-Message-State: AFqh2kpC7O9p2ZXwwVBmw3y3mI7+UNPv+HXYmDV1NwFkW9ZAqL6sNFZa
        /e1tVtxk8TJ9HZGVxyM8ifyzTqme1WdWm60M
X-Google-Smtp-Source: AMrXdXsEw7JEHxZOoh6zH8hla+AeWdxZdbt9Ief8Vuv+W55WAqk95DUOfj9eY8fZRSXQzIUt3xiuIw==
X-Received: by 2002:ac8:5214:0:b0:3a5:3234:cc7b with SMTP id r20-20020ac85214000000b003a53234cc7bmr3255156qtn.65.1671189998784;
        Fri, 16 Dec 2022 03:26:38 -0800 (PST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id v23-20020ac87497000000b003a689a5b177sm1204357qtq.8.2022.12.16.03.26.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 03:26:37 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id fu10so2462289qtb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 03:26:37 -0800 (PST)
X-Received: by 2002:ac8:4992:0:b0:3a7:648d:23d4 with SMTP id
 f18-20020ac84992000000b003a7648d23d4mr19675311qtq.180.1671189997363; Fri, 16
 Dec 2022 03:26:37 -0800 (PST)
MIME-Version: 1.0
References: <CAO4mrfcX8J73DWunmdYjf_SK5TyLfp9W9rmESTj57PCkG2qkBw@mail.gmail.com>
 <5eff70b8-04fc-ee87-973a-2099a65f6e29@opensource.wdc.com> <Y5s7F/4WKe8BtftB@ZenIV>
 <80dc24c5-2c4c-b8da-5017-31aae65a4dfa@opensource.wdc.com> <Y5vo00v2F4zVKeug@ZenIV>
In-Reply-To: <Y5vo00v2F4zVKeug@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Dec 2022 03:26:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgOFV=QmwWQW0QxDNkeDt4t5dOty7AvGyWRyj-O=8db9A@mail.gmail.com>
Message-ID: <CAHk-=wgOFV=QmwWQW0QxDNkeDt4t5dOty7AvGyWRyj-O=8db9A@mail.gmail.com>
Subject: Re: possible deadlock in __ata_sff_interrupt
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Wei Chen <harperchen1110@gmail.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzkaller@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
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

On Thu, Dec 15, 2022 at 7:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> CPU1: ptrace(2)
>         ptrace_check_attach()
>                 read_lock(&tasklist_lock);
>
> CPU2: setpgid(2)
>         write_lock_irq(&tasklist_lock);
>         spins
>
> CPU1: takes an interrupt that would call kill_fasync().  grep and the
> first instance of kill_fasync() is in hpet_interrupt() - it's not
> something exotic.  IRQs disabled on CPU2 won't stop it.
>         kill_fasync(..., SIGIO, ...)
>                 kill_fasync_rcu()
>                         read_lock_irqsave(&fa->fa_lock, flags);
>                         send_sigio()
>                                 read_lock_irqsave(&fown->lock, flags);
>                                 read_lock(&tasklist_lock);
>
> ... and CPU1 spins as well.

Nope. See kernel/locking/qrwlock.c:

        /*
         * Readers come here when they cannot get the lock without waiting
         */
        if (unlikely(in_interrupt())) {
                /*
                 * Readers in interrupt context will get the lock immediately
                 * if the writer is just waiting (not holding the lock yet),
                 * so spin with ACQUIRE semantics until the lock is available
                 * without waiting in the queue.
                 */
                atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
                return;
        }

and that's the new "civilized" reader unfairness.

The traditional rwlock was unconditionally unfair to writers, to the
point that there were starvation issues because new readers would
always get the lock.

         Linus
