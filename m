Return-Path: <linux-fsdevel+bounces-44663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD19A6B2B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 02:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242BD485CC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 01:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514F01DF968;
	Fri, 21 Mar 2025 01:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="O+HQ7TZD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40A31DED40;
	Fri, 21 Mar 2025 01:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742521469; cv=none; b=iLgEEfoa1IjlEVhH4Zhd7e9WbUAvG4009Q2rmDNPCfOnqb6OhinlEyAlzWs6SaHSEG+NqhscuedgV4N0myYAyQYQQpOw8tZdYvh5TnUS9ydpHg3bbVx5LSxF83CzgFEKG725Z0A/fszuPEhyXepCo61T7uMJkuFUWl9BSWaOvsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742521469; c=relaxed/simple;
	bh=16cc4KHT/TGVInG6/sIhiVIeHtROS6EMUut/J6wo2j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WySe+ZnmPlTc/X+oEYtdgJIDiCbOEjIuTtF2sHgPIBScy+lB+N6ajQsyk5GMlAG34I4Xm0/CYtGtB6OoWshKcZqSkKhoIUti3QFD8StdjceBajF/9bODtMYMZIEqG1gW8bhsmLtV8IyZkrMaiImvXBOYfPUvtffKgItjp//wbiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=O+HQ7TZD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TFHenndtR+JmeEXFkqj6A1CTl6kNgvKqQcIKOIozPfc=; b=O+HQ7TZDda8jv+r4HWcvfNrYIB
	8dhaD2c+Iy0+b+lz5dBMM2AZfSJRL2uYdg+a79a56/j7qEG2lWIfct/IffadVyOJwajdrxkyWDMYy
	ICc8r+0kJYJr4B2YftT2nW7xSgQcgiL7o7AjhurV7DC21dWPQaeQqi0sGv/9CkGN3bpGmSZs0+/+Z
	uuIDE6FMou5FPCILl+0CKYMXcnl0Pf2ekOEulpENlptt88iWfq3Tp28BTCO9dYNaPD2lNjbCAgzb+
	jqKStFyCEIq9sPkqbwu8Hh2qgoiHjOVB93ncEiNRhbtt8R3pZb29MCR47DdCpDxFlCprBA05aHPel
	1kzlrRPQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tvRQt-000000078Ju-1scf;
	Fri, 21 Mar 2025 01:44:23 +0000
Date: Fri, 21 Mar 2025 01:44:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Kees Cook <kees@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [fs?] [mm?] KCSAN: data-race in bprm_execve / copy_fs
 (4)
Message-ID: <20250321014423.GA2023217@ZenIV>
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
 <202503201225.92C5F5FB1@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503201225.92C5F5FB1@keescook>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Mar 20, 2025 at 01:09:38PM -0700, Kees Cook wrote:

> What I can imagine here is two failing execs racing a fork:
> 
> 	A start execve
> 	B fork with CLONE_FS
> 	C start execve, reach check_unsafe_exec(), set fs->in_exec
> 	A bprm_execve() failure, clear fs->in_exec
> 	B copy_fs() increment fs->users.
> 	C bprm_execve() failure, clear fs->in_exec
> 
> But I don't think this is a "real" flaw, though, since the locking is to
> protect a _successful_ execve from a fork (i.e. getting the user count
> right). A successful execve will de_thread, and I don't see any wrong
> counting of fs->users with regard to thread lifetime.
> 
> Did I miss something in the analysis? Should we perform locking anyway,
> or add data race annotations, or something else?

Umm...  What if C succeeds, ending up with suid sharing ->fs?

