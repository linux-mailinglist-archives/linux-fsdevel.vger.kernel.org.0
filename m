Return-Path: <linux-fsdevel+bounces-58581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C1FB2F0B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 10:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CDDAA0A7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 08:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFBC2EA16D;
	Thu, 21 Aug 2025 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="COCR3Rf3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Kz5Z3uik";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="COCR3Rf3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Kz5Z3uik"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCF02EA170
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763868; cv=none; b=roB7MC7mfZCOB3cTiQN+nUbbpoqu8eP+dvNPg2wZ6FKUCjBz2hIuE2+agxeoUWq4U4WNlZ544ci6rGovvrlYAPpdQRv9zxgl4H2cANaT6dUnou7swnaNhPzhuWU6KiorbyyJBj6mNLXxv5EEKRaLtaCSZpPYpGzXEgNccAi5cG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763868; c=relaxed/simple;
	bh=iyyroPi1q1lOUNuwRWedu6plJhaf/ofd9hNt72FTZe8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXeEpPwNRH3ebiNJ0+3btKlWCBwRF70aL1qfKXw4DX2T2AbsOk+9Iu3MloQDu/nnN71FvXjIOL97+GUgf7N9Df8ziKzDnqjaiZn4f0ZoHpk4wrRk8elIQLNLNyF0F8Sa9moWhatzdiuGeCa97gOOIr4LsZTq7e67JQsSYxSB0eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=COCR3Rf3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Kz5Z3uik; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=COCR3Rf3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Kz5Z3uik; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3C6521A41;
	Thu, 21 Aug 2025 08:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755763864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JPFPYZrwWSG3VhwEjcnRYPOLWKGyi0j4E5eB7R1fseo=;
	b=COCR3Rf3SLm+SJ3BVyPgGKYtGyLJeeb6cqOSDq7LY7O9Y4aXaZRZJw55nRjHfQumzr3Ug1
	CCU5ZbkZVZFIUgj4Dw+BDme/KeBIMIW8yrTkDjY5WjRvWcIdNg80EumdVees5AHVz/Ll5o
	YRQU23gl7J8h66sj/geV1RM9Xrkw26o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755763864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JPFPYZrwWSG3VhwEjcnRYPOLWKGyi0j4E5eB7R1fseo=;
	b=Kz5Z3uikjqKKGGJbVLyMXF9CKnpMpK99fF8/PUN0hUdwc93G8p3Xq8AMmXj1LxfjfK3It2
	GSiuG+AOmaV13eDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755763864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JPFPYZrwWSG3VhwEjcnRYPOLWKGyi0j4E5eB7R1fseo=;
	b=COCR3Rf3SLm+SJ3BVyPgGKYtGyLJeeb6cqOSDq7LY7O9Y4aXaZRZJw55nRjHfQumzr3Ug1
	CCU5ZbkZVZFIUgj4Dw+BDme/KeBIMIW8yrTkDjY5WjRvWcIdNg80EumdVees5AHVz/Ll5o
	YRQU23gl7J8h66sj/geV1RM9Xrkw26o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755763864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JPFPYZrwWSG3VhwEjcnRYPOLWKGyi0j4E5eB7R1fseo=;
	b=Kz5Z3uikjqKKGGJbVLyMXF9CKnpMpK99fF8/PUN0hUdwc93G8p3Xq8AMmXj1LxfjfK3It2
	GSiuG+AOmaV13eDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FD6013867;
	Thu, 21 Aug 2025 08:11:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PuOVMpbUpmgsEAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 21 Aug 2025 08:11:02 +0000
Date: Thu, 21 Aug 2025 18:10:56 +1000
From: David Disseldorp <ddiss@suse.de>
To: Nicolas Schier <nsc@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-next@vger.kernel.org
Subject: Re: [PATCH v2 7/7] gen_init_cpio: add -a <data_align> as reflink
 optimization
Message-ID: <20250821181056.79cb38b6.ddiss@suse.de>
In-Reply-To: <aKN9uMf0HeD1Fgqk@levanger>
References: <20250814054818.7266-1-ddiss@suse.de>
	<20250814054818.7266-8-ddiss@suse.de>
	<aKN9uMf0HeD1Fgqk@levanger>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

Oops, I somehow missed this comment...

On Mon, 18 Aug 2025 21:23:36 +0200, Nicolas Schier wrote:
...
> Thanks!  Testing with a massively oversized initramfs (600MB) was fun:
> from 2:44 down to 38s.

Thanks for the benchmarking :)

> Questions that pop up in my mind:
> Now, how can we make other benefit from this?  Might it make sense to
> introduce a kconfig variable for initramfs alignment -- even though this
> is just a build-time optimisation of few seconds?

A kconfig option with non-aligned as default isn't a bad idea, but at
this stage I don't think it's worth adding. Mostly because reflinks are
very FS / arch / environment specific and the extra fragmentation may
have unintended consequences.

Thanks, David

