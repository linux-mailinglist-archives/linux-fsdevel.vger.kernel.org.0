Return-Path: <linux-fsdevel+bounces-49570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 761B6ABF12F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 12:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1BBC1BA87F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 10:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C0D25D202;
	Wed, 21 May 2025 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w574xfpk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2JKzkc8c";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w574xfpk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2JKzkc8c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2131425A65C
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822502; cv=none; b=TvnGcV7OoGXHVDwxQTqlrhUY1WK6iDLU8CPNJ5n/Kf7VpftSqswOh32HBzCzSe9KYRVRujcnMa0Q4ZbLgBo4qo4vKCRmSdi5RB6DizoLAralYWSkVIL7RNTgknTCk1rTa7tw+WNHbms+Kw5GVjSsD+RcvtIGXwfKH/rShJGHPTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822502; c=relaxed/simple;
	bh=y5z+scst9L6WOsgv58e8D2KAkZzWs3X0bQLmazuf3xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qP0V7Zy8xVZtaT9MlFb9RfjeVw80WGMt4VPVYICglsaKwZZ6e44oi1dIPl/21p02uteTfAqj9jEMpa9wCWrx/QSsK1wYqkxiwpijpw3ngg4akJuTEbKbaekCRK9PNG9c0z9XgXOA6S2vTXc7taUqU0FcN7Sl8JVCqY2hp7ETORU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w574xfpk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2JKzkc8c; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w574xfpk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2JKzkc8c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D8B121D8E;
	Wed, 21 May 2025 10:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747822499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GynE6KdBO08qdxebfuojQtMAyhQGgYEbFQ7voy4xDSI=;
	b=w574xfpkganpk1eb5Ie0ntMWtQ2Tt6xHfCbU7Qtqf+uQyJuTo63LdBWTxfWNo0PbvveHPo
	tbI4rIHQ6MX7TnmbHhylHi/SC74V8dDbxdwdBTyHK/8KIFHh/gcE3p2Ue4W8+u+j2FLL92
	b77OYTqDCHGObKJ1HiynBQk+v5Kb+3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747822499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GynE6KdBO08qdxebfuojQtMAyhQGgYEbFQ7voy4xDSI=;
	b=2JKzkc8ccR+pjZeCEnqly5WVGqJAHuoBteyXauQOPP8macINxYWNkN41EgYKyt8ZhbwFp9
	8RClzC9nBnPeOcBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747822499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GynE6KdBO08qdxebfuojQtMAyhQGgYEbFQ7voy4xDSI=;
	b=w574xfpkganpk1eb5Ie0ntMWtQ2Tt6xHfCbU7Qtqf+uQyJuTo63LdBWTxfWNo0PbvveHPo
	tbI4rIHQ6MX7TnmbHhylHi/SC74V8dDbxdwdBTyHK/8KIFHh/gcE3p2Ue4W8+u+j2FLL92
	b77OYTqDCHGObKJ1HiynBQk+v5Kb+3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747822499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GynE6KdBO08qdxebfuojQtMAyhQGgYEbFQ7voy4xDSI=;
	b=2JKzkc8ccR+pjZeCEnqly5WVGqJAHuoBteyXauQOPP8macINxYWNkN41EgYKyt8ZhbwFp9
	8RClzC9nBnPeOcBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40E4213AA0;
	Wed, 21 May 2025 10:14:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VgPSD6OnLWi6TAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 May 2025 10:14:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C7B17A09DE; Wed, 21 May 2025 12:14:53 +0200 (CEST)
Date: Wed, 21 May 2025 12:14:53 +0200
From: Jan Kara <jack@suse.cz>
To: 
	Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
Cc: Yangtao Li <frank.li@vivo.com>, ethan@ethancedwards.com, 
	asahi@lists.linux.dev, brauner@kernel.org, dan.carpenter@linaro.org, 
	ernesto@corellium.com, gargaditya08@live.com, gregkh@linuxfoundation.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, 
	sven@svenpeter.dev, tytso@mit.edu, viro@zeniv.linux.org.uk, willy@infradead.org, 
	slava@dubeyko.com, glaubitz@physik.fu-berlin.de
Subject: Re: Subject: [RFC PATCH v2 0/8] staging: apfs: init APFS filesystem
 support
Message-ID: <n7kkoptktdvldadvymcfmnaw3yqbk6bfmzpxvgdkpsvvpc3p7i@ilqcgz7wur7i>
References: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
 <20250512101122.569476-1-frank.li@vivo.com>
 <20250512234024.GA19326@eaf>
 <226043d9-068c-496a-a72c-f3503da2f8f7@vivo.com>
 <20250520185939.GA7885@eaf>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250520185939.GA7885@eaf>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,live.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vivo.com,ethancedwards.com,lists.linux.dev,kernel.org,linaro.org,corellium.com,live.com,linuxfoundation.org,suse.cz,vger.kernel.org,svenpeter.dev,mit.edu,zeniv.linux.org.uk,infradead.org,dubeyko.com,physik.fu-berlin.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

Hi!

On Tue 20-05-25 15:59:39, Ernesto A. Fernández wrote:
> On Tue, May 20, 2025 at 01:08:54PM +0800, Yangtao Li wrote:
> > Now that some current use cases have already been provided
> 
> Some interesting use cases have been mentioned, yes, but I doubt they are
> common enough to convince upstream to pick up a whole new filesystem. I was
> also more curious about your own personal interest in the driver, because
> you are going to get some very hostile feedback if you try to get it merged.
> You won't get anywhere without strong conviction in the matter.

Correct, this kind of matches my feelings from this discussion so far. Sure
APFS support in the kernel would be more convenient for some users. But so
far I didn't hear a reason why FUSE driver wouldn't cover 99% of the
usecases (since I know close to nothing about Apple ecosystem, maybe I've
missed some so please correct me in that case).

Perhaps to explain the reasons of a pushback a bit: Once the filesystem
driver is merged, it's very difficult to get rid of it as users may depend
on it. Each filesystem driver adds certain maintenance burden - most
notably for changes in VFS and other generic infrastructure that need to
take into account what each and every filesystem is doing. We already carry
quite a few filesystem drivers used by very few people and since few people
are interested it them it's difficult to find people to get these drivers
converted to new mount API, iomap infrastructure, new page cache APIs etc.
which forces us to keep carring the old interfaces. This gets particularly
painful for filesystems where we don't have full specification so usually
the mkfs and fsck tooling is not as comprehensive which makes testing
changes harder. So the bar (in terms of usecases) to get the new filesystem
driver merged is relatively high.

> > APFS in the kernel should have better performance than a FUSE
> > implementation.
> 
> Sure, but how much better? You could try running benchmarks against the two
> existing (read-only) fuse implementations. And if the driver is indeed much
> faster, does that matter to you for any particular reason? Keep in mind that
> you need to convince Jan Kara, not me.

Using FUSE to access the filesystem certainly has it's overhead (although
there is work in progress to heavily reduce that for data-intensive
operations such as streaming IO). But I doubt your the usecase for APFS is
to use it as a backend for a file server or a database. We have other
filesystems in Linux for that. All the usecases I've heard are about being
able to access you Mac files from Linux. And FUSE driver should have
acceptable performance for that from my experience.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

