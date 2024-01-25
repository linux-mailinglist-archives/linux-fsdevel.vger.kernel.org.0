Return-Path: <linux-fsdevel+bounces-9005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70CC83CD43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 21:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3B828A503
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 20:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC2E137C23;
	Thu, 25 Jan 2024 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HVt/bVee";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="twLGafix";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="I7VhO6R3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bAQXolaQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56138136656;
	Thu, 25 Jan 2024 20:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706213894; cv=none; b=Z2fachS9xNomRhYq+Eq2jXP4MlYmP90OqlyvokwjWVIu65OREpuZKseWmwfDMk1TRablFwKW9jwud8ckOYMGObiWm2T3+8W/aNIKaKyIgnqsaqWw44bNbRVUrxOoSR2ayFM3y29Q+bb5/9pv6vBudouTnhTzvTzDr0Ae24Iz3qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706213894; c=relaxed/simple;
	bh=9n7l06mR29TS443bZyCN+P+8yeXmh3DCeJFL3+cp/Es=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JNhnMv/jAXXCJJVFIfYNEZXSqqFcunV3o/S45sSsD/fKwG09sK7ZtvJBsRtLECg5Tdr2DCOlGFf3AVPwGY5eIPA+55yigGLsnjrBnyFVXmkOK1SSqD2IrO9We481Ti/C38s89MJeUbxJ3YfrbHr0d1E+D7BFgpQ1JnqvP2YQz1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HVt/bVee; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=twLGafix; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=I7VhO6R3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bAQXolaQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A99D91FE6B;
	Thu, 25 Jan 2024 20:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706213884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A3ya30AYW8N/E78PgSlPUr0eoJq9IfloPJjz3fkDUrA=;
	b=HVt/bVeeOovvvvh7pnp/g7SfUmHMWUvSjIXnJBdPLLRUXjWiaT5Pa9dEl5aELHCAGjZKdT
	3OzndkI1FHMlj2DLt7x6sTcP9TR2AuHRHj2EQdh83tHf85fMEsj7vxvj8eKyMngV4IAc4S
	QKxGOIT8vdOpw4WbddTG/zlUzs7eWBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706213884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A3ya30AYW8N/E78PgSlPUr0eoJq9IfloPJjz3fkDUrA=;
	b=twLGafixShOuaMbCl36toLifBb6JP1CXrgrCJw1rMMmK8V5Hd7Rtb9eqfRh5SwNTkqqMuU
	hVPcOaajDB6JpxAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706213883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A3ya30AYW8N/E78PgSlPUr0eoJq9IfloPJjz3fkDUrA=;
	b=I7VhO6R3I7ul/zXahlEOZzJ5bEFab/IWJTSBsUJFic7kDSCW7VwhppO6rqKCJfk9MMnsMp
	BCyOLwvhSVvLxDDS+PCIvLaDKboj9ju05RhApqAldUX0dajDIZhi6IwmfL5gveJWfmTqCJ
	lc2KzCQgyQT4vXYSkZXLNcpRu8x6CjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706213883;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A3ya30AYW8N/E78PgSlPUr0eoJq9IfloPJjz3fkDUrA=;
	b=bAQXolaQ447YaxrGzDEUJ9g2EdXFfozjizMDsPADS4pEsEBUdsdEBTgLG0tedtHwiVum2+
	w0o/iDmDjp949kBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E1ED13649;
	Thu, 25 Jan 2024 20:18:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hIeCMPrBsmXfPAAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 25 Jan 2024 20:18:02 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: viro@zeniv.linux.org.uk,  jaegeuk@kernel.org,  tytso@mit.edu,
  linux-ext4@vger.kernel.org,  linux-f2fs-devel@lists.sourceforge.net,
  linux-fsdevel@vger.kernel.org,  amir73il@gmail.com
Subject: Re: [PATCH v3 02/10] fscrypt: Share code between functions that
 prepare lookup
In-Reply-To: <20240125030530.GB52073@sol.localdomain> (Eric Biggers's message
	of "Wed, 24 Jan 2024 19:05:30 -0800")
Organization: SUSE
References: <20240119184742.31088-1-krisman@suse.de>
	<20240119184742.31088-3-krisman@suse.de>
	<20240125030530.GB52073@sol.localdomain>
Date: Thu, 25 Jan 2024 17:18:00 -0300
Message-ID: <87a5otxj47.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=I7VhO6R3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bAQXolaQ
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.05 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.04)[57.42%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,mit.edu,vger.kernel.org,lists.sourceforge.net,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -5.05
X-Rspamd-Queue-Id: A99D91FE6B
X-Spam-Flag: NO

Eric Biggers <ebiggers@kernel.org> writes:

> On Fri, Jan 19, 2024 at 03:47:34PM -0300, Gabriel Krisman Bertazi wrote:
>> To make the patch simpler, we now call fscrypt_get_encryption_info twice
>> for fscrypt_prepare_lookup, once inside fscrypt_setup_filename and once
>> inside fscrypt_prepare_lookup_dentry.  It seems safe to do, and
>> considering it will bail early in the second lookup and most lookups
>> should go to the dcache anyway, it doesn't seem problematic for
>> performance.  In addition, we add a function call for the unencrypted
>> case, also during lookup.
>
> Unfortunately I don't think it's correct.  This is basically undoing my fix
> b01531db6cec ("fscrypt: fix race where ->lookup() marks plaintext dentry as
> ciphertext") from several years ago.
>
> When a lookup is done, the filesystem needs to either treat the name being
> looked up as a no-key name *or* as a regular name, depending on whether the
> directory's key is present.  We shouldn't enable race conditions where, due to
> the key being concurrently added, the name is treated as a no-key name for
> filename matching purposes but a regular name for dentry validation purposes.
> That can result in an anomaly where a file that exists ends up with a negative
> dentry that doesn't get invalidated.
>
> Basically, the boolean fscrypt_name::is_nokey_name that's produced by
> fscrypt_setup_filename() should continue to be propagated to DCACHE_NOKEY_NAME.

I see your point.  I'll drop this patch and replace it with a patch that
just merges the DCACHE_NOKEY_NAME configuration.  Sadly, we gotta keep
the two variants I think.

thanks for the review

-- 
Gabriel Krisman Bertazi

