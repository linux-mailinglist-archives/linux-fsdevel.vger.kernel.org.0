Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244FA440DB3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Oct 2021 10:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhJaJ4a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Oct 2021 05:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhJaJ43 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Oct 2021 05:56:29 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE05C061714
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Oct 2021 02:53:58 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id n11so4862451iod.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Oct 2021 02:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JGqPbm7tO1VICGqBd/Inpku02T8Zpei3T3QkIwLq8SM=;
        b=NFDharSlF3D7NuTEJXRJ8w1Nw3SZHAaCzfkcDT5CT6rfiXYtDzilMrsQgn011HIyU7
         SBn4ifDKNfvIZKJnFskWTEKWZoHV958/U3+Ke8Q4NOi+fXSfab4ycifxdCvZSDTmxxiz
         +2UTEMDRiOsegVhCHVAQrNmalAfQD3BpeOtDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JGqPbm7tO1VICGqBd/Inpku02T8Zpei3T3QkIwLq8SM=;
        b=m+Jz0rizzuef6JyeEyt/CZD7wEzgYR3w9kOS/VsugpUpFx/eMlHr71rc3FoH5F692Y
         TA+3C+sQ9wCcjDUKEYZSVD/nqm9zPHp7nRg2Ie2xlyv5fVxCkDF1iPttOSucZnTcPgBv
         UWhBwuqmcB87FV7DDXwKnptPmx/3fhuad9qTdW8yCuOEISua7NbIWDkIEWeRt0p3mXmg
         y+/JL80QMJO1KR8yRgos14oiuBiRNOJytiHUCU2bE65clYAkiJrFL8n/Bv+IMHmBo+Oz
         1HAlDm4aiCJlXfRVhTll9fV9BpPLtL00zlPevxHO1pThUyzBcChOh3otY+Ek5x6s3Lwn
         Ac5g==
X-Gm-Message-State: AOAM531cEHW+wegHRHx+ya06b74CRK15/bw74m1REUDJ4Mq9JoV8eR1Z
        dOewSslzX6qEtFcy+ghSbFz3pQ==
X-Google-Smtp-Source: ABdhPJyd9nJTh/xtnuU20jE0Eo7UMVdEDWKaC6h7c/trM5RBR3EgdftWHrZXdAyUnYqkQC7ZilG0uA==
X-Received: by 2002:a5e:8911:: with SMTP id k17mr14660691ioj.63.1635674037235;
        Sun, 31 Oct 2021 02:53:57 -0700 (PDT)
Received: from ircssh-3.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id w6sm6628345ilv.63.2021.10.31.02.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 02:53:56 -0700 (PDT)
Date:   Sun, 31 Oct 2021 09:53:55 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Eric Wong <e@80x24.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        willy@infradead.org, arnd@kernel.org,
        Willem de Bruijn <willemb@google.com>
Subject: Re: epoll may leak events on dup
Message-ID: <20211031095355.GA15963@ircssh-3.c.rugged-nimbus-611.internal>
References: <20211030100319.GA11526@ircssh-3.c.rugged-nimbus-611.internal>
 <20211031073923.M174137@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211031073923.M174137@dcvr>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 31, 2021 at 07:39:23AM +0000, Eric Wong wrote:
> Sargun Dhillon <sargun@sargun.me> wrote:
> > I discovered an interesting behaviour in epoll today. If I register the same 
> > file twice, under two different file descriptor numbers, and then I close one of 
> > the two file descriptors, epoll "leaks" the first event. This is fine, because 
> > one would think I could just go ahead and remove the event, but alas, that isn't 
> > the case. Some example python code follows to show the issue at hand.
> >
> > I'm not sure if this is really considered a "bug" or just "interesting epoll
> > behaviour", but in my opinion this is kind of a bug, especially because leaks
> > may happen by accident -- especially if files are not immediately freed.
> 
> "Interesting epoll behavior" combined with a quirk with the
> Python wrapper for epoll.  It passes the FD as epoll_event.data
> (.data could also be any void *ptr, a u64, or u32).
> 
> Not knowing Python myself (but knowing Ruby and Perl5 well); I
> assume Python developers chose the safest route in passing an
> integer FD for .data.  Passing a pointer to an arbitrary
> Perl/Ruby object would cause tricky lifetime issues with the
> automatic memory management of those languages; I expect Python
> would have the same problem.
> 

Python was just chosen as a way to have some inline code to explain the problem. 
Python has a bunch of libraries that will properly manage epoll under the hood, 
but the point was to describe the "leak" behaviour, where you cannot (easily) 
free up the registered epoll_event.

It was shorter inline code than C. :).

> > I'm also not sure why epoll events are registered by file, and not just fd.
> > Is the expectation that you can share a single epoll amongst multiple
> > "users" and register different files that have the same file descriptor
> 
> No, the other way around.  Different FDs for the same file.
> 
> Having registration keyed by [file+fd] allows users to pass
> different pointers for different events to the same file;
> which could have its uses.
> 
> Registering by FD alone isn't enough; since the epoll FD itself
> can be shared across fork (which is of limited usefulness[1]).
> Originaly iterations of epoll were keyed only by the file;
> with the FD being added later.
> 
> > number (at least for purposes other than CRIU). Maybe someone can shed
> > light on the behaviour.
> 
> CRIU?  Checkpoint/Restore In Userspace?
> 
Right, in CRIU, epoll is restored by manually cloning the FDs to the
right spot, and re-installing the events into epoll. This requires:
0. Getting the original epoll FD
1. Fetching / recreating the original FD
2. dup2'ing it to right spot (and avoiding overwriting the original epoll FD)
3. EPOLL_CTL_ADD'ing the FD back in.

> 
> [1] In contrast, kqueue has a unique close-on-fork behavior
>     which greatly simplifies usage from C code (but less so
>     for high-level runtimes which auto-close FDs).

Perhaps a question for epoll developers and maintains, how would you feel about 
the idea of adding a new set of commands that allow the user to add / mod / del 
by arbitrary key. For example, EPOLL_CTL_ADD_BY_KEY, EPOLL_CTL_MOD_BY_KEY, 
EPOLL_CTL_DEL_BY_KEY, and instead the fd argument would be an arbitrary key, and 
the object for add would be:


struct epoll_event_with_fd {
	uint32_t	fd;	
	epoll_data_t	data;
}

EPOLL_CTL_MOD_BY_KEY and EPOLL_CTL_DEL_BY_KEY would just treat the fd argument 
as a key. In order for this not to be horrible (IMHO), we would have to make
epoll run in a mode where only one event can be registered for a given key.

Then the rb_tree key, instead of being:
struct epoll_filefd {
	struct file *file;
	int fd;
} __packed;

would be:
struct epoll_filefd {
	struct file *file;
	union {
		int fd;
		int key;
	}
} __packed;

Perhaps this is rambly, and code / patches are required for better articulation,
but I guess the whole idea "fd is the key" for entries in epoll seems weird to
me, and I'm wondering if people would be open to changing the API at this point
in time.
