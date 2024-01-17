Return-Path: <linux-fsdevel+bounces-8195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9817830D0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 19:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B79C28A547
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 18:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA899249F1;
	Wed, 17 Jan 2024 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bokyynVi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Hf1fhwne";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bokyynVi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Hf1fhwne"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FBA24215;
	Wed, 17 Jan 2024 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705517964; cv=none; b=LrtjQOe8GZXDE69Fe/TLGgY9ksw0n/huaz+NBFnASGVR7UQPxbsB5xeb+3t7CNymmlXwc7bbl0iVRSLseaebxUCiFGnmTG6A8QBtEXWnT4I80eqfN7CWsAfHBWUwKXZuDrZVAa5cNWXIp+m5NCAp2h3F5ELo5y5FeRqRXJaSNsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705517964; c=relaxed/simple;
	bh=y5ipUQurDVauXRqc8laDxRO7z7X/T9tYZni+X4r3YoM=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:From:To:Cc:Subject:
	 In-reply-to:References:Date:Message-id:X-Spamd-Result:
	 X-Rspamd-Server:X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Spam-Flag:X-Spamd-Bar; b=Gx947A3NTyqn1HcmucYYtjj0oToF2y6+0cjswzQUuBFXStsGKk9h4FboTm1WPQa2RA4j1JkJxA2Nuoe8odPBFN32UxYae0kGioR1jjQ6Js9ocvbPqNe8e6Nx2d2VAn3PuQazrdfgXIUDjI5/b4EJWhbE6qa76llWTy8Q4FkoIp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bokyynVi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Hf1fhwne; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bokyynVi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Hf1fhwne; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 849632201D;
	Wed, 17 Jan 2024 18:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705517960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=noM15di5cvIK0OqUnGYNFVuIuKXsDIbW7D9yrRXfJBA=;
	b=bokyynViqgWX8EwZm5wi+bXf0WXQPO7hu/kzla1s8MixAeY1EXZAlg/ZVB9bTSXAATCwtk
	+QgcL9zApBk82BcwqNZEpb17YPvOhf8ZF2h4JEjGEdk/eA/Ma5fOpOrHK/y3V7ZxmCQ8fT
	ePJgvv+xyJuaKLOyJ1HO5zFmKxp3w6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705517960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=noM15di5cvIK0OqUnGYNFVuIuKXsDIbW7D9yrRXfJBA=;
	b=Hf1fhwne1mFJ9AqrYL68FzLRplqkLHg7BJlTDQKeP4RNvybhIcstU403RdcOuRzmKZHmZU
	8gCjUq7Vg4E/WTAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705517960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=noM15di5cvIK0OqUnGYNFVuIuKXsDIbW7D9yrRXfJBA=;
	b=bokyynViqgWX8EwZm5wi+bXf0WXQPO7hu/kzla1s8MixAeY1EXZAlg/ZVB9bTSXAATCwtk
	+QgcL9zApBk82BcwqNZEpb17YPvOhf8ZF2h4JEjGEdk/eA/Ma5fOpOrHK/y3V7ZxmCQ8fT
	ePJgvv+xyJuaKLOyJ1HO5zFmKxp3w6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705517960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=noM15di5cvIK0OqUnGYNFVuIuKXsDIbW7D9yrRXfJBA=;
	b=Hf1fhwne1mFJ9AqrYL68FzLRplqkLHg7BJlTDQKeP4RNvybhIcstU403RdcOuRzmKZHmZU
	8gCjUq7Vg4E/WTAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A4A013800;
	Wed, 17 Jan 2024 18:59:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QSC0NHojqGUyWwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 17 Jan 2024 18:59:06 +0000
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
 "Ronnie Sahlberg" <lsahlber@redhat.com>,
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
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 00/20] filelock: split struct file_lock into file_lock and
 file_lease structs
In-reply-to: <ZafuXpR4Y8Y6HFFl@tissot.1015granger.net>
References: <20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org>,
 <ZafuXpR4Y8Y6HFFl@tissot.1015granger.net>
Date: Thu, 18 Jan 2024 05:59:04 +1100
Message-id: <170551794427.23031.1969485804246583443@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bokyynVi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Hf1fhwne
X-Spamd-Result: default: False [-0.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn),to_ip_from(RLouahofup1mwqksbidco3ksry)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[45];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,ionkov.net,codewreck.org,crudebyte.com,redhat.com,auristor.com,gmail.com,szeredi.hu,hammerspace.com,netapp.com,oracle.com,talpey.com,suse.cz,fasheh.com,evilplan.org,linux.alibaba.com,samba.org,manguebit.com,microsoft.com,chromium.org,goodmis.org,efficios.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,lists.samba.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[16.90%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.31
X-Rspamd-Queue-Id: 849632201D
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Thu, 18 Jan 2024, Chuck Lever wrote:
> On Tue, Jan 16, 2024 at 02:45:56PM -0500, Jeff Layton wrote:
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
> 
> Naive question: locks and leases are similar. Why do they need to be
> split apart? The cover letter doesn't address that, and I'm new
> enough at this that I don't have that context.

For me, the big win was in the last patch where we got separate
lock_manager_operations and lease_manager_operations.  There is zero
overlap between the two.  This highlights that one one level these are
different things with different behaviours.

NeilBrown

