Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07CA1179D2E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 02:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgCEBLc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 20:11:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60210 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgCEBLc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 20:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ATYs8WYSob7D1uXHAGhQnBidHLKqyWEDLWJr1UpmKBE=; b=ll1ti9vCegEMDvTIpAlQjfhWcy
        MZN6xKgVwk7FRgVb01kIYw1Z2eYvESC3SsJXbNbhnLvp3lul+YMfFlyTwo6QqsV7RCSeg82/kVpg9
        MA7W4YrtBeORJ00RzwBr9DmDgpj7DieDkbkDb2hOzC5F1QkikHrMcWrEAw3sEV8ej4KNiUot4mkui
        6wa8XEgQpZb2fA39Fg6Uj6MIpRCS8UBSSGpYzO78jP1Gt77Ox05MmxlNjyuLfXc8KjwOMlRStu+2k
        K1WFHIC1XPPGeBiXEien2FgMZQF6ykj394QpgZVr6xRbKC78AX1mNrDJr7vzOLTmhHzs6+lJ1Lvfk
        vH8ZvgAw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9f2p-0002to-8m; Thu, 05 Mar 2020 01:11:23 +0000
Date:   Wed, 4 Mar 2020 17:11:23 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCHSET] sanitized pathwalk machinery (v3)
Message-ID: <20200305011123.GL29971@bombadil.infradead.org>
References: <20200223011154.GY23230@ZenIV.linux.org.uk>
 <20200301215125.GA873525@ZenIV.linux.org.uk>
 <CAHk-=wh1Q=H-YstHZRKfEw2McUBX2_TfTc=+5N-iH8DSGz44Qg@mail.gmail.com>
 <20200302003926.GM23230@ZenIV.linux.org.uk>
 <87o8tdgfu8.fsf@x220.int.ebiederm.org>
 <20200304002434.GO23230@ZenIV.linux.org.uk>
 <87wo80g0bo.fsf@x220.int.ebiederm.org>
 <20200304065547.GP23230@ZenIV.linux.org.uk>
 <20200304105946.4xseo3jokcnpptrj@yavin>
 <20200304210031.GT23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304210031.GT23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 09:00:31PM +0000, Al Viro wrote:
> On Wed, Mar 04, 2020 at 09:59:46PM +1100, Aleksa Sarai wrote:
> 
> > > FWIW, I'm putting together some litmus tests for pathwalk semantics -
> > > one of the things I'd like to discuss at LSF; quite a few codepaths
> > > are simply not touched by anything in xfstests.
> > 
> > I won't be at LSF unfortunately, but this is something I would be very
> > interested in helping with -- one of the things I've noticed is the lack
> > of a test-suite for some of the more generic VFS bits (such as namei).
> 
> BTW, has anyone tried to run tests with oprofile and see how much of the
> core kernel gets exercised?  That looks like an obvious thing to try -
> at least the places outside of spin_lock_irq() ought to get lit after
> a while...
> 
> Have any CI folks tried doing that, or am I missing some obvious reason
> why that is not feasible?

I don't know about oprofile, but LTP got their gcov patches merged
into 2.6.31:

http://ltp.sourceforge.net/coverage/gcov.php
