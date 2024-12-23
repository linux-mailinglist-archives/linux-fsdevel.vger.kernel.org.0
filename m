Return-Path: <linux-fsdevel+bounces-38018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A329FAAE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 08:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8FB1885E46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 07:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52CD1898ED;
	Mon, 23 Dec 2024 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eE7hOodW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tETBeL3j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eE7hOodW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tETBeL3j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FD9EEB5;
	Mon, 23 Dec 2024 07:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734937893; cv=none; b=a3lRcRg/cH+7mTkozhg6Bm6dI/FCuO+4mJBl1akglSw9ex0yAZWooE6s9K/8VOaFyLGh7hLH+C7FZufj1K9QGPin7VxvUjvJ0YCiY6LHcDmXs+tmixbHV5xNU9aFHcC3fGfEJnsOo8kOs/+DrnTFVLg9zhu6L3NT6DVnvYoh9x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734937893; c=relaxed/simple;
	bh=xN90c9Z1RDIzcJWIgCprNsuSei9MBOzCCjDKyo3Jr9o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=TTNx2hITmBSoF9o0MraWGUFIRqUPBc0op58BYLFs0MMYFwSpUW29wgzc7CD6igUWbn35VtPUDb0EwGDXtEJ1+un/S9vjBi5PS/UIHgJSYzOAwwN4Fr+qoJ6ljEjIgPPjsMzPDrHXz4psEEIibC/3A9RdORikkNPQseyhmZFu95Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eE7hOodW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tETBeL3j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eE7hOodW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tETBeL3j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A5D781F394;
	Mon, 23 Dec 2024 07:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734937889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3P5lgOvrV2OugSbQXFXowkZWD04tCEkVAmTNybgnRI=;
	b=eE7hOodW+daflgHJgDnSwLL1JlELbu6n0twQb2nYtTkrMwDJuXm+Kb52MYVBBXPJGUdf/F
	PuZUOf1EuI4S9OFBq3ZHRUR0rj/nZgSUayiXnumqZXDwqW8WC14zj+AtG/IS/TtBIR3xhx
	RG3/H3/ZxNwrV5ydQl2xsTSNcuI+hC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734937889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3P5lgOvrV2OugSbQXFXowkZWD04tCEkVAmTNybgnRI=;
	b=tETBeL3jClnq4fK4VVHZSUJXHhzQYZ4eezsk/l9t/rLqggPbUhKTHpuDPFbLvgk0t4gNkr
	+iMT2yJFMb4Fn2BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734937889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3P5lgOvrV2OugSbQXFXowkZWD04tCEkVAmTNybgnRI=;
	b=eE7hOodW+daflgHJgDnSwLL1JlELbu6n0twQb2nYtTkrMwDJuXm+Kb52MYVBBXPJGUdf/F
	PuZUOf1EuI4S9OFBq3ZHRUR0rj/nZgSUayiXnumqZXDwqW8WC14zj+AtG/IS/TtBIR3xhx
	RG3/H3/ZxNwrV5ydQl2xsTSNcuI+hC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734937889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3P5lgOvrV2OugSbQXFXowkZWD04tCEkVAmTNybgnRI=;
	b=tETBeL3jClnq4fK4VVHZSUJXHhzQYZ4eezsk/l9t/rLqggPbUhKTHpuDPFbLvgk0t4gNkr
	+iMT2yJFMb4Fn2BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A56713485;
	Mon, 23 Dec 2024 07:11:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A6XWKxwNaWfORgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 23 Dec 2024 07:11:24 +0000
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
Subject: Re: [PATCH 10/11] VFS: take a shared lock for create/remove directory
 operations.
In-reply-to: <20241223051941.GK1977892@ZenIV>
References: <>, <20241223051941.GK1977892@ZenIV>
Date: Mon, 23 Dec 2024 18:11:16 +1100
Message-id: <173493787613.11072.4293875424077013617@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
> On Fri, Dec 20, 2024 at 01:54:28PM +1100, NeilBrown wrote:
> 
> > Once the exclusive "update" lock is obtained on the dentry we must make
> > sure it wasn't unlinked or renamed while we slept.  If it was we repeat
> > the lookup.
> 
> > +		if (
> > +			/* Was unlinked while we waited ?*/
> > +			d_unhashed(dentry) ||
> > +			/* Or was dentry renamed ?? */
> > +			dentry->d_parent != base ||
> > +			dentry->d_name.hash != last->hash ||
> > +			!d_same_name(dentry, base, last)
> > +		) {
> > +			rcu_read_unlock();
> > +			spin_unlock(&dentry->d_lock);
> > +			lock_map_release(&dentry->d_update_map);
> > +			dput(dentry);
> > +			goto retry;
> > +		}
> > +		rcu_read_unlock();
> > +	}
> > +	dentry->d_flags |= DCACHE_PAR_UPDATE;
> > +	spin_unlock(&dentry->d_lock);
> 
> ... and now __d_unalias() moves it to new place, making all the checks
> you've just done completely useless.
> 

... Yes, thanks.

So I need __d_unalias() to effectively do a "try_lock" of
DCACHE_PAR_UPDATE and hold the lock across __d_move().
I think that would address the concerned you raised.

Did you see anything else that might be problematic?

Thanks,
NeilBrown



