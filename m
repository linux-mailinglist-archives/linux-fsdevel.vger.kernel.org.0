Return-Path: <linux-fsdevel+bounces-26564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E15A95A819
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79BFBB21CBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 23:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D508B17C7C6;
	Wed, 21 Aug 2024 23:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fRMZjeEA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NFD2bP1d";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fRMZjeEA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NFD2bP1d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F66A1494AD;
	Wed, 21 Aug 2024 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724282568; cv=none; b=IaELEqmNfjSYwKiagmmFr1hWkJCTzBMaLuwtlD1R3CAATZ+/9AG9a0TXYFKVmeAtlcHJ+lNf1qH+WwgNbrjmLRtpi260+QYo1dGPt2FHh6RQsIXvnDPBS2Bb4oZGkSFPTF59DBP/BMP74K0ghsa2bBEVd8uzxtLBJ7pNEWl94Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724282568; c=relaxed/simple;
	bh=kVhZqRkVV1bjvD670JLB8X4z7NTopasXuAIDVCcygdY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ety+K8pVZ+UMecN5MSrBR7aww8Sbriwa846k22K1Vfgn/H9+GJCiDJzJU+Bw5GBSQ/k37d5m9P1uPad+GKrDUca5bcZ6L8tBFtsag5L8rpa6J3X3RUj55vPfEfy/FE0Avwu6g9mygg3I2W70EyJfwmHqpbD0KDNuciGothb1gNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fRMZjeEA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NFD2bP1d; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fRMZjeEA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NFD2bP1d; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB2FD200FF;
	Wed, 21 Aug 2024 23:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724282564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0VqUrt7TEVe2jgA3XFvg/WNbxDZE9ihhU0buJlSZ4FU=;
	b=fRMZjeEAPiwU8kAOxk7iq8G87VobLct+Y43y5nF1ZRhgBh0qsoJ2/Lz4YHFmhYOtW5OewE
	Oxpv/saQVKxe0fG5jG057HqMGIJPy8UgiINT1hA2t3R82t+i2sqsnupm9Pg+IBxxsqR407
	r+86/jGo4jJtOaHngXebdPvsv3CcuK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724282564;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0VqUrt7TEVe2jgA3XFvg/WNbxDZE9ihhU0buJlSZ4FU=;
	b=NFD2bP1dhXmZyOe4jau1both/UEfeSxP44nftleYUtpcrvTKbxSCVFeDrwFQwVfVZWGuX7
	Ck+qdVCPKLd7OZBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724282564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0VqUrt7TEVe2jgA3XFvg/WNbxDZE9ihhU0buJlSZ4FU=;
	b=fRMZjeEAPiwU8kAOxk7iq8G87VobLct+Y43y5nF1ZRhgBh0qsoJ2/Lz4YHFmhYOtW5OewE
	Oxpv/saQVKxe0fG5jG057HqMGIJPy8UgiINT1hA2t3R82t+i2sqsnupm9Pg+IBxxsqR407
	r+86/jGo4jJtOaHngXebdPvsv3CcuK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724282564;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0VqUrt7TEVe2jgA3XFvg/WNbxDZE9ihhU0buJlSZ4FU=;
	b=NFD2bP1dhXmZyOe4jau1both/UEfeSxP44nftleYUtpcrvTKbxSCVFeDrwFQwVfVZWGuX7
	Ck+qdVCPKLd7OZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7727513770;
	Wed, 21 Aug 2024 23:22:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sj3PFsR2xmaRUAAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 21 Aug 2024 23:22:44 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: viro@zeniv.linux.org.uk,  brauner@kernel.org,  tytso@mit.edu,
  linux-ext4@vger.kernel.org,  jack@suse.cz,  adilger.kernel@dilger.ca,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  kernel@collabora.com,  shreeya.patel@collabora.com
Subject: Re: [PATCH 1/2] fs/dcache: introduce d_alloc_parallel_check_existing
In-Reply-To: <2df894de-8fa9-40c2-ba2c-f9ae65520656@collabora.com> (Eugen
	Hristev's message of "Wed, 21 Aug 2024 12:10:23 +0300")
Organization: SUSE
References: <20240705062621.630604-1-eugen.hristev@collabora.com>
	<20240705062621.630604-2-eugen.hristev@collabora.com>
	<87zfp7rltx.fsf@mailhost.krisman.be>
	<2df894de-8fa9-40c2-ba2c-f9ae65520656@collabora.com>
Date: Wed, 21 Aug 2024 19:22:39 -0400
Message-ID: <87jzg9wjeo.fsf@mailhost.krisman.be>
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
	NEURAL_HAM_SHORT(-0.20)[-0.986];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Eugen Hristev <eugen.hristev@collabora.com> writes:

> Yes, but we cannot add another dentry for the same file with a different case.
> That would break everything about dentry lookups, etc.
> We need to have the one dentry in the cache which use the right case. Regardless of
> the case of the lookup.
>
> As Al Viro said here :
> https://lore.kernel.org/lkml/YVmyYP25kgGq9uEy@zeniv-ca.linux.org.uk/
> we cannot have parallel lookups for names that would compare as equals (two
> different dentries for the same file with different case).
>
> So yes, I return the same dentry-under-lookup, because that's the purpose of that
> search, return it, have it use the right case, and then splice it to the cache.

It is not changing the case of the returned dentry.  The patch simply
returns the same dentry you sent to d_alloc_parallel, which is then
spliced into the cache. Exactly as if you had issued d_splice_alias
directly.  You are just doing a hop in d_alloc_parallel and finding the
same dentry.

A quick test case below. You can print the ->d_name through
several methods. I'm doing it by reading /proc/self/cwd.

$ # In a case-insensitive filesystem
$ mkdir cf &&  chattr +F cf
$ mkdir cf/hello
$ echo 3 > /proc/sys/vm/drop_caches    # drop the dentry created above
$ cd cf/HELLO                          # provoke a case-inexact lookup.
$ readlink /proc/self/cwd

If we replaced the dentry with the disk name, it should
print <mnt>/cf/hello.  With your patch, it still prints <mnt>/cf/HELLO

Al,

Would it be acceptable to just change the dentry->d_name here in a new
flavor of d_add_ci used only by these filesystems? We are inside the
creation path, so the dentry has never been hashed.  Concurrent lookups
will be stuck in d_wait_lookup() until we are done and will never become
invalid after the change because the lookup was already done
case-insensitively, so they all match the same dentry, per-definition,
and we know there is no other matching dentries in the directory.  We'd
only need to be careful not to expose partial names to concurrent
parallel lookups.

-- 
Gabriel Krisman Bertazi

