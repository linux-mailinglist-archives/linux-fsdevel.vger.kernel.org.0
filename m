Return-Path: <linux-fsdevel+bounces-27074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D266395E60E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 02:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0258D1C209BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 00:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F341C27;
	Mon, 26 Aug 2024 00:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dDUIWybJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lOnptRk9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dDUIWybJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lOnptRk9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D3C173;
	Mon, 26 Aug 2024 00:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724632370; cv=none; b=OQw2H+WNaQljd8TNId784a7P+ke387g3Raz25fKlkviyzArKPMpYDu5Xs7veiFsjtLuAso0siPTorcOXfePa4vFwzCr61QtD5/dLY0TKRd2LFWRrt+HiTtFEaoKfPxSCxbGN7YuryijwjuOi/UOptceHcBeT4OK/ZgrNul0x4xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724632370; c=relaxed/simple;
	bh=prkr+Qwur/824XObZGbmmk/P+gvWTDCqFifm0Tpx6mQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=e+szQ4PGyN6/VY5Ad+Iv2Plvw8wNHhdDaD6R9hX7oOoXFYGct0X/FQXjFehnB03t3X+y1okFRnckcivQpwE195/N8vX5xaDlNYnRlMbRkTMkcuo+68rL3ZMdabqLEZtJY+469co9eJBaX62ss/QJUdNmDi3KbhqRTq+/gtm4tJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dDUIWybJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lOnptRk9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dDUIWybJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lOnptRk9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC9EE219B8;
	Mon, 26 Aug 2024 00:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724632365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6cw2GBXbb7ZtGi8x105bnLgPcHUpQtSNnKOrjv6aRGM=;
	b=dDUIWybJcH3xFBfnQY6bgACDX/gABS9C35Ea+Ar40nYqKmQOkxbs1cJutUInFmVvjtnxC9
	n9OHp7Idc6pXLfkp8kwhsg2yOODDHr6RcJT1tVQ/Fgi1M7RP2yzac5WqP76CjdApFLh078
	dmP2vNEr34RaIzxZaVq62Jki0p2ikWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724632365;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6cw2GBXbb7ZtGi8x105bnLgPcHUpQtSNnKOrjv6aRGM=;
	b=lOnptRk95Vrrp+FalutYY4nDghYhF/klREnL8o7V00ctbX7SaMSsxSJIRC2KJIHg53kRYH
	8zhxAAjeq0wMk9DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724632365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6cw2GBXbb7ZtGi8x105bnLgPcHUpQtSNnKOrjv6aRGM=;
	b=dDUIWybJcH3xFBfnQY6bgACDX/gABS9C35Ea+Ar40nYqKmQOkxbs1cJutUInFmVvjtnxC9
	n9OHp7Idc6pXLfkp8kwhsg2yOODDHr6RcJT1tVQ/Fgi1M7RP2yzac5WqP76CjdApFLh078
	dmP2vNEr34RaIzxZaVq62Jki0p2ikWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724632365;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6cw2GBXbb7ZtGi8x105bnLgPcHUpQtSNnKOrjv6aRGM=;
	b=lOnptRk95Vrrp+FalutYY4nDghYhF/klREnL8o7V00ctbX7SaMSsxSJIRC2KJIHg53kRYH
	8zhxAAjeq0wMk9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4918113724;
	Mon, 26 Aug 2024 00:32:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /C06OyrNy2YlWwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 26 Aug 2024 00:32:42 +0000
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
Subject: Re: [PATCH v13 09/19] nfs_common: add NFS LOCALIO auxiliary protocol
 enablement
In-reply-to: <20240823181423.20458-10-snitzer@kernel.org>
References: <20240823181423.20458-1-snitzer@kernel.org>,
 <20240823181423.20458-10-snitzer@kernel.org>
Date: Mon, 26 Aug 2024 10:32:30 +1000
Message-id: <172463235065.6062.5648288713828077276@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.26 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.16)[-0.811];
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
X-Spam-Score: -4.26
X-Spam-Flag: NO

On Sat, 24 Aug 2024, Mike Snitzer wrote:
>=20
> Also, expose localio's required nfsd symbols to NFS client:
> - Cache nfsd_open_local_fh symbol (defined in next commit) and other
>   required nfsd symbols in a globally accessible 'nfs_to'
>   nfs_to_nfsd_t struct.

I'm not thrilled with the mechanism for getting these symbols.

I'd rather nfsd passed the symbols to nfs_uuid_is_local(), and it stored
them somewhere that nfs can see them.  No need for reference counting
etc.  If nfs/localio holds an auth_domain, then it implicitly holds a
reference to the nfsd module and the functions cannot disappear.

I would created an 'nfs_localio_operations' structure which is defined
in nfsd as a constant.
The address of this is passed to nfs_uud_is_local() and that address
is stored in nfs_to if it doesn't already have the correct value.

So no need for symbol_request() or symbol_put().


> +
> +DEFINE_MUTEX(nfs_uuid_mutex);

This doesn't need to be a mutex - a spinlock is sufficient.

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
> +		is_local =3D true;
> +		nfs_uuid->net =3D net;

It looks odd that you don't take a reference to the net.
It is probably correct but a comment explaining why would help.
Is it that the dom implies a reference to the net?

> +		kref_get(&dom->ref);
> +		nfs_uuid->dom =3D dom;
> +	}
> +	rcu_read_unlock();
> +
> +	return is_local;
> +}
> +EXPORT_SYMBOL_GPL(nfs_uuid_is_local);

Thanks,
NeilBrown

