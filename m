Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7133F22CC30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 19:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgGXR33 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 13:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgGXR32 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:29:28 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B9CC0619E6
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 10:29:28 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gc9so5664964pjb.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 10:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=xVJb6QB7yJwnn1Z6Ovzuc7SiH2/mFZI/eEetibZkjak=;
        b=oCF2bACf0J3wi10Mkevj6a1lx9ZJ2XYqftXol/Y5C3BUVETOi1ThoRhsL2OxKFCyb4
         LGJ3ZE9QuRoT+dYLR9CdhNjE9P+KA1F0J34lD0z4Rjmsdl1uULCFsHQh/kjIrw/3yYIN
         MIxEx6ObahD1W2wfYbyu5J04MgrODyT6hzuLM3mpaqgWNY1btI1HYMmRRqfrG327H9oM
         z5+CURUIEaZafgf40maNhBKcXiwP+sIOTIqvFURURI9WNSOzDt9L7YckftzfASDKb67X
         c6S0yxsINqy7Fs9MCqKwbe5ZznH0YewS4KMFQ8V9Fo2+D3qH4LKoiOb9hjdKp/ooZMns
         71UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=xVJb6QB7yJwnn1Z6Ovzuc7SiH2/mFZI/eEetibZkjak=;
        b=Wkvuruv0rDX+Ken5VkjwKaQfVNDsL2unBehYkTzMkoCze0X6lHx/0ei4A6ETyoNtfV
         S2WZGvGMy2JxJ34GH/6UpzZsPZJASYH8p0Q+3GKiJ1uR7SX4i/zp/FtT3P0Dz5U5hi+b
         imdHO9Yj9syKZQMRhMs9qoFPADwkFWEVO05Sh4jCTxRtx2uTyH79FO0i/DoBsqZRGnm/
         6wWrgffbdSXgNMWIPLGA4ffsZy6LS6HfCZ6mYeFXOtbyJ/8wKI4d+tPO5HNLF6bQLBQc
         887WjARAzSh+3RcbY7x20EWl2vTdl1KkR/oxkJUwqB1T3nu8XUHYBjwPdYqa5EfC8zHU
         bvEg==
X-Gm-Message-State: AOAM5324tIZG+XDIv/oWBRIqCH9awT5wRZ38M0pP3Vmp4fRrJ7ceAXFm
        v1STNzshB6qRn/2EFHdyaAxSJw==
X-Google-Smtp-Source: ABdhPJxgGZkOO3kQzBrpxCwHwlk1F6DYD0lzx0NwksvJwkCVThBWugwQYsACXzFP/Kw/IrlXRyq2VQ==
X-Received: by 2002:a17:90a:1b2c:: with SMTP id q41mr6495292pjq.195.1595611767681;
        Fri, 24 Jul 2020 10:29:27 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:cc1b:c95e:6185:cfc7? ([2601:646:c200:1ef2:cc1b:c95e:6185:cfc7])
        by smtp.gmail.com with ESMTPSA id x66sm6882326pgb.12.2020.07.24.10.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 10:29:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
Date:   Fri, 24 Jul 2020 10:29:23 -0700
Message-Id: <D866BD75-42A2-43B2-B07A-55BCC3781FEC@amacapital.net>
References: <20200724172344.GO844235@iweiny-DESK2.sc.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
In-Reply-To: <20200724172344.GO844235@iweiny-DESK2.sc.intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On Jul 24, 2020, at 10:23 AM, Ira Weiny <ira.weiny@intel.com> wrote:
>=20
> =EF=BB=BFOn Thu, Jul 23, 2020 at 10:15:17PM +0200, Thomas Gleixner wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>>=20
>>> Ira Weiny <ira.weiny@intel.com> writes:
>>>> On Fri, Jul 17, 2020 at 12:06:10PM +0200, Peter Zijlstra wrote:
>>>>>> On Fri, Jul 17, 2020 at 12:20:56AM -0700, ira.weiny@intel.com wrote:
>>>>> I've been really digging into this today and I'm very concerned that I=
'm
>>>>> completely missing something WRT idtentry_enter() and idtentry_exit().=

>>>>>=20
>>>>> I've instrumented idt_{save,restore}_pkrs(), and __dev_access_{en,dis}=
able()
>>>>> with trace_printk()'s.
>>>>>=20
>>>>> With this debug code, I have found an instance where it seems like
>>>>> idtentry_enter() is called without a corresponding idtentry_exit().  T=
his has
>>>>> left the thread ref counter at 0 which results in very bad things happ=
ening
>>>>> when __dev_access_disable() is called and the ref count goes negative.=

>>>>>=20
>>>>> Effectively this seems to be happening:
>>>>>=20
>>>>> ...
>>>>>    // ref =3D=3D 0
>>>>>    dev_access_enable()  // ref +=3D 1 =3D=3D> disable protection
>>>>>        // exception  (which one I don't know)
>>>>>            idtentry_enter()
>>>>>                // ref =3D 0
>>>>>                _handler() // or whatever code...
>>>>>            // *_exit() not called [at least there is no trace_printk()=
 output]...
>>>>>            // Regardless of trace output, the ref is left at 0
>>>>>    dev_access_disable() // ref -=3D 1 =3D=3D> -1 =3D=3D> does not enab=
le protection
>>>>>    (Bad stuff is bound to happen now...)
>>>=20
>>> Well, if any exception which calls idtentry_enter() would return without=

>>> going through idtentry_exit() then lots of bad stuff would happen even
>>> without your patches.
>>>=20
>>>> Also is there any chance that the process could be getting scheduled an=
d that
>>>> is causing an issue?
>>>=20
>>> Only from #PF, but after the fault has been resolved and the tasks is
>>> scheduled in again then the task returns through idtentry_exit() to the
>>> place where it took the fault. That's not guaranteed to be on the same
>>> CPU. If schedule is not aware of the fact that the exception turned off
>>> stuff then you surely get into trouble. So you really want to store it
>>> in the task itself then the context switch code can actually see the
>>> state and act accordingly.
>>=20
>> Actually thats nasty as well as you need a stack of PKRS values to
>> handle nested exceptions. But it might be still the most reasonable
>> thing to do. 7 PKRS values plus an index should be really sufficient,
>> that's 32bytes total, not that bad.
>=20
> I've thought about this a bit more and unless I'm wrong I think the
> idtentry_state provides for that because each nested exception has it's ow=
n
> idtentry_state doesn't it?

Only the ones that use idtentry_enter() instead of, say, nmi_enter().

>=20
> Ira
