Return-Path: <linux-fsdevel+bounces-39568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DED0A15ACC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 02:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73DB6188BDEF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 01:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D69B67F;
	Sat, 18 Jan 2025 01:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vRjB35G0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HA4AmZF+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vRjB35G0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HA4AmZF+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE94D2913
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jan 2025 01:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737162406; cv=none; b=jx2jIh7D96bC1OPgpftvaCoVIgJOuzCVBSpjojxfrGGRDfAW6T6yGRvSRqhKqi8nE2glZJDR6fPm7dAza7g1Kr8T2OkYGd4zQhZxUfS/10QHyu3z1imcFFGA67UDKXxQwVKhV3Z/shVjFzfVlRkEf3Wxjtp8i2fQsGADd5qkzSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737162406; c=relaxed/simple;
	bh=orVIIie4w76FtKSMwRZPTK+/2w1TozZKibr+CNs+SWM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=p1Ui4FeghVxR7kHJLrziGdAAPKdfzVR6L6thv+k6suoaBSCTog+i7rv4agISmEq/vv8ZPbffxeidlv8FtxNKcYVyq9s5E7FJrd3nKnfMRScmFrLtNdB/Ww2pYc9AnxAAmBycfhkQBedbpyixqaS62edk5VXRpNQFefPUeRk32M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vRjB35G0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HA4AmZF+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vRjB35G0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HA4AmZF+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C2F6C211B2;
	Sat, 18 Jan 2025 01:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737162402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pP3D6xjte2sz8UcOgt28FCbxF/C93FidDliHj1mxQHY=;
	b=vRjB35G0+SeaU/twcfVkyZKhsABa57048TM5LKFeBDO3Vys5A0k7by9VhN6zwDoQ2uLZ7F
	UzU3yaiuc4wegVwLyCSK2XYH3uDroMaKM/KvvNkqoRY0scmnj5HyF+u6lz6iBjXZTvPzdh
	9LH1Ymeg9vtyhe7w36x+pF7tjmAXprw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737162402;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pP3D6xjte2sz8UcOgt28FCbxF/C93FidDliHj1mxQHY=;
	b=HA4AmZF+NkO4K2b67azEBlggq65YphiiCyAI82wKulR2bMwBrAvOKWemmaKXqAH0itYVht
	rYfXOiaW/f3ixPCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737162402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pP3D6xjte2sz8UcOgt28FCbxF/C93FidDliHj1mxQHY=;
	b=vRjB35G0+SeaU/twcfVkyZKhsABa57048TM5LKFeBDO3Vys5A0k7by9VhN6zwDoQ2uLZ7F
	UzU3yaiuc4wegVwLyCSK2XYH3uDroMaKM/KvvNkqoRY0scmnj5HyF+u6lz6iBjXZTvPzdh
	9LH1Ymeg9vtyhe7w36x+pF7tjmAXprw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737162402;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pP3D6xjte2sz8UcOgt28FCbxF/C93FidDliHj1mxQHY=;
	b=HA4AmZF+NkO4K2b67azEBlggq65YphiiCyAI82wKulR2bMwBrAvOKWemmaKXqAH0itYVht
	rYfXOiaW/f3ixPCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B6AD13332;
	Sat, 18 Jan 2025 01:06:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6SPvN6D+imdGHAAAD6G6ig
	(envelope-from <neilb@suse.de>); Sat, 18 Jan 2025 01:06:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: lsf-pc@lists.linuxfoundation.org, "Al Viro" <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] allowing parallel directory modifications at
 the VFS layer
In-reply-to: <f78f4a5e86c10d723fd60d51a52dd727924fed3a.camel@kernel.org>
References: <f78f4a5e86c10d723fd60d51a52dd727924fed3a.camel@kernel.org>
Date: Sat, 18 Jan 2025 12:06:30 +1100
Message-id: <173716239018.22054.4624947284143971296@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 18 Jan 2025, Jeff Layton wrote:
> We've hit a number of cases in testing recently where the parent's
> i_rwsem ends up being the bottleneck in heavy parallel create
> workloads. Currently we have to take the parent's inode->i_rwsem
> exclusively when altering a directory, which means that any directory-
> morphing operations in the same directory are serialized.
>=20
> This is particularly onerous in the ->create codepath, since a
> filesystem may have to do a number of blocking operations to create a
> new file (allocate memory, start a transaction, etc.)
>=20
> Neil recently posted this RFC series, which allows parallel directory
> modifying operations:
>=20
>     https://lore.kernel.org/linux-fsdevel/20241220030830.272429-1-neilb@sus=
e.de/
>=20
> Al pointed out a number of problems in it, but the basic approach seems
> sound. I'd like to have a discussion at LSF/MM about this.
>=20
> Are there any problems with the basic approach? Are there other
> approaches that might be better? Are there incremental steps we could
> do pave the way for this to be a reality?

Thanks for raising this!
There was at least one problem with the approach but I have a plan to
address that.  I won't go into detail here.  I hope to get a new
patch set out sometime in the coming week.

My question to fs-devel is: is anyone willing to convert their fs (or
advice me on converting?) to use the new interface and do some testing
and be open to exploring any bugs that appear?

I'd like to try ext4 using the patches that lustre maintains for
parallel directory ops in ext4 but making them suitable for upstream
doesn't look to be straight forward.

  https://git.whamcloud.com/?p=3Dfs/lustre-release.git;a=3Dblob;f=3Dldiskfs/k=
ernel_patches/patches/linux-6.5/ext4-pdirop.patch;h=3D208d9dc44f4860fbf27072e=
d1969744131e30108;hb=3DHEAD

NeilBrown

