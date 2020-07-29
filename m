Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69368231F59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 15:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgG2N3o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 09:29:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56388 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726365AbgG2N3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 09:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596029380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pHdy6Zb9Xi6Br1uklysJIGNGzShuC9IUN8gmmUSKfJ8=;
        b=StrTU9oAaFyMo8uishULmnxLv3sKAnkqy15rvlzA2HfO+NXVnvv0Cspud/eRZeYdSPaht2
        IUV460kzHsVD/jpGuIUtU9OQFwpHqrWvX0TSUKtgr/FCqj8zKLMQQvr+ssay3zVb/xgN/F
        pyba1BecjySRY2XMQ5NeRi6RyZTcoyo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-oUnvNmSeOLyVa6xnjYceCQ-1; Wed, 29 Jul 2020 09:29:36 -0400
X-MC-Unique: oUnvNmSeOLyVa6xnjYceCQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE5481902EA0;
        Wed, 29 Jul 2020 13:29:34 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-113-29.ams2.redhat.com [10.36.113.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B422869327;
        Wed, 29 Jul 2020 13:29:32 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     madvenka@linux.microsoft.com,
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
Date:   Wed, 29 Jul 2020 15:29:31 +0200
In-Reply-To: <CALCETrVy5OMuUx04-wWk9FJbSxkrT2vMfN_kANinudrDwC4Cig@mail.gmail.com>
        (Andy Lutomirski's message of "Tue, 28 Jul 2020 10:31:59 -0700")
Message-ID: <87pn8eo3es.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Andy Lutomirski:

> This is quite clever, but now I=E2=80=99m wondering just how much kernel =
help
> is really needed. In your series, the trampoline is an non-executable
> page.  I can think of at least two alternative approaches, and I'd
> like to know the pros and cons.
>
> 1. Entirely userspace: a return trampoline would be something like:
>
> 1:
> pushq %rax
> pushq %rbc
> pushq %rcx
> ...
> pushq %r15
> movq %rsp, %rdi # pointer to saved regs
> leaq 1b(%rip), %rsi # pointer to the trampoline itself
> callq trampoline_handler # see below
>
> You would fill a page with a bunch of these, possibly compacted to get
> more per page, and then you would remap as many copies as needed.

libffi does something like this for iOS, I believe.

The only thing you really need is a PC-relative indirect call, with the
target address loaded from a different page.  The trampoline handler can
do all the rest because it can identify the trampoline from the stack.
Having a closure parameter loaded into a register will speed things up,
of course.

I still hope to transition libffi to this model for most Linux targets.
It really simplifies things because you don't have to deal with cache
flushes (on both the data and code aliases for SELinux support).

But the key observation is that efficient trampolines do not need
run-time code generation at all because their code is so regular.

Thanks,
Florian

