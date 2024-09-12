Return-Path: <linux-fsdevel+bounces-29263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EE5977596
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 01:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E96E1F20EF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 23:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF561C2DBF;
	Thu, 12 Sep 2024 23:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ddltiUOc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LE9pQkc8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ddltiUOc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LE9pQkc8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F316C18DF92;
	Thu, 12 Sep 2024 23:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183901; cv=none; b=Jkbr4f4Cz31PeQbfImItZ/M758XQGCreHcJ5ijbPfv+ps/VbudMld3dEhXvWleM5GuigAKMx5kMVkFRTLMDW7uMZUmSX34uce4VcJWzDUxwIwMh/TMSekVNcK1sMc7qR7841OgCZeZpb4bdH7BzS/1drSTKJVW4kYKm87eiWBwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183901; c=relaxed/simple;
	bh=fCL1oN6TMkEAVZcW5Ji3L1L50ch7AisDWGLM88M1/+Q=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=YmWuVk5twasA0sf/zOtGN3WKo5pWWHtDypO6OBgFpvCeihOQx4z98U/BMfq1Asj2UigyEJ6wYQgaQHICYEuCsKIz/PMyMY0yvKqlmEN4mcyXh7FMDAfKdPwh+6o/Rol7vVuvlFmOhgqn6Hrq6g+JhjthljUxVXynIm4vPITcWNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ddltiUOc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LE9pQkc8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ddltiUOc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LE9pQkc8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3F4262198C;
	Thu, 12 Sep 2024 23:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726183898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GCT3WkFZ4a+bJ6B/FTLwpRuFnnrsntfDKcRHZNEoqCc=;
	b=ddltiUOczVraT1M29DFv0i17WA4rKoHtvNCvsICzOvaS/QfZwYdWjl8Ul49VZkT4xBD7qG
	i11AfnVhP0qKzBySSzuIEiaSX6E6bGMmYWh6FhYphCJJ6lmWuyjSexEf+JoCVpArmtI4RH
	SaQWJEvSk665v/epba9/VOwY1/XLTsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726183898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GCT3WkFZ4a+bJ6B/FTLwpRuFnnrsntfDKcRHZNEoqCc=;
	b=LE9pQkc8j2Ofz2LQ6aq3+3ZQU2dbMvQh48i2P7oJslYUM3ERPJ6ym//Gqo/QE1y+flI+C6
	rb7lbvVBiFbzdGDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726183898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GCT3WkFZ4a+bJ6B/FTLwpRuFnnrsntfDKcRHZNEoqCc=;
	b=ddltiUOczVraT1M29DFv0i17WA4rKoHtvNCvsICzOvaS/QfZwYdWjl8Ul49VZkT4xBD7qG
	i11AfnVhP0qKzBySSzuIEiaSX6E6bGMmYWh6FhYphCJJ6lmWuyjSexEf+JoCVpArmtI4RH
	SaQWJEvSk665v/epba9/VOwY1/XLTsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726183898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GCT3WkFZ4a+bJ6B/FTLwpRuFnnrsntfDKcRHZNEoqCc=;
	b=LE9pQkc8j2Ofz2LQ6aq3+3ZQU2dbMvQh48i2P7oJslYUM3ERPJ6ym//Gqo/QE1y+flI+C6
	rb7lbvVBiFbzdGDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CA9513A56;
	Thu, 12 Sep 2024 23:31:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o9mAENd542bXIwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 12 Sep 2024 23:31:35 +0000
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
Cc: "Anna Schumaker" <anna.schumaker@oracle.com>,
 "Mike Snitzer" <snitzer@kernel.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 00/26] nfs/nfsd: add support for LOCALIO
In-reply-to: <A8A5876A-4C8A-4630-AED3-7AED4FF121AB@oracle.com>
References: <>, <A8A5876A-4C8A-4630-AED3-7AED4FF121AB@oracle.com>
Date: Fri, 13 Sep 2024 09:31:24 +1000
Message-id: <172618388461.17050.3025025482727199332@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,noble.neil.brown.name:mid,suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Thu, 12 Sep 2024, Chuck Lever III wrote:
>=20
>=20
> > On Sep 10, 2024, at 8:43=E2=80=AFPM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > On Sat, 07 Sep 2024, Anna Schumaker wrote:
> >> Hi Mike,
> >>=20
> >> On 8/31/24 6:37 PM, Mike Snitzer wrote:
> >>> Hi,
> >>>=20
> >>> Happy Labor Day weekend (US holiday on Monday)!  Seems apropos to send
> >>> what I hope the final LOCALIO patchset this weekend: its my birthday
> >>> this coming Tuesday, so _if_ LOCALIO were to get merged for 6.12
> >>> inclusion sometime next week: best b-day gift in a while! ;)
> >>>=20
> >>> Anyway, I've been busy incorporating all the review feedback from v14
> >>> _and_ working closely with NeilBrown to address some lingering net-ns
> >>> refcounting and nfsd modules refcounting issues, and more (Chnagelog
> >>> below):
> >>>=20
> >>=20
> >> I've been running tests on localio this afternoon after finishing up goi=
ng through v15 of the patches (I was most of the way through when you posted =
v16, so I haven't updated yet!). Cthon tests passed on all NFS versions, and =
xfstests passed on NFS v4.x. However, I saw this crash from xfstests with NFS=
 v3:
> >>=20
> >> [ 1502.440896] run fstests generic/633 at 2024-09-06 14:04:17
> >> [ 1502.694356] process 'vfstest' launched '/dev/fd/4/file1' with NULL ar=
gv: empty string added
> >> [ 1502.699514] Oops: general protection fault, probably for non-canonica=
l address 0x6c616e69665f6140: 0000 [#1] PREEMPT SMP NOPTI
> >> [ 1502.700970] CPU: 3 UID: 0 PID: 513 Comm: nfsd Not tainted 6.11.0-rc6-=
g0c79a48cd64d-dirty+ #42323 70d41673e6cbf8e3437eb227e0a9c3c46ed3b289
> >> [ 1502.702506] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS =
unknown 2/2/2022
> >> [ 1502.703593] RIP: 0010:nfsd_cache_lookup+0x2b3/0x840 [nfsd]
> >> [ 1502.704474] Code: 8d bb 30 02 00 00 bb 01 00 00 00 eb 12 49 8d 46 10 =
48 8b 08 ff c3 48 85 c9 0f 84 9c 00 00 00 49 89 ce 4c 8d 61 c8 41 8b 45 00 <3=
b> 41 c8 75 1f 41 8b 45 04 41 3b 46 cc 74 15 8b 15 2c c6 b8 f2 be
> >> [ 1502.706931] RSP: 0018:ffffc27ac0a2fd18 EFLAGS: 00010206
> >> [ 1502.707547] RAX: 00000000b95691f7 RBX: 0000000000000002 RCX: 6c616e69=
665f6178
> >=20
> > This doesn't look like code anywhere near the changes that LOCALIO
> > makes.
> >=20
> > I dug around and the faulting instruction is=20
> >   cmp    -0x38(%rcx),%eax=20
> >=20
> > The -0x38 points to nfsd_cache_insert().  -0x38 is the index back
> > from the rbnode pointer to c_key.k_xid.  So the rbtree is corrupt.
> > %rcx is 6c616e69665f6178 which is "xa_final".  So that rbtree node has
> > been over-written or freed and re-used.
> >=20
> > It looks like
> >=20
> > Commit add1511c3816 ("NFSD: Streamline the rare "found" case")
> >=20
> > moved a call to nfsd_reply_cache_free_locked() that was inside a region
> > locked with ->cache_lock out of that region.
>=20
> My reading of the current code is that cache_lock is held
> during the nfsd_reply_cache_free_locked() call.
>=20
> add1511c3816 simply moved the call site from before a "goto"
> to after the label it branches to. What am I missing?

Yes, I let myself get confused by the gotos.  As you say that patch
didn't move the call out of the locked region.  Sorry.

I can't see anything wrong with the locking or tree management in
nfscache.c, yet this Oops looks a lot like a corrupted rbtree.
It *could* be something external stomping on the memory but I think
that is unlikely.  I'd rather have a more direct explanation....  Not
today though it seems.

NeilBrown

