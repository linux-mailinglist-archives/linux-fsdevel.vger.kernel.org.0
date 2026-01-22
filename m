Return-Path: <linux-fsdevel+bounces-75033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KblFTkycmmadwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 15:20:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D5867D87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 15:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9DFB0781876
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 12:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE522D9EE8;
	Thu, 22 Jan 2026 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cPAqDkpS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="egvEWqOG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cPAqDkpS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="egvEWqOG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791F9261B8D
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769086128; cv=none; b=eWpzXqhaDGSkM5rnybttciiXahAQR4Xxu5BQRzcRFL199n2Wd3BI7yjxE9ZbSJSWK7hcx9hv+tOIiAx5SSYguMWG9f826Sy52zCGRA6zjOsgNxMsYRubBuzTrjNWzppDvQjVRgrQB7Znaqmw+ov/xc3OD8fHwUYTbwjcZm14rZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769086128; c=relaxed/simple;
	bh=hgrxei/8pUZ0+IU9mMT/FJfPDTAcv2cuwYG3TlCK0BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kY8btvAOSas1aIwKHIF+Va286h62V8ZFWpnYHeQsM3nEZXJcTbrhWsIuHAqlU7BYxCrAs/3kaWwY0cBg7xGWGEW8sgBNKEkuvmC75/sW0nl0jg+nxgOrxRqoOoEHl+UZONVN5cQDrhPmTDbEfNsKuZqng2CGunVU3LHybo1Llt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cPAqDkpS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=egvEWqOG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cPAqDkpS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=egvEWqOG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7BC7B33706;
	Thu, 22 Jan 2026 12:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769086124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIQcEBECAq/TFnuQZqH2HMcX30blPI/mr+FmAJz1rMs=;
	b=cPAqDkpSkwJI23bvv56txf2+XTgBO2HdoWr7qKogEthiBgjHLsO5pvE7+4koZfYpJsloZ3
	vobucYi2jRgYklfiVzuHUmxGYqiXmoE3Y8Zd1v6PXFBH7mf2u8CutD5pV5gYy9bq2TH+BM
	PWVHYiCyoiUk/SNEhrb/UfTGAFKJeAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769086124;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIQcEBECAq/TFnuQZqH2HMcX30blPI/mr+FmAJz1rMs=;
	b=egvEWqOGB7ZgXopmCeDj4G/Nb97vk7mYOsX+9dKCv/inAvZbPg7S5GGtwxFgcwsuUts2bt
	9nm1dJ2qnsmvGGBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cPAqDkpS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=egvEWqOG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769086124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIQcEBECAq/TFnuQZqH2HMcX30blPI/mr+FmAJz1rMs=;
	b=cPAqDkpSkwJI23bvv56txf2+XTgBO2HdoWr7qKogEthiBgjHLsO5pvE7+4koZfYpJsloZ3
	vobucYi2jRgYklfiVzuHUmxGYqiXmoE3Y8Zd1v6PXFBH7mf2u8CutD5pV5gYy9bq2TH+BM
	PWVHYiCyoiUk/SNEhrb/UfTGAFKJeAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769086124;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIQcEBECAq/TFnuQZqH2HMcX30blPI/mr+FmAJz1rMs=;
	b=egvEWqOGB7ZgXopmCeDj4G/Nb97vk7mYOsX+9dKCv/inAvZbPg7S5GGtwxFgcwsuUts2bt
	9nm1dJ2qnsmvGGBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 649B613533;
	Thu, 22 Jan 2026 12:48:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jgqLGKwccmkdHAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Jan 2026 12:48:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0FFFBA09FC; Thu, 22 Jan 2026 13:48:40 +0100 (CET)
Date: Thu, 22 Jan 2026 13:48:40 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] fsnotify: Use connector list for destroying inode
 marks
Message-ID: <yv2vy77alupkcgjkfxarpehe5fhx5ifnh2ufw7m34a6qvw5s42@aksgx2t6rpbv>
References: <20260121135513.12008-1-jack@suse.cz>
 <20260121135948.8448-5-jack@suse.cz>
 <CAOQ4uxg4HrLqizEdgc8TUaZOUbBTR1if0SBSwxeu5VKAwU5FBA@mail.gmail.com>
 <zx4boczfwcbu5a6vcmalup6ogcqlqg2sbn5ex7rbidd3rdwr7s@2exh6w7hypi3>
 <CAOQ4uxiwqerdbR=TrMZwhfCSOn=D-6D6Bx_0Djw1j05WLfzK=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiwqerdbR=TrMZwhfCSOn=D-6D6Bx_0Djw1j05WLfzK=w@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-75033-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D6D5867D87
X-Rspamd-Action: no action

On Thu 22-01-26 11:28:37, Amir Goldstein wrote:
> On Thu, Jan 22, 2026 at 11:04 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 21-01-26 17:27:45, Amir Goldstein wrote:
> > > On Wed, Jan 21, 2026 at 3:00 PM Jan Kara <jack@suse.cz> wrote:
> > > > +               spin_lock(&inode->i_lock);
> > > > +               if (unlikely(
> > > > +                   inode_state_read(inode) & (I_FREEING | I_WILL_FREE))) {
> > > > +                       spin_unlock(&inode->i_lock);
> > > > +                       continue;
> > > > +               }
> > > > +               __iget(inode);
> > > > +               spin_unlock(&inode->i_lock);
> > > > +               spin_unlock(&sbinfo->list_lock);
> > > > +               fsnotify_inode(inode, FS_UNMOUNT);
> > > > +               fsnotify_clear_marks_by_inode(inode);
> > > > +               iput(inode);
> > > > +               cond_resched();
> > > > +               goto restart;
> > > > +       }
> > >
> > > This loop looks odd being a while loop that is always restarted for
> > > the likely branch.
> > >
> > > Maybe would be more clear to add some comment like:
> > >
> > > find_next_inode:
> > >        /* Find the first non-evicting inodes and free connector and marks */
> > >        spin_lock(&sbinfo->list_lock);
> > >        list_for_each_entry(iconn, &sbinfo->inode_conn_list, conns_list) {
> > >
> > > Just a thought.
> >
> > I agree the loop is perverse and I'm not happy about it either (but at
> > least it works :)). With a fresh mind: What about the attached variant?
> 
> This is waaay nicer :)
> 
> I think that we don't need to worry about a hung task warning in
> fsnotify_get_living_inode(), because a long list of evicting inodes
> would be unexpected. Right?

Yes, very much unexpected. If something like that happens, we'll be
probably better off to export the __wait_for_freeing_inode() logic from
core VFS and use it here instead of skipping over freeing inodes. At this
point I find that unnecessary...

> Feel free to add:
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks! So I'll push the changes to my tree.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

