Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B934049D15D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 19:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244049AbiAZSEA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 13:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiAZSEA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:04:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F823C06161C;
        Wed, 26 Jan 2022 10:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=91pY7WHsiZcMLE/SeJIJM6HsjUa7+6H46gg9u/uUPng=; b=vKVRrchafi1klVzAPWTWhsPIdw
        eQaps9a3g35CEMfkAzjbuKVO7wNtD7O7qlI4DwYoCoi68KaJV3iNgRz3IE6ofLFz3EZsVAFatN7kS
        wClec6snlHX4x6lzsaNJ3Do3U7ZJnP7rtQcWSsJ82aMPa1FGc6t59vtsAKA6BlWHHMUyTFk8nLXkb
        rN49WRzlPpfpgSrmJ3MGHI4dq1Y5+UvtINcGhjTepm9ukdME037+3dkmiidKwOgDIebzgsnFWGWuc
        VJhTvlv8xJdwMonSPezB0mznSndiUftphLgS671GSF9S5lvpNhJSkI/H/vDMv0v1aaks+x6v3uINu
        51FDZWwQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCme7-004Hx7-44; Wed, 26 Jan 2022 18:03:51 +0000
Date:   Wed, 26 Jan 2022 18:03:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Ariadne Conill <ariadne@dereferenced.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fs/exec: require argv[0] presence in
 do_execveat_common()
Message-ID: <YfGNBz0gigWwNnHn@casper.infradead.org>
References: <20220126114447.25776-1-ariadne@dereferenced.org>
 <YfFh6O2JS6MybamT@casper.infradead.org>
 <877damwi2u.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877damwi2u.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 10:57:29AM -0600, Eric W. Biederman wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
> > On Wed, Jan 26, 2022 at 11:44:47AM +0000, Ariadne Conill wrote:
> >> Interestingly, Michael Kerrisk opened an issue about this in 2008[1],
> >> but there was no consensus to support fixing this issue then.
> >> Hopefully now that CVE-2021-4034 shows practical exploitative use
> >> of this bug in a shellcode, we can reconsider.
> >> 
> >> [0]: https://pubs.opengroup.org/onlinepubs/9699919799/functions/exec.html
> >> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=8408
> >
> > Having now read 8408 ... if ABI change is a concern (and I really doubt
> > it is), we could treat calling execve() with a NULL argv as if the
> > caller had passed an array of length 1 with the first element set to
> > NULL.  Just like we reopen fds 0,1,2 for suid execs if they were
> > closed.
> 
> Where do we reopen fds 0,1,2 for suid execs?  I feel silly but I looked
> through the code fs/exec.c quickly and I could not see it.

I'm wondering if I misremembered and it's being done in ld.so
rather than in the kernel?  That might be the right place to put
this fix too.

> I am attracted to the notion of converting an empty argv array passed
> to the kernel into something we can safely pass to userspace.
> 
> I think it would need to be having the first entry point to "" instead
> of the first entry being NULL.  That would maintain the invariant that you
> can always dereference a pointer in the argv array.

Yes, I like that better than NULL.
