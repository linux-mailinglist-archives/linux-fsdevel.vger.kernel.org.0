Return-Path: <linux-fsdevel+bounces-75978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKZUBmNWfWn9RQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 02:09:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C243BFE1E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 02:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A93B302145D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 01:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5E5318EE6;
	Sat, 31 Jan 2026 00:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UM/ksZZW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAAC24337B;
	Sat, 31 Jan 2026 00:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769821087; cv=none; b=N56xULbDAvBaoZ4KCOVgO5BcERqkWyPoYbulrgUdrAvQWe49m6KaRcFU5V9lLHS/FB+BoDqELD8aqUj+20kF2VSoAkfZamgJ+evFNVRa2nTrp9R3EBHZhtXkaR6gSs31zGF8oBLtu12xiESDCFdznwD0+14L4FTNCCkYjrJb7s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769821087; c=relaxed/simple;
	bh=qauTqKHGto8i5EEkgwEAfw5OJmnWY9nGSftYNvMTteM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPb/UmhMw0YerphG5j1eG8fPIaQpz5/rCyYce659p4v0S9JK7f59sB+5HnzrdYA1bO/FuAWm5IPC0ThspdugnaxLapiAvtOH8oL2uvH8XFf+AHs7eFCKmD2ShlNEt9vkLL6aF9wc/jeaKs7CSyBffcki3d9tsKCDaJCHLfMizF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UM/ksZZW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6wn5ysU0YfloeA6exMYYK6iQpv2UsqLmSW+HgYt8Lvk=; b=UM/ksZZWv++c+yQ2Z0BCZkfn/S
	HjTROjfZP9usvFLH2AozqIKT5BfvGCplmb5PT/OrqOxyIcxn1AnMzXsSeyOPcgbqqK7NMoXLYcvD+
	AiRLG7sl+WVpci94VwwaRDPiyv+ALu0PW0AOh4CiNKrQBg0ntaI7j9YVDXwgHCt8rFkuXFoQG/qMG
	eM8x2UZHeYYWXCwshzBNpx/h2uX9YYt6vLnLMjgpBNC6Py3sbsH1CGWkWSNnpJz82lWdW9yjSFjyo
	D5jPNPQHtBTk91smKSHKmFupg6W69tzPTg2LBnAVeU/tacJaM4FNWwWmfNA5hRayFruPqi7yXGApP
	RaQL9bWw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vlzL8-0000000D2NM-1MYL;
	Sat, 31 Jan 2026 00:59:54 +0000
Date: Sat, 31 Jan 2026 00:59:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Samuel Wu <wusamuel@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name,
	a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org, clm@meta.com,
	android-kernel-team <android-kernel-team@google.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
Message-ID: <20260131005954.GX3183987@ZenIV>
References: <2026012715-mantra-pope-9431@gregkh>
 <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV>
 <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV>
 <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
 <20260130070424.GV3183987@ZenIV>
 <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
 <20260130235743.GW3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130235743.GW3183987@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75978-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.org.uk:dkim]
X-Rspamd-Queue-Id: 3C243BFE1E
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 11:57:43PM +0000, Al Viro wrote:

> Another thing to try (not as a suggestion of a fix, just an attempt to figure
> out how badly would the things break): in current mainline replace that
> 	ffs_mutex_lock(&ffs->mutex, file->f_flags & O_NONBLOCK)
> in ffs_ep0_open() with
> 	ffs_mutex_lock(&ffs->mutex, false)
> and see how badly do the things regress for userland.  Again, I'm not saying
> that this is a fix - just trying to get some sense of what's the userland
> is doing.

At a guess, quite badly.  ffs->mutex *is* way too heavy for that purpose -
that's a geniune bug.

State transitions in that thing are messy; AFAICS, the state is a combination
of ->opened and ->state, and transitions assume atomicity that just isn't there.

All updates of ->opened are process-synchronous; the nasty part is in the
FFS_DEACTIVATED handling.  We don't want it to coexist with ->opened > 0;
normally decrement of ->opened to 0 gets us into FFS_CLOSING immediately
and follows that with ffs_data_reset().  In -o no_disconnect mounts we switch
to FFS_DEACTIVATED instead.  On the next open() after that we want it to
transition to the same FFS_CLOSING + the same call of ffs_data_reset().

open() running into FFS_CLOSING fails; that happens until ffs_data_reset()
switches ->state to FFS_READ_DESCRIPTORS.

Things are complicated by ffs_func_set_alt() and ffs_func_disable() - these
can come with ->opened being zero and both contain this:
        if (ffs->state == FFS_DEACTIVATED) {
		ffs->state = FFS_CLOSING;
		INIT_WORK(&ffs->reset_work, ffs_reset_work);
		schedule_work(&ffs->reset_work);
		return -ENODEV;
	}
with s/return -ENODEV;/return;/ for ffs_func_disable().  The point, AFAICT,
is to avoid deadlocks from having ffs_data_reset() called in the locking
environment these two are called in.  At least ->set_alt() can be called
under a spinlock and ffs_data_reset() is blocking.

Another potentially troubling part is the check for FFS_ACTIVE in the
same functions, seeing that
                        ffs->state = FFS_ACTIVE;
                        mutex_unlock(&ffs->mutex);
 
                        ret = ffs_ready(ffs);
                        if (ret < 0) {
                                ffs->state = FFS_CLOSING;
                                return ret;
                        }
in ep0 write() happens with no exclusion with those (as the matter of
fact, that transition to FFS_CLOSING holds no locks at all)...

