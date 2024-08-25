Return-Path: <linux-fsdevel+bounces-27071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7F195E5B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 01:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BEE81C20A5A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 23:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272567BB01;
	Sun, 25 Aug 2024 23:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z1qYr2e1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ynf25fZf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DK0plsvh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dHbOwWxO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20EA770F1;
	Sun, 25 Aug 2024 23:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724629504; cv=none; b=SIs6wgLdSqMo1g8NlbAVNi1E8LKePrG27/35Z3cX9kCpd5K5rsyyfORN+xipOxO7gnB4l78GpsHOZUD7/2FMzp8KN79auPqQ/cBpkxQf3awjX578o/irWntnKMcuvqKKgtbWXrW5o3h7u2ovwiUvCTKrYOBI3qcBYUbMZ5mk6mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724629504; c=relaxed/simple;
	bh=JvqXyZhjMJCcx0sH9AFyA6BwUuH3aXipFR175yGZZqU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=jAzVbvXk0W4nQGt8slpxgshEqd59ic7U2M/ocYvDs7gefHfdN0cl2LHTsFLXZ8ddrPa67iNa0IAUtLE4x79QTmpZMhfUPJyOp0C9ROLs3lUxTJPw1bsXnyCiErXqeDilje5bw6iCvA2bzWIwKAVOnda/NbkV3QNLeMnAsM5bJ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z1qYr2e1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ynf25fZf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DK0plsvh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dHbOwWxO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6EDC91F80F;
	Sun, 25 Aug 2024 23:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724629499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/sjBBsaqlCWY83uGnV+zDoVtHJsjjDXpe6cyVb3Ka4=;
	b=z1qYr2e1Ivq0I3RNQlaWYtXODDUBcCl9MRvag+8sEwgLPGF1+7C5xcD9ldHiheLQsJ/pIG
	cx4PqVGXnWSNqYJJQwMd03hMWMFqJeNael8GA+gNdXmHP8WpwDCOEwksvDmHnGUjMAQhR0
	FeBZdmyZlcCfke5j8vogJPWLA+Q7Sgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724629499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/sjBBsaqlCWY83uGnV+zDoVtHJsjjDXpe6cyVb3Ka4=;
	b=ynf25fZfXhGFPV9WwfxJiCRUas42OTE4uLHFmvg44htFILi4ALwc/cqvIngLYvQF1N/AJ3
	RjsWy5fDM15FH3Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DK0plsvh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dHbOwWxO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724629498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/sjBBsaqlCWY83uGnV+zDoVtHJsjjDXpe6cyVb3Ka4=;
	b=DK0plsvhRPJl2pVu9+0h1yYp1YDQAu2Gc2ZLAATVQvitCIN2aR/cI28MsBXOgRsV7WOByL
	MDyqTHy2e8kQiMuKLjuVuyyP/AtxD0PXdDyl4Db8XsJJPJX1QmKhlEy+9SO2Fc+UzJSA2J
	IRU6/rWCFLjs6n4sT6Vb28GgZAT6Adw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724629498;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/sjBBsaqlCWY83uGnV+zDoVtHJsjjDXpe6cyVb3Ka4=;
	b=dHbOwWxOU26DLFvLRB+SbJyF0dAXN2Cv1QZFyq1QxvDpAKMPcPdMH/0qBWzpj5/CsJ92IH
	AUsAxvY6tLEtYEBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03DE813704;
	Sun, 25 Aug 2024 23:44:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tFjYKffBy2YuTwAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 25 Aug 2024 23:44:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Mike Snitzer" <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 04/19] nfsd: factor out __fh_verify to allow NULL
 rqstp to be passed
In-reply-to: <ZstOonct0HiaRCBM@tissot.1015granger.net>
References: <>, <ZstOonct0HiaRCBM@tissot.1015granger.net>
Date: Mon, 26 Aug 2024 09:44:48 +1000
Message-id: <172462948890.6062.12952329291740788286@noble.neil.brown.name>
X-Rspamd-Queue-Id: 6EDC91F80F
X-Spam-Score: -6.50
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.19)[-0.961];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,noble.neil.brown.name:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 26 Aug 2024, Chuck Lever wrote:
> On Fri, Aug 23, 2024 at 02:14:02PM -0400, Mike Snitzer wrote:
> > +	exp =3D rqst_exp_find(rqstp ? &rqstp->rq_chandle : NULL,
> > +			    net, client, gssclient,
> >  			    fh->fh_fsid_type, fh->fh_fsid);
>=20
> Question: Would rqst_exp_find() be the function that would prevent
> a LOCALIO open to a file handle where the client's IP address is not
> listed on the export?

Yes.

>=20
> I don't really see how IP address-related export access control is
> being enforced, but it's possible I'm missing something.

The "client" is key.  The LOCALIO RPC protocol allows the server to
determine a "client" which matches the network connection.  It passes
this to the client code which uses it for future authentication.

> See comment on 5/N: since that patch makes this a public API again,
> consider not removing this kdoc comment but rather updating it.

What exactly do you consider to be a "public API"??  Anything without
"static"?  That seems somewhat arbitrary.

I think of __fh_verify() as a private API used by fh_verify() and
nfsd_file_acquire_local() and nothing else.

It seems pointless duplication the documentation for __fh_verify() and
fh_verify().  Maybe one could refer to the other "fh_verify is like
fh_verify except ....."

??

>=20
>=20
> > -__be32
> > -fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int =
access)
> > +static __be32
> > +__fh_verify(struct svc_rqst *rqstp,


Thanks,
NeilBrown

