Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1798D72B24B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 16:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbjFKOZ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 10:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbjFKOZ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:25:57 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9C2E64;
        Sun, 11 Jun 2023 07:25:51 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b3c578c602so1984385ad.2;
        Sun, 11 Jun 2023 07:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686493551; x=1689085551;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FEUC84ROoHVABqnr4dI/cj4KX+6iNK6lndFHJ/mwlXo=;
        b=edryt8mdvhQJj71/1dM05AfMgnAgWAUD1/uXzpwqZvcDwagyKMp2oFH70dnGBmc9rb
         5UHSx2/81AqGWagmjfnarfkHF7AvypdF8EqNILonbt3Ao3AtbP1Fg60fPZOSTBIm1SzY
         0MdHXJPnxwAJg9LecaqhCMd7jNOl+pkVda7QbCnZtEKkvKfTB+JvZZslwh1Vcjj4X3Pf
         Zmc5PLrjxq3hXt7cSQccP0qakTiD7eKrD7WbZQ9PPxNqrIQa6pIannjbEnI322jO0fou
         6qVGSAbKxbNOygr1F4T7wF1T75tpUTQIxqq/kkI9UXG24xQIPeXyplnhmEhtIpns5j1o
         dAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686493551; x=1689085551;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FEUC84ROoHVABqnr4dI/cj4KX+6iNK6lndFHJ/mwlXo=;
        b=AVyQKVscwMrNyVzXybMXWZVjjbWaJfzOoGfrOlVQsXT0ZimcY5UzLUyO2pIMDiPgfq
         YCYWWbjZS1kW38b8pY+e62XkdRlxuebc41MegSe4p6Iz3YsydosSw7e273S9nI/mP/XB
         bQVTF9tk2akTRC3W53mjYbQDSHjgJKkdZi8yT8nKZ6w5eub95830XlLHG6LzyR7FS419
         09NtaEeAzo2UIAfyF1tlmu0s5RaV60YsV1InY0F+o+jfwcQHXLLVltpbA+hXQbEAD7FT
         NAT8W1mcvyhXvOWsUH2c1poghyztGoxERDBRnMGgH/0WgPQ+afMjIJywFSkrLgKqUAhC
         L+eA==
X-Gm-Message-State: AC+VfDywPAHU8llhQHfJZUoJrQoAo6VARKeAPgEJ+TakARp6CUxKMLHw
        RN3fkJLxKTf4OIKTei/XQIQ=
X-Google-Smtp-Source: ACHHUZ6pzdYGNePrJpVUMSrvm6ii2LgA6QRoGnuOAP7gKCT4uEvBLaB1awpOa5yqI3WTwMbbfbVpOw==
X-Received: by 2002:a17:903:11c9:b0:1b1:8e8b:7f6c with SMTP id q9-20020a17090311c900b001b18e8b7f6cmr4626208plh.16.1686493550787;
        Sun, 11 Jun 2023 07:25:50 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902da8300b001b045c9ababsm6441256plx.264.2023.06.11.07.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:25:50 -0700 (PDT)
Date:   Sun, 11 Jun 2023 19:55:46 +0530
Message-Id: <87a5x6hy8l.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv2 2/5] ext4: Remove PAGE_SIZE assumption of folio from mpage_submit_folio
In-Reply-To: <20230611055831.GF1436857@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Please ignore the previous email.

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Mon, May 15, 2023 at 04:10:41PM +0530, Ritesh Harjani (IBM) wrote:
>> mpage_submit_folio() was converted to take folio. Even though
>> folio_size() in ext4 as of now is PAGE_SIZE, but it's better to
>> remove that assumption which I am assuming is a missed left over from
>> patch[1].
>>
>> [1]: https://lore.kernel.org/linux-ext4/20230324180129.1220691-7-willy@infradead.org/
>>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
> I didn't notice this right away, because the failure is not 100%
> reliable, but this commit will sometimes cause "kvm-xfstests -c
> ext4/encrypt generic/068" to crash.  Reverting the patch fixes the
> problem, so I plan to drop this patch from my tree.
>

Sorry about the crash. I am now able to reproduce the problem on my
setup as well. I will debug this and will update once I have some more info.

From the initial look, it looks like the problem might be occurring when
folio_pos(folio) itself is > i_size_read(inode).

If that is indeed the case, then I think even doing this with folio
conversion (below code after folio conversion) looks incorrect for case
when size is not PAGE_SIZE aligned.

However, I will spend some more time debugging this.

static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
{
	size_t len;
	loff_t size;
	int err;

	BUG_ON(folio->index != mpd->first_page);
	folio_clear_dirty_for_io(folio);
	/*
	 * We have to be very careful here!  Nothing protects writeback path
	 * against i_size changes and the page can be writeably mapped into
	 * page tables. So an application can be growing i_size and writing
	 * data through mmap while writeback runs. folio_clear_dirty_for_io()
	 * write-protects our page in page tables and the page cannot get
	 * written to again until we release folio lock. So only after
	 * folio_clear_dirty_for_io() we are safe to sample i_size for
	 * ext4_bio_write_page() to zero-out tail of the written page. We rely
	 * on the barrier provided by TestClearPageDirty in
	 * folio_clear_dirty_for_io() to make sure i_size is really sampled only
	 * after page tables are updated.
	 */
	size = i_size_read(mpd->inode);
	len = folio_size(folio);
	if (folio_pos(folio) + len > size &&
	    !ext4_verity_in_progress(mpd->inode))
		len = size & ~PAGE_MASK;
	err = ext4_bio_write_page(&mpd->io_submit, &folio->page, len);
	if (!err)
		mpd->wbc->nr_to_write--;

	return err;
}

>       	    		      	      	   	- Ted
>
> generic/068 42s ...  [01:56:09][    7.014363] run fstests generic/068 at 2023-06-11 01:56:09
> [    7.538841] EXT4-fs (vdc): Test dummy encryption mode enabled
> [   11.407307] traps: PANIC: double fault, error_code: 0x0
> [   11.407313] double fault: 0000 [#1] PREEMPT SMP NOPTI
> [   11.407315] CPU: 1 PID: 3358 Comm: fsstress Not tainted 6.4.0-rc5-xfstests-lockdep-00069-gfc362247e79f #169
> [   11.407316] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   11.407317] RIP: 0010:__switch_to_asm+0x33/0x80
> [   11.407322] Code: 55 41 56 41 57 48 89 a7 d8 17 00 00 48 8b a6 d8 17 00 00 48 8b 9e 40 04 00 00 65 48 89 1c 25 28 00 00 00 49 c7 c4 10 00 00 00 <e8> 01 00 00 00 cc e8 01 00 00 00 cc 48 83 c4 10 49 ff cc 75 eb 0f
> [   11.407323] RSP: 0018:ffffc90003ec7e18 EFLAGS: 00010046
> [   11.407324] RAX: 0000000000000001 RBX: 961d22f2e2e05800 RCX: 00000002afbf75a9
> [   11.407325] RDX: 0000000000000003 RSI: ffff88800d174080 RDI: ffff88800d0ae200
> [   11.407325] RBP: ffffc90003fd7af0 R08: 0000000000000001 R09: 0000000000000001
> [   11.407326] R10: 00000000000003cc R11: 0000000000000001 R12: 0000000000000010
> [   11.407326] R13: ffffe8ffffc29c50 R14: ffff88807ddee998 R15: ffff88800d174080
> [   11.407327] FS:  00007f144aee4740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> [   11.407329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   11.407330] CR2: ffffc90003ec7e08 CR3: 000000000cb3e004 CR4: 0000000000770ee0
> [   11.407330] PKRU: 55555554
> [   11.407330] Call Trace:
> [   11.407331]  <#DF>
> [   11.407332]  ? die+0x36/0x80
> [   11.407334]  ? exc_double_fault+0xf1/0x1b0
> [   11.407336]  ? asm_exc_double_fault+0x23/0x30
> [   11.407338]  ? __switch_to_asm+0x33/0x80
> [   11.407339]  </#DF>
> [   11.413852] ---[ end trace 0000000000000000 ]---
> [   11.413853] RIP: 0010:__switch_to_asm+0x33/0x80
> [   11.413856] Code: 55 41 56 41 57 48 89 a7 d8 17 00 00 48 8b a6 d8 17 00 00 48 8b 9e 40 04 00 00 65 48 89 1c 25 28 00 00 00 49 c7 c4 10 00 00 00 <e8> 01 00 00 00 cc e8 01 00 00 00 cc 48 83 c4 10 49 ff cc 75 eb 0f
> [   11.413857] RSP: 0018:ffffc90003ec7e18 EFLAGS: 00010046
> [   11.413857] RAX: 0000000000000001 RBX: 961d22f2e2e05800 RCX: 00000002afbf75a9
> [   11.413858] RDX: 0000000000000003 RSI: ffff88800d174080 RDI: ffff88800d0ae200
> [   11.413858] RBP: ffffc90003fd7af0 R08: 0000000000000001 R09: 0000000000000001
> [   11.413859] R10: 00000000000003cc R11: 0000000000000001 R12: 0000000000000010
> [   11.413859] R13: ffffe8ffffc29c50 R14: ffff88807ddee998 R15: ffff88800d174080
> [   11.413860] FS:  00007f144aee4740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> [   11.413861] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   11.413862] CR2: ffffc90003ec7e08 CR3: 000000000cb3e004 CR4: 0000000000770ee0
> [   11.413863] PKRU: 55555554
> [   11.413863] Kernel panic - not syncing: Fatal exception in interrupt
> [   11.413889] BUG: unable to handle page fault for address: ffffc90003ebfe88
> [   11.414112] #PF: supervisor read access in kernel mode
> [   11.414320] #PF: error_code(0x0009) - reserved bit violation
> [   11.415151] PGD 5000067 P4D 5000067 PUD 5219067 PMD d278067 PTE 1e914974aa550b07
> [   11.417015] Oops: 0009 [#2] PREEMPT SMP NOPTI
> [   11.417375] CPU: 0 PID: 29 Comm: kworker/u4:2 Tainted: G      D            6.4.0-rc5-xfstests-lockdep-00069-gfc362247e79f #169
> [   11.417641] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   11.417962] Workqueue: writeback wb_workfn (flush-254:32)
> [   11.418683] RIP: 0010:timerqueue_add+0x28/0xb0
> [   11.418916] Code: 90 90 66 0f 1f 00 55 53 48 3b 36 48 89 f3 0f 85 96 00 00 00 48 8b 07 48 85 c0 74 55 48 8b 73 18 bd 01 00 00 00 eb 03 48 89 d0 <48> 3b 70 18 48 8d 48 10 7c 06 48 8d 48 08 31 ed 48 8b 11 48 85 d2
> [   11.419173] RSP: 0018:ffffc90000003f00 EFLAGS: 00010082
> [   11.419710] RAX: ffffc90003ebfe70 RBX: ffff88807dbe0210 RCX: ffff88800d07a3e8
> [   11.420219] RDX: ffffc90003ebfe70 RSI: 00000002a849a0e0 RDI: ffff88807dbdfb58
> [   11.420634] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
> [   11.420877] R10: 0000000000000000 R11: 0000000000000659 R12: ffff88807dbdfa40
> [   11.421082] R13: 0000000000000002 R14: ffff888005d3c180 R15: ffff88807dbdfb00
> [   11.421924] FS:  0000000000000000(0000) GS:ffff88807da00000(0000) knlGS:0000000000000000
> [   11.422165] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   11.422487] CR2: ffffc90003ebfe88 CR3: 000000000c81c001 CR4: 0000000000770ef0
> [   11.422810] PKRU: 55555554
> [   11.423133] Call Trace:
> [   11.423451]  <IRQ>
> [   11.423778]  ? __die+0x23/0x60
> [   11.424139]  ? page_fault_oops+0xa4/0x170
> [   11.424399]  ? exc_page_fault+0xfa/0x1e0
> [   11.424741]  ? asm_exc_page_fault+0x26/0x30
> [   11.424884]  ? timerqueue_add+0x28/0xb0
> [   11.425001]  enqueue_hrtimer+0x42/0xa0
> [   11.425097]  __hrtimer_run_queues+0x304/0x380
> [   11.425241]  hrtimer_interrupt+0xf8/0x230
> [   11.425426]  __sysvec_apic_timer_interrupt+0x75/0x190
> [   11.425605]  sysvec_apic_timer_interrupt+0x65/0x80
> [   11.425794]  </IRQ>
> [   11.425966]  <TASK>
> [   11.426139]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [   11.426344] RIP: 0010:aesni_xts_encrypt+0x2d/0x1d0
> [   11.426529] Code: 00 66 0f 6f 3d 24 ff 93 01 41 0f 10 18 44 8b 8f e0 01 00 00 48 83 e9 40 0f 8c f3 00 00 00 66 0f 6f c3 f3 0f 6f 0a 66 0f ef c1 <f3> 0f 7f 1e 66 0f 70 d3 13 66 0f d4 db 66 0f 72 e2 1f 66 0f db d7
> [   11.426757] RSP: 0018:ffffc9000052f558 EFLAGS: 00010206
> [   11.427074] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000fc0
> [   11.427172] RDX: ffff88801281a000 RSI: ffff88800d7c3000 RDI: ffff88800d180220
> [   11.427406] RBP: ffffc9000052f720 R08: ffffc9000052f780 R09: 0000000000000020
> [   11.427624] R10: ffff88800d1800a0 R11: 0000000000000018 R12: ffffc9000052f580
> [   11.428468] R13: ffff88800d180220 R14: 0000000000001000 R15: 0000000000000001
> [   11.428705]  ? aesni_enc+0x13/0x20
> [   11.429027]  xts_crypt+0x10f/0x340
> [   11.429349]  ? lock_release+0x65/0x100
> [   11.429667]  ? do_raw_spin_unlock+0x4e/0xa0
> [   11.429987]  ? _raw_spin_unlock+0x23/0x40
> [   11.430312]  ? lock_is_held_type+0x9d/0x110
> [   11.430471]  fscrypt_crypt_block+0x268/0x320
> [   11.430627]  ? mempool_alloc+0x94/0x1e0
> [   11.430803]  fscrypt_encrypt_pagecache_blocks+0xde/0x150
> [   11.430991]  ext4_bio_write_folio+0x371/0x500
> [   11.431172]  mpage_submit_folio+0x6f/0x90
> [   11.431363]  mpage_map_and_submit_buffers+0xc5/0x180
> [   11.431558]  mpage_map_and_submit_extent+0x55/0x300
> [   11.431739]  ext4_do_writepages+0x70d/0x810
> [   11.431981]  ext4_writepages+0xf1/0x290
> [   11.432182]  do_writepages+0xd2/0x1e0
> [   11.432366]  ? __lock_release.isra.0+0x15e/0x2a0
> [   11.432595]  __writeback_single_inode+0x54/0x300
> [   11.432817]  ? do_raw_spin_unlock+0x4e/0xa0
> [   11.433006]  writeback_sb_inodes+0x1fc/0x500
> [   11.433183]  wb_writeback+0xf2/0x370
> [   11.433352]  wb_do_writeback+0x9e/0x2e0
> [   11.433560]  ? set_worker_desc+0xc7/0xd0
> [   11.433772]  wb_workfn+0x6a/0x2b0
> [   11.433964]  ? __lock_release.isra.0+0x15e/0x2a0
> [   11.434157]  ? process_one_work+0x21b/0x540
> [   11.434322]  process_one_work+0x286/0x540
> [   11.434500]  worker_thread+0x53/0x3c0
> [   11.434678]  ? __pfx_worker_thread+0x10/0x10
> [   11.434831]  kthread+0xf2/0x130
> [   11.435042]  ? __pfx_kthread+0x10/0x10
> [   11.435233]  ret_from_fork+0x29/0x50
> [   11.435417]  </TASK>
> [   11.435584] CR2: ffffc90003ebfe88
> [   11.435931] ---[ end trace 0000000000000000 ]---
> [   11.436101] RIP: 0010:__switch_to_asm+0x33/0x80
> [   11.436265] Code: 55 41 56 41 57 48 89 a7 d8 17 00 00 48 8b a6 d8 17 00 00 48 8b 9e 40 04 00 00 65 48 89 1c 25 28 00 00 00 49 c7 c4 10 00 00 00 <e8> 01 00 00 00 cc e8 01 00 00 00 cc 48 83 c4 10 49 ff cc 75 eb 0f
> [   11.436367] RSP: 0018:ffffc90003ec7e18 EFLAGS: 00010046
> [   11.436727] RAX: 0000000000000001 RBX: 961d22f2e2e05800 RCX: 00000002afbf75a9
> [   11.436938] RDX: 0000000000000003 RSI: ffff88800d174080 RDI: ffff88800d0ae200
> [   11.437766] RBP: ffffc90003fd7af0 R08: 0000000000000001 R09: 0000000000000001
> [   11.438000] R10: 00000000000003cc R11: 0000000000000001 R12: 0000000000000010
> [   11.438322] R13: ffffe8ffffc29c50 R14: ffff88807ddee998 R15: ffff88800d174080
> [   11.438641] FS:  0000000000000000(0000) GS:ffff88807da00000(0000) knlGS:0000000000000000
> [   11.438967] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   11.439285] CR2: ffffc90003ebfe88 CR3: 000000000c81c001 CR4: 0000000000770ef0
> [   11.439604] PKRU: 55555554
> [   12.433529] Shutting down cpus with NMI
> [   12.433728] Kernel Offset: disabled
> QEMU: Terminated

Thanks for letting me know. I will look more into this.

-ritesh
