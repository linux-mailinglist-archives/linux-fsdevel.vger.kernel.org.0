Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239A223353D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 17:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgG3PXA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 11:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG3PXA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:23:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D762C061574;
        Thu, 30 Jul 2020 08:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4bydmAjPf0XV0W/dCiNPJqn8R+6FiklWLJpmzcUfDKs=; b=BXjcyU0xM7pYt0CK9swwyhX4Pz
        1l37kX/MvEr6EFtNbLFRZWRRW06DnyKKHzHD/jj18TtQv7bSGl9tl81QAygMuGd0771Gfmo3a1iSy
        9Dssl4YE3F+pYskQPX9lRIgfl8m6P4y75/EZ7YwSKTz3dxHsNZmGzvd79qRY1CZi5iV/VnIrmVJb0
        7shEkS9OJ6G7cmx02PmeY0b8MoTBXWIjyt0bNa13db6DUNo69HiQBuCOyTsNOnfvejF/gG4UusL1e
        MTqfAMpJR/4wFALwZThS4ENnMpO/n3z2kdWQK+bKl8gS4LC7oC9HxcQdgsqhWRGkzLcBoyRBInz8K
        7lDHwnOg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1AOR-0006H0-0d; Thu, 30 Jul 2020 15:22:51 +0000
Date:   Thu, 30 Jul 2020 16:22:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Anthony Yznaga <anthony.yznaga@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        gerg@linux-m68k.org, ktkhai@virtuozzo.com,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me,
        areber@redhat.com, cyphar@cyphar.com, steven.sistare@oracle.com
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Message-ID: <20200730152250.GG23808@casper.infradead.org>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 27, 2020 at 10:11:22AM -0700, Anthony Yznaga wrote:
> This patchset adds support for preserving an anonymous memory range across
> exec(3) using a new madvise MADV_DOEXEC argument.  The primary benefit for
> sharing memory in this manner, as opposed to re-attaching to a named shared
> memory segment, is to ensure it is mapped at the same virtual address in
> the new process as it was in the old one.  An intended use for this is to
> preserve guest memory for guests using vfio while qemu exec's an updated
> version of itself.  By ensuring the memory is preserved at a fixed address,
> vfio mappings and their associated kernel data structures can remain valid.
> In addition, for the qemu use case, qemu instances that back guest RAM with
> anonymous memory can be updated.

I just realised that something else I'm working on might be a suitable
alternative to this.  Apologies for not realising it sooner.

http://www.wil.cx/~willy/linux/sileby.html

To use this, you'd mshare() the anonymous memory range, essentially
detaching the VMA from the current process's mm_struct and reparenting
it to this new mm_struct, which has an fd referencing it.

Then you call exec(), and the exec'ed task gets to call mmap() on that
new fd to attach the memory range to its own address space.

Presto!
