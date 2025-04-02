Return-Path: <linux-fsdevel+bounces-45560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06927A79700
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 23:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157783B20A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 21:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932A81F12FC;
	Wed,  2 Apr 2025 21:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBC1+Upo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5111D288DA;
	Wed,  2 Apr 2025 21:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743627742; cv=none; b=WGmSJY8JtHUaOTfE4B+cOwMff0ty/tTG+viLkH6VqgxAxFeo4FVyrr1Bm84V6FedOzV8F3k4tSH9DZp1Y0HExytuC8NqNfvEDXr48Px20u+lm4gS/LU9C9pI8SKoDJd2OvOLutFrhejJA3tkPo6a6HbhI0womFdf0Rd4ubVx8dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743627742; c=relaxed/simple;
	bh=2Gw6+EmGZ9dXPUdJNkeVng4IBOBI0JCxLKLo4CK54Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lv22YUY1ya/cMIpajNBJmazRptVdhk615o4UwrZkK8FkaWJfUHzNzG43vevC41+l07rROVOOzIONI/1fHqLf/LuhABcdgeIfiESZZPX77Z36ItROVfl/TI7Pt/Q3g9gPjEXW+v1FISo576vGY1QNsjcZUxBkGBg0d9ktPlAcvCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBC1+Upo; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39c1ee0fd43so218072f8f.0;
        Wed, 02 Apr 2025 14:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743627738; x=1744232538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IGrN/FFltZsiMZB/NzWOs/pkOG1+/TXlaHQIjn9hafc=;
        b=fBC1+UpoT/bGjE5ZidGlhl5U9TKLr9tTohTxzBgPfVvzaRdxQ4vB9S4JuHQVAMg6XI
         8iKtBMCFpD0uFyOvzu3YbZSLUDM4X6bC7e1eU3Tx1WiNeMWm4Qm+5/baXGJz78A+2kya
         kKbmZxU5eLlLzupkqp2wvD/vWbPuMM+13GZgdCwFrChzHNfdD95x7+rsyj2GufV8JCxu
         mBX9HKn2RxR+3kcVn6GDeQ522qHWKaZiA2h/cwgTyarEu3HCtceqRUfBF/KJX7kLUets
         98lnhy6f1qhfl4mChNEiHAQu6C5FOvZoDJfnOzrFhD8jghG+1Mzp82dnL9POR1Re24u/
         hrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743627738; x=1744232538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGrN/FFltZsiMZB/NzWOs/pkOG1+/TXlaHQIjn9hafc=;
        b=oLVGBr2l/A5ONBtl8aoGXmtVKOX7NNtSCkTy+/GEiyb11trzh8NdMA+tQSbI//otkP
         Iecp41ERBd53BCbs/a/Cs4is59YPaHT2Falq8fM30c2INYXbqx0KYhiN7wqI7V4i97nu
         oMmGSP85IGCDLore56fwjIGOFZZqndK2lTBq6z7FQ8gOCRVexw2RALLIsoHHEFnVB3sD
         VVDnX9o4m92KkrFAalqD2fH0n6lPe8KVfn8yCOhenzlnbuOcK+p0aWYUdp/xfoEA59pv
         EofoBz5y4HFDXGlJ2IXMDjG1Bdrobm7MWHVOj6oOX1DZYdeaKcydG/Q6ooQqKBYRQmb8
         rxpg==
X-Forwarded-Encrypted: i=1; AJvYcCUBgEKm7WBclQsV2ULqgp+Y56lntRTudQvTWuJmyfjaCBS+Hf6w5GkLDcGidQi4IrjrUvDgLQmhr9n3MemD@vger.kernel.org, AJvYcCUgkkhucXhJXE78/e/FHVUnLqsOhZHcNgXffTFbd8M7A+NEZ3sdDXZXmwHUEi9w+cxD008Z5zShUzKdUgu2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy75r1MeV3JrTI8/3/cqC14SJHC+I02JXtrifON48l6jbC7aOro
	Lghg2toGbVu5bbLzlSDQs4I5TxkzA+i+eIMrJ0+dzFWANiHwYfFl
X-Gm-Gg: ASbGncsV9BqcL/ZtEE7p5u7lugs8jxNdLs4meAFL+9Nd1qknHVb1WvvT8GEAPwUgw2i
	NgtReMq3IyfP3HKPkTfVAlWLn3GSxlMLN+ysytmDdvo7+o9rjibOmc7z/rGGvMaEtfsvO9mMYWV
	rw3j6qdfWJf9CHSf94FjQkIm3CqY4VqAZq5vgfmPtyzUCaLft3FrSr6t3wtWUMpc2+p7FB86GzT
	GMTDxp4ju80yithz/11AnOPJ2FSiZtG5ITxU7OR4e0hmaFCw7n9Zq9998xIBhSRpgXhMj5g/Fbg
	SpMMiaw7YvMjEfC/SZJFjdw9K8OdBLWrSuVqEuNx8uKYHuSwdYIJ05wewvHC+YsMqEQG
X-Google-Smtp-Source: AGHT+IEaUDgdXLMxhlxRry6jlYdO4J0UuBCmaj0A9eWu6Vs3YaKVL2E9JXee0QR5qTIaNE1+A1tkhQ==
X-Received: by 2002:a05:6000:1845:b0:39c:dfa:d347 with SMTP id ffacd0b85a97d-39c2f8c674emr92803f8f.2.1743627738359;
        Wed, 02 Apr 2025 14:02:18 -0700 (PDT)
Received: from f (cst-prg-6-220.cust.vodafone.cz. [46.135.6.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a41c0sm17610646f8f.88.2025.04.02.14.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 14:02:17 -0700 (PDT)
Date: Wed, 2 Apr 2025 23:02:09 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: syzbot <syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] kernel BUG in may_open
Message-ID: <5u3utx4wgzscgspbcpqhaj75gpg43gcmjnxfhbrjrgv6j6af3a@pbsz3qyoa2wk>
References: <67ed3fb3.050a0220.14623d.0009.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67ed3fb3.050a0220.14623d.0009.GAE@google.com>

On Wed, Apr 02, 2025 at 06:46:27AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    08733088b566 Merge tag 'rust-fixes-6.15-merge' of git://gi..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=10c8a178580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=acce2ca43d1e8c46
> dashboard link: https://syzkaller.appspot.com/bug?extid=5d8e79d323a13aa0b248
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bb094c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c2b7b0580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2ec0ad16833c/disk-08733088.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/aaa58ee04595/vmlinux-08733088.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9799f5b55d91/bzImage-08733088.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
> 
> VFS_BUG_ON_INODE(1) encountered for inode ffff888148c44000
> ------------[ cut here ]------------
> kernel BUG at fs/namei.c:3432!
> Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> CPU: 0 UID: 0 PID: 5828 Comm: syz-executor329 Not tainted 6.14.0-syzkaller-11270-g08733088b566 #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> RIP: 0010:may_open+0x450/0x460 fs/namei.c:3432
> Code: 38 c1 0f 8c 95 fe ff ff 48 89 df e8 aa 3c eb ff e9 88 fe ff ff e8 10 b3 84 ff 4c 89 ef 48 c7 c6 c0 f6 58 8c e8 81 21 05 00 90 <0f> 0b 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
> RSP: 0018:ffffc90003ce78d8 EFLAGS: 00010246
> RAX: 000000000000003a RBX: 00000000000fffff RCX: 8d133bf8e6cb7a00
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: ffffffff8ee96300 R08: ffffffff81a29bdc R09: 1ffff9200079ceb8
> R10: dffffc0000000000 R11: fffff5200079ceb9 R12: 0000000000000006
> R13: ffff888148c44000 R14: dffffc0000000000 R15: ffffc90003ce7ba0
> FS:  0000555582428380(0000) GS:ffff888124fe2000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000056466efce608 CR3: 0000000033c36000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  do_open fs/namei.c:3843 [inline]
>  path_openat+0x2b39/0x35d0 fs/namei.c:4004
>  do_filp_open+0x284/0x4e0 fs/namei.c:4031
>  do_sys_openat2+0x12b/0x1d0 fs/open.c:1429
>  do_sys_open fs/open.c:1444 [inline]
>  __do_sys_openat fs/open.c:1460 [inline]
>  __se_sys_openat fs/open.c:1455 [inline]
>  __x64_sys_openat+0x249/0x2a0 fs/open.c:1455
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

This is issuing open on bpf:

bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_DEVMAP, key_size=4, value_size=4, max_entries=3, map_flags=0,
inner_map_fd=-1, map_name="", map_ifindex=0, btf_fd=-1, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 3
openat(AT_FDCWD, "/proc/self/fd/3", O_RDWR) = ?
+++ killed by SIGSEGV +++

I verified i_mode & S_ISFMT is 0.

I don't know what expectation is, should this be some special dev
instead?

