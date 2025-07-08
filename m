Return-Path: <linux-fsdevel+bounces-54238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BBEAFC9C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 13:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA87A564652
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 11:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2732D9ED4;
	Tue,  8 Jul 2025 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PUZD10zD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GCKHGtsI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PUZD10zD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GCKHGtsI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A4D25E828
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974809; cv=none; b=ULePhZb8P2fOZQoHGj7r96iGeBFs1YVPzOO3BoUv28fGa53faPqg6Sx83apkXHgXXLljE2fZ2JZkp9kCqlpg5l6dSfNTLp4kqQOLeGMvjo6EP+gHvAX09u7W1kD4cZULwMBwOPwKBUWW4rMgRzdU2Gx9exsUDsF7TBq/foRqr/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974809; c=relaxed/simple;
	bh=fH3KiuImjrjoK1V5mqJgQtITke8YfINetATCAuDN2dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUtJR2RSh3MFZqbTo6iV56axsHNl1LbuKD57tn91Xy2j3RcU96fNenp4PntL8n2OnOZ7zQTUbKG7LnN793nIJPjR+pm82CdYIvo/CZRbfvqZBiC3xFSF/+nyzvCCEnDcALAIe4PUrrfnw625rOR1gN/rr4tdZJUOl7wy2G8amg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PUZD10zD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GCKHGtsI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PUZD10zD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GCKHGtsI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B9982117C;
	Tue,  8 Jul 2025 11:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751974805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDUaD6llVPcuJQkCo8BDWrwMHFrqWPeP9tmChMPue6I=;
	b=PUZD10zDXrpRSyxTrKEfu/qAKvGgZFbEloDmvtEGr/XWke0dirDBTNWYFkY4k7VZ7+J2F0
	m3F0WphjIQvKUbjl5uArVBECMt3XDK8tRQZ6sUVDQzvoGepPTcEuIeMTWuz/Dusd9X4jov
	84EPh2SuGTD6lpKqNzwCASYvESI+D/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751974805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDUaD6llVPcuJQkCo8BDWrwMHFrqWPeP9tmChMPue6I=;
	b=GCKHGtsIxT/ucuR7u4pb/QXaj03l4i+868wZURnQrxvOopNzN8f6R6tQsf82PzaY7B7DcE
	n2Fm9Y67X/1u9iAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PUZD10zD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GCKHGtsI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751974805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDUaD6llVPcuJQkCo8BDWrwMHFrqWPeP9tmChMPue6I=;
	b=PUZD10zDXrpRSyxTrKEfu/qAKvGgZFbEloDmvtEGr/XWke0dirDBTNWYFkY4k7VZ7+J2F0
	m3F0WphjIQvKUbjl5uArVBECMt3XDK8tRQZ6sUVDQzvoGepPTcEuIeMTWuz/Dusd9X4jov
	84EPh2SuGTD6lpKqNzwCASYvESI+D/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751974805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDUaD6llVPcuJQkCo8BDWrwMHFrqWPeP9tmChMPue6I=;
	b=GCKHGtsIxT/ucuR7u4pb/QXaj03l4i+868wZURnQrxvOopNzN8f6R6tQsf82PzaY7B7DcE
	n2Fm9Y67X/1u9iAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19A4D13A54;
	Tue,  8 Jul 2025 11:40:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QIE9BpUDbWg8FAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 08 Jul 2025 11:40:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 99576A098F; Tue,  8 Jul 2025 13:40:04 +0200 (CEST)
Date: Tue, 8 Jul 2025 13:40:04 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, jack@suse.cz, 
	josef@toxicpanda.com, lesha@meta.com, linux-fsdevel@vger.kernel.org, sargun@meta.com
Subject: Re: [PATCH] fanotify: introduce unique event identifier
Message-ID: <pcyd4ejepc6akgw3uq2bxuf2e255zhirbpfxxe463zj2m7iyfl@6bgetglt74ei>
References: <CAOQ4uxi8xjfhKLc7T0WGjOmtO4wRQT6b5MLUdaST2KE01BsKBg@mail.gmail.com>
 <20250701072209.1549495-1-ibrahimjirdeh@meta.com>
 <CAOQ4uxhrbN4k+YMd99h8jGyRc0d_n05H8q-gTuJ35jkO1aLO7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhrbN4k+YMd99h8jGyRc0d_n05H8q-gTuJ35jkO1aLO7A@mail.gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 3B9982117C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Mon 07-07-25 18:33:41, Amir Goldstein wrote:
> On Tue, Jul 1, 2025 at 9:23 AM Ibrahim Jirdeh <ibrahimjirdeh@meta.com> wrote:
> > On 6/30/25, 9:06 AM, "Amir Goldstein" <amir73il@gmail.com <mailto:amir73il@gmail.com>> wrote:
> > > On Mon, Jun 30, 2025 at 4:50 PM Jan Kara <jack@suse.cz> wrote:
> > > > I agree expanding fanotify_event_metadata painful. After all that's the
> > > > reason why we've invented the additional info records in the first place :).
> > > > So I agree with putting the id either in a separate info record or overload
> > > > something in fanotify_event_metadata.
> > > >
> > > > On Sun 29-06-25 08:50:05, Amir Goldstein wrote:
> > > > > I may have mentioned this before, but I'll bring it up again.
> > > > > If we want to overload event->fd with response id I would consider
> > > > > allocating response_id with idr_alloc_cyclic() that starts at 256
> > > > > and then set event->fd = -response_id.
> > > > > We want to skip the range -1..-255 because it is used to report
> > > > > fd open errors with FAN_REPORT_FD_ERROR.
> > > >
> > > > I kind of like this. It looks elegant. The only reason I'm hesitating is
> > > > that as you mentioned with persistent notifications we'll likely need
> > > > 64-bit type for identifying event. But OTOH requirements there are unclear
> > > > and I can imagine even userspace assigning the ID. In the worst case we
> > > > could add info record for this persistent event id.
> > >
> > > Yes, those persistent id's are inherently different from the response key,
> > > so I am not really worried about duplicity.
> > >
> > > > So ok, let's do it as you suggest.
> > >
> > > Cool.
> > >
> > > I don't think that we even need an explicit FAN_REPORT_EVENT_ID,
> > > because it is enough to say that (fid_mode != 0) always means that
> > > event->fd cannot be >= 0 (like it does today), but with pre-content events
> > > event->fd can be a key < -255?
> > >
> > > Ibrahim,
> > >
> > > Feel free to post the patches from my branch, if you want
> > > post the event->fd = -response_id implementation.
> > >
> > > I also plan to post them myself when I complete the pre-dir-content patches.
> >
> > Sounds good. I will pull in the FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID branch
> > and resubmit this patch now that we have consensus on the approach here.
> 
> FYI, I pushed some semantic changed to fan_pre_content_fid branch:
> 
> - Created shortcut macro FAN_CLASS_PRE_CONTENT_FID
> - Created a group priority FSNOTIFY_PRIO_PRE_CONTENT_FID
> 
> Regarding the question whether reporting response_id instead of event->fd
> requires an opt-in, so far my pre-dir-content patches can report event->fd,
> so my preference id the response_id behavior will require opt-in with init
> flag FAN_REPORT_RESPONSE_ID.

No problem with the FAN_REPORT_RESPONSE_ID feature flag, just we'll see
whether the classical fd-based events are useful enough with
pre-dir-content events to justify their existence ;).

> @@ -67,6 +67,7 @@
>  #define FAN_REPORT_TARGET_FID  0x00001000      /* Report dirent target id  */
>  #define FAN_REPORT_FD_ERROR    0x00002000      /* event->fd can report error */
>  #define FAN_REPORT_MNT         0x00004000      /* Report mount events */
> +#define FAN_REPORT_RESPONSE_ID 0x00008000      /* event->fd is a response id */
> 
>  /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
>  #define FAN_REPORT_DFID_NAME   (FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
> @@ -144,7 +145,10 @@ struct fanotify_event_metadata {
>         __u8 reserved;
>         __u16 metadata_len;
>         __aligned_u64 mask;
> -       __s32 fd;
> +       union {
> +               __s32 fd;
> +               __s32 id; /* FAN_REPORT_RESPONSE_ID */
> +       }
>         __s32 pid;
>  };
> 
> @@ -228,7 +232,10 @@ struct fanotify_event_info_mnt {
>  #define FAN_RESPONSE_INFO_AUDIT_RULE   1
> 
>  struct fanotify_response {
> -       __s32 fd;
> +       union {
> +               __s32 fd;
> +               __s32 id; /* FAN_REPORT_RESPONSE_ID */
> +       }
>         __u32 response;
>  };
> 
> And to add a check like this:
> 
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1583,6 +1583,16 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int,
> flags, unsigned int, event_f_flags)
>             (class | fid_mode) != FAN_CLASS_PRE_CONTENT_FID)
>                 return -EINVAL;
> 
> +       /*
> +        * With group that reports fid info and allows only pre-content events,
> +        * user may request to get a response id instead of event->fd.
> +        * FAN_REPORT_FD_ERROR does not make sense in this case.
> +        */
> +       if ((flags & FAN_REPORT_RESPONSE_ID) &&
> +           ((flag & FAN_REPORT_FD_ERROR) ||
> +            !fid_mode || class != FAN_CLASS_PRE_CONTENT_FID))
> +               return -EINVAL;
> +
> 
> 
> This new group mode is safe, because:
> 1. event->fd is redundant to target fid
> 2. other group priorities allow mixing async events in the same group
>     async event can have negative event->fd which signifies an error
>     to open event->fd

I'm not sure I follow here. I'd expect:

	if ((flags & FAN_REPORT_RESPONSE_ID) && !fid_mode)
		return -EINVAL;

I.e., if you ask for event ids, we don't return fds at all so you better
had FID enabled to see where the event happened. And then there's no need
for FAN_CLASS_PRE_CONTENT_FID at all. Yes, you cannot mix async fanotify
events with fd with permission events using event id but is that a sane
combination? What case do you have in mind that justifies this
complication?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

