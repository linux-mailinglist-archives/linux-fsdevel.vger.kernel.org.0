Return-Path: <linux-fsdevel+bounces-15936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0293895E3A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 23:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D5D1F24FA6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 21:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F03C15E5C0;
	Tue,  2 Apr 2024 21:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="i8ufSoak"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587DC15E5B6;
	Tue,  2 Apr 2024 21:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091643; cv=none; b=Vqhsz3hchdnVH9a9Tw0rAI2/qYbTLg62/lusF/km8PH4q19D8QgLGeawuRv3m0CWAMguWJB2BghJZxdxlt8l/mRUXkd/SsqvP1okq/SaX4U8DstWmzYyNRoDdlfh2+bYpQNkqIZ73JEwT8M/lwmy1vjAnFqnqrAhAC4lE7bxHXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091643; c=relaxed/simple;
	bh=mmlsy0glwQjZjzYz4GUf3NdQiCwzbIVvgkGnZVN/MHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRj8kFwTsbEZWueAjuDn9q2NTnZoGr9uEWTTAjfRTg00HHqEx11ZmYgF2NlEdxPVRxBbTOF30nzVMnLwWJJT2LNjPoQfpj3CMkuliwqXruDDc0gTdvp1TS6x1oPQBgZqGVi+734ftxOR2BK7bPstC6Lb1Fd8SIqQ2lehKQJsxEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=i8ufSoak; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rnZFeGv4CURRmMTLk2PI3PHUPW4f8QH+Dl/k7a2oeuE=; b=i8ufSoakMqzaxH9TQ72e9wUEZM
	NDIoVPNSQL0XuCa37FuFw4DvU6AnTXybND7/vDBnSOBE8QqZYTOtS64RbKGmFvljaxMWA/74jSmI0
	K66GMFddggVi3YgUfJ7ZVjOlCdIMqIuekCx7rng4CSkaToLjmH2RfAS+yt+rMN5SDWbWUHEA+AbSW
	f5Yy/kaXnEAxZMWoTOxAoxM7FmCOBNlCobX/w9rdPAf0atcR6hoqQRbtczUh6HXOOSUV5dtIkqTew
	LhdjU4LSsW88aTaQckskwa1V+tvKSk6gC9z990ih70l/iZUaWub7jBAOJQZ5L2fNLMxWPLMiXn4Ps
	4s50TMJQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rrlFD-004Q20-08;
	Tue, 02 Apr 2024 21:00:35 +0000
Date: Tue, 2 Apr 2024 22:00:35 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [GIT PULL] security changes for v6.9-rc3
Message-ID: <20240402210035.GI538574@ZenIV>
References: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com>
 <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
 <CAHk-=wjjx3oZ55Uyaw9N_kboHdiScLkXAu05CmPF_p_UhQ-tbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjjx3oZ55Uyaw9N_kboHdiScLkXAu05CmPF_p_UhQ-tbw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Apr 02, 2024 at 12:57:28PM -0700, Linus Torvalds wrote:

> So in other cases we do handle the NULL, but it does seem like the
> other cases actually do validaly want to deal with this (ie the
> fsnotify case will say "the directory that mknod was done in was
> changed" even if it doesn't know what the change is.
> 
> But for the security case, it really doesn't seem to make much sense
> to check a mknod() that you don't know the result of.
> 
> I do wonder if that "!inode" test might also be more specific with
> "d_unhashed(dentry)". But that would only make sense if we moved this
> test from security_path_post_mknod() into the caller itself, ie we
> could possibly do something like this instead (or in addition to):
> 
>   -     if (error)
>   -             goto out2;
>   -     security_path_post_mknod(idmap, dentry);
>   +     if (!error && !d_unhashed(dentry))
>   +             security_path_post_mknod(idmap, dentry);
> 
> which might also be sensible.
> 
> Al? Anybody?

Several things here:

	1) location of that hook is wrong.  It's really "how do we catch
file creation that does not come through open() - yes, you can use
mknod(2) for that".  It should've been after the call of vfs_create(),
not the entire switch.  LSM folks have a disturbing fondness of inserting
hooks in various places, but IMO this one has no business being where
they'd placed it.  Bikeshedding regarding the name/arguments/etc. for
that thing is, IMO, not interesting...

	2) the only ->mknod() instance in the tree that tries to leave
dentry unhashed negative on success is CIFS (and only one case in it).
From conversation with CIFS folks it's actually cheaper to instantiate
in that case as well - leaving instantiation to the next lookup will
cost several extra roundtrips for no good reason.

	3) documentation (in vfs.rst) is way too vague.  The actual
rules are
	* ->create() must instantiate on success
	* ->mkdir() is allowed to return unhashed negative on success and
it might be forced to do so in some cases.  If a caller of vfs_mkdir()
wants the damn thing positive, it should account for such possibility and do
a lookup.  Normal callers don't care; see e.g. nfsd and overlayfs for example
of those that do.
	* ->mknod() is interesting - historically it had been "may leave
unhashed negative", but e.g. unix_bind() expected that it won't do so;
the reason it didn't blow up for CIFS is that this case (SFU) of their mknod()
does not support FIFOs and sockets anyway.  Considering how few instances
try to make use of that option and how it doesn't actually save them
anything, I would prefer to declare that ->mknod() should act as ->create().
	* ->symlink() - not sure; there are instances that make use of that
option (coda and hostfs).  OTOH, the only callers of vfs_symlink() that
care either way are nfsd and overlayfs, and neither is usable with coda
or hostfs...  Could go either way, but we need to say it clearly in the
docs, whichever way we choose.

