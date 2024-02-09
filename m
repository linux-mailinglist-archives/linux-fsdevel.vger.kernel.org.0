Return-Path: <linux-fsdevel+bounces-10971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 861FB84F7B9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 15:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A961F23583
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 14:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3E56996C;
	Fri,  9 Feb 2024 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rik195Bu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sAgMlvIs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rik195Bu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sAgMlvIs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E2D3D3AC;
	Fri,  9 Feb 2024 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489656; cv=none; b=AnPPzmIvlo1pjXRigyp/v2qX3jlNTB/blkG4d+k0W73PAt9n0QiYM5tPJy+kiX7M6jud/XJwDWmMNAebaGyu+faehrAIdhc6KxZRpj3//GGG2x5NQjipSsPF1SR/nPDLuOPeZ6H2mfYQY4MF06+zTrAkyDDwylAWJxfx7uBtJ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489656; c=relaxed/simple;
	bh=kvW+uCn5zpR/htv2BPZyVAn0uebTfIuOnIXAYkQ9fzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l9v0eX31o81VELiybSwrOY6k+Icl1sYC0pLKvec2DrgbabCAQTy+Q+KJjYysxHPNJJ+1Ca20KJf+Kc8LJ7NOm7hR3sVtfsYbKANQMYTmvH6FqAmKz47dejSw0uJS1Lltwi0THo5dmVm47wptSuRy3SLOfrxNA6ehcQ3ziCGbvmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rik195Bu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sAgMlvIs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rik195Bu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sAgMlvIs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B97C3220BC;
	Fri,  9 Feb 2024 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707489652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pCpdUnMf8dHC2jO7IQm6xTmkZXEGVeDSlQYqvB/gkX8=;
	b=rik195BuEiJ+54TW0+5DiHxcPCpP+UXXjqQn0U5gu74mMSOnaHJIf65yLAxdUjvgQJeako
	68k5Ed0LGf0VnO5SFtI3eHHKfLjwJz788fj/GkrOSMdNDuSfmLLRs5nPqIzQa+SfWw0aAS
	GIWDJxS99CgrfK+YAHSbwFEMr8X0tG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707489652;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pCpdUnMf8dHC2jO7IQm6xTmkZXEGVeDSlQYqvB/gkX8=;
	b=sAgMlvIs3EvhP/uvQTD6I/2QJW4IZSk2RxR/87b+F7h6Jb7Z8vOBGQgBOt6komTg9z7pf7
	0S98BxqgTp0LNWAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707489652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pCpdUnMf8dHC2jO7IQm6xTmkZXEGVeDSlQYqvB/gkX8=;
	b=rik195BuEiJ+54TW0+5DiHxcPCpP+UXXjqQn0U5gu74mMSOnaHJIf65yLAxdUjvgQJeako
	68k5Ed0LGf0VnO5SFtI3eHHKfLjwJz788fj/GkrOSMdNDuSfmLLRs5nPqIzQa+SfWw0aAS
	GIWDJxS99CgrfK+YAHSbwFEMr8X0tG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707489652;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pCpdUnMf8dHC2jO7IQm6xTmkZXEGVeDSlQYqvB/gkX8=;
	b=sAgMlvIs3EvhP/uvQTD6I/2QJW4IZSk2RxR/87b+F7h6Jb7Z8vOBGQgBOt6komTg9z7pf7
	0S98BxqgTp0LNWAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7573B1326D;
	Fri,  9 Feb 2024 14:40:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s5yiFnQ5xmXjdQAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 09 Feb 2024 14:40:52 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu,  adilger.kernel@dilger.ca,  jaegeuk@kernel.org,
  chao@kernel.org,  viro@zeniv.linux.org.uk,  brauner@kernel.org,
  linux-ext4@vger.kernel.org,  linux-f2fs-devel@lists.sourceforge.net,
  jack@suse.cz,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  kernel@collabora.com,  Gabriel Krisman
 Bertazi <krisman@collabora.com>,  Eric Biggers <ebiggers@google.com>
Subject: Re: [RESEND PATCH v9 1/3] libfs: Introduce case-insensitive string
 comparison helper
In-Reply-To: <ff492e0f-3760-430e-968a-8b2adab13f3f@collabora.com> (Eugen
	Hristev's message of "Fri, 9 Feb 2024 12:30:47 +0200")
Organization: SUSE
References: <20240208064334.268216-1-eugen.hristev@collabora.com>
	<20240208064334.268216-2-eugen.hristev@collabora.com>
	<87ttmivm1i.fsf@mailhost.krisman.be>
	<ff492e0f-3760-430e-968a-8b2adab13f3f@collabora.com>
Date: Fri, 09 Feb 2024 09:40:51 -0500
Message-ID: <87plx5u2do.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rik195Bu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sAgMlvIs
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.78 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.27)[74.12%]
X-Spam-Score: -3.78
X-Rspamd-Queue-Id: B97C3220BC
X-Spam-Flag: NO

Eugen Hristev <eugen.hristev@collabora.com> writes:

> On 2/8/24 20:38, Gabriel Krisman Bertazi wrote:

>> (untested)
>
> I implemented your suggestion, but any idea about testing ? I ran smoke on xfstests
> and it appears to be fine, but maybe some specific test case might try the
> different paths here ?

Other than running the fstests quick group for each affected filesystems
looking for regressions, the way I'd do it is create a few files and
look them up with exact and inexact name matches.  While doing that,
observe through bpftrace which functions got called and what they
returned.

Here, since you are testing the uncached lookup, you want to make sure
to drop the cached version prior to each lookup.

-- 
Gabriel Krisman Bertazi

