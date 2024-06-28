Return-Path: <linux-fsdevel+bounces-22760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6454691BD2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 13:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371381C214F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 11:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B330156237;
	Fri, 28 Jun 2024 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wiKoSuo7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="shKHQb+W";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wiKoSuo7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="shKHQb+W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFC914F9F2;
	Fri, 28 Jun 2024 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719573238; cv=none; b=hJ+5H00PgHji5O55VD1rqMSgtvFua8xen1CEyF6mbMB/iSSBqsqytsJZYyTjxCWKBMncNHnv0mwCxr6NQQqI8wlVtR2hiK4oUxgsi57Qmf8W6Ve6ILqj22DygfFaVIxki7PdHwnXbn1CDip1Vr3yrgGKc8Cw/kaN/VOY2rNUAKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719573238; c=relaxed/simple;
	bh=MuriAqX618t8StIaVZuupMBbbg4WrxyKt9NA3Tb2N4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTNJCQzlxAPhkBuzqK/iKzAauwY/xf01jEbaxMgLw23zLX8Jz8NKLT1FJ9N1UswnT9hDew763umaGZc1C3p7uYdYAlKEtw/wD8JFNIAreAm28yGL8FKQug9CnysHLwO1za5Pjq2JomGuO/uepcLFOl1VjyXDoDtRGJc1SDaU7t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wiKoSuo7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=shKHQb+W; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wiKoSuo7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=shKHQb+W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2DB3B1F441;
	Fri, 28 Jun 2024 11:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719573234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iSabMPYZH3IQ9skkdgGwlpc9kmhikVgNIgrANj0iNso=;
	b=wiKoSuo7uhWB/poWLfuJK+j7kpWmZXaYb8n21lplFeGLcX/eAru1tTO6IqNgzrl3SDNji/
	1WfTAWfTO+W1pDrv0IKdHnia9axR8tyY3Q+2htUI/dpY6lJboHU0rab0Aflz4kmgL6u1yr
	gpc0thKIM9+b+ltennYhNpp1Hl1Yh08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719573234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iSabMPYZH3IQ9skkdgGwlpc9kmhikVgNIgrANj0iNso=;
	b=shKHQb+WUGwVaCTGkuqrnkWxCXFEoTWaoC8atyu6UscfQ8NWB2SMF05BaLs8ArKoBgpgSv
	CQVa+1LoWXcCyVDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719573234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iSabMPYZH3IQ9skkdgGwlpc9kmhikVgNIgrANj0iNso=;
	b=wiKoSuo7uhWB/poWLfuJK+j7kpWmZXaYb8n21lplFeGLcX/eAru1tTO6IqNgzrl3SDNji/
	1WfTAWfTO+W1pDrv0IKdHnia9axR8tyY3Q+2htUI/dpY6lJboHU0rab0Aflz4kmgL6u1yr
	gpc0thKIM9+b+ltennYhNpp1Hl1Yh08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719573234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iSabMPYZH3IQ9skkdgGwlpc9kmhikVgNIgrANj0iNso=;
	b=shKHQb+WUGwVaCTGkuqrnkWxCXFEoTWaoC8atyu6UscfQ8NWB2SMF05BaLs8ArKoBgpgSv
	CQVa+1LoWXcCyVDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 203D813A9A;
	Fri, 28 Jun 2024 11:13:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rbraB/KafmbjVAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 28 Jun 2024 11:13:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A4950A088E; Fri, 28 Jun 2024 13:13:45 +0200 (CEST)
Date: Fri, 28 Jun 2024 13:13:45 +0200
From: Jan Kara <jack@suse.cz>
To: Ian Kent <ikent@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	Lucas Karpinski <lkarpins@redhat.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, raven@themaw.net, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alexander Larsson <alexl@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Subject: Re: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
Message-ID: <20240628111345.3bbcgie4gar6icyj@quack3>
References: <20240626201129.272750-2-lkarpins@redhat.com>
 <20240626201129.272750-3-lkarpins@redhat.com>
 <Znx-WGU5Wx6RaJyD@casper.infradead.org>
 <50512ec3-da6d-4140-9659-58e0514a4970@redhat.com>
 <20240627115418.lcnpctgailhlaffc@quack3>
 <cfda4682-34b4-462c-acf6-976b0d79ba06@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfda4682-34b4-462c-acf6-976b0d79ba06@redhat.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Fri 28-06-24 10:58:54, Ian Kent wrote:
> 
> On 27/6/24 19:54, Jan Kara wrote:
> > On Thu 27-06-24 09:11:14, Ian Kent wrote:
> > > On 27/6/24 04:47, Matthew Wilcox wrote:
> > > > On Wed, Jun 26, 2024 at 04:07:49PM -0400, Lucas Karpinski wrote:
> > > > > +++ b/fs/namespace.c
> > > > > @@ -78,6 +78,7 @@ static struct kmem_cache *mnt_cache __ro_after_init;
> > > > >    static DECLARE_RWSEM(namespace_sem);
> > > > >    static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
> > > > >    static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
> > > > > +static bool lazy_unlock = false; /* protected by namespace_sem */
> > > > That's a pretty ugly way of doing it.  How about this?
> > > Ha!
> > > 
> > > That was my original thought but I also didn't much like changing all the
> > > callers.
> > > 
> > > I don't really like the proliferation of these small helper functions either
> > > but if everyone
> > > 
> > > is happy to do this I think it's a great idea.
> > So I know you've suggested removing synchronize_rcu_expedited() call in
> > your comment to v2. But I wonder why is it safe? I *thought*
> > synchronize_rcu_expedited() is there to synchronize the dropping of the
> > last mnt reference (and maybe something else) - see the comment at the
> > beginning of mntput_no_expire() - and this change would break that?
> 
> Interesting, because of the definition of lazy umount I didn't look closely
> enough at that.
> 
> But I wonder, how exactly would that race occur, is holding the rcu read
> lock sufficient since the rcu'd mount free won't be done until it's
> released (at least I think that's how rcu works).

I'm concerned about a race like:

[path lookup]				[umount -l]
...
path_put()
  mntput(mnt)
    mntput_no_expire(m)
      rcu_read_lock();
      if (likely(READ_ONCE(mnt->mnt_ns))) {
					do_umount()
					  umount_tree()
					    ...
					    mnt->mnt_ns = NULL;
					    ...
					  namespace_unlock()
					    mntput(&m->mnt)
					      mntput_no_expire(mnt)
				              smp_mb();
					      mnt_add_count(mnt, -1);
					      count = mnt_get_count(mnt);
					      if (count != 0) {
						...
						return;
        mnt_add_count(mnt, -1);
        rcu_read_unlock();
        return;
-> KABOOM, mnt->mnt_count dropped to 0 but nobody cleaned up the mount!
      }

And this scenario is exactly prevented by synchronize_rcu() in
namespace_unlock().


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

