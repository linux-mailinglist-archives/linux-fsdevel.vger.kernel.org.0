Return-Path: <linux-fsdevel+bounces-61673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C090B58C59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 05:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106B916B9EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1D8262FE9;
	Tue, 16 Sep 2025 03:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2glzSgGg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1195825A2C9
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 03:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757993289; cv=none; b=hG6bIS8QXCGAVoe7qiGHg3YaaucqmQTVMrzp5RPJy2QjT8GduehedCAdUe7obm9zXptUGIH7KcYZHOpmhhQbGV4AzmnvhRXZoacc/pD7mcRybVuO//lSxDjdri6d8sPQwIRiklCSZlxwIe3WbDocZ/daj2giGbn7eXx5D0U2Cgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757993289; c=relaxed/simple;
	bh=DF/QcwnHUaAwpS9JBDkkttxn/peoZcu8Xdye0uAT9Hk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AGYZ1nHRNPL1FgPaxrarmoLxTyWkyG/petVyD05Dq54B/ph8GX+Ng1kMGTNz2dl6CwIH1yA+vua1pNPhCZyak4zUN5KCjyAUsZwf7TtyuSKi3/gE+KLql1faed/pQOifHzjpX1Wx2+y6TkEstfc7rmWqwyd+LO2u77oPmiZP9aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2glzSgGg; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b522037281bso3448567a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 20:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757993287; x=1758598087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FGLtV5R5S2zyNcCBEbvma/kC8/hOyGX9SiQiXwZ5GwA=;
        b=2glzSgGgNrYbDFWLP1rylJHAIy8Q38tDNSPKiViwyESqtE6s8IWevEWrkGgwflZUM5
         5COcHzBXdKOKCdSgfVL6pofkoeZvX8ehimE3sCgyoqcmWljPwUr6xpGZWi9afrm2gJpv
         y4WOJ3La15vpO39fWLWQ2HiGZ2Wgqe/PpPVnltUjxmLrN+EfSIgsYspWulPNiEL7zmhT
         PQ4rCejwYJsQXNqJIY8tOQ9PErAZLp40/GBSCTd/uuXwPoYZED4/hPbG/JYjrU1jvoAJ
         du89Wkkx4mpcpbR4jPXSrsDDvzWGAAr1TuCGoBfvp/PXSyXBc7wOToe5Lf/mOFvnfWfh
         SntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757993287; x=1758598087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGLtV5R5S2zyNcCBEbvma/kC8/hOyGX9SiQiXwZ5GwA=;
        b=ABu3IdfckkeN7Sb5BAiGm/+Q/SDOfgCH6rWEoHTVcyIek9dG03HpDMRzhK6ccPXLFc
         KXTXj9X9Ib89qiMzEjuBaK40VojeMom0TC3PSRn2kwUuZjHRktZeU2HPumiL1yDcnKs/
         x5SCyr3/zXuV5qFEgVCsHL6TvIOVbGFBLaxfmdqPIHfuli8Z8b2Am04ht0KlrUchEXIx
         m1giiIU/2VFHF+g+5oDLOwcYFFWKEZ/qqfqe3rhiwk7JL9BjcAuFLqPlpNOCRtRtP4ec
         YTQAZt/nP8hyd92GJWN6ORhTeGpWvRnAxQ7fINM2NwcYZyPebUQR2+HIVv1qH26s+zr6
         Wvww==
X-Forwarded-Encrypted: i=1; AJvYcCWOLCaV4Mj9oHFtvNig3zHtHeFkoVGXg1pLMhlQB2+u5uMfXSGm/GH+4SO9ICb0aOJxSdPRJBvUC/xVpCz+@vger.kernel.org
X-Gm-Message-State: AOJu0YyGttCRxLieYorpfhI7jwV2OxYuN67/FwGBgaBpRvADVDffb/AE
	hHQgv7+khNer69g/dgAeL71fQEwn7m4kKrvkswigF/Pb/GsvRAMtkP+Vb900QU8pD1f9nTq+2ZY
	eqm7OkQ==
X-Google-Smtp-Source: AGHT+IHV+3Xcxct6+V3hyeQUqL1wIhdcrFd3uuOM+An7NvmjsxgNzv+BcgjP+qm72BHySGTu9uR39srp30s=
X-Received: from pjbdy13.prod.google.com ([2002:a17:90b:6cd:b0:32e:3552:8c77])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9146:b0:246:1c:488
 with SMTP id adf61e73a8af0-2602d00ecabmr19434254637.53.1757993287434; Mon, 15
 Sep 2025 20:28:07 -0700 (PDT)
Date: Tue, 16 Sep 2025 03:24:07 +0000
In-Reply-To: <20250912-work-namespace-v2-18-1a247645cef5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912-work-namespace-v2-18-1a247645cef5@kernel.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916032806.310477-1-kuniyu@google.com>
Subject: Re: [PATCH v2 18/33] mnt: support ns lookup
From: Kuniyuki Iwashima <kuniyu@google.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com, axboe@kernel.dk, cgroups@vger.kernel.org, 
	chuck.lever@oracle.com, cyphar@cyphar.com, daan.j.demeyer@gmail.com, 
	edumazet@google.com, hannes@cmpxchg.org, horms@kernel.org, jack@suse.cz, 
	jlayton@kernel.org, josef@toxicpanda.com, kuba@kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-nfs@vger.kernel.org, me@yhndnzj.com, mkoutny@suse.com, 
	mzxreary@0pointer.de, netdev@vger.kernel.org, pabeni@redhat.com, 
	tj@kernel.org, viro@zeniv.linux.org.uk, zbyszek@in.waw.pl, kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"

Hi,

From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:41 +0200
[...]
> @@ -4275,7 +4197,7 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
>  	if (pwdmnt)
>  		mntput(pwdmnt);
>  
> -	mnt_ns_tree_add(new_ns);
> +	ns_tree_add_raw(new_ns);

When copy_tree() fails, new_ns's rb tree could be empty,

	guard(namespace_excl)();
...
	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
	if (IS_ERR(new)) {
		emptied_ns = new_ns;
		return ERR_CAST(new);
	}

which seems to trigger this warning in __ns_tree_remove().

	VFS_WARN_ON_ONCE(RB_EMPTY_NODE(&ns->ns_tree_node));


stack trace captured by syzbot:

WARNING: kernel/nstree.c:115 at __ns_tree_remove+0x28d/0x330 kernel/nstree.c:115, CPU#0: syz.5.2042/14092
Modules linked in:
CPU: 0 UID: 0 PID: 14092 Comm: syz.5.2042 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:__ns_tree_remove+0x28d/0x330 kernel/nstree.c:115
Code: 0f 85 a4 00 00 00 48 8b 04 24 ff 00 48 8b 7c 24 18 48 83 c4 30 5b 41 5c 41 5d 41 5e 41 5f 5d e9 e9 b4 f8 09 e8 94 f1 31 00 90 <0f> 0b 90 e9 cc fd ff ff e8 86 f1 31 00 90 0f 0b 90 e9 ee fd ff ff
RSP: 0018:ffffc9001040faa8 EFLAGS: 00010287
RAX: ffffffff818de18c RBX: ffff8880565d4620 RCX: 0000000000080000
RDX: ffffc9001ca51000 RSI: 00000000000003f8 RDI: 00000000000003f9
RBP: dffffc0000000000 R08: ffffffff8e1eff53 R09: 1ffffffff1c3dfea
R10: dffffc0000000000 R11: fffffbfff1c3dfeb R12: ffff8880565d4620
R13: 1ffff1100acba8c3 R14: ffff8880565d4600 R15: ffffffff8e1ea7c0
FS:  00007fba829d56c0(0000) GS:ffff8881259e0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c3b8de5 CR3: 000000004bb54000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 mnt_ns_tree_remove fs/namespace.c:165 [inline]
 free_mnt_ns+0xd1/0x110 fs/namespace.c:4074
 namespace_unlock+0x529/0x760 fs/namespace.c:1710
 class_namespace_excl_destructor fs/namespace.c:96 [inline]
 copy_mnt_ns+0x6e0/0x870 fs/namespace.c:4180
 create_new_namespaces+0xd1/0x720 kernel/nsproxy.c:78
 unshare_nsproxy_namespaces+0x11c/0x170 kernel/nsproxy.c:218
 ksys_unshare+0x4c8/0x8c0 kernel/fork.c:3144
 __do_sys_unshare kernel/fork.c:3215 [inline]
 __se_sys_unshare kernel/fork.c:3213 [inline]
 __x64_sys_unshare+0x38/0x50 kernel/fork.c:3213
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fba8478eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fba829d5038 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007fba849d6180 RCX: 00007fba8478eba9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000028060400
RBP: 00007fba84811e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fba849d6218 R14: 00007fba849d6180 R15: 00007ffe311606c8
 </TASK>

