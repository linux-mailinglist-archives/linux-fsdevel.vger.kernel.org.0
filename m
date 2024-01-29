Return-Path: <linux-fsdevel+bounces-9432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E226584138E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 20:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955791F27AD9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 19:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF9760ECF;
	Mon, 29 Jan 2024 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Akdljbtn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SRLQhXt3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WkNFisM6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t5FAcg/7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE84948790;
	Mon, 29 Jan 2024 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556855; cv=none; b=JRfxduaWuJrE8IAwFuj4x+9Ah5V3MWgcOnEBt2THY9oTXGVFB6Jq5F47S3LRe2/qsBM65dN1l/uMkXlxP7VbV4xqG+jztlTyjoOBuhwpHEPHbAHW8FsoATg68T/iD0FHCHmEPSp/06t/SaUvzDpRFd8a3kcFi9vvCqcO0TFQoiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556855; c=relaxed/simple;
	bh=uHM5m2K+Q/d8fvb+2LX/cQgLqj6Atsg102NmIArIBUQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g/8YqpcjlrCaypZVLaC1ghDowCk3Pc4t9tmKevXJU+4S3DBo/BqHASVoeHLXpmqv1OPhAO16eQrR3FHJJlGbyKHqUXdO10qC+uZa/sYdG9rj4gRzPzLh7gaDQNTMDO+nuh5qz7OE6zN+nE6BQ71jKIjFWS8dVxqKuDUNehWDy88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Akdljbtn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SRLQhXt3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WkNFisM6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t5FAcg/7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB74A1F804;
	Mon, 29 Jan 2024 19:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706556851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OKQR5gl8Z8oP7RS5Lte3WVwl5Sgn5t9EAu+p+g9JCHs=;
	b=Akdljbtn+F93q9XccTDO0Lr/Xh7tqJkwWJDtW0bqAGII9RD9cQA0gKip5uOQ9NG9p9VgXa
	6EzIRQ9nUwsAWKs0K/CYZQRU6Mye6EY5ZERlaegAYcm3noPDsDRIlUfX+uYwzjspMJhtL4
	UAtLQz/pROzwSPbEbQkSlVKq5evXzUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706556851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OKQR5gl8Z8oP7RS5Lte3WVwl5Sgn5t9EAu+p+g9JCHs=;
	b=SRLQhXt36qU0Qn/7dGzH033vFIufR8Dc08GWj2lS8xYmSkhF2//42gBAFjOKMLSl09HovF
	Wy7SE0jAQEEJo+DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706556850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OKQR5gl8Z8oP7RS5Lte3WVwl5Sgn5t9EAu+p+g9JCHs=;
	b=WkNFisM6pCijBZtZpRAOSWgcOdAoa3Awt9MJVTg4BTCcNZAMy7fhuBBM9GBKseoeXH50Yn
	FixiX75q/F10zpdnkx/YvAjLr/T8IoND0S3PiAUFwillO81LQDNffKr9HZ7Y5juIA70AL4
	VkItiClDIPcynZKxhRbmNuzLQZNRw2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706556850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OKQR5gl8Z8oP7RS5Lte3WVwl5Sgn5t9EAu+p+g9JCHs=;
	b=t5FAcg/7BbqBPNoSmmVOUL1IJTyZv6Nb1gDjGcM7hds4ZFAjRIBroTsdu5VPHY3QOXDFl9
	YizM3mCMpbFicmCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DC6B13647;
	Mon, 29 Jan 2024 19:34:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FcSFOLH9t2W4fQAAD6G6ig
	(envelope-from <krisman@suse.de>); Mon, 29 Jan 2024 19:34:09 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: viro@zeniv.linux.org.uk,  jaegeuk@kernel.org,  tytso@mit.edu,
  linux-ext4@vger.kernel.org,  linux-f2fs-devel@lists.sourceforge.net,
  linux-fsdevel@vger.kernel.org,  amir73il@gmail.com
Subject: Re: [PATCH v3 04/10] fscrypt: Drop d_revalidate once the key is added
In-Reply-To: <20240127071742.GE11935@sol.localdomain> (Eric Biggers's message
	of "Fri, 26 Jan 2024 23:17:42 -0800")
Organization: SUSE
References: <20240119184742.31088-1-krisman@suse.de>
	<20240119184742.31088-5-krisman@suse.de>
	<20240125031251.GC52073@sol.localdomain>
	<875xzhxizb.fsf@mailhost.krisman.be>
	<20240127071742.GE11935@sol.localdomain>
Date: Mon, 29 Jan 2024 16:34:07 -0300
Message-ID: <87zfwo2ats.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
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
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,mit.edu,vger.kernel.org,lists.sourceforge.net,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[34.53%]
X-Spam-Flag: NO

Eric Biggers <ebiggers@kernel.org> writes:

> On Thu, Jan 25, 2024 at 05:20:56PM -0300, Gabriel Krisman Bertazi wrote:
>> Eric Biggers <ebiggers@kernel.org> writes:
>> 
>> > On Fri, Jan 19, 2024 at 03:47:36PM -0300, Gabriel Krisman Bertazi wrote:
>> >> /*
>> >>  * When d_splice_alias() moves a directory's no-key alias to its plaintext alias
>> >>  * as a result of the encryption key being added, DCACHE_NOKEY_NAME must be
>> >>  * cleared.  Note that we don't have to support arbitrary moves of this flag
>> >>  * because fscrypt doesn't allow no-key names to be the source or target of a
>> >>  * rename().
>> >>  */
>> >>  static inline void fscrypt_handle_d_move(struct dentry *dentry)
>> >>  {
>> >>  	dentry->d_flags &= ~DCACHE_NOKEY_NAME;
>> >> +
>> >> +	/*
>> >> +	 * Save the d_revalidate call cost during VFS operations.  We
>> >> +	 * can do it because, when the key is available, the dentry
>> >> +	 * can't go stale and the key won't go away without eviction.
>> >> +	 */
>> >> +	if (dentry->d_op && dentry->d_op->d_revalidate == fscrypt_d_revalidate)
>> >> +		dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
>> >>  }
>> >
>> > Is there any way to optimize this further for the case where fscrypt is not
>> > being used?  This is called unconditionally from d_move().  I've generally been
>> > trying to avoid things like this where the fscrypt support slows things down for
>> > everyone even when they're not using the feature.
>> 
>> The problem would be figuring out whether the filesystem has fscrypt
>> enabled.  I think we can rely on sb->s_cop always being set:
>> 
>> if (sb->s_cop)
>>    fscrypt_handle_d_move(dentry);
>> 
>> What do you think?
>
> That's better, I just wonder if there's an even better way.  Do you need to do
> this for dentries that don't have DCACHE_NOKEY_NAME set?  If not, it would be
> more efficient to test for DCACHE_NOKEY_NAME before clearing the flags.

I like that.  We don't need it for dentries without DCACHE_NOKEY_NAME,
because those dentries have the d_revalidate disabled at lookup-time.

I raced my v4 with your comment, but I'll spin a v5 folding in this
suggestion shortly.

-- 
Gabriel Krisman Bertazi

