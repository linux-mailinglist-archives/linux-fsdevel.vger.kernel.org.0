Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A29031C73A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 09:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhBPIRD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 03:17:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:42062 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229916AbhBPIQk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 03:16:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613463352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cd6iBVx8TLBh3eG8PbSuUvtxi0546CjvNoO2Rg8UJbo=;
        b=ff0+X2CNo/g34XoaYWYd+6mjjJvmqDexKEitwg62RNGxJPmQENfikjDuVCe9o6D3+xi0C4
        fNMneR8n7GZVjxLI/Xk3uP5ivfK1EK6Xk6ErzCnCfwatUiUSJGhX5KRVDUOaGWv+ohz4rF
        CpFvVsxFEYtZd/aVNMEZbOx56ATbbYY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6FCFAB027;
        Tue, 16 Feb 2021 08:15:52 +0000 (UTC)
Date:   Tue, 16 Feb 2021 09:15:51 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v15 4/8] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
Message-ID: <YCt/N9LkJT1VJEW1@dhcp22.suse.cz>
References: <CAMZfGtWT8CJ-QpVofB2X-+R7GE7sMa40eiAJm6PyD0ji=FzBYQ@mail.gmail.com>
 <YCpmlGuoTakPJs1u@dhcp22.suse.cz>
 <CAMZfGtWd_ZaXtiEdMKhpnAHDw5CTm-CSPSXW+GfKhyX5qQK=Og@mail.gmail.com>
 <YCp04NVBZpZZ5k7G@dhcp22.suse.cz>
 <CAMZfGtV8-yJa_eGYtSXc0YY8KhYpgUo=pfj6TZ9zMo8fbz8nWA@mail.gmail.com>
 <YCqhDZ0EAgvCz+wX@dhcp22.suse.cz>
 <CAMZfGtW6n_YUbZOPFbivzn-HP4Q2yi0DrUoQ3JAjSYy5m17VWw@mail.gmail.com>
 <CAMZfGtWVwEdBfiof3=wW2-FUN4PU-N5J=HfiAETVbwbEzdvAGQ@mail.gmail.com>
 <YCrN4/EWRTOwNw72@dhcp22.suse.cz>
 <CAMZfGtX8xizYQxwB_Ffe6VcesaftkzGPDr=BP=6va_=aR3HikQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMZfGtX8xizYQxwB_Ffe6VcesaftkzGPDr=BP=6va_=aR3HikQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 16-02-21 12:34:41, Muchun Song wrote:
> On Tue, Feb 16, 2021 at 3:39 AM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > > Using GFP_KERNEL will also use the current task cpuset to allocate
> > > memory. Do we have an interface to ignore current task cpuset？If not,
> > > WQ may be the only option and it also will not limit the context of
> > > put_page. Right?
> >
> > Well, GFP_KERNEL is constrained to the task cpuset only if the said
> > cpuset is hardwalled IIRC. But I do not see why this is a problem.
> 
> I mean that if there are more than one node in the system,
> but the current task cpuset only allows one node.

How would that cpuset get a huge pages from a node which is not part of
the cpuset? Well, that would be possible if the cpuset was dynamic but I
am not sure that such a configuration would be very sensible along with
hardwall setup.

> If current
> node has no memory and other nodes have enough memory.
> We can fail to allocate vmemmap pages. But actually it is
> suitable to allocate vmemmap pages from other nodes.
> Right?

Falling back to a different node would be very suboptimal because then
you would have vmemmap back by remote pages. We do not want that.
-- 
Michal Hocko
SUSE Labs
