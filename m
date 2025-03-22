Return-Path: <linux-fsdevel+bounces-44783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3E4A6C930
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40E1188AE23
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F9D1F55F5;
	Sat, 22 Mar 2025 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCINIn1l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406551EB5D7;
	Sat, 22 Mar 2025 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742639006; cv=none; b=QKWKprvYIw1TxlP99rrAEt7+0uDwVCb6E9nVPYaQmevdXSSpr66dgvKNI0n8WJLOUYPzcgxcCM3XAP5IfQccxBvIApEAEfjsyFjf+ZtkKZkBGT9YpyVJtXhYWtT1B46+siBqJT+I55CTdDdjSuxvKOxw+uCGv21xvk4FYQvuU1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742639006; c=relaxed/simple;
	bh=t+PIvS79Qf0n/qUFkEgtZFqVsT7vv4uoH0INvOthFUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSS+3ezhKKu2Mf73xrwWKp2k1ETtst5Ak/8O8TGzA2lkC6O2WkzkM5RVz/RXNWZ+UCXQc8wb5z85yYQEGMtqECEZ1CmPGDH3VVcFPdS3TwguNzAGk+TaZ/Pe6jhuEOn3shk0QMIC3pxaS45k/pFRgRl6F0jnXDKixKi49LJyBlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCINIn1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F86C4CEDD;
	Sat, 22 Mar 2025 10:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742639005;
	bh=t+PIvS79Qf0n/qUFkEgtZFqVsT7vv4uoH0INvOthFUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RCINIn1lyvOjbb3rB21I50hIooClHoF4/rI+lIxAfdh5Acj3r8LgSR4vbji0uudVE
	 xBRnOujwOhyO3W3GmMjN9lMs1YYHcY13sCWfBZvfYUZuHhbORtWvss1fmUS8lrW+Ka
	 Z2yclWa66pKhIWLb6ahQvaTNQmvtyOGZP60rgVTTeLgKkpV528f5l2KjVp5WEKk9tD
	 EOWo6AtAqcpSlUYSRBTW1pOFXa2ugCLjNtz56+OFWvmxhQcZMdK5XwnY3EJA7NEGhn
	 6KHMUzIThHwhz+xA9VOtl3M77AbzEUSjog8STDlStWCqW6dfuIH1DrLe88owiHizFW
	 osMTnXul6BAkw==
Date: Sat, 22 Mar 2025 11:23:21 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <kees@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [fs?] [mm?] KCSAN: data-race in bprm_execve / copy_fs
 (4)
Message-ID: <20250322-nettigkeiten-weitreichend-fa9e8ee6875b@brauner>
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
 <202503201225.92C5F5FB1@keescook>
 <20250321-abdecken-infomaterial-2f373f8e3b3c@brauner>
 <20250322010008.GG2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250322010008.GG2023217@ZenIV>

On Sat, Mar 22, 2025 at 01:00:08AM +0000, Al Viro wrote:
> On Fri, Mar 21, 2025 at 09:45:39AM +0100, Christian Brauner wrote:
> 
> > Afaict, the only way this data race can happen is if we jump to the
> > cleanup label and then reset current->fs->in_exec. If the execve was
> > successful there's no one to race us with CLONE_FS obviously because we
> > took down all other threads.
> 
> Not really.
> 
> 1) A enters check_unsafe_execve(), sets ->in_exec to 1
> 2) B enters check_unsafe_execve(), sets ->in_exec to 1
> 3) A calls exec_binprm(), fails (bad binary)
> 4) A clears ->in_exec
> 5) C calls clone(2) with CLONE_FS and spawns D - ->in_exec is 0
> 6) B gets through exec_binprm(), kills A and C, but not D.
> 7) B clears ->in_exec, returns
> 
> Result: B and D share ->fs, B runs suid binary.
> 
> Had (5) happened prior to (2), (2) wouldn't have set ->in_exec;
> had (5) happened prior to (4), clone() would've failed; had
> (5) been delayed past (6), there wouldn't have been a thread
> to call clone().
> 
> But in the window between (4) and (6), clone() doesn't see
> execve() in progress and check_unsafe_execve() has already
> been done, so it hadn't seen the extra thread.

Eewww, you're right. That's ugly as hell.

