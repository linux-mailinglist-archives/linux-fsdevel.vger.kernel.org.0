Return-Path: <linux-fsdevel+bounces-19358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F066A8C3898
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 23:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8518281BB2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 21:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22949535A8;
	Sun, 12 May 2024 21:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DbWyX943";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yRY4TBZ8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DbWyX943";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yRY4TBZ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023BE381DA;
	Sun, 12 May 2024 21:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715549286; cv=none; b=CTapvuktD/BfhXQnrktJIwUJKHwm8/zr4rSipwWbowA2DKjYp3lFrg4DtlycKbCZ/E0eLbK4U9sqPolv24X643/TOu7M3F0x9HK7xYW8Bb5gFRD1YLrU+FMAIkyZqqqzM0abDFYp7wMp4/PUF4B2Q7v5RLclPCcxYLdr6K4ISzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715549286; c=relaxed/simple;
	bh=KSIt88quIRh+q0RVSSIS6Irr9lCYULs84MOjvBaWryI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h8pGbkk38+wYo0pVzTtqHr5sw9yq301pyHE/BmxQLwtoPynJnh6rcSmcsFaVGd4OsNd0aTtErMc5O3ykZT90OWxlldTtfAtAJk187MEspbROeP3+SWtInuiSnO/S8yrSfMsj9aHT7gmPaOhQ0Ii5LC2eV1nqV+HIal8+3tN+Bi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DbWyX943; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yRY4TBZ8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DbWyX943; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yRY4TBZ8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0538121B3F;
	Sun, 12 May 2024 21:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715549283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jf/nTYdtFSrpGP4pdOHHrKJq/xNpkR7aBGpW4FB068A=;
	b=DbWyX943Zj70x56Nu5YgEr4FCOAh0dtpj+t4G2PgTfoy//scOf6Upl/2ALkpZviP/yX48T
	16bWEN8/pYhA4iad797kO1XQD8K9KFz09caqlOnCa6rlJH1ovo99p4LhDeP58pK57G0gVZ
	wbhbJhV8kkX/EDOhsZ5sxMYUEUnGgF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715549283;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jf/nTYdtFSrpGP4pdOHHrKJq/xNpkR7aBGpW4FB068A=;
	b=yRY4TBZ86MHjyMIrAdjz0dLJGgy2lyo0mqSjd4lOhFDT/L6JwGmx3Xwg47UTM8Q0D8ktrZ
	vij7rp5eteZocLDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DbWyX943;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yRY4TBZ8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715549283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jf/nTYdtFSrpGP4pdOHHrKJq/xNpkR7aBGpW4FB068A=;
	b=DbWyX943Zj70x56Nu5YgEr4FCOAh0dtpj+t4G2PgTfoy//scOf6Upl/2ALkpZviP/yX48T
	16bWEN8/pYhA4iad797kO1XQD8K9KFz09caqlOnCa6rlJH1ovo99p4LhDeP58pK57G0gVZ
	wbhbJhV8kkX/EDOhsZ5sxMYUEUnGgF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715549283;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jf/nTYdtFSrpGP4pdOHHrKJq/xNpkR7aBGpW4FB068A=;
	b=yRY4TBZ86MHjyMIrAdjz0dLJGgy2lyo0mqSjd4lOhFDT/L6JwGmx3Xwg47UTM8Q0D8ktrZ
	vij7rp5eteZocLDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BDEE13A3A;
	Sun, 12 May 2024 21:28:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tzV8L2E0QWbqKAAAD6G6ig
	(envelope-from <krisman@suse.de>); Sun, 12 May 2024 21:28:01 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,  tytso@mit.edu,
  adilger.kernel@dilger.ca,  linux-ext4@vger.kernel.org,
  jaegeuk@kernel.org,  chao@kernel.org,
  linux-f2fs-devel@lists.sourceforge.net,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel@collabora.com,
  viro@zeniv.linux.org.uk,  brauner@kernel.org,  jack@suse.cz,  Gabriel
 Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v16 3/9] libfs: Introduce case-insensitive string
 comparison helper
In-Reply-To: <20240510013330.GI1110919@google.com> (Eric Biggers's message of
	"Fri, 10 May 2024 01:33:30 +0000")
Organization: SUSE
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
	<20240405121332.689228-4-eugen.hristev@collabora.com>
	<20240510013330.GI1110919@google.com>
Date: Sun, 12 May 2024 17:27:48 -0400
Message-ID: <875xviyb3f.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0538121B3F
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -6.51

Eric Biggers <ebiggers@kernel.org> writes:

> On Fri, Apr 05, 2024 at 03:13:26PM +0300, Eugen Hristev wrote:

>> +		if (WARN_ON_ONCE(!fscrypt_has_encryption_key(parent)))
>> +			return -EINVAL;
>> +
>> +		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
>> +		if (!decrypted_name.name)
>> +			return -ENOMEM;
>> +		res = fscrypt_fname_disk_to_usr(parent, 0, 0, &encrypted_name,
>> +						&decrypted_name);
>> +		if (res < 0)
>> +			goto out;
>
> If fscrypt_fname_disk_to_usr() returns an error and !sb_has_strict_encoding(sb),
> then this function returns 0 (indicating no match) instead of the error code
> (indicating an error).  Is that the correct behavior?  I would think that
> strict_encoding should only have an effect on the actual name
> comparison.

No. we *want* this return code to be propagated back to f2fs.  In ext4 it
wouldn't matter since the error is not visible outside of ext4_match,
but f2fs does the right thing and stops the lookup.

Thinking about it, there is a second problem with this series.
Currently, if we are on strict_mode, f2fs_match_ci_name does not
propagate unicode errors back to f2fs. So, once a utf8 invalid sequence
is found during lookup, it will be considered not-a-match but the lookup
will continue.  This allows some lookups to succeed even in a corrupted
directory.  With this patch, we will abort the lookup on the first
error, breaking existing semantics.  Note that these are different from
memory allocation failure and fscrypt_fname_disk_to_usr. For those, it
makes sense to abort.

Also, once patch 6 and 7 are added, if fscrypt fails with -EINVAL for
any reason unrelated to unicode (like in the WARN_ON above), we will
incorrectly print the error message saying there is a bad UTF8 string.

My suggestion would be to keep the current behavior.  Make
generic_ci_match only propagate non-unicode related errors back to the
filesystem.  This means that we need to move the error messages in patch
6 and 7 into this function, so they only trigger when utf8_strncasecmp*
itself fails.

>> +	/*
>> +	 * Attempt a case-sensitive match first. It is cheaper and
>> +	 * should cover most lookups, including all the sane
>> +	 * applications that expect a case-sensitive filesystem.
>> +	 */
>> +	if (folded_name->name) {
>> +		if (dirent.len == folded_name->len &&
>> +		    !memcmp(folded_name->name, dirent.name, dirent.len))
>> +			goto out;
>> +		res = utf8_strncasecmp_folded(um, folded_name, &dirent);
>
> Shouldn't the memcmp be done with the original user-specified name, not the
> casefolded name?  I would think that the user-specified name is the one that's
> more likely to match the on-disk name, because of case preservation.  In most
> cases users will specify the same case on both file creation and later access.

Yes.

-- 
Gabriel Krisman Bertazi

