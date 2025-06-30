Return-Path: <linux-fsdevel+bounces-53374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CABAEE2BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 17:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30BCC1898F54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE9F28FAAD;
	Mon, 30 Jun 2025 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t98y25Gr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n+GHKMzU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t98y25Gr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n+GHKMzU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DD028F942
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297809; cv=none; b=Am4gw08H5PGqsoMaLCrzgw/vT+1M4ERYdE4S5puTvmiW1tMhZ6hlFSy1SkAZku5OuFfxbqa8FsIwDr/uddnDpfq63M5d15TZIdupySmWceF/lQ8mf++LZWy/GoVJk1aZ/U8EpdS01dOtHCQNemiNFNaHqkz82W1jahi8m15tL/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297809; c=relaxed/simple;
	bh=XxcppwMVZNyonxQ81jlpCQgkf/bbp5WD26AOzm0x2S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bckeurjy11vLtNpxjKr6DCvOGVIUSvSQTBfMsC9Jnrsa3/Rn3yUSOOhtWusU/EPbNkfQN+xVOhdl6ZySUqm0fEdIL1rSAq/aJDafCyUoXfnvMZen7rhMX+jGHI+/TpsaSYNLiROrFQU9+Byj4TJnb30D9wIo02tWPPCDQ2weLck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t98y25Gr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n+GHKMzU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t98y25Gr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n+GHKMzU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 086A821163;
	Mon, 30 Jun 2025 15:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751297806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ysf7+c4l+VCjY/NfxKVQbt3dUbhPjQbh/e7WSTOoTTE=;
	b=t98y25GrD4NCnlOcIVKIizUaFGFhIJaBay8HlvinHbCpeLrwbFq70qg9Pjfz5EnnoeOR+R
	uyjmKdX28sfelB9xq75MoWUyos8clq4Q/Vqv7abfDCgi5jKPWWPbYiQRzLfJ6uujzqkM1c
	X1CQm1oVl3p3Ql/wiamlQtB1Bqofg9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751297806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ysf7+c4l+VCjY/NfxKVQbt3dUbhPjQbh/e7WSTOoTTE=;
	b=n+GHKMzUiYwizxIKjKXEgnLzHq1LBaoAA52skpm+Pl2X/b/XbmSE8f+2577fyvm6fc0VN8
	vystYmG+G5GxOyCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=t98y25Gr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=n+GHKMzU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751297806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ysf7+c4l+VCjY/NfxKVQbt3dUbhPjQbh/e7WSTOoTTE=;
	b=t98y25GrD4NCnlOcIVKIizUaFGFhIJaBay8HlvinHbCpeLrwbFq70qg9Pjfz5EnnoeOR+R
	uyjmKdX28sfelB9xq75MoWUyos8clq4Q/Vqv7abfDCgi5jKPWWPbYiQRzLfJ6uujzqkM1c
	X1CQm1oVl3p3Ql/wiamlQtB1Bqofg9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751297806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ysf7+c4l+VCjY/NfxKVQbt3dUbhPjQbh/e7WSTOoTTE=;
	b=n+GHKMzUiYwizxIKjKXEgnLzHq1LBaoAA52skpm+Pl2X/b/XbmSE8f+2577fyvm6fc0VN8
	vystYmG+G5GxOyCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9CCB13983;
	Mon, 30 Jun 2025 15:36:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UaQQOQ2vYmgaCQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 30 Jun 2025 15:36:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6B6D9A0A31; Mon, 30 Jun 2025 17:36:37 +0200 (CEST)
Date: Mon, 30 Jun 2025 17:36:37 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, jack@suse.cz, 
	josef@toxicpanda.com, lesha@meta.com, linux-fsdevel@vger.kernel.org, sargun@meta.com
Subject: Re: [PATCH] fanotify: support custom default close response
Message-ID: <tq6g6bkzojggcwu3bxkj57ongbvyynykylrtmlphqa7g7wb6f2@7gid5uogbfc4>
References: <20250623192503.2673076-1-ibrahimjirdeh@meta.com>
 <CAOQ4uxguBgMuUZqs0bT_cDyEX6465YkQkUHFPFE4tndys-y2Wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxguBgMuUZqs0bT_cDyEX6465YkQkUHFPFE4tndys-y2Wg@mail.gmail.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 086A821163
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01
X-Spam-Level: 

On Tue 24-06-25 08:30:03, Amir Goldstein wrote:
> On Mon, Jun 23, 2025 at 9:26 PM Ibrahim Jirdeh <ibrahimjirdeh@meta.com> wrote:
> >
> > Currently the default response for pending events is FAN_ALLOW.
> > This makes default close response configurable. The main goal
> > of these changes would be to provide better handling for pending
> > events for lazy file loading use cases which may back fanotify
> > events by a long-lived daemon. For earlier discussion see:
> > https://lore.kernel.org/linux-fsdevel/6za2mngeqslmqjg3icoubz37hbbxi6bi44canfsg2aajgkialt@c3ujlrjzkppr/
> 
> These lore links are typically placed at the commit message tail block
> if related to a suggestion you would typically use:
> 
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxi6PvAcT1vL0d0e+7YjvkfU-kwFVVMAN-tc-FKXe1wtSg@mail.gmail.com/
> Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
> 
> This way reviewers whose response is "what a terrible idea!" can
> point their arrows at me instead of you ;)
> 
> Note that this is a more accurate link to the message where the default
> response API was proposed, so readers won't need to sift through
> this long thread to find the reference.

I've reread that thread to remember how this is supposed to be used. After
thinking about it now maybe we could just modify how pending fanotify
events behave in case of group destruction? Instead of setting FAN_ALLOW in
fanotify_release() we'd set a special event state that will make fanotify
group iteration code bubble up back to fsnotify() and restart the event
generation loop there?

In the usual case this would behave the same way as setting FAN_ALLOW (just
in case of multiple permission event watchers some will get the event two
times which shouldn't matter). In case of careful design with fd store
etc., the daemon can setup the new notification group as needed and then
close the fd from the old notification group at which point it would
receive all the pending events in the new group. I can even see us adding
ioctl to the fanotify group which when called will result in the same
behavior (i.e., all pending permission events will get the "retry"
response). That way the new daemon could just take the old fd from the fd
store and call this ioctl to receive all the pending events again.

No need for the new default response. We probably need to provide a group
feature flag for this so that userspace can safely query kernel support for
this behavior but otherwise even that wouldn't be really needed.

What do you guys think?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

