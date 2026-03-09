Return-Path: <linux-fsdevel+bounces-79746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PuDBtyLrmnNFwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 09:59:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBC1235C69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 09:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2995830379B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 08:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECFF258EFF;
	Mon,  9 Mar 2026 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2nkjj3C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6955936EA91;
	Mon,  9 Mar 2026 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773046687; cv=none; b=u+A7kdC8LA7ulOZqkGiZYRJJDApfstWBFCgcFr7RsJh+ijwC8LJMlbIrlntEEVhW2Eb1CFV2om7h8FezWMzqkYdcoCdVf1F+NXYi7eXEI8rSJFwRgDhf60Ni3fAnz8C0m48Le4DeI7usXus4e5K3XjiX1H5dk01ZL2+ZARlHgfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773046687; c=relaxed/simple;
	bh=cl/hu2kx5OeDQ/m+WetcJahiybpZ+b3vIIu0tYnyjrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+sxaj4XqlGbuYTRdknxhfSvZCE6cWiH5/+S7IzyLzHCmj/9+rQRVS4mMcegKdZyl4LMT55BQ8fnIDZAXR+8iy7m+2gOFrgb+smujoYWF+1WB2g0ci1K5CBF2PpkqcIQqsxOrExfRcgdNoCKTaL/ktljXPc0+iQ+2XTm3xNn740=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2nkjj3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DB2C4CEF7;
	Mon,  9 Mar 2026 08:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773046686;
	bh=cl/hu2kx5OeDQ/m+WetcJahiybpZ+b3vIIu0tYnyjrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q2nkjj3C5c+896swBnKlZdazq5Lh7zU8sBiO6vtOzPwkoc1Lb2eYECsMpGV55QUQG
	 ISzWbX46pdGkG3ZUO8pPNoSEI71MLsjGROfoUl1aaQStJjDkCo69YNoneAArTSolg7
	 zV5GpT8BUdpu6Q8lWyJSfg7Tqs4g3dX9+/CQMkCfuYiRCKf5ZX9E2ycnN7TiroedFf
	 LeF0qhyaHPjdFeevydcVEeWASMxF2RMwNnjLh9zi0AoibQBjHxO9xjXNQKOb0hHxiu
	 8hTAYE17UpvuQqzCZPXfGtmyq9CFT2r3lc34lnMQ7vP/tqaMLzxw305Slr6mIdGf3m
	 F5rhCdD12mQNA==
Date: Mon, 9 Mar 2026 09:57:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Jeff Layton <jlayton@kernel.org>, 
	Dorjoy Chowdhury <dorjoychy111@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, chuck.lever@oracle.com, 
	alex.aring@gmail.com, arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, 
	smfrench@gmail.com, richard.henderson@linaro.org, mattst88@gmail.com, 
	linmag7@gmail.com, tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, trondmy@kernel.org, 
	anna@kernel.org, sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, shuah@kernel.org, 
	miklos@szeredi.hu, hansg@kernel.org
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
Message-ID: <20260309-umsturz-herfallen-067eb2df7ec2@brauner>
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com>
 <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
 <801cf2c42b80d486726ea0a3774e52abcb158100.camel@kernel.org>
 <CALCETrVt7o+7JCMfTX3Vu9PANJJgR8hB5Z2THcXzam61kG9Gig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrVt7o+7JCMfTX3Vu9PANJJgR8hB5Z2THcXzam61kG9Gig@mail.gmail.com>
X-Rspamd-Queue-Id: AEBC1235C69
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79746-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,suse.cz,oracle.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.443];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, Mar 08, 2026 at 10:10:05AM -0700, Andy Lutomirski wrote:
> On Sun, Mar 8, 2026 at 4:40 AM Jeff Layton <jlayton@kernel.org> wrote:
> >
> > On Sat, 2026-03-07 at 10:56 -0800, Andy Lutomirski wrote:
> > > On Sat, Mar 7, 2026 at 6:09 AM Dorjoy Chowdhury <dorjoychy111@gmail.com> wrote:
> > > >
> > > > This flag indicates the path should be opened if it's a regular file.
> > > > This is useful to write secure programs that want to avoid being
> > > > tricked into opening device nodes with special semantics while thinking
> > > > they operate on regular files. This is a requested feature from the
> > > > uapi-group[1].
> > > >
> > >
> > > I think this needs a lot more clarification as to what "regular"
> > > means.  If it's literally
> > >
> > > > A corresponding error code EFTYPE has been introduced. For example, if
> > > > openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> > > > param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> > > > like FreeBSD, macOS.
> > >
> > > I think this needs more clarification as to what "regular" means,
> > > since S_IFREG may not be sufficient.  The UAPI group page says:
> > >
> > > Use-Case: this would be very useful to write secure programs that want
> > > to avoid being tricked into opening device nodes with special
> > > semantics while thinking they operate on regular files. This is
> > > particularly relevant as many device nodes (or even FIFOs) come with
> > > blocking I/O (or even blocking open()!) by default, which is not
> > > expected from regular files backed by “fast” disk I/O. Consider
> > > implementation of a naive web browser which is pointed to
> > > file://dev/zero, not expecting an endless amount of data to read.
> > >
> > > What about procfs?  What about sysfs?  What about /proc/self/fd/17
> > > where that fd is a memfd?  What about files backed by non-"fast" disk
> > > I/O like something on a flaky USB stick or a network mount or FUSE?
> > >
> > > Are we concerned about blocking open?  (open blocks as a matter of
> > > course.)  Are we concerned about open having strange side effects?
> > > Are we concerned about write having strange side effects?  Are we
> > > concerned about cases where opening the file as root results in
> > > elevated privilege beyond merely gaining the ability to write to that
> > > specific path on an ordinary filesystem?

I think this is opening up a barrage of question that I'm not sure are
all that useful. The ability to only open regular file isn't intended to
defend against hung FUSE or NFS servers or other random Linux
special-sauce murder-suicide file descriptor traps. For a lot of those
we have O_PATH which can easily function with the new extension. A lot
of the other special-sauce files (most anonymous inode fds) cannot even
be reopened via e.g., /proc.

