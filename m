Return-Path: <linux-fsdevel+bounces-10347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860B684A23D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 19:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF8D1B2182B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 18:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB03482F0;
	Mon,  5 Feb 2024 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q4KNRKtw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ROwfoMR6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q4KNRKtw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ROwfoMR6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D16247F76
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157642; cv=none; b=W8V6ftLb7Z5U3hcD8Zpjy/XosXBrj4/MHl6RRF0/odVxBddfW2BrO7qnsAqmZX5Tz8K0TPgr5bQaeCfunvGdWeEo59T3R9a+n6BBc2TkcmJ8j0yOSL+oPerzDxuxI1q23i3SALhlPKhRxJp15+jG+COxuDTsXA7hqeiwKLjFjt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157642; c=relaxed/simple;
	bh=HVddpkjrThTI+wcVOu7rQblO8jHrhD3YfQUQzyHTd6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pi8NCVrTRMOuicxDU38Abwneb/v4bIoRnfc2YM7NJJH9P+360dMsWH6B0HC/b1579NzAHStYG5vra6AZ8aJdgVzy+qk/+BXQ1j92xvAoN1p4+x7r+EpSXU/zuZZIYSsFclLZ0KYa0OgPNnrVheZFPuIguYtNtG3z4t/cO/P94ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q4KNRKtw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ROwfoMR6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q4KNRKtw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ROwfoMR6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 01A171F74C;
	Mon,  5 Feb 2024 18:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707157639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abq8dpjAqaY2FioVf6B14pRgDEVBdpv99Ovy0kuAf6I=;
	b=Q4KNRKtwdxtP8ixTro4AbkFEEXfYSAXqPOlR+LyKHkokpw5LgSCFAuJxH7yWA+JpVqvOfq
	GJEg63M1rPpty2h9D3DIcRE+cmx6DCvREwFzm6gpbnDsSw43/SZMUvNfKdbHmA1ZglSd14
	wSwbxDg+MKakhzUGp8I2Y0jFKQNKlxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707157639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abq8dpjAqaY2FioVf6B14pRgDEVBdpv99Ovy0kuAf6I=;
	b=ROwfoMR6H8zIb4czU4uvcbThaqkpvZyRxtDu3lv3eYiKcCpNv8zqpHt3N9DZAHqyVnQuBH
	snc/w6mD7Q80/ZBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707157639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abq8dpjAqaY2FioVf6B14pRgDEVBdpv99Ovy0kuAf6I=;
	b=Q4KNRKtwdxtP8ixTro4AbkFEEXfYSAXqPOlR+LyKHkokpw5LgSCFAuJxH7yWA+JpVqvOfq
	GJEg63M1rPpty2h9D3DIcRE+cmx6DCvREwFzm6gpbnDsSw43/SZMUvNfKdbHmA1ZglSd14
	wSwbxDg+MKakhzUGp8I2Y0jFKQNKlxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707157639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abq8dpjAqaY2FioVf6B14pRgDEVBdpv99Ovy0kuAf6I=;
	b=ROwfoMR6H8zIb4czU4uvcbThaqkpvZyRxtDu3lv3eYiKcCpNv8zqpHt3N9DZAHqyVnQuBH
	snc/w6mD7Q80/ZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EACD7132DD;
	Mon,  5 Feb 2024 18:27:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RNRNOYYowWWOLgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Feb 2024 18:27:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8A2FDA0809; Mon,  5 Feb 2024 19:27:18 +0100 (CET)
Date: Mon, 5 Feb 2024 19:27:18 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
	Sweet Tea Dorminy <thesweettea@meta.com>
Subject: Re: [RFC][PATCH] fanotify: allow to set errno in FAN_DENY permission
 response
Message-ID: <20240205182718.lvtgfsxcd6htbqyy@quack3>
References: <20231208080135.4089880-1-amir73il@gmail.com>
 <20231213172844.ygjbkyl6i4gj52lt@quack3>
 <CAOQ4uxjMv_3g1XSp41M7eV+Tr+6R2QK0kCY=+AuaMCaGj0nuJA@mail.gmail.com>
 <20231215153108.GC683314@perftesting>
 <CAOQ4uxjVuhznNZitsjzDCanqtNrHvFN7Rx4dhUEPeFxsM+S22A@mail.gmail.com>
 <20231218143504.abj3h6vxtwlwsozx@quack3>
 <CAOQ4uxjNzSf6p9G79vcg3cxFdKSEip=kXQs=MwWjNUkPzTZqPg@mail.gmail.com>
 <CAOQ4uxgxCRoqwCs7mr+7YP4mmW7JXxRB20r-fsrFe2y5d3wDqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgxCRoqwCs7mr+7YP4mmW7JXxRB20r-fsrFe2y5d3wDqQ@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Q4KNRKtw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ROwfoMR6
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 01A171F74C
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

I'm sorry for the delay. The last week was busy and this fell through the
cracks.

On Mon 29-01-24 20:30:34, Amir Goldstein wrote:
> On Mon, Dec 18, 2023 at 5:53 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > In the HttpDirFS HSM demo, I used FAN_OPEN_PERM on a mount mark
> > to deny open of file during the short time that it's content is being
> > punched out [1].
> > It is quite complicated to explain, but I only used it for denying access,
> > not to fill content and not to write anything to filesystem.
> > It's worth noting that returning EBUSY in that case would be more meaningful
> > to users.
> >
> > That's one case in favor of allowing FAN_DENY_ERRNO for FAN_OPEN_PERM,
> > but mainly I do not have a proof that people will not need it.
> >
> > OTOH, I am a bit concerned that this will encourage developer to use
> > FAN_OPEN_PERM as a trigger to filling file content and then we are back to
> > deadlock risk zone.
> >
> > Not sure which way to go.
> >
> > Anyway, I think we agree that there is no reason to merge FAN_DENY_ERRNO
> > before FAN_PRE_* events, so we can continue this discussion later when
> > I post FAN_PRE_* patches - not for this cycle.
> 
> I started to prepare the pre-content events patches for posting and got back
> to this one as well.
> 
> Since we had this discussion I have learned of another use case that
> requires filling file content in FAN_OPEN_PERM hook, FAN_OPEN_EXEC_PERM
> to be exact.
>
> The reason is that unless an executable content is filled at execve() time,
> there is no other opportunity to fill its content without getting -ETXTBSY.

Yes, I've been scratching my head over this usecase for a few days. I was
thinking whether we could somehow fill in executable (and executed) files on
access but it all seemed too hacky so I agree that we probably have to fill
them in on open. 

> So to keep things more flexible, I decided to add -ETXTBSY to the
> allowed errors with FAN_DENY_ERRNO() and to decided to allow
> FAN_DENY_ERRNO() with all permission events.
>
> To keep FAN_DENY_ERRNO() a bit more focused on HSM, I have
> added a limitation that FAN_DENY_ERRNO() is allowed only for
> FAN_CLASS_PRE_CONTENT groups.

I have no problem with adding -ETXTBSY to the set of allowed errors. That
makes sense. Adding FAN_DENY_ERRNO() to all permission events in
FAN_CLASS_PRE_CONTENT groups - OK, if we don't find anything better - I
wanted to hash out another possibility here: Currently all permission
events (and thus also the events we plan to use for HSM AFAIU) are using
'fd' to identify file where the event happened. This is used as identifier
for response, can be used to fill in file contents for HSM but it also
causes issues such as the problem with exec(2) occasionally failing if this
fd happens to get closed only after exec(2) gets to checking
deny_write_access(). So what if we implemented events needed for HSM as FID
events (we'd have think how to match replies to events)? Then the app would
open the file for filling in using FID as well as it would naturally close
the handle before replying so problems with exec(2) would not arise. These
would be essentially new events (so far we didn't allow permission events
in FID groups) so allowing FAN_DENY_ERRNO() replies for them would be
natural. Overall it would seem like a cleaner "clean room implementation"
API?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

