Return-Path: <linux-fsdevel+bounces-78930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHW6AYGspWmpDgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 16:28:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C88DF1DBD21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 16:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9551F30325CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 15:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B2840FDA9;
	Mon,  2 Mar 2026 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LGg0RbnZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3xlrUM9c";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LGg0RbnZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3xlrUM9c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3A740149D
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465201; cv=none; b=SSiHDbh2NW8XCJ/0FKzLJM8i6Je+JGkplRCNgqexkFOeo8ypkDigSSf0227o+QZeKnySfKIREoHbOGZFXWQq1y+xD3lFgnjP259Jn6KdRB1Y8Jqypj3ekqIvs4s2uXBZhO/7FT3moBv0wMXQPhfOrRtMmiTk52FgDI04iLZPGMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465201; c=relaxed/simple;
	bh=bgemlqptfQf70G9CaWcSSsg+IrumiQx9bGnpjSrqn0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WU9wWG0w+cZ6H5ib/5iWsLDdAOFcD7uPX2vhiPFgv7l9XjXXhrHo/MpICAmkcZy7C6lftynP/NHJQAc59iM5XRB9sRFYmgY41aeXI0qdJ3QU8m4Me+ahs1bYlBYGpFDrUQ/8NWg8Fvsot9+DlJGHNMn1BrlJ3c0hBGQG7vEVTl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LGg0RbnZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3xlrUM9c; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LGg0RbnZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3xlrUM9c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 08AD43E806;
	Mon,  2 Mar 2026 15:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772465198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F89b+aS5l0gzlJ6qVHGzvbZZ/UFggSDUfwTM8BVPn7M=;
	b=LGg0RbnZOdE+jawXdzONokxu+AkKVBpzTL2ZNpA5MDO3hZXL7P2Co1jjPgLL/BmFX+5jvC
	cm9+8sH82d8mSP3pnClpz5CJn/JNFZt8AovenqjGPfLHY8LfkiwoL6AVFxQcS7XUwjTEew
	xz1058M3P7Y/8eZyCH/jYF22OVxzJ9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772465198;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F89b+aS5l0gzlJ6qVHGzvbZZ/UFggSDUfwTM8BVPn7M=;
	b=3xlrUM9c5wuSVfrAVh3BOee6r/24aqpE1z1dswcivZfQl52I2XCblp1lpu9WTjyXNopVJr
	PJdgdSjEr0uPIQDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LGg0RbnZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3xlrUM9c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772465198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F89b+aS5l0gzlJ6qVHGzvbZZ/UFggSDUfwTM8BVPn7M=;
	b=LGg0RbnZOdE+jawXdzONokxu+AkKVBpzTL2ZNpA5MDO3hZXL7P2Co1jjPgLL/BmFX+5jvC
	cm9+8sH82d8mSP3pnClpz5CJn/JNFZt8AovenqjGPfLHY8LfkiwoL6AVFxQcS7XUwjTEew
	xz1058M3P7Y/8eZyCH/jYF22OVxzJ9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772465198;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F89b+aS5l0gzlJ6qVHGzvbZZ/UFggSDUfwTM8BVPn7M=;
	b=3xlrUM9c5wuSVfrAVh3BOee6r/24aqpE1z1dswcivZfQl52I2XCblp1lpu9WTjyXNopVJr
	PJdgdSjEr0uPIQDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F10493EA69;
	Mon,  2 Mar 2026 15:26:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q9PROi2spWnkdgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Mar 2026 15:26:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A6149A0A0B; Mon,  2 Mar 2026 16:26:37 +0100 (CET)
Date: Mon, 2 Mar 2026 16:26:37 +0100
From: Jan Kara <jack@suse.cz>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>, 
	Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.com>, 
	Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 1/3] fs: add umount notifier chain for filesystem
 unmount notification
Message-ID: <3r5imygq5ah4khza5fsbgam6ss6ohla24p4ikmbpfpjoj4qmns@f6bw344w4axz>
References: <CAOQ4uxhEpf1p3agEF7_HBrhUeKz1Fb_yKAQ0Pjo0zztTJfMoXA@mail.gmail.com>
 <1165a90b-acbf-4c0d-a7e3-3972eba0d35a@kernel.org>
 <jxyalrg3a2yjtjfmdylncg7fz63jstbq6pwhhqlaaxju5sk72f@55lb7mfucc5i>
 <3cff098e-74a8-4111-babb-9c13c7ba2344@kernel.org>
 <CAOQ4uxiX5anNeZge9=uzw8Dkbad3bMBk5Ana5S94t9VfKNFO5g@mail.gmail.com>
 <d7f2562a-7d32-41d5-a02e-904aa4203ed3@app.fastmail.com>
 <CAOQ4uxiO+NCjhBme=YWCfnVyhJ=Zcg4zmnfoRspJab3n5waSCA@mail.gmail.com>
 <07a2af61-6737-4e47-ad69-652af18eb47b@app.fastmail.com>
 <177242454307.7472.11164903103911826962@noble.neil.brown.name>
 <d7abef36-ce90-4b36-af16-e8bd61b963ed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7abef36-ce90-4b36-af16-e8bd61b963ed@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: C88DF1DBD21
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78930-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.cz:dkim,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[brown.name,gmail.com,suse.cz,kernel.org,suse.com,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon 02-03-26 08:57:28, Chuck Lever wrote:
> On 3/1/26 11:09 PM, NeilBrown wrote:
> > On Mon, 02 Mar 2026, Chuck Lever wrote:
> >> On Sun, Mar 1, 2026, at 1:09 PM, Amir Goldstein wrote:
> >>> On Sun, Mar 1, 2026 at 6:21 PM Chuck Lever <cel@kernel.org> wrote:
> >>>> Perhaps that description nails down too much implementation detail,
> >>>> and it might be stale. A broader description is this user story:
> >>>>
> >>>> "As a system administrator, I'd like to be able to unexport an NFSD
> >>>
> >>> Doesn't "unexporting" involve communicating to nfsd?
> >>> Meaning calling to svc_export_put() to path_put() the
> >>> share root path?
> >>>
> >>>> share that is being accessed by NFSv4 clients, and then unmount it,
> >>>> reliably (for example, via automation). Currently the umount step
> >>>> hangs if there are still outstanding delegations granted to the NFSv4
> >>>> clients."
> >>>
> >>> Can't svc_export_put() be the trigger for nfsd to release all resources
> >>> associated with this share?
> >>
> >> Currently unexport does not revoke NFSv4 state. So, that would
> >> be a user-visible behavior change. I suggested that approach a
> >> few months ago to linux-nfs@ and there was push-back.
> >>
> > 
> > Could we add a "-F" or similar flag to "exportfs -u" which implements the
> > desired semantic?  i.e.  asking nfsd to release all locks and close all
> > state on the filesystem.
> 
> That meets my needs, but should be passed by the linux-nfs@ review
> committee.
> 
> -F could probably just use the existing "unlock filesystem" API
> after it does the unexport.

If this option flies, then I guess it is the most sensible variant. If it
doesn't work for some reason, then something like ->umount_begin sb
callback could be twisted (may possibly need some extension) to provide
the needed notification? At least in my naive understanding it was created
for usecases like this...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

