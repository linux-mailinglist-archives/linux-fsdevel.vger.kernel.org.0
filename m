Return-Path: <linux-fsdevel+bounces-9013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D9D83CF78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 23:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52AAD1F21D17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 22:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51C712B8D;
	Thu, 25 Jan 2024 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZOUobf0e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yUs2jVJK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZOUobf0e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yUs2jVJK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4660E10A29;
	Thu, 25 Jan 2024 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706222105; cv=none; b=TpgYWzEsZHfp7I3zkL5TOOBI5JoJYGvPlMWhaKlC8qSmf/EATQCAmVKaHHxNUVtBdCHtHCvj8mTRbObp70pp1uLi3Z/AcOssid/Z6naXe2eLSu6OQSlfInMeu0l1Y/Pxxg44CylzPNTziQtaKlCoHzzK7k0lCE7GemMKEy+v5x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706222105; c=relaxed/simple;
	bh=YOkDgAPOGX+3yUf289GizPduKRrR4GYqFGRb1/Oir2U=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=BOKjeYDZznwYiSetYuYS9/XpDfU1H4Ur4A+FjSLKJ2E5Jm7JejQKXVENYPr33bOJYzPgsdmNdI5VFcOpM/4q1v59ld2ZL9yti+/d7hiuoGflqGOhGHi8+KFGZ0Ow88zvjT2SMyejYVEcfcrq+0AMfVwPnv2x4b84sKMquqgfbQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZOUobf0e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yUs2jVJK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZOUobf0e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yUs2jVJK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E89982242E;
	Thu, 25 Jan 2024 22:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706222100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dEF3qBSHdfhxWr1uVJuvK+HFHBusGPLQ/NY34eH+fno=;
	b=ZOUobf0eU0MWWTPmMuXuzwMUzRextIfV7U4/QyxXhdOjHBiFji3EwFBX7kg1iz/tfpPG97
	uqvsCjVpcRVGComQR9QvHmnHZnFB79gp8WWzLYuSsNSBTEtVontA2YPDN0K8xZc6RBTsCv
	tJRXK0vq6KFVnmcUAZ23T0+eOf9/kEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706222100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dEF3qBSHdfhxWr1uVJuvK+HFHBusGPLQ/NY34eH+fno=;
	b=yUs2jVJKRMZgaKFPPbx+hxBGNQ7msdbJoZQWI4olnt/4Kde8HDKlyDI3CACVd0MAur9enF
	gbu4zVRHF6YchcBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706222100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dEF3qBSHdfhxWr1uVJuvK+HFHBusGPLQ/NY34eH+fno=;
	b=ZOUobf0eU0MWWTPmMuXuzwMUzRextIfV7U4/QyxXhdOjHBiFji3EwFBX7kg1iz/tfpPG97
	uqvsCjVpcRVGComQR9QvHmnHZnFB79gp8WWzLYuSsNSBTEtVontA2YPDN0K8xZc6RBTsCv
	tJRXK0vq6KFVnmcUAZ23T0+eOf9/kEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706222100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dEF3qBSHdfhxWr1uVJuvK+HFHBusGPLQ/NY34eH+fno=;
	b=yUs2jVJKRMZgaKFPPbx+hxBGNQ7msdbJoZQWI4olnt/4Kde8HDKlyDI3CACVd0MAur9enF
	gbu4zVRHF6YchcBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F01313649;
	Thu, 25 Jan 2024 22:34:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pwa1MQbismWjYAAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 25 Jan 2024 22:34:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>,
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
 "Anna Schumaker" <anna@kernel.org>, "Olga Kornievskaia" <kolga@netapp.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Jan Kara" <jack@suse.cz>, "Mark Fasheh" <mark@fasheh.com>,
 "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>,
 "Steve French" <sfrench@samba.org>, "Paulo Alcantara" <pc@manguebit.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Ronnie Sahlberg" <ronniesahlberg@gmail.com>, linux-kernel@vger.kernel.org,
 v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
 ceph-devel@vger.kernel.org, gfs2@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/41] filelock: split struct file_lock into file_lock
 and file_lease structs
In-reply-to: <ZbJ2zc3I3uBwF/RE@tissot.1015granger.net>
References: <20240125-flsplit-v2-0-7485322b62c7@kernel.org>,
 <ZbJ2zc3I3uBwF/RE@tissot.1015granger.net>
Date: Fri, 26 Jan 2024 09:34:43 +1100
Message-id: <170622208395.21664.2510213291504081000@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZOUobf0e;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yUs2jVJK
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLouahofup1mwqksbidco3ksry)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[44];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,ionkov.net,codewreck.org,crudebyte.com,redhat.com,auristor.com,gmail.com,szeredi.hu,hammerspace.com,netapp.com,oracle.com,talpey.com,suse.cz,fasheh.com,evilplan.org,linux.alibaba.com,samba.org,manguebit.com,microsoft.com,chromium.org,goodmis.org,efficios.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: E89982242E
X-Spam-Flag: NO

On Fri, 26 Jan 2024, Chuck Lever wrote:
> On Thu, Jan 25, 2024 at 05:42:41AM -0500, Jeff Layton wrote:
> > Long ago, file locks used to hang off of a singly-linked list in struct
> > inode. Because of this, when leases were added, they were added to the
> > same list and so they had to be tracked using the same sort of
> > structure.
> > 
> > Several years ago, we added struct file_lock_context, which allowed us
> > to use separate lists to track different types of file locks. Given
> > that, leases no longer need to be tracked using struct file_lock.
> > 
> > That said, a lot of the underlying infrastructure _is_ the same between
> > file leases and locks, so we can't completely separate everything.
> > 
> > This patchset first splits a group of fields used by both file locks and
> > leases into a new struct file_lock_core, that is then embedded in struct
> > file_lock. Coccinelle was then used to convert a lot of the callers to
> > deal with the move, with the remaining 25% or so converted by hand.
> > 
> > It then converts several internal functions in fs/locks.c to work
> > with struct file_lock_core. Lastly, struct file_lock is split into
> > struct file_lock and file_lease, and the lease-related APIs converted to
> > take struct file_lease.
> > 
> > After the first few patches (which I left split up for easier review),
> > the set should be bisectable. I'll plan to squash the first few
> > together to make sure the resulting set is bisectable before merge.
> > 
> > Finally, I left the coccinelle scripts I used in tree. I had heard it
> > was preferable to merge those along with the patches that they
> > generate, but I wasn't sure where they go. I can either move those to a
> > more appropriate location or we can just drop that commit if it's not
> > needed.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> 
> v2 looks nicer.
> 
> I would add a few list handling primitives, as I see enough
> instances of list_for_each_entry, list_for_each_entry_safe,
> list_first_entry, and list_first_entry_or_null on fl_core.flc_list
> to make it worth having those.
> 
> Also, there doesn't seem to be benefit for API consumers to have to
> understand the internal structure of struct file_lock/lease to reach
> into fl_core. Having accessor functions for common fields like
> fl_type and fl_flags could be cleaner.

I'm not a big fan of accessor functions.  They don't *look* like normal
field access, so a casual reader has to go find out what the function
does, just to find the it doesn't really do anything.

But neither am I a fan have requiring filesystems to use
"fl_core.flc_foo".  As you say, reaching into fl_core isn't ideal.

It would be nice if we could make fl_core and anonymous structure, but
that really requires -fplan9-extensions which Linus is on-record as not
liking.
Unless...

How horrible would it be to use

   union {
       struct file_lock_core flc_core;
       struct file_lock_core;
   };

I think that only requires -fms-extensions, which Linus was less
negative towards.  That would allow access to the members of
file_lock_core without the "flc_core." prefix, but would still allow
getting the address of 'flc_core'.
Maybe it's too ugly.

While fl_type and fl_flags are most common, fl_pid, fl_owner, fl_file
and even fl_wait are also used.  Having accessor functions for all of those
would be too much I think.

Maybe higher-level functions which meet the real need of the filesystem
might be a useful approach:

 locks_wakeup(lock)
 locks_wait_interruptible(lock, condition)
 locks_posix_init(lock, type, pid, ...) ??
 locks_is_unlock() - fl_type is compared with F_UNLCK 22 times.

While those are probably a good idea, through don't really help much
with reducing the need for accessor functions.

I don't suppose we could just leave the #defines in place?  Probably not
a good idea.

Maybe spell "fl_core" as "c"?  lk->c.flc_flags ???


And I wonder if we could have a new fl_flag for 'FOREIGN' locks rather
than encoding that flag in the sign of the pid.  That seems a bit ...
clunky?

NeilBrown


