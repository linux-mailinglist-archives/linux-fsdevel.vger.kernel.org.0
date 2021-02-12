Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1169D31A77D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 23:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhBLWXX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 17:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhBLWXQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 17:23:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F814C061574;
        Fri, 12 Feb 2021 14:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gcKKlfGrXCNStLb77lduw+pSfBW0G3SrA7qx+d7hHpY=; b=l+hj+dUZzkrD66BOmu9NMPhELV
        letFIgAorb6tgN8wQH3Ac9PqiCC5ex3XBOYsL1/hCFqpZeyP8U+ddX13otsbesapH5cmPC1PfBUNa
        DXugmettieUb3WZPsikow1WxhI7o5zDpRsenp1VR13gUWjlmgYKOuodH2SCpSREMPCKu7YBGHd/ij
        Yo1/XyFKFalI4cZ3CM70V7uH8j6ICKDB/IOcbo+QJiNkVME+BRIz8xQjfGcLNIxO21rcHD/S6xllU
        5dQkfGfbDrT3YD0g//P7sEm8hkm9lmBPZsrOokpBu4ct6lly5b15a7FYeDPjYvPGcAD4YXnZR0VSI
        XbEuG8xw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lAgor-00CCXn-7e; Fri, 12 Feb 2021 22:21:45 +0000
Date:   Fri, 12 Feb 2021 22:21:45 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v5 05/10] userfaultfd: add minor fault registration mode
Message-ID: <20210212222145.GB2858050@casper.infradead.org>
References: <20210210212200.1097784-1-axelrasmussen@google.com>
 <20210210212200.1097784-6-axelrasmussen@google.com>
 <CAJHvVch8jmqu=Hi9=1CHzPHJfZCRvSb6g7xngSBDQ_nDfSj-gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJHvVch8jmqu=Hi9=1CHzPHJfZCRvSb6g7xngSBDQ_nDfSj-gA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 11, 2021 at 11:28:09AM -0800, Axel Rasmussen wrote:
> Ah, I had added this just after VM_UFFD_WP, without noticing that this
> would be sharing a bit with VM_LOCKED. That seems like not such a
> great idea.
> 
> I don't see another unused bit, and I don't see some other obvious
> candidate to share with. So, the solution that comes to mind is

it'd be even better if you didn't use the last unused bit for UFFD_WP.
not sure how feasible that is, but you can see we're really short on
bits here.
