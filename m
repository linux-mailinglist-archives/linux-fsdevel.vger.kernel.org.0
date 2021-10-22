Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01410437EF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 21:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbhJVUBI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 16:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbhJVUBG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:01:06 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFBBC061764
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 12:58:48 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bq11so4889151lfb.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 12:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OyTESXkijXq7pnJGTLADUG+9VskuYUOHv78z9I+1K/4=;
        b=hM/XQhqnuwClqFHl0xmMUwVFiZI2zWX0Fsvmyov2HtrZf+eht/rZgRbn7tgV6JR5/t
         oaUf+A7xemNq2BqlSo7CgdMlfz4uNIfFdFMMG/GRhS1ONKFBhEIzCT11CSLKS+TAVP9U
         qBUMJuZF6FSADRHZc19vWgXXWGONFvtcXh0sM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OyTESXkijXq7pnJGTLADUG+9VskuYUOHv78z9I+1K/4=;
        b=TZbUimVP9IRU4ucj2oXNdihiMdbf0fvK2drnMZL34MDP6CG7XCSt/DRiE+vVsWbtr4
         1B+toOc7eTAjyxZsod33lGv1BdrHp5Hsu0BhoZ1cx6hQvuWZLSeMeDXj1PbIughg9QW+
         WTuQDaXPEjWm/a+g/Jv8kHmWSWiZdBNaIqzlOut/X13RKj3/g/FOWX7Q/f9eag3453p3
         XCXmPXkl99k8RIe7zS+foXAi5gM5Le1lcmjq0MurDRdjN+5E+jznctsOtn7XLhShRwg7
         v8Ed5glRfK4ImBDEYRldv7N1Qzmzsthx9ksto7a7Sb4arxrWEDHVyqHaMcZ/T248rKV/
         C0Uw==
X-Gm-Message-State: AOAM530iMkz/2WsQbKz5nE16eV20ZT76gbL1t/csNIHRd4DG3CZ0xF1l
        BpYV6V/iiozbQhFZWinQlRFuf/IiCZCmodQ4vmU=
X-Google-Smtp-Source: ABdhPJxOUXna890qImqqWymnMDINDNzaxIckM8wjA3veoXjtMkMcagvc9KnQeVwZHnkHQk43tUJWww==
X-Received: by 2002:a05:6512:4027:: with SMTP id br39mr1589943lfb.549.1634932726323;
        Fri, 22 Oct 2021 12:58:46 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id u4sm814912lfs.153.2021.10.22.12.58.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 12:58:43 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id n7so682253ljp.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 12:58:39 -0700 (PDT)
X-Received: by 2002:a2e:5cc7:: with SMTP id q190mr2066391ljb.494.1634932708154;
 Fri, 22 Oct 2021 12:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
 <CAHk-=wjmx7+PD0hzWj5Bg2b807xYD2KCZApTvFje=ufo+MxBMQ@mail.gmail.com> <1041557.1634931616@warthog.procyon.org.uk>
In-Reply-To: <1041557.1634931616@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Oct 2021 09:58:12 -1000
X-Gmail-Original-Message-ID: <CAHk-=wg2LQtWC3e4Z4EGQzEmsLjmk6jm67Ga6UMLY1MH6iDcNQ@mail.gmail.com>
Message-ID: <CAHk-=wg2LQtWC3e4Z4EGQzEmsLjmk6jm67Ga6UMLY1MH6iDcNQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/53] fscache: Rewrite index API and management system
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@kernel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        ceph-devel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 9:40 AM David Howells <dhowells@redhat.com> wrote:
>
> What's the best way to do this?  Is it fine to disable caching in all the
> network filesystems and then directly remove the fscache and cachefiles
> drivers and replace them?

So the basic issue with this whole "total rewrite" is that there's no
way to bisect anything.

And there's no way for people to say "I don't trust the rewrite, I
want to keep using the old tested model".

Which makes this all painful and generally the wrong way to do
anything like this, and there's fundamentally no "best way".

The real best way would be if the conversion could be done truly
incrementally. Flag-days simply aren't good for development, because
even if the patch to enable the new code might be some trivial
one-liner, that doesn't _help_ anything. The switch-over switches from
one code-base to another, with no help from "this is where the problem
started".

So in order of preference:

 (a) actual incremental changes where the code keeps working all the
time, and no flag days

 (b) same interfaces, so at least you can do A/B testing and people
can choose one or the other

 (c) total rewrite

and if (c) is the thing that all the network filesystem people want,
then what the heck is the point in keeping dead code around? At that
point, all the rename crap is just extra work, extra noise, and only a
distraction. There's no upside that I can see.

                   Linus
