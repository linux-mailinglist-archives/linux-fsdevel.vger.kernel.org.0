Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4289D28D62F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 23:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgJMVWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 17:22:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37603 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgJMVWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 17:22:32 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kSRka-0007PO-QI; Tue, 13 Oct 2020 21:22:28 +0000
Date:   Tue, 13 Oct 2020 23:22:28 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Giuseppe Scrivano <gscrivan@redhat.com>,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] fs, close_range: add flag CLOSE_RANGE_CLOEXEC
Message-ID: <20201013212228.gan6rcayveanujwd@wittgenstein>
References: <20201013140609.2269319-1-gscrivan@redhat.com>
 <20201013140609.2269319-2-gscrivan@redhat.com>
 <20201013205427.clvqno24ctwxbuyv@wittgenstein>
 <22ff41f8-c009-84f4-849b-a807b7382253@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22ff41f8-c009-84f4-849b-a807b7382253@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 13, 2020 at 11:04:21PM +0200, Rasmus Villemoes wrote:
> On 13/10/2020 22.54, Christian Brauner wrote:
> > On Tue, Oct 13, 2020 at 04:06:08PM +0200, Giuseppe Scrivano wrote:
> > 
> > Hey Guiseppe,
> > 
> > Thanks for the patch!
> > 
> >> When the flag CLOSE_RANGE_CLOEXEC is set, close_range doesn't
> >> immediately close the files but it sets the close-on-exec bit.
> > 
> > Hm, please expand on the use-cases a little here so people know where
> > and how this is useful. Keeping the rationale for a change in the commit
> > log is really important.
> > 
> 
> > I think I don't have quarrels with this patch in principle but I wonder
> > if something like the following wouldn't be easier to follow:
> > 
> > diff --git a/fs/file.c b/fs/file.c
> > index 21c0893f2f1d..872a4098c3be 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -672,6 +672,32 @@ int __close_fd(struct files_struct *files, unsigned fd)
> >  }
> >  EXPORT_SYMBOL(__close_fd); /* for ksys_close() */
> >  
> > +static inline void __range_cloexec(struct files_struct *cur_fds,
> > +				   unsigned int fd, unsigned max_fd)
> > +{
> > +	struct fdtable *fdt;
> > +	spin_lock(&cur_fds->file_lock);
> > +	fdt = files_fdtable(cur_fds);
> > +	while (fd <= max_fd)
> > +		__set_close_on_exec(fd++, fdt);
> 

(I should've warned that I just proposed this as a completely untested
brainstorm.)

> Doesn't that want to be
> 
>   bitmap_set(fdt->close_on_exec, fd, max_fd - fd + 1)
> 
> to do word-at-a-time? I assume this would mostly be called with (3, ~0U)
> as arguments or something like that.

Yes, that is the common case.

Thanks Rasmus, I was unaware we had that function.

In that case I think we'd actually need sm like:
spin_lock(&cur_fds->file_lock);
fdt = files_fdtable(cur_fds);
cur_max = files_fdtable(cur_fds)->max_fds - 1;
max_fd = min(max_fd, cur_max);
bitmap_set(fdt->close_on_exec, fd, max_fd - fd + 1)

so we retrieve max_fd with the spinlock held, I think.

Christian
