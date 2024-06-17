Return-Path: <linux-fsdevel+bounces-21805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD1A90A7E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 09:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919F41C25042
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 07:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B52190041;
	Mon, 17 Jun 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eA4aKwt0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tj8nkiOI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iV4/VjvN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HsOasgVE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B4039FFB;
	Mon, 17 Jun 2024 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718611082; cv=none; b=kflu8dwq6FXP+OEUeXMu6w3hbtAsvhQImWNWoyVYUrPWduOv0V6omrnCbG9bSpgb62OxaIc3a0SGAFYCDkR/MFb6nJxL5Pz41+B8K00M1p5T3l2FM7/Anor7U1Ybet/of313SHcrNH6uakWDPXa6d/txo6orXpcCQRQR719bVDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718611082; c=relaxed/simple;
	bh=/M7TJTtJjy9l/c0yWPhDVD7o+uURzHHBo3jWYPTDd+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpcqoPy44pd33HLO7eW+VLVu2KBUWYWQnZ4Py2zfTCdvJ6QV+DmjWXHtgVywQqez7Hlaa08QbxzzV1AvYiOy2w5jQezxP0UuhJLDOboXGhoSTwzRUIWXD3avcbs5Q+t1zQjQPa+LfgMcPu7PIQBGY4COGw9A17NmoeK7mHrNzBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eA4aKwt0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tj8nkiOI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iV4/VjvN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HsOasgVE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E0E6F5FCB3;
	Mon, 17 Jun 2024 07:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718611079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1OWs18jQXFDiEgM1u8rR79jHDrXS+3IONMQeRLW12dc=;
	b=eA4aKwt0F+sd90WSHWD2UNVr9+xY36uhNEWEK8kIjQ6alr5ZAYSUfSc65OTFkpBhjVIjT8
	yVcF5K/RtjeijjGP7qbynY81VE6fE//4DSzatOwyhCbZdoO+WJQBpaXM4mrgN9JnyG5CsL
	6RXiBy58m5+MRJGGn2uKFQJQv1xTr/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718611079;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1OWs18jQXFDiEgM1u8rR79jHDrXS+3IONMQeRLW12dc=;
	b=Tj8nkiOIQjt5eNnI0I0rcdGVCqHqQpg/yo9KTGGdBWxmoNKlig26EzuZfcsCq12SGoU0lz
	QSA04Syj9xRLrIDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="iV4/VjvN";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HsOasgVE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718611078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1OWs18jQXFDiEgM1u8rR79jHDrXS+3IONMQeRLW12dc=;
	b=iV4/VjvNqHWk3K7xEXCS0xXn3rkfIYQIWBGKSXApuMB6Wo09mdlVVERPJiyIbaaGwcd5lM
	ZgzLZfcLtwBZvZMcKWRDfdXlhGZUgBQv6PIVW3j5TypR2Rvp8YBdpzJYhxqJm/PZNROK6S
	kjImWecNiUR9t9W1xXWKhIAZ9U+hs04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718611078;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1OWs18jQXFDiEgM1u8rR79jHDrXS+3IONMQeRLW12dc=;
	b=HsOasgVEinePImewMQ1+yrRscfwDziQtI1ND8hakeJvO+yylbnToqQcgMfYfpeeSQDwdf8
	VbZG0ZtRpfNQsGCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6BBF139AB;
	Mon, 17 Jun 2024 07:57:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W/doNIbsb2b/VwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 17 Jun 2024 07:57:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7446CA0886; Mon, 17 Jun 2024 09:57:58 +0200 (CEST)
Date: Mon, 17 Jun 2024 09:57:58 +0200
From: Jan Kara <jack@suse.cz>
To: Hillf Danton <hdanton@sina.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
	syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com,
	linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: Re: [RFC PATCH] mm: truncate: flush lru cache for evicted inode
Message-ID: <20240617075758.wewhukbrjod5fp5o@quack3>
References: <Zm39RkZMjHdui8nh@casper.infradead.org>
 <20240616023951.1250-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616023951.1250-1-hdanton@sina.com>
X-Rspamd-Queue-Id: E0E6F5FCB3
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[sina.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,sina.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[d79afb004be235636ee8];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,kvack.org,suse.cz,vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Sun 16-06-24 10:39:51, Hillf Danton wrote:
> On Sat, 15 Jun 2024 21:44:54 +0100 Matthew Wilcox wrote:
> > 
> > I suspect this would trigger:
> > 
> > +++ b/fs/inode.c
> > @@ -282,6 +282,7 @@ static struct inode *alloc_inode(struct super_block *sb)
> >  void __destroy_inode(struct inode *inode)
> >  {
> >         BUG_ON(inode_has_buffers(inode));
> > +       BUG_ON(inode->i_data.nrpages);
> >         inode_detach_wb(inode);
> >         security_inode_free(inode);
> >         fsnotify_inode_delete(inode);
> > 
> Yes, it was triggered [1]
> 
> [1] https://lore.kernel.org/lkml/00000000000084b401061af6ab80@google.com/
> 
> and given trigger after nrpages is checked in clear_inode(),
> 
> 	iput(inode)
> 	evict(inode)
> 	truncate_inode_pages_final(&inode->i_data);
> 	clear_inode(inode);
> 	destroy_inode(inode);
> 
> why is folio added to exiting mapping?
> 
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  83a7eefedc9b

OK, so based on syzbot results this seems to be a bug in
nilfs_evict_inode() (likely caused by corrupted filesystem so that root
inode's link count was 0 and hence was getting deleted on iput()). I guess
nilfs maintainers need to address these with more consistency checks of
metadata when loading them...

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

