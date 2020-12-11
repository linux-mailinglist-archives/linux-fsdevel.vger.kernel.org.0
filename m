Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69F92D7D32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 18:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405646AbgLKRpT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 12:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405645AbgLKRpC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 12:45:02 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56EBC0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 09:44:21 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id w13so14446696lfd.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 09:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t6QHLULS092inRMkE/T6qBCbZqjvuVhsY2UsUXGyDPc=;
        b=TlAmXRbSItD78DbAxqIgNBckY5QwGGNV320UHUybbd3GsrH4jtkpi/xVkLEucIRdb+
         B+chqgu6KXNqXWIYRrlIqFELojEsGaRYMW6WdxVi7GQv+9e9BndWWtPrRlH2rsl0JLQn
         ltPUA7u1sLSNtwmMRQcC7AukbsSZtBXj28Www=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t6QHLULS092inRMkE/T6qBCbZqjvuVhsY2UsUXGyDPc=;
        b=Tu6LBMWkJ0xll0aQCBembeRHdOrd4Mn9PFJ6pf6y1HwYrPIKBhZf32+jHK8r0ahdJ0
         ssXRu/iDMNyWuPSDVnR1yTS7UDo2i5XoNX/CMY4O4GZmYI3Iy42eONjHMcq+XA1BXCl1
         ZgbonYHeU2GG60o7NknYX5RCrXg/3l0sk9+VrHokIowTb0Jap6Yg228UPxn2wI/Hb+Jt
         ZY7DDNL1VMcteFU9OhS/tFfJroY0RzdPnYFfB3UmWpzsM6kxmnjq2h3ds3UlltOmLYpa
         xhSB7vjEeZYDFOubumvCYGaWl+MsctS2M8J/Sy768lPvQ4yfNzpYCPhkryDMkAe7vtdH
         q6XQ==
X-Gm-Message-State: AOAM530Kka8sg6d8FdgOZ2S1gPwH3OCEvB9rANWngzPqojciQd/KBXql
        e9Z+edQX9P3nwkb2j6QJCxu0SOs860iwMg==
X-Google-Smtp-Source: ABdhPJzlRLWtlPQr7tvIeiQGyqMcI007fm5KehiFDJyZ3GUNUVyZm9Qp59pb0oewD7DvxIMI5LR4AQ==
X-Received: by 2002:a05:6512:20c9:: with SMTP id u9mr5575976lfr.280.1607708659953;
        Fri, 11 Dec 2020 09:44:19 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id d15sm962812lfn.169.2020.12.11.09.44.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 09:44:19 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 23so14448336lfg.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 09:44:18 -0800 (PST)
X-Received: by 2002:a19:8557:: with SMTP id h84mr4679254lfd.201.1607708658645;
 Fri, 11 Dec 2020 09:44:18 -0800 (PST)
MIME-Version: 1.0
References: <20201210200114.525026-1-axboe@kernel.dk> <20201210200114.525026-2-axboe@kernel.dk>
 <20201211023555.GV3579531@ZenIV.linux.org.uk> <bef3f905-f6b7-1134-7ca9-ff9385d6bf86@kernel.dk>
 <CAHk-=wjkA5Rx+0UjkSFQUqLJK9eRJ_MqoTZ8y2nyt4zXwE9vDg@mail.gmail.com> <20201211172931.GY3579531@ZenIV.linux.org.uk>
In-Reply-To: <20201211172931.GY3579531@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Dec 2020 09:44:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgPDdazXgYDo_zpKQNgCX7OM5Nw2RDOmU+6qnsUjUptVw@mail.gmail.com>
Message-ID: <CAHk-=wgPDdazXgYDo_zpKQNgCX7OM5Nw2RDOmU+6qnsUjUptVw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: add support for LOOKUP_NONBLOCK
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 11, 2020 at 9:29 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Again, that part is trivial - what to do with do_open()/open_last_lookups()
> is where the nastiness will be.  Basically, it makes sure we bail out in
> cases when lookup itself would've blocked, but it does *not* bail out
> when equally heavy (and unlikely) blocking sources hit past the complete_walk().

See my other email - while you are obviously correct from a "must
never sleep" standpoint, and from a general standpoint, from a
practical standpoint I suspect it really doesn't matter.

Exactly because it's not primarily a correctness issue, but a
performance issue - and because people wouldn't use this for things
like "open a named pipe that then blocks on the open side" use.

I do agree that maybe that LOOKUP_NONBLOCK might then want to be also
coupled with extra logic to also just fail if it turns out it's a
special device file or whatever - I just think that ends up being a
separate issue.

For example, in user space, we already have alternate methods for that
(ie O_NONBLOCK for fifo etc), and maybe io_uring wants that too.

               Linus
