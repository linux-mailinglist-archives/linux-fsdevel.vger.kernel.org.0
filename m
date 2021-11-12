Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7866644E229
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 08:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbhKLHEb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 02:04:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230510AbhKLHEb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 02:04:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636700500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dQ1FGdEwDDeCS8H5TmjJM5o4K99EC4X3ezpUweTmRC4=;
        b=d6v7dtfmncoGxQyjAjg1h7c5wu+fTz4li/TvAHW+UsHL/mAPjUYEH3P3EMVzuK0AQMqgqH
        /6kg6dV8JltlaP+OQI/h6xtrVeYyvbBqvqt9/4GGX27WAl9hn8h3rboDad7NmF1d8rViqU
        hSXmnSD6VSFPgDgRF0tcpF/qkW0U+LE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-LpxmXNG7MbOinP_pDGbgvw-1; Fri, 12 Nov 2021 02:01:37 -0500
X-MC-Unique: LpxmXNG7MbOinP_pDGbgvw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 506BB8799F3;
        Fri, 12 Nov 2021 07:01:35 +0000 (UTC)
Received: from localhost (ovpn-12-197.pek2.redhat.com [10.72.12.197])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B33618A8F;
        Fri, 12 Nov 2021 07:01:15 +0000 (UTC)
Date:   Fri, 12 Nov 2021 15:01:13 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] proc/vmcore: fix clearing user buffer by properly
 using clear_user()
Message-ID: <20211112070113.GA19016@MiWiFi-R3L-srv>
References: <20211111191800.21281-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111191800.21281-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/11/21 at 08:18pm, David Hildenbrand wrote:
> To clear a user buffer we cannot simply use memset, we have to use
> clear_user(). Using a kernel config based on rawhide Fedora and a
> virtio-mem device that registers a vmcore_cb, I can easily trigger:
> 
> [   11.327580] systemd[1]: Starting Kdump Vmcore Save Service...
> [   11.339697] kdump[420]: Kdump is using the default log level(3).
> [   11.370964] kdump[453]: saving to /sysroot/var/crash/127.0.0.1-2021-11-11-14:59:22/
> [   11.373997] kdump[458]: saving vmcore-dmesg.txt to /sysroot/var/crash/127.0.0.1-2021-11-11-14:59:22/
> [   11.385357] kdump[465]: saving vmcore-dmesg.txt complete
> [   11.386722] kdump[467]: saving vmcore
> [   16.531275] BUG: unable to handle page fault for address: 00007f2374e01000
> [   16.531705] #PF: supervisor write access in kernel mode
> [   16.532037] #PF: error_code(0x0003) - permissions violation
> [   16.532396] PGD 7a523067 P4D 7a523067 PUD 7a528067 PMD 7a525067 PTE 800000007048f867
> [   16.532872] Oops: 0003 [#1] PREEMPT SMP NOPTI
> [   16.533154] CPU: 0 PID: 468 Comm: cp Not tainted 5.15.0+ #6
> [   16.533513] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-27-g64f37cc530f1-prebuilt.qemu.org 04/01/2014
> [   16.534198] RIP: 0010:read_from_oldmem.part.0.cold+0x1d/0x86
> [   16.534552] Code: ff ff ff e8 05 ff fe ff e9 b9 e9 7f ff 48 89 de 48 c7 c7 38 3b 60 82 e8 f1 fe fe ff 83 fd 08 72 3c 49 8d 7d 08 4c 89 e9 89 e8 <49> c7 45 00 00 00 00 00 49 c7 44 05 f8 00 00 00 00 48 83 e7 f81
> [   16.535670] RSP: 0018:ffffc9000073be08 EFLAGS: 00010212
> [   16.535998] RAX: 0000000000001000 RBX: 00000000002fd000 RCX: 00007f2374e01000
> [   16.536441] RDX: 0000000000000001 RSI: 00000000ffffdfff RDI: 00007f2374e01008
> [   16.536878] RBP: 0000000000001000 R08: 0000000000000000 R09: ffffc9000073bc50
> [   16.537315] R10: ffffc9000073bc48 R11: ffffffff829461a8 R12: 000000000000f000
> [   16.537755] R13: 00007f2374e01000 R14: 0000000000000000 R15: ffff88807bd421e8
> [   16.538200] FS:  00007f2374e12140(0000) GS:ffff88807f000000(0000) knlGS:0000000000000000
> [   16.538696] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   16.539055] CR2: 00007f2374e01000 CR3: 000000007a4aa000 CR4: 0000000000350eb0
> [   16.539510] Call Trace:
> [   16.539679]  <TASK>
> [   16.539828]  read_vmcore+0x236/0x2c0
> [   16.540063]  ? enqueue_hrtimer+0x2f/0x80
> [   16.540323]  ? inode_security+0x22/0x60
> [   16.540572]  proc_reg_read+0x55/0xa0
> [   16.540807]  vfs_read+0x95/0x190
> [   16.541022]  ksys_read+0x4f/0xc0
> [   16.541238]  do_syscall_64+0x3b/0x90
> [   16.541475]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> To fix, properly use clear_user() when required.

Looks a great fix to me, thanks for fixing this. 

Check the code, clear_user invokes access_ok to do check, then call
memset(). It's unclear to me how the bug is triggered, could you
please tell more so that I can learn? 


> 
> Fixes: 997c136f518c ("fs/proc/vmcore.c: add hook to read_from_oldmem() to check for non-ram pages")
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Philipp Rudo <prudo@redhat.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  fs/proc/vmcore.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 30a3b66f475a..509f85148fee 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -154,9 +154,13 @@ ssize_t read_from_oldmem(char *buf, size_t count,
>  			nr_bytes = count;
>  
>  		/* If pfn is not ram, return zeros for sparse dump files */
> -		if (!pfn_is_ram(pfn))
> -			memset(buf, 0, nr_bytes);
> -		else {
> +		if (!pfn_is_ram(pfn)) {
> +			tmp = 0;
> +			if (!userbuf)
> +				memset(buf, 0, nr_bytes);
> +			else if (clear_user(buf, nr_bytes))
> +				tmp = -EFAULT;
> +		} else {
>  			if (encrypted)
>  				tmp = copy_oldmem_page_encrypted(pfn, buf,
>  								 nr_bytes,
> @@ -165,12 +169,12 @@ ssize_t read_from_oldmem(char *buf, size_t count,
>  			else
>  				tmp = copy_oldmem_page(pfn, buf, nr_bytes,
>  						       offset, userbuf);
> -
> -			if (tmp < 0) {
> -				up_read(&vmcore_cb_rwsem);
> -				return tmp;
> -			}
>  		}
> +		if (tmp < 0) {
> +			up_read(&vmcore_cb_rwsem);
> +			return tmp;
> +		}
> +
>  		*ppos += nr_bytes;
>  		count -= nr_bytes;
>  		buf += nr_bytes;
> 
> base-commit: debe436e77c72fcee804fb867f275e6d31aa999c
> -- 
> 2.31.1
> 

