Return-Path: <linux-fsdevel+bounces-8273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D02D0831F6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 19:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 353F8B20FED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 18:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B963E2E405;
	Thu, 18 Jan 2024 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bg1NkNUa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LuygAVDb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bg1NkNUa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LuygAVDb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB292DF9E;
	Thu, 18 Jan 2024 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705604308; cv=none; b=lTkG6yydT/XS15v720rPETDXY8yaP1bUDMtSyBh85k2P7r0E2V01YsqvUpr0LSangVLGtrzWQZmf+k6nPxlfDius3S2FB+Kmep1FZfub+xn0jSHpvfn7q1bqgBK2cK5TgkWB+lXk7LDD+vwUZ2riFHLhX76f7EZlE90IWrF+HdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705604308; c=relaxed/simple;
	bh=pipxpEE0rEdRS9iWd4oW/yQhMvoeMbUnIH96TFKmjYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I3FuATcrpPgrHefed90oHQMrauWoges2/SV5IHwOjxYY7wVLMILm3RSHp+lfaphIdUAOrI/y6mYzePmzsKcOM2gWhcL6XFBLtqBajf0Vtc88Ox9Yuwzg2Q+niWUyC4MWOE3e2F8A6fMqKsLFd6TnyKg3PuIZfMkVbCRWiokZcTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bg1NkNUa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LuygAVDb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bg1NkNUa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LuygAVDb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F63F1F794;
	Thu, 18 Jan 2024 18:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705604303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TePT6SNkYG0/NMcWF4qAEY2n4Ayu1wLmJP7XENenT9Q=;
	b=bg1NkNUaXbl++aWubXC2t/jEGICrskI3EL+J3X8yt78sLYMJZavPltcZtIHMdjsNIElH7K
	JKYPPOhbNUVpGXO3Eo0BYv8ZaJuGrgfVc/WDPfb/qbz4jIcEkJqnC3jXArE59Kh2rIbMwS
	kHo5zio7WJg6VZfffN78D5UEKNYJi+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705604303;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TePT6SNkYG0/NMcWF4qAEY2n4Ayu1wLmJP7XENenT9Q=;
	b=LuygAVDbldUH5u2UtDHFQA58x42zps9tlIHirRp3sFrMUvYqORfWQ1m9qaNyipLYAoH6gz
	UFl2sHyyr0ci8RCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705604303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TePT6SNkYG0/NMcWF4qAEY2n4Ayu1wLmJP7XENenT9Q=;
	b=bg1NkNUaXbl++aWubXC2t/jEGICrskI3EL+J3X8yt78sLYMJZavPltcZtIHMdjsNIElH7K
	JKYPPOhbNUVpGXO3Eo0BYv8ZaJuGrgfVc/WDPfb/qbz4jIcEkJqnC3jXArE59Kh2rIbMwS
	kHo5zio7WJg6VZfffN78D5UEKNYJi+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705604303;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TePT6SNkYG0/NMcWF4qAEY2n4Ayu1wLmJP7XENenT9Q=;
	b=LuygAVDbldUH5u2UtDHFQA58x42zps9tlIHirRp3sFrMUvYqORfWQ1m9qaNyipLYAoH6gz
	UFl2sHyyr0ci8RCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A502136F5;
	Thu, 18 Jan 2024 18:58:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tN2KC850qWUYcAAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 18 Jan 2024 18:58:22 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: <oe-lkp@lists.linux.dev>,  <lkp@intel.com>,
  <linux-fscrypt@vger.kernel.org>,  <viro@zeniv.linux.org.uk>,
  <ebiggers@kernel.org>,  <jaegeuk@kernel.org>,  <tytso@mit.edu>,
  <linux-f2fs-devel@lists.sourceforge.net>,  <linux-ext4@vger.kernel.org>,
  <linux-fsdevel@vger.kernel.org>,  <amir73il@gmail.com>
Subject: Re: [PATCH v3 04/10] fscrypt: Drop d_revalidate once the key is added
In-Reply-To: <202401181648.4192e541-oliver.sang@intel.com> (kernel test
	robot's message of "Thu, 18 Jan 2024 16:23:26 +0800")
Organization: SUSE
References: <202401181648.4192e541-oliver.sang@intel.com>
Date: Thu, 18 Jan 2024 15:58:19 -0300
Message-ID: <87o7di8o50.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bg1NkNUa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LuygAVDb
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[lists.linux.dev,intel.com,vger.kernel.org,zeniv.linux.org.uk,kernel.org,mit.edu,lists.sourceforge.net,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 2F63F1F794
X-Spam-Flag: NO

kernel test robot <oliver.sang@intel.com> writes:

> Hello,
>
> kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
>
> commit: 1cfe4ba685d9eb6123648a0d9bef2d3d57b078ef ("[PATCH v3 04/10] fscrypt: Drop d_revalidate once the key is added")
> url: https://github.com/intel-lab-lkp/linux/commits/Gabriel-Krisman-Bertazi/ovl-Reject-mounting-case-insensitive-filesystems/20240112-070113
> base: https://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git dev-test
> patch link: https://lore.kernel.org/all/20240111225816.18117-5-krisman@suse.de/
> patch subject: [PATCH v3 04/10] fscrypt: Drop d_revalidate once the key is added
>
> in testcase: fxmark
> version: fxmark-x86_64-0ce9491-1_20220601
> with following parameters:
>
> 	disk: 1SSD
> 	media: ssd
> 	test: MWRL
> 	fstype: xfs
> 	directio: bufferedio
> 	cpufreq_governor: performance
>
>
>
> compiler: gcc-12
> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202401181648.4192e541-oliver.sang@intel.com
>
>
> [   73.173380][ T6828] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [   73.181338][ T6828] #PF: supervisor read access in kernel mode
> [   73.187453][ T6828] #PF: error_code(0x0000) - not-present page
> [   73.193566][ T6828] PGD 11cc47067 P4D 0
> [   73.197762][ T6828] Oops: 0000 [#1] SMP NOPTI
> [   73.202383][ T6828] CPU: 16 PID: 6828 Comm: fxmark Tainted: G S                 6.7.0-rc1-00176-g1cfe4ba685d9 #1
> [   73.212818][ T6828] Hardware name: Intel Corporation M50CYP2SB1U/M50CYP2SB1U, BIOS SE5C620.86B.01.01.0003.2104260124 04/26/2021
> [ 73.224837][ T6828] RIP: 0010:__d_move (include/linux/fscrypt.h:241 fs/dcache.c:3003) 
> [ 73.229912][ T6828] Code: c1 00 00 00 08 0f 84 ed 00 00 00 81 e1 3f 10 07 00 0f 84 e1 00 00 00 80 cc 40 89 c1 81 e1 ff ff ff fd 41 89 4d 00 49 8b 4d 60 <48> 81 39 10 21 4e 81 0f 84 66 01 00 00 83 43 04 01 41 83 45 04 01
> All code
> ========
>    0:	c1 00 00             	roll   $0x0,(%rax)
>    3:	00 08                	add    %cl,(%rax)
>    5:	0f 84 ed 00 00 00    	je     0xf8
>    b:	81 e1 3f 10 07 00    	and    $0x7103f,%ecx
>   11:	0f 84 e1 00 00 00    	je     0xf8
>   17:	80 cc 40             	or     $0x40,%ah
>   1a:	89 c1                	mov    %eax,%ecx
>   1c:	81 e1 ff ff ff fd    	and    $0xfdffffff,%ecx
>   22:	41 89 4d 00          	mov    %ecx,0x0(%r13)
>   26:	49 8b 4d 60          	mov    0x60(%r13),%rcx
>   2a:*	48 81 39 10 21 4e 81 	cmpq   $0xffffffff814e2110,(%rcx)		<-- trapping instruction
>   31:	0f 84 66 01 00 00    	je     0x19d
>   37:	83 43 04 01          	addl   $0x1,0x4(%rbx)
>   3b:	41 83 45 04 01       	addl   $0x1,0x4(%r13)
>
> Code starting with the faulting instruction
> ===========================================
>    0:	48 81 39 10 21 4e 81 	cmpq   $0xffffffff814e2110,(%rcx)
>    7:	0f 84 66 01 00 00    	je     0x173
>    d:	83 43 04 01          	addl   $0x1,0x4(%rbx)
>   11:	41 83 45 04 01       	addl   $0x1,0x4(%r13)
> [   73.249920][ T6828] RSP: 0018:ffa000000a99bce8 EFLAGS: 00010206
> [   73.256134][ T6828] RAX: 0000000000480000 RBX: ff1100012cab5380 RCX: 0000000000000000
> [   73.264248][ T6828] RDX: ff1100012cab4609 RSI: 0000000000000000 RDI: ff1100012cab4600
> [   73.272366][ T6828] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000020c
> [   73.280473][ T6828] R10: ff110001622ddde0 R11: 0000000000010000 R12: 0000000000000000
> [   73.288584][ T6828] R13: ff1100012cab4600 R14: 0000000000000000 R15: ff1100012cab5200
> [   73.296699][ T6828] FS:  00007f1073011600(0000) GS:ff1100103f600000(0000) knlGS:0000000000000000
> [   73.305766][ T6828] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   73.312488][ T6828] CR2: 0000000000000000 CR3: 000000012af2a006 CR4: 0000000000771ef0
> [   73.320596][ T6828] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   73.328699][ T6828] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   73.336803][ T6828] PKRU: 55555554
> [   73.340485][ T6828] Call Trace:
> [   73.343900][ T6828]  <TASK>
> [ 73.346960][ T6828] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
> [ 73.350983][ T6828] ? page_fault_oops (arch/x86/mm/fault.c:707) 
> [ 73.355957][ T6828] ? exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561) 
> [ 73.360837][ T6828] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570) 
> [ 73.365974][ T6828] ? __d_move (include/linux/fscrypt.h:241 fs/dcache.c:3003) 
> [ 73.370410][ T6828] ? __d_move (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 include/asm-generic/qspinlock.h:57 include/linux/fsnotify_backend.h:580 fs/dcache.c:3002) 
> [ 73.374846][ T6828] d_move (include/linux/seqlock.h:500 include/linux/seqlock.h:572 include/linux/seqlock.h:910 fs/dcache.c:3032) 
> [ 73.378757][ T6828] vfs_rename (include/linux/fs.h:807 fs/namei.c:4864) 
> [ 73.383189][ T6828] ? do_renameat2 (fs/namei.c:4996) 
> [ 73.387963][ T6828] do_renameat2 (fs/namei.c:4996) 
> [ 73.392568][ T6828] __x64_sys_rename (fs/namei.c:5040) 
> [ 73.397336][ T6828] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:82) 
> [ 73.401835][ T6828] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
> [   73.407817][ T6828] RIP: 0033:0x7f1072e83ed7
> [ 73.412325][ T6828] Code: e8 6e 82 09 00 85 c0 0f 95 c0 0f b6 c0 f7 d8 5d c3 66 90 b8 ff ff ff ff 5d c3 66 0f 1f 84 00 00 00 00 00 b8 52 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 89 8f 17 00 f7 d8 64 89 02 b8
> All code
> ========
>    0:	e8 6e 82 09 00       	callq  0x98273
>    5:	85 c0                	test   %eax,%eax
>    7:	0f 95 c0             	setne  %al
>    a:	0f b6 c0             	movzbl %al,%eax
>    d:	f7 d8                	neg    %eax
>    f:	5d                   	pop    %rbp
>   10:	c3                   	retq   
>   11:	66 90                	xchg   %ax,%ax
>   13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
>   18:	5d                   	pop    %rbp
>   19:	c3                   	retq   
>   1a:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
>   21:	00 00 
>   23:	b8 52 00 00 00       	mov    $0x52,%eax
>   28:	0f 05                	syscall 
>   2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
>   30:	77 01                	ja     0x33
>   32:	c3                   	retq
>   33:	48 8b 15 89 8f 17 00 	mov    0x178f89(%rip),%rdx        # 0x178fc3
>   3a:	f7 d8                	neg    %eax
>   3c:	64 89 02             	mov    %eax,%fs:(%rdx)
>   3f:	b8                   	.byte 0xb8
>

Hm. So, the thing I missed here is that fscrypt_handle_d_move will be
called even by filesystems that don't support fscrypt.  While we know
fscrypt filesystem dentries must have ->d_op, others might not have
it, and the dereferencing of dentry->d_op causes the oops at:

  if (dentry->d_op->d_revalidate == fscrypt_d_revalidate)

causes the Oops.

One fix would be to prevent non-fscrypt filesystems from calling this
function. But since __d_move only touches the dentries, I think I'll
leave it as-is and just do:

  if (dentry->d_op && dentry->d_op->d_revalidate)

sorry for the noise.

-- 
Gabriel Krisman Bertazi

