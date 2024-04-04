Return-Path: <linux-fsdevel+bounces-16139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E4D8991C5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 01:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB28A1C21C22
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 23:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F6A13C3E3;
	Thu,  4 Apr 2024 23:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bcky6LVO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0e/jlncX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CcbL799t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TN73Rs8E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329F0130A76;
	Thu,  4 Apr 2024 23:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712271916; cv=none; b=jE2CVIx+tSwjs6MZy9lq6/IPTBQkll+qkGySl4RqQ3bhx7Gvsb5TT8U0qBTCCykSodeX/CU2YgU20RdaYIcPn57/aelKC3+JXjJPZZtAwC1d0uX7LwZ+bhDvQ4r9pMoy8epD2xCc8WDqosP4qpf2dvyISJzJvfAMEDDIyAA6CkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712271916; c=relaxed/simple;
	bh=b1kCDBDvOShJK96rPcAUIog34L3Yk7Ibpoxk4AGUui8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AvJgldvXUy40WrHZlo84UY2KrY9/tZbigvmDtibDPMcfLY3+BW21MEphhDvfGYw34Ij/bBPrQfnzVQ6a2BXou1T1GOy3tJaOFZonKONMkuH7IWpyJ8YI11twDTAeoi9A/hOAAhKkRDwda+J651fe3XGXZvi7N0qGtZn1PIsDl6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bcky6LVO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0e/jlncX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CcbL799t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TN73Rs8E; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0D2011F456;
	Thu,  4 Apr 2024 23:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712271913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7VE3ztJCG2vuXZkOYNMILtCyLk93dzgPNmKlKaF1EYA=;
	b=Bcky6LVOBlzfTS5gWcWJtwJoeaVRF90KYZbI6vpJ8CCT6ir5JPTKTwDJyWdiHbZz/AJWfe
	7lfOEV+kOTlohOmZP9kox8debfyLNarmyf6IjLrEYaohaJxXViW/5kmKz4X25+3fY5xzP2
	Gajbvsr4Sp/EM9pRbA3XUSKL0Snpll0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712271913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7VE3ztJCG2vuXZkOYNMILtCyLk93dzgPNmKlKaF1EYA=;
	b=0e/jlncXZbZB5g91s3iKziBK5JWfQTxctQIKX14WlY1m7nd4/hgKhFOUyeN3yVJ6C5K/dN
	bSP1nK3RbXXE/iBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712271912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7VE3ztJCG2vuXZkOYNMILtCyLk93dzgPNmKlKaF1EYA=;
	b=CcbL799tKj3KExxNjYWMJZnMhI7aNJaApzcwMuzj6pe5Lfc3RrWTSYvrgOaU9jYw2hvGMB
	Ec/U5HZ9zU4KmsF8HTXAT6J3aI+xLBkfsih5ZFg0/8A8DG6w2pk4HvwC/rWPagu3RO3o7y
	RFSwlYH3rXU32IcPH05Lg7fJ55k78R4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712271912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7VE3ztJCG2vuXZkOYNMILtCyLk93dzgPNmKlKaF1EYA=;
	b=TN73Rs8EamcWeu9yssAmGKbtBok/WbaXA9BgRNDFMilXw3WQ+E6MN86mAkGQXPQ7Cbr6cl
	3KFzZaJo/fEknkCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B0A5B139E8;
	Thu,  4 Apr 2024 23:05:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id mA7jHicyD2YpIgAAn2gu4w
	(envelope-from <krisman@suse.de>); Thu, 04 Apr 2024 23:05:11 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Eric Biggers <ebiggers@kernel.org>,  tytso@mit.edu,
  adilger.kernel@dilger.ca,  linux-ext4@vger.kernel.org,
  jaegeuk@kernel.org,  chao@kernel.org,
  linux-f2fs-devel@lists.sourceforge.net,  linux-fsdevel@vger.kernel.org,
  brauner@kernel.org,  jack@suse.cz,  linux-kernel@vger.kernel.org,
  viro@zeniv.linux.org.uk,  kernel@collabora.com
Subject: Re: [f2fs-dev] [PATCH v15 7/9] f2fs: Log error when lookup of
 encoded dentry fails
In-Reply-To: <e6d1ad0b-719a-4693-bd34-bea3cf6e4fa2@collabora.com> (Eugen
	Hristev's message of "Thu, 4 Apr 2024 17:50:29 +0300")
References: <20240402154842.508032-1-eugen.hristev@collabora.com>
	<20240402154842.508032-8-eugen.hristev@collabora.com>
	<20240403042503.GI2576@sol.localdomain>
	<e6d1ad0b-719a-4693-bd34-bea3cf6e4fa2@collabora.com>
Date: Thu, 04 Apr 2024 19:05:10 -0400
Message-ID: <87v84w3f15.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:email,collabora.com:email]

Eugen Hristev <eugen.hristev@collabora.com> writes:

> On 4/3/24 07:25, Eric Biggers wrote:
>> On Tue, Apr 02, 2024 at 06:48:40PM +0300, Eugen Hristev via Linux-f2fs-devel wrote:
>>> If the volume is in strict mode, generi c_ci_compare can report a broken
>>> encoding name.  This will not trigger on a bad lookup, which is caught
>>> earlier, only if the actual disk name is bad.
>>>
>>> Suggested-by: Gabriel Krisman Bertazi <krisman@suse.de>
>>> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
>>> ---
>>>  fs/f2fs/dir.c | 15 ++++++++++-----
>>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
>>> index 88b0045d0c4f..64286d80dd30 100644
>>> --- a/fs/f2fs/dir.c
>>> +++ b/fs/f2fs/dir.c
>>> @@ -192,11 +192,16 @@ static inline int f2fs_match_name(const struct inode *dir,
>>>  	struct fscrypt_name f;
>>>  
>>>  #if IS_ENABLED(CONFIG_UNICODE)
>>> -	if (fname->cf_name.name)
>>> -		return generic_ci_match(dir, fname->usr_fname,
>>> -					&fname->cf_name,
>>> -					de_name, de_name_len);
>>> -
>>> +	if (fname->cf_name.name) {
>>> +		int ret = generic_ci_match(dir, fname->usr_fname,
>>> +					   &fname->cf_name,
>>> +					   de_name, de_name_len);
>>> +		if (ret == -EINVAL)
>>> +			f2fs_warn(F2FS_SB(dir->i_sb),
>>> +				"Directory contains filename that is invalid UTF-8");
>>> +
>> 
>> Shouldn't this use f2fs_warn_ratelimited?
>
> f2fs_warn_ratelimited appears to be very new in the kernel,
>
> Krisman do you think you can rebase your for-next on top of latest such that this
> function is available ? I am basing the series on your for-next
> branch.

I try to make unicode/for-next a non-rebase branch, and I don't want to
pollute the tree with an unecessary backmerge.  Instead, why not base
your work on a more recent branch, since it has no dependencies on
anything from unicode/for-next?

-- 
Gabriel Krisman Bertazi

