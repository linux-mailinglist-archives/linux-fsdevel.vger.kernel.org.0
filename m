Return-Path: <linux-fsdevel+bounces-67871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E927C4CA42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD53F1885B6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654712F12B1;
	Tue, 11 Nov 2025 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4F6wrYi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A1435950;
	Tue, 11 Nov 2025 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853074; cv=none; b=S0Uj1OoWYry2MRJPJ0uXJqamDPlXaC+UsvJnddrz3eYpFA7GVBkOGIQMefFSR2GNmJYVP9YDWE5rGhqfxFJnd7WKmVGCKXdcIanJHSEAAQ0Cl+xo789nnTkhjoyPQN3a3Mp2Hp9yIkXADPdXj4j0Bn7ZGfcptLT81wQ/jv2HIHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853074; c=relaxed/simple;
	bh=oqo4ODlyQOZAF+e8zvIC1WyiLILrt4nXl7b8zNXWo44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbjlwnuRwKtDgMH8PZ6PY+Wr1Ip5BO86OvlOx+hNo8PzQcZ46sf1SgzMU0+k5/LokwF85rgFF0A+0YG+JHfgMVLpzvRW7c7WtoRIiw8txbFR4FecqGc8reuyskzy8pjSKkZe2yjmldsheFnUB2TwEbQRA/SRT1IMgVHuB2Chi8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4F6wrYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A841C116B1;
	Tue, 11 Nov 2025 09:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762853074;
	bh=oqo4ODlyQOZAF+e8zvIC1WyiLILrt4nXl7b8zNXWo44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b4F6wrYigF74u/gM39t5dR4yPM/K39Os3h41DM2HEnQyd7F3uIzD8A3fxAuLwXaFk
	 Xr0ugeiA8A+oQ7qOVe0xZvkVcmuX5W7EnOj5B/UEG+VJsA+cxjdU5LxoMnQwH01aAF
	 uQR1i6zpFgV5/1sf/LPS6F2MeS82TASh9CPIwSv+Mo60ws8nZrTolhCqULZXDJ/Inp
	 WNLVu3MijLSIvYeNENkBYXsmFW0fdmcbbcdaBhDUx4nCfby2JC34XSIJby6UGuj8CN
	 uSm04F6slHTJtqvCdO2jkOoESqNVSjsmw7pLJat+5mO2wMbErWhjv4xacl5iobdWP9
	 fu6Hj1x4bETrQ==
Date: Tue, 11 Nov 2025 10:24:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	bpf@vger.kernel.org, bsegall@google.com, david@redhat.com, dietmar.eggemann@arm.com, 
	jack@suse.cz, jsavitz@redhat.com, juri.lelli@redhat.com, kartikey406@gmail.com, 
	kees@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, mgorman@suse.de, mhocko@suse.com, mingo@redhat.com, 
	mjguzik@gmail.com, oleg@redhat.com, paul@paul-moore.com, peterz@infradead.org, 
	rostedt@goodmis.org, rppt@kernel.org, sergeh@kernel.org, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz, vincent.guittot@linaro.org, 
	viro@zeniv.linux.org.uk, vschneid@redhat.com
Subject: Re: [syzbot] [fs?] WARNING in nsproxy_ns_active_put
Message-ID: <20251111-lausbub-wieweit-76ec521875b2@brauner>
References: <690bfb9e.050a0220.2e3c35.0013.GAE@google.com>
 <69104fa2.a70a0220.22f260.00a5.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69104fa2.a70a0220.22f260.00a5.GAE@google.com>

On Sun, Nov 09, 2025 at 12:24:02AM -0800, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 3a18f809184bc5a1cfad7cde5b8b026e2ff61587
> Author: Christian Brauner <brauner@kernel.org>
> Date:   Wed Oct 29 12:20:24 2025 +0000
> 
>     ns: add active reference count
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11a350b4580000
> start commit:   9c0826a5d9aa Add linux-next specific files for 20251107
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=13a350b4580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=15a350b4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f2ebeee52bf052b8
> dashboard link: https://syzkaller.appspot.com/bug?extid=0b2e79f91ff6579bfa5b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1639d084580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1625aa92580000
> 
> Reported-by: syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com
> Fixes: 3a18f809184b ("ns: add active reference count")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz test: https://github.com/brauner/linux.git namespace-6.19

