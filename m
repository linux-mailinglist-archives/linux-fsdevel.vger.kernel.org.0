Return-Path: <linux-fsdevel+bounces-76803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOw2EGGOimmwLwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 02:48:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A086B116110
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 02:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4203830191BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E632848AA;
	Tue, 10 Feb 2026 01:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Lev8E5oj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JwPTxXjD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8306D35898;
	Tue, 10 Feb 2026 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770688083; cv=none; b=KVO2ef5EMJmrd0cZg3j8vJz8vj5Yp9RgImp8yxX5jB2Jp0aCfJyHgXgDIr/WHeTD6zbZ8OcizCyS4cwS35KUjrU2cBCinWn0oCqSMU8lepdQuV+10pA39uiU59tYijd0JLErKuIg1O7lNxpm3nmbQBTbG8UL6B6zmlSIko/SvPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770688083; c=relaxed/simple;
	bh=LQ8tVo1hmvmy9ebQfFxGIjrw5yO5LUREWtfRdgdwcus=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=GG1u0RHosbpFldswD2LAlGZ1MaRZYODAwBUm8wVuDT0+uzP5+w6Kuu7yqLODF008+XlEMPdDwXG/5Kw0oU/TaV006E4HD/z0zOrz7rl05wt0VcLkpqcmSc8QZa5e9kY8/lDGj1cF87/sDDnA8VqBr9DczbykHHXtR5nW/PxFahg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Lev8E5oj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JwPTxXjD; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9042E14001BA;
	Mon,  9 Feb 2026 20:47:59 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 09 Feb 2026 20:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1770688079; x=1770774479; bh=aTU/cRbpcMcDn6zYJqQZgveNsh4OG8IZIS6
	VftMjRwo=; b=Lev8E5ojaEx3avzr47XPvz6U3Q1SH904zSJET1WoRH5JWv3oldv
	Pzs7qUfYLPLAOISNIL5Xr1Tw6/8HZMOxqENNbRRE7Dp2Zgjzj0Ur2/3/1+PGo59Y
	FBzjeNXn0bzRJkvOx35gEQWX/H65OnFiOX11hhajUeJDMdt/G2n4DFjYjp91Z7O9
	LtY4kaxT4FgdMGgAiiBkqsLyjHFAIrTM3ett0n6ZPtscUG2FsHXSCJr66jmDIueH
	NCTGvUbOE1ZPo9wpOoFS9IxGARI/kamLQ9TH1ZacR/l5UtYILGJrsUs9aXnuKd1i
	uv3vwy9DNj/Vq4NRYg/KQ04wsksZ1DICVGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770688079; x=
	1770774479; bh=aTU/cRbpcMcDn6zYJqQZgveNsh4OG8IZIS6VftMjRwo=; b=J
	wPTxXjD2VOkrKSIoqIwSTzbA9obJNqgj+ZWgXosu7iEq8haxJSC8e/oP3j2M5kVY
	m++YkoYxhsQulQjrMCGYxFJ7Vjsdnh25Tm80PfS0Hcbs+4YQlu/aIaIfWPzYCpeh
	tkcT0l02I7iAqNeGogAvYlOENAeCVL1vynTy4mllHO9RaWkkK7O7i8MvnN87aZOV
	i1YYzt3suJ2GFZQTFB2uSxBeOuS0Lpuk3DEadUyfok1xkwyZKJkb2CscLFw0zxQf
	q/MDVXhEbWZwbJOXcNIbLtAzdwUhr6nK7ye4HeFtcPS2Dxry4reatRGxo2Rfua3l
	gQt4MzKWzms0dErKb4fbQ==
X-ME-Sender: <xms:T46KaRFLZZNE5YaDh0cgBZ5nEZW8_p_o1n3DmaMuwFnEdBDDxV69aw>
    <xme:T46KacWzQI5irySz55KWWSvjE8mBfJGVv4C1oZhiIsuUP1orBw7OWKPlxTXFBC-rE
    MEDlfhM0v4jTSeb8m1ZrF0Na_Bwy9ALhcXNvvKaUhQ-eKE5iQ>
X-ME-Received: <xmr:T46Kad_xa9a9xijWYTkU-Qtp0XHQ995qQEZKjvM-AbaS269g_hS3j0uIgyyj53gIWk-aKL3aaxprrQ5j34rCUPrhJbf-zQkMG0QJu8kBSiEO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleekgedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:T46KaZ5mSmXPjgufGFn_SpH2iNL7Ulb9QZiZtPYsw5GrU9LRpJ9LaA>
    <xmx:T46KaWlnAiAHZP4zoEH7XfC7XFSXAl6X-UNJ17Ko606AQ7KVl2VK-g>
    <xmx:T46KacHjMo_03gMsKWFwRJPRiXwDquAKBkGq21E5WzMucn9Xrloz1g>
    <xmx:T46Kad-ihPxCK2cMaCR78yoOudb9AhUf3WC5vz_nq6lJA4Lf0d9vjA>
    <xmx:T46KaQYXOx44ihb1cN99adTp_ASqMnrsDpPir9puHmmFkjC90pdaHh7P>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 20:47:56 -0500 (EST)
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
Subject: Re: [PATCH v4 1/3] NFSD: Add a key for signing filehandles
In-reply-to: =?utf-8?q?=3C09698b80d78c7c0a8709967f0f3cf103b3ddad9d=2E1770390?=
 =?utf-8?q?036=2Egit=2Ebcodding=40hammerspace=2Ecom=3E?=
References: <cover.1770390036.git.bcodding@hammerspace.com>, =?utf-8?q?=3C09?=
 =?utf-8?q?698b80d78c7c0a8709967f0f3cf103b3ddad9d=2E1770390036=2Egit=2Ebcodd?=
 =?utf-8?q?ing=40hammerspace=2Ecom=3E?=
Date: Tue, 10 Feb 2026 12:47:52 +1100
Message-id: <177068807252.16766.7681820155678057342@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76803-lists,linux-fsdevel=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,hammerspace.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,noble.neil.brown.name:mid,brown.name:replyto,ownmail.net:dkim]
X-Rspamd-Queue-Id: A086B116110
X-Rspamd-Action: no action

On Sat, 07 Feb 2026, Benjamin Coddington wrote:
> A future patch will enable NFSD to sign filehandles by appending a Message
> Authentication Code(MAC).  To do this, NFSD requires a secret 128-bit key
> that can persist across reboots.  A persisted key allows the server to
> accept filehandles after a restart.  Enable NFSD to be configured with this
> key the netlink interface.
>=20
> Link: https://lore.kernel.org/linux-nfs/cover.1770390036.git.bcodding@hamme=
rspace.com
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---
>  Documentation/netlink/specs/nfsd.yaml |  6 +++++
>  fs/nfsd/netlink.c                     |  5 ++--
>  fs/nfsd/netns.h                       |  2 ++
>  fs/nfsd/nfsctl.c                      | 37 ++++++++++++++++++++++++++-
>  fs/nfsd/trace.h                       | 25 ++++++++++++++++++
>  include/uapi/linux/nfsd_netlink.h     |  1 +
>  6 files changed, 73 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/=
specs/nfsd.yaml
> index f87b5a05e5e9..8ab43c8253b2 100644
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
>        doc: get the maximum number of running threads
> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index 887525964451..4e08c1a6b394 100644
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
> +		.maxattr	=3D NFSD_A_SERVER_MAX,
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
> index a58eb1adac0f..55af3e403750 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1571,6 +1571,31 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *sk=
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
> +	siphash_key_t *fh_key =3D nn->fh_key;
> +
> +	if (nla_len(attr) !=3D sizeof(siphash_key_t))
> +		return -EINVAL;
> +
> +	if (!fh_key) {
> +		fh_key =3D kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
> +		if (!fh_key)
> +			return -ENOMEM;
> +		nn->fh_key =3D fh_key;
> +	}
> +	put_unaligned_le64(fh_key->key[0], nla_data(attr));
> +	put_unaligned_le64(fh_key->key[0], nla_data(attr));

Should the second one be [1], or is a comment needs to explain some
subtlety?

Otherwise this looks sensible.

NeilBrown


> +	return 0;
> +}
> +
>  /**
>   * nfsd_nl_threads_set_doit - set the number of running threads
>   * @skb: reply buffer
> @@ -1612,7 +1637,8 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, str=
uct genl_info *info)
> =20
>  	if (info->attrs[NFSD_A_SERVER_GRACETIME] ||
>  	    info->attrs[NFSD_A_SERVER_LEASETIME] ||
> -	    info->attrs[NFSD_A_SERVER_SCOPE]) {
> +	    info->attrs[NFSD_A_SERVER_SCOPE] ||
> +	    info->attrs[NFSD_A_SERVER_FH_KEY]) {
>  		ret =3D -EBUSY;
>  		if (nn->nfsd_serv && nn->nfsd_serv->sv_nrthreads)
>  			goto out_unlock;
> @@ -1641,6 +1667,14 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, st=
ruct genl_info *info)
>  		attr =3D info->attrs[NFSD_A_SERVER_SCOPE];
>  		if (attr)
>  			scope =3D nla_data(attr);
> +
> +		attr =3D info->attrs[NFSD_A_SERVER_FH_KEY];
> +		if (attr) {
> +			ret =3D nfsd_nl_fh_key_set(attr, nn);
> +			trace_nfsd_ctl_fh_key_set((const char *)nn->fh_key, ret);
> +			if (ret)
> +				goto out_unlock;
> +		}
>  	}
> =20
>  	attr =3D info->attrs[NFSD_A_SERVER_MIN_THREADS];
> @@ -2240,6 +2274,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
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


