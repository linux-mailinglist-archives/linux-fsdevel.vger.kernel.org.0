Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE85B30C136
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 15:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhBBOQK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 09:16:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21605 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234217AbhBBOOH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 09:14:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612275160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mAXEVjxGkaVgIUFhfXA1HRN3FgtOlJcIpAQw2h/beVM=;
        b=eKDUxb1+pqSJGwixp0bJb9IpFbLQ2YWSNtr9y6B5b9tHnfKB8XWwqMi4lg2wcz689fqN+7
        ixbEtjubRl8BQ3SthB9ROO4tXppvD18dReUGmXO7MA7mXPXT1SkBZZqlAPN5rjZaPaek3k
        ft4gaH36hp6hgsL1Zdqrv2sUA+94Msc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-DO7GaD-qPMSuJ9daYkp31A-1; Tue, 02 Feb 2021 09:12:35 -0500
X-MC-Unique: DO7GaD-qPMSuJ9daYkp31A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B117B100A8E8;
        Tue,  2 Feb 2021 14:12:30 +0000 (UTC)
Received: from [10.36.114.148] (ovpn-114-148.ams2.redhat.com [10.36.114.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CE915B4A7;
        Tue,  2 Feb 2021 14:12:22 +0000 (UTC)
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
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
References: <303f348d-e494-e386-d1f5-14505b5da254@redhat.com>
 <20210126120823.GM827@dhcp22.suse.cz> <20210128092259.GB242749@kernel.org>
 <YBK1kqL7JA7NePBQ@dhcp22.suse.cz>
 <73738cda43236b5ac2714e228af362b67a712f5d.camel@linux.ibm.com>
 <YBPF8ETGBHUzxaZR@dhcp22.suse.cz>
 <6de6b9f9c2d28eecc494e7db6ffbedc262317e11.camel@linux.ibm.com>
 <YBkcyQsky2scjEcP@dhcp22.suse.cz> <20210202124857.GN242749@kernel.org>
 <6653288a-dd02-f9de-ef6a-e8d567d71d53@redhat.com>
 <YBlUXdwV93xMIff6@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v16 07/11] secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <211f0214-1868-a5be-9428-7acfc3b73993@redhat.com>
Date:   Tue, 2 Feb 2021 15:12:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YBlUXdwV93xMIff6@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02.02.21 14:32, Michal Hocko wrote:
> On Tue 02-02-21 14:14:09, David Hildenbrand wrote:
> [...]
>> As already expressed, I dislike allowing user space to consume an unlimited
>> number unmovable/unmigratable allocations. We already have that in some
>> cases with huge pages (when the arch does not support migration) - but there
>> we can at least manage the consumption using the whole max/reserved/free/...
>> infrastructure. In addition, adding arch support for migration shouldn't be
>> too complicated.
> 
> Well, mlock is not too different here as well. Hugepages are arguably an
> easier model because it requires an explicit pre-configuration by an
> admin. Mlock doesn't have anything like that. Please also note that
> while mlock pages are migrateable by default, this is not the case in
> general because they can be configured to disalow migration to prevent
> from minor page faults as some workloads require that (e.g. RT).

Yeah, however that is a very special case. In most cases mlock() simply 
prevents swapping, you still have movable pages you can place anywhere 
you like (including on ZONE_MOVABLE).

> Another example is ramdisk or even tmpfs (with swap storage depleted or
> not configured). Both are PITA from the OOM POV but they are manageable
> if people are careful.

Right, but again, special cases - e.g., tmpfs explicitly has to be resized.

> If secretmem behaves along those existing models
> then we know what to expect at least.

I think secretmem behaves much more like longterm GUP right now 
("unmigratable", "lifetime controlled by user space", "cannot go on 
CMA/ZONE_MOVABLE"). I'd either want to reasonably well control/limit it 
or make it behave more like mlocked pages.

-- 
Thanks,

David / dhildenb

