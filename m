Return-Path: <linux-fsdevel+bounces-74631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGmiGMMRcGlyUwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:37:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A7A4DED8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E84536C0F2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 13:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE56140B6CC;
	Tue, 20 Jan 2026 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SchaW3BI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N/EsPC+f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LFqrPpD5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZhOxoH5m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7971366DD6
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913707; cv=none; b=BpWXo7zsffUJs8hQJ3dEQjrlQA2nUisVTHDb0zOVftvtBvbzdS2beb0oV5kW28eJfjm1MnlFU2rY/J/r67Rre9lU8NiU6tuyDKuU1wDYTsPI8KlRoccPi+ra+KkcYSMuExXFsz3Qbd+BHZ63NICsGPiUEEplGVu6cKmNQeuMg18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913707; c=relaxed/simple;
	bh=YaF1/B0opynjHmYLGPaK1kv2nTeEj3MjZwujVzupTlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgvAIXLZTi72QgqxClcFK+efIcbVsQGbUMcDKi1sK8psUTcVAHrRh6jDt4ibiJIPngfhzusBmdmlw8iOoHA0F2EA82jJVRTPllxIUMe0EBA/U9Z8DHRXpz6PiFVJDthdhMsuoY3Wfues9i4B2YgTln02ES5NSkgrgPZfNxGYbSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SchaW3BI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N/EsPC+f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LFqrPpD5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZhOxoH5m; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0A4A233820;
	Tue, 20 Jan 2026 12:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768913704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gL80up0eVkAVdr7HkA2jeJ7+u2ygb+fw4iPr8b+L/Sw=;
	b=SchaW3BICKbRekiVc7a1qMPCGZ6GwPYtZ9fKpETpxgn4CpXHVJhQxc3qgsm9v0tiSdeXDu
	1l+UNYYsagqEB6hTs5hybNduiwxBZS6bRKpJqbIyQA5QQogzUt2mvgspif2m32pd16lTM2
	8mlwfiVfF//L/2QxB85hXJ0Y1YFlm30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768913704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gL80up0eVkAVdr7HkA2jeJ7+u2ygb+fw4iPr8b+L/Sw=;
	b=N/EsPC+fhDIG9BU81lkHsJAl78JHXa15df3o7dSxU1rTXnEHuPb35nLOxLXNLuZQ/2bN1Y
	l55hltXFh7NwnHCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768913703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gL80up0eVkAVdr7HkA2jeJ7+u2ygb+fw4iPr8b+L/Sw=;
	b=LFqrPpD5bTmmw3qibdF4BaB2QDQXBbdR9uy6P+3pIJwKOVDOAc02wNOGjjocveZYh6PIFe
	UgeWyDtyTfFxfnKgx5ujJP1pzgdYvygO3//FAAFSOUIH7xEtOxv+vXsp7i84jKJbbxCl8C
	EKv6pQdod8tFcYQnDxAC6gEpBHwPvgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768913703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gL80up0eVkAVdr7HkA2jeJ7+u2ygb+fw4iPr8b+L/Sw=;
	b=ZhOxoH5m9dLuR7OrvH79g7Puj4d1l6EfmYIznKwN4+AZGqQVyNHKnm4iksbgy3GCyrK0nm
	2EXo/YFN3xNuVYDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F059F3EA63;
	Tue, 20 Jan 2026 12:55:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sk+tOiZ7b2kBAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 20 Jan 2026 12:55:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B277DA09DA; Tue, 20 Jan 2026 13:55:02 +0100 (CET)
Date: Tue, 20 Jan 2026 13:55:02 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] fsnotify: Use connector hash for destroying inode
 marks
Message-ID: <sig57pv7svl66s3yup5mbot35ze4dggbgtokponcthv5bq3tbq@5ol23mu25igm>
References: <20260119161505.26187-1-jack@suse.cz>
 <20260119171400.12006-5-jack@suse.cz>
 <CAOQ4uxje6rMQGNHKYjjO9_Bw3nZuOTyephS=wcOBJSv+Kh27yQ@mail.gmail.com>
 <56pt2kjxhxhki2vwed4pme4dwefq3uz3pqktb25zekcs2in6nk@mmlns7qnmhxf>
 <CAOQ4uxjCz3X8pV=SgXJLN1A7kWfbH4DnX0R4Q_+CWv2jz03gOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjCz3X8pV=SgXJLN1A7kWfbH4DnX0R4Q_+CWv2jz03gOQ@mail.gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74631-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 02A7A4DED8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue 20-01-26 13:06:32, Amir Goldstein wrote:
> On Tue, Jan 20, 2026 at 1:03 PM Jan Kara <jack@suse.cz> wrote:
> > > > +        */
> > > > +       idx = srcu_read_lock(&fsnotify_mark_srcu);
> > > > +       spin_lock(&sbinfo->list_lock);
> > > > +       while (!list_empty(&sbinfo->inode_conn_list)) {
> > > > +               conn = fsnotify_inode_connector_from_list(
> > > > +                                               sbinfo->inode_conn_list.next);
> > > > +               /* All connectors on the list are still attached to an inode */
> > > > +               inode = conn->obj;
> > > >                 __iget(inode);
> > > > -               spin_unlock(&inode->i_lock);
> > > > -               spin_unlock(&sb->s_inode_list_lock);
> > > > -
> > > > -               iput(iput_inode);
> > > > -
> > > > -               /* for each watch, send FS_UNMOUNT and then remove it */
> > > > +               spin_unlock(&sbinfo->list_lock);
> > > >                 fsnotify_inode(inode, FS_UNMOUNT);
> > > > -
> > > > -               fsnotify_inode_delete(inode);
> > > > -
> > > > -               iput_inode = inode;
> > > > -
> > > > +               fsnotify_destroy_marks(&inode->i_fsnotify_marks);
> > > > +               iput(inode);
> > > >                 cond_resched();
> > > > -               spin_lock(&sb->s_inode_list_lock);
> > > > +               spin_lock(&sbinfo->list_lock);
> > >
> > > The list could be long.
> > > Do we maybe want to avoid holding srcu read for the entire list walk?
> > >
> > > Anyway, with or without, feel free to add:
> > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >
> > Thanks for review! Actually now that I think about it sbinfo->list_lock is
> > enough to protect lifetime of the connector so we don't need srcu at all
> > here. I'll remove it for the next revision.
> 
> OK, in that case, without the need for the comment about
> fsnotify_destroy_marks(), I was going to suggest using the nicer wrapper
> 
> fsnotify_clear_marks_by_inode(inode);

Right, done.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

