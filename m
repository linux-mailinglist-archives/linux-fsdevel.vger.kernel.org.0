Return-Path: <linux-fsdevel+bounces-39417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF655A13E29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 16:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5393E188D9BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 15:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE5022BAC5;
	Thu, 16 Jan 2025 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JIZ2k6LZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C64A86329;
	Thu, 16 Jan 2025 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042391; cv=none; b=ShlJDEGBtmoNXOh1AV9jsKqKCvjsNuqHsn4ZfQvD6gygR6ISnmOfzEgDTIlJRK3yWDJU6RoQj4QdEfKOl52UaQQjmP1mfSUgeOzqqBzb3P355cKStK3GOVDUdJY+DGEO8CjgwF34DTJVAbObp0qAuAvjGjXpPrdFF03AfIcIFiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042391; c=relaxed/simple;
	bh=UImHlw4d/6uI7oG1fhuzXrfmbL0jjBq5KOZgHrs8WmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSCibQmHiOUpCyxOt7k+Be0sxtCBypeISGDU1XYfQkBLbEFQiA5IAlXB+MPpEyyJKcI/Q1fz4dtchYMy/RmiOwbpEBp8TRT0e2SZMHi9x+vYE/4KqYW6JEeuXjKhFr6bUm3qP9MDuTxDSM8yE9hPLxcjDJk3TI15XO1A5IoTD5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JIZ2k6LZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F1qj6tl21IifxBG2YwVZZcUt++2u+OK18UMurQRpprQ=; b=JIZ2k6LZ0CgQPgEnPRfCSBY6Wi
	cqFYYmCTMxJ8AdGjW6Y6PUaa39yISK0BJRkiNKxtjPqNMmmWlN8+g7uZdhUgldTqzb/JSOTAtgQiH
	dwQgzPa3+f2cYSnEo8wSawzFAd4iaoWJBaSaMUa0estz2Sw9ZcloUEmswQ1lk9ncHbSPo17vILJOr
	n7st97VPGGP7O3q5IsatHmZToICmI1kmGPixZju0xZgME6aFsuRL9XqQLHzhq8Px8nNNY6w6A9VKg
	k1vx82FPuT7CPkERoGxzXJgQytUYUuIq5MJvV+oLe2UGgh0AOdjhGF+48OMErxbd2oDdb+2uQH+fK
	0qEuiTPg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYS4f-00000002RBE-2dhs;
	Thu, 16 Jan 2025 15:46:25 +0000
Date: Thu, 16 Jan 2025 15:46:25 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: linux-fsdevel@vger.kernel.org, agruenba@redhat.com, amir73il@gmail.com,
	brauner@kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com,
	hubcap@omnibond.com, jack@suse.cz, linux-nfs@vger.kernel.org,
	miklos@szeredi.hu, torvalds@linux-foundation.org
Subject: Re: [PATCH v2 06/20] generic_ci_d_compare(): use shortname_storage
Message-ID: <20250116154625.GG1977892@ZenIV>
References: <20250116052103.GF1977892@ZenIV>
 <20250116052317.485356-1-viro@zeniv.linux.org.uk>
 <20250116052317.485356-6-viro@zeniv.linux.org.uk>
 <87cygmlqeq.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cygmlqeq.fsf@mailhost.krisman.be>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jan 16, 2025 at 10:38:53AM -0500, Gabriel Krisman Bertazi wrote:
> >  	 * If the dentry name is stored in-line, then it may be concurrently
> >  	 * modified by a rename.  If this happens, the VFS will eventually retry
> >  	 * the lookup, so it doesn't matter what ->d_compare() returns.
> >  	 * However, it's unsafe to call utf8_strncasecmp() with an unstable
> >  	 * string.  Therefore, we have to copy the name into a temporary buffer.
> 
> This part of the comment needs updating since there is no more copying.
> 
> > +	 * As above, len is guaranteed to match str, so the shortname case
> > +	 * is exactly when str points to ->d_shortname.
> >  	 */
> > -	if (len <= DNAME_INLINE_LEN - 1) {
> > -		memcpy(strbuf, str, len);
> > -		strbuf[len] = 0;
> > -		str = strbuf;
> > +	if (qstr.name == dentry->d_shortname.string) {
> > +		strbuf = dentry->d_shortname; // NUL is guaranteed to be in there
> > +		qstr.name = strbuf.string;
> >  		/* prevent compiler from optimizing out the temporary buffer */
> >  		barrier();
> 
> If I read the code correctly, I admit I don't understand how this
> guarantees the stability.  Aren't you just assigning qstr.name back the
> same value it had in case of an inlined name through a bounce pointer?
> The previous implementation made sense to me, since the memcpy only
> accessed each character once, and we guaranteed the terminating
> character explicitly, but I'm having a hard time with this version.

This
		strbuf = dentry->d_shortname; // NUL is guaranteed to be in there
copies the entire array.  No bounce pointers of any sort; we copy
the array contents, all 40 bytes of it.  And yes, struct (or union,
in this case) assignment generates better code than manual memcpy()
here.

