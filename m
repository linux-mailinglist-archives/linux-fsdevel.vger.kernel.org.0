Return-Path: <linux-fsdevel+bounces-41817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9B1A37A36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 04:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D5016CC3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 03:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDE315B554;
	Mon, 17 Feb 2025 03:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SbtO2gjl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pC/UAdbo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SbtO2gjl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pC/UAdbo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2850CC2C9
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2025 03:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739764442; cv=none; b=reaKbhRxYh0zbZS5rjs77caqlu5QMYQ2cSg5lGrYOpbx0Ws9LuAXriWhp7YPbK8L3qxlJwkQOHZ4xJ6hdpVpMFtD+g1yBtyRj+C0yLOxi3fFZkw6Es0qof76CY8wuf0dJujcZbl/taa90x896oRIO8J2HwW22y6psOuvAsiwiSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739764442; c=relaxed/simple;
	bh=xQedsCPSFhtHw6QVp+EHduhxYmC5oWUg5T7GxRBi3IY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=mofWwwrmBiCQodwHINKJbbuKDVbmFNLlGo3fxZ+3MviM6COQ+kjJoydSa23pjCoCPYkSzw6Hr5a7NoabMSGpPgUKC7NSZkYJSZV33DBzkD0iXYQ5a74dxTOprUf5zWGfOSwKhJOt3foj6CUecAYzT/m3k/TT47Xh0nWm8/d6HUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SbtO2gjl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pC/UAdbo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SbtO2gjl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pC/UAdbo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 04A4D2115F;
	Mon, 17 Feb 2025 03:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739764439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=keg1qJuuA789j7Ba4lkiMaAbdgqyTR7GNNcXfWjDZGE=;
	b=SbtO2gjlRW4a5ChiHpK4R3YV8cXedBUMCUIuZny0PbSY0u293kTdYS7Lizopb2xd07E92h
	m/jQK623tU9QPGmkJow+L5eIJuMBhAe2Z0s9F/tzS2jhmOyiAozK9LoG1nIZfdERLlRyQC
	oNBOBzul4HP1CYRx2bjna7HaEO8ARho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739764439;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=keg1qJuuA789j7Ba4lkiMaAbdgqyTR7GNNcXfWjDZGE=;
	b=pC/UAdboh2TmGXFGrInv2kNMRoOIT6xqTa7MDwreFRAfmnUfm0hla0tF8Zd9WVg5MzzJHt
	+uscuXdjYm5lNtCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SbtO2gjl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="pC/UAdbo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739764439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=keg1qJuuA789j7Ba4lkiMaAbdgqyTR7GNNcXfWjDZGE=;
	b=SbtO2gjlRW4a5ChiHpK4R3YV8cXedBUMCUIuZny0PbSY0u293kTdYS7Lizopb2xd07E92h
	m/jQK623tU9QPGmkJow+L5eIJuMBhAe2Z0s9F/tzS2jhmOyiAozK9LoG1nIZfdERLlRyQC
	oNBOBzul4HP1CYRx2bjna7HaEO8ARho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739764439;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=keg1qJuuA789j7Ba4lkiMaAbdgqyTR7GNNcXfWjDZGE=;
	b=pC/UAdboh2TmGXFGrInv2kNMRoOIT6xqTa7MDwreFRAfmnUfm0hla0tF8Zd9WVg5MzzJHt
	+uscuXdjYm5lNtCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9607E1363A;
	Mon, 17 Feb 2025 03:53:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nY2BEtSysmfPWgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 17 Feb 2025 03:53:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3} Change ->mkdir() and vfs_mkdir() to return a dentry
In-reply-to: <20250214060039.GB1977892@ZenIV>
References:
 <20250214052204.3105610-1-neilb@suse.de>, <20250214060039.GB1977892@ZenIV>
Date: Mon, 17 Feb 2025 14:53:52 +1100
Message-id: <173976443235.3118120.11496260792280593655@noble.neil.brown.name>
X-Rspamd-Queue-Id: 04A4D2115F
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 14 Feb 2025, Al Viro wrote:
> On Fri, Feb 14, 2025 at 04:16:40PM +1100, NeilBrown wrote:
> > This is a small set of patches which are needed before we can make the
> > locking on directory operations more fine grained.  I think they are
> > useful even if we don't go that direction.
> > 
> > Some callers of vfs_mkdir() need to operation on the resulting directory
> > but cannot be guaranteed that the dentry will be hashed and positive on
> > success - another dentry might have been used.
> > 
> > This patch changes ->mkdir to return a dentry, changes NFS in particular
> > to return the correct dentry (I believe it is the only filesystem to
> > possibly not use the given dentry), and changes vfs_mkdir() to return
> > that dentry, removing the look that a few callers currently need.
> > 
> > I have not Cc: the developers of all the individual filesystems - only
> > NFS.  I have build-tested all the changes except hostfs.  I can email
> > them explicitly if/when this is otherwise acceptable.  If anyone sees
> > this on fs-devel and wants to provide a pre-emptive ack I will collect
> > those and avoid further posting for those fs.
> 
> 1) please, don't sprinkle the PTR_ERR_OR_ZERO() shite all over the place.
> Almost always the same thing can be done without it and it ends up
> being cleaner.  Seriously.

I've removed several PTR_ERR_OR_ZERO() calls.  Some times that could be
seen as a slight improvement, other times possibly a slight negative
(depending on how one feels about PTR_ERR_OR_ZERO of course).  I have
left three as I cannot see how to remove them without making the code
significant more clumsy.  If you find the remaining few to still be
objectionable I would be happy to see what alternate you would propose.

Your other feedback has been quite helpful - thanks.

NeilBrown


> 
> 2) I suspect that having method instances return NULL for "just use the
> argument" would would be harder to fuck up; basically, the same as for
> ->lookup() instances.  I'll try to tweak it and see what falls out...
> 
> 3) I'm pretty sure that NFS is *not* the only filesystem that returns
> unhashed negative in some success cases; will need to go over the instances
> to verify that, though.
> 


