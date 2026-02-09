Return-Path: <linux-fsdevel+bounces-76760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOkVON5Limk6JQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 22:04:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6AD114AFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 22:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54F2B300C32C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 21:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16C230C371;
	Mon,  9 Feb 2026 21:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gv90zBto"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE2D309DDD;
	Mon,  9 Feb 2026 21:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770671063; cv=none; b=fe+tuYorKGIQK9n1GgugXxusIyPxGG8/FSocbpyeDSoBVJGwx3/ZezdC87aOBUZtzk7CZU+QugZyBisPKUJT+ZAuV0IILNHmLAgce38CPAtAGXHWWGnJE1koQkdeKTBweCX2RlHH+f+oj1vXMI8hXXEyOV9+hjcmXXPbAv6CKvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770671063; c=relaxed/simple;
	bh=jJ3cK4VUb4s5Rf+L68t7ejmKpLRBAuRmTpiC/IIB2tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAaAn7j5cK8JIAs48mV1Yn7hWT1QeYgnczkWuQmu7VznZrUCCBvGcbOvP93A+ATSX4pWPPXmhyCxzyF+6/00UJPTezqpg/MjIwHM5MnOuvumSkJmDkY3vgwsPOSRqQ+LxijERmVfnA/nsFprUWrFdi3WnU70RfdfTT/5Z9i9NVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gv90zBto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E31DC116C6;
	Mon,  9 Feb 2026 21:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770671062;
	bh=jJ3cK4VUb4s5Rf+L68t7ejmKpLRBAuRmTpiC/IIB2tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gv90zBtoO/Rx1js4Z5tbCdTifurT8sNcXLLKEHBDBe0N7XZffWtYoxyKHlQYMznY7
	 heN5mBJT1+HG0YmKXLT1lD6V/9wT5VgrBjFXMMscTeZiCwWR16E5cf07ts0srjF3+n
	 YO9PBykgOywHMQ7EJJceWc1ly3/6sTi7MB1LO6O2rHsqXEaBnFMpPAo+QjJZOvNlHt
	 ne6kAbd1esTPKijeUbYlaRvmLBFHGXz4gEQw8AkI+VV6tg1EN8VnJRmHWjyx7n+v7b
	 sX0kzHcbV3Mvg7FNnZvAnk+K6qNdpgMoo9eDJBUdWdYW/oxzplv8vCdJvRag3OjPuK
	 iaMBbzcWX4zqA==
Date: Mon, 9 Feb 2026 21:04:20 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Benjamin Coddington <bcodding@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v5 3/3] NFSD: Sign filehandles
Message-ID: <20260209210420.GA1062842@google.com>
References: <cover.1770660136.git.bcodding@hammerspace.com>
 <c24f0ce95c5d2ec5b7855d6ab4e3f673b4f29321.1770660136.git.bcodding@hammerspace.com>
 <8574c412-31fb-4810-a675-edf72240ae29@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8574c412-31fb-4810-a675-edf72240ae29@oracle.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76760-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[hammerspace.com,kernel.org,brown.name,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yp.to:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF6AD114AFC
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 03:29:07PM -0500, Chuck Lever wrote:
> On 2/9/26 1:09 PM, Benjamin Coddington wrote:
> > NFS clients may bypass restrictive directory permissions by using
> > open_by_handle() (or other available OS system call) to guess the
> > filehandles for files below that directory.
> > 
> > In order to harden knfsd servers against this attack, create a method to
> > sign and verify filehandles using siphash as a MAC (Message Authentication
> > Code).  Filehandles that have been signed cannot be tampered with, nor can
> > clients reasonably guess correct filehandles and hashes that may exist in
> > parts of the filesystem they cannot access due to directory permissions.
> 
> It's been pointed out to me that siphash is a PRF designed for hash
> tables, not a standard MAC. We suggested siphash as it may be sufficient
> here for preventing 8-byte tag guessing, but the commit message and
> documentation calls it a "MAC" which is a misnomer. Can the commit
> message (or even the new .rst file) document why siphash is adequate for
> this threat model?
> 
> Perhaps Eric has some thoughts on this.

PRFs are also MACs, though.  So SipHash is also a MAC.  See the original
paper: https://cr.yp.to/siphash/siphash-20120918.pdf

However, SipHash's tag size is only 64 bits, which limits its resistance
to forgeries.  There will always be at least a 1 in 2^64 chance of a
forgery.

In addition, the specific variant of SipHash implemented by the kernel's
siphash library is SipHash-2-4.  That's the performance-optimized
variant.  While no attack is known on that variant, and the SipHash
paper claims that even this variant is a cryptographically strong PRF
and thus also a MAC, SipHash-4-8 is the more conservative variant.

If you'd like to be more conservative with the cryptographic primitive
and also bring the forgery chance down to 1 in 1^128, HMAC-SHA256 or
BLAKE2s with 128-bit tags could be a good choice.

(In commit 2f3dd6ec901f29aef5fff3d7a63b1371d67c1760, I used HMAC-SHA256
with 256-bit tags for SCTP cookies.  Probably overkill, but the struct
already had 256 bits reserved for the tag.)

But again, SipHash (even SipHash-2-4) is indeed considered to be a MAC.
So if the only concern is that it's "a PRF but not a MAC", that's not
correct.

- Eric

