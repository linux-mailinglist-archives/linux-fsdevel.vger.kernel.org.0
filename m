Return-Path: <linux-fsdevel+bounces-75038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGU7B8k7cmlMfAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:01:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF2E6840A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FF058C21C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 13:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4046E322B99;
	Thu, 22 Jan 2026 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlCXNBDk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B482F1FE3;
	Thu, 22 Jan 2026 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769089806; cv=none; b=p/Ict/axubCDnT58jUuYnJmHs0f6aw5EvNzuGfOPc+o14duAHchQNM2qIwUQld0aUNV5sAm1E76xyhKHR6pGj6KS3g3/qnNMtFVgTD/2vYCzS+2Yalf6dpDI6A/1bfh182DCQ9IqIE2xDBiwrhG0iQ6hbYAwmqdBnu5gq3g5c/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769089806; c=relaxed/simple;
	bh=idi9karSPfTDdyfqVjN5b6cdZpgAnAuuR+wJEVskkvU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cg6ShqRs6yxIFxyqff4x2I280P0KMwlq5/Z+7Oll3rQ45nLmLbM0eOrWilKbjWjiWlOhKhdckl1DXxTSO3+b3HumYEiV+PjzEgOqFw5YaHbs2C57eTOoaXCfbc4K84lrxs9O6mVFcEXV3MRAxx9GIt4dlgfXyAJDcHf5IajGcY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlCXNBDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22554C116C6;
	Thu, 22 Jan 2026 13:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769089806;
	bh=idi9karSPfTDdyfqVjN5b6cdZpgAnAuuR+wJEVskkvU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TlCXNBDkVY75mgUsmF/d/C2MqFtuo9MO0TIyt3DivZnoeyYt/193F9z3g3czzVpAb
	 dj+XDsobUnuEO/Vxzq3w3Di2CCXVO9mozg+DSpVt8exJWEnT8UkF6SIG647NqK7NwP
	 50I1+AYZVHW8jDMhXX3m0Nvf8ODfqcgQ77IS3mWjlDXIFLHsJ+N6PiOteb3MkMhYYW
	 /2z67fm8slHwPp2/ULVqIR5f+LZG+yhssEFS9UC1owpu2yf6aPSKy5bQkv3smzezM4
	 xyOdrhyVTGuW/Cr91Ck/ppX8TPxAzFgfwWuLqmj/mbGSpg+PnH/U9XQCp1brjST62S
	 drEHWMQKtvpmA==
Message-ID: <bf6b833c5cf45da96df4349ab318a597e5189c83.camel@kernel.org>
Subject: Re: [PATCH v2 1/3] NFSD: Add a key for signing filehandles
From: Jeff Layton <jlayton@kernel.org>
To: Benjamin Coddington <bcodding@hammerspace.com>
Cc: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>,  Eric Biggers <ebiggers@kernel.org>, Rick
 Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Date: Thu, 22 Jan 2026 08:50:04 -0500
In-Reply-To: <989656C1-F190-4F58-AB82-974F63551C26@hammerspace.com>
References: <cover.1769026777.git.bcodding@hammerspace.com>
	 <6d7bfccbaf082194ea257749041c19c2c2385cce.1769026777.git.bcodding@hammerspace.com>
	 <e299b7c6-9d37-4ffe-8d45-a95d92e33406@app.fastmail.com>
	 <0D5F8EA8-D77E-4F56-9EA6-8D6FC2F2CD37@hammerspace.com>
	 <9c5e9e07-b370-4c71-9dd6-8b6a3efe32c7@kernel.org>
	 <5EBC1684-ECA5-497A-8892-9317B44186EC@hammerspace.com>
	 <29aabe1c-3062-4dff-887d-805d7835912e@kernel.org>
	 <DC80A9CE-C98B-4D03-889F-90F477065FB1@hammerspace.com>
	 <d43cd682b0c51b187ba124f0c3c11ccc9d8698c8.camel@kernel.org>
	 <989656C1-F190-4F58-AB82-974F63551C26@hammerspace.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
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
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,brown.name,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75038-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bcodding:email,hammerspace.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FF2E6840A
X-Rspamd-Action: no action

On Thu, 2026-01-22 at 08:28 -0500, Benjamin Coddington wrote:
> On 22 Jan 2026, at 7:30, Jeff Layton wrote:
>=20
> > On Wed, 2026-01-21 at 20:22 -0500, Benjamin Coddington wrote:
> > > On 21 Jan 2026, at 18:55, Chuck Lever wrote:
> > >=20
> > > > On 1/21/26 5:56 PM, Benjamin Coddington wrote:
> > > > > On 21 Jan 2026, at 17:17, Chuck Lever wrote:
> > > > >=20
> > > > > > On 1/21/26 3:54 PM, Benjamin Coddington wrote:
> > > > > > > On 21 Jan 2026, at 15:43, Chuck Lever wrote:
> > > > > > >=20
> > > > > > > > On Wed, Jan 21, 2026, at 3:24 PM, Benjamin Coddington wrote=
:
> > > > > > > > > A future patch will enable NFSD to sign filehandles by ap=
pending a Message
> > > > > > > > > Authentication Code(MAC).  To do this, NFSD requires a se=
cret 128-bit key
> > > > > > > > > that can persist across reboots.  A persisted key allows =
the server to
> > > > > > > > > accept filehandles after a restart.  Enable NFSD to be co=
nfigured with this
> > > > > > > > > key via both the netlink and nfsd filesystem interfaces.
> > > > > > > > >=20
> > > > > > > > > Since key changes will break existing filehandles, the ke=
y can only be set
> > > > > > > > > once.  After it has been set any attempts to set it will =
return -EEXIST.
> > > > > > > > >=20
> > > > > > > > > Link:
> > > > > > > > > https://lore.kernel.org/linux-nfs/cover.1769026777.git.bc=
odding@hammerspace.com
> > > > > > > > > Signed-off-by: Benjamin Coddington <bcodding@hammerspace.=
com>
> > > > > > > > > ---
> > > > > > > > >  Documentation/netlink/specs/nfsd.yaml |  6 ++
> > > > > > > > >  fs/nfsd/netlink.c                     |  5 +-
> > > > > > > > >  fs/nfsd/netns.h                       |  2 +
> > > > > > > > >  fs/nfsd/nfsctl.c                      | 94 +++++++++++++=
++++++++++++++
> > > > > > > > >  fs/nfsd/trace.h                       | 25 +++++++
> > > > > > > > >  include/uapi/linux/nfsd_netlink.h     |  1 +
> > > > > > > > >  6 files changed, 131 insertions(+), 2 deletions(-)
> > > > > > > > >=20
> > > > > > > > > diff --git a/Documentation/netlink/specs/nfsd.yaml
> > > > > > > > > b/Documentation/netlink/specs/nfsd.yaml
> > > > > > > > > index badb2fe57c98..d348648033d9 100644
> > > > > > > > > --- a/Documentation/netlink/specs/nfsd.yaml
> > > > > > > > > +++ b/Documentation/netlink/specs/nfsd.yaml
> > > > > > > > > @@ -81,6 +81,11 @@ attribute-sets:
> > > > > > > > >        -
> > > > > > > > >          name: min-threads
> > > > > > > > >          type: u32
> > > > > > > > > +      -
> > > > > > > > > +        name: fh-key
> > > > > > > > > +        type: binary
> > > > > > > > > +        checks:
> > > > > > > > > +            exact-len: 16
> > > > > > > > >    -
> > > > > > > > >      name: version
> > > > > > > > >      attributes:
> > > > > > > > > @@ -163,6 +168,7 @@ operations:
> > > > > > > > >              - leasetime
> > > > > > > > >              - scope
> > > > > > > > >              - min-threads
> > > > > > > > > +            - fh-key
> > > > > > > > >      -
> > > > > > > > >        name: threads-get
> > > > > > > > >        doc: get the number of running threads
> > > > > > > > > diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> > > > > > > > > index 887525964451..81c943345d13 100644
> > > > > > > > > --- a/fs/nfsd/netlink.c
> > > > > > > > > +++ b/fs/nfsd/netlink.c
> > > > > > > > > @@ -24,12 +24,13 @@ const struct nla_policy
> > > > > > > > > nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1] =3D {
> > > > > > > > >  };
> > > > > > > > >=20
> > > > > > > > >  /* NFSD_CMD_THREADS_SET - do */
> > > > > > > > > -static const struct nla_policy
> > > > > > > > > nfsd_threads_set_nl_policy[NFSD_A_SERVER_MIN_THREADS + 1]=
 =3D {
> > > > > > > > > +static const struct nla_policy
> > > > > > > > > nfsd_threads_set_nl_policy[NFSD_A_SERVER_FH_KEY + 1] =3D =
{
> > > > > > > > >  	[NFSD_A_SERVER_THREADS] =3D { .type =3D NLA_U32, },
> > > > > > > > >  	[NFSD_A_SERVER_GRACETIME] =3D { .type =3D NLA_U32, },
> > > > > > > > >  	[NFSD_A_SERVER_LEASETIME] =3D { .type =3D NLA_U32, },
> > > > > > > > >  	[NFSD_A_SERVER_SCOPE] =3D { .type =3D NLA_NUL_STRING, }=
,
> > > > > > > > >  	[NFSD_A_SERVER_MIN_THREADS] =3D { .type =3D NLA_U32, },
> > > > > > > > > +	[NFSD_A_SERVER_FH_KEY] =3D NLA_POLICY_EXACT_LEN(16),
> > > > > > > > >  };
> > > > > > > > >=20
> > > > > > > > >  /* NFSD_CMD_VERSION_SET - do */
> > > > > > > > > @@ -58,7 +59,7 @@ static const struct genl_split_ops nfsd=
_nl_ops[] =3D {
> > > > > > > > >  		.cmd		=3D NFSD_CMD_THREADS_SET,
> > > > > > > > >  		.doit		=3D nfsd_nl_threads_set_doit,
> > > > > > > > >  		.policy		=3D nfsd_threads_set_nl_policy,
> > > > > > > > > -		.maxattr	=3D NFSD_A_SERVER_MIN_THREADS,
> > > > > > > > > +		.maxattr	=3D NFSD_A_SERVER_FH_KEY,
> > > > > > > > >  		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > > > > > > > >  	},
> > > > > > > > >  	{
> > > > > > > > > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > > > > > > > > index 9fa600602658..c8ed733240a0 100644
> > > > > > > > > --- a/fs/nfsd/netns.h
> > > > > > > > > +++ b/fs/nfsd/netns.h
> > > > > > > > > @@ -16,6 +16,7 @@
> > > > > > > > >  #include <linux/percpu-refcount.h>
> > > > > > > > >  #include <linux/siphash.h>
> > > > > > > > >  #include <linux/sunrpc/stats.h>
> > > > > > > > > +#include <linux/siphash.h>
> > > > > > > > >=20
> > > > > > > > >  /* Hash tables for nfs4_clientid state */
> > > > > > > > >  #define CLIENT_HASH_BITS                 4
> > > > > > > > > @@ -224,6 +225,7 @@ struct nfsd_net {
> > > > > > > > >  	spinlock_t              local_clients_lock;
> > > > > > > > >  	struct list_head	local_clients;
> > > > > > > > >  #endif
> > > > > > > > > +	siphash_key_t		*fh_key;
> > > > > > > > >  };
> > > > > > > > >=20
> > > > > > > > >  /* Simple check to find out if a given net was properly =
initialized */
> > > > > > > > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > > > > > > > index 30caefb2522f..e59639efcf5c 100644
> > > > > > > > > --- a/fs/nfsd/nfsctl.c
> > > > > > > > > +++ b/fs/nfsd/nfsctl.c
> > > > > > > > > @@ -49,6 +49,7 @@ enum {
> > > > > > > > >  	NFSD_Ports,
> > > > > > > > >  	NFSD_MaxBlkSize,
> > > > > > > > >  	NFSD_MinThreads,
> > > > > > > > > +	NFSD_Fh_Key,
> > > > > > > > >  	NFSD_Filecache,
> > > > > > > > >  	NFSD_Leasetime,
> > > > > > > > >  	NFSD_Gracetime,
> > > > > > > > > @@ -69,6 +70,7 @@ static ssize_t write_versions(struct fi=
le *file, char
> > > > > > > > > *buf, size_t size);
> > > > > > > > >  static ssize_t write_ports(struct file *file, char *buf,=
 size_t size);
> > > > > > > > >  static ssize_t write_maxblksize(struct file *file, char =
*buf, size_t
> > > > > > > > > size);
> > > > > > > > >  static ssize_t write_minthreads(struct file *file, char =
*buf, size_t
> > > > > > > > > size);
> > > > > > > > > +static ssize_t write_fh_key(struct file *file, char *buf=
, size_t size);
> > > > > > > > >  #ifdef CONFIG_NFSD_V4
> > > > > > > > >  static ssize_t write_leasetime(struct file *file, char *=
buf, size_t
> > > > > > > > > size);
> > > > > > > > >  static ssize_t write_gracetime(struct file *file, char *=
buf, size_t
> > > > > > > > > size);
> > > > > > > > > @@ -88,6 +90,7 @@ static ssize_t (*const write_op[])(stru=
ct file *,
> > > > > > > > > char *, size_t) =3D {
> > > > > > > > >  	[NFSD_Ports] =3D write_ports,
> > > > > > > > >  	[NFSD_MaxBlkSize] =3D write_maxblksize,
> > > > > > > > >  	[NFSD_MinThreads] =3D write_minthreads,
> > > > > > > > > +	[NFSD_Fh_Key] =3D write_fh_key,
> > > > > > > > >  #ifdef CONFIG_NFSD_V4
> > > > > > > > >  	[NFSD_Leasetime] =3D write_leasetime,
> > > > > > > > >  	[NFSD_Gracetime] =3D write_gracetime,
> > > > > > > > > @@ -950,6 +953,60 @@ static ssize_t write_minthreads(stru=
ct file *file,
> > > > > > > > > char *buf, size_t size)
> > > > > > > > >  	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n",=
 minthreads);
> > > > > > > > >  }
> > > > > > > > >=20
> > > > > > > > > +/*
> > > > > > > > > + * write_fh_key - Set or report the current NFS filehand=
le key, the key
> > > > > > > > > + * 		can only be set once, else -EEXIST because changing=
 the key
> > > > > > > > > + * 		will break existing filehandles.
> > > > > > > >=20
> > > > > > > > Do you really need both a /proc/fs/nfsd API and a netlink A=
PI? I
> > > > > > > > think one or the other would be sufficient, unless you have
> > > > > > > > something else in mind (in which case, please elaborate in =
the
> > > > > > > > patch description).
> > > > > > >=20
> > > > > > > Yes, some distros use one or the other.  Some try to use both=
!  Until you
> > > > > > > guys deprecate one of the interfaces I think we're stuck expa=
nding them
> > > > > > > both.
> > > > > >=20
> > > > > > Neil has said he wants to keep /proc/fs/nfsd rather indefinitel=
y, and
> > > > > > we have publicly stated we will add only to netlink unless it's
> > > > > > unavoidable. I prefer not growing the legacy API.
> > > > >=20
> > > > > Having both is more complete, and doesn't introduce any conflicts=
 or
> > > > > problems.
> > > >=20
> > > > That doesn't tell me why you need it. It just says you want things =
to
> > > > be "tidy".
> > > >=20
> > > >=20
> > > > > > We generally don't backport new features like this one to stabl=
e
> > > > > > kernels, so IMO tucking this into only netlink is defensible.
> > > > >=20
> > > > > Why only netlink for this one besides your preference?
> > > >=20
> > > > You might be channeling one of your kids there.
> > >=20
> > > That's unnecessary.
> > >=20
> > > > As I stated before: we have said we don't want to continue adding
> > > > new APIs to procfs. It's not just NFSD that prefers this, it's a lo=
ng
> > > > term project across the kernel. If you have a clear technical reaso=
n
> > > > that a new procfs API is needed, let's hear it.
> > >=20
> > > You've just added one to your nfsd-testing branch two weeks ago that =
you
> > > asked me to rebase onto.
> > >=20
> >=20
> > Mea culpa. I probably should have dropped the min-threads procfile from
> > those patches, but it was convenient when I was doing the development
> > work. Chuck, if you like I can send a patch to remove it before the
> > merge window.
> >=20
> > I can't see why we need both interfaces. The old /proc interface is
> > really for the case where you have old nfs-utils and/or an old kernel.
> > In order to use this, you need both new nfs-utils and new kernel. If
> > you have those, then both should support the netlink interface.
>=20
> I'm not trying to win an argument about how I want it, but I want to just
> point out one more thing: its possible to have products built out of the
> server where the tooling so far hasn't been taught to use nfsdctl yet.
> We're in that situation - we will backport the kernel bits here, and use =
the
> /proc interface because the tooling hasn't been converted to nfsdctl yet.
>=20
> > > > > There's a very good reason for both interfaces - there's been no =
work to
> > > > > deprecate the old interface or co-ordination with distros to ensu=
re they
> > > > > have fully adopted the netlink interface.  Up until now new featu=
res have
> > > > > been added to both interfaces.
> > > >=20
> > > > I'm not seeing how this is a strong and specific argument for inclu=
ding
> > > > a procfs version of this specific interface. It's still saying "tid=
y" to
> > > > me and not explaining why we must have the extra clutter.
> > > >=20
> > > > An example of a strong technical reason would be "We have legacy us=
er
> > > > space applications that expect to find this API in procfs."
> > >=20
> > > The systemd startup for the nfs-server in RHEL falls back to rpc.nfsd=
 on
> > > nfsdctl failure.  Without the additional interface you can have syste=
ms that
> > > start the nfs-server via rpc.nfsd without setting the key - exactly t=
he
> > > situation you're so adamant should never happen in your below argumen=
t..
> > >=20
> >=20
> > The main reason it would fail is because the kernel doesn't support the
> > netlink interface (or e.g. nfsdctl isn't present at all). If it fails
> > with the netlink interface for some other reason, it's quite likely to
> > have the same failure with procfs.
>=20
> You're right, but it also could fail for any number of other reasons -
> admittedly unlikely ones.
>=20
> > To be clear, the procfs interface is categorically inferior due to its
> > piecemeal nature. There's little guidance as to how to the changes in
> > nfsdfs should be ordered. We mostly make it work, but the cracks were
> > showing in those interfaces long before. We really don't want to be
> > expanding it.
>=20
> I understand.  I'll remove the procfs interface here on the next posting,
> and thanks for chiming in here.
>=20
> One thing that is confusing with nfsdctl is that when it reports a failur=
e
> its not easy to figure out what's going wrong.  It ends up having its own
> ordering stuff - for example:
>=20
> (fresh boot)
> root@bcodding:~# nfsdctl threads 4
> nfsdctl: nfsdctl started
> nfsdctl: failed to resolve nfsd generic netlink family
> nfsdctl: nfsdctl exiting
> root@bcodding:~# modprobe nfsd
> root@bcodding:~# nfsdctl threads 4
> nfsdctl: nfsdctl started
> nfsdctl: Error: Input/output error
> nfsdctl: nfsdctl exiting
>=20
> ^^ that's an actual situation I encountered, then tried to diagnose with
> strace (no good), then had to turn on the function tracer in the kernel t=
o
> find that the error was coming from somewhere in nfs4_state_start().  I
> think something not getting set (listener?), finally I looked in the log =
and
> found:
>=20
> [   47.428237] NFSD: Failed to start, no listeners configured.
>=20
> ah - so then I knew that I had to use "autostart" before being able to us=
e
> the "threads".  Compared with rpc.nfsd in the same situation:
>=20
> root@bcodding:~# rpc.nfsd 4
> rpc.nfsd: knfsd is currently down
> rpc.nfsd: Writing version string to kernel: -2 +3
> rpc.nfsd: Created AF_INET TCP socket.
> rpc.nfsd: Created AF_INET6 TCP socket.
> rpc.nfsd: unable to interpret port name n
>=20
> .. and I know I need to configure the ports.  It also loads the module fo=
r
> me.
>=20

That's a great point. The simplest fix would be to just advise the user
to check dmesg for errors, but that's not ideal for containers.=C2=A0

In principle, we could have the kernel pass an error string back in the
netlink upcall that nfsdctl could display. The problem is that nfsd
startup is spread over a bunch of functions, so passing that string
back from the deep call stack would take some refactoring.

In hindsight, I wish I had just added a single "service" netlink
command that configured everything (listeners, versions, etc.) all at
once. That would have made it a lot easier to ensure proper setup
before starting things and we could more easily catch stuff like "no
listeners" in userland before sending anything to the kernel.

I guess it's not too late to add one. We could just have nfsdctl fall
back to the old commands if necessary. It'd be a fair bit of work
though since it'd be a UAPI change.


> Would it make sense to have nfsctld load the nfsd module if the netlink
> interface doesn't exist, then on error it could also suggest checking the
> system log?
>=20

That'd be a great improvement.

> Please don't take this as me whining or complaining - just some
> observations.  Most users will never encounter these problems because the
> tooling to start the server ensures its done the right way..  So, sorry l=
ong
> read -- maybe we can eventually improve nfsdctl to have better stderr on
> failure, or maybe the problem was mine because I didn't immediately look =
in
> the log.  :P

Not at all! These are great observations.

Most users don't do anything but "autostart" and "threads 0" via
systemd, but it definitely has rough edges if you're doing things
manually. Chuck and I would welcome improvements.
--=20
Jeff Layton <jlayton@kernel.org>

