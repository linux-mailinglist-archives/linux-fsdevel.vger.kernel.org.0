Return-Path: <linux-fsdevel+bounces-27076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB5395E63A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 03:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF5B1F211CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 01:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7780728F1;
	Mon, 26 Aug 2024 01:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fI6lxZ3D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="heMNkBRm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fI6lxZ3D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="heMNkBRm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA5D635;
	Mon, 26 Aug 2024 01:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724635336; cv=none; b=gemZN+VqkbNwRxPpvKLXafyXQo2VETb9NNBBVA+jNpiC6R7KtupXpDmF6/vXIn+p2ScVnv1KHwpVSNnwV+Qa6wQgkCfSqVJPaTlv78GyCSPniZfsYpJxOcHCgrgzxLvJHOjzlHp2WEE29BlQvd5mGPUXc82IfkX2s6htyzafZyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724635336; c=relaxed/simple;
	bh=FLQP+MabxmQs6hATLDa5J7xVl6Y8V0QYRvh5DVsob6o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=rLGOMUNbR5kuOrXAK7UDcoVdAnHlt676mkpDf7TBNbz8rzlEAch+l20swj+51tIJrpBdyF3u5YgGeb42bMEFLSSlw3s6t/3WVSveJ5dqtx8DE/x08gyE+sAWWsmhieEY4TqSbbxUQ/mWi+aqkmrFkf7XicVMHpMNT36BBt6Hrbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fI6lxZ3D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=heMNkBRm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fI6lxZ3D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=heMNkBRm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6405F21A21;
	Mon, 26 Aug 2024 01:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724635333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hVNo0Y0NCPJ7KcRthLsM8ZW0pO50iXGE+YijhJff3pQ=;
	b=fI6lxZ3DrlDlzfhyjfvDempsmheyxlctFuez+qoKJO9KmrPUHtF8f41xcrD08yJbzIEib5
	J8X2+snoNQg+Gq5Vw+kMMDTyje7ekwJ/EmK5hudjmxMM2Y6h+QRZMRQkxYVw6SMCTlmTnX
	7dbYj1ezBv/LsMx50HSkYtqQRhGY4o8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724635333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hVNo0Y0NCPJ7KcRthLsM8ZW0pO50iXGE+YijhJff3pQ=;
	b=heMNkBRmOQKY9UgD2/43jvcTx6OrV1Pe/sI2JdmDeoSKIVnsXyJUUhS/N//ROis/v2+7zi
	KgdoEkAOfazhnVAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724635333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hVNo0Y0NCPJ7KcRthLsM8ZW0pO50iXGE+YijhJff3pQ=;
	b=fI6lxZ3DrlDlzfhyjfvDempsmheyxlctFuez+qoKJO9KmrPUHtF8f41xcrD08yJbzIEib5
	J8X2+snoNQg+Gq5Vw+kMMDTyje7ekwJ/EmK5hudjmxMM2Y6h+QRZMRQkxYVw6SMCTlmTnX
	7dbYj1ezBv/LsMx50HSkYtqQRhGY4o8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724635333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hVNo0Y0NCPJ7KcRthLsM8ZW0pO50iXGE+YijhJff3pQ=;
	b=heMNkBRmOQKY9UgD2/43jvcTx6OrV1Pe/sI2JdmDeoSKIVnsXyJUUhS/N//ROis/v2+7zi
	KgdoEkAOfazhnVAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F187D139DE;
	Mon, 26 Aug 2024 01:22:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8wmHKMLYy2bQaAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 26 Aug 2024 01:22:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Subject: Re: [PATCH v13 13/19] nfs: add localio support
In-reply-to: <20240823181423.20458-14-snitzer@kernel.org>
References: <20240823181423.20458-1-snitzer@kernel.org>,
 <20240823181423.20458-14-snitzer@kernel.org>
Date: Mon, 26 Aug 2024 11:21:52 +1000
Message-id: <172463531265.6062.17679380134627038117@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.936];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.29
X-Spam-Flag: NO

On Sat, 24 Aug 2024, Mike Snitzer wrote:
> +/*
> + * nfs_local_disable - disable local i/o for an nfs_client
> + */
> +void nfs_local_disable(struct nfs_client *clp)
> +{
> +	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {

This use of test_and_clear_bit() led me to think about the atomicity
requirements here.

If this were called (on a different CPU) between the
nfs_server_is_local() test in nfs_local_file_open() and the
nfs_local_open_fh() call which follows, then nfs_to.nfsd_open_local_fh()
could be passed a NULL client which wouldn't end well.

Maybe we need an rcu-protected auth_domain_tryget() in
nfsd_local_open_fh(), and the auth_domain_put() below need to be behind
call_rcu().

Or something...

> +		trace_nfs_local_disable(clp);
> +		clp->cl_nfssvc_net = NULL;
> +		if (clp->cl_nfssvc_dom) {
> +			auth_domain_put(clp->cl_nfssvc_dom);
> +			clp->cl_nfssvc_dom = NULL;
> +		}
> +	}
> +}


> +
> +struct nfsd_file *
> +nfs_local_file_open(struct nfs_client *clp, const struct cred *cred,
> +		    struct nfs_fh *fh, struct nfs_open_context *ctx)
> +{
> +	struct nfsd_file *nf;
> +
> +	if (!nfs_server_is_local(clp))
> +		return NULL;
> +
> +	nf = nfs_local_open_fh(clp, cred, fh, ctx->mode);
> +	if (IS_ERR(nf))
> +		return NULL;
> +
> +	return nf;
> +}

It isn't clear to be what nfs_local_file_open() adds any value over
nfs_local_open_fh.  The nfs_server_is_local() test is cheap and can
safely be in nfs_local_open_fh(), and the current callers of
nfs_local_file_open() can simple pass ctx->mode to _fh instead of
passing ctx to _open.

Thanks,
NeilBrown

