Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD281E7F67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 15:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgE2N5y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 09:57:54 -0400
Received: from verein.lst.de ([213.95.11.211]:33136 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbgE2N5y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 09:57:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 40A5D68B02; Fri, 29 May 2020 15:57:51 +0200 (CEST)
Date:   Fri, 29 May 2020 15:57:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        viro@ZenIV.linux.org.uk, hch@lst.de, x86@kernel.org
Subject: Re: mmotm 2020-05-13-20-30 uploaded (objtool warnings)
Message-ID: <20200529135750.GA1580@lst.de>
References: <20200514033104.kRFL_ctMQ%akpm@linux-foundation.org> <611fa14d-8d31-796f-b909-686d9ebf84a9@infradead.org> <20200528172005.GP2483@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528172005.GP2483@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 07:20:05PM +0200, Peter Zijlstra wrote:
> > on x86_64:
> > 
> > arch/x86/lib/csum-wrappers_64.o: warning: objtool: csum_and_copy_from_user()+0x2a4: call to memset() with UACCESS enabled
> > arch/x86/lib/csum-wrappers_64.o: warning: objtool: csum_and_copy_to_user()+0x243: return with UACCESS enabled
> 
> Urgh, that's horrible code. That's got plain stac()/clac() calls on
> instead of the regular uaccess APIs.

Does it?  If this is from the code in linux-next, then the code does a
user_access_begin/end in csum_and_copy_{from,to}_user, then uses
unsafe_{get,put}_user inside those function itself.  But then they call
csum_partial_copy_generic with the __user casted away, but without any
comment on why this is safe.
