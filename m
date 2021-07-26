Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82E33D65B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 19:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241414AbhGZQrA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 12:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239792AbhGZQqz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:46:55 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0D3C09B129
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jul 2021 10:15:51 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id b21so12130250ljo.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jul 2021 10:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9nCFSPU1gol0E4rDrQO0oADKpQ2235snVgYBEAYRF9Y=;
        b=FxPJdanONOHHlkh8d+J5uVuVxTrNApcx9MiCzLB+nhd8tO35LqWJyHr+nxkh4eWigS
         ZNzz6/AWWNqMLc+6W91Fb7ndI1UZV6LZf2IS1/3v1vXYt+73u2Zxzb6gTHcdLl3xf0YV
         A1H174iotHYgi5TQ4Xu9vzheCPDn7kIx+3FPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9nCFSPU1gol0E4rDrQO0oADKpQ2235snVgYBEAYRF9Y=;
        b=dtrbaeVhL95Zzsb+sGw+wD2zvf4MUy5oR2H9V9I9vQQ2b7oNEui3jHaDAzPS/Uu0aw
         Q9MZ1RzdXXIrUnMxvxQqKi3VJyT6m+g+NacE4vs6wF7g/JWo98wPmWVRRnYVThN+/Ywi
         AT1m14CqUEJ8N7orOECIGlg3QkGF3jY902Ntk37LmMy5N/GCXeUTuxgnDJ3K73Neq06r
         ru5MMe9GJUwFlF3gTzKgwwIa5UKv9fmj25LwOZXDE0VBQdFbgY6wmsheSn6XYkOk4t/3
         86kyL8+VZxjZT2gNguwb3XiELeqFDuQ6jvfukf5pC5rsudojw6JSruw+Mma0o1Eqff0U
         sh0Q==
X-Gm-Message-State: AOAM5300iK2NGMOCFPrwxLYrnYQ7F9RXuqW3cx9tQNnVlEtzN4uMBAn2
        Ua7s9/hHB6JaImPr7wbpSmZ3QozDqDxyWA43
X-Google-Smtp-Source: ABdhPJyLVavvOH8kLUi3DXUCsBnZz7HcOvkAzy9uGwyDtYqcL9biCExt2t+/Nhy0efvMPYQuNwEiXA==
X-Received: by 2002:a2e:7319:: with SMTP id o25mr12611837ljc.264.1627319748883;
        Mon, 26 Jul 2021 10:15:48 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id g9sm54843lfh.95.2021.07.26.10.15.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 10:15:48 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id b21so12130113ljo.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jul 2021 10:15:47 -0700 (PDT)
X-Received: by 2002:a2e:3212:: with SMTP id y18mr12834084ljy.220.1627319747365;
 Mon, 26 Jul 2021 10:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210723205840.299280-1-agruenba@redhat.com> <20210723205840.299280-2-agruenba@redhat.com>
 <20210726163326.GK20621@quack2.suse.cz>
In-Reply-To: <20210726163326.GK20621@quack2.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Jul 2021 10:15:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqOZmRT_gmAS+K9sA7EYCKM9BYzvJMhy1_P6JaaVGvfA@mail.gmail.com>
Message-ID: <CAHk-=wgqOZmRT_gmAS+K9sA7EYCKM9BYzvJMhy1_P6JaaVGvfA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] iov_iter: Introduce fault_in_iov_iter helper
To:     Jan Kara <jack@suse.cz>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 26, 2021 at 9:33 AM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 23-07-21 22:58:34, Andreas Gruenbacher wrote:
> > +     gup_flags = FOLL_TOUCH | FOLL_POPULATE;
>
> I don't think FOLL_POPULATE makes sense here. It makes sense only with
> FOLL_MLOCK and determines whether mlock(2) should fault in missing pages or
> not.

Yeah, it won't hurt, but FOLL_POPULATE doesn't actually do anything
unless FOLL_MLOCK is set. It is, as you say, a magic flag just for
mlock.

The only ones that should matter are FOLL_WRITE (for obvious reasons)
and FOLL_TOUCH (to set the accessed and dirty bits, rather than just
th protection bits)

                   Linus
