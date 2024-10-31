Return-Path: <linux-fsdevel+bounces-33344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D6A9B7B0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 13:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162FC1F247AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 12:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153A019CD19;
	Thu, 31 Oct 2024 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RxSs4OLK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BABvsNtF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RxSs4OLK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BABvsNtF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA1A19CC07
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378888; cv=none; b=U54xfAX9+D+v3jjj/H3rQ3gJ4PFID8NaJOF9PZge3cQifAGrnfsgluSGSrOgw+4G5bsx9H3/UGzu/yMjcpfqlrWBMbkMM5h74ADKrc49Cg5+tz+/8RFknSqibCuwoH7YKAsFD9++qq4HyVuSDF5aCfYWEDeFWb9pkXVMCslpyng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378888; c=relaxed/simple;
	bh=FaPBwI8Cg1m6lOYBgOW8k3/Yy4Q80MQKisdXg+AWhKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cib1nelSotLaZYPZWD8bZEjOszJ7O9ECmz2hugmVhZD8K3nyoXmYHWY34BK3qyLXYgtg4AtuOHYKxfo/stzz/DFKLKg+hpXq40Zmn8kp8FRKeE/5nDT0jpwCWuu0B4wF8XZYwPUlasumL6/lNF1tVS9QzhWEShcNpXV5ssuCh1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RxSs4OLK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BABvsNtF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RxSs4OLK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BABvsNtF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E52521A9A;
	Thu, 31 Oct 2024 12:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730378884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fte6/sC0oGdp4VKkI4YU2oH0wvQwxQnoH6FnMpllK/c=;
	b=RxSs4OLKM0HaPpFqH0hM+LhCN8+OikxrNzjkM9TRRcmU1iqVx81XRO/U7NcBWD29SOzS8+
	x9NlbEnckCEfsom3DRAfYqqaNuNdrjc97TBHFf+prC3KqNu/tiDTDQlrS3xP5Fdzta9Oi3
	NOPFnNsBeL/50ItrVIjHGjjroqPntXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730378884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fte6/sC0oGdp4VKkI4YU2oH0wvQwxQnoH6FnMpllK/c=;
	b=BABvsNtFq5GFp7/dfpU5sd76sjzsj0Q/cOkEocscd65L45eIgP1HdmNvUT4goWUvlUBAAw
	WlzpKOkV9ZjmUjBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730378884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fte6/sC0oGdp4VKkI4YU2oH0wvQwxQnoH6FnMpllK/c=;
	b=RxSs4OLKM0HaPpFqH0hM+LhCN8+OikxrNzjkM9TRRcmU1iqVx81XRO/U7NcBWD29SOzS8+
	x9NlbEnckCEfsom3DRAfYqqaNuNdrjc97TBHFf+prC3KqNu/tiDTDQlrS3xP5Fdzta9Oi3
	NOPFnNsBeL/50ItrVIjHGjjroqPntXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730378884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fte6/sC0oGdp4VKkI4YU2oH0wvQwxQnoH6FnMpllK/c=;
	b=BABvsNtFq5GFp7/dfpU5sd76sjzsj0Q/cOkEocscd65L45eIgP1HdmNvUT4goWUvlUBAAw
	WlzpKOkV9ZjmUjBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3BD8136A5;
	Thu, 31 Oct 2024 12:48:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /It9O4N8I2ctawAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 31 Oct 2024 12:48:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9ABAEA086F; Thu, 31 Oct 2024 13:47:48 +0100 (CET)
Date: Thu, 31 Oct 2024 13:47:48 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: Re: [PATCH 02/10] fsnotify: introduce pre-content permission event
Message-ID: <20241031124748.edlgoayucxrstlhn@quack3>
References: <cover.1721931241.git.josef@toxicpanda.com>
 <a6010470b2d11f186cba89b9521940716fa66f3b.1721931241.git.josef@toxicpanda.com>
 <20240801163134.4rj7ogd5kthsnsps@quack3>
 <CAOQ4uxg83erL-Esw4qf6+p+gBTDspBRWcFyMM_0HC1oVCAzf4Q@mail.gmail.com>
 <CAOQ4uxi6YR1ryiU34UtkSpe64jVaBBi3146e=oVuBvxsSMiCCA@mail.gmail.com>
 <20241025130925.ctbaq6lx3drvcdev@quack3>
 <CAOQ4uxhtiEW6RstB18CAMdPA6=H5AvUxdwEix3iDw=wAfAOSBQ@mail.gmail.com>
 <CAOQ4uxjZkbQQjDbWi1jw5ErdhZATk1LqLF9NB3Un_TGDJROrNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjZkbQQjDbWi1jw5ErdhZATk1LqLF9NB3Un_TGDJROrNg@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Sat 26-10-24 08:58:47, Amir Goldstein wrote:
> On Fri, Oct 25, 2024 at 3:39 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Fri, Oct 25, 2024 at 3:09 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Fri 25-10-24 09:55:21, Amir Goldstein wrote:
> > > > On Sat, Aug 3, 2024 at 6:52 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > On Thu, Aug 1, 2024 at 6:31 PM Jan Kara <jack@suse.cz> wrote:
> > > > > > On Thu 25-07-24 14:19:39, Josef Bacik wrote:
> > > > > > > From: Amir Goldstein <amir73il@gmail.com>
> > > > > > >
> > > > > > > The new FS_PRE_ACCESS permission event is similar to FS_ACCESS_PERM,
> > > > > > > but it meant for a different use case of filling file content before
> > > > > > > access to a file range, so it has slightly different semantics.
> > > > > > >
> > > > > > > Generate FS_PRE_ACCESS/FS_ACCESS_PERM as two seperate events, same as
> > > > > > > we did for FS_OPEN_PERM/FS_OPEN_EXEC_PERM.
> > > > > > >
> > > > > > > FS_PRE_MODIFY is a new permission event, with similar semantics as
> > > > > > > FS_PRE_ACCESS, which is called before a file is modified.
> > > > > > >
> > > > > > > FS_ACCESS_PERM is reported also on blockdev and pipes, but the new
> > > > > > > pre-content events are only reported for regular files and dirs.
> > > > > > >
> > > > > > > The pre-content events are meant to be used by hierarchical storage
> > > > > > > managers that want to fill the content of files on first access.
> > > > > > >
> > > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > >
> > > > > > The patch looks good. Just out of curiosity:
> > > > > >
> > > > > > > diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> > > > > > > index 8be029bc50b1..21e72b837ec5 100644
> > > > > > > --- a/include/linux/fsnotify_backend.h
> > > > > > > +++ b/include/linux/fsnotify_backend.h
> > > > > > > @@ -56,6 +56,9 @@
> > > > > > >  #define FS_ACCESS_PERM               0x00020000      /* access event in a permissions hook */
> > > > > > >  #define FS_OPEN_EXEC_PERM    0x00040000      /* open/exec event in a permission hook */
> > > > > > >
> > > > > > > +#define FS_PRE_ACCESS                0x00100000      /* Pre-content access hook */
> > > > > > > +#define FS_PRE_MODIFY                0x00200000      /* Pre-content modify hook */
> > > > > >
> > > > > > Why is a hole left here in the flag space?
> > > > >
> > > > > Can't remember.
> > > > >
> > > > > Currently we have a draft design for two more events
> > > > > FS_PATH_ACCESS, FS_PATH_MODIFY
> > > > > https://github.com/amir73il/man-pages/commits/fan_pre_path
> > > > >
> > > > > So might have been a desire to keep the pre-events group on the nibble.
> > > >
> > > > Funny story.
> > > >
> > > > I straced a program with latest FS_PRE_ACCESS (0x00080000) and
> > > > see what I got:
> > > >
> > > > fanotify_mark(3, FAN_MARK_ADD|FAN_MARK_MOUNT,
> > > > FAN_CLOSE_WRITE|FAN_OPEN_PERM|FAN_ACCESS_PERM|FAN_DIR_MODIFY|FAN_ONDIR,
> > > > AT_FDCWD, "/vdd") = 0
> > > >
> > > > "FAN_DIR_MODIFY"! a blast from the past [1]
> > > >
> > > > It would have been nice if we reserved 0x00080000 for FAN_PATH_MODIFY [2]
> > > > to be a bit less confusing for users with old strace.
> > > >
> > > > WDYT?
> > >
> > > Yeah, reusing that bit for something semantically close would reduce some
> > > confusion. But realistically I don't think FAN_DIR_MODIFY go wide use when
> > > it was never supported in a released upstream kernel.
> >
> > No, but its legacy lives in strace forever...
> >
> 
> Speaking of legacy events, you will notice that in the fan_pre_access
> branch I swapped the order of FS_PRE_ACCESS to be generated
> before FS_ACCESS_PERM.
> 
> It is a semantic difference that probably does not matter much in practice,
> but I justified it as "need to fill the content before content can be inspected"
> because FS_ACCESS_PERM is the legacy Anti-malware event.
> 
> This order is also aligned with the priority group associated with those
> events (PRE_CONTENT before CONTENT).

Yes, I've noticed this and it makes sense. Thanks for the expanded
rationale.

> But from a wider POV, my feeling is that FS_ACCESS_PERM is not
> really used by anyone and it is baggage that we need to try to get rid of.
> It is not worth the bloat of the inlined fsnotify_file_area_perm() hook.
> It is not worth the wasted cycles in the __fsnotify_parent() call that will
> not be optimized when there is any high priority group listener on the sb.
> 
> I am tempted to try and combine the PRE/PERM access events into
> a single event and make sure that no fanotify group can subscribe to
> both of them at the same time, so a combined event can never be seen,
> but it is not very easy to rationalize this API.
> 
> For example, if we would have required FAN_REPORT_RANGE init flag
> for subscribing to FAN_PRE_ACCESS, then we could have denied the legacy
> FAN_ACCESS_PERM in this group, but I don't think that we want to do that (?).

Yeah, this would look a bit weird in the API. If you really think that
FAN_ACCESS_PERM is dead (which it may well be but I would not bet on it),
then we could start a deprecation period for it and if nobody comes back to
us saying they still use it, we can then remove it from the kernel
altogether.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

