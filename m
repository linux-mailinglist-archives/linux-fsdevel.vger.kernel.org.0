Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F881275F43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 20:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgIWSAP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 14:00:15 -0400
Received: from mother.openwall.net ([195.42.179.200]:53989 "HELO
        mother.openwall.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726228AbgIWSAP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 14:00:15 -0400
Received: (qmail 18029 invoked from network); 23 Sep 2020 18:00:12 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 23 Sep 2020 18:00:12 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
        id 59151AB844; Wed, 23 Sep 2020 20:00:07 +0200 (CEST)
Date:   Wed, 23 Sep 2020 20:00:07 +0200
From:   Solar Designer <solar@openwall.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     madvenka@linux.microsoft.com, kernel-hardening@lists.openwall.com,
        linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, luto@kernel.org, David.Laight@ACULAB.COM,
        fweimer@redhat.com, mark.rutland@arm.com, mic@digikod.net,
        Rich Felker <dalias@libc.org>
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
Message-ID: <20200923180007.GA8646@openwall.com>
References: <20200922215326.4603-1-madvenka@linux.microsoft.com> <20200923081426.GA30279@amd> <20200923091456.GA6177@openwall.com> <20200923141102.GA7142@openwall.com> <20200923151835.GA32555@duo.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923151835.GA32555@duo.ucw.cz>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 23, 2020 at 05:18:35PM +0200, Pavel Machek wrote:
> > It sure does make sense to combine ret2libc/ROP to mprotect() with one's
> > own injected shellcode.  Compared to doing everything from ROP, this is
> > easier and more reliable across versions/builds if the desired
> > payload
> 
> Ok, so this starts to be a bit confusing.
> 
> I thought W^X is to protect from attackers that have overflowed buffer
> somewhere, but can not to do arbitrary syscalls, yet.
> 
> You are saying that there's important class of attackers that can do
> some syscalls but not arbitrary ones.

They might be able to do many, most, or all arbitrary syscalls via
ret2libc or such.  The crucial detail is that each time they do that,
they risk incompatibility with the given target system (version, build,
maybe ASLR if gadgets from multiple libraries are involved).  By using
mprotect(), they only take this risk once (need to get the address of an
mprotect() gadget and of what to change protections on right), and then
they can invoke multiple syscalls from their shellcode more reliably.
So for doing a lot of work, mprotect() combined with injected code can
be easier and more reliable.  It is also an extra option an attacker can
use, in addition to doing everything via borrowed code.  More
flexibility for the attacker means the attacker may choose whichever
approach works better in a given case (or try several).

I am embarrassed for not thinking/recalling this when I first posted
earlier today.  It's actually obvious.  I'm just getting old and rusty.

> I'd like to see definition of that attacker (and perhaps description
> of the system the protection is expected to be useful on -- if it is
> not close to common Linux distros).

There's nothing unusual about that attacker and the system.

A couple of other things Brad kindly pointed out:

SELinux already has similar protections (execmem, execmod):

http://lkml.iu.edu/hypermail/linux/kernel/0508.2/0194.html
https://danwalsh.livejournal.com/6117.html

PaX MPROTECT is implemented in a way or at a layer that covers ptrace()
abuse that I mentioned.  (At least that's how I understood Brad.)

Alexander

P.S. Meanwhile, Twitter locked my account "for security purposes".  Fun.
I'll just let it be for now.
