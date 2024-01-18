Return-Path: <linux-fsdevel+bounces-8211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48025831045
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 01:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02DDC282DCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 00:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7C01F16B;
	Thu, 18 Jan 2024 00:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JWnVo48a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rdOVDzlI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JWnVo48a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rdOVDzlI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAC01DFCE
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 00:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705536131; cv=none; b=PLSwPMxZvx8C0cHMTiH8kMFJqk5GaLk8GZhIpzzWAHdQlDsNaRdRCh5oj0xkw30tFRUBrY9141WXfC26TBJYiTQKaXluXk29/WOSz0lPbhqeH+5D3r8FBpRgnjeqm7hvu6MphwaPBHS/Hpl2/FHPEUfapCPvR09bF7GgdN8QyOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705536131; c=relaxed/simple;
	bh=pxnjld9I7dYZcehpV4j4ggbqIXqPB7V6Bw1gcoezzUc=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:In-Reply-To:
	 Organization:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Spamd-Result:X-Spam-Level:X-Spam-Flag:X-Spam-Score;
	b=QAvlU8PBy6TmgY4+7ezeWPv6FTroQruJkCEgBgxbV1DvjYduIS6SRoiNwRFnP9SjGC7hGONqxFAE3OgtpOV+7WZoGwJvhFpSGzmRNMB2ZIxLhY7jwIKK+vnGh+PumfzK6pX5EQUw2pJqYGfDYsZmyXZ7/8JKCRG1/aP+3I6Q8z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JWnVo48a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rdOVDzlI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JWnVo48a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rdOVDzlI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 832A422294;
	Thu, 18 Jan 2024 00:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705536127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1tuwcynDzHfhYKMb3PNbEa1UmMAhpbej5Exat8VYPNo=;
	b=JWnVo48aetnJrcymfZHUfAOaXeezjqx9eH4kvMSw9xFPm/0z9ePi58ioF5jW/xRBHyVToQ
	CkK0N6GYKlAxecWu/ZLxKkU14LH7iwa/7SGRZgqCb/UpD/jtLuzjDA6Hf4PZMH9agNepbB
	oFNeFbskwi/of+31xt8DJz/NEyrEX5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705536127;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1tuwcynDzHfhYKMb3PNbEa1UmMAhpbej5Exat8VYPNo=;
	b=rdOVDzlIqyjNzOWc+1qI+VdAyqQ2LOz9G3rnJC3xtJwD/rNKKiUSwsOLPHQfxjy1szl1Mm
	EZkJeHprAXHsJXAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705536127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1tuwcynDzHfhYKMb3PNbEa1UmMAhpbej5Exat8VYPNo=;
	b=JWnVo48aetnJrcymfZHUfAOaXeezjqx9eH4kvMSw9xFPm/0z9ePi58ioF5jW/xRBHyVToQ
	CkK0N6GYKlAxecWu/ZLxKkU14LH7iwa/7SGRZgqCb/UpD/jtLuzjDA6Hf4PZMH9agNepbB
	oFNeFbskwi/of+31xt8DJz/NEyrEX5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705536127;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1tuwcynDzHfhYKMb3PNbEa1UmMAhpbej5Exat8VYPNo=;
	b=rdOVDzlIqyjNzOWc+1qI+VdAyqQ2LOz9G3rnJC3xtJwD/rNKKiUSwsOLPHQfxjy1szl1Mm
	EZkJeHprAXHsJXAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC3D9136F5;
	Thu, 18 Jan 2024 00:02:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L1xuI35qqGWJLAAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 18 Jan 2024 00:02:06 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: ebiggers@kernel.org,  tytso@mit.edu,  linux-fsdevel@vger.kernel.org,
  jaegeuk@kernel.org,  Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] libfs: Attempt exact-match comparison first during
 casefold lookup
In-Reply-To: <20240117223857.GN1674809@ZenIV> (Al Viro's message of "Wed, 17
	Jan 2024 22:38:57 +0000")
Organization: SUSE
References: <20240117222836.11086-1-krisman@suse.de>
	<20240117223857.GN1674809@ZenIV>
Date: Wed, 17 Jan 2024 21:02:03 -0300
Message-ID: <87edeffr0k.fsf@mailhost.krisman.be>
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
X-Spamd-Result: default: False [-0.11 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[50.44%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.11

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Wed, Jan 17, 2024 at 07:28:36PM -0300, Gabriel Krisman Bertazi wrote:
>
>> Note that, for strict mode, generic_ci_d_compare used to reject an
>> invalid UTF-8 string, which would now be considered valid if it
>> exact-matches the disk-name.  But, if that is the case, the filesystem
>> is corrupt.  More than that, it really doesn't matter in practice,
>> because the name-under-lookup will have already been rejected by
>> generic_ci_d_hash and we won't even get here.
>
>> -	if (ret >= 0)
>> -		return ret;
>> -
>> -	if (sb_has_strict_encoding(sb))
>> +	qstr.len = len;
>> +	qstr.name = str;
>> +	ret = utf8_strncasecmp(dentry->d_sb->s_encoding, name, &qstr);
>> +	if (ret < 0)
>>  		return -EINVAL;
>
> Umm...  So why bother with -EINVAL?  The rest looks sane, but
> considering the fact that your string *has* passed ->d_hash(),
> do we need anything beyond
> 	return utf8_strncasecmp(dentry->d_sb->s_encoding, name, &qstr);
> here?

No, you are right.  In fact, it seems d_compare can't propagate errors
anyway as it is only compared against 0, anyway.

I spin the v2 dropping this bit as suggested.

thanks,

-- 
Gabriel Krisman Bertazi

