Return-Path: <linux-fsdevel+bounces-64149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9652BDACC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 19:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0563C18A6F97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 17:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED50C30275B;
	Tue, 14 Oct 2025 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AvawKqZF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jI7OfjFi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SEugYAdJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZTOv4Mzw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D1727A10F
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760463637; cv=none; b=CLUE0cXb/tWOrBdKdA8/Jpu/tDHbqM1IcOg0TexY9ku9AameLn+Rw5pyS2bcMU8E2P92AvyzhBXAJdvNJQ20QoPNESfNx96eWMB0sJDso8DRmbLckbUmpwmRmzTEstBtHbl5TeY7CZRTiiJYqr+41bZN4qDoQU6ZflMIMc/8pgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760463637; c=relaxed/simple;
	bh=RTdW7mLaF/iXXKpo/JOdk7iGRXU1zDzO5oAZOrzYMYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UD+bBuiPaiiLtrOqYHSsff9wWcJwIqgd03/2RCzrAbvwmMOSNMmTyACY/sc6YHReE3fZ+RBXl38ZJgEnzthlyZ7b/VDdf0cozIpbp90kOvzOoUUvhWx5ex0GW0bU4vtYqgqLAQRkCrDGN+G5NiDLsF5a99X+10mVg+AzzO6mREM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AvawKqZF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jI7OfjFi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SEugYAdJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZTOv4Mzw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CB03521293;
	Tue, 14 Oct 2025 17:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760463634;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/eEJr0vh6Ms092OOq5LENbMjP5M0eUCSzb+gN9R63ZU=;
	b=AvawKqZFoMSQk4t2aHatsyyluX1MEZhC3gtCj+wStu4NivM6snqv1Nest8a08rGXS4wUSK
	gArR+eUWQ4TlXe0dtB7iLwNitxnl4Uv1r3n6J+nu+rF5vyzK19SHHgPoYXJgMceXmj+tM9
	WXMQWCye2Q2mkp4al6mNR68rxg7Mt6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760463634;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/eEJr0vh6Ms092OOq5LENbMjP5M0eUCSzb+gN9R63ZU=;
	b=jI7OfjFi1y/zIX2rSB21Tk6u2xUEPmpxa65bfSntuoOxUE2SyWA5TfYzUBtByQ59VFPjFG
	Ws9g+DySkjmvJHAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SEugYAdJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZTOv4Mzw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760463633;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/eEJr0vh6Ms092OOq5LENbMjP5M0eUCSzb+gN9R63ZU=;
	b=SEugYAdJcB5TL9A44fWUd/vh/j8azDWF8XnpET6TJRqfkTd9QItfZo4sjKq8RQ/ihWlF2b
	g+IhGWRzsvjML4pG1naVP5vJ8aKkMQwnGqLsXOE0TKEJRw6K3egcpQgSU73btZ7LprSPes
	zwS2jv0G1FNWKfcykwQQeYF6bAde60U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760463633;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/eEJr0vh6Ms092OOq5LENbMjP5M0eUCSzb+gN9R63ZU=;
	b=ZTOv4MzwyUUuYk68NktEK7BQSFJvRTNOIHMwcx/Z7s0Pf+cRUk/0X4Y/5n+CnNyz+aDzG/
	ltlfUENg3BKuW2Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2C82139B0;
	Tue, 14 Oct 2025 17:40:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uMX7JhGL7mg3NgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 14 Oct 2025 17:40:33 +0000
Date: Tue, 14 Oct 2025 19:40:32 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com, Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Anand Jain <anand.jain@oracle.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>
Subject: Re: [RFC PATCH 1/1] ovl: Use fsid as unique identifier for trusted
 origin
Message-ID: <20251014174032.GC13776@suse.cz>
Reply-To: dsterba@suse.cz
References: <20251014015707.129013-1-andrealmeid@igalia.com>
 <20251014015707.129013-2-andrealmeid@igalia.com>
 <aO3T8BGM6djYFyrz@infradead.org>
 <fe7201ac-e066-4ac5-8fa1-8c470195248b@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe7201ac-e066-4ac5-8fa1-8c470195248b@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: CB03521293
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[infradead.org,igalia.com,vger.kernel.org,szeredi.hu,gmail.com,fb.com,suse.com,oracle.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Tue, Oct 14, 2025 at 03:43:54PM +1030, Qu Wenruo wrote:
> 在 2025/10/14 15:09, Christoph Hellwig 写道:
> > On Mon, Oct 13, 2025 at 10:57:07PM -0300, André Almeida wrote:
> >> Some filesystem have non-persistent UUIDs, that can change between
> >> mounting, even if the filesystem is not modified. To prevent
> >> false-positives when mounting overlayfs with index enabled, use the fsid
> >> reported from statfs that is persistent across mounts.
> > 
> > Please fix btrfs to not change uuids, as that completely defeats the
> > point of uuids.
> > 
> 
> That is the temp-fsid feature from Anand, introduced by commit 
> a5b8a5f9f835 ("btrfs: support cloned-device mount capability").
> 
> I'm not 100% sure if it's really that important to support mounting 
> cloned devices in the first place, as LVM will reject activating any LVs 
> if there is even conflicting VGs names, not to mention conflicting UUIDs.
> 
> If temp-fsid is causing problems with overlayfs, I'm happy to remove it, 
> as this really looks like a niche that no one is asking.

What do you mean no one asking?  This was specifically asked for by
Steam to do A/B root partition mounts for recovery. It is a niche use
case but it has its users.

