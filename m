Return-Path: <linux-fsdevel+bounces-72606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB907CFD267
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 11:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73B3830AEA16
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 10:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5915B331A4B;
	Wed,  7 Jan 2026 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QFDq+39C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1xIkwc0J";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QFDq+39C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1xIkwc0J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB81331A41
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780745; cv=none; b=obdfu5pnA21FX4E70xtVP17urBGPKItMD0rR4IWnCh8PS7DQC9hmaVrzKo9Nw/3ViS+30F2BCnjWuZwiyBk0JlDFZGcigTYcWvWwd9y3dr1b00gwvDFfd6JtZVKl0yz6+q73uHVFo9ZY7cc3IdPy+jDhz2jaPMZ2pvhSUemwv/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780745; c=relaxed/simple;
	bh=l+PDwA+2NM+D3BHAPC7CtcIt4FSJI2OMX3/1kzk1nJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJABKz1vMzP+J9WKJ0+7o/y0myn3L7tD4c4KMaN1TDRY+w1Jvcf/AMw/OJwCvcDfuSuZhYojEJxKi7YIOs+QiC7L+vOWeyjHWdbCnTXAm6Wwx2ttg3wUPbA+T60uNZATxGYXwfzYi4pYptQuhamenQDDFi+YNmCChzQaQomeV0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QFDq+39C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1xIkwc0J; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QFDq+39C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1xIkwc0J; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 73F8C5BD4B;
	Wed,  7 Jan 2026 10:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767780742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QyjOnRY6tYvp1SLKJ5JK+KsRA6c7bJH9ig4viKI2uqE=;
	b=QFDq+39Cc7oo8MwJC5X9kvzdCAs7F5gTkXwgDDInSioh8QXQXlDb1qgFSYSvwBtauL8ArC
	QsQD+xenkJ81NoU+vDAFF111htE7lk4tIz3upqa4dYT/nByhjztWJFH3hbN75DTkIaIlFX
	OxpJ8Bgm3iodG9WIcNEGtH8cZ1UnkwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767780742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QyjOnRY6tYvp1SLKJ5JK+KsRA6c7bJH9ig4viKI2uqE=;
	b=1xIkwc0Jq/RwWecfl7uotKiHHKwTnzT3D1ecK3Ds2roqaVuBqa0GpxNyu2ET6nRwqeEMjh
	3rOgLBlVdLtCW7DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767780742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QyjOnRY6tYvp1SLKJ5JK+KsRA6c7bJH9ig4viKI2uqE=;
	b=QFDq+39Cc7oo8MwJC5X9kvzdCAs7F5gTkXwgDDInSioh8QXQXlDb1qgFSYSvwBtauL8ArC
	QsQD+xenkJ81NoU+vDAFF111htE7lk4tIz3upqa4dYT/nByhjztWJFH3hbN75DTkIaIlFX
	OxpJ8Bgm3iodG9WIcNEGtH8cZ1UnkwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767780742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QyjOnRY6tYvp1SLKJ5JK+KsRA6c7bJH9ig4viKI2uqE=;
	b=1xIkwc0Jq/RwWecfl7uotKiHHKwTnzT3D1ecK3Ds2roqaVuBqa0GpxNyu2ET6nRwqeEMjh
	3rOgLBlVdLtCW7DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 628923EA63;
	Wed,  7 Jan 2026 10:12:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fAwLGIYxXmm1RwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Jan 2026 10:12:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 12E80A09E9; Wed,  7 Jan 2026 11:12:18 +0100 (CET)
Date: Wed, 7 Jan 2026 11:12:18 +0100
From: Jan Kara <jack@suse.cz>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Jan Kara <jack@suse.cz>, akpm@linux-foundation.org, david@redhat.com, 
	miklos@szeredi.hu, linux-mm@kvack.org, athul.krishna.kr@protonmail.com, 
	j.neuschaefer@gmx.net, carnil@debian.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
 in wait_sb_inodes()
Message-ID: <ucnvcqbmxsiszobzzkjrgekle2nabf3w5omnfbitmotgujas4e@4f5ct4ot4mup>
References: <20251215030043.1431306-1-joannelkoong@gmail.com>
 <20251215030043.1431306-2-joannelkoong@gmail.com>
 <ypyumqgv5p7dnxmq34q33keb6kzqnp66r33gtbm4pglgdmhma6@3oleltql2qgp>
 <CAJnrk1aYpcDpm8MpN5Emb8qNOn34-qEiARLH0RudySKFtEZVpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aYpcDpm8MpN5Emb8qNOn34-qEiARLH0RudySKFtEZVpA@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net,protonmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,linux-foundation.org,redhat.com,szeredi.hu,kvack.org,protonmail.com,gmx.net,debian.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue 06-01-26 15:30:05, Joanne Koong wrote:
> On Tue, Jan 6, 2026 at 1:34 AM Jan Kara <jack@suse.cz> wrote:
> > [Thanks to Andrew for CCing me on patch commit]
> 
> Sorry, I didn't mean to exclude you. I hadn't realized the
> fs-writeback.c file had maintainers/reviewers listed for it. I'll make
> sure to cc you next time.

No problem, I don't think it's formally spelled out anywhere. It's just
that for changes in fs/*.c people tend to CC VFS maintainers / reviewers.

Thanks for the historical perspective, it does put some more peace into my
mind that things were considered :)

> For the fsync() and truncate() examples you mentioned, I don't think
> it's an issue that these now wait for the server to finish the I/O and
> hang if the server doesn't. I think it's actually more correct
> behavior than what we had with temp pages, eg imo these actually ought
> to wait for the writeback to have been completed by the server. If the
> server is malicious / buggy and fsync/truncate hangs, I think that's
> fine given that fsync/truncate is initiated by the user on a specific
> file descriptor (as opposed to the generic sync()) (and imo it should
> hang if it can't actually be executed correctly because the server is
> malfunctioning).

Here, I have a comment. The hang in truncate is not as innocent as you
might think. It will happen in truncate_inode_pages() and as such it will
also end up hanging inode reclaim. Thus kswapd (or other arbitrary process
entering direct reclaim) may hang in inode reclaim waiting for
truncate_inode_pages() to finish. And at that point you are between a rock
and a hard place - truncate_inode_pages() cannot fail because the inode is
at the point of no return. You cannot just detach the folio under writeback
from the mapping because if the writeback ever completes, the IO end
handlers will get seriously confused - at least in the generic case, maybe
specifically for FUSE there would be some solution possible - like a
special handler in fuse_evict_inode() walking all the pages under writeback
and tearing them down in a clean way (properly synchronizing with IO
completion) before truncate_inode_pages() is called.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

