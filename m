Return-Path: <linux-fsdevel+bounces-74634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SF4RFtQwcGkSXAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 02:50:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F14F24F59B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 02:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AEB7D50B897
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 13:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA9C42B747;
	Tue, 20 Jan 2026 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3I/CYS3j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y/t0uyE+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3I/CYS3j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y/t0uyE+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F3C42B74F
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914466; cv=none; b=OuDUSwZl0M1E0ixFStf0MueXFS7akidrkvmTMUSFI2z3wwgdTFAbv4PKjoHX6CQRURpM+sPpRI4WFXq5aRNAtAVr7S1gWJnxS1HCN+8rcCk//35DIaj6GnyuFlwRDsXionutiMVe9x0ZOsxXSmvJf389VKrCk8BA/CKsMK16V2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914466; c=relaxed/simple;
	bh=guxKQTFZluXzKstfQXBa4lNDuzSP5kqYsVgc86ay6mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4RQfOz8lSxoee9/IVd86b2/u4kdcoOhUY2CxuPEcA5K6P/40xPIRyHJZNOfzSGcqCLpqZVqLipbcdiapyn/ymbMwYzSd83z2DaiiVtlKZo4E5BD2IQ4CABOZDTWn6kOkdgO65+Qx44niJiY9KBalF3dL9J1H3VZEaKOInVE8U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3I/CYS3j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y/t0uyE+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3I/CYS3j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y/t0uyE+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9A454337DC;
	Tue, 20 Jan 2026 13:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768914462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b2NmaFxFaBXFXbYYWVbFgcdP+qDUsQpjFq/BiVC1K7E=;
	b=3I/CYS3jR/n8fME73b6yFxfGpGxiY05fFdDwETBXOV6176AKhLqBjzc1GpRQr4O05Vfs9S
	wvnhKWLPLX3oKT6ocufoV0bmYZdCfLefJvyUtnNQeUOkShtbwzWutFb/dxhjbqlDiqx9hi
	J1+HPz/TByiXg8fG3fGLHXzDyzZOsnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768914462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b2NmaFxFaBXFXbYYWVbFgcdP+qDUsQpjFq/BiVC1K7E=;
	b=y/t0uyE+Jwi9xMpsR4+xeTzOAj2VWoZK798k6sOGXlkfYprqhACHQQ9EUM1+XLjtRal4uU
	6BAcRY/bGIQskIDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="3I/CYS3j";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="y/t0uyE+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768914462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b2NmaFxFaBXFXbYYWVbFgcdP+qDUsQpjFq/BiVC1K7E=;
	b=3I/CYS3jR/n8fME73b6yFxfGpGxiY05fFdDwETBXOV6176AKhLqBjzc1GpRQr4O05Vfs9S
	wvnhKWLPLX3oKT6ocufoV0bmYZdCfLefJvyUtnNQeUOkShtbwzWutFb/dxhjbqlDiqx9hi
	J1+HPz/TByiXg8fG3fGLHXzDyzZOsnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768914462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b2NmaFxFaBXFXbYYWVbFgcdP+qDUsQpjFq/BiVC1K7E=;
	b=y/t0uyE+Jwi9xMpsR4+xeTzOAj2VWoZK798k6sOGXlkfYprqhACHQQ9EUM1+XLjtRal4uU
	6BAcRY/bGIQskIDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F2AD3EA63;
	Tue, 20 Jan 2026 13:07:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AkDvIh5+b2knDgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 20 Jan 2026 13:07:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 42299A09DA; Tue, 20 Jan 2026 14:07:42 +0100 (CET)
Date: Tue, 20 Jan 2026 14:07:42 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] fsnotify: Track inode connectors for a superblock
Message-ID: <hkopua34rlgzvy75q4bqqwy7xyuth3jkhgyxjsursoo263vowr@xancmcz6abqh>
References: <20260119161505.26187-1-jack@suse.cz>
 <20260119171400.12006-4-jack@suse.cz>
 <CAOQ4uxirm_zApKhBffJiGWgPi3AR-m3m4ruAFVSkQY7x59CEMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxirm_zApKhBffJiGWgPi3AR-m3m4ruAFVSkQY7x59CEMw@mail.gmail.com>
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74634-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.com:email,suse.cz:email,suse.cz:dkim];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F14F24F59B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue 20-01-26 13:04:27, Amir Goldstein wrote:
> On Mon, Jan 19, 2026 at 6:14 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Introduce a linked list tracking all inode connectors for a superblock.
> > We will use this list when the superblock is getting shutdown to
> > properly clean up all the inode marks instead of relying on scanning all
> > inodes in the superblock which can get rather slow.
> >
> > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
...
> > +static struct fsnotify_mark_connector *
> > +fsnotify_alloc_inode_connector(struct inode *inode)
> > +{
> > +       struct fsnotify_inode_mark_connector *iconn;
> > +       struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(inode->i_sb);
> > +
> > +       iconn = kmem_cache_alloc(fsnotify_inode_mark_connector_cachep,
> > +                                GFP_KERNEL);
> > +       if (!iconn)
> > +               return NULL;
> > +
> > +       fsnotify_init_connector(&iconn->common, inode, FSNOTIFY_OBJ_TYPE_INODE);
> > +       spin_lock(&sbinfo->list_lock);
> > +       list_add(&iconn->conns_list, &sbinfo->inode_conn_list);
> > +       spin_unlock(&sbinfo->list_lock);
> > +       iconn->common.flags |= FSNOTIFY_CONN_FLAG_TRACKED;
> > +
> > +       return &iconn->common;
> > +}
> > +
> > +static void fsnotify_untrack_connector(struct fsnotify_mark_connector *conn)
> > +{
> > +       struct fsnotify_inode_mark_connector *iconn;
> > +       struct fsnotify_sb_info *sbinfo;
> > +
> > +       if (!(conn->flags & FSNOTIFY_CONN_FLAG_TRACKED))
> > +               return;
> 
> Is this condition somehow possible?
> If not, please add a WARN_ON_ONCE or consider dropping the flag
> because it is equivalent to type == FSNOTIFY_OBJ_TYPE_INODE,
> is it not?
> IOW, if conn->obj points to an inode, it is tracked, from alloc() to free().
> 
> Unless I missed something?
> I have no problem with keeping it as a sanity-explicit flag.

No, you're right. Let's replace this with conn->type check. Originally I've
ported this flag when I was creating this commit based on rhashtable code
but then I've realized this simple version cannot observe unattached
connectors in fsnotify_untrack_connector(). So I've ditched some pointless
code but the flag stayed...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

