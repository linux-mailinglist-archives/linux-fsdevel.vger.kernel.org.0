Return-Path: <linux-fsdevel+bounces-19480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A1B8C5E4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 02:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE91282879
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 00:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A77184F;
	Wed, 15 May 2024 00:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dKxHkkbf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RUmsnmKQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dKxHkkbf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RUmsnmKQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C979370;
	Wed, 15 May 2024 00:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715732721; cv=none; b=dGejtmVuuANEuMmWVblD2NgvYXJg6u0GOht47lWQ0K9HefHVYi2oM7SFjvqslF9L8b9e+GNGp/LndvUXX2s/snRjSAH4W7hFD2dnkj/lW+yBiub6AX66QpK8rwb+BqtuXewCqySUC+8bc0VZsv4hSpfELPpSoTttBUCfAfRMM6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715732721; c=relaxed/simple;
	bh=UwwJLzqENrZle2Y4/i+YEoQ9LtfalYqLwPCpLhSIrUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOIMAOBeCsvwNS764W0otCZPTsLpvwt/NYR/J6ruUvDDXWct3m3kku49Jd1+P2TE3NhRrfKDJsHTJwMfoSzeBJ9XIdXnMeJIT2lJVEmPrvGw3C58F4YQUa1nVoYv/b4eOhS9/MgWKf/DS/mhwe9Oo7oxL/q+VkU0h/HlVEv0O+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dKxHkkbf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RUmsnmKQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dKxHkkbf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RUmsnmKQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8151C22907;
	Wed, 15 May 2024 00:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715732717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UHZT2BoZr0ijthsLDchrpbeknRtm/GuvmkXc1Pxxy/Q=;
	b=dKxHkkbfWr/geiKeNoSlV1mVmQf5zQreuILpWf9/GLWY/3/a5NyfxWXMVEB8uHBkbbqfa6
	In94j0lIZ4i/3BbACEBrA8VoBTbC3qis5t8x2oQbTilbwCkp4ZR9ZRVKy9KYHeeOEpbh0a
	9X08WDtx6L44QuzOi9TL9da9LeE9I9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715732717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UHZT2BoZr0ijthsLDchrpbeknRtm/GuvmkXc1Pxxy/Q=;
	b=RUmsnmKQCuQfioWktYkb0msP1mHO2iwm8FFWoYA7jgNOe0RAiTN4e1xS6in7Eg4NoXJsP2
	89RlT9BPhNwCPpBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715732717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UHZT2BoZr0ijthsLDchrpbeknRtm/GuvmkXc1Pxxy/Q=;
	b=dKxHkkbfWr/geiKeNoSlV1mVmQf5zQreuILpWf9/GLWY/3/a5NyfxWXMVEB8uHBkbbqfa6
	In94j0lIZ4i/3BbACEBrA8VoBTbC3qis5t8x2oQbTilbwCkp4ZR9ZRVKy9KYHeeOEpbh0a
	9X08WDtx6L44QuzOi9TL9da9LeE9I9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715732717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UHZT2BoZr0ijthsLDchrpbeknRtm/GuvmkXc1Pxxy/Q=;
	b=RUmsnmKQCuQfioWktYkb0msP1mHO2iwm8FFWoYA7jgNOe0RAiTN4e1xS6in7Eg4NoXJsP2
	89RlT9BPhNwCPpBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D668F13A56;
	Wed, 15 May 2024 00:25:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5i9SNOwARGbpVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 15 May 2024 00:25:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 41AECA08B5; Wed, 15 May 2024 02:25:13 +0200 (CEST)
Date: Wed, 15 May 2024 02:25:13 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH] ext4/jbd2: drop jbd2_transaction_committed()
Message-ID: <20240515002513.yaglghza4i4ldmr5@quack3>
References: <20240513072119.2335346-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513072119.2335346-1-yi.zhang@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -2.29
X-Spam-Level: 
X-Spamd-Result: default: False [-2.29 / 50.00];
	BAYES_HAM(-2.99)[99.96%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]

On Mon 13-05-24 15:21:19, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> jbd2_transaction_committed() is used to check whether a transaction with
> the given tid has already committed, it hold j_state_lock in read mode
> and check the tid of current running transaction and committing
> transaction, but holding the j_state_lock is expensive.
> 
> We have already stored the sequence number of the most recently
> committed transaction in journal t->j_commit_sequence, we could do this
> check by comparing it with the given tid instead. If the given tid isn't
> smaller than j_commit_sequence, we can ensure that the given transaction
> has been committed. That way we could drop the expensive lock and
> achieve about 10% ~ 20% performance gains in concurrent DIOs on may
> virtual machine with 100G ramdisk.
> 
> fio -filename=/mnt/foo -direct=1 -iodepth=10 -rw=$rw -ioengine=libaio \
>     -bs=4k -size=10G -numjobs=10 -runtime=60 -overwrite=1 -name=test \
>     -group_reporting
> 
> Before:
>   overwrite       IOPS=88.2k, BW=344MiB/s
>   read            IOPS=95.7k, BW=374MiB/s
>   rand overwrite  IOPS=98.7k, BW=386MiB/s
>   randread        IOPS=102k, BW=397MiB/s
> 
> After:
>   verwrite:       IOPS=105k, BW=410MiB/s
>   read:           IOPS=112k, BW=436MiB/s
>   rand overwrite: IOPS=104k, BW=404MiB/s
>   randread:       IOPS=111k, BW=432MiB/s
> 
> CC: Dave Chinner <david@fromorbit.com>
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Link: https://lore.kernel.org/linux-ext4/493ab4c5-505c-a351-eefa-7d2677cdf800@huaweicloud.com/T/#m6a14df5d085527a188c5a151191e87a3252dc4e2
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

I agree this is workable solution and the performance benefits are nice. But
I have some comments regarding the implementation:

> @@ -3199,8 +3199,8 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
>  	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
>  
>  	if (journal) {
> -		if (jbd2_transaction_committed(journal,
> -			EXT4_I(inode)->i_datasync_tid))
> +		if (tid_geq(journal->j_commit_sequence,
> +			    EXT4_I(inode)->i_datasync_tid))

Please leave the helper jbd2_transaction_committed(), just make the
implementation more efficient. Also accessing j_commit_sequence without any
lock is theoretically problematic wrt compiler optimization. You should have
READ_ONCE() there and the places modifying j_commit_sequence need to use
WRITE_ONCE().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

