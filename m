Return-Path: <linux-fsdevel+bounces-67588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 378A6C43F17
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 14:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A94A74E5C16
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 13:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E882FBDE6;
	Sun,  9 Nov 2025 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCDTG7yW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FAB2F9C2A;
	Sun,  9 Nov 2025 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762695569; cv=none; b=q5q0MloUJ+kb7O3vSUiAiQW1NpEKnOFasMBp4GA0lo0N+tJ6Y6+iKyXVaCgdVXVOUUmuiWgrUzSANAHXfgMQSpvkmrEg7BB4VEuH3eAJPkGVF8XGbyiCVybDx+Jzvyi6VIp2QkYZULtJ7CtuiZrKttpStrOITjrMVMJoKKLTuog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762695569; c=relaxed/simple;
	bh=FV6nIOrd9444B+mlGQsh9CSaoRsJM/FxBjLlQCcf7Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZD2hMqjdqX49qziHTjgtpTGy7QAhwl4D8EVI8AGN1rXEDOXpWhRg8o3D2cAca9i6PRq8k9VnN3+FtZq1J86l8XW86MRDTvqyETYC+lzxhAzBQ+pBq0nwC7hiWcoTBsOn2AD4zqxyQljD/Y9X0db7TSomHewhAdDCSpeQYCm+SII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCDTG7yW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E154C4AF0C;
	Sun,  9 Nov 2025 13:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762695569;
	bh=FV6nIOrd9444B+mlGQsh9CSaoRsJM/FxBjLlQCcf7Ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JCDTG7yWV3lfOfydcImpyi17b3P3GZLuSATHpoliBde4zFx8fh61QvaCh34B/HHii
	 pJ27gbrypWJWTH4Ulv+LOs72Quk/MUQ6LEtzHk02x8ZrpVtg5X87QGI4Nl3RU6aGOd
	 lbBJpjgNUXe1JyH6/xkSaHKgUVe/JH/zCh1uPdHSwDpYxG/tMvoJ6iGev/uMqQHTV4
	 SjvlJSoXJyzeQtNvM3gIcK9CnH290NCNuDjzDbc4fDFlbBYmlnB7RJzXJxV3foHm6E
	 9exKHGGww7iriJrIByK4WlNzn/KZiugBpkenja+mrf9Vg9KpQqyMj1qWw4b0Ao2ATp
	 aQQdmL5ydsFsg==
Date: Sun, 9 Nov 2025 14:39:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	anna-maria@linutronix.de, bpf@vger.kernel.org, bsegall@google.com, cgroups@vger.kernel.org, 
	david@redhat.com, dietmar.eggemann@arm.com, frederic@kernel.org, 
	hannes@cmpxchg.org, jack@suse.cz, jsavitz@redhat.com, juri.lelli@redhat.com, 
	kees@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, mgorman@suse.de, mhocko@suse.com, mingo@redhat.com, 
	mjguzik@gmail.com, mkoutny@suse.com, oleg@redhat.com, paul@paul-moore.com, 
	peterz@infradead.org, rostedt@goodmis.org, rppt@kernel.org, sergeh@kernel.org, 
	surenb@google.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	tj@kernel.org, vbabka@suse.cz, vincent.guittot@linaro.org, 
	viro@zeniv.linux.org.uk, vschneid@redhat.com
Subject: Re: [syzbot] [fs?] WARNING in destroy_super_work
Message-ID: <20251109-lesung-erkaufen-476f6fb00b1b@brauner>
References: <690da04f.a70a0220.22f260.0027.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <690da04f.a70a0220.22f260.0027.GAE@google.com>

On Thu, Nov 06, 2025 at 11:31:27PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    982312090977 Add linux-next specific files for 20251103
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17b2932f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=43cc0e31558cb527
> dashboard link: https://syzkaller.appspot.com/bug?extid=1957b26299cf3ff7890c
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1347817c580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/40058f8a830c/disk-98231209.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1d7f42e8639f/vmlinux-98231209.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d8bb0284f393/bzImage-98231209.xz
> 
> The issue was bisected to:
> 
> commit 3c9820d5c64aeaadea7ffe3a6bb99d019a5ff46a
> Author: Christian Brauner <brauner@kernel.org>
> Date:   Wed Oct 29 12:20:24 2025 +0000
> 
>     ns: add active reference count
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101e9bcd980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=121e9bcd980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=141e9bcd980000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com
> Fixes: 3c9820d5c64a ("ns: add active reference count")

#syz test: https://github.com/brauner/linux.git namespace-6.19.fixes

