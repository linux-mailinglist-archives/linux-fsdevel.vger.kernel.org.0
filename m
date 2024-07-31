Return-Path: <linux-fsdevel+bounces-24684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A056E942FAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 15:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FCBFB215C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 13:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368321AAE1D;
	Wed, 31 Jul 2024 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HOWoLdAn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GfLIaFt/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cH62HwFj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wAkuxeSP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E851E1EB36
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 13:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431068; cv=none; b=FH6Upo3KjBxIL0swIWCnbm0pxFib2PtgdTPvixymzFRs35mqs53jt7ciZYSBut8ynFhZL6MIZFbQ29w9zELoZDt3WXq8r07Xnhttv2mpoB7Ye/sF+lP12PgB40lGoMd5+pBMRKC/4tD3JoVBrnLMfS1PCeryGSBpgV2UEjJI8Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431068; c=relaxed/simple;
	bh=GZT3TTnmUvnWN5Qyw4DLQC5qpxvgwhe8qP0p9X/KX1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEHDmRQcuxnnEGxSl5oXkWzfJZtX3c2hlRyn1jkNItISg/lRBudZFiu7amkQbskE6Wr6+DMSWVuesS4ykm5hetwwBtd9a6KzeuG2NQYVn7CASJ0LqiHxXEbpiNj4iPB0gfa7fP5DB3tRmmkp1pqyQOK0G1RyjxTHGBSZ61hu7K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HOWoLdAn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GfLIaFt/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cH62HwFj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wAkuxeSP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 082A21F810;
	Wed, 31 Jul 2024 13:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722431065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ivJaimO/MuIX0nZIv/LV5ejuL6aUSpF1ANU8xkUs+w8=;
	b=HOWoLdAnpBjqNzQ9aqEpgsGhMMgI4djSP7YYcSEMeV6g3NBJIm7W1LT7bcnmySOwiRP5V9
	epp4nMPoy4Uy7tm3ep9dlU4E32Kr2MwHt2SkoYve6M7Dk0B+Cf7DkfQMyisQjsAG6SlmYV
	TjbMM1to28Ft4O2y5TCi27AtaaivU9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722431065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ivJaimO/MuIX0nZIv/LV5ejuL6aUSpF1ANU8xkUs+w8=;
	b=GfLIaFt/Q95HscvhSiZkp67yQO8QDoGbZ3uDsvRpIdpp+dgjVGUFvaWFuj4rSyhvhMg9dw
	NLxNUjEFV5hkArDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722431064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ivJaimO/MuIX0nZIv/LV5ejuL6aUSpF1ANU8xkUs+w8=;
	b=cH62HwFjA+oSbPzm9DCKN3cLz78HNKeJKUsHHf2e5hs6SMAN5uC4JB5Va52WOhCBYC4gGL
	wdo/sNWnW8a+8lL3vp6T7NSIK0QNI1TOeVUJ80yyJn3g/sKolRdBQ4CQpfL6UVpkBD68M7
	gy/6o4coPo9tjnC16r/x58gohHA5Uxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722431064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ivJaimO/MuIX0nZIv/LV5ejuL6aUSpF1ANU8xkUs+w8=;
	b=wAkuxeSPLgY1xnbjtJ7THDlWHjRre/C3WneFjo1K0ji4n19l1gtY0twVT/5EEXKEQQSIEY
	fJbzIL9OVCObKoCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAAB113297;
	Wed, 31 Jul 2024 13:04:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GdRFOVc2qmYGWgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 31 Jul 2024 13:04:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 59684A099C; Wed, 31 Jul 2024 15:04:23 +0200 (CEST)
Date: Wed, 31 Jul 2024 15:04:23 +0200
From: Jan Kara <jack@suse.cz>
To: yangerkun <yangerkun@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, yangerkun <yangerkun@huawei.com>,
	hch@infradead.org, chuck.lever@oracle.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, hughd@google.com, zlang@kernel.org,
	fdmanana@suse.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] libfs: fix infinite directory reads for offset dir
Message-ID: <20240731130423.wztpcevyzm4cnkjg@quack3>
References: <20240731043835.1828697-1-yangerkun@huawei.com>
 <20240731115134.tkiklyu72lwnhbxg@quack3>
 <57de6354-f53d-d106-aed8-9dff3e88efa6@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57de6354-f53d-d106-aed8-9dff3e88efa6@huaweicloud.com>
X-Spamd-Result: default: False [-3.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.60

On Wed 31-07-24 20:51:05, yangerkun wrote:
> 在 2024/7/31 19:51, Jan Kara 写道:
> > On Wed 31-07-24 12:38:35, yangerkun wrote:
> > > After we switch tmpfs dir operations from simple_dir_operations to
> > > simple_offset_dir_operations, every rename happened will fill new dentry
> > > to dest dir's maple tree(&SHMEM_I(inode)->dir_offsets->mt) with a free
> > > key starting with octx->newx_offset, and then set newx_offset equals to
> > > free key + 1. This will lead to infinite readdir combine with rename
> > > happened at the same time, which fail generic/736 in xfstests(detail show
> > > as below).
> > > 
> > > 1. create 5000 files(1 2 3...) under one dir
> > > 2. call readdir(man 3 readdir) once, and get one entry
> > > 3. rename(entry, "TEMPFILE"), then rename("TEMPFILE", entry)
> > > 4. loop 2~3, until readdir return nothing or we loop too many
> > >     times(tmpfs break test with the second condition)
> > > 
> > > We choose the same logic what commit 9b378f6ad48cf ("btrfs: fix infinite
> > > directory reads") to fix it, record the last_index when we open dir, and
> > > do not emit the entry which index >= last_index. The file->private_data
> > > now used in offset dir can use directly to do this, and we also update
> > > the last_index when we llseek the dir file.
> > 
> > The patch looks good! Just I'm not sure about the llseek part. As far as I
> > understand it was added due to this sentence in the standard:
> > 
> > "If a file is removed from or added to the directory after the most recent
> > call to opendir() or rewinddir(), whether a subsequent call to readdir()
> > returns an entry for that file is unspecified."
> > 
> > So if the offset used in offset_dir_llseek() is 0, then we should update
> > last_index. But otherwise I'd leave it alone because IMHO it would do more
> > harm than good.
> 
> IIUC, what you means is that we should only reset the private_data to
> new last_index when we call rewinddir(which will call lseek to set
> offset of dir file to 0)?

Yes, exactly. Sorry for being a bit vague.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

