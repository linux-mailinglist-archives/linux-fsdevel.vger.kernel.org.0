Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C596AAF4A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Mar 2023 12:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjCEL0m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Mar 2023 06:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCEL0k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Mar 2023 06:26:40 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40AFEF84;
        Sun,  5 Mar 2023 03:26:38 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id ky4so7280064plb.3;
        Sun, 05 Mar 2023 03:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OwKM7GHWgJRm0qnvN5L/kXJLsHyAatYIIo/ePs6DUss=;
        b=Txs0WjAPbf/jY+XtQ20KPKoQVwa4+aWZbX2rQZDxiUT1Oll6cmiG1S4E6WOEwiZ6U6
         f5UUYZLx8MDJJHcZCG5Rataie6eSJBfQ5Tj6ey98DzLWZ3l9I3sThG93zcJ4r5b0/adc
         nWRXG5iEDfySlEVLExXGXOQS5KF/xMipny2l7IEGUk7ZPFxAvSUaqAODBGaxv/6yD0j7
         ZZjA32B7RUhVLsdO6F9DFTZQv/5ZKxcFsi9PX21DytJOKw++1OOMVa47ZX0n0fFfa+Hh
         T2Sh0rfD5KqqUwxsoDKHqzNNtlZFaMiL7Jc4Pso6D51Pf5pkFjXaHqLQuB3A+Awl0vVH
         E0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OwKM7GHWgJRm0qnvN5L/kXJLsHyAatYIIo/ePs6DUss=;
        b=zYQ26ITeVnt63cZiUx8LFBbK+fK3+xzcFZY/w4PuqlrLgXYGzaF6y2SGvQlJm0aIs+
         kGw3OmdW41VVD3bSQjH1ndoyGEJN3bLurg6gV4zuGnIJYGKb16uGwBIZD4sLBvIS0xnW
         9rwsNWwXz6szjKn/9+d6AdFB+9hdUUF2PY3cKXAC8X6nz7E2mspF423+a8MR44Pr8IRt
         p36dJXCBglXvZLnzuO2Zvhj3wDSK7MIhBVKWDwOwpHSSmDM+hkWoPoWgYr6QcnDQM8Ka
         dzv5Qg+4uZMcwK2fLonNSIE4HeYbfcQTnpESmZa9c+YkgcoDNK3Eik9cLhhAqBB5JMwu
         8JDA==
X-Gm-Message-State: AO0yUKXZfNljHYufHRe+z8gqvtCRuJltSiwJrxDqdSTxxXcNUqiqHo93
        xGoLM+rAotlGvO42qHaUNR+dnuPSA5wi6Q==
X-Google-Smtp-Source: AK7set+g3PQVG4noSKTHACljoRwFJyiNQo6R7vcPtPKQ3kJ1bqrYb66h+0+F/br/hyyXv8e5qUZe1g==
X-Received: by 2002:a17:90b:384f:b0:230:c723:f37d with SMTP id nl15-20020a17090b384f00b00230c723f37dmr7651330pjb.40.1678015597777;
        Sun, 05 Mar 2023 03:26:37 -0800 (PST)
Received: from rh-tp ([2406:7400:63:469f:eb50:3ffb:dc1b:2d55])
        by smtp.gmail.com with ESMTPSA id z11-20020a63190b000000b005039c35225bsm4347271pgl.94.2023.03.05.03.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 03:26:36 -0800 (PST)
Date:   Sun, 05 Mar 2023 16:56:30 +0530
Message-Id: <87356j30d5.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 24/31] ext4: Convert ext4_mpage_readpages() to work on folios
In-Reply-To: <Y9P251BErHVfsum5@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Thu, Jan 26, 2023 at 08:15:04PM -0800, Eric Biggers wrote:
>> On Thu, Jan 26, 2023 at 08:24:08PM +0000, Matthew Wilcox (Oracle) wrote:
>> >  int ext4_mpage_readpages(struct inode *inode,
>> > -		struct readahead_control *rac, struct page *page)
>> > +		struct readahead_control *rac, struct folio *folio)
>> >  {
>> >  	struct bio *bio = NULL;
>> >  	sector_t last_block_in_bio = 0;
>> > @@ -247,16 +247,15 @@ int ext4_mpage_readpages(struct inode *inode,
>> >  		int fully_mapped = 1;
>> >  		unsigned first_hole = blocks_per_page;
>> >
>> > -		if (rac) {
>> > -			page = readahead_page(rac);
>> > -			prefetchw(&page->flags);
>> > -		}
>> > +		if (rac)
>> > +			folio = readahead_folio(rac);
>> > +		prefetchw(&folio->flags);
>>
>> Unlike readahead_page(), readahead_folio() puts the folio immediately.  Is that
>> really safe?
>
> It's safe until we unlock the page.  The page cache holds a refcount,
> and truncation has to lock the page before it can remove it from the
> page cache.
>
> Putting the refcount in readahead_folio() is a transitional step; once
> all filesystems are converted to use readahead_folio(), I'll hoist the
> refcount put to the caller.  Having ->readahead() and ->read_folio()
> with different rules for who puts the folio is a long-standing mistake.
>
>> > @@ -299,11 +298,11 @@ int ext4_mpage_readpages(struct inode *inode,
>> >
>> >  				if (ext4_map_blocks(NULL, inode, &map, 0) < 0) {
>> >  				set_error_page:
>> > -					SetPageError(page);
>> > -					zero_user_segment(page, 0,
>> > -							  PAGE_SIZE);
>> > -					unlock_page(page);
>> > -					goto next_page;
>> > +					folio_set_error(folio);
>> > +					folio_zero_segment(folio, 0,
>> > +							  folio_size(folio));
>> > +					folio_unlock(folio);
>> > +					continue;
>>
>> This is 'continuing' the inner loop, not the outer loop as it should.
>
> Oops.  Will fix.  I didn't get any extra failures from xfstests
> with this bug, although I suspect I wasn't testing with block size <
> page size, which is probably needed to make a difference.

I am still reviewing the rest of the series. But just wanted to paste
this failure with generic/574 with 4k blocksize on x86 system.

The fix is the same which Eric pointed out.


[  208.818910] fsverity_msg: 3 callbacks suppressed
[  208.818927] fs-verity (loop7, inode 12): FILE CORRUPTED! pos=0, level=0, want_hash=sha256:5d55504690cf24b26f46d577f874d2d4c6
[  208.835984] ------------[ cut here ]------------
[  208.839047] WARNING: CPU: 2 PID: 2370 at fs/verity/verify.c:277 verify_data_blocks+0xc5/0x1b0
[  208.844648] Modules linked in:
[  208.846986] CPU: 2 PID: 2370 Comm: cat Not tainted 6.2.0-xfstests-13498-ga1825ad035c0 #29
[  208.852746] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/4
[  208.860155] RIP: 0010:verify_data_blocks+0xc5/0x1b0
[  208.863491] Code: 89 e7 e8 8e 32 e0 ff 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 bf 00 00 00 49 e
[  208.875434] RSP: 0018:ffff8881b8867688 EFLAGS: 00010246
[  208.878903] RAX: 0110000000000110 RBX: 0000000000001000 RCX: ffffffff81cd8a92
[  208.883539] RDX: 1ffffd4000a69bb0 RSI: 0000000000000008 RDI: ffffea000534dd80
[  208.888246] RBP: 0000000000001000 R08: 0000000000000000 R09: ffffea000534dd87
[  208.892932] R10: fffff94000a69bb0 R11: ffffffff86d90cb3 R12: ffffea000534dd80
[  208.897570] R13: ffff8881444381c8 R14: 0000000000000000 R15: ffff88810dd0cea8
[  208.901848] FS:  00007ffff7fb3740(0000) GS:ffff8883eb800000(0000) knlGS:0000000000000000
[  208.904643] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  208.906858] CR2: 00007ffff7f91000 CR3: 00000001f9202006 CR4: 0000000000170ee0
[  208.909510] Call Trace:
[  208.910545]  <TASK>
[  208.911469]  fsverity_verify_blocks+0xc7/0x140
[  208.913364]  ext4_mpage_readpages+0x545/0xe50
[  208.915211]  ? __pfx_ext4_mpage_readpages+0x10/0x10
[  208.917051]  ? find_held_lock+0x2d/0x120
[  208.918753]  ? kvm_clock_read+0x14/0x30
[  208.920316]  ? kvm_sched_clock_read+0x9/0x20
[  208.922074]  ? local_clock+0xf/0xd0
[  208.923436]  ? __lock_release+0x480/0x940
[  208.925071]  ? __pfx___lock_release+0x10/0x10
[  208.926723]  read_pages+0x190/0xb60
[  208.928134]  ? folio_add_lru+0x334/0x630
[  208.929746]  ? lock_release+0xff/0x2c0
[  208.931190]  ? folio_add_lru+0x355/0x630
[  208.932904]  ? __pfx_read_pages+0x10/0x10
[  208.934450]  page_cache_ra_unbounded+0x2cc/0x510
[  208.936249]  filemap_get_pages+0x233/0x7c0
[  208.937851]  ? __pfx_filemap_get_pages+0x10/0x10
[  208.939674]  ? __lock_acquire+0x7e1/0x1120
[  208.941229]  filemap_read+0x2dd/0xa20
[  208.942763]  ? __pfx_filemap_read+0x10/0x10
[  208.944522]  ? do_anonymous_page+0x58b/0x12e0
[  208.946333]  ? do_raw_spin_unlock+0x14d/0x1f0
[  208.948279]  ? _raw_spin_unlock+0x2d/0x50
[  208.949899]  ? do_anonymous_page+0x58b/0x12e0
[  208.951631]  vfs_read+0x512/0x750
[  208.953018]  ? __pfx_vfs_read+0x10/0x10
[  208.954480]  ? local_clock+0xf/0xd0
[  208.955964]  ? __pfx___lock_release+0x10/0x10
[  208.957744]  ? __fget_light+0x51/0x230
[  208.959408]  ksys_read+0xfd/0x1d0
[  208.960719]  ? __pfx_ksys_read+0x10/0x10
[  208.962327]  ? syscall_enter_from_user_mode+0x21/0x50
[  208.964180]  do_syscall_64+0x3f/0x90
[  208.965732]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  208.967618] RIP: 0033:0x7ffff7d0ccf1
[  208.969181] Code: 31 c0 e9 b2 fe ff ff 50 48 8d 3d b2 0a 0b 00 e8 65 29 02 00 0f 1f 44 00 00 f3 0f 1e fa 80 3d ed 18 0f 00 4
[  208.975395] RSP: 002b:00007fffffffccc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[  208.978052] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007ffff7d0ccf1
[  208.980657] RDX: 0000000000020000 RSI: 00007ffff7f92000 RDI: 0000000000000003
[  208.983256] RBP: 00007ffff7f92000 R08: 00000000ffffffff R09: 0000000000000000
[  208.985874] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000022000
[  208.988480] R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000
[  208.991004]  </TASK>
[  208.992250] irq event stamp: 6759
[  208.993616] hardirqs last  enabled at (6769): [<ffffffff81528362>] __up_console_sem+0x52/0x60
[  208.996681] hardirqs last disabled at (6780): [<ffffffff81528347>] __up_console_sem+0x37/0x60
[  208.999764] softirqs last  enabled at (6278): [<ffffffff8445c3d6>] __do_softirq+0x546/0x87f
[  209.002772] softirqs last disabled at (6273): [<ffffffff813d0d64>] irq_exit_rcu+0x124/0x1a0
[  209.005992] ---[ end trace 0000000000000000 ]---
[  209.007743] page:ffffea000534dd80 refcount:1 mapcount:0 mapping:ffff88814476db30 index:0x0 pfn:0x14d376
[  209.011119] memcg:ffff8881800f9000
[  209.012564] aops:ext4_da_aops ino:c dentry name:"file.fsv"
[  209.014614] flags: 0x110000000000110(error|lru|node=0|zone=2)
[  209.016839] raw: 0110000000000110 ffffea0005404388 ffffea0005411588 ffff88814476db30
[  209.019657] raw: 0000000000000000 0000000000000000 00000001ffffffff ffff8881800f9000
[  209.022464] page dumped because: VM_BUG_ON_FOLIO(!folio_test_locked(folio))
[  209.025086] ------------[ cut here ]------------
[  209.026790] kernel BUG at mm/filemap.c:1529!
[  209.028620] invalid opcode: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN PTI
[  209.030944] CPU: 2 PID: 2370 Comm: cat Tainted: G        W          6.2.0-xfstests-13498-ga1825ad035c0 #29
[  209.034067] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/4
[  209.038883] RIP: 0010:folio_unlock+0x6a/0x80
[  209.040434] Code: ec 1c 00 f0 80 65 00 fe 78 06 5d c3 cc cc cc cc 48 89 ef 5d 31 f6 e9 15 f6 ff ff 48 c7 c6 a0 9c 93 84 48 0
[  209.048850] RSP: 0018:ffff8881b8867700 EFLAGS: 00010246
[  209.050702] RAX: 000000000000003f RBX: 0000000000000001 RCX: 0000000000000000
[  209.054327] RDX: 0000000000000000 RSI: ffffffff84cd7440 RDI: 0000000000000001
[  209.056733] RBP: ffffea000534dd80 R08: 0000000000000001 R09: ffff8881b886751f
[  209.060241] R10: ffffed103710cea3 R11: 0000000000000000 R12: 0000000000000000
[  209.062776] R13: 0000000000000001 R14: ffffea000534dd80 R15: dffffc0000000000
[  209.065462] FS:  00007ffff7fb3740(0000) GS:ffff8883eb800000(0000) knlGS:0000000000000000
[  209.068635] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  209.070598] CR2: 00007ffff7f91000 CR3: 00000001f9202006 CR4: 0000000000170ee0
[  209.072954] Call Trace:
[  209.073922]  <TASK>
[  209.074887]  ext4_mpage_readpages+0x731/0xe50
[  209.076506]  ? __pfx_ext4_mpage_readpages+0x10/0x10
[  209.078372]  ? find_held_lock+0x2d/0x120
[  209.079776]  ? kvm_clock_read+0x14/0x30
[  209.081165]  ? kvm_sched_clock_read+0x9/0x20
[  209.082883]  ? local_clock+0xf/0xd0
[  209.084158]  ? __lock_release+0x480/0x940
[  209.085591]  ? __pfx___lock_release+0x10/0x10
[  209.087127]  read_pages+0x190/0xb60
[  209.088433]  ? folio_add_lru+0x334/0x630
[  209.089843]  ? lock_release+0xff/0x2c0
[  209.091188]  ? folio_add_lru+0x355/0x630
[  209.092574]  ? __pfx_read_pages+0x10/0x10
[  209.093991]  page_cache_ra_unbounded+0x2cc/0x510
[  209.095580]  filemap_get_pages+0x233/0x7c0
[  209.097019]  ? __pfx_filemap_get_pages+0x10/0x10
[  209.098607]  ? __lock_acquire+0x7e1/0x1120
[  209.100032]  filemap_read+0x2dd/0xa20
[  209.101357]  ? __pfx_filemap_read+0x10/0x10
[  209.102809]  ? do_anonymous_page+0x58b/0x12e0
[  209.104321]  ? do_raw_spin_unlock+0x14d/0x1f0
[  209.105853]  ? _raw_spin_unlock+0x2d/0x50
[  209.107254]  ? do_anonymous_page+0x58b/0x12e0
[  209.108770]  vfs_read+0x512/0x750
[  209.109997]  ? __pfx_vfs_read+0x10/0x10
[  209.111350]  ? local_clock+0xf/0xd0
[  209.112604]  ? __pfx___lock_release+0x10/0x10
[  209.114138]  ? __fget_light+0x51/0x230
[  209.115469]  ksys_read+0xfd/0x1d0
[  209.116676]  ? __pfx_ksys_read+0x10/0x10
[  209.118189]  ? syscall_enter_from_user_mode+0x21/0x50
[  209.119894]  do_syscall_64+0x3f/0x90
[  209.121201]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  209.122901] RIP: 0033:0x7ffff7d0ccf1
[  209.124159] Code: 31 c0 e9 b2 fe ff ff 50 48 8d 3d b2 0a 0b 00 e8 65 29 02 00 0f 1f 44 00 00 f3 0f 1e fa 80 3d ed 18 0f 00 4
[  209.129836] RSP: 002b:00007fffffffccc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000

-ritesh
