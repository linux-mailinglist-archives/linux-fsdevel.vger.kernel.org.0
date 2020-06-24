Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC73206A87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 05:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388662AbgFXDZH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 23:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388526AbgFXDZH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 23:25:07 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC71CC061573;
        Tue, 23 Jun 2020 20:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ukvtydvO6v/huANXwXMEUQDQqt4nzrdZg8Ec18jLIfE=; b=TgT8Q6jQceWJZID30HBOuDzxJ8
        QWDsnC6gRO62PUd7otmn0RY+xm2nbLlvm0CREPLjuaB20ZdJjnPAe3lSnnwplNy8Nb2KwpNxVasiC
        rGDqzpf3sftJt/jYtTgNUjsb9EcX2r4kP7NtQ3+CedIk0ZeTtDla+HA1r3hjJXIfNf6Qe4lqJPn7v
        2Gl+O2+6fac2LmKPmCH0keVj1KusM5Yun2DMgA0vjNyHhUvc5hZ7UtBEKgmBe736wAMOeW4GqNXsm
        MD/TTwpOjLRKAYprwKNFDZjaempyiTK0sfxQ91hyav+JU3t184qArBwXpK/v7LcOVZNALIpXhF1vS
        FyYGGoYw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnw1n-0007sL-Gi; Wed, 24 Jun 2020 03:24:47 +0000
Date:   Wed, 24 Jun 2020 04:24:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Fan <fanpeng@loongson.cn>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH] fs/read_write.c: Fix memory leak in read_write.c
Message-ID: <20200624032447.GK21350@casper.infradead.org>
References: <1592968023-20383-1-git-send-email-fanpeng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592968023-20383-1-git-send-email-fanpeng@loongson.cn>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 11:07:03AM +0800, Peng Fan wrote:
> kmemleak report:
> unreferenced object 0x98000002bb591d00 (size 256):
>   comm "ftest03", pid 24778, jiffies 4301603810 (age 490.665s)
>   hex dump (first 32 bytes):
>     00 01 04 20 01 00 00 00 80 00 00 00 00 00 00 00  ... ............
>     f0 02 04 20 01 00 00 00 80 00 00 00 00 00 00 00  ... ............
>   backtrace:
>     [<0000000050b162cb>] __kmalloc+0x234/0x438
>     [<00000000491da9c7>] rw_copy_check_uvector+0x1ac/0x1f0
>     [<00000000b0dddb43>] import_iovec+0x50/0xe8
>     [<00000000ae843d73>] vfs_readv+0x50/0xb0
>     [<00000000c7216b06>] do_readv+0x80/0x160
>     [<00000000cad79c3f>] syscall_common+0x34/0x58
> 
> This is because "iov" allocated by kmalloc() is not destroyed. Under normal
> circumstances, "ret_pointer" should be equal to "iov". But if the previous 
> statements fails to execute, and the allocation is successful, then the
> block of memory will not be released, because it is necessary to 
> determine whether they are equal. So we need to change the order.

This patch doesn't make sense.  It will _introduce_ a memory leak,
not fix one.
