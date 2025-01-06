Return-Path: <linux-fsdevel+bounces-38411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C42A0210D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 09:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D883A13BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 08:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A056B1D86CE;
	Mon,  6 Jan 2025 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="LHz7te1P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A2B1D6DB7;
	Mon,  6 Jan 2025 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736153223; cv=none; b=oTn7qNGv8w1AqowR1Qt2MetHSJ68ZqYY+Vlb18/4bjFkxazsYo2ixW/qnLDbTyoMG8nNj90ev9RHfcUucz3PsIQ4CkTx9X6HaSuqUJcWv2ulDCEDj1xCS6XWnHiYEe4Bc/c8D0BIgm+ZKeI4OeN+QQs88hgZ4I4rZTCuGn8ZKSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736153223; c=relaxed/simple;
	bh=bdwCJaRc0NhIN1eujVEj5S0ccizl5OwLSYPkifa2ZA4=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=rmey8UCLvl1/YUUXxYT6MtiZWjYjnH2+IkhXfbBpumSOZAeC2j7rT8eBz9KZaCQho3egH6NbKT4ugzK7dn19qq4+AG+GXI+kUThiH2UW6QEEKVMIoDIGvCdvpyub5ZfKhdpxI++n7kvetGEQqmD1oPZlbDLngrLWivcTXQkxQFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=LHz7te1P; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1736153156;
	bh=vsblgSXFXopivgIx3Vxd57llgSHm0A2faMT7+RjvGPA=;
	h=From:Mime-Version:Subject:Message-Id:Date:To;
	b=LHz7te1P0pY0Zh8M7qTG4bbg4IuP8MLhPqqFNtE5zLdLLPAmRzyK4tKO/KRbHsp5U
	 ugyxgqF207zGN/XPz1z/1ZbvBE56yBc/Q3QLzSumiyDSyaAj629vIvDz9qC7J35raY
	 OAyh1gcVQ1mkbyUnClAgv7SWjrfIMCzHxmeG3bXo=
X-QQ-mid: bizesmtpip2t1736153149t5wqwvj
X-QQ-Originating-IP: W66C8zQJ8jPXc/Fjbxcpn73EUWC3z4FZgQ0XVUpQRY4=
Received: from smtpclient.apple ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 06 Jan 2025 16:45:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7965384316647114918
From: Kun Hu <huk23@m.fudan.edu.cn>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Bug: soft lockup in exfat_clear_bitmap
Message-Id: <8F76A19F-2EFD-4DD4-A4B1-9F5C644B69EA@m.fudan.edu.cn>
Date: Mon, 6 Jan 2025 16:45:37 +0800
Cc: linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>
To: linkinjeon@kernel.org,
 sj1557.seo@samsung.com,
 yuezhang.mo@sony.com
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M6mCw2Ve0qEm0tKhfntmoQJQ/tk09aH2nHBYKfaB53rcvL0nk7Sjh23R
	+Qvemvb6/idf4bijUHiBRiGMaVcDEpQIV6Qa9Cz/AoqNSj1PefhRhQt4IloDbSjy4leoavo
	0cTBRdNqVjOlomKt2A6+pUZEVxaN46mXqz29FWkO8bnHzWqeXdPCWS1I4H45ca+iUa123V3
	l3Rg7dssme/UvYjzeSUsB0nPukYzF6Blp+MAiGMgF4X+HM1BXdxMxgyXVZfvZvvDCDVvD++
	rdLPhnv/yqKlI6j8pq4jPWPBAN2OS/YPimujb+YMU+22hooJanKzg4pQM11t1mPqQFqvSmy
	I8ANuMHGk+xyfQeXAriRIIJ0kg6umS0XeUt6dVSiZ1SrLMplPssf0tjsvO6M+bsotE4lnzG
	P49iPrYPzSDZPoFxL6yBAcl4Tpr6Yd3SASFyoxYcI427KxJAMWcAYcR7bS0caTGxP59VG/g
	cli9gowVI3yjzaQ7UtyoCIS92pAc2vNUxvw+udjadGLXGIrH+uzHz62vfAJwMxifm2pLfC5
	/7EYEaQKrfKjZmYGkew6ianUYv7Dn2uaY9m4SDl9rwPpSMgjUyKOaWk9EnCnJOpGdM+Vj/G
	VZdqA2Ha8rrJmJwKHWLvxHlPm1DvHB2dmwmrGhOZMBruw/E+6sl5AMNpgUHJGt/210XoBSJ
	/dTkUiaOpHXJXjQRpJZZzAjKspQy9tzvkfbfyIfdqzz07OZUptySH4wRWFPLS3AkO55SUKG
	nWwo2N1bntupae2e1qMWvfCGFmTQKFe8ARLthJ4Fj738VQM5HfvsG81KEKWruYj6qtrXy13
	PGjrFjA7RZ71LfwUjb7qyACcn1fAQADrNkWrgnUsC2x9bwx6hwxectMQi8enCaYc/NMMjsb
	r0+w+FPo05xr+X8Dpf2UM1gQMw13kLz1jMQpmPLKjsmEegvhkB1FZsqN5cQRZz/hWU2PUPK
	Yva1X+L07U8/qypGmQfUYFSbilp3qXXj0AXPtgoIeggAM3sWO8Pz0LTrNqlbadXUKuWVIVE
	dCkraXwA==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Hello,

When using our customized fuzzer tool to fuzz the latest Linux kernel, =
the following crash
was triggered.

HEAD commit: fc033cf25e612e840e545f8d5ad2edd6ba613ed5
git tree: upstream
Console output: =
https://drive.google.com/file/d/1aWtDTAUFlAzvMI7YM_TLWbfbyqKFB71i/view?usp=
=3Ddrive_link
Kernel config: =
https://drive.google.com/file/d/1n2sLNg-YcIgZqhhQqyMPTDWM_N1Pqz73/view?usp=
=3Dsharing
C reproducer: =
https://drive.google.com/file/d/1oXFZgdxZDCrcZTmyatmI6TeYoHCaIxEA/view?usp=
=3Ddrive_link
Syzlang reproducer: =
https://drive.google.com/file/d/1KX9cnANDRzXZ1FjKl3uv6rSFC-5kLsko/view?usp=
=3Dsharing


If you fix this issue, please add the following tag to the commit:
Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin =
<jjtan24@m.fudan.edu.cn>

watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [syz-executor140:420]
Modules linked in:
irq event stamp: 163590
hardirqs last  enabled at (163589): [<ffffffff9c4d07eb>] =
irqentry_exit+0x3b/0x90 kernel/entry/common.c:357
hardirqs last disabled at (163590): [<ffffffff9c4cedbf>] =
sysvec_apic_timer_interrupt+0xf/0xb0 arch/x86/kernel/apic/apic.c:1049
softirqs last  enabled at (163576): [<ffffffff9450f554>] =
softirq_handle_end kernel/softirq.c:407 [inline]
softirqs last  enabled at (163576): [<ffffffff9450f554>] =
handle_softirqs+0x544/0x870 kernel/softirq.c:589
softirqs last disabled at (163555): [<ffffffff9451120e>] __do_softirq =
kernel/softirq.c:595 [inline]
softirqs last disabled at (163555): [<ffffffff9451120e>] invoke_softirq =
kernel/softirq.c:435 [inline]
softirqs last disabled at (163555): [<ffffffff9451120e>] __irq_exit_rcu =
kernel/softirq.c:662 [inline]
softirqs last disabled at (163555): [<ffffffff9451120e>] =
irq_exit_rcu+0xee/0x140 kernel/softirq.c:678
CPU: 1 UID: 0 PID: 420 Comm: syz-executor140 Not tainted 6.13.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:exfat_clear_bitmap+0x3f1/0x580 fs/exfat/balloc.c:174
Code: 24 60 01 00 00 b9 40 0c 00 00 4c 89 fa e8 57 10 ff 01 bf a1 ff ff =
ff 89 c3 89 c6 e8 49 52 5f ff 83 fb a1 74 13 48 83 c4 18 5b <5d> 41 5c =
41 5d 41 5e 41 5f e9 01 50 5f ff e8 fc 4f 5f ff 49 8d b4
RSP: 0018:ffa00000035f7a90 EFLAGS: 00000286
RAX: 0000000000000000 RBX: 0000000000006ccc RCX: ffffffff952a4d03
RDX: 0000000000000011 RSI: ff110000118ba340 RDI: 0000000000000003
RBP: ff110000131cc000 R08: 0000000000000000 R09: fffffbfff4d5f0ed
R10: fffffbfff4d5f0ec R11: 0000000000000001 R12: ff110000131ce000
R13: 0000000000000011 R14: 0000000000000000 R15: 0000000006cccf6b
FS:  000055556ed2d880(0000) GS:ff11000053a80000(0000) =
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe1b6fdd18 CR3: 000000000db32002 CR4: 0000000000771ef0
PKRU: 55555554
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 __exfat_free_cluster+0x775/0x980 fs/exfat/fatent.c:192
 exfat_free_cluster+0x7a/0x100 fs/exfat/fatent.c:232
 __exfat_truncate+0x6bf/0x900 fs/exfat/file.c:235
 exfat_evict_inode+0x10d/0x1a0 fs/exfat/inode.c:683
 evict+0x403/0x880 fs/inode.c:796
 iput_final fs/inode.c:1946 [inline]
 iput fs/inode.c:1972 [inline]
 iput+0x51c/0x830 fs/inode.c:1958
 do_unlinkat+0x5c7/0x750 fs/namei.c:4594
 __do_sys_unlink fs/namei.c:4635 [inline]
 __se_sys_unlink fs/namei.c:4633 [inline]
 __x64_sys_unlink+0x40/0x50 fs/namei.c:4633
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff5d82fb1db
Code: 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e =
0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 57 00 00 00 0f 05 <48> 3d 01 =
f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe1b6ff558 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff5d82fb1db
RDX: 00007ffe1b6ff580 RSI: 00007ffe1b6ff580 RDI: 00007ffe1b6ff610
RBP: 00007ffe1b6ff610 R08: 0000000000000001 R09: 00007ffe1b6ff3e0
R10: 00000000fffffff7 R11: 0000000000000206 R12: 00007ffe1b700710
R13: 000055556ed36bb0 R14: 00007ffe1b6ff578 R15: 0000000000000001
 </TASK>


---------------
thanks,
Kun Hu=

