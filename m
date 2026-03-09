Return-Path: <linux-fsdevel+bounces-79832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BZaIMMMr2lzMQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 19:09:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D68D323E475
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 19:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30ACE30D0D23
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 18:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAF83ECBF7;
	Mon,  9 Mar 2026 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="YDc+XF+e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C9E3E5599
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079380; cv=none; b=VzcZ3d3tXZw7vx3piU1+y1Uj9dFsMASEa9HVvhbYhEU3agoVIYCEePQJ99YhufbaezYU+fR6rOxU+p7/ODAeVm3gvOluGXA2lAk0tQqSk7fWfEKeRKvIeVa7FQOkm/vIYzJ88YZOQcqep4TWQsEdBSN2SUIfC0BjqiMShuasQmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079380; c=relaxed/simple;
	bh=jO4db0+Vvz27njqBCFARGJJrX6R5+m40AGf5WBcVFOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TprLLxqFyF1wZm3n+woyGaAQpv8mTNSfu3jlbs6WdqhVEI9mO8mziBkz69L92T4E+YrndAgmrKAz3zL5FwuQfU8JoP81L/5YUWxd1ai+MtQMPGXR07+U4RksZ4M2MVtcE6bVXg4xfNhqPf9PYDy5aNZ63Q4rJUcCnCixktjJZ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=YDc+XF+e; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ad9fabd08so10151879d50.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 11:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773079377; x=1773684177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U0E0WjzWnjqKyFX0awNnkIKkxya+sqvMWbLiiTHfrHc=;
        b=YDc+XF+e0+ZaAl5mOchZDk4ruOdlZhERq12mhqGjWrzEdSlNOPiBZGkIwHm1ue8v71
         y/K6+3jbKVc9d6tTQg5VQkWnP3GcjiVdn44PX8YBQw1ibZ58KA8aYptwIxU6vGCM+elu
         uT56VTdWOzSlBb/c+If88lSVsIvHXL4Zw/HDNuVxBJ1tsLpo8Y3uJd1ECx+La8tVOAe0
         APROX7o0cjXIiQryLTHxObgrg2g8vzIEq11Swy3LXZ9yH3LWffYA5C8BSHiPqHQLKJDE
         RgM+5hhj82ddkhthcIxlR7R+FwBgCFUlXp9hgMmdv3YgglYxuauBwXs2LbkJuUuLzasp
         HwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079377; x=1773684177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0E0WjzWnjqKyFX0awNnkIKkxya+sqvMWbLiiTHfrHc=;
        b=gjKwk21x+/CAJfjD+K+9jW9F6VYaLjCCwOR14NPXvoS1TgwUA+fk2wqlDbK2wbrSEi
         aXUguJasWUiYKX5InT38mRcf8P1fp6eTRfb8TcIFa+9Bp7F9fymsqMHPjbtmp6410P4L
         dUDGuu54oBlQ2JEmbZzGLxjBXpYyWC5ylcaTsNHmOvd+Wvk1TxVlDwjpRBPrcfORZuKv
         LFcRD98d2OPcx/pyRVYcHZNbjvfKSAjVKhbuJ9O0ugxMDvCD6hURn/ZC8JtWC4fJtOEP
         2YSfbIYo/YnDAW59syn8QfGXvg3rV8cxIb/5JWBuRpVppAkcUZfVc0nGnRCUu5wIoq15
         NQHw==
X-Forwarded-Encrypted: i=1; AJvYcCWRnWAKaf1nscVZVHPiRPwZ7/bp6mewz9u714yTuePR6NvBTsTVq0NvMHtpB9Gdshk68FsvnNVcCxWh5g7u@vger.kernel.org
X-Gm-Message-State: AOJu0YwcFTKkdDOBnKj1HHgiJCc7mNt+ZiArc7hr1rhiMo1YqqqOz8CJ
	ehMx5XnZuWGEfO1QHWc/LQNIttqZntsrdZN+0bj0CFh59osM7TDSAW3W3VO4m/va9T4=
X-Gm-Gg: ATEYQzxNnNUqEn2bJv6cKClU2XmMowmdDB7SDxbkYFOn67ZxyFyaUcIHxxDYzW0ucDT
	q0CLICF09gEvfmW185mdz0/+QAcwLdlntwk/bnWEA09oODTHXiV2mW6s89StB7wAP4VSaf1jin2
	28Zys9mcZOlO2AiTsShPQgYvaGPBA3YtgA8AdtdW5vTR12WDWo9vD1GcKWc9BoR1jFlKR7VzU6d
	QNH6ikdyAN4JV19+OEmu+i7PsHv+1g9jbtOcYwj7aeDvYKJ+TYjKEevoPofP/5761VU0OrNoh61
	QYTIYoTbZtVzS16KwcwRhhnJ8K4M9MJcoEo9FAaYpWQPEt3DujEbRcz38vIR1vfyVTF51bnVy3x
	FL4PrR8W2asG8kLbH0QiPqz4LokeA/3iyUVffKxkXiCg/2l4JtqZFhSEv/eaBW2h5XZHATtz7Zp
	yMYxqEJmjkYgJzkM7GvUTjMLUW0CcG47w2DnjEN5C/ahrRwf26UHobNlNyPggARWC8ona0MUtoY
	e1dJ52fxtTgkoQAsy72SyCUVJSLHAc=
X-Received: by 2002:a05:690c:6d81:b0:799:1fb:9a7a with SMTP id 00721157ae682-79901fba578mr24740977b3.28.1773079376767;
        Mon, 09 Mar 2026 11:02:56 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:e4e3:2aa7:b432:e03b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7990a63ff43sm2005327b3.26.2026.03.09.11.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 11:02:55 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: dhowells@redhat.com,
	pc@manguebit.org,
	netfs@lists.linux.dev
Cc: ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [PATCH] netfs: fix VM_BUG_ON_FOLIO() issue in netfs_write_begin() call
Date: Mon,  9 Mar 2026 11:02:16 -0700
Message-ID: <20260309180215.2479178-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D68D323E475
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dubeyko-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[slava@dubeyko.com,linux-fsdevel@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-79832-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[dubeyko.com];
	DKIM_TRACE(0.00)[dubeyko-com.20230601.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dubeyko-com.20230601.gappssmtp.com:dkim,dubeyko.com:mid]
X-Rspamd-Action: no action

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The multiple runs of generic/013 test-case is capable
to reproduce a kernel BUG at mm/filemap.c:1504 with
probability of 30%.

while true; do
  sudo ./check generic/013
done

[ 9849.452376] page: refcount:3 mapcount:0 mapping:00000000e58ff252 index:0x10781 pfn:0x1c322
[ 9849.452412] memcg:ffff8881a1915800
[ 9849.452417] aops:ceph_aops ino:1000058db9e dentry name(?):"f9XXXXXX"
[ 9849.452432] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[ 9849.452441] raw: 0017ffffc0000000 0000000000000000 dead000000000122 ffff88816110d248
[ 9849.452445] raw: 0000000000010781 0000000000000000 00000003ffffffff ffff8881a1915800
[ 9849.452447] page dumped because: VM_BUG_ON_FOLIO(!folio_test_locked(folio))
[ 9849.452474] ------------[ cut here ]------------
[ 9849.452476] kernel BUG at mm/filemap.c:1504!
[ 9849.478635] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
[ 9849.481772] CPU: 2 UID: 0 PID: 84223 Comm: fsstress Not tainted 7.0.0-rc1+ #18 PREEMPT(full)
[ 9849.482881] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/1
0/2025
[ 9849.484539] RIP: 0010:folio_unlock+0x85/0xa0
[ 9849.485076] Code: 89 df 31 f6 e8 1c f3 ff ff 48 8b 5d f8 c9 31 c0 31 d2 31 f6 31 ff c3 cc
cc cc cc 48 c7 c6 80 6c d9 a7 48 89 df e8 4b b3 10 00 <0f> 0b 48 89 df e8 21 e6 2c 00 eb 9d 0f 1f 40 00 66 66 2e 0f 1f 84
[ 9849.493818] RSP: 0018:ffff8881bb8076b0 EFLAGS: 00010246
[ 9849.495740] RAX: 0000000000000000 RBX: ffffea00070c8980 RCX: 0000000000000000
[ 9849.498678] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[ 9849.500559] RBP: ffff8881bb8076b8 R08: 0000000000000000 R09: 0000000000000000
[ 9849.501097] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000010782000
[ 9849.502108] R13: ffff8881935de738 R14: ffff88816110d010 R15: 0000000000001000
[ 9849.502516] FS:  00007e36cbe94740(0000) GS:ffff88824a899000(0000) knlGS:0000000000000000
[ 9849.502996] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9849.503810] CR2: 000000c0002b0000 CR3: 000000011bbf6004 CR4: 0000000000772ef0
[ 9849.504459] PKRU: 55555554
[ 9849.504626] Call Trace:
[ 9849.505242]  <TASK>
[ 9849.505379]  netfs_write_begin+0x7c8/0x10a0
[ 9849.505877]  ? __kasan_check_read+0x11/0x20
[ 9849.506384]  ? __pfx_netfs_write_begin+0x10/0x10
[ 9849.507178]  ceph_write_begin+0x8c/0x1c0
[ 9849.507934]  generic_perform_write+0x391/0x8f0
[ 9849.508503]  ? __pfx_generic_perform_write+0x10/0x10
[ 9849.509062]  ? file_update_time_flags+0x19a/0x4b0
[ 9849.509581]  ? ceph_get_caps+0x63/0xf0
[ 9849.510259]  ? ceph_get_caps+0x63/0xf0
[ 9849.510530]  ceph_write_iter+0xe79/0x1ae0
[ 9849.511282]  ? __pfx_ceph_write_iter+0x10/0x10
[ 9849.511839]  ? lock_acquire+0x1ad/0x310
[ 9849.512334]  ? ksys_write+0xf9/0x230
[ 9849.512582]  ? lock_is_held_type+0xaa/0x140
[ 9849.513128]  vfs_write+0x512/0x1110
[ 9849.513634]  ? __fget_files+0x33/0x350
[ 9849.513893]  ? __pfx_vfs_write+0x10/0x10
[ 9849.514143]  ? mutex_lock_nested+0x1b/0x30
[ 9849.514394]  ksys_write+0xf9/0x230
[ 9849.514621]  ? __pfx_ksys_write+0x10/0x10
[ 9849.514887]  ? do_syscall_64+0x25e/0x1520
[ 9849.515122]  ? __kasan_check_read+0x11/0x20
[ 9849.515366]  ? trace_hardirqs_on_prepare+0x178/0x1c0
[ 9849.515655]  __x64_sys_write+0x72/0xd0
[ 9849.515885]  ? trace_hardirqs_on+0x24/0x1c0
[ 9849.516130]  x64_sys_call+0x22f/0x2390
[ 9849.516341]  do_syscall_64+0x12b/0x1520
[ 9849.516545]  ? do_syscall_64+0x27c/0x1520
[ 9849.516783]  ? do_syscall_64+0x27c/0x1520
[ 9849.517003]  ? lock_release+0x318/0x480
[ 9849.517220]  ? __x64_sys_io_getevents+0x143/0x2d0
[ 9849.517479]  ? percpu_ref_put_many.constprop.0+0x8f/0x210
[ 9849.517779]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 9849.518073]  ? do_syscall_64+0x25e/0x1520
[ 9849.518291]  ? __kasan_check_read+0x11/0x20
[ 9849.518519]  ? trace_hardirqs_on_prepare+0x178/0x1c0
[ 9849.518799]  ? do_syscall_64+0x27c/0x1520
[ 9849.519024]  ? local_clock_noinstr+0xf/0x120
[ 9849.519262]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 9849.519544]  ? do_syscall_64+0x25e/0x1520
[ 9849.519781]  ? __kasan_check_read+0x11/0x20
[ 9849.520008]  ? trace_hardirqs_on_prepare+0x178/0x1c0
[ 9849.520273]  ? do_syscall_64+0x27c/0x1520
[ 9849.520491]  ? trace_hardirqs_on_prepare+0x178/0x1c0
[ 9849.520767]  ? irqentry_exit+0x10c/0x6c0
[ 9849.520984]  ? trace_hardirqs_off+0x86/0x1b0
[ 9849.521224]  ? exc_page_fault+0xab/0x130
[ 9849.521472]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 9849.521766] RIP: 0033:0x7e36cbd14907
[ 9849.521989] Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[ 9849.523057] RSP: 002b:00007ffff2d2a968 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[ 9849.523484] RAX: ffffffffffffffda RBX: 000000000000e549 RCX: 00007e36cbd14907
[ 9849.523885] RDX: 000000000000e549 RSI: 00005bd797ec6370 RDI: 0000000000000004
[ 9849.524277] RBP: 0000000000000004 R08: 0000000000000047 R09: 00005bd797ec6370
[ 9849.524652] R10: 0000000000000078 R11: 0000000000000246 R12: 0000000000000049
[ 9849.525062] R13: 0000000010781a37 R14: 00005bd797ec6370 R15: 0000000000000000
[ 9849.525447]  </TASK>
[ 9849.525574] Modules linked in: intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_core pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vsec kvm_intel joydev kvm irqbypass ghash_clmulni_intel aesni_intel input_leds rapl mac_hid psmouse vga16fb serio_raw vgastate floppy i2c_piix4 bochs qemu_fw_cfg i2c_smbus pata_acpi sch_fq_codel rbd msr parport_pc ppdev lp parport efi_pstore
[ 9849.529150] ---[ end trace 0000000000000000 ]---
[ 9849.529502] RIP: 0010:folio_unlock+0x85/0xa0
[ 9849.530813] Code: 89 df 31 f6 e8 1c f3 ff ff 48 8b 5d f8 c9 31 c0 31 d2 31 f6 31 ff c3 cc cc cc cc 48 c7 c6 80 6c d9 a7 48 89 df e8 4b b3 10 00 <0f> 0b 48 89 df e8 21 e6 2c 00 eb 9d 0f 1f 40 00 66 66 2e 0f 1f 84
[ 9849.534986] RSP: 0018:ffff8881bb8076b0 EFLAGS: 00010246
[ 9849.536198] RAX: 0000000000000000 RBX: ffffea00070c8980 RCX: 0000000000000000
[ 9849.537718] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[ 9849.539321] RBP: ffff8881bb8076b8 R08: 0000000000000000 R09: 0000000000000000
[ 9849.540862] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000010782000
[ 9849.542438] R13: ffff8881935de738 R14: ffff88816110d010 R15: 0000000000001000
[ 9849.543996] FS:  00007e36cbe94740(0000) GS:ffff88824b899000(0000) knlGS:0000000000000000
[ 9849.545854] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9849.547092] CR2: 00007e36cb3ff000 CR3: 000000011bbf6006 CR4: 0000000000772ef0
[ 9849.548679] PKRU: 55555554

The race sequence:
1. Read completes -> netfs_read_collection() runs
2. netfs_wake_rreq_flag(rreq, NETFS_RREQ_IN_PROGRESS, ...)
3. netfs_wait_for_read() returns -EFAULT to netfs_write_begin()
4. The netfs_unlock_abandoned_read_pages() unlocks the folio
5. netfs_write_begin() calls folio_unlock(folio) -> VM_BUG_ON_FOLIO()

The key reason of the issue that netfs_unlock_abandoned_read_pages()
doesn't check the flag NETFS_RREQ_NO_UNLOCK_FOLIO and executes
folio_unlock() unconditionally. This patch implements in
netfs_unlock_abandoned_read_pages() logic similar to
netfs_unlock_read_folio().

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 fs/netfs/read_retry.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 7793ba5e3e8f..71a0c7ed163a 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -285,8 +285,15 @@ void netfs_unlock_abandoned_read_pages(struct netfs_io_request *rreq)
 			struct folio *folio = folioq_folio(p, slot);
 
 			if (folio && !folioq_is_marked2(p, slot)) {
-				trace_netfs_folio(folio, netfs_folio_trace_abandon);
-				folio_unlock(folio);
+				if (folio->index == rreq->no_unlock_folio &&
+				    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO,
+					     &rreq->flags)) {
+					_debug("no unlock");
+				} else {
+					trace_netfs_folio(folio,
+						netfs_folio_trace_abandon);
+					folio_unlock(folio);
+				}
 			}
 		}
 	}
-- 
2.53.0


