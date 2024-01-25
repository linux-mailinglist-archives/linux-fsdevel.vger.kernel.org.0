Return-Path: <linux-fsdevel+bounces-9006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CB383CD52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 21:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 404EAB240FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 20:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C642F137C2C;
	Thu, 25 Jan 2024 20:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DyQyYBbt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zE+tHEoS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M2SBXYyM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dkupbRlf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C222A13666B;
	Thu, 25 Jan 2024 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706214063; cv=none; b=nypA05boMJoICK+PmjwXP+bnYJ8gsAP+FrRDjEHEXxb5yvrq/cCSwjxW0UCUlucxPbPVQU3bg5iq/pU0jliyxiAaUVZ4SQ1OrAbVM2j15qgnvh+NWnmyjUr1muthCRY1fEDnGMj/eDBc76ffPRtzj9aX40gRe70c4HqCPnZLWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706214063; c=relaxed/simple;
	bh=rbRZxa6LFDBopRM/ciECMXMrl/A74NTxTRwa3hwp9tc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M7vWm3YP1n42jm6FXo3AD/RbMBKuXFkSIo9gLay2tnpKv/AvIlXwQa5NtV3G3HRGzPy1+45ADU5q4buIP/BoH39VhigDfOUZlnLQ2d1lKY5AFZ5MeA5hQM2xYPn6Q2IvcgvpQuQi338E09pYpe+1IY27Wi6OxWoLZfEPbmXrDpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DyQyYBbt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zE+tHEoS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M2SBXYyM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dkupbRlf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E5A281F8C0;
	Thu, 25 Jan 2024 20:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706214060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8bFRvUiQ4Ykyi+6Nv/iNNF89mabY21hkYIXwk/h2jKk=;
	b=DyQyYBbtPHSAT6EYfoylG0h4g3LW7fy2UMngStybNtploSj1qFdKOaKk1dTBtcVy9ZYZL4
	QEizUNfia+r4OlZRhRgd7N+Z2/jMQX6MVe5riaapjzy6eKm8DtUXX6C+sNjoZHz5L2qC/P
	1JaytiF53PdApXimLVY3XgDrynIzfjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706214060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8bFRvUiQ4Ykyi+6Nv/iNNF89mabY21hkYIXwk/h2jKk=;
	b=zE+tHEoSuY9QGq1Y+mG8ChBZFLE/zNUn2E3RJhVgs5c7fowwBaxmrVpZzGqttVAoNja3AO
	gMKfgSmd6Y6V/uCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706214059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8bFRvUiQ4Ykyi+6Nv/iNNF89mabY21hkYIXwk/h2jKk=;
	b=M2SBXYyMQOu98RHsKRH0L/fsmPdh3rjWLh/3fpu9yKwFEwab16deD3s3optPyNalukdJUP
	QHtDjm0hPB5cv0rQE85BxDnNXkdqgFaf+NZp+uLnGDrdXovQvXtiSrCzorlO80r9e0/Uos
	eLbgfmgQ3tIo2X43LONDpXlPpXfgIGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706214059;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8bFRvUiQ4Ykyi+6Nv/iNNF89mabY21hkYIXwk/h2jKk=;
	b=dkupbRlfT2sT3mO1Yw10H5b2WZbnk84rVxKbt8/1jpe8fFuM3vJlwWbumuXxojiiXbEx07
	6XcNf8y99svsQTDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 486FE13649;
	Thu, 25 Jan 2024 20:20:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HGBVAKvCsmWcPQAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 25 Jan 2024 20:20:58 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: viro@zeniv.linux.org.uk,  jaegeuk@kernel.org,  tytso@mit.edu,
  linux-ext4@vger.kernel.org,  linux-f2fs-devel@lists.sourceforge.net,
  linux-fsdevel@vger.kernel.org,  amir73il@gmail.com
Subject: Re: [PATCH v3 04/10] fscrypt: Drop d_revalidate once the key is added
In-Reply-To: <20240125031251.GC52073@sol.localdomain> (Eric Biggers's message
	of "Wed, 24 Jan 2024 19:12:51 -0800")
Organization: SUSE
References: <20240119184742.31088-1-krisman@suse.de>
	<20240119184742.31088-5-krisman@suse.de>
	<20240125031251.GC52073@sol.localdomain>
Date: Thu, 25 Jan 2024 17:20:56 -0300
Message-ID: <875xzhxizb.fsf@mailhost.krisman.be>
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
X-Spamd-Result: default: False [-0.12 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,mit.edu,vger.kernel.org,lists.sourceforge.net,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[53.38%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.12

Eric Biggers <ebiggers@kernel.org> writes:

> On Fri, Jan 19, 2024 at 03:47:36PM -0300, Gabriel Krisman Bertazi wrote:
>> /*
>>  * When d_splice_alias() moves a directory's no-key alias to its plaintext alias
>>  * as a result of the encryption key being added, DCACHE_NOKEY_NAME must be
>>  * cleared.  Note that we don't have to support arbitrary moves of this flag
>>  * because fscrypt doesn't allow no-key names to be the source or target of a
>>  * rename().
>>  */
>>  static inline void fscrypt_handle_d_move(struct dentry *dentry)
>>  {
>>  	dentry->d_flags &= ~DCACHE_NOKEY_NAME;
>> +
>> +	/*
>> +	 * Save the d_revalidate call cost during VFS operations.  We
>> +	 * can do it because, when the key is available, the dentry
>> +	 * can't go stale and the key won't go away without eviction.
>> +	 */
>> +	if (dentry->d_op && dentry->d_op->d_revalidate == fscrypt_d_revalidate)
>> +		dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
>>  }
>
> Is there any way to optimize this further for the case where fscrypt is not
> being used?  This is called unconditionally from d_move().  I've generally been
> trying to avoid things like this where the fscrypt support slows things down for
> everyone even when they're not using the feature.

The problem would be figuring out whether the filesystem has fscrypt
enabled.  I think we can rely on sb->s_cop always being set:

if (sb->s_cop)
   fscrypt_handle_d_move(dentry);

What do you think?

-- 
Gabriel Krisman Bertazi

