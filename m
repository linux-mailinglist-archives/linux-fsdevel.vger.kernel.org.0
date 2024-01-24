Return-Path: <linux-fsdevel+bounces-8777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 291B383ADFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 17:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A2B2B267B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 16:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850B67C0BE;
	Wed, 24 Jan 2024 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Olk0Z3jm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0srUKDHJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Olk0Z3jm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0srUKDHJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397537E560
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112482; cv=none; b=NOnE0i4rJn5h7dCpKjHIAXOXv5c0PrS1io4W1XoZy4PTn6veNkmGLJIpESAindqFhzyysflt51ZfkbEUMN+IlkMC9agmntOt+FufGxl6eqA7oUhw+s2qUXPxgjfTqhgeBfUQiuyfQJDpeVtGV3Duq9vKcIW74ZoFfFZPZ80ubTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112482; c=relaxed/simple;
	bh=15vRi6qnyQa9Axm5eA9e+oSFrOslwqINcmukLc94b9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avSkHFRf4wa+NW4ciYYOSUm/yUEMWUuMq+GXwgbqhztIkxaQuvOIUcApu62X2l7MV/pH9CoiixDUA5u6+sGyAE9Bf6ofPY0TjTu5jiATWc+0PpBirWsLWTmOGbl/UgbxOcrN6wH64FTN2ddltFym6/zul4MZE08PdQa+PaHxpGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Olk0Z3jm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0srUKDHJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Olk0Z3jm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0srUKDHJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 99F9E22029;
	Wed, 24 Jan 2024 16:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706112478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f5MOv1gxkN1oNVnxczDttER2sIzlzzRe610X8VX2O80=;
	b=Olk0Z3jmTRsk47Ez4K/qYDIG5XNTuHEDk/m8UT+8m9nRb9R1h+R/nzhEUvh+UkFFuYpoCC
	Tyx1IJ2CEWWi3jEB/qV8Rps4EQA1k/WOIvND+OzsoD9aDSh4isLDySfWNt6KlaMrRWlwqw
	LlODzxZdClDyJfsVSnIOddDRzdBJ+Ds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706112478;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f5MOv1gxkN1oNVnxczDttER2sIzlzzRe610X8VX2O80=;
	b=0srUKDHJbKSxzlWIMn2lLFUGkZgZFz9nHCqjljht0Rkho0tAuWq34dm3a6F+YXKKuXnH50
	slI1u/aegoon/EDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706112478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f5MOv1gxkN1oNVnxczDttER2sIzlzzRe610X8VX2O80=;
	b=Olk0Z3jmTRsk47Ez4K/qYDIG5XNTuHEDk/m8UT+8m9nRb9R1h+R/nzhEUvh+UkFFuYpoCC
	Tyx1IJ2CEWWi3jEB/qV8Rps4EQA1k/WOIvND+OzsoD9aDSh4isLDySfWNt6KlaMrRWlwqw
	LlODzxZdClDyJfsVSnIOddDRzdBJ+Ds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706112478;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f5MOv1gxkN1oNVnxczDttER2sIzlzzRe610X8VX2O80=;
	b=0srUKDHJbKSxzlWIMn2lLFUGkZgZFz9nHCqjljht0Rkho0tAuWq34dm3a6F+YXKKuXnH50
	slI1u/aegoon/EDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92D141333E;
	Wed, 24 Jan 2024 16:07:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jRHVI941sWVIHQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Jan 2024 16:07:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 49990A0807; Wed, 24 Jan 2024 17:07:58 +0100 (CET)
Date: Wed, 24 Jan 2024 17:07:58 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fsnotify: optimize the case of no parent watcher
Message-ID: <20240124160758.zodsoxuzfjoancly@quack3>
References: <20240116113247.758848-1-amir73il@gmail.com>
 <20240116120434.gsdg7lhb4pkcppfk@quack3>
 <CAOQ4uxjioTjpxueE8OF_SjgqknDAsDVmCbG6BSmGLB_kqXRLmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjioTjpxueE8OF_SjgqknDAsDVmCbG6BSmGLB_kqXRLmg@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Olk0Z3jm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0srUKDHJ
X-Spamd-Result: default: False [0.13 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.06)[60.89%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.13
X-Rspamd-Queue-Id: 99F9E22029
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Tue 16-01-24 14:53:00, Amir Goldstein wrote:
> On Tue, Jan 16, 2024 at 2:04 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 16-01-24 13:32:47, Amir Goldstein wrote:
> > > If parent inode is not watching, check for the event in masks of
> > > sb/mount/inode masks early to optimize out most of the code in
> > > __fsnotify_parent() and avoid calling fsnotify().
> > >
> > > Jens has reported that this optimization improves BW and IOPS in an
> > > io_uring benchmark by more than 10% and reduces perf reported CPU usage.
> > >
> > > before:
> > >
> > > +    4.51%  io_uring  [kernel.vmlinux]  [k] fsnotify
> > > +    3.67%  io_uring  [kernel.vmlinux]  [k] __fsnotify_parent
> > >
> > > after:
> > >
> > > +    2.37%  io_uring  [kernel.vmlinux]  [k] __fsnotify_parent
> > >
> > > Reported-and-tested-by: Jens Axboe <axboe@kernel.dk>
> > > Link: https://lore.kernel.org/linux-fsdevel/b45bd8ff-5654-4e67-90a6-aad5e6759e0b@kernel.dk/
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> > > Jan,
> > >
> > > Considering that this change looks like a clear win and it actually
> > > the change that you suggested, I cleaned it up a bit and posting for
> > > your consideration.
> >
> > Agreed, I like this. What did you generate this patch against? It does not
> > apply on top of current Linus' tree (maybe it needs the change sitting in
> > VFS tree - which is fine I can wait until that gets merged)?
> >
> 
> Yes, it is on top of Christian's vfs-fixes branch.

Merged your improvement now (and I've split off the cleanup into a separate
change and dropped the creation of fsnotify_path() which seemed a bit
pointless with a single caller). All pushed out.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

