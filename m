Return-Path: <linux-fsdevel+bounces-41562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49908A31D8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 05:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB3D167034
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 04:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435071E990B;
	Wed, 12 Feb 2025 04:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xdlNUzqR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AhCGTOfs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xdlNUzqR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AhCGTOfs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FC4271834;
	Wed, 12 Feb 2025 04:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739335802; cv=none; b=tEcnW9nm4kwVuVS6qbpf2TeuXryCKwZM/S5WsHfPH0hkGyIhz87iv+Eg6T0CG1AkxhTxvqrkwPJ8HbLOjp+hrPVRML8eNOGXHKaiMQGbJCbHqDWQN6BEY6wt9GA1o1kDSAyoSkwcq5vC2hhaF7Upt9WWWhinD7SbeLV5R2nDs6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739335802; c=relaxed/simple;
	bh=BGHOemmvt71/nTumpd3K985vBmmRHoA9QX0wKRp01H4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=CNal3mAb5p5ZvrY16/c643Bi5PMB65cYqYmsXKD6MGyMOGg57aDHiV39n3A4HQPObYHYCP2gDDRIp8+YPJsNhrpY27+rKv4G0KdVb3fwNvhRgLiQJmnbT5xOKDo7+zEwFjZVaUE+rlEF/pDtXq2OpWct9g1iqMGjm/z0qVJJ7yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xdlNUzqR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AhCGTOfs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xdlNUzqR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AhCGTOfs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFD3F1FD51;
	Wed, 12 Feb 2025 04:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739335799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RfNk99z/BcyLeTgOjcg0CI6DLSs5tska4YouV/6NT/c=;
	b=xdlNUzqR1RL6124TAyEniD5qAUYhq9DMi6O+ckxlN1L20UbUvDsMazSKSL91Ux/B+d0ERJ
	e+R+Cgf4t33BXKPmoB1+XnIlKOTinDbU7I6gPCkY5YkpSufitTf4e3BbD9aSaVxv4H0D0G
	AXHqqd+KbFwkr/ynC1j4Jl1Ty8h2Zrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739335799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RfNk99z/BcyLeTgOjcg0CI6DLSs5tska4YouV/6NT/c=;
	b=AhCGTOfsehueZIMyWlBhU1AfWaaNwCBOXhUIgijaz1tKL07s7Agdh5tikyXofm4o831ud+
	/nTFnySeHHNvbgBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xdlNUzqR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AhCGTOfs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739335799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RfNk99z/BcyLeTgOjcg0CI6DLSs5tska4YouV/6NT/c=;
	b=xdlNUzqR1RL6124TAyEniD5qAUYhq9DMi6O+ckxlN1L20UbUvDsMazSKSL91Ux/B+d0ERJ
	e+R+Cgf4t33BXKPmoB1+XnIlKOTinDbU7I6gPCkY5YkpSufitTf4e3BbD9aSaVxv4H0D0G
	AXHqqd+KbFwkr/ynC1j4Jl1Ty8h2Zrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739335799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RfNk99z/BcyLeTgOjcg0CI6DLSs5tska4YouV/6NT/c=;
	b=AhCGTOfsehueZIMyWlBhU1AfWaaNwCBOXhUIgijaz1tKL07s7Agdh5tikyXofm4o831ud+
	/nTFnySeHHNvbgBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D79E13874;
	Wed, 12 Feb 2025 04:49:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DdP2AHQorGfcbgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 12 Feb 2025 04:49:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Dave Chinner" <david@fromorbit.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/19] VFS: introduce lookup_and_lock() and friends
In-reply-to: <20250207202235.GH1977892@ZenIV>
References: <>, <20250207202235.GH1977892@ZenIV>
Date: Wed, 12 Feb 2025 15:49:53 +1100
Message-id: <173933579332.22054.11267140614769378076@noble.neil.brown.name>
X-Rspamd-Queue-Id: EFD3F1FD51
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 08 Feb 2025, Al Viro wrote:
> On Thu, Feb 06, 2025 at 04:42:45PM +1100, NeilBrown wrote:
> > lookup_and_lock() combines locking the directory and performing a lookup
> > prior to a change to the directory.
> > Abstracting this prepares for changing the locking requirements.
> > 
> > done_lookup_and_lock() provides the inverse of putting the dentry and
> > unlocking.
> > 
> > For "silly_rename" we will need to lookup_and_lock() in a directory that
> > is already locked.  For this purpose we add LOOKUP_PARENT_LOCKED.
> 
> Ewww...  I do realize that such things might appear in intermediate
> stages of locking massage, but they'd better be _GONE_ by the end of it.
> Conditional locking of that sort is really asking for trouble.
> 
> If nothing else, better split the function in two variants and document
> the differences; that kind of stuff really does not belong in arguments.
> If you need it to exist through the series, that is - if not, you should
> just leave lookup_one_qstr() for the "locked" case from the very beginning.

That's what I did at first, but then when I realised I had to pass the
lookup flags around everywhere....  Will revert.

> 
> > This functionality is exported as lookup_and_lock_one() which takes a
> > name and len rather than a qstr.
> 
> ... for the sake of ...?

nfsd.

Thanks,
NeilBrown

