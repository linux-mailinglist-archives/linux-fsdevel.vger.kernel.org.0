Return-Path: <linux-fsdevel+bounces-69864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 019CCC88D1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 10:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D35A84EA1F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 09:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E37A2E06EA;
	Wed, 26 Nov 2025 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PwzhDNQm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JyhBzehp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dEptsKoL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JhkS8lWa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F821A9FAC
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147761; cv=none; b=EV3s3meCAykNFiV2GJNWsB/hele/V2Jdt91Sk9rj3awMHrmjzUPeHhJFVM8GQfaCk0c/zQmI7RXJ26XqJqmuqzwMTOk1ibLkzFfkbgORN7pj1oVr46QhcrtDpWzXJ3UW5TsisJO/1uPVE3C2sO4yUqR6iJwRZW9Yn6UYYvG3NcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147761; c=relaxed/simple;
	bh=7S0o4A2Iqu7ypvA81Fuav1qx7vPiBxdCnjTecxYIvnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZGeBRUOAl+9vJ349o/EWFz5l3a6oeNwNkuhGSRTwZQ5ax0j6Y+f1FbKCXUew9Ux/t29wR9fJUNFlS4iWp5PaWwT6jKbZcvWjrrYV2EYwG7MrXFT7peul8tx8TKlpwkaK2pkNIXSsOqlpryJFeFeobYA9LgF4f7GFr9qhgFXWAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PwzhDNQm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JyhBzehp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dEptsKoL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JhkS8lWa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D655B5BDF7;
	Wed, 26 Nov 2025 09:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764147758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4DkFnCX2tMnm89mTI1dyopVVvuwQd722ablmjza3zo=;
	b=PwzhDNQmxqBMD2AE93VTwTPSaGbmhSYvjBu5KXizIac+obx7HuOuJgdGUHpNJJhRw48kzX
	34uTHnL7UITcljCRYRsEulqGicRfQgPVhS0yZTV5jNuEUC17uzpfOhpFbluPCCgXE72tWK
	oKaZI+Wjg+sUHwHDe/BZ13N1jv9V3gU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764147758;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4DkFnCX2tMnm89mTI1dyopVVvuwQd722ablmjza3zo=;
	b=JyhBzehpq7fLNghYkyTuHSU0gE0hiYG17yoneUuv9vTVEeoenZxiANDU+mRhCoUXCQ/9Ik
	2K+mCwxirbQMcGDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dEptsKoL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JhkS8lWa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764147757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4DkFnCX2tMnm89mTI1dyopVVvuwQd722ablmjza3zo=;
	b=dEptsKoLJjaWA6VymHOdZWDb0Tsp8y3C4m4StoAfQNckIkOTKBNcUVcNgctyyJO+R3/W8y
	Q5aYJOPngHsJ2NfZRibhcJKgXZQFHUQhQ2WW1eFtEMbDVd8sBLgH98Q5JSkKMK9O6WCU5O
	UwFepEdUf5py4rkh7wYsFf9Knb3ASGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764147757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4DkFnCX2tMnm89mTI1dyopVVvuwQd722ablmjza3zo=;
	b=JhkS8lWa3mOU3avKJ6CBhI6Qi0RrOvCQ0cSArILuVmgAY8V0kyA1nYGwa6qfWLQHNBAa16
	bro4TGOB5gMP6hDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C628B3EA63;
	Wed, 26 Nov 2025 09:02:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hbF2Ly3CJmlmeAAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Wed, 26 Nov 2025 09:02:37 +0000
Date: Wed, 26 Nov 2025 10:03:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Joel Granados <joel.granados@kernel.org>, lkp@intel.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	oe-lkp@lists.linux.dev, ltp@lists.linux.it
Subject: Re: [LTP] [linux-next:master] [sysctl]  50b496351d: ltp.proc01.fail
Message-ID: <aSbCY9flDrZGC5NC@yuki.lan>
References: <202511251654.9c415e9b-lkp@intel.com>
 <aSWI07xSK9zGsivq@yuki.lan>
 <aSZnS2a4hcHWB6V7@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSZnS2a4hcHWB6V7@xsang-OptiPlex-9020>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D655B5BDF7
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

Hi!
> I attached one results.json FYI.

Looks like the test is getting unexpected EINVAL when reading from files
from /proc/sys/net/ipv4/neigh/default/ and
/proc/sys/net/ipv6/neigh/default/ directories.

> it need some code change to upload it to download directory, we will consider
> to implement it in the future. thanks

Please do so, without the logs it's much harder to debug the problems.

-- 
Cyril Hrubis
chrubis@suse.cz

