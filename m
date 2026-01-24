Return-Path: <linux-fsdevel+bounces-75367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WXY7JBkrdWkfBgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 21:27:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F1C7EE43
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 21:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0464300C82B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 20:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70FA279908;
	Sat, 24 Jan 2026 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bruU3SPw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351B425A33F
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jan 2026 20:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769286419; cv=none; b=oOj6I0GmRq57/RofgdjY1rpTcOsYEtijMdWQkRoZvoXauTJ8sQ6EUAA9jzenozX1oFpznKmTtsd3cvfwKeGImOWenb4lgqiiWGn//qlV8OehmkkcjXasspyIz1+TA5Ro1+YOYsgC95Hy5RpP+8wH+zw7Nz+IAbD5yWlVCPJeySw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769286419; c=relaxed/simple;
	bh=G79gxNlTI9yunC6BxSuv43e/vZBKuL229CBdovTperY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5f3gxsx778K7CjCqo/duMeSxWi8pAwHkrvFPVcI/yJtL5z2VpxxwShCzhQlOBeg7QojBNr2TelMvooBl0mSVdWIPANoXPs5mPV+gVA8AueRde9Offbu1dF7KTy9UOY5illl38hYYJUPLUL1pxLM8ux8K/8UlyO/hpSn5/kLX9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bruU3SPw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=afxbx41Q9RzLWQia5rO0/PgqJcFZmTIdwlPzJzqSmkI=; b=bruU3SPwiGojv3KQDZCK6yEzgv
	IzILYBrIoPzs4jKNj5AWwcbpg9b59km4G1ndTA0ts5pF2/kzOnlD8+GyPIldvZu4GjQdvkOZnA1IE
	j1JLsA2F8d74tlNYjhPIp7nL2fd92ysOhe41cGxkKvmMs4FBMyJ1hrE4Pny7rOCgg4VplXnNP2RMb
	v3wDT4d6whHo02i7Sgs9ww0W/D6oa9XzGoOvxX8NLHOXK+q+xQO+s1FVPxGLLbXyzh0pfwFJxqxng
	clsrNgo8gJnz6MVpdbHFJNh1AaB9tPxVbDrMPS0CjvajpvwzAhelPXblxBPoXSopHiuDgvYDFQ+/0
	nNtlbdIQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vjkFM-00000004VkE-0raD;
	Sat, 24 Jan 2026 20:28:40 +0000
Date: Sat, 24 Jan 2026 20:28:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH][RFC] get rid of busy-wait in shrink_dcache_tree()
Message-ID: <20260124202840.GO3183987@ZenIV>
References: <20260122202025.GG3183987@ZenIV>
 <CAHk-=wj1nKArJE8dj+mwF2bGu+N2-DL0P2ytaLYJRrDdPpa9MA@mail.gmail.com>
 <20260123003651.GH3183987@ZenIV>
 <20260124043623.GK3183987@ZenIV>
 <CAHk-=wgkSAHswtOzvTXeBOz1GLNfsohSPdyzZmnVYe2Qx4fetQ@mail.gmail.com>
 <20260124053639.GL3183987@ZenIV>
 <CAHk-=wgGCyjEC9ookrcVou4__nkPbSosP7RG6AwntBZbdeAjuA@mail.gmail.com>
 <20260124184328.GM3183987@ZenIV>
 <CAHk-=whLR=hAPRWsPxV8GQ5VsNb+b+SQ7KpmPCkc9E6SsqnwqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whLR=hAPRWsPxV8GQ5VsNb+b+SQ7KpmPCkc9E6SsqnwqQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75367-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,linux.org.uk:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04F1C7EE43
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 11:32:59AM -0800, Linus Torvalds wrote:
> On Sat, 24 Jan 2026 at 10:41, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > > In fact, RANDSTRUCT is so broken in general that we actually taint the
> > > kernel if you enable that crazy option in the first place. So no,
> > > "what if somebody enables it on random things" is not even remotely
> > > worth worrying about.
> >
> > Very much agreed, but we *do* have that on e.g. struct path (two pointers),
> > as well as struct inode, struct file, struct mount, etc.  As far as VFS goes,
> > those are core data structures...
> 
> I certainly wouldn't mind if we remove the 'struct path' one in
> particular. It's insanely pointless to do randstruct on two fields.

<wry>
Frankly, each time I talk to these folks I keep hearing "Every bit
is wanted/Every bit is good/Every bit is needed/In your neighborhood"
set to the obvious tune...
</wry>

