Return-Path: <linux-fsdevel+bounces-44751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89112A6C6C6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 02:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3CB67A891F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 00:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEB41BDCF;
	Sat, 22 Mar 2025 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uBjMFXhd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE55944F;
	Sat, 22 Mar 2025 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742605214; cv=none; b=LVVnZcUYoO53UdpXyt8SrHNcn80ayb/5rqjhhyC2t0JcCaCeL5MOsfpZyK3BPteJWukBjC51N2x2AUAIYAkyL5xwZNvBLA30SdVOAlliFTMhERUEJ0TnRDV/eJg659Nu2Q3+i5G+V7QWwexizUoMPg90tLm1xUMhTkZzq0Y5dnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742605214; c=relaxed/simple;
	bh=gYMB5a3/Rpk0ckAEqrG50bQbFpr8Q2IQbHkSLcyjiBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGKPwumEmfpuR2RmffBPylcaIw8A12V2gsVx8o2ePjPEUJIpFziiIMQYhyDE9sc07TlgDfDQS/85dlOHmwKaXCU8JmZp09vFJ8uT8wpfRpfZutnkWC/ZfPStH9epYkbYWO9cslisZ0mPC1UVsuOGF4wCzqS5fNl7r0jdEsyrTB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uBjMFXhd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=brVpSmMBxEBHe/mauCDyz1l9dPAg6klXWq2o5u4LmD0=; b=uBjMFXhdb8kmVGniBWcZRkdmka
	uPsjak1F4yycbmRSvzN4HYfZUCWqgHRiryKh2BtTL6rEI6XrJXCDb/oxMqnyvFrPP4WWaSGuuR36J
	4fz7V6XnJddzdPMl6WjJeF2LxdM/n8cgdPZU+AGQB7MB2KoZVig1D6lGagBxS4SP5+H0WngvB4f94
	26igtjOdyFJvUnrEfyhisD0R66Wf7u4out/AV6b85NAKWoiTuD/P7QGiFmnXNMf9xUQ729FYP/okA
	apSO1mpMlL5rQ0HViIQEBMIcVoc67k40HQSglhtrk1JbUsyLb+Nau6FsLZ4umzp0gc4XSxmLVP5aK
	S2+pOOcA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tvnDc-0000000BHcc-410J;
	Sat, 22 Mar 2025 01:00:09 +0000
Date: Sat, 22 Mar 2025 01:00:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [fs?] [mm?] KCSAN: data-race in bprm_execve / copy_fs
 (4)
Message-ID: <20250322010008.GG2023217@ZenIV>
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
 <202503201225.92C5F5FB1@keescook>
 <20250321-abdecken-infomaterial-2f373f8e3b3c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-abdecken-infomaterial-2f373f8e3b3c@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Mar 21, 2025 at 09:45:39AM +0100, Christian Brauner wrote:

> Afaict, the only way this data race can happen is if we jump to the
> cleanup label and then reset current->fs->in_exec. If the execve was
> successful there's no one to race us with CLONE_FS obviously because we
> took down all other threads.

Not really.

1) A enters check_unsafe_execve(), sets ->in_exec to 1
2) B enters check_unsafe_execve(), sets ->in_exec to 1
3) A calls exec_binprm(), fails (bad binary)
4) A clears ->in_exec
5) C calls clone(2) with CLONE_FS and spawns D - ->in_exec is 0
6) B gets through exec_binprm(), kills A and C, but not D.
7) B clears ->in_exec, returns

Result: B and D share ->fs, B runs suid binary.

Had (5) happened prior to (2), (2) wouldn't have set ->in_exec;
had (5) happened prior to (4), clone() would've failed; had
(5) been delayed past (6), there wouldn't have been a thread
to call clone().

But in the window between (4) and (6), clone() doesn't see
execve() in progress and check_unsafe_execve() has already
been done, so it hadn't seen the extra thread.

IOW, it really is racy.  It's a counter, not a flag.

