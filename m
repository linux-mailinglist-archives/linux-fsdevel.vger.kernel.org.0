Return-Path: <linux-fsdevel+bounces-8262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C9E831CB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 16:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0946F283CE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 15:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1403286B1;
	Thu, 18 Jan 2024 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tIZf8BT9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G+ja1URl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tIZf8BT9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G+ja1URl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8D52575C
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705592554; cv=none; b=tvHira9tTubpEgLjebgpIRi1i+zsVuu6KJWPTpelqnu/IJMrrgHIPhg3XyEwEEotc8npFoZVnaeOZ4K60h4agMDKfhXxiiS2BKyVmsGmSS6tSJBJKOggU9+zB6+Zh0ErTarW0p82nkqv5iS+lXn3q6JaFN6ku+8y473n7LgWciw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705592554; c=relaxed/simple;
	bh=sL+Vw7htqrL5OslK+O02PRzCUVsusw3xzU3Q/Bd/yJA=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:In-Reply-To:
	 Organization:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Spamd-Result:X-Rspamd-Server:X-Spam-Score:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Spam-Flag:X-Spamd-Bar; b=aYrpOZWeGFEY0Ep2/zT7HjaAUpHBOmJ4zhSfO5PvESaoLH5oyELHE+jKVuw8QVKCZoJY68VdKn2K+Uorm3qivaIr0d3eOjNoEN3iL4a3DuNX5D86pLb2V7dLAm2PtvH/Sul8pbY6ep0Oh49an8CGYOgh7WbOHGrl2xYqR4DScG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tIZf8BT9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G+ja1URl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tIZf8BT9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G+ja1URl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A57B41FCF4;
	Thu, 18 Jan 2024 15:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705592550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cDqxxn8VLKLk1x+l41hgZ7+oPsz6/W34y7vwEDgoveM=;
	b=tIZf8BT9if96EB+4lMqGz2XlFe/n7UnaLj6S5/wNwJmbeyn8OLM54hf8IOowntmslpTbzq
	P3X5l161MQrAOmiSBeLZHyg5G4ieeksagRkA4dlC0NbKy+nJbHsOmiN2N3zW3Y6ydiWS5Q
	yplNNsWwLs7S56olW9gvHx1FWF+hHA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705592550;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cDqxxn8VLKLk1x+l41hgZ7+oPsz6/W34y7vwEDgoveM=;
	b=G+ja1URl1b74I5d9B1JNEhi9+RXpbp8KXD2Xvs834xsc+Lars+ZM9A3WjRbo3TDCxsEx+q
	ahLJTbgOTroAVvCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705592550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cDqxxn8VLKLk1x+l41hgZ7+oPsz6/W34y7vwEDgoveM=;
	b=tIZf8BT9if96EB+4lMqGz2XlFe/n7UnaLj6S5/wNwJmbeyn8OLM54hf8IOowntmslpTbzq
	P3X5l161MQrAOmiSBeLZHyg5G4ieeksagRkA4dlC0NbKy+nJbHsOmiN2N3zW3Y6ydiWS5Q
	yplNNsWwLs7S56olW9gvHx1FWF+hHA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705592550;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cDqxxn8VLKLk1x+l41hgZ7+oPsz6/W34y7vwEDgoveM=;
	b=G+ja1URl1b74I5d9B1JNEhi9+RXpbp8KXD2Xvs834xsc+Lars+ZM9A3WjRbo3TDCxsEx+q
	ahLJTbgOTroAVvCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 331F313874;
	Thu, 18 Jan 2024 15:42:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oBXxOuVGqWU0NAAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 18 Jan 2024 15:42:29 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: tytso@mit.edu,  linux-fsdevel@vger.kernel.org,  viro@zeniv.linux.org.uk,
  jaegeuk@kernel.org,  Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] libfs: Attempt exact-match comparison first during
 casefold lookup
In-Reply-To: <20240118035053.GB1103@sol.localdomain> (Eric Biggers's message
	of "Wed, 17 Jan 2024 19:50:53 -0800")
Organization: SUSE
References: <20240118004618.19707-1-krisman@suse.de>
	<20240118035053.GB1103@sol.localdomain>
Date: Thu, 18 Jan 2024 12:42:27 -0300
Message-ID: <8734uufy1o.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tIZf8BT9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=G+ja1URl
X-Spamd-Result: default: False [-0.33 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[53.64%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.33
X-Rspamd-Queue-Id: A57B41FCF4
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

Eric Biggers <ebiggers@kernel.org> writes:

> On Wed, Jan 17, 2024 at 09:46:18PM -0300, Gabriel Krisman Bertazi wrote:
>> Note that, for strict mode, generic_ci_d_compare used to reject an
>> invalid UTF-8 string, which would now be considered valid if it
>> exact-matches the disk-name.  But, if that is the case, the filesystem
>> is corrupt.  More than that, it really doesn't matter in practice,
>> because the name-under-lookup will have already been rejected by
>> generic_ci_d_hash and we won't even get here.
>
> Can you make the code comment explain this, please?

will do, once we settle the other discussion about this point.
>
>> +	/*
>> +	 * Attempt a case-sensitive match first. It is cheaper and
>> +	 * should cover most lookups, including all the sane
>> +	 * applications that expect a case-sensitive filesystem.
>> +	 */
>> +	if (len == name->len && !memcmp(str, name->name, len))
>> +		return 0;
>
> Is the memcmp() safe, considering that the 'str' can be concurrently
> modified?

You wrote quite a bit of the data race documentation, so you definitely
know better.

But I don't see how this could be a problem.  the str pointer itself
can't change since it's already a copy of the dentry->d_name pointer; if
the string is external, it is guaranteed to exist until the end of the
lookup; Finally, If it's inlined, the string can change concurrently
which, in the worst case scenario, gives us a false result. But then,
VFS will retry, like we do for the case-insensitive comparison right
below.

..Right? :)

-- 
Gabriel Krisman Bertazi

