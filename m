Return-Path: <linux-fsdevel+bounces-47221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB56EA9AC29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 13:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA931B6602E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 11:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0DA22F75F;
	Thu, 24 Apr 2025 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J611qTyw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nv0m4t43";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J611qTyw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nv0m4t43"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B5422F762
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745494447; cv=none; b=trxhhO5vXfseCyDasc1ZqpAmU/KOwnhnptN4Q0bjlqMO/LxFQ/ftf3RjvVyS1BRlazGoYVSnrQmADjTCflkWONytK+Pywyq3Ria1HSfo/iEugGGLm1j2K2b4XPnIoGX0uL/ihIYu24+exKNhTA5eojFE8cwL2Hi6puRRSR2ORNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745494447; c=relaxed/simple;
	bh=iKWoOUQson26LfUxIL7SIHtSGdq5XOffycHv6JCneLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CN0yGusTQJv6HLa6JY2VHfXRXkecJle19JhXya/HlaIiJijLilllwUkvSXqPVLgn4Raiy6IfznzqTS1gUUC1cIB4yNj3lxCcaXQQtzR/fYs5tf0KG9t+t5ML7ZGa03PAaKU9UsSbG0Op5jRFGpkv+AqMDN2z9/GBM7rzwBxGCnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J611qTyw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nv0m4t43; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J611qTyw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nv0m4t43; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 328121F445;
	Thu, 24 Apr 2025 11:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745494132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Fyu/Nu9A1yRtHGJim+jCEoPs0g98HsWG9zorgFuOmQ=;
	b=J611qTywUKO7Z4BAe3lLOvyyUc+/rqIZ2u+Qw9NvrqVT7t2DoK43bGSauEebiXapLZqltf
	KnKxpjUCjzhe66fbY9nr9xk9rXBWCf0SLS+0ywCp2sDgA/pgavzjnwIudoCyH9qJv5Ccmz
	VzAzw+fx3nR/3MtmwAzxK/nB6VNoAYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745494132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Fyu/Nu9A1yRtHGJim+jCEoPs0g98HsWG9zorgFuOmQ=;
	b=nv0m4t43lnoEmxb4uo9Uuz5ygb2Vf64+BwgyrilBbej6HN3hgZfD984oSFYikzM+ijXSYT
	Bu5Jmi7OaUFSPwDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745494132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Fyu/Nu9A1yRtHGJim+jCEoPs0g98HsWG9zorgFuOmQ=;
	b=J611qTywUKO7Z4BAe3lLOvyyUc+/rqIZ2u+Qw9NvrqVT7t2DoK43bGSauEebiXapLZqltf
	KnKxpjUCjzhe66fbY9nr9xk9rXBWCf0SLS+0ywCp2sDgA/pgavzjnwIudoCyH9qJv5Ccmz
	VzAzw+fx3nR/3MtmwAzxK/nB6VNoAYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745494132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Fyu/Nu9A1yRtHGJim+jCEoPs0g98HsWG9zorgFuOmQ=;
	b=nv0m4t43lnoEmxb4uo9Uuz5ygb2Vf64+BwgyrilBbej6HN3hgZfD984oSFYikzM+ijXSYT
	Bu5Jmi7OaUFSPwDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 236391393C;
	Thu, 24 Apr 2025 11:28:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0F2aCHQgCmhaPAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 24 Apr 2025 11:28:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D0171A0921; Thu, 24 Apr 2025 13:28:47 +0200 (CEST)
Date: Thu, 24 Apr 2025 13:28:47 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Lennart Poettering <lennart@poettering.net>, Jan Kara <jack@suse.cz>, 
	Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	containers@lists.linux.dev
Subject: Re: fanotify sb/mount watch inside userns (Was: [PATCH RFC] :
 fhandle: relax open_by_handle_at() permission checks)
Message-ID: <vmmqyhedlcmph2zcdx5wnhxj57hrmtssr7t47uhbd5py7epuv7@mwedyjqkcq37>
References: <20240524-vfs-open_by_handle_at-v1-1-3d4b7d22736b@kernel.org>
 <CAOQ4uxhjQwvJZEcuPyOg02rcDgcLfHQL-zhUGUmTf1VD8cCg4w@mail.gmail.com>
 <CAOQ4uxgjY=upKo7Ry9NxahJHhU8jV193EjsRbK80=yXd5yikYg@mail.gmail.com>
 <20241015-geehrt-kaution-c9b3f1381b6f@brauner>
 <CAOQ4uxj6ja4PN3=S9WxmZG0pLQOjBS-hNdwmGBzFjJ4GX64WCA@mail.gmail.com>
 <CAOQ4uxiwGTg=FeO6iiLEwtsP9eTudw-rsLD_0u3NtG8rz5chFg@mail.gmail.com>
 <CAOQ4uxgwfQNM=cRBJ0BJ-UtZ1R=v3uuFrOfLxWCr5c0WA_Nh3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgwfQNM=cRBJ0BJ-UtZ1R=v3uuFrOfLxWCr5c0WA_Nh3w@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 18-04-25 13:32:48, Amir Goldstein wrote:
> On Wed, Oct 16, 2024 at 2:53 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> ...
> > > > > Christian,
> > > > >
> > > > > Follow up question:
> > > > > Now that open_by_handle_at(2) is supported from non-root userns,
> > > > > What about this old patch [1] to allow sb/mount watches from non-root userns?
> > > > >
> > > > >
> ...
> > >
> > > My question is whether this is useful, because there are still a few
> > > limitations.
> > > I will start with what is possible with this patch:
> > > 1. Watch an entire tmpfs filesystem that was mounted inside userns
> > > 2. Watch an entire overlayfs filesystem that was mounted [*] inside userns
> > > 3. Watch an entire mount [**] of any [***] filesystem that was
> > > idmapped mounted into userns
> > >
> > > Now the the fine prints:
> > > [*] Overlayfs sb/mount CAN be watched, but decoding file handle in
> > > events to path
> > >      only works if overlayfs is mounted with mount option
> > > nfs_export=on, which conflicts
> > >      with mount option metacopy=on, which is often used in containers
> > > (e.g. podman)
> > > [**] Watching a mount is only possible with the legacy set of fanotify events
> > >      (i.e. open,close,access,modify) so this is less useful for
> > > directory tree change tracking
> > > [***] Watching an idmapped mount has the same limitations as watching
> > > an sb/mount
> > >      in the root userns, namely, filesystem needs to have a non zero
> > > fsid (so not FUSE)
> > >      and filesystem needs to have a uniform fsid (so not btrfs
> > > subvolume), although
> > >      with some stretch, I could make watching an idmapped mount of
> > > btrfs subvol work.
> > >
> > > No support for watching btrfs subvol and overlayfs with metacopy=on,
> > > reduces the attractiveness for containers, but perhaps there are still use cases
> > > where watching an idmapped mount or userns private tmpfs are useful?
> > >
> > > To try out this patch inside your favorite container/userns, you can build
> > > fsnotifywait with a patch to support watching inside userns [2].
> > > It's actually only the one lines O_DIRECTORY patch that is needed for the
> > > basic tmpfs userns mount case.
> > >
> > > Jan,
> > >
> > > If we do not get any buy-in from potential consumers now, do you think that
> > > we should go through with the patch and advertise the new supported use cases,
> > > so that users may come later on?
> > >
> 
> Hi guys,
> 
> The fine print section in the above "is it useful" question is quite complex.
> Maybe that explains why I got no response ;)
> 
> I can now ask another flavor of the question:
> 
> Is it useful to allow FAN_MARK_MNTNS watches from non-root userns?
 
Yes, I think these are useful but one has to be careful about not leaking
information from other namespaces.

> Just to make sure that I get it right, the unique mntid that is reported with
> mount attach/detach events is not namespaced right?

Correct. It is not namespaced.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

