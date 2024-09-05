Return-Path: <linux-fsdevel+bounces-28666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0B996CC58
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 03:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDEE31F26A30
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 01:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C90BCA64;
	Thu,  5 Sep 2024 01:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M2o8Q8rD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cymQDEGW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M2o8Q8rD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cymQDEGW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C185D635;
	Thu,  5 Sep 2024 01:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725500678; cv=none; b=c1ZrFuOpQxe+ot39ojq8Hs9W7wGUMgc4BhLoGPuW3aqBJj5MdQfE+YNvMM3dJeS4nDpKFgD9Ju7Cr/4yPEhr+SOJnEzoBPrkLNtG0B+9aYZlun1APYmlTBHgYI6qdrEsnded1jzDGc//LLqLP3azl3HtJCWFZkcAVuEIM+4or8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725500678; c=relaxed/simple;
	bh=4i2uC5hyOgFUSDqHUCGYYwvnxKpRZHOaOW//nRc2gEw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=cIYLHrsKnOFMPS+gSvCiPuWoDoMY5HWBxD2IsHItVPSMAWeomyzBE/v4zTSfXtXuxSKyFAO+qhE6KUJqMxnDuqpGU4MIAWYhURw46DOQR89SV/RINQ0YUMUIUYxLXz1bQqvgIcUr1Xk9LGiWjpRnlZlwjC9PUd+X4Jc/96vqiFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M2o8Q8rD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cymQDEGW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M2o8Q8rD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cymQDEGW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BFB9221A61;
	Thu,  5 Sep 2024 01:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725500674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTi9sXVnnFjpBjJesi3UR5hVhx3v23LG1PtFEXVp71M=;
	b=M2o8Q8rDpHawI0s0xyHhyMrU/jTAeOpjnySxF2k+3kObyLvGCj1hHYvz9OSNzhHsqHtWZJ
	LBabVtViKA+9jI1QYjkgg9AjGPKO5nkSu/hmZEd3JP/HxGi9ioVCJ4HC6z1JGSDWLPZBrJ
	xVO9I3Wk0miDpAUPMLNwbV2eDIWvHAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725500674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTi9sXVnnFjpBjJesi3UR5hVhx3v23LG1PtFEXVp71M=;
	b=cymQDEGWOADoKN1LyZ03d1GlVDNw0dRcXfrSODgwuzUAHuPCr3kGQ1Ns9kUzE3kITnGhjo
	Iq7YTdPKKll+VAAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=M2o8Q8rD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cymQDEGW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725500674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTi9sXVnnFjpBjJesi3UR5hVhx3v23LG1PtFEXVp71M=;
	b=M2o8Q8rDpHawI0s0xyHhyMrU/jTAeOpjnySxF2k+3kObyLvGCj1hHYvz9OSNzhHsqHtWZJ
	LBabVtViKA+9jI1QYjkgg9AjGPKO5nkSu/hmZEd3JP/HxGi9ioVCJ4HC6z1JGSDWLPZBrJ
	xVO9I3Wk0miDpAUPMLNwbV2eDIWvHAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725500674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTi9sXVnnFjpBjJesi3UR5hVhx3v23LG1PtFEXVp71M=;
	b=cymQDEGWOADoKN1LyZ03d1GlVDNw0dRcXfrSODgwuzUAHuPCr3kGQ1Ns9kUzE3kITnGhjo
	Iq7YTdPKKll+VAAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B39E1398F;
	Thu,  5 Sep 2024 01:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QhGVCP0M2WY7MwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 05 Sep 2024 01:44:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever III" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <kolga@netapp.com>,
 "Dai Ngo" <dai.ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Al Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>,
 "Jan Kara" <jack@suse.cz>, "Jonathan Corbet" <corbet@lwn.net>,
 "Tom Haynes" <loghyr@gmail.com>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Linux FS Devel" <linux-fsdevel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 03/13] nfsd: drop the ncf_cb_bmap field
In-reply-to: <59DF9B68-4D5F-4E2D-A208-B8EE86D61A85@oracle.com>
References: <>, <59DF9B68-4D5F-4E2D-A208-B8EE86D61A85@oracle.com>
Date: Thu, 05 Sep 2024 11:44:21 +1000
Message-id: <172550066195.4433.11555037330378400882@noble.neil.brown.name>
X-Rspamd-Queue-Id: BFB9221A61
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,netapp.com,oracle.com,talpey.com,redhat.com,zeniv.linux.org.uk,suse.cz,lwn.net,gmail.com,vger.kernel.org];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 05 Sep 2024, Chuck Lever III wrote:
>=20
>=20
> > On Sep 4, 2024, at 1:39=E2=80=AFPM, Jeff Layton <jlayton@kernel.org> wrot=
e:
> >=20
> > On Wed, 2024-09-04 at 17:28 +0000, Chuck Lever III wrote:
> >>=20
> >>> On Sep 4, 2024, at 12:58=E2=80=AFPM, Jeff Layton <jlayton@kernel.org> w=
rote:
> >>>=20
> >>> On Wed, 2024-09-04 at 11:20 -0400, Chuck Lever wrote:
> >>>> On Thu, Aug 29, 2024 at 09:26:41AM -0400, Jeff Layton wrote:
> >>>>> This is always the same value, and in a later patch we're going to ne=
ed
> >>>>> to set bits in WORD2. We can simplify this code and save a little spa=
ce
> >>>>> in the delegation too. Just hardcode the bitmap in the callback encode
> >>>>> function.
> >>>>>=20
> >>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> >>>>=20
> >>>> OK, lurching forward on this ;-)
> >>>>=20
> >>>> - The first patch in v3 was applied to v6.11-rc.
> >>>> - The second patch is now in nfsd-next.
> >>>> - I've squashed the sixth and eighth patches into nfsd-next.
> >>>>=20
> >>>> I'm replying to this patch because this one seems like a step
> >>>> backwards to me: the bitmap values are implementation-dependent,
> >>>> and this code will eventually be automatically generated based only
> >>>> on the protocol, not the local implementation. IMO, architecturally,
> >>>> bitmap values should be set at the proc layer, not in the encoders.
> >>>>=20
> >>>> I've gone back and forth on whether to just go with it for now, but
> >>>> I thought I'd mention it here to see if this change is truly
> >>>> necessary for what follows. If it can't be replaced, I will suck it
> >>>> up and fix it up later when this encoder is converted to an xdrgen-
> >>>> manufactured one.
> >>>=20
> >>> It's not truly necessary, but I don't see why it's important that we
> >>> keep a record of the full-blown bitmap here. The ncf_cb_bmap field is a
> >>> field in the delegation record, and it has to be carried around in
> >>> perpetuity. This value is always set by the server and there are only a
> >>> few legit bit combinations that can be set in it.
> >>>=20
> >>> We certainly can keep this bitmap around, but as I said in the
> >>> description, the delstid draft grows this bitmap to 3 words, and if we
> >>> want to be a purists about storing a bitmap,
> >>=20
> >> Fwiw, it isn't purism about storing the bitmap, it's
> >> purism about adopting machine-generated XDR marshaling/
> >> unmarshaling code. The patch adds non-marshaling logic
> >> in the encoder. Either we'll have to add a way to handle
> >> that in xdrgen eventually, or we'll have to exclude this
> >> encoder from machine generation. (This is a ways down the
> >> road, of course)
> >>=20
> >=20
> > Understood. I'll note that this function works with a nfs4_delegation
> > pointer too, which is not part of the protocol spec.
> >=20
> > Once we move to autogenerated code, we will always have a hand-rolled
> > "glue" layer that morphs our internal representation of these sorts of
> > objects into a form that the xdrgen code requires. Storing this info as
> > a flag in the delegation makes more sense to me, as the glue layer
> > should massage that into the needed form.
>=20
> My thought was the existing proc functions would do
> the massaging for us. But that's an abstract,
> architectural kind of thought. I'm just starting to
> integrate this idea into lockd.

So presumably xdrgen defines a bunch of structs.  The proc code fills
those in (on the stack?) and passes them to the generated xdr code which
encodes them to the network stream??  That seems reasonable.

We still don't want ncf_cb_bmap in struct nfs4_cb_fattr, we only need it
in the generated struct.

Thanks,
NeilBrown


