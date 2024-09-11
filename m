Return-Path: <linux-fsdevel+bounces-29065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8CD97477C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 02:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624561F267AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 00:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EC5182B4;
	Wed, 11 Sep 2024 00:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b6uD+MqY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RysV6uF0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gbVQt0rE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5STRkk1E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F56B15E8B;
	Wed, 11 Sep 2024 00:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726015454; cv=none; b=bZRUvp/YRAHGeIbo+9yuxj4EvzWu5ZG4L5iTnNIzwPhrXg1DhYskiWnR2nnz6b+trStBpbGLwkMBWcVdzH6y/YKhwziWzytKpLyWwCdLOZP1DGInmYW9MKS89Ug8iMnfXvVC+Tl6p9LB++az9Qm2Tv0aSM+JMG1as8g5bz4zBDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726015454; c=relaxed/simple;
	bh=sHOxuhKGZbvvffatnBLJte+8Z90KsOWt/Q9t0XsOehk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=QHH3MHDof1ahaPoOmj2l1IshlVdEZnyq66CGiIlkbKUVF+Xh6UlNvGiu9OZsNsY+B7ZXVuevJu6ogeEAlbj6aB7bCP5UwogO52uvNFRwqHfLQxJC1ZWhtn3koXMHkYCEgbLHS+tzYhzP6dsh8/qeGJXR701OBPQAcLlbOAfFTuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b6uD+MqY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RysV6uF0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gbVQt0rE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5STRkk1E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EDEC321A67;
	Wed, 11 Sep 2024 00:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726015450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vF9RHeTTFpzNehF/dRzbumcV0675My2JGekvEYQYHcQ=;
	b=b6uD+MqYd/HELFwSdThee9vOyL7sbu/ZXu6K/7714myaUT5OZS65dmjFMj/UwQrbpNxbQN
	JUfmf4bYc+Oik/7CHkDiEwopuyJI6B7yv95lvTwB/wanZYGCLoGkBQfzeMAwxaUkwuAnlm
	aZT9Fq8wr1wtlwQfV6HqikjHsDn6NeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726015450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vF9RHeTTFpzNehF/dRzbumcV0675My2JGekvEYQYHcQ=;
	b=RysV6uF06xlBhl14BUTP1Gi9urZjeSwQzDLn8PrTlgcqYvYn9PbSQoob4zUIEEgYvT1YKX
	35/5GcpGgjbInbDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gbVQt0rE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5STRkk1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726015448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vF9RHeTTFpzNehF/dRzbumcV0675My2JGekvEYQYHcQ=;
	b=gbVQt0rEjr1Hhfb9E6wrQeQkAZ3QGhF5yS9G23imNpJDeZvZiYyyxDjqswZMqX6Tdyvr/S
	VvSNRot+kYrrf+baoQlLF4iLLIbn4exvB2eFSW/PCfZ78NwukkCFFIKffpy/fzDduX/eK5
	hW0EANkgtAt3jxsSQIAKt7bZRytnx6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726015448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vF9RHeTTFpzNehF/dRzbumcV0675My2JGekvEYQYHcQ=;
	b=5STRkk1ED5aP0AcYkqLwgA3CdTYLsEXTd2Y71cnOPvmBpmA+Rx41iAejJbb4qTinKBIBAV
	K+YjFiBFjL10+PCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F9F6132CB;
	Wed, 11 Sep 2024 00:44:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x+8NAtbn4GaUXwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 11 Sep 2024 00:44:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Anna Schumaker" <anna.schumaker@oracle.com>,
 "Chuck Lever" <chuck.lever@oracle.com>,
Cc: "Mike Snitzer" <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v15 00/26] nfs/nfsd: add support for LOCALIO
In-reply-to: <66ab4e72-2d6e-4b78-a0ea-168e1617c049@oracle.com>
References: <20240831223755.8569-1-snitzer@kernel.org>,
 <66ab4e72-2d6e-4b78-a0ea-168e1617c049@oracle.com>
Date: Wed, 11 Sep 2024 10:43:59 +1000
Message-id: <172601543903.4433.11916744141322776500@noble.neil.brown.name>
X-Rspamd-Queue-Id: EDEC321A67
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.51
X-Spam-Flag: NO

On Sat, 07 Sep 2024, Anna Schumaker wrote:
> Hi Mike,
>=20
> On 8/31/24 6:37 PM, Mike Snitzer wrote:
> > Hi,
> >=20
> > Happy Labor Day weekend (US holiday on Monday)!  Seems apropos to send
> > what I hope the final LOCALIO patchset this weekend: its my birthday
> > this coming Tuesday, so _if_ LOCALIO were to get merged for 6.12
> > inclusion sometime next week: best b-day gift in a while! ;)
> >=20
> > Anyway, I've been busy incorporating all the review feedback from v14
> > _and_ working closely with NeilBrown to address some lingering net-ns
> > refcounting and nfsd modules refcounting issues, and more (Chnagelog
> > below):
> >=20
>=20
> I've been running tests on localio this afternoon after finishing up going =
through v15 of the patches (I was most of the way through when you posted v16=
, so I haven't updated yet!). Cthon tests passed on all NFS versions, and xfs=
tests passed on NFS v4.x. However, I saw this crash from xfstests with NFS v3:
>=20
> [ 1502.440896] run fstests generic/633 at 2024-09-06 14:04:17
> [ 1502.694356] process 'vfstest' launched '/dev/fd/4/file1' with NULL argv:=
 empty string added
> [ 1502.699514] Oops: general protection fault, probably for non-canonical a=
ddress 0x6c616e69665f6140: 0000 [#1] PREEMPT SMP NOPTI
> [ 1502.700970] CPU: 3 UID: 0 PID: 513 Comm: nfsd Not tainted 6.11.0-rc6-g0c=
79a48cd64d-dirty+ #42323 70d41673e6cbf8e3437eb227e0a9c3c46ed3b289
> [ 1502.702506] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unk=
nown 2/2/2022
> [ 1502.703593] RIP: 0010:nfsd_cache_lookup+0x2b3/0x840 [nfsd]
> [ 1502.704474] Code: 8d bb 30 02 00 00 bb 01 00 00 00 eb 12 49 8d 46 10 48 =
8b 08 ff c3 48 85 c9 0f 84 9c 00 00 00 49 89 ce 4c 8d 61 c8 41 8b 45 00 <3b> =
41 c8 75 1f 41 8b 45 04 41 3b 46 cc 74 15 8b 15 2c c6 b8 f2 be
> [ 1502.706931] RSP: 0018:ffffc27ac0a2fd18 EFLAGS: 00010206
> [ 1502.707547] RAX: 00000000b95691f7 RBX: 0000000000000002 RCX: 6c616e69665=
f6178

This doesn't look like code anywhere near the changes that LOCALIO
makes.

I dug around and the faulting instruction is=20
   cmp    -0x38(%rcx),%eax=09

The -0x38 points to nfsd_cache_insert().  -0x38 is the index back
from the rbnode pointer to c_key.k_xid.  So the rbtree is corrupt.
%rcx is 6c616e69665f6178 which is "xa_final".  So that rbtree node has
been over-written or freed and re-used.

It looks like

Commit add1511c3816 ("NFSD: Streamline the rare "found" case")

moved a call to nfsd_reply_cache_free_locked() that was inside a region
locked with ->cache_lock out of that region.

Maybe that is the cause of this crash.

NeilBrown

