Return-Path: <linux-fsdevel+bounces-10807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C8F84E7D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 19:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B9E1C241E1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 18:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F2D23769;
	Thu,  8 Feb 2024 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D8wF4yq8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kIfh3JVw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D8wF4yq8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kIfh3JVw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2C720335;
	Thu,  8 Feb 2024 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417781; cv=none; b=OK5GhLpanclBLyrzmj2c3PD8dO8Sexyu/MX0MFVoCOqhEgxZws2wbluiVwLpRSipIRpOf3En9h1JGIKRdPktqVL//jL+oUY/sYJidOlGrXi0Te9FEzkTeiv2x1bN9TWcOGg10q3wyto4Dd8tlmVVq3cueeGp1uBuswJBiUAxGUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417781; c=relaxed/simple;
	bh=ZW79UOB61sdCtxFs9rijrIwJ4eurUey1b1meP3mOTsM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t2zPAl+Zi3HeC2YuG1SLD8A8jSY/O9aXktvoGqu0agOF4oVQlSXrwH0Jfe6D1HontfOUbXOaRQ0xrjGMCTuPWI6B4XqVWjDRdzGpjIiyiJ1xbLsteHR/EzApdnP9CrCmpm/NjBK6EJecEdDSlaZsuZ34SM+pLT0ssPZpqzuW2E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D8wF4yq8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kIfh3JVw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D8wF4yq8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kIfh3JVw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 67B781FCFF;
	Thu,  8 Feb 2024 18:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707417776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rGFuTx22nZyt1Ef3qC80mJYAGVh7KhD1thhPxbHOGK4=;
	b=D8wF4yq8THXA1vsqQdCTE6uUX6rW7cNjgIgR8xhM/GZ16nCCoc+4e+x2fnssC1xsFlLgfF
	HHjFlL6QrUvFFXoYyDjoNcM3lhUUNhAVH3UHdm+OEdXovXxeP2KG1U4JLfbsQtmxZwgNPp
	6YvhSlyhufFeVADqNyyVpDRCme3XFkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707417776;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rGFuTx22nZyt1Ef3qC80mJYAGVh7KhD1thhPxbHOGK4=;
	b=kIfh3JVw0WDKSkwrxfijyXcmYm9rzJN0/q6AaQ+aGGaWL1ZonJma/1e/o4VEswAS70MnAa
	9rIYaC0cxoo0rZAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707417776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rGFuTx22nZyt1Ef3qC80mJYAGVh7KhD1thhPxbHOGK4=;
	b=D8wF4yq8THXA1vsqQdCTE6uUX6rW7cNjgIgR8xhM/GZ16nCCoc+4e+x2fnssC1xsFlLgfF
	HHjFlL6QrUvFFXoYyDjoNcM3lhUUNhAVH3UHdm+OEdXovXxeP2KG1U4JLfbsQtmxZwgNPp
	6YvhSlyhufFeVADqNyyVpDRCme3XFkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707417776;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rGFuTx22nZyt1Ef3qC80mJYAGVh7KhD1thhPxbHOGK4=;
	b=kIfh3JVw0WDKSkwrxfijyXcmYm9rzJN0/q6AaQ+aGGaWL1ZonJma/1e/o4VEswAS70MnAa
	9rIYaC0cxoo0rZAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24A1D1326D;
	Thu,  8 Feb 2024 18:42:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bIXQArAgxWWqMgAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 08 Feb 2024 18:42:56 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu,  adilger.kernel@dilger.ca,  jaegeuk@kernel.org,
  chao@kernel.org,  viro@zeniv.linux.org.uk,  brauner@kernel.org,
  linux-ext4@vger.kernel.org,  linux-f2fs-devel@lists.sourceforge.net,
  jack@suse.cz,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  kernel@collabora.com,  Gabriel Krisman
 Bertazi <krisman@collabora.com>
Subject: Re: [RESEND PATCH v9 2/3] ext4: Reuse generic_ci_match for ci
 comparisons
In-Reply-To: <20240208064334.268216-3-eugen.hristev@collabora.com> (Eugen
	Hristev's message of "Thu, 8 Feb 2024 08:43:33 +0200")
References: <20240208064334.268216-1-eugen.hristev@collabora.com>
	<20240208064334.268216-3-eugen.hristev@collabora.com>
Date: Thu, 08 Feb 2024 13:42:54 -0500
Message-ID: <87plx6vlu9.fsf@mailhost.krisman.be>
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
X-Spam-Score: -1.31
X-Spamd-Result: default: False [-1.31 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.01)[46.77%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

Eugen Hristev <eugen.hristev@collabora.com> writes:

>  int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
>  				  struct ext4_filename *name)
>  {
> @@ -1503,20 +1451,35 @@ static bool ext4_match(struct inode *parent,
>  #if IS_ENABLED(CONFIG_UNICODE)
>  	if (IS_CASEFOLDED(parent) &&
>  	    (!IS_ENCRYPTED(parent) || fscrypt_has_encryption_key(parent))) {
> -		if (fname->cf_name.name) {
> -			if (IS_ENCRYPTED(parent)) {
> -				if (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
> -					fname->hinfo.minor_hash !=
> -						EXT4_DIRENT_MINOR_HASH(de)) {
> +		int ret;
>  
> -					return false;
> -				}
> -			}
> -			return !ext4_ci_compare(parent, &fname->cf_name,
> -						de->name, de->name_len, true);
> +		/*
> +		 * Just checking IS_ENCRYPTED(parent) below is not
> +		 * sufficient to decide whether one can use the hash for
> +		 * skipping the string comparison, because the key might
> +		 * have been added right after
> +		 * ext4_fname_setup_ci_filename().  In this case, a hash
> +		 * mismatch will be a false negative.  Therefore, make
> +		 * sure cf_name was properly initialized before
> +		 * considering the calculated hash.
> +		 */
> +		if (IS_ENCRYPTED(parent) && fname->cf_name.name &&
> +		    (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
> +		     fname->hinfo.minor_hash != EXT4_DIRENT_MINOR_HASH(de)))
> +			return false;
> +
> +		ret = generic_ci_match(parent, fname->usr_fname,
> +				       &fname->cf_name, de->name,
> +				       de->name_len);
> +		if (ret < 0) {
> +			/*
> +			 * Treat comparison errors as not a match.  The
> +			 * only case where it happens is on a disk
> +			 * corruption or ENOMEM.
> +			 */
> +			return false;

A minor problem with splitting the series as you did is that "ext4: Log
error when lookup of encoded dentry fails" conflicts with this change
and you get a merge conflict if it is applied in the wrong order.

-- 
Gabriel Krisman Bertazi

