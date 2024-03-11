Return-Path: <linux-fsdevel+bounces-14149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EE68786E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 19:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B1C1C217FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 18:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D7053E0A;
	Mon, 11 Mar 2024 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IUBx8sFS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zw9XqBd9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IUBx8sFS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zw9XqBd9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A083537E3;
	Mon, 11 Mar 2024 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710180092; cv=none; b=pF6Qox8fnAFK/9K4iLzAmwwjMszpO1Yb/cortVU+0rO30oNAzZOls27sJkQUbpgTOUHaMxKTtU+Mi99z4zgafphssdC3wBk05Tthzorh7RGefkwJ0ccOYC1ZsgjMVRS0qVhdE8hdAgpXtKtfrybZto815d6F7u26zWFr/ZZ0wGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710180092; c=relaxed/simple;
	bh=YwQ3R76+KLkiJDzmZlZvHr0Ih1ifU7CC0K6Lnax3Koo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKNTwI3KIoMZEOq4w/nI7nb7D+I4POAE3KeqdoU8Mugz0sjh4cadajYZ6yxwjhshqKR71rleHlwFIXim8fdgV9aByM3dhj3wzB+LQYDlUCtNy1dj+9s/NlbGYhh9/tw9m8Mb9zFmPz/fdbU9vbkqjgfXsdOncsm9YFiW9MxckDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IUBx8sFS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zw9XqBd9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IUBx8sFS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zw9XqBd9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4A00F21D16;
	Mon, 11 Mar 2024 18:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710180088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1nuY4Ji3/LCK1/g56T1VrxYdJ9wsBsTAQhk/YstClZ4=;
	b=IUBx8sFSykKkAWFkUo5A2ufI7D0423uxhOPzJXWJNAbi3P6WmYD3tUPPvKyXC7GDfAJ6Ib
	Y1lT3Em+8uU6mEuBFG/DTKV9C2Q40GEnCMqt4sj9dymxvGQix2jfU4N3YJIwCrMY9hwL35
	6VKFQqppm70gyGEfZgg45+FtYuFD6YM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710180088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1nuY4Ji3/LCK1/g56T1VrxYdJ9wsBsTAQhk/YstClZ4=;
	b=Zw9XqBd9Zb5tOag9RIEpLDAYOHLi6R8NE7yoJ6PgHZkorPI24xG+Ru5WZuNQ9VaalrCDri
	lopbc7J0zqAGfBAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710180088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1nuY4Ji3/LCK1/g56T1VrxYdJ9wsBsTAQhk/YstClZ4=;
	b=IUBx8sFSykKkAWFkUo5A2ufI7D0423uxhOPzJXWJNAbi3P6WmYD3tUPPvKyXC7GDfAJ6Ib
	Y1lT3Em+8uU6mEuBFG/DTKV9C2Q40GEnCMqt4sj9dymxvGQix2jfU4N3YJIwCrMY9hwL35
	6VKFQqppm70gyGEfZgg45+FtYuFD6YM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710180088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1nuY4Ji3/LCK1/g56T1VrxYdJ9wsBsTAQhk/YstClZ4=;
	b=Zw9XqBd9Zb5tOag9RIEpLDAYOHLi6R8NE7yoJ6PgHZkorPI24xG+Ru5WZuNQ9VaalrCDri
	lopbc7J0zqAGfBAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E997136BA;
	Mon, 11 Mar 2024 18:01:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oitFD/hG72VlNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 11 Mar 2024 18:01:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DE241A0807; Mon, 11 Mar 2024 19:01:27 +0100 (CET)
Date: Mon, 11 Mar 2024 19:01:27 +0100
From: Jan Kara <jack@suse.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>,
	Luis Henriques <lhenriques@suse.de>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ovl: fix the parsing of empty string mount
 parameters
Message-ID: <20240311180127.4qdr6ln2xf6vviu3@quack3>
References: <20240307160225.23841-1-lhenriques@suse.de>
 <20240307160225.23841-4-lhenriques@suse.de>
 <CAJfpegtQSi0GFzUEDqdeOAq7BN2KvDV8i3oBFvPOCKfJJOBd2g@mail.gmail.com>
 <87le6p6oqe.fsf@suse.de>
 <CAJfpeguN9nMJGJzx8sgwP=P9rJFVkYF5rVZOi_wNu7mj_jfBsA@mail.gmail.com>
 <20240311-weltmeere-gesiegt-798c4201c3f8@brauner>
 <CAJfpegsn-jMY2J8Wd2Q9qmZFqxR6fAwZ4auoK+-uyxaK+F-0rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsn-jMY2J8Wd2Q9qmZFqxR6fAwZ4auoK+-uyxaK+F-0rw@mail.gmail.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.24 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.org,suse.de,mit.edu,dilger.ca,zeniv.linux.org.uk,suse.cz,gmail.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.64)[82.43%]
X-Spam-Score: -0.24
X-Spam-Flag: NO

On Mon 11-03-24 15:39:39, Miklos Szeredi wrote:
> On Mon, 11 Mar 2024 at 14:25, Christian Brauner <brauner@kernel.org> wrote:
> 
> > Yeah, so with that I do agree. But have you read my reply to the other
> > thread? I'd like to hear your thoughs on that. The problem is that
> > mount(8) currently does:
> >
> > fsconfig(3, FSCONFIG_SET_FLAG, "usrjquota", NULL, 0) = -1 EINVAL (Invalid argument)
> >
> > for both -o usrjquota and -o usrjquota=
> 
> For "-o usrjquota" this seems right.
> 
> For "-o usrjquota=" it doesn't.  Flags should never have that "=", so
> this seems buggy in more than one ways.
> 
> > So we need a clear contract with userspace or the in-kernel solution
> > proposed here. I see the following options:
> >
> > (1) Userspace must know that mount options such as "usrjquota" that can
> >     have no value must be specified as "usrjquota=" when passed to
> >     mount(8). This in turn means we need to tell Karel to update
> >     mount(8) to recognize this and infer from "usrjquota=" that it must
> >     be passed as FSCONFIG_SET_STRING.
> 
> Yes, this is what I'm thinking.  Of course this only works if there
> are no backward compatibility issues, if "-o usrjquota" worked in the
> past and some systems out there relied on this, then this is not
> sufficient.

No, "-o usrjquota" never worked and I'm inclined to keep refusing this
variant as IMHO it is confusing.

> > In any case, we need to document what we want:
> >
> > https://github.com/brauner/man-pages-md/blob/main/fsconfig.md
> 
> What's the plan with these?  It would be good if "man fsconfig" would
> finally work.

Yes, merging these into official manpages would be nice.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

