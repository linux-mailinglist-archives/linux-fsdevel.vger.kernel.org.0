Return-Path: <linux-fsdevel+bounces-14735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C95987E87D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 12:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288091F23071
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 11:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A5136B1D;
	Mon, 18 Mar 2024 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qY4r/LVk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ADB2C85D;
	Mon, 18 Mar 2024 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760928; cv=none; b=NKeFCVlmm6Z+DwB7k9Q6AfzW9oCxy0XhNw0T7LDqUpuThuMNAjcgtjPpZM5CKwOEN4HpnZTqmy/g9jORofrzbxULU9jleivYiWt7ibBRGxgvsv5oMsBs69JNJkt7W3w3k+IOBa4LUFEZU2V8b0jddV01mOjSDPjptP+JQAT8YJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760928; c=relaxed/simple;
	bh=0xOr6SIupIgFP91LGldL2VaJn7VG0m94uoYWdc60Zbc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fmhZjeI/6Uqgy+4KIDMvSbtq69qEuosUL5w1HMKsi+auF1MKnc1nqMcmfRjBbmhz2GodRQe1csrqOrhckDtPqSO92xweNO23bRrb8zn843PV+ziGb4HZwh63buii2MZVegw9BNOOdt0bf1fVN8/9GTbNno5K4l3ibPBwfHqGWGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qY4r/LVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3330CC433C7;
	Mon, 18 Mar 2024 11:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710760928;
	bh=0xOr6SIupIgFP91LGldL2VaJn7VG0m94uoYWdc60Zbc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=qY4r/LVkNbaubL7kQdZSigdtImRj8XV7gdVH9zytMDfp1G2AiNEsyPFUbcrIq4QxK
	 PkLeBI3iCml6AstODLC+MCV4ppult4Tf8PxVedJWNjtFFvfTJgPbUS1Ol7XmDeREEU
	 LTMCLKiajHPHdCHzfRBIEdDx7hzyQRjUjZ/l9Az2dvvNUuy42pMRfhU1nMLv8gdzPH
	 BQsHP8HdP2xM4ZhWHX8b2dBg+5xHc681xeQ+/HlOLO2ykFQzwK5bdYbffB78SVP/jf
	 +N7+IWqeRHl8kRQYEd+7Q0EGZypLNUgEKPdQFajjYDvzFHpSwqCqFrlQXJes6BqaSn
	 pG0RokFnVGEug==
Message-ID: <5d6688d419f19512a8170ca915ec5825df8f489a.camel@kernel.org>
Subject: Re: [PATCH RFC 11/24] nfsd: allow DELEGRETURN on directories
From: Jeff Layton <jlayton@kernel.org>
To: Trond Myklebust <trondmy@hammerspace.com>, "chuck.lever@oracle.com"
	 <chuck.lever@oracle.com>
Cc: "senozhatsky@chromium.org" <senozhatsky@chromium.org>, 
 "sfrench@samba.org" <sfrench@samba.org>, "ecryptfs@vger.kernel.org"
 <ecryptfs@vger.kernel.org>,  "linux-unionfs@vger.kernel.org"
 <linux-unionfs@vger.kernel.org>, "davem@davemloft.net"
 <davem@davemloft.net>,  "viro@zeniv.linux.org.uk"
 <viro@zeniv.linux.org.uk>, "anna@kernel.org" <anna@kernel.org>,
 "jack@suse.cz" <jack@suse.cz>, "tom@talpey.com" <tom@talpey.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>,  "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "ronniesahlberg@gmail.com"
 <ronniesahlberg@gmail.com>, "samba-technical@lists.samba.org"
 <samba-technical@lists.samba.org>, "dhowells@redhat.com"
 <dhowells@redhat.com>,  "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "rafael@kernel.org"
 <rafael@kernel.org>, "alex.aring@gmail.com" <alex.aring@gmail.com>, 
 "pc@manguebit.com" <pc@manguebit.com>, "amir73il@gmail.com"
 <amir73il@gmail.com>,  "kolga@netapp.com" <kolga@netapp.com>,
 "sprasad@microsoft.com" <sprasad@microsoft.com>,  "code@tyhicks.com"
 <code@tyhicks.com>, "brauner@kernel.org" <brauner@kernel.org>, 
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "edumazet@google.com" <edumazet@google.com>,  "linux-cifs@vger.kernel.org"
 <linux-cifs@vger.kernel.org>, "linkinjeon@kernel.org"
 <linkinjeon@kernel.org>,  "neilb@suse.de" <neilb@suse.de>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
 "netfs@lists.linux.dev" <netfs@lists.linux.dev>, "miklos@szeredi.hu"
 <miklos@szeredi.hu>
Date: Mon, 18 Mar 2024 07:22:04 -0400
In-Reply-To: <d3d8483b1248e4bccadb8591019dbe7c4aeb3d1c.camel@hammerspace.com>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
	 <20240315-dir-deleg-v1-11-a1d6209a3654@kernel.org>
	 <ZfcHvSEkwIS8-Ytj@manet.1015granger.net>
	 <d3d8483b1248e4bccadb8591019dbe7c4aeb3d1c.camel@hammerspace.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-03-17 at 16:03 +0000, Trond Myklebust wrote:
> On Sun, 2024-03-17 at 11:09 -0400, Chuck Lever wrote:
> > On Fri, Mar 15, 2024 at 12:53:02PM -0400, Jeff Layton wrote:
> > > fh_verify only allows you to filter on a single type of inode, so
> > > have
> > > nfsd4_delegreturn not filter by type. Once fh_verify returns, do
> > > the
> > > appropriate check of the type and return an error if it's not a
> > > regular
> > > file or directory.
> > >=20
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > =A0fs/nfsd/nfs4state.c | 14 +++++++++++++-
> > > =A01 file changed, 13 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 17d09d72632b..c52e807f9672 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -7425,12 +7425,24 @@ nfsd4_delegreturn(struct svc_rqst *rqstp,
> > > struct nfsd4_compound_state *cstate,
> > > =A0	struct nfs4_delegation *dp;
> > > =A0	stateid_t *stateid =3D &dr->dr_stateid;
> > > =A0	struct nfs4_stid *s;
> > > +	umode_t mode;
> > > =A0	__be32 status;
> > > =A0	struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp),
> > > nfsd_net_id);
> > > =A0
> > > -	if ((status =3D fh_verify(rqstp, &cstate->current_fh,
> > > S_IFREG, 0)))
> > > +	if ((status =3D fh_verify(rqstp, &cstate->current_fh, 0,
> > > 0)))
> > > =A0		return status;
> > > =A0
> > > +	mode =3D d_inode(cstate->current_fh.fh_dentry)->i_mode &
> > > S_IFMT;
> > > +	switch(mode) {
> > > +	case S_IFREG:
> > > +	case S_IFDIR:
> > > +		break;
> > > +	case S_IFLNK:
> > > +		return nfserr_symlink;
> > > +	default:
> > > +		return nfserr_inval;
> > > +	}
> > > +
> >=20
> > RFC 8881 Section 15.2 does not list NFS4ERR_SYMLINK among the
> > valid status codes for the DELEGRETURN operation. Maybe the naked
> > fh_verify() call has gotten it wrong all these years...?
>=20
> The WANT_DELEGATION operation allows the server to hand out delegations
> for aggressive caching of symlinks. It is not an error to return that
> delegation using DELEGRETURN.
>=20
> Furthermore, provided that the presented stateid is actually valid, it
> is also sufficient to uniquely identify the file to which it is
> associated (see RFC8881 Section 8.2.4), so the filehandle should be
> considered mostly irrelevant for operations like DELEGRETURN.
>=20

Ok. I think we can probably just drop the switch altogether. We already
don't validate that the stateid is associated with current_fh, AFAICT.
It looks possible to send a valid stateid alongside an FH that refers to
a completely different file, and we'll just accept it.

--=20
Jeff Layton <jlayton@kernel.org>

