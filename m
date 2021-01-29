Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFB130889D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 12:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhA2LvR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 06:51:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:52542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232310AbhA2K0S (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 05:26:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611908593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s/Q67vMMYuPsjuSK9sLzU1LCeFaWe4xF/l4UFNZMONQ=;
        b=AVLJQflv/+SYkSv4ERXyiT7/jY3GzNjJm97jAboIN3LMwVBbN2x7H/KCFiEihomOMdrfsH
        gcyRhiH9LkuycXyRf5uQ6UzJ7Ci67vQ0hTzLhrvCsqWvWU3wqQc1iBhmw76ZvSCZGUhLvj
        8w0LFU8kORoRU9LyGyyHc/SD3SCCYBo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8D1A8AFEC;
        Fri, 29 Jan 2021 08:23:13 +0000 (UTC)
Date:   Fri, 29 Jan 2021 09:23:12 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH v16 07/11] secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <YBPF8ETGBHUzxaZR@dhcp22.suse.cz>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-8-rppt@kernel.org>
 <20210126114657.GL827@dhcp22.suse.cz>
 <303f348d-e494-e386-d1f5-14505b5da254@redhat.com>
 <20210126120823.GM827@dhcp22.suse.cz>
 <20210128092259.GB242749@kernel.org>
 <YBK1kqL7JA7NePBQ@dhcp22.suse.cz>
 <73738cda43236b5ac2714e228af362b67a712f5d.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73738cda43236b5ac2714e228af362b67a712f5d.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 28-01-21 13:05:02, James Bottomley wrote:
> Obviously the API choice could be revisited
> but do you have anything to add over the previous discussion, or is
> this just to get your access control?

Well, access control is certainly one thing which I still believe is
missing. But if there is a general agreement that the direct map
manipulation is not that critical then this will become much less of a
problem of course.

It all boils down whether secret memory is a scarce resource. With the
existing implementation it really is. It is effectivelly repeating
same design errors as hugetlb did. And look now, we have a subtle and
convoluted reservation code to track mmap requests and we have a cgroup
controller to, guess what, have at least some control over distribution
if the preallocated pool. See where am I coming from?

If the secret memory is more in line with mlock without any imposed
limit (other than available memory) in the end then, sure, using the same
access control as mlock sounds reasonable. Btw. if this is really
just a more restrictive mlock then is there any reason to not hook this
into the existing mlock infrastructure (e.g. MCL_EXCLUSIVE)?
Implications would be that direct map would be handled on instantiation/tear
down paths, migration would deal with the same (if possible). Other than
that it would be mlock like.
-- 
Michal Hocko
SUSE Labs
