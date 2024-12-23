Return-Path: <linux-fsdevel+bounces-38019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF4F9FAB06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 08:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB8BC1643C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 07:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CF218BBBB;
	Mon, 23 Dec 2024 07:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aUrw/Kcc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a057nPny";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q1RpwTBP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mID9g9ML"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE79918052;
	Mon, 23 Dec 2024 07:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734938781; cv=none; b=Bu3Da8kNLmoLdxD43makqzVPzvuNci3S81eHMZ0zLtfSghV/JtA1MoVV+we3VGnPM2ERbQPRDuWwJ1w6r2xYnihhV6Vl9oGFSUb/MQ7tBOYZuW6TBikqDQIouN0ni6zJTjbLujM7vACkbjbDV6jeEaRlrGly38tE48I1dy2E0Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734938781; c=relaxed/simple;
	bh=Y/XIN8hcsL01BI7IfvTxBaF8cdOkbvGR+xDQMW9EBrw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=EbQtkrsUvd6cgiZWmDem3e9fIApEtY8YCzgAuyBiF7Uv9isRnM4/U3zw2xTu5GunH4khrngV0v9JvfDPPRSJstDEQegb95zhTI+c875RBR5ypdPtfZ+oc7bqy8KA140qx1YbhgHQ9zwcOMNuASVpfEq/0bZwobqU7d3h/Fluakg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aUrw/Kcc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a057nPny; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q1RpwTBP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mID9g9ML; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DA60A1F394;
	Mon, 23 Dec 2024 07:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734938778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+NPdHo0+qjkzlLeWvU8ckHA7dDij3G4vbeyxRR3K1E=;
	b=aUrw/KccAwgAd5U9mhd10HRNuPfPtsiBByNqcqrjbuIN0gH9F9AnAP1sVZrSdX3d2FrjIB
	jXqBZs1tEr8Qm752/LgtJnkpTmeR/aRI8hKx5lJ0uBgLvkCetWFUC8IB2oEUNqz9Ms6ilv
	KGY/k7+lZTGFt/KP5IHih/XZmWbsFNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734938778;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+NPdHo0+qjkzlLeWvU8ckHA7dDij3G4vbeyxRR3K1E=;
	b=a057nPnyP/L+fWNGWoWdp+HkJMNqGMF+4Ar0ebV/uP02cXnFxNMs5ZTHA/gRTt+edd1uyr
	XwzElI0RRc/O6vAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734938777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+NPdHo0+qjkzlLeWvU8ckHA7dDij3G4vbeyxRR3K1E=;
	b=Q1RpwTBPvTztHa9ON/BUSVPnxlWOisAyBjbT2f7zn+Gv73rSvjC01w+FE1ng80agLnJgZ8
	Y6vUeBVRgZJVaq6xhfHSh9CyW+1aFNbPoncHUYJpddboSN8Djr8xNdFjAz2XZgCzobEQ5N
	s47Ijn8HzB0RYYurFO/uCUclnQLIs30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734938777;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+NPdHo0+qjkzlLeWvU8ckHA7dDij3G4vbeyxRR3K1E=;
	b=mID9g9MLkQDM1GO/ZBKdcUV787kHBnj0iKE8C1EcyU0eOFDFMe9xX+18PBNVx5MAq5pALz
	f49WBIpWxkYjDGCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE0B213485;
	Mon, 23 Dec 2024 07:26:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VQNHHJcQaWcSSgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 23 Dec 2024 07:26:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] VFS: introduce vfs_mkdir_return()
In-reply-to: <20241223050418.GI1977892@ZenIV>
References: <>, <20241223050418.GI1977892@ZenIV>
Date: Mon, 23 Dec 2024 18:26:12 +1100
Message-id: <173493877280.11072.5624032826602566309@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Mon, 23 Dec 2024, Al Viro wrote:
> On Fri, Dec 20, 2024 at 01:54:19PM +1100, NeilBrown wrote:
> > +	error = dir->i_op->mkdir(idmap, dir, dentry, mode);
> > +	if (!error) {
> > +		fsnotify_mkdir(dir, dentry);
> > +		if (unlikely(d_unhashed(dentry))) {
> > +			struct dentry *d;
> > +			d = lookup_dcache((const struct qstr *)&dentry->d_name,
> > +					  dentry->d_parent, 0);
> > +			if (IS_ERR(d)) {
> > +				error = PTR_ERR(d);
> > +			} else if (unlikely(d_is_negative(d))) {
> 
> 
> ... which will instantly oops if there's no cached dentry with
> such name and parent.  lookup_dcache() is pure dcache lookup;
> it does *NOT* call ->lookup() on miss - just returns NULL.
> 

I originally had lookup_one_len() but realised that I don't really want
any of lookup_one_common() so optimised - badly.

Maybe I should go back to lookup_one_len().
Or maybe I can just insert
   if (!d)
       d = __lookup_slow(....->d_name, dentry->d_parent, 0);

I'll look more closely and see which seems best.

Thanks,
NeilBrown

