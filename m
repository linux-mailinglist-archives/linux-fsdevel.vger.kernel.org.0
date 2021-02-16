Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86C831CEDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 18:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhBPRSd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 12:18:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21138 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230166AbhBPRS1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:18:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613495820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IbwyoqWTddMQQM4e/pb2Tn5NqnOPDp0+cC8mDVS66VE=;
        b=GHo9tkX1SbVo+1OOHOI1jCap6OUfB4bCMxW4oxuD76Er6F/ojThTD9WEJhFPj/LLOeWxh5
        rSf81Za2VtpvsR2+eMKnxChzNeT/KJwyy7RWzdfAu44wYqjcSZo4J8dA2tESKfBcpfItMc
        bWFb/MJKriWt99QEJM9NEz4rxujy5z0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-KxZdhhyXMpKDSHckankMMw-1; Tue, 16 Feb 2021 12:16:50 -0500
X-MC-Unique: KxZdhhyXMpKDSHckankMMw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 465FB80402E;
        Tue, 16 Feb 2021 17:16:45 +0000 (UTC)
Received: from [10.36.114.70] (ovpn-114-70.ams2.redhat.com [10.36.114.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 615F35D9CC;
        Tue, 16 Feb 2021 17:16:37 +0000 (UTC)
To:     jejb@linux.ibm.com, Michal Hocko <mhocko@suse.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
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
References: <20210214091954.GM242749@kernel.org>
 <052DACE9-986B-424C-AF8E-D6A4277DE635@redhat.com>
 <244f86cba227fa49ca30cd595c4e5538fe2f7c2b.camel@linux.ibm.com>
 <YCo7TqUnBdgJGkwN@dhcp22.suse.cz>
 <be1d821d3f0aec24ad13ca7126b4359822212eb0.camel@linux.ibm.com>
 <YCrJjYmr7A2nO6lA@dhcp22.suse.cz>
 <12c3890b233c8ec8e3967352001a7b72a8e0bfd0.camel@linux.ibm.com>
 <dfd7db5c-a8c7-0676-59f8-70aa6bcaabe7@redhat.com>
 <000cfaa0a9a09f07c5e50e573393cda301d650c9.camel@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <5a8567a9-6940-c23f-0927-e4b5c5db0d5e@redhat.com>
Date:   Tue, 16 Feb 2021 18:16:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <000cfaa0a9a09f07c5e50e573393cda301d650c9.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>   For the other parts, the question is what we actually want to let
>> user space configure.
>>
>> Being able to specify "Very secure" "maximum secure" "average
>> secure"  all doesn't really make sense to me.
> 
> Well, it doesn't to me either unless the user feels a cost/benefit, so
> if max cost $100 per invocation and average cost nothing, most people
> would chose average unless they had a very good reason not to.  In your
> migratable model, if we had separate limits for non-migratable and
> migratable, with non-migratable being set low to prevent exhaustion,
> max secure becomes a highly scarce resource, whereas average secure is
> abundant then having the choice might make sense.

I hope that we can find a way to handle the migration part internally. 
Especially, because Mike wants the default to be "as secure as 
possible", so if there is a flag, it would have to be an opt-out flag.

I guess as long as we don't temporarily map it into the "owned" location 
in the direct map shared by all VCPUs we are in a good positon. But this 
needs more thought, of course.

> 
>>   The discussion regarding migratability only really popped up because
>> this is a user-visible thing and not being able to migrate can be a
>> real problem (fragmentation, ZONE_MOVABLE, ...).
> 
> I think the biggest use will potentially come from hardware
> acceleration.  If it becomes simple to add say encryption to a secret
> page with no cost, then no flag needed.  However, if we only have a
> limited number of keys so once we run out no more encrypted memory then
> it becomes a costly resource and users might want a choice of being
> backed by encryption or not.

Right. But wouldn't HW support with configurable keys etc. need more 
syscall parameters (meaning, even memefd_secret() as it is would not be 
sufficient?). I suspect the simplistic flag approach might not be 
sufficient. I might be wrong because I have no clue about MKTME and friends.

Anyhow, I still think extending memfd_create() might just be good enough 
- at least for now. Things like HW support might have requirements we 
don't even know yet and that we cannot even model in memfd_secret() 
right now.

-- 
Thanks,

David / dhildenb

