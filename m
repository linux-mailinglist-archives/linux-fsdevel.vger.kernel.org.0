Return-Path: <linux-fsdevel+bounces-14879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEE8880F28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 10:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E031F23512
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 09:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A323BBE3;
	Wed, 20 Mar 2024 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EGGJYF6m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S9aNPKuv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EGGJYF6m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S9aNPKuv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3313BBCC
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710928675; cv=none; b=dTvzczuelG++TuTVrUpHKln1+F6Fq/IjMOe3Ot7gcHEjI5X2n2JkONhao5PPpkOBeBzEHsolRxNrTdstNqBTTcpjcrukETxcQpyJ2/nRT/1dbSgA65+mkz3uiIsyGjPQiB3vsr0Yg2TA/ZsgTKE4PSMbr6dnlHVLvQB2MY46zXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710928675; c=relaxed/simple;
	bh=zkWYx8W7IX76XqAqHGzKZNxwlbNfJIyNG4ctz/k6hzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/sMCPfc2UqmdpOYntzdDsoBF4aMSyZ+stPhlt2w6Yt/we3leTDhYnBv75Mc8mOkHASWgXsSqo7e3fhyCT1MIZWjtUWGG624uEdWrB4YctxEQSyDZ2H0tXPx0rfFV/M1F0uxcQCJDaOLYOBZShsvPRkr1v7Ur2KazToh+MAK1AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EGGJYF6m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S9aNPKuv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EGGJYF6m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S9aNPKuv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 35C0B20C31;
	Wed, 20 Mar 2024 09:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710928666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZftk7I+JFrIv/9Kzatj1GHT0cpfxL9Us/4tzkFxg1U=;
	b=EGGJYF6m4s7PpTn61nqvd+NLgrtRybLOmfz1JLFOxEma4HKAL91LbrLgiciaeUPmiLSCH8
	WnPvL/4gLA0fgpm7ritMy6COBUJuadhj4X9Naj5Uvroyy7GOyYL/wNqMVpsW3851/vxjJU
	8bmiHuRSukS2vGJlDUvtfLuWyCYGVX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710928666;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZftk7I+JFrIv/9Kzatj1GHT0cpfxL9Us/4tzkFxg1U=;
	b=S9aNPKuvBDsPpgIWvclYBE7LGgn/4t2qYS3BcLPCCD4U3SOMU2N79AadLrQC5jDVNwLUZk
	UubOO/CN0xleDyDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710928666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZftk7I+JFrIv/9Kzatj1GHT0cpfxL9Us/4tzkFxg1U=;
	b=EGGJYF6m4s7PpTn61nqvd+NLgrtRybLOmfz1JLFOxEma4HKAL91LbrLgiciaeUPmiLSCH8
	WnPvL/4gLA0fgpm7ritMy6COBUJuadhj4X9Naj5Uvroyy7GOyYL/wNqMVpsW3851/vxjJU
	8bmiHuRSukS2vGJlDUvtfLuWyCYGVX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710928666;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZftk7I+JFrIv/9Kzatj1GHT0cpfxL9Us/4tzkFxg1U=;
	b=S9aNPKuvBDsPpgIWvclYBE7LGgn/4t2qYS3BcLPCCD4U3SOMU2N79AadLrQC5jDVNwLUZk
	UubOO/CN0xleDyDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29F29136D6;
	Wed, 20 Mar 2024 09:57:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fHU/Chqz+mWbXwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 20 Mar 2024 09:57:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C8EB1A07D6; Wed, 20 Mar 2024 10:57:41 +0100 (CET)
Date: Wed, 20 Mar 2024 10:57:41 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/10] fsnotify: create helpers to get sb and connp from
 object
Message-ID: <20240320095741.iwfcrhya7s4lkxcs@quack3>
References: <20240317184154.1200192-1-amir73il@gmail.com>
 <20240317184154.1200192-3-amir73il@gmail.com>
 <20240320-versorgen-furios-aba1d9706de3@brauner>
 <CAOQ4uxi+uPePQKeqGiOLbqCvCyWKMsH4AJjZ7NXEH+SD7CQvbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxi+uPePQKeqGiOLbqCvCyWKMsH4AJjZ7NXEH+SD7CQvbw@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Wed 20-03-24 10:34:45, Amir Goldstein wrote:
> On Wed, Mar 20, 2024 at 10:29 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Sun, Mar 17, 2024 at 08:41:46PM +0200, Amir Goldstein wrote:
> > > In preparation to passing an object pointer to add/remove/find mark
> > > helpers, create helpers to get sb and connp by object type.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  fs/notify/fsnotify.h | 14 ++++++++++++++
> > >  fs/notify/mark.c     | 14 ++++++++++++++
> > >  2 files changed, 28 insertions(+)
> > >
> > > diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
> > > index fde74eb333cc..87456ce40364 100644
> > > --- a/fs/notify/fsnotify.h
> > > +++ b/fs/notify/fsnotify.h
> > > @@ -27,6 +27,20 @@ static inline struct super_block *fsnotify_conn_sb(
> > >       return container_of(conn->obj, struct super_block, s_fsnotify_marks);
> > >  }
> > >
> > > +static inline struct super_block *fsnotify_object_sb(void *obj, int obj_type)
> >
> > If I read correctly, then in some places you use unsigned int obj_type
> > and here you use int obj_type. The best option would likely be to just
> > introduce an enum fsnotify_obj_type either in this series or in a
> > follow-up series.
> 
> Good point.
> 
> There is an enum already but we do not use it.
> Jan, WDYT?

Yeah. So far we just use enum fsnotify_obj_type to define values but don't
use it as a type itself. I guess it would be worthy cleanup but not in this
series. Here I guess we could just use the enum instead of introducing new
functions taking 'int' argument.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

