Return-Path: <linux-fsdevel+bounces-41155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E97A4A2BA6D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 05:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218EB3A82F5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 04:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AD12327B9;
	Fri,  7 Feb 2025 04:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zTcjZgn0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QwJ1xeQe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TTi0Azu2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7GQFZErX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D12715E5B8;
	Fri,  7 Feb 2025 04:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738904046; cv=none; b=TnZ3Vv3Xi6ohCLPkpoFunei2ZekyeAKMy7BZ2dfdzF2ZQsDUXTnQCW2C5/6PbqYhNylr2Kx9lzfjsIV7oodS7ZL3VxH/aLVcaLE5quJWeww8P0ysFJ8kEcy7rQZFd3gVafOHq96KTKUhQDYjNl3jxef8vwc74mGraF7YL4JB2tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738904046; c=relaxed/simple;
	bh=yvp5+iFGxsXXoz37obH+yIQkRZTLyzWtlf2GB/zxLgk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=nggl66HD+BM3nxzlHns1NhLFfZl5AxVaxRKchzU962EKgb2fxcnBsPAYOzdLW7G277qr3ETZ/hW8TX0OTKlSPndd9qFBQJNl8urx5/P4rXVTwCH7XFvmiAHzKMMrNdNqB8SYl2eqTsnl03ioOfR2PDfmkGUKLYTzjaqvYsl1cSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zTcjZgn0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QwJ1xeQe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TTi0Azu2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7GQFZErX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E2B081F38D;
	Fri,  7 Feb 2025 04:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738904043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Crukq6TBlJWCL4x+GPIaCUtygA5TOMB9R80rZgQXvY=;
	b=zTcjZgn0c04iSzTwtnpc/p+4Wxd7JBOLmD+oDkB0lc4FcIgSgzK5KrH+AuJTC/mx58oskZ
	0vpyEHMMwYfWcColz116Hr2npgqd349KWp1LlKsqe6+emkuFTZsQ+eYs0bc3Jjg5gMnwA8
	dTpMjKlFj5KKakACyV59qMgjNePzH1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738904043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Crukq6TBlJWCL4x+GPIaCUtygA5TOMB9R80rZgQXvY=;
	b=QwJ1xeQe0FvVpJkoOmRNUlEkuZrCWDJn3Mzjk7gNYqOadkXByPfbDkD9y1oFPgghQQze6g
	5WQrtjhi46Pq17Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TTi0Azu2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7GQFZErX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738904042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Crukq6TBlJWCL4x+GPIaCUtygA5TOMB9R80rZgQXvY=;
	b=TTi0Azu2Oiry3kv0MlS8nQlTPJUwsfqi18KWYdABCuKwydIOmDQQy81ggoZuOm/US1DQzV
	ShNJy+UGBujQYYLlE4rCuoE5RzN2OWs2OiO3bNGw/FvLJYw1RAfdHCJ0+5qKMx1ZQsMj7C
	toUDZuqp+ukljZxnQFj51jCKjo63xaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738904042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Crukq6TBlJWCL4x+GPIaCUtygA5TOMB9R80rZgQXvY=;
	b=7GQFZErXqXXtgh/r9UMbajeLd7p6Rgt+kZBRocxtMYsDfqgyIpu/Ah5Se9szVsLQVw0yWh
	f/ytjAEIlRSjHCAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22C1D13694;
	Fri,  7 Feb 2025 04:53:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ClxbMeORpWciEQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 07 Feb 2025 04:53:55 +0000
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
In-reply-to: <6p2m4jqtl62cabb2xolxt76ycule5prukjzx4nxklvhk23g6qh@luj2tzicloph>
References:
 <>, <6p2m4jqtl62cabb2xolxt76ycule5prukjzx4nxklvhk23g6qh@luj2tzicloph>
Date: Fri, 07 Feb 2025 15:53:52 +1100
Message-id: <173890403265.22054.8267826472424760232@noble.neil.brown.name>
X-Rspamd-Queue-Id: E2B081F38D
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Fri, 07 Feb 2025, Kent Overstreet wrote:
> On Fri, Feb 07, 2025 at 02:36:47PM +1100, NeilBrown wrote:
> > No callers of kern_path_locked() or user_path_locked_at() want a
> > negative dentry.  So change them to return -ENOENT instead.  This
> > simplifies callers.
> > 
> > This results in a subtle change to bcachefs in that an ioctl will now
> > return -ENOENT in preference to -EXDEV.  I believe this restores the
> > behaviour to what it was prior to
> 
> I'm not following how the code change matches the commit message?

Maybe it doesn't.  Let me checked.

Two of the possible error returns from bch2_ioctl_subvolume_destroy(),
which implements the BCH_IOCTL_SUBVOLUME_DESTROY ioctl, are -ENOENT and
-EXDEV.

-ENOENT is returned if the path named in arg.dst_ptr cannot be found.
-EXDEV is returned if the filesystem on which that path exists is not
 the one that the ioctl is called on.

If the target filesystem is "/foo" and the path given is "/bar/baz" and
/bar exists but /bar/baz does not, then user_path_locked_at or
user_path_at will return a negative dentry corresponding to the
(non-existent) name "baz" in /bar.

In this case the dentry exists so the filesystem on which it was found
can be tested, but the dentry is negative.  So both -ENOENT and -EXDEV
are credible return values.


- before bbe6a7c899e7 the -EXDEV is tested immediately after the call
  to user_path_att() so there is no chance that ENOENT will be returned.
  I cannot actually find where ENOENT could be returned ...  but that
  doesn't really matter now.

- after that patch .... again the -EXDEV test comes first. That isn't
  what I remember.  I must have misread it.

- after my patch user_path_locked_at() will return -ENOENT if the whole
  name cannot be found.  So now you get -ENOENT instead of -EXDEV.

So with my patch, ENOENT always wins, and it was never like that before.
Thanks for challenging me!

Do you think there could be a problem with changing the error returned
in this circumstance? i.e. if you try to destroy a subvolume with a
non-existant name on a different filesystem could getting -ENOENT
instead of -EXDEV be noticed?

Thanks,
NeilBrown

