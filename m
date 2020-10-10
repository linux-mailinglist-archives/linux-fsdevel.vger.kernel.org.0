Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EF4289D1E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Oct 2020 03:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgJJBfy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 21:35:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729627AbgJJBT1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 21:19:27 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E21C92222E;
        Sat, 10 Oct 2020 01:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602292761;
        bh=/LYWflPFUQmr4zRX/3aYO5X4zGhKa6rc4/cUxk3xBL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fnNqw0PxV6IX/oLMEyLtVNaBKSLmW486bhyKJLb6xU/3aVPdJKhHCe2HS/jCJdP0f
         h0sh+gunMLdhhfPbzEwE/adD6a+CcuxJBLWFF4wZ5mMEi09wQZiAX4gGdyI1D/7+Em
         Ko/SaQsKuwBj912JA0Lt3zk0AWrOM2p3zFXWLH54=
Date:   Fri, 9 Oct 2020 18:19:19 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20201010011919.GC1122@sol.localdomain>
References: <20200903142242.925828-1-hch@lst.de>
 <20200903142242.925828-6-hch@lst.de>
 <20201001223852.GA855@sol.localdomain>
 <20201001224051.GI3421308@ZenIV.linux.org.uk>
 <CAHk-=wgj=mKeN-EfV5tKwJNeHPLG0dybq+R5ZyGuc4WeUnqcmA@mail.gmail.com>
 <20201009220633.GA1122@sol.localdomain>
 <CAHk-=whcEzYjkqdpZciHh+iAdUttvfWZYoiHiF67XuTXB1YJLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whcEzYjkqdpZciHh+iAdUttvfWZYoiHiF67XuTXB1YJLw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 09, 2020 at 06:03:31PM -0700, Linus Torvalds wrote:
> On Fri, Oct 9, 2020 at 3:06 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > It's a bit unintuitive that ppos=NULL means "use pos 0", not "use file->f_pos".
> 
> That's not at all what it means.
> 
> A NULL ppos means "this has no position at all", and is what we use
> for FMODE_STREAM file descriptors (ie sockets, pipes, etc).
> 
> It also means that we don't do the locking for position updates.
> 
> The fact that "ki_pos" gets set to zero is just because it needs to be
> _something_. It shouldn't actually ever be used for stream devices.
> 

Okay, that makes more sense.  So the patchset from Matthew
https://lkml.kernel.org/linux-fsdevel/20201003025534.21045-1-willy@infradead.org/T/#u
isn't what you had in mind.

- Eric
