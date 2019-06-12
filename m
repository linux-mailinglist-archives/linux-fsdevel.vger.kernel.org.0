Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11AE742A66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 17:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440010AbfFLPKN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 11:10:13 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44313 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437304AbfFLPKN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:10:13 -0400
Received: by mail-yb1-f196.google.com with SMTP id x187so6502399ybc.11;
        Wed, 12 Jun 2019 08:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=whA1MTQ/AQLJNqb+5D2QO/K0h7g3p7yYZHms0D8AcfU=;
        b=hmGDYtb1Cvfqgb4T8epuX9aN30ElC4h99ZBYD8BBT0avdBTjncS4lUxyO+zfy8KkCK
         T97FVMy1zM5VsDq8K7VULsHhBE52+BTYqYBVXlr6AQ1uUxiDgUw4GK0lxQZOht2bRcBN
         +rGCva5D+rL5e/UxLFyI3371rg2jO99mQO4BpwGgL9ThWCFl5VfGUKMPWZHjklipXyLZ
         YkZQYqQkX0Ahy/Uvmr9SvJnkilaHPQhb0ZLFH0olf28/vCDGQ21R5IXSlwksY6d8ZeK2
         z4lEkOuTLoWvZrOKFLo3TIL2U5CF1rN3Ofw37L1hOvvFx7ch+35uWk2cUWsAjKKjd59A
         rfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whA1MTQ/AQLJNqb+5D2QO/K0h7g3p7yYZHms0D8AcfU=;
        b=S2L06v4TmF8RFQja8aef4iCllDMqve7yTZw3aKrQRXTu5pNqy2pHC6Y4w5lE+OoSXt
         YWugBQjqTtBN4Iu8XiKvZhL0OQGDKQqYrNtCSVQX3xajOovp3RR63Nfq6XSJOK2Hjrfl
         yglqYTMUtaJd+eJnYyAPEd1/qDhjQ8BZO8dOaJDYZbHIst/EVo6HgtnXJphlk4I+gIns
         RroUmd28bJFEp6vjE4gGAmfVaMNoWSiEKEjPw3A2CKNYeyR0fJFImId+nkjIM3EH3FGV
         g6mtkiPYU6tSkKAOUIrS+uhCcnJNWfythwo7gdLD+2hWRPSd/vyqxxhzyxuN02i92XyZ
         l5BQ==
X-Gm-Message-State: APjAAAUTywwpoqWqhsa1bWX0OhaOAUv3cpdsxb81yf9zUR37D+t2WcAc
        OsAUkfcCn4ngE676P400Xz2bJ/iTcvDfX2EekWI=
X-Google-Smtp-Source: APXvYqzZvBvyZY1onRqoKdTzhjMQBcY5zXvQ3lzUyJcP7f0JpG1CqEEQwmFIgdsy1KIyP5VwvJNgqQw2E6ZOEWIahoI=
X-Received: by 2002:a25:8109:: with SMTP id o9mr36591180ybk.132.1560352212349;
 Wed, 12 Jun 2019 08:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190608135717.8472-1-amir73il@gmail.com> <20190608135717.8472-2-amir73il@gmail.com>
 <1560343899.4578.9.camel@linux.ibm.com>
In-Reply-To: <1560343899.4578.9.camel@linux.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 12 Jun 2019 18:09:59 +0300
Message-ID: <CAOQ4uxhooVwtHcDCr4hu+ovzKGUdWfQ+3F3nbgK3HXgV+fUK9w@mail.gmail.com>
Subject: Re: [PATCH 1/2] vfs: replace i_readcount with a biased i_count
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 12, 2019 at 3:52 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Sat, 2019-06-08 at 16:57 +0300, Amir Goldstein wrote:
> > Count struct files open RO together with inode reference count instead
> > of using a dedicated i_readcount field.  This will allow us to use the
> > RO count also when CONFIG_IMA is not defined and will reduce the size of
> > struct inode for 32bit archs when CONFIG_IMA is defined.
> >
> > We need this RO count for posix leases code, which currently naively
> > checks i_count and d_count in an inaccurate manner.
> >
> > Should regular i_count overflow into RO count bias by struct files
> > opened for write, it's not a big deal, as we mostly need the RO count
> > to be reliable when the first writer comes along.
>
> "i_count" has been defined forever.  Has its meaning changed?  This
> patch implies that "i_readcount" was never really needed.
>

Not really.
i_count is only used to know if object is referenced.
It does not matter if user takes 1 or more references on i_count
as long as user puts back all the references it took.

If user took i_readcount, i_count cannot be zero, so short of overflow,
we can describe i_readcount as a biased i_count.

But if I am following Miklos' suggestion to make i_count 64bit, inode
struct size is going to grow for 32bit arch when  CONFIG_IMA is not
defined, so to reduce impact, I will keep i_readcount as a separate
member and let it be defined also when BITS_PER_LONG == 64
and implement inode_is_open_rdonly() using d_count and i_count
when i_readcount is not defined.

Let's see what people will have to say about that...

Thanks,
Amir.
