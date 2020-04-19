Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543001AFDA5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 21:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgDSTpv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 15:45:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41478 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgDSTpt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 15:45:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id h69so3961444pgc.8;
        Sun, 19 Apr 2020 12:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NfZ0CGpXM408BLI+JTnLaP9+hTWHS+ak5H64DsHwe+U=;
        b=HXEbvziQVPWsqvdqi9Z5q4opX7eVzv+UiSo2gIPKdj2N27qQA1epZxa/pES2sQ38Kf
         3qFakPojpxGJgsIz9p2koUMYlRq85vtsENdxSnXhIVQphKf/uzOwxuECrlwo2UxKPgUK
         7n9AmFjwI2c6LkciTyWXYpMtVOVgVpSAGK5sZRVGke1Jm+0yy48eWbiHexfuU4UDXXEo
         k/pHBmG3aHRSkoN2ySV7PRptiw7i0SESYqXjMFNeJKJWLyAynFpg/8sb6d/fk9DxsBPe
         mlMSeNX1Fy5Yy8GKkUAIR6TcEbjZaODxKY7ht0nYQrntoId4XiCyW/j1sw0vSELrdRDu
         7I1w==
X-Gm-Message-State: AGi0PuYEZvt9YnX+DsVkhk69UdLpEu3GcbsrhbbLEtI5ddL5vuZLxiPB
        YrMzgK/LXtg/ayKk51roldk=
X-Google-Smtp-Source: APiQypJ6bnJ0rlwGymcyw63MUruuzFDFbkQ4D0UHyI3+4jLivHWMyxrjz3q+GZQtHyRNB34mhpOi4Q==
X-Received: by 2002:a63:de41:: with SMTP id y1mr12910054pgi.176.1587325547486;
        Sun, 19 Apr 2020 12:45:47 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id t23sm11668393pjq.27.2020.04.19.12.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 12:45:43 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id AEEA741D12; Sun, 19 Apr 2020 19:45:38 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: [PATCH v2 03/10] blktrace: fix debugfs use after free
Date:   Sun, 19 Apr 2020 19:45:22 +0000
Message-Id: <20200419194529.4872-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200419194529.4872-1-mcgrof@kernel.org>
References: <20200419194529.4872-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On commit 6ac93117ab00 ("blktrace: use existing disk debugfs directory")
merged on v4.12 Omar fixed the original blktrace code for request-based
drivers (multiqueue). This however left in place a possible crash, if you
happen to abuse blktrace in a way it was not intended, and even more so
with our current asynchronous request_queue removal.

Namely, if you loop adding a device, setup the blktrace with BLKTRACESETUP,
forget to BLKTRACETEARDOWN, and then just remove the device you end up
with a panic:

[  107.193134] debugfs: Directory 'loop0' with parent 'block' already present!
[  107.254615] BUG: kernel NULL pointer dereference, address: 00000000000000a0
[  107.258785] #PF: supervisor write access in kernel mode
[  107.262035] #PF: error_code(0x0002) - not-present page
[  107.264106] PGD 0 P4D 0
[  107.264404] Oops: 0002 [#1] SMP NOPTI
[  107.264803] CPU: 8 PID: 674 Comm: kworker/8:2 Tainted: G            E 5.6.0-rc7-next-20200327 #1
[  107.265712] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
[  107.266553] Workqueue: events __blk_release_queue
[  107.267051] RIP: 0010:down_write+0x15/0x40
[  107.267488] Code: eb ca e8 ee a5 8d ff cc cc cc cc cc cc cc cc cc cc cc cc cc cc 0f 1f 44 00 00 55 48 89 fd e8 52 db ff ff 31 c0 ba 01 00 00 00 <f0> 48 0f b1 55 00 75 0f  65 48 8b 04 25 c0 8b 01 00 48 89 45 08 5d
[  107.269300] RSP: 0018:ffff9927c06efda8 EFLAGS: 00010246
[  107.269841] RAX: 0000000000000000 RBX: ffff8be7e73b0600 RCX: ffffff8100000000
[  107.270559] RDX: 0000000000000001 RSI: ffffff8100000000 RDI: 00000000000000a0
[  107.271281] RBP: 00000000000000a0 R08: ffff8be7ebc80fa8 R09: ffff8be7ebc80fa8
[  107.272001] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  107.272722] R13: ffff8be7efc30400 R14: ffff8be7e0571200 R15: 00000000000000a0
[  107.273475] FS:  0000000000000000(0000) GS:ffff8be7efc00000(0000) knlGS:0000000000000000
[  107.274346] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  107.274968] CR2: 00000000000000a0 CR3: 000000042abee003 CR4: 0000000000360ee0
[  107.275710] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  107.276465] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  107.277214] Call Trace:
[  107.277532]  simple_recursive_removal+0x4e/0x2e0
[  107.278049]  ? debugfs_remove+0x60/0x60
[  107.278493]  debugfs_remove+0x40/0x60
[  107.278922]  blk_trace_free+0xd/0x50
[  107.279339]  __blk_trace_remove+0x27/0x40
[  107.279797]  blk_trace_shutdown+0x30/0x40
[  107.280256]  __blk_release_queue+0xab/0x110
[  107.280734]  process_one_work+0x1b4/0x380
[  107.281194]  worker_thread+0x50/0x3c0
[  107.281622]  kthread+0xf9/0x130
[  107.281994]  ? process_one_work+0x380/0x380
[  107.282467]  ? kthread_park+0x90/0x90
[  107.282895]  ret_from_fork+0x1f/0x40
[  107.283316] Modules linked in: loop(E) <etc>
[  107.288562] CR2: 00000000000000a0
[  107.288957] ---[ end trace b885d243d441bbce ]---

This splat happens to be very similar to the one reported via
kernel.org korg#205713, only that korg#205713 was for v4.19.83
and the above now includes the simple_recursive_removal() introduced
via commit a3d1e7eb5abe ("simple_recursive_removal(): kernel-side rm
-rf for ramfs-style filesystems") merged on v5.6.

korg#205713 then was used to create CVE-2019-19770 and claims that
the bug is in a use-after-free in the debugfs core code. The
implications of this being a generic UAF on debugfs would be
much more severe, as it would imply parent dentries can sometimes
not be positive, which we hold by design is just not possible.

Below is the splat explained with a bit more details, explaining
what is happening in userspace, kernel, and a print of the CPU on,
which the code runs on:

load loopback module
[   13.603371] == blk_mq_debugfs_register(12) start
[   13.604040] == blk_mq_debugfs_register(12) q->debugfs_dir created
[   13.604934] == blk_mq_debugfs_register(12) end
[   13.627382] == blk_mq_debugfs_register(12) start
[   13.628041] == blk_mq_debugfs_register(12) q->debugfs_dir created
[   13.629240] == blk_mq_debugfs_register(12) end
[   13.651667] == blk_mq_debugfs_register(12) start
[   13.652836] == blk_mq_debugfs_register(12) q->debugfs_dir created
[   13.655107] == blk_mq_debugfs_register(12) end
[   13.684917] == blk_mq_debugfs_register(12) start
[   13.687876] == blk_mq_debugfs_register(12) q->debugfs_dir created
[   13.691588] == blk_mq_debugfs_register(13) end
[   13.707320] == blk_mq_debugfs_register(13) start
[   13.707863] == blk_mq_debugfs_register(13) q->debugfs_dir created
[   13.708856] == blk_mq_debugfs_register(13) end
[   13.735623] == blk_mq_debugfs_register(13) start
[   13.736656] == blk_mq_debugfs_register(13) q->debugfs_dir created
[   13.738411] == blk_mq_debugfs_register(13) end
[   13.763326] == blk_mq_debugfs_register(13) start
[   13.763972] == blk_mq_debugfs_register(13) q->debugfs_dir created
[   13.765167] == blk_mq_debugfs_register(13) end
[   13.779510] == blk_mq_debugfs_register(13) start
[   13.780522] == blk_mq_debugfs_register(13) q->debugfs_dir created
[   13.782338] == blk_mq_debugfs_register(13) end
[   13.783521] loop: module loaded

LOOP_CTL_DEL(loop0) #1
[   13.803550] = __blk_release_queue(4) start
[   13.807772] == blk_trace_shutdown(4) start
[   13.810749] == blk_trace_shutdown(4) end
[   13.813437] = __blk_release_queue(4) calling blk_mq_debugfs_unregister()
[   13.817593] ==== blk_mq_debugfs_unregister(4) begin
[   13.817621] ==== blk_mq_debugfs_unregister(4) debugfs_remove_recursive(q->debugfs_dir)
[   13.821203] ==== blk_mq_debugfs_unregister(4) end q->debugfs_dir is NULL
[   13.826166] = __blk_release_queue(4) blk_mq_debugfs_unregister() end
[   13.832992] = __blk_release_queue(4) end

LOOP_CTL_ADD(loop0) #1
[   13.843742] == blk_mq_debugfs_register(7) start
[   13.845569] == blk_mq_debugfs_register(7) q->debugfs_dir created
[   13.848628] == blk_mq_debugfs_register(7) end

BLKTRACE_SETUP(loop0) #1
[   13.850924] == blk_trace_ioctl(7, BLKTRACESETUP) start
[   13.852852] === do_blk_trace_setup(7) start
[   13.854580] === do_blk_trace_setup(7) creating directory
[   13.856620] === do_blk_trace_setup(7) using what debugfs_lookup() gave
[   13.860635] === do_blk_trace_setup(7) end with ret: 0
[   13.862615] == blk_trace_ioctl(7, BLKTRACESETUP) end

LOOP_CTL_DEL(loop0) #2
[   13.883304] = __blk_release_queue(7) start
[   13.885324] == blk_trace_shutdown(7) start
[   13.887197] == blk_trace_shutdown(7) calling __blk_trace_remove()
[   13.889807] == __blk_trace_remove(7) start
[   13.891669] === blk_trace_cleanup(7) start
[   13.911656] ====== blk_trace_free(7) start

This is a scheduled __blk_release_queue(). Note that at this point
we know that the old device is gone as the gendisk removal is
synchronous.

LOOP_CTL_ADD(loop0) #2
[   13.912709] == blk_mq_debugfs_register(2) start

This is a *new* device, as we know the last one was removed synchronously.

---> From LOOP_CTL_DEL(loop0) #2
[   13.915887] ====== blk_trace_free(7) end

---> From LOOP_CTL_ADD(loop0) #2
[   13.918359] debugfs: Directory 'loop0' with parent 'block' already present!

Above we have a case where the upon LOOP_CTL_ADD(loop) #2 the
debugfs_create_dir() start_creating() call will have found an existing dentry,
and return ERR_PTR(-EEXIST), and so the q->debugfs_dir will be initialized to
NULL. This clash happens because an asynchronous __blk_release_queue() has
been scheduled from the above LOOP_CTL_DEL(loop0) #2 call, and it has not yet
removed the old loop0 debugfs directory.

[   13.926433] == blk_mq_debugfs_register(2) q->debugfs_dir created

This is a huge assumption, since we never check for errors on
blk_mq_debugfs_register(), and so the child files we need to
create *can* simply be created using NULL as as the parent, in
which case debugfs would use debugfs_mount->mnt_root as the parent.

[   13.930373] == blk_mq_debugfs_register(2) end

BLKTRACE_SETUP(loop0) #2
[   13.933961] == blk_trace_ioctl(2, BLKTRACESETUP) start
[   13.936758] === do_blk_trace_setup(2) start
[   13.938944] === do_blk_trace_setup(2) creating directory
[   13.941029] === do_blk_trace_setup(2) using what debugfs_lookup() gave

Here debugfs_lookup() will have found the old debugfs directory, even
though q->debugfs_dir was empty when initializing this device. So the
files created can actually be created where they should have.

---> From LOOP_CTL_DEL(loop0) #2
[   13.971046] === blk_trace_cleanup(7) end
[   13.973175] == __blk_trace_remove(7) end
[   13.975352] == blk_trace_shutdown(7) end
[   13.977415] = __blk_release_queue(7) calling blk_mq_debugfs_unregister()
[   13.980645] ==== blk_mq_debugfs_unregister(7) begin
[   13.980696] ==== blk_mq_debugfs_unregister(7) debugfs_remove_recursive(q->debugfs_dir)

This is a continuation from the old scheduled  __blk_release_queue(). It
is using another request_queue structure than what the currently activated
blktrace setup is using.

Here now the dentry where the blktrace setup files were created on top
of is gone.  In fact, since debugfs_remove_recursive() is used, *all* of
those blktrace debugfs files should have been removed as well, including
the relay. This is despite the fact that the removal and blktrace setup
are working on two different request_queue structures.

[   13.983118] ==== blk_mq_debugfs_unregister(7) end q->debugfs_dir is NULL
[   13.986945] = __blk_release_queue(7) blk_mq_debugfs_unregister() end
[   13.993155] = __blk_release_queue(7) end

The scheduled __blk_release_queue completes finally.

---> From BLKTRACE_SETUP(loop0) #2
[   13.995928] === do_blk_trace_setup(2) end with ret: 0
[   13.997623] == blk_trace_ioctl(2, BLKTRACESETUP) end

At this point the old blktrace *setup* is complete though, and let us
recall that the old dentry is still used. But recall that we just had
our old device removed, and since debugfs_remove_recursive() was used,
so are all of its files. This request_queue however is still active.

LOOP_CTL_DEL(loop0) #3
[   14.035119] = __blk_release_queue(2) start
[   14.036925] == blk_trace_shutdown(2) start
[   14.038518] == blk_trace_shutdown(2) calling __blk_trace_remove()
[   14.040829] == __blk_trace_remove(2) start
[   14.042413] === blk_trace_cleanup(2) start

This removal will cleanup the blktrace setup. Note the trap though,
the blktrace setup will already have been cleaned up since the
scheduled removal from instance #2 removed the files on the same
debugfs path.

The __blk_release_queue() is scheduled and is asynchronous so can
continue later, and that is where the crash happens, on CPU 2.

LOOP_CTL_ADD(loop0) #3
[   14.072522] == blk_mq_debugfs_register(6) start

---> From LOOP_CTL_DEL(loop0) #3
[   14.075151] ====== blk_trace_free(2) start

---> From LOOP_CTL_ADD(loop0) #3
[   14.075882] == blk_mq_debugfs_register(6) q->debugfs_dir created

---> From LOOP_CTL_DEL(loop0) #3
The panic happens on CPU 2 when we continue with the old scheduled
removal of the request_queue, which will run into a blktrace setup
with NULL pointers.

[   14.078624] BUG: kernel NULL pointer dereference, address: 00000000000000a0
[   14.084332] == blk_mq_debugfs_register(6) end
[   14.086971] #PF: supervisor write access in kernel mode
[   14.086974] #PF: error_code(0x0002) - not-present page
[   14.086977] PGD 0 P4D 0
[   14.086984] Oops: 0002 [#1] SMP NOPTI
[   14.086990] CPU: 2 PID: 287 Comm: kworker/2:2 Tainted: G            E 5.6.0-next-20200403+ #54
[   14.086991] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
[   14.087002] Workqueue: events __blk_release_queue
[   14.087011] RIP: 0010:down_write+0x15/0x40
[   14.090300] == blk_trace_ioctl(6, BLKTRACESETUP) start
[   14.093277] Code: eb ca e8 3e 34 8d ff cc cc cc cc cc cc cc cc cc cc
cc cc cc cc 0f 1f 44 00 00 55 48 89 fd e8 52 db ff ff 31 c0 ba 01 00 00
00 <f0> 48 0f b1 55 00 75 0f 65 48 8b 04 25 c0 8b 01 00 48 89 45 08 5d
[   14.093280] RSP: 0018:ffffc28a00533da8 EFLAGS: 00010246
[   14.093284] RAX: 0000000000000000 RBX: ffff9f7a24d07980 RCX: ffffff8100000000
[   14.093286] RDX: 0000000000000001 RSI: ffffff8100000000 RDI: 00000000000000a0
[   14.093287] RBP: 00000000000000a0 R08: 0000000000000000 R09: 0000000000000019
[   14.093289] R10: 0000000000000774 R11: 0000000000000000 R12: 0000000000000000
[   14.093291] R13: ffff9f7a2fab0400 R14: ffff9f7a21dd1140 R15: 00000000000000a0
[   14.093294] FS:  0000000000000000(0000) GS:ffff9f7a2fa80000(0000) knlGS:0000000000000000
[   14.093296] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   14.093298] CR2: 00000000000000a0 CR3: 00000004293d2003 CR4: 0000000000360ee0
[   14.093307] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   14.093308] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   14.093310] Call Trace:
[   14.093324]  simple_recursive_removal+0x4e/0x2e0
[   14.093330]  ? debugfs_remove+0x60/0x60
[   14.093334]  debugfs_remove+0x40/0x60
[   14.093339]  blk_trace_free+0x20/0x70
[   14.093346]  __blk_trace_remove+0x54/0x90
[   14.096704] === do_blk_trace_setup(6) start
[   14.098534]  blk_trace_shutdown+0x74/0x80
[   14.100958] === do_blk_trace_setup(6) creating directory
[   14.104575]  __blk_release_queue+0xbe/0x160
[   14.104580]  process_one_work+0x1b4/0x380
[   14.104585]  worker_thread+0x50/0x3c0
[   14.104589]  kthread+0xf9/0x130
[   14.104593]  ? process_one_work+0x380/0x380
[   14.104596]  ? kthread_park+0x90/0x90
[   14.104599]  ret_from_fork+0x1f/0x40
[   14.104603] Modules linked in: loop(E) xfs(E) libcrc32c(E)
crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) joydev(E)
serio_raw(E) aesni_intel(E) glue_helper(E) virtio_balloon(E) evdev(E)
crypto_simd(E) pcspkr(E) cryptd(E) i6300esb(E) button(E) ip_tables(E)
x_tables(E) autofs4(E) ext4(E) crc32c_generic(E) crc16(E) mbcache(E)
jbd2(E) virtio_net(E) net_failover(E) failover(E) virtio_blk(E)
ata_generic(E) uhci_hcd(E) ata_piix(E) ehci_hcd(E) nvme(E) libata(E)
crc32c_intel(E) usbcore(E) psmouse(E) nvme_core(E) virtio_pci(E)
scsi_mod(E) virtio_ring(E) t10_pi(E) virtio(E) i2c_piix4(E) floppy(E)
[   14.107400] === do_blk_trace_setup(6) using what debugfs_lookup() gave
[   14.108939] CR2: 00000000000000a0
[   14.110589] === do_blk_trace_setup(6) end with ret: 0
[   14.111592] ---[ end trace 7a783b33b9614db9 ]---

The root cause to this issue is that debugfs_lookup() can find a
previous incarnation's dir of the same name which is about to get
removed from a not yet schedule work. When that happens, the the files
are taken underneath the nose of the blktrace, and when it comes time to
cleanup, these dentries are long gone because of a scheduled removal.

This issue is happening because of two reasons:

  1) The request_queue is currently removed asynchronously as of commit
     dc9edc44de6c ("block: Fix a blk_exit_rl() regression") merged on
     v4.12, this allows races with userspace which were not possible
     before unless as removal of a block device used to happen
     synchronously with its request_queue. One could however still
     parallelize blksetup calls while one loops on device addition and
     removal.

  2) There are no errors checks when we create the debugfs directory,
     be it on init or for blktrace. The concept of when the directory
     *should* really exist is further complicated by the fact that
     we have asynchronous request_queue removal. And, we have no
     real sanity checks to ensure we don't re-create the queue debugfs
     directory.

We can fix the UAF by using a debugfs directory which moving forward
will always be accessible if debugfs is enabled, this way, its allocated
and avaialble always for both request-based block drivers or
make_request drivers (multiqueue) block drivers.

We also put sanity checks in place to ensure that if the directory is
found with debugfs_lookup() it is the dentry we expect. When doing a
blktrace against a parition, we will always be creating a temporary
debugfs directory, so ensure that only exists once as well to avoid
issues against concurrent blktrace runs.

Lastly, since we are now always creating the needed request_queue
debugfs directory upon init, we can also take the initiative to
proactively check against errors. We currently do not check for
errors on add_disk() and friends, but we shouldn't make the issue
any worse.

This also simplifies the code considerably, with the only penalty now
being that we're always creating the request queue debugfs directory for
the request-based block device drivers.

The UAF then is not a core debugfs issue, but instead a complex misuse
of debugfs, and this issue can only be triggered if you are root.

This issue can be reproduced with break-blktrace [2] using:

  break-blktrace -c 10 -d -s

This patch fixes this issue. Note that there is also another
respective UAF but from the ioctl path [3], this should also fix
that issue.

This patch then also disputes the severity of CVE-2019-19770 as
this issue is only possible by being root and using blktrace.

It is not a core debugfs issue.

[0] https://bugzilla.kernel.org/show_bug.cgi?id=205713
[1] https://nvd.nist.gov/vuln/detail/CVE-2019-19770
[2] https://github.com/mcgrof/break-blktrace
[3] https://lore.kernel.org/lkml/000000000000ec635b059f752700@google.com/

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: yu kuai <yukuai3@huawei.com>
Reported-by: syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Fixes: 6ac93117ab00 ("blktrace: use existing disk debugfs directory")
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/blk-debugfs.c          | 30 +++++++++++
 block/blk-mq-debugfs.c       |  5 --
 block/blk-sysfs.c            |  9 ++++
 block/blk.h                  | 11 ++++
 include/linux/blkdev.h       |  5 +-
 include/linux/blktrace_api.h |  1 +
 kernel/trace/blktrace.c      | 98 +++++++++++++++++++++++++++++++++---
 7 files changed, 146 insertions(+), 13 deletions(-)

diff --git a/block/blk-debugfs.c b/block/blk-debugfs.c
index 19091e1effc0..d84038bce0a5 100644
--- a/block/blk-debugfs.c
+++ b/block/blk-debugfs.c
@@ -3,6 +3,9 @@
 /*
  * Shared request-based / make_request-based functionality
  */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/blkdev.h>
 #include <linux/debugfs.h>
@@ -13,3 +16,30 @@ void blk_debugfs_register(void)
 {
 	blk_debugfs_root = debugfs_create_dir("block", NULL);
 }
+
+int __must_check blk_queue_debugfs_register(struct request_queue *q)
+{
+	struct dentry *dir = NULL;
+
+	/* This can happen if we have a bug in the lower layers */
+	dir = debugfs_lookup(kobject_name(q->kobj.parent), blk_debugfs_root);
+	if (dir) {
+		pr_warn("%s: registering request_queue debugfs directory twice is not allowed\n",
+			kobject_name(q->kobj.parent));
+		dput(dir);
+		return -EALREADY;
+	}
+
+	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
+					    blk_debugfs_root);
+	if (!q->debugfs_dir)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void blk_queue_debugfs_unregister(struct request_queue *q)
+{
+	debugfs_remove_recursive(q->debugfs_dir);
+	q->debugfs_dir = NULL;
+}
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index b3f2ba483992..bda9378eab90 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -823,9 +823,6 @@ void blk_mq_debugfs_register(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
-					    blk_debugfs_root);
-
 	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
 
 	/*
@@ -856,9 +853,7 @@ void blk_mq_debugfs_register(struct request_queue *q)
 
 void blk_mq_debugfs_unregister(struct request_queue *q)
 {
-	debugfs_remove_recursive(q->debugfs_dir);
 	q->sched_debugfs_dir = NULL;
-	q->debugfs_dir = NULL;
 }
 
 static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index fca9b158f4a0..7072f408e69a 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -895,6 +895,7 @@ static void __blk_release_queue(struct work_struct *work)
 
 	blk_trace_shutdown(q);
 
+	blk_queue_debugfs_unregister(q);
 	if (queue_is_mq(q))
 		blk_mq_debugfs_unregister(q);
 
@@ -975,6 +976,14 @@ int blk_register_queue(struct gendisk *disk)
 		goto unlock;
 	}
 
+	ret = blk_queue_debugfs_register(q);
+	if (ret) {
+		blk_trace_remove_sysfs(dev);
+		kobject_del(&q->kobj);
+		kobject_put(&dev->kobj);
+		goto unlock;
+	}
+
 	if (queue_is_mq(q)) {
 		__blk_mq_register_dev(dev, q);
 		blk_mq_debugfs_register(q);
diff --git a/block/blk.h b/block/blk.h
index 86a66b614f08..0cae5a92fe0b 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -489,10 +489,21 @@ int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 		bool *same_page);
 #ifdef CONFIG_DEBUG_FS
 void blk_debugfs_register(void);
+int __must_check blk_queue_debugfs_register(struct request_queue *q);
+void blk_queue_debugfs_unregister(struct request_queue *q);
 #else
 static inline void blk_debugfs_register(void)
 {
 }
+
+static inline int __must_check blk_queue_debugfs_register(struct request_queue *q)
+{
+	return 0;
+}
+
+static inline void blk_queue_debugfs_unregister(struct request_queue *q)
+{
+}
 #endif /* CONFIG_DEBUG_FS */
 
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 32868fbedc9e..cc43c8e6516c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -569,8 +569,11 @@ struct request_queue {
 	struct list_head	tag_set_list;
 	struct bio_set		bio_split;
 
-#ifdef CONFIG_BLK_DEBUG_FS
+#ifdef CONFIG_DEBUG_FS
+	/* Used by block/blk-*debugfs.c and kernel/trace/blktrace.c */
 	struct dentry		*debugfs_dir;
+#endif
+#ifdef CONFIG_BLK_DEBUG_FS
 	struct dentry		*sched_debugfs_dir;
 	struct dentry		*rqos_debugfs_dir;
 #endif
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 3b6ff5902edc..43a6f98840dc 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -23,6 +23,7 @@ struct blk_trace {
 	u32 pid;
 	u32 dev;
 	struct dentry *dir;
+	struct dentry *backing_dir;
 	struct dentry *dropped_file;
 	struct dentry *msg_file;
 	struct list_head running_list;
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 2c6e6c386ace..8f87979d0971 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -3,6 +3,9 @@
  * Copyright (C) 2006 Jens Axboe <axboe@kernel.dk>
  *
  */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/blkdev.h>
 #include <linux/blktrace_api.h>
@@ -311,7 +314,15 @@ static void blk_trace_free(struct blk_trace *bt)
 	debugfs_remove(bt->msg_file);
 	debugfs_remove(bt->dropped_file);
 	relay_close(bt->rchan);
-	debugfs_remove(bt->dir);
+	/*
+	 * backing_dir is set when we use the request_queue debugfs directory.
+	 * Otherwise we are using a temporary directory created only for the
+	 * purpose of blktrace.
+	 */
+	if (bt->backing_dir)
+		dput(bt->backing_dir);
+	else
+		debugfs_remove(bt->dir);
 	free_percpu(bt->sequence);
 	free_percpu(bt->msg_data);
 	kfree(bt);
@@ -468,16 +479,89 @@ static void blk_trace_setup_lba(struct blk_trace *bt,
 	}
 }
 
+static bool blk_trace_target_disk(const char *target, const char *diskname)
+{
+	if (strlen(target) != strlen(diskname))
+		return false;
+
+	if (!strncmp(target, diskname,
+		     min_t(size_t, strlen(target), strlen(diskname))))
+		return true;
+
+	return false;
+}
+
 static struct dentry *blk_trace_debugfs_dir(struct blk_user_trace_setup *buts,
+					    struct request_queue *q,
 					    struct blk_trace *bt)
 {
 	struct dentry *dir = NULL;
 
+	/* This can only happen if we have a bug on our lower layers */
+	if (!q->kobj.parent) {
+		pr_warn("%s: request_queue parent is gone\n", buts->name);
+		return NULL;
+	}
+
+	/*
+	 * From a sysfs kobject perspective, the request_queue sits on top of
+	 * the gendisk, which has the name of the disk. We always create a
+	 * debugfs directory upon init for this gendisk kobject, so we re-use
+	 * that if blktrace is going to be done for it.
+	 */
+	if (blk_trace_target_disk(buts->name, kobject_name(q->kobj.parent))) {
+		if (!q->debugfs_dir) {
+			pr_warn("%s: expected request_queue debugfs_dir is not set\n",
+				buts->name);
+			return NULL;
+		}
+		/*
+		 * debugfs_lookup() is used to ensure the directory is not
+		 * taken from underneath us. We must dput() it later once
+		 * done with it within blktrace.
+		 */
+		dir = debugfs_lookup(buts->name, blk_debugfs_root);
+		if (!dir) {
+			pr_warn("%s: expected request_queue debugfs_dir dentry is gone\n",
+				buts->name);
+			return NULL;
+		}
+		 /*
+		 * This is a reaffirmation that debugfs_lookup() shall always
+		 * return the same dentry if it was already set.
+		 */
+		if (dir != q->debugfs_dir) {
+			dput(dir);
+			pr_warn("%s: expected dentry dir != q->debugfs_dir\n",
+				buts->name);
+			return NULL;
+		}
+		bt->backing_dir = q->debugfs_dir;
+		return bt->backing_dir;
+	}
+
+	/*
+	 * If not using blktrace on the gendisk, we are going to create a
+	 * temporary debugfs directory for it, however this cannot be shared
+	 * between two concurrent blktraces since the path is not unique, so
+	 * ensure this is only done once.
+	 */
 	dir = debugfs_lookup(buts->name, blk_debugfs_root);
-	if (!dir)
-		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
+	if (dir) {
+		pr_warn("%s: temporary blktrace debugfs directory already present\n",
+			buts->name);
+		dput(dir);
+		return NULL;
+	}
+
+	bt->dir = debugfs_create_dir(buts->name, blk_debugfs_root);
+	if (!bt->dir) {
+		pr_warn("%s: temporary blktrace debugfs directory could not be created\n",
+			buts->name);
+		return NULL;
+	}
 
-	return dir;
+	return bt->dir;
 }
 
 /*
@@ -521,7 +605,9 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 
 	ret = -ENOENT;
 
-	dir = blk_trace_debugfs_dir(buts, bt);
+	dir = blk_trace_debugfs_dir(buts, q, bt);
+	if (!dir)
+		goto err;
 
 	bt->dev = dev;
 	atomic_set(&bt->dropped, 0);
@@ -561,8 +647,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 
 	ret = 0;
 err:
-	if (dir && !bt->dir)
-		dput(dir);
 	if (ret)
 		blk_trace_free(bt);
 	return ret;
-- 
2.25.1

