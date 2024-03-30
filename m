Return-Path: <linux-fsdevel+bounces-15810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7C68932AA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 18:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E33E282BD4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 16:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184BA14534D;
	Sun, 31 Mar 2024 16:25:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9450B757FB;
	Sun, 31 Mar 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902309; cv=fail; b=RNTYxGTNeRo1LE8YI9O2gEJTY5J1je/yw3Pzel2rVjiNjKFy9txF+biuVey6idEMj3EIcP4UwMYf1Mi5kJJ/tcJIIPXpk0tawC3Z+11HwCxJ1TjzCZ9eqDJPYiSx7CZgernJjphqQtQUcVo+MmH245D84fafFtybqqPem/r/tpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902309; c=relaxed/simple;
	bh=esAXML7DHdxiwyFJ3iRZS4Izea43hxblUD9ErMVwPiI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rpxuvCHCPevDHNVlnpRWupVcNFyh/wVV/4JxlNgDNVgXwvRJDKlO8ncMnZUnBg7t5HHMsjF6JQ7yBTotBOegcr6qJYdjpXD38fY83WkpnomK2H2JBRgDqeeLvboy/eKBlfRQIuRig8FGtZzUEbAc7BmmAQPj437OS7kK6aRXRd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=fail smtp.mailfrom=syzkaller.appspotmail.com; arc=none smtp.client-ip=209.85.166.70; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=syzkaller.appspotmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E9A59207D1;
	Sun, 31 Mar 2024 18:25:05 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5lSHRW7xtaWL; Sun, 31 Mar 2024 18:25:05 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id E4FB820799;
	Sun, 31 Mar 2024 18:25:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com E4FB820799
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id D53C180004A;
	Sun, 31 Mar 2024 18:25:04 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:25:04 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:49 +0000
X-sender: <linux-kernel+bounces-125687-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAoNPp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgA1AAAAmYoAAAUABAAUIAEAAAAcAAAAc3RlZmZlbi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 19133
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125687-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 31AE520519
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711797212; cv=none; b=WES0ESFnVj93EkbZ0lIxabtBp11eaIb8JNwYe7iByRt6p8rJrAoOP/SL/k4jn+6HSOpVCt3xfxsWmtjYoHju1XGdqUQh6xrFhybYp4aGACJUOxfE7eUFpVv85YXCGrGmORCkd/M2/OcXZucHTEHXYZITlmr+Txco0LKkIgy4amk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711797212; c=relaxed/simple;
	bh=esAXML7DHdxiwyFJ3iRZS4Izea43hxblUD9ErMVwPiI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HUWqtkgtmmFnyKGzJx9c69xGdSOGxWHxTeGotjFZhiHzrMCxMSGz9olJi+CsDLjFLGTlKL/o3rSRCJwtomCwEuDNRoVe+KL3k/O65CQhDyhKe+Cga14cCH2XMCwgt9bqzxCsCe8sBFEp+wS2pQp2RNSNLZ/AIlEfvdat5/gqX3I=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711797210; x=1712402010;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Th/ktqkvCCzUDJYZJAFFpoB/hGLm/LGgGFQxtdAl6RU=;
        b=RFXecT8qHM4b9Ib98tk/s0G0AVyVju9KCNSt/9wqwf+FiGXh4Jk5mbqEuJajEqZTXL
         oXcD7/vykYsVdF211NAai27JCJ/4tB12fDtIbzfmJalUodZTjHXqvp0aEEGADszMcxlw
         XWFedpcOUrUKNYOCoJjmb6qICneFA+CKeigvcHUOlFElrO3OKVRFK8+wipoOUMVaKYg6
         Go2fGObv3oyHaWUAnGlnB13oA8Az0W6xfgtSJRCEXoiSqZBgN8sZWeLccCCRNEbPRwoZ
         OD/z8Nu6aeJ1Hiu7coRoFsti5V8gqpgXU8RwCYanc97aee2JvPKGHlOKDIuS3j5SFMBs
         q2dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzxRAuw1vuykvkE1eippebQTdnxPx1d2b2Ks95P+vIwri4Rsa56dTLs4Z1CH9v+tJ86lDKmgXoGeDj3ntD85RUjdT2VKr8sXj4jwbS
X-Gm-Message-State: AOJu0YyPeMXcpisf98vsicO2y47Dli0ARtiDrQ78BUMhxpwx23aQXM9X
	9dw4n+pXMnoZKkBGACTg3b16LnCC+06anrd1kSqiDN8q5Izbv6VQVNpo6TrAXzQ7R6CsNXOvR2W
	RM9pIfTAuquh/s9egFj2F+jQq0bhv37zFjpWNBATDRZUxGy69u+rhWgw=
X-Google-Smtp-Source: AGHT+IGxal1IK5WXsozmNjYHSWk6UQm4arNSNM0+XE34coPxtoa/VQPoyRHCC6IT846ZPApk7qV62yTI6SCgeH/pNAly4hRnVze8
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:858f:b0:475:2758:9f20 with SMTP id
 it15-20020a056638858f00b0047527589f20mr184172jab.1.1711797210408; Sat, 30 Mar
 2024 04:13:30 -0700 (PDT)
Date: Sat, 30 Mar 2024 04:13:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a77e580614ded85a@google.com>
Subject: [syzbot] [v9fs?] KMSAN: uninit-value in p9_client_rpc (2)
From: syzbot <syzbot+ff14db38f56329ef68df@syzkaller.appspotmail.com>
To: <asmadeus@codewreck.org>, <ericvh@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux_oss@crudebyte.com>, <lucho@ionkov.net>,
	<syzkaller-bugs@googlegroups.com>, <v9fs@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hello,

syzbot found the following issue on:

HEAD commit:    928a87efa423 Merge tag 'gfs2-v6.8-fix' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=106cc57e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2599baf258ef795
dashboard link: https://syzkaller.appspot.com/bug?extid=ff14db38f56329ef68df
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a39546180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b4aa7e180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7d66fa7ed5c7/disk-928a87ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b511d64cde0/vmlinux-928a87ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8810588440a2/bzImage-928a87ef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff14db38f56329ef68df@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in trace_9p_client_res include/trace/events/9p.h:146 [inline]
BUG: KMSAN: uninit-value in p9_client_rpc+0x1314/0x1340 net/9p/client.c:754
 trace_9p_client_res include/trace/events/9p.h:146 [inline]
 p9_client_rpc+0x1314/0x1340 net/9p/client.c:754
 p9_client_create+0x1551/0x1ff0 net/9p/client.c:1031
 v9fs_session_init+0x1b9/0x28e0 fs/9p/v9fs.c:410
 v9fs_mount+0xe2/0x12b0 fs/9p/vfs_super.c:122
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1797
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x2de/0x1400 mm/slub.c:2391
 ___slab_alloc+0x1184/0x33d0 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmem_cache_alloc+0x6d3/0xbe0 mm/slub.c:3852
 p9_tag_alloc net/9p/client.c:278 [inline]
 p9_client_prepare_req+0x20a/0x1770 net/9p/client.c:641
 p9_client_rpc+0x27e/0x1340 net/9p/client.c:688
 p9_client_create+0x1551/0x1ff0 net/9p/client.c:1031
 v9fs_session_init+0x1b9/0x28e0 fs/9p/v9fs.c:410
 v9fs_mount+0xe2/0x12b0 fs/9p/vfs_super.c:122
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1797
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

CPU: 1 PID: 5017 Comm: syz-executor353 Not tainted 6.9.0-rc1-syzkaller-00005-g928a87efa423 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


