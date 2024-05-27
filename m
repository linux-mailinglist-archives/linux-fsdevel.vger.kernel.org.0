Return-Path: <linux-fsdevel+bounces-20279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7468D0ECB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 22:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25EEC282520
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 20:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5FE161338;
	Mon, 27 May 2024 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MgT3Hug8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SA5aB+ZS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MgT3Hug8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SA5aB+ZS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7304C1DA58;
	Mon, 27 May 2024 20:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716843303; cv=none; b=Y72VuEVhedgKoRx7hdfWfThICLpdZvahf5Swxebxtb6KKVtaFCVtfUDvQsbwhDxydlgALGtOs6cVafsj86eq/HG6BlkhBFnGNo4YDxRLSPaN/d6YHhk4daMBe3C943jGmisqN/rwISJivLK2PJ5hmV8aNVOcELE1uU8tHGrtESM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716843303; c=relaxed/simple;
	bh=PeTQPue/126RRk2XEbMW7nbOvogEjizFdhoD4CmtnVg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p/BPaSnRNm10wDWjv5ZEefiRAIqqFU9A9kJMmQ67zmG4aJwOJpPJASxuw6RoqgYdInuBXyIfUqX4wjhiVyw6SAZRSKtn391nxn4RD9JEpjscdU8Kh8JTPafJcc9ks/ybTGuwwYbaoEzq3tTkzwI9Y+s2wmCM5glsHqOxaWAK7j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MgT3Hug8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SA5aB+ZS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MgT3Hug8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SA5aB+ZS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49DC3221BE;
	Mon, 27 May 2024 20:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716843299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1F/wXLo9doe6bC7o3BMJeghui7DJB78U6JuX0/mydHs=;
	b=MgT3Hug8e+KVU6O4LMN/a0d3ULjFYJIS6qIFRuvLdwgwMve5voXhllyWCKVR1BCCex9LiK
	VY9CxK3g0JtRjfOFKogaXimv8HWCuBoExAXI44uI6IE84HE3+Ofq+nFLueuKNCPST+9k12
	LIoN3elEntuU4dSw4nDsQT2cJ5Fh/rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716843299;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1F/wXLo9doe6bC7o3BMJeghui7DJB78U6JuX0/mydHs=;
	b=SA5aB+ZSsX4CYLFpeEMg4W4HMB5T2Ew9XdF4wVMMMr+fuexZ9VunrqaH9Lk51EVj3UAqM9
	pztfQZtu9Syu52DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716843299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1F/wXLo9doe6bC7o3BMJeghui7DJB78U6JuX0/mydHs=;
	b=MgT3Hug8e+KVU6O4LMN/a0d3ULjFYJIS6qIFRuvLdwgwMve5voXhllyWCKVR1BCCex9LiK
	VY9CxK3g0JtRjfOFKogaXimv8HWCuBoExAXI44uI6IE84HE3+Ofq+nFLueuKNCPST+9k12
	LIoN3elEntuU4dSw4nDsQT2cJ5Fh/rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716843299;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1F/wXLo9doe6bC7o3BMJeghui7DJB78U6JuX0/mydHs=;
	b=SA5aB+ZSsX4CYLFpeEMg4W4HMB5T2Ew9XdF4wVMMMr+fuexZ9VunrqaH9Lk51EVj3UAqM9
	pztfQZtu9Syu52DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05BE313A6B;
	Mon, 27 May 2024 20:54:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NsewNiLzVGY2SQAAD6G6ig
	(envelope-from <krisman@suse.de>); Mon, 27 May 2024 20:54:58 +0000
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
In-Reply-To: <92b56554-3415-46fe-99b4-99258d8a496c@collabora.com> (Eugen
	Hristev's message of "Sun, 26 May 2024 14:49:42 +0300")
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
	<20240405121332.689228-4-eugen.hristev@collabora.com>
	<20240510013330.GI1110919@google.com>
	<875xviyb3f.fsf@mailhost.krisman.be>
	<9afebadd-765f-42f3-a80b-366dd749bf48@collabora.com>
	<87ttipqwfn.fsf@mailhost.krisman.be>
	<92b56554-3415-46fe-99b4-99258d8a496c@collabora.com>
Date: Mon, 27 May 2024 16:54:53 -0400
Message-ID: <87ttijnffm.fsf@mailhost.krisman.be>
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
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
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

> On 5/23/24 02:05, Gabriel Krisman Bertazi wrote:
>> Eugen Hristev <eugen.hristev@collabora.com> writes:
>> 
>>> On 5/13/24 00:27, Gabriel Krisman Bertazi wrote:
>>>> Eric Biggers <ebiggers@kernel.org> writes:
>>>>
>>>>> On Fri, Apr 05, 2024 at 03:13:26PM +0300, Eugen Hristev wrote:
>>>>
>>>>>> +		if (WARN_ON_ONCE(!fscrypt_has_encryption_key(parent)))
>>>>>> +			return -EINVAL;
>>>>>> +
>>>>>> +		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
>>>>>> +		if (!decrypted_name.name)
>>>>>> +			return -ENOMEM;
>>>>>> +		res = fscrypt_fname_disk_to_usr(parent, 0, 0, &encrypted_name,
>>>>>> +						&decrypted_name);
>>>>>> +		if (res < 0)
>>>>>> +			goto out;
>>>>>
>>>>> If fscrypt_fname_disk_to_usr() returns an error and !sb_has_strict_encoding(sb),
>>>>> then this function returns 0 (indicating no match) instead of the error code
>>>>> (indicating an error).  Is that the correct behavior?  I would think that
>>>>> strict_encoding should only have an effect on the actual name
>>>>> comparison.
>>>>
>>>> No. we *want* this return code to be propagated back to f2fs.  In ext4 it
>>>> wouldn't matter since the error is not visible outside of ext4_match,
>>>> but f2fs does the right thing and stops the lookup.
>>>
>>> In the previous version which I sent, you told me that the error should be
>>> propagated only in strict_mode, and if !strict_mode, it should just return no match.
>>> Originally I did not understand that this should be done only for utf8_strncasecmp
>>> errors, and not for all the errors. I will change it here to fix that.
>> 
>> Yes, it depends on which error we are talking about. For ENOMEM and
>> whatever error fscrypt_fname_disk_to_usr returns, we surely want to send
>> that back, such that f2fs can handle it (i.e abort the lookup).  Unicode
>> casefolding errors don't need to stop the lookup.
>> 
>> 
>>>> Thinking about it, there is a second problem with this series.
>>>> Currently, if we are on strict_mode, f2fs_match_ci_name does not
>>>> propagate unicode errors back to f2fs. So, once a utf8 invalid sequence
>>>> is found during lookup, it will be considered not-a-match but the lookup
>>>> will continue.  This allows some lookups to succeed even in a corrupted
>>>> directory.  With this patch, we will abort the lookup on the first
>>>> error, breaking existing semantics.  Note that these are different from
>>>> memory allocation failure and fscrypt_fname_disk_to_usr. For those, it
>>>> makes sense to abort.
>>>
>>> So , in the case of f2fs , we must not propagate utf8 errors ? It should just
>>> return no match even in strict mode ?
>>> If this helper is common for both f2fs and ext4, we have to do the same for ext4 ?
>>> Or we are no longer able to commonize the code altogether ?
>> 
>> We can have a common handler.  It doesn't matter for Ext4 because it
>> ignores all errors. Perhaps ext4 can be improved too in a different
>> patchset.
>> 
>>>> My suggestion would be to keep the current behavior.  Make
>>>> generic_ci_match only propagate non-unicode related errors back to the
>>>> filesystem.  This means that we need to move the error messages in patch
>>>> 6 and 7 into this function, so they only trigger when utf8_strncasecmp*
>>>> itself fails.
>>>>
>>>
>>> So basically unicode errors stop here, and print the error message here in that case.
>>> Am I understanding it correctly ?
>> 
>> Yes, that is it.  print the error message - only in strict mode - and
>> return not-a-match.
>> 
>> Is there any problem with this approach that I'm missing?
>
> As the printing is moved here, in the common code, we cannot use either of
> f2fs_warn nor EXT4_ERROR_INODE . Any suggestion ? Would have to be something
> meaningful for the user and ratelimited I guess.
>

Ah, that is not great, since EXT4_ERROR_INODE does more things like
annotating the error in the sb and sending a FAN_FS_ERROR to any
watchers. But still, this is a rare error and I'm not really sure we
care, nor that it should gate the rest of the series.

I'd say just use pr_err and be done with it.


-- 
Gabriel Krisman Bertazi

