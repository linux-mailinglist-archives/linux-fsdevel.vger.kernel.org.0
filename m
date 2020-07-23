Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B5C22B7A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jul 2020 22:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgGWUXd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jul 2020 16:23:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32818 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgGWUXc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:23:32 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595535810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=13eX65NKhTLwr4wa9nwWsPlfdutzeNj03w02PC/5rs4=;
        b=1jhXPCQJstdH9CtCCpLyVZrksLIJXuuhxFGZnUfU+3pOZrI2KPqYgwbQ0Sm6xJAm0rqb84
        MHefvsezd2XnqxVHrgIgYMxqPKxJw66D6fHc3dzQpiqG2CEqUFsp0YBLPVaaHTntLvme+H
        /Q8NDd4wYx6RFEtIrLe9e6gf5/SxK6E6ht8GAnl2/bGnX2DS7v/GfkzPP8deRI3nk6JNGz
        27vZK5cyaZYNrHexeR5733cnor3v8w+8CWKk5ger8jF9c2FgL5I5wddjdqqVfWk25QGE2H
        3ASkgTxi1JE5c3gbGfZu716QRCpJgAIHFiydJcxvc3hVBjjwb9YihZ2FZYZpkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595535810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=13eX65NKhTLwr4wa9nwWsPlfdutzeNj03w02PC/5rs4=;
        b=MQsGZUsaQ6TJWdR6X93SMfni2qTkk1ixXSwjPCEB5I6pgQ0aMVt+vX2XZ7ErADgwbnwtgk
        5MptZ2mJQ+GxetAg==
To:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Weiny Ira <ira.weiny@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list\:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
In-Reply-To: <71f0e3d8-6dfa-742d-eaa7-330b59611e2f@intel.com>
References: <20200723165204.GB77434@romley-ivt3.sc.intel.com> <C03DA782-BD1A-42E3-B118-ABB34BC5F2AF@amacapital.net> <71f0e3d8-6dfa-742d-eaa7-330b59611e2f@intel.com>
Date:   Thu, 23 Jul 2020 22:23:29 +0200
Message-ID: <87ft9ivv3y.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave Hansen <dave.hansen@intel.com> writes:

> On 7/23/20 10:08 AM, Andy Lutomirski wrote:
>> Suppose some kernel code (a syscall or kernel thread) changes PKRS
>> then takes a page fault. The page fault handler needs a fresh PKRS.
>> Then the page fault handler (say a VMA=E2=80=99s .fault handler) changes
>> PKRS.  The we get an interrupt. The interrupt *also* needs a fresh
>> PKRS and the page fault value needs to be saved somewhere.
>>=20
>> So we have more than one saved value per thread, and thread_struct
>> isn=E2=80=99t going to solve this problem.
>
> Taking a step back...  This is all true only if we decide that we want
> protection keys to provide protection during exceptions and interrupts.
>  Right now, the code supports nesting:
>
> 	kmap(foo);
> 		kmap(bar);
> 		kunmap(bar);
> 	kunmap(foo);
>
> with a reference count.  So, the nested kmap() will see the count
> elevated and do nothing.

Hopefully with a big fat warning if the nested map requires a different
key than the outer one.
