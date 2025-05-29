Return-Path: <linux-fsdevel+bounces-50067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 688F2AC7D7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 13:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87BFB9E7D31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 11:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D1C223320;
	Thu, 29 May 2025 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xnnrzbUB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p2IQMEM6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RSN1Ryz1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QVgW4yDc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AA52222C1
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748519901; cv=none; b=VO7u0XurbDzD74UzKiEhpygnF72xLZSznM7fYncQzgvfEzpDr8w/A+AZTnAuQMXEmVWiMoiizzpNP+H9mWCbhWUjzyebBUX3zrvFf4lSo3h/qum2vAJmMPjTkpLUyzEPV9Imlkgme/uvj+1gjh6gUgmmoHoqbWRKnY+KkJ8zoCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748519901; c=relaxed/simple;
	bh=JoeMj1sgCg3+bjd+DCtURjgjQEBOvEMZ6ee7lPUm2DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZK6PpHPJH9cQMqU8qicyuqn2IbpGcVQXYCYFhkAJzUx4i7smacBpce82HaWhqlP1mWQcmLXSSah+B9uhmeXpGv7SO0NledLEdTDGhpRW1Ho6C+1w4KrusHMgt1Z4To1OsDOS8Gh9CmYMFlG8iO4xGSmPkHi1kqPN1zMV3aSrvjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xnnrzbUB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p2IQMEM6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RSN1Ryz1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QVgW4yDc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E458521D1C;
	Thu, 29 May 2025 11:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748519892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NHQv/Giezg5cPyruHZ9ILxYpRZTFVMY6zbeSiUuy0hY=;
	b=xnnrzbUBYUVs2I8eKhk3l4iyRqDf2fQdKPYnrsUa1JnBo0m62z/53QtfmtGzl/C+NgjR/i
	XdbvBvcvSMWNxV1HXkL/0bIcSiC1kQwVQcWy3EkN3gy2VFuZHo1bV7JLrq4410T56m/ytz
	Y/ksOwk4n11yIoNhaiJGURB2cyvai0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748519892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NHQv/Giezg5cPyruHZ9ILxYpRZTFVMY6zbeSiUuy0hY=;
	b=p2IQMEM6iV8zhwc6JrrMfyfzuP6Zu/o5LgX0Bywzkwh87O9YEUEqipZBAs6hWSkL/ZbY88
	Gcmr+dkd1OEg+xBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748519891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NHQv/Giezg5cPyruHZ9ILxYpRZTFVMY6zbeSiUuy0hY=;
	b=RSN1Ryz1+Ab0N5ORp1gINlW1WQf9Ekr8y/NnyQ+TKb53bRkGk7NLeWYkQurQtpmaqWrAPz
	itf2gagyAdBQRuhmP6vWIc8+daXKGIOX9Ecf9JA7Obov5dPEarONTsh0XtvwEsqOgMyc8Z
	cvBa4HC/40MUmdr3vKCQni7ZQw3aPao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748519891;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NHQv/Giezg5cPyruHZ9ILxYpRZTFVMY6zbeSiUuy0hY=;
	b=QVgW4yDcAjXTMrE8AyITNuiFcSb7gDNa8Yng5w9muUr2lvLyap7HE6lubUhSH0kjbSwZzD
	rgStXu9+q7/+d1Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3B5013325;
	Thu, 29 May 2025 11:58:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FDmmM9NLOGjmHQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 29 May 2025 11:58:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 71B9FA09B5; Thu, 29 May 2025 13:58:07 +0200 (CEST)
Date: Thu, 29 May 2025 13:58:07 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, brauner@kernel.org, 
	jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com, 
	repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net, 
	gnoack@google.com
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
Message-ID: <yti2dilasy7b3tu6iin5pugkn6oevdswrwoy6gorudb7x2cqhh@nqb3gcyxg4by>
References: <20250528222623.1373000-1-song@kernel.org>
 <20250528222623.1373000-4-song@kernel.org>
 <20250528223724.GE2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528223724.GE2023217@ZenIV>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,meta.com,gmail.com,iogearbox.net,linux.dev,suse.cz,google.com,toxicpanda.com,digikod.net];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed 28-05-25 23:37:24, Al Viro wrote:
> On Wed, May 28, 2025 at 03:26:22PM -0700, Song Liu wrote:
> > Introduce a path iterator, which reliably walk a struct path.
> 
> No, it does not.  If you have no external warranty that mount
> *and* dentry trees are stable, it's not reliable at all.

I agree that advertising this as "reliable walk" is misleading. It is
realiable in the sense that it will not dereference freed memory, leak
references etc. As you say it is also reliable in the sense that without
external modifications to dentry & mount tree, it will crawl the path to
root. But in presence of external modifications the only reliability it
offers is "it will not crash". E.g. malicious parallel modifications can
arbitrarily prolong the duration of the walk.

> And I'm extremely suspicious regarding the validity of anything
> that pokes around in mount trees.  There is a very good reason
> struct mount is *not* visible in include/linux/*.h

Well, but looking at the actual code I don't see anything problematic
there. It does not export any new functionality from the VFS AFAICT. It
just factors out some parent lookup details from Landlock into generic code
and exposes it as a helper to fetch parent dentry. But overall any kernel
module can do what's in the helper already today and exposing the
functionality of looking up dentry parent to BPF as well seems OK to me.

So I have only reservations against calling it "reliable walk". It should
rather come with warnings like "The sequence of dentries may be rather
surprising in presence of parallel directory or mount tree modifications
and the iteration need not ever finish in face of parallel malicious
directory tree manipulations."

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

