Return-Path: <linux-fsdevel+bounces-74607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDw6NeRNcWkahAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 23:06:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DE15E7AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 23:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 958F058AD0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 10:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC69440B6D4;
	Tue, 20 Jan 2026 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1CnPJjX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD1E3ED13E;
	Tue, 20 Jan 2026 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905442; cv=none; b=Y+QPoSOGUeuPNBcrxP0+tIxlqMOsNm3Q0WI4BJaRZLMpbHhhC8n7r6FGqtDmqoRoILcbRTScPo1dQyelp/2K18kpePiRj6Lj8x58aelmzTABYsP7cc6uQ6T6do3rn2/ffrcn8oCeSsGUTS/I9jC2N7lj7D8yufVAhlNBGk6hwgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905442; c=relaxed/simple;
	bh=pXSDHluWsRP0ONrt2c4w8+y04vClCGg63HGKISeqXk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oqf9S2Ax5zy6usXQYp1D2re7Q61UtgmiC2sBES374pi6t89rNtNhA3ivLheiOmJ4SVDB/zZqPM/RSPg8ptifCF4dJc69OhAJ9oNbMe/hEVOfcW5708R7wUUZO7JJllV8CtpOTR9LsEQnSjmWsX0FFG1yXAc+rOsxl1C3sMRPO9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1CnPJjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5C9C16AAE;
	Tue, 20 Jan 2026 10:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768905441;
	bh=pXSDHluWsRP0ONrt2c4w8+y04vClCGg63HGKISeqXk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j1CnPJjX4mcaIEUN6krptYAmbm5vqV9fYKxtAMaWcB3j2XeJe4k7q/k9lj6ITGgiy
	 qZ35wiEOcQyS73TdBS9Ux7cz6vN9+zOqXptZE0YdydL+C+fS3kQ9fDxKcIwQ2ADdto
	 BBz35lqNBlRhO4xMAQZoNwdbL7c9dXC2MbM+pm2JjPFUpBje/Ih7H/stTfXmPOlyzg
	 thMrOTxD5wcvAUs0aPKotSo/R3T5cnos7esEgUiInb3MCWfF0A+WSpLBkrw8e4w8eM
	 VCUnXBrcciz2dippNMBrFJlZEm8wKtqPO8XylhMkJcWc9PTj+q1N6BYqKuFIzpV3OB
	 Apy0k4iYCPSBQ==
Date: Tue, 20 Jan 2026 11:37:16 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Benjamin Coddington <bcodding@hammerspace.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH v1 0/4] kNFSD Signed Filehandles
Message-ID: <20260120-kundgeben-privat-e9077477f862@brauner>
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <20260119-reingehen-gelitten-a5e364f704fa@brauner>
 <176885678653.16766.8436118850581649792@noble.neil.brown.name>
 <20260120-tratsch-luftfahrt-d447fdd12c10@brauner>
 <176890236169.16766.7338555258291967939@noble.neil.brown.name>
 <20260120-irrelevant-zeilen-b3c40a8e6c30@brauner>
 <176890489330.16766.1807342797736472831@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <176890489330.16766.1807342797736472831@noble.neil.brown.name>
X-Spamd-Result: default: False [5.04 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DATE_IN_PAST(1.00)[35];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74607-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[hammerspace.com,oracle.com,kernel.org,gmail.com,vger.kernel.org,poettering.net];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 47DE15E7AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 09:28:13PM +1100, NeilBrown wrote:
> On Tue, 20 Jan 2026, Christian Brauner wrote:
> > On Tue, Jan 20, 2026 at 08:46:01PM +1100, NeilBrown wrote:
> > > On Tue, 20 Jan 2026, Christian Brauner wrote:
> > > > > You don't need signing to ensure a filehandle doesn't persist across
> > > > > reboot.  For that you just need a generation number.  Storing a random
> > > > > number generated at boot time in the filehandle would be a good solution.
> > > > 
> > > > For pidfs I went with the 64-bit inode number. But I dislike the
> > > > generation number thing. If I would have to freedom to completely redo
> > > > it I would probably assign a uuid to the pidfs sb and then use that in
> > > > the file handles alongside the inode number. That would be enough for
> > > > sure as the uuid would change on each boot.
> > > 
> > > What you are calling a "uuid" in "the pidfs sb" is exactly what I am
> > > calling a "generation number" - for pidfs it would be a "generation
> > 
> > "generation number" just evokes the 32-bit identifier in struct inode
> > that's overall somewhat useless. And a UUID has much stronger
> > guarantees.
> > 
> > > number" for the whole filesystem, while for ext4 etc it is a generation
> > > number of the inode number.
> > > 
> > > So we are substantially in agreement.
> > 
> > Great!
> > 
> > > 
> > > Why do you not have freedom to add a uuid to the pidfs sb and to the
> > > filehandles now?
> > 
> > Userspace relies on the current format to get the inode number from the
> > file handle:
> > https://github.com/systemd/systemd/blob/main/src/basic/pidfd-util.c#L233-L281
> 
> The
>   assert(r != -EOVERFLOW);
> means you cannot extend it
> 
> > 
> > And they often also construct them in userspace. That needs to continue
> > to work. I also don't think it's that critical.
> > 
> 
> as does this.

Well, we could add a new version and we could make this work. I just
don't think we need to right now.

Btw, the manpage for name_to_handle_at() and friends mandates that file
handles are to be treated as opaque and should not be messed with
directly. That ship has sailed a long time ago. Userspace very much
relies on file handle layout. That's at least true for cgroupfs and
pidfs.

