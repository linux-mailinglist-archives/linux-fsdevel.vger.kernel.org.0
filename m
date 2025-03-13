Return-Path: <linux-fsdevel+bounces-43934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C825FA5FDB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 18:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097A9421BBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C6E1632C7;
	Thu, 13 Mar 2025 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Oc6u9XlG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9N9Q6KgL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Oc6u9XlG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9N9Q6KgL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E28178F4C
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886722; cv=none; b=JrpnjHTZHoIjfOmXugCyFEEjmXfMeuYXVGDfw56CVrLspuwhgAuQcxTOEjGgL9I9bdHDEy3SI0B6rY+otVrHTydm5EM8zt60Hem15YcpCNSMvESOCcwx721w3VKjT549Uq/3d+aU4Cmsjw31EanH6hlV086lwnxo0PtqKFD9SIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886722; c=relaxed/simple;
	bh=A55CczTT94DvNSr0wJ9e4J0r+IBXgSrnu/nteMaOeWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/8eQaOsd6c38ybgU2lnnQ4xHr+YxEJ/DXzWdVY+7F3MPP36+tur4sqle/xUaaeBBJmdlu9Zp0E0jFBNVlY6mCn59HKOdrUxPRiUqGEtcjKJuzTpIRiqFNOePfii+FnzbA7+4hgtnuqb2KBqT7sokyM5XMG0opKnYJWjV46cW2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Oc6u9XlG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9N9Q6KgL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Oc6u9XlG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9N9Q6KgL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 998DD2116E;
	Thu, 13 Mar 2025 17:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741886718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rb66SVEbSSUP5qA+Mp4cXnC0KPLqlP7nV4rllQzAPUI=;
	b=Oc6u9XlGjeb/RW7pWUKFQkfpdbRA/gyNP+2QjD401EB3/QtK7zls73tMORx41eCI+Pw91r
	RB+iJP9p6VyxXS4HGvQNaVYyECJRo0UeLGFJVKuW977zPhtwAAyE6D8hH+3+1h5GScrnGY
	l0hbVsoCCCGUcIbi72NsxQdA+SR9k4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741886718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rb66SVEbSSUP5qA+Mp4cXnC0KPLqlP7nV4rllQzAPUI=;
	b=9N9Q6KgLMec9WxBMId1xViA8tpUJA73ieg4pFsaiyKGuE0rx6NMwJWSdBsc9FRmw14pDTW
	cMegfaJUc0TNxxDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Oc6u9XlG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9N9Q6KgL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741886718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rb66SVEbSSUP5qA+Mp4cXnC0KPLqlP7nV4rllQzAPUI=;
	b=Oc6u9XlGjeb/RW7pWUKFQkfpdbRA/gyNP+2QjD401EB3/QtK7zls73tMORx41eCI+Pw91r
	RB+iJP9p6VyxXS4HGvQNaVYyECJRo0UeLGFJVKuW977zPhtwAAyE6D8hH+3+1h5GScrnGY
	l0hbVsoCCCGUcIbi72NsxQdA+SR9k4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741886718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rb66SVEbSSUP5qA+Mp4cXnC0KPLqlP7nV4rllQzAPUI=;
	b=9N9Q6KgLMec9WxBMId1xViA8tpUJA73ieg4pFsaiyKGuE0rx6NMwJWSdBsc9FRmw14pDTW
	cMegfaJUc0TNxxDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 908C0137BA;
	Thu, 13 Mar 2025 17:25:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AhVCI/4U02cOQAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 13 Mar 2025 17:25:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4E562A0908; Thu, 13 Mar 2025 18:25:18 +0100 (CET)
Date: Thu, 13 Mar 2025 18:25:18 +0100
From: Jan Kara <jack@suse.cz>
To: Carlos Maiolino <cem@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>, stable@vger.kernel.org
Subject: Re: [PATCH] udf: Fix inode_getblk() return value
Message-ID: <2hupq2bfdxdwfmruus6yyqjbwzno5pggvopp7blva2b7iwz2l7@nkfob5bfuvi5>
References: <kTCh8T9LAi-c_EZZeR5n35O79mJYo1igl-bR8kBN0MQn6vWW8i_XSuO3dDDVuHo7ggqWLk4lZOAIAzf4T57-Zg==@protonmail.internalid>
 <20250312163846.22851-2-jack@suse.cz>
 <zh6ygcz237c23e7w47glfckqioyaeu62shroy6p5mlaxnp25rd@xyrcogmtwmth>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zh6ygcz237c23e7w47glfckqioyaeu62shroy6p5mlaxnp25rd@xyrcogmtwmth>
X-Rspamd-Queue-Id: 998DD2116E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linaro.org:email,suse.cz:dkim,suse.cz:email,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Thu 13-03-25 11:13:45, Carlos Maiolino wrote:
> On Wed, Mar 12, 2025 at 05:38:47PM +0100, Jan Kara wrote:
> > Smatch noticed that inode_getblk() can return 1 on successful mapping of
> > a block instead of expected 0 after commit b405c1e58b73 ("udf: refactor
> > udf_next_aext() to handle error"). This could confuse some of the
> > callers and lead to strange failures (although the one reported by
> > Smatch in udf_mkdir() is impossible to trigger in practice). Fix the
> > return value of inode_getblk().
> > 
> > Link: https://lore.kernel.org/all/cb514af7-bbe0-435b-934f-dd1d7a16d2cd@stanley.mountain
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Fixes: b405c1e58b73 ("udf: refactor udf_next_aext() to handle error")
> > CC: stable@vger.kernel.org
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/udf/inode.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > I plan to merge this patch through my tree.
> > 
> > diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> > index 70c907fe8af9..4386dd845e40 100644
> > --- a/fs/udf/inode.c
> > +++ b/fs/udf/inode.c
> > @@ -810,6 +810,7 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
> >  		}
> >  		map->oflags = UDF_BLK_MAPPED;
> >  		map->pblk = udf_get_lb_pblock(inode->i_sb, &eloc, offset);
> > +		ret = 0;
> >  		goto out_free;
> >  	}
> > 
> 
> Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

Thanks. Picked up.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

