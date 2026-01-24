Return-Path: <linux-fsdevel+bounces-75360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BrRKgAUdWlPAgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 19:48:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C007E89A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 19:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10323301464D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 18:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E598A238C0F;
	Sat, 24 Jan 2026 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o91svOgn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E412B9B9;
	Sat, 24 Jan 2026 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769280497; cv=none; b=dpUq6Dx9pnN99OLlYXGTQbh6vufcrksQiYMyVQW2M5pkdR2O0Gk+5gnTfOzOVBYg7mOVZByetXyVKS0aBOC81XsjORVqZPw7CWhRuOufV0jO2flsOvapdK7S+23K5uM+pBAo5c86DyaBgZaSBQFL0DHHyRyK0aoJkj1X4YqbUOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769280497; c=relaxed/simple;
	bh=oCyXSOHbDmGJqfXO2G6w+kNTI/ryPsJQUM9byBK6jFk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CR3iskS2JKrtzKZu5CvLrfh62Pe35JpozxyagDFURI8G5Z1iIMZqLYPET2X/UhMKU9pa+h7GueafOl2/LKx6GtEXKljIDIfZHiAWRcNO0YfGKpuWlliV/q6C0DlafnsbyrbTgjYUT61BSyZgigCU/7+ncxglbyGaMutNWpWOXhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o91svOgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9EDC116D0;
	Sat, 24 Jan 2026 18:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769280497;
	bh=oCyXSOHbDmGJqfXO2G6w+kNTI/ryPsJQUM9byBK6jFk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=o91svOgnezeWNa/QMECwrJEMi+s80v+NB9DFoW6B4obdl16Epg+NWwWbCAjo8w+xr
	 xkO7UmFc6oARBhEqE33uUzGTmnO90FFiaAxt2ZQZpsS5qRSEpRttUs2inQ/9aYYJUQ
	 y0lKIA5zhVdEe6Vk+4zVnCV9zHJrU8i5aoVULRTPk0l3fpfV9YQZe79TYlalgM0+1b
	 FqoZb9g1KM2ismXPV/aQEwyJKN+Kd4u70FGAj866+OFt9KoMzm5wyYdQSNbkI10u6e
	 xmN2UeIHGXYBM789mCFhEe+RhkwHD2GFqsZUIo4Ve0Z8+m1LdiBmF30beSrW+aJ4Vm
	 vgnq0LftyUEcQ==
Message-ID: <8be0a065a84bed02735141b4333e9c49a2ab0c90.camel@kernel.org>
Subject: Re: [PATCH v2 3/3] NFSD: Sign filehandles
From: Trond Myklebust <trondmy@kernel.org>
To: Chuck Lever <cel@kernel.org>, Benjamin Coddington
 <bcodding@hammerspace.com>,  NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 Anna Schumaker
	 <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>, Rick Macklem
	 <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Date: Sat, 24 Jan 2026 13:48:15 -0500
In-Reply-To: <77e7a645-66bd-4ce2-b963-2a2488595b00@kernel.org>
References: <> <e545c35e-31fc-4069-8d83-1f9585e82532@app.fastmail.com>
	 <176921979948.16766.5458950508894093690@noble.neil.brown.name>
	 <686CBEE5-D524-409D-8508-D3D48706CC02@hammerspace.com>
	 <77e7a645-66bd-4ce2-b963-2a2488595b00@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-75360-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:email]
X-Rspamd-Queue-Id: 37C007E89A
X-Rspamd-Action: no action

On Sat, 2026-01-24 at 11:07 -0500, Chuck Lever wrote:
> On 1/24/26 8:58 AM, Benjamin Coddington wrote:
> > Hey Chuck and Neil - Sorry to be late responding here..
> >=20
> > On 23 Jan 2026, at 20:56, NeilBrown wrote:
>=20
>=20
> > Not a great argument, I know, but I think its nice to keep the
> > standard that
> > filehandles are independently self-describing.
> >=20
> > We're building server systems that pass around filehandles
> > generated by NFSD
> > and it can be a useful signal to those 3rd-party systems that
> > there's a
> > signature.=C2=A0 Trond might know more about whether its essential -
> > I'll ask him
> > to weigh in here.
>=20
> Thanks, yes, let's hear from Trond.
>=20
>=20
> > All said - please let me know if the next version should keep it.
>=20
> There are really two question marks:
>=20
> 1. If I were a security reviewer, I would say that NFSD shouldn't
> rely
> on network input like this to decide whether or not to validate the
> MAC.
> Either the server expects a MAC and uses it to validate, or it
> doesn't.
> For me as a maintainer, that is a risk we probably can deal with
> immediately -- would it be OK at least to change the FH verification
> code to not use the auth_type to decide when to validate the FH's
> MAC?
>=20
> 2. Is setting FH_AT_MAC still useful for other reasons? I think we
> don't
> really know whether to keep the auth_type or how to document it until
> we've decided on how exactly NFSD will deal with changing the sign_fh
> setting while clients have the export mounted.
>=20
> So, let's leave the field in place and we'll come back to it. If you
> want, add a comment like /* XXX is FH_AT_MAC still needed? */
>=20

I fully agree with the argument that policy decisions about whether to
check for a MAC need to be driven by the /etc/exports configuration,
and not by the filehandle itself. The only use I can think of for a
flag in that context would be to expedite the rejection of the
filehandle in the case where that policy was set, however that would
seem to be optimising for what should be a rare corner case.

I did speculate a little in some internal conversations whether or not
a metadata server that is using knfsd as a flex files data server might
be able to re-sign a filehandle after the secret key were changed,
rather than having to look up the file again using its path. However
that too is very much a corner case that we have no plans to optimise
for at this time. Even if we did, we wouldn't need a flag in the
filehandle to know whether or not to sign it, because we'd want to
determine the policy through other means (if for no other reason that
the metadata server needs to know the secret key as well).

So personally, I'm neutral about the need for that flag. I don't think
it is harmful (provided it isn't being used by knfsd to determine MAC
policy enforcement) however I don't see a strong argument for it being
needed either.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

