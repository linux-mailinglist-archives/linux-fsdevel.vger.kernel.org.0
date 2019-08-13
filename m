Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1526D8BD69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 17:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbfHMPlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 11:41:18 -0400
Received: from orelay.tugraz.at ([129.27.2.230]:9262 "EHLO orelay.tugraz.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbfHMPlS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:41:18 -0400
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Aug 2019 11:41:15 EDT
Received: from mx01.iaik.tugraz.at (blackstone.iaik.at [129.27.152.26])
        by mrelayout.tugraz.at (Postfix) with ESMTPSA id 467Gwf54Hxz8ql3;
        Tue, 13 Aug 2019 17:34:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mrelayout.tugraz.at 467Gwf54Hxz8ql3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
        s=mailrelay; t=1565710469;
        bh=3+1uN8R8+i16Iygk+2mDQxITYNuBvydPnLHqbZMhhbE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=cTdYhn0Di0tK/WIMpTlHZZmqSgRMH3GKc4pR9f9UTrsIFsolWnVH8/pZv9xGw/avf
         58cPlyXko9fecMQ1reRvbev/ELiZPRfQLM6JBE6+tKyYePB2zm9l4l+cH0l7Z7PycL
         XO/Y0A5sgtKEA7ai+83tugVJHnVdt1uPXvkiAla8=
Received: from [10.71.23.192] (8.25.222.101) by EXCG01-INT.iaik.tugraz.at
 (2002:811b:981a::811b:981a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 13
 Aug 2019 17:34:18 +0200
Subject: Re: [PATCH v5 1/6] mm/page_idle: Add per-pid idle page tracking using
 virtual index
To:     Jann Horn <jannh@google.com>, Michal Hocko <mhocko@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
CC:     kernel list <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Borislav Petkov" <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>,
        "Daniel Colascione" <dancol@google.com>, <fmayer@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        kernel-team <kernel-team@android.com>,
        Linux API <linux-api@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>, <namhyung@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Suren Baghdasaryan <surenb@google.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
References: <20190807171559.182301-1-joel@joelfernandes.org>
 <CAG48ez0ysprvRiENhBkLeV9YPTN_MB18rbu2HDa2jsWo5FYR8g@mail.gmail.com>
 <20190813100856.GF17933@dhcp22.suse.cz>
 <CAG48ez2cuqe_VYhhaqw8Hcyswv47cmz2XmkqNdvkXEhokMVaXg@mail.gmail.com>
From:   Daniel Gruss <daniel.gruss@iaik.tugraz.at>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.gruss@iaik.tugraz.at; prefer-encrypt=mutual; keydata=
 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
 v8D8ArI3
Message-ID: <d6ae7f06-f0ef-ec00-a020-98e7cfada281@iaik.tugraz.at>
Date:   Tue, 13 Aug 2019 17:34:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez2cuqe_VYhhaqw8Hcyswv47cmz2XmkqNdvkXEhokMVaXg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [8.25.222.101]
X-ClientProxiedBy: EXCG01-EXT.iaik.tugraz.at (2002:811b:98d3::811b:98d3) To
 EXCG01-INT.iaik.tugraz.at (2002:811b:981a::811b:981a)
X-TM-AS-Product-Ver: SMEX-12.5.0.1684-8.5.1010-24844.005
X-TM-AS-Result: No-14.382400-4.000000-10
X-TMASE-MatchedRID: 0lhM5bBmjEPmLzc6AOD8DfHkpkyUphL9AQ8mtiWx//o/hcT28SJs8uD9
        pOnPHAzhcUp8V3Al4iXhvj8c2bhgihvXuwv8L4HaSszr2nuUNKzbjtx2Oq4Xg/n6214PlHOFRrz
        Ipk4noLUItWSsjLDRh2MSJ0HWAsy3eowfs+b4f+1WfOVCJoTbWh0uOLC2hwDynvxplJ6sWvDFgy
        mj9DufcpUlXPCybjjpyUmJtMlYIk4EpTm5f4ffZSX+a5eEMES4vupteabB3fV/GXao7FChFVnbf
        l9ZhZv90qZ9l/HrySb58zKcJ6DmacX6zzMWVMJEN19PjPJahlLUHmaN+mm9YGmycYYiBYyZLLer
        TDWsZmYvE40xnii1XOzznoLIx35H+GfEEInjVF5l2ityh8f8aZ661eVJ1FWN2VVfO8p2c0v5ECF
        bXGR5l6tUn36QB84O49ojshnO5h4ocApp2HQ05Y6cpbnLdja9j87/LK+2sqOA6UrbM3j3qT2j/N
        8mMgrkle1SEYlyiKSPZSqM8MVnirhYaHW9RIv/bWsCUkrA4EkiJN3aXuV/ofa7agslQWYY+Tnzq
        hV8NpDYw0vFR+xKH0eUcoyt6sr0EbZg2oCkmJjwoYkKJX7f8qRbM2iyYu2pwj10jtt9j+84+qrs
        HfOFPLJna51YX1d4zF273/DE1XADpmiSD/gHbxrRZIDqhgsgAp+UH372RZVGM2uNXRqsUkOf7N3
        I4ltrfS0Ip2eEHny+qryzYw2E8LLn+0Vm71Lcq7rFUcuGp/HCttcwYNipX4nxgmBGuBcXi+KYK1
        c6e5b1o76zQcqLeiWEjGh+UzAiUwqpGcnw30E=
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.382400-4.000000
X-TMASE-Version: SMEX-12.5.0.1684-8.5.1010-24844.005
X-TM-SNTS-SMTP: 1ECB56E9596B344772ED14E96F42C35887618A0E2F40B0E81DEE63A3AB660A7E2000:9
X-TUG-Backscatter-control: IqAlG2Mm08USmfDJcRVXXA
X-Spam-Scanner: SpamAssassin 3.003001 
X-Spam-Score-relay: -1.9
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.116
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/13/19 5:29 PM, Jann Horn wrote:
> On Tue, Aug 13, 2019 at 12:09 PM Michal Hocko <mhocko@kernel.org> wrote:
>> On Mon 12-08-19 20:14:38, Jann Horn wrote:
>>> On Wed, Aug 7, 2019 at 7:16 PM Joel Fernandes (Google)
>>> <joel@joelfernandes.org> wrote:
>>>> The page_idle tracking feature currently requires looking up the pagemap
>>>> for a process followed by interacting with /sys/kernel/mm/page_idle.
>>>> Looking up PFN from pagemap in Android devices is not supported by
>>>> unprivileged process and requires SYS_ADMIN and gives 0 for the PFN.
>>>>
>>>> This patch adds support to directly interact with page_idle tracking at
>>>> the PID level by introducing a /proc/<pid>/page_idle file.  It follows
>>>> the exact same semantics as the global /sys/kernel/mm/page_idle, but now
>>>> looking up PFN through pagemap is not needed since the interface uses
>>>> virtual frame numbers, and at the same time also does not require
>>>> SYS_ADMIN.
>>>>
>>>> In Android, we are using this for the heap profiler (heapprofd) which
>>>> profiles and pin points code paths which allocates and leaves memory
>>>> idle for long periods of time. This method solves the security issue
>>>> with userspace learning the PFN, and while at it is also shown to yield
>>>> better results than the pagemap lookup, the theory being that the window
>>>> where the address space can change is reduced by eliminating the
>>>> intermediate pagemap look up stage. In virtual address indexing, the
>>>> process's mmap_sem is held for the duration of the access.
>>>
>>> What happens when you use this interface on shared pages, like memory
>>> inherited from the zygote, library file mappings and so on? If two
>>> profilers ran concurrently for two different processes that both map
>>> the same libraries, would they end up messing up each other's data?
>>
>> Yup PageIdle state is shared. That is the page_idle semantic even now
>> IIRC.
>>
>>> Can this be used to observe which library pages other processes are
>>> accessing, even if you don't have access to those processes, as long
>>> as you can map the same libraries? I realize that there are already a
>>> bunch of ways to do that with side channels and such; but if you're
>>> adding an interface that allows this by design, it seems to me like
>>> something that should be gated behind some sort of privilege check.
>>
>> Hmm, you need to be priviledged to get the pfn now and without that you
>> cannot get to any page so the new interface is weakening the rules.
>> Maybe we should limit setting the idle state to processes with the write
>> status. Or do you think that even observing idle status is useful for
>> practical side channel attacks? If yes, is that a problem of the
>> profiler which does potentially dangerous things?
> 
> I suppose read-only access isn't a real problem as long as the
> profiler isn't writing the idle state in a very tight loop... but I
> don't see a usecase where you'd actually want that? As far as I can
> tell, if you can't write the idle state, being able to read it is
> pretty much useless.
> 
> If the profiler only wants to profile process-private memory, then
> that should be implementable in a safe way in principle, I think, but
> since Joel said that they want to profile CoW memory as well, I think
> that's inherently somewhat dangerous.

I agree that allowing profiling of shared pages would leak information.
To me the use case is not entirely clear. This is not a feature that
would normally be run in everyday computer usage, right?
