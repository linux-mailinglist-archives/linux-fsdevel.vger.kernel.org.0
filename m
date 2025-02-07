Return-Path: <linux-fsdevel+bounces-41163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6F1A2BBE0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 07:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4E71886061
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 06:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7A1198A29;
	Fri,  7 Feb 2025 06:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g/byUuNE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0AVtNEM4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g/byUuNE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0AVtNEM4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12D615539D;
	Fri,  7 Feb 2025 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738911422; cv=none; b=JWas6kVsd6R+WwMqtcpefHX21yhncD26OKx4hgj56XMSr0QIiXydapMv3PKdMMLy5tVMAlfs3HWSM9/kk8id3+M/Dl1zJZPb9wFqxUuWSRIt0Pwj3j2Q/3Z1Np7zm854DR4Og7SgQYTGUxCUCuGRUVZFNurwKBgvWv49GOog5sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738911422; c=relaxed/simple;
	bh=a+ZrqQ7/dxIQo/7BABs6hf+fQbkXeAcGoBpGTTHuav4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ApZeG3nxs7PnrQsnlGoRrlKL7n3gFh118rVsK4k4RgPWFgMiS4O3eGLlKIE+RmiZsOe++W8LPFHmwbhxRe5XaNTSZ7SqyBqXuUyOuUyDfJBZOws/sPhTXp7w80Jr5KN6PoSh5bwK4R3ZHAc+Dgz7cZ5TTa4krAAXy73rOQSeXtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g/byUuNE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0AVtNEM4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g/byUuNE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0AVtNEM4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B243C21163;
	Fri,  7 Feb 2025 06:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738911418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vVqNNwToD8mb5gmNkOobwURBO8YT/dTtWhgkGdmCTSY=;
	b=g/byUuNEK43A+/ZMqs225i5G2gZ+L/vIkhPn+hKgPPfe/DyiBIqHQctF8jQWZGlok4onwm
	GcRnx5OlAqiccDcRtxY0FGVzYRIz7rYtn0jd5grlpZbiisTkBqNOCq+3Jx5lTv/MsX09PU
	hR4jbDGEJOAo+ZHPnZ37DdSctMZkiTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738911418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vVqNNwToD8mb5gmNkOobwURBO8YT/dTtWhgkGdmCTSY=;
	b=0AVtNEM43RZt0RHtjPbb0ohoAtdWUQy5BGkLgSMZPjtq7ShseB2uMBmNjdK9dN7polsAA/
	5es7VmQ1c05X+oAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738911418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vVqNNwToD8mb5gmNkOobwURBO8YT/dTtWhgkGdmCTSY=;
	b=g/byUuNEK43A+/ZMqs225i5G2gZ+L/vIkhPn+hKgPPfe/DyiBIqHQctF8jQWZGlok4onwm
	GcRnx5OlAqiccDcRtxY0FGVzYRIz7rYtn0jd5grlpZbiisTkBqNOCq+3Jx5lTv/MsX09PU
	hR4jbDGEJOAo+ZHPnZ37DdSctMZkiTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738911418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vVqNNwToD8mb5gmNkOobwURBO8YT/dTtWhgkGdmCTSY=;
	b=0AVtNEM43RZt0RHtjPbb0ohoAtdWUQy5BGkLgSMZPjtq7ShseB2uMBmNjdK9dN7polsAA/
	5es7VmQ1c05X+oAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE1CA13694;
	Fri,  7 Feb 2025 06:56:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nm3JJ7OupWdYMAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 07 Feb 2025 06:56:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Kent Overstreet" <kent.overstreet@linux.dev>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>, "Steve French" <sfrench@samba.org>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Tom Talpey" <tom@talpey.com>, "Paul Moore" <paul@paul-moore.com>,
 "Eric Paris" <eparis@redhat.com>, linux-kernel@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH 1/2] VFS: change kern_path_locked() and
 user_path_locked_at() to never return negative dentry
In-reply-to: <173890403265.22054.8267826472424760232@noble.neil.brown.name>
References: <>,
 <6p2m4jqtl62cabb2xolxt76ycule5prukjzx4nxklvhk23g6qh@luj2tzicloph>,
 <173890403265.22054.8267826472424760232@noble.neil.brown.name>
Date: Fri, 07 Feb 2025 17:53:43 +1100
Message-id: <173891122321.22054.758548441508211924@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 07 Feb 2025, NeilBrown wrote:
> On Fri, 07 Feb 2025, Kent Overstreet wrote:
> > On Fri, Feb 07, 2025 at 02:36:47PM +1100, NeilBrown wrote:
> > > No callers of kern_path_locked() or user_path_locked_at() want a
> > > negative dentry.  So change them to return -ENOENT instead.  This
> > > simplifies callers.
> > > 
> > > This results in a subtle change to bcachefs in that an ioctl will now
> > > return -ENOENT in preference to -EXDEV.  I believe this restores the
> > > behaviour to what it was prior to
> > 
> > I'm not following how the code change matches the commit message?
> 
> Maybe it doesn't.  Let me checked.
> 
> Two of the possible error returns from bch2_ioctl_subvolume_destroy(),
> which implements the BCH_IOCTL_SUBVOLUME_DESTROY ioctl, are -ENOENT and
> -EXDEV.
> 
> -ENOENT is returned if the path named in arg.dst_ptr cannot be found.
> -EXDEV is returned if the filesystem on which that path exists is not
>  the one that the ioctl is called on.
> 
> If the target filesystem is "/foo" and the path given is "/bar/baz" and
> /bar exists but /bar/baz does not, then user_path_locked_at or
> user_path_at will return a negative dentry corresponding to the
> (non-existent) name "baz" in /bar.
> 
> In this case the dentry exists so the filesystem on which it was found
> can be tested, but the dentry is negative.  So both -ENOENT and -EXDEV
> are credible return values.
> 
> 
> - before bbe6a7c899e7 the -EXDEV is tested immediately after the call
>   to user_path_at() so there is no chance that ENOENT will be returned.
>   I cannot actually find where ENOENT could be returned ...  but that
>   doesn't really matter now.

No, that's not right.  user_path_at() never returns a negative dentry.
It isn't documented and I tried reading the code instead of looking at
callers.

So before that commit it DID return ENOENT rather than -EXDEV where as
after that commit it returns -EXDEV rather than -ENOENT.

So my patch IS restoring the old behaviour.  Are you *sure* you want
-EXDEV when given a non-existent path?

Thanks,
NeilBrown


> 
> - after that patch .... again the -EXDEV test comes first. That isn't
>   what I remember.  I must have misread it.
> 
> - after my patch user_path_locked_at() will return -ENOENT if the whole
>   name cannot be found.  So now you get -ENOENT instead of -EXDEV.
> 
> So with my patch, ENOENT always wins, and it was never like that before.
> Thanks for challenging me!
> 
> Do you think there could be a problem with changing the error returned
> in this circumstance? i.e. if you try to destroy a subvolume with a
> non-existant name on a different filesystem could getting -ENOENT
> instead of -EXDEV be noticed?
> 
> Thanks,
> NeilBrown
> 
> 


