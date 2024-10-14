Return-Path: <linux-fsdevel+bounces-31903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF5599D382
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 17:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80B37B23672
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 15:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3603B298;
	Mon, 14 Oct 2024 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YzZXMfde";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O45xErwo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YzZXMfde";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O45xErwo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1A51CAB8;
	Mon, 14 Oct 2024 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920292; cv=none; b=mxQJqVBUiXv/k55/8N7+Wh68yxh1mqi1VWLPvNnvJgEm3wPWPXKosxpgnOWAfaRzHBrHV/jJLcm/67S4Jdh2E5H400Ln5QivN7IoMJrpTYyzf47K6lPC232Mrfb1mGNh6Xb5N1AznzG5cV8mc4OdfZd994B02EXVEbaOsQ+scnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920292; c=relaxed/simple;
	bh=F+5CC99gSkaFwvZWslQS56jqqnYMTOyjm3WE7RswFO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=th8eOCeVGvwzuwrneocQyEjnkLXdo1+YWkTIScWxuzSkejk/T1aCwzboRAnQ1vvUPV22eh38bHdEpwnu/aMAPMmeZcHDPco5mmwftxEZ3Ez8rummvDkXiGWht3lnfSb0fD0YlZGuG++CAkdyhXKA5W6+wvbTljnvdQZs9IxpArw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YzZXMfde; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O45xErwo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YzZXMfde; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O45xErwo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 07FCA1F745;
	Mon, 14 Oct 2024 15:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728920287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6epGgHPHoZqECZ17ny8VdhoMLTLAGxdFJV6F+nPwp10=;
	b=YzZXMfdeAK7NWfVE0MjsijaNb1xfA9jPP54BqURKvq7hfGexF3H8FSVlHftRXa44gZClwZ
	8DJGMWYQ081PWQZ8lwQ+l8/OtROOm9vyCjDIDTSUQAS7J0jgcM6uh9rDvbpU0QKcrXWeDg
	2AHAyBiYnOk+cXgTnGeQmRVphMbeAU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728920287;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6epGgHPHoZqECZ17ny8VdhoMLTLAGxdFJV6F+nPwp10=;
	b=O45xErwoTDfTjcwKekS1fygPscPAMEP4j+FX21z8Miv4JkUwI2fSUrPgAVFUE45mQDjLNv
	fFc8DwLvhGdXxgBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YzZXMfde;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=O45xErwo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728920287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6epGgHPHoZqECZ17ny8VdhoMLTLAGxdFJV6F+nPwp10=;
	b=YzZXMfdeAK7NWfVE0MjsijaNb1xfA9jPP54BqURKvq7hfGexF3H8FSVlHftRXa44gZClwZ
	8DJGMWYQ081PWQZ8lwQ+l8/OtROOm9vyCjDIDTSUQAS7J0jgcM6uh9rDvbpU0QKcrXWeDg
	2AHAyBiYnOk+cXgTnGeQmRVphMbeAU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728920287;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6epGgHPHoZqECZ17ny8VdhoMLTLAGxdFJV6F+nPwp10=;
	b=O45xErwoTDfTjcwKekS1fygPscPAMEP4j+FX21z8Miv4JkUwI2fSUrPgAVFUE45mQDjLNv
	fFc8DwLvhGdXxgBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E646F13A51;
	Mon, 14 Oct 2024 15:38:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KAQwON46DWdSfQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Oct 2024 15:38:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 72E75A0896; Mon, 14 Oct 2024 17:38:02 +0200 (CEST)
Date: Mon, 14 Oct 2024 17:38:02 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Song Liu <songliubraving@meta.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Song Liu <song@kernel.org>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	LSM List <linux-security-module@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH v2] fsnotify, lsm: Decouple fsnotify from lsm
Message-ID: <20241014153802.bgimwlm37mqbf5m4@quack3>
References: <20241013002248.3984442-1-song@kernel.org>
 <CAOQ4uxjQ--cBoNNHQYz+AFz2z8g=pCZ0CFDHujuCELOJBg8wzw@mail.gmail.com>
 <AE7ECD50-A7DC-4D7D-8BC7-2A555A327483@fb.com>
 <CAOQ4uxgL7OKf6U9UUsaapcMpKVeF4meo_7_hA1QovMf_TBf6Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgL7OKf6U9UUsaapcMpKVeF4meo_7_hA1QovMf_TBf6Jw@mail.gmail.com>
X-Rspamd-Queue-Id: 07FCA1F745
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sun 13-10-24 16:51:35, Amir Goldstein wrote:
> On Sun, Oct 13, 2024 at 4:46 PM Song Liu <songliubraving@meta.com> wrote:
> >
> > Hi Amir,
> >
> > > On Oct 13, 2024, at 2:38 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Sun, Oct 13, 2024 at 2:23 AM Song Liu <song@kernel.org> wrote:
> > >>
> > >> Currently, fsnotify_open_perm() is called from security_file_open(). This
> > >> is not right for CONFIG_SECURITY=n and CONFIG_FSNOTIFY=y case, as
> > >> security_file_open() in this combination will be a no-op and not call
> > >> fsnotify_open_perm(). Fix this by calling fsnotify_open_perm() directly.
> > >
> > > Maybe I am missing something.
> > > I like cleaner interfaces, but if it is a report of a problem then
> > > I do not understand what the problem is.
> > > IOW, what does "This is not right" mean?
> >
> > With existing code, CONFIG_FANOTIFY_ACCESS_PERMISSIONS depends on
> > CONFIG_SECURITY, but CONFIG_FSNOTIFY does not depend on
> > CONFIG_SECURITY. So CONFIG_SECURITY=n and CONFIG_FSNOTIFY=y is a
> > valid combination. fsnotify_open_perm() is an fsnotify API, so I
> > think it is not right to skip the API call for this config.
> >
> > >
> > >>
> > >> After this, CONFIG_FANOTIFY_ACCESS_PERMISSIONS does not require
> > >> CONFIG_SECURITY any more. Remove the dependency in the config.
> > >>
> > >> Signed-off-by: Song Liu <song@kernel.org>
> > >> Acked-by: Paul Moore <paul@paul-moore.com>
> > >>
> > >> ---
> > >>
> > >> v1: https://lore.kernel.org/linux-fsdevel/20241011203722.3749850-1-song@kernel.org/
> > >>
> > >> As far as I can tell, it is necessary to back port this to stable. Because
> > >> CONFIG_FANOTIFY_ACCESS_PERMISSIONS is the only user of fsnotify_open_perm,
> > >> and CONFIG_FANOTIFY_ACCESS_PERMISSIONS depends on CONFIG_SECURITY.
> > >> Therefore, the following tags are not necessary. But I include here as
> > >> these are discussed in v1.
> > >
> > > I did not understand why you claim that the tags are or not necessary.
> > > The dependency is due to removal of the fsnotify.h include.
> >
> > I think the Fixes tag is also not necessary, not just the two
> > Depends-on tags. This is because while fsnotify_open_perm() is a
> > fsnotify API, only CONFIG_FANOTIFY_ACCESS_PERMISSIONS really uses
> > (if I understand correctly).
> >
> 
> That is correct.
> 
> > >
> > > Anyway, I don't think it is critical to backport this fix.
> > > The dependencies would probably fail to apply cleanly to older kernels,
> > > so unless somebody cares, it would stay this way.
> >
> > I agree it is not critical to back port this fix. I put the
> > Fixes tag below "---" for this reason.
> >
> > Does this answer your question?
> >
> 
> Yes, I agree with not including any of the tags and not targeting stable.
> 
> Jan, Christian,
> 
> do you agree with the wording of the commit message, or think
> that it needs to be clarified?
> 
> Would you prefer this to go via the fsnotify tree or vfs tree?

I guess I'll take this through fsnotify tree after updating the changelog a
bit.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

