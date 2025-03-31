Return-Path: <linux-fsdevel+bounces-45316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 866A4A75F02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 08:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D97018891D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 06:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AA9192D96;
	Mon, 31 Mar 2025 06:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dMONIVjP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="09wHGfdY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dMONIVjP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="09wHGfdY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB7870805
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 06:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743403803; cv=none; b=TKVcXXk554HdE2wqbl6vHzz3zvhLT/4blqwvu1kluk6JVoMXPusJw4DOl8AhvbQmi9WHC7AkB0auantIpxIIqgP7EWp6j+S7manBL7H7b2LbhDjr6dC3svRn9132Vrrb4/l7l8h633fzc8iG6UA45ZUjyuanRIDRYFdI/Ign8jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743403803; c=relaxed/simple;
	bh=D3O5imBHUYGS5OxjuAF0+hlyxeWodMwjvFTbgrjbpe4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hEz9TwhGdJBGBfPRlbs1fb2fUVI1IFSeS7wy2aCTOQVyKG/FlsHTKkkzr3TFsRGx/wbeVrhZ8CBmCaJwlHQDN165Eeb5+49X3vnEr6e1zMe2SHYEuBeeZ9j8tvSgL6qD+xNcZ6iyJqv4GFMVaj7KuSELoErQPrtx46TL2C6Bu9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dMONIVjP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=09wHGfdY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dMONIVjP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=09wHGfdY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F417C21197;
	Mon, 31 Mar 2025 06:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743403800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPyRbVbHSj/XyzZeopPN7997hVKl+H5ekbnEEyjfIJ8=;
	b=dMONIVjP1JvnMtyCaXJz14Doc1kvCQrENwA6aJevbGuvONuUHllbojuoNi3EBgzXYcPtrC
	fF8cBDvhYBViCNzonwjDpmmqCwadnslTf4Rw72C6vqJsvRTaDNN3vr8xKiTvTwcFCGwmxG
	2S5AjRuVa+V5aRhb6n4ZTRb/lCdT1nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743403800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPyRbVbHSj/XyzZeopPN7997hVKl+H5ekbnEEyjfIJ8=;
	b=09wHGfdYBGhExkIK3F9fic1Vec8G4MNx2hedWYJHCZXFey0Ign0shr6r4V2V177ZMMc4dv
	WimDb9Ct9rEij6CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dMONIVjP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=09wHGfdY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743403800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPyRbVbHSj/XyzZeopPN7997hVKl+H5ekbnEEyjfIJ8=;
	b=dMONIVjP1JvnMtyCaXJz14Doc1kvCQrENwA6aJevbGuvONuUHllbojuoNi3EBgzXYcPtrC
	fF8cBDvhYBViCNzonwjDpmmqCwadnslTf4Rw72C6vqJsvRTaDNN3vr8xKiTvTwcFCGwmxG
	2S5AjRuVa+V5aRhb6n4ZTRb/lCdT1nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743403800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPyRbVbHSj/XyzZeopPN7997hVKl+H5ekbnEEyjfIJ8=;
	b=09wHGfdYBGhExkIK3F9fic1Vec8G4MNx2hedWYJHCZXFey0Ign0shr6r4V2V177ZMMc4dv
	WimDb9Ct9rEij6CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED3C3139A1;
	Mon, 31 Mar 2025 06:49:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sLjWKBU76mcjHAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 31 Mar 2025 06:49:57 +0000
Date: Mon, 31 Mar 2025 17:49:51 +1100
From: David Disseldorp <ddiss@suse.de>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: initramfs: update compression and mtime
 descriptions
Message-ID: <20250331174951.7818afb1.ddiss@suse.de>
In-Reply-To: <39c91e20-94b2-4103-8654-5a7bbb8e1971@infradead.org>
References: <20250331050330.17161-1-ddiss@suse.de>
	<39c91e20-94b2-4103-8654-5a7bbb8e1971@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F417C21197
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

Thanks for the feedback, Randy...

On Sun, 30 Mar 2025 22:13:19 -0700, Randy Dunlap wrote:

> Hi,
> 
> On 3/30/25 10:03 PM, David Disseldorp wrote:
> > Update the document to reflect that initramfs didn't replace initrd
> > following kernel 2.5.x.
> > The initramfs buffer format now supports many compression types in
> > addition to gzip, so include them in the grammar section.
> > c_mtime use is dependent on CONFIG_INITRAMFS_PRESERVE_MTIME.
> > 
> > Signed-off-by: David Disseldorp <ddiss@suse.de>
> > ---
> >  .../early-userspace/buffer-format.rst         | 30 ++++++++++++-------
> >  1 file changed, 19 insertions(+), 11 deletions(-)
> > 
> > diff --git a/Documentation/driver-api/early-userspace/buffer-format.rst b/Documentation/driver-api/early-userspace/buffer-format.rst
> > index 7f74e301fdf35..cb31d617729c5 100644
> > --- a/Documentation/driver-api/early-userspace/buffer-format.rst
> > +++ b/Documentation/driver-api/early-userspace/buffer-format.rst
> > @@ -4,20 +4,18 @@ initramfs buffer format
> >  
> >  Al Viro, H. Peter Anvin
> >  
> > -Last revision: 2002-01-13
> > -
> > -Starting with kernel 2.5.x, the old "initial ramdisk" protocol is
> > -getting {replaced/complemented} with the new "initial ramfs"
> > -(initramfs) protocol.  The initramfs contents is passed using the same
> > -memory buffer protocol used by the initrd protocol, but the contents
> > +With kernel 2.5.x, the old "initial ramdisk" protocol was complemented
> > +with an "initial ramfs" protocol.  The initramfs contents is passed  
> 
>                                                              are passed
> 
> > +using the same memory buffer protocol used by initrd, but the contents
> >  is different.  The initramfs buffer contains an archive which is  
> 
>   are different.

I've not really changed those sentences with this patch, so I don't mind
if they stay as is, or switch "contents" to "content" or "is" to "are".

> >  expanded into a ramfs filesystem; this document details the format of
> >  the initramfs buffer format.  
> 
> Don't use "format" 2 times above.

This is also not changed by the patch. I'm happy to send a v2 or have
these clean-ups squashed in when applied. Will leave it up to the
maintainers.

