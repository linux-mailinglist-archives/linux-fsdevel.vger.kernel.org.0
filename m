Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCB41C2F80
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 May 2020 23:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgECVe6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 May 2020 17:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729104AbgECVe6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 May 2020 17:34:58 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFF1C061A0E
        for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2020 14:34:56 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id x16so1946830oop.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 May 2020 14:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=IgTeF+LVkrmnHGOkyt/OzpDEYF5QYc9hbEmPaYioyu0=;
        b=qSOkuJHDBtR/oPMjvTGnHm5RKzGT0BPqeqGc8PygnC+CxUQh1J/V27Lt+QCrnJeGYz
         VTCSSMWuPLtKkQgYnI0C1CUkFO7RPiCcq/KFyt1yMS/sTaCLx4zxHC4qMNoq8cOa9PmI
         iSeRyh5SzK7IEgxPoQYk+7zNivYvvZbLTTkFkuz/FcaAcWzMPAa8LcRTPuV+sZ2RPDoS
         wkSQa96IfVrbw/gingwHEyBxmaRZEAfVdLbhO7tGs5YkOhH/wTgw/F5kkl9D8RYw5AVY
         sqAT7QT4JNol1CDs1oB/mHabGch4Ay+XG8txQ5ePb3PClxCECdMB/NrBleSrY6RH9UWn
         5AYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=IgTeF+LVkrmnHGOkyt/OzpDEYF5QYc9hbEmPaYioyu0=;
        b=sEuFhzxWShDaJO6dREVI5H05fvwhtXc6zakyLP3Kmnd0dYzaMQb2VgaFUa6mS+fjIR
         ND3DqzT5JhT4w4fXeeWNhhwyotQr4eMigfjSIPaMczcCKu3wIQaTAA8HHsqmf4PIXCS1
         sf6/e7QSnvYFfOB4lmWOi3fPYckMopxUbaMGjtYBnd+DvT3+K6YVScfxjnRRQEG8boXt
         PSlUkomwBx5iDVjoguC+GHrIeu+54fYIsfX2H+QW2l3Qypo12pl20Us9SOB8THOW6WxN
         jSaCCgcOC6CMiZ1ussn+Atkg8IllHJyQFG/5/7/PJekokIRzJUzkAgg4++dbeAX1nXaw
         6Sdg==
X-Gm-Message-State: AGi0PubNf/7sa4s2tjN9WwkhH84pORnBwi5uiSTuVRiM+SqJHFiq3MKt
        DBnUBoYH+o0OW64u0C96iq5yYQ==
X-Google-Smtp-Source: APiQypIhrXkS38NaBOw0Ubh4BR6oaPPy8n2CZ8sy6uuHzXloQ+3ERxcPAvt2P2jIBybO3uvRtqnhRQ==
X-Received: by 2002:a4a:274f:: with SMTP id w15mr5041010oow.93.1588541694956;
        Sun, 03 May 2020 14:34:54 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 80sm2693094otd.35.2020.05.03.14.34.53
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 03 May 2020 14:34:54 -0700 (PDT)
Date:   Sun, 3 May 2020 14:34:39 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-mm <linux-mm@kvack.org>, miklos <mszeredi@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Andre Almeida <andrealmeid@collabora.com>
Subject: Re: [fuse-devel] fuse: trying to steal weird page
In-Reply-To: <20200503102742.GF29705@bombadil.infradead.org>
Message-ID: <alpine.LSU.2.11.2005031421230.4028@eggly.anvils>
References: <87a72qtaqk.fsf@vostro.rath.org> <877dxut8q7.fsf@vostro.rath.org> <20200503032613.GE29705@bombadil.infradead.org> <87368hz9vm.fsf@vostro.rath.org> <20200503102742.GF29705@bombadil.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 3 May 2020, Matthew Wilcox wrote:
> On Sun, May 03, 2020 at 09:43:41AM +0100, Nikolaus Rath wrote:
> > Here's what I got:
> > 
> > [  221.277260] page:ffffec4bbd639880 refcount:1 mapcount:0 mapping:0000000000000000 index:0xd9
> > [  221.277265] flags: 0x17ffffc0000097(locked|waiters|referenced|uptodate|lru)
> > [  221.277269] raw: 0017ffffc0000097 ffffec4bbd62f048 ffffec4bbd619308 0000000000000000
> > [  221.277271] raw: 00000000000000d9 0000000000000000 00000001ffffffff ffff9aec11beb000
> > [  221.277272] page dumped because: fuse: trying to steal weird page
> > [  221.277273] page->mem_cgroup:ffff9aec11beb000
> 
> Great!  Here's the condition:
> 
>         if (page_mapcount(page) ||
>             page->mapping != NULL ||
>             page_count(page) != 1 ||
>             (page->flags & PAGE_FLAGS_CHECK_AT_PREP &
>              ~(1 << PG_locked |
>                1 << PG_referenced |
>                1 << PG_uptodate |
>                1 << PG_lru |
>                1 << PG_active |
>                1 << PG_reclaim))) {
> 
> mapcount is 0, mapping is NULL, refcount is 1, so that's all fine.
> flags has 'waiters' set, which is not in the allowed list.  I don't
> know the internals of FUSE, so I don't know why that is.

That list of PG_flags dates back to 2010: which 2016's 62906027091f
("mm: add PageWaiters indicating tasks are waiting for a page bit")
ought to have updated.  Though it's understandable that it did not:
surprising to find a list of PG_flags outside of mm/ and fs/proc/.
Just add PG_waiters to the list and the issue should go away.

> 
> Also, page_count() is unstable.

Agreed: fine to back out if page_count() is high,
but not good to issue a worrying warning about it.

> Unless there has been an RCU grace period
> between when the page was freed and now, a speculative reference may exist
> from the page cache.  So I would say this is a bad thing to check for.
> 
> Thanks for the swift provision of the debugging data!
