Return-Path: <linux-fsdevel+bounces-21134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E257F8FF70A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 23:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 527FEB23CD9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 21:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F41B13AD1D;
	Thu,  6 Jun 2024 21:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XF0+T9vu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HO9NPha7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XF0+T9vu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HO9NPha7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0256D53C;
	Thu,  6 Jun 2024 21:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717710656; cv=none; b=Ml1k73Z9aN7+C3enFbGjV/Wj5lwCm2HhygnRTawAoKysXkaM3Jw0ITdvIpes27LE8VgR4VJwMDUQxiToQrrqPQ54Nl1+qITiJKvqlsU+y0VMbxVk9lxtOBUG0g+zRcSegWcUfZ6ZNZbHPzXQYe5Mq0T3OtuQ3OsL+JJ1cDu28DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717710656; c=relaxed/simple;
	bh=yRlzVq1f85dbcOPA1niy6gpUdxU/LAv6b1KRhJ4sF1A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e07X9yAMy5/IYq0fhi9E2Uh3TFib2MroUQf0tFbaTNW63u9+JRbiwgIYUAT0FqGokP8XcFCGHyttmneJQ3Fd1UdfoCb08MKUcqXYrctPr7kIIEUlcLDu6xaR21Q8K++75bxNHCSzdDTpHNhBIIj7e3TwtkNrYOrVPpYrBfs/4kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XF0+T9vu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HO9NPha7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XF0+T9vu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HO9NPha7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5B7351FB5A;
	Thu,  6 Jun 2024 21:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717710650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PQTf0zBkx+6dYehfEwHIIeqVqSDrnQHWK9tVjpEW7s4=;
	b=XF0+T9vu3aR4QBcisT3dppVXlPEF6SyNqm6k9wGy24cFhwtxuQNSfqsQu4lliWc5St//hy
	txATNenfL3qtEnEze4CdH4Whz1UU0uGdZC8JQEePOJUC3ZGiIF5ukiox5bmcCpggWtGCpu
	RtxcJNOMth9Y2JGfkbufuqe49WVj7V8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717710650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PQTf0zBkx+6dYehfEwHIIeqVqSDrnQHWK9tVjpEW7s4=;
	b=HO9NPha7lz19I5x9wkNaD7XGnXuuqb7e+TSrgf1sGir4rQMJ2RT+JrTf3Qiob7SGgJTY3R
	QTLl5ogL0xScvUCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717710650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PQTf0zBkx+6dYehfEwHIIeqVqSDrnQHWK9tVjpEW7s4=;
	b=XF0+T9vu3aR4QBcisT3dppVXlPEF6SyNqm6k9wGy24cFhwtxuQNSfqsQu4lliWc5St//hy
	txATNenfL3qtEnEze4CdH4Whz1UU0uGdZC8JQEePOJUC3ZGiIF5ukiox5bmcCpggWtGCpu
	RtxcJNOMth9Y2JGfkbufuqe49WVj7V8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717710650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PQTf0zBkx+6dYehfEwHIIeqVqSDrnQHWK9tVjpEW7s4=;
	b=HO9NPha7lz19I5x9wkNaD7XGnXuuqb7e+TSrgf1sGir4rQMJ2RT+JrTf3Qiob7SGgJTY3R
	QTLl5ogL0xScvUCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1394313A79;
	Thu,  6 Jun 2024 21:50:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4jzcOTkvYmaTXAAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 06 Jun 2024 21:50:49 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: "Eugen Hristev" <eugen.hristev@collabora.com>, "Christian Brauner"
 <christian@brauner.io>
Cc: linux-ext4@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-f2fs-devel@lists.sourceforge.net,  linux-fsdevel@vger.kernel.org,
  jaegeuk@kernel.org,  adilger.kernel@dilger.ca,  tytso@mit.edu,
  chao@kernel.org,  viro@zeniv.linux.org.uk,  brauner@kernel.org,
  jack@suse.cz,  ebiggers@google.com,  kernel@collabora.com
Subject: Re: [PATCH v18 0/7] Case insensitive cleanup for ext4/f2fs
In-Reply-To: <20240606073353.47130-1-eugen.hristev@collabora.com> (Eugen
	Hristev's message of "Thu, 6 Jun 2024 10:33:46 +0300")
Organization: SUSE
References: <20240606073353.47130-1-eugen.hristev@collabora.com>
Date: Thu, 06 Jun 2024 17:50:38 -0400
Message-ID: <87v82livv5.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.981];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Eugen Hristev <eugen.hristev@collabora.com> writes:

> Hello,
>
> I am trying to respin the series here :
> https://www.spinics.net/lists/linux-ext4/msg85081.html
>
> I resent some of the v9 patches and got some reviews from Gabriel,
> I did changes as requested and here is v18.

The patchset looks good to me.  Feel free to add:

Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>

Bringing Christian into the loop, since this is getting ready and it
should go through the VFS tree, as it touches libfs and a couple
filesystems.

Christian, can you please take a look? Eric has also been involved in
the review, so we should give him a few days to see if he has more
comments.

-- 
Gabriel Krisman Bertazi

