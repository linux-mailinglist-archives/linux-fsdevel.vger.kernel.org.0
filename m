Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940F91E80FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 16:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgE2Oxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 10:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2Oxk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 10:53:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8E0C03E969;
        Fri, 29 May 2020 07:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Bscdkat8wbOQ224oN96JSsIfkRZJsilufq7V5AwStvs=; b=CQIp3F2YX5AGGiVlwKRt0JXRj3
        p317YbXtQQeP1j0ecSJalUYu7C/e+qqE6WGZeSSbetQN1hMLcszfK0cCa3urVnB2uRzYgu7wt6tcQ
        yxQ33Z/pryEtr4hRx4o1CjhSKH6i+8Nena/26tpxv+AzkQA6iF6qzWoVJ6UlG0uEmft4OxGavVhUb
        S1EbHH/pktU1L5Ucu73OAcSU4xX3LO462CokHX2rgAIA9+0d7lWJ5WT9woISpL8yQlgXmGOGD0xNZ
        2AOO2Xq7Sy4geJqLlXh33CNojoe4xo2Jyt6LS9nBqN7U+L8DNzJtrclw25v7RW/ZdNocxhOpRtuFG
        i9uEgp6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jegO0-00061q-Fn; Fri, 29 May 2020 14:53:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B934030047A;
        Fri, 29 May 2020 16:53:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 30B8820185BD9; Fri, 29 May 2020 16:53:25 +0200 (CEST)
Date:   Fri, 29 May 2020 16:53:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        viro@ZenIV.linux.org.uk, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: mmotm 2020-05-13-20-30 uploaded (objtool warnings)
Message-ID: <20200529145325.GB706518@hirez.programming.kicks-ass.net>
References: <20200514033104.kRFL_ctMQ%akpm@linux-foundation.org>
 <611fa14d-8d31-796f-b909-686d9ebf84a9@infradead.org>
 <20200528172005.GP2483@worktop.programming.kicks-ass.net>
 <20200529135750.GA1580@lst.de>
 <20200529143556.GE706478@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529143556.GE706478@hirez.programming.kicks-ass.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 04:35:56PM +0200, Peter Zijlstra wrote:
> On Fri, May 29, 2020 at 03:57:51PM +0200, Christoph Hellwig wrote:
> > On Thu, May 28, 2020 at 07:20:05PM +0200, Peter Zijlstra wrote:
> > > > on x86_64:
> > > > 
> > > > arch/x86/lib/csum-wrappers_64.o: warning: objtool: csum_and_copy_from_user()+0x2a4: call to memset() with UACCESS enabled
> > > > arch/x86/lib/csum-wrappers_64.o: warning: objtool: csum_and_copy_to_user()+0x243: return with UACCESS enabled
> > > 
> > > Urgh, that's horrible code. That's got plain stac()/clac() calls on
> > > instead of the regular uaccess APIs.
> > 
> > Does it?  If this is from the code in linux-next, then the code does a
> > user_access_begin/end in csum_and_copy_{from,to}_user, then uses
> > unsafe_{get,put}_user inside those function itself.  But then they call
> > csum_partial_copy_generic with the __user casted away, but without any
> > comment on why this is safe.
> 
> Bah, clearly I was looking at the wrong tree. You're right, Al cleaned
> it all up.
> 
> Let me try and figure out why objtool is unhappy with it.

*groan*, this is one of those CONFIG_PROFILE_ALL_BRANCHES builds. If I
disable that it goes away.

Still trying to untangle the mess it generated, but on first go it
looks like objtool is right, but I'm not sure what went wrong.
