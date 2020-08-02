Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726F4235746
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Aug 2020 15:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgHBN5p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Aug 2020 09:57:45 -0400
Received: from albireo.enyo.de ([37.24.231.21]:57926 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgHBN5p (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Aug 2020 09:57:45 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1k2EUc-0007uG-D1; Sun, 02 Aug 2020 13:57:38 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1k2EUZ-0006B6-7g; Sun, 02 Aug 2020 15:57:35 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
References: <20200728131050.24443-1-madvenka@linux.microsoft.com>
        <CALCETrVy5OMuUx04-wWk9FJbSxkrT2vMfN_kANinudrDwC4Cig@mail.gmail.com>
        <6540b4b7-3f70-adbf-c922-43886599713a@linux.microsoft.com>
        <CALCETrWnNR5v3ZCLfBVQGYK8M0jAvQMaAc9uuO05kfZuh-4d6w@mail.gmail.com>
        <46a1adef-65f0-bd5e-0b17-54856fb7e7ee@linux.microsoft.com>
Date:   Sun, 02 Aug 2020 15:57:35 +0200
In-Reply-To: <46a1adef-65f0-bd5e-0b17-54856fb7e7ee@linux.microsoft.com>
        (Madhavan T. Venkataraman's message of "Fri, 31 Jul 2020 12:13:49
        -0500")
Message-ID: <87o8nttak0.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Madhavan T. Venkataraman:

> Standardization
> ---------------------
>
> Trampfd is a framework that can be used to implement multiple
> things. May be, a few of those things can also be implemented in
> user land itself. But I think having just one mechanism to execute
> dynamic code objects is preferable to having multiple mechanisms not
> standardized across all applications.
>
> As an example, let us say that I am able to implement support for
> JIT code. Let us say that an interpreter uses libffi to execute a
> generated function. The interpreter would use trampfd for the JIT
> code object and get an address. Then, it would pass that to libffi
> which would then use trampfd for the trampoline. So, trampfd based
> code objects can be chained.

There is certainly value in coordination.  For example, it would be
nice if unwinders could recognize the trampolines during all phases
and unwind correctly through them (including when interrupted by an
asynchronous symbol).  That requires some level of coordination with
the unwinder and dynamic linker.

A kernel solution could hide the intermediate state in a kernel-side
trap handler, but I think it wouldn't reduce the overall complexity.
