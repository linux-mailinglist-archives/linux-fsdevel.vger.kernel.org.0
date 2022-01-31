Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EA24A4C3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 17:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380516AbiAaQfR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 11:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380512AbiAaQfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:35:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9C0C061714;
        Mon, 31 Jan 2022 08:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uxNZYP3LGCky/ZKmDFz/8zNFJ/WaFMrh5Ih+cZEMlts=; b=XZVTYtHjrOi/dz9ct7Y6VN7aL+
        igs/tFjbkhhZiIlBOBWn1fOIDa49M5C+aKAyluZFWKsDn4ZLtTqUt/9fLr5QO3lQ3G2CvpZMHD6p9
        uA4aDjgsMbmXxHST4Punkm+KumfyRKFStZRe/JHF40DHKG2oCCFtenKt9gXMhAgXlUhWr/mMSZUzo
        nJq4iw4fI8iipgcT1jmL1sYgkuOhGmLqV0uelUIuAThItlKHUGkhBfVQ6KwoRJlw7AWrO0M6uAdpj
        oyZq+teZb44xsQ2q5NWYscPCA9k1UC4JUC6GlfyiK8AdR33L18xRB1CMAnIKDNIPj1bP97Jo/NsJ1
        7I3bVl/w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEZe4-00AAB1-JG; Mon, 31 Jan 2022 16:35:12 +0000
Date:   Mon, 31 Jan 2022 16:35:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH] binfmt_elf: Take the mmap lock when walking the VMA list
Message-ID: <YfgPwPvopO1aqcVC@casper.infradead.org>
References: <20220131153740.2396974-1-willy@infradead.org>
 <871r0nriy4.fsf@email.froward.int.ebiederm.org>
 <YfgKw5z2uswzMVRQ@casper.infradead.org>
 <877dafq3bw.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dafq3bw.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 10:26:11AM -0600, Eric W. Biederman wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
> > On Mon, Jan 31, 2022 at 10:03:31AM -0600, Eric W. Biederman wrote:
> >> "Matthew Wilcox (Oracle)" <willy@infradead.org> writes:
> >> 
> >> > I'm not sure if the VMA list can change under us, but dump_vma_snapshot()
> >> > is very careful to take the mmap_lock in write mode.  We only need to
> >> > take it in read mode here as we do not care if the size of the stack
> >> > VMA changes underneath us.
> >> >
> >> > If it can be changed underneath us, this is a potential use-after-free
> >> > for a multithreaded process which is dumping core.
> >> 
> >> The problem is not multi-threaded process so much as processes that
> >> share their mm.
> >
> > I don't understand the difference.  I appreciate that another process can
> > get read access to an mm through, eg, /proc, but how can another process
> > (that isn't a thread of this process) modify the VMAs?
> 
> There are a couple of ways.
> 
> A classic way is a multi-threads process can call vfork, and the
> mm_struct is shared with the child until exec is called.

While true, I thought the semantics of vfork() were that the parent
was suspended.  Given that, it can't core dump until the child execs
... right?

> A process can do this more deliberately by forking a child using
> clone(CLONE_VM) and not including CLONE_THREAD.   Supporting this case
> is a hold over from before CLONE_THREAD was supported in the kernel and
> such processes were used to simulate threads.

That is a multithreaded process then!  Maybe not in the strict POSIX
compliance sense, but the intent is to be a multithreaded process.
ie multiple threads of execution, sharing an address space.

> It also happens that there are subsystems in the kernel that do things
> like kthread_use_mm that can also be modifying the mm during a coredump.

Yikes.  That's terrifying.  It's really legitimate for a kthread to
attach to a process and start tearing down VMAs?

> > Uhh .. that seems like it needs a lot more understanding of binfmt_elf
> > than I currently possess.  I'd rather spend my time working on folios
> > than learning much more about binfmt_elf.  I was just trying to fix an
> > assertion failure with the maple tree patches (we now assert that you're
> > holding a lock when walking the list of VMAs).
> 
> Fair enough.  I will put it on my list of things to address.

Thanks.  Now that I've disclosed it's a UAF, I hope you're able to
get to it soon.  Otherwise we should put this band-aid in for now
and you can address it properly in the fullness of time.
