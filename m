Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF591BC750
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 19:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgD1R4R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 13:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgD1R4R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:56:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7447FC03C1AB;
        Tue, 28 Apr 2020 10:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=txJAmcMNWInk7Je0EhEiqvBKeJ6FacLYDzFb9yyt3XA=; b=EGX1twqz+y+1j3yIJjgGqck0XL
        Nqk9T09pADsy41RA5qkhbTQ4YrnXBS+9LZ2hLIbcfl/wc5fa0wssJnQ59GKGA0kwqVrddwBypPjYs
        /L9JL5SciVf/m7KNLDRZVi9F3W5COqKIydomDmwZ6O7JP9i48HVUGhZ4Z3X8SEB7rcxVUz59Qw8NZ
        ZFPvFqH2fZWSaWnF6siTql2yHRkR1I4VFN+Y0PVMaqwEgzDLi7P6nPvd9lixBqCM6D8ACvkl7zm2t
        OQU+SD0uPBa5+mprcuO+ZW57mKbZvPY9ZTpNvEviTHUzwvKlcYyqqvq+Z9UktSrjqgc78nkz3BVQN
        WEpZ1mHA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTUSu-0003cu-LS; Tue, 28 Apr 2020 17:56:16 +0000
Subject: Re: [RFC PATCH 5/5] kvm_main: replace debugfs with statsfs
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mst@redhat.com,
        borntraeger@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>
References: <20200427141816.16703-1-eesposit@redhat.com>
 <20200427141816.16703-6-eesposit@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2bb5bb1d-deb8-d6cd-498b-8948bae6d848@infradead.org>
Date:   Tue, 28 Apr 2020 10:56:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427141816.16703-6-eesposit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/27/20 7:18 AM, Emanuele Giuseppe Esposito wrote:
> Use statsfs API instead of debugfs to create sources and add values.
> 
> This also requires to change all architecture files to replace the old
> debugfs_entries with statsfs_vcpu_entries and statsfs_vm_entries.
> 
> The files/folders name and organization is kept unchanged, and a symlink
> in sys/kernel/debugfs/kvm is left for backward compatibility.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> ---
>  arch/arm64/kvm/guest.c          |   2 +-
>  arch/mips/kvm/mips.c            |   2 +-
>  arch/powerpc/kvm/book3s.c       |   6 +-
>  arch/powerpc/kvm/booke.c        |   8 +-
>  arch/s390/kvm/kvm-s390.c        |  16 +-
>  arch/x86/include/asm/kvm_host.h |   2 +-
>  arch/x86/kvm/Makefile           |   2 +-
>  arch/x86/kvm/debugfs.c          |  64 -------
>  arch/x86/kvm/statsfs.c          |  49 +++++
>  arch/x86/kvm/x86.c              |   6 +-
>  include/linux/kvm_host.h        |  39 +---
>  virt/kvm/arm/arm.c              |   2 +-
>  virt/kvm/kvm_main.c             | 314 ++++----------------------------
>  13 files changed, 130 insertions(+), 382 deletions(-)
>  delete mode 100644 arch/x86/kvm/debugfs.c
>  create mode 100644 arch/x86/kvm/statsfs.c


You might want to select STATS_FS here (or depend on it if it is required),
or you could provide stubs in <linux/statsfs.h> for the cases of STATS_FS
is not set/enabled.

-- 
~Randy

