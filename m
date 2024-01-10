Return-Path: <linux-fsdevel+bounces-7694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677B082970C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 11:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E595EB26D01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 10:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B553FB2E;
	Wed, 10 Jan 2024 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TShPm84o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IsXaIdU+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TShPm84o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IsXaIdU+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDDE3FB29
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B03FD21E1D;
	Wed, 10 Jan 2024 10:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704881589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vcxlVI/6LvUCJH/YT6qHYKRSiy8vfnR2rGtHFI/h8VU=;
	b=TShPm84ovAlRla3d+XP0+cAGsY2lClSB4uesV/T6hEsuMwJ0oAYmE1u+DIaPil100dIH5H
	/qGy4h4UnE2wG/MFjtq/LbcMAhhMW7KdeZzi2qhReKviQwiUyQ/YkWm7n2KasWlSqVJSbY
	3xkjQqCVsz7AIsjvBME79XbMd9NWLQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704881589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vcxlVI/6LvUCJH/YT6qHYKRSiy8vfnR2rGtHFI/h8VU=;
	b=IsXaIdU+pbaMcGjLKP3guuqIy2k/i7r9NtjvHpdjPLUyt0GahK12IpKdezAdG/qe8SU9Ed
	IuaSlGGp7tJ52hBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704881589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vcxlVI/6LvUCJH/YT6qHYKRSiy8vfnR2rGtHFI/h8VU=;
	b=TShPm84ovAlRla3d+XP0+cAGsY2lClSB4uesV/T6hEsuMwJ0oAYmE1u+DIaPil100dIH5H
	/qGy4h4UnE2wG/MFjtq/LbcMAhhMW7KdeZzi2qhReKviQwiUyQ/YkWm7n2KasWlSqVJSbY
	3xkjQqCVsz7AIsjvBME79XbMd9NWLQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704881589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vcxlVI/6LvUCJH/YT6qHYKRSiy8vfnR2rGtHFI/h8VU=;
	b=IsXaIdU+pbaMcGjLKP3guuqIy2k/i7r9NtjvHpdjPLUyt0GahK12IpKdezAdG/qe8SU9Ed
	IuaSlGGp7tJ52hBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AEE813CB3;
	Wed, 10 Jan 2024 10:13:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eL2JJbVtnmUiWgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Jan 2024 10:13:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0231EA07EB; Wed, 10 Jan 2024 11:13:08 +0100 (CET)
Date: Wed, 10 Jan 2024 11:13:08 +0100
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: compile out fsnotify permission hooks if
 !FANOTIFY_ACCESS_PERMISSIONS
Message-ID: <20240110101308.7r5yggtxel7d6ckk@quack3>
References: <20240109182245.38884-1-amir73il@gmail.com>
 <ee847921-2b4e-4d81-8cfd-9ca5960ac00f@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee847921-2b4e-4d81-8cfd-9ca5960ac00f@kernel.dk>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.63
X-Spamd-Result: default: False [1.63 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SUBJECT_HAS_EXCLAIM(0.00)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[gmail.com,kernel.org,suse.cz,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.07)[95.47%]
X-Spam-Flag: NO

On Tue 09-01-24 11:23:49, Jens Axboe wrote:
> On 1/9/24 11:22 AM, Amir Goldstein wrote:
> > The depency of FANOTIFY_ACCESS_PERMISSIONS on SECURITY made sure that
> 
> dependency
> 
> > the fsnotify permission hooks were never called when SECURITY was
> > disabled.
> > 
> > Moving the fsnotify permission hook out of the secutiy hook broke that
> 
> security
> 
> > optimisation.
> 
> Patch obviously looks good to me, as I already tested it :-)
> 
> Thanks for fixing this up.

Thanks Amir for the fix and Jens for the spelling fixes. I'll fix them on
commit.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

