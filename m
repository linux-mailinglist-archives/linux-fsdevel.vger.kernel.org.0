Return-Path: <linux-fsdevel+bounces-27977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4944965718
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 07:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 382CDB224CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 05:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098DE14E2C1;
	Fri, 30 Aug 2024 05:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fgWjEQCv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r3gnTWP/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pHrBfdn3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i1GYO0hP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9E02F2C;
	Fri, 30 Aug 2024 05:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724996801; cv=none; b=ol/luM4lDUChrihUMoLkTT7JdXOUGsOObsbQ3Vl/a23V0wvT2akOJMb8TVP/GdgGphG4nalqLUXgWxBlkOjh3jsb9HjT+ysmMBFUDTNICghlAVlwCcwvf5gCEpi9e13J3mlzqadw1OaIeUpwufNLKJdlwR++bCwvwOt7d7M88qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724996801; c=relaxed/simple;
	bh=7l5PDqtjZqEuo9ChGdykGEU0+ed0L2m4TMbKWTnhCts=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=UJJQLCooJkkg0OBYLG47lmEFfAzFjuPpgHv8CWTem5XVD20b6ulUem3LDEqWXB3tYJrKUnpMkltGL2t/F0wIT/nSWJs7haxCvO+wNYSS4Q6zQ2iQwMZns5yjSr31kzI7u+yGxChShLM/Dh1ik43WU0vvmTl8btUEGGM4I+OSiMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fgWjEQCv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r3gnTWP/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pHrBfdn3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i1GYO0hP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BBAAA21A0E;
	Fri, 30 Aug 2024 05:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724996798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ky4pMoctvrbg6CTQOKI8h0XhhzHJHO/ngzzUZ/83mPM=;
	b=fgWjEQCvm58zjwXQxGFNN6JTqAfEZNgSGTumYE+Sh7MyCYe5TeJWG6NJ/HSadyNaXsgRxX
	MR9GPW1fhvT/4uHOfRtOopWLVh4KaJzwmvPMYXgXtLgOuqpIjGiGWOcF5Q3tdnaINqx+hg
	OOF/4X6Tn6pg0BJo0z0RC6WCWfK3ll4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724996798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ky4pMoctvrbg6CTQOKI8h0XhhzHJHO/ngzzUZ/83mPM=;
	b=r3gnTWP/N3IlmA08zwW0gtSRmsSyXbZ5S1bz3poVcT0dKfjNOM74jIpvaLbJhNOB3yVKnR
	meOqgj4LgyYE9YAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724996796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ky4pMoctvrbg6CTQOKI8h0XhhzHJHO/ngzzUZ/83mPM=;
	b=pHrBfdn3JcDsBrNl/s7sEAn6QN/71sjUH3RUgwtciGhWcycyLLeG/aKlAp7V/H8p+HgmgG
	oNtoRtskfgGdAApAp+9GRohVlGIF3LFhqNNwFCgwWK63U6L7G9ZFvycsrUBT7odzZWotkH
	EK1dJm5nsUfpEC7C89IKjZ3FMKNiQkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724996796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ky4pMoctvrbg6CTQOKI8h0XhhzHJHO/ngzzUZ/83mPM=;
	b=i1GYO0hP75kTZGjEpF/A2Ah9LeOd+jPlYEzM7nZZQa2FpnhkSQMcysaTIyUw8Uf9XI4vBf
	JHiZptNOeThsE8Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57D5E13A44;
	Fri, 30 Aug 2024 05:46:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F/5CA7pc0WZ0RgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 30 Aug 2024 05:46:34 +0000
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
Subject: Re: [PATCH v14 15/25] nfs_common: introduce nfs_localio_ctx struct
 and interfaces
In-reply-to: <20240829010424.83693-16-snitzer@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>,
 <20240829010424.83693-16-snitzer@kernel.org>
Date: Fri, 30 Aug 2024 15:46:31 +1000
Message-id: <172499679141.4433.17192274712086631600@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.987];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,noble.neil.brown.name:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 29 Aug 2024, Mike Snitzer wrote:
> +
> +struct nfs_localio_ctx {
> +	struct nfsd_file *nf;
> +	struct nfsd_net *nn;
> +};

struct nfsd_file contains "struct net *nf_net" which is initialised
early.
So this structure is redundant.

Instead of exporting nfsd_file_put() to nfs-localio, export
nfsd_file_local_put() (or whatever) which both does the nfs_serv_put()
and the nfsd_file_put().

NeilBrown

