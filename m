Return-Path: <linux-fsdevel+bounces-78948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIGBMjzLpWnEFgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 18:39:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D102A1DDEEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 18:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11CFF301BFAF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 17:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD6D31ED7C;
	Mon,  2 Mar 2026 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eOBjgkmG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pkqkQ2Xg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eOBjgkmG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pkqkQ2Xg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A74317143
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772473071; cv=none; b=qMcIW13yTDzFNZUBTcmuBOnOmnWCIOf6pobSXQiTOv4tUqfEQH0fFbOx/JDQ538NlmYbICjhjEdC5KW7tw4ehCNDNBSJSqaqjRU/dvk5SOYOuxhCWQ/n9MS9as/ukqT1kyIwj/Ycxj0Vf2KW/uKIg5cUmHRqvPRlRc0Yo6MlG7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772473071; c=relaxed/simple;
	bh=tgE9xUWa3q2Tyxkvbljlpb9wJDOquZSZwVsF0oPJqsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlC3nf4veXrhIz7zk3tSnSvhSL55NJarKwYCOKWHz+En9I41URl+lCuTUh1KS+eWdflZY2NzcV/0NlMPicsoSTE/eZzyEj1PnnYWTPSZQsDY33IWfDHgDDHH17HSGmRpbKA26eAW+4XqlH+i9GwCfcKbUKE+3hr6iLaACC+LY9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eOBjgkmG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pkqkQ2Xg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eOBjgkmG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pkqkQ2Xg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C1AB3E6CC;
	Mon,  2 Mar 2026 17:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772473068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JQrP5jdf+uTHik0GVbgGHODBs44BqB1yBm17/8K1TTk=;
	b=eOBjgkmGj/11cD6na15g3AvAeOwMA1UxMaB2lDF6+/hlhpBkX0mfZFEH75O+MCC8lf2QPy
	MIKSzdZWGujdHJ4WbooRBrnyfS8QT7hD0kWXrKAORbhSUyr2UproYe1beiddZDYFYg6ie7
	aDHGQgm6d+jzH+wOci7c2waFdV0yZpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772473068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JQrP5jdf+uTHik0GVbgGHODBs44BqB1yBm17/8K1TTk=;
	b=pkqkQ2XgYCLhKCixDL49C3xguOYz5Dgs4mSJCr8z87mRZZiIDiBYDq4RalTTpjrRbmpdp/
	EV8je9YvIBAU+gAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772473068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JQrP5jdf+uTHik0GVbgGHODBs44BqB1yBm17/8K1TTk=;
	b=eOBjgkmGj/11cD6na15g3AvAeOwMA1UxMaB2lDF6+/hlhpBkX0mfZFEH75O+MCC8lf2QPy
	MIKSzdZWGujdHJ4WbooRBrnyfS8QT7hD0kWXrKAORbhSUyr2UproYe1beiddZDYFYg6ie7
	aDHGQgm6d+jzH+wOci7c2waFdV0yZpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772473068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JQrP5jdf+uTHik0GVbgGHODBs44BqB1yBm17/8K1TTk=;
	b=pkqkQ2XgYCLhKCixDL49C3xguOYz5Dgs4mSJCr8z87mRZZiIDiBYDq4RalTTpjrRbmpdp/
	EV8je9YvIBAU+gAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F38B83EA69;
	Mon,  2 Mar 2026 17:37:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k0RvO+vKpWnmAQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Mar 2026 17:37:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B0FA9A0A4E; Mon,  2 Mar 2026 18:37:47 +0100 (CET)
Date: Mon, 2 Mar 2026 18:37:47 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Chuck Lever <cel@kernel.org>, 
	NeilBrown <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.com>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 1/3] fs: add umount notifier chain for filesystem
 unmount notification
Message-ID: <2fdaxflmm7hottalnc3wbyzvjp4i5cd6etyvgzq4v3oktfwuuf@spgdoi45urqd>
References: <jxyalrg3a2yjtjfmdylncg7fz63jstbq6pwhhqlaaxju5sk72f@55lb7mfucc5i>
 <3cff098e-74a8-4111-babb-9c13c7ba2344@kernel.org>
 <CAOQ4uxiX5anNeZge9=uzw8Dkbad3bMBk5Ana5S94t9VfKNFO5g@mail.gmail.com>
 <d7f2562a-7d32-41d5-a02e-904aa4203ed3@app.fastmail.com>
 <CAOQ4uxiO+NCjhBme=YWCfnVyhJ=Zcg4zmnfoRspJab3n5waSCA@mail.gmail.com>
 <07a2af61-6737-4e47-ad69-652af18eb47b@app.fastmail.com>
 <177242454307.7472.11164903103911826962@noble.neil.brown.name>
 <d7abef36-ce90-4b36-af16-e8bd61b963ed@kernel.org>
 <3r5imygq5ah4khza5fsbgam6ss6ohla24p4ikmbpfpjoj4qmns@f6bw344w4axz>
 <74db1cb73ef8571e2e38187b668a83d28e19933b.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74db1cb73ef8571e2e38187b668a83d28e19933b.camel@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Rspamd-Queue-Id: D102A1DDEEB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78948-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,brown.name,gmail.com,suse.com,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon 02-03-26 12:10:52, Jeff Layton wrote:
> On Mon, 2026-03-02 at 16:26 +0100, Jan Kara wrote:
> > On Mon 02-03-26 08:57:28, Chuck Lever wrote:
> > > On 3/1/26 11:09 PM, NeilBrown wrote:
> > > > On Mon, 02 Mar 2026, Chuck Lever wrote:
> > > > > On Sun, Mar 1, 2026, at 1:09 PM, Amir Goldstein wrote:
> > > > > > On Sun, Mar 1, 2026 at 6:21 PM Chuck Lever <cel@kernel.org> wrote:
> > > > > > > Perhaps that description nails down too much implementation detail,
> > > > > > > and it might be stale. A broader description is this user story:
> > > > > > > 
> > > > > > > "As a system administrator, I'd like to be able to unexport an NFSD
> > > > > > 
> > > > > > Doesn't "unexporting" involve communicating to nfsd?
> > > > > > Meaning calling to svc_export_put() to path_put() the
> > > > > > share root path?
> > > > > > 
> > > > > > > share that is being accessed by NFSv4 clients, and then unmount it,
> > > > > > > reliably (for example, via automation). Currently the umount step
> > > > > > > hangs if there are still outstanding delegations granted to the NFSv4
> > > > > > > clients."
> > > > > > 
> > > > > > Can't svc_export_put() be the trigger for nfsd to release all resources
> > > > > > associated with this share?
> > > > > 
> > > > > Currently unexport does not revoke NFSv4 state. So, that would
> > > > > be a user-visible behavior change. I suggested that approach a
> > > > > few months ago to linux-nfs@ and there was push-back.
> > > > > 
> > > > 
> > > > Could we add a "-F" or similar flag to "exportfs -u" which implements the
> > > > desired semantic?  i.e.  asking nfsd to release all locks and close all
> > > > state on the filesystem.
> > > 
> > > That meets my needs, but should be passed by the linux-nfs@ review
> > > committee.
> > > 
> > > -F could probably just use the existing "unlock filesystem" API
> > > after it does the unexport.
> > 
> > If this option flies, then I guess it is the most sensible variant. If it
> > doesn't work for some reason, then something like ->umount_begin sb
> > callback could be twisted (may possibly need some extension) to provide
> > the needed notification? At least in my naive understanding it was created
> > for usecases like this...
> > 
> > 								Honza
> 
> umount_begin is a superblock op that only occurs when MNT_FORCE is set.
> In this case though, we really want something that calls back into
> nfsd, rather than to the fs being unmounted.

I see OK.

> You could just wire up a bunch of umount_begin() operations but that
> seems rather nasty. Maybe you could add some sort of callback that nfsd
> could register that runs just before umount_begin does?

Thinking about this more - Chuck was also writing about the problem of
needing to shutdown the state only when this is the last unmount of a
superblock but until we grab namespace_lock(), that's impossible to tell in
a race-free manner? And how about lazy unmounts? There it would seem to be
extra hard to determine when NFS needs to drop it's delegations since you
need to figure out whether all file references are NFS internal only? It
all seems like a notification from VFS isn't the right place to solve this
issue...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

