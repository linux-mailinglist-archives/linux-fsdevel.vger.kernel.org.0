Return-Path: <linux-fsdevel+bounces-68007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1ECC506C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 04:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE6CA4E93E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 03:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDD12BE035;
	Wed, 12 Nov 2025 03:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jP7jAJmL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218712820DB
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 03:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762918638; cv=none; b=VGcL7Y9ilmL8usarc4nIshhQcyt1A7nCBshBoUhyFd7wpYwiYSTkpD0IqGF5LYKw3+zEDzgY9Euu6gGzARGV14DvTOE8MKEz1Eu6ixldp3F90JrmP/zKXuvSIl3kv/8zWH4C4aKebUkmEztSmJStQZdEStif362GHM9RBeCqXRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762918638; c=relaxed/simple;
	bh=DhBiuBHhj4QOKjeJlb0OHaTCaIWmPT1vhkfV6SR6PGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZx4VOMi5UCOfHdtRKrnTem0c1bBEmCImujY6HZhTi8B81ZMrg8O4KDYzVQ7X+uMzHX0Bxirz3UaRyc2s7g9+gJsqZEi1173tQmeQNjxE669AHL8fUpse79Cs9gRz/iJWJuUb47pwi+CTpd615O93Ed3mj1hrFaAL6+3OqzZNew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jP7jAJmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37DBC2BC87
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 03:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762918637;
	bh=DhBiuBHhj4QOKjeJlb0OHaTCaIWmPT1vhkfV6SR6PGU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jP7jAJmLr4bjyTIDz2ocjZh7/vJ7bWbVlq2zm3oopz+/0SkTvOu2P/BsonuaMfXwW
	 bWEV0SborAGcdiThKUeWjcbi/9rcg3VOD0kJ0JE2uZUvqPvSJ65MD6Ke1H1HMcNuEv
	 jcYC2M9AFRLRjRconH62QHsjmaXl3wbRe33ybNxojCsCyEY0ydiNgJPfRVLXF1CBTs
	 P+2lZ+QmJHEbv+fGXVRS6rJEEb2RCUAfcudu3PKi9mBDRPdxtRXNc2ciXDVZa++wry
	 ckKbqsUvOvWEWraLxIXXFrZSRoDgZc9O1eb5nbgcP9vtz5OXTRd9WoOSL5QQ1zgl/c
	 bIhaHfmATiINg==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6418738efa0so621573a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 19:37:17 -0800 (PST)
X-Gm-Message-State: AOJu0YxwV5hpK6hON7dU99X64QUU1ugm3eGs8wdFDLcM3fZHV1c3YeFw
	n5RuXZlp09EqDKogpAfH4qc3sCtKTbndOxjcoSA6rcP24Ss+hFyG6w2/5QDv1Y6qwuBDT9FZZPy
	sRYtIOGGAFSu2edvRcFTH8tYuwYD6+kI=
X-Google-Smtp-Source: AGHT+IHukNbNLmeiNC4vEIccYa/dou23gkyUsfB8nWcmnhRuoTXMLXEWGET38bCmXQzeDQvxqqFXs5YeigpeZJrZcew=
X-Received: by 2002:a05:6402:1e95:b0:641:27d8:ec4c with SMTP id
 4fb4d7f45d1cf-6431a4d4523mr1317030a12.16.1762918636228; Tue, 11 Nov 2025
 19:37:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <690d2bd5.a70a0220.22f260.000f.GAE@google.com>
In-Reply-To: <690d2bd5.a70a0220.22f260.000f.GAE@google.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 12 Nov 2025 12:37:03 +0900
X-Gmail-Original-Message-ID: <CAKYAXd86eFyX5sVi_5exaFJ-wGn2U16n_L1c9ouDBnFGPuH_qg@mail.gmail.com>
X-Gm-Features: AWmQ_bkDTKsFH4cIqTj1EJ1WAA5Yr-2Kv2RxgHDICiTGssV6riagZcltc37jwtM
Message-ID: <CAKYAXd86eFyX5sVi_5exaFJ-wGn2U16n_L1c9ouDBnFGPuH_qg@mail.gmail.com>
Subject: Re: [syzbot] [exfat?] WARNING in __rt_mutex_slowlock_locked (2)
To: syzbot <syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	"Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Content-Type: multipart/mixed; boundary="00000000000014fa5706435d7bf9"

--00000000000014fa5706435d7bf9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Fri, Nov 7, 2025 at 8:14=E2=80=AFAM syzbot
<syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c2c2ccfd4ba7 Merge tag 'net-6.18-rc5' of git://git.kernel=
...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D151be11458000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D41ad820f608cb=
833
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D5216036fc59c43d=
1ee02
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b797=
6-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11062a58580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16e1908458000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/121c46acc3df/dis=
k-c2c2ccfd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/eb0aef8fb7a1/vmlinu=
x-c2c2ccfd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a2bba0757aa5/b=
zImage-c2c2ccfd.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/03760a9baa=
bf/mount_0.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=3D=
12084532580000)
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com
>
> loop0: detected capacity change from 0 to 256
> exFAT-fs (loop0): start_clu is invalid cluster(0x400)
> ------------[ cut here ]------------
> rtmutex deadlock detected
> WARNING: CPU: 0 PID: 6071 at kernel/locking/rtmutex.c:1674 rt_mutex_handl=
e_deadlock kernel/locking/rtmutex.c:1674 [inline]
> WARNING: CPU: 0 PID: 6071 at kernel/locking/rtmutex.c:1674 __rt_mutex_slo=
wlock kernel/locking/rtmutex.c:1734 [inline]
> WARNING: CPU: 0 PID: 6071 at kernel/locking/rtmutex.c:1674 __rt_mutex_slo=
wlock_locked+0xed2/0x25e0 kernel/locking/rtmutex.c:1760
> Modules linked in:
> CPU: 0 UID: 0 PID: 6071 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{=
RT,(full)}
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/02/2025
> RIP: 0010:rt_mutex_handle_deadlock kernel/locking/rtmutex.c:1674 [inline]
> RIP: 0010:__rt_mutex_slowlock kernel/locking/rtmutex.c:1734 [inline]
> RIP: 0010:__rt_mutex_slowlock_locked+0xed2/0x25e0 kernel/locking/rtmutex.=
c:1760
> Code: 7c 24 20 dd 4c 8b b4 24 98 00 00 00 0f 85 fd 0a 00 00 48 8b 7c 24 1=
0 e8 4c 50 28 09 90 48 c7 c7 60 fd ea 8a e8 ef 62 e7 ff 90 <0f> 0b 90 90 48=
 8b 9c 24 80 00 00 00 43 80 3c 3e 00 74 08 4c 89 e7
> RSP: 0018:ffffc90003d87a20 EFLAGS: 00010246
> RAX: 5bae39e042a2bb00 RBX: ffff88802472e4e0 RCX: ffff88802472da00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc90003d87c10 R08: 0000000000000000 R09: 0000000000000000
> R10: dffffc0000000000 R11: ffffed101710487b R12: ffff88802472f160
> R13: ffff88802472da18 R14: 1ffff110048e5e2c R15: dffffc0000000000
> FS:  00005555931b8500(0000) GS:ffff888126df9000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffefdd79178 CR3: 000000003e14c000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  rt_mutex_slowlock+0xb5/0x160 kernel/locking/rtmutex.c:1800
>  __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
>  rwbase_write_lock+0x14f/0x750 kernel/locking/rwbase_rt.c:244
>  inode_lock include/linux/fs.h:980 [inline]
>  vfs_rmdir+0xf7/0x520 fs/namei.c:4537
>  do_rmdir+0x25f/0x550 fs/namei.c:4603
>  __do_sys_unlinkat fs/namei.c:4777 [inline]
>  __se_sys_unlinkat fs/namei.c:4771 [inline]
>  __x64_sys_unlinkat+0xc2/0xf0 fs/namei.c:4771
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f03a63ff6c9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd1d6ca228 EFLAGS: 00000246 ORIG_RAX: 0000000000000107
> RAX: ffffffffffffffda RBX: 00007f03a6655fa0 RCX: 00007f03a63ff6c9
> RDX: 0000000000000200 RSI: 0000200000000040 RDI: 0000000000000006
> RBP: 00007f03a6481f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f03a6655fa0 R14: 00007f03a6655fa0 R15: 0000000000000003
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

--00000000000014fa5706435d7bf9
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-exfat-validate-the-cluster-bitmap-bits-of-directory.patch"
Content-Disposition: attachment; 
	filename="0001-exfat-validate-the-cluster-bitmap-bits-of-directory.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mhvg7w4k0>
X-Attachment-Id: f_mhvg7w4k0

RnJvbSBkYTUzNjY1YWUzODA4MDk0MjdhYWU5ZGY3MmQ5NzMzNDVhM2RlN2FiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPgpE
YXRlOiBXZWQsIDEyIE5vdiAyMDI1IDA5OjQyOjI1ICswOTAwClN1YmplY3Q6IFtQQVRDSF0gZXhm
YXQ6IHZhbGlkYXRlIHRoZSBjbHVzdGVyIGJpdG1hcCBiaXRzIG9mIGRpcmVjdG9yeQoKU3l6Ym90
IGNyZWF0ZWQgdGhpcyBpc3N1ZSBieSB0ZXN0aW5nIGFuIGltYWdlIHRoYXQgZGlkIG5vdCBoYXZl
IHRoZSByb290CmNsdXN0ZXIgYml0bWFwIGJpdCBtYXJrZWQuIEFmdGVyIGFjY2Vzc2luZyBhIGZp
bGUgdGhyb3VnaCB0aGUgcm9vdApkaXJlY3RvcnkgdmlhIGV4ZmF0X2xvb2t1cCwgd2hlbiBjcmVh
dGluZyBhIGZpbGUgYWdhaW4gd2l0aCBta2RpciwKdGhlIHJvb3QgY2x1c3RlciBiaXQgY2FuIGJl
IGFsbG9jYXRlZCBmb3IgZGlyZWNvdHJ5LCB3aGljaCBjYW4gY2F1c2UKdGhlIHJvb3QgY2x1c3Rl
ciB0byBiZSB6ZXJvZWQgb3V0IGFuZCB0aGUgc2FtZSBlbnRyeSBjYW4gYmUgYWxsb2NhdGVkCmlu
IHRoZSBzYW1lIGNsdXN0ZXIuIFRoaXMgcGF0Y2ggaW1wcm92ZWQgdGhpcyBpc3N1ZSBieSBhZGRp
bmcKZXhmYXRfdGVzdF9iaXRtYXAgdG8gdmFsaWRhdGUgdGhlIGNsdXN0ZXIgYml0cyBvZiB0aGUg
cm9vdCBkaXJlY3RvcnkKYW5kIGRpcmVjdG9yeS4gQW5kIHRoZSBmaXJzdCBjbHVzdGVyIGJpdCBv
ZiB0aGUgcm9vdCBkaXJlY3Rvcnkgc2hvdWxkCm5ldmVyIGJlIHVuc2V0IGV4Y2VwdCB3aGVuIHN0
b3JhZ2UgaXMgY29ycnVwdGVkLiBUaGlzIGJpdCBpcyBzZXQgdG8KYWxsb3cgb3BlcmF0aW9ucyBh
ZnRlciBtb3VudC4KClJldmlld2VkLWJ5OiBTdW5nam9uZyBTZW8gPHNqMTU1Ny5zZW9Ac2Ftc3Vu
Zy5jb20+ClJldmlld2VkLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+ClNp
Z25lZC1vZmYtYnk6IE5hbWphZSBKZW9uIDxsaW5raW5qZW9uQGtlcm5lbC5vcmc+Ci0tLQogZnMv
ZXhmYXQvYmFsbG9jLmMgICB8IDI4ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0KIGZzL2V4
ZmF0L2Rpci5jICAgICAgfCAgNSArKysrKwogZnMvZXhmYXQvZXhmYXRfZnMuaCB8ICA1ICsrKy0t
CiBmcy9leGZhdC9mYXRlbnQuYyAgIHwgIDYgKysrLS0tCiBmcy9leGZhdC9zdXBlci5jICAgIHwg
MTEgKysrKysrKysrKysKIDUgZmlsZXMgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKSwgOSBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9leGZhdC9iYWxsb2MuYyBiL2ZzL2V4ZmF0L2JhbGxv
Yy5jCmluZGV4IDJkMmQ1MTBmMjM3Mi4uYjM4N2JmN2RmNjVlIDEwMDY0NAotLS0gYS9mcy9leGZh
dC9iYWxsb2MuYworKysgYi9mcy9leGZhdC9iYWxsb2MuYwpAQCAtMTgzLDExICsxODMsMTAgQEAg
dm9pZCBleGZhdF9mcmVlX2JpdG1hcChzdHJ1Y3QgZXhmYXRfc2JfaW5mbyAqc2JpKQogCWt2ZnJl
ZShzYmktPnZvbF9hbWFwKTsKIH0KIAotaW50IGV4ZmF0X3NldF9iaXRtYXAoc3RydWN0IGlub2Rl
ICppbm9kZSwgdW5zaWduZWQgaW50IGNsdSwgYm9vbCBzeW5jKQoraW50IGV4ZmF0X3NldF9iaXRt
YXAoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgdW5zaWduZWQgaW50IGNsdSwgYm9vbCBzeW5jKQog
ewogCWludCBpLCBiOwogCXVuc2lnbmVkIGludCBlbnRfaWR4OwotCXN0cnVjdCBzdXBlcl9ibG9j
ayAqc2IgPSBpbm9kZS0+aV9zYjsKIAlzdHJ1Y3QgZXhmYXRfc2JfaW5mbyAqc2JpID0gRVhGQVRf
U0Ioc2IpOwogCiAJaWYgKCFpc192YWxpZF9jbHVzdGVyKHNiaSwgY2x1KSkKQEAgLTIwMiwxMSAr
MjAxLDEwIEBAIGludCBleGZhdF9zZXRfYml0bWFwKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHVuc2ln
bmVkIGludCBjbHUsIGJvb2wgc3luYykKIAlyZXR1cm4gMDsKIH0KIAotaW50IGV4ZmF0X2NsZWFy
X2JpdG1hcChzdHJ1Y3QgaW5vZGUgKmlub2RlLCB1bnNpZ25lZCBpbnQgY2x1LCBib29sIHN5bmMp
CitpbnQgZXhmYXRfY2xlYXJfYml0bWFwKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHVuc2lnbmVk
IGludCBjbHUsIGJvb2wgc3luYykKIHsKIAlpbnQgaSwgYjsKIAl1bnNpZ25lZCBpbnQgZW50X2lk
eDsKLQlzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiID0gaW5vZGUtPmlfc2I7CiAJc3RydWN0IGV4ZmF0
X3NiX2luZm8gKnNiaSA9IEVYRkFUX1NCKHNiKTsKIAogCWlmICghaXNfdmFsaWRfY2x1c3Rlcihz
YmksIGNsdSkpCkBAIC0yMjYsNiArMjI0LDI4IEBAIGludCBleGZhdF9jbGVhcl9iaXRtYXAoc3Ry
dWN0IGlub2RlICppbm9kZSwgdW5zaWduZWQgaW50IGNsdSwgYm9vbCBzeW5jKQogCXJldHVybiAw
OwogfQogCitib29sIGV4ZmF0X3Rlc3RfYml0bWFwKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHVu
c2lnbmVkIGludCBjbHUpCit7CisJaW50IGksIGI7CisJdW5zaWduZWQgaW50IGVudF9pZHg7CisJ
c3RydWN0IGV4ZmF0X3NiX2luZm8gKnNiaSA9IEVYRkFUX1NCKHNiKTsKKworCWlmICghc2JpLT52
b2xfYW1hcCkKKwkJcmV0dXJuIHRydWU7CisKKwlpZiAoIWlzX3ZhbGlkX2NsdXN0ZXIoc2JpLCBj
bHUpKQorCQlyZXR1cm4gZmFsc2U7CisKKwllbnRfaWR4ID0gQ0xVU1RFUl9UT19CSVRNQVBfRU5U
KGNsdSk7CisJaSA9IEJJVE1BUF9PRkZTRVRfU0VDVE9SX0lOREVYKHNiLCBlbnRfaWR4KTsKKwli
ID0gQklUTUFQX09GRlNFVF9CSVRfSU5fU0VDVE9SKHNiLCBlbnRfaWR4KTsKKworCWlmICghdGVz
dF9iaXRfbGUoYiwgc2JpLT52b2xfYW1hcFtpXS0+Yl9kYXRhKSkKKwkJcmV0dXJuIGZhbHNlOwor
CisJcmV0dXJuIHRydWU7Cit9CisKIC8qCiAgKiBJZiB0aGUgdmFsdWUgb2YgImNsdSIgaXMgMCwg
aXQgbWVhbnMgY2x1c3RlciAyIHdoaWNoIGlzIHRoZSBmaXJzdCBjbHVzdGVyIG9mCiAgKiB0aGUg
Y2x1c3RlciBoZWFwLgpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZGlyLmMgYi9mcy9leGZhdC9kaXIu
YwppbmRleCA3MjI5MTQ2ZmUyYmYuLjMwNDVhNThlMTI0YSAxMDA2NDQKLS0tIGEvZnMvZXhmYXQv
ZGlyLmMKKysrIGIvZnMvZXhmYXQvZGlyLmMKQEAgLTYwNCw2ICs2MDQsMTEgQEAgc3RhdGljIGlu
dCBleGZhdF9maW5kX2xvY2F0aW9uKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBleGZh
dF9jaGFpbiAqcF9kaXIKIAlpZiAocmV0KQogCQlyZXR1cm4gcmV0OwogCisJaWYgKCFleGZhdF90
ZXN0X2JpdG1hcChzYiwgY2x1KSkgeworCQlleGZhdF9lcnIoc2IsICJmYWlsZWQgdG8gdGVzdCBj
bHVzdGVyIGJpdCgldSkiLCBjbHUpOworCQlyZXR1cm4gLUVJTzsKKwl9CisKIAkvKiBieXRlIG9m
ZnNldCBpbiBjbHVzdGVyICovCiAJb2ZmID0gRVhGQVRfQ0xVX09GRlNFVChvZmYsIHNiaSk7CiAK
ZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmggYi9mcy9leGZhdC9leGZhdF9mcy5oCmlu
ZGV4IDM4MjEwZmI2OTAxYy4uMTc2ZmVmNjI1NzRjIDEwMDY0NAotLS0gYS9mcy9leGZhdC9leGZh
dF9mcy5oCisrKyBiL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgKQEAgLTQ1Miw4ICs0NTIsOSBAQCBpbnQg
ZXhmYXRfY291bnRfbnVtX2NsdXN0ZXJzKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsCiAvKiBiYWxs
b2MuYyAqLwogaW50IGV4ZmF0X2xvYWRfYml0bWFwKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IpOwog
dm9pZCBleGZhdF9mcmVlX2JpdG1hcChzdHJ1Y3QgZXhmYXRfc2JfaW5mbyAqc2JpKTsKLWludCBl
eGZhdF9zZXRfYml0bWFwKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHVuc2lnbmVkIGludCBjbHUsIGJv
b2wgc3luYyk7Ci1pbnQgZXhmYXRfY2xlYXJfYml0bWFwKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHVu
c2lnbmVkIGludCBjbHUsIGJvb2wgc3luYyk7CitpbnQgZXhmYXRfc2V0X2JpdG1hcChzdHJ1Y3Qg
c3VwZXJfYmxvY2sgKnNiLCB1bnNpZ25lZCBpbnQgY2x1LCBib29sIHN5bmMpOworaW50IGV4ZmF0
X2NsZWFyX2JpdG1hcChzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCB1bnNpZ25lZCBpbnQgY2x1LCBi
b29sIHN5bmMpOworYm9vbCBleGZhdF90ZXN0X2JpdG1hcChzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNi
LCB1bnNpZ25lZCBpbnQgY2x1KTsKIHVuc2lnbmVkIGludCBleGZhdF9maW5kX2ZyZWVfYml0bWFw
KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHVuc2lnbmVkIGludCBjbHUpOwogaW50IGV4ZmF0X2Nv
dW50X3VzZWRfY2x1c3RlcnMoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgdW5zaWduZWQgaW50ICpy
ZXRfY291bnQpOwogaW50IGV4ZmF0X3RyaW1fZnMoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0
IGZzdHJpbV9yYW5nZSAqcmFuZ2UpOwpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZmF0ZW50LmMgYi9m
cy9leGZhdC9mYXRlbnQuYwppbmRleCA4MjUwODM2MzRiYTIuLmM5YzVmMmUzYTA1ZSAxMDA2NDQK
LS0tIGEvZnMvZXhmYXQvZmF0ZW50LmMKKysrIGIvZnMvZXhmYXQvZmF0ZW50LmMKQEAgLTIwNSw3
ICsyMDUsNyBAQCBzdGF0aWMgaW50IF9fZXhmYXRfZnJlZV9jbHVzdGVyKHN0cnVjdCBpbm9kZSAq
aW5vZGUsIHN0cnVjdCBleGZhdF9jaGFpbiAqcF9jaGFpbgogCQkJCWN1cl9jbWFwX2kgPSBuZXh0
X2NtYXBfaTsKIAkJCX0KIAotCQkJZXJyID0gZXhmYXRfY2xlYXJfYml0bWFwKGlub2RlLCBjbHUs
IChzeW5jICYmIElTX0RJUlNZTkMoaW5vZGUpKSk7CisJCQllcnIgPSBleGZhdF9jbGVhcl9iaXRt
YXAoc2IsIGNsdSwgKHN5bmMgJiYgSVNfRElSU1lOQyhpbm9kZSkpKTsKIAkJCWlmIChlcnIpCiAJ
CQkJYnJlYWs7CiAJCQljbHUrKzsKQEAgLTIzMyw3ICsyMzMsNyBAQCBzdGF0aWMgaW50IF9fZXhm
YXRfZnJlZV9jbHVzdGVyKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBleGZhdF9jaGFpbiAq
cF9jaGFpbgogCQkJCWN1cl9jbWFwX2kgPSBuZXh0X2NtYXBfaTsKIAkJCX0KIAotCQkJaWYgKGV4
ZmF0X2NsZWFyX2JpdG1hcChpbm9kZSwgY2x1LCAoc3luYyAmJiBJU19ESVJTWU5DKGlub2RlKSkp
KQorCQkJaWYgKGV4ZmF0X2NsZWFyX2JpdG1hcChzYiwgY2x1LCAoc3luYyAmJiBJU19ESVJTWU5D
KGlub2RlKSkpKQogCQkJCWJyZWFrOwogCiAJCQlpZiAoc2JpLT5vcHRpb25zLmRpc2NhcmQpIHsK
QEAgLTQwOSw3ICs0MDksNyBAQCBpbnQgZXhmYXRfYWxsb2NfY2x1c3RlcihzdHJ1Y3QgaW5vZGUg
Kmlub2RlLCB1bnNpZ25lZCBpbnQgbnVtX2FsbG9jLAogCQl9CiAKIAkJLyogdXBkYXRlIGFsbG9j
YXRpb24gYml0bWFwICovCi0JCWlmIChleGZhdF9zZXRfYml0bWFwKGlub2RlLCBuZXdfY2x1LCBz
eW5jX2JtYXApKSB7CisJCWlmIChleGZhdF9zZXRfYml0bWFwKHNiLCBuZXdfY2x1LCBzeW5jX2Jt
YXApKSB7CiAJCQlyZXQgPSAtRUlPOwogCQkJZ290byBmcmVlX2NsdXN0ZXI7CiAJCX0KZGlmZiAt
LWdpdCBhL2ZzL2V4ZmF0L3N1cGVyLmMgYi9mcy9leGZhdC9zdXBlci5jCmluZGV4IDdmOTU5Mjg1
NmJmNy4uZTQ0MGFiNmI1NTYyIDEwMDY0NAotLS0gYS9mcy9leGZhdC9zdXBlci5jCisrKyBiL2Zz
L2V4ZmF0L3N1cGVyLmMKQEAgLTYyNiw2ICs2MjYsMTcgQEAgc3RhdGljIGludCBfX2V4ZmF0X2Zp
bGxfc3VwZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwKIAkJZ290byBmcmVlX2JoOwogCX0KIAor
CWlmICghZXhmYXRfdGVzdF9iaXRtYXAoc2IsIHNiaS0+cm9vdF9kaXIpKSB7CisJCWV4ZmF0X3dh
cm4oc2IsICJmYWlsZWQgdG8gdGVzdCBmaXJzdCBjbHVzdGVyIGJpdCBvZiByb290IGRpcigldSki
LAorCQkJICAgc2JpLT5yb290X2Rpcik7CisJCS8qCisJCSAqIFRoZSBmaXJzdCBjbHVzdGVyIGJp
dCBvZiB0aGUgcm9vdCBkaXJlY3Rvcnkgc2hvdWxkIG5ldmVyCisJCSAqIGJlIHVuc2V0IGV4Y2Vw
dCB3aGVuIHN0b3JhZ2UgaXMgY29ycnVwdGVkLiBUaGlzIGJpdCBpcworCQkgKiBzZXQgdG8gYWxs
b3cgb3BlcmF0aW9ucyBhZnRlciBtb3VudC4KKwkJICovCisJCWV4ZmF0X3NldF9iaXRtYXAoc2Is
IHNiaS0+cm9vdF9kaXIsIGZhbHNlKTsKKwl9CisKIAlyZXQgPSBleGZhdF9jb3VudF91c2VkX2Ns
dXN0ZXJzKHNiLCAmc2JpLT51c2VkX2NsdXN0ZXJzKTsKIAlpZiAocmV0KSB7CiAJCWV4ZmF0X2Vy
cihzYiwgImZhaWxlZCB0byBzY2FuIGNsdXN0ZXJzIik7Ci0tIAoyLjI1LjEKCg==
--00000000000014fa5706435d7bf9--

