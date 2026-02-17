Return-Path: <linux-fsdevel+bounces-77350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2E2VDGQ8lGmTAwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 11:01:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1CB14A9FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 11:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 345DA300CA2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 10:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD40728D8FD;
	Tue, 17 Feb 2026 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Et/eL/8b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FQ/hRcK2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H+l0FWmp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PBDhoemM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2281D31A81C
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771322460; cv=none; b=Mv7JiEGP15gfEOCwKPR8MsXHGDZvBbwuSsMuMJ7OGkyzJfPUDNFNHl+QXom73+qAmZYeP7Edt/b7eerLYZXEYkmBvWMffJMGBoJvUrYK0UnMzhWtvnW8rYjycNagBv4tcCKtvQeInn+FKqjRQbu9TaWur4psBLP3IwL2VMQ5kDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771322460; c=relaxed/simple;
	bh=WvbSJG18f0qrRcBaMKTlvE4EDFtVfB0iH3lA6r7nM2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pu1xWXKx6G9hBa5qCB9YZV9Jv4JAg71VYWjn/Qv9Ixp2COgcVax8ZcQmqoEFJLi8Vm7MJvOWZBOZQxTM1elUOfS8jrOtjYYAp4oiJhOrteb6kHCN9phqfrUwLk3okpB884PtCntyPR5lRvDKLoaTw07m6qVdctpEccbPBIyTZYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Et/eL/8b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FQ/hRcK2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H+l0FWmp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PBDhoemM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 801B63E94C;
	Tue, 17 Feb 2026 10:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771322453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXFew/VphsUb2djQEERQyRCETTqYpZbxEZdKIiHK6kk=;
	b=Et/eL/8b98kq1OXGkH37XukK1I/557ShpGRGlB5apALLL4vXLXXgj0y+vkxSF4XRXN2Rse
	+xiUS7+zk+bG/KgCX629thSPPogqLlIlQPBfl7nl21rBKDuj9Lz7uATjCA3E/vEJsDLJmq
	fpWDVC4L5QrfG76Eh+BQrqBchx88giU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771322453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXFew/VphsUb2djQEERQyRCETTqYpZbxEZdKIiHK6kk=;
	b=FQ/hRcK2xUwvKvCmv5YPr3nNIqPsyjcAxYRNirWGKnS2sM6F0ruNzfNROPterZHmX1SgeK
	iSDNvwn2x69653DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771322449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXFew/VphsUb2djQEERQyRCETTqYpZbxEZdKIiHK6kk=;
	b=H+l0FWmpZasj0sfITiQ/cGFXFWZ46NeLJY+CP40mkgH5mqAKquylCd9LfVX2p5t2JQK0Vq
	3b6mV1FzklPy0vng4DGzSuDTkmCg2mo1rDJLkvmsEVRAWPO2IIVfVd7b/Hqq0qUpoIL4zM
	1qVtpIjTVrmuAhlf2h4PGA3gqoW0UfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771322449;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXFew/VphsUb2djQEERQyRCETTqYpZbxEZdKIiHK6kk=;
	b=PBDhoemM5vXEW3KLxGe9lz6/iyroCe6gC/BpCD3DmD/pFjPRiEq9pnxEsyel7BEGzxV14K
	SZ05xbFBlgr0FODQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33E9A3EA65;
	Tue, 17 Feb 2026 10:00:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qqjIDFE8lGnkPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Feb 2026 10:00:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B3215A08CF; Tue, 17 Feb 2026 11:00:42 +0100 (CET)
Date: Tue, 17 Feb 2026 11:00:42 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev, 
	stable@vger.kernel.org, Jan Kara <jack@suse.cz>, Jakub Acs <acsjakub@amazon.de>, 
	Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.19-5.15] fsnotify: Shutdown fsnotify before
 destroying sb's dcache
Message-ID: <z6nyopsvzubwxowiqxdg2yt5v6yu4i3uzlflvryjwuk2su7z4m@35ikyzqbxb46>
References: <20260214212452.782265-1-sashal@kernel.org>
 <20260214212452.782265-85-sashal@kernel.org>
 <CAOQ4uxgKwp2FSAUwqhHN-kTBcy0DsFmLstGUY+zJWppOzTAmHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgKwp2FSAUwqhHN-kTBcy0DsFmLstGUY+zJWppOzTAmHA@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-77350-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[suse.cz:query timed out,suse.com:query timed out];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[jack.suse.com:query timed out,jack.suse.cz:query timed out,sashal.kernel.org:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0B1CB14A9FC
X-Rspamd-Action: no action

On Sun 15-02-26 09:11:30, Amir Goldstein wrote:
> On Sat, Feb 14, 2026 at 11:27 PM Sasha Levin <sashal@kernel.org> wrote:
> >
> > From: Jan Kara <jack@suse.cz>
> >
> > [ Upstream commit 74bd284537b3447c651588101c32a203e4fe1a32 ]
> >
> > Currently fsnotify_sb_delete() was called after we have evicted
> > superblock's dcache and inode cache. This was done mainly so that we
> > iterate as few inodes as possible when removing inode marks. However, as
> > Jakub reported, this is problematic because for some filesystems
> > encoding of file handles uses sb->s_root which gets cleared as part of
> > dcache eviction. And either delayed fsnotify events or reading fdinfo
> > for fsnotify group with marks on fs being unmounted may trigger encoding
> > of file handles during unmount.
> 
> In retrospect, the text "Now that we iterate inode connectors..."
> would have helped LLM (as well as human) patch backports understand
> that this is NOT a standalone patch.

Good point :)

> Sasha,
> 
> I am very for backporting this fix, but need to backport the series
> https://lore.kernel.org/linux-fsdevel/20260121135513.12008-1-jack@suse.cz/

Yes. Without commits 94bd01253c3d5 ("fsnotify: Track inode connectors for a
superblock") and a05fc7edd988c ("fsnotify: Use connector list for
destroying inode marks") the reordering alone can cause large latencies
during filesystem unmount.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

