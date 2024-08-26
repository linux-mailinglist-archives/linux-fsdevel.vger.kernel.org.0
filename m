Return-Path: <linux-fsdevel+bounces-27079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8016895E68F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 03:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36460280F2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 01:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C4A8837;
	Mon, 26 Aug 2024 01:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Mkv2xkKI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kG22H8OY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Mkv2xkKI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kG22H8OY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397B12CA7;
	Mon, 26 Aug 2024 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724637585; cv=none; b=fk9l09XQ8WDn227JSCJogBLo54rCcl+aCzwpqyKUxQyHOoB8uLPtlHkkWn+R6tOhsY8+FvC9Twvqqlkq0J+vgi18CIsOn65gMvdC7AodRvlRdIotfuDWhoKsl7/F7l146p7DGlJ4e3dpoGvsOEfXezfjbz8wK835Sxzfnys7E5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724637585; c=relaxed/simple;
	bh=mIjynFn6513XTbHU2QyVSXOoRFujeE+M7Y+ZrKfm/mo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=nu3iVGvraTTTOP3tMi/W382dhxIJX8D90va5hzq0nBrNwrIq4svv+j5gng61dtKFCOBUegKAtyH13Ds42PNiIT8X9G4Q9FSZNsD7FSihLqP02ofuUrozWQeJMgy2QyhIaFfirx1rC3dNRYVTEcr6zhFdFWqCwb1RVHzDtlJkk6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Mkv2xkKI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kG22H8OY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Mkv2xkKI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kG22H8OY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 70B3A1F804;
	Mon, 26 Aug 2024 01:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724637582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvypKpQsM9sWZoV1lEGB9aUktFBmWCBgtlesvBDZzCk=;
	b=Mkv2xkKIcra4qgnAj8O20QjEF1xtkykfBnYwIOZODYo0FKQIbYogcHDgL6dKaYX8oZE4Yf
	HeY8sHn6NdEgruO36x/h2snMbqvpC5bHyVjUairHrLrBBvXpvlYfu9fkaAL1N0A4SR8Ruh
	JS1H41PMYQX3J1amTnWaE2jhQuBwrmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724637582;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvypKpQsM9sWZoV1lEGB9aUktFBmWCBgtlesvBDZzCk=;
	b=kG22H8OY7cRQv3djrWnE44xyScAUj4YtjUcN491ppO8xswH1RxqTGy14nGWjelO2HrmOhe
	betFsqLessD8ogAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Mkv2xkKI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kG22H8OY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724637582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvypKpQsM9sWZoV1lEGB9aUktFBmWCBgtlesvBDZzCk=;
	b=Mkv2xkKIcra4qgnAj8O20QjEF1xtkykfBnYwIOZODYo0FKQIbYogcHDgL6dKaYX8oZE4Yf
	HeY8sHn6NdEgruO36x/h2snMbqvpC5bHyVjUairHrLrBBvXpvlYfu9fkaAL1N0A4SR8Ruh
	JS1H41PMYQX3J1amTnWaE2jhQuBwrmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724637582;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvypKpQsM9sWZoV1lEGB9aUktFBmWCBgtlesvBDZzCk=;
	b=kG22H8OY7cRQv3djrWnE44xyScAUj4YtjUcN491ppO8xswH1RxqTGy14nGWjelO2HrmOhe
	betFsqLessD8ogAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FC44139DE;
	Mon, 26 Aug 2024 01:59:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 957WLYvhy2ZXcgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 26 Aug 2024 01:59:39 +0000
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
Subject: Re: [PATCH v13 00/19] nfs/nfsd: add support for localio
In-reply-to: <20240823181423.20458-1-snitzer@kernel.org>
References: <20240823181423.20458-1-snitzer@kernel.org>
Date: Mon, 26 Aug 2024 11:59:37 +1000
Message-id: <172463757705.6062.17876074269050148095@noble.neil.brown.name>
X-Rspamd-Queue-Id: 70B3A1F804
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 24 Aug 2024, Mike Snitzer wrote:
> These latest changes are available in my git tree here:
> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=3D=
nfs-localio-for-next
>=20
> Changes since v12:
> - Rebased to rearrange code to avoid "churn" that Jeff Layton felt
>   distracting (biggest improvement came from folding switch from
>   struct file to nfsd_file changes in from the start of the series)
> - Updated relevant patch headers accordingly.
> - Updated localio.rst to provide more performance data.
> - Dropped v12's buggy "nfsd: fix nfsfh tracepoints to properly handle
>   NULL rqstp" patch -- fixing localio to support fh_verify tracepoints
>   will need more think-time and discussion, but they aren't of
>   critical importance so fixing them doesn't need to hold things up.

Thanks for continuing to revise this.  While I think there are still
issues that need addressing, they are much smaller than some of the
things we had to address in the past.  It is certainly getting closer.

NeilBrown

