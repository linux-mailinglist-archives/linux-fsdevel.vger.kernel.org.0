Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2279289D69
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Oct 2020 04:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbgJJCKs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 22:10:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729975AbgJJBzc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 21:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602294931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZEq+9RUNCLcUowlY3rNV2I+fdNX5VdqF7iThjTKHAYU=;
        b=Zsjr9QjSBcUNNd4xyMv3oCnmSdfItWDhAMRt+KF2IX+ynuZS0ifDJQIVc+ZaTRu04e010n
        wf59G1JjISYuLbp+QQD59WYIb/li4NhgrMcUoPbFzx/i6q3yEyeUTVL/4S6i1U3C8MfNvo
        PJ5R656jxEmWLQ/GEMf2Zu+JjjKyOLo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-iD51xsXWOkmoDtx0CE8sLQ-1; Fri, 09 Oct 2020 21:55:27 -0400
X-MC-Unique: iD51xsXWOkmoDtx0CE8sLQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9583C1005513;
        Sat, 10 Oct 2020 01:55:25 +0000 (UTC)
Received: from shell-el7.hosts.prod.upshift.rdu2.redhat.com (shell-el7.hosts.prod.upshift.rdu2.redhat.com [10.0.15.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F36285D9FC;
        Sat, 10 Oct 2020 01:55:24 +0000 (UTC)
Received: by shell-el7.hosts.prod.upshift.rdu2.redhat.com (Postfix, from userid 2518)
        id 888946000432; Sat, 10 Oct 2020 01:55:24 +0000 (UTC)
Date:   Sat, 10 Oct 2020 01:55:24 +0000
From:   Alexander Viro <aviro@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Alexander Viro <aviro@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        the arch/x86 maintainers <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 05/14] fs: don't allow kernel reads and writes without
 iter ops
Message-ID: <20201010015524.GB101464@shell-el7.hosts.prod.upshift.rdu2.redhat.com>
References: <20200903142242.925828-1-hch@lst.de>
 <20200903142242.925828-6-hch@lst.de>
 <20201001223852.GA855@sol.localdomain>
 <20201001224051.GI3421308@ZenIV.linux.org.uk>
 <CAHk-=wgj=mKeN-EfV5tKwJNeHPLG0dybq+R5ZyGuc4WeUnqcmA@mail.gmail.com>
 <20201009220633.GA1122@sol.localdomain>
 <CAHk-=whcEzYjkqdpZciHh+iAdUttvfWZYoiHiF67XuTXB1YJLw@mail.gmail.com>
 <20201010011919.GC1122@sol.localdomain>
 <CAHk-=wigvcmp-jcgoNCbx45W7j3=0jA320CfpskwuoEjefM7nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wigvcmp-jcgoNCbx45W7j3=0jA320CfpskwuoEjefM7nQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 09, 2020 at 06:29:13PM -0700, Linus Torvalds wrote:
> On Fri, Oct 9, 2020 at 6:19 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > Okay, that makes more sense.  So the patchset from Matthew
> > https://lkml.kernel.org/linux-fsdevel/20201003025534.21045-1-willy@infradead.org/T/#u
> > isn't what you had in mind.
> 
> No.
> 
> That first patch makes sense - it's just the "ppos can be NULL" patch.
> 
> But as mentioned, NULL isn't "shorthand for zero". It's just "pipes
> don't _have_ a pos, trying to pass in some explicit position is
> crazy".
> 
> So no, the other patches in that set are a bit odd, I think.
> 
> SOME of them look potentially fine - the bpfilter one seems to be
> valid, for example, because it's literally about reading/writing a
> pipe. And maybe the sysctl one is similarly sensible - I didn't check
> the context of that one.

FWIW, I hadn't pushed that branch out (or merged it into #for-next yet);
for one thing, uml part (mconsole) is simply broken, for another...
IMO ##5--8 are asking for kernel_pread() and if you look at binfmt_elf.c,
you'll see elf_read() being pretty much that.  acct.c, keys and usermode
parts are asking for kernel_pwrite() as well.

I've got stuck looking through the drivers/target stuff - it would've
been another kernel_pwrite() candidate, but it smells like its use of
filp_open() is really asking for trouble, starting with symlink attacks.
Not sure - I'm not familiar with the area, but...

