Return-Path: <linux-fsdevel+bounces-8988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2550183C937
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 18:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4992F1C2496D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEC914198C;
	Thu, 25 Jan 2024 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZN6cYtR+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yzXOPLtF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZN6cYtR+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yzXOPLtF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB62140777;
	Thu, 25 Jan 2024 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201707; cv=none; b=VGrBagA8INiodAYvBV+/DT0Txgxg0K2LeN64vCm8ccdDBdGtWhnXDfvXHaqFX31wNnwUnkz9ZJ+ZnLwUl3avjDR+u8sWOC0s4AsIb1c870q6CQYRkioYNtggfKRSE4PgSAC71uFBPUy3QtP2t+k4PYAF23PSts60hnz3wIGLjB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201707; c=relaxed/simple;
	bh=VXT9oJ9eK9Oh90OfJPvx0TF2pq2TYs7We+ExcqrDEaE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZQpagAGbWN1QDCObkjJUW3tG0iuaAbKc/O6ZfVef0NkoUz7mKxCRm1JEANHPoeHKle/opAiF9vEYvQPy0lbcqM2O2pmoazpmma0gFVvqVhsy6P8HakAb40HvpWiZJSHaZubuuRys/UtEUjfRloXQPsaE04ATrQTUVWeEpqoN6M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZN6cYtR+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yzXOPLtF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZN6cYtR+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yzXOPLtF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B33B71F8AB;
	Thu, 25 Jan 2024 16:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706201703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MqyFwT/zF35b3QEIc+pC02CwmxeyFqwYPps3QzTYVw4=;
	b=ZN6cYtR+uVMFCmxJ2DYwzWhKfe2BVsc2IHcvHk/edLcSia7gmN76vOX3FtbNOGJF45uxlE
	ouQg9ygNmKrOj7QCpCdmdOIQI/O/phFk/1jphpvhWwfUiTm6/4rUy6TlAfwU8H7VY68b1w
	jZWZeRBms9nAqkPwvHnn11pLJgiYHK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706201703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MqyFwT/zF35b3QEIc+pC02CwmxeyFqwYPps3QzTYVw4=;
	b=yzXOPLtF4FhYk84PWdhMgoMRbh1X73RvUIYnIYAC5S//8C1S3Tn3+CxuuUe6Xds0BAWHUq
	ixpCU8TM6kG32MAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706201703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MqyFwT/zF35b3QEIc+pC02CwmxeyFqwYPps3QzTYVw4=;
	b=ZN6cYtR+uVMFCmxJ2DYwzWhKfe2BVsc2IHcvHk/edLcSia7gmN76vOX3FtbNOGJF45uxlE
	ouQg9ygNmKrOj7QCpCdmdOIQI/O/phFk/1jphpvhWwfUiTm6/4rUy6TlAfwU8H7VY68b1w
	jZWZeRBms9nAqkPwvHnn11pLJgiYHK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706201703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MqyFwT/zF35b3QEIc+pC02CwmxeyFqwYPps3QzTYVw4=;
	b=yzXOPLtF4FhYk84PWdhMgoMRbh1X73RvUIYnIYAC5S//8C1S3Tn3+CxuuUe6Xds0BAWHUq
	ixpCU8TM6kG32MAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DB83134C3;
	Thu, 25 Jan 2024 16:55:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZdLPNWaSsmX1AwAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 25 Jan 2024 16:55:02 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: viro@zeniv.linux.org.uk,  jaegeuk@kernel.org,  tytso@mit.edu,
  linux-ext4@vger.kernel.org,  linux-f2fs-devel@lists.sourceforge.net,
  linux-fsdevel@vger.kernel.org,  amir73il@gmail.com
Subject: Re: [PATCH v3 01/10] ovl: Reject mounting case-insensitive filesystems
In-Reply-To: <20240125025115.GA52073@sol.localdomain> (Eric Biggers's message
	of "Wed, 24 Jan 2024 18:51:15 -0800")
Organization: SUSE
References: <20240119184742.31088-1-krisman@suse.de>
	<20240119184742.31088-2-krisman@suse.de>
	<20240125025115.GA52073@sol.localdomain>
Date: Thu, 25 Jan 2024 13:55:00 -0300
Message-ID: <87jznxs68r.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZN6cYtR+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yzXOPLtF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.04 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,mit.edu,vger.kernel.org,lists.sourceforge.net,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.53)[80.60%]
X-Spam-Score: -2.04
X-Rspamd-Queue-Id: B33B71F8AB
X-Spam-Flag: NO

Eric Biggers <ebiggers@kernel.org> writes:

> On Fri, Jan 19, 2024 at 03:47:33PM -0300, Gabriel Krisman Bertazi wrote:
>> ovl: Reject mounting case-insensitive filesystems
>
> Overlayfs doesn't mount filesystems.  I think you might mean something like
> reject case-insensitive lowerdirs?

uppers and workdir too. I'd make this:

  "ovl: Reject mounting over case-insensitive filesystems"

>
>> +	/*
>> +	 * Root dentries of case-insensitive filesystems might not have
>> +	 * the dentry operations set, but still be incompatible with
>> +	 * overlayfs.  Check explicitly to prevent post-mount failures.
>> +	 */
>> +	if (sb_has_encoding(path->mnt->mnt_sb))
>> +		return invalfc(fc, "case-insensitive filesystem on %s not supported", name);
>
> sb_has_encoding() doesn't mean that the filesystem is case-insensitive.  It
> means that the filesystem supports individual case-insensitive
> directories.
>
> With that in mind, is this code still working as intended?
>

Yes, it is. In particular, after the rest of the patchset, any dentry
will be weird and lookups will throw -EREMOTE.

> If so, can you update the comment and error message accordingly?

I'm not sure how to change and still make it readable by users.  How about:

  return invalfc(fc, "case-insensitive capable filesystem on %s not supported", name);

what do you think?

-- 
Gabriel Krisman Bertazi

