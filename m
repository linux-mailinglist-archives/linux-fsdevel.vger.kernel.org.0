Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98D51E8057
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 16:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgE2OgH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 10:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgE2OgG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 10:36:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DBEC03E969;
        Fri, 29 May 2020 07:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3OBSAvJ90qHPxRF94+gf1522d7T4xfleronq0nrrLQ8=; b=IjGAFeTFMnfigc25pFNWxLqxDQ
        5O6YpIhpgdPJQtH/qxEtKR3PhIrGvEYlFbXcF7mFI+hkBSyD5NBypzpfMybrKfuMGyH+ivUL12xjG
        k433VgsJmHnfPxrlZ0TTg3UgKcUe0g0I8/nI6DZF3h19IPDcwQxudCoG7QFs3VGDW5fBd4gil5ZuP
        Wzb2HkgBAi4/vnwPNWLWSDYKyI+IrlVGKJBanmXBRcUETzNfXIYbtOoI+V8h1LtH2eWS1zJL4uvC5
        xwX7Q0/OcY9YM5ViFfIKW/ppid9mKvy+dS61NP3B64YOI2QeLE6VjtjxfEFlBqRq7xzD3JJSiTtZd
        OopsVc4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeg75-0003Us-Vv; Fri, 29 May 2020 14:36:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0CA723012C3;
        Fri, 29 May 2020 16:35:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E7B020185BC5; Fri, 29 May 2020 16:35:56 +0200 (CEST)
Date:   Fri, 29 May 2020 16:35:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        viro@ZenIV.linux.org.uk, x86@kernel.org
Subject: Re: mmotm 2020-05-13-20-30 uploaded (objtool warnings)
Message-ID: <20200529143556.GE706478@hirez.programming.kicks-ass.net>
References: <20200514033104.kRFL_ctMQ%akpm@linux-foundation.org>
 <611fa14d-8d31-796f-b909-686d9ebf84a9@infradead.org>
 <20200528172005.GP2483@worktop.programming.kicks-ass.net>
 <20200529135750.GA1580@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529135750.GA1580@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 03:57:51PM +0200, Christoph Hellwig wrote:
> On Thu, May 28, 2020 at 07:20:05PM +0200, Peter Zijlstra wrote:
> > > on x86_64:
> > > 
> > > arch/x86/lib/csum-wrappers_64.o: warning: objtool: csum_and_copy_from_user()+0x2a4: call to memset() with UACCESS enabled
> > > arch/x86/lib/csum-wrappers_64.o: warning: objtool: csum_and_copy_to_user()+0x243: return with UACCESS enabled
> > 
> > Urgh, that's horrible code. That's got plain stac()/clac() calls on
> > instead of the regular uaccess APIs.
> 
> Does it?  If this is from the code in linux-next, then the code does a
> user_access_begin/end in csum_and_copy_{from,to}_user, then uses
> unsafe_{get,put}_user inside those function itself.  But then they call
> csum_partial_copy_generic with the __user casted away, but without any
> comment on why this is safe.

Bah, clearly I was looking at the wrong tree. You're right, Al cleaned
it all up.

Let me try and figure out why objtool is unhappy with it.
