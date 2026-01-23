Return-Path: <linux-fsdevel+bounces-75319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DUOLVb1c2ny0AAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 23:25:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E347B236
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 23:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FC8D30293F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 22:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E270C28850E;
	Fri, 23 Jan 2026 22:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="SGRHhydQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aqUEeS8g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE2E27FB1C;
	Fri, 23 Jan 2026 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769207086; cv=none; b=lmOeOk8kzwxmb0pplamYb7XQc/Qk5Y7gbOtDPK/71QcWf2uIE5OuAq4Lm2EsZecTVBzmX9YorAejtyDPtcQ2YlPDVIgPEVU09F6Jwtb4/JuD7f3/i0lS0joRxVcS9mGJZmgbIWV0Aivj+pTNRZifVRlqnHfff5HCKsAsx+LrvLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769207086; c=relaxed/simple;
	bh=jU4naThy7W9m03WESVkb4OU0rCwEzFRmMpBq/sWgAs4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=tPO72THrNeJHI3XXKIcb0J14bIt9nZfAG5qau8oegtWUe1Rn0/l6RC2M563893IQUcD7gQM9yj8ftJeoXy9C9bbJ/w/4LnqTBiZ9AWuLolw2nPK3FlaOSBelozfo5N3z0gSMRhd+2tJDzYsV3BVBQr1buHxT9wswfvradoX8s9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=SGRHhydQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aqUEeS8g; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 84AA3EC0110;
	Fri, 23 Jan 2026 17:24:43 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 23 Jan 2026 17:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1769207083; x=1769293483; bh=H5Wo4f2P0pvyNzEnErQ2N0bc+vOhq89iMy9
	1M4thB+Q=; b=SGRHhydQVp5zRkiguAcCPSnnompY3MMWeSMSLGFY4wDZdDyJHrH
	8R9LMSXTeCoSshpvZlzHN/9cm/bG9Ghk7v8ET6dRdqmcYOJuzx2TpYV8UmDu6LgK
	7yjaLP2TnWlOR6pXqN4lM8TB2ZyWnhzeh9HQLyRW3SewVGt4nXz/MHbfxlJck3h6
	nwQ4imuW97GghEYL8KaNGw6QzxldBz91PvTSxkCU0/rfDXxWCwNsmk3mmgLnJFpx
	HstPTPiXYMp72gBrMvuD5F/fGCuoqTWufn+T8qKUy9hj5RBnblOKraWybPKcwGp2
	sbgssW3Tyo5bBTw5Fpo9zXi4HSzkLrqgOeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769207083; x=
	1769293483; bh=H5Wo4f2P0pvyNzEnErQ2N0bc+vOhq89iMy91M4thB+Q=; b=a
	qUEeS8giphGFH2p8+TcmCO6yANAnPmg2eihcQIqd5g8c0QS/H4Kah4N4HlC+xbqK
	t4zAurpKf4FNDKYRi/f6BtdJrZjcbnXrMssHTxEBGP3GZRvpF6i52B/OJLJRbK5w
	i2YRP1eN0+dLbOYd1Ex0bf08n6OqHt4OuyF5gOdtWyjiFhcUcoEAhHTQImMJK60v
	koTWxOBkDlop9vyFNIgHSdPssEYo3EJV8be/fZy5Jei6hUrNoZmoGB5gsjtDlJ3W
	tLBRxZX7UuqEH4sfdbWX1KTzj3lDtd4EhJ4mh6lMT4AFeXPhLmPBoCLg2OnA6tV5
	IuZiD/ydRMjmJtWxqmSEg==
X-ME-Sender: <xms:K_VzaYfQmOfvCuPTSgoYw4V1e2oMa9Qdf-myO9LJV9MXCTDUxc41xQ>
    <xme:K_VzaXl8nsnx5Sa1SWzBu5UTixedkcBBHJb1ttLpu2dEFYaE7YeY6Bpd99pSvidBy
    BEp2Hnkh3lUC-qdWjN5tgypEmGGcTWG4-8ejbYDOqBkNP5TpcY>
X-ME-Received: <xmr:K_VzaTDGTayb1wHSukWHUKluQ6TdHlXenoV2tRdfMCpoMJPXykgbTiwo-LZX-mPos3zvkxxknukr1YbWFW0XYhnOTHp-Eabd-k40_mzjtrcJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduhedtvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugi
    dqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhf
    shguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqtghrhihpthhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhuhgt
    khdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepthhrohhnughmhieskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepvggsihhgghgvrhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggtohguughinhhgsehhrghm
    mhgvrhhsphgrtggvrdgtohhm
X-ME-Proxy: <xmx:K_VzaZNE5xrJdG4hht0zyfDfAqsZuqrdUNhrrzWVrEKjJ_y5WciuhQ>
    <xmx:K_VzaaPKEFCBDdZq8LeiqmEt15Qsg8pfEfOplI2W-u_n30el-iZYhw>
    <xmx:K_VzaRn9xkxRWZ6IxWiv2FdMjgGMRf_rpCwGvgve_tEWlwwF5Bwt_w>
    <xmx:K_VzaYsMD3AlwsovVfwFVuIlAq-Ai3cynpAYCPBwun4P6KBzsATs8Q>
    <xmx:K_VzaWKjr9ITigNZ2zMJoY3rIFxq18oacspLP7GdAXxeVk0P-hHobTqT>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 17:24:40 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Benjamin Coddington" <bcodding@hammerspace.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Eric Biggers" <ebiggers@kernel.org>, "Rick Macklem" <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 1/3] NFSD: Add a key for signing filehandles
In-reply-to: =?utf-8?q?=3C6d7bfccbaf082194ea257749041c19c2c2385cce=2E1769026?=
 =?utf-8?q?777=2Egit=2Ebcodding=40hammerspace=2Ecom=3E?=
References: <cover.1769026777.git.bcodding@hammerspace.com>, =?utf-8?q?=3C6d?=
 =?utf-8?q?7bfccbaf082194ea257749041c19c2c2385cce=2E1769026777=2Egit=2Ebcodd?=
 =?utf-8?q?ing=40hammerspace=2Ecom=3E?=
Date: Sat, 24 Jan 2026 09:24:38 +1100
Message-id: <176920707852.16766.4790063070167605541@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75319-lists,linux-fsdevel=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,hammerspace.com,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,noble.neil.brown.name:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:dkim,hammerspace.com:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 11E347B236
X-Rspamd-Action: no action

On Thu, 22 Jan 2026, Benjamin Coddington wrote:
> A future patch will enable NFSD to sign filehandles by appending a Message
> Authentication Code(MAC).  To do this, NFSD requires a secret 128-bit key
> that can persist across reboots.  A persisted key allows the server to
> accept filehandles after a restart.  Enable NFSD to be configured with this
> key via both the netlink and nfsd filesystem interfaces.
>=20
> Since key changes will break existing filehandles, the key can only be set
> once.  After it has been set any attempts to set it will return -EEXIST.
>=20
> Link: https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@hamme=
rspace.com
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---
>  Documentation/netlink/specs/nfsd.yaml |  6 ++
>  fs/nfsd/netlink.c                     |  5 +-
>  fs/nfsd/netns.h                       |  2 +
>  fs/nfsd/nfsctl.c                      | 94 +++++++++++++++++++++++++++
>  fs/nfsd/trace.h                       | 25 +++++++
>  include/uapi/linux/nfsd_netlink.h     |  1 +
>  6 files changed, 131 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/=
specs/nfsd.yaml
> index badb2fe57c98..d348648033d9 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml
> @@ -81,6 +81,11 @@ attribute-sets:
>        -
>          name: min-threads
>          type: u32
> +      -
> +        name: fh-key
> +        type: binary
> +        checks:
> +            exact-len: 16
>    -
>      name: version
>      attributes:
> @@ -163,6 +168,7 @@ operations:
>              - leasetime
>              - scope
>              - min-threads
> +            - fh-key
>      -
>        name: threads-get
>        doc: get the number of running threads
> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index 887525964451..81c943345d13 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c
> @@ -24,12 +24,13 @@ const struct nla_policy nfsd_version_nl_policy[NFSD_A_V=
ERSION_ENABLED + 1] =3D {
>  };
> =20
>  /* NFSD_CMD_THREADS_SET - do */
> -static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_MI=
N_THREADS + 1] =3D {
> +static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_FH=
_KEY + 1] =3D {
>  	[NFSD_A_SERVER_THREADS] =3D { .type =3D NLA_U32, },
>  	[NFSD_A_SERVER_GRACETIME] =3D { .type =3D NLA_U32, },
>  	[NFSD_A_SERVER_LEASETIME] =3D { .type =3D NLA_U32, },
>  	[NFSD_A_SERVER_SCOPE] =3D { .type =3D NLA_NUL_STRING, },
>  	[NFSD_A_SERVER_MIN_THREADS] =3D { .type =3D NLA_U32, },
> +	[NFSD_A_SERVER_FH_KEY] =3D NLA_POLICY_EXACT_LEN(16),
>  };
> =20
>  /* NFSD_CMD_VERSION_SET - do */
> @@ -58,7 +59,7 @@ static const struct genl_split_ops nfsd_nl_ops[] =3D {
>  		.cmd		=3D NFSD_CMD_THREADS_SET,
>  		.doit		=3D nfsd_nl_threads_set_doit,
>  		.policy		=3D nfsd_threads_set_nl_policy,
> -		.maxattr	=3D NFSD_A_SERVER_MIN_THREADS,
> +		.maxattr	=3D NFSD_A_SERVER_FH_KEY,

Please make this NFSD_A_SERVER_MAX


>  		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>  	},
>  	{
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 9fa600602658..c8ed733240a0 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -16,6 +16,7 @@
>  #include <linux/percpu-refcount.h>
>  #include <linux/siphash.h>
>  #include <linux/sunrpc/stats.h>
> +#include <linux/siphash.h>
> =20
>  /* Hash tables for nfs4_clientid state */
>  #define CLIENT_HASH_BITS                 4
> @@ -224,6 +225,7 @@ struct nfsd_net {
>  	spinlock_t              local_clients_lock;
>  	struct list_head	local_clients;
>  #endif
> +	siphash_key_t		*fh_key;
>  };
> =20
>  /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 30caefb2522f..e59639efcf5c 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -49,6 +49,7 @@ enum {
>  	NFSD_Ports,
>  	NFSD_MaxBlkSize,
>  	NFSD_MinThreads,
> +	NFSD_Fh_Key,
>  	NFSD_Filecache,
>  	NFSD_Leasetime,
>  	NFSD_Gracetime,
> @@ -69,6 +70,7 @@ static ssize_t write_versions(struct file *file, char *bu=
f, size_t size);
>  static ssize_t write_ports(struct file *file, char *buf, size_t size);
>  static ssize_t write_maxblksize(struct file *file, char *buf, size_t size);
>  static ssize_t write_minthreads(struct file *file, char *buf, size_t size);
> +static ssize_t write_fh_key(struct file *file, char *buf, size_t size);
>  #ifdef CONFIG_NFSD_V4
>  static ssize_t write_leasetime(struct file *file, char *buf, size_t size);
>  static ssize_t write_gracetime(struct file *file, char *buf, size_t size);
> @@ -88,6 +90,7 @@ static ssize_t (*const write_op[])(struct file *, char *,=
 size_t) =3D {
>  	[NFSD_Ports] =3D write_ports,
>  	[NFSD_MaxBlkSize] =3D write_maxblksize,
>  	[NFSD_MinThreads] =3D write_minthreads,
> +	[NFSD_Fh_Key] =3D write_fh_key,
>  #ifdef CONFIG_NFSD_V4
>  	[NFSD_Leasetime] =3D write_leasetime,
>  	[NFSD_Gracetime] =3D write_gracetime,
> @@ -950,6 +953,60 @@ static ssize_t write_minthreads(struct file *file, cha=
r *buf, size_t size)
>  	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", minthreads);
>  }
> =20
> +/*
> + * write_fh_key - Set or report the current NFS filehandle key, the key
> + * 		can only be set once, else -EEXIST because changing the key
> + * 		will break existing filehandles.
> + *
> + * Input:
> + *			buf:		ignored
> + *			size:		zero
> + * OR
> + *
> + * Input:
> + *			buf:		C string containing a parseable UUID
> + *			size:		non-zero length of C string in @buf
> + * Output:
> + *	On success:	passed-in buffer filled with '\n'-terminated C string
> + *			containing the standard UUID format of the server's fh_key
> + *			return code is the size in bytes of the string
> + *	On error:	return code is zero or a negative errno value
> + */
> +static ssize_t write_fh_key(struct file *file, char *buf, size_t size)
> +{
> +	struct nfsd_net *nn =3D net_generic(netns(file), nfsd_net_id);
> +	int ret =3D -EEXIST;
> +
> +	if (size > 35 && size < 38) {

I know Chuck wants you to drop this, so maybe this comment isn't
relevant, but those two magic numbers need an explanation.
Though
        if (size =3D=3D 36 || size =3D=3D 37) {
would mean the samr thing and be a little clearer.

Thanks,
NeilBrown


> +		siphash_key_t *sip_fh_key;
> +		uuid_t uuid_fh_key;
> +
> +		mutex_lock(&nfsd_mutex);
> +
> +		/* Is the key already set? */
> +		if (nn->fh_key)
> +			goto out;
> +
> +		ret =3D uuid_parse(buf, &uuid_fh_key);
> +		if (ret)
> +			goto out;
> +
> +		sip_fh_key =3D kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
> +		if (!sip_fh_key) {
> +			ret =3D -ENOMEM;
> +			goto out;
> +		}
> +
> +		memcpy(sip_fh_key, &uuid_fh_key, sizeof(siphash_key_t));
> +		nn->fh_key =3D sip_fh_key;
> +	}
> +	ret =3D scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%pUb\n", nn->fh_key);
> +out:
> +	mutex_unlock(&nfsd_mutex);
> +	trace_nfsd_ctl_fh_key_set((const char *)nn->fh_key, ret);
> +	return ret;
> +}
> +
>  #ifdef CONFIG_NFSD_V4
>  static ssize_t __nfsd4_write_time(struct file *file, char *buf, size_t siz=
e,
>  				  time64_t *time, struct nfsd_net *nn)
> @@ -1343,6 +1400,7 @@ static int nfsd_fill_super(struct super_block *sb, st=
ruct fs_context *fc)
>  		[NFSD_Ports] =3D {"portlist", &transaction_ops, S_IWUSR|S_IRUGO},
>  		[NFSD_MaxBlkSize] =3D {"max_block_size", &transaction_ops, S_IWUSR|S_IRU=
GO},
>  		[NFSD_MinThreads] =3D {"min_threads", &transaction_ops, S_IWUSR|S_IRUGO},
> +		[NFSD_Fh_Key] =3D {"fh_key", &transaction_ops, S_IWUSR|S_IRUSR},
>  		[NFSD_Filecache] =3D {"filecache", &nfsd_file_cache_stats_fops, S_IRUGO},
>  #ifdef CONFIG_NFSD_V4
>  		[NFSD_Leasetime] =3D {"nfsv4leasetime", &transaction_ops, S_IWUSR|S_IRUS=
R},
> @@ -1615,6 +1673,33 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *sk=
b,
>  	return ret;
>  }
> =20
> +/**
> + * nfsd_nl_fh_key_set - helper to copy fh_key from userspace
> + * @attr: nlattr NFSD_A_SERVER_FH_KEY
> + * @nn: nfsd_net
> + *
> + * Callers should hold nfsd_mutex, returns 0 on success or negative errno.
> + */
> +static int nfsd_nl_fh_key_set(const struct nlattr *attr, struct nfsd_net *=
nn)
> +{
> +	siphash_key_t *fh_key;
> +
> +	if (nla_len(attr) !=3D sizeof(siphash_key_t))
> +		return -EINVAL;
> +
> +	/* Is the key already set? */
> +	if (nn->fh_key)
> +		return -EEXIST;
> +
> +	fh_key =3D kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
> +	if (!fh_key)
> +		return -ENOMEM;
> +
> +	memcpy(fh_key, nla_data(attr), sizeof(siphash_key_t));
> +	nn->fh_key =3D fh_key;
> +	return 0;
> +}
> +
>  /**
>   * nfsd_nl_threads_set_doit - set the number of running threads
>   * @skb: reply buffer
> @@ -1691,6 +1776,14 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, st=
ruct genl_info *info)
>  	if (attr)
>  		nn->min_threads =3D nla_get_u32(attr);
> =20
> +	attr =3D info->attrs[NFSD_A_SERVER_FH_KEY];
> +	if (attr) {
> +		ret =3D nfsd_nl_fh_key_set(attr, nn);
> +		trace_nfsd_ctl_fh_key_set((const char *)nn->fh_key, ret);
> +		if (ret && ret !=3D -EEXIST)
> +			goto out_unlock;
> +	}
> +
>  	ret =3D nfsd_svc(nrpools, nthreads, net, get_current_cred(), scope);
>  	if (ret > 0)
>  		ret =3D 0;
> @@ -2284,6 +2377,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
>  {
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> =20
> +	kfree_sensitive(nn->fh_key);
>  	nfsd_proc_stat_shutdown(net);
>  	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
>  	nfsd_idmap_shutdown(net);
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index d1d0b0dd0545..c1a5f2fa44ab 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -2240,6 +2240,31 @@ TRACE_EVENT(nfsd_end_grace,
>  	)
>  );
> =20
> +TRACE_EVENT(nfsd_ctl_fh_key_set,
> +	TP_PROTO(
> +		const char *key,
> +		int result
> +	),
> +	TP_ARGS(key, result),
> +	TP_STRUCT__entry(
> +		__array(unsigned char, key, 16)
> +		__field(unsigned long, result)
> +		__field(bool, key_set)
> +	),
> +	TP_fast_assign(
> +		__entry->key_set =3D true;
> +		if (!key)
> +			__entry->key_set =3D false;
> +		else
> +			memcpy(__entry->key, key, 16);
> +		__entry->result =3D result;
> +	),
> +	TP_printk("key=3D%s result=3D%ld",
> +		__entry->key_set ? __print_hex_str(__entry->key, 16) : "(null)",
> +		__entry->result
> +	)
> +);
> +
>  DECLARE_EVENT_CLASS(nfsd_copy_class,
>  	TP_PROTO(
>  		const struct nfsd4_copy *copy
> diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_ne=
tlink.h
> index e9efbc9e63d8..97c7447f4d14 100644
> --- a/include/uapi/linux/nfsd_netlink.h
> +++ b/include/uapi/linux/nfsd_netlink.h
> @@ -36,6 +36,7 @@ enum {
>  	NFSD_A_SERVER_LEASETIME,
>  	NFSD_A_SERVER_SCOPE,
>  	NFSD_A_SERVER_MIN_THREADS,
> +	NFSD_A_SERVER_FH_KEY,
> =20
>  	__NFSD_A_SERVER_MAX,
>  	NFSD_A_SERVER_MAX =3D (__NFSD_A_SERVER_MAX - 1)
> --=20
> 2.50.1
>=20
>=20


