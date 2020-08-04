Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E7623B946
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 13:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbgHDLPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 07:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730016AbgHDLO6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:14:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4885C06179E;
        Tue,  4 Aug 2020 04:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JW6B2OD0Jc1EExGD+ptuOCacpQEjtzVk2AEqTGdI46A=; b=PzwSj9y3HWvWL1Rp+pmHIne3rH
        wKYMzFQT6F4iULIoYFz7BrP4Dn/r6IX7jpbgu0fYM7o1HJRyfr2gSwgW9KrJ6pbleU7wTrQDUxj2/
        lzfw0wgiy7rHpZv8tVGkaRHJmVFnwtdV+CIjmaC5GkUqGi1ySTIZJFOHyiYulFLVqHmOhrLioUBbh
        h4uzdEkGQe/1O77PFpozs6gKfiUHIoS1YcwCUk42qCOmRDr/WMylVhNTmG7k5iIsLcN0TiQQByPz3
        xX/j8+YSud/d3gYpvv8BkRFyI1J/G+3C5zz4BYPiT76mQ6WLKu3vDFAD67oSnwWwCK+/mghapqqcG
        LlnoD+pQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2use-000476-F4; Tue, 04 Aug 2020 11:13:16 +0000
Date:   Tue, 4 Aug 2020 12:13:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'James Bottomley' <James.Bottomley@hansenpartnership.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "ktkhai@virtuozzo.com" <ktkhai@virtuozzo.com>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "esyr@redhat.com" <esyr@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "christian@kellner.me" <christian@kellner.me>,
        "areber@redhat.com" <areber@redhat.com>,
        "cyphar@cyphar.com" <cyphar@cyphar.com>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Message-ID: <20200804111316.GE23808@casper.infradead.org>
References: <db3bdbae-eb0f-1ae3-94dd-045e37bc94ba@oracle.com>
 <20200730171251.GI23808@casper.infradead.org>
 <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
 <20200730174956.GK23808@casper.infradead.org>
 <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
 <87y2n03brx.fsf@x220.int.ebiederm.org>
 <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com>
 <877dufvje9.fsf@x220.int.ebiederm.org>
 <1596469370.29091.13.camel@HansenPartnership.com>
 <9371b8272fd84280ae40b409b260bab3@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9371b8272fd84280ae40b409b260bab3@AcuMS.aculab.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 04, 2020 at 08:44:42AM +0000, David Laight wrote:
> From: James Bottomley
> > Sent: 03 August 2020 16:43
> > 
> > On Mon, 2020-08-03 at 10:28 -0500, Eric W. Biederman wrote:
> > [...]
> > > What is wrong with live migration between one qemu process and
> > > another qemu process on the same machine not work for this use case?
> > >
> > > Just reusing live migration would seem to be the simplest path of
> > > all, as the code is already implemented.  Further if something goes
> > > wrong with the live migration you can fallback to the existing
> > > process.  With exec there is no fallback if the new version does not
> > > properly support the handoff protocol of the old version.
> > 
> > Actually, could I ask this another way: the other patch set you sent to
> > the KVM list was to snapshot the VM to a PKRAM capsule preserved across
> > kexec using zero copy for extremely fast save/restore.  The original
> > idea was to use this as part of a CRIU based snapshot, kexec to new
> > system, restore.  However, why can't you do a local snapshot, restart
> > qemu, restore using the PKRAM capsule to achieve exactly the same as
> > MADV_DOEXEC does but using a system that's easy to reason about?  It
> > may be slightly slower, but I think we're still talking milliseconds.
> 
> 
> I've had another idea (that is probably impossible...).
> What about a 'reverse mmap' operation.
> Something that creates an fd whose contents are a chunk of the
> processes address space.

http://www.wil.cx/~willy/linux/sileby.html
