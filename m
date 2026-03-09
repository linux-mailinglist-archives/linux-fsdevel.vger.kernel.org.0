Return-Path: <linux-fsdevel+bounces-79791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO3hGozermm/JQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 15:51:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0615623AEC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 15:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95DB130634C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 14:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758AF3D349D;
	Mon,  9 Mar 2026 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LdlaWqYP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IE/omseZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BkWjcn1Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+W6jIuNc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E14389E16
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067593; cv=none; b=sfrteFZZ6AQf21zyVKmgBQoyFLkcboV3L4RvcOpUeuvw0nIO2aWon4AtiX95csUFVaO2J47pX1gstEutHdGbSsub0Jowq7ayCdrO2QgcN9BKMQzxk7cP+61FampKcf67jVd2b2Icfx+GKasm6RRTQT9ExUai3w7IA6jCBiL4L0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067593; c=relaxed/simple;
	bh=P43d7cRAiqeOH+ZlCkpK1DAFw3SJGnd6g+OmDbih+DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQnUiD6lt5J2bAxD5ZvEd2bVzgWMmfevPBQsGZAkSC58H3Pk9hSTG+4bVQpm7AJyXPSCkNo2HKokpa2jhMEZOzGPHuJ291xasQfGQ64dbgPJeQ1yRLbAOv0ALzsOE6rf8yV1FgOIA246vCC0q8wXFBDQr18S40QQA1MqFIHYH7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LdlaWqYP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IE/omseZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BkWjcn1Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+W6jIuNc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8FB3E5BE29;
	Mon,  9 Mar 2026 14:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773067588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZ9IDB4ziHA3T0JifdVk3185gR+WO87Rc4mv0vS5fyc=;
	b=LdlaWqYP9KDHtj/06QouX2wI/Up91ofgxuQxHf8B8o0Y9r6pg/f4RuCaqJE+0k/Pt1HCdg
	fkBPJbykwjf+vRmpRbAoyi7reUMCSnWCNcAhrvgerMjWKjBAutfgiX1MlFsCIe1zOvUcdJ
	8cLciHM8XzXRHUtlU5seLlxrV1//f6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773067588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZ9IDB4ziHA3T0JifdVk3185gR+WO87Rc4mv0vS5fyc=;
	b=IE/omseZFdhcSF5UB3c/uEcSoxYbrqmXoLWHFP0t0z18/PQo7dO5RndPDyjOWi3Dciu8qs
	8kS2eRx+FYpjtcBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BkWjcn1Q;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+W6jIuNc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773067587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZ9IDB4ziHA3T0JifdVk3185gR+WO87Rc4mv0vS5fyc=;
	b=BkWjcn1QQJbqadJ4tda56Kx2oWgM59VqKJQ9oLyk334h2lSwHkjMqDRf13veXOuAjoUmjr
	kWQb4Y0oLaA+lIx+rHcn3di6697ATjfNauwM4UbU4QnKYi4ucI74nu1VeqaF1b8sfYewlg
	pahiHFaBMiu6D/0Ay18dFsAluWPSHno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773067587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZ9IDB4ziHA3T0JifdVk3185gR+WO87Rc4mv0vS5fyc=;
	b=+W6jIuNcBb+UkfYCXxrLGOVcYnGR2xqsOby8JOmfjdsse2f9zsy1mzxC0f9CI3YovuSwd8
	+uJZBkStNQYGnLCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8625A3EF56;
	Mon,  9 Mar 2026 14:46:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C5+6IEPdrmmKWwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Mar 2026 14:46:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3E3D4A09C2; Mon,  9 Mar 2026 15:46:27 +0100 (CET)
Date: Mon, 9 Mar 2026 15:46:27 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: remove externs from fs.h on functions modified
 by i_ino widening
Message-ID: <mkgjambnzw35slfb3vens5tlsugxpjg7q7cckrmwj426ot4x4b@acvye7cjmzde>
References: <20260307-iino-u64-v2-1-a1a1696e0653@kernel.org>
 <urwtj2zfmxfhksormxkzb2z26a7nt5vesbkuwtow47fflf4u2l@x7cbae5dv7tr>
 <c73452245cd85a75bbfc12b31b940641352fb979.camel@kernel.org>
 <wlwvnfrhpw4yyzdnxte73nv6rs5lh2jilvnfd2mtocyct4jyel@4l4km3lehq2c>
 <214341c4753f7ce61d9b01155e9c493e880b7bbd.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <214341c4753f7ce61d9b01155e9c493e880b7bbd.camel@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 0615623AEC3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_FROM(0.00)[bounces-79791-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lst.de:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.940];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon 09-03-26 09:27:47, Jeff Layton wrote:
> On Mon, 2026-03-09 at 13:27 +0100, Jan Kara wrote:
> > On Mon 09-03-26 07:53:51, Jeff Layton wrote:
> > > On Mon, 2026-03-09 at 11:02 +0100, Jan Kara wrote:
> > > > On Sat 07-03-26 14:54:31, Jeff Layton wrote:
> > > > > Christoph says, in response to one of the patches in the i_ino widening
> > > > > series, which changes the prototype of several functions in fs.h:
> > > > > 
> > > > >     "Can you please drop all these pointless externs while you're at it?"
> > > > > 
> > > > > Remove extern keyword from functions touched by that patch (and a few
> > > > > that happened to be nearby). Also add missing argument names to
> > > > > declarations that lacked them.
> > > > > 
> > > > > Suggested-by: Christoph Hellwig <hch@lst.de>
> > > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ...
> > > > > -extern void inode_init_once(struct inode *);
> > > > > -extern void address_space_init_once(struct address_space *mapping);
> > > > > -extern struct inode * igrab(struct inode *);
> > > > > -extern ino_t iunique(struct super_block *, ino_t);
> > > > > -extern int inode_needs_sync(struct inode *inode);
> > > > > -extern int inode_just_drop(struct inode *inode);
> > > > > +void inode_init_once(struct inode *inode);
> > > > > +void address_space_init_once(struct address_space *mapping);
> > > > > +struct inode *igrab(struct inode *inode);
> > > > > +ino_t iunique(struct super_block *sb, ino_t max_reserved);
> > > > 
> > > > I've just noticed that we probably forgot to convert iunique() to use u64
> > > > for inode numbers... Although the iunique() number allocator might prefer
> > > > to stay within 32 bits, the interfaces should IMO still use u64 for
> > > > consistency.
> > > > 
> > > 
> > > I went back and forth on that one, but I left iunique() changes off
> > > since they weren't strictly required. Most filesystems that use it
> > > won't have more than 2^32 inodes anyway.
> > > 
> > > If they worked before with iunique() limited to 32-bit values, they
> > > should still after this. After the i_ino widening we could certainly
> > > change it to return a u64 though.
> > 
> > Yes, it won't change anything wrt functionality. I just think that if we go
> > for "ino_t is the userspace API type and kernel-internal inode numbers
> > (i.e.  what gets stored in inode->i_ino) are passed as u64", then this
> > place should logically have u64...
> > 
> 
> I think we'll need a real plan for this.

<snip claude analysis>
 
> It certainly wouldn't hurt to make these functions return a u64 type,
> but I worry a little about letting them return values bigger than
> UINT_MAX:
> 
> One of my very first patches was 866b04fccbf1 ("inode numbering: make
> static counters in new_inode and iunique be 32 bits"), and it made
> get_next_ino() and iunique() always return 32 bit values. 
> 
> At the time, 32-bit machines and legacy binaries were a lot more
> prevalent than they are today and this was real problem. I'm guessing
> it's not so much today, so we could probably make them return real 64-
> bit values. That might also obviate the need for locking in these
> functions too.

Hum, I think I still didn't express myself clearly enough. I *don't* want
to change values returned from get_next_ino() or iunique(). I would leave
that for the moment when someone comes with a need for more than 4 billions
of inodes in a filesystem using these (which I think is still quite a few
years away). All I want is that in-kernel inode number is consistently
passed as u64 and not as ino_t. So all I ask for is this diff:

- ino_t iunique(struct super_block *sb, ino_t max_reserved)
+ u64 iunique(struct super_block *sb u64 max_reserved)
...
 	static unsigned int counter;
-	ino_t res;
+	u64 res;

and that's it. I.e., the 'counter' variable that determines max value of
returned number stays as unsigned int.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

