Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3943363F96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 12:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbhDSK3f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 06:29:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:37318 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238600AbhDSK3S (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 06:29:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AAFE0AEBB;
        Mon, 19 Apr 2021 10:28:47 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id fe81b09b;
        Mon, 19 Apr 2021 10:30:16 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Subject: Re: [RFC PATCH v6 00/20] ceph+fscrypt: context, filename and
 symlink support
References: <20210413175052.163865-1-jlayton@kernel.org>
Date:   Mon, 19 Apr 2021 11:30:16 +0100
In-Reply-To: <20210413175052.163865-1-jlayton@kernel.org> (Jeff Layton's
        message of "Tue, 13 Apr 2021 13:50:32 -0400")
Message-ID: <87h7k2murr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> writes:

> The main change in this posting is in the detection of fscrypted inodes.
> The older set would grovel around in the xattr blob to see if it had an
> "encryption.ctx" xattr. This was problematic if the MDS didn't send
> xattrs in the trace, and not very efficient.
>
> This posting changes it to use the new "fscrypt" flag, which should
> always be reported by the MDS (Luis, I'm hoping this may fix the issues
> you were seeing with dcache coherency).

I just fetched from your updated 'ceph-fscrypt-fnames' branch (which I
assume contains this RFC series) and I'm now seeing the splat bellow.

Cheers,
--
Luis

[  149.508364] ============================================  
[  149.511075] WARNING: possible recursive locking detected  
[  149.513652] 5.12.0-rc4+ #140 Not tainted                                                                                                                                   
[  149.515656] --------------------------------------------                          
[  149.518293] cat/273 is trying to acquire lock:                                      
[  149.520570] ffff88813b3f6070 (&mdsc->mutex){+.+.}-{3:3}, at: ceph_mdsc_submit_request+0x206/0x600 [ceph]
[  149.525497]                                                                         
[  149.525497] but task is already holding lock:                                
[  149.528420] ffff88813b3f6070 (&mdsc->mutex){+.+.}-{3:3}, at: ceph_mdsc_submit_request+0x206/0x600 [ceph]
[  149.533163]                                                                         
[  149.533163] other info that might help us debug this:
[  149.536383]  Possible unsafe locking scenario:
[  149.536383] 
[  149.539344]        CPU0
[  149.540588]        ----
[  149.541870]   lock(&mdsc->mutex);
[  149.543534]   lock(&mdsc->mutex);
[  149.545205] 
[  149.545205]  *** DEADLOCK ***
[  149.545205] 
[  149.548142]  May be due to missing lock nesting notation
[  149.548142] 
[  149.551254] 2 locks held by cat/273:
[  149.552926]  #0: ffff88812296b590 (&type->i_mutex_dir_key#7){++++}-{3:3}, at: path_openat+0x959/0xe10
[  149.556923]  #1: ffff88813b3f6070 (&mdsc->mutex){+.+.}-{3:3}, at: ceph_mdsc_submit_request+0x206/0x600 [ceph]
[  149.560954] 
[  149.560954] stack backtrace:
[  149.562574] CPU: 0 PID: 273 Comm: cat Not tainted 5.12.0-rc4+ #140
[  149.564785] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
[  149.567573] Call Trace:
[  149.568207]  dump_stack+0x93/0xc2
[  149.569072]  __lock_acquire.cold+0x2e5/0x30f
[  149.570100]  ? lockdep_hardirqs_on_prepare+0x1f0/0x1f0
[  149.571318]  ? stack_trace_save+0x91/0xc0
[  149.572272]  ? mark_held_locks+0x65/0x90
[  149.573196]  lock_acquire+0x16d/0x4e0
[  149.574030]  ? ceph_mdsc_submit_request+0x206/0x600 [ceph]
[  149.575340]  ? lock_release+0x410/0x410
[  149.576211]  ? lockdep_hardirqs_on_prepare+0x1f0/0x1f0
[  149.577348]  ? mark_lock+0x101/0x1a20
[  149.578145]  ? mark_lock+0x101/0x1a20
[  149.578948]  __mutex_lock+0xfd/0xb80
[  149.579773]  ? ceph_mdsc_submit_request+0x206/0x600 [ceph]
[  149.581031]  ? ceph_mdsc_submit_request+0x206/0x600 [ceph]
[  149.582174]  ? ceph_get_cap_refs+0x1c/0x40 [ceph]
[  149.583171]  ? mutex_lock_io_nested+0xab0/0xab0
[  149.584079]  ? lock_release+0x1ea/0x410
[  149.584869]  ? ceph_mdsc_submit_request+0x42/0x600 [ceph]
[  149.585962]  ? lock_downgrade+0x390/0x390
[  149.586737]  ? lock_is_held_type+0x98/0x110
[  149.587565]  ? ceph_take_cap_refs+0x43/0x220 [ceph]
[  149.588560]  ceph_mdsc_submit_request+0x206/0x600 [ceph]
[  149.589603]  ceph_mdsc_do_request+0x31/0x320 [ceph]
[  149.590554]  __ceph_do_getattr+0xf9/0x2b0 [ceph]
[  149.591453]  __ceph_getxattr+0x2fa/0x480 [ceph]
[  149.592337]  ? find_held_lock+0x85/0xa0
[  149.593055]  ? lock_is_held_type+0x98/0x110
[  149.593799]  ceph_crypt_get_context+0x17/0x20 [ceph]
[  149.594732]  fscrypt_get_encryption_info+0x133/0x220
[  149.595621]  ? fscrypt_prepare_new_inode+0x160/0x160
[  149.596512]  ? dget_parent+0x95/0x2f0
[  149.597166]  ? lock_downgrade+0x390/0x390
[  149.597850]  ? rwlock_bug.part.0+0x60/0x60
[  149.598567]  ? lock_downgrade+0x390/0x390
[  149.599251]  ? do_raw_spin_unlock+0x93/0xf0
[  149.599968]  ? dget_parent+0xc4/0x2f0
[  149.600604]  ceph_mdsc_build_path.part.0+0x367/0x7c0 [ceph]
[  149.601587]  ? remove_session_caps_cb+0x7b0/0x7b0 [ceph]
[  149.602506]  ? __lock_acquire+0x863/0x3070
[  149.603188]  ? lockdep_hardirqs_on_prepare+0x1f0/0x1f0
[  149.604030]  ? __is_insn_slot_addr+0xc9/0x140
[  149.604774]  ? mark_lock+0x101/0x1a20
[  149.605365]  ? lock_is_held_type+0x98/0x110
[  149.606040]  ? find_held_lock+0x85/0xa0
[  149.606660]  ? lock_release+0x1ea/0x410
[  149.607279]  ? set_request_path_attr+0x173/0x500 [ceph]
[  149.608174]  ? lock_downgrade+0x390/0x390
[  149.608825]  ? find_held_lock+0x85/0xa0
[  149.609443]  ? lockdep_hardirqs_on_prepare+0x1f0/0x1f0
[  149.610267]  ? lock_release+0x1ea/0x410
[  149.610924]  set_request_path_attr+0x1a5/0x500 [ceph]
[  149.611811]  __prepare_send_request+0x30e/0x13c0 [ceph]
[  149.612847]  ? rwlock_bug.part.0+0x60/0x60
[  149.613551]  ? set_request_path_attr+0x500/0x500 [ceph]
[  149.614540]  ? __choose_mds+0x323/0xcb0 [ceph]
[  149.615398]  ? trim_caps_cb+0x3b0/0x3b0 [ceph]
[  149.616215]  ? rwlock_bug.part.0+0x60/0x60
[  149.616953]  ? ceph_get_mds_session+0xad/0x1e0 [ceph]
[  149.617847]  ? ceph_session_state_name+0x30/0x30 [ceph]
[  149.618788]  ? ceph_reserve_caps+0x331/0x5a0 [ceph]
[  149.619626]  __do_request+0x338/0x9b0 [ceph]
[  149.620376]  ? cleanup_session_requests+0x1b0/0x1b0 [ceph]
[  149.621347]  ? lock_is_held_type+0x98/0x110
[  149.622052]  ceph_mdsc_submit_request+0x4af/0x600 [ceph]
[  149.622998]  ceph_mdsc_do_request+0x31/0x320 [ceph]
[  149.623885]  ceph_atomic_open+0x3be/0x1050 [ceph]
[  149.624729]  ? d_alloc_parallel+0x576/0xe50
[  149.625309]  ? ceph_renew_caps+0x270/0x270 [ceph]
[  149.625986]  ? __d_lookup_rcu+0x2e0/0x2e0
[  149.626539]  ? lock_is_held_type+0x98/0x110
[  149.627113]  ? lockdep_hardirqs_on_prepare+0x12e/0x1f0
[  149.627835]  lookup_open.isra.0+0x5d2/0x7f0
[  149.628407]  ? hashlen_string+0xa0/0xa0
[  149.628961]  path_openat+0x457/0xe10
[  149.629468]  ? path_parentat+0xc0/0xc0
[  149.630047]  ? __alloc_pages_slowpath.constprop.0+0x1070/0x1070
[  149.630825]  ? lockdep_hardirqs_on_prepare+0x1f0/0x1f0
[  149.631540]  ? mntput_no_expire+0xe6/0x650
[  149.632080]  ? mark_held_locks+0x24/0x90
[  149.632605]  do_filp_open+0x10b/0x220
[  149.633100]  ? may_open_dev+0x50/0x50
[  149.633577]  ? lock_downgrade+0x390/0x390
[  149.634147]  ? do_raw_spin_lock+0x119/0x1b0
[  149.634785]  ? rwlock_bug.part.0+0x60/0x60
[  149.635423]  ? do_raw_spin_unlock+0x93/0xf0
[  149.636094]  ? _raw_spin_unlock+0x1f/0x30
[  149.636735]  ? alloc_fd+0x150/0x300
[  149.637284]  do_sys_openat2+0x115/0x240
[  149.637887]  ? build_open_flags+0x270/0x270
[  149.638511]  ? __ia32_compat_sys_newlstat+0x30/0x30
[  149.639264]  __x64_sys_openat+0xce/0x140
[  149.639878]  ? __ia32_compat_sys_open+0x120/0x120
[  149.640622]  ? lockdep_hardirqs_on_prepare+0x12e/0x1f0
[  149.641389]  ? syscall_enter_from_user_mode+0x1d/0x50
[  149.642175]  ? trace_hardirqs_on+0x32/0x100
[  149.642835]  do_syscall_64+0x33/0x40
[  149.643395]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  149.644165] RIP: 0033:0x7f6d190daffb
[  149.644705] Code: 25 00 00 41 00 3d 00 00 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 5
[  149.647306] RSP: 002b:00007ffe706cec20 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[  149.648294] RAX: ffffffffffffffda RBX: 000055656fd16000 RCX: 00007f6d190daffb
[  149.649200] RDX: 0000000000000000 RSI: 00007ffe706d0eda RDI: 00000000ffffff9c
[  149.650094] RBP: 00007ffe706d0eda R08: 0000000000000000 R09: 0000000000000000
[  149.650983] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  149.651876] R13: 0000000000000002 R14: 00007ffe706cef48 R15: 0000000000020000
