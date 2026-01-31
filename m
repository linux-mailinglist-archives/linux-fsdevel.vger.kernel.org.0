Return-Path: <linux-fsdevel+bounces-75980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4D0LHQJXfWn9RQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 02:12:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2BBBFE6C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 02:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4163930116B5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 01:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1870031D38A;
	Sat, 31 Jan 2026 01:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bgRCHe/1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6383164BB;
	Sat, 31 Jan 2026 01:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769821591; cv=none; b=lUNRUQASnKSzlzmgN+ZhKr3+sLrpowUaKUy1HP09g3C7nm1ctiWdCdektEv7XMwvy/cSJhBsJaVMEd4+UhuKLRZhZNhwfpDD/vldQnF+NcDtHJ2/Ajvv5FVpJhVHqZqU7znKUkaGoqWaC4tquJZl1nc3Z8Dt3B8Tuko3naUx+9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769821591; c=relaxed/simple;
	bh=MXV0TJpBaCDVcBvvP3MAXPF6TlMCxjpB/Xlnxl8VTNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1wVJu4P9dY/7netSWgbaZdU2k7c34v875Ws07ns2xhoi0IZISgUCRxu9RoAFRKeTdwBZXBCgRvN4jmquipZejaavwNCCaZCid2q1GghGSSQtiLpJwwQrRNQwtbLuSjDycYPHCF2WIU3DV82cTQ6OYZYBXcWjZR7UUIJZv6B5n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bgRCHe/1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j6niAf9hGe4w9oPvmCTGyNtjBKea5D0eR+MRPWb1Frg=; b=bgRCHe/1HuJX1btyYG1KNZ3vno
	TCqbEHHU6qGFN6p0raUIHroX/2Mch+Dje7lhnqFfAJqsXO6HOqA7hIbTc5Ox2EyVbbOISxAEFdnC6
	W6r9RbXH0cnnhzNCiUhyza8AQbuIL4q3umghKXNiUTquST9A8JtmhoMfurM+zy30Rr9a+EJlhTbz4
	mYdFlsgU/wLW6TW33NJuVF5q5MA2CVNgEEq5fEtx1mxQWuXErxAlK11j+2i67Fvpc3vfpacoulXyo
	qXmAQ2zn5lax6oOz0fp9VhU1n6CsYyGOFMeanmsPrwfxDcQRKBhE1jubjYt0zbsFP4o9GMz2qqGl5
	v717ALhA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vlzTJ-0000000D8c0-0LnE;
	Sat, 31 Jan 2026 01:08:21 +0000
Date: Sat, 31 Jan 2026 01:08:21 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Samuel Wu <wusamuel@google.com>, Greg KH <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz,
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
Message-ID: <20260131010821.GY3183987@ZenIV>
References: <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV>
 <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV>
 <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
 <20260130070424.GV3183987@ZenIV>
 <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
 <20260130235743.GW3183987@ZenIV>
 <CAHk-=wgk7MRBj4iwQLHocVCa94Jf0cMEz2HzUAS9+6rGtnp4JA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgk7MRBj4iwQLHocVCa94Jf0cMEz2HzUAS9+6rGtnp4JA@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-75980-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.org.uk:email,linux.org.uk:dkim]
X-Rspamd-Queue-Id: CE2BBBFE6C
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 04:14:48PM -0800, Linus Torvalds wrote:
> On Fri, 30 Jan 2026 at 15:55, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > So we have something that does O_NDELAY opens of ep0 *and* does not retry on
> > EAGAIN?
> >
> > How lovely...
> 
> Actually, I think that is pretty normal behavior.
> 
> Generally, O_NDELAY and friends should *NOT* turn locks into trylocks
> - because user space has no sane way to deal with kernel lock issues,
> and user space simply shouldn't care.
> 
> So O_NDELAY should be about avoiding IO, not about avoiding perfectly
> normal locks.
> 
> Of course, that horrendous driver locking is broken, since it holds
> the lock over IO, so that driver basically conflates IO and locking,
> and that's arguably the fundamental problem here.
> 
> But I suspect that for this case, we should just pass in zero to
> ffs_mutex_lock() on open, and say that the O_NONBLOCK flag is purely
> about the subsequent IO, not about the open() itself.
> 
> That is, after all, how the driver used to work.

I'd rather go for a spinlock there, protecting these FFS_DEACTIVATED
transitions; let me try and put together something along those lines.
Matter of fact, I would drop the atomics for ->opened completely
and do all changes under the same spinlock - it's really just
->open() and ->release().  Simpler that way...

The shitty part is that ->set_alt() thing and its callers seems to
be written in assumption that it can come from an interrupt, so we'd
need spin_lock_irq() in open/release and spin_lock_irqsave() in
set_alt/disable...

Another fun part is that we need a barrier on transition from
FFS_CLOSING in ffs_data_reset() - right now it's not even the last
assignment in there.  Same spinlock would solve that - screw explicit
barriers, it's _not_ a hot path and the locking is convoluted enough
as it is.

