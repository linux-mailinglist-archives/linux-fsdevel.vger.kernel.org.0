Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EB07B745F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 00:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjJCW6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 18:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjJCW6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 18:58:11 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9BE9E
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 15:58:08 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c364fb8a4cso12736525ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Oct 2023 15:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696373888; x=1696978688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3JvWESe0lSEDvpuZ7eC9fLLBPWTe4VjlZm52MFoyxHw=;
        b=uc/30WLuoTzLRt+N+hRci8q1THTJvjEXRo+Ur5axfhIYo2BwvtOioJoG61bO5SvbRk
         k1ZpNquNjDQiFikPRkgryIH5Hct6NyTGDsyrl8TWyA55VW7ZxgXhUFdJHFUTCzQGUzFm
         8CTZbgf4zgU8HP4veCryYRjrd9oAgydDP7wmCgc/Zbak5OE63Cc2NWosMIBzhdLNOnlj
         zopT40naxOIFdZwZVourL7DRw5rGMUhP+4+8o8ZPlQziRgFrKbUQKtvcynhrPSc4MqN9
         vwSD8LbcwMYY5PNz3RKdr+gD7+9976QLs5k5aNi7yr8fOnKcgyY4RKgOSny37Omz6snU
         Nvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696373888; x=1696978688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JvWESe0lSEDvpuZ7eC9fLLBPWTe4VjlZm52MFoyxHw=;
        b=n9ny+jqnsQK2LwHsCfI7UZXcsrVGh5rzNnzAhxs962fmYC2VNY9ecegtdPmTEe0kTa
         EDbXP+8c4aVs9nUnbqOEYUgOPpL8a+rlwTOmbA2bk3MRzw99jXzOv19JW0DaWSLlVqXR
         NL6fEpOj0Z97MHvvs2iExZwejstzcdMWYspq9D4h8l/FDDwhNyXQGk80RBf7aiEMBQUe
         6p1WmTShmIECr54idFsvZSTuuTbqb3svhuZutE8WalXbS6f2X+TLZdkPwoPxbG5sRwZY
         VBGQT+jsRHhPIrAl4HGE2DVY0IdP2E630aUJilyMRq53KqwUDpFyusKW4TWx+tNYkvTT
         V4og==
X-Gm-Message-State: AOJu0YweCUFk4nGIZ3w1Vs5OplYniu9K8PXcbud6diARL9mDAuOgnBtu
        WYhScbQ/0FNd81EppzPMeN50JA==
X-Google-Smtp-Source: AGHT+IFW2cwsAODKjPVPHFFeQctUGwjCr1o5jxYyiloHlNhRxWVUe+1LJ99Yu+Woy7PE0LA8njLcqg==
X-Received: by 2002:a17:902:ea09:b0:1c5:d747:a124 with SMTP id s9-20020a170902ea0900b001c5d747a124mr1157219plg.9.1696373887906;
        Tue, 03 Oct 2023 15:58:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id jb17-20020a170903259100b001bbdd44bbb6sm2147647plb.136.2023.10.03.15.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 15:58:07 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qnoL6-0095u7-2A;
        Wed, 04 Oct 2023 09:58:04 +1100
Date:   Wed, 4 Oct 2023 09:58:04 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     antal.nemes@hycu.com
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>
Subject: Re: [BUG] soft lockup in filemap_get_read_batch
Message-ID: <ZRycfLxGP1CSd/ud@dread.disaster.area>
References: <95d6033195a781f81e6ad5bd46026aae@hycu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95d6033195a781f81e6ad5bd46026aae@hycu.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 03, 2023 at 03:48:14PM +0200, antal.nemes@hycu.com wrote:
> Hi Matthew,
> 
> We have observed intermittent soft lockups on at least seven different hosts:
> - six hosts ran 6.2.8.fc37-200
> - one host ran 6.0.13.fc37-200
> 
> The list of affected hosts is growing.
> 
> Stack traces are all similar:
> 
> emerg kern kernel - - watchdog: BUG: soft lockup - CPU#7 stuck for 17117s! [postmaster:2238460]
> warning kern kernel - - Modules linked in: target_core_user uio target_core_pscsi target_core_file target_core_iblock nbd loop nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver fscache netfs veth iscsi_tcp libiscsi_tcp libiscsi iscsi_target_mod target_core_mod scsi_transport_iscsi nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink sunrpc dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua bochs drm_vram_helper drm_ttm_helper ttm crct10dif_pclmul i2c_piix4 crc32_pclmul polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 virtio_balloon joydev pcspkr xfs crc32c_intel virtio_net serio_raw ata_generic net_failover failover virtio_scsi pata_acpi qemu_fw_cfg fuse [last unloaded: nbd]
> warning kern kernel - - CPU: 7 PID: 2238460 Comm: postmaster Kdump: loaded Tainted: G             L     6.2.8-200.fc37.x86_64 #1
> warning kern kernel - - Hardware name: Nutanix AHV, BIOS 1.11.0-2.el7 04/01/2014
> warning kern kernel - - RIP: 0010:xas_descend+0x28/0x70
> warning kern kernel - - Code: 90 90 0f b6 0e 48 8b 57 08 48 d3 ea 83 e2 3f 89 d0 48 83 c0 04 48 8b 44 c6 08 48 89 77 18 48 89 c1 83 e1 03 48 83 f9 02 75 08 <48> 3d fd 00 00 00 76 08 88 57 12 c3 cc cc cc cc 48 c1 e8 02 89 c2
> warning kern kernel - - RSP: 0018:ffffab66c9f4bb98 EFLAGS: 00000246
> warning kern kernel - - RAX: 00000000000000c2 RBX: ffffab66c9f4bbb8 RCX: 0000000000000002
> warning kern kernel - - RDX: 0000000000000032 RSI: ffff89cd6c8cd6d0 RDI: ffffab66c9f4bbb8
> warning kern kernel - - RBP: ffff89cd6c8cd6d0 R08: ffffab66c9f4be20 R09: 0000000000000000
> warning kern kernel - - R10: 0000000000000001 R11: 0000000000000100 R12: 00000000000000b3
> warning kern kernel - - R13: 00000000000000b2 R14: 00000000000000b2 R15: ffffab66c9f4be48
> warning kern kernel - - FS:  00007ff1e8bfb540(0000) GS:ffff89d35fbc0000(0000) knlGS:0000000000000000
> warning kern kernel - - CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> warning kern kernel - - CR2: 00007ff1e8af0768 CR3: 000000016fdde001 CR4: 00000000003706e0
> warning kern kernel - - Call Trace:
> warning kern kernel - -  <TASK>
> warning kern kernel - -  xas_load+0x3d/0x50
> warning kern kernel - -  filemap_get_read_batch+0x179/0x270
> warning kern kernel - -  filemap_get_pages+0xa9/0x690
> warning kern kernel - -  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> warning kern kernel - -  filemap_read+0xd2/0x340
> warning kern kernel - -  ? filemap_read+0x32f/0x340
> warning kern kernel - -  xfs_file_buffered_read+0x4f/0xd0 [xfs]
> warning kern kernel - -  xfs_file_read_iter+0x70/0xe0 [xfs]
> warning kern kernel - -  vfs_read+0x23c/0x310
> warning kern kernel - -  ksys_read+0x6b/0xf0
> warning kern kernel - -  do_syscall_64+0x5b/0x80
> warning kern kernel - -  ? syscall_exit_to_user_mode+0x17/0x40
> warning kern kernel - -  ? do_syscall_64+0x67/0x80
> warning kern kernel - -  ? do_syscall_64+0x67/0x80
> warning kern kernel - -  ? __irq_exit_rcu+0x3d/0x140
> warning kern kernel - -  entry_SYSCALL_64_after_hwframe+0x72/0xdc

Fixed by commit cbc02854331e ("XArray: Do not return sibling entries
from xa_load()").

Should already be backported to the lastest stable kernels.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
