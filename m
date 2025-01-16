Return-Path: <linux-fsdevel+bounces-39418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0C5A13E46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 16:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1BF07A3292
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 15:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CBC22CA1C;
	Thu, 16 Jan 2025 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="pZy4nGvj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2D122C9F1;
	Thu, 16 Jan 2025 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042812; cv=none; b=D+oe9XC/7LwOGsow0XflnnoBGeqliA0pM+SghDWJihb0/FNaI7ootO9Hp2EOTpmtXgnFcdC9ToMYmNkwR1JSeFV1hfDT8N8/VOD5XgXNk+/1jFEwMZu6RspLQIu0BnqA3XZz+mSu7Ly/heW5xIk9qnS/VhZFrcWnf1JQU/9xpdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042812; c=relaxed/simple;
	bh=qr+2uK1/s+XKKcmkTzU+RHEUk1jmYNh6Yl1nIwx90x4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FtTTqWzLGdraHdHtNf8eZITGLh4kq/OENRt06Td95jlX8d8k8JzILHcUrRaftUxOgKLkH/5sdCZcXt/f4o8Ch0OzEw3EPX2m/+/SPe6y1BmQLIHzq4Chj5wKOpyd2uu8USV4oeLgzVC4OtWrq3MPh841/cD6kSRIMUF+Fx4A4JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=pZy4nGvj; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F829E0006;
	Thu, 16 Jan 2025 15:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1737042802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6jkeeydjqGAJ/hShZOm5IhOEBgZfUdmZJvp6cGQBREw=;
	b=pZy4nGvjonJkVzJIBiHsG48HKoQsR226QtoJYpxdpPj8BCqaehEPeLg7wFV0R86my7GDz1
	SFlVGS/PgiTlZyaheQGmb+XrZ0Tx+uxSAUTyDorKPSPrhC+wAlNs8S2lWNaXGcd2F7VtuB
	BcXLTi18aiBp5AGpRv8Xd+gNgz0jGXvXUxZuwrGpal7tLa0e7dTim84ItnIpN8rB+4IA/0
	7QR/IsR2QwFoaBcD4mJspuCSaWwajBL+nT+CG0ATlbpnuGJ+7EEK83Kbpoo862p48ypZro
	L8YQhFRssPnshT1m2zZRYWoPDGNyJePTLj/EVq26MX77JnWk0CxaGYjcWD9MgA==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,  agruenba@redhat.com,
  amir73il@gmail.com,  brauner@kernel.org,  ceph-devel@vger.kernel.org,
  dhowells@redhat.com,  hubcap@omnibond.com,  jack@suse.cz,
  linux-nfs@vger.kernel.org,  miklos@szeredi.hu,
  torvalds@linux-foundation.org
Subject: Re: [PATCH v2 06/20] generic_ci_d_compare(): use shortname_storage
In-Reply-To: <20250116154625.GG1977892@ZenIV> (Al Viro's message of "Thu, 16
	Jan 2025 15:46:25 +0000")
References: <20250116052103.GF1977892@ZenIV>
	<20250116052317.485356-1-viro@zeniv.linux.org.uk>
	<20250116052317.485356-6-viro@zeniv.linux.org.uk>
	<87cygmlqeq.fsf@mailhost.krisman.be> <20250116154625.GG1977892@ZenIV>
Date: Thu, 16 Jan 2025 10:53:18 -0500
Message-ID: <878qralpqp.fsf@mailhost.krisman.be>
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

> On Thu, Jan 16, 2025 at 10:38:53AM -0500, Gabriel Krisman Bertazi wrote:
>> >  	 * If the dentry name is stored in-line, then it may be concurrently
>> >  	 * modified by a rename.  If this happens, the VFS will eventually retry
>> >  	 * the lookup, so it doesn't matter what ->d_compare() returns.
>> >  	 * However, it's unsafe to call utf8_strncasecmp() with an unstable
>> >  	 * string.  Therefore, we have to copy the name into a temporary buffer.
>> 
>> This part of the comment needs updating since there is no more copying.
>> 
>> > +	 * As above, len is guaranteed to match str, so the shortname case
>> > +	 * is exactly when str points to ->d_shortname.
>> >  	 */
>> > -	if (len <= DNAME_INLINE_LEN - 1) {
>> > -		memcpy(strbuf, str, len);
>> > -		strbuf[len] = 0;
>> > -		str = strbuf;
>> > +	if (qstr.name == dentry->d_shortname.string) {
>> > +		strbuf = dentry->d_shortname; // NUL is guaranteed to be in there
>> > +		qstr.name = strbuf.string;
>> >  		/* prevent compiler from optimizing out the temporary buffer */
>> >  		barrier();
>> 
>> If I read the code correctly, I admit I don't understand how this
>> guarantees the stability.  Aren't you just assigning qstr.name back the
>> same value it had in case of an inlined name through a bounce pointer?
>> The previous implementation made sense to me, since the memcpy only
>> accessed each character once, and we guaranteed the terminating
>> character explicitly, but I'm having a hard time with this version.
>
> This
> 		strbuf = dentry->d_shortname; // NUL is guaranteed to be in there
> copies the entire array.  No bounce pointers of any sort; we copy
> the array contents, all 40 bytes of it.  And yes, struct (or union,
> in this case) assignment generates better code than manual memcpy()
> here.

Ah. I read that as:

unsigned char *strbuf = &dentry->d_shortname

Thanks for explaining.  Makes sense to me:

Reviewed-by: Gabriel Krisman Bertazi <gabriel@krisman.be>

-- 
Gabriel Krisman Bertazi

