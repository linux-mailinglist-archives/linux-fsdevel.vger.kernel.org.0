Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A9C408A46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 13:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239494AbhIMLdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 07:33:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55632 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238644AbhIMLdr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:33:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BB1091FFCB;
        Mon, 13 Sep 2021 11:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631532750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MmOXV82ZmaGCqV2USJ7r1chshtX3p4vyPS/RDmpH9Kk=;
        b=vHJ/IqG0alI4RYXeXt2lzVpnkym3TKly6X3vzChUlIH1R77qODq709I17odCQgvkv/UxpH
        SKwrSpddX9iSgeoKOV4V6QpnuH3hpMbTYda2XSHEp8O7Arah0suPYatmAWfRLjZFRXvzgO
        +AxoNOvttcegmZToweCpn1IdmB1u81A=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8C2C3A3B88;
        Mon, 13 Sep 2021 11:32:30 +0000 (UTC)
Date:   Mon, 13 Sep 2021 13:32:30 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <YT82zg6UE9DtQLhL@dhcp22.suse.cz>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <20210911012324.6vb7tjbxvmpjfhxv@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911012324.6vb7tjbxvmpjfhxv@box.shutemov.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 11-09-21 04:23:24, Kirill A. Shutemov wrote:
> On Fri, Sep 10, 2021 at 04:16:28PM -0400, Kent Overstreet wrote:
> > So we should listen to the MM people.
> 
> Count me here.
> 
> I think the problem with folio is that everybody wants to read in her/his
> hopes and dreams into it and gets disappointed when see their somewhat
> related problem doesn't get magically fixed with folio.
> 
> Folio started as a way to relief pain from dealing with compound pages.
> It provides an unified view on base pages and compound pages. That's it.
> 
> It is required ground work for wider adoption of compound pages in page
> cache. But it also will be useful for anon THP and hugetlb.
> 
> Based on adoption rate and resulting code, the new abstraction has nice
> downstream effects. It may be suitable for more than it was intended for
> initially. That's great.
> 
> But if it doesn't solve your problem... well, sorry...
> 
> The patchset makes a nice step forward and cuts back on mess I created on
> the way to huge-tmpfs.
> 
> I would be glad to see the patchset upstream.

I do agree here. While points that Johannes brought up are relevant
and worth thinking about I do also see a clear advantage of folio (or
whatever $name) is bringing. The compound page handling is just a mess
and source of practical problems and bugs.

This really requires some systematic approach to deal with it. The
proposed type system is definitely a good way to approach it. Johannes
is not happy about having the type still refer to page units but I
haven't seen an example where that leads to a worse or harder to
maintain code so far. The evolution is likely not going to stop at the
current type system but I haven't seen any specifics to prove it would
stand in the way. The existing code (fs or other subsystem interacting
with MM) is going to require quite a lot of changes to move away from
struct page notion but I do not see folios to add fundamental blocker
there.

All that being said, not only I see folios to be a step into the
right direction to address compound pages mess it is also a code that
already exists and gives some real advantages. I haven't heard anybody
subscribing to a different approach and providing an implementation in a
foreseeable future so I would rather go with this approach then dealing
with the existing code long term.
-- 
Michal Hocko
SUSE Labs
