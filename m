Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2B0717A286
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 10:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgCEJyq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 04:54:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44246 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgCEJyq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 04:54:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gGA7flVCST725vtJqB26uJyaaG/lu1I8Qz42onV745s=; b=XDSFNWk5Ipa30OZfsw2YqPZNqS
        0jh9PBOidx9nmuBysUH6767sUR6aNmMdZt4qGxdwR02hSbr1E7usd6xToFhaU0uZL7oPlEuhj3/pv
        wfTiZbVLTywcNIgleBztTZfHBKOtgF0Sj6/hW120Qik5I8TX252+LoAollcXU0MszWLZ1qXtOdwbS
        s+3xbMeJhTzJ+GgQf2RLGzzT6xVU+GMtW0uEcBoM8MqcqFCWpaSrMh6KE0r4a8NcUJkadizEhA3ql
        D9AsIBdHJQuq2dUkboUn+S5cYDknYz2dSIS56y0zcqyI+RQH87x7zbRFWHwfZtVJmPLV+CvhNTMuf
        79sRhkpA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9nDC-0008AR-Rr; Thu, 05 Mar 2020 09:54:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 92D92300606;
        Thu,  5 Mar 2020 10:52:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2106C23D4FA17; Thu,  5 Mar 2020 10:54:36 +0100 (CET)
Date:   Thu, 5 Mar 2020 10:54:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Josh Poimboeuf <jpoimboe@redhat.com>, dvyukov@google.com
Subject: Re: mmotm 2020-03-03-22-28 uploaded (warning: objtool:)
Message-ID: <20200305095436.GV2596@hirez.programming.kicks-ass.net>
References: <20200304062843.9yA6NunM5%akpm@linux-foundation.org>
 <cd1c6bd2-3db3-0058-f3b4-36b2221544a0@infradead.org>
 <20200305081717.GT2596@hirez.programming.kicks-ass.net>
 <20200305081842.GB2619@hirez.programming.kicks-ass.net>
 <1583399782.17146.14.camel@mtksdccf07>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583399782.17146.14.camel@mtksdccf07>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 05, 2020 at 05:16:22PM +0800, Walter Wu wrote:
> On Thu, 2020-03-05 at 09:18 +0100, Peter Zijlstra wrote:
> > On Thu, Mar 05, 2020 at 09:17:17AM +0100, Peter Zijlstra wrote:
> > > On Wed, Mar 04, 2020 at 09:34:49AM -0800, Randy Dunlap wrote:
> > 
> > > > mm/kasan/common.o: warning: objtool: kasan_report()+0x13: call to report_enabled() with UACCESS enabled
> > > 
> > > I used next/master instead, and found the below broken commit
> > > responsible for this.
> > 
> > > @@ -634,12 +637,20 @@ void kasan_free_shadow(const struct vm_struct *vm)
> > >  #endif
> > >  
> > >  extern void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip);
> > > +extern bool report_enabled(void);
> > >  
> > > -void kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
> > > +bool kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
> > >  {
> > > -	unsigned long flags = user_access_save();
> > > +	unsigned long flags;
> > > +
> > > +	if (likely(!report_enabled()))
> > > +		return false;
> > 
> > This adds an explicit call before the user_access_save() and that is a
> > straight on bug.
> > 
> Hi Peter,
> 
> Thanks for your help. Unfortunately, I don't reproduce it in our
> environment, so I have asked Stephen, if I can reproduce it, then we
> will send new patch.

The patch is trivial; and all you need is an x86_64 (cross) compiler to
reproduce.


diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index ad2dc0c9cc17..2906358e42f0 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -618,16 +618,17 @@ extern bool report_enabled(void);
 
 bool kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
 {
-	unsigned long flags;
+	unsigned long flags = user_access_save();
+	bool ret = false;
 
-	if (likely(!report_enabled()))
-		return false;
+	if (likely(report_enabled())) {
+		__kasan_report(addr, size, is_write, ip);
+		ret = true;
+	}
 
-	flags = user_access_save();
-	__kasan_report(addr, size, is_write, ip);
 	user_access_restore(flags);
 
-	return true;
+	return ret;
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
