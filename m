Return-Path: <linux-fsdevel+bounces-55585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2489AB0C13C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 12:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EFA317F9A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 10:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E88328F933;
	Mon, 21 Jul 2025 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GGCpmZZg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TiuaNzkK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GGCpmZZg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TiuaNzkK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553B728F523
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753093559; cv=none; b=TCNMFjnaS8/Wcc498yyzMSHJj7VlObRSRg3VZDA2IXeilihbSS0OB14Qsd5RZkojVda82LrNMEgioIucL5RczIOjOYbECfz1ZzP0xoiU8JWNImybWzZQ5ki4XR1ipbnW53kS845aiOJBCmF4nxM3qGlGRrwaQPADdWyogJxEK+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753093559; c=relaxed/simple;
	bh=Z/K6Ye2yVremOud0OLYhMdZovDfpcmMfzOvsRX4VC50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqSJ34e2Yjx9jAsf7nCHgo0MLOvb3eDh9DRHS1eSiC+pFkeubCMYhZurbK4+5yGDBFvZBrUR55D6skdxEtSzbVCsZ23mrZyYkCfl+LE2mxvpxUPn+eX9S9X56BWkWgrIkiytRouzvS4hZaalg2wMzwn7mTWbEeVrdOHI5i5u0f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GGCpmZZg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TiuaNzkK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GGCpmZZg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TiuaNzkK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 51A1E1F397;
	Mon, 21 Jul 2025 10:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753093555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=baH6ow82NzmU1jGwAd7SMMrxH3jdioo5q/Xo9G5hG+4=;
	b=GGCpmZZgbAB5XlOhPaT/l0zeSwhiqSn6JbNbcSAdSIrsIWr7T0Mc7Nurq9TLL5MlDIKSzb
	G3mxxnF5X/WFL2F9PDn8NfEprPokB+uugrjkHFG+jVRlyIUBsFn+89vrEh51dQKAspuIIa
	bOQxVSvP+dassyYss7hQFywZfgAWP9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753093555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=baH6ow82NzmU1jGwAd7SMMrxH3jdioo5q/Xo9G5hG+4=;
	b=TiuaNzkKooiGvnBZgx/DGGdlv5vk/tkXPxkZgwh1y7czyZp1RZa8jl8Z3vpXSlkZ0+KbS8
	LZDo/WglGtJ31cBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GGCpmZZg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TiuaNzkK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753093555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=baH6ow82NzmU1jGwAd7SMMrxH3jdioo5q/Xo9G5hG+4=;
	b=GGCpmZZgbAB5XlOhPaT/l0zeSwhiqSn6JbNbcSAdSIrsIWr7T0Mc7Nurq9TLL5MlDIKSzb
	G3mxxnF5X/WFL2F9PDn8NfEprPokB+uugrjkHFG+jVRlyIUBsFn+89vrEh51dQKAspuIIa
	bOQxVSvP+dassyYss7hQFywZfgAWP9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753093555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=baH6ow82NzmU1jGwAd7SMMrxH3jdioo5q/Xo9G5hG+4=;
	b=TiuaNzkKooiGvnBZgx/DGGdlv5vk/tkXPxkZgwh1y7czyZp1RZa8jl8Z3vpXSlkZ0+KbS8
	LZDo/WglGtJ31cBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3453C13A88;
	Mon, 21 Jul 2025 10:25:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Lyt7DLMVfmi/GgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 21 Jul 2025 10:25:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5D047A0884; Mon, 21 Jul 2025 12:25:54 +0200 (CEST)
Date: Mon, 21 Jul 2025 12:25:54 +0200
From: Jan Kara <jack@suse.cz>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Barry Song <21cnbao@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org, 
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, 
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, 
	David Howells <dhowells@redhat.com>, netfs@lists.linux.dev, Paulo Alcantara <pc@manguebit.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, ntfs3@lists.linux.dev, Steve French <sfrench@samba.org>, 
	linux-cifs@vger.kernel.org, Phillip Lougher <phillip@squashfs.org.uk>, 
	Hailong Liu <hailong.liu@oppo.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Compressed files & the page cache
Message-ID: <z2ule3ilnnpoevo5mvt3intvjtuyud7vg3pbfauon47fhr4owa@giaehpbie4a5>
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
 <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
 <b61c4b7f-4bb1-4551-91ba-a0e0ffd19e75@linux.alibaba.com>
 <CAGsJ_4xJjwsvMpeBV-QZFoSznqhiNSFtJu9k6da_T-T-a6VwNw@mail.gmail.com>
 <7ea73f49-df4b-4f88-8b23-c917b4a9bd8a@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ea73f49-df4b-4f88-8b23-c917b4a9bd8a@linux.alibaba.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 51A1E1F397
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL76kpr34nasjgd69zbi7paxtw)];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,infradead.org,fb.com,toxicpanda.com,suse.com,vger.kernel.org,fluxnic.net,kernel.org,lists.ozlabs.org,lists.sourceforge.net,suse.cz,nod.at,lists.infradead.org,redhat.com,lists.linux.dev,manguebit.org,paragon-software.com,samba.org,squashfs.org.uk,oppo.com,gmx.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -4.01

On Mon 21-07-25 11:14:02, Gao Xiang wrote:
> Hi Barry,
> 
> On 2025/7/21 09:02, Barry Song wrote:
> > On Wed, Jul 16, 2025 at 8:28 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > > 
> 
> ...
> 
> > > 
> > > ... high-order folios can cause side effects on embedded devices
> > > like routers and IoT devices, which still have MiBs of memory (and I
> > > believe this won't change due to their use cases) but they also use
> > > Linux kernel for quite long time.  In short, I don't think enabling
> > > large folios for those devices is very useful, let alone limiting
> > > the minimum folio order for them (It would make the filesystem not
> > > suitable any more for those users.  At least that is what I never
> > > want to do).  And I believe this is different from the current LBS
> > > support to match hardware characteristics or LBS atomic write
> > > requirement.
> > 
> > Given the difficulty of allocating large folios, it's always a good
> > idea to have order-0 as a fallback. While I agree with your point,
> > I have a slightly different perspective — enabling large folios for
> > those devices might be beneficial, but the maximum order should
> > remain small. I'm referring to "small" large folios.
> 
> Yeah, agreed. Having a way to limit the maximum order for those small
> devices (rather than disabling it completely) would be helpful.  At
> least "small" large folios could still provide benefits when memory
> pressure is light.

Well, in the page cache you can tune not only the minimum but also the
maximum order of a folio being allocated for each inode. Btrfs and ext4
already use this functionality. So in principle the functionality is there,
it is "just" a question of proper user interfaces or automatic logic to
tune this limit.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

