Return-Path: <linux-fsdevel+bounces-28191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99FA967CD5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 01:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52235281A24
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 23:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8D41586D3;
	Sun,  1 Sep 2024 23:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sv6KiahB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="75vcbQMZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P/wfWp3d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ft+Mzkx4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD0EF4EB;
	Sun,  1 Sep 2024 23:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725234798; cv=none; b=hzvtpmB//5nZ5jQ1vSFUtq/7JdIf0xNFBXFTY2kyA7+DLbSscapQjBLoyE5PcVqQ9gbnUUMnP7CK/qgCxbW7j7QodJ0bjTI1Z3vM+gkwzpnefn0ABkgQYynEkfwaqN+FG/qfix1IM5eq9BQmnVNHVFpwRWXGWxmdpOR1ruGZZNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725234798; c=relaxed/simple;
	bh=1hWs7Xakpjnz1f+3A2PP3awmKEWSZUZlHmp4cKqDz+w=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=hT4a2iEtpXOG76mvo90ldorZqlhWddbYE8/zslalnXOeNb/cRhMwVmqwFcveX+nWluqY+0tqim9K3K34QjUNubmFSa+UnDfgJp9+6owLJPVtms5ZK2HlaS90tKFqTldZ6npGdWKkWkALMbv5IKWU8cEngAqGY1JHWmaTQPykHDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sv6KiahB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=75vcbQMZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P/wfWp3d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ft+Mzkx4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ECA2F219D2;
	Sun,  1 Sep 2024 23:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725234795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZc4JStUPmZHb+mbJjBbmHlsiM3ok5bXfNP1dDG7tc0=;
	b=sv6KiahBGB3o+OcW4gfodH3V5N9EmGugqOnfonCq/wJ9LrVTwS1rtNeLyHVIIbQ7eoPZFL
	iIgPq1XgsOQfr0AJrvJYIYsyaSbh+8qY3tCWdJeEpPF84wK/ZdNXYutV6YBftYcohCDsKd
	8bZjE0ZM+qxRm86H4Dm4PRga67XTh3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725234795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZc4JStUPmZHb+mbJjBbmHlsiM3ok5bXfNP1dDG7tc0=;
	b=75vcbQMZUdxFcKjJWO4eQRU7MccqsTc0xwF62yIXNGnsCkOExVGmfHyLBiqhQkkVhVhUqI
	gq41PJ9P2X+gfdCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725234794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZc4JStUPmZHb+mbJjBbmHlsiM3ok5bXfNP1dDG7tc0=;
	b=P/wfWp3dP7d6OJDRyNBJWsN2t3eJg+SpDUZaRnqyyGwbIuk0KzL3f3TcFhpy8ZID0iW6Bd
	2vGP4M8KDQ3HHXaF/DSS0xuy58+CdcXEz3I8hZFggmbEG8l8CWbfYe1lYuWSJtE3jL8pG8
	/qnZ572ibB90JOH0ditJwsfylfnaBYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725234794;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZc4JStUPmZHb+mbJjBbmHlsiM3ok5bXfNP1dDG7tc0=;
	b=ft+Mzkx42oONCoHuCLWhDUapKny2qIx3uKqTcr0LVKWCs0CUVty+8RTZZw/VP/5Wg0tlUn
	Z2gcouQjwYTx5ZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AF331373A;
	Sun,  1 Sep 2024 23:53:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id trPLD2j+1GaiMgAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 01 Sep 2024 23:53:12 +0000
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
Subject: Re: [PATCH v15 00/26] nfs/nfsd: add support for LOCALIO
In-reply-to: <20240831223755.8569-1-snitzer@kernel.org>
References: <20240831223755.8569-1-snitzer@kernel.org>
Date: Mon, 02 Sep 2024 09:52:54 +1000
Message-id: <172523477460.4433.8873238976467311263@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, 01 Sep 2024, Mike Snitzer wrote:
> Hi,
> 
> Happy Labor Day weekend (US holiday on Monday)!  Seems apropos to send
> what I hope the final LOCALIO patchset this weekend: its my birthday
> this coming Tuesday, so _if_ LOCALIO were to get merged for 6.12
> inclusion sometime next week: best b-day gift in a while! ;)
> 
> Anyway, I've been busy incorporating all the review feedback from v14
> _and_ working closely with NeilBrown to address some lingering net-ns
> refcounting and nfsd modules refcounting issues, and more (Chnagelog
> below):

I think this is close enough to land.  There are a number of
imperfections but those that I can see are minor and can be fixed up
later.  They would be easier to review and discuss after landing, rather
then trying to find the changes in a v16 and review them amid all the
noise.

So feel free to add:
  Reviewed-by: NeilBrown <neilb@suse.de>

to any patch that doesn't already have it.

Thanks,
NeilBrown

