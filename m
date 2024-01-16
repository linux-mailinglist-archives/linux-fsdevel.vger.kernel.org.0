Return-Path: <linux-fsdevel+bounces-8126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4824B82FD4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 23:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBC829553D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 22:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210B61F953;
	Tue, 16 Jan 2024 22:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f6Kejs3y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HjfwTsYn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f6Kejs3y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HjfwTsYn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2B91D6A8;
	Tue, 16 Jan 2024 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705445072; cv=none; b=J/j0nT2kqmRDP1KqtTQbciSLQ2OX2cYla/SyXga4mjSS99EIc6MSSSXNOHg0VuqcZhmbOh4eCHbc+mYrwTujc/nSIPSX8f6G/ChuGjS2FkRlHR6Ggyqn/t3btH1Z03DEcBPDIJO4UZBjbesCkEZYeCb43chcGhbwQdBhnarJKkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705445072; c=relaxed/simple;
	bh=AKPYrNOerbRHsirgEfZ0p1S5QHwiWw7x8ovHOI5lE1o=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:From:To:Cc:Subject:
	 In-reply-to:References:Date:Message-id:X-Spam-Level:X-Spam-Score:
	 X-Spamd-Result:X-Spam-Flag; b=M39EnUL400qnev8vMtKtrSlTaRf0Olee+4TYLnWnh/irCGY0qRKsRWPx8RU6z4BjeZqp/R813liO1wdQ1Uu7aopyop39IitwlZBIhUYZ4I2FrHo6ZNpeDSaAEl7xAC/eM648B+DboBLqfKXPCZBEoEjIfpQCfKVafnTrPiDStqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f6Kejs3y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HjfwTsYn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f6Kejs3y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HjfwTsYn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0DE9E21FD7;
	Tue, 16 Jan 2024 22:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705445069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh+oq1spB9mXnL92/e4GJ7ibfkaNrbj9dH8Tk64Djcw=;
	b=f6Kejs3ynwExykrJLsf6I7d5bcEDabcWJXxJV92F4iHVc7UOqw1z6bgFyUdjZB1nZZzUCy
	uYn6ovQ2wTV5Uxps5LTHqoIi8FbN9c3jpKoKlo+yzVUeHRhsOYMjfowfic3prCOTRXHmJI
	i8ViuIPt524UHL9J9oGTH1HL5w0L8M4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705445069;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh+oq1spB9mXnL92/e4GJ7ibfkaNrbj9dH8Tk64Djcw=;
	b=HjfwTsYnAa/QGGZbmcPUUDcpirEYaDZy2aVFXUHAzwLEEj1ZabVT5GkD0w3g233fYFYFkp
	/MP1zNcr5sIVRlCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705445069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh+oq1spB9mXnL92/e4GJ7ibfkaNrbj9dH8Tk64Djcw=;
	b=f6Kejs3ynwExykrJLsf6I7d5bcEDabcWJXxJV92F4iHVc7UOqw1z6bgFyUdjZB1nZZzUCy
	uYn6ovQ2wTV5Uxps5LTHqoIi8FbN9c3jpKoKlo+yzVUeHRhsOYMjfowfic3prCOTRXHmJI
	i8ViuIPt524UHL9J9oGTH1HL5w0L8M4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705445069;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh+oq1spB9mXnL92/e4GJ7ibfkaNrbj9dH8Tk64Djcw=;
	b=HjfwTsYnAa/QGGZbmcPUUDcpirEYaDZy2aVFXUHAzwLEEj1ZabVT5GkD0w3g233fYFYFkp
	/MP1zNcr5sIVRlCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCF6513751;
	Tue, 16 Jan 2024 22:44:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nzD3HL8Gp2UWAgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 16 Jan 2024 22:44:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Eric Van Hensbergen" <ericvh@kernel.org>,
 "Latchesar Ionkov" <lucho@ionkov.net>,
 "Dominique Martinet" <asmadeus@codewreck.org>,
 "Christian Schoenebeck" <linux_oss@crudebyte.com>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>, "Xiubo Li" <xiubli@redhat.com>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Alexander Aring" <aahringo@redhat.com>,
 "David Teigland" <teigland@redhat.com>, "Miklos Szeredi" <miklos@szeredi.hu>,
 "Andreas Gruenbacher" <agruenba@redhat.com>,
 "Trond Myklebust" <trond.myklebust@hammerspace.com>,
 "Anna Schumaker" <anna@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Jan Kara" <jack@suse.cz>,
 "Mark Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>,
 "Joseph Qi" <joseph.qi@linux.alibaba.com>, "Steve French" <sfrench@samba.org>,
 "Paulo Alcantara" <pc@manguebit.com>, "Ronnie Sahlberg" <lsahlber@redhat.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
 gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-trace-kernel@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH 20/20] filelock: split leases out of struct file_lock
In-reply-to: <20240116-flsplit-v1-20-c9d0f4370a5d@kernel.org>
References: <20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org>,
 <20240116-flsplit-v1-20-c9d0f4370a5d@kernel.org>
Date: Wed, 17 Jan 2024 09:44:12 +1100
Message-id: <170544505284.23031.2594557379971928071@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -5.32
X-Spamd-Result: default: False [-5.32 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLx183r465j9c4mdtrpq4cws5u)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[46];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,ionkov.net,codewreck.org,crudebyte.com,redhat.com,auristor.com,gmail.com,szeredi.hu,hammerspace.com,oracle.com,netapp.com,talpey.com,suse.cz,fasheh.com,evilplan.org,linux.alibaba.com,samba.org,manguebit.com,microsoft.com,chromium.org,goodmis.org,efficios.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,lists.samba.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[54.77%]
X-Spam-Flag: NO

On Wed, 17 Jan 2024, Jeff Layton wrote:
> Add a new struct file_lease and move the lease-specific fields from
> struct file_lock to it. Convert the appropriate API calls to take
> struct file_lease instead, and convert the callers to use them.

I think that splitting of struct lease_manager_operations out from
lock_manager_operations should be mentioned here too.


> =20
> +struct file_lease {
> +	struct file_lock_core fl_core;
> +	struct fasync_struct *	fl_fasync; /* for lease break notifications */
> +	/* for lease breaks: */
> +	unsigned long fl_break_time;
> +	unsigned long fl_downgrade_time;
> +	const struct lease_manager_operations *fl_lmops;	/* Callbacks for lockman=
agers */

comment should be "Callbacks for leasemanagers".  Or maybe=20
"lease managers".=20

It is unfortunate that "lock" and "lease" both start with 'l' as we now
have two quite different fields in different structures with the same
name - fl_lmops.

NeilBrown

