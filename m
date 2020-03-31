Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17D46199A60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 17:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbgCaPxp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 11:53:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36218 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730528AbgCaPxp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OFqOc+bJyrugjvE3pryu+rtDGYa5Qg3q/CyA2OqbQJA=; b=pfvOxZeY2utKj3hO3eTL30CYn5
        skremNMpqHNKXILWV0VBJsYJdTjU1V1dvasr5eOUbn1JV/xK9sUjglwhQnAzcNweAeolxPdK5cTDL
        EItpcfcOe/AkrCQVHevtWZZJ1DQ+ZvXpyjMcZHaGHTn12omjP5lPm0/R/KmscoWcsmIv3jubehmDx
        c/iEGFwgVgG+l7HAbREa7uVMBSiXjAW712crz8RKhs5AnU/Uea+9v0CdzlxKizF8jFBwfRDt6MJed
        uG2U9gr2QL1Ge+UTir6jPHggK0p6WNLHqX9z6F9pWovxEzmC60Cvcj0F2dUCH3HPdoLjKAFedZsqC
        4yN+ukAQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJGXc-0004FX-KP; Tue, 31 Mar 2020 13:02:52 +0000
Date:   Tue, 31 Mar 2020 06:02:52 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] iomap: Remove indirect function call
Message-ID: <20200331130252.GA21484@bombadil.infradead.org>
References: <20200328155156.GS22483@bombadil.infradead.org>
 <20200331074628.GA9872@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331074628.GA9872@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 31, 2020 at 12:46:28AM -0700, Christoph Hellwig wrote:
> On Sat, Mar 28, 2020 at 08:51:56AM -0700, Matthew Wilcox wrote:
> > By splitting iomap_apply into __iomap_apply and an inline iomap_apply,
> > we convert the call to 'actor' into a direct function call.  I haven't
> > done any performance measurements, but given the current costs of indirect
> > function calls, this would seem worthwhile to me?
> 
> Hmm.  Given that emount of compiler stupidity we are dealing with did
> you at least look at the assembly output to see if this actually removes
> the indirect call?  I wouldn't be quite sure.

If it does get inlined, then the compiler does it:

     b9d:       e8 ae fe ff ff          callq  a50 <iomap_page_mkwrite_actor>

If not, then the compiler emits a function in each file called iomap_apply
which makes an indirect call.  So s/inline/__always_inline/ in the original
patch.

before:
   text	   data	    bss	    dec	    hex	filename
   5314	   4648	      0	   9962	   26ea	fs/iomap/trace.o
   1050	     72	      0	   1122	    462	fs/iomap/apply.o
  17316	    636	    224	  18176	   4700	fs/iomap/buffered-io.o
   4773	     76	      0	   4849	   12f1	fs/iomap/direct-io.o
   1335	     28	      0	   1363	    553	fs/iomap/fiemap.o
   1928	     28	      0	   1956	    7a4	fs/iomap/seek.o
   1394	      8	      0	   1402	    57a	fs/iomap/swapfile.o

after:
   text	   data	    bss	    dec	    hex	filename
   5314	   4648	      0	   9962	   26ea	fs/iomap/trace.o
    722	     72	      0	    794	    31a	fs/iomap/apply.o
  18784	    636	    224	  19644	   4cbc	fs/iomap/buffered-io.o
   5169	     76	      0	   5245	   147d	fs/iomap/direct-io.o
   2093	     28	      0	   2121	    849	fs/iomap/fiemap.o
   2467	     28	      0	   2495	    9bf	fs/iomap/seek.o
   1664	      8	      0	   1672	    688	fs/iomap/swapfile.o

33110 to 36213 bytes of text.  So not free.  Worthwhile?
