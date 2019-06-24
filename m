Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5181C50946
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 12:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbfFXKxr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 06:53:47 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36927 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbfFXKxq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:53:46 -0400
Received: by mail-io1-f65.google.com with SMTP id e5so570002iok.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2019 03:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ihyVj9AIhaK8HPGk1OnxZEKSWZ3zvaM69CEDWZY4270=;
        b=kNvTBzS1kgK2pYWUqAL5lg8L1Jo2qcmxnVBYOFobN30s473diN3VjSH7n5IS7i5Dp3
         YpzhqyqJnIxYjmaxfwtrR5OlAea6PgdCi+lQPQCq1PCTfMG/s4Lxfc9mJz9pG0PXNBd2
         5qdBIMbzKJmhfDqrZVeYFV+G8oN4uaqsOlhccGxIU3v+S1dm+kNiQIHRZa+l4nEUwq0N
         AmEEu6nhKmIxIYxq5YBeP/PJNTgvWW0fCAik4F4zGdl+HlsWauq7KOD6doPwPKZbkaFZ
         Xr4qJyQ+RQ7bweR3FdMz8LG/Jus8IEyeOVv3pEJK77NqZ4Enj3Ekugk9irV1BbfS/PWD
         3g0w==
X-Gm-Message-State: APjAAAUItbcNRMWweH3xeMka6I9JDQEKAoxnSpNcM9cVUrReADb/Uwmw
        /et6V6IuE07Z73vUZJPj5PljoJilVlZ9TsfR7fyE6A==
X-Google-Smtp-Source: APXvYqxJ7VQx/5vlszbYxhrcE+AmHiH+fTrA2A9o0xXqBtLrWiYkGQw4oqtxmCEH7s7wCWiEVWWuSJO5tYSbMYTpKrg=
X-Received: by 2002:a6b:f711:: with SMTP id k17mr1753892iog.273.1561373625285;
 Mon, 24 Jun 2019 03:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190619123019.30032-1-mszeredi@redhat.com> <20190619123019.30032-5-mszeredi@redhat.com>
 <1ea8ec52ce19499f021510b5c9e38be8d8ebe38f.camel@themaw.net>
 <CAOssrKcU2JKDYMDbW7V6jpM7_4WFSMA91h9AjpjoYmX=H4ybeg@mail.gmail.com>
 <30205.1561372589@warthog.procyon.org.uk> <CAOssrKdGSRVSc38X1J0zCQQN+tUhiwPA4bCL0rHCZ-O8iVzzeQ@mail.gmail.com>
In-Reply-To: <CAOssrKdGSRVSc38X1J0zCQQN+tUhiwPA4bCL0rHCZ-O8iVzzeQ@mail.gmail.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 24 Jun 2019 12:53:34 +0200
Message-ID: <CAOssrKc=1FDpOzgpzO9dtkk2sTyq2VVL5ajqgowh4PafzQQJBg@mail.gmail.com>
Subject: Re: [PATCH 05/13] vfs: don't parse "silent" option
To:     David Howells <dhowells@redhat.com>
Cc:     Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 12:44 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> On Mon, Jun 24, 2019 at 12:36 PM David Howells <dhowells@redhat.com> wrote:
> >
> > Miklos Szeredi <mszeredi@redhat.com> wrote:
> >
> > > What I'm saying is that with a new interface the rules need not follow
> > > the rules of the old interface, because at the start no one is using
> > > the new interface, so no chance of breaking anything.
> >
> > Er. No.  That's not true, since the old interface comes through the new one.
>
> No, old interface sets SB_* directly from arg 4 of mount(2) and not
> via parsing arg 5.

See also 9p mess up of "posixacl" handling *on the old interface* due
to exactly because the internal API doesn't differentiate between
options coming from the old interface and ones coming from the new.

So you are right that there's breakage, but it's due to the fact that
common code parses anything, and not because it doesn't.

Thanks,
Miklos
