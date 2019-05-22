Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8A025BF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 04:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfEVCdO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 22:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbfEVCdO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 22:33:14 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5302B2173C;
        Wed, 22 May 2019 02:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558492393;
        bh=stsomyQrXg2oFOXmpSx06uL2yS8uJMmKpQW0CHbxwiU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S9s7o5FgX4z/u7+WIrJ4i4+Qxe4jXFBy3y5hH0XzwyZgwDhA92N2D+Qji5lMGhvct
         ALiCiNedjpmNN/4R0cPv4AmY+Vx6Ho0GShjq1voZmi5rbAp8MhNOGAnhK4UEhHH7uC
         q6RDy4zNqynWhzrlKoTS0fuaO0iCWzj2oi/N6fUU=
Date:   Tue, 21 May 2019 19:33:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Azat Khuzhin <azat@libevent.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 13/13] epoll: implement epoll_create2() syscall
Message-Id: <20190521193312.42a3fdda1774b1922730e459@linux-foundation.org>
In-Reply-To: <41b847c48ccbe0c406bd54c16fbc1bf0@suse.de>
References: <20190516085810.31077-1-rpenyaev@suse.de>
        <20190516085810.31077-14-rpenyaev@suse.de>
        <CAK8P3a2-fN_BHEnEHvf4X9Ysy4t0_SnJetQLvFU1kFa3OtM0fQ@mail.gmail.com>
        <41b847c48ccbe0c406bd54c16fbc1bf0@suse.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 16 May 2019 12:20:50 +0200 Roman Penyaev <rpenyaev@suse.de> wrote:

> On 2019-05-16 12:03, Arnd Bergmann wrote:
> > On Thu, May 16, 2019 at 10:59 AM Roman Penyaev <rpenyaev@suse.de> 
> > wrote:
> >> 
> >> epoll_create2() is needed to accept EPOLL_USERPOLL flags
> >> and size, i.e. this patch wires up polling from userspace.
> > 
> > Could you add the system call to all syscall*.tbl files at the same 
> > time here?
> 
> For all other archs, you mean?  Sure.  But what is the rule of thumb?
> Sometimes people tend to add to the most common x86 and other tables
> are left untouched, but then you commit the rest, e.g.
> 
> commit 39036cd2727395c3369b1051005da74059a85317
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Thu Feb 28 13:59:19 2019 +0100
> 
>      arch: add pidfd and io_uring syscalls everywhere
> 

I thought the preferred approach was to wire up the architectures on
which the submitter has tested the syscall, then allow the arch
maintainers to enable the syscall independently?

And to help them in this, provide a test suite for the new syscall
under tools/testing/selftests/.

https://github.com/rouming/test-tools/blob/master/userpolled-epoll.c
will certainly help but I do think it would be better to move the test
into the kernel tree to keep it maintained and so that many people run
it in their various setups on an ongoing basis.


