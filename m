Return-Path: <linux-fsdevel+bounces-78271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJMzN6+2nWlyRQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 15:33:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD16188673
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 15:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5381306AF49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 14:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263CF3806A5;
	Tue, 24 Feb 2026 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KryYQSna"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CE01DE894;
	Tue, 24 Feb 2026 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771943494; cv=none; b=Un1E62Yfque03+eGZZ6SOStRChAdI/UlD+YAl48N4YMQgUetHl04jWhQz7UZS3ELYwby1cn3zOa31H6CJ/XBGaKILiPg6PorMZ1plQy1+XufDi/Ay6cxVnpwN7VvTX2HR42Icn94pkwVNhJZa3gAv2B9MbVLnRO0NmDhHt7W9mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771943494; c=relaxed/simple;
	bh=/bd114QHkC3A2lk/V0zjOM3mgCNoj5ks7ZlnedEGf0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXVBNdnRawhKYUtv2OxSn4ZEOnNBAMJq8G5mGBNNnrwlZjI8LeV2GJ16pn5VfX7r1Y12KDVHak2PIQqahjD8V0EbyQ0Oh9QlgD6uTJKB6P1TXI8m2zbYGE/Q5ExNPICJlWMA1RXCEqvk60LlAwwWW7ZckeHav//6iXOfcPWPu4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KryYQSna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF9AC116D0;
	Tue, 24 Feb 2026 14:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771943494;
	bh=/bd114QHkC3A2lk/V0zjOM3mgCNoj5ks7ZlnedEGf0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KryYQSnasbEt23Cyz4aYQsuaS1HKeuiqyRG/58RWhyDichRA3mvQ9vvIZOfOdBOn+
	 3nOD7omh0HwWUhmQWG7tbCfIbrc4rpY4/+KYhTnoCnPbE+UzjHx5EbHtlH7wtlzQU0
	 k7xmuZQbOAEwVqpgFJFCfbQ2tpH/0IseTEG8KO5VlWTT7hQA9WRNXWKG2akosAITBm
	 eZGgsChyGPjVR8lh8KRwpoCrjGoJ+r23WJZ1lD2ys2CCNnSatp+cb6FnoJtQLNqD+S
	 bcd67BTU1GGdLqyjrZXjl9XpXfBF7iyAPmQgg6x+sHBUPlje0ajyiLUYZ021AFa9Qz
	 95uQOFXKbPcpQ==
Date: Tue, 24 Feb 2026 15:31:29 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com, 
	alex.aring@gmail.com, viro@zeniv.linux.org.uk, jack@suse.cz, arnd@arndb.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] Add support for empty path in openat and openat2 syscalls
Message-ID: <20260224-einquartieren-lahmen-aa7e0203f917@brauner>
References: <20260223151652.582048-1-jkoolstra@xs4all.nl>
 <44a2111e33631d78aded73e4b79908db6237227f.camel@kernel.org>
 <20260224-karotten-wegnimmt-79410ef99aeb@brauner>
 <695828658.1952887.1771940100883@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <695828658.1952887.1771940100883@kpc.webmail.kpnmail.nl>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78271-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,gmail.com,zeniv.linux.org.uk,suse.cz,arndb.de,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.936];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CD16188673
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 02:35:00PM +0100, Jori Koolstra wrote:
> 
> > Op 24-02-2026 11:10 CET schreef Christian Brauner <brauner@kernel.org>:
> > 
> >  
> > On Mon, Feb 23, 2026 at 10:28:24AM -0500, Jeff Layton wrote:
> > > On Mon, 2026-02-23 at 16:16 +0100, Jori Koolstra wrote:
> > > > To get an operable version of an O_PATH file descriptors, it is possible
> > > > to use openat(fd, ".", O_DIRECTORY) for directories, but other files
> > > > currently require going through open("/proc/<pid>/fd/<nr>") which
> > > > depends on a functioning procfs.
> > > > 
> > > > This patch adds the O_EMPTY_PATH flag to openat and openat2. If passed
> > > > LOOKUP_EMPTY is set at path resolve time.
> > > > 
> > > 
> > > This sounds valuable, but there was recent discussion around the
> > > O_REGULAR flag that said that we shouldn't be adding new flags to older
> > > syscalls [1]. Should this only be an OPENAT2_* flag instead?
> > > 
> > > [1]: https://lore.kernel.org/linux-fsdevel/20260129-siebzehn-adler-efe74ff8f1a9@brauner/
> > 
> > I do like restricting it to openat2() as well.
> 
> So would you want to filter the O_EMPTY_PATH flag from openat(), or maybe add
> a RESOLVE_EMPTY flag to the resolve options?

No, add a OPENAT2_EMPTY_PATH in the upper 32 bit of the 64-bit flag
argument for struct open_how. Then it cannot be used in openat(). But
let's wait a day or so to see whether we have someone that really wants
to extend this to openat() as well...

