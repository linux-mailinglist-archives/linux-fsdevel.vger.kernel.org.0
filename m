Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F14145F02C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 15:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377878AbhKZOzc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 09:55:32 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:53480 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347485AbhKZOxb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 09:53:31 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8C7851FD38;
        Fri, 26 Nov 2021 14:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637938217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vIFiAUSKYA6iDyHQMizk9Jjiw/pwaTCNzr86pTCJre4=;
        b=SHfMGLegEv0b2KByE3H2YJ6kJ4MIoSMhnvigyKETU7+4Tl840wTAL4Z6bVaAc2/fXo/wyh
        8TfIXodqhbwHM4hDgnW3ZTXLhBnwyBAPBOshFHHoLDemXpIzLsXzOWzTFtmJLk+UiJmUux
        C9u7AVBBbmgeMKkbDk+8jkd7gOP1UxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637938217;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vIFiAUSKYA6iDyHQMizk9Jjiw/pwaTCNzr86pTCJre4=;
        b=lZU3tzKj1bkLYYq31czyyQv7U8vwHyfHRSeSVFUFClnmaasMryMs4TuivbeAnN+4DutXxb
        j8UERmDMCCucCTCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5708B13C60;
        Fri, 26 Nov 2021 14:50:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9RuTFCn0oGEXXAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 26 Nov 2021 14:50:17 +0000
Message-ID: <919f547e-beb7-34b7-7835-9e1625600323@suse.cz>
Date:   Fri, 26 Nov 2021 15:50:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211122153233.9924-3-mhocko@kernel.org> <YZ06nna7RirAI+vJ@pc638.lan>
 <20211123170238.f0f780ddb800f1316397f97c@linux-foundation.org>
 <163772381628.1891.9102201563412921921@noble.neil.brown.name>
 <20211123194833.4711add38351d561f8a1ae3e@linux-foundation.org>
 <163773141164.1891.1440920123016055540@noble.neil.brown.name>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
In-Reply-To: <163773141164.1891.1440920123016055540@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/24/21 06:23, NeilBrown wrote:
>> 
>> I forget why radix_tree_preload used a cpu-local store rather than a
>> per-task one.
>> 
>> Plus "what order pages would you like" and "on which node" and "in
>> which zone", etc...
> 
> "what order" - only order-0 I hope.  I'd hazard a guess that 90% of
> current NOFAIL allocations only need one page (providing slub is used -
> slab seems to insist on high-order pages sometimes).

Yeah AFAIK SLUB can prefer higher orders than SLAB, but also allows fallback
to smallest order that's enough (thus 0 unless the objects are larger than a
page).

> "which node" - whichever.  Unless __GFP_HARDWALL is set, alloc_page()
> will fall-back to "whichever" anyway, and NOFAIL with HARDWALL is
> probably a poor choice.
> "which zone" - NORMAL.  I cannot find any NOFAIL allocations that want
> DMA.  fs/ntfs asks for __GFP_HIGHMEM with NOFAIL, but that that doesn't
> *requre* highmem.
> 
> Of course, before designing this interface too precisely we should check
> if anyone can use it.  From a quick through the some of the 100-ish
> users of __GFP_NOFAIL I'd guess that mempools would help - the
> preallocation should happen at init-time, not request-time.  Maybe if we
> made mempools even more light weight .... though that risks allocating a
> lot of memory that will never get used.
> 
> This brings me back to the idea that
>     alloc_page(wait and reclaim allowed)
> should only fail on OOM_KILL.  That way kernel threads are safe, and
> user-threads are free to return ENOMEM knowing it won't get to

Hm I thought that's already pretty much the case of the "too small to fail"
of today. IIRC there's exactly that gotcha that OOM KILL can result in such
allocation failure. But I believe that approach is rather fragile. If you
encounter such an allocation not checking the resulting page != NULL, you
can only guess which one is true:

- the author simply forgot to check at all
- the author relied on "too small to fail" without realizing the gotcha
- at the time of writing the code was verified that it can be only run in
kernel thread context, not user and
  - it is still true
  - it stopped being true at some later point
  - might be hard to even decide which is the case

IIRC at some point we tried to abolish the "too small to fail" rule because
of this, but Linus denied that. But the opposite - make it hard guarantee in
all cases - also didn't happen, so...

> user-space.  If user-thread code really needs NOFAIL, it punts to a
> workqueue and waits - aborting the wait if it is killed, while the work
> item still runs eventually.
> 
> NeilBrown
> 

