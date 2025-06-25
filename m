Return-Path: <linux-fsdevel+bounces-52885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66031AE7F4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 12:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9A417CFFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFFB29E0F9;
	Wed, 25 Jun 2025 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0w29L976";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LzoVUj3D";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0w29L976";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LzoVUj3D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF75298981
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750847442; cv=none; b=Pg/gjUBMsXfZqnvR9MpmcreoNrQeGwdeOlcmG1U5sNoCU94A6MbwSkPMY8UrIHvaWBrf0KYzkS5t/0DbowzE/AK1hAIM3RyF/rVsN1ZtPQRdtzrtz7vp+R2VJiDOalyUxW2eGPEudkzkotKaAQVAwTXgIVRWPnxG7jA/XATZB9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750847442; c=relaxed/simple;
	bh=dGAZhOW9p7UwAYvCs8OxhJrCgfybhv8mUBpkNFp5PFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4BFzyMQlxL5ZgJkxXdM2QoQ8EnxdzPiWn2o1zeuuwKPF4W2yKxQ5N+l2fhwi87MoFuDlVB5wvSTDL4s+sHTup5ZqINXCWOAqProplRI6a35ybYssaT4NkOz+LoKpQNBD1WK7qyAxsR+HvFnrgKU0Z3/lKIL3tgp++9hekOucz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0w29L976; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LzoVUj3D; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0w29L976; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LzoVUj3D; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AB60C1F457;
	Wed, 25 Jun 2025 10:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750847438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvOY1s9oIG3GS4kWTIeUXpu8PIXRrkNntzq+8SohfCY=;
	b=0w29L976TyeLxycUSigGqiNZWkVskGuKF7WjT9Wc6stkhOo2k9ha/8vytFUIV19bb7Uk08
	YxPKaAdCqgdgOpypXqshCw4Mmw5/P0HnXaigCE0cAipDG5KZhJ469gStpb9dw/k+PWZcWL
	x6Sy6iCIqTKbXriuaaWYCvfTeOJq9U8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750847438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvOY1s9oIG3GS4kWTIeUXpu8PIXRrkNntzq+8SohfCY=;
	b=LzoVUj3DQg2qvYZlo4LmGcETxvT6NjS+LkOf2+VwrID+aNzOKbwU1rFluXlnoZBU7iPt10
	d5oVQtwRejbM8qBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750847438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvOY1s9oIG3GS4kWTIeUXpu8PIXRrkNntzq+8SohfCY=;
	b=0w29L976TyeLxycUSigGqiNZWkVskGuKF7WjT9Wc6stkhOo2k9ha/8vytFUIV19bb7Uk08
	YxPKaAdCqgdgOpypXqshCw4Mmw5/P0HnXaigCE0cAipDG5KZhJ469gStpb9dw/k+PWZcWL
	x6Sy6iCIqTKbXriuaaWYCvfTeOJq9U8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750847438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvOY1s9oIG3GS4kWTIeUXpu8PIXRrkNntzq+8SohfCY=;
	b=LzoVUj3DQg2qvYZlo4LmGcETxvT6NjS+LkOf2+VwrID+aNzOKbwU1rFluXlnoZBU7iPt10
	d5oVQtwRejbM8qBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E5A113AC4;
	Wed, 25 Jun 2025 10:30:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DYq8Is7PW2hjRwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 25 Jun 2025 10:30:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0F7D3A0857; Wed, 25 Jun 2025 12:30:34 +0200 (CEST)
Date: Wed, 25 Jun 2025 12:30:34 +0200
From: Jan Kara <jack@suse.cz>
To: Song Liu <song@kernel.org>
Cc: Jan Kara <jack@suse.cz>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kpsingh@kernel.org, mattbobrowski@google.com, 
	m@maowtm.org, neil@brown.name
Subject: Re: [PATCH v5 bpf-next 1/5] namei: Introduce new helper function
 path_walk_parent()
Message-ID: <ob35gal3xcbkdkcdpekyvglwg5jsf6sgkdeyoj3gu4jr76ilxh@yhupo3iwet3l>
References: <20250617061116.3681325-1-song@kernel.org>
 <20250617061116.3681325-2-song@kernel.org>
 <htn4tupeslsrhyzrqt7pi34tye7tpp7amziiwflfpluj3u2nhs@e2axcpfuucv5>
 <CAPhsuW5GKn=0HWDKkmOMTge_rCEJ+UMRNnmo7HpT-gwtURHpiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5GKn=0HWDKkmOMTge_rCEJ+UMRNnmo7HpT-gwtURHpiw@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,meta.com,kernel.org,gmail.com,iogearbox.net,linux.dev,zeniv.linux.org.uk,google.com,maowtm.org,brown.name];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue 24-06-25 10:37:36, Song Liu wrote:
> On Tue, Jun 24, 2025 at 5:18 AM Jan Kara <jack@suse.cz> wrote:
> > > + *
> > > + * Returns: either an ERR_PTR() or the chosen parent which will have had
> > > + * the refcount incremented.
> > > + */
> >
> > The behavior with LOOKUP_NO_XDEV is kind of odd (not your fault) and
> > interestingly I wasn't able to find a place that would depend on the path
> > being updated in that case. So either I'm missing some subtle detail (quite
> > possible) or we can clean that up in the future.
> 
> We have RESOLVE_NO_XDEV in uapi/linux/openat2.h, so I guess we
> cannot really remove it?

I didn't mean to remove the LOOKUP_NO_XDEV flag, I meant to not update the
passed path if LOOKUP_NO_XDEV is set, we are crossing the mountpoint and
thus returning -EXDEV. As far as I've checked once we return error,
everybody just path_put()s the nd->path so its update is just pointless.
But there are many (indirect) callers so I might have missed some case.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

