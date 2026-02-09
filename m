Return-Path: <linux-fsdevel+bounces-76698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAbeNb7WiWnZCAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 13:44:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBC110EE4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 13:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC6EE30157DC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 11:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8C725D216;
	Mon,  9 Feb 2026 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kiqlLj/L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cSIkMvd+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kiqlLj/L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cSIkMvd+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D0C36EA98
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770636534; cv=none; b=Bt5uMp9FkAHMqb0Q92Wrl5Zmx332P+dfJdbt0nbSBlMoUNWcMwwNJzZkP0XxSOj12jlUMJXyW4RI5gZdOpak1RYhjCTfKAwgQ0zlICIG1u1EJSvwz23KmckE6fRQDikHWegsUpP3Q1bvE1952pgskjpDqwFtbMnd4YCAMgWA/kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770636534; c=relaxed/simple;
	bh=1zaqITieQNkgMziduoZI/dVIuTvEqRCK1r4c8nOVtds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJEe33sScA+LkXf/BsW+S5vLIxhWO3WrYLoc2t61wKGrkoEHa7VSi/Ymrne9teABU7w8sXcgq0yKvYdwcl7fxQhFw2YBvJXWHPqyPxwCId4wgeL9Jn3E2QIOV3Ec1him4DijZQfKdoYnoPdK5FUYf19nG98hsvd4sjJGOiPfVJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kiqlLj/L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cSIkMvd+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kiqlLj/L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cSIkMvd+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 876E95BD10;
	Mon,  9 Feb 2026 11:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770636532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OzlQrhAOB0G6tZe8ExjaUd0JTAYTy0qS2QjfxPtG3Wk=;
	b=kiqlLj/LfHLDBmggXQwQQ+3MbuzoI8cx0FaKVOXEYkDlTvlQ06Brrna3iJ2qL8qWzrFSB2
	kgJl/vGhRfZ+4ZiMgkO07AGkAwXNWB7xQ6qhgQUvopWF7S5lb5WBKkggIqfHMOdfGRr79F
	c1u2AHo6y+qBVreo3aVeJ0z7NZo2Q+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770636532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OzlQrhAOB0G6tZe8ExjaUd0JTAYTy0qS2QjfxPtG3Wk=;
	b=cSIkMvd+eMW9Au2DQjCjHT1rD6oHSWQeT6WJ8jc0kxm9pgiEPencXkyRW/oq87Pw68mmw5
	eUXntGC0QVlD8zCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="kiqlLj/L";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cSIkMvd+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770636532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OzlQrhAOB0G6tZe8ExjaUd0JTAYTy0qS2QjfxPtG3Wk=;
	b=kiqlLj/LfHLDBmggXQwQQ+3MbuzoI8cx0FaKVOXEYkDlTvlQ06Brrna3iJ2qL8qWzrFSB2
	kgJl/vGhRfZ+4ZiMgkO07AGkAwXNWB7xQ6qhgQUvopWF7S5lb5WBKkggIqfHMOdfGRr79F
	c1u2AHo6y+qBVreo3aVeJ0z7NZo2Q+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770636532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OzlQrhAOB0G6tZe8ExjaUd0JTAYTy0qS2QjfxPtG3Wk=;
	b=cSIkMvd+eMW9Au2DQjCjHT1rD6oHSWQeT6WJ8jc0kxm9pgiEPencXkyRW/oq87Pw68mmw5
	eUXntGC0QVlD8zCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 743E93EA63;
	Mon,  9 Feb 2026 11:28:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id isZUHPTEiWnzXgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Feb 2026 11:28:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 38953A061E; Mon,  9 Feb 2026 12:28:52 +0100 (CET)
Date: Mon, 9 Feb 2026 12:28:52 +0100
From: Jan Kara <jack@suse.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, Linux NFS list <linux-nfs@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [LSF/MM/BPF TOPIC] xattr caching
Message-ID: <z24xrtha2ha4ppxomzcqzdkevgtpoiazwb2aehfocyfqwnhkoe@clrijunqda67>
References: <CAJfpegu0PrfCemFdimcvDfw6BZ2R5=kaZ=Zrt6U5T37W=mfEAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegu0PrfCemFdimcvDfw6BZ2R5=kaZ=Zrt6U5T37W=mfEAw@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76698-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5EBC110EE4C
X-Rspamd-Action: no action

On Mon 09-02-26 10:46:54, Miklos Szeredi wrote:
> I'm looking at implementing xattr caching for fuse and wondering how to
> do this.
> 
> Why is there no common infrastructure?

As you write below, accessing xattrs is relatively rare. Also frequently
accessed information stored in xattrs (such as ACLs) are generally cached
in the layer handling them. Finally, e.g. ext4 ends up caching xattrs in
the buffer cache / page cache as any other metadata. So I guess the
practical gains from such layer won't be generally big?

> Should we create one?

I'm not against such layer but it would be good to define about which
practical workloads we care and see how much we can gain with such
caching...

> What currently exists:
> 
> - mb_cache for ext2/4.  This seems to be used for deduplicating data,
> so it's no good for fuse, afaics.

Yes, this is about deduplication of identical sets of xattrs among inodes.
Furthermore it is currently kind of specific to ext4 on-disk format.

> - simple_xattr for tmpfs/kernfs. This looks good, except it doesn't
> have a shrinker, for obvious reasons.
> 
> - nfs4_xattr_cache for nfs. I don't really understand the design
> choice of separate cache tables for each inode, which seems wasteful
> for the common case of just a couple of xattrs per inode(*).
> 
> Without having looked deeply at each implementation, I'd think that
> combining the features of all of the above into a common utility would
> make sense.
> 
> Large, multi page xattrs (which I haven't seen in the wild, but I'm
> sure they are out there) should be cached similarly to file data.
> Small values could be stored "inline".
> 
> Deduplication of keys, values and lists is probably also useful.
> 
> Shrinking would not be used for tmpfs and kin, just like the other caches.
> 
> Any other considerations?

As I wrote above, I'm just not sure about the load that would measurably
benefit from this. Otherwise it sounds as a fine idea.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

