Return-Path: <linux-fsdevel+bounces-22852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC0491DB8C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 11:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F161F21763
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 09:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F31E85626;
	Mon,  1 Jul 2024 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NbE49N1w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rxylWUg+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a/p0kXeh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UOg+M19d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47D56EB5B;
	Mon,  1 Jul 2024 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719826482; cv=none; b=TYcc5NuqIWdcio3CIgYfSrkGYDvKQenotZ6gk0RehoEfX8VxlYGzmWWSDg6aVhYrSva/tAWC2zP9uMZ6/W594kpdN1EDIIMpdovBtmFcVEi1lMsILseSMY5ApjThkyPp/DXYGrA1porVS63MATEQlypvxCRw/Smi5ICO9fBCsRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719826482; c=relaxed/simple;
	bh=f8A4N+tEl5e0q03GpDKXFyL2ptcO6DWC6XTKDmFJvfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJFic4Wk5XKfvukBEJ5Gh0fryVwUNmvs5pSh0KZFwnaS2urq8rU89iKrXOghHq6INT4XOauWiFr8EfwuM4YKu2ssRjcEMlNq0LjJfDzeFoK5IlQrmbzc7y1GDpnMb/skzrIsS/ezsQFdgx1s6ysQQ0aL5mF7LRjpaN5ApTOCjeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NbE49N1w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rxylWUg+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a/p0kXeh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UOg+M19d; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE0FD21AE6;
	Mon,  1 Jul 2024 09:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719826479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FozuB0CgYy31OmZnoj5QofV+vYenuNBwwgLrQA0VLBg=;
	b=NbE49N1wg6cM3fA5V/gAHBOfJZ3iQ6sNbuWpsuZ4Zp+bn9Z5Umyo3ZIVsTHpUWUPn2enzW
	tsMj7AFVvfs8oGvA3u0u0q4fHUpLk8ljfoqfa7KBA0sAlgAvwo7GlAk02ifm04KQgEK8+W
	oPs5DXZdULhit68Q3ZL6j/6brVN45y0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719826479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FozuB0CgYy31OmZnoj5QofV+vYenuNBwwgLrQA0VLBg=;
	b=rxylWUg+p7ebJEM0zMG68ju2VcNhbAxt57fAMc54omZ0LcTD2DD8Ho+V0qlj9iLpi3Z+YY
	SmqhwNuzV3gVgjCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719826477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FozuB0CgYy31OmZnoj5QofV+vYenuNBwwgLrQA0VLBg=;
	b=a/p0kXehdSYe3JnwY+HlC46fhPrRSpXxMBXGv/2xw9LkSth2INE9N3aQvcU8OPTBNXf0GK
	pGHA3H2sYuP9fsloNxZQY+e55cDT7gCJpurzfVnq8ETslMJpp110cle3MpclosQ69nvXFd
	lPF9U2+C59K1awyl3VaCyb0n98PPWyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719826477;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FozuB0CgYy31OmZnoj5QofV+vYenuNBwwgLrQA0VLBg=;
	b=UOg+M19dnm3PpJnbD1VmxR+FfwdjHAe4yQgxNY1Q9aGxTYVLbOO6OYpafqcZhp4u9ItxH5
	NnuyFGkeLi7VTnCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD63813800;
	Mon,  1 Jul 2024 09:34:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ps0FNi14gmb4FwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Jul 2024 09:34:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 533E2A088E; Mon,  1 Jul 2024 11:34:37 +0200 (CEST)
Date: Mon, 1 Jul 2024 11:34:37 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Eric Sandeen <sandeen@redhat.com>,
	linux-fsdevel@vger.kernel.org, autofs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-efi@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>, linux-ext4@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>, linux-mm@kvack.org,
	ntfs3@lists.linux.dev, linux-cifs@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Hans Caniullan <hcaniull@redhat.com>
Subject: Re: [PATCH 01/14] fs_parse: add uid & gid option option parsing
 helpers
Message-ID: <20240701093437.d2654yek4nnq2ep6@quack3>
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
 <de859d0a-feb9-473d-a5e2-c195a3d47abb@redhat.com>
 <20240628094517.ifs4bp73nlggsnxz@quack3>
 <20240628-fernfahrt-missverstanden-01543e7492b4@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628-fernfahrt-missverstanden-01543e7492b4@brauner>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sandeen.net:email,suse.com:email]

On Fri 28-06-24 14:23:35, Christian Brauner wrote:
> On Fri, Jun 28, 2024 at 11:45:17AM GMT, Jan Kara wrote:
> > On Thu 27-06-24 19:26:24, Eric Sandeen wrote:
> > > Multiple filesystems take uid and gid as options, and the code to
> > > create the ID from an integer and validate it is standard boilerplate
> > > that can be moved into common helper functions, so do that for
> > > consistency and less cut&paste.
> > > 
> > > This also helps avoid the buggy pattern noted by Seth Jenkins at
> > > https://lore.kernel.org/lkml/CALxfFW4BXhEwxR0Q5LSkg-8Vb4r2MONKCcUCVioehXQKr35eHg@mail.gmail.com/
> > > because uid/gid parsing will fail before any assignment in most
> > > filesystems.
> > > 
> > > Signed-off-by: Eric Sandeen <sandeen@sandeen.net>
> > 
> > I like the idea since this seems like a nobrainer but is actually
> > surprisingly subtle...
> > 
> > > diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> > > index a4d6ca0b8971..24727ec34e5a 100644
> > > --- a/fs/fs_parser.c
> > > +++ b/fs/fs_parser.c
> > > @@ -308,6 +308,40 @@ int fs_param_is_fd(struct p_log *log, const struct fs_parameter_spec *p,
> > >  }
> > >  EXPORT_SYMBOL(fs_param_is_fd);
> > >  
> > > +int fs_param_is_uid(struct p_log *log, const struct fs_parameter_spec *p,
> > > +		    struct fs_parameter *param, struct fs_parse_result *result)
> > > +{
> > > +	kuid_t uid;
> > > +
> > > +	if (fs_param_is_u32(log, p, param, result) != 0)
> > > +		return fs_param_bad_value(log, param);
> > > +
> > > +	uid = make_kuid(current_user_ns(), result->uint_32);
> > 
> > But here is the problem: Filesystems mountable in user namespaces need to use
> > fc->user_ns for resolving uids / gids (e.g. like fuse_parse_param()).
> > Having helpers that work for some filesystems and are subtly broken for
> > others is worse than no helpers... Or am I missing something?
> > 
> > And the problem with fc->user_ns is that currently __fs_parse() does not
> > get fs_context as an argument... So that will need some larger work.
> 
> Not really. If someone does an fsopen() in a namespace but the process
> that actually sets mount options is in another namespace then it's
> completely intransparent what uid/gid this will resolve to if it's
> resovled according to fsopen().
> 
> It's also a bit strange if someone ends up handing off a tmpfs fscontext
> that was created in the initial namespace to some random namespace and
> they now can set uid/gid options that aren't mapped according to their
> namespace but instead are 1:1 resolved according to the intial
> namespace. So this would hinder delegation.
> 
> The expectation is that uid/gid options are resolved in the caller's
> namespace and that shouldn't be any different for fscontexts for
> namespace mountable filesystems. The crucial point is to ensure that the
> resulting kuid/kgid can be resolved in the namespace the filesystem is
> mounted in at the end. That's what was lacking in e.g., tmpfs in commit
> 0200679fc795 ("tmpfs: verify {g,u}id mount options correctly")
> 
> The fuse conversion is the only inconsistency in that regard.

OK, thanks for explanation!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

