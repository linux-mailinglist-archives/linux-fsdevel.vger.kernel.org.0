Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180787B4F05
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 11:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbjJBJ0z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 05:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbjJBJ0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:26:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC51591
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 02:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696238760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0PdD95eQa7pRzI20cGWxgLJ0k+Wv+3imJtntajjlHo=;
        b=d5tIfhxNnfS6wqIYMXLScwou2fWLV/nfbEkkHEKRcnpn/peh0NEdB4w3VeME0847l+E1T9
        Cvm5/BTQB/+inLgKgVmPvTzDmluVQ30DVkfrWrFk/GxTbLzOU1V5hlVKjgOeb1m9xi6aWN
        uamEl8gFdwiAKgdgRKR0lcqKWRguwWc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-PQBTnD6gOOy2ZO4-BcF33g-1; Mon, 02 Oct 2023 05:25:55 -0400
X-MC-Unique: PQBTnD6gOOy2ZO4-BcF33g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2035D811E7D;
        Mon,  2 Oct 2023 09:25:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 638B951E3;
        Mon,  2 Oct 2023 09:25:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230925120309.1731676-9-dhowells@redhat.com>
References: <20230925120309.1731676-9-dhowells@redhat.com> <20230925120309.1731676-1-dhowells@redhat.com>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/12] iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1809397.1696238751.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 02 Oct 2023 10:25:51 +0100
Message-ID: <1809398.1696238751@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> +static size_t __copy_from_iter_mc(void *addr, size_t bytes, struct iov_=
iter *i)
>  {
> -	struct iov_iter *iter =3D priv2;
> +	size_t progress;
>  =

> -	if (iov_iter_is_copy_mc(iter))
> -		return copy_mc_to_kernel(to + progress, iter_from, len);
> -	return memcpy_from_iter(iter_from, progress, len, to, priv2);
> +	if (unlikely(i->count < bytes))
> +		bytes =3D i->count;
> +	if (unlikely(!bytes))
> +		return 0;
> +	progress =3D iterate_bvec(i, bytes, addr, NULL, memcpy_from_iter_mc);
> +	i->count -=3D progress;

i->count shouldn't be decreased here as iterate_bvec() now does that.

This causes the LTP abort01 test to log a warning under KASAN (see below).
I'll remove the line and repush the patches.

David

    LTP: starting abort01
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    BUG: KASAN: stack-out-of-bounds in __copy_from_iter_mc+0x2e6/0x480
    Read of size 4 at addr ffffc90004777594 by task abort01/708

    CPU: 4 PID: 708 Comm: abort01 Not tainted 99.6.0-rc3-ged6251886a1d #46
    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)/Incus, BIOS unknown=
 2/2/2022
    Call Trace:
     <TASK>
     dump_stack_lvl+0x3d/0x70
     print_report+0xce/0x650
     ? lock_acquire+0x1b1/0x330
     kasan_report+0xda/0x110
     ? __copy_from_iter_mc+0x2e6/0x480
     ? __copy_from_iter_mc+0x2e6/0x480
     __copy_from_iter_mc+0x2e6/0x480
     copy_page_from_iter_atomic+0x517/0x1350
     ? __pfx_copy_page_from_iter_atomic+0x10/0x10
     ? __filemap_get_folio+0x281/0x6c0
     ? folio_wait_writeback+0x53/0x1e0
     ? prepare_pages.constprop.0+0x40b/0x6c0
     btrfs_copy_from_user+0xc6/0x290
     btrfs_buffered_write+0x8c9/0x1190
     ? __pfx_btrfs_buffered_write+0x10/0x10
     ? _raw_spin_unlock+0x2d/0x50
     ? btrfs_file_llseek+0x100/0xf00
     ? follow_page_mask+0x69f/0x1e10
     btrfs_do_write_iter+0x859/0xff0
     ? __pfx_btrfs_file_llseek+0x10/0x10
     ? find_held_lock+0x2d/0x110
     ? __pfx_btrfs_do_write_iter+0x10/0x10
     ? __up_read+0x211/0x790
     ? __pfx___get_user_pages+0x10/0x10
     ? __pfx___up_read+0x10/0x10
     ? __kernel_write_iter+0x3be/0x6d0
     __kernel_write_iter+0x226/0x6d0
     ? __pfx___kernel_write_iter+0x10/0x10
     dump_user_range+0x25d/0x650
     ? __pfx_dump_user_range+0x10/0x10
     ? __pfx_writenote+0x10/0x10
     elf_core_dump+0x231f/0x2e90
     ? __pfx_elf_core_dump+0x10/0x10
     ? do_coredump+0x12a9/0x38c0
     ? kasan_set_track+0x25/0x30
     ? __kasan_kmalloc+0xaa/0xb0
     ? __kmalloc_node+0x6c/0x1b0
     ? do_coredump+0x12a9/0x38c0
     ? get_signal+0x1e7d/0x20f0
     ? 0xffffffffff600000
     ? mas_next_slot+0x328/0x1dd0
     ? lock_acquire+0x162/0x330
     ? do_coredump+0x2537/0x38c0
     do_coredump+0x2537/0x38c0
     ? __pfx_do_coredump+0x10/0x10
     ? kmem_cache_free+0x114/0x520
     ? find_held_lock+0x2d/0x110
     get_signal+0x1e7d/0x20f0
     ? __pfx_get_signal+0x10/0x10
     ? do_send_specific+0xf1/0x1c0
     ? __pfx_do_send_specific+0x10/0x10
     arch_do_signal_or_restart+0x8b/0x4b0
     ? __pfx_arch_do_signal_or_restart+0x10/0x10
     exit_to_user_mode_prepare+0xde/0x210
     syscall_exit_to_user_mode+0x16/0x50
     do_syscall_64+0x53/0x90
     entry_SYSCALL_64_after_hwframe+0x6e/0xd8

