Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1043FA1BF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Aug 2021 01:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhH0XXj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 19:23:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:52665 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232433AbhH0XXj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 19:23:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10089"; a="205253045"
X-IronPort-AV: E=Sophos;i="5.84,357,1620716400"; 
   d="scan'208";a="205253045"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 16:22:47 -0700
X-IronPort-AV: E=Sophos;i="5.84,357,1620716400"; 
   d="scan'208";a="538679488"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 16:22:47 -0700
Date:   Fri, 27 Aug 2021 16:22:46 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v7 05/19] iov_iter: Introduce fault_in_iov_iter_writeable
Message-ID: <20210827232246.GA1668365@agluck-desk2.amr.corp.intel.com>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-6-agruenba@redhat.com>
 <YSkz025ncjhyRmlB@zeniv-ca.linux.org.uk>
 <CAHk-=wh5p6zpgUUoY+O7e74X9BZyODhnsqvv=xqnTaLRNj3d_Q@mail.gmail.com>
 <YSk7xfcHVc7CxtQO@zeniv-ca.linux.org.uk>
 <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
 <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk>
 <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSlftta38M4FsWUq@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSlftta38M4FsWUq@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 09:57:10PM +0000, Al Viro wrote:
> On Fri, Aug 27, 2021 at 09:48:55PM +0000, Al Viro wrote:
> 
> > 	[btrfs]search_ioctl()
> > Broken with memory poisoning, for either variant of semantics.  Same for
> > arm64 sub-page permission differences, I think.
> 
> 
> > So we have 3 callers where we want all-or-nothing semantics - two in
> > arch/x86/kernel/fpu/signal.c and one in btrfs.  HWPOISON will be a problem
> > for all 3, AFAICS...
> > 
> > IOW, it looks like we have two different things mixed here - one that wants
> > to try and fault stuff in, with callers caring only about having _something_
> > faulted in (most of the users) and one that wants to make sure we *can* do
> > stores or loads on each byte in the affected area.
> > 
> > Just accessing a byte in each page really won't suffice for the second kind.
> > Neither will g-u-p use, unless we teach it about HWPOISON and other fun
> > beasts...  Looks like we want that thing to be a separate primitive; for
> > btrfs I'd probably replace fault_in_pages_writeable() with clear_user()
> > as a quick fix for now...
> > 
> > Comments?
> 
> Wait a sec...  Wasn't HWPOISON a per-page thing?  arm64 definitely does have
> smaller-than-page areas with different permissions, so btrfs search_ioctl()
> has a problem there, but arch/x86/kernel/fpu/signal.c doesn't have to deal
> with that...
> 
> Sigh...  I really need more coffee...

On Intel poison is tracked at the cache line granularity. Linux
inflates that to per-page (because it can only take a whole page away).
For faults triggered in ring3 this is pretty much the same thing because
mm/memory_failure.c unmaps the page ... so while you see a #MC on first
access, you get #PF when you retry. The x86 fault handler sees a magic
signature in the page table and sends a SIGBUS.

But it's all different if the #MC is triggerd from ring0. The machine
check handler can't unmap the page. It just schedules task_work to do
the unmap when next returning to the user.

But if your kernel code loops and tries again without a return to user,
then your get another #MC.

-Tony
