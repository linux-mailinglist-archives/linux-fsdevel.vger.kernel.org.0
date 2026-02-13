Return-Path: <linux-fsdevel+bounces-77185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN2vI1Wkj2nASAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 23:23:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9B0139C75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 23:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0D17301D312
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 22:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FCF30BF6B;
	Fri, 13 Feb 2026 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="J9n4Oncx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6254A23AB9D
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771021392; cv=none; b=gFgPTQ3xlKx5gvmSJTt2/7kxTkHLDfmGs3OnRJz8R88SIPJpgI4gGTg+gywMtt2nleod+n+BZYOMYIsouIGZ1LR8x0xn4iXTBwb2Il2+xR/6JxZ299Lojc2I01wNZLdIGGcky0UDKfCQ6n7zXMv0r7iUnwAuTSjAhhPG5n61Au0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771021392; c=relaxed/simple;
	bh=gZpFPWX/Oinf9/cSsHplisZLMmusIn0AE7Jr9Miop5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHP6iGe0dbsFcqoXL6we+9fv2bgAb5Bmp0cppgNd3deuE5mTQ8+XnZzkFP3rwiott4ukXsQdc3Aggn9+gpIjkyek708Nx0+tofO6r5aCJF1urVPRz5cICJrxT1UzRUbGwfwyf5kIti/EiiW7mTVbVNhYIwrxy1Elc3wRyIKU6Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=J9n4Oncx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l0uxOj9Zmk2jNUcdqyv9b8i6ISND9IPl11XFf2mAF0g=; b=J9n4Oncxu2giElg9Nlile6N32n
	/6ViEuRBDlkQZfj0Fj/rpKEZUylcepdlNZC0IPBGIvFpaWeHuoqNUAcHBSbY+bZlHgukorSRGp8H0
	4slSfqmvblzHCRaalGNgTnq8fxGFySvXHU5YpqNaieBXgJTfLkDs6SXn6IzqWPlGSSlqSHYrHOAD5
	f0LaBYE1DBKlvxRjDBCf5RLjy+2UaBjVg5S4RLoUC2xiq0SKVdHqtQlsm9Dwfe+H3IvpucpK0wlpM
	1vyGW/od20hixlRJBVsj3pwvmMjhSGAXq1HX6GyOUC0L2SSlRIFUXbdBHBLn4hoRZi6R2bU9XGcKV
	bPY9dg+w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vr1bF-00000002HtD-49yS;
	Fri, 13 Feb 2026 22:25:22 +0000
Date: Fri, 13 Feb 2026 22:25:21 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Askar Safin <safinaskar@gmail.com>, christian@brauner.io,
	cyphar@cyphar.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, werner@almesberger.net
Subject: Re: [RFC] pivot_root(2) races
Message-ID: <20260213222521.GQ3183987@ZenIV>
References: <1FC2FB1F-BDA5-472D-A7DB-D146F6F75B16@zytor.com>
 <20260213174721.132662-1-safinaskar@gmail.com>
 <1caf6a70-e49b-42c7-81d0-bd0d6f5027bf@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1caf6a70-e49b-42c7-81d0-bd0d6f5027bf@zytor.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77185-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,brauner.io,cyphar.com,suse.cz,vger.kernel.org,linux-foundation.org,almesberger.net];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.org.uk:dkim]
X-Rspamd-Queue-Id: 0E9B0139C75
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 12:27:46PM -0800, H. Peter Anvin wrote:
> On 2026-02-13 09:47, Askar Safin wrote:
> > "H. Peter Anvin" <hpa@zytor.com>:
> >> It would be interesting to see how much would break if pivot_root() was restricted (with kernel threads parked in nullfs safely out of the way.)
> > 
> > As well as I understand, kernel threads need to follow real root directory,
> > because they sometimes load firmware from /lib/firmware and call
> > user mode helpers, such as modprobe.
> > 
> 
> If they are parked in nullfs, which is always overmounted by the global root,
> that should Just Work[TM]. Path resolution based on that directory should
> follow the mount point unless I am mistaken (which is possible, the Linux vfs
> has changed a lot since the last time I did a deep dive.)

You are, and it had always been that way.  We do *not* follow mounts at
the starting point.  /../lib would work, /lib won't.  I'd love to deal with
that wart, but that would break early boot on unknown number of boxen and
breakage that early is really unpleasant to debug.

