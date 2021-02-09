Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239783159B2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 23:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbhBIWuO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 17:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbhBIWhC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:37:02 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DDCC06121E
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Feb 2021 13:25:50 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id a25so95692ljn.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Feb 2021 13:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5NXrj70SaJJJRtMQWC0+3w4cmGywCfZjtndBL9rb8Bo=;
        b=g8n7RWB/hph+MNS6KsfC0GffC4feoLtbwfzXkMDO5VGlvyK682yT02RPRIOW6hieUR
         nxG1Mlzbyp5mtI1Do4dwBB4pr2NfNtLSNxuXGIfX+Az+7iAT6uxAH+/kuEuPZoNDiHrT
         JX8A9+J4I4DIw7KDC1ACDk8XTP+nwuXWBZL+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NXrj70SaJJJRtMQWC0+3w4cmGywCfZjtndBL9rb8Bo=;
        b=en2+GJYVow9iHg0BADkKtfMzOygxiShx1wlcFtAvVL7tff5tIlJcnT9dgsAN7je3t0
         8FCBZ1GW/RxwuV5TJtJBAatzSOA6RNdQjMTrNIRDNraIMMmriQ9FViFTkLZyffVe3XSo
         wRBx75+qsfxUJJ5wtBv7sbHlHDZW6021e4ehzT3ihrYeNEeyFuLEkXowqHjrSCamIRM9
         XUpS20Jw91+T0iANDYDVBjaImtFOhGUM0XBod5uqv6FRgMOwim+GjJLM1F8Y4tUowOdI
         YPqM3VvbXXJDCtp0BgsnwclrwHcjOELnqA0PuxVtBEG0Aodl4zpADunvChVN0oFqpOKA
         BIPg==
X-Gm-Message-State: AOAM531a/lTO3jr8KvieUVaHlv3lH2JRB6lu7uduJgIRoKqEyK6N3CkG
        Z22R8Xiw9a4D/5tfhFFYP2uPQWsJwiQIGQ==
X-Google-Smtp-Source: ABdhPJxKlMgkT1uzRGFd2YNwo2CT6pTWHQTChWtXM2jaagkDD0eIND05X+Y104zwD4LZD7sS1FylVw==
X-Received: by 2002:a05:651c:38f:: with SMTP id e15mr7762630ljp.420.1612905948824;
        Tue, 09 Feb 2021 13:25:48 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id w15sm1541850lfp.171.2021.02.09.13.25.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 13:25:48 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id h26so4317020lfm.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Feb 2021 13:25:48 -0800 (PST)
X-Received: by 2002:a2e:b1c8:: with SMTP id e8mr15253931lja.251.1612905557284;
 Tue, 09 Feb 2021 13:19:17 -0800 (PST)
MIME-Version: 1.0
References: <591237.1612886997@warthog.procyon.org.uk> <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com>
 <20210209202134.GA308988@casper.infradead.org>
In-Reply-To: <20210209202134.GA308988@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Feb 2021 13:19:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh+2gbF7XEjYc=HV9w_2uVzVf7vs60BPz0gFA=+pUm3ww@mail.gmail.com>
Message-ID: <CAHk-=wh+2gbF7XEjYc=HV9w_2uVzVf7vs60BPz0gFA=+pUm3ww@mail.gmail.com>
Subject: Re: [GIT PULL] fscache: I/O API modernisation and netfs helper library
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 9, 2021 at 12:21 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> Yeah, I have trouble with the private2 vs fscache bit too.  I've been
> trying to persuade David that he doesn't actually need an fscache
> bit at all; he can just increment the page's refcount to prevent it
> from being freed while he writes data to the cache.

Does the code not hold a refcount already?

Honestly, the fact that writeback doesn't take a refcount, and then
has magic "if writeback is set, don't free" code in other parts of the
VM layer has been a problem already, when the wakeup ended up
"leaking" from a previous page to a new allocation.

I very much hope the fscache bit does not make similar mistakes,
because the rest of the VM will _not_ have special "if fscache is set,
then we won't do X" the way we do for writeback.

So I think the fscache code needs to hold a refcount regardless, and
that the fscache bit is set the page has to have a reference.

So what are the current lifetime rules for the fscache bit?

             Linus
