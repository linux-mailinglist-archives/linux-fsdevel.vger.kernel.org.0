Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BEB462816
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 00:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhK2XTw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 18:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhK2XTh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:19:37 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F2CC0619DC;
        Mon, 29 Nov 2021 15:12:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4ED62CE16E7;
        Mon, 29 Nov 2021 23:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665C2C53FAD;
        Mon, 29 Nov 2021 23:12:44 +0000 (UTC)
Date:   Mon, 29 Nov 2021 23:12:41 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: Avoid live-lock in search_ioctl() on hardware
 with sub-page faults
Message-ID: <YaVeafjbutiVXavv@arm.com>
References: <CAHc6FU4-P9sVexcNt5CDQxROtMAo=kH8hEu==AAhZ_+Zv53=Ag@mail.gmail.com>
 <20211127123958.588350-1-agruenba@redhat.com>
 <YaJM4n31gDeVzUGA@arm.com>
 <CAHc6FU7BSL58GVkOh=nsNQczRKG3P+Ty044zs7PjKPik4vzz=Q@mail.gmail.com>
 <YaTEkAahkCwuQdPN@arm.com>
 <CAHc6FU6zVi9A2D3V3T5zE71YAdkBiJTs0ao1Q6ysSuEp=bz8fQ@mail.gmail.com>
 <YaTziROgnFwB6Ddj@arm.com>
 <CAHk-=wiZgAgcynfLsop+D1xBUAZ-Z+NUBxe9mb-AedecFRNm+w@mail.gmail.com>
 <YaU+aDG5pCAba57r@arm.com>
 <CAHk-=wjZ6zME2SzohM1P_-B0BNi2JJgvz22ypF-EuAQiVKipRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjZ6zME2SzohM1P_-B0BNi2JJgvz22ypF-EuAQiVKipRg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 29, 2021 at 01:53:01PM -0800, Linus Torvalds wrote:
> On Mon, Nov 29, 2021 at 12:56 PM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > I think that would be useful, though it doesn't solve the potential
> > livelock with sub-page faults.
> 
> I was assuming we'd just do the sub-page faults.
> 
> In fact, I was assuming we'd basically just replace all the PAGE_ALIGN
> and PAGE_SIZE with SUBPAGE_{ALIGN,SIZE}, together with something like
> 
>         if (size > PAGE_SIZE)
>                 size = PAGE_SIZE;
> 
> to limit that size thing (or possibly make that "min size" be a
> parameter, so that people who have things like that "I need at least
> this initial structure to be copied" issue can document their minimum
> size needs).

Ah, so fault_in_writeable() would never fault in the whole range (if too
large). When copy_to_user() goes beyond the faulted in range, it may
fail and we go back to fault in a bit more of the range. A copy loop
would be equivalent to:

	fault_addr = ubuf;
	end = ubuf + size;
	while (1) {
		if (fault_in_writeable(fault_addr,
				       min(PAGE_SIZE, end - fault_addr)))
			break;
		left = copy_to_user(ubuf, kbuf, size);
		if (!left)
			break;
		fault_addr = end - left;
	}

That should work. I'll think about it tomorrow, getting late over here.

(I may still keep the sub-page probing in the arch code, see my earlier
exchanges with Andreas)

-- 
Catalin
