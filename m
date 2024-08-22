Return-Path: <linux-fsdevel+bounces-26821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 946C195BD24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 19:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA705B2670E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8871CEAD2;
	Thu, 22 Aug 2024 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t7bRC+77";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1vOjQtg2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ho8VzL9h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TVNg7y82"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC8E1CEABB;
	Thu, 22 Aug 2024 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347539; cv=none; b=kmW1KaVl2GLsX68YXLgN6ZionvKOZjxBIQglUTirplREuJMD5NdWDjYO5Zt2WTCiQGDXdo/KQ3W4ysoYoAjiQ8qQL/Iq144TztWpMvAICWb2+Jv93XRi9niLuppPYnshM+6dnnMmQc3/YoVVOQGzcP10/zmis/vv2V+3w8sFbQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347539; c=relaxed/simple;
	bh=lZz2b+UIfcm76DYpcUn3AC660hwcw/loySTha54lQR4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pLRhqaPFs2t/gfMouMPpwwyk4fd9MngCZrvmUZah5LIcea1v+48T9Dl0bXhPAs0MxwdeVIozcRp2AZ/1eSKxx8itlupq0tlUTkuY26BYoGwvc8zJEl5AJF0U5cqCW8pc/7F31A2YsTBRGneRu57gtfJRn1PUCd4FDwtBVqyZw+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t7bRC+77; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1vOjQtg2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ho8VzL9h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TVNg7y82; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E82782020D;
	Thu, 22 Aug 2024 17:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724347535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BObgr4Z1nBzmg7iQR4vsFNHe/0eQMqqJIKMig54d+WY=;
	b=t7bRC+77OR6/NWFx47bUZGgve7AI/XiZjiO1dppmXhr6x/cdGJvzxIjlftga0lsoPWxYbc
	XrE2SLnexdMzA61Bya8KlA0rHmbxVengX6jtYmwUALgn2HhEKSmmho9RErcB/SWTaN+EK3
	HePBOutOXfVOwCopgx9/h4OFk2Jx0ug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724347535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BObgr4Z1nBzmg7iQR4vsFNHe/0eQMqqJIKMig54d+WY=;
	b=1vOjQtg2+4yPFcrKWikFzyDAABw4sAJGqrPJhX13v+P+YE1RNnWBbDEng9jalzaEuwdjFc
	1BZ6+dZG40KdIICw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ho8VzL9h;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TVNg7y82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724347534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BObgr4Z1nBzmg7iQR4vsFNHe/0eQMqqJIKMig54d+WY=;
	b=ho8VzL9haiPDdrXvqolJg/wNSKS0UVG9hXShBWklDjZ5/jm4fKz7wEDhxdxpj6jitIZ3W9
	a0ZT2N5pgfgTTj9cUQ0Er2PtCK/jDzG4lAuUKzkmKYaNGaP/itfKLEa5yWHZ43AM++Bvaw
	aECvA0erDCb55TJ0CQ8wN7xknDBPZK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724347534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BObgr4Z1nBzmg7iQR4vsFNHe/0eQMqqJIKMig54d+WY=;
	b=TVNg7y82VmpzTXpW7vXGdIN0hR3jJVeb/JEGCLUiYt9qsSEM9Zsiqtk4mPm+ivC2YTl+ea
	QkCCKCLXqItDm9Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC53113A1F;
	Thu, 22 Aug 2024 17:25:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B98pJI50x2bmFwAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 22 Aug 2024 17:25:34 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,  brauner@kernel.org,
  tytso@mit.edu,  linux-ext4@vger.kernel.org,  jack@suse.cz,
  adilger.kernel@dilger.ca,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel@collabora.com,
  shreeya.patel@collabora.com
Subject: Re: [PATCH 1/2] fs/dcache: introduce d_alloc_parallel_check_existing
In-Reply-To: <20240822011345.GS504335@ZenIV> (Al Viro's message of "Thu, 22
	Aug 2024 02:13:45 +0100")
Organization: SUSE
References: <20240705062621.630604-1-eugen.hristev@collabora.com>
	<20240705062621.630604-2-eugen.hristev@collabora.com>
	<87zfp7rltx.fsf@mailhost.krisman.be>
	<2df894de-8fa9-40c2-ba2c-f9ae65520656@collabora.com>
	<87jzg9wjeo.fsf@mailhost.krisman.be> <20240822011345.GS504335@ZenIV>
Date: Thu, 22 Aug 2024 13:25:33 -0400
Message-ID: <87frqwwjua.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: E82782020D
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Wed, Aug 21, 2024 at 07:22:39PM -0400, Gabriel Krisman Bertazi wrote:
>
>> Would it be acceptable to just change the dentry->d_name here in a new
>> flavor of d_add_ci used only by these filesystems? We are inside the
>> creation path, so the dentry has never been hashed.  Concurrent lookups
>> will be stuck in d_wait_lookup() until we are done and will never become
>> invalid after the change because the lookup was already done
>> case-insensitively, so they all match the same dentry, per-definition,
>> and we know there is no other matching dentries in the directory.  We'd
>> only need to be careful not to expose partial names to concurrent
>> parallel lookups.
>
> *Ow*
>
> ->d_name stability rules are already convoluted as hell; that would make
> them even more painful.
>
> What locking are you going to use there?

Since we are in the ->d_lookup() during the rename, and we use the
dcache-insensitively for the filesystems that will do the rename, we
know there is nothing in the dcache and the dentry is still in the
parallel lookup table.  So we are not racing with a creation of the same
name in the same directory.  A parallel lookup will either find that
dentry (old or new name, doesn't matter) or not find anything, in case
it sees a partial ->d_name.  Therefore, the only possible problem is a
false negative/positive in parent->d_in_lookup_hash.

Can we extend the rename_lock seqlock protection that already exists in
d_alloc_parallel to include the d_in_lookup_hash walk?  d_add_ci then
acquires the rename_lock before writing ->d_name and d_alloc_parallel
will see it changed after iterating over d_in_lookup_hash, in case it
didn't find anything, and retry the entire sequence.

Case-inexact lookups are not supposed to be frequent. Most lookups
should be done in a case-exact way, so the extra acquisition of
rename_lock shouldn't create more contention on the rename_lock for the
regular path or for non-case-insensitive filesystems.  The overhead in
d_alloc_parallel is another read_seqretry() that is done only in the
case where the dentry is not found anywhere and should be created.

-- 
Gabriel Krisman Bertazi

