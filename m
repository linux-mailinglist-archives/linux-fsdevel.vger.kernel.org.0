Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5767047BB76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 09:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbhLUIGq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 03:06:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50771 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234697AbhLUIGp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640074005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9bw88l3NHmiaTt/a1Fx/Og6tPlXiHJAJaUCru5jyB0I=;
        b=gWC1kBqcxy8tey4bmN4xkpVXXuCSdN3ZxXcEzdri9qZ1AG2gfk61RKVlcdoaAkfG5Jr/C/
        AQ01UG8ZGeg9dIrVB2w4VD/zmLbn6pkAXjpo9zkpagP3+Y478A6fu8ghXt0dGtg9rtkNtN
        M/0bOgHmOi6RQz/w3fDmY3/gr3L9jNo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-32-cR91BW0sP-6B7qCjNn-KXA-1; Tue, 21 Dec 2021 03:06:42 -0500
X-MC-Unique: cR91BW0sP-6B7qCjNn-KXA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AA8B34891;
        Tue, 21 Dec 2021 08:06:40 +0000 (UTC)
Received: from localhost (ovpn-12-118.pek2.redhat.com [10.72.12.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 819D17EA4E;
        Tue, 21 Dec 2021 08:06:29 +0000 (UTC)
Date:   Tue, 21 Dec 2021 16:06:26 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
        kexec@lists.infradead.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Convert vmcore to use an iov_iter
Message-ID: <20211221080626.GB7986@MiWiFi-R3L-srv>
References: <20211213143927.3069508-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213143927.3069508-1-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/13/21 at 02:39pm, Matthew Wilcox (Oracle) wrote:
> For some reason several people have been sending bad patches to fix
> compiler warnings in vmcore recently.  Here's how it should be done.
> Compile-tested only on x86.  As noted in the first patch, s390 should
> take this conversion a bit further, but I'm not inclined to do that
> work myself.

Ack this series of patches.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> v3:
>  - Send the correct patches this time
> v2:
>  - Removed unnecessary kernel-doc
>  - Included uio.h to fix compilation problems
>  - Made read_from_oldmem_iter static to avoid compile warnings during the
>    conversion
>  - Use iov_iter_truncate() (Christoph)
> 
> Matthew Wilcox (Oracle) (3):
>   vmcore: Convert copy_oldmem_page() to take an iov_iter
>   vmcore: Convert __read_vmcore to use an iov_iter
>   vmcore: Convert read_from_oldmem() to take an iov_iter
> 
>  arch/arm/kernel/crash_dump.c     |  27 +------
>  arch/arm64/kernel/crash_dump.c   |  29 +------
>  arch/ia64/kernel/crash_dump.c    |  32 +-------
>  arch/mips/kernel/crash_dump.c    |  27 +------
>  arch/powerpc/kernel/crash_dump.c |  35 ++-------
>  arch/riscv/kernel/crash_dump.c   |  26 +------
>  arch/s390/kernel/crash_dump.c    |  13 ++--
>  arch/sh/kernel/crash_dump.c      |  29 ++-----
>  arch/x86/kernel/crash_dump_32.c  |  29 +------
>  arch/x86/kernel/crash_dump_64.c  |  48 ++++--------
>  fs/proc/vmcore.c                 | 129 +++++++++++++------------------
>  include/linux/crash_dump.h       |  19 ++---
>  12 files changed, 122 insertions(+), 321 deletions(-)
> 
> -- 
> 2.33.0
> 

