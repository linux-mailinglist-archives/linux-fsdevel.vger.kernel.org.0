Return-Path: <linux-fsdevel+bounces-27980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98D7965745
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 08:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6891C22EA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 06:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933F7152165;
	Fri, 30 Aug 2024 06:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Hy8hDktj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xh8lUHaa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Hy8hDktj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xh8lUHaa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D681136E3F;
	Fri, 30 Aug 2024 06:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724997723; cv=none; b=c6oUzUlcQlSIj6BsP0vRVX26FeCzpIJM7v4+g5sgvDirm12z+QEf8+ktbJKEWlzqKPNr97/Jg4o6xzacDpIi7pj1OP7RtsP55r+X+19SS/kNEfxma/3vcDhxmgB5K4wruvronvQHz8mHMeBvoSThpUlXpdC5cYPDmqllkBAKlhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724997723; c=relaxed/simple;
	bh=qIRV4J9z3EHhb2uZCZnv5qt7Cx/Dh131OGth2MX4CaI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ZOuYQWyXwkdGd45MiGefSASGzQ62QA8o4aNKs2l+YlUGHVeKVBYDPDnsxo/OToF6ND+BlD+HfGCsIVvu8OPb33CifKYWzssR5hWbdbjmvlwbpx9z73oeLXNxaN3uJKTsdu4bg8Y6p2nj7rt3XNquOp1rmLiJZktWgKcwP5ZeHY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Hy8hDktj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xh8lUHaa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Hy8hDktj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xh8lUHaa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6D2221F7A0;
	Fri, 30 Aug 2024 06:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724997719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQYaQzUbHs1svgPSjeqnrYJpo4sR50O8Yv6Fg3B8xn0=;
	b=Hy8hDktj5Lf2eSU+OVgsgDiM4EXz3/OriOmPh4ePyyB+8GEPtifz5DZvqou+cWlct8Riy7
	aD/5t5KXfZFmohdxIyqxpgtYSNfiQRPIdcOS127i8FZaSArwpfLNhp3IjWJHgGcgvoVYW3
	B0jviqZb4wtwkoUy40umLXyULJLlX0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724997719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQYaQzUbHs1svgPSjeqnrYJpo4sR50O8Yv6Fg3B8xn0=;
	b=xh8lUHaaHK+ZyjmP/6fd/CEgMUpzrp68A3NnI/VsySk/8VgotmiVrEFi0SrWt/v16stKph
	zW6dtPGrIzVwNIAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724997719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQYaQzUbHs1svgPSjeqnrYJpo4sR50O8Yv6Fg3B8xn0=;
	b=Hy8hDktj5Lf2eSU+OVgsgDiM4EXz3/OriOmPh4ePyyB+8GEPtifz5DZvqou+cWlct8Riy7
	aD/5t5KXfZFmohdxIyqxpgtYSNfiQRPIdcOS127i8FZaSArwpfLNhp3IjWJHgGcgvoVYW3
	B0jviqZb4wtwkoUy40umLXyULJLlX0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724997719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQYaQzUbHs1svgPSjeqnrYJpo4sR50O8Yv6Fg3B8xn0=;
	b=xh8lUHaaHK+ZyjmP/6fd/CEgMUpzrp68A3NnI/VsySk/8VgotmiVrEFi0SrWt/v16stKph
	zW6dtPGrIzVwNIAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B9C713A69;
	Fri, 30 Aug 2024 06:01:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id egO6LFFg0WbcSgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 30 Aug 2024 06:01:53 +0000
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
Cc: "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <kolga@netapp.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Jonathan Corbet" <corbet@lwn.net>, "Tom Haynes" <loghyr@gmail.com>,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 01/13] nfsd: fix nfsd4_deleg_getattr_conflict in
 presence of third party lease
In-reply-to: <ZtCRGfPRayPPDXRM@tissot.1015granger.net>
References: <>, <ZtCRGfPRayPPDXRM@tissot.1015granger.net>
Date: Fri, 30 Aug 2024 16:01:43 +1000
Message-id: <172499770304.4433.15669416955311925812@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,netapp.com,oracle.com,talpey.com,redhat.com,zeniv.linux.org.uk,suse.cz,lwn.net,gmail.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,noble.neil.brown.name:mid,suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Fri, 30 Aug 2024, Chuck Lever wrote:
> On Thu, Aug 29, 2024 at 09:26:39AM -0400, Jeff Layton wrote:
> > From: NeilBrown <neilb@suse.de>
> >=20
> > It is not safe to dereference fl->c.flc_owner without first confirming
> > fl->fl_lmops is the expected manager.  nfsd4_deleg_getattr_conflict()
> > tests fl_lmops but largely ignores the result and assumes that flc_owner
> > is an nfs4_delegation anyway.  This is wrong.
> >=20
> > With this patch we restore the "!=3D &nfsd_lease_mng_ops" case to behave
> > as it did before the changed mentioned below.  This the same as the
> > current code, but without any reference to a possible delegation.
> >=20
> > Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation=
")
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> I've already applied this to nfsd-fixes.
>=20
> If I include this commit in both nfsd-fixes and nfsd-next then the
> linux-next merge whines about duplicate patches. Stephen Rothwell
> suggested git-merging nfsd-fixes and nfsd-next but I'm not quite
> confident enough to try that.
>=20
> Barring another solution, merging this series will have to wait a
> few days before the two trees can sync up.

Hmmm....  I would probably always rebase nfsd-next on nfsd-fixes, which
I would rebase on the most recent of rc0, rc1, or the latest rc to
receive nfsd patches.

nfsd-fixes is currently based on 6.10-rc7, while -next is based on
6.11-rc5.

Why the 6.10 base??

NeilBrown

