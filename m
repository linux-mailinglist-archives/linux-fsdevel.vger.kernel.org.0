Return-Path: <linux-fsdevel+bounces-20027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E508CC963
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 01:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C64FA1C21B7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 23:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44524149C5F;
	Wed, 22 May 2024 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NlJx4mwR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7MQP87kK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NlJx4mwR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7MQP87kK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE70149C49;
	Wed, 22 May 2024 23:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716419159; cv=none; b=kGGBIe6C82ur5mSa32qGlpjHNW38pLffZkgRl624HH2WpingvmQTwNYIQhEk4nnA0kp+4kOaTz+aTW0z6tEuLtTHd4T+b4VwzpOhyx8GxN1n8QBicxaNyv5vaeoH0++qfJ7lWdyme4xwpIgN+kwgKAiqyFQBtKP+bHH/neHHHHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716419159; c=relaxed/simple;
	bh=/3H1/xx70RPb1v9mPd7+wQJNDge3wLi4qa1B8CddtdM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fLOUrP60iysE652zmtY+cX+baCK7AsnTS5/ID2PaXxPktc59McRB33OjYvnzcBK8ZXddRalxaDCfpzQJcBX38a2o/9xrmC0F5IBjGL8GjYOIbKWC2Lho6S5T7fXzxbmS6lIc2e7waDUkx6doR/8/lb42kbdeGDbsPK7UljHaY78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NlJx4mwR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7MQP87kK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NlJx4mwR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7MQP87kK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4EDFE21C90;
	Wed, 22 May 2024 23:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716419155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qPfXVp/tEVsWFQJc+z+Z0QErdbW1K9EWBB3fgBG/hmQ=;
	b=NlJx4mwR3v/+64ZICJXtuF36Dupuk5G3omX9aABu8HjIwXsxGa1gTxreU114AX7FSBAWI5
	TMwfhTkUZTu1iDP2c/uwVe20hKDTK6CD6t00KGcBUxfwv5PS3IF+ev6h7NifXQ+uI/cvtN
	T1lTUm2GTQRxGDQHHng6oBseJgWffrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716419155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qPfXVp/tEVsWFQJc+z+Z0QErdbW1K9EWBB3fgBG/hmQ=;
	b=7MQP87kKUGrd9GkznCF0BQTR3zQasxlgg407MdhO6svLyWZOfqc6N/g3kMQvJZNdFhbI1b
	OlM3APRdoOBd/aAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716419155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qPfXVp/tEVsWFQJc+z+Z0QErdbW1K9EWBB3fgBG/hmQ=;
	b=NlJx4mwR3v/+64ZICJXtuF36Dupuk5G3omX9aABu8HjIwXsxGa1gTxreU114AX7FSBAWI5
	TMwfhTkUZTu1iDP2c/uwVe20hKDTK6CD6t00KGcBUxfwv5PS3IF+ev6h7NifXQ+uI/cvtN
	T1lTUm2GTQRxGDQHHng6oBseJgWffrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716419155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qPfXVp/tEVsWFQJc+z+Z0QErdbW1K9EWBB3fgBG/hmQ=;
	b=7MQP87kKUGrd9GkznCF0BQTR3zQasxlgg407MdhO6svLyWZOfqc6N/g3kMQvJZNdFhbI1b
	OlM3APRdoOBd/aAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1477E13A6B;
	Wed, 22 May 2024 23:05:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uYagOlJ6TmYKVQAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 22 May 2024 23:05:54 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Eric Biggers <ebiggers@kernel.org>,  tytso@mit.edu,
  adilger.kernel@dilger.ca,  linux-ext4@vger.kernel.org,
  jaegeuk@kernel.org,  chao@kernel.org,
  linux-f2fs-devel@lists.sourceforge.net,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel@collabora.com,
  viro@zeniv.linux.org.uk,  brauner@kernel.org,  jack@suse.cz,  Gabriel
 Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v16 3/9] libfs: Introduce case-insensitive string
 comparison helper
In-Reply-To: <9afebadd-765f-42f3-a80b-366dd749bf48@collabora.com> (Eugen
	Hristev's message of "Wed, 22 May 2024 17:02:53 +0300")
Organization: SUSE
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
	<20240405121332.689228-4-eugen.hristev@collabora.com>
	<20240510013330.GI1110919@google.com>
	<875xviyb3f.fsf@mailhost.krisman.be>
	<9afebadd-765f-42f3-a80b-366dd749bf48@collabora.com>
Date: Wed, 22 May 2024 19:05:48 -0400
Message-ID: <87ttipqwfn.fsf@mailhost.krisman.be>
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
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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

> On 5/13/24 00:27, Gabriel Krisman Bertazi wrote:
>> Eric Biggers <ebiggers@kernel.org> writes:
>> 
>>> On Fri, Apr 05, 2024 at 03:13:26PM +0300, Eugen Hristev wrote:
>> 
>>>> +		if (WARN_ON_ONCE(!fscrypt_has_encryption_key(parent)))
>>>> +			return -EINVAL;
>>>> +
>>>> +		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
>>>> +		if (!decrypted_name.name)
>>>> +			return -ENOMEM;
>>>> +		res = fscrypt_fname_disk_to_usr(parent, 0, 0, &encrypted_name,
>>>> +						&decrypted_name);
>>>> +		if (res < 0)
>>>> +			goto out;
>>>
>>> If fscrypt_fname_disk_to_usr() returns an error and !sb_has_strict_encoding(sb),
>>> then this function returns 0 (indicating no match) instead of the error code
>>> (indicating an error).  Is that the correct behavior?  I would think that
>>> strict_encoding should only have an effect on the actual name
>>> comparison.
>> 
>> No. we *want* this return code to be propagated back to f2fs.  In ext4 it
>> wouldn't matter since the error is not visible outside of ext4_match,
>> but f2fs does the right thing and stops the lookup.
>
> In the previous version which I sent, you told me that the error should be
> propagated only in strict_mode, and if !strict_mode, it should just return no match.
> Originally I did not understand that this should be done only for utf8_strncasecmp
> errors, and not for all the errors. I will change it here to fix that.

Yes, it depends on which error we are talking about. For ENOMEM and
whatever error fscrypt_fname_disk_to_usr returns, we surely want to send
that back, such that f2fs can handle it (i.e abort the lookup).  Unicode
casefolding errors don't need to stop the lookup.


>> Thinking about it, there is a second problem with this series.
>> Currently, if we are on strict_mode, f2fs_match_ci_name does not
>> propagate unicode errors back to f2fs. So, once a utf8 invalid sequence
>> is found during lookup, it will be considered not-a-match but the lookup
>> will continue.  This allows some lookups to succeed even in a corrupted
>> directory.  With this patch, we will abort the lookup on the first
>> error, breaking existing semantics.  Note that these are different from
>> memory allocation failure and fscrypt_fname_disk_to_usr. For those, it
>> makes sense to abort.
>
> So , in the case of f2fs , we must not propagate utf8 errors ? It should just
> return no match even in strict mode ?
> If this helper is common for both f2fs and ext4, we have to do the same for ext4 ?
> Or we are no longer able to commonize the code altogether ?

We can have a common handler.  It doesn't matter for Ext4 because it
ignores all errors. Perhaps ext4 can be improved too in a different
patchset.

>> My suggestion would be to keep the current behavior.  Make
>> generic_ci_match only propagate non-unicode related errors back to the
>> filesystem.  This means that we need to move the error messages in patch
>> 6 and 7 into this function, so they only trigger when utf8_strncasecmp*
>> itself fails.
>> 
>
> So basically unicode errors stop here, and print the error message here in that case.
> Am I understanding it correctly ?

Yes, that is it.  print the error message - only in strict mode - and
return not-a-match.

Is there any problem with this approach that I'm missing?

>>>> +	/*
>>>> +	 * Attempt a case-sensitive match first. It is cheaper and
>>>> +	 * should cover most lookups, including all the sane
>>>> +	 * applications that expect a case-sensitive filesystem.
>>>> +	 */
>>>> +	if (folded_name->name) {
>>>> +		if (dirent.len == folded_name->len &&
>>>> +		    !memcmp(folded_name->name, dirent.name, dirent.len))
>>>> +			goto out;
>>>> +		res = utf8_strncasecmp_folded(um, folded_name, &dirent);
>>>
>>> Shouldn't the memcmp be done with the original user-specified name, not the
>>> casefolded name?  I would think that the user-specified name is the one that's
>>> more likely to match the on-disk name, because of case preservation.  In most
>>> cases users will specify the same case on both file creation and later access.
>> 
>> Yes.
>> 
> so the utf8_strncasecmp_folded call here must use name->name instead of folded_name ?

No, utf8_strncasecmp_folded requires a casefolded name.  Eric's point is
that the *memcmp* should always compare against name->name since it's more
likely to match the name on disk than the folded version because the user
is probably doing a case-exact lookup.

This also means the memcmp can be moved outside the "if (folded_name->name)",
simplifying the patch!

-- 
Gabriel Krisman Bertazi

