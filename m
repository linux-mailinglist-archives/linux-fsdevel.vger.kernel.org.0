Return-Path: <linux-fsdevel+bounces-12073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9E585B023
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 01:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4AA1B21E71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 00:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD379F9F8;
	Tue, 20 Feb 2024 00:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XUO2Pzsn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z5Jal858";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q1oHSXBW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z9aDjGaz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CC7FBF3;
	Tue, 20 Feb 2024 00:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708390118; cv=none; b=NIoxnvwJXi1wHsXrtuoKVgpxZtInKSJGmAgNSIavTT4jLswIlz/JmGyi6zEVvaM3d1rlwVrnLDCOmwt1Exewh5c8ykN3czv8xTRl55w3d/uJurpBfYfy1KYeBB55OeaY2UEpuXtlJXLHnnbhwKhRxjWkFw/Xs/Kwe/UTZnmPiWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708390118; c=relaxed/simple;
	bh=EF/D4yQ52h5Gd2SbCgPL1B8Ff1iTXJxuj4D3lTm9I6s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LvMCkvpf8cf9+0nKtc48LxA/nGfMZ8z93T3qis2tU3ze5jz8PZ21PDlVrwW0qjFhyv/nPpaL2dITTMHP7H+j/lLuEPQeBhjBZlZZKrGtOlpkrSp+nvQY2K5oQE/m1nbUqdByQn1BJRyzTOKpAMRasRww06TqMqKZauWIzyyN3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XUO2Pzsn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Z5Jal858; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q1oHSXBW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z9aDjGaz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2EB202202B;
	Tue, 20 Feb 2024 00:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708390113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGEecwVaYaJpSbMfZXIT26jnfC5dHGGtAOwZ6dBUMhw=;
	b=XUO2PzsnpxrtzQAcjiKAcYfns23lBtjvFRuxq7/8WfCbqamevQAhwVK325bBA4m0f8Okmq
	YF5y4k8Xb2+L1cyxgPKlGuspAl6/H9hNqxDR/N9jQbfVajiCoS7BsmOtwJEHzjCICbPUnx
	k3uc2+uVfRP1LiyIEWC4aV+yNUJbM/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708390113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGEecwVaYaJpSbMfZXIT26jnfC5dHGGtAOwZ6dBUMhw=;
	b=Z5Jal858y9Bllawtyexcx+fB1cZ6YqQEkoIdcV0a5RiG059dmkjKuvDi5IlIblvTTaCq6m
	FaBo2ZRFrt962aBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708390112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGEecwVaYaJpSbMfZXIT26jnfC5dHGGtAOwZ6dBUMhw=;
	b=q1oHSXBWXZX86VZPXZew6IHWtc017Pe+W0H38TZVA90eO9I80wB+zZYgzvrQ5gNCJSuMsv
	mzTbowJ/PLoog4JDlM4suRS0K3C1oQnTckFs77llXVz932h+7NrCSitenR4Sk51Pi36tDi
	oeyTEbrMvxT6LCcfIXp3UWMm3+vsUmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708390112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGEecwVaYaJpSbMfZXIT26jnfC5dHGGtAOwZ6dBUMhw=;
	b=z9aDjGaz3EhGU0YUKTERwzdmglwyXYyACGM+uIQ/17k2YInQaftYOs1QmoM/V3Dlvw1+Si
	uHLg5EiLFb7XV5BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA7DC139D0;
	Tue, 20 Feb 2024 00:48:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SNs9M9/202WucAAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 20 Feb 2024 00:48:31 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: viro@zeniv.linux.org.uk,  jaegeuk@kernel.org,  tytso@mit.edu,
  amir73il@gmail.com,  linux-ext4@vger.kernel.org,
  linux-f2fs-devel@lists.sourceforge.net,  linux-fsdevel@vger.kernel.org,
  brauner@kernel.org
Subject: Re: [PATCH v6 04/10] fscrypt: Drop d_revalidate once the key is added
In-Reply-To: <20240215003145.GK1638@sol.localdomain> (Eric Biggers's message
	of "Wed, 14 Feb 2024 16:31:45 -0800")
Organization: SUSE
References: <20240213021321.1804-1-krisman@suse.de>
	<20240213021321.1804-5-krisman@suse.de>
	<20240215001631.GI1638@sol.localdomain>
	<20240215003145.GK1638@sol.localdomain>
Date: Mon, 19 Feb 2024 19:48:30 -0500
Message-ID: <875xykarkx.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,mit.edu,gmail.com,vger.kernel.org,lists.sourceforge.net];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Eric Biggers <ebiggers@kernel.org> writes:

> On Wed, Feb 14, 2024 at 04:16:31PM -0800, Eric Biggers wrote:
>> On Mon, Feb 12, 2024 at 09:13:15PM -0500, Gabriel Krisman Bertazi wrote:
>> > From fscrypt perspective, once the key is available, the dentry will
>> > remain valid until evicted for other reasons, since keyed dentries don't
>> > require revalidation and, if the key is removed, the dentry is
>> > forcefully evicted.  Therefore, we don't need to keep revalidating them
>> > repeatedly.
>> > 
>> > Obviously, we can only do this if fscrypt is the only thing requiring
>> > revalidation for a dentry.  For this reason, we only disable
>> > d_revalidate if the .d_revalidate hook is fscrypt_d_revalidate itself.
>> > 
>> > It is safe to do it here because when moving the dentry to the
>> > plain-text version, we are holding the d_lock.  We might race with a
>> > concurrent RCU lookup but this is harmless because, at worst, we will
>> > get an extra d_revalidate on the keyed dentry, which is will find the
>> > dentry is valid.
>> > 
>> > Finally, now that we do more than just clear the DCACHE_NOKEY_NAME in
>> > fscrypt_handle_d_move, skip it entirely for plaintext dentries, to avoid
>> > extra costs.
>> > 
>> > Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
>> 
>> I think this explanation misses an important point, which is that it's only
>> *directories* where a no-key dentry can become the regular dentry.  The VFS does
>> the move because it only allows one dentry to exist per directory.
>> 
>> For nondirectories, the dentries don't get reused and this patch is irrelevant.
>> 
>> (Of course, there's no point in making fscrypt_handle_d_move() check whether the
>> dentry is a directory, since checking DCACHE_NOKEY_NAME is sufficient.)
>> 
>> The diff itself looks good -- thanks.
>> 
>
> Also, do I understand correctly that this patch is a performance optimization,
> not preventing a performance regression?  The similar patch that precedes this
> one, "fscrypt: Drop d_revalidate for valid dentries during lookup", is about
> preventing a performance regression on dentries that aren't no-key.  This patch
> looks deceptively similar, but it only affects no-key directory dentries, which
> we were already doing the fscrypt_d_revalidate for, even after the move to the
> plaintext name.  It's probably still a worthwhile optimization to stop doing the
> fscrypt_d_revalidate when a directory dentry gets moved like that.  But I want
> to make sure I'm correctly understanding each patch.

Hi Eric,

Yes, your understanding is correct. The previous patch prevents the
regression, given that we will install d_revalidate "by default" on all
dentries when fscrypt is enabled. Once that was done, it seemed obvious
to add the optimization to also drop it when the key is added later,
which is what this patch is about.

I'll follow up with a v7 shortly. Just need to find some cycles to work
on it.

thanks,


-- 
Gabriel Krisman Bertazi

