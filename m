Return-Path: <linux-fsdevel+bounces-39415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F363A13DE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 16:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97D7B163585
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 15:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EF622BAB3;
	Thu, 16 Jan 2025 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="j3YRDj3r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F45D1DDC12;
	Thu, 16 Jan 2025 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041941; cv=none; b=TCaPg6wdG1ZcXC+LZ9q+kEzLfVOPwjHcGoEP82DzRjS3DH8Cnr6yL7wPJ+xkAVU12FQR+gYwuKLPdP1vSrSAMZkjL0efk4/fNAY0YTyCQghoaDNOszyLlm8N7RICTs/5WHXLpwBx40399Y14GgnAnyMqOtr552MOYRM1kFAvNJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041941; c=relaxed/simple;
	bh=awwHzI1Z1/x3HyInkRgOMr1h572tgiAEaGwaKELzOdM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gak/VnRsC7oZ3dWiBJaJZAS/Bhd4OmqiUoV1KefJ6ENq0Ntg0M/2QWeYxFkZzLc6OZdElMxSFsYb4f/MFmpqnzCLc0iy0CoZbWwYOf9knFOggtIqISoYk/llvQa2QAOC0zW8J7z4Ih6GWKdSSeZHwH8em4SpbfbQvbwXBv19AkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=j3YRDj3r; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8340AFF808;
	Thu, 16 Jan 2025 15:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1737041936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MmKv0Rf0wv9cIc2vKkICHbEQe1aK7ETgo4BrVAmd2x0=;
	b=j3YRDj3reFI7El+9v37BTiRXv413bpugh7FunWxxPAHgmjxv7JhhtJ1h5tEF2v7xku2jMJ
	K43/F515o4G4keeEPTl5opN2ki8kfw8YFOA9yQpUU9Z0JRBpILmjvqivrBv76NoVNvpX3Q
	yRNNInjP7+i4yyAxaZ1Be4d96Z2iVnnl/dXZQ3rS19d1/VtLWm7MT8lNOQIehMJfD6J7ie
	Lt6UHqtoPGfEKLw36oAzZXM7RAD1GqsnvniRjpvjV5lI/pdCxn6HRIbQxK9TEpRMGH0n9H
	kUA2x8DtxPTHjzBgXfocZAMfE4JBfj/Ji/NSYvGQzODuHtNWCJVxiYePHB4rbg==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,  agruenba@redhat.com,
  amir73il@gmail.com,  brauner@kernel.org,  ceph-devel@vger.kernel.org,
  dhowells@redhat.com,  hubcap@omnibond.com,  jack@suse.cz,
  linux-nfs@vger.kernel.org,  miklos@szeredi.hu,
  torvalds@linux-foundation.org
Subject: Re: [PATCH v2 06/20] generic_ci_d_compare(): use shortname_storage
In-Reply-To: <20250116052317.485356-6-viro@zeniv.linux.org.uk> (Al Viro's
	message of "Thu, 16 Jan 2025 05:23:03 +0000")
References: <20250116052103.GF1977892@ZenIV>
	<20250116052317.485356-1-viro@zeniv.linux.org.uk>
	<20250116052317.485356-6-viro@zeniv.linux.org.uk>
Date: Thu, 16 Jan 2025 10:38:53 -0500
Message-ID: <87cygmlqeq.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gabriel@krisman.be

Al Viro <viro@zeniv.linux.org.uk> writes:

> ... and check the "name might be unstable" predicate
> the right way.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/libfs.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 748ac5923154..3ad1b1b7fed6 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1789,7 +1789,7 @@ int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
>  {
>  	const struct dentry *parent;
>  	const struct inode *dir;
> -	char strbuf[DNAME_INLINE_LEN];
> +	union shortname_store strbuf;
>  	struct qstr qstr;
>  
>  	/*
> @@ -1809,22 +1809,23 @@ int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
>  	if (!dir || !IS_CASEFOLDED(dir))
>  		return 1;
>  
> +	qstr.len = len;
> +	qstr.name = str;
>  	/*
>  	 * If the dentry name is stored in-line, then it may be concurrently
>  	 * modified by a rename.  If this happens, the VFS will eventually retry
>  	 * the lookup, so it doesn't matter what ->d_compare() returns.
>  	 * However, it's unsafe to call utf8_strncasecmp() with an unstable
>  	 * string.  Therefore, we have to copy the name into a temporary buffer.

This part of the comment needs updating since there is no more copying.

> +	 * As above, len is guaranteed to match str, so the shortname case
> +	 * is exactly when str points to ->d_shortname.
>  	 */
> -	if (len <= DNAME_INLINE_LEN - 1) {
> -		memcpy(strbuf, str, len);
> -		strbuf[len] = 0;
> -		str = strbuf;
> +	if (qstr.name == dentry->d_shortname.string) {
> +		strbuf = dentry->d_shortname; // NUL is guaranteed to be in there
> +		qstr.name = strbuf.string;
>  		/* prevent compiler from optimizing out the temporary buffer */
>  		barrier();

If I read the code correctly, I admit I don't understand how this
guarantees the stability.  Aren't you just assigning qstr.name back the
same value it had in case of an inlined name through a bounce pointer?
The previous implementation made sense to me, since the memcpy only
accessed each character once, and we guaranteed the terminating
character explicitly, but I'm having a hard time with this version.

>  	}
> -	qstr.len = len;
> -	qstr.name = str;
>  
>  	return utf8_strncasecmp(dentry->d_sb->s_encoding, name, &qstr);
>  }

-- 
Gabriel Krisman Bertazi

