Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55ADF39AAAB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 21:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhFCTKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 15:10:18 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:44921 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhFCTKR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 15:10:17 -0400
Received: by mail-qk1-f173.google.com with SMTP id h20so7001802qko.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jun 2021 12:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=j1A5KVJOcx2Sm/u6BzmYkKLVORkN+8973B9sz+toaOM=;
        b=DxJJe+sS3pZmKekJ7WUEU3udkpFiy/cthYRmwPXFXjO2t48zZcaDEQtfe95cyb0nh2
         Ty5LJLkKnflgq4BScb5FM3CWAhaiJnk88gFHBAgw+V0xG4eQgIXAJ2cEqTlQv0Icxmyy
         J2JTuNFMIYeACbppEwU/kYMwCZQ3/hVpN9M8bUunh9aeCxT+Py7p8K/dPdtb8O3avyQp
         dBK97ei4/1FXNfqBi+fKboPMNKZOz3dnRTPsxL8bBl8Rwe1coC5uyY0WSaUo7n3KIQyy
         HTXnFw32p9oV8LhjMDc0nSJpFKTLDdgrTosILMhS05fLozoUjpsUTe1Ok5390BX2f1nA
         2LrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=j1A5KVJOcx2Sm/u6BzmYkKLVORkN+8973B9sz+toaOM=;
        b=eHv4CHpUEcVV2nD/tjGuJCzDnePxZ6upO6USBR8PTtUb8/rls5O9EY3uwug6qRMbt9
         /uq27B3ndJe2CTvVwEtCxjzti7HgspVc2WhPru4ZWfrzSvXGj3yTHdL469MYS8AIWnLO
         uXzuXmXCykUAK21++YvckRnlOgymGA6VvdVEMzzMaWOOgJZ1MAEj9F31J+BvyDdhz01J
         p5sFHzHqexTPJmGvKyezVmjtaxNpRHp2Nw7pCjkt2BcJq+afmyioxYpz7rcSkAu5K3U6
         m8t875CvEcb+koXAuzNZeVYyv54N6RekPBBj7WlKG+S74mj2P2MuM2Y/DmdeaapXga8G
         yYuQ==
X-Gm-Message-State: AOAM533dmEHDufDgwbw+c8NQwHxC5CoT3r206HgVeAT8aXmgPUkcWB36
        PUC7mj0LmHd7AaF5PmZoAmfl7Q==
X-Google-Smtp-Source: ABdhPJy0iLvQA3EpRpciKhPlEkLxhoPyCANwdMooLs3uoQCCY5zReAZamVDSUB5Nz1XmH4UP27XScg==
X-Received: by 2002:ae9:f310:: with SMTP id p16mr697061qkg.267.1622747251960;
        Thu, 03 Jun 2021 12:07:31 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v8sm2451410qkg.102.2021.06.03.12.07.30
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 03 Jun 2021 12:07:31 -0700 (PDT)
Date:   Thu, 3 Jun 2021 12:07:18 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>, Ming Lin <mlin@kernel.org>,
        Simon Ser <contact@emersion.fr>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm: adds NOSIGBUS extension for out-of-band shmem
 read
In-Reply-To: <CAHk-=wiHJ2GF503wnhCC4jsaSWNyq5=NqOy7jpF_v_t82AY0UA@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2106031142250.11088@eggly.anvils>
References: <1622589753-9206-1-git-send-email-mlin@kernel.org> <1622589753-9206-3-git-send-email-mlin@kernel.org> <alpine.LSU.2.11.2106011913590.3353@eggly.anvils> <79a27014-5450-1345-9eea-12fc9ae25777@kernel.org> <alpine.LSU.2.11.2106021719500.8333@eggly.anvils>
 <CAHk-=wiHJ2GF503wnhCC4jsaSWNyq5=NqOy7jpF_v_t82AY0UA@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 3 Jun 2021, Linus Torvalds wrote:
> On Wed, Jun 2, 2021 at 5:46 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > Ideally you can simply call do_anonymous_page() from __do_fault()
> > in the VM_FAULT_SIGBUS on VM_NOSIGBUS case.
> 
> Heh.
> 
> We're actually then back to my original patch.
> 
> That one doesn't handle shared mappings (even read-only ones), for the
> simple reason that do_anonymous_page() refuses to insert anonymous
> pages into a shared mapping, and has
> 
>         /* File mapping without ->vm_ops ? */
>         if (vma->vm_flags & VM_SHARED)
>                 return VM_FAULT_SIGBUS;
> 
> at the very top.
> 
> But yes, if we just remove that check, I think my original patch
> should actually "JustWork(tm)".

But no!

Sorry, I don't have time for this at present, so haven't looked at
your original patch.

But the point that we've arrived at, that I'm actually now fairly
happy with, is do *not* permit MAP_NOSIGBUS on MAP_SHARED mappings.

I didn't check the placement yet, easy to get wrong, but I believe
Ming Lin is now enforcing that over at the mmap() end.

On a MAP_PRIVATE mapping, the nasty opaque blob of zeroes can
claim some precedent in what already happens with COW'ed pages.

Which leaves MAP_NOSIGBUS on MAP_SHARED as currently unsupported,
perhaps never supported on anything, perhaps one day supported on
shmem; but if it's ever supported then that one will naturally be
transparent to future changes in page cache - we call that "shared".

Of course, internally, there's the in-between case of MAP_SHARED
without PROT_WRITE and without writable fd: VM_MAYSHARE without
VM_SHARED or VM_MAYWRITE.  We *could* let that one accept
MAP_NOSIGBUS, but who wants to write the manpage for it?

Please stick to MAP_PRIVATE: that's good enough.

> 
> I'm attaching it again, with old name and old commentary (ie that
> 
>     /* FIXME! We don't have a VM_NOFAULT bit */
> 
> should just be replaced with that VM_NOSIGBUS bit instead, and the
> #if'ed out region should be enabled.
> 
> Oh, and we need to think hard about one more case: mprotect().
> 
> In particular, I think the attached patch fails horribly for the case
> of a shared mapping that starts out read-only, then inserts a zero
> page, then somebody does mprotect(MAP_WRITE), and then writes to the
> page. I haven't checked what the write protect fault handler does, but
> I think that for a shared mapping it will just make the page dirty and
> writable.

Obviously the finished patch will need to be scrutinized carefully, but
I think the mprotect() questions vanish when restricted to MAP_PRIVATE.

> 
> Which would be horribly wrong for VM_NOSIGBUS.
> 
> So that support infrastructure that adds MAP_NOSIGBUS, and checks that
> it is only done on a read-only mapping, also has to make sure that it
> clears the VM_MAYWRITE bit when it sets VM_NOSIGBUS.
> 
> That way mprotect can't then later make it writable.
> 
> Hugh, comments on this approach?

Comments above, just stick to MAP_PRIVATE.

Hugh

> 
> Again: this patch is my *OLD* one, I didn't try to update it to the
> new world order. It requires
> 
>  - Ming's MAP_NOSIGBUS ccode
> 
>  - removal of that "File mapping without ->vm_ops" case
> 
>  - that FIXME fixed and name updated
> 
>  - and that VM_MAYWRITE clearing if VM_NOSIGBUS is set, to avoid the
> mprotect issue.
> 
> Hmm?
> 
>                   Linus
