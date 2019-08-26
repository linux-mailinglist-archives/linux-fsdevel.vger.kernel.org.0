Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB709D7A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 22:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbfHZUpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 16:45:10 -0400
Received: from 195-159-176-226.customer.powertech.no ([195.159.176.226]:58990
        "EHLO blaine.gmane.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfHZUpI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:45:08 -0400
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <lnx-linux-fsdevel@m.gmane.org>)
        id 1i2LrK-0007aw-I0
        for linux-fsdevel@vger.kernel.org; Mon, 26 Aug 2019 22:45:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-fsdevel@vger.kernel.org
From:   sbaugh@catern.com
Subject: Re: [PATCH RESEND v11 7/8] open: openat2(2) syscall
Date:   Mon, 26 Aug 2019 19:50:50 +0000
Message-ID: <854l2366zp.fsf@catern.com>
References: <20190820033406.29796-1-cyphar@cyphar.com>
        <20190820033406.29796-8-cyphar@cyphar.com>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Cancel-Lock: sha1:ym8TD2+JE56rxevrCvTf9T8Ptcg=
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Aleksa Sarai <cyphar@cyphar.com> writes:
> To this end, we introduce the openat2(2) syscall. It provides all of the
> features of openat(2) through the @how->flags argument, but also
> also provides a new @how->resolve argument which exposes RESOLVE_* flags
> that map to our new LOOKUP_* flags. It also eliminates the long-standing
> ugliness of variadic-open(2) by embedding it in a struct.

I don't like this usage of a structure in memory to pass arguments that
would fit in registers. This would be quite inconvenient for me as a
userspace developer.

Others have brought up issues with this: the issue of seccomp, and the
issue of mismatch between the userspace interface and the kernel
interface, are the most important for me. I want to add another,
admittedly somewhat niche, concern.

This interfaces requires a program to allocate memory (even on the
stack) just to pass arguments to the kernel which could be passed
without allocating that memory. That makes it more difficult and less
efficient to use this syscall in any case where memory is not so easily
allocatable: such as early program startup or assembly, where the stack
may be limited in size or not even available yet, or when injecting a
syscall while ptracing.

A struct-passing interface was needed for clone, since we ran out of
registers; but we have not run out of registers yet for openat, so it
would be nice to avoid this if we can. We can always expand later...

