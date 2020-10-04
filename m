Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48737282A97
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 14:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgJDMNc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Oct 2020 08:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgJDMNc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Oct 2020 08:13:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE93C0613CE;
        Sun,  4 Oct 2020 05:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cHTKu4nuBlPPbIt95VbLjTa8IGQzS48ApyAMi+1cy9k=; b=plbijpReQFM+W3Ey1ADXq7S599
        j7YlG6mLpRHj6nhQVnoqK/Eg8u95O9kRT/K0q1W8oe4fb7ksqa5Vr/JtIVQaISwgLnseFBkQaqiHp
        6x9NnxenjC+GbKzuQgPWN+OoY8dNpqoNLxJ04VxMPiyE1SzJRH8ZCx3Rj6ZnVfZML9/6s2O/Otjih
        akgalff0ev/u7ywezEikE+BiwZ/Smk4vS+OW4szSIKLljc23Hdk9QwAlK396HqSIPjjLutmAmhbQm
        IGVHj5OyvD+jXvhBdf1JTGSvul8z7bEN3k+QWQPUSq8z72rAtmtcxdlG8ER1AephTMZvwBmTfmJlm
        LR+0AtBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kP2tN-0002KT-86; Sun, 04 Oct 2020 12:13:29 +0000
Date:   Sun, 4 Oct 2020 13:13:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC][PATCHSET] epoll cleanups
Message-ID: <20201004121329.GG20115@casper.infradead.org>
References: <20201004023608.GM3421308@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201004023608.GM3421308@ZenIV.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 04, 2020 at 03:36:08AM +0100, Al Viro wrote:
> 	Finally, there's the mess with reverse path check.  When we insert
> a new file into a epoll, we need to check that there won't be excessively long
> (or excessively many) wakeup chains.  If the target is not an epoll, we need
> to check that for the target alone, but if it's another epoll we need the same
> check done to everything reachable from that epoll.  The way it's currently
> done is Not Nice(tm): we collect the set of files to check and, once we have
> verified the absence of loops, created a new epitem and inserted it into
> the epoll data structures, we run reverse_path_check_proc() for every file
> in the set.  The set is maintained as a (global) cyclic list threaded through
> some struct file.  Everything is serialized on epmutex, so the list can be
> global.  Unfortunately, each struct file ends up with list_head embedded into
> it, all for the sake of operation that is rare *and* involves a small fraction
> of all struct file instances on the system.
> 	Worse, files can end up disappearing while we are collecting the set;
> explicit EPOLL_CTL_DEL does not grab epmutex, and final fput() won't touch
> epmutex if all epitem refering to that file have already been removed.  This
> had been worked around this cycle (by grabbing temporary references to struct
> file added to the set), but that's not a good solution.
> 	What we need is to separate the head of epitem list (->f_ep_links)
> from struct file; all we need in struct file is a reference to that head.
> We could thread the list representing the set of files through those objects
> (getting rid of 3 pointers in each struct file) and have epitem removal
> free those objects if there's no epitems left *and* they are not included
> into the set.  Reference from struct file would be cleared as soon as there's
> no epitems left.  Dissolving the set would free those that have no epitems
> left and thus would've been freed by ep_remove() if they hadn't been in the
> set.
> 	With some massage it can be done; we end up with
> * 3 pointers gone from each struct file
> * one pointer added to struct eventpoll
> * two-pointer object kept for each non-epoll file that is currently watched by
> some epoll.

Have you considered just storing a pointer to each struct file in an
epoll set in an XArray?  Linked lists suck for modern CPUs, and there'd
be no need to store any additional data in each struct file.  Using
xa_alloc() to store the pointer and throw away the index the pointer
got stored at would leave you with something approximating a singly
linked list, except it's an array.  Which does zero memory allocations
for a single entry and will then allocate a single node for your first
64 entries.

