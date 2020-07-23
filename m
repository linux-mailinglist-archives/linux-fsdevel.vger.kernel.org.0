Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B40622B427
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jul 2020 19:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbgGWRIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jul 2020 13:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgGWRIq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:08:46 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6180AC0619E2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2020 10:08:46 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x8so2817903plm.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2020 10:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=NPbssqK1INtrFyjAUzj5mlbSJgxK4WzDaPmXZHhkVOg=;
        b=yoXd9uVkO2vV1qapKWvg6gqU+YlOechgMeu61k1dp7CN9clp8UmaHRbquyhgRG0EEc
         qzNe84TrLIXIyjqC0IiE0n1EHX+P8HvoY7yvHrCHdph8GNfNnaBIpslpqlns5gX8TQ4q
         Bjc8eIcn2XxbBGMyr4IOZe4gzlsbUnxZEddFJMD7FKjlftnULb8az0udybrX2ZdDEO6x
         +Zy+/yT5PdnRQvQeYA0xF4eJxdQH8BXXKKGfX9TFsapCl/a4p9//S4304AlD7ypcAdCx
         lgtOkhY7tTnU+9KXye1d1QzYZAXqKP44YDuwrRT/s98xYKGWvdcqCEQ8yQLWxSOQlrvX
         Yn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=NPbssqK1INtrFyjAUzj5mlbSJgxK4WzDaPmXZHhkVOg=;
        b=egti7jFnxKAt2KHjp0a9NMGQmqm/aPkE5tN1T+AYFD47LvbGI57RZCM6CFqG6CP0J5
         JRDok2K/Cny+E5NwSltg5kcyYC4Xu1Tv4Y5Ie1j9EfzPL/R1aftJWhb0sWITCoItIJZF
         764QAcaSR3xPtidtmUnuS5W9kD6OOuWYH3rzodJbXTe0WZCM+AxpTl5lo9FBKJl2a4Ri
         JPZ4TGerKjLRif8SDXUkX0beDa0fW7N6U2X69pZxb4NI7upoJdxBwFKmywNQNu5pQIu9
         pUNZSqZ+TrVxPQty0iKnQTvxCluqXT5xtS6LLTLpK2bUKFiEBfNzTeA0P6b/0nm921Qg
         xjbg==
X-Gm-Message-State: AOAM531r5dAhYnolPEobIGhew123m3AyMlbwhpboiTK4Lamklrq5rlWq
        UjBzfNuuXVrQIagt7b/PfAS71Q==
X-Google-Smtp-Source: ABdhPJzhEVeWE+MsYhg97fGrJZMWD4MyQ/tPFCjeaW/T/ed2wa91gkVSb8XcX/EmBjVpwheP/E/Q+w==
X-Received: by 2002:a17:90a:ff0c:: with SMTP id ce12mr1353809pjb.100.1595524125805;
        Thu, 23 Jul 2020 10:08:45 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:ecdf:69cc:bc40:aa6d? ([2601:646:c200:1ef2:ecdf:69cc:bc40:aa6d])
        by smtp.gmail.com with ESMTPSA id v197sm3695465pfc.35.2020.07.23.10.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2020 10:08:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
Date:   Thu, 23 Jul 2020 10:08:42 -0700
Message-Id: <C03DA782-BD1A-42E3-B118-ABB34BC5F2AF@amacapital.net>
References: <20200723165204.GB77434@romley-ivt3.sc.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Weiny Ira <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
In-Reply-To: <20200723165204.GB77434@romley-ivt3.sc.intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On Jul 23, 2020, at 9:52 AM, Fenghua Yu <fenghua.yu@intel.com> wrote:
>=20
> =EF=BB=BFHi, Dave,
>=20
>> On Thu, Jul 23, 2020 at 09:23:13AM -0700, Dave Hansen wrote:
>>> On 7/23/20 9:18 AM, Fenghua Yu wrote:
>>> The PKRS MSR has been preserved in thread_info during kernel entry. We
>>> don't need to preserve it in another place (i.e. idtentry_state).
>>=20
>> I'm missing how the PKRS MSR gets preserved in thread_info.  Could you
>> explain the mechanism by which this happens and point to the code
>> implementing it, please?
>=20
> [Sorry, my mistake: I mean "thread_struct" instead of "thread_info".
> Hopefully the typo doesn't change the essential part in my last email.]
>=20
> The "saved_pkrs" is defined in thread_struct and context switched in
> patch 04/17:
> https://lore.kernel.org/lkml/20200717072056.73134-5-ira.weiny@intel.com/
>=20
> Because there is no XSAVE support the PKRS MSR, we preserve it in
> "saved_pkrs" in thread_struct. It's initialized as 0 (init state, no
> protection key) in fork() or exec(). It's updated to a right protection
> value when a driver calls the updating API. The PKRS MSR is context
> switched by "saved_pkrs" when switching to a task (unless optimized if the=

> cached MSR is the same as the saved one).
>=20
>=20

Suppose some kernel code (a syscall or
kernel thread) changes PKRS then takes a page fault. The page fault handler n=
eeds a fresh PKRS. Then the page fault handler (say a VMA=E2=80=99s .fault h=
andler) changes PKRS.  The we get an interrupt. The interrupt *also* needs a=
 fresh PKRS and the page fault value needs to be saved somewhere.

So we have more than one saved value per thread, and thread_struct isn=E2=80=
=99t going to solve this problem.

But idtentry_state is also not great for a couple reasons.  Not all entries h=
ave idtentry_state, and the unwinder can=E2=80=99t find it for debugging. Fo=
r that matter, the page fault logic probably wants to know the previous PKRS=
, so it should either be stashed somewhere findable or it should be explicit=
ly passed around.

My suggestion is to enlarge pt_regs.  The save and restore logic can probabl=
y be in C, but pt_regs is the logical place to put a register that is saved a=
nd restored across all entries.

Whoever does this work will have the delightful job of figuring out whether B=
PF thinks that the layout of pt_regs is ABI and, if so, fixing the resulting=
 mess.

The fact the new fields will go at the beginning of pt_regs will make this a=
n entertaining prospect.=
