Return-Path: <linux-fsdevel+bounces-77961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEj9LmxonGlnGAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 15:47:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 478621783A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 15:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2565130D924E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CB91DDC35;
	Mon, 23 Feb 2026 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="oBxS4oiF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E4B14A60C;
	Mon, 23 Feb 2026 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857931; cv=none; b=dNBysABRTPnyKlJhM9h+7ZuNrHK2HI2UxW/sWzqA1D8v1sJT1syiWdzgz4SBf21A5oSfveFHYLL4zOk/Li8znuHZRNuTAAU5t8lTpMi3MbyAt/0sJKYN9KLNmDw3ZVcbLi1SqE3N+445pEIMn7Q1RWtcNbMymjy6tfcwa1xA350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857931; c=relaxed/simple;
	bh=rbqaeaXWAOX+f168RGuiX9opo28PTMTTkZQHmxCQWj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JkIFwbyHKwTBZlKYQB7ohUUu53moo/khh+kG1PpqfMDmEu+Fh2xwQ+NO6KLr5emS3CzFqqQhA19sE96groncc3FV779vpp+FqhlxHNy8MUxgblpscy52A3Ye20wUBaEgSqMTovJ3TF0VifiPScYIDeJRq7l2HvF9owr6gUmk/oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=oBxS4oiF; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=xIuNQ3UxNNUvzDppf0sdJxW7+WQLLbzNj0JON6LH8xo=; b=oBxS4oiFEcoyU+QrAx/UTcFNgn
	OVs4W0QYV/sgRVVAI2hH6+bM55k6tx/PeFvR4rA+j0n53vh6zudrxtxDTRE9NATsomMbuOpqy6vj0
	CZ4OUXN54uE9+KM5+dIgRRAVPTiPki3+Jt6z5gvuIVzObbo3Ioi9+WU9GL+jl64HRoNwx0VH4iwEA
	4ZrO7Eb7vGxWprixXUp1yhchFaow5qpxPpoSjCpIRHHCH1n5WvKHIFMytj6DSMWdZqjfEPF0igmbw
	YDKJGeBdzOvwFAa2itGRNUQrjPuKZb75Fzf2pC3nw4OnOyYFiPNHsO/KMZlIPfQ+m4HNPRWhsNu9j
	dMONmzcw2PNOatipSbDiMo3h4+ZPH9hx6KeZ96vby2CYGuhjneRyyuSwmMWzD3LAtF1Am72HhBpLX
	R9eJt2Q8YHrhiwC5i9swtw3snfogf6yUjpgI6AfvYmixGZhZUzot29eE/HWyjqbCGZxuahee6GJNw
	esf9Jt8R/l3xqvuo7T34xf/SW4QcdhSpPfFExq04DqWQjZuW2BGxc/2x+Hhw4X6Rj2n1HeC68ZQg6
	c+PO8iE15cKRlPSyYjTYzj2FtqfTiSMGUCN9jjfblYc3xWBzT3vU0Hob/iOBzwh1b4xLYSPQCGg2p
	EdG1FQKKU8gUModcSBLjunyjsIgbKX9T0AIPzEwDE=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Remi Pommarel <repk@triplefau.lt>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH v2 1/3] 9p: Cache negative dentries for lookup performance
Date: Mon, 23 Feb 2026 15:45:21 +0100
Message-ID: <4715570.LvFx2qVVIh@weasel>
In-Reply-To: <aZoXKN8pPOqEBBBz@pilgrim>
References:
 <cover.1769013622.git.repk@triplefau.lt> <aY2aXG4ljulj1QRh@pilgrim>
 <aZoXKN8pPOqEBBBz@pilgrim>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crudebyte.com,quarantine];
	R_DKIM_ALLOW(-0.20)[crudebyte.com:s=kylie];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77961-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[crudebyte.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux_oss@crudebyte.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,crudebyte.com:dkim]
X-Rspamd-Queue-Id: 478621783A9
X-Rspamd-Action: no action

On Saturday, 21 February 2026 21:35:52 CET Remi Pommarel wrote:
> On Thu, Feb 12, 2026 at 10:16:13AM +0100, Remi Pommarel wrote:
> > On Wed, Feb 11, 2026 at 04:49:19PM +0100, Christian Schoenebeck wrote:
> > > On Wednesday, 21 January 2026 20:56:08 CET Remi Pommarel wrote:
[...]
> > > > diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
> > > > index 6a12445d3858..99d1a0ff3368 100644
> > > > --- a/fs/9p/v9fs.h
> > > > +++ b/fs/9p/v9fs.h
> > > > @@ -91,6 +91,7 @@ enum p9_cache_bits {
> > > >=20
> > > >   * @debug: debug level
> > > >   * @afid: authentication handle
> > > >   * @cache: cache mode of type &p9_cache_bits
> > > >=20
> > > > + * @ndentry_timeout: Negative dentry lookup cache retention time in
> > > > ms
> > > >=20
> > > >   * @cachetag: the tag of the cache associated with this session
> > > >   * @fscache: session cookie associated with FS-Cache
> > > >   * @uname: string user name to mount hierarchy as
> > > >=20
> > > > @@ -116,6 +117,7 @@ struct v9fs_session_info {
> > > >=20
> > > >  	unsigned short debug;
> > > >  	unsigned int afid;
> > > >  	unsigned int cache;
> > > >=20
> > > > +	unsigned int ndentry_timeout;
> > >=20
> > > Why not (signed) long?
> >=20
> > I first though 40+ days of cache retention was enough but that is just
> > an useless limitation, I will change it to signed long.
>=20
> Well now that I think about it, this is supposed to be set from a mount
> options. However, with the new mount API in use, there is currently no
> support for fsparam_long or fsparam_s64.
>=20
> While it could be implemented using a custom __fsparam, is the effort
> truly justified here? Also in that case maybe a long long would be a bit
> more portable across 32-bit and 64-bit platform?

Ah, there is fsparam_u64 but not fsparam_s64 and you are using -1 as option
for "infinite".

There is also `long session_lock_timeout=C2=B4, but now that I look at it, =
its mount
option was apparently always limited to 32-bit, even before the new mount A=
PI
transition.

I agree, then just leave it as `int=C2=B4 type now.

Thanks!

/Christian




