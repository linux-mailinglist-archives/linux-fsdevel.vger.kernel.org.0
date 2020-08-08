Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F69423F948
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Aug 2020 00:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgHHWRw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Aug 2020 18:17:52 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:37712 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgHHWRw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Aug 2020 18:17:52 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id EAB141C0BDA; Sun,  9 Aug 2020 00:17:49 +0200 (CEST)
Date:   Sun, 9 Aug 2020 00:17:48 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
Message-ID: <20200808221748.GA1020@bug>
References: <aefc85852ea518982e74b233e11e16d2e707bc32>
 <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <20200731180955.GC67415@C02TD0UTHF1T.local>
 <6236adf7-4bed-534e-0956-fddab4fd96b6@linux.microsoft.com>
 <20200804143018.GB7440@C02TD0UTHF1T.local>
 <b3368692-afe6-89b5-d634-12f4f0a601f8@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3368692-afe6-89b5-d634-12f4f0a601f8@linux.microsoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

> Thanks for the lively discussion. I have tried to answer some of the
> comments below.

> > There are options today, e.g.
> >
> > a) If the restriction is only per-alias, you can have distinct aliases
> >    where one is writable and another is executable, and you can make it
> >    hard to find the relationship between the two.
> >
> > b) If the restriction is only temporal, you can write instructions into
> >    an RW- buffer, transition the buffer to R--, verify the buffer
> >    contents, then transition it to --X.
> >
> > c) You can have two processes A and B where A generates instrucitons into
> >    a buffer that (only) B can execute (where B may be restricted from
> >    making syscalls like write, mprotect, etc).
> 
> The general principle of the mitigation is W^X. I would argue that
> the above options are violations of the W^X principle. If they are
> allowed today, they must be fixed. And they will be. So, we cannot
> rely on them.

Would you mind describing your threat model?

Because I believe you are using model different from everyone else.

In particular, I don't believe b) is a problem or should be fixed.

I'll add d), application mmaps a file(R--), and uses write syscall to change
trampolines in it.

> b) This is again a violation. The kernel should refuse to give execute
> ???????? permission to a page that was writeable in the past and refuse to
> ???????? give write permission to a page that was executable in the past.

Why?

										Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
