Return-Path: <linux-fsdevel+bounces-77900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKSqN7O8m2ly5gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 03:34:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A640171696
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 03:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25564302592A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD1A2773C3;
	Mon, 23 Feb 2026 02:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gmWNwHUQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="auQ0GoDN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gmWNwHUQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="auQ0GoDN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D80C274B58
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 02:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771814050; cv=none; b=QbBUTgLMMhW/v6r8pHbsW/TuMjwvl+uve4tZbni6SLoFQfOVDfKdXHUKM/ClaDWrvyuvlIeJSMCReOnCMvXF1qmWG7vWEyQJvjCg1ATTplDoRAwoEc4ympA4FhO4688mJe6dlrcBn4UdkP9+ZeVUhECIZ4aENBaBI3OGmdmQL6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771814050; c=relaxed/simple;
	bh=o3vrtzHydrZPd18X8TUbC24WHKnqPdXQ96c1KGfW4+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=psrlMz1AvYGgO6yIzyJdXVLderkaPLTbdF42AuZNj7ZU0EfArFsplG5zPHDuacKdWvKx4m5tsg4o7ZsnbGgKB1Is/In6Asd5duyXtM2RAVZ/iFReUMYAay5zkvBGOlsKaoU6+4hWhJ3ueph4tXjfsEvs/sBzqYxDEpZSa/j5Eco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gmWNwHUQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=auQ0GoDN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gmWNwHUQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=auQ0GoDN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 825B03EA2A;
	Mon, 23 Feb 2026 02:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771814047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxBYf+cdsMcA82jqSZJfW81TKbNCK8ORNnR1WW9nGd8=;
	b=gmWNwHUQsLKFsdQq3rxX7oYQBWRe+tb8pRi7wAhILa5mA/1USLZgYdjeqxOhBf9nXv8kDv
	IaYpn+7OTs+SM/Dth8DtPyBYbXANRZPqf90pCSHSb+ALcktyx7clsssAB46keRQyuQ7G8T
	so5wcd04uN5je3AX8vWIMd5r0IyWGJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771814047;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxBYf+cdsMcA82jqSZJfW81TKbNCK8ORNnR1WW9nGd8=;
	b=auQ0GoDN3o96PnHEwC1UaFkwqGjmNjDjO9s8zTrhPJ8C60BBcRw9Zz9b+Xq6ByxUB26Gpx
	kzrSWbIEpEK5uwBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771814047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxBYf+cdsMcA82jqSZJfW81TKbNCK8ORNnR1WW9nGd8=;
	b=gmWNwHUQsLKFsdQq3rxX7oYQBWRe+tb8pRi7wAhILa5mA/1USLZgYdjeqxOhBf9nXv8kDv
	IaYpn+7OTs+SM/Dth8DtPyBYbXANRZPqf90pCSHSb+ALcktyx7clsssAB46keRQyuQ7G8T
	so5wcd04uN5je3AX8vWIMd5r0IyWGJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771814047;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxBYf+cdsMcA82jqSZJfW81TKbNCK8ORNnR1WW9nGd8=;
	b=auQ0GoDN3o96PnHEwC1UaFkwqGjmNjDjO9s8zTrhPJ8C60BBcRw9Zz9b+Xq6ByxUB26Gpx
	kzrSWbIEpEK5uwBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14AF93EA68;
	Mon, 23 Feb 2026 02:34:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 90XqLpq8m2nxfAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 23 Feb 2026 02:34:02 +0000
Date: Mon, 23 Feb 2026 13:33:57 +1100
From: David Disseldorp <ddiss@suse.de>
To: Rob Landley <rob@landley.net>
Cc: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Randy Dunlap
 <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, initramfs@vger.kernel.org, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 patches@lists.linux.dev
Subject: Re: [PATCH 1/2] init: ensure that /dev/console is (nearly) always
 available in initramfs
Message-ID: <20260223133357.0c3b8f8e.ddiss@suse.de>
In-Reply-To: <6d34c95a-a2ea-46a4-b491-45e7cb86049b@landley.net>
References: <20260219210312.3468980-1-safinaskar@gmail.com>
	<20260219210312.3468980-2-safinaskar@gmail.com>
	<20260220105913.4b62e124.ddiss@suse.de>
	<6d34c95a-a2ea-46a4-b491-45e7cb86049b@landley.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77900-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,zeniv.linux.org.uk,suse.cz,infradead.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ddiss@suse.de,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,landley.net:url,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 5A640171696
X-Rspamd-Action: no action

On Sun, 22 Feb 2026 19:27:50 -0600, Rob Landley wrote:

> On 2/19/26 17:59, David Disseldorp wrote:
> >> This problem can be solved by using gen_init_cpio.  
> 
> It used to work, then they broke it. (See below.)
> 
> >> But I think that proper solution is to ensure that /dev/console
> >> is always available, no matter what. This is quality-of-implementation
> >> feature. This will reduce number of possible failure modes. And
> >> this will make easier for developers to get early boot right.
> >> (Early boot issues are very hard to debug.)  
> > 
> > I'd prefer not to go down this path:
> > - I think it's reasonable to expect that users who override the default
> >    internal initramfs know what they're doing WRT /dev/console creation.
> > - initramfs can be made up of concatenated cpio archives, so tools which
> >    insist on using GNU cpio and run into mknod EPERM issues could append
> >    the nodes via gen_init_cpio, while continuing to use GNU cpio for
> >    everything else.  
> 
> Who said anything about gnu? Busybox has a cpio, toybox has a cpio... 
> once upon a time it was a posix command, removed from the standard for 
> the same reason tar was removed, and that was just as widely ignored.

I'm not familiar with Busybox or toybox cpio. I've referred to GNU cpio
as it carries the archive-contents-must-exist-locally interface. Any
tool which uses the same interface will likely need to workaround the
same mknod EPERM issues for initramfs.

> It's an archive format. There are tools that create that archive format 
> from a directory.
> 
> The kernel itself had a fairly generic one one built-in, which you 
> _could_ use to create cpio archives with /dev/console as a regular 
> user... until the kernel guys decided to break it. I carried a patch to 
> fix that for a little while myself:
> 
> https://landley.net/bin/mkroot/0.8.10/linux-patches/0011-gen_init_cpio-regression.patch

This seems like a helpful feature to me.

Thanks, David

