Return-Path: <linux-fsdevel+bounces-16038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A578972DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 16:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D345A1C26863
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 14:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8A114901F;
	Wed,  3 Apr 2024 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1WMBwuQg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1j4fSfPP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1642958203;
	Wed,  3 Apr 2024 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155208; cv=none; b=E7xvv8H4iH8AAW7YF+aN0e7VWKaim0PAENkxFqI6Vwg5RGAFmEDu23G52p1x2qwTOi1wNu/JPmjolX5bAbyfIhSnbX/7naYP7vUPOsu8CWXN7EPysR1fex5Eglq+8T0lQWV9m0uKuFvjJydgOxOPkIJ/oviTgarerU43jsO/CsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155208; c=relaxed/simple;
	bh=uKHh7k0GJP4j01baq9WegVjq8qw85xaG5tTV6U2NN20=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uSrBL4+biaYz4PHg/dBJGb+KmNtbTPCZuszbEEt6eUBT6XziYyitS4YOk/W71EJemugJd2eLSH8ZEVD9ZMxRHcLk6TO9odAwfmvzFX5KRN7IyQK+eCdceqGjPnScGykYXPcSeSvPwQVLXvpWbAOg3YfDHQAgkPxUUSaFJbP5ZVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1WMBwuQg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1j4fSfPP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 381865CDA1;
	Wed,  3 Apr 2024 14:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712155205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vg01ihmdMVYCcMWpiDO8wUezeruG1JoTh7eUEiDh8b0=;
	b=1WMBwuQgKWXff/t00TI4vFVa432ksxn76MjdXvNwvOEqlfev7LMCS6Jbd/0Fya7i/hOES1
	a1CJgDcQ6AvK1r7EGUvS7tk72YgfbmKDfmRHyVlZYQPOqX7NjsaNumL3ZfSuypxNvDMmXD
	p/R/48iIWZdH4MzxmQ8sg+i36IQi3Wo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712155205;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vg01ihmdMVYCcMWpiDO8wUezeruG1JoTh7eUEiDh8b0=;
	b=1j4fSfPPBkMW+IsWTbUTExt+0KmxtV9CIOp0hik5GPmobg+PelWQIGVwj3vxm8/yztIuPJ
	sC+C3te25NJAu0BA==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E867013357;
	Wed,  3 Apr 2024 14:40:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id p4ljMkRqDWagZAAAn2gu4w
	(envelope-from <krisman@suse.de>); Wed, 03 Apr 2024 14:40:04 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,  tytso@mit.edu,
  adilger.kernel@dilger.ca,  linux-ext4@vger.kernel.org,
  jaegeuk@kernel.org,  chao@kernel.org,
  linux-f2fs-devel@lists.sourceforge.net,  linux-fsdevel@vger.kernel.org,
  brauner@kernel.org,  jack@suse.cz,  linux-kernel@vger.kernel.org,
  viro@zeniv.linux.org.uk,  kernel@collabora.com,  Gabriel Krisman Bertazi
 <krisman@collabora.com>
Subject: Re: [f2fs-dev] [PATCH v15 6/9] ext4: Log error when lookup of
 encoded dentry fails
In-Reply-To: <20240403042231.GH2576@sol.localdomain> (Eric Biggers's message
	of "Tue, 2 Apr 2024 21:22:31 -0700")
Organization: SUSE
References: <20240402154842.508032-1-eugen.hristev@collabora.com>
	<20240402154842.508032-7-eugen.hristev@collabora.com>
	<20240403042231.GH2576@sol.localdomain>
Date: Wed, 03 Apr 2024 10:39:59 -0400
Message-ID: <8734s24iio.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.73 / 50.00];
	BAYES_HAM(-0.43)[78.40%];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo]
X-Spam-Score: -0.73
X-Spam-Level: 
X-Spam-Flag: NO

Eric Biggers <ebiggers@kernel.org> writes:

> On Tue, Apr 02, 2024 at 06:48:39PM +0300, Eugen Hristev via Linux-f2fs-devel wrote:
>> From: Gabriel Krisman Bertazi <krisman@collabora.com>
>> 

> I'm seeing this error when the volume is *not* in strict mode and a file has a
> name that is not valid UTF-8.  That doesn't seem to be working as
> intended.
>
>     mkfs.ext4 -F -O casefold /dev/vdb
>     mount /dev/vdb /mnt
>     mkdir /mnt/dir
>     chattr +F /mnt/dir
>     touch /mnt/dir/$'\xff'

Yes.  This should work without warnings.  When not in strict mode,
/mnt/dir/$'\xff' is just a valid filename which can only be
looked up with an exact-match name-under-lookup.

The issue is that we must propagate errors from utf8_strncasecmp in
generic_ci_match only if we are in strict mode.  If not on strict mode, we
need to return not-match on error.

-- 
Gabriel Krisman Bertazi

