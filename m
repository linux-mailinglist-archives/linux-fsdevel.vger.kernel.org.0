Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2674A4B8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 17:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349709AbiAaQOD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 11:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244114AbiAaQN7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:13:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE10C061714;
        Mon, 31 Jan 2022 08:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NLdODiHTPTsbH2gcUJrMZUfjS0qe2bnC35PSPmqa0PU=; b=KfQvseu3bFxdTGbr/MHWv5i1Vk
        ZypEn1p52ab5g02GlNK8qYLjtPUyVuBpopwTXNy7ymM7FU7D3vJQApnwtGUF394nu0xFbhdwgK5q0
        7y8oxIj63QcxL4kaZoTkfRIcY4a8YQyWFIEEWoLHe6DMgEPeELnyUiFCWxywIUID6A/aH/sV/Saif
        4ImrDpOmWnUNfcUJcxywC2UOXLcgXGN6CnGAGnjxtfg5oHv8NC/gHIDSYG8D45CyMXD7+s1KOSkST
        wkk7ir1ev1/lq0HAo4JONiaHITq1mgxyQwHONqvEA8WGE0Hr/uNyrwMK4Qx/nwwqdfosxOJE0MZKH
        y81leLpg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEZJT-00A7DP-2f; Mon, 31 Jan 2022 16:13:55 +0000
Date:   Mon, 31 Jan 2022 16:13:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH] binfmt_elf: Take the mmap lock when walking the VMA list
Message-ID: <YfgKw5z2uswzMVRQ@casper.infradead.org>
References: <20220131153740.2396974-1-willy@infradead.org>
 <871r0nriy4.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871r0nriy4.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 10:03:31AM -0600, Eric W. Biederman wrote:
> "Matthew Wilcox (Oracle)" <willy@infradead.org> writes:
> 
> > I'm not sure if the VMA list can change under us, but dump_vma_snapshot()
> > is very careful to take the mmap_lock in write mode.  We only need to
> > take it in read mode here as we do not care if the size of the stack
> > VMA changes underneath us.
> >
> > If it can be changed underneath us, this is a potential use-after-free
> > for a multithreaded process which is dumping core.
> 
> The problem is not multi-threaded process so much as processes that
> share their mm.

I don't understand the difference.  I appreciate that another process can
get read access to an mm through, eg, /proc, but how can another process
(that isn't a thread of this process) modify the VMAs?

> I think rather than take a lock we should be using the snapshot captured
> with dump_vma_snapshot.  Otherwise we have the very real chance that the
> two get out of sync.  Which would result in a non-sense core file.
> 
> Probably that means that dump_vma_snapshot needs to call get_file on
> vma->vm_file store it in core_vma_metadata.
> 
> Do you think you can fix it something like that?

Uhh .. that seems like it needs a lot more understanding of binfmt_elf
than I currently possess.  I'd rather spend my time working on folios
than learning much more about binfmt_elf.  I was just trying to fix an
assertion failure with the maple tree patches (we now assert that you're
holding a lock when walking the list of VMAs).

