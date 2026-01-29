Return-Path: <linux-fsdevel+bounces-75850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG9rCng7e2mNCgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 11:50:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D35AF21D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 11:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF585302382A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 10:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BA738551C;
	Thu, 29 Jan 2026 10:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5z0VVmL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B453137F74A;
	Thu, 29 Jan 2026 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769683771; cv=none; b=MncTYfvMCoVj1TgpQQEQJ7ZU+irhZV4EUgcTa/pwkZaLPi6IhKXjyczjPVuX8XNqe8GGBdp+ywN4oFrRRP7CgiQf5xSVDNp6XHB313xf6QsdKLf6Zs+zkyRa+Ygv5nnsuuXMis0bnmytjn1O0ufTRapfvV4eslQh35MEhHJ15oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769683771; c=relaxed/simple;
	bh=jjf6U+aNszTfB0UVxCbn9ahIqQSTAYTWbd0r5N28E7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmqrG1rbRxdNWHkWKQlqdhu2s7RDc6K8YTQZ+O624T36LQ8WZlmFEOG++5Ozpnu94g4WT0PagqZPFhhZ9ba2YfOtXK+qf08Zf6daWCHqfxv3+doSZrEUWNcDggzo2hjdPU1DESB1QhSN0rYuAfgVH0MAgnkKMlvfhsNOtX1M6eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5z0VVmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B97C116D0;
	Thu, 29 Jan 2026 10:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769683771;
	bh=jjf6U+aNszTfB0UVxCbn9ahIqQSTAYTWbd0r5N28E7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s5z0VVmL+olA9dnqCNxPhRmPK2ALjW8d8CNoQ5aZ/6ToUeuPTt86nsh4LeuFs7TBI
	 wsV+OAkNaL6wvEHdSBKANweKy6DQbKSuVkDku4WyCTWxf8Sywn4ctXDThGBHPCBv93
	 Awt78P6K2fw4dcYsSnGGUntS5e13MehSk7K0lnNLFlg4CX27qejSNV9IFfYSUo0oDg
	 RnZGjwhQt5WJ7NqhJbQNxPOmAXTERcNU2oCa72KP6tqZ9sB+aytpu0pRYA5Qnema4Y
	 xBGG2FJcRhtfl8iTp0yzUf3S66tkzCfdCtn57Ez68rAZt0F4n/acrwS7XgajcOCbjm
	 CPhJz1SVr4H1g==
Date: Thu, 29 Jan 2026 11:49:26 +0100
From: Christian Brauner <brauner@kernel.org>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org, chuck.lever@oracle.com, 
	alex.aring@gmail.com, arnd@arndb.de, adilger@dilger.ca
Subject: Re: [PATCH v3 1/4] open: new O_REGULAR flag support
Message-ID: <20260129-siebzehn-adler-efe74ff8f1a9@brauner>
References: <20260127180109.66691-1-dorjoychy111@gmail.com>
 <20260127180109.66691-2-dorjoychy111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127180109.66691-2-dorjoychy111@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75850-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,suse.cz,kernel.org,oracle.com,gmail.com,arndb.de,dilger.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7D35AF21D
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 11:58:17PM +0600, Dorjoy Chowdhury wrote:
> This flag indicates the path should be opened if it's a regular file.
> This is useful to write secure programs that want to avoid being tricked
> into opening device nodes with special semantics while thinking they
> operate on regular files.
> 
> A corresponding error code ENOTREG has been introduced. For example, if
> open is called on path /dev/null with O_REGULAR in the flag param, it
> will return -ENOTREG.
> 
> When used in combination with O_CREAT, either the regular file is
> created, or if the path already exists, it is opened if it's a regular
> file. Otherwise, -ENOTREG is returned.
> 
> -EINVAL is returned when O_REGULAR is combined with O_DIRECTORY (not
> part of O_TMPFILE) because it doesn't make sense to open a path that
> is both a directory and a regular file.
> 
> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> ---

Yeah, we shouldn't add support for this outside of openat2(). We also
shouldn't call this OEXT_* or O2_*. Let's just follow the pattern where
we prefix the flag space with the name of the system call
OPENAT2_REGULAR.

There's also no real need to make O_DIRECTORY exclusive with
OPENAT2_REGULAR. Callers could legimitately want to open a directory or
regular file but not anything else. If someone wants to operate on a
whole filesystem tree but only wants to interact with regular files and
directories and ignore devices, sockets, fifos etc it's very handy to
just be able to set both in flags.

Frankly, this shouldn't be a flag at all but we already have O_DIRECTORY
in there so no need to move this into a new field.

Add EFTYPE as the errno code. Some of the bsds including macos already
have that.

