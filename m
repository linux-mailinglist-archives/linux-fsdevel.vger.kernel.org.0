Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C661EFBC2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 16:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgFEOrX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 10:47:23 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:53116 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbgFEOrX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:47:23 -0400
Received: from comp-core-i7-2640m-0182e6 (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 29B20209AF;
        Fri,  5 Jun 2020 14:47:19 +0000 (UTC)
Date:   Fri, 5 Jun 2020 16:47:14 +0200
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH 0/2] proc: use subset option to hide some top-level
 procfs entries
Message-ID: <20200605144714.7voi2hgtg5r2oiql@comp-core-i7-2640m-0182e6>
References: <20200604200413.587896-1-gladkov.alexey@gmail.com>
 <87ftbah8q2.fsf@x220.int.ebiederm.org>
 <20200605000838.huaeqvgpvqkyg3wh@comp-core-i7-2640m-0182e6>
 <87zh9idu3h.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zh9idu3h.fsf@x220.int.ebiederm.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Fri, 05 Jun 2020 14:47:20 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 04, 2020 at 11:17:38PM -0500, Eric W. Biederman wrote:
> >> I am not going to seriously look at this for merging until after the
> >> merge window closes. 
> >
> > OK. I'll wait.
> 
> That will mean your patches can be based on -rc1.

OK.

> > Do you suggest to allow a user to mount procfs with hidepid=2,subset=pid
> > options? If so then this is an interesting idea.
> 
> The key part would be subset=pid.  You would still need to be root in
> your user namespace, and mount namespace.  You would not need to have a
> separate copy of proc with nothing hidden already mounted.

Can you tell me more about your idea ? I thought I understood it, but it
seems my understanding is different.

I thought that you are suggesting that you move in the direction of
allowing procfs to mount an unprivileged user.

> > I can not agree with this because I do not touch on other options.
> > The hidepid and subset=pid has no relation to the visibility of regular
> > files. On the other hand, in procfs there is absolutely no way to restrict
> > access other than selinux.
> 
> Untrue.  At a practical level the user namespace greatly restricts
> access to proc because many of the non-process files are limited to
> global root only.

I am not worried about the files created in procfs by the kernel itself
because the permissions are set correctly and are checked correctly.

I worry about kernel modules, especially about modules out of tree.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/gadget/function/rndis.c#n904

I certainly understand that 0660 is not 0666, but still.

> > I know that java uses meminfo for sure.
> >
> > The purpose of this patch is to isolate the container from unwanted files
> > in procfs.
> 
> If what we want is the ability not to use the original but to have
> a modified version of these files.  We probably want empty files that
> serve as mount points.
> 
> Or possibly a version of these files that takes into account
> restrictions.  In either even we need to do the research through real
> programs and real kernel options to see what is our best option for
> exporting the limitations that programs have and deciding on the long
> term API for that.

Yes, but that's a slightly different story. It would be great if all of
these files provide modified information.

My patch is about those files that we don’t know about and which we don’t
want.

> If we research things and we decide the best way to let java know of
> it's limitations is to change /proc/meminfo.  That needs to be a change
> that always applies to meminfo and is not controlled by options.
> 
> > For now I'm just trying ti create a better way to restrict access in
> > the procfs than this since procfs is used in containers.
> 
> Docker historically has been crap about having a sensible policy.  The
> problem is that Docker wanted to allow real root in a container and
> somehow make it safe by blocking access to proc files and by dropping
> capabilities.
> 
> Practically everything that Docker has done is much better and simpler by
> restricting the processes to a user namespace, with a root user whose
> uid is not the global root user.
> 
> Which is why I want us to make certain we are doing something that makes
> sense, and is architecturally sound.

Ok. Then ignore this patchset.

> You have cleared the big hurdle and proc now has options that are
> usable.   I really appreciate that.  I am not opposed to the general
> direction you are going to find a way to make proc more usable.  I just
> want our next step to be solid.

-- 
Rgrds, legion

