Return-Path: <linux-fsdevel+bounces-79727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJVgOVE7rmn4AgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 04:15:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0DA2337E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 04:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63905301AAA5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 03:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89834261B9B;
	Mon,  9 Mar 2026 03:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHqFZgNE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34712868A9
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 03:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773026113; cv=pass; b=jscEZ+5bOwZdeInFL3EX7XvFCL6n2hO0mO7GzA+zq+K6uQWqwZLcg5Ldl4aVhzM57e9yzR4VnL3TA6lgFFkpJ21PZYuOhqCmWVWZboBKDJXNd2swRbVUfE6wx5U6xY/s9VQRZFeLPDrhoorLNQ0DhQKKeX8qKxuf4vqmKv8akN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773026113; c=relaxed/simple;
	bh=SZSiPj1NVyhvizWhUUC0wPEd9YxwtDfmbckRRyPoO0c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bChZQ92dopnUTGtKShDXIx1SprSI1JTBRS1HXEnSxxIclp5RsTBviKhLtCG+6rzrnmz6BJvSWlBDeALPg5lCbA7/gVLXah/+bDlBBa+dxVWfvk0tRdAVipFVIHiuL7w2LqrqmJFnhefxYVZGyXk3Tvsro86FD7onBdoxLCd9/DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHqFZgNE; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c736261ee8dso2551430a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Mar 2026 20:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773026109; cv=none;
        d=google.com; s=arc-20240605;
        b=QemNsF8Kz1+dVHwb3ztZo+Ls4DYkxA6ym3mIaVxaogjSosN8H6qBY/KiWERSJ5fnDJ
         B1R53JNzh42vOWmJ/Ylqcn414lBO78Ob7srIm7rnWTQvp0u4G83XSmyOsJQwMc51ubck
         Mp7eH6PYZu4+0XQSWN3qZtrwm2PwBVSTOrSyZT7zAu1698zMGSLHW3R/drmdCDbWCM6v
         86mCb9FuPVYsGl+8OERnrUl0bxCMbhvJO5MvviGTKthfGpnfwUDYbfQh1AeAg5+7PI3L
         SVaBoVrfw8s9/mRAA2oO8UJtvOZ7sFi1dqCCeQ7vzXMGKH2jMubq4adVyjOJuavXGkP5
         dRjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=SZSiPj1NVyhvizWhUUC0wPEd9YxwtDfmbckRRyPoO0c=;
        fh=dChIL1ummxtH44PyadLQNKi47U1fh0QesqzfuZrtvAY=;
        b=ZlIEHXwi/HsinJd/NjQuH6tQxHoupEWU8cM49xMKzynJg+C4g7iSqAoMeu10sAW9kX
         pyTq3Wvog7RcYpNxZLTY5GCP149bSMX43WwdvxqHpDT8aP2cTD/vnNi4r7RntuYyDXQK
         BhFN8Xr+fM46OpSwUxl3n9TdvbKiZ/qsz2oJp7Q7cSYfO24RyF8PTI+jvkxVL3wja0Ii
         Rs6gQywqum5rlIICjm7HOZPwk5tu2QEUWr+O84AuyR610BQsB1bn9GUmwI6HpPMMquvE
         NPLatPO+AyNQ2mav185zu3Ppu5VsJJsRZKek6H3I8mICbJBLR4u/HyTmAZ/EncwI9QP/
         7TSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773026109; x=1773630909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SZSiPj1NVyhvizWhUUC0wPEd9YxwtDfmbckRRyPoO0c=;
        b=dHqFZgNEQs5te4kW8xYyzm0XhoJQpWk0YW72SU2h9W4Cxi7BMjBin16+bRAcexVKWi
         FGU0c16KaFr3LcoxghkwkpoVBELD6evfUlBxD4LD2pejkQr20BQvvPiGrw5s8DFMKd6a
         Q6eTNEux5uD1WJz/MzqeOS7cNYGDQbCG82r1/9VgdMDT4WoZbBMU0RrDdlP+YyzknOXx
         GAh8+DhjSQ8JulYj5SMGHnvspUJ6jbRodm6iE6QFr5vJQvfPIovGDRrG9NPWv2G19DzJ
         28o5Rg8PH6GK+bXTrXqDXGLHBLJKpnTE3GG/lc4HkNQaSiXE95iJ2+hAh692r9P+8tO5
         9B/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773026109; x=1773630909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZSiPj1NVyhvizWhUUC0wPEd9YxwtDfmbckRRyPoO0c=;
        b=syF0n+hgZ5LWRKXJENH3RHPZtsfy29G/5GeF51KYNgZt4U1fCh3rOzIPgYb1IygPDd
         jL/Y9w7knpPB5Aj3VaGH+WFP9HAF5vT6Y304rBHklIIYUlKXpp9mmtqPwuC6daq1NveI
         /WmNDzPFfDpEiaO3oUo45VJrdcJ3uCFvXROO1butO21OZvXngcza0JxRyOMHDI8marNG
         hISrTyZK+5blwJfcYa6cJTQhAow2SJy68Bvadzq7TiRBiqY2rEpM6DKal9QCHgPbsa0o
         iBSzKruVaanM200+6ZVCjbfE4K5CwNsJHxbam8VI8YNWwyIShSzu/kMVlmNBzcDck0T8
         qmyg==
X-Forwarded-Encrypted: i=1; AJvYcCVSnRDxZxvME3W0S4+IpIdx7u/MJGr40S4eGbPiS7NovZJ10GYIMUaXZaHU70IGIrej3LrNk0z9obFvctNb@vger.kernel.org
X-Gm-Message-State: AOJu0YxLcI/HuV0xxijgb7PCgcvKihacvMfFyhMRgOck699XdhhWSjy/
	KB7VjbwTQWnOJWMLqnYYLTfiajhMbjWn4ponfmI0/xfVYkv+SpGmZ7qfoiDrfLMaIi6i2W/rYf6
	Mf/VVAN/ICRGoaXuxDOJMD4TMy1xzb8NbY9cFkkbvY48p
X-Gm-Gg: ATEYQzzgpTfpDovo9sqcXLOKdOgQQNWCD5noRLs0T12IA7ljW7dTIsf0rzBZ6xfkaSa
	fAG+onBRPx4AWJHGUHGMz4TwYrWfDo1HmngyAXS6D6UUmDZ2jno9tTyLVf9HypsjRYbqSVDm5Dp
	VAjcDoYacFKpt3wuf2eebD88P34jY7iboSGlN+VlYy5I+tgRTLVc6cxWdyHB9mUuQ1g014gDJgf
	dCn8BYFAsKWcpP5N7K34z8J+h52mBQ5EtXGLfcwZksmafZ/e1FNwAnCZ7KfZJwzqm9XtaVspld1
	CIgb3D0=
X-Received: by 2002:a05:6300:492:b0:398:7d6e:27f1 with SMTP id
 adf61e73a8af0-3987d6e4e98mr3093477637.9.1773026108783; Sun, 08 Mar 2026
 20:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zw Tang <shicenci@gmail.com>
Date: Mon, 9 Mar 2026 11:14:58 +0800
X-Gm-Features: AaiRm52UI71Zsv1DyyQfuTtqar8_kcar-WvI_WLGIKWrKj10BzZgSbMrapZjPpE
Message-ID: <CAPHJ_VKuMKSke8b11AZQw1PTSFN4n2C0gFxC6xGOG0ZLHgPmnA@mail.gmail.com>
Subject: [BUG] WARNING in alloc_slab_obj_exts triggered by __d_alloc
To: Vlastimil Babka <vbabka@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andreas Dilger <adilger.kernel@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6B0DA2337E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79727-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.836];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shicenci@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi,

I encountered a WARNING in alloc_slab_obj_exts() while running a
syzkaller-generated reproducer on Linux 7.0-rc2.

The warning is triggered during dentry allocation (__d_alloc) after
mounting a crafted ext4 filesystem image.

Kernel
git tree: torvalds/linux
commit=EF=BC=9A 0031c06807cfa8aa51a759ff8aa09e1aa48149af
kernel version:Linux 7.0.0-rc2-00057-g0031c06807cf
hardware: QEMU Ubuntu 24.10

I was able to reproduce this issue reliably using the attached
reproducer.

Reproducer=EF=BC=9A
C reproducer: https://pastebin.com/raw/eHjm2Aw6
console output: https://pastebin.com/raw/FQAhquTy
kernel config: pastebin.com/raw/CnHdTQNm

The warning originates from:

mm/slub.c:2189

Call trace:

WARNING: mm/slub.c:2189 at alloc_slab_obj_exts+0x132/0x180
CPU: 0 UID: 0 PID: 699 Comm: syz.0.118

Call Trace:
 <TASK>
 __memcg_slab_post_alloc_hook+0x130/0x460 mm/memcontrol.c:3234
 memcg_slab_post_alloc_hook mm/slub.c:2464 [inline]
 slab_post_alloc_hook.constprop.0+0x9c/0xf0 mm/slub.c:4526
 slab_alloc_node.constprop.0+0xaa/0x160 mm/slub.c:4844
 __do_kmalloc_node mm/slub.c:5237 [inline]
 __kmalloc_noprof+0x82/0x200 mm/slub.c:5250
 kmalloc_noprof include/linux/slab.h:954 [inline]
 __d_alloc+0x235/0x2f0 fs/dcache.c:1757
 d_alloc_pseudo+0x1d/0x70 fs/dcache.c:1871
 alloc_path_pseudo fs/file_table.c:364 [inline]
 alloc_file_pseudo+0x64/0x140 fs/file_table.c:380
 __shmem_file_setup+0x136/0x270 mm/shmem.c:5863
 memfd_alloc_file+0x81/0x240 mm/memfd.c:471
 __do_sys_memfd_create mm/memfd.c:522 [inline]
 __se_sys_memfd_create mm/memfd.c:505 [inline]
 __x64_sys_memfd_create+0x205/0x440 mm/memfd.c:505
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x11d/0x5a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

The issue happens after mounting an ext4 filesystem image via a loop
device created from a compressed image in the reproducer.

Relevant kernel messages:

EXT4-fs (loop0): mounted filesystem
00000000-0000-0000-0000-000000000000 r/w without journal.
EXT4-fs (loop3): Delayed block allocation failed for inode 18 at
logical offset 768 with max blocks 2 with error 28
EXT4-fs (loop3): This should not happen!! Data will be lost

The WARNING occurs in alloc_slab_obj_exts(), which is related to slab
object extension allocation.

This may indicate a slab metadata inconsistency triggered by the
filesystem state.

Please let me know if additional debugging information would help.

Thanks.
Zw Tang

