Return-Path: <linux-fsdevel+bounces-27077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BDE95E661
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 03:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB1AEB20AAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 01:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005FD79DE;
	Mon, 26 Aug 2024 01:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wDzxJkZh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S1UTwtRQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wDzxJkZh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S1UTwtRQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7333D528;
	Mon, 26 Aug 2024 01:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724636380; cv=none; b=f7KIdoFf1D8wACQVTcyb7/kwPeY7gKAPywRkvobD1nKUFbtnxnq2QhmJvwNwt+9z+FsF26XlrGTZD/dXPVB2dRrxpsxPRwwlfl1dDK2hV7Es7Rr2BfilFlU/nYwIbOKUk/DNHK6xYKtOwOwexH1iEpT5tHPMqxiFT/h7PgsEO6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724636380; c=relaxed/simple;
	bh=7K4IyGh/LxMVqDh8ReQndM3gGCwAZ2jz7oBj/Xq0/+U=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=hREk20yI1Oybw2q6AkOTMR/w7KA1cM9buLSaFh9U/3/o4ODJPLhtQPdimCKM5MrkZY+mRCD8yB3om75QbaTzC1gLHYJ6oce55YmtBHo7KahXOUV9mpJWMic06skjUAbU0cTgh1DwK5UMNfHi0xpvzjeORchUWEGP35b1t7AeS7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wDzxJkZh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S1UTwtRQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wDzxJkZh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S1UTwtRQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 897E721A49;
	Mon, 26 Aug 2024 01:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724636376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ognilqogl0irxe4RRpZpxXAsJWxI12uL/nz18jlxPL0=;
	b=wDzxJkZhpY/BPjgBNahjF9gqvqP6ndK2+ApjqxzycEeKGTf4mt+T5suv68UQuIfBCGf4Ez
	lMDQvasYdd9zphS7iVBBKjn4ohS/6iQaO/TYpqkLuwXexNnUcL6xqZs8yVaYizA3mV2ouh
	ebp9VrxtrZ5FEFnWj4Yc0DTFaQA0UZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724636376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ognilqogl0irxe4RRpZpxXAsJWxI12uL/nz18jlxPL0=;
	b=S1UTwtRQygGstSlsIam/UQ2Cvn94KXDyiKLAzEbISiAD+hTjKuY44df9A7IPxgzLVQUDMr
	X0yZevND2qrCG5Dg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wDzxJkZh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=S1UTwtRQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724636376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ognilqogl0irxe4RRpZpxXAsJWxI12uL/nz18jlxPL0=;
	b=wDzxJkZhpY/BPjgBNahjF9gqvqP6ndK2+ApjqxzycEeKGTf4mt+T5suv68UQuIfBCGf4Ez
	lMDQvasYdd9zphS7iVBBKjn4ohS/6iQaO/TYpqkLuwXexNnUcL6xqZs8yVaYizA3mV2ouh
	ebp9VrxtrZ5FEFnWj4Yc0DTFaQA0UZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724636376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ognilqogl0irxe4RRpZpxXAsJWxI12uL/nz18jlxPL0=;
	b=S1UTwtRQygGstSlsIam/UQ2Cvn94KXDyiKLAzEbISiAD+hTjKuY44df9A7IPxgzLVQUDMr
	X0yZevND2qrCG5Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FEB2139DE;
	Mon, 26 Aug 2024 01:39:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lIzHMdXcy2ZObQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 26 Aug 2024 01:39:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 15/19] pnfs/flexfiles: enable localio support
In-reply-to: <20240823181423.20458-16-snitzer@kernel.org>
References: <20240823181423.20458-1-snitzer@kernel.org>,
 <20240823181423.20458-16-snitzer@kernel.org>
Date: Mon, 26 Aug 2024 11:39:31 +1000
Message-id: <172463637116.6062.16257686016201336610@noble.neil.brown.name>
X-Rspamd-Queue-Id: 897E721A49
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Sat, 24 Aug 2024, Mike Snitzer wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> If the DS is local to this client use localio to write the data.
>=20
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/flexfilelayout/flexfilelayout.c    | 136 +++++++++++++++++++++-
>  fs/nfs/flexfilelayout/flexfilelayout.h    |   2 +
>  fs/nfs/flexfilelayout/flexfilelayoutdev.c |   6 +
>  3 files changed, 140 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout=
/flexfilelayout.c
> index 01ee52551a63..d91b640f6c05 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> @@ -11,6 +11,7 @@
>  #include <linux/nfs_mount.h>
>  #include <linux/nfs_page.h>
>  #include <linux/module.h>
> +#include <linux/file.h>
>  #include <linux/sched/mm.h>
> =20
>  #include <linux/sunrpc/metrics.h>
> @@ -162,6 +163,72 @@ decode_name(struct xdr_stream *xdr, u32 *id)
>  	return 0;
>  }
> =20
> +/*
> + * A dummy definition to make RCU (and non-LOCALIO compilation) happy.
> + * struct nfsd_file should never be dereferenced in this file.
> + */
> +struct nfsd_file {
> +       int undefined__;
> +};

I removed this and tried building both with and without LOCALIO enabled
and the compiler didn't complain.
Could you tell me what to do to see the unhappiness you mention?


> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h b/fs/nfs/flexfilelayout=
/flexfilelayout.h
> index f84b3fb0dddd..562e7e27a8b5 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.h
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.h
> @@ -82,7 +82,9 @@ struct nfs4_ff_layout_mirror {
>  	struct nfs_fh			*fh_versions;
>  	nfs4_stateid			stateid;
>  	const struct cred __rcu		*ro_cred;
> +	struct nfsd_file __rcu		*ro_file;
>  	const struct cred __rcu		*rw_cred;
> +	struct nfsd_file __rcu		*rw_file;

What is the lifetime of a layout_mirror?  Does it live for longer than a
single IO request?  If so we have a problem as this will pin the
nfsd_file until the layout is returned.


Thanks,
NeilBrown

