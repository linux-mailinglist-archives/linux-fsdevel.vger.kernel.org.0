Return-Path: <linux-fsdevel+bounces-27075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D00895E61F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 02:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A228B20C8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 00:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485771FBA;
	Mon, 26 Aug 2024 00:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sDSPcFmV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FKsbO6WN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sDSPcFmV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FKsbO6WN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9F910E3;
	Mon, 26 Aug 2024 00:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724633614; cv=none; b=ARIqkjILON3dQWvVZkt3PNVKg1N1zYyDC2fvG3FYrDTujnsiJcG/NWDbuA9G/CNZPEjR6QCEep863LPfnJnH6mHoK4gHYNZjcmIZB1U09nKWmj4bZH8YEr/9WwdJcumg0tYQkplEDDGzcpNAwLOMkjI0QHlXUJrB864NIPVV63k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724633614; c=relaxed/simple;
	bh=HNJ4YvPnMq7TzmqIZ8t8wVyZ++Nwj2MWvyGrUPtPTkE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=sWML7uLVKFwizPO1OZ+xDXdeuIaVfbj/8N0B3+ISvijPvLhzaky8xTTVPZNzjJc9X2Rx4WjgzTUb+1/2f8CYh8CJoBvvG3ZWIM0kSH57woFDt/rk+VJCBM0gjxUtJaGlTNl3g6f+IVI3adOfWvuFj8+QELGpbZKhXMb4kGkFqKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sDSPcFmV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FKsbO6WN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sDSPcFmV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FKsbO6WN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D64581F815;
	Mon, 26 Aug 2024 00:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724633610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzMnmYmB8p6JrOUdnZpWMOo3VfHW/DBdbLUdeSBjK3I=;
	b=sDSPcFmV0+I+xHMl0IOA0em2yT0KbyIBeyC1seFDSbWSEFgcHV3iXiogNwlWtomyh3vcAn
	kewbF/NiC5YgFu+EZlBl+Go3+3/TVP/CCAZ+M3NxYwd1GmXJSb4+2Xdag0wBW+eGQMqdgW
	v1mIRKlbUik+gW3KNm91g178fD4FNtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724633610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzMnmYmB8p6JrOUdnZpWMOo3VfHW/DBdbLUdeSBjK3I=;
	b=FKsbO6WNr+gyVjWHrS1IrQOqfAOQJC6t5S4xPLpiSw30rr7id7J9kXCYsTz9zJmDdjSToi
	CDG0pc7TSHKjS7DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724633610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzMnmYmB8p6JrOUdnZpWMOo3VfHW/DBdbLUdeSBjK3I=;
	b=sDSPcFmV0+I+xHMl0IOA0em2yT0KbyIBeyC1seFDSbWSEFgcHV3iXiogNwlWtomyh3vcAn
	kewbF/NiC5YgFu+EZlBl+Go3+3/TVP/CCAZ+M3NxYwd1GmXJSb4+2Xdag0wBW+eGQMqdgW
	v1mIRKlbUik+gW3KNm91g178fD4FNtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724633610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzMnmYmB8p6JrOUdnZpWMOo3VfHW/DBdbLUdeSBjK3I=;
	b=FKsbO6WNr+gyVjWHrS1IrQOqfAOQJC6t5S4xPLpiSw30rr7id7J9kXCYsTz9zJmDdjSToi
	CDG0pc7TSHKjS7DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7649313724;
	Mon, 26 Aug 2024 00:53:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n5Y3CwjSy2brXwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 26 Aug 2024 00:53:28 +0000
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
Subject: Re: [PATCH v13 10/19] nfsd: add localio support
In-reply-to: <20240823181423.20458-11-snitzer@kernel.org>
References: <20240823181423.20458-1-snitzer@kernel.org>,
 <20240823181423.20458-11-snitzer@kernel.org>
Date: Mon, 26 Aug 2024 10:53:25 +1000
Message-id: <172463360544.6062.2165398603066803638@noble.neil.brown.name>
X-Spam-Score: -4.26
X-Spamd-Result: default: False [-4.26 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.16)[-0.808];
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
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 24 Aug 2024, Mike Snitzer wrote:
> +
> +	/* Save client creds before calling nfsd_file_acquire_local which calls n=
fsd_setuser */
> +	save_cred =3D get_current_cred();

I don't think this belongs here.  I would rather than
nfsd_file_acquire_local() saved and restored the cred so it could be
called without concern for internal implementation details.

> +
> +	/* nfs_fh -> svc_fh */
> +	fh_init(&fh, NFS4_FHSIZE);
> +	fh.fh_handle.fh_size =3D nfs_fh->size;
> +	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> +
> +	if (fmode & FMODE_READ)
> +		mayflags |=3D NFSD_MAY_READ;
> +	if (fmode & FMODE_WRITE)
> +		mayflags |=3D NFSD_MAY_WRITE;
> +
> +	rpcauth_map_clnt_to_svc_cred_local(rpc_clnt, cred, &rq_cred);
> +
> +	beres =3D nfsd_file_acquire_local(cl_nfssvc_net, &rq_cred, rpc_clnt->cl_v=
ers,
> +					cl_nfssvc_dom, &fh, mayflags, pnf);
> +	if (beres) {
> +		status =3D nfs_stat_to_errno(be32_to_cpu(beres));
> +		goto out_fh_put;
> +	}
> +out_fh_put:
> +	fh_put(&fh);
> +	if (rq_cred.cr_group_info)
> +		put_group_info(rq_cred.cr_group_info);
> +	revert_creds(save_cred);
> +	nfsd_serv_put(nn);

I think this is too early to be calling nfsd_serv_put().
I think it should be called when the IO completes - when=20
nfs_to.nfsd_file_put() is called.

nfs_to.nfsd_open_local_fh() and nfs_to.nfsd_file_get() should each get a ref =
to the
server.
nfsd_to.nfsd_file_put() should drop the ref.

Note that nfs_do.nfsd_file_get() would not exactly be nfsd_file_get.  So
maybe a different name would suit.

Thanks,
NeilBrown

