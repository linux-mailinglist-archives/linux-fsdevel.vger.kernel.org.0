Return-Path: <linux-fsdevel+bounces-27964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1BD96538D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 01:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA941F22E81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 23:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE17518FDBC;
	Thu, 29 Aug 2024 23:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UcRCZy1c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6Xuq9z9s";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UcRCZy1c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6Xuq9z9s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC994187843;
	Thu, 29 Aug 2024 23:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724974763; cv=none; b=XXdjJLELGsFxWrTRluP5BDVR8TND0QjeuBjY7gf4I1D+3gNwq8nCX8/rEqj/Hsb1bhrRWXe9LgPOn3QJoJfFNJEpmjcgyLs+898BO4UpD7wa2fgorP27ohmDfQCDhdVPEqdm2lHMrHigAAs2ncN7JksjuRl3ABgszQB7aOQ4oHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724974763; c=relaxed/simple;
	bh=LRaKIqDoRDPDZ8NKeNexQ95zEmfySlzu7wUO4rfvlWA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=pMm31pduSwuRuuNu4AIGP3qalUkcXLhsu6WOP7tOixokSSNRd5E47ptk/Hkx4d3rCgbtglgYwPpqppsWmMaoPj2LtvxhV2I2zM5VBQns7HMu+CBOlEpggVgewgZYQWL+HYokf7xukBofbIPl3HyXsfZEcgF4j5JXBR3TQoJ8zmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UcRCZy1c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6Xuq9z9s; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UcRCZy1c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6Xuq9z9s; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E04601F787;
	Thu, 29 Aug 2024 23:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724974759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9ME5gDooW2WAf1bctjtnxLbFxwn+6oro4LBqf1xTw4=;
	b=UcRCZy1ciYD8k1/ZzlEpa3pycoMRp3wogZ/s6u5ABXCg3Pco6fvJhjR1qIVBROv4KeJK+6
	CgnYbwgXXtoIp/fLkywegvF16rLUb7EqCwWhcXR2okjRavIXgJVI/pPstWbwJQZ2jTzhGs
	OmhBC+8PY+nWO/diFWTjZp2RoUI/VGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724974759;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9ME5gDooW2WAf1bctjtnxLbFxwn+6oro4LBqf1xTw4=;
	b=6Xuq9z9sG5kVKuDbC9aRwUeE4jNlgClenqNlZf8JgfSAoCrTu+/qZQzwJupiS6AGymkGah
	1/+hqiJcq/Z1UnBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724974759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9ME5gDooW2WAf1bctjtnxLbFxwn+6oro4LBqf1xTw4=;
	b=UcRCZy1ciYD8k1/ZzlEpa3pycoMRp3wogZ/s6u5ABXCg3Pco6fvJhjR1qIVBROv4KeJK+6
	CgnYbwgXXtoIp/fLkywegvF16rLUb7EqCwWhcXR2okjRavIXgJVI/pPstWbwJQZ2jTzhGs
	OmhBC+8PY+nWO/diFWTjZp2RoUI/VGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724974759;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9ME5gDooW2WAf1bctjtnxLbFxwn+6oro4LBqf1xTw4=;
	b=6Xuq9z9sG5kVKuDbC9aRwUeE4jNlgClenqNlZf8JgfSAoCrTu+/qZQzwJupiS6AGymkGah
	1/+hqiJcq/Z1UnBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C913139B0;
	Thu, 29 Aug 2024 23:39:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BUE4DKUG0Wa7aQAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 29 Aug 2024 23:39:17 +0000
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
Subject: Re: [PATCH v14 14/25] nfs_common: add NFS LOCALIO auxiliary protocol
 enablement
In-reply-to: <20240829010424.83693-15-snitzer@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>,
 <20240829010424.83693-15-snitzer@kernel.org>
Date: Fri, 30 Aug 2024 09:39:10 +1000
Message-id: <172497475053.4433.8625349705350143756@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 29 Aug 2024, Mike Snitzer wrote:

> +
> +bool nfs_uuid_is_local(const uuid_t *uuid, struct net *net, struct auth_do=
main *dom)
> +{
> +	bool is_local =3D false;
> +	nfs_uuid_t *nfs_uuid;
> +
> +	rcu_read_lock();
> +	nfs_uuid =3D nfs_uuid_lookup(uuid);
> +	if (nfs_uuid) {
> +		nfs_uuid->net =3D maybe_get_net(net);

I know I said it looked wrong to be getting a ref for the domain but not
the net - and it did.  But that doesn't mean the fix was to get a ref
for the net and to hold it indefinitely.

This ref is now held until the client happens to notice that localio
doesn't work any more (because nfsd_serv_try_get() fails).  So the
shutdown of a net namespace will be delayed indefinitely if the NFS
filesystem isn't being actively used.

I would prefer that there were a way for the net namespace to reach back
into the client and disconnect itself.  Probably this would be a
linked-list in struct nfsd_net which linked list_heads in struct
nfs_client.  This list would need to be protected by a spinlock -
probably global in nfs_common so client could remove itself and server
could remove all clients after clearing their net pointers.

It is probably best if I explain all of what I am thinking as a patch.

Stay tuned.

NeilBrown

